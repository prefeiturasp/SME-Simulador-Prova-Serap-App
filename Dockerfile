FROM ghcr.io/cirruslabs/flutter:3.10.5 as build

WORKDIR /usr/src/app

COPY . .

ARG ENVIRONMENT
RUN flutter pub get
RUN flutter pub run build_runner build --delete-conflicting-outputs
RUN flutter build web --web-renderer html --profile -t lib/main_$ENVIRONMENT.dart

FROM nginx:1.20.1-alpine

COPY configuracoes/default.conf /etc/nginx/conf.d/
#COPY --from=build /usr/src/app/config /usr/share/nginx/html/config
COPY --from=build /usr/src/app/build/web /usr/share/nginx/html

EXPOSE 80
