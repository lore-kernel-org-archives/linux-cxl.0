Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499DB4AEE0
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663539; cv=none; b=uLdfTTOupiadxEmHw2rr0oRwktOS4dcv/vE4EB7Gnko/lZhNAp7Dpf8ea/uUheucUaFHxs0gLA/HwgDP5iuUVeKTNp/62+/czA/kpQfHvlhG058F+id6JASHAlymDVVgFwZqvxmc8ESj2wxQVcnGNZzyo2VrgmSNb19KPge179U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663539; c=relaxed/simple;
	bh=8HLLVQNaEtntTxHBNrRsnTqJ36ybcpROimSjhqUlUsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7FUlDDfsShQEUes3qXziNuUMoDig1iD43RoLTajVYeGHf1hmr2lxza5tXfQUQF40Csppdrg6zt3VJlbPObjWcxdCoSAX/o0+TurI0q8mguBsp09WDZnu+eLlj80YTNZ3oNIRvpd864ldRkQ6KCqsM4+VI175ox68JWOmqQTM1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQg0G0a3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQg0G0a3"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7396f13b750so535810b3a.1
        for <linux-cxl@vger.kernel.org>; Wed, 07 May 2025 17:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746663537; x=1747268337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yBJJKeNr6AER/b7GVBjWusRo2VXtW9qLVii1bSraWw=;
        b=AQg0G0a3HVAhMIzLwE02W6z8VmASkImjwkJKGM22jWAQYTibwmCH/csv766UEJ9Zpl
         Sz36BGHvZAeV+vKdfH+yC8reERDdpcJSz7nj7GJYxpR2mtCJVoS7b+n0BMkBb+XdyHAF
         /4QMsAYB1xJnxjXG19jlsIL5uXGhlkSLxPMWTQ7RPxS8Lg5TZDA/HXI62mdUS12NIOU7
         956qTQGESQdhut1ACJly+iFHpy9rNytTYCNbWlzJbN/A3W4T07K8lXpXjDjylRxC0Kjd
         7Zx6se5mxBP2f3iGeAQwzOgJYG3C6NVfhXV4KFKU7DsaBC6zHRjjlOJIQSdFCoBqfEuD
         /vBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746663537; x=1747268337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yBJJKeNr6AER/b7GVBjWusRo2VXtW9qLVii1bSraWw=;
        b=Qoq9ifEaubXDwY+hwfFIkQjB9OGfMr9qkux4znRMOsUo5591UGjNKb/a8wvrSQviM3
         OK3b/5rG3pZng2uMU43Je54uZhVw7OMbzOMxh0cv9OMliBEpCKOvlzacw4dTWooH23e+
         uxy7L2NlMNNLr8Vi7p9M2RoVMibYkvHStqgEQ1A2h+IAZTXAv85oEhwqDQpUDZincfra
         EvA1YA5FKIWObWyWZZALngghzPEsGSFkmavic/OqHFJ0nqcjuk3l1N9KDJDJyqsZnEcC
         1vWngUClIZ5nBvQ8rI+oVwrY4SOTuGvAfHpzXchsDj6/qE4eWOiDJ2EvnhQup2/1VHNc
         aPHA==
X-Forwarded-Encrypted: i=1; AJvYcCU7IGjajD2I9AL6wLhf5OmCxVpEO3q9GM0rid7sblkERb2Z6z0UREQyPfKeFd3P+avjnnnP3Kbr3Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWMoWAAvPn2sH0QzX+3AZc05iv+w7rQrt19bNYNw9yq8ITOLo
	oIExml3MTdK/kgPxiuTLKXCZhFKb5G3OH/hz/HXsxjv46lpbrllh
X-Gm-Gg: ASbGncvD1lbz0RtxVov6fjXf5L2Ad+bQNQpq+B+JGfhDV0D1pDqubmln+Dl2KRACDLR
	cEIBN0FJfobOIsJ66vRv6FQtsGQzWSddp2HQITQq6EghfDs6mjWgjLuRKJb5FXTJjHTCCc0puH7
	/v4EnC/y8/DjKdxQuIRZCr9ve+tKCRc2MShfN3+hrc3QHvieUXkU/Rej5+YZ9EXjcBIgB7FI1fy
	U0irAKYmywOoOwRnfnKslL1XDJwtuK379Ks0ska2i3pIBb6u8pslkHaJt18q342D9QWpYWJCG1H
	p9XjIgsMtd7FwPG1GrlRYlqQLDiq0vW7wB14cOVhzUbwvz5xTDjGIDAABPV+EQ==
X-Google-Smtp-Source: AGHT+IHcHANQRb6/Xx6ktsCkHqFQJ/4FwioJ4Qo/bn6EIdS/+halZw2P0l4KxuAGm9KFyUykROv8ig==
X-Received: by 2002:a05:6a00:3cc1:b0:740:a52f:9652 with SMTP id d2e1a72fcca58-740a52f96d6mr3819670b3a.6.1746663537511;
        Wed, 07 May 2025 17:18:57 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 17:18:57 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 09/10] cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
Date: Thu,  8 May 2025 00:01:05 +0000
Message-ID: <20250508001754.122180-10-anisa.su887@gmail.com>
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

FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 195 +++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c           |   8 +-
 include/hw/cxl/cxl_device.h  |   4 +
 include/hw/cxl/cxl_opcodes.h |   1 +
 4 files changed, 204 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a897a34ef9..9b176dea08 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3589,6 +3589,194 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cxl_mbox_dc_prescriptive_sanity_check(CXLType3Dev *dcd,
+                                                        uint16_t host_id,
+                                                        uint32_t ext_count,
+                                                        CXLDCExtentRaw extents[],
+                                                        CXLDCEventType type)
+{
+    CXLDCExtentRaw ext;
+    CXLDCRegion *reg = NULL;
+    int i, j;
+
+    if (host_id != 0) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    for (i = 0; i < ext_count; i++) {
+        ext = extents[i];
+
+        if (ext.len == 0) {
+            return CXL_MBOX_INVALID_EXTENT_LIST;
+        }
+
+        reg = cxl_find_dc_region(dcd, ext.start_dpa, ext.len);
+        if (!reg) {
+            return CXL_MBOX_INVALID_EXTENT_LIST;
+        }
+
+        if (ext.len % reg->block_size || ext.start_dpa % reg->block_size) {
+            return CXL_MBOX_INVALID_EXTENT_LIST;
+        }
+
+        /* Check requested extents do not overlap with each other. */
+        for (j = i + 1; j < ext_count; j++) {
+            if (ranges_overlap(ext.start_dpa, ext.len, extents[j].start_dpa,
+                               extents[j].len)) {
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+            }
+        }
+
+        if (type == DC_EVENT_ADD_CAPACITY) {
+            /* Check requested extents do not overlap with pending extents. */
+            if (cxl_extent_groups_overlaps_dpa_range(&dcd->dc.extents_pending,
+                ext.start_dpa, ext.len)) {
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+            }
+            /* Check requested extents do not overlap with existing extents. */
+            if (cxl_extents_overlaps_dpa_range(&dcd->dc.extents,
+                                               ext.start_dpa, ext.len)) {
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+            }
+        }
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
+static int cxl_mbox_get_pending_ext_count(CXLType3Dev *ct3d)
+{
+    CXLDCExtentGroup *group;
+    CXLDCExtentList *list;
+    CXLDCExtent *ent;
+    int count = 0;
+
+    QTAILQ_FOREACH(group, &ct3d->dc.extents_pending, node) {
+        list = &group->list;
+        QTAILQ_FOREACH(ent, list, node) {
+            count++;
+        }
+    }
+
+    return count;
+}
+
+static int cxl_mbox_get_accepted_ext_count(CXLType3Dev *ct3d)
+{
+    CXLDCExtent *ent;
+    int count = 0;
+
+    QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
+        count++;
+    }
+
+    return count;
+}
+
+static void cxl_mbox_dc_add_to_pending(CXLType3Dev *ct3d,
+                                       uint32_t ext_count,
+                                       CXLDCExtentRaw extents[])
+{
+    CXLDCExtentGroup *group = NULL;
+    int i;
+
+    for (i = 0; i < ext_count; i++) {
+        group = cxl_insert_extent_to_extent_group(group,
+                                                  extents[i].start_dpa,
+                                                  extents[i].len,
+                                                  extents[i].tag,
+                                                  extents[i].shared_seq);
+    }
+
+    cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
+}
+
+static void cxl_mbox_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
+                                                         CXLDCEventType type,
+                                                         CXLDCExtentRaw extents[],
+                                                         uint32_t ext_count)
+{
+    CXLEventDynamicCapacity event_rec = {};
+    int i;
+
+    cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
+    event_rec.type = type;
+    event_rec.validity_flags = 1;
+    event_rec.host_id = 0;
+    event_rec.updated_region_id = 0;
+    event_rec.extents_avail = ct3d->dc.total_extent_count -
+                              cxl_mbox_get_accepted_ext_count(ct3d) -
+                              cxl_mbox_get_pending_ext_count(ct3d);
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
+
+/* CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h) */
+static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t selection_policy;
+        uint8_t reg_num;
+        uint64_t length;
+        uint8_t tag[0x10];
+        uint32_t ext_count;
+        CXLDCExtentRaw extents[];
+    } QEMU_PACKED *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    int rc;
+
+    switch (in->selection_policy) {
+    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
+        /* Adding extents exceeds device's extent tracking ability. */
+        if (in->ext_count + ct3d->dc.total_extent_count >
+            CXL_NUM_EXTENTS_SUPPORTED) {
+            return CXL_MBOX_RESOURCES_EXHAUSTED;
+        }
+        rc = cxl_mbox_dc_prescriptive_sanity_check(ct3d,
+                                                   in->host_id,
+                                                   in->ext_count,
+                                                   in->extents,
+                                                   DC_EVENT_ADD_CAPACITY);
+        if (rc) {
+            return rc;
+        }
+        cxl_mbox_dc_add_to_pending(ct3d, in->ext_count, in->extents);
+        cxl_mbox_create_dc_event_records_for_extents(ct3d,
+                                                     DC_EVENT_ADD_CAPACITY,
+                                                     in->extents,
+                                                     in->ext_count);
+
+        return CXL_MBOX_SUCCESS;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "CXL extent selection policy not supported.\n");
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3724,6 +3912,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
     [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
         cmd_fm_get_dc_region_extent_list, 12, 0 },
+    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
+        cmd_fm_initiate_dc_add, ~0,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+        CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
 };
 
 /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index edc29f1ccb..71fad3391c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1991,8 +1991,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
  * the list.
  * Return value: return true if has overlaps; otherwise, return false
  */
-static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
-                                           uint64_t dpa, uint64_t len)
+bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len)
 {
     CXLDCExtent *ent;
     Range range1, range2;
@@ -2037,8 +2037,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
     return false;
 }
 
-static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
-                                                 uint64_t dpa, uint64_t len)
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len)
 {
     CXLDCExtentGroup *group;
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 22823e2054..93b6df0ccd 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -824,4 +824,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
                              uint8_t length, uint64_t timestamp);
+bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len);
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len);
 #endif
diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
index ad4e614daa..72ea0a7d44 100644
--- a/include/hw/cxl/cxl_opcodes.h
+++ b/include/hw/cxl/cxl_opcodes.h
@@ -66,5 +66,6 @@ enum {
         #define GET_HOST_DC_REGION_CONFIG 0x1
         #define SET_DC_REGION_CONFIG 0x2
         #define GET_DC_REGION_EXTENT_LIST 0x3
+        #define INITIATE_DC_ADD           0x4
     GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
 };
-- 
2.47.2

