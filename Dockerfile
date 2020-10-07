FROM debian 

WORKDIR /app/

RUN apt update
RUN apt -y dist-upgrade
RUN apt -y install git
RUN git clone https://github.com/grinco/HarmonizeProject
RUN cd HarmonizeProject && chmod 755 setup.sh && ./setup.sh
RUN mv ./HarmonizeProject/harmonize.py /app 

ENV ARGS ''

CMD [ "sh", "-c", "python3 /app/harmonize.py $ARGS" ]
