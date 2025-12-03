all:
	as -o day3.o day3.s
	ld -o day3 day3.o -l System -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _main

run: all
	./day3 < input.txt

clean:
	rm -f day3 day3.o