FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y wget \
    unzip \
    default-jdk \
    xvfb \
    xorg \
    python \
    zip

RUN mkdir /install /install/bin
WORKDIR /install

# download IGV
RUN wget --quiet https://data.broadinstitute.org/igv/projects/downloads/2.7/IGV_Linux_2.7.2.zip && \
    unzip IGV_Linux_2.7.2 -d /install/bin/


# make a dummy batch script in order to load the hg19 genome into the container
# https://software.broadinstitute.org/software/igv/PortCommands
RUN printf 'new\ngenome hg19\nexit\n' > /genome.bat
RUN xvfb-run --auto-servernum --server-num=1 bin/IGV_Linux_2.7.2/igv.sh -b /genome.bat


