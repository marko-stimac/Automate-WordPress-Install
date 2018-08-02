#!/bin/bash -ee

###################### CONFIG #####################
# Project path from localhost root if necessary, the project currently will be at http://localhost/project
# For example set it to "_work/" if you want organize project inside some folder
project_path=""
# Category name
category="Blog"
# Contact page
contact="Contact"
# Page title
frontpage="Homepage"
# Timezone
timezone="Europe/Zagreb"
# Current directory name (project slug)
project_slug=${PWD##*/}

###################### VARIABLES #####################

# Project name
read -p "Enter project name (Wordpress setting): " project_name
# Database name
read -e -p "Enter database name (database will be created in PHPMyAdmin): " -i $project_slug database
# Enter username
read -p "Enter username: " username
# Admin email
read -p "Enter admin email: " admin_email
# Wordpress locale
read -e -p "Wordpress locale: " -i "en_US" locale

echo "==========================================="
echo "Lets begin!"
echo "==========================================="

###################### DOWNLOAD WORDPRESS #####################

# Install Wordpress
echo "Downloading Wordpress...":
wp core download --locale=$locale --skip-content

###################### DATABASE AND PROJECT SETUP #####################

# Generate password for login
passgen=`head -c 10 /dev/random | base64`
project_password=${passgen:0:10}

echo "Creating database $database..."
mysql -uroot -e "CREATE DATABASE $database"

# Search and replace for htaccess and wp-config setup
sed -i -e "s@PROJECT_PATH@$project_path@g" .htaccess
sed -i -e "s@PROJECT_PATH@$project_path@g" wp-config-local.php
sed -i -e "s/PROJECT_SLUG/$project_slug/g" .htaccess
sed -i -e "s/PROJECT_SLUG/$project_slug/g" wp-config.php
sed -i -e "s/PROJECT_SLUG/$project_slug/g" wp-config-local.php
sed -i -e "s/PROJECT_DATABASE/$database/g" wp-config-local.php

# Initialize Wordpress database setup
wp core install --url=localhost/$project_slug --title="$project_name" --admin_user=$username  --admin_password=$project_password --admin_email=$admin_email

###################### COMPOSER PLUGINS ######################

# Plugin download
echo "Installing Composer files..."
composer install

# Delete Composer folder because it is not needed as all updates later will be done through Wordpress
echo "Deleting Composer files..."
rm -rf vendor

###################### WORDPRESS SETUP #####################

# Install default theme
wp theme install twentysixteen --activate

# Activate all plugins
wp plugin activate --all
# Deactivate Wordfence because it is not needed yet
wp plugin deactivate wordfence

# Delete blog description
wp option update blogdescription ""

# Deactivate indexing
wp option update blog_public 0

# Delete sample post and page
wp post delete 1 2

# Generate Frontpage
wp post generate --count=1 --post_type=page --post_title=$frontpage --post_content=""
# Generate Contact page
wp post generate --count=1 --post_type=page --post_title=$contact --post_content=""
# Generate posts and set featured image
wp post generate --count=20 --format=ids | xargs -0 -d ' ' -I % wp post meta update % _thumbnail_id 29

# Deactivate option for post comments
wp option set default_comment_status closed

# Set static frontpage
wp option update show_on_front page
wp option update page_on_front 6

# Disable pingback
wp option update default_pingback_flag 0
wp option update default_ping_status 0

# Set timezone
wp option update timezone_string "$timezone"

# Set pretty permalinks
wp rewrite structure "%postname%/" --hard

# Import placeholder image
wp media import https://i.imgur.com/qYpvAeJ.jpg

# Create menu
wp menu create "Nav"
# Add pages by id to Nav menu
wp menu item add-post Nav 6 # Frontpage
wp menu item add-post Nav 7 # Contact
# Set Nav to primary-menu location
wp menu location assign Nav primary-menu

# Update category
wp term update category 1 --name=$category --slug=${category,,}

# Go to root directory and delete script files to clean a bit and to maintain Wordpress integrity
rm composer.json
rm composer.lock
rm start.sh

echo "==========================================="
echo "==========================================="
echo "==========================================="
echo "Install is finished. Login credentials are:"
echo "Username: $username"
echo "Password: $project_password"

# Open in browser
start http://localhost/$project_path$project_slug/wp-admin