Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BF9218E96
	for <linux-cxl@vger.kernel.org>; Thu,  5 Jun 2025 23:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749166960; cv=none; b=AMuHrrJbyGgfNqfGgY3TyGLYflOcr4oVMCeVNzGBH2aqDLHJEvMVe4+sSg4t7BsZ/Skm2NLe/U2zpmJyMuONKyjOMOvy2PRI/pePNVHdIqfbHxyiAVUm0kXpPWUXJuRqjRxDpFi0spDLHgNvPYQ1jlipQBG//QhweNml8uLNW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749166960; c=relaxed/simple;
	bh=Z3N0QFqJ5Y7ZySTJ/MlX5RPINIh6M/IaFVoxFPglN1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8JLblNTSLxCSGynGgSI5rPz7MB2+5iGUClhD9y3GueqjrnAuz9goZyyDzgXskbXsgWXoYQCAuJgijRrrv6/UWZdwCrdMHFQhKRW/maOmS3tO8e3/OzQIGqj9n5ErCp1Wl/ANxYk+JznSQcmeOIJV6FSkUzL67DiEy9xo8fVWU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIu/BXwx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIu/BXwx"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747fc77ba9eso1282016b3a.0
        for <linux-cxl@vger.kernel.org>; Thu, 05 Jun 2025 16:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749166958; x=1749771758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vbz0CDPq236t18mBju+EUapSkDzWeN6uVn3bY2hAz/g=;
        b=QIu/BXwxTiv8oWwd/BPzxohtEl/inyHj6fawqaFL4lA5RgR5xIW1y7CfoFGut3nn2g
         XYL9V0utx5yO9EMRupWPVox7TSB2gfC7S8FGDwR8POlhc/mHn3XwlG4AEzTGNtUjpQiF
         dTFmu6aRoW81NgCN+qecOvh4CBJHkr5MaKliW2qFKnLTT5xqlGX1OCnL429AdXrr8seg
         KKioiJDfnz6lRHk91PGMkj4+rK2R4wm9gKXtkcRO33MkOCE6AZjsjw2fgZiBhMS2XP88
         qkIEN9K7CtcDH745JNC7pQAMEkM1RUXR5iULehOoJH5wcjTivL48a9EKMoa6xA5HIgOc
         8HwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749166958; x=1749771758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vbz0CDPq236t18mBju+EUapSkDzWeN6uVn3bY2hAz/g=;
        b=i+JSt1hGdWqog8B/4eEB3MZmutMpalgEJTmHxOLso1MCeIXQZAliVscS4ymNGQwin7
         HCNjaJtSQvHRpCmmPqIVIuuldQHcqCb3rYFq+3Z2g5QZt7Rwze7W6A0HBaXfDoYh+ZWY
         e72bAoKFsrQToq5F7LVayNKUs/0HqBOTTuaLDQURM1WBtqEFw9QwCvujLWHOQp/AdSEz
         DwRPs9c/EWE5J+C2ZXlnDsUGq2h4AX3Mjy+MHCfBGMVuOqi4zHRaa0ctzrJV/4dJjLh6
         PVubq0a7L6ayDEUAoD0KwSbpzeWh6FXD5MknM+3B4Zt8WTnAIwBIjrgZ3OmGnQzXSTSo
         dW7g==
X-Forwarded-Encrypted: i=1; AJvYcCW5p0SlktVUmJOhP3+kpzSdKCag07Lj/6g4Tar/dRyhLpzzSQX2fPFZZU9dsRpe9zIKKkGSADia/VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoVIC41mTiRgnZ4IX75ODCt1XH6xb6565j6Bvk7bHsQPqCBNN5
	F7Is91sNXqEXOO2IANy2xWY+jHE3Y6DkQKE+U6XMHKq3/TsFmezpciLN
X-Gm-Gg: ASbGnctDaNK2NUAAxm6DKCI5Mip1iPVvoaykKfG2mN+WIRBC5oaIwLIfznUD+bn39dX
	nlT9Zbjxny+G7tJRZMXjfUfGy2tNclh2ZGTVpmo8zvP/UByqjRiEddERedhuP0BeE6tP8UHBoE8
	JFSuDWHxlZiIqXkAcB8S6LT9Ou40xd/6Te/DGUZVxiaCFezRBbY8vECNpi7QJZGeQ3uWubShNUu
	9tNJ8BPlnDqqnW8gvUcHISnnmgAkC1bkp15nVNvJO+YZSv4w5TmYxkswTBjeBIOlZYoFvocFvwA
	o2GdDuoIP3lLILsTm5CwVwAGL+lz4KLvjWiRVPdHDy8Wvo2zQCvmCr0XyCXSJAyn1631Pstt
X-Google-Smtp-Source: AGHT+IHuxw4YKp3xud2AJIiH0aYA6/yv1A7vzszTQ/nO3KSTaQQujwTfKuvf03Rd0cgb7dyMoOsqGQ==
X-Received: by 2002:a05:6a00:1818:b0:746:285b:595c with SMTP id d2e1a72fcca58-74827e7f47amr2068617b3a.8.1749166958518;
        Thu, 05 Jun 2025 16:42:38 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 16:42:38 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v3 2/9] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Date: Thu,  5 Jun 2025 23:42:16 +0000
Message-ID: <20250605234227.970187-3-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605234227.970187-1-anisa.su887@gmail.com>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

Add booleans to DC Region struct to represent dsmas flags (defined in CDAT) in
preparation for the next command, which returns the flags in the next mailbox
command 0x5601.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          |  8 +++++++-
 include/hw/cxl/cxl_device.h | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index f608470362..0fccd22800 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -226,10 +226,16 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
          * future.
          */
         for (i = 0; i < ct3d->dc.num_regions; i++) {
+            ct3d->dc.regions[i].nonvolatile = false;
+            ct3d->dc.regions[i].sharable = false;
+            ct3d->dc.regions[i].hw_managed_coherency = false;
+            ct3d->dc.regions[i].ic_specific_dc_management = false;
+            ct3d->dc.regions[i].rdonly = false;
             ct3_build_cdat_entries_for_mr(&(table[cur_ent]),
                                           dsmad_handle++,
                                           ct3d->dc.regions[i].len,
-                                          false, true, region_base);
+                                          ct3d->dc.regions[i].nonvolatile,
+                                          true, region_base);
             ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
 
             cur_ent += CT3_CDAT_NUM_ENTRIES;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 7eade9cf8a..469e5d872a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -133,6 +133,15 @@ typedef enum {
     CXL_MBOX_MAX = 0x20
 } CXLRetCode;
 
+/* r3.2 Section 7.6.7.6.2 Table 7-66 DSMAS Flags Bits */
+typedef enum {
+    CXL_DSMAS_FLAGS_NONVOLATILE = 2,
+    CXL_DSMAS_FLAGS_SHARABLE = 3,
+    CXL_DSMAS_FLAGS_HW_MANAGED_COHERENCY = 4,
+    CXL_DSMAS_FLAGS_IC_SPECIFIC_DC_MANAGEMENT = 5,
+    CXL_DSMAS_FLAGS_RDONLY = 6,
+} CXLDSMASFlags;
+
 typedef struct CXLCCI CXLCCI;
 typedef struct cxl_device_state CXLDeviceState;
 struct cxl_cmd;
@@ -531,6 +540,12 @@ typedef struct CXLDCRegion {
     uint8_t flags;
     unsigned long *blk_bitmap;
     uint64_t supported_blk_size_bitmask;
+    /* Following bools make up dsmas flags, as defined in the CDAT */
+    bool nonvolatile;
+    bool sharable;
+    bool hw_managed_coherency;
+    bool ic_specific_dc_management;
+    bool rdonly;
 } CXLDCRegion;
 
 typedef struct CXLSetFeatureInfo {
-- 
2.47.2

