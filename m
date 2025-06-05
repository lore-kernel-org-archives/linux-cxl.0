Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FC827510E
	for <linux-cxl@vger.kernel.org>; Thu,  5 Jun 2025 23:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749166961; cv=none; b=u8k7SQCtZ/qh29rdjPQ52P9o/MAkrXWEG1QYy0pbhL1hDfMtZCISdEBOosxoZvRXPoPKlKa7lMbPmzN1XmkMxR4c4Ym5LqMYfZIFLY6ukklnHCE33jUHfMX893W7BXlnDa7ZWY7mjw3zOdcbPc8Su9noaIJ7sgVnPb41qOfwRXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749166961; c=relaxed/simple;
	bh=UBvza8HuBbjHU4bh7Zqj/6zAEeM86mF3V1xCRt1FSW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjKDob0+2Vrq0oCzL6CsBSQeceDNl8h1m7hVnyN5yTxhQ2BQnbgLB8+xQwjf06/2itepKtMCy5wtoYrBGvOS4Idc2L11nQf3AGT9FA8MZCB1ouPiP6+j1qquy7epg+azMdHJ3Qt4C7D5gIWoS1m2pKfGSGDANsxlvdGthzKkgdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbNeOA/f; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbNeOA/f"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-742c5eb7d1cso1860442b3a.3
        for <linux-cxl@vger.kernel.org>; Thu, 05 Jun 2025 16:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749166959; x=1749771759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc9CyLeYRP4cGdcJ1FH56qskgbCqUlCPSG4MktpVjaA=;
        b=lbNeOA/fANe9FaDvbvNCmfJOeIfGBXEYWrtuusr3dTx8cPnKuI2CbBkIrFMcNe0aXU
         /Ji8c05KriXw1wzLt1siZNZABAzEt66du08qAk2fV7oM5dQDlAxlpL8WusUhBMkEJcQr
         lwGeQf+d7QPR4y6OozGsozcWlc8olNULNTGLvDTFq7a4yxmwY8+iO/NERurJOq5p4g4l
         4LNQ2yDd5mtw4HcLWL6Xmb3pA1AjFVsG4Cd9xdqT5lqPZoitUnk1N/P5/qydN27gXzAP
         5qmuvfi3BDFVNRpSkLojHtdM6q4tb5PYPiFhiX+Vq4tc1BYci41MuXKt9cdQ3x4iQrWJ
         8E1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749166959; x=1749771759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tc9CyLeYRP4cGdcJ1FH56qskgbCqUlCPSG4MktpVjaA=;
        b=RilWKDFeFXXFFgCkUCiWWs843KtUrqVjWZp4TboZ76uPmKl7q6Ew7zxohSz97OMU+f
         UxpWvYVER0tvA0OP0v4fqFmjDH9ViIcdNadozMgD8WTfg5ZqNetiF7CENFk/TwBT1jj/
         XU3G/SfZUq/rirhOC1w+ZUGDp8VNz5CeXExa1bdJeKub0VcuLocypm+kk0Mr0runncuP
         bSEhnzhjP5bxu5DgsEooiHE8ypaqaJoGe4wvk0JvbJj+eSYVB7s/ndgQmYvHNYy2TiVC
         cMyQorF922YfGcbmKw/uDchbD8S8TTHWWIibPGX5A4ekR+OsQv7IrJ+9grOx/VoTG/y+
         WG2w==
X-Forwarded-Encrypted: i=1; AJvYcCUO72lE9vedfV6Yb9hWQpDQGMcZ54SQ5O/3NjLItLHx+Tg7JUxJKQJ7YNs/B35teFn0k6DNx38N96c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnUHP3BpBqdiZqHX5GzKrndIOdk39QSMydaBQeoaOB5KRMemwQ
	vPeloQcgLJbBk++C0CY0mi2nq0xmD59oPTpFedg+jISEpAl60GiXFBjG
X-Gm-Gg: ASbGncvC9MMryfHtKNahCcjmZEX7A2YQsAUQwuMNvYQVWGM9SfglUK6XCbJBHMzO4i5
	g2VWTGV1nRV21Tj9Oibi4tbMSyTUzKyZEd9g4OxvNHpO8IRSSajBw10t9gjEGMLa54tcy4AGesD
	0/bM2Vrd7AuVeXLFvyWk4G5sX/axFPMIs/bVDC2kiU6WZmBpAYeFNASSrcaP9thl+M8RXanZMQN
	mb+28qVG69a1/C9xZ5FeaB96n7xdl9Ja5QLwriDUikPceRH/GaKjynt4ETRS0z4kAMetorC5ZyS
	LH0Np/chJgNj/DQXUEDNXrtE4Ed8P0E/j9IWwo28i/1LK7HIXp4Te5LPLQVCJdDV1RcwVuxH
X-Google-Smtp-Source: AGHT+IGDBayHHtqYwWofO7lswtiMiuroLrsQuXTMWLGl2lc3iTFH/b4JDWDKEZhD/7by6QWv/IGCwg==
X-Received: by 2002:a05:6a21:110:b0:1f5:70d8:6a98 with SMTP id adf61e73a8af0-21ee139fdf0mr1601468637.0.1749166959456;
        Thu, 05 Jun 2025 16:42:39 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 16:42:39 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v3 3/9] cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
Date: Thu,  5 Jun 2025 23:42:17 +0000
Message-ID: <20250605234227.970187-4-anisa.su887@gmail.com>
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

FM DCD Management command 0x5601 implemented per CXL r3.2 Spec Section 7.6.7.6.2

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 103 +++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3304048922..1b5c7216f9 100644
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

