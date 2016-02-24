" First, we do the mapping again, but this time we invoke a special function created for the task
nnoremap <silent> dsf :call <SID>DeleteSurroundingFunctionCall()<cr>

" (The s: of this function is the <SID> upstairs)
function! s:DeleteSurroundingFunctionCall()
  " most of the real work is done by the s:FindFunctionCallStart function.
  let [success, opening_bracket] = s:FindFunctionCallStart('b')
  if !success
    return
  endif

  " if it succeeded, it moved us to the right place to just delete everything to the opening bracket...
  exe 'normal! dt'.opening_bracket
  " ...and then delete the brackets themselves
  exe 'normal ds'.opening_bracket
  " and let's get repeat.vim support, so we can do this again with a simple `.`
  silent! call repeat#set('dsf')
endfunction

function! s:FindFunctionCallStart(flags)
  " first, look for something that looks like a keyword, followed by a ( or a [
  if search('\k\+\zs[([]', a:flags, line('.')) <= 0
    return [0, '']
  endif

  " what's the opening bracket?
  let opener = getline('.')[col('.') - 1]

  " go back one word to get to the beginning of the function call
  normal! b

  " now we're on the function's name, see if we should move back some more
  let prefix = strpart(getline('.'), 0, col('.') - 1)
  while prefix =~ '\k\(\.\|::\|:\|#\)$'
    if search('\k\+', 'b', line('.')) <= 0
      break
    endif
    let prefix = strpart(getline('.'), 0, col('.') - 1)
  endwhile

  return [1, opener]
endfunction
