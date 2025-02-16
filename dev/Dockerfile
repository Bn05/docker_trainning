FROM python:3.13.2

WORKDIR /opt/project/

RUN pip install --user --no-cache-dir fastapi uvicorn
# Copier le code source

EXPOSE 8000
#Commande par défaut pour lancer l'application
CMD ["tail", "-f", "/dev/null"]