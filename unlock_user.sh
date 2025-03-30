#!/bin/bash
set -e

CONTAINER_NAME="test-db"
POSTGRES_DB="testdb"
POSTGRES_USER="dbuser"
POSTGRES_PASSWORD="12345"
UPDATE_QUERY="UPDATE users SET is_blocked = 'f';"
CHECK_QUERY="SELECT id, is_blocked FROM users;"

echo "Запуск разблокировки ползователей"

docker exec -i "$CONTAINER_NAME" psql \
 -U "$POSTGRES_USER" \
 -d "$POSTGRES_DB" \
 -W \
 -c "$UPDATE_QUERY"

if [ $? -eq 0 ]; then
  echo "Все пользователи успешно разблокированы!"
  docker exec -i "$CONTAINER_NAME" psql \
    -U "$POSTGRES_USER" \
    -d "$POSTGRES_DB" \
    -W \
    -c "$CHECK_QUERY"
else
  echo "Ошибка при выполнении операции" >&2
  exit 1
fi
