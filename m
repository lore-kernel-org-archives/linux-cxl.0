Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58913535CA
	for <linux-cxl@vger.kernel.org>; Sat,  6 Apr 2024 22:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712442780; cv=none; b=NYSVft5yAG/rz0VuOW1/3J+OLrfkWV+9cTaS6SXQho5UIcUTE11vZBTy4NAYbPFEUAzSNMGbIsb8TO4K83WFL/mwyzWmTcSo0fTOnneazfUaR1oNohZ5TzYC4AhO211G+SPTAUcgkl465Rbi2tE9KwQKBdVUFtEcikDkcqWHnec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712442780; c=relaxed/simple;
	bh=nd6ehPHRJEt87xUJse+QPnLlfZ6m+0p5NUnTg4HCP70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2g3D+mFr6wYLe2rB1csafYJtN0Q3YJYynxXNkJFjd/VUY26NRUPhRXAE8iZP/QAlB+8Wfv/tHLGbhTBnSBtJrC37aXV8e156q1LuIhJ31sqIzHXicp4mY3XlUGbGs6iipEH1E90h7YAcVDEUk3YXoONcWnFDEnzpbpsOLZtxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DHLwdc0i; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DHLwdc0i"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e2b1cd446fso23070135ad.3
        for <linux-cxl@vger.kernel.org>; Sat, 06 Apr 2024 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712442778; x=1713047578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+n5c7Yxg8Vn5seTMJXxw9ptGbTW4ezPBKl3xezctxZM=;
        b=DHLwdc0ihCT/GgR4ryt+P1Es//bc9wx4gVxF87qOzGH4lO7EKYcgrDwkH3raAhmO35
         sGyrjpGtuwsYIYKY90+aVX0srvCluQJb+BLRox9THez/HcnBXmJfSbneCptJ7JtWCD+Q
         vuv/ulGaURqRLK0JN5NbRdc6wYgBusf3gL5re/NX9+80n+gc7Jl3vx+xteKvH1O2Y603
         CQpZPRsFNWdPlNDl9E9dngNIpLDCHbNDNMfv+E3CJx4XPm/OX5akKI9d/bgj45BYkXBs
         x4FryUuc0lICWz82lv25PYf+fvm/1Kbcd7sY0Vv7cs+PTHMc5X15/IHUuf8JnVJ/J5ao
         CN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712442778; x=1713047578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+n5c7Yxg8Vn5seTMJXxw9ptGbTW4ezPBKl3xezctxZM=;
        b=DKiWcIRtfoVAeR4zj1wLqFp6WTIwPatlekWOHe9r1xeH4J02iG6iDPhVAk1V7ytNin
         +gBYNbFQil6WAkvR90TCnUBeRgBqR49nGYHTPnS+S5Vr9oFThP/fDwT70FPWFMdk22wl
         AS78ZuOzh6Thufw4CfSjnoBxElcX/xKOqqs2Gz/Vnm3/I1Cyl6x9zbF5oO5K+1Qg2hCt
         AJ1jBLeNjoARZU3FkAXG20rOm/Pi0jwQAXi9ksiBP8jD91UEPzhmE53sGRAk1yz5k5zF
         VkcqZcXwUagopsDQkrkAhAtupPqroW271tH14F3qtkentZcAJy3n/2S3S8GT1t1O9TjZ
         5e3w==
X-Forwarded-Encrypted: i=1; AJvYcCW6a7GjI4mrWACyHy5urKIZ5dFadRgI8EPAZp2djcwniEF0s2scerZKaYl2mBHTqol+kKsr4ReoIH1GFbJaZ8WoK4ru5n3Z0L86
X-Gm-Message-State: AOJu0YzRtT7HiyGk9rrbeq6UCGhKVUxGFM44YRZaQsgz3qk7pEthMP/q
	Svam96lW0P0iaPpRA3S4rQChLAi97IZ/zNA3BbX2QgLKtPCC+aCkJc5XRiH8mxg=
X-Google-Smtp-Source: AGHT+IECsFtB+N+jqMU1g/THG5NcNWkWpYs1ZikTHMVxfD9Jpit6UqTKaKaRMDwwebgxM6ymSwRFeQ==
X-Received: by 2002:a17:902:efce:b0:1e0:983c:d686 with SMTP id ja14-20020a170902efce00b001e0983cd686mr4702554plb.20.1712442778661;
        Sat, 06 Apr 2024 15:32:58 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 15:32:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Jorgen.Hansen@wdc.com,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org
Subject: [PATCH 4/9] target/hppa: Use insn_start from DisasContextBase
Date: Sat,  6 Apr 2024 12:32:43 -1000
Message-Id: <20240406223248.502699-5-richard.henderson@linaro.org>
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
 target/hppa/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8a1a8bc3aa..42fa480950 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -44,7 +44,6 @@ typedef struct DisasCond {
 typedef struct DisasContext {
     DisasContextBase base;
     CPUState *cs;
-    TCGOp *insn_start;
 
     uint64_t iaoq_f;
     uint64_t iaoq_b;
@@ -62,6 +61,7 @@ typedef struct DisasContext {
     int privilege;
     bool psw_n_nonzero;
     bool is_pa20;
+    bool insn_start_updated;
 
 #ifdef CONFIG_USER_ONLY
     MemOp unalign;
@@ -300,9 +300,9 @@ void hppa_translate_init(void)
 
 static void set_insn_breg(DisasContext *ctx, int breg)
 {
-    assert(ctx->insn_start != NULL);
-    tcg_set_insn_start_param(ctx->insn_start, 2, breg);
-    ctx->insn_start = NULL;
+    assert(!ctx->insn_start_updated);
+    ctx->insn_start_updated = true;
+    tcg_set_insn_start_param(ctx->base.insn_start, 2, breg);
 }
 
 static DisasCond cond_make_f(void)
@@ -4694,7 +4694,7 @@ static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     tcg_gen_insn_start(ctx->iaoq_f, ctx->iaoq_b, 0);
-    ctx->insn_start = tcg_last_op();
+    ctx->insn_start_updated = false;
 }
 
 static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
-- 
2.34.1

