```yaml
Part2:- 
Delete any containers running from the last part.

Now we will create docker-compose.yaml

vi docker-compose.yaml

version: '3'
services:
  csvserver:
    image: infracloudio/csvserver:latest
    ports:
      - "9393:9300"
    environment:
      - CSVSERVER_BORDER=${CSVSERVER_BORDER}
    volumes:
      - ./inputFile:/csvserver/inputdata
    command: ["./csvserver", "/csvserver/inputdata"]

Now we need to create csvserver.env in docker-compose.yaml to pass environment variables used

vi csvserver.env 
CSVSERVER_BORDER=Orange

now we are good to run docker-compose up

root@ip-172-31-21-212:~# docker-compose up

now we can access our application on http://localhost:9393 in my case i have public ip http://<public-ip>:9393
