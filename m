Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F822579E
	for <linux-cxl@vger.kernel.org>; Wed,  3 Dec 2025 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764794166; cv=none; b=VCe9uIVn/twssDVrwHlmMOfB2ql7cYuGpwLAqsa1DBRWZMQR5ujJOmnChcpl8otqnKfQb+gIaOtO1SNCTLuau+GTfAP2kxtHC6BKwzA/rF7QqZtCUk4QgLvVQlxbY0pJQ+0EJajSPbb/FJT67djB7Qk2KZkLVl9yANuLB3vIv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764794166; c=relaxed/simple;
	bh=vNRHTH6IlgE1C+8S1DZbESIAHNLQ8mzoHmpCXHwo9Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJYfalJe/v8fVQoivptHoSOZmbYPw8/c4z8U4icyTaUDqsBJXkHCgqto6OEDQTEd+3BiNdJo5xiEtVryuidgukfUjkZGTpLtzKv5NUH4goXBQaqNc6dIdEj040pJ6UTB+n06zvOyCU71e37Tb6oI5QibQkDPnYXb8VeBaYZOpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JC1yRrqK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC1yRrqK"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso138553b3a.3
        for <linux-cxl@vger.kernel.org>; Wed, 03 Dec 2025 12:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764794164; x=1765398964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mi3dOymvwDTayuobG0tKTNeMdRHkWQPsfuoVp7xk9wI=;
        b=JC1yRrqKi0gWGN7EvlPQ5SAD5tr/cdtKHy1KP7F382knw9yokCrqvAXrNiPMpn3orD
         TyzvWLYvapG7Hq1lxsoB9ZKfZRxXaE3pdyKsS94Ssk8dMZwW53JOjgak6QsJKK4nSjdn
         0DhHwzZlHP2tgpYVwHClglJN26er6A2lbspcZDpPFQqGjtHNcM7UzLp516qKMdInzzyq
         AIzAe4M/TWYDR326IxTZUOP3+ov5Gps/bRc7HVekVhSM14tqFAlVkabjWcpnp2bhVm2X
         YAGUFspxJp5VmdgVVKl8V5TC125bewFFxrF80OiDiVuBZEZ1i+CENPpaN3L+6kggzf7Y
         /Kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764794164; x=1765398964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mi3dOymvwDTayuobG0tKTNeMdRHkWQPsfuoVp7xk9wI=;
        b=tW68ZbsOS48fbpgdbrl/FtwwqFbFFHQkBzNCg8W6bDTf6eeFkLC4mJe8y+ByejqiEK
         KmH5Uo1MsbzFxQF8UNtgoEtQDSqkZj3irV87ZMoiP+WcMxG30Ec5BI722dVZxpA4R3uK
         6/7UVKviWddZPlDahTr7rBR8PV7e0Vr2kDQEUou6hoJSJjyXLShTDyv+K0eFojY5561B
         EpOtf8jhVVbGdGIuJ9CkHbeJ8SAEmBzrcX8ciqXuzJWyrtdnYKqoPsFgphuyV2uor9ci
         g8PGZaoPjunwu5e+rQjpiaH6dptk04CgyGEuDIRhkATrn7WBOCPGTcfWZ5Cey7OGnnnm
         V3hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh1MhMvLv+bEwafh4jh38QF4GR9Ahfsxc394dpVJm30vUXfuwQaX35PY7CcbAO3LZ1CzjWc5J9gaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynSOk03uLN+BqIwM1crTjz7P1VOdtm87SZiVxjILqWkkDifKtz
	Zu2qUahOokAAPVEVXxORBJNNvMKO2DKCTr4jLq01rr1iPAho+Sj+qLU5
X-Gm-Gg: ASbGncsHOWpPWvr+A/zVkJSLig/W7FVEAxtvqmSxlqTz0vbNWbjx07fUphr+2UPNgem
	Yfn58+rdvthlNyeeYDA5eS3m1LRSnHa5qt87SljrFeznUdeRflErd+mgPs2Ob4i1GmRreAllakk
	3hCSOdUdSjVZkA7enXcoLvJ93j/6p73zBvHKVkMcjkDr1z9y9wrxtiSH+KqqU606OIZD/J5S/JL
	ZASeotmdE1OGco1HZy2CkVz9S8wuJ/nutB2uYiVSV7ianPMi+uwCtMgiqOjinO6GTN7JuD7YB25
	5vUk+cLqrbiDlGmubo6fuD4VVexkcwZLbWgCMz/r9rtddsKVL7TYpKZZQapEFkYatT/XSThTLC0
	KWyFUMnodi36EV1ylnCiFGPiifPKbYQs6qrcjkO2IxApM3fDNziPHAWcot4PNgLfCrcPeXMByCP
	UGfHwbq4Vvl4v3R8NNtlcw/BFelQfcaFwR4rX5OiTJ2f8=
X-Google-Smtp-Source: AGHT+IHcAofEjIVpqwBeyLxp38rK2fJ6aVVLNfYQLuqHy0jJMGMvheR5GQUGtZQnmyrs2ntcFPXxFA==
X-Received: by 2002:a05:7022:10d:b0:119:e569:fba9 with SMTP id a92af1059eb24-11df0c3c923mr2803246c88.24.1764794164501;
        Wed, 03 Dec 2025 12:36:04 -0800 (PST)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb04a07bsm88257115c88.7.2025.12.03.12.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 12:36:04 -0800 (PST)
From: anisa.su887@gmail.com
To: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Cc: nifan.cxl@gmail.com,
	dongjoo.seo1@samsung.com,
	Fan Ni <fan.ni@samsung.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [RFC PATCH 1/3] core/region: fix return logic for store_targetN
Date: Wed,  3 Dec 2025 20:29:11 +0000
Message-ID: <20251203203540.1091827-2-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251203203540.1091827-1-anisa.su887@gmail.com>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Currently, store_targetN attempts to attach_target even if an error
(cxlr->mode is incorrect, DCD is unsupported). Add a goto out statement
to skip any attempt to attach the target on error.

Signed-off-by: Fan Ni <nifan.cxl@gmail.com>
Tested-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 drivers/cxl/core/region.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a93979dd345d..adab1f338ee9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2258,7 +2258,8 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
 		if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A &&
 		    !cxl_dcd_supported(cxled_to_mds(cxled))) {
 			dev_dbg(dev, "DCD unsupported\n");
-			return -EINVAL;
+			rc = -EINVAL;
+			goto out;
 		}
 		rc = attach_target(cxlr, cxled, pos, TASK_INTERRUPTIBLE);
 out:
-- 
2.51.0

