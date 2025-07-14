Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A6E79FE
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515330; cv=none; b=TOXAM1DZUkUuUBfYOMbUE5hh2DgL1+iHo8jrGxuEa/U32hR+WvRDbTT5GO5Vq0EjogFztaPFXF1dUXUEH81KwWE0rfdXUunz2XVDijm9L0Y8LPOQXTca9cZI6O/eluuDcOkDY9TPvk4fgLGOb5djUkVXoY6fdXRDENG7TJevjxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515330; c=relaxed/simple;
	bh=/ZUOc/6p08Dsm1wxayc2kdc3WMh2/SkMzBVm1Y9cvj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3SC0ybxp166TiOctDQbkmMe3lVqWOIkwusUqmCMp490bHjjozg8Xp/eqCorqMN4GbeiMyz8PKYhr4SamZ3ucsBxSCJQGD01Lk5MKjAYlC/yjQow1jKZ3U+YDxujTK4T1ng22gqSliqw3LM3oH3szSE3FHb+wuWT8OM68Cdo2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgqXY669Tz6L50k;
	Tue, 15 Jul 2025 01:47:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 03E9A140142;
	Tue, 15 Jul 2025 01:48:47 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 19:48:46 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
	<fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>, Anisa Su
	<anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu v2 07/11] hw/cxl: mailbox-utils: 0x5602 - FMAPI Set DC Region Config
Date: Mon, 14 Jul 2025 18:45:03 +0100
Message-ID: <20250714174509.1984430-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714174509.1984430-1-Jonathan.Cameron@huawei.com>
References: <20250714174509.1984430-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2 of set to merge:
- Fixed blksize check in set dc region config
- Added check that it is a power of 2 (and host-utils.h include for that)
---
 include/hw/cxl/cxl_device.h  |  3 ++
 include/hw/cxl/cxl_mailbox.h |  6 +++
 hw/cxl/cxl-mailbox-utils.c   | 87 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c           |  6 +--
 4 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 42ae5b7479..c836fc17f0 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -721,4 +721,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                    uint64_t len);
 bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                   uint64_t len);
+void cxl_assign_event_header(CXLEventRecordHdr *hdr,
+                             const QemuUUID *uuid, uint32_t flags,
+                             uint8_t length, uint64_t timestamp);
 #endif
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index 9008402d1c..a05d7cb5b7 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -8,6 +8,7 @@
 #ifndef CXL_MAILBOX_H
 #define CXL_MAILBOX_H
 
+#define CXL_MBOX_CONFIG_CHANGE_COLD_RESET (1)
 #define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
 #define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -15,5 +16,10 @@
 #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
 #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
 #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
+#define CXL_MBOX_SECONDARY_MBOX_SUPPORTED (1 << 8)
+#define CXL_MBOX_REQUEST_ABORT_BACKGROUND_OP_SUPPORTED (1 << 9)
+#define CXL_MBOX_CEL_10_TO_11_VALID (1 << 10)
+#define CXL_MBOX_CONFIG_CHANGE_CONV_RESET (1 << 11)
+#define CXL_MBOX_CONFIG_CHANGE_CXL_RESET (1 << 12)
 
 #endif
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index bf1710b251..b4a0f7d664 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -18,6 +18,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci-bridge/cxl_upstream_port.h"
 #include "qemu/cutils.h"
+#include "qemu/host-utils.h"
 #include "qemu/log.h"
 #include "qemu/units.h"
 #include "qemu/uuid.h"
@@ -121,6 +122,7 @@ enum {
     FMAPI_DCD_MGMT = 0x56,
         #define GET_DCD_INFO    0x0
         #define GET_HOST_DC_REGION_CONFIG   0x1
+        #define SET_DC_REGION_CONFIG        0x2
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3390,6 +3392,84 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602) */
+static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
+                                              uint8_t *payload_in,
+                                              size_t len_in,
+                                              uint8_t *payload_out,
+                                              size_t *len_out,
+                                              CXLCCI *cci)
+{
+    struct {
+        uint8_t reg_id;
+        uint8_t rsvd[3];
+        uint64_t block_sz;
+        uint8_t flags;
+        uint8_t rsvd2[3];
+    } QEMU_PACKED *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLEventDynamicCapacity dcEvent = {};
+    CXLDCRegion *region = &ct3d->dc.regions[in->reg_id];
+
+    /*
+     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
+     * This command shall fail with Unsupported when the Sanitize on Release
+     * field does not match the region’s configuration... and the device
+     * does not support reconfiguration of the Sanitize on Release setting.
+     *
+     * Currently not reconfigurable, so always fail if sanitize bit (bit 0)
+     * doesn't match.
+     */
+    if ((in->flags & 0x1) != (region->flags & 0x1)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    if (in->reg_id >= DCD_MAX_NUM_REGION) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /* Check that no extents are in the region being reconfigured */
+    if (!bitmap_empty(region->blk_bitmap, region->len / region->block_size)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /* Check that new block size is supported */
+    if (!is_power_of_2(in->block_sz) ||
+        !(in->block_sz & region->supported_blk_size_bitmask)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    /* Return success if new block size == current block size */
+    if (in->block_sz == region->block_size) {
+        return CXL_MBOX_SUCCESS;
+    }
+
+    /* Free bitmap and create new one for new block size. */
+    qemu_mutex_lock(&region->bitmap_lock);
+    g_free(region->blk_bitmap);
+    region->blk_bitmap = bitmap_new(region->len / in->block_sz);
+    qemu_mutex_unlock(&region->bitmap_lock);
+    region->block_size = in->block_sz;
+
+    /* Create event record and insert into event log */
+    cxl_assign_event_header(&dcEvent.hdr,
+                            &dynamic_capacity_uuid,
+                            (1 << CXL_EVENT_TYPE_INFO),
+                            sizeof(dcEvent),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+    dcEvent.type = DC_EVENT_REGION_CONFIG_UPDATED;
+    dcEvent.validity_flags = 1;
+    dcEvent.host_id = 0;
+    dcEvent.updated_region_id = in->reg_id;
+
+    if (cxl_event_insert(&ct3d->cxl_dstate,
+                         CXL_EVENT_TYPE_DYNAMIC_CAP,
+                         (CXLEventRecordRaw *)&dcEvent)) {
+        cxl_event_irq_assert(ct3d);
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3508,6 +3588,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
         cmd_fm_get_dcd_info, 0, 0 },
     [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
         cmd_fm_get_host_dc_region_config, 4, 0 },
+    [FMAPI_DCD_MGMT][SET_DC_REGION_CONFIG] = { "SET_DC_REGION_CONFIG",
+        cmd_fm_set_dc_region_config, 16,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
 };
 
 /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a7a1857a0c..4a45b4510e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1590,9 +1590,9 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
     pcie_aer_inject_error(PCI_DEVICE(obj), &err);
 }
 
-static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
-                                    const QemuUUID *uuid, uint32_t flags,
-                                    uint8_t length, uint64_t timestamp)
+void cxl_assign_event_header(CXLEventRecordHdr *hdr,
+                             const QemuUUID *uuid, uint32_t flags,
+                             uint8_t length, uint64_t timestamp)
 {
     st24_le_p(&hdr->flags, flags);
     hdr->length = length;
-- 
2.48.1

