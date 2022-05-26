# syntax=docker/dockerfile:1
FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /opt/classifyr
COPY Gemfile /opt/classifyr/Gemfile
COPY Gemfile.lock /opt/classifyr/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY scripts/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
