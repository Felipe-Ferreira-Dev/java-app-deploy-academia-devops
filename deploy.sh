cd ~/projetos/java-app-deploy-academia-devops/terraform &
pwd
~/terraform init &
~/terraform validate &
~/terraform apply -auto-approve &

echo "Aguardando criação de maquinas ..." &

sleep 10 &

echo "[ec2-lab-docker]" > ../ansible/hosts &
echo "$(~/terraform output | awk '{print $3;exit}')" >> ../ansible/hosts &
echo "Aguardando criação de maquinas ..." &

sleep 10 &

cd ../ansible &

ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/.ssh/id_rsa 

cd ../terraform
