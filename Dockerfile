FROM python:3.13.5-alpine3.22

# Etapa 1: Definir o diretório de trabalho
# Todos os comandos subsequentes serão executados a partir deste diretório
WORKDIR /app

# Etapa 2: Copiar e instalar as dependências
# Copiamos primeiro o requirements.txt para aproveitar o cache do Docker.
# Se este arquivo não mudar, o Docker não reinstalará as dependências,
# acelerando o processo de build.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 3: Copiar o código da aplicação
# Copia todos os arquivos do projeto para o diretório de trabalho no container
COPY . .

# Etapa 4: Expor a porta
# Informa ao Docker que o container escutará na porta 8000 em tempo de execução
EXPOSE 8000

# Etapa 5: Comando para executar a aplicação
# Inicia o servidor Uvicorn. O host 0.0.0.0 torna a aplicação acessível
# de fora do container, o que é essencial para produção.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

#