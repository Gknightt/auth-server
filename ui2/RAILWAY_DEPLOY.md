# Frontend Deployment on Railway

This directory contains the frontend React application for the auth server.

## Deploy to Railway

### Option 1: Deploy as Separate Service (Recommended)

1. **Create a new Railway project** for the frontend
2. **Connect your GitHub repository** to Railway
3. **Set the root directory** to `ui2` in Railway's service settings
4. **Railway will automatically detect** the `Dockerfile` and `railway.json`
5. **Deploy** - Railway will build and deploy your frontend

### Option 2: Deploy from this Directory

If you want to deploy just the frontend:

1. **Clone/copy the `ui2` directory** to a separate repository
2. **Connect that repository** to Railway
3. **Deploy** normally

## Environment Variables

The frontend typically doesn't need many environment variables, but you may want to set:

- **API Backend URL**: If your frontend needs to know the backend URL, you can set it as a build-time environment variable
- **Runtime Configuration**: The app uses `public/papermerge-runtime-config.js` for runtime configuration

## Configuration

- **Runtime config**: Edit `public/papermerge-runtime-config.js` to configure login providers
- **Build settings**: The app builds using Vite and serves static files with `serve`
- **Port**: Railway automatically sets the `PORT` environment variable

## Build Process

1. `npm ci --omit=dev` - Install dependencies
2. `npm run build` - Build the React app with Vite
3. `serve -s dist -l $PORT` - Serve static files

## File Structure

- `Dockerfile` - Docker configuration for Railway
- `railway.json` - Railway-specific deployment configuration
- `.env.example` - Environment variables template
- `package.json` - Node.js dependencies and scripts

## Connecting to Backend

Make sure your frontend can communicate with your auth server backend. You may need to:

1. **Configure CORS** in your backend to allow requests from your frontend domain
2. **Update API URLs** in your frontend code to point to your Railway backend service
3. **Set up proper authentication** flow between frontend and backend
