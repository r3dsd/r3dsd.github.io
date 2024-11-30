FROM ruby:3.2

RUN apt update && apt install -y --no-install-recommends \
    build-essential \
    git \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

ENV TZ=Asia/Seoul

WORKDIR /usr/src/app

COPY Gemfile ./
RUN bundle install

COPY . .

CMD ["bundle", "exec", "jekyll", "serve", "--watch", "--host", "0.0.0.0"] 
