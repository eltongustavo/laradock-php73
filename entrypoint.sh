#!/bin/bash

# Exibe mensagem de início
echo "Iniciando o processo de criação do projeto Laravel..."

# Verifica se o diretório do projeto Laravel já existe
if [ ! -d "/var/www/html/project" ]; then
    # Cria o projeto Laravel e mostra a saída
    composer create-project --prefer-dist laravel/laravel:^8.0 project
fi

# Ajusta a propriedade do diretório para todos os usuários
chown -R www-data:www-data /var/www/html/project
chmod -R 777 /var/www/html/project

# Define permissões apropriadas
find /var/www/html/project -type d -exec chmod 777 {} \;
find /var/www/html/project -type f -exec chmod 666 {} \;

# Inicia o Apache no primeiro plano
exec apache2-foreground

