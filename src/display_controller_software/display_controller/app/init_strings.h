#ifndef INIT_STRINGS_H_
#define INIT_STRINGS_H_

#include "linux_cpu_strings.h"

#ifndef ICACHE_SIZE_STR
#define ICACHE_SIZE_STR "??"
#endif
#ifndef DCACHE_SIZE_STR
#define DCACHE_SIZE_STR "??"
#endif
#ifndef PROCESS_ID_NUM_BITS_STR
#define PROCESS_ID_NUM_BITS_STR "??"
#endif
#ifndef TLB_NUM_WAYS_STR
#define TLB_NUM_WAYS_STR "??"
#endif
#ifndef TLB_NUM_ENTRIES_STR
#define TLB_NUM_ENTRIES_STR "????"
#endif
#ifndef LINUX_TIMER_1MS_FREQ_STR
#define LINUX_TIMER_1MS_FREQ_STR "???"
#endif

#if defined(MMU_PRESENT)

#define LINE_3_TXT "\n" "IC:" ICACHE_SIZE_STR "KB  DC:" DCACHE_SIZE_STR "KB"
#define LINE_4_TXT "\n" "PID:" PROCESS_ID_NUM_BITS_STR " TLBS:" TLB_NUM_ENTRIES_STR
#define LINE_5_TXT "\n" "WAYS:" TLB_NUM_WAYS_STR "   " LINUX_TIMER_1MS_FREQ_STR "MHz"

#else

#define LINE_3_TXT "\n" "IC:" ICACHE_SIZE_STR "KB  DC:" DCACHE_SIZE_STR "KB"
#define LINE_4_TXT "\n" "NO MMU"
#define LINE_5_TXT "\n" "          " LINUX_TIMER_1MS_FREQ_STR "MHz"

#endif

#endif /*INIT_STRINGS_H_*/
