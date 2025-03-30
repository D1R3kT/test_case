#!/bin/bash
set -eo pipefail

API_BASE_URL="http://localhost:8080/api/v1"
AUTH_TOKEN="api_token"

handle_error() {
    echo "Ошибка в строке $1: $2" >&2
    exit 1
}

trap 'handle_error $LINENO "$BASH_COMMAND"' ERR

echo "Получаем список пользователей..."
response=$(curl -s -X GET \
    -H "Content-Type: application/json" \
    "$API_BASE_URL/users")

users=$(echo "$response" | jq -r '.[] | select(.signingEnabled == "f") | .id')

if [[ -z "$users" ]]; then
    echo "Нет пользователей с отключенным подписанием"
    exit 0
fi

count=0
for user_id in $users; do
    echo "Обрабатываем пользователя $user_id..."
    http_status=$(curl -s -o /dev/null -w "%{http_code}" -X PUT \
        -H "Content-Type: application/json" \
        "$API_BASE_URL/users/$user_id/signing/enable")

    if [[ "$http_status" == "200" || "$http_status" == "204" ]]; then
        count=$((count + 1))
        echo "Успешно включено подписание для $user_id"
    else
        echo "Ошибка при обработке $user_id (HTTP $http_status)" >&2
    fi
done

echo "Готово! Обработано пользователей: $count"
