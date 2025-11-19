version: '3.8'
services:
  activepieces:
    image: activepieces/activepieces:latest
    ports:
      - "8080:80"
    volumes:
      - activepieces_data:/root/.activepieces
    environment:
      - AP_DB_TYPE=POSTGRES
      - AP_POSTGRES_HOST=postgres
      - AP_POSTGRES_PORT=5432
      - AP_POSTGRES_USERNAME=activepieces
      - AP_POSTGRES_PASSWORD=your_secure_password
      - AP_POSTGRES_DATABASE=activepieces
      - AP_REDIS_TYPE=REDIS
      - AP_REDIS_HOST=redis
      - AP_FRONTEND_URL=http://localhost:8080 # Adjust if using a different URL
    depends_on:
      - postgres
      - redis

  postgres:
    image: postgres:13
    environment:
      - POSTGRES_USER=activepieces
      - POSTGRES_PASSWORD=your_secure_password
      - POSTGRES_DB=activepieces
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:6-alpine
    volumes:
      - redis_data:/data

volumes:
  activepieces_data:
  postgres_data:
  redis_data:
