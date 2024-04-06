Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C92537E2
	for <linux-cxl@vger.kernel.org>; Sat,  6 Apr 2024 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712442785; cv=none; b=Ecji/QPWWQ/Y4fVm4HwssJMbFNJd8Dt5jg60JGQCkNuCuIIIs9ZfNhQgiGI7WRVublyJ6kXGdod/oJMcYDRXinXWZdq7FxmnqlGNfqf9TMzcv/UrKa06d8LdyI0gaCxfGcPeTKEv1Wltnx8Wz8sdowqaypSgcjyaXBBcN0K1C4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712442785; c=relaxed/simple;
	bh=tBK6NnKKzlfSmrmW2pYYzLKTYkE5AHE2QGy/IvfM/34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J7hLbU4Dqjt/BFruN8MxOeaGiUQOkf31EObT12IiRcIkeuEmjkRAOfjKCnI3nSnPjWAElleYa+Zqv7vE1s3MKM1UE2wa7Foq+qREkiDFWABw9EZVUbN8kDOsmJwd8/4SuJqHbZzVEqXy2aAVMpzReDas96qcbHOuu/5QatpA+p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eRwK0EjH; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eRwK0EjH"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2629335a12.3
        for <linux-cxl@vger.kernel.org>; Sat, 06 Apr 2024 15:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712442783; x=1713047583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EK613jOMt0q5YKINPHaRaY+PjrWQT7TxkM34vbcqwA=;
        b=eRwK0EjHZERaY2yDCO3QGDPwWsZTaw/Q23Vba7CPChrICFBTqJF+FiLcLKvRsIVQMZ
         fiuztMGwCwPI/iMtwl2OkrqsqLW5TZwOq/koBieZfUrtjMqkr1TqMLNz6D7b+yS349E2
         u1wtxMaV/kCqS0fYfZITp5YFkigX3rvv5fIQp8AoXGEFOW0vc5/8oDGu8+1WP/yTSWGv
         YdMPWnABlmdIYgybjtLOHQ3AHgBFW9ZZB0LLeofiLXmQbdUKY7QPlOW/05m9k+JR+cBY
         1dig6q1JXhuBB5Vb+fysf9dXptdJIXQ2pTV0wEdtt5Uuh+U9DGMU1bh6NfH4+51sd/Oi
         IeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712442783; x=1713047583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EK613jOMt0q5YKINPHaRaY+PjrWQT7TxkM34vbcqwA=;
        b=mlgz5euU+P2jYIIwF5iCxTX2oPbqkQ0imNR+XgadE/b9iFOuVu3ZH/mO0byXTb/IdW
         5KEmRdUW5i0jFoer4ciss/0kjq4eDoue8LcAnK70hRIT7CvO6lZg0HlL0eHnB/AA0mB8
         mmslJQyGMyhLSaSXl3sayANIh961dBOAmQk+Uz289kv3nZGV1ucmgu8KqvILldRZMjTP
         AHMouanwguM38QfmGUGP6mQkJvnd6nXSRR/jRE3QbMwg04JOPwWiHuVJ3zXgU8sKvnag
         QNBi3DdVJZqdy5mbBMMcPx7PJSqDvUZUgc//V9Qgb7FdKOW+BuYCDi3ZQ4JtfK4s8S1t
         VSuA==
X-Forwarded-Encrypted: i=1; AJvYcCVSbFg6urdwhnWQdh1lxpRzq/cnEu/kkM05c3QbmsNSB1FT9Nmu3+QIAfMHWnJ7P85hG/3W5ODVtQKSQtRbtM7DVtlQpB1lioR+
X-Gm-Message-State: AOJu0YwpjG1QmpM/Ue3SeSkhrsaWoD6Rny8E9drg1HetColC3ssDPHyL
	F/hNbCWUvijwwRhHJx53TbRxr4Q2xv866I8fi0O0/XTqLBgKmpbo3iszpitAchg=
X-Google-Smtp-Source: AGHT+IGy+KLMAwHUSM52vBzPht35ASNrL/VNKIbtrWp2B0kUGRZYRnvr8HGuhMxp9ffDQHEtdbUDuw==
X-Received: by 2002:a05:6a21:8182:b0:1a7:5706:9b96 with SMTP id pd2-20020a056a21818200b001a757069b96mr966857pzb.38.1712442783698;
        Sat, 06 Apr 2024 15:33:03 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 15:33:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Jorgen.Hansen@wdc.com,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org
Subject: [PATCH 7/9] target/riscv: Use insn_start from DisasContextBase
Date: Sat,  6 Apr 2024 12:32:46 -1000
Message-Id: <20240406223248.502699-8-richard.henderson@linaro.org>
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

To keep the multiple update check, replace insn_start
with insn_start_updated.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/translate.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9d57089fcc..9ff09ebdb6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -115,8 +115,7 @@ typedef struct DisasContext {
     bool itrigger;
     /* FRM is known to contain a valid value. */
     bool frm_valid;
-    /* TCG of the current insn_start */
-    TCGOp *insn_start;
+    bool insn_start_updated;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -207,9 +206,9 @@ static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
 
 static void decode_save_opc(DisasContext *ctx)
 {
-    assert(ctx->insn_start != NULL);
-    tcg_set_insn_start_param(ctx->insn_start, 1, ctx->opcode);
-    ctx->insn_start = NULL;
+    assert(!ctx->insn_start_updated);
+    ctx->insn_start_updated = true;
+    tcg_set_insn_start_param(ctx->base.insn_start, 1, ctx->opcode);
 }
 
 static void gen_pc_plus_diff(TCGv target, DisasContext *ctx,
@@ -1224,7 +1223,7 @@ static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     tcg_gen_insn_start(pc_next, 0);
-    ctx->insn_start = tcg_last_op();
+    ctx->insn_start_updated = false;
 }
 
 static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.34.1

