Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D723BB44
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663524; cv=none; b=qKbIMycLdgF0ux4mWqu0acJeFuOthn1zmxe/SvF9vuZIrY+hLHF6eFy09TWI1kqh+eXSADYRJb1GvjgY/+RzC/cqq3Fm1D7wqUJdFSmSR15sOn8Kmlbhnm78EnCQRneLVAHSHaZPhAO1z85QF1n/ObcJTP5N+nr8w/etOP5etOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663524; c=relaxed/simple;
	bh=RJgP4CCc3NO8h56oCoAi26Tk3hizKCxyT4h4dqa0BjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvLCUqdfFE+F9F+C9TOWgV5DsJn6MnnVbc1E2LLf/FShN9fMYAhvBuIILsmL7GslGg1wBDvABVOB8oZ3x4S6ZKFJf/9BMGqriqLYoH735c+PsDFAdiGqDbpSlwOU0Zs7r2/iSSNRBwG/2LqhRpvlC6HsqdP+fZloR9nB9Q87OZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR1le1yQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR1le1yQ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso583797b3a.2
        for <linux-cxl@vger.kernel.org>; Wed, 07 May 2025 17:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746663521; x=1747268321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjR+4cbwIjuGdu5a9Wc1yALEfQJBd/CuIo518XL/+fg=;
        b=UR1le1yQoZxFI+dcQt9Yf5AmDDKS4vQOanKiLPy7M4Rix5UnYWwAdsRazHRyWHgKs/
         j4OBY6jumLlHr3owaJbRTECZOweQW8IlyIg083mpbYOIzhwI+ehrz0xcEW3W1hdpyMf5
         3jKrdD1pXM87V4Qs3T0zcmPMlfDkjQossICJVfMecGqp+lpJZPvRe8+D88usYLXKoAoG
         PnwiJd0BJecpnRhyOlMPZDWZXY9F6a2jRPJHr6dxBek93ab0iBL+1W3aJRBDPKNjxhY1
         P9QTYPeS7CXG0nACUjCgsESwHGH/ksymtN8uG9EI84X/sIV+f+/1UoghdyRl+RNfb6qk
         Z+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746663521; x=1747268321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjR+4cbwIjuGdu5a9Wc1yALEfQJBd/CuIo518XL/+fg=;
        b=F+N5XV3p6+v1xHBgfweFxvH67uIDveguCJ8V6tEJppAA3xMsvsUJQEsQmgGj8+ymSP
         xmdH75vSeoSil9qv9mUNuWcKWUw1UhdH2WubW8ttSNZ6YtZ42QyBf0ETTBF+ssYlxW1x
         e3r9E/00Cx0cQnkVILouSHXmq/CPEvbhD9uf2Q3bnKo7qzuCwPGgZj9VP+5eFtU+hjHP
         D9VjHgv7eUKV6ZQ7RuCANqdi6aYUSTVNp3ob3/YxxH2m0yNaJsKbThoUk65G9sGSkX6G
         Fj0mr1qRxd4bs9dumrE39xXJJuT/p6FQtIQid1mIbsAHlTP4CsrH1xdhDcmGyl/PhIWM
         3KdA==
X-Forwarded-Encrypted: i=1; AJvYcCXNIVA++A0bnNLdgvhEmWR25qu+YLD2Qu2Nn7c3YaRETZTYuh0BYU2ZhYSaroiqFtiZj/pCS9bNMYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI8czW6OQ6p3AKcDVp6od5bP5kJMIS0wG+c6XEO4s/KGxazQj2
	YL4LnPzUI3PfXvk/2k63UZeTln9pGppqscQ0vDR66ha03jm9PsP6
X-Gm-Gg: ASbGncv/E6EdJiYJt3XgG7OTxMuAM43k+T0nKAFvX2XTBXW1KEKZXDReoQBrTo7XWOS
	OxDSILfJl1+67DWNojSPxCyx3x/UzqyvQ/vKgf8s3rMikaRH/TTlyevQCjakjscxfzI08oDAiQX
	aMwdF/tMaIgMqghnV/BjN1wZ4+LLCnsPwYtUa2XYh4m2XxsjiEuOZcrOaKl1lit5s/go62i0Zb4
	rCKEuXf+K0I31kAG3HzCgvx/a0X2bEXYdR5TnUkEY6R0rxe+BlnZv8fG41XX3zOAgq3cnzmMm1Z
	uUS6nhqFksDiReJPtvaIy8DDMzujehpww8bHyCEZg2ynm+d6WhaXRufkQED6hw==
X-Google-Smtp-Source: AGHT+IFVW9/qE144753BxmrJrZ3KQKrB5Cd+qE4MZUI/qK0vbO/pbkjxTE2f8Un30OPgdezgLBxmoA==
X-Received: by 2002:a05:6a00:3286:b0:736:5c8e:baaa with SMTP id d2e1a72fcca58-7409cee610cmr7425910b3a.2.1746663520848;
        Wed, 07 May 2025 17:18:40 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 17:18:40 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 05/10] cxl_events.h: Move definition for dynamic_capacity_uuid and enum for DC event types
Date: Thu,  8 May 2025 00:01:01 +0000
Message-ID: <20250508001754.122180-6-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

Move definition/enum to cxl_events.h for shared use in next patch

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 15 ---------------
 include/hw/cxl/cxl_events.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 05d4c861f1..6ad48f55ce 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1982,21 +1982,6 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     }
 }
 
-/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
-static const QemuUUID dynamic_capacity_uuid = {
-    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
-                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
-};
-
-typedef enum CXLDCEventType {
-    DC_EVENT_ADD_CAPACITY = 0x0,
-    DC_EVENT_RELEASE_CAPACITY = 0x1,
-    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
-    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
-    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
-    DC_EVENT_CAPACITY_RELEASED = 0x5,
-} CXLDCEventType;
-
 /*
  * Check whether the range [dpa, dpa + len - 1] has overlaps with extents in
  * the list.
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 38cadaa0f3..758b075a64 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -184,4 +184,19 @@ typedef struct CXLEventDynamicCapacity {
     uint32_t tags_avail;
 } QEMU_PACKED CXLEventDynamicCapacity;
 
+/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
+static const QemuUUID dynamic_capacity_uuid = {
+    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
+                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+};
+
+typedef enum CXLDCEventType {
+    DC_EVENT_ADD_CAPACITY = 0x0,
+    DC_EVENT_RELEASE_CAPACITY = 0x1,
+    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
+    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
+    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
+    DC_EVENT_CAPACITY_RELEASED = 0x5,
+} CXLDCEventType;
+
 #endif /* CXL_EVENTS_H */
-- 
2.47.2

