Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22A31280D
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165154; cv=none; b=C8p0uKX4T7VbFYMnLDBFXlpmGcKsvAThEsX22IeZGp1xqiHiCRZHl2qVXapNI5iLX2AsiGpscPOPYqiidafT8uggpP8noGCTzU+lcouMzWKRQP8S7Nx8KF1NdokMr871PopW8ggXyMrzKIGn7/VzJcQbAAme5pCQcBAd+ssz0o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165154; c=relaxed/simple;
	bh=/fcO5PvnBvL5ZUEF1lo1Qe5BDAxGE1RtLVLHr5iOP1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jbu0LeJIck6Lvcnsl/RA4saVx7ikKNwPBx5iCXqYbt+0lVvGDxeDKmr3A2NTnmuyOcT+p6PT6N/E6BqivvG39NExqn++7IPlON1JC5ADEj3J2rr6tRR8+5tpY/1uaJUxUn8dNXWhbvgiUb1epnyMOXOHNAh+/oJEVAVcq/s3O8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxTcJyXx; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxTcJyXx"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so271195e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 15:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789165148; x=1789769948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l6ZIiebb4ZMiW4arJXrmno4PJu47VBpVh+nHVQaLggA=;
        b=QxTcJyXxq3fjhOSqWCp4OE94grIcgYo7s94/1Tq9iq/GFu00Ei5ZudNaNmJ5TgL8KF
         Iymab2ywIGfXLDaD/oyNoLtKoPFPYCNREA2o3Gxknstq2aJylRGLxf+Ni4NIP7egCWcZ
         uVX66kqAl5MBVMweSbMtufLoJlZxmdy2/DQijJJGksZ8wehIXX54dZZS1oaAtyTATIII
         cSBq+YMccgU/sF4JXMFTOz+ODDFyiKceW3p9mOZIC7TD/u6Ry7znXeQq3urOD+EVIKAy
         x4PzBspE/AmHLp+KfMGN1pPaKUB1FJ4yTBaNNx6Crib+lyb1PuBwv3z6pwyPR/xnQrMt
         WsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789165148; x=1789769948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l6ZIiebb4ZMiW4arJXrmno4PJu47VBpVh+nHVQaLggA=;
        b=K3Vcy3YTW1vwQnT8tY3v+hwfGn7K4Bq0kCVGlOxxrHSIt4uYQr6v2i4i5c3Yg9Ys5H
         2zog7jLTWuXW1bEXU3mpKJhMU8GFhWTxYYR6qGxqKvYKSZ61GY1YLTCpItdmFCtylwHg
         3X0H70VtqAm3mKCj7VR3p8yJKIXVuusNAzQQRHmRDzuqDL51Sm0Mn6qiP+9uE1wSfG2Q
         kXYAkI8qHV3cK/POkT1EmNAPU0WScrWWYyfLyWCStXvAEJ6GSaSdFjSC0onbjs4Am2Yr
         pUOAMRAgJabtG+MoUG/m2Jp93UJplXclCLlhWo2luGvAJK1o4ED8pfdNPi7tWH6kDLEM
         ey8A==
X-Forwarded-Encrypted: i=1; AKwUvBy9NSZv835SWdz+ny1ZdtBhlFYqu5m+2k8tfeGe7s3Kfa7F97dYJC3qyZeonFR9xIp8I2ksHKGF6iY=@vger.kernel.org
X-Gm-Message-State: AFuF++mnl2OAI1/RVV2z7q2+ipo0PpxpA2FFpU1jCY97UA6srLA3C43P
	byjfU6Al+jpFYE26TKHPz44XLfVWWKQj1bG9YGWLYtF8ZB1bHX366nb832PIsbIK
X-Gm-Gg: AYBFou1U+u2HQPKQCAH6hNF7baVYKedr7rG5dO3rQB1Hch9kdfZTvA0XX9KSy6Zraqv
	RIyoVLG2UHP4cDsG/svdLc+fkWTnU4OVVpDbCC0+sTgAlCcrt/De1KOmej4jJF0jiWbz3V6Pa75
	DDWZ+ZqUoLZUtw+RGe8Jk7iko46UWnbhLb1utpPyBnhezVpZqfNIezstCfmrzL4yiHshvAXI5AE
	mHACL3VE54VnVEz39DXi53kLpgLrosnevRxjTCiQRSaQs5wCk440Ifgp5PDrlfwgEpoAUYTcYc0
	qQvnq0md/zAyw/KNUboSEYhsLs7tgx14d4F3O2oqSg5b1F0jjejaSHhbD3QprLkfyuIxgJzagsy
	635a4ZMogqv33In2EsRL1swdaoGoxR4Diq/sWQpSIKQ9OXKef5/2nYC30VwvPPrHp4u9kgeBhgm
	YORTWzqkXgpPS7IXLl2kiaNn4Hfts1Uf/MXWYXr8j2KOpOm+rX1rCQ1/khmqviYIxUrHNm8TeMw
	QB5+4DbmH/nbFWc7p+N1W2KXvfEkf6tu46aGzoA8nGrfzyd5wQjevPt5cAbaCagioGfYECafPCc
	ymwmTJt7b/4EUxCjfZz9s9f0Ty/Y+wwqWGm5
X-Received: by 2002:a05:600c:358c:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49e6caad0bcmr1654755e9.2.1789165147535;
        Fri, 11 Sep 2026 15:19:07 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486f0403125sm6355193f8f.8.2026.09.11.15.19.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 15:19:06 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Ben Widawsky <bwidawsk@kernel.org>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/region: Fix the return value in devm_cxl_add_region() kernel-doc
Date: Sat, 12 Sep 2026 00:17:48 +0200
Message-Id: <20260911221748.7212-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_cxl_add_region() returns the new struct cxl_region, or an ERR_PTR()
on failure, but its kernel-doc says "0 if the region was added to the
@cxlrd, else returns negative error code", which was never true.
Describe the pointer.

Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c82ccd6c34b7955f52789a32ce478..28a8e3d1e1231eef40bc30cdd937af980952232c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2727,7 +2727,7 @@ void kill_regions(struct cxl_root_decoder *cxlrd)
  * This is the second step of region initialization. Regions exist within an
  * address space which is mapped by a @cxlrd.
  *
- * Return: 0 if the region was added to the @cxlrd, else returns negative error
+ * Return: the new region if it was added to the @cxlrd, else an ERR_PTR() with the error
  * code. The region will be named "regionZ" where Z is the unique region number.
  */
 static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
