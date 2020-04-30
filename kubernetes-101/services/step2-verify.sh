# Verify the http pod
var1=$(kubectl get pods -o jsonpath='{range .items[*]}{@.metadata.name}{" "}{@.spec.containers[].image}{"\n"}{end}'| grep -ow "http katacoda/docker-http-server:latest")
var2="http katacoda/docker-http-server:latest"

[ "$var1" == "$var2" ] && echo "done"