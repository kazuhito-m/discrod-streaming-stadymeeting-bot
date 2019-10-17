FROM ubuntu:19.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      gnome-core \
      ubuntu-desktop \
      gnome-panel metacity nautilus gnome-terminal \
      tightvncserver \
      ibus \
      ibus-mozc \
      language-pack-ja-base \
      language-pack-ja \
      fonts-ipafont-gothic \
      fonts-ipafont-mincho \
    && apt-get remove -y clipit \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* \
    && rm -rf /var/lib/apt/lists/*

# Expose VNC port
EXPOSE 5901

# Set locale
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && echo 'Asia/Tokyo' > /etc/timezone
RUN locale-gen ja_JP.UTF-8 \
    && echo 'LC_ALL=ja_JP.UTF-8' > /etc/default/locale \
    && echo 'LANG=ja_JP.UTF-8' >> /etc/default/locale
ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8

# Copy VNC endpoint script
COPY scripts/entrypoint.sh /opt/
CMD ["/opt/entrypoint.sh"]
