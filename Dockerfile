# Wybór obrazu bazowego
FROM ruby:3.4.1

# Ustawienie katalogu roboczego
WORKDIR /blog

# Zainstalowanie zależności systemowych
RUN apt-get update -qq && apt-get install -y \
    nodejs \
    npm \
    yarn \
    postgresql-client \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# Kopiowanie pliku Gemfile i Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instalacja zależności Ruby
RUN gem install bundler && bundle install

# Kopiowanie aplikacji do kontenera
COPY . .

# Otworzenie portu
EXPOSE 3000

# Uruchomienie serwera
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
