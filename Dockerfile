## Build the website
FROM node:12 as builder

WORKDIR /webapp

ADD . .

# Should only reinstall npms if package.json or yarn.lock change
# Not working here, might need extra files
# COPY package.json package.json

# Install the node module
RUN npm install --unsafe-perm

# Now copy the rest of the application
# ADD . .

RUN npm run production


## Deploy the website using nginx
FROM nginx:1.14.1-alpine

# Copy our default nginx config
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy build folder from 'builder' to the default nginx public folder
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /webapp/build/ /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]