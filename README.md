# Teste 
# OIIIII amiga tudo bão? então isso é o produto de 2 dias fazendo isso :) 

# Olha eu testei, os pods sobem, os serviços é pra estarem aq se eu upei certo, só o banco de dados não quer conectar sei lá pq vou tentar ver isso dps

# melhor jeito de rodar isso é com chmod +x k8s/deploy.sh e ./k8s/deploy.sh

# ou se vc quiser ser masoquista:

docker build -t auth-service:latest ./auth_service
docker build -t recovery-service:latest ./recovery_service
docker build -t doctors-service:latest ./doctor_service
docker build -t scheduling-service:latest ./schedule_service
docker build -t gateway:latest ./gateway

7. Aplicar os manifests na ordem certa
bash# Secrets e ConfigMaps primeiro
kubectl apply -f k8s/secrets.yaml
kubectl apply -f k8s/db-configmaps.yaml

# Bancos de dados
kubectl apply -f k8s/databases.yaml

# Aguardar os bancos subirem
kubectl wait --for=condition=ready pod -l app=credentials-db --timeout=120s
kubectl wait --for=condition=ready pod -l app=doctors-db --timeout=120s
kubectl wait --for=condition=ready pod -l app=scheduling-db --timeout=120s

# Esperar o MySQL aceitar conexoes
sleep 30

# Microsservicos
kubectl apply -f k8s/auth-service.yaml
kubectl apply -f k8s/recovery-service.yaml
kubectl apply -f k8s/doctors-service.yaml
kubectl apply -f k8s/scheduling-service.yaml
kubectl apply -f k8s/gateway.yaml

# Aguardar os microsservicos subirem
kubectl wait --for=condition=ready pod -l app=auth-service --timeout=60s
kubectl wait --for=condition=ready pod -l app=recovery-service --timeout=60s
kubectl wait --for=condition=ready pod -l app=doctors-service --timeout=60s
kubectl wait --for=condition=ready pod -l app=scheduling-service --timeout=60s
kubectl wait --for=condition=ready pod -l app=gateway --timeout=60s

# Isso tudo ai deve subir o minikube (y) eu acho, é pra estar tudo isso ai no deploy tbm

# ai tem o front end que sobe com 
# cd frontend
# npm install
# npm run dev

# se na pastinha frontend tiver o node_modules o npm install é opcional se eu entendi certo

# miga é isso beijins to inddo dormir :))) vou deixar isso num branch, tenta rodar/ver/entender/processsar numa ia, ver o que tá utilizavel o q é lixo e monta em cima, sério isso aqui foi o produto do meu máximo kskskskksksks eu acho que tá ok mas não sei slá tô com muita self-doubt sobre esse projeto, real confiança no meu trabalho tá abaixo do chão :'( espero que seja útil esse trambolho todo aq!