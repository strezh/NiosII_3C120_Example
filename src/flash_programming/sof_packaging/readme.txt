USAGE: ./create-flash-programming-file.sh <PAGE>

Valid <PAGE> options are --PAGE_0, --PAGE_1 or --PAGE_2

This script will package the SOF data for device configuration along with the
ascii data for the macros defined in the linux_cpu header file.  The resultant
dot-flash file can be programmed as usual with nios2-flash-programmer.
