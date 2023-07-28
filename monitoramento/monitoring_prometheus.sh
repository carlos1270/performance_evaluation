docker run --volume=/:/rootfs:ro --volume=/var/run:/var/run:ro --volume=/sys:/sys:ro --volume=/var/lib/docker/:/var/lib/docker:ro --volume=/dev/disk/:/dev/disk:ro --env-file ./cadvisor.env --publish=8080:8080 --detach=true --name=cadvisorm gcr.io/cadvisor/cadvisor@sha256:daee1ca59659fddb2e089756d39745d3fae211ebe809a5e45808498b57ae8bf1

docker run --name prometheusm -v ./prometheus.yml:/etc/prometheus/prometheus.yml --volume=/home/monitoramento/prometheus:/prometheus/data -e --config.file=/etc/prometheus/prometheus.yml --detach=true --publish=9090:9090 prom/prometheus:v2.19.0

docker run -d -p 3000:3000 --name grafanam grafana/grafana:5.2.0