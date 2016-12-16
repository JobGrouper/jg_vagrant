# PUPPET INSTALLATION

echo "Adding puppet repository"
sudo rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-5.noarch.rpm

echo "Install wget"
sudo yum -y install wget

echo "Installing dos2unix"
sudo yum -y install dos2unix

echo "Installing vim"
sudo yum -y install vim

echo "Installing SELinux Tools"
sudo yum -y install vsftpd
sudo yum -y install policycoreutils policycoreutils-python selinux-policy selinux-policy-targeted libselinux-utils setroubleshoot-server setools setools-console mcstrans

echo "Adding binary files to path"
PATH=$PATH:~/opt/puppetlabs/bin

#if ! [[rpm -qa | grep -q webtatic-release]]; then
#fi
echo "Adding repositories for PHP5.6"
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

echo "Adding repos for Mysql 5.6"
wget https://dev.mysql.com/get/mysql57-community-release-el5-7.noarch.rpm
sudo rpm -Uvh mysql57-community-release-el5-7.noarch.rpm

echo "Specifying Mysql Install series"
sudo sed -i '12 s/enabled=0/enabled=1/g' /etc/yum.repos.d/mysql-community.repo # enable 5.6
sudo sed -i '19 s/enabled=1/enabled=0/g' /etc/yum.repos.d/mysql-community.repo # disable 5.7; I know it's messy

echo "Installing beanstalkd"
sudo yum -y --enablerepo=epel install beanstalkd

echo "Installing Puppet-Agent"
sudo yum -y install puppet-agent

echo "=================================================="
echo "Starting Puppet Service"
echo "=================================================="

sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

echo "======================================================================="
echo "Nothing might happen for a little while. Puppet needs to update Linux"
echo "......................................................................"
echo "You'll see what I mean in a second..."
echo "......................................................................"

