 #
 # 	Coded By: 	Josh Woolbright
 # 	Date: 		12/6/2019
 #
 # 	Description:
 # 			This file contains a program that solves the
 #			quadratic equation for given inputs.
 #

	.data
 title:	.asciiz	"QE Solver by Josh Woolbright\n"
 line:	.asciiz "\n"
 error1:.asciiz "Equation is not quadratic\n"
 error2:.asciiz	"Imaginary roots\n"
 a:	.asciiz	"Enter a? "
 be:	.asciiz "Enter b? "
 c:	.asciiz "Enter c? "
 x1:	.asciiz	"x1 = "
 x2:	.asciiz "x2 = "

	.text
 main:
	la	$a0, title		# Print title
	li	$v0, 4
	syscall

	la	$a0, line		# Print line
	syscall

	la	$a0, a			# Prompt for a
	syscall

	li	$v0, 6			# Read float
	syscall

	li.s	$f4, 0.0
	c.eq.s	$f0, $f4		# If a = 0, set flag
	bc1t	notQuad			# If flag set, branch

	mov.s	$f20, $f0		# Move a to saved reg

	la	$a0, be			# Prompt for b
	li	$v0, 4
	syscall

	li	$v0, 6			# Read float
	syscall

	mov.s	$f21, $f0		# Move b to saved reg

	la	$a0, c			# Prompt for c
	li	$v0, 4
	syscall

	li	$v0, 6			# Read float
	syscall

	mov.s	$f22, $f0		# Move c to saved reg

	la	$a0, line		# print line
	li	$v0, 4
	syscall

	mul.s	$f7, $f21, $f21		# f7 = b^2
	mul.s	$f8, $f20, $f22		# f8 = ac
	li.s	$f9, 4.0		
	mul.s	$f8, $f9, $f8		# f8 = 4ac
	sub.s	$f7, $f7, $f8		# f7 = b^2 - 4ac

	li.s	$f8, 0.0
	c.lt.s	$f7, $f8		# If discriminant < 0, set flag
	bc1t	imaginary		# If flag set, branch

	mov.s	$f12, $f7
	jal	bsqrt			# Get sqrt(b^2 - 4ac)

	neg.s	$f5, $f21		# f5 = -b
	add.s	$f6, $f5, $f0		# f6 = -b + sqrt
	sub.s	$f7, $f5, $f0		# f7 = -b - sqrt
	
	li.s	$f8, 2.0
	mul.s	$f4, $f20, $f8		# f4 = 2a
	div.s	$f8, $f6, $f4		# f8 = root x1
	div.s	$f9, $f7, $f4 		# f9 = root x2

	la	$a0, x1			# print x1 =
	syscall

	mov.s	$f12, $f8		# print x1
	li	$v0, 2
	syscall

	la	$a0, line		# print line
	li	$v0, 4
	syscall

	la	$a0, x2			# print x2 =
	syscall

	mov.s	$f12, $f9		# print x2
	li	$v0, 2
	syscall

	li	$v0, 10			# end program
	syscall

 imaginary:
	la	$a0, error2		# print imgaginary roots
	syscall

	li	$v0, 10			# end progam
	syscall

 notQuad:
	la	$a0, line		# print line
	li	$v0, 4
	syscall

	la	$a0, error1		# print not quadratic
	syscall

	li	$v0, 10			# end program
	syscall
	
