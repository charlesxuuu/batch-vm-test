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

