Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D9A535CA
	for <linux-cxl@vger.kernel.org>; Sat,  6 Apr 2024 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712442784; cv=none; b=llHXWsqYgfTvL1HQd+lpkCpZWNyvl0xCjMfO8TvH0JtBELVpOiqG6I0HKvXe3Uka9OILxgqd8gZmcqQAMvHlG0cccVpWrP5+GizVCRT4A3X+WiI6bEkbyh2xbhBl0E6oDGoEex25IL866q7TjXYZvYATxeL9XWbE/DSgrL+pVT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712442784; c=relaxed/simple;
	bh=soviEJVwtdu4iAodCmAk18R8aHJtKM/9Ebhv8emqJg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n00+L9wGVEdAncwuRUj1NjqZxHbPyCfBsEnNIaMBQN8QRHy7UTjWKihCmS5omlssvQXbrPqucndETXLjjqzuXXAOzjnsUcZ3c2I4MRO7doilv3EJBOfOmfzPBUfp4kFOCn7xYTyQ2A9pi9p+oaN6UxBdCcNoGDsk/wS4oU4+A+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ijjhf0Ma; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ijjhf0Ma"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aa27dba8a1so175022eaf.0
        for <linux-cxl@vger.kernel.org>; Sat, 06 Apr 2024 15:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712442782; x=1713047582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUzNX9wVB6qbDLCwM/K8CjqXVmj1FUosoEHWX0Cy0rY=;
        b=Ijjhf0MaadqK4I1fQHceTsOKiYzT5Gv059mtmh6Cikos04eqSEmKACpx3hNaGgiRrp
         +lXYfQJaDNi/TAj6nee7tWN0hOgxacfjsPjdPlNV/J3IeX7qkmuFEqbUS8r+kGOZjdF7
         ESPyzDLbVMz6pmcsWEpN5lS8MpcmOMprArWHERzx8zFnT4GBsr+M8xZMIAFYa316bVnK
         Oi+iDqsKH4MBDuO3QUGxuuT0SEB0s7czWC6WNPnXSLwq3BcEz+JcMR1APou2ZH+URbhQ
         7pztjP5keiEgFjlcPJuUheDY0tUk6/p98b/PjHvlh+Z8V00tDH8q01IIq9wockwJ9pet
         BbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712442782; x=1713047582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUzNX9wVB6qbDLCwM/K8CjqXVmj1FUosoEHWX0Cy0rY=;
        b=qe5HoHidgTztKYLDakPl1Hsh2RxFWc6SIhGJJbirRFPVRmi56UtUMmKT3UuXP8duIe
         CanVSUEBQr51K6F5AsGa/2ZUiHZq4jDsW5U7R5dRiJHhUSVnmfmYVZ02ZjdehUs1A/NQ
         W1tblyyphnAe+MMQ1l7HHrZO+1Wmi/wt7GG9CzapWZTyv2hHHxBK9XDIPl58CL6M2r5r
         climZVK3U/iqIYgItRamNIQ3u4PXdYiZJtaMqx0ug7QSfLOTDCLfEAonJKA+sH1v2p9K
         CgcMS2c82Z4aoks1q+tWe7GkO8wEFtlGcFux/qPaX7UxOjlXLT76kZ3Lr9c+v4VYb4v9
         qCZg==
X-Forwarded-Encrypted: i=1; AJvYcCX1/Avn90XzMU1eCjnCsgEtYotlOO6ajh8fnejyqAeSYO8oVdHPm9AHTJmZFnJaPfC/gEkKOzpfHGe2Ssxg+XQzcy+uzhKaAkae
X-Gm-Message-State: AOJu0YwnZD9A7KpO/Ck8pxtOxRkT6tMtaf4c53x9L9jFNwcTUfvyuWcj
	SGMpWbkEIKuCF9b0wj7t+Qu57ZfjQT1eynMiIG6NPOUpscihX9ghhO+rNBMwSmA=
X-Google-Smtp-Source: AGHT+IHo2yLEETdAst9o5o1IGSNTCzGyLb/wyHFihxgL403DK8gVFtTMbMP8D6raA8o6AFRUJW/UPg==
X-Received: by 2002:a05:6358:7a8e:b0:17c:263a:5b8e with SMTP id f14-20020a0563587a8e00b0017c263a5b8emr6804018rwg.14.1712442782138;
        Sat, 06 Apr 2024 15:33:02 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 15:33:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Jorgen.Hansen@wdc.com,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org
Subject: [PATCH 6/9] target/microblaze: Use insn_start from DisasContextBase
Date: Sat,  6 Apr 2024 12:32:45 -1000
Message-Id: <20240406223248.502699-7-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4e52ef32db..fc451befae 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -62,9 +62,6 @@ typedef struct DisasContext {
     DisasContextBase base;
     const MicroBlazeCPUConfig *cfg;
 
-    /* TCG op of the current insn_start.  */
-    TCGOp *insn_start;
-
     TCGv_i32 r0;
     bool r0_set;
 
@@ -699,14 +696,14 @@ static TCGv compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
 static void record_unaligned_ess(DisasContext *dc, int rd,
                                  MemOp size, bool store)
 {
-    uint32_t iflags = tcg_get_insn_start_param(dc->insn_start, 1);
+    uint32_t iflags = tcg_get_insn_start_param(dc->base.insn_start, 1);
 
     iflags |= ESR_ESS_FLAG;
     iflags |= rd << 5;
     iflags |= store * ESR_S;
     iflags |= (size == MO_32) * ESR_W;
 
-    tcg_set_insn_start_param(dc->insn_start, 1, iflags);
+    tcg_set_insn_start_param(dc->base.insn_start, 1, iflags);
 }
 #endif
 
@@ -1624,7 +1621,6 @@ static void mb_tr_insn_start(DisasContextBase *dcb, CPUState *cs)
     DisasContext *dc = container_of(dcb, DisasContext, base);
 
     tcg_gen_insn_start(dc->base.pc_next, dc->tb_flags & ~MSR_TB_MASK);
-    dc->insn_start = tcg_last_op();
 }
 
 static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
-- 
2.34.1

