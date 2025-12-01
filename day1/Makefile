all:
	as -o day1.o day1.s
	ld -o day1 day1.o -l System -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _main

run: all
	./day1 < input.txt

clean:
	rm -f day1 day1.o