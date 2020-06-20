# Stage 1
# Create image based on the official Node 8 image from dockerhub

FROM node:10 as build-stage

# Create a directory where our app will be placed
RUN mkdir -p /usr/src/app

# Change directory so that our commands run inside this new directory

WORKDIR /usr/src/app

# Copy dependency definitions

COPY package*.json ./

# Install dependecies

RUN npm install

# Get all the code needed to run the app

COPY . .

# Run the angular in product
RUN npm run build
COPY . .
# Stage 2, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:1.15

#copy dist content to html nginx folder, config nginx to point in index.html
COPY --from=build-stage /usr/src/app/build /usr/share/nginx/html

COPY /nginx.conf /etc/nginx/conf.d/default.conf
