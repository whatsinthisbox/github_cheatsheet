#!/bin/bash

# Sprawdzenie, czy podano nazwę repozytorium jako parametr
if [ -z "$1" ]; then
  echo "Użycie: $0 <nazwa_repozytorium>"
  exit 1
fi

REPO_NAME=$1
KEY_PATH="$HOME/.ssh/id_rsa_$REPO_NAME"

# Generowanie klucza SSH
echo "Generowanie klucza SSH dla repozytorium: $REPO_NAME"
ssh-keygen -t rsa -b 4096 -C "$REPO_NAME@github.com" -f "$KEY_PATH" -N ""

# Uruchomienie agenta SSH, jeśli nie jest uruchomiony
if [ -z "$(pgrep ssh-agent)" ]; then
  echo "Uruchamianie agenta SSH"
  eval "$(ssh-agent -s)"
fi

# Dodanie klucza SSH do agenta
echo "Dodawanie klucza SSH do agenta"
ssh-add "$KEY_PATH"

# Dodanie wpisu do pliku ~/.ssh/config
CONFIG_FILE="$HOME/.ssh/config"
echo "Dodawanie konfiguracji do $CONFIG_FILE"

{
  echo ""
  echo "# Konfiguracja dla repozytorium $REPO_NAME"
  echo "Host github-$REPO_NAME"
  echo "  HostName github.com"
  echo "  User git"
  echo "  IdentityFile $KEY_PATH"
  echo "  IdentitiesOnly yes"
} >> "$CONFIG_FILE"

# Wyświetlenie klucza publicznego, aby można było go dodać do GitHuba
echo "Dodaj poniższy klucz publiczny do GitHuba:"
echo ""
cat "$KEY_PATH.pub"
echo ""

# Instrukcja dodania zdalnego repozytorium do Git
echo "Po dodaniu klucza do GitHuba, skonfiguruj repozytorium w folderze:"
echo "git remote add origin git@github.com:whatsinthisbox/$REPO_NAME.git"
echo "git push -u origin master"

