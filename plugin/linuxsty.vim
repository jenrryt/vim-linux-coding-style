" Vim plugin to fit the Linux kernel coding style and help kernel development
" Last Change:	2012 Jul 1
" Maintainer:	Vivien Didelot <vivien@didelot.org>
" License:		This file is distributed under the Beerware license.
"
" This script is inspired from an article written by Bart:
" http://www.jukie.net/bart/blog/vim-and-linux-coding-style

if exists("g:loaded_linuxsty")
	finish
endif
let g:loaded_linuxsty = 1

set wildignore+=*.ko,*.mod.c,*.order,modules.builtin

augroup linuxsty
	autocmd!

	autocmd FileType c,cpp			call s:LinuxFormatting()
	autocmd FileType c,cpp			call s:LinuxKeywords()
	autocmd FileType c,cpp			call s:LinuxHighlighting()
	autocmd FileType diff,kconfig	setlocal tabstop=8
augroup END

function s:LinuxFormatting()
	setlocal tabstop=8
	setlocal shiftwidth=8
	setlocal textwidth=80
	setlocal noexpandtab

	setlocal cindent
	setlocal formatoptions=tcqlron
	setlocal cinoptions=:0,l1,t0,g0
endfunction

function s:LinuxKeywords()
	syn keyword cOperator likely unlikely
	syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64
endfunction

function s:LinuxHighlighting()
	highlight default link LinuxError ErrorMsg

	match			LinuxError	" \+\t"		" spaces before tab
	match			LinuxError	"\s\+$"		" trailing whitespaces
	syntax match	LinuxError	/.\%>81v/	" virtual column 81 and more
endfunction
