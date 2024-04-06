Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC551537E2
	for <linux-cxl@vger.kernel.org>; Sat,  6 Apr 2024 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712442779; cv=none; b=BEIQ7cLih7baONiFFjZztQ2G9BAHZmFdbUTIcxyBKuro85lYyToq2mR2ogwn0YGyIGzE/tAW2UINxDr+1tnQKjOpkhqXD56YIkp6ZrA3uYrJ8CBZ8USH809lyKvQaKxjjsfAOLOlZgAId3+p3zjJ0A92oNmrhaOzJKuSnvehtZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712442779; c=relaxed/simple;
	bh=QvxbKmb5CUVVOw38x2Htt9OlPCEVUkt3r2lxEwqLNtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CO5fwDYLR0mddwyj+EI2jPWNVBj2tW+PKE2fkJ8JDrCkQmEB81/Rt29ZqU4glY2E3MP4CnqjE+ejqp+AfHf+y7M+/PUM2RnhhCAQsnPapJdKpzI7v17SzCv53TTZlGtPzJ6A7fCosqPagE2xjwTKUUO0lgA9IFG6uFbE4svuH1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FoE8HNdF; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FoE8HNdF"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c66b093b86so3291093a12.0
        for <linux-cxl@vger.kernel.org>; Sat, 06 Apr 2024 15:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712442777; x=1713047577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQc6e5RogWeg+/QqEB/0KfIIQRJeLZXWsX6Xz7y/RG8=;
        b=FoE8HNdFpMkScuFALJxOc1PAB0vcPf4I8Q/g3oAxF21bFg+eGB4ZynGRYnodpeIon/
         E9yul+rb3RNLUNY6wasKtFLuebN6U9Q0rZh8xf93zH8yrGCOSypVwP16HqlGFd5QPhxL
         RhzQEiW01dKiKpSNY8BA9moygeGpZpr/47olsP7igtjWRbHwB889hiMaIQxBJYirzTZ3
         yEZq4tPYnwt8hCPR8xakOoBG5i6LAl19UwK68cvmRr1yA6gJvG9nnlOllXiV0XqTnor3
         Xd823c9X0iA/EP4rVhfsbqO1DBlrEh0CyMgxSwau/vRz3TnSlwkWc+Ygg51QFCugahOX
         iPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712442777; x=1713047577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQc6e5RogWeg+/QqEB/0KfIIQRJeLZXWsX6Xz7y/RG8=;
        b=AV5OBDNwgGYICKxqc2PhVx2JNelib+8NuA1DtuGKrOcHID36IbVt9MYbx/dBUFnZ9g
         NRuTaExGOVRKws4sNU5uEemLmNwXvugFzj522FK6PnT2Y+WkVrcjf7DeMZ3hWwo2p0ek
         wSgNWDLVx5TYoTCfbaujl7dBxYVuUyslIdyMFPdlyCa1vYFOKxcnrINGIOpqh43aQZkp
         Hz4a1ObI1yO+DMx7Ff7/+sztf/Db/F+Cz1UOxS+kg3/NeVude8C6FFrvnOZpNPYhtn3S
         /qiYmtDNni428IxWiT8dQsnFH7D8EM3rZah/pBeqIGOlja/g4W1uKAZ+PMvY+GSKaGJP
         Ihjw==
X-Forwarded-Encrypted: i=1; AJvYcCUvpnFi/C5adgTtA202+287y+HMS+yoTtSyYWOQrCSKOC1fGstzWi45eJHRsffq6iCCUF9Oy8QYN1VBIOO9Qr1WVQ+R2gFL2d8o
X-Gm-Message-State: AOJu0Yx3OScM76amLz4ild+8bWfF9jWLjjajLoY//HDKOUhu5VrusPuE
	+7rYqwB7FEWrDB7SgwPs7xq4kVM/BdtApepKqgprkXipWtesSccPflgu+beMHTY=
X-Google-Smtp-Source: AGHT+IHvglE+20EV14TIEcEtETBS3PRrO9IVFh74Usc8OZGns7hc9vLAHRrHFRw7/hKBktR7zvRXwA==
X-Received: by 2002:a17:90a:7c43:b0:2a2:f249:6180 with SMTP id e3-20020a17090a7c4300b002a2f2496180mr8207410pjl.18.1712442777063;
        Sat, 06 Apr 2024 15:32:57 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 15:32:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Jorgen.Hansen@wdc.com,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org
Subject: [PATCH 3/9] target/arm: Use insn_start from DisasContextBase
Date: Sat,  6 Apr 2024 12:32:42 -1000
Message-Id: <20240406223248.502699-4-richard.henderson@linaro.org>
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
 target/arm/tcg/translate.h     | 12 ++++++------
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate.c     |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 93be745cf3..dc66ff2190 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -165,10 +165,10 @@ typedef struct DisasContext {
     uint8_t gm_blocksize;
     /* True if this page is guarded.  */
     bool guarded_page;
+    /* True if the current insn_start has been updated. */
+    bool insn_start_updated;
     /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
     int c15_cpar;
-    /* TCG op of the current insn_start.  */
-    TCGOp *insn_start;
     /* Offset from VNCR_EL2 when FEAT_NV2 redirects this reg to memory */
     uint32_t nv2_redirect_offset;
 } DisasContext;
@@ -276,10 +276,10 @@ static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
     syn &= ARM_INSN_START_WORD2_MASK;
     syn >>= ARM_INSN_START_WORD2_SHIFT;
 
-    /* We check and clear insn_start_idx to catch multiple updates.  */
-    assert(s->insn_start != NULL);
-    tcg_set_insn_start_param(s->insn_start, 2, syn);
-    s->insn_start = NULL;
+    /* Check for multiple updates.  */
+    assert(!s->insn_start_updated);
+    s->insn_start_updated = true;
+    tcg_set_insn_start_param(s->base.insn_start, 2, syn);
 }
 
 static inline int curr_insn_len(DisasContext *s)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 340265beb0..2666d52711 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -14179,7 +14179,7 @@ static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
         pc_arg &= ~TARGET_PAGE_MASK;
     }
     tcg_gen_insn_start(pc_arg, 0, 0);
-    dc->insn_start = tcg_last_op();
+    dc->insn_start_updated = false;
 }
 
 static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 69585e6003..dc49a8d806 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -9273,7 +9273,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
         condexec_bits = (dc->condexec_cond << 4) | (dc->condexec_mask >> 1);
     }
     tcg_gen_insn_start(pc_arg, condexec_bits, 0);
-    dc->insn_start = tcg_last_op();
+    dc->insn_start_updated = false;
 }
 
 static bool arm_check_kernelpage(DisasContext *dc)
-- 
2.34.1

