FROM klakegg/hugo:0.78.2-alpine AS build
RUN apk add -U git
COPY . /src
RUN mkdir -p /opt/IBM/HTTPServer
RUN mkdir /work 
RUN touch /work/ihsstart.sh
RUN chmod -R g=u /opt/IBM/HTTPServer /work/ihsstart.sh
RUN make init
RUN make build

FROM nginx:1.19.4-alpine
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/old-index.html
COPY --from=build /src/public /usr/share/nginx/html
EXPOSE 80
