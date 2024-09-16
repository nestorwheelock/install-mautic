
# Mautic Installation Script

This script automates the installation and setup of a Mautic server on FreeBSD along with necessary dependencies like Apache, MariaDB, PHP, and additional required packages. The script also generates a random database password for Mautic and configures the system accordingly.

## Features

- Sets up hostname, Apache, and MySQL services to start on boot.
- Installs necessary packages such as MariaDB, PHP, Apache, Git, and Node.js.
- Downloads and installs Mautic.
- Configures the Mautic database with a randomly generated password.
- Sets appropriate file permissions for Mautic files.

## Requirements

- FreeBSD operating system
- Internet access to download necessary packages and Mautic

## Usage

### Step 1: Clone the repository or download the script

Download the script directly:

```bash
wget https://your-server/mautic-install.sh
chmod +x mautic-install.sh
```

Alternatively, clone the repository if available:

```bash
git clone https://github.com/your-username/mautic-installer.git
cd mautic-installer
chmod +x mautic-install.sh
```

### Step 2: Run the script

Run the script as root or with sudo:

```bash
./mautic-install.sh
```

### Step 3: Database Details

After running the script, a file `/root/mauticnotes` will be created containing the database details, including:

- **Database name**: `mautic`
- **Database user**: `mautic`
- **Database password**: Randomly generated password
- **Database host**: `127.0.0.1`

You can reference this file for the database credentials during Mautic setup.

### Step 4: Access Mautic

Once the script finishes, you can access Mautic through the configured IP address or hostname. For example:

```bash
http://192.168.1.34
```

or

```bash
http://mautic.scity.co
```

### Additional Notes

- The script installs PHP 8.0 with various extensions required by Mautic.
- Apache and MySQL services are set to start on boot.
- You may need to configure Apache further based on your environment.

## License

This script is provided under the MIT License. See the [LICENSE](LICENSE) file for more details.
