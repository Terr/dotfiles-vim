" Compile .COM file
CompilerSet makeprg=uasm-nocolor\ -nologo\ -bin\ -DBuildDOS=1\ $*\ -Fl\ -Fo\ %:r.com\ %

CompilerSet errorformat=%f\(%l\)\ :\ %m
CompilerSet errorformat+=%-G%.%#
