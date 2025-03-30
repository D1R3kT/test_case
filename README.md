# Тестовый проект
Проект предназначен для демонстрации навыков работы с bash-скриптами и docker-файлами

## Установка  

1. Клонируйте репозиторий:  
   ```bash
   git clone git@github.com:D1R3kT/test_case.git
   ```  
2. Выполните команду для запуска контейнера:  
   ```bash
   docker compose up -d
   ```  
3. Проверьте права доступа для файлов singingEnabled.sh и unlock_user.sh, необходимо предоставить права на выполнение:  
   ```bash
   ls -l
   ``` 
   ```bash
   chmod +x ./singingEnabled.sh ./unlock_user.sh
   ``` 
4. Запустите скрипт singingEnabled.sh, а затем unlock_user.sh:  
   ```bash
   ./singingEnabled.sh
   ``` 
   ```bash
   ./unlock_user.sh
   ```
   Изменения можно проверить перейдя по ссылке: <http://localhost:8080/api/v1/users>
   
