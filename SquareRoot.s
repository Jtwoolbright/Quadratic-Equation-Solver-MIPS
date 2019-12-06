 #
 # 	Coded By: 	Josh Woolbright
 # 	Due: 		12/6/2019
 #
 # 	Description:
 # 			This file contains a subprogram that calculates the 
 #			square root of an inputted number.
 #

 	.text
 bsqrt:
	li.s	$f4, 1.0
	c.eq.s	$f12, $f4		# set flag if x = 1
	bc1t	one			# branch if flag set
	li.s	$f13, 2.0

	div.s	$f14, $f12, $f13	# guess = x/2

	li.s	$f4, 4.0
	c.lt.s	$f12, $f4		# set flag if x < 4
	bc1t	less			# branch if flag set
 loop:
	div.s	$f4, $f12, $f14		# r = x / guess
	add.s	$f5, $f14, $f4		# f5 = guess + r
	div.s	$f6, $f5, $f13		# new guess = (guess + r) / 2
	c.lt.s	$f6, $f14		# if new guess < guess, set flag
	mov.s	$f14, $f6		# move new guess to guess
	bc1t 	loop			# branch loop if flag set
	b 	done			# else, branch done
 one:
	mov.s	$f0, $f12
	jr	$ra			# return f0 = 1
 less:
	div.s	$f4, $f12, $f14		# r = x / guess
	add.s	$f5, $f14, $f4		# f5 = guess + r
	div.s	$f6, $f5, $f13		# new guess = (guess + r) / 2
	c.lt.s	$f6, $f14		# if new guess < guess, set flag
	mov.s	$f14, $f6		# move new guess to guess
	bc1t 	done
	bc1f	less
 done:
	mov.s	$f0, $f14		# return last guess
	jr	$ra
