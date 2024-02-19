Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E447F55
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364008; cv=none; b=ueP+ILW9y5zRHXaOyYMrEHMF8iRMrzYU8LdO3tgrkaaOfzrhrSfbW55G6XwoZ9VRq0F0HVJabT3uZSEeQZpNiMQ3DlqpnS5zeKp1vrg4jBN58cWVm9HW0zt27rveCby78LSEZDc3lEk9sE6UXufqukXo+uOEhcVcWkE488GyIBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364008; c=relaxed/simple;
	bh=bkmNJQ2NiRXIVXOgVourWs5r8knbBn+ikzOzNx80zlY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqyYs2UO+7j5CdX2Xa+daEe1skG0JHeGGuaZzuc/T3MYWGokweVtdrOuLpVDZwgVY6nT33LOElMCTk4ih4s/dGtdRDZ9L7jLXQltOzs8KVTNgfRp3HgzEWDqZCGE1rWyaDZB+BaM/XUCiBrvaem0lGVdQMzghhURrQ9XJ9b48Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TdqKM0MC8z6K5kB;
	Tue, 20 Feb 2024 01:29:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BF90140519;
	Tue, 20 Feb 2024 01:33:24 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 17:33:23 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gregory
 Price <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
	<alex.bennee@linaro.org>, Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos
	<dimitrios.palyvos@zptcorp.com>, <richard.henderson@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH v2 3/3] tcg: Avoid double lock if page tables happen to be in mmio memory.
Date: Mon, 19 Feb 2024 17:31:53 +0000
Message-ID: <20240219173153.12114-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219173153.12114-1-Jonathan.Cameron@huawei.com>
References: <20240219173153.12114-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On i386, after fixing the page walking code to work with pages in
MMIO memory (specifically CXL emulated interleaved memory),
a crash was seen in an interrupt handling path.

Useful part of backtrace

7  0x0000555555ab1929 in bql_lock_impl (file=0x555556049122 "../../accel/tcg/cputlb.c", line=2033) at ../../system/cpus.c:524
8  bql_lock_impl (file=file@entry=0x555556049122 "../../accel/tcg/cputlb.c", line=line@entry=2033) at ../../system/cpus.c:520
9  0x0000555555c9f7d6 in do_ld_mmio_beN (cpu=0x5555578e0cb0, full=0x7ffe88012950, ret_be=ret_be@entry=0, addr=19595792376, size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2033
10 0x0000555555ca0fbd in do_ld_8 (cpu=cpu@entry=0x5555578e0cb0, p=p@entry=0x7ffff4efd1d0, mmu_idx=<optimized out>, type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:2356
11 0x0000555555ca341f in do_ld8_mmu (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=19595792376, oi=oi@entry=52, ra=0, ra@entry=52, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
12 0x0000555555ca5f59 in cpu_ldq_mmu (ra=52, oi=52, addr=19595792376, env=0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:169
13 cpu_ldq_le_mmuidx_ra (env=0x5555578e3470, addr=19595792376, mmu_idx=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/ldst_common.c.inc:301
14 0x0000555555b4b5fc in ptw_ldq (ra=0, in=0x7ffff4efd320) at ../../target/i386/tcg/sysemu/excp_helper.c:98
15 ptw_ldq (ra=0, in=0x7ffff4efd320) at ../../target/i386/tcg/sysemu/excp_helper.c:93
16 mmu_translate (env=env@entry=0x5555578e3470, in=0x7ffff4efd3e0, out=0x7ffff4efd3b0, err=err@entry=0x7ffff4efd3c0, ra=ra@entry=0) at ../../target/i386/tcg/sysemu/excp_helper.c:174
17 0x0000555555b4c4b3 in get_physical_address (ra=0, err=0x7ffff4efd3c0, out=0x7ffff4efd3b0, mmu_idx=0, access_type=MMU_DATA_LOAD, addr=18446741874686299840, env=0x5555578e3470) at ../../target/i386/tcg/sysemu/excp_helper.c:580
18 x86_cpu_tlb_fill (cs=0x5555578e0cb0, addr=18446741874686299840, size=<optimized out>, access_type=MMU_DATA_LOAD, mmu_idx=0, probe=<optimized out>, retaddr=0) at ../../target/i386/tcg/sysemu/excp_helper.c:606
19 0x0000555555ca0ee9 in tlb_fill (retaddr=0, mmu_idx=0, access_type=MMU_DATA_LOAD, size=<optimized out>, addr=18446741874686299840, cpu=0x7ffff4efd540) at ../../accel/tcg/cputlb.c:1315
20 mmu_lookup1 (cpu=cpu@entry=0x5555578e0cb0, data=data@entry=0x7ffff4efd540, mmu_idx=0, access_type=access_type@entry=MMU_DATA_LOAD, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:1713
21 0x0000555555ca2c61 in mmu_lookup (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=18446741874686299840, oi=oi@entry=32, ra=ra@entry=0, type=type@entry=MMU_DATA_LOAD, l=l@entry=0x7ffff4efd540) at ../../accel/tcg/cputlb.c:1803
22 0x0000555555ca3165 in do_ld4_mmu (cpu=cpu@entry=0x5555578e0cb0, addr=addr@entry=18446741874686299840, oi=oi@entry=32, ra=ra@entry=0, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2416
23 0x0000555555ca5ef9 in cpu_ldl_mmu (ra=0, oi=32, addr=18446741874686299840, env=0x5555578e3470) at ../../accel/tcg/ldst_common.c.inc:158
24 cpu_ldl_le_mmuidx_ra (env=env@entry=0x5555578e3470, addr=addr@entry=18446741874686299840, mmu_idx=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/ldst_common.c.inc:294
25 0x0000555555bb6cdd in do_interrupt64 (is_hw=1, next_eip=18446744072399775809, error_code=0, is_int=0, intno=236, env=0x5555578e3470) at ../../target/i386/tcg/seg_helper.c:889
26 do_interrupt_all (cpu=cpu@entry=0x5555578e0cb0, intno=236, is_int=is_int@entry=0, error_code=error_code@entry=0, next_eip=next_eip@entry=0, is_hw=is_hw@entry=1) at ../../target/i386/tcg/seg_helper.c:1130
27 0x0000555555bb87da in do_interrupt_x86_hardirq (env=env@entry=0x5555578e3470, intno=<optimized out>, is_hw=is_hw@entry=1) at ../../target/i386/tcg/seg_helper.c:1162
28 0x0000555555b5039c in x86_cpu_exec_interrupt (cs=0x5555578e0cb0, interrupt_request=<optimized out>) at ../../target/i386/tcg/sysemu/seg_helper.c:197
29 0x0000555555c94480 in cpu_handle_interrupt (last_tb=<synthetic pointer>, cpu=0x5555578e0cb0) at ../../accel/tcg/cpu-exec.c:844

Peter identified this as being due to the BQL already being
held when the page table walker encounters MMIO memory and attempts
to take the lock again.  There are other examples of similar paths
TCG, so this follows the approach taken in those of simply checking
if the lock is already held and if it is, don't take it again.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2: Thanks Peter, Philippe and Richard.
- Put missing bt in commit message.
- Switch from locked to need_lock and added likely() to indicate that
  the path where we are skipping locking is an obscure one so not
  expected to happen much. (Philippe)
- Equivalent change made to do_ld16_mmio_beN, do_st_mmio_leN,
  do_st16_mmio_leN as well as do_ld_mmio_beN (Peter)
---
 accel/tcg/cputlb.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 047cd2cc0a..d2b9444796 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2018,6 +2018,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
                                uint64_t ret_be, vaddr addr, int size,
                                int mmu_idx, MMUAccessType type, uintptr_t ra)
 {
+    bool need_lock = !bql_locked();
     MemoryRegionSection *section;
     MemoryRegion *mr;
     hwaddr mr_offset;
@@ -2030,10 +2031,14 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
     mr = section->mr;
 
-    bql_lock();
+    if (likely(need_lock)) {
+        bql_lock();
+    }
     ret = int_ld_mmio_beN(cpu, full, ret_be, addr, size, mmu_idx,
                           type, ra, mr, mr_offset);
-    bql_unlock();
+    if (likely(need_lock)) {
+        bql_unlock();
+    }
 
     return ret;
 }
@@ -2042,6 +2047,7 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
                                uint64_t ret_be, vaddr addr, int size,
                                int mmu_idx, uintptr_t ra)
 {
+    bool need_lock = !bql_locked();
     MemoryRegionSection *section;
     MemoryRegion *mr;
     hwaddr mr_offset;
@@ -2054,12 +2060,16 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
     mr = section->mr;
 
-    bql_lock();
+    if (likely(need_lock)) {
+        bql_lock();
+    }
     a = int_ld_mmio_beN(cpu, full, ret_be, addr, size - 8, mmu_idx,
                         MMU_DATA_LOAD, ra, mr, mr_offset);
     b = int_ld_mmio_beN(cpu, full, ret_be, addr + size - 8, 8, mmu_idx,
                         MMU_DATA_LOAD, ra, mr, mr_offset + size - 8);
-    bql_unlock();
+    if (likely(need_lock)) {
+        bql_unlock();
+    }
 
     return int128_make128(b, a);
 }
@@ -2565,6 +2575,7 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
                                uint64_t val_le, vaddr addr, int size,
                                int mmu_idx, uintptr_t ra)
 {
+    bool need_lock = !bql_locked();
     MemoryRegionSection *section;
     hwaddr mr_offset;
     MemoryRegion *mr;
@@ -2577,10 +2588,14 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
     mr = section->mr;
 
-    bql_lock();
+    if (likely(need_lock)) {
+        bql_lock();
+    }
     ret = int_st_mmio_leN(cpu, full, val_le, addr, size, mmu_idx,
                           ra, mr, mr_offset);
-    bql_unlock();
+    if (likely(need_lock)) {
+        bql_unlock();
+    }
 
     return ret;
 }
@@ -2589,6 +2604,7 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
                                  Int128 val_le, vaddr addr, int size,
                                  int mmu_idx, uintptr_t ra)
 {
+    bool need_lock = !bql_locked();
     MemoryRegionSection *section;
     MemoryRegion *mr;
     hwaddr mr_offset;
@@ -2601,12 +2617,16 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
     mr = section->mr;
 
-    bql_lock();
+    if (likely(need_lock)) {
+        bql_lock();
+    }
     int_st_mmio_leN(cpu, full, int128_getlo(val_le), addr, 8,
                     mmu_idx, ra, mr, mr_offset);
     ret = int_st_mmio_leN(cpu, full, int128_gethi(val_le), addr + 8,
                           size - 8, mmu_idx, ra, mr, mr_offset + 8);
-    bql_unlock();
+    if (likely(need_lock)) {
+        bql_unlock();
+    }
 
     return ret;
 }
-- 
2.39.2

