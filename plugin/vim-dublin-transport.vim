" Determine if using Python3 or not
function! s:UsingPython3()
  if has( "python3" )
    return 1
  endif
  return 0
endfunction

" Determine correct Python command based off Python version
let s:using_python3 = s:UsingPython3()
let s:python_until_eof = s:using_python3 ? "python3 << EOF" : "python << EOF"
let s:python_command = s:using_python3 ? "python3" : "python"

" Setup Python
let s:plugin_root_dir = fnamemodify( resolve( expand( '<sfile>:p')), ':h' )
exec s:python_until_eof
import sys
from os.path import normpath, join
import vim
plugin_root_dir = vim.eval( 's:plugin_root_dir' )
python_root_dir = normpath( join(plugin_root_dir, '..', 'python' ) )
sys.path.insert( 0, python_root_dir )
import DublinBusInfo
EOF


" Next buses at stop -> both preset as favourites in vimrc E.g.
" let g:FavouriteBusStop = 46
" let g:FavouriteBusRoute = 4
function! NextFavouriteBuses()
    if !exists( "g:FavouriteBusStop" )
      echom "Please set g:FavouriteBusStop and g:FavouriteBusRoute in your .vimrc"
    endif
    if has( "python3" )
      python3 DublinBusInfo.listNextBuses( vim.eval( "g:FavouriteBusStop" ), vim.eval( "g:FavouriteBusRoute" ) )
    endif
    if has( "python" )
      python DublinBusInfo.listNextBuses( vim.eval( "g:FavouriteBusStop" ), vim.eval( "g:FavouriteBusRoute" ) )
    endif
endfunction	
command! -nargs=* Bus :call NextFavouriteBuses()

" All buses at a stop
function! NextBusesAtStop( stopNumber )
    if has( "python3" )
      python3 DublinBusInfo.listNextBuses( vim.eval( "a:stopNumber" ) )
    endif
    if has( "python" )
      python DublinBusInfo.listNextBuses( vim.eval(" a:stopNumber" ) )
    endif
endfunction
command! -nargs=1 Stop :call NextBusesAtStop(<f-args>)

" Command to see next buses of specific route
" E.g. all 31 buses at stop 583
function! NextBusOfRoute( stopNumber, busNumber )
    if has( "python3" )
      python3 DublinBusInfo.listNextBuses( vim.eval( "a:stopNumber" ), vim.eval( "a:busNumber" ) )
    endif
    if has( "python" )
      python DublinBusInfo.listNextBuses( vim.eval( "a:stopNumber" ), vim.eval( "a:busNumber" ) )
    endif
endfunction
command! -nargs=* NextBus :call NextBusOfRoute(<f-args>)



