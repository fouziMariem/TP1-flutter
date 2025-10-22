# 1️⃣ Use official Flutter image
FROM ghcr.io/cirruslabs/flutter:latest

# 2️⃣ Disable analytics
ENV FLUTTER_SUPPRESS_ANALYTICS=true
ENV CI=true

# 3️⃣ Set working directory
WORKDIR /app

# 4️⃣ Copy project files
COPY . .

# 5️⃣ Get dependencies and pre-cache web build
RUN flutter pub get && flutter precache --web

# 6️⃣ Expose Flutter Web port
EXPOSE 8080

# 7️⃣ Run Flutter Web server
CMD ["flutter", "run", "-d", "web-server", "--web-port=8080", "--web-hostname=0.0.0.0"]
