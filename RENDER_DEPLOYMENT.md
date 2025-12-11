# Deploying Hospital Management System to Render

## Files Created for Docker Deployment

1. **Dockerfile** - Multi-stage build for creating the application container
2. **.dockerignore** - Excludes unnecessary files from Docker build
3. **docker-compose.yml** - For local development with MySQL
4. **render.yaml** - Render deployment configuration
5. **db.properties** - Database configuration file

---

## Local Testing with Docker

### Prerequisites
- Docker Desktop installed on your machine

### Steps to run locally:

```bash
# Build and run with docker-compose
docker-compose up --build

# Access the application at:
# http://localhost:8080
```

---

## Deploying to Render with TiDB Cloud

### Step 1: Set Up TiDB Cloud Database

1. Go to [TiDB Cloud](https://tidbcloud.com/) and create a free account
2. Create a new **Serverless Tier** cluster
3. Note down the connection details:
   - Host (e.g., `gateway01.ap-southeast-1.prod.aws.tidbcloud.com`)
   - Port (usually `4000`)
   - Username
   - Password
4. Create your database and import schema

### Step 2: Push Code to GitHub

```bash
git init
git add .
git commit -m "Initial commit with Docker support"
git remote add origin <your-github-repo-url>
git push -u origin main
```

### Step 3: Deploy on Render

1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click **"New +"** → **"Web Service"**
3. Connect your GitHub repository
4. Configure the service:
   - **Name:** hospital-management-system
   - **Environment:** Docker
   - **Plan:** Free (or your preferred plan)

5. Add Environment Variables for TiDB Cloud:
   | Key | Value |
   |-----|-------|
   | DB_HOST | Your TiDB host (e.g., gateway01.ap-southeast-1.prod.aws.tidbcloud.com) |
   | DB_PORT | 4000 |
   | DB_NAME | Your database name |
   | DB_USER | Your TiDB username |
   | DB_PASSWORD | Your TiDB password |
   | DB_SSL | true |
   | DB_SSL_MODE | VERIFY_IDENTITY |

6. Click **"Create Web Service"**

---

## Configuration Priority

The application reads configuration in this order:
1. **Environment Variables** (highest priority - for production)
2. **db.properties file** (for local development)
3. **Default values** (fallback)

This means:
- **Locally:** Uses `db.properties` settings (localhost, root, root)
- **On Render:** Uses environment variables (TiDB Cloud settings)

---

## Important Notes

1. **Free Tier Limitations**: Render's free tier spins down after 15 minutes of inactivity. The first request after inactivity will be slow.

2. **TiDB Cloud Free Tier**: Provides 5GB storage and is MySQL-compatible.

3. **SSL Required**: TiDB Cloud requires SSL connections. The `DB_SSL=true` environment variable enables this automatically.

4. **SSL**: Render provides free SSL certificates automatically.

5. **Logs**: View logs in Render dashboard for debugging.

---

## Troubleshooting

- **Build fails**: Check Maven dependencies in pom.xml
- **Database connection error**: Verify environment variables are set correctly
- **SSL connection error**: Make sure `DB_SSL=true` is set on Render
- **Application not loading**: Check Render logs for errors
- **TiDB connection timeout**: Check if your IP is whitelisted in TiDB Cloud
