Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F99341C84
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363978; cv=none; b=VcMLno0ROEp2AG+G5QvVPBZnGAi2aIg62HbL8rJSM9/kb3p+2KKjUZYPDbGf7KYZMfGq4szYJzVFqPMupL61p5JmR3gSSPbFwweG90YFeB+BnSKAH21VDFKCS63YFOju3LXiqHxqv4Wx0h6UGsCzx0ix7RDGmTn4WcSewOjhvJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363978; c=relaxed/simple;
	bh=f775fYUi0GZ/quF/JLUyuXps4hlBzppKqPUXUn9xL3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgKxm/fZlMTQxsq2duWbde+sguRD2LzGbnltFl1i7ux+ftuNH9qusDU/X+drnszkxf2GrSxQJawiyXpvwerPmNPIGhEANb9GsmBNBPJ6KEy5kHhiwQNxP5U3/J2JLZLiv6MZ7gHAkc3ZJSF+VgmAUJSvp8ocAlXZDHHLIaRVLVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TdqJQ6cJFz6JB3W;
	Tue, 20 Feb 2024 01:28:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B52B140D30;
	Tue, 20 Feb 2024 01:32:53 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 17:32:53 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gregory
 Price <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
	<alex.bennee@linaro.org>, Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos
	<dimitrios.palyvos@zptcorp.com>, <richard.henderson@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH v2 2/3] target/i386: Enable page walking from MMIO memory
Date: Mon, 19 Feb 2024 17:31:52 +0000
Message-ID: <20240219173153.12114-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219173153.12114-1-Jonathan.Cameron@huawei.com>
References: <20240219173153.12114-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Gregory Price <gregory.price@memverge.com>

CXL emulation of interleave requires read and write hooks due to
requirement for subpage granularity. The Linux kernel stack now enables
using this memory as conventional memory in a separate NUMA node. If a
process is deliberately forced to run from that node
$ numactl --membind=1 ls
the page table walk on i386 fails.

Useful part of backtrace:

    (cpu=cpu@entry=0x555556fd9000, fmt=fmt@entry=0x555555fe3378 "cpu_io_recompile: could not find TB for pc=%p")
    at ../../cpu-target.c:359
    (retaddr=0, addr=19595792376, attrs=..., xlat=<optimized out>, cpu=0x555556fd9000, out_offset=<synthetic pointer>)
    at ../../accel/tcg/cputlb.c:1339
    (cpu=0x555556fd9000, full=0x7fffee0d96e0, ret_be=ret_be@entry=0, addr=19595792376, size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2030
    (cpu=cpu@entry=0x555556fd9000, p=p@entry=0x7ffff56fddc0, mmu_idx=<optimized out>, type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:2356
    (cpu=cpu@entry=0x555556fd9000, addr=addr@entry=19595792376, oi=oi@entry=52, ra=ra@entry=0, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
    at ../../accel/tcg/ldst_common.c.inc:301
    at ../../target/i386/tcg/sysemu/excp_helper.c:173
    (err=0x7ffff56fdf80, out=0x7ffff56fdf70, mmu_idx=0, access_type=MMU_INST_FETCH, addr=18446744072116178925, env=0x555556fdb7c0)
    at ../../target/i386/tcg/sysemu/excp_helper.c:578
    (cs=0x555556fd9000, addr=18446744072116178925, size=<optimized out>, access_type=MMU_INST_FETCH, mmu_idx=0, probe=<optimized out>, retaddr=0) at ../../target/i386/tcg/sysemu/excp_helper.c:604

Avoid this by plumbing the address all the way down from
x86_cpu_tlb_fill() where is available as retaddr to the actual accessors
which provide it to probe_access_full() which already handles MMIO accesses.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: Thanks Richard and Philippe for reviews.
 - Picked up tags.
 
 target/i386/tcg/sysemu/excp_helper.c | 57 +++++++++++++++-------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 5b86f439ad..b3bce020f4 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -59,14 +59,14 @@ typedef struct PTETranslate {
     hwaddr gaddr;
 } PTETranslate;
 
-static bool ptw_translate(PTETranslate *inout, hwaddr addr)
+static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
 {
     CPUTLBEntryFull *full;
     int flags;
 
     inout->gaddr = addr;
     flags = probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
-                              inout->ptw_idx, true, &inout->haddr, &full, 0);
+                              inout->ptw_idx, true, &inout->haddr, &full, ra);
 
     if (unlikely(flags & TLB_INVALID_MASK)) {
         TranslateFault *err = inout->err;
@@ -82,20 +82,20 @@ static bool ptw_translate(PTETranslate *inout, hwaddr addr)
     return true;
 }
 
-static inline uint32_t ptw_ldl(const PTETranslate *in)
+static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
 {
     if (likely(in->haddr)) {
         return ldl_p(in->haddr);
     }
-    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
+    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
 }
 
-static inline uint64_t ptw_ldq(const PTETranslate *in)
+static inline uint64_t ptw_ldq(const PTETranslate *in, uint64_t ra)
 {
     if (likely(in->haddr)) {
         return ldq_p(in->haddr);
     }
-    return cpu_ldq_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
+    return cpu_ldq_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
 }
 
 /*
@@ -132,7 +132,8 @@ static inline bool ptw_setl(const PTETranslate *in, uint32_t old, uint32_t set)
 }
 
 static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
-                          TranslateResult *out, TranslateFault *err)
+                          TranslateResult *out, TranslateFault *err,
+                          uint64_t ra)
 {
     const int32_t a20_mask = x86_get_a20_mask(env);
     const target_ulong addr = in->addr;
@@ -166,11 +167,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                  */
                 pte_addr = ((in->cr3 & ~0xfff) +
                             (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
-                if (!ptw_translate(&pte_trans, pte_addr)) {
+                if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                     return false;
                 }
             restart_5:
-                pte = ptw_ldq(&pte_trans);
+                pte = ptw_ldq(&pte_trans, ra);
                 if (!(pte & PG_PRESENT_MASK)) {
                     goto do_fault;
                 }
@@ -191,11 +192,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              */
             pte_addr = ((pte & PG_ADDRESS_MASK) +
                         (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
-            if (!ptw_translate(&pte_trans, pte_addr)) {
+            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                 return false;
             }
         restart_4:
-            pte = ptw_ldq(&pte_trans);
+            pte = ptw_ldq(&pte_trans, ra);
             if (!(pte & PG_PRESENT_MASK)) {
                 goto do_fault;
             }
@@ -212,11 +213,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              */
             pte_addr = ((pte & PG_ADDRESS_MASK) +
                         (((addr >> 30) & 0x1ff) << 3)) & a20_mask;
-            if (!ptw_translate(&pte_trans, pte_addr)) {
+            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                 return false;
             }
         restart_3_lma:
-            pte = ptw_ldq(&pte_trans);
+            pte = ptw_ldq(&pte_trans, ra);
             if (!(pte & PG_PRESENT_MASK)) {
                 goto do_fault;
             }
@@ -239,12 +240,12 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              * Page table level 3
              */
             pte_addr = ((in->cr3 & ~0x1f) + ((addr >> 27) & 0x18)) & a20_mask;
-            if (!ptw_translate(&pte_trans, pte_addr)) {
+            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
                 return false;
             }
             rsvd_mask |= PG_HI_USER_MASK;
         restart_3_nolma:
-            pte = ptw_ldq(&pte_trans);
+            pte = ptw_ldq(&pte_trans, ra);
             if (!(pte & PG_PRESENT_MASK)) {
                 goto do_fault;
             }
@@ -262,11 +263,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          */
         pte_addr = ((pte & PG_ADDRESS_MASK) +
                     (((addr >> 21) & 0x1ff) << 3)) & a20_mask;
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
     restart_2_pae:
-        pte = ptw_ldq(&pte_trans);
+        pte = ptw_ldq(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -289,10 +290,10 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          */
         pte_addr = ((pte & PG_ADDRESS_MASK) +
                     (((addr >> 12) & 0x1ff) << 3)) & a20_mask;
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
-        pte = ptw_ldq(&pte_trans);
+        pte = ptw_ldq(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -307,11 +308,11 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 2
          */
         pte_addr = ((in->cr3 & ~0xfff) + ((addr >> 20) & 0xffc)) & a20_mask;
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
     restart_2_nopae:
-        pte = ptw_ldl(&pte_trans);
+        pte = ptw_ldl(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -336,10 +337,10 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 1
          */
         pte_addr = ((pte & ~0xfffu) + ((addr >> 10) & 0xffc)) & a20_mask;
-        if (!ptw_translate(&pte_trans, pte_addr)) {
+        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
             return false;
         }
-        pte = ptw_ldl(&pte_trans);
+        pte = ptw_ldl(&pte_trans, ra);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
         }
@@ -529,7 +530,8 @@ static G_NORETURN void raise_stage2(CPUX86State *env, TranslateFault *err,
 
 static bool get_physical_address(CPUX86State *env, vaddr addr,
                                  MMUAccessType access_type, int mmu_idx,
-                                 TranslateResult *out, TranslateFault *err)
+                                 TranslateResult *out, TranslateFault *err,
+                                 uint64_t ra)
 {
     TranslateParams in;
     bool use_stage2 = env->hflags2 & HF2_NPT_MASK;
@@ -548,7 +550,7 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
             in.mmu_idx = MMU_USER_IDX;
             in.ptw_idx = MMU_PHYS_IDX;
 
-            if (!mmu_translate(env, &in, out, err)) {
+            if (!mmu_translate(env, &in, out, err, ra)) {
                 err->stage2 = S2_GPA;
                 return false;
             }
@@ -575,7 +577,7 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
                     return false;
                 }
             }
-            return mmu_translate(env, &in, out, err);
+            return mmu_translate(env, &in, out, err, ra);
         }
         break;
     }
@@ -601,7 +603,8 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
     TranslateResult out;
     TranslateFault err;
 
-    if (get_physical_address(env, addr, access_type, mmu_idx, &out, &err)) {
+    if (get_physical_address(env, addr, access_type, mmu_idx, &out, &err,
+                             retaddr)) {
         /*
          * Even if 4MB pages, we map only one 4KB page in the cache to
          * avoid filling it too fast.
-- 
2.39.2

