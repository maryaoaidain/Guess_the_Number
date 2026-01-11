# Guess the Number Game for QtSpim (Fixed Version)
# Uses simple pseudo-random algorithm since QtSpim doesn't support syscall 30/40/42

.data
    welcome:    .asciiz "=== Guess the Number Game ===\n"
    prompt:     .asciiz "I'm thinking of a number between 1 and 100.\n"
    guess_msg:  .asciiz "Enter your guess: "
    high_msg:   .asciiz "Too high! Try lower.\n"
    low_msg:    .asciiz "Too low! Try higher.\n"
    success:    .asciiz "Congratulations! You guessed it!\n"
    attempts:   .asciiz "Number of attempts: "
    newline:    .asciiz "\n"
    play_again: .asciiz "Play again? (1=Yes, 0=No): "
    goodbye:    .asciiz "Thanks for playing!\n"
    error_msg:  .asciiz "Invalid input! Please enter 1-100.\n"
    
    # For pseudo-random number generation
    seed:       .word 12345
    counter:    .word 0

.text
.globl main

main:
    # Display welcome message
    li $v0, 4
    la $a0, welcome
    syscall

game_loop:
    # Initialize variables
    li $t0, 0           # $t0 = number of attempts
    
    # Generate pseudo-random number (1-100)
    jal generate_random
    move $t1, $v0       # $t1 = random number (1-100)
    
    # For debugging - you can uncomment to see the random number
    # li $v0, 1
    # move $a0, $t1
    # syscall
    # li $v0, 4
    # la $a0, newline
    # syscall
    
    # Display prompt
    li $v0, 4
    la $a0, prompt
    syscall

guess_loop:
    # Display guess prompt
    li $v0, 4
    la $a0, guess_msg
    syscall

    # Read integer from user
    li $v0, 5
    syscall
    move $t2, $v0       # $t2 = user's guess

    # Validate input (1-100)
    blt $t2, 1, invalid_input
    bgt $t2, 100, invalid_input
    j input_valid

invalid_input:
    li $v0, 4
    la $a0, error_msg
    syscall
    j guess_loop

input_valid:
    # Increment attempt counter
    addi $t0, $t0, 1

    # Check if guess is correct
    beq $t2, $t1, correct_guess

    # Check if guess is too high
    bgt $t2, $t1, guess_too_high

    # Otherwise, guess is too low
    li $v0, 4
    la $a0, low_msg
    syscall
    j guess_loop

guess_too_high:
    li $v0, 4
    la $a0, high_msg
    syscall
    j guess_loop

correct_guess:
    # Display success message
    li $v0, 4
    la $a0, success
    syscall

    # Display number of attempts
    li $v0, 4
    la $a0, attempts
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    # Ask if user wants to play again
    li $v0, 4
    la $a0, play_again
    syscall

    li $v0, 5
    syscall
    move $t3, $v0       # $t3 = play again choice

    # Check choice
    beq $t3, 1, game_loop  # if 1, play again

    # Otherwise, exit
    li $v0, 4
    la $a0, goodbye
    syscall

    # Exit program
    li $v0, 10
    syscall

# -------------------------------------------------
# Function: generate_random
# Returns: $v0 = random number between 1 and 100
# Uses simple linear congruential generator
# -------------------------------------------------
generate_random:
    # Load and update seed
    lw $t4, seed
    lw $t5, counter
    
    # Update counter
    addi $t5, $t5, 1
    sw $t5, counter
    
    # Linear congruential generator algorithm
    # formula: seed = (seed * 1103515245 + 12345) & 0x7FFFFFFF
    li $t6, 1103515245
    mul $t4, $t4, $t6
    addi $t4, $t4, 12345
    
    # Keep only positive 31 bits
    srl $t4, $t4, 1
    
    # Store updated seed
    sw $t4, seed
    
    # Convert to range 1-100
    li $t6, 100
    div $t4, $t6
    mfhi $v0           # remainder (0-99)
    addi $v0, $v0, 1   # (1-100)
    
    jr $ra
# -------------------------------------------------