<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - EventManager</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --dark-gradient: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: rgba(255, 255, 255, 0.2);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--primary-gradient);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow-x: hidden;
        }

        .login-container {
            position: relative;
            width: 100%;
            max-width: 450px;
            padding: 20px;
        }

        .login-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            padding: 60px 40px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
            position: relative;
            overflow: hidden;
        }

        .login-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: var(--secondary-gradient);
        }

        .brand {
            text-align: center;
            margin-bottom: 40px;
        }

        .brand-icon {
            width: 70px;
            height: 70px;
            background: var(--secondary-gradient);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 28px;
            color: white;
            box-shadow: 0 10px 30px rgba(245, 87, 108, 0.3);
        }

        .brand h2 {
            color: white;
            font-weight: 700;
            font-size: 32px;
            margin-bottom: 8px;
        }

        .brand p {
            color: rgba(255, 255, 255, 0.8);
            font-size: 16px;
            font-weight: 300;
        }

        .form-floating {
            margin-bottom: 25px;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 16px;
            color: white;
            font-size: 16px;
            padding: 20px 24px;
            height: auto;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(245, 87, 108, 0.6);
            box-shadow: 0 0 0 3px rgba(245, 87, 108, 0.1);
            color: white;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        .form-floating label {
            color: rgba(255, 255, 255, 0.8);
            font-weight: 500;
            padding: 20px 24px;
        }

        .login-btn {
            width: 100%;
            background: var(--secondary-gradient);
            border: none;
            border-radius: 16px;
            padding: 18px;
            font-size: 18px;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
            margin-bottom: 30px;
            position: relative;
            overflow: hidden;
        }

        .login-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .login-btn:hover::before {
            left: 100%;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 35px rgba(245, 87, 108, 0.4);
        }

        .links-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
        }

        .auth-link {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 8px 16px;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.1);
            font-size: 14px;
        }

        .auth-link:hover {
            color: white;
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-1px);
        }

        .input-icon {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.6);
            font-size: 20px;
            z-index: 10;
        }

        .input-group {
            position: relative;
        }

        /* Floating particles animation */
        .particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .particle {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .particle:nth-child(1) { width: 6px; height: 6px; top: 20%; left: 10%; animation-delay: 0s; }
        .particle:nth-child(2) { width: 8px; height: 8px; top: 60%; left: 85%; animation-delay: 2s; }
        .particle:nth-child(3) { width: 4px; height: 4px; top: 80%; left: 20%; animation-delay: 4s; }
        .particle:nth-child(4) { width: 10px; height: 10px; top: 30%; left: 70%; animation-delay: 1s; }
        .particle:nth-child(5) { width: 6px; height: 6px; top: 70%; left: 50%; animation-delay: 3s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        /* Responsive */
        @media (max-width: 576px) {
            .login-card {
                padding: 40px 30px;
                margin: 20px;
            }
            
            .brand h2 {
                font-size: 28px;
            }
            
            .links-container {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="particles">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>

    <div class="login-container">
        <div class="login-card">
            <div class="brand">
                <div class="brand-icon">
                    <i class="fas fa-user-shield"></i>
                </div>
                <h2>Admin Portal</h2>
                <p>Manage your events with ease</p>
            </div>

            <% 
                String message = (String) request.getAttribute("message");
                if (message == null) {
                    message = (String) session.getAttribute("message");
                    if (message != null) {
                        session.removeAttribute("message");
                    }
                }
            %>
            <% if (message != null) { %>
                <script>
                    document.addEventListener('DOMContentLoaded', function() {
                        Swal.fire({
                            icon: 'info',
                            title: 'Notification',
                            text: '<%= message %>',
                            background: 'rgba(255,255,255,0.95)',
                            backdrop: 'rgba(0,0,0,0.8)',
                            confirmButtonColor: '#f5576c'
                        });
                    });
                </script>
            <% } %>

            <form action="adminlogindata" method="post">
                <div class="input-group">
                    <div class="form-floating">
                        <input type="text" class="form-control" id="username" name="uname" placeholder="Username" required>
                        <label for="username">Username</label>
                    </div>
                    <i class="fas fa-user input-icon"></i>
                </div>

                <div class="input-group">
                    <div class="form-floating">
                        <input type="password" class="form-control" id="password" name="pword" placeholder="Password" required>
                        <label for="password">Password</label>
                    </div>
                    <i class="fas fa-lock input-icon"></i>
                </div>

                <button type="submit" class="btn login-btn">
                    <i class="fas fa-sign-in-alt me-2"></i>
                    Sign In
                </button>

                <div class="links-container">
                    <a href="/nadmin" class="auth-link">
                        <i class="fas fa-user-plus me-1"></i>
                        New Admin
                    </a>
                    <a href="/ulogin" class="auth-link">
                        <i class="fas fa-users me-1"></i>
                        User Login
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.12/sweetalert2.min.js"></script>
</body>
</html>