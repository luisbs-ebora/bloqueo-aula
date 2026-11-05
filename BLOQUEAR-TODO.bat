@echo off
rem FIRMA: BLOQUEO-AULA
rem Aplica TODOS los bloqueos (IA, Google sin IA, juegos, descarga de otros navegadores) en Edge, Chrome, Brave y Firefox,
rem y escribe en el archivo hosts las mismas webs (sin rutas), que afecta a cualquier navegador.
rem Este archivo es la lista maestra: los equipos con la tarea BloqueoAula lo descargan de GitHub cada 30 minutos.
rem Para bloquear o desbloquear una web, cambia aqui la lista y sube el archivo al repo bloqueo-aula.
rem Tambien funciona suelto: doble clic y pide permisos de administrador solo.
fltmc >nul 2>&1
if errorlevel 1 (
  powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
  exit /b
)
set ERR=0

rem Vacia las listas antes de aplicarlas: asi, lo que quites de este archivo tambien se desbloquea en los equipos.
reg delete "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /f >nul 2>&1

echo Aplicando bloquear-ia ...
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "1" /t REG_SZ /d "chatgpt.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "1" /t REG_SZ /d "chatgpt.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "2" /t REG_SZ /d "chat.openai.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "2" /t REG_SZ /d "chat.openai.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "3" /t REG_SZ /d "openai.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "3" /t REG_SZ /d "openai.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "4" /t REG_SZ /d "gemini.google.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "4" /t REG_SZ /d "gemini.google.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "5" /t REG_SZ /d "aistudio.google.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "5" /t REG_SZ /d "aistudio.google.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "6" /t REG_SZ /d "notebooklm.google.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "6" /t REG_SZ /d "notebooklm.google.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "7" /t REG_SZ /d "bard.google.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "7" /t REG_SZ /d "bard.google.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "8" /t REG_SZ /d "claude.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "8" /t REG_SZ /d "claude.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "9" /t REG_SZ /d "copilot.microsoft.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "9" /t REG_SZ /d "copilot.microsoft.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "10" /t REG_SZ /d "copilot.cloud.microsoft" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "10" /t REG_SZ /d "copilot.cloud.microsoft" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "11" /t REG_SZ /d "perplexity.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "11" /t REG_SZ /d "perplexity.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "12" /t REG_SZ /d "deepseek.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "12" /t REG_SZ /d "deepseek.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "13" /t REG_SZ /d "chat.mistral.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "13" /t REG_SZ /d "chat.mistral.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "14" /t REG_SZ /d "grok.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "14" /t REG_SZ /d "grok.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "15" /t REG_SZ /d "meta.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "15" /t REG_SZ /d "meta.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "16" /t REG_SZ /d "poe.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "16" /t REG_SZ /d "poe.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "17" /t REG_SZ /d "character.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "17" /t REG_SZ /d "character.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "18" /t REG_SZ /d "you.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "18" /t REG_SZ /d "you.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "19" /t REG_SZ /d "pi.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "19" /t REG_SZ /d "pi.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "20" /t REG_SZ /d "phind.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "20" /t REG_SZ /d "phind.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "21" /t REG_SZ /d "blackbox.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "21" /t REG_SZ /d "blackbox.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "22" /t REG_SZ /d "huggingface.co/chat" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "22" /t REG_SZ /d "huggingface.co/chat" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "23" /t REG_SZ /d "chat.qwen.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "23" /t REG_SZ /d "chat.qwen.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "24" /t REG_SZ /d "kimi.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "24" /t REG_SZ /d "kimi.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "25" /t REG_SZ /d "duck.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "25" /t REG_SZ /d "duck.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "1" /t REG_SZ /d "chatgpt.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "2" /t REG_SZ /d "chat.openai.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "3" /t REG_SZ /d "openai.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "4" /t REG_SZ /d "gemini.google.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "5" /t REG_SZ /d "aistudio.google.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "6" /t REG_SZ /d "notebooklm.google.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "7" /t REG_SZ /d "bard.google.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "8" /t REG_SZ /d "claude.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "9" /t REG_SZ /d "copilot.microsoft.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "10" /t REG_SZ /d "copilot.cloud.microsoft" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "11" /t REG_SZ /d "perplexity.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "12" /t REG_SZ /d "deepseek.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "13" /t REG_SZ /d "chat.mistral.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "14" /t REG_SZ /d "grok.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "15" /t REG_SZ /d "meta.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "16" /t REG_SZ /d "poe.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "17" /t REG_SZ /d "character.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "18" /t REG_SZ /d "you.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "19" /t REG_SZ /d "pi.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "20" /t REG_SZ /d "phind.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "21" /t REG_SZ /d "blackbox.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "22" /t REG_SZ /d "huggingface.co/chat" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "23" /t REG_SZ /d "chat.qwen.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "24" /t REG_SZ /d "kimi.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "25" /t REG_SZ /d "duck.ai" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /t REG_DWORD /d 0 /f >nul || set ERR=1
echo Aplicando bloquear-ia-google ...
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultSearchProviderEnabled" /t REG_DWORD /d 1 /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave" /v "DefaultSearchProviderEnabled" /t REG_DWORD /d 1 /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultSearchProviderName" /t REG_SZ /d "Google (sin IA)" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave" /v "DefaultSearchProviderName" /t REG_SZ /d "Google (sin IA)" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultSearchProviderSearchURL" /t REG_SZ /d "https://www.google.com/search?udm=14&q={searchTerms}" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave" /v "DefaultSearchProviderSearchURL" /t REG_SZ /d "https://www.google.com/search?udm=14&q={searchTerms}" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "DefaultSearchProviderSuggestURL" /t REG_SZ /d "https://www.google.com/complete/search?client=chrome&q={searchTerms}" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave" /v "DefaultSearchProviderSuggestURL" /t REG_SZ /d "https://www.google.com/complete/search?client=chrome&q={searchTerms}" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "301" /t REG_SZ /d "google.com/search?udm=50" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "301" /t REG_SZ /d "google.com/search?udm=50" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "302" /t REG_SZ /d "google.es/search?udm=50" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "302" /t REG_SZ /d "google.es/search?udm=50" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DefaultSearchProviderEnabled" /t REG_DWORD /d 1 /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DefaultSearchProviderName" /t REG_SZ /d "Google (sin IA)" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DefaultSearchProviderSearchURL" /t REG_SZ /d "https://www.google.com/search?udm=14&q={searchTerms}" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DefaultSearchProviderSuggestURL" /t REG_SZ /d "https://www.google.com/complete/search?client=chrome&q={searchTerms}" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "301" /t REG_SZ /d "google.com/search?udm=50" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "302" /t REG_SZ /d "google.es/search?udm=50" /f >nul || set ERR=1
echo Aplicando bloquear-juegos ...
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "101" /t REG_SZ /d "poki.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "101" /t REG_SZ /d "poki.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "102" /t REG_SZ /d "crazygames.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "102" /t REG_SZ /d "crazygames.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "103" /t REG_SZ /d "miniclip.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "103" /t REG_SZ /d "miniclip.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "104" /t REG_SZ /d "friv.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "104" /t REG_SZ /d "friv.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "105" /t REG_SZ /d "y8.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "105" /t REG_SZ /d "y8.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "106" /t REG_SZ /d "coolmathgames.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "106" /t REG_SZ /d "coolmathgames.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "107" /t REG_SZ /d "kongregate.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "107" /t REG_SZ /d "kongregate.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "108" /t REG_SZ /d "armorgames.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "108" /t REG_SZ /d "armorgames.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "109" /t REG_SZ /d "1001juegos.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "109" /t REG_SZ /d "1001juegos.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "110" /t REG_SZ /d "minijuegos.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "110" /t REG_SZ /d "minijuegos.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "111" /t REG_SZ /d "juegos.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "111" /t REG_SZ /d "juegos.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "112" /t REG_SZ /d "itch.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "112" /t REG_SZ /d "itch.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "113" /t REG_SZ /d "krunker.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "113" /t REG_SZ /d "krunker.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "114" /t REG_SZ /d "slither.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "114" /t REG_SZ /d "slither.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "115" /t REG_SZ /d "agar.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "115" /t REG_SZ /d "agar.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "116" /t REG_SZ /d "roblox.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "116" /t REG_SZ /d "roblox.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "117" /t REG_SZ /d "now.gg" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "117" /t REG_SZ /d "now.gg" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "118" /t REG_SZ /d "play.geforcenow.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "118" /t REG_SZ /d "play.geforcenow.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "119" /t REG_SZ /d "xbox.com/play" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "119" /t REG_SZ /d "xbox.com/play" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "120" /t REG_SZ /d "playhop.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "120" /t REG_SZ /d "playhop.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "121" /t REG_SZ /d "tsnowrider.github.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "122" /t REG_SZ /d "snowrider.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "123" /t REG_SZ /d "snowrider3d.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "124" /t REG_SZ /d "snowriders.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "125" /t REG_SZ /d "snowrider.org" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "126" /t REG_SZ /d "snowrider3d.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "127" /t REG_SZ /d "snowrider.game" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "128" /t REG_SZ /d "snowrider3dgame.org" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "129" /t REG_SZ /d "snowrider3d.school" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "130" /t REG_SZ /d "classroom-6x.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "131" /t REG_SZ /d "gamesroid.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "132" /t REG_SZ /d "snake.es" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "133" /t REG_SZ /d "snow-rider-3d-unblocked.github.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "134" /t REG_SZ /d "snowriderx.github.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "135" /t REG_SZ /d "snow-rider3d.github.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "136" /t REG_SZ /d "snow-rider.gitlab.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "137" /t REG_SZ /d "snow-rider-3d.gitlab.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "138" /t REG_SZ /d "hoodamath.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "139" /t REG_SZ /d "thesantatracker.com/reindeer-barn-snow-rider" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "140" /t REG_SZ /d "snowclassroom.github.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "121" /t REG_SZ /d "tsnowrider.github.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "122" /t REG_SZ /d "snowrider.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "123" /t REG_SZ /d "snowrider3d.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "124" /t REG_SZ /d "snowriders.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "125" /t REG_SZ /d "snowrider.org" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "126" /t REG_SZ /d "snowrider3d.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "127" /t REG_SZ /d "snowrider.game" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "128" /t REG_SZ /d "snowrider3dgame.org" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "129" /t REG_SZ /d "snowrider3d.school" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "130" /t REG_SZ /d "classroom-6x.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "131" /t REG_SZ /d "gamesroid.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "132" /t REG_SZ /d "snake.es" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "133" /t REG_SZ /d "snow-rider-3d-unblocked.github.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "134" /t REG_SZ /d "snowriderx.github.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "135" /t REG_SZ /d "snow-rider3d.github.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "136" /t REG_SZ /d "snow-rider.gitlab.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "137" /t REG_SZ /d "snow-rider-3d.gitlab.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "138" /t REG_SZ /d "hoodamath.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "139" /t REG_SZ /d "thesantatracker.com/reindeer-barn-snow-rider" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "140" /t REG_SZ /d "snowclassroom.github.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "101" /t REG_SZ /d "poki.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "102" /t REG_SZ /d "crazygames.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "103" /t REG_SZ /d "miniclip.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "104" /t REG_SZ /d "friv.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "105" /t REG_SZ /d "y8.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "106" /t REG_SZ /d "coolmathgames.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "107" /t REG_SZ /d "kongregate.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "108" /t REG_SZ /d "armorgames.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "109" /t REG_SZ /d "1001juegos.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "110" /t REG_SZ /d "minijuegos.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "111" /t REG_SZ /d "juegos.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "112" /t REG_SZ /d "itch.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "113" /t REG_SZ /d "krunker.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "114" /t REG_SZ /d "slither.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "115" /t REG_SZ /d "agar.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "116" /t REG_SZ /d "roblox.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "117" /t REG_SZ /d "now.gg" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "118" /t REG_SZ /d "play.geforcenow.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "119" /t REG_SZ /d "xbox.com/play" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "120" /t REG_SZ /d "playhop.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "121" /t REG_SZ /d "tsnowrider.github.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "122" /t REG_SZ /d "snowrider.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "123" /t REG_SZ /d "snowrider3d.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "124" /t REG_SZ /d "snowriders.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "125" /t REG_SZ /d "snowrider.org" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "126" /t REG_SZ /d "snowrider3d.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "127" /t REG_SZ /d "snowrider.game" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "128" /t REG_SZ /d "snowrider3dgame.org" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "129" /t REG_SZ /d "snowrider3d.school" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "130" /t REG_SZ /d "classroom-6x.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "131" /t REG_SZ /d "gamesroid.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "132" /t REG_SZ /d "snake.es" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "133" /t REG_SZ /d "snow-rider-3d-unblocked.github.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "134" /t REG_SZ /d "snowriderx.github.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "135" /t REG_SZ /d "snow-rider3d.github.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "136" /t REG_SZ /d "snow-rider.gitlab.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "137" /t REG_SZ /d "snow-rider-3d.gitlab.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "138" /t REG_SZ /d "hoodamath.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "139" /t REG_SZ /d "thesantatracker.com/reindeer-barn-snow-rider" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "140" /t REG_SZ /d "snowclassroom.github.io" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "AllowDinosaurEasterEgg" /t REG_DWORD /d 0 /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave" /v "AllowDinosaurEasterEgg" /t REG_DWORD /d 0 /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave" /v "BraveAIChatEnabled" /t REG_DWORD /d 0 /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave" /v "TorDisabled" /t REG_DWORD /d 1 /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "AllowSurfGame" /t REG_DWORD /d 0 /f >nul || set ERR=1
echo Aplicando bloquear-ia-firefox ...
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "1" /t REG_SZ /d "*://chatgpt.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "2" /t REG_SZ /d "*://*.chatgpt.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "3" /t REG_SZ /d "*://chat.openai.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "4" /t REG_SZ /d "*://*.chat.openai.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "5" /t REG_SZ /d "*://openai.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "6" /t REG_SZ /d "*://*.openai.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "7" /t REG_SZ /d "*://gemini.google.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "8" /t REG_SZ /d "*://*.gemini.google.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "9" /t REG_SZ /d "*://aistudio.google.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "10" /t REG_SZ /d "*://*.aistudio.google.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "11" /t REG_SZ /d "*://notebooklm.google.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "12" /t REG_SZ /d "*://*.notebooklm.google.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "13" /t REG_SZ /d "*://bard.google.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "14" /t REG_SZ /d "*://*.bard.google.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "15" /t REG_SZ /d "*://claude.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "16" /t REG_SZ /d "*://*.claude.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "17" /t REG_SZ /d "*://copilot.microsoft.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "18" /t REG_SZ /d "*://*.copilot.microsoft.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "19" /t REG_SZ /d "*://copilot.cloud.microsoft/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "20" /t REG_SZ /d "*://*.copilot.cloud.microsoft/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "21" /t REG_SZ /d "*://perplexity.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "22" /t REG_SZ /d "*://*.perplexity.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "23" /t REG_SZ /d "*://deepseek.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "24" /t REG_SZ /d "*://*.deepseek.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "25" /t REG_SZ /d "*://chat.mistral.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "26" /t REG_SZ /d "*://*.chat.mistral.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "27" /t REG_SZ /d "*://grok.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "28" /t REG_SZ /d "*://*.grok.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "29" /t REG_SZ /d "*://meta.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "30" /t REG_SZ /d "*://*.meta.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "31" /t REG_SZ /d "*://poe.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "32" /t REG_SZ /d "*://*.poe.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "33" /t REG_SZ /d "*://character.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "34" /t REG_SZ /d "*://*.character.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "35" /t REG_SZ /d "*://you.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "36" /t REG_SZ /d "*://*.you.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "37" /t REG_SZ /d "*://pi.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "38" /t REG_SZ /d "*://*.pi.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "39" /t REG_SZ /d "*://phind.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "40" /t REG_SZ /d "*://*.phind.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "41" /t REG_SZ /d "*://blackbox.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "42" /t REG_SZ /d "*://*.blackbox.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "43" /t REG_SZ /d "*://huggingface.co/chat*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "44" /t REG_SZ /d "*://www.huggingface.co/chat*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "45" /t REG_SZ /d "*://chat.qwen.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "46" /t REG_SZ /d "*://*.chat.qwen.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "47" /t REG_SZ /d "*://kimi.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "48" /t REG_SZ /d "*://*.kimi.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "49" /t REG_SZ /d "*://duck.ai/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "50" /t REG_SZ /d "*://*.duck.ai/*" /f >nul || set ERR=1
echo Aplicando bloquear-juegos-firefox ...
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "201" /t REG_SZ /d "*://poki.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "202" /t REG_SZ /d "*://*.poki.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "203" /t REG_SZ /d "*://crazygames.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "204" /t REG_SZ /d "*://*.crazygames.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "205" /t REG_SZ /d "*://miniclip.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "206" /t REG_SZ /d "*://*.miniclip.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "207" /t REG_SZ /d "*://friv.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "208" /t REG_SZ /d "*://*.friv.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "209" /t REG_SZ /d "*://y8.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "210" /t REG_SZ /d "*://*.y8.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "211" /t REG_SZ /d "*://coolmathgames.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "212" /t REG_SZ /d "*://*.coolmathgames.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "213" /t REG_SZ /d "*://kongregate.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "214" /t REG_SZ /d "*://*.kongregate.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "215" /t REG_SZ /d "*://armorgames.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "216" /t REG_SZ /d "*://*.armorgames.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "217" /t REG_SZ /d "*://1001juegos.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "218" /t REG_SZ /d "*://*.1001juegos.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "219" /t REG_SZ /d "*://minijuegos.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "220" /t REG_SZ /d "*://*.minijuegos.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "221" /t REG_SZ /d "*://juegos.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "222" /t REG_SZ /d "*://*.juegos.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "223" /t REG_SZ /d "*://itch.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "224" /t REG_SZ /d "*://*.itch.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "225" /t REG_SZ /d "*://krunker.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "226" /t REG_SZ /d "*://*.krunker.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "227" /t REG_SZ /d "*://slither.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "228" /t REG_SZ /d "*://*.slither.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "229" /t REG_SZ /d "*://agar.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "230" /t REG_SZ /d "*://*.agar.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "231" /t REG_SZ /d "*://roblox.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "232" /t REG_SZ /d "*://*.roblox.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "233" /t REG_SZ /d "*://now.gg/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "234" /t REG_SZ /d "*://*.now.gg/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "235" /t REG_SZ /d "*://play.geforcenow.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "236" /t REG_SZ /d "*://*.play.geforcenow.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "237" /t REG_SZ /d "*://xbox.com/play*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "238" /t REG_SZ /d "*://www.xbox.com/play*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "239" /t REG_SZ /d "*://playhop.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "240" /t REG_SZ /d "*://*.playhop.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "241" /t REG_SZ /d "*://tsnowrider.github.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "242" /t REG_SZ /d "*://snowrider.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "243" /t REG_SZ /d "*://*.snowrider.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "244" /t REG_SZ /d "*://snowrider3d.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "245" /t REG_SZ /d "*://*.snowrider3d.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "246" /t REG_SZ /d "*://snowriders.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "247" /t REG_SZ /d "*://*.snowriders.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "248" /t REG_SZ /d "*://snowrider.org/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "249" /t REG_SZ /d "*://*.snowrider.org/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "250" /t REG_SZ /d "*://snowrider3d.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "251" /t REG_SZ /d "*://*.snowrider3d.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "252" /t REG_SZ /d "*://snowrider.game/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "253" /t REG_SZ /d "*://*.snowrider.game/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "254" /t REG_SZ /d "*://snowrider3dgame.org/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "255" /t REG_SZ /d "*://*.snowrider3dgame.org/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "256" /t REG_SZ /d "*://snowrider3d.school/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "257" /t REG_SZ /d "*://*.snowrider3d.school/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "258" /t REG_SZ /d "*://classroom-6x.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "259" /t REG_SZ /d "*://*.classroom-6x.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "260" /t REG_SZ /d "*://gamesroid.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "261" /t REG_SZ /d "*://*.gamesroid.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "262" /t REG_SZ /d "*://snake.es/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "263" /t REG_SZ /d "*://*.snake.es/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "264" /t REG_SZ /d "*://snow-rider-3d-unblocked.github.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "265" /t REG_SZ /d "*://snowriderx.github.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "266" /t REG_SZ /d "*://snow-rider3d.github.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "267" /t REG_SZ /d "*://snow-rider.gitlab.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "268" /t REG_SZ /d "*://snow-rider-3d.gitlab.io/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "269" /t REG_SZ /d "*://hoodamath.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "270" /t REG_SZ /d "*://*.hoodamath.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "271" /t REG_SZ /d "*://thesantatracker.com/reindeer-barn-snow-rider*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "272" /t REG_SZ /d "*://www.thesantatracker.com/reindeer-barn-snow-rider*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "273" /t REG_SZ /d "*://snowclassroom.github.io/*" /f >nul || set ERR=1
echo Aplicando bloquear-descarga-navegadores ...
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "401" /t REG_SZ /d "opera.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "401" /t REG_SZ /d "opera.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "402" /t REG_SZ /d "operacdn.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "402" /t REG_SZ /d "operacdn.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "403" /t REG_SZ /d "opera.software" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "403" /t REG_SZ /d "opera.software" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "404" /t REG_SZ /d "brave.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "404" /t REG_SZ /d "brave.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "405" /t REG_SZ /d "vivaldi.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "405" /t REG_SZ /d "vivaldi.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\URLBlocklist" /v "406" /t REG_SZ /d "torproject.org" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v "406" /t REG_SZ /d "torproject.org" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "401" /t REG_SZ /d "opera.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "402" /t REG_SZ /d "operacdn.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "403" /t REG_SZ /d "opera.software" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "404" /t REG_SZ /d "brave.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "405" /t REG_SZ /d "vivaldi.com" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v "406" /t REG_SZ /d "torproject.org" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "401" /t REG_SZ /d "*://opera.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "402" /t REG_SZ /d "*://*.opera.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "403" /t REG_SZ /d "*://operacdn.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "404" /t REG_SZ /d "*://*.operacdn.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "405" /t REG_SZ /d "*://opera.software/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "406" /t REG_SZ /d "*://*.opera.software/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "407" /t REG_SZ /d "*://brave.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "408" /t REG_SZ /d "*://*.brave.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "409" /t REG_SZ /d "*://vivaldi.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "410" /t REG_SZ /d "*://*.vivaldi.com/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "411" /t REG_SZ /d "*://torproject.org/*" /f >nul || set ERR=1
reg add "HKLM\SOFTWARE\Policies\Mozilla\Firefox\WebsiteFilter\Block" /v "412" /t REG_SZ /d "*://*.torproject.org/*" /f >nul || set ERR=1

echo Aplicando archivo hosts (afecta a todos los navegadores) ...
set "BAT=%~f0"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$t=[IO.File]::ReadAllText($env:BAT); iex ($t.Substring($t.LastIndexOf('#PS-INICIO')))"
if errorlevel 1 set ERR=1

echo.
if %ERR%==0 (echo TODO OK en %COMPUTERNAME%.) else (echo HA FALLADO ALGUNA LINEA.)
echo.
echo Comprobacion (debe salir opera.com):
reg query "HKLM\SOFTWARE\Policies\Microsoft\Edge\URLBlocklist" /v 401
echo Comprobacion Brave (debe salir playhop.com):
reg query "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\URLBlocklist" /v 120
echo.
echo Cierra Edge, Chrome, Brave y Firefox del todo y vuelve a abrirlos (o en edge://policy pulsa Volver a cargar directivas).
if /i not "%~1"=="/s" pause
exit /b %ERR%
rem ===== A partir de aqui no es cmd: es el codigo PowerShell del archivo hosts. cmd nunca llega (exit /b de arriba). =====
#PS-INICIO
$ErrorActionPreference = 'Stop'
try {
  # Las webs salen de la lista de Chrome de este mismo archivo: solo dominios, sin rutas (hosts no entiende rutas).
  $bat = [IO.File]::ReadAllText($env:BAT)
  $doms = [regex]::Matches($bat, 'Google\\Chrome\\URLBlocklist" /v "\d+" /t REG_SZ /d "([^"/?]+)"') | ForEach-Object { $_.Groups[1].Value.ToLower() }
  # Los dominios de Microsoft no van al hosts: Windows Defender lo marca como amenaza. Ya estan bloqueados en los navegadores.
  $doms = $doms | Where-Object { -not ($_.EndsWith('microsoft.com') -or $_.EndsWith('.microsoft')) }
  # Extras solo para hosts (subdominios que hosts no cubre por si solo)
  $doms = @($doms) + @('auth.openai.com') | Sort-Object -Unique
  $lineas = foreach ($d in $doms) { '0.0.0.0 ' + $d; if ($d.Split('.').Count -eq 2) { '0.0.0.0 www.' + $d } }

  $h = Join-Path $env:SystemRoot 'System32\drivers\etc\hosts'
  if (-not (Test-Path ($h + '.copia-aula'))) { Copy-Item $h ($h + '.copia-aula') }
  $f = Get-Item $h -Force
  if ($f.IsReadOnly) { $f.IsReadOnly = $false }
  $antes = [IO.File]::ReadAllText($h)
  $limpio = [regex]::Replace($antes, '(?s)\r?\n?# INICIO BLOQUEO AULA.*?# FIN BLOQUEO AULA\r?\n?', '')
  $bloque = "# INICIO BLOQUEO AULA (lo escribe BLOQUEAR-TODO.bat, no tocar a mano)`r`n" + ($lineas -join "`r`n") + "`r`n# FIN BLOQUEO AULA`r`n"
  $nuevo = $limpio.TrimEnd() + "`r`n`r`n" + $bloque
  if ($nuevo -ne $antes) {
    [IO.File]::WriteAllText($h, $nuevo, [Text.Encoding]::ASCII)
    ipconfig /flushdns | Out-Null
    Write-Host ('hosts actualizado: ' + $lineas.Count + ' lineas')
  } else {
    Write-Host 'hosts sin cambios'
  }
} catch {
  Write-Host ('ERROR en hosts: ' + $_.Exception.Message)
  exit 1
}
