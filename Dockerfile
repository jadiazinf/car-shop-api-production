# Usa una imagen base de Ruby
FROM ruby:3.1.2

# Instala dependencias
# RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Configura el directorio de trabajo
WORKDIR /app

# Copia y instala las dependencias del proyecto
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs=4 --retry=3

# Copia el resto de la aplicación
COPY . .

# Expone el puerto en el que correrá el servidor
EXPOSE 3000

# Define la variable de entorno para producción
ENV RAILS_ENV=production

# Ejecuta las migraciones y precompila assets en Railway
CMD ["bash", "-c", "bundle exec rails db:create && bundle exec rails db:migrate && bundle exec rails assets:precompile && bundle exec rails s"]
