Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6492535CA
	for <linux-cxl@vger.kernel.org>; Sat,  6 Apr 2024 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712442787; cv=none; b=a0iVg9S1hGv2cmDZQioQm2+uLiCn5PZoNxnawLJd6cV4VIskBmKMSVQ20tzMMt3QU2fXSRzn1fCa6qgRApuY95371HRdeA0W3p+yRco9G+5bZpvSje+kvp3bQwmihRn9KmdWlZkqUr3QJghsZ53Z24/VC/SkejMGzmyyWh1N2HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712442787; c=relaxed/simple;
	bh=sgPsU5m713ceL+E367RKdOkiYcnSShbY/D0jSyD8IH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rGExvhjYqzwlW8rPcx4VQ0qq/WxRpA7p3a2MM+OIvQgoWDVUY0wFBYIZgFcbCfocc8G1oUZsc0zP0t1gmCQgVgmcMF/E6a3fugPGnHv5K6Qb7wm2V6eG2m8sFhYKv5I5mbszjuK0IOnQViYHvBoevlcFImqsbYTmcBfe97y8VK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Aje5gP0R; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aje5gP0R"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a2474f2595so2671143a91.1
        for <linux-cxl@vger.kernel.org>; Sat, 06 Apr 2024 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712442785; x=1713047585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NX9Ag++TnmEtIL49KdN8wfC5CW3UFh53IC9I9+TmU/s=;
        b=Aje5gP0RRBqBCkeudo5YL7X3kP7DQvdzFZUkXOdoCtkFjhQB4K8t+q8UIQiooWA0FN
         PGmzFLep+oo/7irRT8S4czkgVGfUXQj3K8rQX6FzOglFd0eHgVm9JZ+0/INnNkdq4I7d
         3Ye6HFWoWZsTYaA+CYyQbDKwuHjqlmAiE4cpd4x1yQIqxmIocjiyf3vkM0rGsa2oufEG
         +qlVrFsrVK6wHhtyvfCey9d6fwhlG4BjkzOYjuamlzehUirWVicgxhAUWWp8V3pg0so4
         pJKrPWIXnPePmWvPFuSPMbTbNXlG79hqS0lYUJgvb1bU3TUPWHa0sPcGjvBT51j6Bzuc
         OMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712442785; x=1713047585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NX9Ag++TnmEtIL49KdN8wfC5CW3UFh53IC9I9+TmU/s=;
        b=xGEk8ixF9bzG172Pis4/TtwObaYa7mVsMdU8IRCC9rEqefb7qPRum7iXgB1rcz75y8
         +b9+woEzBD5F59V44mGx7TGta6UdT04dLoSlk5WjP1Z/IGqZIXmrMNbPeVBGfKCi++MO
         hEzQNnp8g3xnNQbYkLfvj3K0FGgDl4vp42LgSDMSPIUslxVV6krmsqflg2/e/WPeepqh
         9zhIsd+0NIHqCrxRB6ztuetwCbxVxpHB971ibAyUu2C1Otg1peNxuU2wSfVLulC7UmAU
         xdU1sLf8KISdrAz/QbkxNALF5L8W6IatRrNw5LjhBCQE34PtGiwJM1sB5upFZtJLf/JW
         BDXw==
X-Forwarded-Encrypted: i=1; AJvYcCWDRX6rDQBafkF/JBVV4b29usC19Vi+WSvFPgYG32PaFiVUoCNBPYt/eYn6pO+62Csominb+iiSWkjn7gKzh9AdQApmMFU20bI0
X-Gm-Message-State: AOJu0YwpmmGWhwTuz9mea9r4JCbnekpfEz0GPNKNzgZmC6eAUF5S5dla
	LU7PVVN5EHGY99Y5ss9WgrQo/qg/9Bj65egkDOui/jeRCdsDZHtakrY/wXbo+R2nwdFJE2rgZcG
	q
X-Google-Smtp-Source: AGHT+IHYOBkC/tVr9XQnUsLDf4qmmqdSuaXzPwppauLJh3EXu8d8scHM2yoGpW1A1RnyYZeBvN7EqQ==
X-Received: by 2002:a17:90a:eb0f:b0:2a2:53a5:7559 with SMTP id j15-20020a17090aeb0f00b002a253a57559mr4607335pjz.38.1712442785243;
        Sat, 06 Apr 2024 15:33:05 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
        by smtp.gmail.com with ESMTPSA id f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 15:33:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Jorgen.Hansen@wdc.com,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org
Subject: [PATCH 8/9] target/s390x: Use insn_start from DisasContextBase
Date: Sat,  6 Apr 2024 12:32:47 -1000
Message-Id: <20240406223248.502699-9-richard.henderson@linaro.org>
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
 target/s390x/tcg/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 57b7db1ee9..90a74ee795 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -141,7 +141,6 @@ struct DisasFields {
 struct DisasContext {
     DisasContextBase base;
     const DisasInsn *insn;
-    TCGOp *insn_start;
     DisasFields fields;
     uint64_t ex_value;
     /*
@@ -6314,7 +6313,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     insn = extract_insn(env, s);
 
     /* Update insn_start now that we know the ILEN.  */
-    tcg_set_insn_start_param(s->insn_start, 2, s->ilen);
+    tcg_set_insn_start_param(s->base.insn_start, 2, s->ilen);
 
     /* Not found means unimplemented/illegal opcode.  */
     if (insn == NULL) {
@@ -6468,7 +6467,6 @@ static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 
     /* Delay the set of ilen until we've read the insn. */
     tcg_gen_insn_start(dc->base.pc_next, dc->cc_op, 0);
-    dc->insn_start = tcg_last_op();
 }
 
 static target_ulong get_next_pc(CPUS390XState *env, DisasContext *s,
-- 
2.34.1

