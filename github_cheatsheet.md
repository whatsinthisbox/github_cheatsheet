Oto ściągawka dotycząca obsługi repozytoriów prywatnych na GitHubie oraz zarządzania kluczami SSH:

---

### **Ściągawka do obsługi repozytoriów prywatnych na GitHubie i kluczy SSH**

#### **1. Tworzenie klucza SSH**

Jeśli potrzebujesz nowego klucza SSH do połączenia z GitHubem:

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ~/.ssh/github_key
```

Następnie dodaj klucz publiczny do GitHuba:
- Skopiuj klucz publiczny:
  ```bash
  cat ~/.ssh/github_key.pub
  ```
- Wklej go do GitHuba w ustawieniach konta, w sekcji **SSH and GPG keys**.

#### **2. Konfiguracja agenta SSH**

Aby nie musieć każdorazowo podawać klucza przy połączeniu z GitHubem:

1. Uruchom agenta SSH:
   ```bash
   eval "$(ssh-agent -s)"
   ```

2. Dodaj klucz do agenta:
   ```bash
   ssh-add ~/.ssh/github_key
   ```

#### **3. Konfiguracja pliku `~/.ssh/config`**

Jeśli masz wiele kluczy SSH i repozytoriów, możesz skonfigurować plik `~/.ssh/config`, aby GitHub wiedział, który klucz ma używać dla którego repozytorium.

```bash
nano ~/.ssh/config
```

Dodaj poniższą konfigurację dla każdego repozytorium:

```bash
# Konfiguracja dla repozytorium prywatnego
Host github-repo
  HostName github.com
  User git
  IdentityFile ~/.ssh/github_key
  IdentitiesOnly yes
```

#### **4. Inicjalizacja repozytorium lokalnego i połączenie z GitHubem**

1. **Przejdź do folderu z plikami**:
   ```bash
   cd /path/to/your/folder
   ```

2. **Zainicjuj repozytorium Git**:
   ```bash
   git init
   ```

3. **Dodaj pliki do repozytorium**:
   ```bash
   git add .
   ```

4. **Zatwierdź zmiany**:
   ```bash
   git commit -m "Initial commit"
   ```

5. **Powiąż repozytorium lokalne z GitHubem**:
   ```bash
   git remote add origin git@github.com:whatsinthebox/github_cheatsheet.git
   ```

6. **Wgraj pliki na GitHub**:
   ```bash
   git push -u origin master
   ```

#### **5. Sprawdzenie połączenia SSH z GitHubem**

Aby upewnić się, że połączenie działa, przetestuj je:

```bash
ssh -T git@github.com
```

---

### Tworzenie repozytorium `github_cheatsheet` i wgrywanie ściągawki

1. Utwórz plik `github_cheatsheet.md` w swoim folderze:
   ```bash
   nano github_cheatsheet.md
   ```

2. Skopiuj powyższą ściągawkę do pliku i zapisz.

3. Wykonaj kroki opisane w ściągawce:
   - **Inicjalizacja repozytorium**:
     ```bash
     git init
     git add github_cheatsheet.md
     git commit -m "Dodanie ściągawki z obsługi GitHub i kluczy SSH"
     ```

   - **Powiązanie z GitHubem i wysłanie plików**:
     ```bash
     git remote add origin git@github.com:whatsinthebox/github_cheatsheet.git
     git push -u origin master
     ```

Teraz Twoja ściągawka powinna być dostępna w prywatnym repozytorium na GitHubie.
