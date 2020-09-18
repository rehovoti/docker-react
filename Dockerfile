FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# for AWS to know what port to use
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# automatically runs nginx