Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890571B07AE
	for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229827; cv=none; b=dQ/ToZQ5J9EPRxAbXjQRpiv7rekOMrV3tCtpUgB5XudAn2FzyyNUV+wthQ2OG0Ru4Q9K1T3CkqbDQFczEQrdycBuyUfpN2jgWItmKdeaU2vNsU6V5fotIuZbl8+DPwJU0m6CYFCTIjYVCzq6q0+Rz+P8Yupa6MtSyRb3k6rLvvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229827; c=relaxed/simple;
	bh=A4PWJt9Qpchy9QMvURr/5wuYjtLZ8u7YrNRIJEPnZ7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDnljgq0gh6BMQHhllDgmbRYJwRCYNRNAqphSmYR0I/id5lRm1wz/NFoIAlQqDUW77XXNNS96u1kGYSS4348mBODqf+zI8afmLwit0n1EI3w0ruD61W7YvtzeKHbFq7ZN/O0vi/2nlbn1zBdikw2cGkw3n5hc6SnGBOHjip+Jkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LISgX8g3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LISgX8g3"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2232aead377so103205285ad.0
        for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742229825; x=1742834625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/81TCdkrP4U9ftuJqqmxfWdVPH8Vq1OR4n4vbJaQfuc=;
        b=LISgX8g31wN/9P4nKv35OiOajICUprVq4XaJb4ZedMfSvS/yQyvLemJW7svymz66Zk
         f1OieAd6Lm/+gdTjXlvDVilSBo23NcgF8zzCiAk5thjCyC+hbHx77bALsvJpWcOFNEfM
         pRWCFGmeObVsl5lgzlT0QY5xP7QyR7ufny7vbPiX21xIP+6sE3tDdwlbVG8YNyQZJ8Nr
         3wPyHMZBo/dQUZVhOHnuQ5Ll58RAxPFqjWRfyy/NbDz9W2a6zlvhZ6zFtFTspxbTkDZl
         a+ue2DrmEclk3zPQIwx5ASNXvaGQFhU4iLOXCTuLIU4AwECb129Oe2yyGhhPrY5jjj+7
         /PdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229825; x=1742834625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/81TCdkrP4U9ftuJqqmxfWdVPH8Vq1OR4n4vbJaQfuc=;
        b=PrgUMzKQ2ByT+y1q5Qs1SxHbyWNcxL2IJXzlscMzQtBCoK4U3GAQuHsqHYeXS/S3kA
         +OtAnhQRgHvc1zldWiptXTYUSoOfp4l2ATNaQdAJVSTJVR5DC6tyWciZeFwNZWLLVkBh
         S0LA98eJ2s+YgP3PZHiXSaOrROQ4wzwEn5zV9NCRNsVGN0b5IMvdogVVHgPUU+ZWVh89
         YelOBdBusPpFHVgkcBaU7er/aa16uFE+bxQJ+c2+eN81N0lMojWINx4YQWhYMt+4kTt9
         1dQa4oxbEuHAL8CgUPT3mffE0N4H7OXPVL2RtwxVUyM09y2wkEqa1PZ7PC4jEckOOVIz
         GL5A==
X-Forwarded-Encrypted: i=1; AJvYcCXuaD8PpwsJfGAA9eRjdwG1KhAxgTDuzsSRZqeR7h5jMPOjzGNNSGP0Rjw5cQm5JhBL4Qx9etC5fUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd12vZPPsPnV2oYZSGCr515BdjbDPN4e0G4P34NS7xQ3UejfNP
	jDQSAtc5Qw4oVyDhCQi4blRPOD20ap5d0p/hE4NM877o+LfvQltr
X-Gm-Gg: ASbGncvJ95VaXvaPBorI5S8ssiSP6GLtiEXfLvVcp4C5LODDt1rWLeG5ANwpr1kzPpq
	eCY5uzMSNAB9r/qokT0fMhTOROMhwOKv30geVRMxJ5u+y5RWdKE2zBcq+19ik9wHRlzTWGCJl+E
	0pYqDsP5MI0oqqaqi6/kTyZJ15jQa7E0CVbZNMp4rCYYRdqLdKiE4+VAsAytflHry/NDrMQG4+0
	DyM04+dhicK2aelaX2UsWawY8VuCScKvQKcdUiNHlNFLfNoIHwZI8b41ztn0hkcf1awBJWMRGYW
	AA26zxN4r1WlE4D1fLBo/rbiGcYTYnIvkSeMTj4Et/1SZO+I3uF6OReoMNkW+N3w1w==
X-Google-Smtp-Source: AGHT+IFak24zVoWJ9MyZ/aEEihMeyRc3i0vqCnEzyb8zC6JLW9jUB2nMLHXl1QSGf0gpVDtxsB5jkQ==
X-Received: by 2002:a17:903:1a2f:b0:223:5a6e:b16 with SMTP id d9443c01a7336-225e0a15ecemr181984885ad.5.1742229824837;
        Mon, 17 Mar 2025 09:43:44 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:43:44 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 4/9] cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
Date: Mon, 17 Mar 2025 16:31:31 +0000
Message-ID: <20250317164204.2299371-5-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317164204.2299371-1-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
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
 hw/cxl/cxl-mailbox-utils.c | 97 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index e9991fd1a7..4bb51bf3e8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -124,6 +124,7 @@ enum {
         #define GET_MHD_INFO 0x0
     FMAPI_DCD_MGMT = 0x56,
         #define GET_DCD_INFO 0x0
+        #define GET_HOST_DC_REGION_CONFIG 0x1
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3399,6 +3400,100 @@ static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.2 section 7.6.7.6.2: Get Host DC Region Configuration (Opcode 5601h)
+ */
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
+    } QEMU_PACKED *in;
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
+    } QEMU_PACKED *out;
+    struct {
+        uint32_t num_extents_supported;
+        uint32_t num_extents_available;
+        uint32_t num_tags_supported;
+        uint32_t num_tags_available;
+    } QEMU_PACKED *extra_out;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    uint16_t record_count, out_pl_len, i;
+    uint8_t start_rid;
+
+    if (ct3d->dc.num_regions == 0) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    in = (void *)payload_in;
+    if (in->start_rid >= ct3d->dc.num_regions) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    start_rid = in->start_rid;
+    record_count = MIN(ct3d->dc.num_regions - start_rid, in->region_cnt);
+
+    out = (void *)payload_out;
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+
+    extra_out = (void *)(out) + out_pl_len;
+    out_pl_len += sizeof(*extra_out);
+
+    assert(*len_out <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    /* TODO: For now, fix host id to be 0 */
+    stw_le_p(&out->host_id, 0);
+    out->num_regions = ct3d->dc.num_regions;
+    out->regions_returned = record_count;
+
+    for (i = 0; i < record_count; i++) {
+        stq_le_p(&out->records[i].base,
+                 ct3d->dc.regions[start_rid + i].base);
+        stq_le_p(&out->records[i].decode_len,
+                 ct3d->dc.regions[start_rid + i].decode_len /
+                 CXL_CAPACITY_MULTIPLIER);
+        stq_le_p(&out->records[i].region_len,
+                 ct3d->dc.regions[start_rid + i].len);
+        stq_le_p(&out->records[i].block_size,
+                 ct3d->dc.regions[start_rid + i].block_size);
+        out->records[i].dsmas_flags =
+            ct3d->dc.regions[start_rid + i].dsmas_flags;
+        out->records[i].sanitize = 0;
+    }
+    /*
+     * TODO: Assign values once extents and tags are introduced
+     * to use.
+     */
+    stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
+    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED -
+             ct3d->dc.total_extent_count);
+    stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
+    stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
+
+    *len_out = out_pl_len;
+
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3523,6 +3618,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
 static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
     [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
         cmd_fm_get_dcd_info, 0, 0},
+    [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
+        cmd_fm_get_host_dc_region_config, 4, 0},
 };
 
 /*
-- 
2.47.2

