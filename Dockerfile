FROM python:3.9-slim

RUN apt-get update \
    && apt-get install -y \
        build-essential \
        libchromaprint-tools \
        python3-gi \
        ffmpeg \
        imagemagick \
        pkg-config \
        libcairo2-dev \
        libgirepository1.0-dev \
        beets \
    && rm -rf /var/lib/apt/lists/*

RUN pip install pyacoustid \
    flask \
    flask-cors \
    requests \
    beautifulsoup4 \
    beets[thumbnails] \
    beets[bpd] \
    beets[bpm] \
    beets[fetchart] \
    beets[lyrics] \
    beets[inline] \
    beets[chroma] \
    beets[discogs]

ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID beets \
    && useradd -u $UID -g $GID -m beets
COPY config.yaml /home/beets/.config/beets/config.yaml
RUN chown -R beets:beets /home/beets
USER beets

ENTRYPOINT ["beet"]
