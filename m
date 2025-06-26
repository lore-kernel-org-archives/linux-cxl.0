Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96F26772D
	for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976903; cv=none; b=ERKPXwZYOGl921dC/cHTaJfEoG99znttYVvKfTc+A9lZM394hxpsB/AWVPHoCyXSowPfBInEhN/PNJpkLprS/I3np+aIOjDltFgxjsh5bmbKwohVIFeNZPjau8a6FkSee7kxXrXHkPYKVEzEZIRc+Iuv87HIb7rM+zEkgFGqOWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976903; c=relaxed/simple;
	bh=cJMuvnS1n9aAby6NMfc6vGAQofcMwbqWmEhAqjDQamI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaRpAn8Kh+faRN4Jk7YlPgGDimcfR+4bQlOjk7HYMmvZ5Is7b4g2zSaduzcupVUZsrwj7ccSjPnlSu0Robd0WbUxawWxJ/uwb2tURDdWbRu/EjCXmetuz04Gcq8JLVpbRzB6h4HChaCzC78wKY6LpPk/S+DZXTMCSYB18/CZbmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Au5eabn+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au5eabn+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235e1d710d8so20336405ad.1
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 15:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750976899; x=1751581699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/txe+GX1yelBZfnxrTVVuIYl+qM4L46oqnhDie7BELg=;
        b=Au5eabn+6/JzNZ1z7KBUQ9bIiut+frDhAWUAxdNY37mVSrPl9AWK66ni/i3OAoIfgb
         gA97uej/pMdIgW2Jf6k2ttKZM3135tGkNSSz9UrfRTEKTeXPzEe5QfWKvgPWLyYLrDYV
         pd1ZPKJjk/g52MGhofRGJezVLgN/Ktp6EfsJ5LXJII58R+Ix6mPvOKN9BxP/dna8HiM3
         hTEnLJF9czodAOnYbJ7bpw2LEZQ2M/L5bWhoIX8EVTTJbsp2zwha7z4DTKUiVPQHn5hD
         4FyF9+yjp8R/7I5WNOHRmTjLIepLrRJxsaDokdLXZaRVzxWWcuDXU1jnV3ecOcgok+aL
         DV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750976899; x=1751581699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/txe+GX1yelBZfnxrTVVuIYl+qM4L46oqnhDie7BELg=;
        b=AuRgrhCb5Rc9cVE8dZOlitkmSvpDYAfb9QmKbYCOwuUqYqQgzyFXCJ6QEsrOQBRWF4
         r0Z327oFOUdQyRUTxRRSCMrxFLXfnpiDpapCOLZH8tEsKqJWaL5y4LPZ3ifJ1k+xgq9+
         /ROdm9GQmxO9eox7JwYsEg8pDN1W1emNz3jg0SpOkBZ0GBetA92TNBj8+IKeyhG318hb
         PhUb2TwAr02Dtt6ZYu9BtLwmm5ynEEGO3ZkpCQX7pHSLyB2keYhuwQiCL/t5QPEZC8S9
         X89kR8qAOcOfMwqYIP096Tv19PMSCMNFlqYah1FyMo/OdZu3VQgfGjFubIi8P8t42eni
         3SQw==
X-Forwarded-Encrypted: i=1; AJvYcCXB6jENnsaDpiqReffmBf6OKEKGLJADhCeDReii4K76CY727tFACFM1ufBwZmidyrP/GpvC+mF6YDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4orIFSOApMy/BV5UNi78EJ5zOffcQpHiKl09NCVhuS/moqv1b
	EJRYV5QSqj9ChJkhsNc52lDtGq1odvoVhU873mhP/TOXGOPy7RFAHGlY
X-Gm-Gg: ASbGnct+76uL/s13jAUiroVPrrdyHNXAKjaIPpJzXK6SuQzLvJ1B8nVcLyDsTOco+76
	XyobSTTMxSIGjivoU/9j9DoGtpZbYHquMaRx/qF3ab0hfOP5/UzQCuCpj5FW8RdOHZX/WkFBac9
	GLwAsWVSJlKditP6xKLB4tBmUz3eRErjlgVSD83/6wdEK5NOgEWx5SKvotbvSoyrwC0IQf9Xei5
	0tKoIFWtGHihCcU8AfBOaVUyp83CkmtyhkOf7hivFxDLyVadaxNofWaWKnbIqLWuwIYpl5bru66
	cg8T2Bid0cx37rf4E2mTrHLL5wi/umPfPywTLVTx3qA7YXyWhxLbiObvn/up6wQDQ4CvEim6u1P
	ZkOEHFibglqU+vseH6w==
X-Google-Smtp-Source: AGHT+IGlta+/mPFCCDU/bXzB0MEGu5PRj9+kz3XbJlCrBwUqQ7GCFPAD+WOadorLND+c+51S6uQnzg==
X-Received: by 2002:a17:902:e543:b0:235:779:edfe with SMTP id d9443c01a7336-23ac4653fc7mr14517155ad.43.1750976899056;
        Thu, 26 Jun 2025 15:28:19 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 15:28:18 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	alok.a.tiwari@oracle.com,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v4 02/10] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Date: Thu, 26 Jun 2025 22:23:25 +0000
Message-ID: <20250626222743.1766404-3-anisa.su887@gmail.com>
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
index 1170ac58a3..397edcff4c 100644
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
@@ -538,6 +547,12 @@ typedef struct CXLDCRegion {
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

