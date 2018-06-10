compiler rustc

set makeprg=cd\ %:h\ &&\ cargo\ build
let b:start='-wait=always -dir=%:h cargo run'
