Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15815535CA
	for <linux-cxl@vger.kernel.org>; Sat,  6 Apr 2024 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712442777; cv=none; b=Bpyesmoxc/OaLLkF3egCsJFPCLGPkybmE99PNHyfXPS596cM27aRPNp4B4D8uArTiko9u7K6xfHfpmEfDI80BKZOYqbvf1xF+F9Zr2xQyI5zgLQDG9I/ndndhkF8aUQW8eC7ERctLXv3TLsVkKTWf/t8+xfrmENI2paSvOlCKBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712442777; c=relaxed/simple;
	bh=Ab3pvzIJLcmWEoSr0gqXRZTTP0Pryo5Z38zjtE3YviA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uzZzUOQuGBknPRjhKK1dODdub18nZ8pQTrmoN9wurOIc+YNapjM4qMV10AdJHg4mvulzJysaRxId0xxXluWia4/9Oli/fP1IaO0Do30iTgx0V18oVE9/qn0i3Q0IAhlBrb+N4wW7S92P2Z4wEi4U27/WJJvgVmT3Mof2W+yVJo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gXJ78Vob; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXJ78Vob"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a4bdef3d8eso289952a91.1
        for <linux-cxl@vger.kernel.org>; Sat, 06 Apr 2024 15:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712442775; x=1713047575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2L2/prB0ux2ctNxoqiiUKt6ospzwwfXyvGcwqxEj/VU=;
        b=gXJ78Vobph/mgVzu/8u/5J7bLZsNggJtK8GZsdyHNsU1G0PbJxD6Gr6X+fDNX3GC/7
         MhHVmKipVtb1GldP+/hRSlbkh3WtLTBP8umHn1NI4KHbBkNot6BBxChVsCkInIew2nls
         81FiiOu3tQ301Fo9TI9rlmP9IRgILnIY5UM7IBhNSQWAth0fvHx77KOgN3kqBJqk4JiY
         K3xBRVHoobu/RSL6teMqmbvztoYNP8u3xyDGgrOMA2ofrJW+AF1xC9DK+d8rXaCuMWnT
         txbLfhrDGZzzA7k80LhkBiLLjhiFL3o2dKTs94N7L+LIKdBRGTDKkmuRZCr98dCY++JX
         6wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712442775; x=1713047575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2L2/prB0ux2ctNxoqiiUKt6ospzwwfXyvGcwqxEj/VU=;
        b=nNC+DZ3+nJeEQlE+m7rcUy0V47y07Lcg9stIDWEoN1ky/mS1fG6jR8WI+5qCjdOF3m
         mWAGnD0N3RoSjOlF8tJMOLPuMDYr/XtWk54UEr6uT2i8IOsYw+WmnopnGQiJy3n6QOmA
         +HEiMktjAs+4NXSQl3EdPdrTvK/7ICwRuZOIXRVn6lYoPRltSKwTLUAik87KRBzDVHgB
         4+Og5+pyK9bJEZX2IQXXPgFwKFFTOpZWJq7FNuFYyXQXKuzjEXPYmEs5plhwF893tpUv
         5tzUqE3OvopxMZHt/xSY4eidM6tRPZmaQsHqEt+ko+YkfGrVdmNnBLAEExhCP52kjYbt
         PPRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4Bnf7HLlNRZjxlicmJF2uvMb5l0NVwSDXddHH1uY8x6AScj+2XXdrk6ih3Gi1+8CiBIqEOIgpS8cD/HPkMmElJsQXsnIdxpy0
X-Gm-Message-State: AOJu0YwHXCW7CY554OglTqN/oBh0Mkb2som+VSvWxfH2Ev/YBIM8BNH9
	vyDo+kwgLhdQWDa2lTxkhUmJwxFn6DktCbvw5Jd2Quotc22OKbLdrg1I6+6T/QDsY+RsscC0Fco
	2
X-Google-Smtp-Source: AGHT+IGDChcSyXOe/krl7Jt6OrrMbxdy1DnpqVL6nLsJh1dU/15hj84F26u8LD5cGAiYd07pEisvFA==
X-Received: by 2002:a17:90a:df10:b0:2a2:9b12:da04 with SMTP id gp16-20020a17090adf1000b002a29b12da04mr3882477pjb.3.1712442775469;
        Sat, 06 Apr 2024 15:32:55 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 15:32:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Jorgen.Hansen@wdc.com,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org
Subject: [PATCH 2/9] accel/tcg: Add insn_start to DisasContextBase
Date: Sat,  6 Apr 2024 12:32:41 -1000
Message-Id: <20240406223248.502699-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240406223248.502699-1-richard.henderson@linaro.org>
References: <20240406223248.502699-1-richard.henderson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is currently target-specific for many; begin making it
target independent.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 3 +++
 accel/tcg/translator.c    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 51624feb10..ceaeca8c91 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -74,6 +74,8 @@ typedef enum DisasJumpType {
  * @singlestep_enabled: "Hardware" single stepping enabled.
  * @saved_can_do_io: Known value of cpu->neg.can_do_io, or -1 for unknown.
  * @plugin_enabled: TCG plugin enabled in this TB.
+ * @insn_start: The last op emitted by the insn_start hook,
+ *              which is expected to be INDEX_op_insn_start.
  *
  * Architecture-agnostic disassembly context.
  */
@@ -87,6 +89,7 @@ typedef struct DisasContextBase {
     bool singlestep_enabled;
     int8_t saved_can_do_io;
     bool plugin_enabled;
+    struct TCGOp *insn_start;
     void *host_addr[2];
 } DisasContextBase;
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 38c34009a5..ae61c154c2 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -140,6 +140,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->max_insns = *max_insns;
     db->singlestep_enabled = cflags & CF_SINGLE_STEP;
     db->saved_can_do_io = -1;
+    db->insn_start = NULL;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
 
@@ -157,6 +158,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     while (true) {
         *max_insns = ++db->num_insns;
         ops->insn_start(db, cpu);
+        db->insn_start = tcg_last_op();
         tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
         if (plugin_enabled) {
-- 
2.34.1

