Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CD22C11FE
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304134; cv=none; b=YmwQY9UJ83itjVXW+XEuEj34Z243oKuZiFam9YNJ9LQYg+tXcphIVQk+YSbeclLdCZcstig2xxdnNXWiqEnfpl9+29tCFCeUTijBIEWxH9SYOXk3x1j4pc69lj4tbwSnO1oJXszdHtO3d6fpnRcR/ZtDOL0v1SKhq+bVOJRLAjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304134; c=relaxed/simple;
	bh=LmLICXKN4PxTt9E92rpl5LYBE/MbtV1Wyk/PPd5elW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fs/MRU0HZ4OfVPvJ/Wa/dSmh1jAIDqgw+K76glbGE2eG/NcgkYHqTWrL45M6fHm/HU6gQbsZFOX/8Ea8L4q+qqcYnQyGT+sEUa+7CYa6SdQ8zHp9cbhHzBmkm4kQDbGuDXlhEz0DAz575HBPSYdOsFysOInJlyvKS0G5yf41Bos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAEcc5A6; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAEcc5A6"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7f69b71f7b2so11346857b3.1
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 05:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782304131; x=1782908931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fs/qtc/0ZBm1uHTvn8rnhciGjWqMDaTcX5LgeFuAVEU=;
        b=AAEcc5A6hMnbcfStYJZKu8IPv8z+IoD2uFuYdCQBV7Mp/LdaxDt2/UaNRG7kJI8oAO
         UXsd80Dfsj4MZ8lh8nTXgreK4krpKHM5qF6hrSXgEr7bs8T3gS+m0rZ/4p4UtZ3L+zhd
         7Nh0Qh/4wBEQZaY89QULQxNPX2OsED3VrfFnxugp6+jXVg20u7ZWOuWY2/COVPl08jJr
         Wr40tX6gefD8hklQAF0u6Ob6xVSjAB3dZnZrkVLmxhHosW9zJbHDcYDKiuBXF8lb58Ar
         v3BAJd1GUkvW1iSNlqEyrtfDIb3ebcumv0D/QD1fJIBctZ3WZ04a2S0lYgw7u0ZbnWEY
         /8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782304131; x=1782908931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fs/qtc/0ZBm1uHTvn8rnhciGjWqMDaTcX5LgeFuAVEU=;
        b=Vg3VxqbvizK6x+qUFg56l2dFL+weq5nZ2i47g7XyAsgarZ2FYTilXT+5O2FqZiXvFh
         C5OB3Cslq62KYZKRGKUiWmBT9nyodY16rL6d+wXH9qT0uHJZK6z2RXR3q4KQwQ9RSvkn
         yzLgIHrSSA3hj5XuErIT9wj1RmK1sLkCSQUQiSR4TIQ1CLThoE71KbfZIZX884lHzCJm
         y+u6mpIH8AIGhkKZAIcxk5qu6FY7YkSd1xn3UH6FOPhEvHKo2UbT5HEEmcIh0g72wVbk
         qA6UDWduGv+hGyzvtYNd4m5+yXDTLRFT2Z4pcjsbe4h0NCFUthQJsEKVLCVCCaQl+/2u
         PHKw==
X-Forwarded-Encrypted: i=1; AHgh+RoVBYUBWKTDAykC4M1yfg1pTWTMcmDQFfhOoEUa9sOLVXClFapX52H1CL3mSlem0gxVgfC/Z1d83Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQF1rTn90m+hnpj0SdB9RKClhbY3hci9zIEhYa2Wl8SAs6vp2g
	dUVoVixVuXCFZar6VxdOC17LIQBmhWtsILA1AbNtAhu7ZGgIq5MRiOUr
X-Gm-Gg: AfdE7cmRNUzziX0kBTVhgg3rV1Ly1zEMLfiaPPEcOEPXTfgm4jPk3p8lvvAiUI3QZPe
	89rYp//DiMpjzu4DS3mlzx/qdHvgHtva9+VEzQm3/hFEGd1uTD8huVUHUhxcmsLPbXO/npjDujF
	RgmBjY6u686ISLK0QyXofBW3mljxqGfktmkZjlOWflCRHS+LUMedMJpRtdzNnf9GjWL1gPOXrPR
	yz8hTFN7gkpYRF4VocgOnBs7bjk1dAaAbnyCuPseZQe4asz3eFgwwHRcUzPr5YfAEyM/oizZTWQ
	XMyALume5brxKgz/l7kc3Ek3P05FzqEaK8kfSceTx69hsXNA5c0IJ/tMAB6kD93UOoPto9GHVcL
	rJy6zV+qNO4HL5/XIzGSFokb2G3CUSopMcGG6ssfWHFif2D8qBXLPstBbwObZz0OQUegY5tH/us
	K5I52hE2MWV01UU4R3lJs5u2SvYQMYDJFWc+OA
X-Received: by 2002:a05:690c:6610:b0:7ff:28b1:d325 with SMTP id 00721157ae682-807ef24e577mr29657777b3.35.1782304131407;
        Wed, 24 Jun 2026 05:28:51 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025ffc2730sm56689127b3.34.2026.06.24.05.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:28:51 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] cxl: fix mailbox return code description typo
Date: Wed, 24 Jun 2026 14:28:35 +0200
Message-ID: <20260624122835.5656-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in the CXL mailbox command return code description for the
interrupted-command case.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/cxl/cxlmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ed419d0c5..503ae2864 100644
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
2.54.0

