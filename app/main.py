from fastapi import FastAPI, Request, HTTPException, status
import datetime
import logging

app = FastAPI()

# Logging estruturado para Auditoria (RNF04) 
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("medmatch-auth")

# Simulação de banco de dados (por enquanto)
db_metrics = {"requests": 0, "errors": 0, "failed_logins": 0}

@app.get("/healthcheck")
def healthcheck():
    db_metrics["requests"] += 1
    return {"status": "OK"} # [cite: 18, 19]

@app.post("/register") # RF01: Cadastro [cite: 64]
async def register(request: Request):
    db_metrics["requests"] += 1
    # Aqui entrará a lógica de salvar no MySQL 
    return {"message": "Usuário criado com sucesso"}

@app.post("/login") # RF02: Autenticação [cite: 65]
async def login(request: Request):
    db_metrics["requests"] += 1
    client_ip = request.client.host
    timestamp = datetime.datetime.utcnow().isoformat()
    
    # Simulação de falha para testar o STRIDE (Spoofing) [cite: 125]
    db_metrics["failed_logins"] += 1
    
    # Log de Auditoria conforme RNF04 [cite: 81, 141]
    logger.warning(f"TS={timestamp} LVL=WARNING EP=/login IP={client_ip} MSG=Tentativa de login malsucedida")
    return {"message": "Credenciais inválidas"}