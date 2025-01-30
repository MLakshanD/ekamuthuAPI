using Microsoft.AspNetCore.Identity.Data;
using Microsoft.AspNetCore.Mvc;

namespace EkamuthAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class HomeController : ControllerBase
    {
        // Handle POST request for login
        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest request)
        {
            // Validate the request
            if (request == null || string.IsNullOrEmpty(request.Username) || string.IsNullOrEmpty(request.Password))
            {
                return BadRequest("Username and password are required.");
            }

            // Simulate authentication logic
            bool isAuthenticated = AuthenticateUser(request.Username, request.Password);

            if (isAuthenticated)
            {
                return Ok(new
                {
                    Mode = request.Username.ToLower() == "admin" ? 1 :
                           request.Username.ToLower() == "treasurer" ? 2 : 
                    request.Username.ToLower() == "member" ? 3 : 4,
                    Message = "Login successful!"
                });
            }
            else
            {
                return Unauthorized(new { Message = "Invalid username or password." });
            }
        }

        // Simulated authentication method
        private bool AuthenticateUser(string username, string password)
        {
            // Replace this with actual authentication logic (e.g., database check)
            return (username == "admin" && password == "a") || (username == "treasurer" && password == "a") || (username == "member" && password == "a");
        }
    }

    // Model for the login request
    public class LoginRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }
}
