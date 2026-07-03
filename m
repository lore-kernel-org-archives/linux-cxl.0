Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9444335AC20
	for <linux-cxl@vger.kernel.org>; Fri,  3 Jul 2026 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090481; cv=none; b=XTbE1Q6hUQ3RTuJcCgtdsq2jmjJUcuvFAZtsfc6Q6U+lf+YCH3r7/OxEQrSwVCeK3zY3LruoBR7+vP3LaRYKadHamDPwdREx01cP0oEUIvSj9Xur+JHWKCAIPIHArA9AE4SuHBe9KwCFzbo8PiqeKy4Kd6wcZ8SuYtM7RMoTJps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090481; c=relaxed/simple;
	bh=eeC0J8ilZFI8FMO0xx0Mmy+EomilNkfXYLvWaW7bQsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1cMCToAIKl2wH8T7Q4GHbhsBR5MfeIYEjTu4WFJ12mHMHx6TBcnvhYheMCaGRe/5Hd2R/CWwaxKeAAqFDGLNXLHGJLXr7XidFYe+mVJ3NQQkms4kNvb+vFfiXXeMyei0UR2XeRAgrzHmbjlKoj9hlxru/EJY6x/ZGQ8C1HrI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2fhSW1+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2fhSW1+"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3811f512167so550988a91.3
        for <linux-cxl@vger.kernel.org>; Fri, 03 Jul 2026 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783090480; x=1783695280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s84s7xlHtuCE+qHkzV8euAVnrD8Kmc3QE4u4jTrxAy0=;
        b=N2fhSW1+Mk6lebrZMpTHDU2ejDSi9TkuLWgcO0g9viA6jp4SBeBv06dMlO4VWn8Jmi
         SoLrMpy7bM/Fvd2kplLR5hSQ2jEMG+UT60IMAQv1VpqP9Xbfqy+/JGRtocErcLJGwLSK
         IeR722bvdEaoGhRUTmga0+J1zBOn+8SfpAvqIca1QAkt7Dx9TtLFVkc68oo1bw3j2vfR
         igcnLWVGY5kKJTLPwUgWMRzUrMZYzVWA4gAo+R1/0ApJjk9l+iTRB+58UVR92OfnypR7
         qE2Xr1eAhXNYgb6K+5mt67Om1tcIgyY8KPHVTdeeLIFOTiUDOqzGhw1h7e5O8ZfwYBLm
         QXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783090480; x=1783695280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s84s7xlHtuCE+qHkzV8euAVnrD8Kmc3QE4u4jTrxAy0=;
        b=TQbfo3YKhlroEjrPuf/BLg7HqljGFG6IraWYHKnuxVHmLhqVDtMoXWiJa/GIe2aP9s
         dRt9jzmsAjuHadbDQfzDSzN3LGLQYepLplQJic/7B06iH+3rPOt3ZGke/lN8TW7i7Nan
         1YZNFILbnS/Hjj8WIKdmU/ndgDiT5KWlZpE0xpAqZcB69tQiJQdYDhCrcxifagB0txlg
         /OuS7sGs0knXHvWnS2i2zYAcuSZ2xPVKtwgi5iF+/SrCCqMPwY8zZHohF4Qv0pjsk0cY
         F9rNXZbCfbuye3YdkaGP4HgmDlovmLMm7fWuezHTwVovFKyhf9NLSYeZeeXoqvtEWoGa
         1vvg==
X-Forwarded-Encrypted: i=1; AHgh+RpCOhgiEPJb+4rFLsWT8iV/WsS8eDsoJscbLW4Jvug5F57P7YMjpL6HcbCUkLsMwJxHOHNwzPjFtds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbx6nZnMGYMPXzKOjjXtt29dHlYkATwDKJNpGi0Q9xwFK90Fab
	pTUjZZHqbs+R3cePA+Wp1ntR3sLQPMw8SaKwj3dEjTcFrXZI3f38wnKi
X-Gm-Gg: AfdE7cmseOEZFpXYnTTJ1GuD3goNrWr1AFRQqx30C9IPKcoRWYGuPe/V1+MsgRHTz21
	exwKGILBElNL2cZHv6zYkmohCiTXntmw2nD+mc9BvzsECwprHLWIe9hmF8UklKcwjBCwEJ5X9Hz
	X1v3GeV2FDuAY5Hsa7G74Wtml2+6IiSKInZyFCWTsADlBRS9asBEm3slKRwMptDk4s0h4b+/Y7n
	fcfAZMUjDKg5w3k4kI52eUtJUf4o8sjlLzLk9AIbGiRT+KdyzCLMTIniBxG3hv94jieN0yGcLBG
	SmRfvhPaRIGLvN3VzSz2rd6t/nqIGQvQ/JgwVI81PiXAFuuejaRZQgY+lt8Y3rrhUj2szCSzrGp
	bue/MVp9FGC5vIrUaVWd5K3c0bsXIFr2uK+OMYweH/5qZFmAnadLHyoPJ6maq1pq0InFVq4negM
	uUyRliCBzdGjgN33s8PA2MBuGA/dod4FWEbu47JJV5nW31Rt1/I6DIRC4JCOGbMhzSIK10sAZVo
	rOrNlnW3eE=
X-Received: by 2002:a17:90a:d44e:b0:37f:ad36:8fc5 with SMTP id 98e67ed59e1d1-380aa1d3d70mr9703263a91.23.1783090479611;
        Fri, 03 Jul 2026 07:54:39 -0700 (PDT)
Received: from fedora.localdomain ([152.58.57.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb84405sm30960067eec.17.2026.07.03.07.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 07:54:39 -0700 (PDT)
From: Praveen Rajendran <praveenrajendran2009@gmail.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Praveen Rajendran <praveenrajendran2009@gmail.com>
Subject: [PATCH] cxl: Fix spelling typo in asynchronous event string
Date: Fri,  3 Jul 2026 20:22:50 +0530
Message-ID: <20260703145250.3953-1-praveenrajendran2009@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a user-facing spelling mistake in the CXL memory error logging
macro array where "occurred" was misspelled as "occured".

Signed-off-by: Praveen Rajendran <praveenrajendran2009@gmail.com>
---
 drivers/cxl/cxlmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ed419d0c59f2..503ae2864591 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -183,7 +183,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 	C(MBUNSUPPORTED, -ENXIO, "unsupported on the mailbox it was issued on"),\
 	C(PAYLOADLEN, -ENXIO, "invalid payload length"),			\
 	C(LOG, -ENXIO, "invalid or unsupported log page"),			\
-	C(INTERRUPTED, -ENXIO, "asynchronous event occured"),			\
+	C(INTERRUPTED, -ENXIO, "asynchronous event occurred"),			\
 	C(FEATUREVERSION, -ENXIO, "unsupported feature version"),		\
 	C(FEATURESELVALUE, -ENXIO, "unsupported feature selection value"),	\
 	C(FEATURETRANSFERIP, -ENXIO, "feature transfer in progress"),		\
-- 
2.50.1

