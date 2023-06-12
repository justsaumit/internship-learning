cat /etc/prometheus/prometheus.yml \
 | awk '/prometheus/ {++count; if (count == 2) sub(/prometheus/, "node")} 1 ' \
 | sed '/scrape_configs:/,/targets: \['\''localhost:9090'\''\]/{s/static_configs:/ec2_sd_configs:/; /- targets: \[/d}' \
 | sed '/ec2_sd_configs:/a \      - region: ap-south-1\n        access_key: yourkey\n        secret_key: yourkey\n        port: 9100'

## Usage: 
# $ bash prometheus-service-discovery.sh 
# Check if correct
# $ bash prometheus-service-discovery.sh | sudo tee /etc/prometheus/prometheus.yml
