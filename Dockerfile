# Usar la imagen base de Node.js LTS Alpine
FROM node:lts-alpine

# Instalar http-server globalmente
RUN npm install -g http-server

# Crear un directorio para la aplicación
RUN mkdir /app

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar los archivos package.json y package-lock.json (si existen) al directorio de trabajo del contenedor
COPY package*.json ./

# Instalar las dependencias de npm
RUN npm install

# Copiar toda la aplicación al directorio de trabajo del contenedor
COPY . .

# Construir la aplicación (si es necesario)
RUN npm run build

# Exponer el puerto en el que se ejecutará la aplicación
EXPOSE 8080

# Especificar el comando para iniciar la aplicación usando http-server
CMD ["http-server", "dist"]
