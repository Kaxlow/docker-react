#build phase
FROM node:16-alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
#straight copy for Production, live change not needed
COPY . .
RUN npm run build

#run phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
#nginx container's default command is to start nginx