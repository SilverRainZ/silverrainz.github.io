#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdint.h>
#include <inttypes.h>
#include <sys/syscall.h>
#include <sys/mman.h>
#include <linux/io_uring.h>

static inline uint64_t page_size(void) {
    return sysconf(_SC_PAGESIZE);
}

// See also https://man7.org/linux/man-pages/man5/proc_pid_pagemap.5.html
uint64_t virt_to_phys(void *virt) {
    uint64_t addr = (uint64_t)virt, ps = page_size();
    int fd = open("/proc/self/pagemap", O_RDONLY);
    if (fd < 0) {
        perror("open /proc/self/pagemap failed");
        return 0;
    }

    uint64_t entry;
    uint64_t offset = (addr / ps) * sizeof(uint64_t);
    if (lseek(fd, offset, SEEK_SET) < 0 || read(fd, &entry, 8) != 8 ||
        !(entry & (1ULL << 63))) {
        perror("read pagemap failed");
        close(fd);
        return 0;
    }
    close(fd);
    return (entry & ((1ULL << 55) - 1)) * ps + (addr % ps);
}

void get_sq_cq_ptrs(void **sq, void **cq) {
    struct io_uring_params p = {0};
    int fd = syscall(__NR_io_uring_setup, 1, &p);
    if (fd < 0) {
        perror("syscall io_uring_setup failed");
        return;
    }

    int ssz = p.sq_off.array + p.sq_entries * sizeof(unsigned);
    int csz = p.cq_off.cqes + p.cq_entries * sizeof(struct io_uring_cqe);

    *sq = mmap(0, ssz, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, fd, IORING_OFF_SQ_RING);
    *cq = mmap(0, csz, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE, fd, IORING_OFF_CQ_RING);
}

int main() {
    void *sq, *cq;
    get_sq_cq_ptrs(&sq, &cq);

    // Test phys addr eq.
    uint64_t sq_phys = virt_to_phys(sq);
    uint64_t cq_phys = virt_to_phys(cq);
    printf("sq_ptr = %p -> phys = 0x%016" PRIx64 "\n", sq, sq_phys);
    printf("cq_ptr = %p -> phys = 0x%016" PRIx64 "\n", cq, cq_phys);
    printf("have same phys addr? %s\n", sq_phys == cq_phys ? "true" : "false");

    // Test read and write.
    printf("*sq_ptr = %x\n", *(int *)sq);
    printf("*cq_ptr = %x\n", *(int *)cq);
    int v = 0x1234;
    printf("write 0x%x to sq_ptr, but not cq_ptr\n", v);
    *(int *)sq = v;
    printf("*sq_ptr = %x\n", *(int *)sq);
    printf("*cq_ptr = %x\n", *(int *)cq);
}
