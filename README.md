# API Key Authentication & Management System

A backend service built using **Java**, **Spring Boot**, and **MySQL** that supports secure **API Key generation**, **authentication**, **expiration handling**, and **protected endpoints**.

---

## 🚀 Features

- User Registration & Login  
- Unique API Key Generation  
- API Key Expiration (24 hours by default)  
- Middleware Filter to Validate API Keys  
- Protected Endpoints accessible only with valid keys  
- Error Handling for Expired or Invalid Keys

---

## 🛠️ Tech Stack

- **Java 17**
- **Spring Boot**
- **Spring Data JPA**
- **MySQL**
- **Maven**

---

## 📁 Project Structure
src/
├── main/
│ ├── java/com/example/apikey/
│ │ ├── controller/
│ │ ├── entity/
│ │ ├── repository/
│ │ ├── service/
│ │ └── security/
│ └── resources/
│ └── application.properties


---

## ⚙️ Setup Instructions

### 1️⃣ Clone the repository
```bash
git clone https://github.com/your-username/api-key-auth-system.git
cd api-key-auth-system

2️⃣ Configure your database

Update application.properties:

spring.datasource.url=jdbc:mysql://localhost:3306/apikeydb
spring.datasource.username=root
spring.datasource.password=yourpassword
spring.jpa.hibernate.ddl-auto=update

3️⃣ Run the project
mvn spring-boot:run

🔑 API Endpoints
Register User
POST /api/auth/register
{
  "email": "test@gmail.com",
  "password": "12345"
}

Login & Generate API Key
POST /api/auth/login
{
  "email": "test@gmail.com",
  "password": "12345"
}

Protected Endpoint
GET /api/data/secure
Headers:
X-API-KEY: your_generated_api_key

🧪 API Key Filter (Core Logic)
@Component
public class ApiKeyFilter extends OncePerRequestFilter {

    @Autowired
    private ApiKeyRepository apiKeyRepository;

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {

        String apiKey = request.getHeader("X-API-KEY");

        if (apiKey != null) {
            ApiKey key = apiKeyRepository.findByKey(apiKey);

            if (key != null && key.getExpiry().isAfter(LocalDateTime.now())) {
                filterChain.doFilter(request, response);
                return;
            }
        }

        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.getWriter().write("Invalid or Expired API Key");
    }
}

🔐 Generate API Key Service
@Service
public class ApiKeyService {

    @Autowired
    private ApiKeyRepository repo;

    public ApiKey generate(User user) {
        ApiKey key = new ApiKey();
        key.setKey(UUID.randomUUID().toString());
        key.setUser(user);
        key.setExpiry(LocalDateTime.now().plusHours(24));
        return repo.save(key);
    }
}

🗄️ API Key Entity
@Entity
public class ApiKey {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String key;

    private LocalDateTime expiry;

    @ManyToOne
    private User user;
}

🔒 Protected Controller
@RestController
@RequestMapping("/api/data")
public class DataController {

    @GetMapping("/secure")
    public ResponseEntity<String> secure() {
        return ResponseEntity.ok("You accessed a protected API route!");
    }
}

🌍 Live Deployment

The project is deployed here:
👉 https://your-deployment-url.com

📌 Challenges Faced

Securing endpoints with custom filters

Handling API key expiration

Designing clean & scalable database schema

Testing auth flows via Postman

🧠 What I Learned

Spring Boot security fundamentals

API key authentication in real-world systems

Clean code & layered architecture

Database relationship mapping

⭐ How to Run Tests

Use Postman to test:

Register

Login → get API key

Access protected route

