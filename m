Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3F1535CA
	for <linux-cxl@vger.kernel.org>; Sat,  6 Apr 2024 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712442782; cv=none; b=poAvJwBaLQwDqYlY2z2mo18bbrV/1tqC+oZ84DtVbALzA87Xw6Ste55j8WdisHiYqBmW0QxmJYSMRH0DMquoAB7JYo+CNx2GONAse6DktxGdr2Enaxa/p6+vhYBaC5hkcBxWvqx/g863WKq8pONU8ZxYrp7D/5sVOUCudXOcb18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712442782; c=relaxed/simple;
	bh=LWhPdg2w9OB46nxjmVApLMxCIYTtDNGxAat3gw0euZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sUsf0OMj5n6M7L+gthtdPVbGuJcmwAeWMcekxQn8pQMohco3WUuc6MriYbegwsErYxaSGjO5AeJOFK9FC+2Qk+BdrCXshTYWQfiyl1Bokv5/z2y7NcuQqD7UzYdR6o7pm5+GEZGD0bwD5lAcpIS+S+CDZyHFfx+3V7BNA/u/Mcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xM6zRBxc; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xM6zRBxc"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso2696016a12.0
        for <linux-cxl@vger.kernel.org>; Sat, 06 Apr 2024 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712442780; x=1713047580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huPDBBhYc/g4B/wyxsCiRcrglSPPFxdW6/Rpm03HcSo=;
        b=xM6zRBxcBIKlnQURYGzfA9Wv9VVlUmt9tyPqJbZYQU/qbYDZL1RBl54GqkLUX7TX7X
         bDmBIdqkklzvd+1YdimeCZ9OMfGWufcq1axQW7NUSEOZJVVly/Eq5H43PL0x1pweT2bJ
         cDUFk7XzMsIdvn1gBVsqjGlTgn3KWAdraO9gBgp1c6LLueZDEmLWI86wzhIZ+jBekR9i
         jPDCNK/KxL1Y/oqVLopnkhld1JnZsgzv+xQ0cq0Cq4n667eMJ8uTHdiQX71KNeENCEpg
         Vg2lxAU1zXTet+oeoF1pC18x/cBlLymID/0ZvYD0Rt4ApaJoivMdlFu04YTW2WgR9e5W
         j/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712442780; x=1713047580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huPDBBhYc/g4B/wyxsCiRcrglSPPFxdW6/Rpm03HcSo=;
        b=RhPFCVjkVZ7QFPerL7dgZ3S6T12GHDcPsz7VeW5TFbhi10HEF0vGNeIif7FRdN00os
         rZGmVX8AZQ4IwibynPSGROf/RLbHVeZ7O+R1qlk+AU0meF5GQg56s0XqbCVuLQ7zfHN4
         POASa5f0HwWvg3CI4WbLA6bnUQPjhQyVKs56k010T1sf8V3xtLhYgu7rhZNwvsTlv+8X
         vkBqzg3pmwP9iud4ecNBf2P2N6oGVlUMa7WSRs8d1DjHX6POXpgQ9IdD9TLwf0znVyU9
         Wtct81yKZg2+JD25lupvbDfA5JPWJwj7VwBAAzNLIvM/uotU3+4itAxLZ/0w34XGw5Xt
         aNtw==
X-Forwarded-Encrypted: i=1; AJvYcCX1iyDdFk2P078Yk0/YBoxCBR8zRoyIB1emqWDVI8MvMqQsCWSZqxSExLlZLnEMSEK12mZAvXA3yyOZCC/WN7TJ/FV17J298IXW
X-Gm-Message-State: AOJu0YyBXq0t3WdQlqOVFoHqQBmdWH1t5O5xVz3AECrlu6qNWSxU7AG1
	C+4M9W9ub7NGS92BgankmOc7K3DDuOF2SOGCMBqmzcPqu6/CvdyShvXRYng5P6E=
X-Google-Smtp-Source: AGHT+IGEa0Av52jCbBtMbWWy9iMQU8BOTXVPB447WkmKSEkAq9y1mG0gRgVU8ut5HYzGH/9FPhpsNw==
X-Received: by 2002:a05:6a20:5518:b0:1a7:5b43:326d with SMTP id ko24-20020a056a20551800b001a75b43326dmr426867pzb.22.1712442780564;
        Sat, 06 Apr 2024 15:33:00 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 15:33:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Jorgen.Hansen@wdc.com,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org
Subject: [PATCH 5/9] target/i386: Preserve DisasContextBase.insn_start across rewind
Date: Sat,  6 Apr 2024 12:32:44 -1000
Message-Id: <20240406223248.502699-6-richard.henderson@linaro.org>
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

When aborting translation of the current insn, restore the
previous value of insn_start.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 07f642dc9e..76a42c679c 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -139,6 +139,7 @@ typedef struct DisasContext {
     TCGv_i64 tmp1_i64;
 
     sigjmp_buf jmpbuf;
+    TCGOp *prev_insn_start;
     TCGOp *prev_insn_end;
 } DisasContext;
 
@@ -3123,6 +3124,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         /* END TODO */
         s->base.num_insns--;
         tcg_remove_ops_after(s->prev_insn_end);
+        s->base.insn_start = s->prev_insn_start;
         s->base.is_jmp = DISAS_TOO_MANY;
         return false;
     default:
@@ -6995,6 +6997,7 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     target_ulong pc_arg = dc->base.pc_next;
 
+    dc->prev_insn_start = dc->base.insn_start;
     dc->prev_insn_end = tcg_last_op();
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
-- 
2.34.1

