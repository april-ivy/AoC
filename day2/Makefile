all:
	as -o day2.o day2.s
	ld -o day2 day2.o -l System -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _main

run: all
	./day2 < input.txt

clean:
	rm -f day2 day2.o