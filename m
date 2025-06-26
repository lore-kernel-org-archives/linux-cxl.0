Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC71226A090
	for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976905; cv=none; b=lV/fiMuicTxVi92Y8RcRB6ptPbCDSt1Go9hLDcSBG1fov6DSrME/M9Wd0U+V/U4NSbuVXKGzVZlceKyoX2b6beDJ5K89XBqXxhlkMH0CtVINC0mYrDrNDtHsiarvXAcXgLETv2KV2HWtjz3eLfrTkA3t+lGzV1XE2AaFK5ld+dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976905; c=relaxed/simple;
	bh=r4aLRpb6ohaPlZc7TMyE5GDmFPSXCb9bkU/GLTi6/k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9utNEIX/jY/1z1pXGh6Ww8msfp/YkSpr51VTVNtBXlX5WqG6GyH53wxet8RFL3DK+JxbXeC0jUAx/5fP9yZfexSdcEMM46O/Leuxb0Jz95LJ5c6H7gZ3ffnidc5LYmJTotXGP4tSQDqMsAxOQfo4U0DlPoBiW/vpOTPGsFLLsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdYpVbQU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdYpVbQU"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2366e5e4dbaso25055255ad.1
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750976903; x=1751581703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlJ/ihmtY/Bs+6QNasQQE5ci8/VnkGAsX6ch1ZEqQ/Y=;
        b=CdYpVbQUjQQaX8UKqCeYWyEXySk4mKkRoIVNX89CP1CROSfPcWwy7feoqJ3WPXaSeF
         PSPySiUKglkObMAkXgqwAyzv7lNj+YHqrP0aGTQHpNAtdMalnu4wT21ugxfmff/ub4XE
         1w+bjjDR+7MvWepHZyb8B/Hyr70FonLyx8z2H7XNNxhT+9iBIiO5eTFzZaYph885IFX0
         dIECcCUPTN1XanQ8XP3P27QpdiChkuvmDdx5C1Z/8H7hY1fnnY9w/DET0VH4VIfxyiLq
         U7oB8SU65SdPY1SvngrEFRSnSQpxZacwa5uSnYKG/gEGZLtiASUhTjlLSkf7VK1z5Kpt
         F3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750976903; x=1751581703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlJ/ihmtY/Bs+6QNasQQE5ci8/VnkGAsX6ch1ZEqQ/Y=;
        b=dMKn/oYbCfEVQapCGfj/OjYFce0mjsxRQXo3MLGkOARTXerOr5Km3AKFO0RPgaZ0QE
         x6F6El7Rlrlx4qq+2IpVtO3tK0nodPJoDDIldwpaWtk6zQGGXX85W2um6rBsHTJ2jWte
         SNYKG8R8s9EWvPkNIrqXQgZY9PQkD5D+tDKw8a1XzsxyNfI8GrQSRwAqn6J5mNEwHR4Q
         GQ8Ou2XAcWBHD7XPEyWZCVQaeUw2+G6qYzI7Bqrtg75AXnSsNTBSh4vpdo0v8bzo1tfG
         ggkIxH5Ru3gNTLuKtI7siZ3Abiiobay+3zGPGHLddndJe8BDiZrwRC63jtcUI3Dl/f99
         Rtyg==
X-Forwarded-Encrypted: i=1; AJvYcCUzxCnyHQ4D1uC+mvwFdyxXLLSlhsHtRAC0Twuga78W+P+WRfqnhEYJEzZaybtsb2WTaxCIkIe3JT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4W6IV1xoK30gB1YtjNo2Gc1cLnJxb7abG1/a0oTc025C8INE8
	d0sG5vqkGOVaSjNNY5kWVW1PS7uxcqYP0woEkCfccyo7bHzckU6FK7Iy
X-Gm-Gg: ASbGnct7pna5SBO5zo3vbm7zXgGAZ33hS+c5lKafMiXTA/anNH2CbWKrJknBZu+n+Uo
	qHPcdKsTxNaD3X/UhMudVf/lIr+w9RFk7ckwOngzft74N14sSmvqypXahIEzbsvLedPmnQhw0zI
	KWXSvZZk9EHjPhJKCbs1jj+pxv4eOY3dNDKVoVEtDIcWBynqkk0fWfgs2xlUjkaAtjylN4BKBsD
	a2JyN11rwLLzMTLPF5NGlZhIFEJBFpFCShMRcYR8BRg6PJeqTPqn2pl8i/EUOIu60JSsQJs4gq5
	1XcO4Ry5QUtzFz+403AIQlq5y+udfmb5i+Ltm+De9ak+BTR5d06LtfH1dPs55hYRQRvR3nzmI8e
	HtGXWjVs=
X-Google-Smtp-Source: AGHT+IH3JDlsQy+VzeCP6XavKPgibPAly4QUpzv/KCtsAmiIQzL44pbquOf0jrrKRll8b2m1y7/L2g==
X-Received: by 2002:a17:903:807:b0:234:1e11:95a3 with SMTP id d9443c01a7336-2390a4a8832mr60381845ad.13.1750976903096;
        Thu, 26 Jun 2025 15:28:23 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 15:28:22 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	alok.a.tiwari@oracle.com,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v4 04/10] cxl_events.h: Move definition for dynamic_capacity_uuid and enum for DC event types
Date: Thu, 26 Jun 2025 22:23:27 +0000
Message-ID: <20250626222743.1766404-5-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626222743.1766404-1-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

Move definition/enum to cxl_events.h for shared use in next patch

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          | 15 ---------------
 include/hw/cxl/cxl_events.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0fccd22800..cdd60079c4 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1876,21 +1876,6 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
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

