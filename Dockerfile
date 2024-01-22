FROM node:18 as builder

WORKDIR /app

RUN apt update && apt install git -y

RUN git clone https://github.com/OutmaneOukkoua/Online-Shop.git .

RUN npm run build

CMD [ "npm","start" ]

FROM nginx:1.21.0-alpine as production
ENV NODE_ENV production

COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx-debug", "-g", "daemon off;"]