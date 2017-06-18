FROM node:alpine

# Install python 2
RUN apk --no-cache add --virtual native-deps \
  g++ gcc libgcc libstdc++ linux-headers make python && \
  npm install --quiet node-gyp -g

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN yarn install

# Remove dependencies
RUN apk del native-deps

# Bundle app source
COPY . /usr/src/app

EXPOSE 3005
CMD [ "npm", "start" ]