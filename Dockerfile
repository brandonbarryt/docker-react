FROM node:alpine as builder 

WORKDIR '/app'

COPY package.json ./

RUN sudo npm install
#volumes not needed because we are creating a production build
COPY . .
#this will be created within the working directory of the container
RUN npm run build

#first build terminates automatically
FROM nginx 
#we only care about the build directory whichis copied over to nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html