<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Registration - EventManager</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.12/sweetalert2.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            --accent-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --glass-bg: rgba(255, 255, 255, 0.15);
            --glass-border: rgba(255, 255, 255, 0.25);
            --input-bg: rgba(255, 255, 255, 0.1);
            --input-border: rgba(255, 255, 255, 0.3);
            --input-focus: rgba(56, 239, 125, 0.8);
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
            padding: 20px 0;
            position: relative;
            overflow-x: hidden;
        }

        /* Animated background shapes */
        .bg-shapes {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .shape {
            position: absolute;
            border-radius: 50%;
            opacity: 0.08;
            animation: adminFloat 15s ease-in-out infinite;
        }

        .shape:nth-child(1) {
            width: 250px;
            height: 250px;
            background: var(--secondary-gradient);
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .shape:nth-child(2) {
            width: 180px;
            height: 180px;
            background: var(--accent-gradient);
            top: 60%;
            right: 10%;
            animation-delay: 5s;
        }

        .shape:nth-child(3) {
            width: 120px;
            height: 120px;
            background: var(--secondary-gradient);
            bottom: 15%;
            left: 20%;
            animation-delay: 10s;
        }

        @keyframes adminFloat {
            0%, 100% { transform: translateY(0px) rotate(0deg) scale(1); }
            25% { transform: translateY(-30px) rotate(90deg) scale(1.05); }
            50% { transform: translateY(-60px) rotate(180deg) scale(0.95); }
            75% { transform: translateY(-30px) rotate(270deg) scale(1.05); }
        }

        .register-container {
            width: 100%;
            max-width: 500px;
            padding: 20px;
            position: relative;
        }

        .register-card {
            background: var(--glass-bg);
            backdrop-filter: blur(30px);
            border: 2px solid var(--glass-border);
            border-radius: 28px;
            padding: 50px 40px;
            box-shadow: 
                0 25px 50px rgba(0, 0, 0, 0.2),
                0 0 0 1px rgba(255, 255, 255, 0.1) inset;
            position: relative;
            overflow: hidden;
            animation: slideUpAdmin 0.8s cubic-bezier(0.4, 0, 0.2, 1);
        }

        @keyframes slideUpAdmin {
            from {
                opacity: 0;
                transform: translateY(40px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .register-card::before {
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
        }

        .brand-icon {
            width: 85px;
            height: 85px;
            background: var(--secondary-gradient);
            border-radius: 26px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            font-size: 36px;
            color: white;
            box-shadow: 0 20px 40px rgba(56, 239, 125, 0.4);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .brand-icon:hover {
            transform: scale(1.05) rotate(-5deg);
        }

        .brand h2 {
            color: white;
            font-weight: 700;
            font-size: 36px;
            margin-bottom: 10px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .brand p {
            color: rgba(255, 255, 255, 0.85);
            font-size: 16px;
            font-weight: 400;
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
            border-radius: 18px;
            color: white;
            font-size: 16px;
            padding: 22px 60px 22px 24px;
            height: 65px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(10px);
            outline: none;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.18);
            border-color: var(--input-focus);
            box-shadow: 0 0 0 3px rgba(56, 239, 125, 0.15);
            color: white;
        }
        
        .form-control.is-valid {
            border-color: var(--input-focus);
            background: rgba(56, 239, 125, 0.12);
        }

        .form-control.is-invalid {
            border-color: rgba(245, 87, 108, 0.8);
            background: rgba(245, 87, 108, 0.12);
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.6);
            opacity: 1;
        }

        .form-floating label {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            padding: 22px 60px 22px 24px;
            pointer-events: none;
            border: 2px solid transparent;
            transform-origin: 0 0;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            color: rgba(255, 255, 255, 0.7);
            font-weight: 500;
            font-size: 16px;
            display: flex;
            align-items: center;
            border-radius: 18px;
        }

        .form-floating .form-control:focus ~ label,
        .form-floating .form-control:not(:placeholder-shown) ~ label {
            opacity: 0.8;
            transform: scale(0.75) translateY(-32px) translateX(8px);
            color: rgba(255, 255, 255, 0.9);
            background: linear-gradient(to right, transparent, var(--glass-bg) 10%, var(--glass-bg) 90%, transparent);
            padding: 4px 12px;
            border-radius: 12px;
            backdrop-filter: blur(20px);
        }

        .input-icon {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.6);
            font-size: 20px;
            z-index: 10;
            transition: all 0.3s ease;
            pointer-events: none;
        }

        .input-group:focus-within .input-icon {
            color: var(--input-focus);
            transform: translateY(-50%) scale(1.1);
        }

        /* Password Strength Indicator */
        .password-strength {
            margin-top: 15px;
            margin-bottom: 5px;
        }

        .strength-bar {
            width: 100%;
            height: 6px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 3px;
            overflow: hidden;
            margin-bottom: 12px;
        }

        .strength-fill {
            height: 100%;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border-radius: 3px;
            background: linear-gradient(90deg, #f5576c 0%, #f093fb 100%);
        }

        .strength-text {
            color: rgba(255, 255, 255, 0.85);
            font-size: 13px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .match-indicator {
            font-size: 13px;
            margin-top: 12px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            min-height: 20px; /* Prevents layout shift */
        }

        .match-success { 
            color: #38ef7d; 
            animation: fadeInAdmin 0.3s ease;
        }
        
        .match-error { 
            color: #f5576c; 
            animation: fadeInAdmin 0.3s ease;
        }

        @keyframes fadeInAdmin {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Button Styling */
        .register-btn {
            width: 100%;
            background: var(--secondary-gradient);
            border: none;
            border-radius: 18px;
            padding: 20px;
            font-size: 18px;
            font-weight: 600;
            color: white;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            margin: 30px 0;
            position: relative;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(56, 239, 125, 0.3);
        }

        .register-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s ease;
        }

        .register-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 25px 45px rgba(56, 239, 125, 0.4);
        }

        .register-btn:hover::before {
            left: 100%;
        }

        .register-btn:active {
            transform: translateY(-1px);
        }

        .login-link {
            text-align: center;
        }

        .auth-link {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 15px 25px;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.1);
            display: inline-block;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .auth-link:hover {
            color: white;
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        /* Responsive design */
        @media (max-width: 576px) {
            .register-card {
                padding: 40px 30px;
                margin: 20px;
                border-radius: 24px;
            }
            
            .brand h2 {
                font-size: 30px;
            }
            
            .brand-icon {
                width: 75px;
                height: 75px;
                font-size: 32px;
            }

            .form-control {
                padding: 20px 55px 20px 20px;
                height: 60px;
            }

            .form-floating label {
                padding: 20px 55px 20px 20px;
            }
        }

        @media (max-width: 400px) {
            .register-container {
                padding: 10px;
            }
            
            .register-card {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="bg-shapes">
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
    </div>

    <div class="register-container">
        <div class="register-card">
            <div class="brand">
                <div class="brand-icon">
                    <i class="fas fa-user-shield"></i>
                </div>
                <h2>Join as Admin</h2>
                <p>Create your privileged account</p>
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
                            background: 'rgba(255,255,255,0.98)',
                            color: '#333',
                            backdrop: 'rgba(0,0,0,0.8)',
                            confirmButtonColor: '#38ef7d',
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

            <form action="newadmindata" method="post" id="registerForm">
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
                    <div class="password-strength">
                        <div class="strength-bar">
                            <div class="strength-fill" id="strengthFill"></div>
                        </div>
                        <div class="strength-text" id="strengthText">
                            <i class="fas fa-info-circle"></i>
                            Enter a strong password
                        </div>
                    </div>
                </div>

                <div class="input-group">
                    <div class="form-floating">
                        <input type="password" class="form-control" id="repeatPassword" name="rpword" placeholder=" " required>
                        <label for="repeatPassword">Repeat Password</label>
                    </div>
                    <i class="fas fa-lock input-icon"></i>
                    <div class="match-indicator" id="matchIndicator"></div>
                </div>

                <button type="submit" class="btn register-btn" id="submitBtn">
                    <i class="fas fa-user-plus me-2"></i>
                    Create Admin Account
                </button>

                <div class="login-link">
                    <a href="/alogin" class="auth-link">
                        <i class="fas fa-arrow-left me-2"></i>
                        Already have an account? Login
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert2/11.7.12/sweetalert2.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const passwordInput = document.getElementById('password');
            const repeatPasswordInput = document.getElementById('repeatPassword');
            const strengthFill = document.getElementById('strengthFill');
            const strengthText = document.getElementById('strengthText');
            const matchIndicator = document.getElementById('matchIndicator');
            const form = document.getElementById('registerForm');

            // Password strength checker
            passwordInput.addEventListener('input', function() {
                const password = this.value;
                const strength = getPasswordStrength(password);
                
                strengthFill.style.width = strength.percentage + '%';
                strengthFill.style.background = strength.gradient;
                strengthText.innerHTML = `<i class="${strength.icon}"></i> ${strength.text}`;
                strengthText.style.color = strength.color;
                
                checkPasswordMatch();
            });

            // Password match checker
            repeatPasswordInput.addEventListener('input', checkPasswordMatch);

            function getPasswordStrength(password) {
                let score = 0;

                if (password.length >= 8) score += 2;
                if (password.length >= 12) score += 1;
                if (/[a-z]/.test(password)) score += 1;
                if (/[A-Z]/.test(password)) score += 1;
                if (/[0-9]/.test(password)) score += 1;
                if (/[^A-Za-z0-9]/.test(password)) score += 1;

                const levels = [
                    { 
                        min: 0, max: 2, 
                        text: 'Very Weak - Add more characters', 
                        color: '#f5576c', 
                        gradient: 'linear-gradient(90deg, #f5576c 0%, #f093fb 100%)',
                        percentage: 20,
                        icon: 'fas fa-times-circle'
                    },
                    { 
                        min: 3, max: 4, 
                        text: 'Weak - Include numbers & symbols', 
                        color: '#ff9500', 
                        gradient: 'linear-gradient(90deg, #ff9500 0%, #ffcd00 100%)',
                        percentage: 40,
                        icon: 'fas fa-exclamation-circle'
                    },
                    { 
                        min: 5, max: 5, 
                        text: 'Fair - Almost there!', 
                        color: '#ffcd00', 
                        gradient: 'linear-gradient(90deg, #ffcd00 0%, #38ef7d 100%)',
                        percentage: 60,
                        icon: 'fas fa-info-circle'
                    },
                    { 
                        min: 6, max: 6, 
                        text: 'Good - Well done!', 
                        color: '#7ed321', 
                        gradient: 'linear-gradient(90deg, #7ed321 0%, #38ef7d 100%)',
                        percentage: 80,
                        icon: 'fas fa-check-circle'
                    },
                    { 
                        min: 7, max: 10, 
                        text: 'Strong - Excellent security!', 
                        color: '#38ef7d', 
                        gradient: 'linear-gradient(90deg, #11998e 0%, #38ef7d 100%)',
                        percentage: 100,
                        icon: 'fas fa-shield-alt'
                    }
                ];

                return levels.find(level => score >= level.min && score <= level.max) || levels[0];
            }

            function checkPasswordMatch() {
                const password = passwordInput.value;
                const repeatPassword = repeatPasswordInput.value;

                if (repeatPassword.length === 0) {
                    matchIndicator.innerHTML = '';
                    repeatPasswordInput.classList.remove('is-valid', 'is-invalid');
                    return;
                }

                if (password === repeatPassword && password.length > 0) {
                    matchIndicator.innerHTML = '<i class="fas fa-check-circle"></i> Passwords match perfectly!';
                    matchIndicator.className = 'match-indicator match-success';
                    repeatPasswordInput.classList.remove('is-invalid');
                    repeatPasswordInput.classList.add('is-valid');
                } else {
                    matchIndicator.innerHTML = '<i class="fas fa-times-circle"></i> Passwords don\'t match';
                    matchIndicator.className = 'match-indicator match-error';
                    repeatPasswordInput.classList.remove('is-valid');
                    repeatPasswordInput.classList.add('is-invalid');
                }
            }

            // Form validation
            form.addEventListener('submit', function(e) {
                const password = passwordInput.value;
                const repeatPassword = repeatPasswordInput.value;
                
                if (password !== repeatPassword) {
                    e.preventDefault();
                    Swal.fire({
                        icon: 'error',
                        title: 'Password Mismatch',
                        text: 'Please make sure both passwords match.',
                        confirmButtonColor: '#f5576c',
                        background: 'rgba(255,255,255,0.98)',
                        color: '#333'
                    });
                }
            });
        });
    </script>
</body>
</html>