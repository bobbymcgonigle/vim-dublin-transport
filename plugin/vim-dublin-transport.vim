
" Determine if using Python3 or not
function! s:UsingPython3()
  if has('python3')
    return 1
  endif
  return 0
endfunction

" Determine correct Python command based off Python version
let s:using_python3 = s:UsingPython3()
let s:python_until_eof = s:using_python3 ? "python3 << EOF" : "python << EOF"
let s:python_command = s:using_python3 ? "python3 DublinBusInfo.main() " : "python DublinBusInfo.main()"

" Setup Python
let s:plugin_root_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
exec s:python_until_eof
import sys
from os.path import normpath, join
import vim
plugin_root_dir = vim.eval('s:plugin_root_dir')
python_root_dir = normpath(join(plugin_root_dir, '..', 'python'))
sys.path.insert(0, python_root_dir)
import DublinBusInfo
EOF

" Testing functions [TO BE REMOVED]
function! Test()
    exec s:python_command
endfunction

command! -nargs=0 Test call Test()
