# Use the official Nginx image as base
FROM nginx:alpine

# Copy the index.html file from the host machine to the container
COPY . /usr/share/nginx/html/

# Expose port 80 to the outside world
EXPOSE 80

# Set the default command to start Nginx and serve the index.html file
CMD ["nginx", "-g", "daemon off;"]