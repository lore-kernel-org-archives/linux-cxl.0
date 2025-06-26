Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44210267B61
	for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976903; cv=none; b=JXH/c/Dp1YBmNHfPuOTjZOdxnRH0yYL3+gPcHPPCQj9mjXjuG2aqQ0b0NvTXm2uSatTlWiRxmauZHH1wEAxR/67LDoTzjie4deL6nm581sLB/TJf3HOgFCRkqVPDYxdVIRA6rMdb4i3YNIUmzQINvsN45IaavnBOLFN9bsvMdN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976903; c=relaxed/simple;
	bh=rbBkIWmb9ZLYYyFhEF4gIGi/kByyFgzdivdHBeI4P7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n45SfnMSDsLMzU5A2Ywa/RY1l87+dyfpsCn6ok8z4Pdw4MVcjA9IEKFNBp2PImRvSLK7QvJ0zpzZO+PPLYaJF+dolhovg5oAiDYOBHN7kdSrTsxoGd5AnFRlsy6avRk+OUFcdTxc3HMuzDtHcBXIlZN2MRFYIf1264jcHbAyrXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3hQB1oL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3hQB1oL"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23636167afeso17563125ad.3
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 15:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750976901; x=1751581701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+GGKtwzBUfn14ahXvUOzUJbIbHLEyGrCz9OblHISOk=;
        b=P3hQB1oL5/DqvahQViSfm3Fvp2mKQAKkJecCF/ANMNSxBUNEV8L73pHbSHUi0N8lcF
         +SkkG4O8Go/FjFz0nHGsUORLJ3duRijkiPJp29BSHQDN0U09y08mDrmk1aZW8lq5SYen
         InX7jNnBbWvdRI/nua2iHdEChIuyg/pqIHeH/dEA0l68GYGjprzuyBahTP24G/oSiTo3
         TFJlc92v14GYJhrk1UIZoxLh3TERTvAwNVZYarYNGF12DcFE9cYHIYmDnzWDVi9Gu5Oi
         vR6vp9ji2xzzH6BSDKPllYDjHhFDgmtCAOxjxn+BMIBNeTNtdTZRFCJxOq7xhV89Epu9
         4lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750976901; x=1751581701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+GGKtwzBUfn14ahXvUOzUJbIbHLEyGrCz9OblHISOk=;
        b=a1HB+7nciC7wZgaVkkk3MA1kL8Mo9OLCxCPC3w7aLQiMm4hVi7GzQZ1wdh5z6FKZWH
         QFXFq/tRMLAE05kROk5o1B4H5m4fN2oId31BCd5eI09BoTgIm0GBnN9sFvfFIl39Qhso
         zlHmGXYRXhfsUNsmoXxc0dCUaC76st3LqgOXfSrlMCvhFSAhCSnoabXzsY+Q6oFXt3gw
         VmLTlScYfLyMdP2ljEC1uU2sA9MFUHp5O7qHaNRf8D9hbKldvWTtstirvIYPNjs1KGQ3
         1aNwG59OwaRZr9anOJZM+wogY9CYuJ8DBxVIqHDIkEMqax33vcvP+uCkevbr8rJDCoBv
         Nuwg==
X-Forwarded-Encrypted: i=1; AJvYcCVW4picr7/Hj7HsXu0zAB7NZt9I4qHMfYSbujLnzcNFVThvHsX+Pi7wz6XRYTRflKHyy5sFb3kdmHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVDBudDaDj1J5QkBAVafdvB8tBd2Ax3G2UCE3h/gIKx9OIqZEG
	I+02ymdhytZsspM/coCcmeTdRcRgXEjn9YzTpgc93H/MEG46n8Vee7nH
X-Gm-Gg: ASbGncvpBccOgPY+XjSF1gbi87jW4UlOBZ/KpBRNgyjOzbsP9IPhrKLdyCykkHFXoSk
	MXuHVtj1mOF0Tj54S3eDjrMnQ8L2OMiYvsuIt3nBt9r0M/u6NWpxc+MCyWhEjxpEo+Wi2OpjmFv
	g/wTYSODjvBrMRswlzalYQqyK8lNGeoSaeGFOad7XIypU5OTp06Oly2RTyJArmkUF7EGwTd2r4o
	IXJWqvxj5DkS4aq1nzeH3NbclOEy+RTN+COhlFCiwyvfac4iNezBtotMOf9ce8MNOzqhuhkVQU+
	AtF2/rhYxhrhdu5nopuHyC/EvkD4POA4K6YOeIYkA5+luwCMPGFrYY+HAlmKBS2qUb80S+4g+jr
	2Q2yLEJM=
X-Google-Smtp-Source: AGHT+IEXv04antYorBEAkJ0OQO4gMHB5P6HUZXaOyXNr/drr5XPtQtIJi7p4+d/5UHqi+dTKqu35TQ==
X-Received: by 2002:a17:903:22cf:b0:234:8e78:ce8a with SMTP id d9443c01a7336-23ac4636e48mr13604335ad.48.1750976901408;
        Thu, 26 Jun 2025 15:28:21 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 15:28:21 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	alok.a.tiwari@oracle.com,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v4 03/10] cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
Date: Thu, 26 Jun 2025 22:23:26 +0000
Message-ID: <20250626222743.1766404-4-anisa.su887@gmail.com>
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

FM DCD Management command 0x5601 implemented per CXL r3.2 Spec Section 7.6.7.6.2

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 103 +++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9a0f8bd2fc..7f0709a27f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -120,6 +120,7 @@ enum {
         #define MANAGEMENT_COMMAND     0x0
     FMAPI_DCD_MGMT = 0x56,
         #define GET_DCD_INFO    0x0
+        #define GET_HOST_DC_REGION_CONFIG   0x1
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3286,6 +3287,106 @@ static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void build_dsmas_flags(uint8_t *flags, CXLDCRegion *region)
+{
+    *flags = 0;
+
+    if (region->nonvolatile) {
+        *flags |= BIT(CXL_DSMAS_FLAGS_NONVOLATILE);
+    }
+    if (region->sharable) {
+        *flags |= BIT(CXL_DSMAS_FLAGS_SHARABLE);
+    }
+    if (region->hw_managed_coherency) {
+        *flags |= BIT(CXL_DSMAS_FLAGS_HW_MANAGED_COHERENCY);
+    }
+    if (region->ic_specific_dc_management) {
+        *flags |= BIT(CXL_DSMAS_FLAGS_IC_SPECIFIC_DC_MANAGEMENT);
+    }
+    if (region->rdonly) {
+        *flags |= BIT(CXL_DSMAS_FLAGS_RDONLY);
+    }
+}
+
+/* CXL r3.2 section 7.6.7.6.2: Get Host DC Region Configuration (Opcode 5601h) */
+static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
+                                                   uint8_t *payload_in,
+                                                   size_t len_in,
+                                                   uint8_t *payload_out,
+                                                   size_t *len_out,
+                                                   CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t region_cnt;
+        uint8_t start_rid;
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct {
+        uint16_t host_id;
+        uint8_t num_regions;
+        uint8_t regions_returned;
+        struct {
+            uint64_t base;
+            uint64_t decode_len;
+            uint64_t region_len;
+            uint64_t block_size;
+            uint8_t flags;
+            uint8_t rsvd1[3];
+            uint8_t sanitize;
+            uint8_t rsvd2[3];
+        } QEMU_PACKED records[];
+    } QEMU_PACKED *out = (void *)payload_out;
+    struct {
+        uint32_t num_extents_supported;
+        uint32_t num_extents_available;
+        uint32_t num_tags_supported;
+        uint32_t num_tags_available;
+    } QEMU_PACKED *extra_out;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    uint16_t record_count, out_pl_len, i;
+
+    if (in->start_rid >= ct3d->dc.num_regions) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    record_count = MIN(ct3d->dc.num_regions - in->start_rid, in->region_cnt);
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    extra_out = (void *)out + out_pl_len;
+    out_pl_len += sizeof(*extra_out);
+
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    stw_le_p(&out->host_id, 0);
+    out->num_regions = ct3d->dc.num_regions;
+    out->regions_returned = record_count;
+
+    for (i = 0; i < record_count; i++) {
+        stq_le_p(&out->records[i].base,
+                 ct3d->dc.regions[in->start_rid + i].base);
+        stq_le_p(&out->records[i].decode_len,
+                 ct3d->dc.regions[in->start_rid + i].decode_len /
+                 CXL_CAPACITY_MULTIPLIER);
+        stq_le_p(&out->records[i].region_len,
+                 ct3d->dc.regions[in->start_rid + i].len);
+        stq_le_p(&out->records[i].block_size,
+                 ct3d->dc.regions[in->start_rid + i].block_size);
+        build_dsmas_flags(&out->records[i].flags,
+                          &ct3d->dc.regions[in->start_rid + i]);
+        /* Sanitize is bit 0 of flags. */
+        out->records[i].sanitize =
+            ct3d->dc.regions[in->start_rid + i].flags & BIT(0);
+    }
+
+    stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
+    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED -
+             ct3d->dc.total_extent_count);
+    stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
+    stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3402,6 +3503,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
 static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
     [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
         cmd_fm_get_dcd_info, 0, 0 },
+    [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
+        cmd_fm_get_host_dc_region_config, 4, 0 },
 };
 
 /*
-- 
2.47.2

