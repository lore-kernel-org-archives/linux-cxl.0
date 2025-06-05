Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE51827FD4F
	for <linux-cxl@vger.kernel.org>; Thu,  5 Jun 2025 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749166965; cv=none; b=feKPj5wJvbGcvMZCt+QPUa4ASZ5a0AjIDuyIQbcvlpNcLFSgj9oZo8k6tLiBMnjigVpA6AyZZngg4bBeojsbrjB4mFE+gRKh2XLFep3779ToOozM/iOicPaP6o8Yxnqslu2b3bvYP6Nz4OyPlqyvretrjVh4rrwyb2i0MdD7nSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749166965; c=relaxed/simple;
	bh=l4CG3eXmri+zYbomHZCmylaRZY32iQiyHFoj/C7/5es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryKZDIs0T5epZdW5cnZP4aowPjW5oRnPCzUXzpBUqeN1zarKMCXOratHdifGLojK2oe82cH77V05X25H5ntykDqpd8tMjKon7o3tzbLY5pGHXiiggGb8cbuX6hXtNTyze6u2qN0iOjH8obWiouQDW7Xfa3nfbfxVhdFnW0P0Jv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K40vqZ8N; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K40vqZ8N"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742af84818cso1176600b3a.1
        for <linux-cxl@vger.kernel.org>; Thu, 05 Jun 2025 16:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749166963; x=1749771763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oEmtdkJsqGS/x/sZAr6F/pr5dRN3cjaHb+H2YFOvnI=;
        b=K40vqZ8NkUoIQ5v8OKjIFYWFlIT/Qj1zVt8u8l35pbsjTnXx962cCZ0PQ2zJ/RgVuG
         xsF6wbQIz4dNVUMOObxUJPIHisPazuMuPTx1nEBBBOfdCqHsZ1YH2NKppI8Gcod5wWZw
         0gWmT6nbHyyLEvd8wKEy3jtwPh43iH12KnDJhHO02XI+sFiqQAPRW+xPEWq4l3RuP20M
         mtdpMlXXUjbCxnNeVLl7HKCJ0LrPI5uIUKlPpzMIvpqA0baDwgO4Q8lv8i+IS4F3FGcu
         3Rk7JupZtm8yzHS4e/4A3JSO8UBRr5phq7g7Bzku6LuP6Qgaz/Pmfp1aW0n1/uOWA8qj
         0O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749166963; x=1749771763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oEmtdkJsqGS/x/sZAr6F/pr5dRN3cjaHb+H2YFOvnI=;
        b=oZ6TyZboGeuvuwUdAYzt0Ct5NM34koJNJ382uITN0GEAfIuuiSCc1+Vw40ZYjmylwo
         HDxaGmh3jAV9GLpekAJ67JW13EJW5AxwIkEiprF6r5UrY1WEAcAAGRcBGzBMkYFkJP0/
         8wPISfDEbQH9AttmnHe9rO/TNENevz603LvPNpYiIBrMZVcblW3OF22Qoei7+aywpXDh
         a52QCJDLEzxSAqnMTIn/x5hu0uZcNdGimc+ztsVuA8qHqkDmkjIMP6Eke5xD0+P0Id4e
         A56bqKQ8DndHDPS1vzFdp6Bl7wZ26IDm/C1t1pb68s+62YIUQLD0aClXIomeDFtWSaU8
         UXdw==
X-Forwarded-Encrypted: i=1; AJvYcCVMqU3/GbZvH3IeArQN47G8YzWlYoxwU1vvo7BAWqgulEoWOI8Eqdd6iiFQSfVhI9it6gBTgJzM2qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK9eFmc4ehfeBqNIN1sztJA798tG11mHcbNcmlntbii36e3bsw
	jMY6jEMIM2F56TT3MuHVfFdnqCoF/Z0MQ+AiDacwY/VsoDfPWgzPUTu/
X-Gm-Gg: ASbGnctwikDk67lHTuOmOSQCKDYBdHo+cfssOHH2iu7nYxFqnplzEStDqzfZqQRGGzT
	2SK3aixGdVUTKhtqM2/BHHMby4LZPyfdLi9AmB/E/3ZaLkPtk3AXfiDJQf9oaMD84ylt7zvQbnl
	goHf/W9k+Tzfd21F05h2JcK+vE0m6jcQbtvn4ECeJVK+eD0riv124FOgRtDxbF/0yI+b321fVMj
	QbBVDef+xjB7XK8M95R8Ab6+I2hfreTga820RHaVEUBCsT/HFLq0L5+hTeanKlrgT92uADDbKCt
	zTPpirSD/F9ULG6Tpzgo3S+kjYGydnmZ1seG/rTUwWezeJI0PiU4o8CAE43eH/HDfJZCAPCi+4c
	SFXFOMk4=
X-Google-Smtp-Source: AGHT+IFRCuu4cMYQof8Df+JoU1vvBbDbst0D/wIifD7pQn/OeD7hJZhbK404iYgZEQ47fpKgebP2Ig==
X-Received: by 2002:a05:6a00:9a4:b0:736:a6e0:e66d with SMTP id d2e1a72fcca58-74827e7ea01mr1995951b3a.6.1749166963189;
        Thu, 05 Jun 2025 16:42:43 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 16:42:42 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v3 7/9] cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
Date: Thu,  5 Jun 2025 23:42:21 +0000
Message-ID: <20250605234227.970187-8-anisa.su887@gmail.com>
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

FM DCD Management command 0x5603 implemented per CXL r3.2 Spec Section 7.6.7.6.4
Very similar to previously implemented command 0x4801.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 76 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 47b1509a0e..004e502b22 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -122,6 +122,7 @@ enum {
         #define GET_DCD_INFO    0x0
         #define GET_HOST_DC_REGION_CONFIG   0x1
         #define SET_DC_REGION_CONFIG        0x2
+        #define GET_DC_REGION_EXTENT_LIST   0x3
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3466,6 +3467,79 @@ static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 section 7.6.7.6.4 Get DC Region Extent Lists (Opcode 5603h) */
+static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
+                                                   uint8_t *payload_in,
+                                                   size_t len_in,
+                                                   uint8_t *payload_out,
+                                                   size_t *len_out,
+                                                   CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t rsvd[2];
+        uint32_t extent_cnt;
+        uint32_t start_extent_id;
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct {
+        uint16_t host_id;
+        uint8_t rsvd[2];
+        uint32_t start_extent_id;
+        uint32_t extents_returned;
+        uint32_t total_extents;
+        uint32_t list_generation_num;
+        uint8_t rsvd2[4];
+        CXLDCExtentRaw records[];
+    } QEMU_PACKED *out = (void *)payload_out;
+    QEMU_BUILD_BUG_ON(sizeof(*in) != 0xc);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCExtent *ent;
+    CXLDCExtentRaw *out_rec;
+    uint16_t record_count = 0, record_done = 0, i = 0;
+    uint16_t out_pl_len, max_size;
+
+    if (in->host_id != 0) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (in->start_extent_id > ct3d->dc.nr_extents_accepted) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.nr_extents_accepted - in->start_extent_id);
+    max_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
+    record_count = MIN(record_count, max_size / sizeof(out->records[0]));
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+
+    stw_le_p(&out->host_id, in->host_id);
+    stl_le_p(&out->start_extent_id, in->start_extent_id);
+    stl_le_p(&out->extents_returned, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.nr_extents_accepted);
+    stl_le_p(&out->list_generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
+            if (i++ < in->start_extent_id) {
+                continue;
+            }
+            out_rec = &out->records[record_done];
+            stq_le_p(&out_rec->start_dpa, ent->start_dpa);
+            stq_le_p(&out_rec->len, ent->len);
+            memcpy(&out_rec->tag, ent->tag, 0x10);
+            stw_le_p(&out_rec->shared_seq, ent->shared_seq);
+
+            record_done++;
+            if (record_done == record_count) {
+                break;
+            }
+        }
+    }
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3591,6 +3665,8 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
+    [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
+        cmd_fm_get_dc_region_extent_list, 12, 0 },
 };
 
 /*
-- 
2.47.2

