#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <time.h>

#define DEBUG 


int mycall(const char * cmdstring);
void error (const char * msg);
int writetext(char* filepath, char* string);

int main(int argc, char *argv[])
{

	char iperfcmd[50] = "";
	sprintf(iperfcmd, "iperf -s -i 60 > /dev/null ");


	mycall("sysctl net.mptcp.mptcp_enabled=1 >> log.txt");
	mycall("sysctl net.mptcp.mptcp_path_manager='fullmesh' >> log.txt");
	mycall("sysctl net.ipv4.tcp_congestion_control='lia' >> log.txt");
	mycall("sysctl net.ipv4.tcp_ecn=2 >> log.txt");
	mycall("insmod /home/chix/mptcp_ecn.ko");
	mycall(iperfcmd);
    return 0;
}

int mycall(const char * cmdstring){
    pid_t pid;
    int status;

	if(cmdstring == NULL){
    		return (1); //if cmdstring is null，return 1
	}

	if((pid = fork())<0){
    		status = -1; //failed fork，return -1
	}
	else if(pid == 0){ //child process
    		execl("/bin/sh", "sh", "-c", cmdstring, (char *)0);
    		_exit(127); // if execl failed, return 127
	}
	else{ //father process
    		while(waitpid(pid, &status, 0) < 0){
        		if(errno != EINTR){
            			status = -1; //If waitpid is interrupted，return -1
            			break;
        		}
    		}
	}
    return status; //If waitpid succeed，return status
}

int writetext(char* filepath, char* string){
	if (filepath!=NULL){
	FILE* fd = fopen(filepath, "a");
	fprintf(fd, string);
	fclose(fd);
	}
}


void error(const char *msg)
{
    perror(msg);
    exit(1);
}


	/*
	if(fd1 != NULL){
	#ifdef DEBUG
	fprintf(fd1, "iperfcmd= %s\n", iperfcmd);
	#endif
	}
	fclose(fd1);

	char filepath[]="mp.txt";
	char sip[50];
	strcpy(sip, argv[1]); //sender ip 
	char rip[50];
	strcpy(rip, argv[2]); //receiver ip
	char time[50];
	strcpy(time, argv[3]); //time length
	char scheme[20];        //shift lia tcp dctcp
	char interfaces[20];    //4 2 1

	char output[100]="";
	*/



	/*
	mycall("sudo sysctl net.ipv4.tcp_congestion_control='lia' >> log.txt");
	mycall("sleep 2");

	strcpy(scheme, "lia");
	strcpy(interfaces, "4");
	sprintf(output, "%s\t%s\t%s\t%s\t%s\t", sip, rip, time, scheme, interfaces);
	writetext(filepath, output);
	mycall("sleep 2");
	mycall(iperfcmd);	


	//mptcp enabled (shift and lia) 2 interface
	mycall("sudo ifdown eth2");
	mycall("sudo ifdown eth3");
	mycall("sleep 2");

	mycall("sudo sysctl net.ipv4.tcp_congestion_control='shift' >> log.txt");
	mycall("sleep 2");

	strcpy(scheme, "shift");
	strcpy(interfaces, "2");
	sprintf(output, "%s\t%s\t%s\t%s\t%s\t", sip, rip, time, scheme, interfaces);
	writetext(filepath, output);
	mycall(iperfcmd);		
	
	mycall("sudo sysctl net.ipv4.tcp_congestion_control='lia' >> log.txt");
	mycall("sleep 2");

	strcpy(scheme, "lia");
	strcpy(interfaces, "2");
	sprintf(output, "%s\t%s\t%s\t%s\t%s\t", sip, rip, time, scheme, interfaces);
	writetext(filepath, output);
	mycall(iperfcmd);		

	//mptcp disabled tcp 1 interface
	mycall("sudo ifdown eth1");
	mycall("sleep 1");
	mycall("sudo sysctl net.mptcp.mptcp_enabled=0 >> log.txt");
	mycall("sleep 2");

	strcpy(scheme, "tcp");
	strcpy(interfaces, "1");
	sprintf(output, "%s\t%s\t%s\t%s\t%s\t", sip, rip, time, scheme, interfaces);
	writetext(filepath, output);
	mycall(iperfcmd);		

	mycall("sudo sysctl net.ipv4.tcp_congestion_control='dctcp' >> log.txt");
	mycall("sleep 2");

	strcpy(scheme, "dctcp");
	strcpy(interfaces, "1");
	sprintf(output, "%s\t%s\t%s\t%s\t%s\t", sip, rip, time, scheme, interfaces);
	writetext(filepath, output);
	mycall(iperfcmd);
*/
