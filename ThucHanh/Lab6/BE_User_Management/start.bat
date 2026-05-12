@echo off
REM Script khởi động SQL Server Docker + chạy ứng dụng .NET

echo ========================================
echo Khởi động SQL Server via Docker...
echo ========================================

docker-compose up -d

echo.
echo Chờ SQL Server khỏe...
timeout /t 5 /nobreak

docker-compose ps

echo.
echo ========================================
echo Áp dụng migrations...
echo ========================================

cd WebApplication1
dotnet ef database update

echo.
echo ========================================
echo Chạy ứng dụng .NET...
echo ========================================

dotnet run

pause
