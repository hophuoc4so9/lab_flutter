# PowerShell script khởi động SQL Server Docker + chạy ứng dụng .NET

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Khởi động SQL Server via Docker..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

docker-compose up -d

Write-Host ""
Write-Host "Chờ SQL Server khỏe..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

docker-compose ps

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Áp dụng migrations..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Set-Location WebApplication1
dotnet ef database update

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Chạy ứng dụng .NET..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

dotnet run
