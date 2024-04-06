Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F8537E2
	for <linux-cxl@vger.kernel.org>; Sat,  6 Apr 2024 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712442776; cv=none; b=oHt/V1qzyTmsVFuq0IeZjdu4TXITQ2k9VziDSeGrtd5cNt4jLNHpjoQVspzd9qmDI5kTUpafESIIHb5kZcfBIUq9UdHXvBuzjJgNz564FV+EcfeJ7YIvyok5RNGGE5gG2G7C+khuuvNo/cB0yw974hByi/5VZJAOnL9y50uTQUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712442776; c=relaxed/simple;
	bh=7O8e4qIWktxUShNBxm8MXm81+LSMyPvkNRxcCVLTcRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RTMhlcfZFThqa+Noi6A1OR5tspuDPlYr55+ps4S8tO0aUq6ScdTj1rF2CmlUWSIUEn9t8chDDPQEpXbYH2VuGTsQ13dFAdgYiD4sHWnYPQ89BhKRGE0lUsQxVhpXkmsY44x0gOYn+vxJuk9o6b2dACfbQQ6ldN3e4eM14jOYAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pz38E56e; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pz38E56e"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so2255247a12.0
        for <linux-cxl@vger.kernel.org>; Sat, 06 Apr 2024 15:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712442774; x=1713047574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uK1v+EiguMoYRGbIEG8BvH+kU+PSbAC8gTglH1oJQN4=;
        b=Pz38E56exO7SpzOlSR30Avx8+tU6BP7xmLQaH/ewTWW1MNTXBeYAlVlw65kUOSF45j
         ujp/wfqp525q58f7qTLCt2sM+rchmmnGK577dxC1rB2FUhm2QihlxzjY7SIwXxI9UdBy
         o6n5384L4lGOon3g4osDaVwVpYbUWCgNgQ5M7yLuaET0R+CfI3n336BNVMN/tEERo8vz
         Zy3ncPHfPQkdsfoWtnd0xhSh+oQx75LvyDApq/9JFJJQS1JBIgGmmXEUm7QhNZi2zOoN
         m4LZyiXIQpsDCJwUK0+S0VPi0LwXKI/KJtL0xpmfgv9va16D1BaLdlWaZP0/Qb/lT9oq
         p4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712442774; x=1713047574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uK1v+EiguMoYRGbIEG8BvH+kU+PSbAC8gTglH1oJQN4=;
        b=OQ+HI9gJZOy9Q9dKxiPXeUKfeR86a/dc0TQikN6LBYWwlYullCY6eKOdvFJNC0YdyO
         KZI2dT7qVJnPkGiWhTYLNn3yvCfsbHDxYyzvhp1H8aRCEXYsMl27j0RujHeW1aBlknc4
         3/G4JDa4KbJwCwb6vKidcVcE0NTI5II6rmyF27uJgLXI1UwrLvUbl3NZDyR/5UsTc/Mh
         9MMMVJ3gN+/xnPAy4FEfwhRpVIt6DsT5o3vnX13iNYt4yZ6gUFP4xTU9fFLurvSoPCkX
         XLsWFxU471/LTUJO9NfCIrdwmd9K/fzW//NNwhu3zcCeTMgpmv1Cm6A7BkI4BWBBIOGA
         lDVw==
X-Forwarded-Encrypted: i=1; AJvYcCWDNfRvWqS7erNCvmRriOb+v5e40nS9ge1GFHLY7X4O309tanr/PZpLvlK5XaVRyVZf0YteqmLs3ECr+5UMkvhg/taobDKkrz9E
X-Gm-Message-State: AOJu0YywrnYSWfJVFwdA+NxjG/gxqBB1dEBaDbkvoMvf3Ku+s216IljP
	TdO5H8CVPS8icWzV0vtItZfNl7bVP3ewL91lWChQez79GQcxqZTm0dc7+AwKSOs=
X-Google-Smtp-Source: AGHT+IH4KHGnntIWZ+1epoLd26bxOo7aYk4QCzq7PsjdzeFlPnpZnPzhBgELI5mCBj3KEO86RynA+g==
X-Received: by 2002:a17:90a:f683:b0:2a4:b04b:d204 with SMTP id cl3-20020a17090af68300b002a4b04bd204mr2799489pjb.7.1712442773854;
        Sat, 06 Apr 2024 15:32:53 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 15:32:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Jorgen.Hansen@wdc.com,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/9] tcg: Add TCGContext.emit_before_op
Date: Sat,  6 Apr 2024 12:32:40 -1000
Message-Id: <20240406223248.502699-2-richard.henderson@linaro.org>
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

Allow operations to be emitted via normal expanders
into the middle of the opcode stream.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  6 ++++++
 tcg/tcg.c         | 14 ++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 451f3fec41..05a1912f8a 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -553,6 +553,12 @@ struct TCGContext {
     QTAILQ_HEAD(, TCGOp) ops, free_ops;
     QSIMPLEQ_HEAD(, TCGLabel) labels;
 
+    /*
+     * When clear, new ops are added to the tail of @ops.
+     * When set, new ops are added in front of @emit_before_op.
+     */
+    TCGOp *emit_before_op;
+
     /* Tells which temporary holds a given register.
        It does not take into account fixed registers */
     TCGTemp *reg_to_temp[TCG_TARGET_NB_REGS];
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d6670237fb..0c0bb9d169 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1521,6 +1521,7 @@ void tcg_func_start(TCGContext *s)
 
     QTAILQ_INIT(&s->ops);
     QTAILQ_INIT(&s->free_ops);
+    s->emit_before_op = NULL;
     QSIMPLEQ_INIT(&s->labels);
 
     tcg_debug_assert(s->addr_type == TCG_TYPE_I32 ||
@@ -2332,7 +2333,11 @@ static void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, TCGTemp **args)
     op->args[pi++] = (uintptr_t)info;
     tcg_debug_assert(pi == total_args);
 
-    QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
+    if (tcg_ctx->emit_before_op) {
+        QTAILQ_INSERT_BEFORE(tcg_ctx->emit_before_op, op, link);
+    } else {
+        QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
+    }
 
     tcg_debug_assert(n_extend < ARRAY_SIZE(extend_free));
     for (i = 0; i < n_extend; ++i) {
@@ -3215,7 +3220,12 @@ static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs)
 TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs)
 {
     TCGOp *op = tcg_op_alloc(opc, nargs);
-    QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
+
+    if (tcg_ctx->emit_before_op) {
+        QTAILQ_INSERT_BEFORE(tcg_ctx->emit_before_op, op, link);
+    } else {
+        QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
+    }
     return op;
 }
 
-- 
2.34.1

