Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F581A2C27
	for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229850; cv=none; b=dluM8j/tkuVynMJ7dDzn/uKRHXsOy0HPOQWdu0HJ/OmkJnTSr+DJDNigjzVut/Yr0jb/fdK1KaymawlOLAFHNF3O152y1BeNRetV7CzXEtjb7fPizW2bxWUHZUZ3I0nP0fwAzapaMgiCYGNJwr1rfbivgMNpajv6/yI2FVoS5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229850; c=relaxed/simple;
	bh=1vorEBCoW5FOgGq9/akgwzExTGMyvIaUKoE7p0edv2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQooq4FeSdK4dTXpYlvbuO+OS40SCP3upVLqKaMrIrf67RSsFf+zA2fns0IZnqmwW9C5VgMlGgpehC2LGQDviGeqCI53QKpwLYIJ6JOY+hRP33ZVF4MAoPBZr4/JAYMpS/EInUp31NMedKbvsoVoiZvK8R9g2tbakuEu3cGbMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6C/dsgr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6C/dsgr"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-226185948ffso22915455ad.0
        for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 09:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742229848; x=1742834648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeD8bm35WueORl8KNXonDwF4c8bIUJRaJ8sV3CTjwqM=;
        b=Q6C/dsgrxAoZBsFYknLOHFUaWT9hbeiMW50pAJSWSE1YPg0T/PadMxcRCNN8oAfBXg
         3WMiIwHr/dKZu9jB6xoOcKN2/Mz5q7SRZQoSTGct5qPvYopTxxaH3h31pRLnwlVKYRGe
         nalkqaLUsF+qvKDably2CILFvn9S42UXd6FzVq6fvmdpr+O50Hpz0bGpB/xTZdKTdDVU
         pGhoVeOJH3HeJlqYFtp8qRzn0do+OGosgSiPLSxt83PIToWBZeSLo5bKzVAi8W+m2b4Q
         phMWMDH7koMqXWRdT1TybMOE7mfe6ZVFzdsrw61AfYvUfYySulKECbi3ADxzstHw47Wo
         w+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229848; x=1742834648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeD8bm35WueORl8KNXonDwF4c8bIUJRaJ8sV3CTjwqM=;
        b=nt211TRpfo4e+B9dtMZGOlA+Qr0uUDNE22e6qy4PRB/A7iIu6uX4nE+mYlxcmOD0ad
         CGwRIOjh1THOmEdh2NrN55FDlXjakPFA2OeFAhEET007y9MjxGD+ELgbQBGSLSRXvuD4
         PGXbOFo7V0qmlv5A8XyMMOScns6X0lwMEftC1PzdgC+8J1AQ6bBR1mBKLZoF6b7xG4/W
         WnGd6ZCAsfYMV+Owx5hQ910oVFKAnUzFba6GvQF2I3Vphw17WMJzOFnzCuuBbS8d4Hko
         JpOZK3+rTkCgV2HBSdycgqMBLucd/Tbr5MHISVZr5aAiRzbfOznoYYrkeC8a1jgWrhnU
         hvdg==
X-Forwarded-Encrypted: i=1; AJvYcCVGMuYlhNO0IZsElJaXtEasyuo/un8udTLqcfclB4Ft3ppMwXGyCbEYKrPI8vCCT+geusMWE8w09vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7DCO4BDUHL48M5eYnVGikpl351biBoJaNk/X4QaqbpIaTE8JI
	yRRGuIUnzLbUf1waInNvuOYjBFBiF1ktFI3jS88fOP3CSe/GnhKW
X-Gm-Gg: ASbGnctlGLmKVJ8LIiJIqDk0Xhn9iRZCR8a0ANt8ran9ECICdC//GtBZw8JZXxIziz1
	J/NwBMmdrCMKqdpAXlLh8dHwMLLfheDlFVPft7oD399c/w7KnL040IzcIbpUt8VnDC9684hNCxu
	kmK965s1ZmfQWLtS3nBsN+tygw2pzJVJHgbLi/oigk8b3g/K/wZ/NJdA6n0lEEA95h5B4DIZMG0
	EkGVq5zXiqPwiH9qk6BAYTiPF9LNWLuJKDHIbSWAZ2zwnOZd2w18A7KR+AbtE71llZVkVc4qON4
	t4EgJgT8vuLPLharCF7qUEgftakZK+0FqqqI7VAyQlfyT12sm7eThEB/Cxhka7xWEg==
X-Google-Smtp-Source: AGHT+IG0XeoWDYSAWB21haDmsMHHN7vfotQour+vtP/CxU8L4xDi/z4qMOAZA355+nOAzMAQY9rxlA==
X-Received: by 2002:a17:903:188:b0:224:1d1c:8837 with SMTP id d9443c01a7336-2262c554bc8mr2540105ad.19.1742229848165;
        Mon, 17 Mar 2025 09:44:08 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:44:07 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 8/9] cxl-mailbox-utils: 0x5604 -  FMAPI Initiate DC Add
Date: Mon, 17 Mar 2025 16:31:35 +0000
Message-ID: <20250317164204.2299371-9-anisa.su887@gmail.com>
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

FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 173 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |   8 +-
 include/hw/cxl/cxl_device.h |   4 +
 3 files changed, 181 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 77cf0fdb15..5bcbd434b7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -127,6 +127,8 @@ enum {
         #define GET_HOST_DC_REGION_CONFIG 0x1
         #define SET_DC_REGION_CONFIG 0x2
         #define GET_DC_REGION_EXTENT_LIST 0x3
+        #define INITIATE_DC_ADD           0x4
+
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3669,6 +3671,170 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
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
+    if (dcd->dc.num_regions == 0) {
+        qemu_log_mask(LOG_UNIMP,
+                      "No dynamic capacity support from the device.\n");
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /* TODO: host id check will be added later, currently host id must be 0. */
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
+/*
+ * CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h)
+ */
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
+    g_autofree CXLDCExtentRaw *event_rec_exts = NULL;
+    CXLEventDynamicCapacity event_rec = {};
+    CXLDCExtentGroup *group = NULL;
+    CXLDCExtentRaw ext;
+    int rc, i;
+
+    switch (in->selection_policy) {
+    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
+        /* Adding extents causes exceeding device's extent tracking ability. */
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
+
+        /* Prepare extents for Event Record */
+        event_rec_exts = g_new0(CXLDCExtentRaw, in->ext_count);
+        for (i = 0; i < in->ext_count; i++) {
+            ext = in->extents[i];
+            event_rec_exts[i].start_dpa = ext.start_dpa;
+            event_rec_exts[i].len = ext.len;
+            memset(event_rec_exts[i].tag, 0, 0x10);
+            event_rec_exts[i].shared_seq = 0;
+
+            /* Check requested extents do not overlap with pending extents. */
+            if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
+                                                     ext.start_dpa, ext.len)) {
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+            }
+
+            /* Create extent group to add to pending list. */
+            group = cxl_insert_extent_to_extent_group(group,
+                                                      event_rec_exts[i].start_dpa,
+                                                      event_rec_exts[i].len,
+                                                      event_rec_exts[i].tag,
+                                                      event_rec_exts[i].shared_seq);
+        }
+
+        /* Add requested extents to pending list. */
+        if (group) {
+            cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
+        }
+
+        /* Create event record and insert to event log */
+        cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
+        event_rec.type = DC_EVENT_ADD_CAPACITY;
+        /* FIXME: for now, validity flag is cleared */
+        event_rec.validity_flags = 0;
+        /* FIXME: Currently only support 1 host */
+        event_rec.host_id = 0;
+        /* updated_region_id only valid for DC_EVENT_REGION_CONFIG_UPDATED */
+        event_rec.updated_region_id = 0;
+        for (i = 0; i < in->ext_count; i++) {
+            memcpy(&event_rec.dynamic_capacity_extent,
+                   &event_rec_exts[i],
+                   sizeof(CXLDCExtentRaw));
+
+            event_rec.flags = 0;
+            if (i < in->ext_count - 1) {
+                /* Set "More" flag */
+                event_rec.flags |= BIT(0);
+            }
+
+            if (cxl_event_insert(&ct3d->cxl_dstate,
+                                 CXL_EVENT_TYPE_DYNAMIC_CAP,
+                                 (CXLEventRecordRaw *)&event_rec)) {
+                cxl_event_irq_assert(ct3d);
+            }
+        }
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
@@ -3804,6 +3970,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
          CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
     [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
         cmd_fm_get_dc_region_extent_list, 12, 0},
+    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
+        cmd_fm_initiate_dc_add, ~0,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+        CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
 };
 
 /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b742b2bb8d..ccc619fe10 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1982,8 +1982,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
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
@@ -2028,8 +2028,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
     return false;
 }
 
-static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
-                                                 uint64_t dpa, uint64_t len)
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len)
 {
     CXLDCExtentGroup *group;
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 217003a29d..1d5831a0b6 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -809,4 +809,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
 void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                              const QemuUUID *uuid, uint32_t flags,
                              uint8_t length, uint64_t timestamp);
+bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len);
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len);
 #endif
-- 
2.47.2

