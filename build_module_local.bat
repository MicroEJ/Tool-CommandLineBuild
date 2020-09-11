REM Copyright 2018-2020 MicroEJ Corp. All rights reserved.
REM Use of this source code is governed by a BSD-style license that can be found with this software.

@echo off
  
set PROJECT_DIRECTORY=%~f1
set BUILD_MODE=%~2

if "%3%" == "" (
  set PROPERTIES_FILE_OPTION=
) else (
  set PROPERTIES_FILE_OPTION=-propertyfile "%~f3"
)

if "%PROJECT_DIRECTORY%" == "" (
  echo Missing option PROJECT_DIRECTORY
  goto :usage
)

if "%MICROEJ_BUILD_JDK_HOME%" == "" (
  echo Unknown environment variable MICROEJ_BUILD_JDK_HOME
  goto :usage
)


if "%BUILD_MODE%" == "release" (
  set PUBLISH_LEVEL=release
  set FETCH_LEVEL=release
  set PERSONAL_BUILD=false
) else if "%BUILD_MODE%" == "fetchRelease" (
  set PUBLISH_LEVEL=snapshot
  set FETCH_LEVEL=release
  set PERSONAL_BUILD=false
) else if "%BUILD_MODE%" == "snapshot" (
  set PUBLISH_LEVEL=snapshot
  set FETCH_LEVEL=snapshot
  set PERSONAL_BUILD=false
) else if "%BUILD_MODE%" == "personal" (
  set PUBLISH_LEVEL=snapshot
  set FETCH_LEVEL=snapshot
  set PERSONAL_BUILD=true
) else if "%BUILD_MODE%" == "" (
  set PUBLISH_LEVEL=snapshot
  set FETCH_LEVEL=snapshot
  set PERSONAL_BUILD=true
) else (
  echo Wrong option value for BUILD_MODE
  goto :usage
)

SET BUILD_KIT_HOME=%cd%\buildKit
SET ANT_HOME=%BUILD_KIT_HOME%\ant
"%MICROEJ_BUILD_JDK_HOME%\bin\java.exe" -classpath "%ANT_HOME%\lib\ant-launcher.jar" org.apache.tools.ant.launch.Launcher -lib "%ANT_HOME%\lib" -lib "%BUILD_KIT_HOME%%LIB_PATH%" -buildfile "%cd%\easyant\build-module.ant" -Dartifacts.publish.level="%PUBLISH_LEVEL%" -Dartifacts.fetch.level="%FETCH_LEVEL%" -DpersonalBuild="%PERSONAL_BUILD%" -Duser.ivysettings.file="%cd%\ivy\ivysettings.xml" -Deasyant.module.dir="%PROJECT_DIRECTORY%" -Dmicroej.buildtypes.repository.dir="%BUILD_KIT_HOME%\microej-build-repository" %PROPERTIES_FILE_OPTION%

goto :theend

:usage
@echo Usage: %0 ^<PROJECT_DIRECTORY^> ^<BUILD_MODE^> [^<PROPERTIES_FILE^>]
@echo ^<PROJECT_DIRECTORY^>: The absolute path of the directory to be built.
@echo ^<BUILD_MODE^>: One of `release`, `fetchRelease`, `snapshot` or `personal`. Optional, defaults to `personal`.
@echo ^<PROPERTIES_FILE^>: An optional properties file with build specific module options (build type options are prefixed with `easyant.inject.`)
@echo The following variables must be set:  
@echo - MICROEJ_BUILD_JDK_HOME (%MICROEJ_BUILD_JDK_HOME%)

exit /B 1

:theend