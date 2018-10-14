There's a weird error when I deploy this on my dev board. The first two bits
cause the result of the multiply to be clocked into the output register before
the inputs have been clocked into the input register. Any value using the first
two bits displays this error. The simulation shows the correct values, though.
