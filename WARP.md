# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

**Laptop Shop** - A Spring Boot MVC e-commerce application for selling laptops with admin management capabilities.

- **Framework**: Spring Boot 3.2.2 with Spring MVC
- **View Engine**: JSP with JSTL
- **Database**: MySQL with Spring Data JPA/Hibernate
- **Security**: Spring Security with role-based access control
- **Session Management**: Spring Session JDBC
- **Architecture Pattern**: MVC with Service-Repository layers

## Common Development Commands

### Build & Run
```bash
# Clean and compile the project
mvn clean compile

# Run the application (development mode with Spring DevTools)
mvn spring-boot:run

# Build JAR file
mvn clean package

# Run tests
mvn test

# Run specific test class
mvn test -Dtest=ClassName

# Skip tests during build
mvn clean package -DskipTests
```

### Database Operations
```bash
# Start MySQL (if using Homebrew on macOS)
brew services start mysql

# Connect to MySQL database
mysql -u root -p
```

### Development Server
- **URL**: http://localhost:8080
- **Admin Panel**: http://localhost:8080/admin
- **Login**: http://localhost:8080/login

## Code Architecture

### Package Structure
```
src/main/java/vn/hoidanit/laptopshop/
├── config/           # Security, WebMvc configurations
├── controller/       # MVC Controllers
│   ├── admin/       # Admin panel controllers
│   └── client/      # Client-facing controllers
├── domain/          # JPA Entities
│   └── dto/         # Data Transfer Objects
├── repository/      # Spring Data JPA repositories
├── service/         # Business logic layer
├── validation/      # Custom validators
└── exception/       # Exception handlers
```

### Architectural Patterns

#### 1. Controller-Service-Repository Pattern
- **Controllers**: Handle HTTP requests, validate input, return views
- **Services**: Contain business logic, transaction management
- **Repositories**: Data access layer using Spring Data JPA

#### 2. Role-Based Security
- **ADMIN**: Full access to `/admin/**` endpoints
- **USER**: Access to client endpoints only
- Authentication handled by `CustomUserDetailsService`
- Success handler routes users based on roles (`CustomSuccessHandler`)

#### 3. Base Controller Pattern
- `BaseController` provides common functionality
- Automatically injects current authenticated user via `@ModelAttribute`
- Inherited by controllers needing user context

#### 4. JSP View Resolution
- Views located in `/WEB-INF/view/`
- Separated by `/admin/` and `/client/` directories
- Layout templates for consistent UI structure

### Key Domain Models

#### Core Entities
- **User**: Customer/admin accounts with role-based permissions
- **Product**: Laptop products with inventory management
- **Cart**: User shopping cart with items
- **Order**: Purchase orders with order details
- **Role**: User role management (ADMIN/USER)

#### Entity Relationships
- User → Role (Many-to-One)
- User → Cart (One-to-One)
- User → Orders (One-to-Many)
- Cart → CartItems (One-to-Many)
- Order → OrderDetails (One-to-Many)

### Configuration Highlights

#### Security Configuration (`SecurityConfig`)
- BCrypt password encoding with strength 12
- Session-based authentication with remember-me
- Role-based authorization with method-level security
- Custom success handler for role-based redirects

#### Database Configuration
- MySQL connection with connection pooling
- Hibernate DDL auto-update for development
- SQL logging enabled for debugging
- Spring Session JDBC for session persistence

#### File Upload Configuration
- Max file size: 50MB
- Max request size: 50MB
- Used for product image uploads

## Development Guidelines

### Adding New Features

#### 1. Controller Guidelines
- Extend `BaseController` for user context access
- Keep controllers lightweight - only handle HTTP concerns
- Use proper HTTP status codes and response types
- Validate input using Bean Validation annotations

#### 2. Service Layer
- All business logic must reside in services
- Handle transactions at service level
- Follow single responsibility principle
- Use dependency injection for repository access

#### 3. Database Changes
- Entity changes trigger Hibernate auto-update
- Follow JPA naming conventions
- Use validation annotations on entity fields
- Consider database performance for large datasets

#### 4. View Development
- JSP files in appropriate `/admin/` or `/client/` directories
- Use layout templates for consistency
- Include CSRF tokens in forms
- Follow responsive design patterns

### Testing Approach
- Unit tests for service layer business logic
- Integration tests for repository layer
- Controller tests with MockMvc
- Database tests use H2 in-memory database

### Important Cursor Rules Integration

The project follows strict architectural principles defined in `.cursor/rules/base.mdc`:

1. **Analyze First**: Always read relevant codebase files before implementing
2. **Keep Controllers Lightweight**: Business logic belongs in services only
3. **Follow SOLID Principles**: Maintain separation of concerns
4. **Provide Guidance**: Focus on step-by-step instructions rather than direct patches

When implementing new features, ensure compliance with the current Spring MVC + JSP + MySQL architecture.