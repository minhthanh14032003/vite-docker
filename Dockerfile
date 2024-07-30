FROM node:20-alpine

WORKDIR /home/vite-docker

COPY package*.json .

RUN yarn install 

COPY . .


# EXPOSE 3000

CMD ["yarn", "dev"]
