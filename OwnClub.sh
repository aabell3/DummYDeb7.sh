#script Modify By mr's Dummy
    #!/bin/bash

    clear

    echo ” ”
    echo “*****************************************************”
    echo “WELCOME TO THE OWNCLOUD INSTALLATION SCRIPT”
    echo “—————————————————–”
    echo ” ”
    echo ” This script will set up a ownCloud storage”
    echo ”             server on your target server”
    echo ” ”
    echo “*****************************************************”

    clear

    echo ” ”
    echo “****************************************************************”
    echo “Please enter the domain you would like to use to access ownCloud”
    echo “****************************************************************”
    read d

    clear

    echo ” ”
    echo “*******************************************************************************************”
    echo “THIS SCRIPT WILL REMOVE MYSQL, APACHE AND NGINX ALONG WITH THIER CONFIG FILES AND DATABASES”
    echo “——————————————————————————————-”
    echo ” ”
    echo ” If you do not want to continue with this script”
    echo ”             you have 15 seconds to enter Ctrl + C to Cancel”
    echo ” ”
    echo “*************************************************************”

    sleep 15

    clear

    apt-get update -y
    apt-get upgrade -y
    apt-get –purge remove apache2* php* mysql* -y

    cat <<EOF >> /etc/apt/sources.list
    deb http://packages.dotdeb.org wheezy all
    deb-src http://packages.dotdeb.org wheezy all
    EOF

    wget http://www.dotdeb.org/dotdeb.gpg
    apt-key add dotdeb.gpg

    apt-get update

    apt-get install nginx php5 php5-fpm php5-gd php5-mysql -y

    clear

    echo ” ”
    echo “***************************************************************”
    echo “YOU WILL NOW BE ASKED TO ENTER A PASSWORD FOR YOUR MYSQL SERVER”
    echo “—————————————————————”
    echo ” ”
    echo ” Please enter a password when prompted, this needs to be remembered”
    echo ” ”
    echo “********************************************************************”

    sleep 5

    clear

    apt-get install mysql-server -y

    echo ” ”
    echo “******************************************************************”
    echo “YOU WILL NOW BE ASKED TO ENTER A PASSWORD FOR YOUR MYSQL DATABASE”
    echo “——————————————————————”
    echo ” ”
    echo ” Please enter a password you entered above to create a database for ownCloud”
    echo ” ”
    echo “*****************************************************************************”

    mysql -u root -p -e “create database ownCloud”;

    rm /etc/nginx/sites-available/default

    wget http://etapien.com/scripts/owncloud/default.txt

    cp default.txt /etc/nginx/sites-available/default

    cat <<EOF >> /etc/nginx/sites-available/default
    server_name $d;

    }
    EOF

    clear

    mkdir -p /var/www/owncloud

    wget http://download.owncloud.org/community/owncloud-6.0.1.tar.bz2

    apt-get install bzip2 -y

    tar xvjf owncloud-6.0.1.tar.bz2

    mv owncloud/* /var/www/owncloud

    mkdir /var/www/owncloud/data

    chown -R www-data:www-data /var/www/owncloud/

    service nginx restart

    clear

    echo ” ”
    echo “*****************************************************”
    echo “THE INSTALLATION HAS FINSIHED”
    echo “—————————————————–”
    echo ” ”
    echo ” Please browse to $d or your IP in your browser to access ownCloud”
    echo ” The Database User is root and the password is the same as the one you entered above”
    echo ” the Database is ownCloud and the host is localhost”
    echo ” Once you have entered those details along with your new username and password ownCloud should work correctly.”
    echo ” ”
    echo “**************************************************************************************************************”
