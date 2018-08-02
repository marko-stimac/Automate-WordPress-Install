### What this script should do: 

- create database in PHPMyAdmin
- install latest Wordpress
- install some plugins, for a full list see composer.json. If you have ACF PRO key put it in place of XXXX and add this under require

        "advanced-custom-fields/advanced-custom-fields-pro": "*",
    
- set some usual settings like: static homepage, pretty permalinks, Blog as default category, create nav with Frontpage and Contact, disable indexing, comments and pings...
- harden Wordpress with some definitions inside .htaccess
- set https redirects
- separates local from live config
- generate posts with featured image

Script can be easily extended with installation of your preferred theme, doing npm install and other things depending on your setup. If you need help you can contact me, I have omitted it from this script since we use private Bitbucket repository for such things.

###Requirements: 

- Composer
- Node
- Git Bash
- WP-CLI (if you are on Windows it should be accessible from bash)
- SSH keys for GitHub

Also be sure that in your ~/.wp-cli/config.yml there is

     apache_modules:
       - mod_rewrite

### Steps

1. Create a folder for project and inside do

     git clone git@github.com:marko-stimac/Automate-Wordpres-Install.git .

2. Optionally change some variables at the beginning of start.sh

3. Start the script and answer a few question

        bash start.sh

4. Local configuration will be set in wp-config-local.php (don't upload it live), for live configuration use wp-config.php. 