# podman_bb


Créditos a jsalatiel/wsbb-podman, farribeiro/wscef-docker e juliohm1978/dockerbb

O contêiner tem o módulo de segurança (warsaw) instalado e o navegador é o
firefox. Testado numa máquina hospedeira Ubuntu 21.04

**make build** para construir o contêiner

**make start** para rodar o contêiner. Aguarde e o navegador aparecerá.

O contêiner é destruído quando o navegador é encerrado.

Durante o processo de criação do contêiner, é também criado o diretório no
~/BBShare na maquina hospedeira. Quaisquer arquivos baixados pelo navegador do
contêiner será salvo no diretório /home/user/Downloads (dentro do contêiner)
que será mapeado ao diretório ~/BBShare no hospedeiro. Isso é bastante útil se
se pretente baixar extratos em PDF por exemplo.

O contêiner foi construido para rodar em modo _rootless_ Conforme em [1] os
arquivos descarregados pelo contêiner **não terão as mesmas permissões do
usuário no hospedeiro.** Isso significa que, em princípio, dentro
do hospedeiro não seria possivel apagar ou editar um aquivo descarregado pelo
firefox, que roda do contêiner.

Para que seja possível manipular (editar, apagar, etc) tais aquivos no
hospedeiro, é necessário rodar o seguinte comando conforme [2]:

$ buildah unshare

[1] https://www.tutorialworks.com/podman-rootless-volumes/
[2] https://podman.io/blogs/2018/10/03/podman-remove-content-homedir.html

divirta-se
--
rcassaniga
