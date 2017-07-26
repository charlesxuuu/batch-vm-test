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
#define SUM

int mycall(const char * cmdstring);
void error (const char * msg);
int writetext(char* filepath, char* string);
char *time_stamp();
int countline(char* filepath);

int main(int argc, char *argv[])
 {
		
  	//mycall("rm -rf shift4.txt lia4.txt shift2.txt lia2.txt tcp1.txt dc1.txt");
	FILE* fd1 = fopen("log.txt", "a");
	fprintf(fd1, "\n\n\n------------------------\n");
	if(fd1 != NULL){
		#ifdef DEBUG
		fprintf(fd1, "argc= %d \n", argc);
		fprintf(fd1, "argv[0]= %s \n", argv[0]);
		fprintf(fd1, "client argv[1]= %s \n", argv[1]); /* client */
		fprintf(fd1, "server argv[2]= %s \n", argv[2]); /* server */
		fprintf(fd1, "time argv[3]= %s \n", argv[3]); /* time */
		fprintf(fd1, "connections argv[4]= %s \n", argv[4]); /* connections */
		fprintf(fd1, "experiment argv[5]= %s \n", argv[5]); /* experiment */
		#endif
	}



	char iperfcmd[100] = "";
	sprintf(iperfcmd, "iperf -c %s -t %s -f m -P %s |grep bits/sec > iperf-result.tmp", argv[2], argv[3], argv[4]);
	
	
	char reportcubiccmd[100] = "";
	sprintf(reportcubiccmd, "mv iperf-result.txt /home/chix/nfs-share/%s/%s-%s-%s.txt",  argv[5], "cubic", argv[1], time_stamp() );

	char reportdctcpcmd[100] = "";
	sprintf(reportdctcpcmd, "mv iperf-result.txt /home/chix/nfs-share/%s/%s-%s-%s.txt",  argv[5], "dctcp", argv[1], time_stamp() );

	char reportliacmd[100] = "";
	sprintf(reportliacmd, "mv iperf-result.txt /home/chix/nfs-share/%s/%s-%s-%s.txt",  argv[5], "lia", argv[1], time_stamp() );

	char reportecncmd[100] = "";
	sprintf(reportecncmd, "mv iperf-result.txt /home/chix/nfs-share/%s/%s-%s-%s.txt", argv[5], "ecn", argv[1], time_stamp() );

	char reportmycmd[100] = "";
	sprintf(reportmycmd, "mv iperf-result.txt /home/chix/nfs-share/%s/%s-%s-%s.txt",  argv[5], "my", argv[1], time_stamp() );



	if(fd1 != NULL){
	#ifdef DEBUG
	fprintf(fd1, "iperfcmd= %s\n", iperfcmd);
	fprintf(fd1, "reportcmd= %s\n", reportliacmd);
	#endif
	}

	/* lia */
	mycall("sudo sysctl net.mptcp.mptcp_enabled=1 >> log.txt");
	mycall("sudo sysctl net.mptcp.mptcp_path_manager='fullmesh' >> log.txt");
	mycall("sysctl net.ipv4.tcp_congestion_control='lia' >> log.txt");
	mycall("sysctl net.ipv4.tcp_ecn=1 >> log.txt");
	mycall("sleep 2");

	mycall(iperfcmd);
	mycall("sleep 1");
	#ifdef SUM
	mycall("cat iperf-result.tmp > iperf-result.txt");
	#else 
	mycall("head -n -1 iperf-result.tmp > iperf-result.txt");
	#endif
	fprintf(fd1, "iperf-lia-lines: %d \n", countline("iperf-result.txt"));
	mycall(reportliacmd);

	printf("lia-ecn done.\n");


	fclose(fd1);

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

int countline(char* filepath){
	FILE* fd = fopen(filepath, "r");
	int ch, numlines = 0;
	
	do{
		ch = fgetc(fd);
		if(ch == '\n')
			numlines++;
	} while(ch != EOF);

	if(ch != '\n' && numlines != 0)
		numlines++;
	fclose(fd);

	return numlines;
}


char *time_stamp(){

	char *timestamp = (char *)malloc(sizeof(char) * 16);
	time_t ltime;
	ltime=time(NULL);
	struct tm *tm;
	tm=localtime(&ltime);

	sprintf(timestamp,"%04d%02d%02d%02d%02d%02d", tm->tm_year+1900, tm->tm_mon, 
    	tm->tm_mday, tm->tm_hour, tm->tm_min, tm->tm_sec);
	return timestamp;
}



void error(const char *msg)
{
    perror(msg);
    exit(1);
}

