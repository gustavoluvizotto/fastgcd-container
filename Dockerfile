# syntax=docker/dockerfile:1
FROM docker.io/debian:12
LABEL authors="Gustavo Luvizotto Cesar"

RUN apt-get update -y
RUN apt-get install curl -y
RUN apt-get install bzip2 -y
RUN apt-get install make -y
RUN apt-get install gcc -y
RUN apt-get install libgmp3-dev -y
RUN apt-get install patch -y
RUN apt-get install m4 -y

RUN curl -OL https://ftp.gnu.org/gnu/gmp/gmp-5.0.5.tar.bz2
RUN tar xf gmp-5.0.5.tar.bz2

COPY fastgcd.c .
COPY gmp-5.0.5.patch .
COPY install.sh .
COPY Makefile .

RUN sed -i 's/#define NTHREADS 4/#define NTHREADS 128/' fastgcd.c

RUN ./install.sh

FROM docker.io/alpine

COPY --from=0 fastgcd /bin/fastgcd
COPY fastgcd.sh /bin/fastgcd.sh

RUN chmod +x /bin/fastgcd.sh
WORKDIR /
RUN mkdir -p output

ENTRYPOINT ["/bin/fastgcd.sh"]
