# Security Review Checklist

## Input Validation
- [ ] All user input validated against a schema before use
- [ ] Database queries use parameters, never string concatenation
- [ ] File upload types and sizes checked
- [ ] Path traversal prevented on any file operation

## Authentication
- [ ] Tokens expire
- [ ] Secrets read from the environment, never committed
- [ ] Passwords hashed with bcrypt or argon2
- [ ] Session invalidated on logout and on password change

## Authorization
- [ ] Every endpoint checks who is calling it
- [ ] Object level checks, not just route level
- [ ] Admin paths cannot be reached by changing an ID

## Output
- [ ] User content escaped before rendering
- [ ] Error responses do not leak stack traces or internal paths
- [ ] Logs do not contain credentials or tokens
