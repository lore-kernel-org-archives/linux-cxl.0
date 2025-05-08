Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C76835966
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 00:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663520; cv=none; b=LsrK4jgRe81Ow8w7I9c5HB7FHznO+obov/dty0m+UkD82jzF+Zf9UGG7VnTpzoqtl7Gsli2hspCtRr8Iaae/DQPAB6xR2twTeBoH3GpJvmBpPdi+uWOC5tVfMgtrI9oGf//Gisx+UAJ6BArn5747Nn09VKftNUkRvqLRdodp/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663520; c=relaxed/simple;
	bh=GCNs5nLPOcUmL8/lm+WvsIT1SGkBhlEqZJ+At6id6zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTP5fLf5ignhLYCj3yYWFcVKEw+/rypGv9ylSOeOnI5/5TkXhddaGD45Dg8F+fZGCLMuNhhVZ7Wl752f/XKJK1i84V2zxRJYK0Ltru8QQaihX39H2YQq3RzozZvyPNfz7ONJ1rms177UPILChx144Pgf31jO6IsGycPorMM3T1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGkxLrLD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGkxLrLD"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so414029b3a.2
        for <linux-cxl@vger.kernel.org>; Wed, 07 May 2025 17:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746663518; x=1747268318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UzfCXhOe5/C4YaZOPQC6pTRxKyvgdqK1nFkuJEa6WE=;
        b=bGkxLrLDF53c/d3/ymS+b4AUGcfsOX6mnTOCKKIqJYqymvYR2yPbSiZODThLWR4ZDN
         n/YiTynTk0bgB5ryxHIPURn4uAwMkfJ/JBV2Pz7sa08ZHZgZycrWB+gKb5ofQ/hQ5zBn
         keByh2OApYLLB9LrX9v2d5hJs7xlaA/Z73HKdM09cn5KETNWMfsm/qP/YolnAYxMbiKO
         /ACehPk6yECEir8PHq+YpUIGbXLURxFlTu7XF2Pa4ae2H63DsEq144vHJJ7/fd/uiz68
         TpCv+4RX//cXteYNnakSl14wj9xpk/oHBoTfL5hReQFKbatB7Qmisjx5XJS5VgMgcbR2
         j9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746663518; x=1747268318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UzfCXhOe5/C4YaZOPQC6pTRxKyvgdqK1nFkuJEa6WE=;
        b=qDmKx98lbn44YY/h3/CBkEn0d06V6WLr+wNktXMg3XSWT2yS5hHdHupXwT9hVln3G2
         i9V5YZlEuwqKF+T6czsx5KqmC/9QofJg3eZ0NkTgg/dAyVYIUPzgxn0DxxINSBccMw59
         VRM8xhyNLoiWCcbvHl5yUDAfI8JWkRJWyUt89uTCyXmFqUCdgPT8M5hc+WsCSHc/BsfE
         ScSx+4+KF2iR5yWAu6401bAHK+hoqhxPhGP9uucDLdlsVsYwB9ZN6YBP0ftnuyCr5mP9
         BNe6U/tka6ku0A8/fHqt8Pt7JpWDaOJ6OcXxN8Ph924aVHPHdP1tjmZxcxNU7H9GJDb/
         NX0g==
X-Forwarded-Encrypted: i=1; AJvYcCV/2XKKZKxOQxk3kbYcX4d52HB5itxPt96LDE5krZJxYdIfkXl+b/NDuBJqu9aJpbadrkCBvdqbKtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jJ9u14OOR8ji3J/CGLJ/tvybP0FqAqMUPgaAW8hKqaT5l9P8
	GdtM9YYwiCF8XmlHo+WXfb8e0G6yvN+ixSEvQdpBJ8REvX1M9gyF
X-Gm-Gg: ASbGncvJdrn/VRNvvkoZrkAqF89XAXSv/RBPcOVpyFsw25XRs3K+JeMbtuZTqRFyeSZ
	CDAq1ByVmMw8Sf2t1MW/IY2D3Ahpp2RwFJxviEUlQmpZTHDwIWOq2rGWd8W34NbhvO9/LbATeeB
	cjRnWuMdofjdP+lJMbkz4sramrXRsyNTw51AFmF16s+WEGnRNhi+6jZeItPw9BUkG3uKxB+bNUD
	sutte9rzaM45tiiXy9bV550KMpG7kPE468jJXHU7sHITJQiMa+LtFohNkCw5qCLhpZmAoGKVqht
	g37OkUpbzRSNfgJLU4xQLtcwP/Laj5kh8BYQU0nbA5hVBMQ8tqHL/55aeXeENA==
X-Google-Smtp-Source: AGHT+IG+o8P6V0KtyS2bloAjWwn5+vJfInoujb7IZk0nbc+BciMONlU9JhPHCNfuuvvvfLldxwKgNA==
X-Received: by 2002:a05:6a00:e8e:b0:740:9abe:4d94 with SMTP id d2e1a72fcca58-740a9a97d28mr1701296b3a.21.1746663518380;
        Wed, 07 May 2025 17:18:38 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 17:18:38 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 04/10] cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
Date: Thu,  8 May 2025 00:01:00 +0000
Message-ID: <20250508001754.122180-5-anisa.su887@gmail.com>
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

FM DCD Management command 0x5601 implemented per CXL r3.2 Spec Section 7.6.7.6.2

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 102 +++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_opcodes.h |   1 +
 2 files changed, 103 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d3c69233b8..6afc45833d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3326,6 +3326,106 @@ static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
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
+            uint8_t dsmas_flags;
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
+        build_dsmas_flags(&out->records[i].dsmas_flags,
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
@@ -3450,6 +3550,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
 static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
     [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
         cmd_fm_get_dcd_info, 0, 0 },
+    [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
+        cmd_fm_get_host_dc_region_config, 4, 0 },
 };
 
 /*
diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
index c4c233665e..68ad68291c 100644
--- a/include/hw/cxl/cxl_opcodes.h
+++ b/include/hw/cxl/cxl_opcodes.h
@@ -63,5 +63,6 @@ enum {
         #define GET_MHD_INFO 0x0
     FMAPI_DCD_MGMT = 0x56,
         #define GET_DCD_INFO 0x0
+        #define GET_HOST_DC_REGION_CONFIG 0x1
     GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
 };
-- 
2.47.2

