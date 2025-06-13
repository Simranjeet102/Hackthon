using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var builder = WebApplication.CreateBuilder(args);

// ---- Intentional Security Risk ----
// Hard‑coded secret. REMOVE ME!
const string JwtSecret = "VerySecretKey123!"; 

builder.Services.AddControllers();

var app = builder.Build();

app.MapGet("/", () => new { status = "ok", secret = JwtSecret });

app.Run();
