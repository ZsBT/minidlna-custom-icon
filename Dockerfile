ARG GNUDIST=debian:stable

FROM $GNUDIST as builder

RUN sed -e 's/deb /deb-src /' /etc/apt/sources.list >/etc/apt/sources.list.d/src.list
RUN apt -qq update && apt -y install git build-essential >/dev/null
RUN apt -y build-dep minidlna >/dev/null

RUN git clone --quiet --depth 1 --single-branch https://git.code.sf.net/p/minidlna/git /usr/src/minidlna
WORKDIR /usr/src/minidlna

RUN git clone --quiet --depth 1 --single-branch https://aur.archlinux.org/minidlna-custom-icon.git /usr/src/custom-icon
RUN patch < /usr/src/custom-icon/minidlna-custom-icon.patch
RUN ./autogen.sh >autogen.log
RUN ./configure >configure.log
RUN make -j$(nproc) >make.log
RUN make install
RUN minidlnad -V


FROM $GNUDIST
ENV MINIDLNA_CONFIG /etc/minidlna.conf
ENV MINIDLNA_EXTRA_ARGS -S

RUN apt -qq update
RUN apt-cache depends minidlna | grep ' Depends: lib'|awk '{print $2}'|xargs apt -y install >/dev/null
RUN apt clean && find /var/lib/apt/lists -type f -delete
COPY --from=builder /usr/local/sbin/minidlnad /bin/

ENTRYPOINT minidlnad -S $MINIDLNA_EXTRA_ARGS -f $MINIDLNA_CONFIG
