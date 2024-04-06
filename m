Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9956745
	for <linux-cxl@vger.kernel.org>; Sat,  6 Apr 2024 22:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712442789; cv=none; b=D14oABwQnhNUgypFjiezXHt3ExpGZhfbZ9Xi3FFcIzSkVQSNfbQ+eA3i/wQl+OtAEAaUv3s2NtK5XBpSybTN/0W1hbH0ZqT/ZpDc3JDq+EtDclBF5e/Yt5C9bLmswmhWg9tRX5ephiB1PJ/qDAijjXne1xnW/8HPea4ziEsLACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712442789; c=relaxed/simple;
	bh=W2drLSMesDs6E5OgyOQmShXqnuoln0RB1yg/xe33SB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSFZfJFWph4KbgZJY0xEmwhDtl5UwFK0DVgHdLOlPflGzLogbpRG6GWXScwlMpGmLU+usqBS+5bBlW3QN7nvOGEtLn+5JXwFlCjbnlBK8VlUz1n0fn7DbOniZO+o1om+FEqE8q/smWUnEcyALrNG9lVKcejUIzWUNrB6tdEnT3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KjzU4oL0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjzU4oL0"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ecee5c08e6so3065530b3a.3
        for <linux-cxl@vger.kernel.org>; Sat, 06 Apr 2024 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712442787; x=1713047587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCcliQok5xWZ0STL9q8OCOy2kMXMLfgS8Bx/eIbiktU=;
        b=KjzU4oL0koSjIAAPtFhC0o1fE27IC6yyGyusAt9YHooCTEL9l/CXYIxrRg326DMX4w
         NNO/sBP2RROoEh+NfD1Dpz4qd2GLUWdDdHtWS4DNvBv+5Rpk06wlElMnjgTwCzPjFH4C
         L31TzACeV96RH9DhkRFXk4Yh9le8daJ2JfAT12xYuY1kMNvfZARHL60Jx3ZqGr96UWaH
         e8AlLsu1qeiBg3zzIKF0jRy/e9cbpGCG0SAGSjg1Be4ecSWsbdsQ9DldJv+d2OdgZ22d
         EYbsnNXo5zufNIdxc+7HA58Y/CCSSYGFfs8f1k9owVlj2hQjNkwhfH2li3bDMpu/wQZk
         9byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712442787; x=1713047587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCcliQok5xWZ0STL9q8OCOy2kMXMLfgS8Bx/eIbiktU=;
        b=oKjvFSUtfIfVX9yzMorxGg4ot9i/lBK1vulAQgAdcEu9QzaANG1YmHqSN8k87uTQGj
         EaAGta0cePkTkh/75crH4zWcgYC8gqdh+9uHu2SIMiSgpClvkg8VV/nEkgJ5inzYq0j5
         VGwEuyip54qEcyzJwNKgkmPAI3RDMkezrYqkLHw8oQLVeV4of/B6dOaHRbOShlQbKBWx
         fNpvGgD6tYenCW6rsfR9F9S0R41cXTRQhialwn97txhcgC9fr+kK8Ld+3fMqGaPA9Tlu
         DHp+Jn/6czIpEud60njGe9TU9yy5TkwouJoO1xQSfamqMfbEXm3gOBZAsX9hr+2fAYsd
         phxw==
X-Forwarded-Encrypted: i=1; AJvYcCUhcUa1L1bJITeCqr7yy4IcBNyPNCXAAQJJLa2R2eMIYc5kBplsNIv12jAloC3cm/209lBTp/tjtnk6pkljjqnxnhhysW5uuQ2P
X-Gm-Message-State: AOJu0YygGkwZuZgKJfm22qK1z8r8O+V3aGRLdv3KRiFcK0RD3oowjzM2
	g8XbmYLFpkdSpQOUCOjtNvrwaai/ktrW8cZnzyhbUwLKTwpZufokVRD7LtFGEU8=
X-Google-Smtp-Source: AGHT+IE3AVR0/+mC7iIHHm48lOL1fFr3ZCxMScSe1UR5cKptDMhugGenVanhfxi8QfNUctRI3pzpeQ==
X-Received: by 2002:a05:6a20:158c:b0:1a7:1c26:f9ac with SMTP id h12-20020a056a20158c00b001a71c26f9acmr6020296pzj.62.1712442786698;
        Sat, 06 Apr 2024 15:33:06 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 15:33:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Jorgen.Hansen@wdc.com,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org
Subject: [PATCH 9/9] accel/tcg: Improve can_do_io management
Date: Sat,  6 Apr 2024 12:32:48 -1000
Message-Id: <20240406223248.502699-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240406223248.502699-1-richard.henderson@linaro.org>
References: <20240406223248.502699-1-richard.henderson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We already attempted to set and clear can_do_io before the first
and last insns, but only used the initial value of max_insns and
the call to translator_io_start to find those insns.

Now that we track insn_start in DisasContextBase, and now that
we have emit_before_op, we can wait until we have finished
translation to identify the true first and last insns and emit
the sets of can_do_io at that time.

This fixes case of a translation block which crossed a page boundary,
and for which the second page turned out to be mmio.  In this case we
truncate the block, and the previous logic for can_do_io could leave
a block with a single insn with can_do_io set to false, which would
fail an assertion in cpu_io_recompile.

Reported-by: Jørgen Hansen <Jorgen.Hansen@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h |  1 -
 accel/tcg/translator.c    | 45 ++++++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index ceaeca8c91..2c4fb818e7 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -87,7 +87,6 @@ typedef struct DisasContextBase {
     int num_insns;
     int max_insns;
     bool singlestep_enabled;
-    int8_t saved_can_do_io;
     bool plugin_enabled;
     struct TCGOp *insn_start;
     void *host_addr[2];
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index ae61c154c2..9de0bc34c8 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -18,20 +18,14 @@
 
 static void set_can_do_io(DisasContextBase *db, bool val)
 {
-    if (db->saved_can_do_io != val) {
-        db->saved_can_do_io = val;
-
-        QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
-        tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
-                        offsetof(ArchCPU, parent_obj.neg.can_do_io) -
-                        offsetof(ArchCPU, env));
-    }
+    QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
+    tcg_gen_st8_i32(tcg_constant_i32(val), tcg_env,
+                    offsetof(ArchCPU, parent_obj.neg.can_do_io) -
+                    offsetof(ArchCPU, env));
 }
 
 bool translator_io_start(DisasContextBase *db)
 {
-    set_can_do_io(db, true);
-
     /*
      * Ensure that this instruction will be the last in the TB.
      * The target may override this to something more forceful.
@@ -84,13 +78,6 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
                          - offsetof(ArchCPU, env));
     }
 
-    /*
-     * cpu->neg.can_do_io is set automatically here at the beginning of
-     * each translation block.  The cost is minimal, plus it would be
-     * very easy to forget doing it in the translator.
-     */
-    set_can_do_io(db, db->max_insns == 1);
-
     return icount_start_insn;
 }
 
@@ -129,6 +116,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
 {
     uint32_t cflags = tb_cflags(tb);
     TCGOp *icount_start_insn;
+    TCGOp *first_insn_start = NULL;
     bool plugin_enabled;
 
     /* Initialize DisasContext */
@@ -139,7 +127,6 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->num_insns = 0;
     db->max_insns = *max_insns;
     db->singlestep_enabled = cflags & CF_SINGLE_STEP;
-    db->saved_can_do_io = -1;
     db->insn_start = NULL;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
@@ -159,6 +146,9 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
         *max_insns = ++db->num_insns;
         ops->insn_start(db, cpu);
         db->insn_start = tcg_last_op();
+        if (first_insn_start == NULL) {
+            first_insn_start = db->insn_start;
+        }
         tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
         if (plugin_enabled) {
@@ -171,10 +161,6 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
          * done next -- either exiting this loop or locate the start of
          * the next instruction.
          */
-        if (db->num_insns == db->max_insns) {
-            /* Accept I/O on the last instruction.  */
-            set_can_do_io(db, true);
-        }
         ops->translate_insn(db, cpu);
 
         /*
@@ -207,6 +193,21 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     ops->tb_stop(db, cpu);
     gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);
 
+    /*
+     * Manage can_do_io for the translation block: set to false before
+     * the first insn and set to true before the last insn.
+     */
+    if (db->num_insns == 1) {
+        tcg_debug_assert(first_insn_start == db->insn_start);
+    } else {
+        tcg_debug_assert(first_insn_start != db->insn_start);
+        tcg_ctx->emit_before_op = first_insn_start;
+        set_can_do_io(db, false);
+    }
+    tcg_ctx->emit_before_op = db->insn_start;
+    set_can_do_io(db, true);
+    tcg_ctx->emit_before_op = NULL;
+
     if (plugin_enabled) {
         plugin_gen_tb_end(cpu, db->num_insns);
     }
-- 
2.34.1

