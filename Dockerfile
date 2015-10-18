FROM ubuntu:14.04 
MAINTAINER Robert van Rijn <rvanrijn79@gmail.com> (@rijnr)

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile


# Install software 
RUN apt-get install -y ruby-full git nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Install Bower & Grunt
RUN npm install -g bower && \
    npm install -g grunt-cli 

#Get Git rep
RUN git clone https://github.com/rvanrijn/scala-exercises.git
RUN cd /scala-exercises/
RUN chmod u+rwx /scala-exercises/gruntIt.sh

#RUN npm install -g npm
RUN cd scala-exercises/test && \
    bower install --allow-root
RUN cd scala-exercises/

#RUN locale-gen "en_US.UTF-8" && \
#    dpkg-reconfigure locales && \
#    gem install sass


RUN cd /scala-exercises/ && \
    npm install --save-dev grunt-wiredep && \
    bower install --allow-root jquery --save

RUN cd /scala-exercises/; npm install
#ENTRYPOINT ["grunt", "wiredep"]

#EXPOSE 22
#CMD ["/usr/sbin/sshd", "-D"]

EXPOSE 9000

# By default start the application
ENTRYPOINT ["/scala-exercises/gruntIt.sh"]
