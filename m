Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648D2AE96
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 00:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663517; cv=none; b=p6hE8HTAn6o5exQMMbqVDE6qFBCtWA+d64UR6nFMj9wrc3YzMMgK0IrEPM/7U7nqDDh2tLkDflsbSI4M8RM6L7V8QSNFa1Rax6IIpA9E0MXFUHhwP26EmaP5qKBzOmZGD7XWh6An8CgWg6d/FosRyEpjsyr4goLFh8G+r9aR8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663517; c=relaxed/simple;
	bh=hz8YGzuLgDA/9A9dfv2bTEcBs4B/ZbbRXkQPw7QTylE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmZVx8U0o21j2457PMYh6WbvyaXe+WxwgnKIBCO6P8guFadaFG02KtEVJKBl4OZ0PNY5UsFg5VFK1+yGv3sgIz4PqRR9vmRNcMr3Pv32vyJUP6RqXoQWxB4ZvxWAEzIaJEFaqVxC3iomIay/2N+JVx0TbvFovyKpsH0/zCK5arA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K95U3XDB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K95U3XDB"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736b98acaadso490979b3a.1
        for <linux-cxl@vger.kernel.org>; Wed, 07 May 2025 17:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746663515; x=1747268315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7+mohXqrdEbWb/P26+vE06tjBRbP4oy3sTl3Q0AKe8=;
        b=K95U3XDBKdSOG8R+AdgpBp1vqcIawPAilkmC2a928n2VnJ33JwMFWFMUatXk4svW0C
         ejgQbIrrvvrzi+vCB0MKFu9Irec3QupUIjV0AFrI39XUDylUwQWcbEC/i0zeNcZeK31G
         VBpSzhspWN4z8NxZTizqwWjLIzwUG2SSE0gZ/lHt/nhSDUTcmR/+qdOAW3l9AKYC5fAB
         JrY52zd1A9cr0MDmxOEkNHF7J0Dn2r4+zZsLn+PgIpp3lAoqD5QvEFgc1nvGTmBbopGc
         xs2kYInNuFz7Qr0Xh/Z31XEMd4hx+4aaH2MlhgANvgUlsHCshxp0diGCb/ns+Yk6DeIj
         fs+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746663515; x=1747268315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7+mohXqrdEbWb/P26+vE06tjBRbP4oy3sTl3Q0AKe8=;
        b=GR57C61EzMivqhf1KXAUDflSk8CJSxBL2SXbIWsmVebA8rAEvrTCpF5od4jjX5J8ot
         epIH1YDV7B5nrt3ybQremQQgIOSRSH9i+xbTcPp+OqZhAcUVjhK8eMYKg5YaeTqJfFz7
         mgGqdRA/HPDA+fV+kBqllEgfzrxYb7WBH90ojYZbk75N/dzNyxKWbuTduyI2iPvS37w6
         kZxOI9MZ/6w7A+K7ejvmqYeK+qpcibYGCj3LwcWbxsNHz4YPLim9A9dG7X2caysVwKrc
         6JXEWh1b9E/3LxPrZ6sRYVeous6aLLkYZVRgcKrSQbuB8mgxndY0R9zUx8hdB8XcNLzD
         OJjw==
X-Forwarded-Encrypted: i=1; AJvYcCX4gZ/bQSzlnvA7JztM/3gtXZ4+6/L+27RvnFUE8mZ2elB3PG5UokGbrMdCBzAUXQwvZXPVldzoDKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaEE2Uy94f2SbioUa7rE0pHXT6G8qIHlLB06XoFFDtuGKu4cOS
	htH+j9C8+k9FiOAHabygO29C4PNKxeTti+QTMHha++kGb8K+Z2eE
X-Gm-Gg: ASbGncsIj5pCwH9XgXreBSS5Je3KYcEZowqutdDIHaxbm78c5I+X3nv7bRUiPel80Em
	gqoaAoeSpDTODM/yztqp9FYCGmQ8rfoQ7RPi3opM3hniZUBwhpXMeXealjcI+WSxsRFpSJqaEHL
	RRdo6eRDOKN793EjOHocIg/2w4NjtzOKmuoJdvEtAF97DGcVIF7bXN7mzYHNB+jXy9Xwh1lxUm5
	AUeEFYNkTUgZcck38U7DtRrgQRkBapRUGVHh5DMBOv7j7GKiV1/C3hZjCwSQdXbXQPrkOv8IyIA
	UuiU4VRWOlaMIeD4rWG3uOqzA9BFkDJu+HGTYEyjVY2OQVrlRSniAT5kvU6g4g==
X-Google-Smtp-Source: AGHT+IHibVqj8jZcLyVDhgi+myiefRMZk3bIo6OqeV4F51rIZRhUJ3r6wDFKZ2ARLgO9wOaFTfcN3w==
X-Received: by 2002:a05:6a00:ac86:b0:736:32d2:aa8e with SMTP id d2e1a72fcca58-7409cef5bd4mr7444822b3a.6.1746663514799;
        Wed, 07 May 2025 17:18:34 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 17:18:34 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 02/10] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Date: Thu,  8 May 2025 00:00:58 +0000
Message-ID: <20250508001754.122180-3-anisa.su887@gmail.com>
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

FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 56 ++++++++++++++++++++++++++++++++++++
 hw/cxl/i2c_mctp_cxl.c        |  6 ++--
 hw/mem/cxl_type3.c           |  4 +++
 include/hw/cxl/cxl_device.h  |  1 +
 include/hw/cxl/cxl_opcodes.h |  3 ++
 5 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ed3294530f..d3c69233b8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3280,6 +3280,52 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
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
+        uint16_t add_select_policy_bitmask;
+        uint8_t rsvd2[2];
+        uint16_t release_select_policy_bitmask;
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
+    stw_le_p(&out->add_select_policy_bitmask,
+             BIT(CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE));
+    stw_le_p(&out->release_select_policy_bitmask,
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
@@ -3401,6 +3447,11 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
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
@@ -3703,7 +3754,12 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
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
diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
index 7d2cbc3b75..dd5fc4f393 100644
--- a/hw/cxl/i2c_mctp_cxl.c
+++ b/hw/cxl/i2c_mctp_cxl.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
+#include "hw/cxl/cxl_opcodes.h"
 
 #define TYPE_I2C_MCTP_CXL "i2c_mctp_cxl"
 
@@ -198,9 +199,10 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
          */
 
         if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
-              msg->command_set < 0x51) &&
+              msg->command_set < PHYSICAL_SWITCH) &&
             !(msg->message_type == MCTP_MT_CXL_FMAPI &&
-              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
+              msg->command_set >= PHYSICAL_SWITCH &&
+              msg->command_set < GLOBAL_MEMORY_ACCESS_EP_MGMT)) {
             buf->rc = CXL_MBOX_UNSUPPORTED;
             st24_le_p(buf->pl_length, len_out);
             s->len = s->pos;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 11c38a9292..7129da0940 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -8,6 +8,7 @@
  *
  * SPDX-License-Identifier: GPL-v2-only
  */
+#include <math.h>
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
@@ -766,6 +767,8 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
     uint64_t region_len;
     uint64_t decode_len;
     uint64_t blk_size = 2 * MiB;
+    /* Only 1 block size is supported for now. */
+    uint64_t supported_blk_size_bitmask = BIT((int) log2(blk_size));
     CXLDCRegion *region;
     MemoryRegion *mr;
     uint64_t dc_size;
@@ -811,6 +814,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
             .block_size = blk_size,
             /* dsmad_handle set when creating CDAT table entries */
             .flags = 0,
+            .supported_blk_size_bitmask = supported_blk_size_bitmask,
         };
         ct3d->dc.total_capacity += region->len;
         region->blk_bitmap = bitmap_new(region->len / region->block_size);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ca515cab13..bebed04085 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -608,6 +608,7 @@ typedef struct CXLDCRegion {
     uint32_t dsmadhandle;
     uint8_t flags;
     unsigned long *blk_bitmap;
+    uint64_t supported_blk_size_bitmask;
 } CXLDCRegion;
 
 typedef struct CXLSetFeatureInfo {
diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
index 26d3a99e8a..c4c233665e 100644
--- a/include/hw/cxl/cxl_opcodes.h
+++ b/include/hw/cxl/cxl_opcodes.h
@@ -61,4 +61,7 @@ enum {
         #define MANAGEMENT_COMMAND     0x0
     MHD = 0x55,
         #define GET_MHD_INFO 0x0
+    FMAPI_DCD_MGMT = 0x56,
+        #define GET_DCD_INFO 0x0
+    GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
 };
-- 
2.47.2

