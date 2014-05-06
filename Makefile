#Make file for bash-player
#Install: sudo make install
#Uninstall: sudo make uninstall
#Written by levi

BIN=/usr/bin
DESKTOP=/usr/share/applications
PIXMAPS=/usr/share/pixmaps

install:
	@echo "Installing bash-player [FULL].."
	install -Dm755 bmplayer.sh "${BIN}/bmplayer"
	install -Dm755 mplayer_config.sh "${BIN}/mplayer_config"
	install -Dm755 bash-otube.sh "${BIN}/botube"
	install -Dm755 bash-player.desktop "${DESKTOP}"
	install -Dm755 bash-otube.desktop "${DESKTOP}"
	install -Dm755 bash-player.svg "${PIXMAPS}"
	install -Dm755 bash-otube.svg "${PIXMAPS}"

install-bash-otube:
	@echo "Installing bash-otube [ONLY].."
	install -Dm755 bash-otube.sh "${BIN}/botube"
	install -Dm755 bash-otube.svg "${PIXMAPS}"
	install -Dm755 bash-otube.desktop "${DESKTOP}"

install-bash-player:
	@echo "Installing bash-player [ONLY].."
	install -Dm755 bmplayer.sh "${BIN}/bmplayer"
	install -Dm755 bash-player.svg "${PIXMAPS}"
	install -Dm755 bash-player.desktop "${DESKTOP}"

uninstall:
	@echo "Uninstalling bash-player.."
	rm -f "${BIN}/bmplayer"
	rm -f "${BIN}/mplayer_config"
	rm -f "${BIN}/botube"
	rm -f "${DESKTOP}/bash-player.desktop"
	rm -f "${DESKTOP}/bash-otube.desktop"
	rm -f "${PIXMAPS}/bash-player.svg"
	rm -f "${PIXMAPS}/bash-otube.svg"


.PHONY: install install-bash-player install-bash-otube uninstall
