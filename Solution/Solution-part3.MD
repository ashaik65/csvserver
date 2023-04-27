```yaml
Part2:- 
Delete any containers running from the last part.

for this first we down docker-compose using this command

root@ip-172-31-21-212:~# docker-compose down

now we will add prometheus configuration in exisitng docker-compose.yaml 

vi docker-compose.yaml

prometheus:
    image: prom/prometheus:v2.22.0
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    command:
      - "--config.file=/etc/prometheus/prometheus.yml"

We need to craete prometheus.yaml file to mount volume 

vi prometheus.yml

global:
  scrape_interval:     5s # Set the scrape interval to every 5 seconds.
  evaluation_interval: 5s # Evaluate rules every 5 seconds.

scrape_configs:
  - job_name: 'csvserver'
    static_configs:
      - targets: ['csvserver:9300']

now we can run this configuration using this command

root@ip-172-31-21-212:~# docker-compose up -d

once done we can access the Prometheus instance should be accessible at http://localhost:9090,in my case has (http://<public-ip>:9090) and it should show a straight line graph with value 7 (consider shrinking the time range to 5m).

