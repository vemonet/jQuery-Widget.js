## ‘builder’ stage
FROM node:12 as builder

WORKDIR /webapp

ADD . .

# Storing node modules on a separate layer will prevent unnecessary npm installs at each build
# COPY package.json package.json

# Install the node module
RUN npm install --unsafe-perm

# Now copy the rest of the application
# ADD . .

RUN npm run production


## deploy stage
FROM nginx:1.14.1-alpine

# Copy our default nginx config
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy build folder from 'builder' to default nginx public folder
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /webapp/build/ /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]


# FROM node:8.10.0

# # Install location
# ENV dir /var/www/online-client

# # Copy the client files
# ADD . ${dir}

# # Install the node module
# RUN cd ${dir} && npm install --unsafe-perm
# RUN cd ${dir} && cp settings.json /tmp && cp -r queries /tmp/queries/

# # Expose the default port
# EXPOSE 8080

# # Run base binary

# CMD cp /tmp/settings.json settings.json && rm -rf queries && cp -r /tmp/queries queries/ && npm start
