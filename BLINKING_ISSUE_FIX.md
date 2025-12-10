# Blinking Issue Fix - view_doctor.jsp

## Problem Identified
The `view_doctor.jsp` page was continuously blinking/reloading due to an **infinite redirect loop**.

### Root Cause
The session check was located in `admin/navbar.jsp`, which was included in every admin page. When the session expired or `adminObj` was null:
1. The page would try to load
2. The navbar include would execute the session check
3. It would redirect to `admin_login.jsp`
4. The redirect would happen DURING the page rendering
5. This created a continuous loop of redirects, causing the blinking effect

## Solution Applied
Moved the session authentication check from `navbar.jsp` to individual admin pages **BEFORE** any HTML output or includes.

### Changes Made:

#### 1. **admin/navbar.jsp**
- ✅ Removed the session check and redirect logic completely
- The navbar is now a pure presentation component without authentication logic

#### 2. **admin/view_doctor.jsp**
- ✅ Added session check at the very beginning (after imports, before DOCTYPE)
- The check happens ONCE when the page is accessed, not during includes

#### 3. **admin/index.jsp**
- ✅ Added the same session check

#### 4. **admin/doctor.jsp**
- ✅ Added the same session check

#### 5. **admin/patient.jsp**
- ✅ Added the same session check

#### 6. **admin/edit_doctor.jsp**
- ✅ Added the same session check

### Code Pattern Used
```jsp
<%-- Check if admin is logged in BEFORE any HTML output --%>
<%
    if (session.getAttribute("adminObj") == null) {
        response.sendRedirect("../admin_login.jsp");
        return;
    }
%>
```

## Why This Fixes the Issue
- **Single Execution**: The session check now executes only ONCE at the page level, not repeatedly through includes
- **Early Return**: The `return;` statement ensures no further processing happens after redirect
- **No Loop**: Since navbar.jsp no longer has authentication logic, there's no cyclic redirect
- **Proper Flow**: Invalid sessions redirect cleanly to login page without continuous reload

## Testing
To verify the fix:
1. Access any admin page without logging in → Should redirect to login page ONCE
2. Login with valid credentials (admin@gmail.com / admin)
3. Access `view_doctor.jsp` → Should load normally without blinking
4. Session expiration should redirect cleanly to login page

## Date Fixed
December 9, 2025
