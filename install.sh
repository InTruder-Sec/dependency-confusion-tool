sudo apt-get install -y gh jq golang && \
go install github.com/visma-prodsec/confused@latest && \
sudo cp $HOME/go/bin/confused /usr/local/bin
