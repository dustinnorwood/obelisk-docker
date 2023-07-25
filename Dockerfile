FROM nixos/nix:2.5.1

COPY ./nix.conf /etc/nix/nix.conf

RUN mkdir -p /var/lib/strato-obelisk

COPY . /var/lib/strato-obelisk/

RUN nix-env -f https://github.com/obsidiansystems/obelisk/archive/master.tar.gz -iA command \
  && cd /var/lib/strato-obelisk \
  && mkdir exe \
  && ln -s $(nix-build -A exe --no-out-link)/* exe/ \
  && cp -r config exe

WORKDIR /var/lib/strato-obelisk/exe

EXPOSE 8000

CMD ./backend
