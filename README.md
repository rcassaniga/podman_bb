# podman_bb


Créditos a jsalatiel/wsbb-podman, farribeiro/wscef-docker e juliohm1978/dockerbb

O contêiner tem o módulo de segurança (warsaw) instalado e o navegador é o
firefox.

É necessário rodar o comando prepare.sh para ser possível compartilhar dados
entre o contêiner e hospedeiro. Quaisquer arquivos baixados pelo navegador do
contêiner será salvo no diretório /home/user/Downloads que será mapeado ao
diretório ~/BBShare no hospedeiro. Isso é bastante útil se se pretente baixar
extratos em PDF por exemplo.

https://www.tutorialworks.com/podman-rootless-volumes/

**make build** para construir o contêiner

**make start** para rodar o contêiner. Aguarde e o navegador aparecerá.

O contêiner é destruído quando o navegador é encerrado.

