" Compile .EXE file
CompilerSet makeprg=uasm-nocolor\ -nologo\ -mz\ $*\ -Fl\ -Fo\ %:r.exe\ %

CompilerSet errorformat=%f\(%l\)\ :\ %m
CompilerSet errorformat+=%-G%.%#
