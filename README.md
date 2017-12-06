# AquariumControl
In order to run everything in the Web folder, the LAMP stack must first be installed.
LAMP stack stands for Linux, Apache, MySQL, and PHP. These three technologies used
together create the server that the system runs on. This guide assumes that Linux
is already installed on the machine being used to install the server. 

## Install LAMP Stack

This section of the README uses the documentation from Ubuntu to show the commands
in the terminal needed to install the required components of the server.

The tutorial can be found [here](http://howtoubuntu.org/how-to-install-lamp-on-ubuntu "Ubuntu LAMP Install")

1. **Install Apache**

To install Apache you must install the Metapackage apache2. This can be done by searching for and installing in the Software Centre, or by running the following command.

`sudo apt-get install apache2`

2. **Install MySQL**

To install MySQL you must install the Metapackage mysql-server. This can be done by searching for and installing in the Software Centre, or by running the following command.

`sudo apt-get install mysql-server`

3. **Install PHP**

To install PHP you must install the Metapackages php5 and libapache2-mod-php5. This can be done by searching for and installing in the Software Centre, or by running the following command.

`sudo apt-get install php5 libapache2-mod-php5`

## Setup Server
Now that the LAMP stack is installed (our sever), the server needs to be setup.

1. **Restart Server**

Your server should restart Apache automatically after the installation of both MySQL and PHP. If it doesn't, execute this command.

`sudo /etc/init.d/apache2 restart`

2. **Check Apache**

Open a web browser and navigate to http://localhost/. You should see a message saying It works!

3. **Check PHP**
You can check your PHP by executing any PHP file from within /var/www/. Alternatively you can execute the following command, which will make PHP run the code without the need for creating a file .

`php -r 'echo "\n\nYour PHP installation is working fine.\n\n\n";'`


#### If everything went smoothly (lucky you), you should now have your LAMP stack installed and your server is ready to use!