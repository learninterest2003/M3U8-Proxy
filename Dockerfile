FROM node:20-alpine AS build

WORKDIR /m3u8-proxy

COPY package.json ./
RUN npm install

COPY . .
RUN npm run build

FROM node:20-alpine AS runtime

WORKDIR /m3u8-proxy

COPY --from=build /m3u8-proxy/dist ./dist
COPY --from=build /m3u8-proxy/package.json ./package.json

RUN npm install --production

EXPOSE 3030

CMD ["node", "dist/index.js"]
