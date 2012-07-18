echo off
set MSBUILD="C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"
set MSTEST="C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\MSTest.exe"

rem ************** Rebuild ************** 
set /P REBUILD=Do you want to rebuild now [y/n]? 
if "%REBUILD%"=="y" goto:REBUILD
goto:ENDBUILD
:REBUILD

echo 1. Build
%MSBUILD% /t:Rebuild /p:Configuration=Release "..\Memento.sln"

echo 2. Run tests
%MSTEST% /testcontainer:..\Memento.Test\bin\Release\Memento.Test.dll /test:Memento.Test.Features
:ENDBUILD

rem ************** NuGet ************** 
set /P NUGET=Do you want to publish to NuGet now [y/n]? 
if /i "%NUGET%"=="y" goto:NUGET
goto:EOF

:NUGET
NOTEPAD Memento.nuspec
echo 3. Create NuGet package
xcopy Memento.nuspec ..\Memento\bin\Release\
mkdir ..\Memento\bin\Release\lib\net40\ 
move /Y ..\Memento\bin\Release\Memento.dll ..\Memento\bin\Release\lib\net40\
move /Y ..\Memento\bin\Release\Memento.xml ..\Memento\bin\Release\lib\net40\
nuget pack ..\Memento\bin\Release\Memento.nuspec

:VERSION
set /P VERSION=Enter version: 
if /i "%VERSION%"=="" goto:VERSION
set PACKAGE=Memento.%VERSION%.nupkg
echo 4. Publish NuGet package
nuget push %PACKAGE%