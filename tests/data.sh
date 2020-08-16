#!/bin/bash

array_execute=(
	'yes'		# 01
	'yes'		# 02
	'yes'		# 03
	'test'		# 04
	'no'		# 05
)
array_machine=(
	'local'
	'local'
	'local'
	'local'
	'192.168.1.200'
)
array_remote_user=(
	''
	''
	''
	'username'
	'username'
	
)
array_path=(
	'/etc/bashrc'
	'/root/.bashrc'
	'/etc/vimrc'
	'/ddd/'
	'/eee/'
)
array_read=(
	'./shared/global-bashrc'
	'./shared/root-bashrc'
	'./shared/etc-vimrc'
	'ddd_read'
	'eee_read'
)
array_start=(
	'# 000_GLOBAL_BASHRC_ETC_BASHRC'
	'# 000_ROOT_BASHRC_ROOT_BASHRC'
	'" 000_VIMRC_CONF'
	'ddd_start'
	'eee_start'
)
array_end=(
	'# 000_GLOBAL_BASHRC_ETC_BASHRC_END'
	'# 000_ROOT_BASHRC_ROOT_BASHRC_END'
	'" 000_VIMRC_CONF_END'
	'ddd_end'
	'eee_end'
)

source ./array.sh
