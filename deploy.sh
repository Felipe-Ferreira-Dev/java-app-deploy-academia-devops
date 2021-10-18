cd terraform/

~/terraform  init init

~/terraform  init validate

~/terraform  init apply -auto-approve

echo "Aguardando criação de maquinas ..."

sleep 10 # 10 segundos

echo $"[ec2-nodejs]" > ../ansible/hosts # cria arquivo

echo "$( ~/terraform  init output | awk '{print $3;exit}')" >> ../ansible/hosts # captura output faz split de espaco e replace de ",

echo "Aguardando criação de maquinas ..."

sleep 10 # 20 segundos

cd ../ansible

ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/.ssh/id_rsa

cd ../terraform
