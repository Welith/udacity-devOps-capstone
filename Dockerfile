# Use a simple nginx image
FROM nginx:alpine
# Copy the src html to the nginx app
COPY /src/. /usr/share/nginx/html