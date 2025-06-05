Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E229211484
	for <linux-cxl@vger.kernel.org>; Thu,  5 Jun 2025 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749166960; cv=none; b=Ztg7SnVhtLA2DoXeW93h3/+4LDcBUax8mGmyQxnNebsXSpWAAbq4YS7oPil7vF/+KVn/UnDLO56Nk+kRK1GZ0t2bXzaNTwwZIk1SYY/4OMqWQOX2TfsrfY2dH3rhQCaWJHHuBlIsmFglQi2lCWQkhooTu9fshmIrShirN/PDy5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749166960; c=relaxed/simple;
	bh=e3odqcd9+NGtCUnxV/hzxtsQZcIm8aYwr0Zum4v+vC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gau+HAbaQaN8IDLTx77u7tjRM/TkTX7NzsgwDR+ONwESNpBCVopTG0r312/21MvP+XlzfXQ3T3GexzfV7VX3BdjULFwVBIyPCKI7f2d9+aZXFDRdYpkYfJH9gssKiTqHNMnz+gEo6dU91tTckmbAxP5g+IcrtMsVZTzSU4mzJ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bem6YXX2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bem6YXX2"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c46611b6so2058766b3a.1
        for <linux-cxl@vger.kernel.org>; Thu, 05 Jun 2025 16:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749166958; x=1749771758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIY+I0zgj1+4vetHwZshTaoH/o7+9GIbx0lfx7tbbpA=;
        b=bem6YXX2QLpg2JWKIDWpLcg2vrpOhJX7DZLrQpSpvbXK2zozcYxYbdcSZh/7spEHnS
         iUlSIe5pCDsNCv+L4PnuFvTpoAGilrghm/0Cy6LeduiWBGqgUrnPkJIof2TWaSNSBMT3
         q6uGR+m56TwUqvbR0P93YmzpF62Wp93cDG7mzmM8gF+ivREgJBsDbrVg8ZZSyRFKHn2b
         IYsEe+NKqJBYNI2Hzo3XF6ZlXApUz7QIPlwhd8IkqRHV0bvgiZglcZ44HApOfiqqOXWE
         lxWa5J9UAdMeU2FX3HhXvL3Xd4AWNM99dJl3YvO/3G3FNleM0pRKP3L2NwoDL+/kqPAO
         iUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749166958; x=1749771758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIY+I0zgj1+4vetHwZshTaoH/o7+9GIbx0lfx7tbbpA=;
        b=VUY7qHy4EYGs7pPzHqEZw6hlRddPn8/ImFVGxr6c9SbCr4paJjwg8U9ZKdb4g+c11m
         PkDtftttXsEBuLKL9bidJ7bqr4Ck9zHmC0/qEotlgYszTFJNtSdrzuP0VzSWZmPdyliQ
         YB47QHe0z/Uiclqp+UVYoAoD+CwNUYLdt2Z/3C3yM54CWGib+c+EdnrxIQONnbcKlpbn
         YZa3yTV+KHpdOtIbiHA3red9vRyszxgHlu0uQ9+pwPl8fLc0IXABo7SHAGxZ8uttEqQg
         ifPWmnYCzUoRewh21TRgfU6/nTn3wnvq8c9Bq4x4XiLgI5Ob4EMn/gZrWOrED3AI31Wc
         leBA==
X-Forwarded-Encrypted: i=1; AJvYcCUkhb4QiEO5HzmM4+fBtdnjFMoBvXmdH+YmHjzPKg4yRm2H+dgXG+ekNE9vdbPa4DWo4Pn+dU8E8rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEdNuLkU5FRkdBpuwhRaTgf6Ab/SEJL0x7vlC6Ne3cKT124HIx
	W2bWeM024i3MJvh+Nn35uF/U8aI2CdHFErbmSq6pNQ8Baiq2HAdJJ8wI
X-Gm-Gg: ASbGnctt14uGIiOiE/DzMMRFq+EG1ujQJQQQMCTAG6u4+lNcTNvRyaKi42wg3DMDDb9
	oiWUNad4xaOK7dlbnqY6Rgvg/0b6QK/tfjJKuNCpET7d7E50k7imNkBvjm+0gJFMndWSMpyABDX
	CuyubJUG05AgsB3E6ktaeMDxjm+5Od0A0Ym4H7vu+W3MPq6yF8Sj5V1z3RXpJ+vJmgdLo+4LFBU
	xGU8H6M0L7fLcTgzixqyt1kDP9rfZGJa1nsTdJJGyzXH6+XPthmFnauYzC/u0Kjt9rGpk8kkSBy
	obLKvTHRuN5aPuDNzh5tFxhqyuNDIBRaYR3oHsHFtMBYNJ9zorjTjh+scmvGtmCcf8EdTxOp
X-Google-Smtp-Source: AGHT+IGAtLS/mBYpscr3DexPLJjBaEgPlCDJ/pp27tquY/jFHAanBx5we4RIamCx0ZeeyRFksGIkYA==
X-Received: by 2002:a05:6a21:6d8f:b0:1f5:63f9:9eb4 with SMTP id adf61e73a8af0-21ee6999fecmr1460105637.35.1749166957574;
        Thu, 05 Jun 2025 16:42:37 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 16:42:37 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v3 1/9] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Date: Thu,  5 Jun 2025 23:42:15 +0000
Message-ID: <20250605234227.970187-2-anisa.su887@gmail.com>
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

FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 59 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  4 +++
 include/hw/cxl/cxl_device.h |  1 +
 3 files changed, 64 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 0b615ea37a..3304048922 100644
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
@@ -3624,7 +3678,12 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
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
index a151e19da8..7eade9cf8a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -530,6 +530,7 @@ typedef struct CXLDCRegion {
     uint32_t dsmadhandle;
     uint8_t flags;
     unsigned long *blk_bitmap;
+    uint64_t supported_blk_size_bitmask;
 } CXLDCRegion;
 
 typedef struct CXLSetFeatureInfo {
-- 
2.47.2

