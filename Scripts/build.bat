@echo off

pushd %~dp0
lune %~dp0\build.lua %1
popd