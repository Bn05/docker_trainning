# Étape 1 : Construction (builder)
FROM python:3.13.2-alpine as builder

WORKDIR /opt/projecrt/

RUN apk update && apk add --no-cache gcc musl-dev

RUN pip install --user --no-cache-dir fastapi uvicorn
# Copier le code source
COPY . .

# Étape 2 : Image finale de production
FROM python:3.13.2-alpine

WORKDIR opt/projecrt/

# Copier uniquement les fichiers nécessaires depuis l'étape de construction
COPY --from=builder /opt/projecrt/ /opt/projecrt/
COPY --from=builder /root/.local /root/.local

# Ajouter le dossier des exécutables installés via pip à la variable PATH
ENV PATH=/root/.local/bin:$PATH

# Exposer le port (si votre application écoute sur un port, ici par exemple 8000)
EXPOSE 8000

#Commande par défaut pour lancer l'application
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]