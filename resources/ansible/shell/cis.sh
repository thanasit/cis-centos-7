#!/bin/bash

echo 'This system is for the use of authorized users only!!! Individuals using this computer system with authority, without authority, or in excess of their authority, are subject to having all of their activities on this system monitored and recorded by system personnel. In the course of monitoring individuals improperly using this system, or in the course of system maintenance, the activities of authorized users may also be monitored. Anyone using this system expressly consents to such monitoring and is advised that if such monitoring reveals possible evidence of criminal activity, system personnel may provide the evidence of such monitoring to law enforcement officials.' > /etc/issue
echo 'This system is for the use of authorized users only!!! Individuals using this computer system with authority, without authority, or in excess of their authority, are subject to having all of their activities on this system monitored and recorded by system personnel. In the course of monitoring individuals improperly using this system, or in the course of system maintenance, the activities of authorized users may also be monitored. Anyone using this system expressly consents to such monitoring and is advised that if such monitoring reveals possible evidence of criminal activity, system personnel may provide the evidence of such monitoring to law enforcement officials.' > /etc/issue.net
echo 'This system is for the use of authorized users only!!!' > /etc/motd

TTYS0=`grep 'ttyS0' /etc/securetty | wc -l`
TTYS1=`grep 'ttyS1' /etc/securetty | wc -l`
if [ $TTYS0 -eq 0 ]; then
	echo 'ttyS0' >> /etc/securetty
fi 
if [ $TTYS1 -eq 0 ]; then
	echo 'ttyS1' >> /etc/securetty
fi

chown  root:root  /etc/hosts.allow 
chmod  0644       /etc/hosts.allow 
chown  root:root  /etc/hosts.deny 
chmod  0644       /etc/hosts.deny

chkconfig --level 12345 xinetd off
chkconfig --level 12345 xfs off 
chkconfig --level 12345 kudzu off
chkconfig --level 12345 isdn off
chkconfig --level 12345 ip6tables off
chkconfig --level 12345 iptables off
chkconfig --level 12345 avahi-daemon off
chkconfig --level 12345 bluetooth off
chkconfig --level 12345 gpm off
chkconfig --level 12345 hidd off
chkconfig --level 12345 hplip off
chkconfig --level 12345 pcscd off
chkconfig --level 12345 rhnsd off
chkconfig --level 12345 autofs off
chkconfig --level 12345 nfslock off
chkconfig --level 12345 portmap off
chkconfig --level 12345 netfs off
chkconfig avahi-daemon off  
chkconfig cups off 
chkconfig nfslock off
chkconfig rpcgssd off
chkconfig rpcbind off
chkconfig rpcidmapd off
chkconfig rpcsvcgssd off

ls -lad /etc/cron* /var/spool/cron* 
chown  root:root  /etc/crontab 
chmod  0400       /etc/crontab 
chown  -R  root:root  /var/spool/cron 
chmod  -R  go-rwx     /var/spool/cron
chmod 0700 /root

/sbin/sysctl -w net.ipv4.conf.all.send_redirects=0
/sbin/sysctl -w net.ipv4.conf.default.send_redirects=0
/sbin/sysctl -w net.ipv4.route.flush=1
/bin/ed /etc/sysctl.conf << END
g/^net\.ipv4.conf\.all\.send_redirects.*=/d
g/^net\.ipv4\.conf\.default\.send_redirects.*=/d
\$a
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
.
w
q
END

/sbin/sysctl -w net.ipv4.conf.all.accept_redirects=0
/sbin/sysctl -w net.ipv4.conf.default.accept_redirects=0
/sbin/sysctl -w net.ipv4.route.flush=1
/bin/ed /etc/sysctl.conf << END
g/^net\.ipv4\.conf\.all\.accept_redirects.*=/d
g/^net\.ipv4\.conf\.default\.accept_redirects. =*/d
\$a
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
.
w
q
END

/sbin/sysctl -w net.ipv4.conf.all.log_martians=1
/sbin/sysctl -w net.ipv4.conf.default.log_martians=1
/sbin/sysctl -w net.ipv4.route.flush=1
/bin/ed /etc/sysctl.conf << END
g/^net\.ipv4\.conf\.all\.log_martians.*=/d
g/^net\.ipv4\.conf\.default\.log_martians.*=/d
\$a
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
.
w
q
END

/sbin/sysctl -w net.ipv6.conf.all.accept_ra=0
/sbin/sysctl -w net.ipv6.conf.default.accept_ra=0
/sbin/sysctl -w net.ipv6.route.flush=1
/bin/ed /etc/sysctl.conf << END
g/^net\.ipv6\.conf\.all\.accept_ra.*=/d
g/^net\.ipv6\.conf\.default\.accept_ra.*=/d
\$a
net.ipv6.conf.all.accept_ra = 0
net.ipv6.conf.default.accept_ra = 0
.
w
q
END

/sbin/sysctl -w net.ipv6.conf.all.accept_redirects=0
/sbin/sysctl -w net.ipv6.conf.default.accept_redirects=0
/sbin/sysctl -w net.ipv6.route.flush=1
/bin/ed /etc/sysctl.conf << END
g/^net\.ipv6\.conf\.all\.accept_redirects.*=/d
g/^net\.ipv6\.conf\.default\.accept_redirects.*=/d
\$a
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0
.
w
q
END

echo 'options ipv6 disable=1' > /etc/modprobe.d/ipv6.conf
chmod og-rwx /etc/rsyslog.conf
chown root:root /etc/anacrontab
chmod og-rwx /etc/anacrontab
chown root:root /etc/crontab
chmod og-rwx /etc/crontab
chown root:root /etc/cron.daily
chmod og-rwx /etc/cron.daily 
chown root:root /etc/cron.hourly
chown root:root /etc/cron.weekly
chown root:root /etc/cron.monthly
chmod og-rwx /etc/cron.hourly 
chmod og-rwx /etc/cron.weekly
chmod og-rwx /etc/cron.monthly
chown root:root /etc/cron.d
chmod og-rwx /etc/cron.d
rm -rf /etc/at.deny
touch /etc/at.allow
chown root:root /etc/at.allow
chmod og-rwx /etc/at.allow

yum -y -q install sysstat
yum -y -q erase ypbind
echo 'NETWORKING_IPV6=no' >> /etc/sysconfig/network
echo 'IPV6INIT=no' >> /etc/sysconfig/network
echo 'install dccp /bin/true' >> /etc/modprobe.d/CIS.conf
echo 'umask 027' >> /etc/sysconfig/init

PERMITROOTLOGIN=`grep '#PermitRootLogin' /etc/ssh/sshd_config | wc -l`
PERMITEMPTYPASSWORDS=`grep '#PermitEmptyPasswords' /etc/ssh/sshd_config | wc -l`
BANNER=`grep '#Banner' /etc/ssh/sshd_config | wc -l`
LOGLEVEL=`grep '#LogLevel' /etc/ssh/sshd_config | wc -l`
X11FORWARDING=`grep '#X11Forwarding' /etc/ssh/sshd_config | wc -l`
MAXAUTHTRIES=`grep '#MaxAuthTries' /etc/ssh/sshd_config | wc -l`
IGNORERHOSTS=`grep '#IgnoreRhosts' /etc/ssh/sshd_config | wc -l`
HOSTBASEDAUTHENICATION=`grep '#HostbasedAuthentication' /etc/ssh/sshd_config | wc -l`


if [ $PERMITROOTLOGIN -eq 1 ]; then
	echo 'PermitRootLogin no' >> /etc/ssh/sshd_config
fi
if [ $PERMITEMPTYPASSWORDS -eq 1 ]; then
	echo 'PermitEmptyPasswords no' >> /etc/ssh/sshd_config
fi
if [ $BANNER -eq 1 ]; then
	echo 'Banner /etc/issue.net' >> /etc/ssh/sshd_config
fi
if [ $LOGLEVEL -eq 1 ]; then
	echo 'LogLevel INFO' >> /etc/ssh/sshd_config
fi
if [ $X11FORWARDING -eq 1 ]; then
	echo 'X11Forwarding yes' >> /etc/ssh/sshd_config
fi
if [ $MAXAUTHTRIES -eq 1 ]; then
	echo 'MaxAuthTries 4' >> /etc/ssh/sshd_config
fi
if [ $IGNORERHOSTS -eq 1 ]; then
	echo 'IgnoreRhosts yes' >> /etc/ssh/sshd_config
fi
if [ $HOSTBASEDAUTHENICATION -eq 1 ]; then
	echo 'HostbasedAuthentication no' >> /etc/ssh/sshd_config
fi