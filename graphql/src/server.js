const express = require("express");
const { postgraphile } = require("postgraphile");

const app = express();

app.use(postgraphile(
    process.env.DATABASE_URL || "postgres://user:pass@host:5432/dbname",
    process.env.PUBLIC_SCHEMA || "public",
    {
        watchPg: true,
        graphiql: true,
        enhanceGraphiql: true,
        retryOnInitFail: true,
        pgDefaultRole: process.env.DEFAULT_ROLE || "forum_anon",
        jwtPgTypeIdentifier: "app_public.jwt_token"
    }
));

app.listen(process.env.PORT || 3000);

