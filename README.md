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
   git remote add origin git@github.com:whatsinthisbox/github_cheatsheet.git
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
     git remote add origin git@github.com:whatsinthisbox/github_cheatsheet.git
     git push -u origin master
     ```

Teraz Twoja ściągawka powinna być dostępna w prywatnym repozytorium na GitHubie.

---
Różnica między `git push -u origin master` a `git push -u origin main` polega na nazwie domyślnej gałęzi, do której wysyłasz zmiany.

### 1. **`master` vs. `main`**:
- **`master`**: Przez wiele lat, w Git, domyślną nazwą głównej gałęzi, która była tworzona przy inicjalizacji repozytorium, była `master`.
- **`main`**: Od października 2020 roku Git zmienił domyślną nazwę głównej gałęzi na **`main`**, aby przyczynić się do większej inkluzywności językowej.

W rezultacie nowe repozytoria Git automatycznie używają nazwy `main` jako domyślnej gałęzi, chyba że zostanie to zmienione ręcznie.

### 2. **Polecenia `git push -u origin master` i `git push -u origin main`**:
- **`git push -u origin master`**: Wysyła zmiany do zdalnej gałęzi o nazwie `master` na serwerze (GitHub, GitLab, itd.). Ta komenda używana była w starszych repozytoriach Git, które miały domyślną gałąź nazwaną `master`.
- **`git push -u origin main`**: Wysyła zmiany do zdalnej gałęzi o nazwie `main` na serwerze. To jest nowa domyślna nazwa gałęzi w repozytoriach Git od 2020 roku.

### 3. **Kiedy użyć `master`, a kiedy `main`**:
- **Jeśli tworzysz nowe repozytorium**, używaj `main`, ponieważ jest to nowa domyślna nazwa.
- **Jeśli pracujesz nad starszym repozytorium**, które nadal używa gałęzi `master`, wtedy użyj `master`.
  
Możesz sprawdzić, która gałąź jest domyślna w Twoim repozytorium, wykonując polecenie:

```bash
git branch
```

Domyślna gałąź będzie oznaczona gwiazdką (`*`).

---

Aby pobrać prywatne repozytorium na innym laptopie z Windows 11 z WSL (Ubuntu), wykonaj następujące kroki:

### Krok 1: Skonfiguruj SSH do GitHub

1. **Zaloguj się do WSL i wygeneruj klucz SSH (jeśli go nie masz):**
   Otwórz terminal WSL (Ubuntu) i wygeneruj nowy klucz SSH:

   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```

   Wciśnij `Enter`, aby zaakceptować domyślne lokalizacje, a następnie utwórz hasło (jeśli chcesz zabezpieczyć klucz).

2. **Dodaj klucz prywatny do agenta SSH:**

   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_rsa
   ```

3. **Skopiuj klucz publiczny do GitHub:**

   Skopiuj zawartość klucza publicznego:

   ```bash
   cat ~/.ssh/id_rsa.pub
   ```

   Skopiuj tekst, który pojawi się w terminalu.

4. **Dodaj klucz SSH do GitHub:**
   - Wejdź na stronę GitHub, zaloguj się i przejdź do: `Settings -> SSH and GPG keys -> New SSH key`.
   - Wklej skopiowany klucz publiczny i nadaj mu nazwę.

### Krok 2: Sklonuj repozytorium

1. **Przejdź do pustego folderu w WSL:**

   ```bash
   cd /mnt/c/path/to/empty/folder
   ```

2. **Sklonuj repozytorium za pomocą SSH:**

   Używając swojego loginu i nazwy repozytorium, uruchom:

   ```bash
   git clone git@github.com:whatsinthebox/github_cheatsheet.git
   ```

   Pamiętaj, żeby zastąpić `whatsinthebox/github_cheatsheet.git` właściwą nazwą repozytorium.

3. **Wejdź do katalogu repozytorium:**

   ```bash
   cd github_cheatsheet
   ```

Teraz repozytorium jest sklonowane i możesz nad nim pracować na innym laptopie.
