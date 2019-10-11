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
import IrishRailInfo
EOF


"-------------------------------------------------------------------------------
" Command: :Train
" :TODO rephrase this
" Shows the next Trains going to a particular destination at the favourite station
" 
" Uses:
" let g:FavouriteDirection = 'Northbound'
" let g:FavouriteTrainStation = 'Connolly'
"-------------------------------------------------------------------------------

function! NextFavouriteTrains()
    if !exists( "g:FavouriteTrainStation" )
      echom "Please set g:FavouriteBusStop and g:FavouriteBusRoute in your .vimrc"
    endif
    if has( "python3" )
      python3 IrishRailInfo.getStation( vim.eval( "g:FavouriteTrainStation" ), vim.eval( "g:FavouriteTrainDirection" ) )
    endif
    if has( "python" )
      python IrishRailInfo.getStation( vim.eval( "g:FavouriteTrainStation" ), vim.eval( "g:FavouriteTrainDirection" ) )
    endif
endfunction
command! -nargs=* Train :call NextFavouriteTrains()

"-------------------------------------------------------------------------------
" Command: :Station <stationCode>
" 
" Shows all the trains at a particular station
"-------------------------------------------------------------------------------

function! AllTrainsAtStation( stationCode, direction )
    if has( "python3" )
      python3 IrishRailInfo.getStation( vim.eval( "a:stationCode" ), vim.eval( "a:direction" ) )
    endif
    if has( "python" )
      python IrishRailInfo.getStation( vim.eval( "a:stationCode" ), vim.eval( "a:direction" ) )
    endif
endfunction
command! -nargs=* Station :call AllTrainsAtStation(<f-args>)

"-------------------------------------------------------------------------------
" Command: :Bus
" Shows the next buses for your favourite route at your favourite stop
" 
" Uses:
" let g:FavouriteBusStop = 46
" let g:FavouriteBusRoute = 4
"-------------------------------------------------------------------------------

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

"-------------------------------------------------------------------------------
" Command: :Stop <stopNumber>
" 
" Shows all the buses at a particular stop
"-------------------------------------------------------------------------------

function! NextBusesAtStop( stopNumber )
    if has( "python3" )
      python3 DublinBusInfo.listNextBuses( vim.eval( "a:stopNumber" ) )
    endif
    if has( "python" )
      python DublinBusInfo.listNextBuses( vim.eval(" a:stopNumber" ) )
    endif
endfunction
command! -nargs=1 Stop :call NextBusesAtStop(<f-args>)

"-------------------------------------------------------------------------------
" Command: :NextBus <stopNumber> <busNumber>
" 
" Shows all the buses for a specific route at a stop
" E.g. ':NextBus 489 42': all 42 buses at stop 489
"-------------------------------------------------------------------------------

function! NextBusOfRoute( stopNumber, busNumber )
    if has( "python3" )
      python3 DublinBusInfo.listNextBuses( vim.eval( "a:stopNumber" ), vim.eval( "a:busNumber" ) )
    endif
    if has( "python" )
      python DublinBusInfo.listNextBuses( vim.eval( "a:stopNumber" ), vim.eval( "a:busNumber" ) )
    endif
endfunction
command! -nargs=* NextBus :call NextBusOfRoute(<f-args>)
