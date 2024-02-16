FROM ghcr.io/cirruslabs/flutter:3.10.5 as build

WORKDIR /usr/src/app

COPY . .

ENV URL_API=https://serap-estudante.sme.prefeitura.sp.gov.br/simulador/api/v1/
ENV CHAVE_API=B07E87044FE24077A69C3110CF032320


ARG ENVIRONMENT
ARG APP_VERSION
ARG BUILD_NUMBER
RUN flutter pub get
RUN flutter pub run build_runner build --delete-conflicting-outputs
RUN flutter build web --web-renderer html --build-name=$APP_VERSION --build-number=$BUILD_NUMBER --base-href '/simulador/' --profile -t lib/main_$ENVIRONMENT.dart

FROM nginx:1.20.1-alpine

#COPY configuracoes/default.conf /etc/nginx/conf.d/
#COPY --from=build /usr/src/app/config /usr/share/nginx/html/config
COPY --from=build /usr/src/app/build/web /usr/share/nginx/html/simulador

EXPOSE 80
