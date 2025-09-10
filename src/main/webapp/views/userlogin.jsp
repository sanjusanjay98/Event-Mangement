<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login - EventManager</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.12/sweetalert2.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --secondary-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --accent-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --purple-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --glass-bg: rgba(255, 255, 255, 0.15);
            --glass-border: rgba(255, 255, 255, 0.25);
            --input-bg: rgba(255, 255, 255, 0.1);
            --input-border: rgba(255, 255, 255, 0.3);
            --input-focus: rgba(67, 233, 123, 0.8);
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
            position: relative;
            overflow-x: hidden;
        }

        /* Animated background elements */
        .bg-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .floating-icon {
            position: absolute;
            color: rgba(255, 255, 255, 0.08);
            animation: floatIcon 8s ease-in-out infinite;
        }

        .floating-icon:nth-child(1) {
            top: 15%;
            left: 10%;
            font-size: 3rem;
            animation-delay: 0s;
        }

        .floating-icon:nth-child(2) {
            top: 25%;
            right: 15%;
            font-size: 2.5rem;
            animation-delay: 2s;
        }

        .floating-icon:nth-child(3) {
            bottom: 30%;
            left: 15%;
            font-size: 2rem;
            animation-delay: 4s;
        }

        .floating-icon:nth-child(4) {
            bottom: 20%;
            right: 20%;
            font-size: 3.5rem;
            animation-delay: 6s;
        }

        .floating-icon:nth-child(5) {
            top: 50%;
            left: 5%;
            font-size: 2.2rem;
            animation-delay: 8s;
        }

        @keyframes floatIcon {
            0%, 100% {
                transform: translateY(0px) rotate(0deg);
                opacity: 0.08;
            }
            50% {
                transform: translateY(-30px) rotate(180deg);
                opacity: 0.15;
            }
        }

        .login-container {
            width: 100%;
            max-width: 450px;
            padding: 20px;
            position: relative;
        }

        .login-card {
            background: var(--glass-bg);
            backdrop-filter: blur(30px);
            border: 2px solid var(--glass-border);
            border-radius: 28px;
            padding: 60px 45px;
            box-shadow: 
                0 30px 60px rgba(0, 0, 0, 0.2),
                0 0 0 1px rgba(255, 255, 255, 0.1) inset;
            position: relative;
            overflow: hidden;
            animation: slideInUp 0.8s cubic-bezier(0.4, 0, 0.2, 1);
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .login-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--secondary-gradient);
            border-radius: 28px 28px 0 0;
        }

        .brand {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
            z-index: 10;
        }

        .brand-icon {
            width: 90px;
            height: 90px;
            background: var(--secondary-gradient);
            border-radius: 28px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            font-size: 38px;
            color: white;
            box-shadow: 0 25px 50px rgba(67, 233, 123, 0.4);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
        }

        .brand-icon:hover {
            transform: scale(1.1) rotate(10deg);
            box-shadow: 0 30px 60px rgba(67, 233, 123, 0.5);
        }

        .brand h2 {
            color: white;
            font-weight: 700;
            font-size: 38px;
            margin-bottom: 12px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .brand p {
            color: rgba(255, 255, 255, 0.85);
            font-size: 17px;
            font-weight: 400;
        }

        /* Welcome message styling */
        .welcome-msg {
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 35px;
            text-align: center;
            backdrop-filter: blur(15px);
            position: relative;
        }

        .welcome-msg h4 {
            color: white;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 18px;
        }

        .welcome-msg p {
            color: rgba(255, 255, 255, 0.8);
            margin: 0;
            font-size: 14px;
        }

        /* Form Styling */
        .input-group {
            position: relative;
            margin-bottom: 28px;
        }

        .form-floating {
            position: relative;
            width: 100%;
        }

        .form-control {
            width: 100%;
            background: var(--input-bg);
            border: 2px solid var(--input-border);
            border-radius: 20px;
            color: white;
            font-size: 17px;
            padding: 24px 60px 24px 28px;
            height: 70px;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(10px);
            outline: none;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.18);
            border-color: var(--input-focus);
            box-shadow: 0 0 0 4px rgba(67, 233, 123, 0.15);
            color: white;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.65);
            opacity: 1;
        }

        .form-floating label {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            padding: 24px 60px 24px 28px;
            pointer-events: none;
            border: 2px solid transparent;
            transform-origin: 0 0;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            color: rgba(255, 255, 255, 0.8);
            font-weight: 500;
            font-size: 17px;
            display: flex;
            align-items: center;
            border-radius: 20px;
        }

        .form-floating .form-control:focus ~ label,
        .form-floating .form-control:not(:placeholder-shown) ~ label {
            opacity: 0.9;
            transform: scale(0.75) translateY(-35px) translateX(10px);
            color: rgba(255, 255, 255, 0.9);
            background: linear-gradient(to right, transparent, var(--glass-bg) 10%, var(--glass-bg) 90%, transparent);
            padding: 6px 14px;
            border-radius: 12px;
            backdrop-filter: blur(20px);
        }

        /* Input Icon */
        .input-icon {
            position: absolute;
            right: 24px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.6);
            font-size: 22px;
            z-index: 10;
            transition: all 0.3s ease;
            pointer-events: none;
        }

        .input-group:focus-within .input-icon {
            color: var(--input-focus);
            transform: translateY(-50%) scale(1.1);
        }

        /* Button Styling */
        .login-btn {
            width: 100%;
            background: var(--secondary-gradient);
            border: none;
            border-radius: 20px;
            padding: 22px;
            font-size: 19px;
            font-weight: 600;
            color: white;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            margin-bottom: 35px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(67, 233, 123, 0.4);
        }

        .login-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s ease;
        }

        .login-btn:hover {
            transform: translateY(-4px);
            box-shadow: 0 30px 50px rgba(67, 233, 123, 0.5);
        }

        .login-btn:hover::before {
            left: 100%;
        }

        .login-btn:active {
            transform: translateY(-2px);
        }

        /* Loading animation for submit button */
        .login-btn.loading {
            pointer-events: none;
            background: var(--glass-bg);
            color: transparent !important;
        }

        .login-btn.loading::after {
            content: '';
            position: absolute;
            width: 24px;
            height: 24px;
            margin: auto;
            border: 3px solid transparent;
            border-top-color: white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        @keyframes spin {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
        }

        .links-container {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            position: relative;
            z-index: 10;
        }

        .auth-link {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 16px 22px;
            border-radius: 18px;
            background: rgba(255, 255, 255, 0.1);
            font-size: 15px;
            flex: 1;
            text-align: center;
        }

        .auth-link:hover {
            color: white;
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .auth-link.admin-link:hover {
            background: var(--purple-gradient);
            border-color: rgba(118, 75, 162, 0.3);
        }
        
        @keyframes ripple {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }
        
        /* Responsive design */
        @media (max-width: 576px) {
            .login-card {
                padding: 45px 35px;
                margin: 20px;
                border-radius: 24px;
            }
            
            .brand h2 {
                font-size: 32px;
            }
            
            .brand-icon {
                width: 80px;
                height: 80px;
                font-size: 34px;
            }
            
            .links-container {
                flex-direction: column;
                gap: 12px;
            }

            .form-control {
                padding: 22px 55px 22px 24px;
                height: 65px;
                font-size: 16px;
            }

            .form-floating label {
                padding: 22px 55px 22px 24px;
                font-size: 16px;
            }

            .welcome-msg {
                padding: 20px;
            }
        }

        @media (max-width: 400px) {
            .login-container {
                padding: 15px;
            }
            
            .login-card {
                padding: 35px 25px;
            }
        }
    </style>
</head>
<body>
    <div class="bg-animation">
        <div class="floating-icon">
            <i class="fas fa-calendar-alt"></i>
        </div>
        <div class="floating-icon">
            <i class="fas fa-ticket-alt"></i>
        </div>
        <div class="floating-icon">
            <i class="fas fa-users"></i>
        </div>
        <div class="floating-icon">
            <i class="fas fa-star"></i>
        </div>
        <div class="floating-icon">
            <i class="fas fa-music"></i>
        </div>
    </div>

    <div class="login-container">
        <div class="login-card">
            <div class="brand">
                <div class="brand-icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <h2>Welcome Back</h2>
                <p>Sign in to discover amazing events</p>
            </div>

            <div class="welcome-msg">
                <h4>🎉 Ready for your next adventure?</h4>
                <p>Access thousands of events and book your tickets instantly</p>
            </div>

            <% String message = (String) request.getAttribute("message"); %>
            <% if (message != null) { %>
                <script>
                    document.addEventListener('DOMContentLoaded', function() {
                        Swal.fire({
                            icon: 'info',
                            title: 'Notification',
                            text: '<%= message %>',
                            background: 'rgba(255,255,255,0.98)',
                            color: '#333',
                            backdrop: 'rgba(0,0,0,0.8)',
                            confirmButtonColor: '#43e97b',
                            confirmButtonText: 'Got it!',
                            borderRadius: '16px',
                            showClass: {
                                popup: 'animate__animated animate__zoomIn'
                            },
                            hideClass: {
                                popup: 'animate__animated animate__zoomOut'
                            }
                        });
                    });
                </script>
            <% } %>

            <form action="userlogindata" method="post" id="loginForm">
                <div class="input-group">
                    <div class="form-floating">
                        <input type="text" class="form-control" id="username" name="uname" placeholder=" " required>
                        <label for="username">Username</label>
                    </div>
                    <i class="fas fa-user input-icon"></i>
                </div>

                <div class="input-group">
                    <div class="form-floating">
                        <input type="password" class="form-control" id="password" name="pword" placeholder=" " required>
                        <label for="password">Password</label>
                    </div>
                    <i class="fas fa-lock input-icon"></i>
                </div>

                <button type="submit" class="btn login-btn" id="loginBtn">
                    <i class="fas fa-sign-in-alt me-2"></i>
                    Sign In to Events
                </button>

                <div class="links-container">
                    <a href="/nuser" class="auth-link">
                        <i class="fas fa-user-plus me-2"></i>
                        Create Account
                    </a>
                    <a href="/alogin" class="auth-link admin-link">
                        <i class="fas fa-shield-alt me-2"></i>
                        Admin Portal
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.12/sweetalert2.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('loginForm');
            const loginBtn = document.getElementById('loginBtn');
            
            // Form submission with loading state
            form.addEventListener('submit', function(e) {
                // Prevent the default form submission to control the flow
                // e.preventDefault(); 
                
                loginBtn.classList.add('loading');
                loginBtn.innerHTML = 'Signing you in...';
            });

            // Add ripple effect to buttons
            document.querySelectorAll('.auth-link, .login-btn').forEach(button => {
                button.addEventListener('click', function(e) {
                    const ripple = document.createElement('span');
                    const rect = this.getBoundingClientRect();
                    const size = Math.max(rect.width, rect.height);
                    const x = e.clientX - rect.left - size / 2;
                    const y = e.clientY - rect.top - size / 2;
                    
                    ripple.style.width = ripple.style.height = size + 'px';
                    ripple.style.left = x + 'px';
                    ripple.style.top = y + 'px';
                    ripple.style.position = 'absolute';
                    ripple.style.borderRadius = '50%';
                    ripple.style.background = 'rgba(255,255,255,0.3)';
                    ripple.style.transform = 'scale(0)';
                    ripple.style.animation = 'ripple 0.6s linear';
                    ripple.style.pointerEvents = 'none';
                    
                    this.style.position = 'relative';
                    this.style.overflow = 'hidden';
                    this.appendChild(ripple);
                    
                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });
        });
    </script>
</body>
</html>