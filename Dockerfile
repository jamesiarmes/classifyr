# syntax=docker/dockerfile:1
FROM ruby:3.1.2

RUN apt-get update -q && \
    apt-get upgrade -q -y && \
    apt-get install -q -y nodejs postgresql-client && \
#    apt-get install -q -y libcurl4-openssl-dev libgcrypt11-dev libgnutls-dev libidn11-dev libldap2-dev librtmp-dev libtasn1-3-dev m4 && \
    apt-get install -q -y libcurl4-openssl-dev libgcrypt20-dev libgnutls28-dev libidn11-dev libldap2-dev librtmp-dev libtasn1-6-dev m4 && \
    apt-get clean

WORKDIR /opt/classifyr
COPY . /opt/classifyr
RUN gem update && gem cleanup
RUN bundle install
RUN rails assets:precompile

# Remove lock file from installed dependencies. Bundler doesn't use them but they
# can be flagged by scanning services such as AWS Inspector.
RUN find /usr/local/bundle -name Gemfile.lock -delete

# Add a script to be executed every time the container starts.
COPY scripts/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
