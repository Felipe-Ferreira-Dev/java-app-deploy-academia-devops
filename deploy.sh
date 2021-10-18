cd terraform/ &

~/terraform  init init &

~/terraform  init validate &

~/terraform  init apply -auto-approve &

echo "Aguardando criação de maquinas ..." &

sleep 10 &

echo $"[ec2-nodejs]" > ../ansible/hosts &

echo "$( ~/terraform  init output | awk '{print $3;exit}')" >> ../ansible/hosts &

echo "Aguardando criação de maquinas ..." &

sleep 10 &

cd ../ansible &

ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/.ssh/id_rsa &

cd ../terraform
