Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBEC35966
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663518; cv=none; b=e6SpoNwmkNl08D/xdJ6ILzfAvbn19sWvngjySaKEaxo0xNp7rgK8Bir8BftDdKmGOqNHELCwTUcX7UPVldoHlQeyiVL0Sm2DJR9/bYqn2bvr1ywK85Iuf2gvCMY9q/6uxCfEmbbJ0smnA3E1S7KA+V8mSNFWdHVKTL8nG9VGoj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663518; c=relaxed/simple;
	bh=OValJf5+XVtJg1ev/swD436uKK10Nfp1UOEDpUHPoF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Um6qbRAAAi0tuh8ObhjrwW8Pueb2lbXCoqkdJuJZsCnonIddSrTiyCiSk0leEmC3FoEYzVCNT5SNieM3ZnqwYQAcrvjyJwpKoluB4E7BsyHScIYe4ypeupG7bJ/gniEI/CUSwTbW7ChQkKZyctXogw5AZcFrytCdHNFY4kr8aho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diaTTn+q; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diaTTn+q"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7376dd56eccso486140b3a.0
        for <linux-cxl@vger.kernel.org>; Wed, 07 May 2025 17:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746663517; x=1747268317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24J3bQARsJAxNOHuQ8xXqx3aKqY63r09Vs0+/glM9oo=;
        b=diaTTn+qRKIRKyNhhG9n43PYkIO/HuRVeCWNGwLiZKvki8OxR5S313ho2o26Tm5Fyq
         FiyFeLUXmQVPVhrF8KIwB9nE9DovcQM2NcOfborfUpQ8c8gB2Q7m3l3DBjL3W54yJALt
         ifmYcqksLqaopC2Lz4zLY3/+2grlHHy6mYVLhkWNJ4shKntiRilCqkaTNlXhW7eNpjYa
         On+pzGDhBaifg7wq3Tt/4LU1kdMkqoLnB7aKZUqrG49i9ftskRF8M+2bw0O8QdeadGyx
         dVMV/ArD3lhJe01uxTd3MEXiVjAMxlIbrDqRJrkizdYdJfv6H1G2konpFuaYoBLuf4py
         wRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746663517; x=1747268317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24J3bQARsJAxNOHuQ8xXqx3aKqY63r09Vs0+/glM9oo=;
        b=P5+wHnyeqSwCt52TjTqr828RBSEYsxsvyd44/cdwl1yWCyxSp0K9ATbqMeXjpt0M79
         9nPncc6NvLJThE6CD7eLTO6rv7iR+1zjpiz7NcGQjel9njNaGBzuATPiwoLhfdolR5xX
         KN2SuQTvTXvpmwSSCwEwiGqcqzwYsnIc1nL2SwWLtyuWu1T1KhlPRlwJfdKtKC6f5x4F
         aznmvxR0fdevC1W+1C12udTK1RFEL3QzqgGYpk2Qk+kDQrG+gx5z6K+1UTqlXpgkU2/j
         HjnWjZOZbN4ml2BPWXGTvY1FyJ0s7JoiynqAMVv9EhqqSY7FnIBjBve06hnumTfelRAf
         lvRA==
X-Forwarded-Encrypted: i=1; AJvYcCV8JRh0HXw26Tybi4UYaKOIDzUQTr43iiTR3mNkXzdUaCUSWJTlUrxHqSFVskAAne2vi75cRGb+MtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlukpN4OznxsKlga4Wdphx55h7n2nL4ane8e6jyKubwnOpj8fv
	X6W2a2Pky1UdYExkfdz7zG4uXknROPCmq+357IIHo9/ow9aSAtU7
X-Gm-Gg: ASbGncuhvKM8pvVfpvCNaF5mNgiIXHGQr6jACkHkqa+FlMeU9qV51VZMrWhWAGgpt13
	rILXXjG+2i13jMarDp7gcbIqFLyXc5Hvcu+MJBJtVUd14lZu42VDIJ0XcCwkYlq5Li/+XrIe5KX
	2qA2/UVlBCuUxudfhFIlyQdyTbvSCeA2D247BqBdyxvgRMI8ED7j+V0Le+BJ6QN2fIxcJKQw5Ja
	HKp3SZOfc7ozuUvl2NqhV2QmUBaI/iJEXoJoXDaayN8StTCUB2bi5rVhQlN/+AmXSKDnmRyllR4
	Jf36YD8Lg28ZH7ta4LDshDgl0ZVNYo8C6KKb8kifecjA+J4dJI0mO8M7g89ljA==
X-Google-Smtp-Source: AGHT+IGoeqjRK7ZFr56WSw5bWPKP7f1TV1YrmaY01bM+y2gZcRS32IpW/MbpQWlGq8gyRlz5VeG8lg==
X-Received: by 2002:a05:6a20:d489:b0:1f5:7eee:bb10 with SMTP id adf61e73a8af0-2159af312a7mr1779842637.8.1746663516792;
        Wed, 07 May 2025 17:18:36 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 17:18:36 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 03/10] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Date: Thu,  8 May 2025 00:00:59 +0000
Message-ID: <20250508001754.122180-4-anisa.su887@gmail.com>
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

Add booleans to DC Region struct to represent dsmas flags (defined in CDAT)
in preparation for the next command, which returns the flags in the
response.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/mem/cxl_type3.c          |  8 +++++++-
 include/hw/cxl/cxl_device.h | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 7129da0940..05d4c861f1 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -232,10 +232,16 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
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
index bebed04085..cbcc1bc9f5 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -177,6 +177,15 @@ typedef enum {
     MAX_LOG_TYPE
 } CXLLogType;
 
+/* DSMAS Flags Bits */
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
@@ -609,6 +618,12 @@ typedef struct CXLDCRegion {
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

