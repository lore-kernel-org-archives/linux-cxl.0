Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF9F4653A
	for <linux-cxl@vger.kernel.org>; Mon,  4 Mar 2024 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581468; cv=none; b=t6miCjOCGFXnRsdMQSJh6TrQnWndNPhwpNl+SMffyWNCfO7BM854Yc6wSKkVZsj5ff17mXnWLUdP+KMXHdbfdNceRAGC+EwTZ3CHWkfNKLZaCUqEK9yMuaJ19izQK6WeE5hMmQ025fBbHYgwX3DLM+VKnumMwjdcXWFDYFwTU+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581468; c=relaxed/simple;
	bh=LSo6oc4LwS+/6ubh53NECIeVJQF1M/NbBbQ/cWccBxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SArzBVe/YZVKU1gX+wEGlvuLCXSmL2AIpacUiTGWgTU+hbFIhXzSmy3yAulUREF3p7wWAhbToQpzM8Q8JeDGJmNmclZqsEuUcqIZom90ZQnlASqbiOx4v0+5t3EOLGDYbO6jjTGvuu4fBwQ7iTWi9UVduQvJS+S2zhiXtLFoXfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWxWr9E4; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWxWr9E4"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbed179f0faso4172136276.1
        for <linux-cxl@vger.kernel.org>; Mon, 04 Mar 2024 11:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709581466; x=1710186266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IBOSIGSvnMADzgZ+mW+5zQVhNDHXh+pawO9uLnLzyc=;
        b=mWxWr9E4y9ut5cRhkyFn1KcYsyuHK6Ld+w4DtuBMZpheO4AiYuXa9G36/oLZfS22kW
         H87ux+uc59SCBTAgJ+zyH9p78c2U0TebSG764rCzLX1oSDSc5lJdCecJ93Eforxeo3GC
         jhyK833VARfOrnjffiuYPJtIe+NMZq4+9BSiU04BYiA8J4lXla7IX97/fMPpLqNJlnxo
         MPk50iFpXv7sayFS3Nb1K3hyfjXcXGlqbohbSfnPjKEXuA76CBCT6SaraMLzKpGa8tiL
         xgcM6M6f796rRJl0fdcAODivJBPuPvNbW00xfkafiXpyFIIGsFkQ11XGH0mLxbLFmn4a
         tpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581466; x=1710186266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IBOSIGSvnMADzgZ+mW+5zQVhNDHXh+pawO9uLnLzyc=;
        b=NKiyV/Z6CypxT5/kp1JUpYZ/qrKipE4VApPCwb7sJ0FmcRsTL/5gopgZXearaE9MbL
         PvNvhVoH9dbCZ9RL33QyDrhfs3gnFIX6fV90gRNn/yQJdA6s/GtB4JJOtkWWOgRy0EpU
         UvgmExeqOgcQqLpIheQhIUBmJYN3hINALFGPlHIMUH+Y3wgjGm9bLqwDE+4CWNtEGR5U
         vU1tCHymbbkaZjsFlL4FurOWIUnzPHaKBdpf/X+YapYcQy1KkYqfza4OuZIYGIW41PSb
         O1AGhLtkdLOMRCWkWiom9gTNKOfgJ+8jjokQJV8B+DnFgYLks92zx0cTxH/AtzWKocMn
         vX6g==
X-Forwarded-Encrypted: i=1; AJvYcCUOVYrX1Oz8wAQjyWmLN9SjeUbIAV1mNWDeiMHxaqbSvpmxp0d3JZX1sGLRxf2cR1e/WggeEr0PN8muk3JEEigxkGsLcDUw5MZu
X-Gm-Message-State: AOJu0YzXKCmEMDCCKLJX/R75thmZ2l49HMYELY/gTPh0hm7dsGk5ffog
	RaUt6NgmdIS1X1qgN+GOpEB96NZiuYlwHe5OuX/beKs56hPsnc1lwymSVSvG
X-Google-Smtp-Source: AGHT+IHKrxBL4gj+jTPCrIcVjmwDt26gJvL7p07d8UAeOHaLX1Zkbnj3sPAl0YyHB5/As3vhFckawQ==
X-Received: by 2002:a5b:10f:0:b0:dc7:4265:1e92 with SMTP id 15-20020a5b010f000000b00dc742651e92mr448450ybx.23.1709581465690;
        Mon, 04 Mar 2024 11:44:25 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:44:25 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	gregory.price@memverge.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com,
	wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to add/release dynamic capacity extents
Date: Mon,  4 Mar 2024 11:34:04 -0800
Message-ID: <20240304194331.1586191-10-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304194331.1586191-1-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Since fabric manager emulation is not supported yet, the change implements
the functions to add/release dynamic capacity extents as QMP interfaces.

Note: we skips any FM issued extent release request if the exact extent
does not exist in the extent list of the device. We will loose the
restriction later once we have partial release support in the kernel.

1. Add dynamic capacity extents:

For example, the command to add two continuous extents (each 128MiB long)
to region 0 (starting at DPA offset 0) looks like below:

{ "execute": "qmp_capabilities" }

{ "execute": "cxl-add-dynamic-capacity",
  "arguments": {
      "path": "/machine/peripheral/cxl-dcd0",
      "region-id": 0,
      "extents": [
      {
          "dpa": 0,
          "len": 134217728
      },
      {
          "dpa": 134217728,
          "len": 134217728
      }
      ]
  }
}

2. Release dynamic capacity extents:

For example, the command to release an extent of size 128MiB from region 0
(DPA offset 128MiB) look like below:

{ "execute": "cxl-release-dynamic-capacity",
  "arguments": {
      "path": "/machine/peripheral/cxl-dcd0",
      "region-id": 0,
      "extents": [
      {
          "dpa": 134217728,
          "len": 134217728
      }
      ]
  }
}

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  26 ++--
 hw/mem/cxl_type3.c          | 245 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3_stubs.c    |  14 +++
 include/hw/cxl/cxl_device.h |   6 +
 include/hw/cxl/cxl_events.h |  18 +++
 qapi/cxl.json               |  61 ++++++++-
 6 files changed, 361 insertions(+), 9 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 8c59635a9f..53ebc526ae 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1405,7 +1405,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
  * Check whether any bit between addr[nr, nr+size) is set,
  * return true if any bit is set, otherwise return false
  */
-static bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
+bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
                               unsigned long size)
 {
     unsigned long res = find_next_bit(addr, size + nr, nr);
@@ -1444,7 +1444,7 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
     return NULL;
 }
 
-static void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
+void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
                                              uint64_t dpa,
                                              uint64_t len,
                                              uint8_t *tag,
@@ -1591,16 +1591,28 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
             }
         }
 
-        /*
-         * TODO: we will add a pending extent list based on event log record
-         * and verify the input response; also, the "More" flag is not
-         * considered at the moment.
-         */
+        QTAILQ_FOREACH(ent, &ct3d->dc.extents_pending_to_add, node) {
+            if (ent->start_dpa <= dpa &&
+                dpa + len <= ent->start_dpa + ent->len) {
+                break;
+            }
+        }
+        if (!ent) {
+            return CXL_MBOX_INVALID_PA;
+        }
+
+        cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending_to_add,
+                                           ent);
 
         cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
         ct3d->dc.total_extent_count += 1;
     }
 
+    /*
+     * TODO: extents_pending_to_add needs to be cleared so the extents not
+     * accepted can be reclaimed base on spec r3.1: 8.2.9.9.9.3
+     */
+
     return CXL_MBOX_SUCCESS;
 }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index dccfaaad3a..e9c8994cdb 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -674,6 +674,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         ct3d->dc.total_capacity += region->len;
     }
     QTAILQ_INIT(&ct3d->dc.extents);
+    QTAILQ_INIT(&ct3d->dc.extents_pending_to_add);
 
     return true;
 }
@@ -686,6 +687,12 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
         ent = QTAILQ_FIRST(&ct3d->dc.extents);
         cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
     }
+
+    while (!QTAILQ_EMPTY(&ct3d->dc.extents_pending_to_add)) {
+        ent = QTAILQ_FIRST(&ct3d->dc.extents_pending_to_add);
+        cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending_to_add,
+                                           ent);
+    }
 }
 
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
@@ -1451,7 +1458,8 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
         return CXL_EVENT_TYPE_FAIL;
     case CXL_EVENT_LOG_FATAL:
         return CXL_EVENT_TYPE_FATAL;
-/* DCD not yet supported */
+    case CXL_EVENT_LOG_DYNCAP:
+        return CXL_EVENT_TYPE_DYNAMIC_CAP;
     default:
         return -EINVAL;
     }
@@ -1702,6 +1710,241 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     }
 }
 
+/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
+static const QemuUUID dynamic_capacity_uuid = {
+    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
+                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+};
+
+typedef enum CXLDCEventType {
+    DC_EVENT_ADD_CAPACITY = 0x0,
+    DC_EVENT_RELEASE_CAPACITY = 0x1,
+    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
+    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
+    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
+    DC_EVENT_CAPACITY_RELEASED = 0x5,
+} CXLDCEventType;
+
+/*
+ * Check whether the exact extent exists in the list
+ * Return value: the extent pointer in the list; else null
+ */
+static CXLDCExtent *cxl_dc_extent_exists(CXLDCExtentList *list,
+                                         CXLDCExtentRaw *ext)
+{
+    CXLDCExtent *ent;
+
+    if (!ext || !list) {
+        return NULL;
+    }
+
+    QTAILQ_FOREACH(ent, list, node) {
+        if (ent->start_dpa != ext->start_dpa) {
+            continue;
+        }
+
+        /* Found exact extent */
+        return ent->len == ext->len ? ent : NULL;
+    }
+
+    return NULL;
+}
+
+/*
+ * The main function to process dynamic capacity event. Currently DC extents
+ * add/release requests are processed.
+ */
+static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
+                                             CXLDCEventType type, uint16_t hid,
+                                             uint8_t rid,
+                                             CXLDCExtentRecordList *records,
+                                             Error **errp)
+{
+    Object *obj;
+    CXLEventDynamicCapacity dCap = {};
+    CXLEventRecordHdr *hdr = &dCap.hdr;
+    CXLType3Dev *dcd;
+    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
+    uint32_t num_extents = 0;
+    CXLDCExtentRecordList *list;
+    g_autofree CXLDCExtentRaw *extents = NULL;
+    uint8_t enc_log;
+    uint64_t offset, len, block_size;
+    int i;
+    int rc;
+    g_autofree unsigned long *blk_bitmap = NULL;
+
+    obj = object_resolve_path(path, NULL);
+    if (!obj) {
+        error_setg(errp, "Unable to resolve path");
+        return;
+    }
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        error_setg(errp, "Path not point to a valid CXL type3 device");
+        return;
+    }
+
+    dcd = CXL_TYPE3(obj);
+    if (!dcd->dc.num_regions) {
+        error_setg(errp, "No dynamic capacity support from the device");
+        return;
+    }
+
+    rc = ct3d_qmp_cxl_event_log_enc(log);
+    if (rc < 0) {
+        error_setg(errp, "Unhandled error log type");
+        return;
+    }
+    enc_log = rc;
+
+    if (rid >= dcd->dc.num_regions) {
+        error_setg(errp, "region id is too large");
+        return;
+    }
+    block_size = dcd->dc.regions[rid].block_size;
+
+    /* Sanity check and count the extents */
+    list = records;
+    while (list) {
+        offset = list->value->offset;
+        len = list->value->len;
+
+        if (len == 0) {
+            error_setg(errp, "extent with 0 length is not allowed");
+            return;
+        }
+
+        if (offset % block_size || len % block_size) {
+            error_setg(errp, "dpa or len is not aligned to region block size");
+            return;
+        }
+
+        if (offset + len > dcd->dc.regions[rid].len) {
+            error_setg(errp, "extent range is beyond the region end");
+            return;
+        }
+
+        num_extents++;
+        list = list->next;
+    }
+    if (num_extents == 0) {
+        error_setg(errp, "No extents found in the command");
+        return;
+    }
+
+    blk_bitmap = bitmap_new(dcd->dc.regions[rid].len / block_size);
+
+    /* Create Extent list for event being passed to host */
+    i = 0;
+    list = records;
+    extents = g_new0(CXLDCExtentRaw, num_extents);
+    while (list) {
+        CXLDCExtent *ent;
+        bool skip_extent = false;
+
+        offset = list->value->offset;
+        len = list->value->len;
+
+        extents[i].start_dpa = offset + dcd->dc.regions[rid].base;
+        extents[i].len = len;
+        memset(extents[i].tag, 0, 0x10);
+        extents[i].shared_seq = 0;
+
+        if (type == DC_EVENT_RELEASE_CAPACITY ||
+            type == DC_EVENT_FORCED_RELEASE_CAPACITY) {
+            /*
+             *  if the extent is still pending to be added to the host,
+             * remove it from the pending extent list, so later when the add
+             * response for the extent arrives, the device can reject the
+             * extent as it is not in the pending list.
+             */
+            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
+                        &extents[i]);
+            if (ent) {
+                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
+                g_free(ent);
+                skip_extent = true;
+            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
+                /* If the exact extent is not in the accepted list, skip */
+                skip_extent = true;
+            }
+        }
+
+        /* No duplicate or overlapped extents are allowed */
+        if (test_any_bits_set(blk_bitmap, offset / block_size,
+                              len / block_size)) {
+            error_setg(errp, "duplicate or overlapped extents are detected");
+            return;
+        }
+        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
+
+        list = list->next;
+        if (!skip_extent) {
+            i++;
+        }
+    }
+    num_extents = i;
+
+    /*
+     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
+     *
+     * All Dynamic Capacity event records shall set the Event Record Severity
+     * field in the Common Event Record Format to Informational Event. All
+     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
+     * Event Log.
+     */
+    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
+                            cxl_device_get_timestamp(&dcd->cxl_dstate));
+
+    dCap.type = type;
+    /* FIXME: for now, validity flag is cleared */
+    dCap.validity_flags = 0;
+    stw_le_p(&dCap.host_id, hid);
+    /* only valid for DC_REGION_CONFIG_UPDATED event */
+    dCap.updated_region_id = 0;
+    /*
+     * FIXME: for now, the "More" flag is cleared as there is only one
+     * extent associating with each record and tag-based release is
+     * not supported.
+     */
+    dCap.flags = 0;
+    for (i = 0; i < num_extents; i++) {
+        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
+               sizeof(CXLDCExtentRaw));
+
+        if (type == DC_EVENT_ADD_CAPACITY) {
+            cxl_insert_extent_to_extent_list(&dcd->dc.extents_pending_to_add,
+                                             extents[i].start_dpa,
+                                             extents[i].len,
+                                             extents[i].tag,
+                                             extents[i].shared_seq);
+        }
+
+        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
+                             (CXLEventRecordRaw *)&dCap)) {
+            cxl_event_irq_assert(dcd);
+        }
+    }
+}
+
+void qmp_cxl_add_dynamic_capacity(const char *path, uint8_t region_id,
+                                  CXLDCExtentRecordList  *records,
+                                  Error **errp)
+{
+   qmp_cxl_process_dynamic_capacity(path, CXL_EVENT_LOG_DYNCAP,
+                                    DC_EVENT_ADD_CAPACITY, 0,
+                                    region_id, records, errp);
+}
+
+void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
+                                      CXLDCExtentRecordList  *records,
+                                      Error **errp)
+{
+    qmp_cxl_process_dynamic_capacity(path, CXL_EVENT_LOG_DYNCAP,
+                                     DC_EVENT_RELEASE_CAPACITY, 0,
+                                     region_id, records, errp);
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 3e1851e32b..d913b11b4d 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -67,3 +67,17 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
+
+void qmp_cxl_add_dynamic_capacity(const char *path, uint8_t region_id,
+                                  CXLDCExtentRecordList  *records,
+                                  Error **errp)
+{
+    error_setg(errp, "CXL Type 3 support is not compiled in");
+}
+
+void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
+                                      CXLDCExtentRecordList  *records,
+                                      Error **errp)
+{
+    error_setg(errp, "CXL Type 3 support is not compiled in");
+}
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 341260e6e4..b524c5e699 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -490,6 +490,7 @@ struct CXLType3Dev {
         AddressSpace host_dc_as;
         uint64_t total_capacity; /* 256M aligned */
         CXLDCExtentList extents;
+        CXLDCExtentList extents_pending_to_add;
         uint32_t total_extent_count;
         uint32_t ext_list_gen_seq;
 
@@ -551,4 +552,9 @@ CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
 
 void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
                                         CXLDCExtent *extent);
+void cxl_insert_extent_to_extent_list(CXLDCExtentList *list, uint64_t dpa,
+                                      uint64_t len, uint8_t *tag,
+                                      uint16_t shared_seq);
+bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
+                       unsigned long size);
 #endif
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 5170b8dbf8..38cadaa0f3 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -166,4 +166,22 @@ typedef struct CXLEventMemoryModule {
     uint8_t reserved[0x3d];
 } QEMU_PACKED CXLEventMemoryModule;
 
+/*
+ * CXL r3.1 section Table 8-50: Dynamic Capacity Event Record
+ * All fields little endian.
+ */
+typedef struct CXLEventDynamicCapacity {
+    CXLEventRecordHdr hdr;
+    uint8_t type;
+    uint8_t validity_flags;
+    uint16_t host_id;
+    uint8_t updated_region_id;
+    uint8_t flags;
+    uint8_t reserved2[2];
+    uint8_t dynamic_capacity_extent[0x28]; /* defined in cxl_device.h */
+    uint8_t reserved[0x18];
+    uint32_t extents_avail;
+    uint32_t tags_avail;
+} QEMU_PACKED CXLEventDynamicCapacity;
+
 #endif /* CXL_EVENTS_H */
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 8cc4c72fa9..2645004666 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -19,13 +19,16 @@
 #
 # @fatal: Fatal Event Log
 #
+# @dyncap: Dynamic Capacity Event Log
+#
 # Since: 8.1
 ##
 { 'enum': 'CxlEventLog',
   'data': ['informational',
            'warning',
            'failure',
-           'fatal']
+           'fatal',
+           'dyncap']
  }
 
 ##
@@ -361,3 +364,59 @@
 ##
 {'command': 'cxl-inject-correctable-error',
  'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
+
+##
+# @CXLDCExtentRecord:
+#
+# Record of a single extent to add/release
+#
+# @offset: offset to the start of the region where the extent to be operated
+# @len: length of the extent
+#
+# Since: 9.0
+##
+{ 'struct': 'CXLDCExtentRecord',
+  'data': {
+      'offset':'uint64',
+      'len': 'uint64'
+  }
+}
+
+##
+# @cxl-add-dynamic-capacity:
+#
+# Command to start add dynamic capacity extents flow. The device will
+# have to acknowledged the acceptance of the extents before they are usable.
+#
+# @path: CXL DCD canonical QOM path
+# @region-id: id of the region where the extent to add
+# @extents: Extents to add
+#
+# Since : 9.0
+##
+{ 'command': 'cxl-add-dynamic-capacity',
+  'data': { 'path': 'str',
+            'region-id': 'uint8',
+            'extents': [ 'CXLDCExtentRecord' ]
+           }
+}
+
+##
+# @cxl-release-dynamic-capacity:
+#
+# Command to start release dynamic capacity extents flow. The host will
+# need to respond to indicate that it has released the capacity before it
+# is made unavailable for read and write and can be re-added.
+#
+# @path: CXL DCD canonical QOM path
+# @region-id: id of the region where the extent to release
+# @extents: Extents to release
+#
+# Since : 9.0
+##
+{ 'command': 'cxl-release-dynamic-capacity',
+  'data': { 'path': 'str',
+            'region-id': 'uint8',
+            'extents': [ 'CXLDCExtentRecord' ]
+           }
+}
-- 
2.43.0

