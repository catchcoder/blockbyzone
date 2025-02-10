# blockbyzone

Country IP from http://www.ipdeny.com/

## Make IPTABLES persistent

During the installation for `iptables-persistent`, you will be asked if you want to save your current firewall rules.

```bash
sudo apt update && sudo apt upgrade
sudo apt install iptables-persistent
```

## Making changes to IPTBALES

If you update your firewall rules and want to save the changes, run this command:

```bash
sudo netfilter-persistent save
```
