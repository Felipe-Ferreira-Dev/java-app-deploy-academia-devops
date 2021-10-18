cd java-app-deploy-academia-devopscd 
docker build -t ffaneto/java-app-deploy-academia-devops -f Dockerfile .
docker run -d -p 8081:8081 --name java-app-deploy-academia-devops ffaneto/java-app-deploy-academia-devops
docker stop java-app-deploy-academia-devops

cd ../terraform
~/terraform/terraform init
~/terraform/terraform validate
~/terraform/terraform apply -auto-approve

echo "Aguardando criação de maquinas ..."
sleep 10 # 10 segundos

echo $"[ec2-nodejs]" > ../ansible/hosts # cria arquivo
echo "$(~/terraform/terraform output | awk '{print $3;exit}')" >> ../ansible/hosts # captura output faz split de espaco e replace de ",

echo "Aguardando criação de maquinas ..."
sleep 10 # 20 segundos

cd ../ansible
ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/.ssh/id_rsa

cd ../terraform
