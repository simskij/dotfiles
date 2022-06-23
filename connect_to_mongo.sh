#!/bin/bash

mode=${1:-iaas}
machine=${2:-0}
model=${3:-controller}

case "${mode}" in
    caas | k8s)
        kubectl_bin=microk8s.kubectl
        k8s_ns=`juju whoami | grep Controller | awk '{print "controller-"$2}'`
        k8s_controller_pod=`${kubectl_bin} -n ${k8s_ns} get pods | grep -E "^controller-([0-9]+)" | awk '{print $1}'`
        echo "${k8s_controller_pod}"

        echo "Connecting to mongo-db instance at: ${k8s_ns}:${k8s_controller_pod}"
        mongo_user=`${kubectl_bin} exec -n ${k8s_ns} ${k8s_controller_pod} -c api-server -it -- bash -c "grep tag /var/lib/juju/agents/controller-*/agent.conf | cut -d' ' -f2 | tr -d '\n'"`
        mongo_pass=`${kubectl_bin} exec -n ${k8s_ns} ${k8s_controller_pod} -c api-server -it -- bash -c "grep statepassword /var/lib/juju/agents/controller-*/agent.conf | cut -d' ' -f2 | tr -d '\n'"`
        ${kubectl_bin} exec -n ${k8s_ns} ${k8s_controller_pod} -c mongodb -it -- bash -c "/bin/mongo 127.0.0.1:37017/juju --authenticationDatabase admin --ssl --sslAllowInvalidCertificates --username '${mongo_user}' --password '${mongo_pass}'"
        ;;

    *)
        read -d '' -r cmds <<'EOF'
conf=/var/lib/juju/agents/machine-*/agent.conf
user=`sudo grep tag $conf | cut -d' ' -f2`
password=`sudo grep statepassword $conf | cut -d' ' -f2`
if [ -f /snap/bin/juju-db.mongo ]; then
  client=/snap/bin/juju-db.mongo
elif [ -f /usr/lib/juju/mongo*/bin/mongo ]; then
  client=/usr/lib/juju/mongo*/bin/mongo
else
  client=/usr/bin/mongo
fi
echo $user $password
$client 127.0.0.1:37017/juju --authenticationDatabase admin --ssl --sslAllowInvalidCertificates --username "$user" --password "$password"
EOF
        juju ssh -m "${model}" "${machine}" "${cmds}"
        ;;
esac
