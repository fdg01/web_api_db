================================================================================
BASE TEMPLATE - WEB + API + DATABASE
================================================================================

Template base para aplicaciones full-stack con React, Express, PostgreSQL y Docker.

STACK TECNOLÓGICO
-----------------
Frontend:  React 18 + Vite + TailwindCSS + React Router
Backend:   Node.js + Express + Sequelize ORM
Database:  PostgreSQL 15
Deploy:    Docker + Docker Compose + Nginx

ESTRUCTURA DEL PROYECTO
-----------------------
base_template_web_api_db/
├── docker-compose.yml           → Orquestación de servicios
├── .env.example                 → Template de variables de entorno
├── .gitignore                   → Archivos a ignorar en git
├── README.txt                   → Este archivo
├── DATABASE_GUIDELINES.txt      → Guía de desarrollo DB
├── DOCKER_GUIDELINES.txt        → Guía de Docker
│
├── api/                         → Backend API
│   ├── package.json
│   ├── .sequelizerc
│   ├── DEVELOPMENT_GUIDELINES.txt
│   ├── docker/
│   │   ├── Dockerfile
│   │   └── entrypoint.sh
│   └── src/
│       ├── server.js
│       ├── config/
│       │   └── database.js
│       ├── models/
│       │   ├── index.js
│       │   └── User.js
│       ├── controllers/
│       │   └── authController.js
│       ├── middleware/
│       │   ├── auth.js
│       │   ├── errorHandler.js
│       │   └── validators.js
│       ├── routes/
│       │   └── auth.js
│       └── migrations/
│           └── 20240101000000-create-users.js
│
└── web/                         → Frontend Web
    ├── package.json
    ├── vite.config.js
    ├── tailwind.config.js
    ├── index.html
    ├── DEVELOPMENT_GUIDELINES.txt
    ├── docker/
    │   ├── Dockerfile
    │   ├── nginx.conf
    │   └── entrypoint.sh
    └── src/
        ├── main.jsx
        ├── App.jsx
        ├── index.css
        ├── api/
        │   └── axios.js
        ├── contexts/
        │   └── AuthContext.jsx
        ├── components/
        │   ├── ProtectedRoute.jsx
        │   └── common/
        │       ├── Button.jsx
        │       └── Input.jsx
        ├── pages/
        │   ├── Login.jsx
        │   └── Dashboard.jsx
        └── utils/
            └── cn.js

INICIO RÁPIDO
-------------

1. CONFIGURAR VARIABLES DE ENTORNO
   cp .env.example .env
   # Editar .env con valores reales

2. INICIAR SERVICIOS
   docker-compose up -d

3. VERIFICAR ESTADO
   docker-compose ps
   docker-compose logs -f

4. ACCEDER A LA APLICACIÓN
   Web:      http://localhost:8080
   API:      http://localhost:4000
   PgAdmin:  http://localhost:5050 (con --profile tools)

5. CREAR PRIMER USUARIO
   Usar endpoint POST /api/auth/register con:
   {
     "email": "admin@example.com",
     "password": "password123",
     "name": "Admin User"
   }

DESARROLLO LOCAL (SIN DOCKER)
------------------------------

1. INSTALAR DEPENDENCIAS
   cd api && npm install
   cd ../web && npm install

2. CONFIGURAR BASE DE DATOS
   Crear base de datos PostgreSQL local
   Configurar .env con credenciales

3. EJECUTAR MIGRACIONES
   cd api
   npm run migrate

4. INICIAR SERVICIOS
   # Terminal 1 - API
   cd api
   npm run dev

   # Terminal 2 - Web
   cd web
   npm run dev

5. ACCEDER
   Web: http://localhost:5173
   API: http://localhost:4000

COMANDOS ÚTILES
---------------

DOCKER COMPOSE:
  docker-compose up -d              → Iniciar servicios
  docker-compose down               → Detener servicios
  docker-compose logs -f [service]  → Ver logs
  docker-compose build              → Rebuild imágenes
  docker-compose ps                 → Ver estado
  docker-compose exec api sh        → Entrar a container

API:
  npm run dev                       → Desarrollo con nodemon
  npm start                         → Producción
  npm run migrate                   → Ejecutar migraciones
  npm run migrate:undo              → Revertir última migración
  npm run migrate:status            → Ver estado de migraciones

WEB:
  npm run dev                       → Desarrollo con Vite
  npm run build                     → Build de producción
  npm run preview                   → Preview del build

DATABASE:
  docker-compose exec postgres psql -U postgres -d app_db
  docker-compose exec postgres pg_dump -U postgres app_db > backup.sql

ENDPOINTS API
-------------

AUTH:
  POST   /api/auth/register    → Registrar usuario
  POST   /api/auth/login       → Iniciar sesión
  GET    /api/auth/me          → Obtener usuario actual (requiere auth)

HEALTH:
  GET    /health               → Health check

CARACTERÍSTICAS
---------------

✓ Autenticación JWT
✓ Validación de inputs
✓ Manejo de errores centralizado
✓ Rate limiting
✓ CORS configurado
✓ Security headers (Helmet)
✓ Password hashing (bcrypt)
✓ Protected routes
✓ Responsive design
✓ Docker multi-stage builds
✓ Health checks
✓ Database migrations
✓ Hot reload en desarrollo

SEGURIDAD
---------

✓ Passwords hasheados con bcrypt
✓ JWT para autenticación
✓ HTTP-only cookies
✓ CORS configurado
✓ Rate limiting en endpoints críticos
✓ Helmet para security headers
✓ Input validation y sanitization
✓ SQL injection prevention (Sequelize)
✓ XSS prevention (React)

PRÓXIMOS PASOS
--------------

1. Personalizar para tu proyecto
2. Agregar más modelos y relaciones
3. Implementar funcionalidades específicas
4. Configurar CI/CD
5. Configurar monitoreo
6. Implementar tests
7. Optimizar performance
8. Configurar backups automáticos

DOCUMENTACIÓN ADICIONAL
-----------------------

Ver archivos de guidelines para consideraciones detalladas:
- api/DEVELOPMENT_GUIDELINES.txt      → Desarrollo de API
- web/DEVELOPMENT_GUIDELINES.txt      → Desarrollo de Web
- DATABASE_GUIDELINES.txt             → Base de datos
- DOCKER_GUIDELINES.txt               → Docker y deployment

TROUBLESHOOTING
---------------

PROBLEMA: Containers no inician
SOLUCIÓN: docker-compose logs -f [service]

PROBLEMA: Error de conexión a DB
SOLUCIÓN: Verificar que postgres esté healthy
          docker-compose ps

PROBLEMA: Migraciones no se ejecutan
SOLUCIÓN: docker-compose exec api npm run migrate

PROBLEMA: Web no se conecta a API
SOLUCIÓN: Verificar CORS_ORIGIN en .env
          Verificar proxy en nginx.conf

PROBLEMA: Cambios no se reflejan
SOLUCIÓN: Rebuild imagen
          docker-compose up -d --build

LICENCIA
--------
MIT

SOPORTE
-------
Para preguntas o issues, consultar las guidelines o documentación de cada tecnología.
