# User Management System

## 🌟 O Projekcie | About

**PL**: System zarządzania użytkownikami zbudowany przy użyciu nowoczesnego stosu technologicznego. Projekt wykorzystuje architekturę monorepo z Turborepo, co pozwala na efektywne zarządzanie wieloma aplikacjami i współdzielonymi pakietami.

**EN**: A user management system built with a modern tech stack. The project uses a monorepo architecture with Turborepo, allowing for efficient management of multiple applications and shared packages.

## 🛠 Tech Stack

- **Frontend**: React + Vite + TailwindCSS
- **Backend**: NestJS + Prisma
- **Package Manager**: pnpm
- **Monorepo Tool**: Turborepo
- **Database**: PostgreSQL

## 📦 Project Structure

```
my-turborepo/
├── apps/
│   ├── api/         # NestJS backend application
│   └── web/         # React frontend application
└── packages/
    ├── eslint-config/    # Shared ESLint configurations
    ├── typescript-config/ # Shared TypeScript configurations
    └── ui/               # Shared UI components
```

## 🚀 Getting Started

1. **Prerequisites**
   - Node.js (v18 or higher)
   - pnpm
   - Docker (for database)

2. **Installation**

   ```bash
   # Install dependencies
   pnpm install

   # Start the database
   docker-compose up -d

   # Run database migrations
   cd apps/api && pnpm prisma migrate deploy

   # Start all applications
   pnpm dev
   ```

3. **Access the Applications**
   - Frontend: http://localhost:5173
   - Backend API: http://localhost:3000

## 🔑 Features

- 👥 User management interface
- 📊 User listing with detailed information
- 🎨 Modern and responsive UI
- 🔐 Role-based access control
- 📱 Mobile-friendly design

## 📝 License

MIT
