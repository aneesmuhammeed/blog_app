## Rotate Supabase keys (recommended immediately)

1. Open your Supabase project dashboard.
2. Go to Settings → API.
3. Under "Project API keys", rotate the anon/public key:
   - Click the rotate/regenerate button for the `anon` key.
   - Copy the new `anon` key.
4. Update your local `.env` file with the new `SUPABASE_ANON_KEY` value.
5. If you used the exposed key anywhere in third-party environments (CI/CD, hosted sites), update those secrets too.
6. (Optional) Revoke or remove any sessions or tokens if necessary.

Local setup:

- Copy `.env.example` to `.env` at the project root and fill in real values.
- Keep `.env` private (it's listed in `.gitignore`).
- Example `.env` contents:

```
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOi...replace-with-real-key
```

How the app loads secrets:

- The app uses `flutter_dotenv` to load `.env` at startup in `lib/main.dart`.
- `lib/core/secrets/supabase_secrets.dart` reads values via `dotenv.env[...]`.

If you need help rotating keys or updating deployments, tell me where your app is deployed (e.g., Vercel, Netlify, GitHub Actions) and I can provide exact steps.
