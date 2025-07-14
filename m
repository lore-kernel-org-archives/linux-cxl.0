Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D132F22
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515392; cv=none; b=oALmMHHofIyQSRn9KjjHx2VIAIL2whTJTc66Fmg6gI00R5y5Kzrrpcz9UKzyDHCPQ9W+YbRujr9XH/bWEG6KEg6n1HGsM8z3003QtjpyZt6s6G8xxaMfE/GTcRHroQLp08X6ibkk1JrsLkV9k7mop3pmJBXIWgFUciInSRnOG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515392; c=relaxed/simple;
	bh=0IRkAH3dawNdmPMu0tbEHJhJ01a/qHOpo13ddfiVIdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCzMLb5W82D66i7+RbkPMN6K0w8i0l+/8H4pmEgYOVIIdid4fxfE6o8nuzpdxQAvT8hWFR4VmMYv9MagQ3NAgbcW6CIN1FwyQ4Y5EJpRpeqCPkzbktDn9GJO7jFh8S1fDoCP8F9sJbT83OI+G/Ub5/wF0ELL5nW03outwZmyes0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bgqW12RP6z6L5Nj;
	Tue, 15 Jul 2025 01:46:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E002D1402ED;
	Tue, 15 Jul 2025 01:49:48 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Jul 2025 19:49:48 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
	<fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>, Anisa Su
	<anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu v2 09/11] hw/cxl: Create helper function to create DC Event Records from extents
Date: Mon, 14 Jul 2025 18:45:05 +0100
Message-ID: <20250714174509.1984430-10-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714174509.1984430-1-Jonathan.Cameron@huawei.com>
References: <20250714174509.1984430-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Anisa Su <anisa.su@samsung.com>

Prepatory patch for following FMAPI Add/Release Patches. Refactors part
of qmp_cxl_process_dynamic_capacity_prescriptive() into a helper
function to create DC Event Records and insert in the event log.

Moves definition for CXL_NUM_EXTENTS_SUPPORTED to cxl.h so it can be
accessed by cxl-mailbox-utils.c and cxl-events.c, where the helper
function is defined.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2 of set to merge: Picked up Fan's tag. Thanks!
---
 include/hw/cxl/cxl.h        |  1 +
 include/hw/cxl/cxl_device.h |  4 ++++
 hw/cxl/cxl-events.c         | 38 +++++++++++++++++++++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c  |  1 -
 hw/mem/cxl_type3.c          | 37 +-----------------------------------
 5 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index de66ab8c35..998f495a98 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -23,6 +23,7 @@
 #define CXL_DEVICE_REG_BAR_IDX 2
 
 #define CXL_WINDOW_MAX 10
+#define CXL_NUM_EXTENTS_SUPPORTED 512
 
 typedef struct PXBCXLDev PXBCXLDev;
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c836fc17f0..71a5834c3d 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -724,4 +724,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
                              uint8_t length, uint64_t timestamp);
+void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
+                                             CXLDCEventType type,
+                                             CXLDCExtentRaw extents[],
+                                             uint32_t ext_count);
 #endif
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 12dee2e467..724055f2cf 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -260,3 +260,41 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d)
         }
     }
 }
+
+void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
+                                             CXLDCEventType type,
+                                             CXLDCExtentRaw extents[],
+                                             uint32_t ext_count)
+{
+    CXLEventDynamicCapacity event_rec = {};
+    int i;
+
+    cxl_assign_event_header(&event_rec.hdr,
+                            &dynamic_capacity_uuid,
+                            (1 << CXL_EVENT_TYPE_INFO),
+                            sizeof(event_rec),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+    event_rec.type = type;
+    event_rec.validity_flags = 1;
+    event_rec.host_id = 0;
+    event_rec.updated_region_id = 0;
+    event_rec.extents_avail = CXL_NUM_EXTENTS_SUPPORTED -
+                              ct3d->dc.total_extent_count;
+
+    for (i = 0; i < ext_count; i++) {
+        memcpy(&event_rec.dynamic_capacity_extent,
+               &extents[i],
+               sizeof(CXLDCExtentRaw));
+        event_rec.flags = 0;
+        if (i < ext_count - 1) {
+            /* Set "More" flag */
+            event_rec.flags |= BIT(0);
+        }
+
+        if (cxl_event_insert(&ct3d->cxl_dstate,
+                             CXL_EVENT_TYPE_DYNAMIC_CAP,
+                             (CXLEventRecordRaw *)&event_rec)) {
+            cxl_event_irq_assert(ct3d);
+        }
+    }
+}
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4b0fdbbdd8..b6f30e8689 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -28,7 +28,6 @@
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
-#define CXL_NUM_EXTENTS_SUPPORTED 512
 #define CXL_NUM_TAGS_SUPPORTED 0
 #define CXL_ALERTS_LIFE_USED_WARN_THRESH (1 << 0)
 #define CXL_ALERTS_OVER_TEMP_WARN_THRESH (1 << 1)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4a45b4510e..4e975b1a42 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1957,15 +1957,11 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         CxlDynamicCapacityExtentList *records, Error **errp)
 {
     Object *obj;
-    CXLEventDynamicCapacity dCap = {};
-    CXLEventRecordHdr *hdr = &dCap.hdr;
     CXLType3Dev *dcd;
-    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
     uint32_t num_extents = 0;
     CxlDynamicCapacityExtentList *list;
     CXLDCExtentGroup *group = NULL;
     g_autofree CXLDCExtentRaw *extents = NULL;
-    uint8_t enc_log = CXL_EVENT_TYPE_DYNAMIC_CAP;
     uint64_t dpa, offset, len, block_size;
     g_autofree unsigned long *blk_bitmap = NULL;
     int i;
@@ -2078,38 +2074,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         dcd->dc.total_extent_count += num_extents;
     }
 
-    /*
-     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
-     *
-     * All Dynamic Capacity event records shall set the Event Record Severity
-     * field in the Common Event Record Format to Informational Event. All
-     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
-     * Event Log.
-     */
-    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
-                            cxl_device_get_timestamp(&dcd->cxl_dstate));
-
-    dCap.type = type;
-    /* FIXME: for now, validity flag is cleared */
-    dCap.validity_flags = 0;
-    stw_le_p(&dCap.host_id, hid);
-    /* only valid for DC_REGION_CONFIG_UPDATED event */
-    dCap.updated_region_id = 0;
-    for (i = 0; i < num_extents; i++) {
-        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
-               sizeof(CXLDCExtentRaw));
-
-        dCap.flags = 0;
-        if (i < num_extents - 1) {
-            /* Set "More" flag */
-            dCap.flags |= BIT(0);
-        }
-
-        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
-                             (CXLEventRecordRaw *)&dCap)) {
-            cxl_event_irq_assert(dcd);
-        }
-    }
+    cxl_create_dc_event_records_for_extents(dcd, type, extents, num_extents);
 }
 
 void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
-- 
2.48.1

