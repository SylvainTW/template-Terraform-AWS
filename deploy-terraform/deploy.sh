#!/bin/bash

# Charger le fichier de configuration
source config.env

# Vérifier si un environnement est passé en paramètre et s'il est valide
if [ -z "$1" ]; then
  echo "Error: No environment specified."
  echo "Usage: $0 {prod|preprod|dev}"
  echo "Please provide one of the following environments as an argument:"
  echo "  - prod: Production environment"
  echo "  - preprod: Pre-production environment"
  echo "  - dev: Development environment"
  exit 1
fi

# Définir l'environnement
ENV=$1

# Valider l'environnement
case $ENV in
  prod|preprod|dev)
    # Environnement valide, continuer
    ;;
  *)
    echo "Error: Invalid environment specified."
    echo "Usage: $0 {prod|preprod|dev}"
    echo "Please provide one of the following environments as an argument:"
    echo "  - prod: Production environment"
    echo "  - preprod: Pre-production environment"
    echo "  - dev: Development environment"
    exit 1
    ;;
esac

# Définir l'environnement
ENV=$1

# Définir les chemins des fichiers de configuration en fonction de l'environnement
BACKEND_CONFIG="backend/$ENV.tfbackend"
VARS_FILE="vars/$ENV.tfvars"

# Définir le chemin du répertoire à supprimer
DIR="./.terraform"

# Afficher le chemin pour le débogage
echo "Vérification du répertoire : $DIR"

# Vérifier si le répertoire existe
if [ -d "$DIR" ]; then
  echo "Suppression du répertoire $DIR"
  rm -rf "$DIR"
else
  echo "Le répertoire $DIR n'existe pas"
fi

# Initialiser Terraform avec la configuration du backend
echo "Initialisation de Terraform avec la configuration du backend : $BACKEND_CONFIG"
aws-vault exec $AWS_VAULT_USER -- terraform init -backend-config=$BACKEND_CONFIG

# Planifier les changements d'infrastructure
echo "Planification des changements d'infrastructure avec le fichier de variables : $VARS_FILE"
aws-vault exec $AWS_VAULT_USER -- terraform plan -var-file=$VARS_FILE

# Appliquer les changements
echo "Application des changements d'infrastructure avec le fichier de variables : $VARS_FILE"
aws-vault exec $AWS_VAULT_USER -- terraform apply -var-file=$VARS_FILE
