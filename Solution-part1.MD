```yaml
Part1:- 
First we pull docker image 

root@ip-172-31-24-219:~# docker pull infracloudio/csvserver:latest

root@ip-172-31-24-219:~# docker images
REPOSITORY               TAG       IMAGE ID       CREATED       SIZE
infracloudio/csvserver   latest    8cb989ef80b5   2 years ago   237MB

Now we are running this container
root@ip-172-31-24-219:~# docker run -d --name csvserver  8cb989ef80b5

now as checking this container is go in exited state

root@ip-172-31-24-219:~# docker ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS                     PORTS     NAMES
3f7a680afa7c   8cb989ef80b5   "/csvserver/csvserver"   6 seconds ago   Exited (1) 5 seconds ago             csvserver

Checking logs found the error 

root@ip-172-31-24-219:~# docker logs csvserver
2023/04/27 14:32:56 error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory

the /csvserver/inputdata directory is not found now we need to fix this issue for that creating the script

vi gencsv.sh 

#!/bin/bash
for ((i=$1;i<$2;i++))
do
    echo "$i, $((RANDOM%100))"
done > inputFile

now assign executable permission to this script

root@ip-172-31-24-219:~# chmod +x gencsv.sh 

as per instruction we can fire this script to genrate data

root@ip-172-31-21-212:~# ./gencsv.sh 2 9
output:- gencsv.sh  inputFile  snap

root@ip-172-31-21-212:~# cat inputFile 
2, 59
3, 12
4, 42
5, 33
6, 8
7, 27
8, 74

now remove old container and run using this command

root@ip-172-31-21-212:~# docker run -d --name csvserver -v "$(pwd)"/inputFile:/csvserver/inputdata infracloudio/csvserver:latest
now exec into container 

root@ip-172-31-21-212:~# docker exec -it csvserver /bin/bash
and check whether its running on 9300 port
[root@e1187898fec7 csvserver]# netstat -tlnp | grep 9300
tcp6       0      0 :::9300                 :::*                    LISTEN      1/csvserver

In the next step we need to set ENV variable so follow this steps
root@ip-172-31-21-212:~# docker stop csvserver
root@ip-172-31-21-212:~# docker rm csvserver

now run with this env variable "CSVSERVER_BORDER=Orange"
docker run -d --name csvserver -e CSVSERVER_BORDER=Orange -v "$(pwd)"/inputFile:/csvserver/inputdata -p 9393:9300 infracloudio/csvserver:latest

now we can access our application on http://localhost:9393 in my case i have public ip http://<public-ip>:9393








