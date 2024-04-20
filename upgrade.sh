service ceremonyclient stop
cd ~/ceremonyclient
git fetch origin
git merge origin
cd ~/ceremonyclient/node
GOEXPERIMENT=arenas go clean -v -n -a ./...
rm /root/go/bin/node
ls /root/go/bin
GOEXPERIMENT=arenas  go  install  ./...
ls /root/go/bin
service ceremonyclient start
clear
sudo journalctl -u ceremonyclient.service -f --no-hostname -o cat
