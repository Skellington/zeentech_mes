@echo off
chcp 65001 >nul
color 1F
cls

echo ========================================================
echo      ATUALIZADOR SEGURO - ZEENTECH MES
echo ========================================================
echo.
echo 1. Fechando o sistema...
echo 2. Protegendo o Banco de Dados atual...
echo 3. Atualizando o sistema mantendo os dados...
echo.

:: --- CONFIGURACOES ---
set "ORIGEM=%~dp0"
:: Remove a barra invertida final da origem se houver
if "%ORIGEM:~-1%"=="\" set "ORIGEM=%ORIGEM:~0,-1%"

set "DESTINO=%USERPROFILE%\Desktop\Zeentech_MES"
set "EXE_NAME=zeentech_mes.exe"
set "DB_NAME=zeentech.db"

:: --- 1. FECHAR APLICACAO ---
echo [1/4] Parando processos antigos...
taskkill /F /IM "%EXE_NAME%" >nul 2>&1

:: --- 2. BACKUP DE SEGURANÇA ---
echo [2/4] Criando backup de seguranca dos dados...
if not exist "%DESTINO%" mkdir "%DESTINO%"

if exist "%DESTINO%\%DB_NAME%" (
    copy /Y "%DESTINO%\%DB_NAME%" "%DESTINO%\%DB_NAME%.backup_%date:/=-%_%time::=-%" >nul
    echo     Backup salvo com sucesso na pasta do sistema.
) else (
    echo     Nenhum banco de dados encontrado para backup (Instalacao Limpa?).
)

:: --- 3. ATUALIZAR ARQUIVOS (PRESERVANDO O DB) ---
echo [3/4] Copiando nova versao...

:: ROBOCOPY: Copia tudo (/E), Sobrescreve antigos (/IS),
:: MAS EXCLUI (/XF) o banco de dados e o proprio script da copia.
:: Isso garante que o zeentech.db da pasta de destino NUNCA seja tocado.

robocopy "%ORIGEM%" "%DESTINO%" /E /IS /IT /NP /NJH /NJS /XF "%DB_NAME%" "ATUALIZAR_SISTEMA.bat"

:: Robocopy retorna códigos de sucesso diferentes de 0.
:: Qualquer coisa abaixo de 8 é sucesso.
if %ERRORLEVEL% GEQ 8 (
    echo.
    echo [ERRO] Houve um problema na copia dos arquivos.
    echo Verifique se o antivirus nao esta bloqueando.
    pause
    exit /b
)

:: --- 4. INICIAR ---
echo.
echo [4/4] Atualizacao concluida com sucesso!
echo Dados preservados. Iniciando o sistema...
echo.

start "" "%DESTINO%\%EXE_NAME%"

timeout /t 3 >nul
exit
