<h1>auth_web_app</h1>

<p>A Flutter Responsive Web project with registration, login, and home pages using SQLite database on the web.</p>

<h2>About Project</h2>
<p>
This project is a simple web authentication system built using Flutter Web. It contains three pages:
</p>
<ul>
<li>Registration Page</li>
<li>Login Page</li>
<li>Home Page</li>
</ul>
<p>
The project uses <strong>sqflite_common_ffi_web</strong> for database management on web browsers (Chrome, Edge, etc.) because the default sqflite does not work on web.
</p>

<h2>Architecture (MVVM)</h2>
<p>Project structure:</p>
<pre>
lib/
├─ core/               # App constants, utilities
├─ data/
│  ├─ model/           # User model
│  └─ repository/      # Database repository (register/login)
├─ presentation/
│  ├─ UI/
│  │  └─ widgets/      # Reusable widgets
│  └─ viewmodel/       # MVVM viewmodels for UI logic
└─ main.dart            # App entry point
</pre>
