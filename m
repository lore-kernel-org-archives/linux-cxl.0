Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4241267713
	for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976899; cv=none; b=i6wmoW0eq6Spr5wa8i4aytIVElOrqIeTRPRNtZuJCMEJPMQS3njA0LnFDnkPcCFiIL0/FE6qfY340YxYh+ih/jXZPge7LhYIS4viPXzAi+RKp8wRr29VqTAboC1oNDSWAy9P1LSrSMOZp4VR1A5I5BumjCasJpwvHw9UtbtWixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976899; c=relaxed/simple;
	bh=1dP4sPApCjNx/R28sUp6fzSE6DeQ7eafHtgm4TRZMuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5FIMQjWTr9te+oa0DosXXJ2Wz3STzMakZ35jas57AFF0857gfEYBU1J3T4Wernlox5U7AMwwDGxDuZno0vZfDhFSdj9lQxUhrjGRnDwJSgBC7V+s2VJQkSaRUwYrL/R7oT7q5gBJT65OWbDMHSnjv1kiCivTUlOYuKYLkas9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeYQ0BWA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeYQ0BWA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2366e5e4dbaso25054675ad.1
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 15:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750976896; x=1751581696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aklx2xGgDQNbjMLifr3+RHSJMwqIIoFZqjTwJHtrWFA=;
        b=HeYQ0BWA8SKu37dHI18HVQydoSePYw/5im2jF1ucfZMyX2GMgN79OW6eIH3nfnycU9
         F8Oaksi9IpSGP6BwxWl88lmaMZFciyYQvAungs4KOTuxBv9wxP+f1h8V3018kjC5691R
         vJrOrma2WFp9i92ttyoAj8NQR5XIgN1d5NKIZeW5yv9RSicnHxNIyL0gTGTA6OUcjaVx
         JncPiI4omPL+SYHDuA4ssJCigUMxluk783bYK9KXOVi3M3SLnj949djAZR3srl/LPZVN
         BCG5JVlFfmh7mTypXAQbZwwUO53txsSxOd3WhrSuJhtiF0zIiV+wPIwSRfh9tIxdxnNW
         Sb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750976896; x=1751581696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aklx2xGgDQNbjMLifr3+RHSJMwqIIoFZqjTwJHtrWFA=;
        b=iiP6JU686Sy11sE8+ITS2+SNNO5qy/cynIJP+HxlczppaNcUr3y3gUKcwOxLc5AVH3
         KZ7IbURRIitOq+qIGoDDeCqejkRK/06hHKHN41byfq2mLCDvKhZJFHO0Y2487Qg/CUBZ
         MnXUE0vyIXMd5S8YAdBFK3PtP005LPVyrJD40MPJTw1ljibzRUjwlok2qpv2zlLnqiy+
         Mvxg2boykLbpUfkYxN6zv0EMwqxaPEDcln3xrqJudRMJx+QVNWNWNs6nQ3hEoUiwEhzP
         uHb/1+8ghwqUsS4wgAivTALgd24jUfhzkPIyIibhmAtaz1g16a3BZVjNh8vL067rMku1
         MgfA==
X-Forwarded-Encrypted: i=1; AJvYcCUL0xwUniY5ibw9XGCfxWC4N193Dvpii+gePLJUpIFkouXwlcIcH+2vjyVD7NhC3b40eK91LK574kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycBJERKo4rOq7BloXr7YYWLvVdeX+q1hvnjCQQ4UMXMhM62lOU
	tQRmZfkZnVBgQJPA3/CoeR1Fz1aznW3tkRM2eFrYJPv8WTfzowGay0Zl
X-Gm-Gg: ASbGncu3XlFB2upO4P7anJU9/1DMqtYbpt8OCpaYBpnGfBNQaQK9twVU4GscbtZ3yrX
	DxRdNdnwbF0tazwQ3VlovZnJhUAke33enMw1kW5FAxl++9usB4Vb3lzc0Jd9Qkao8CCZJ4e/FPD
	7nkcMychQfqaGa1p9a7ZCRrccevoa50z9eDD4xGImyBcdGhTPUogcSl6mpdRUR8A/OCmV9qQheI
	NBrM8VLzqRNGwhlzupbUurSW2sXdk2GxzN1cHbPhuc5FhCg0tXFKX3ZUoiVZgSfYeF6KzEawsNS
	CoCbpM/VgARtuHNMPEVwt+Tfow80mZMV+tf3PNLn375rhUQRlwclEARnOQzRdYnLiuhwzws/wO2
	xIwCtvH0=
X-Google-Smtp-Source: AGHT+IHz2T1AGTKlgEh04tTP+AB1TPi1D0Imo3NC98lquq5mX2SDbpto25YBL0kXICCj64vRD1vP8A==
X-Received: by 2002:a17:902:ce8d:b0:234:8a4a:ad89 with SMTP id d9443c01a7336-23ac4e9784amr10003215ad.1.1750976896114;
        Thu, 26 Jun 2025 15:28:16 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 15:28:15 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	alok.a.tiwari@oracle.com,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v4 01/10] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Date: Thu, 26 Jun 2025 22:23:24 +0000
Message-ID: <20250626222743.1766404-2-anisa.su887@gmail.com>
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

FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 59 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  4 +++
 include/hw/cxl/cxl_device.h |  1 +
 3 files changed, 64 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3914fa73b9..9a0f8bd2fc 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -23,6 +23,7 @@
 #include "qemu/uuid.h"
 #include "system/hostmem.h"
 #include "qemu/range.h"
+#include "qapi/qapi-types-cxl.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
@@ -117,6 +118,8 @@ enum {
         #define GET_PHYSICAL_PORT_STATE     0x1
     TUNNEL = 0x53,
         #define MANAGEMENT_COMMAND     0x0
+    FMAPI_DCD_MGMT = 0x56,
+        #define GET_DCD_INFO    0x0
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3237,6 +3240,52 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 section 7.6.7.6.1: Get DCD Info (Opcode 5600h) */
+static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
+                                      uint8_t *payload_in,
+                                      size_t len_in,
+                                      uint8_t *payload_out,
+                                      size_t *len_out,
+                                      CXLCCI *cci)
+{
+    struct {
+        uint8_t num_hosts;
+        uint8_t num_regions_supported;
+        uint8_t rsvd1[2];
+        uint16_t supported_add_sel_policy_bitmask;
+        uint8_t rsvd2[2];
+        uint16_t supported_removal_policy_bitmask;
+        uint8_t sanitize_on_release_bitmask;
+        uint8_t rsvd3;
+        uint64_t total_dynamic_capacity;
+        uint64_t region_blk_size_bitmasks[8];
+    } QEMU_PACKED *out = (void *)payload_out;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCRegion *region;
+    int i;
+
+    out->num_hosts = 1;
+    out->num_regions_supported = ct3d->dc.num_regions;
+    stw_le_p(&out->supported_add_sel_policy_bitmask,
+             BIT(CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE));
+    stw_le_p(&out->supported_removal_policy_bitmask,
+             BIT(CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE));
+    out->sanitize_on_release_bitmask = 0;
+
+    stq_le_p(&out->total_dynamic_capacity,
+             ct3d->dc.total_capacity / CXL_CAPACITY_MULTIPLIER);
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        memcpy(&out->region_blk_size_bitmasks[i],
+               &region->supported_blk_size_bitmask,
+               sizeof(out->region_blk_size_bitmasks[i]));
+    }
+
+    *len_out = sizeof(*out);
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3350,6 +3399,11 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
                                      cmd_tunnel_management_cmd, ~0, 0 },
 };
 
+static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
+    [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
+        cmd_fm_get_dcd_info, 0, 0 },
+};
+
 /*
  * While the command is executing in the background, the device should
  * update the percentage complete in the Background Command Status Register
@@ -3647,7 +3701,12 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
                                            DeviceState *intf,
                                            size_t payload_max)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
+
     cxl_copy_cci_commands(cci, cxl_cmd_set_t3_fm_owned_ld_mctp);
+    if (ct3d->dc.num_regions) {
+        cxl_copy_cci_commands(cci, cxl_cmd_set_fm_dcd);
+    }
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index f283178d88..f608470362 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -8,6 +8,7 @@
  *
  * SPDX-License-Identifier: GPL-v2-only
  */
+#include <math.h>
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
@@ -634,6 +635,8 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
     uint64_t region_len;
     uint64_t decode_len;
     uint64_t blk_size = 2 * MiB;
+    /* Only 1 block size is supported for now. */
+    uint64_t supported_blk_size_bitmask = BIT((int) log2(blk_size));
     CXLDCRegion *region;
     MemoryRegion *mr;
     uint64_t dc_size;
@@ -679,6 +682,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
             .block_size = blk_size,
             /* dsmad_handle set when creating CDAT table entries */
             .flags = 0,
+            .supported_blk_size_bitmask = supported_blk_size_bitmask,
         };
         ct3d->dc.total_capacity += region->len;
         region->blk_bitmap = bitmap_new(region->len / region->block_size);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c43a394ce1..1170ac58a3 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -537,6 +537,7 @@ typedef struct CXLDCRegion {
     uint32_t dsmadhandle;
     uint8_t flags;
     unsigned long *blk_bitmap;
+    uint64_t supported_blk_size_bitmask;
 } CXLDCRegion;
 
 typedef struct CXLSetFeatureInfo {
-- 
2.47.2

