Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2D26A1CC
	for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 22:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976910; cv=none; b=khquYdYwZLEJQapNaohCaYvt7Y/reu4mds1QOLTIeO9qE/f2ox0zj24EGOOfBM1F93uasj0a5ulFzptJJEO1FDlwCgY1nKr+p4MWgfE/AqQhXhByYK7KwQr08Qln/X6j20a/HFZlrrTsMZxkad7HWpKph+1O1dEljkeXbgkPCKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976910; c=relaxed/simple;
	bh=rTvpWNbDrhIR1nS7APauqJV0Fde3Al1PUuSUIr4yT/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZBzv7QWHNr+cq9nKkDncIVrA2iCR+NXIioBtVjp/Gry6w+dd4macgD6vWMKxH3YqyrC/DJCPbSrEvJihMNdHJPf5JY4LR8ua7aoRxCp7uYjkUbygwPxH3ITesDEab+HkBAeoWCyCr563Q+DRJv87k6DgKHwplI0X20BAj7JfW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkyxSD4W; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkyxSD4W"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2363616a1a6so15457075ad.3
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750976908; x=1751581708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4FJYJ8U4O5w3tqy5MpavB61ZpcaWiN2iAUIoKHfFUQ=;
        b=BkyxSD4WzprK4bGKacjdqsWeCX27/JptfXrEYdC+GpxWb151RLDS+q2GAgIjBy9KjL
         h65EtLwcQ/pSV7BVAZf342w7cw/BFgrhxOcQGJwYeemNSxdH9usV2BNDTikfXfZjazyj
         39Ny1WtViNd6zqrnbREWm90MMATsXgFhZV7N2MmE0Y5pJ6cfibKe2zqCInlxYT3HyrRn
         C6oTrE1trJQax0crI8lsUXPY7XyzyU966RKzpAyYyEamveIZ0GzN6Gra804s4NkjSw/D
         XFQS2FICNXEu5PDGmJudjM1F6e4oPEqjgZLFFzssiiUcMRtYDB2TZebvbzwSfj57JIxT
         PHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750976908; x=1751581708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4FJYJ8U4O5w3tqy5MpavB61ZpcaWiN2iAUIoKHfFUQ=;
        b=tgBk+I4T5Q1GF2Kudr8BHnt3sziqBJ6BYtrqteGFy/6NFTzAjGjvTPJxqxvPxGjHNd
         +82UslS+BqvmStYUYNfF0gLmr1kXw9ynaik5lkME9dc6WXcDqeC9S2jc026jc2pfB7FU
         AKcrZDQXzjtQ77Qf9Wl/R21yYUFY5x9EiukDNWLAI03dNIM+1NyZJzOBq680tli2xHD1
         sgbc8/lptx2jXqZDCs3cfAugApceWARoUHqkSKTOGaMf3ix5AvelG+QiKqIg++pE99qC
         tNeDk5RsHIdAA0y7vvXjddG25KKevnTapWbiNK77X3IX5pvVjUx42q1R3eD5o6ClbO4/
         e7KA==
X-Forwarded-Encrypted: i=1; AJvYcCUnwCMxHR4tqGzCeaVjQWRVNTLDTJ5bcFwE+wPEsGih3m3Xz8ZyCwsL1pHYWHr2WCSXxXznlSZRQYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBycwS6vnFiSSD4cGGsAxUYwTMtouoVXzUj8kTw9NNWW8816GX
	3UvH4h7o4CZITFLBpkp3SbGMyqO9mQ0m/jP+pRtvoEGA7BdS27EAQOdf
X-Gm-Gg: ASbGncuf1/jF4aDtho2/VXO19QFCS6cF4jzvqqkP1nhRGm1r/DQwmUqC49LAtGJwlK7
	5e7FRHxOmXa2hqDERN0PPWp4ETuUJHIxN543lXKAFkmekkyfDtkkPL339vGPgrej94bY8cDJsXH
	M/FKkWUVjRgriHTmkEXhnMRZbng+hYmbeeGSop/Yee/kWxf3/9cJnTGw9SZpTCuykQ5hAnc2NYg
	9W9nsSiJYIFgTIXZRshSPlonsRyjfVCjp0aXVtKedEYfCLd4/+T2tZRvm3imBGgyaFwTutCL42P
	K4WT+EVWn48uiUlZJPmg3StF3NFjApjW+fIWIm5pf3Y0djthdEAKiR8KDDAINnpVNv8hKGLDfBi
	NOo1wbtM=
X-Google-Smtp-Source: AGHT+IFPGI/jENu1Opk6rzXQM1PGC5KaqM00tRrzeAzqShzQOnfmyVlrJeo/YfMr80WZPQXkgnxrGw==
X-Received: by 2002:a17:903:1b6b:b0:234:8eeb:d834 with SMTP id d9443c01a7336-23ac43d318dmr14505035ad.16.1750976908121;
        Thu, 26 Jun 2025 15:28:28 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 15:28:27 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	alok.a.tiwari@oracle.com,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v4 07/10] cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
Date: Thu, 26 Jun 2025 22:23:30 +0000
Message-ID: <20250626222743.1766404-8-anisa.su887@gmail.com>
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

FM DCD Management command 0x5603 implemented per CXL r3.2 Spec Section 7.6.7.6.4
Very similar to previously implemented command 0x4801.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 76 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 69c618383a..e3d54ed124 100644
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

