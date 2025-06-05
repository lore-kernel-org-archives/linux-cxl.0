Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA38227FD51
	for <linux-cxl@vger.kernel.org>; Thu,  5 Jun 2025 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749166966; cv=none; b=L52wWezGGzmHSQmxfV0tul/JGZLQTVGtxtHjoCs2K29DfmZkXZtuAQQCsWWQ75z01uEeF2HyA846BWV1zWD3ntha+jHE0JZt6kdbwu+Bgy7YVYVb6Hz0r9CCp/bGHLAX3PW/QePnyCJ0ghrBhz0dGCkkLFSKbq2UjIVoEK1cZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749166966; c=relaxed/simple;
	bh=ZRlHtPuF+4VGe/wEFoyM7qU/woJ8Tg8UwSP2mLV1Hk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTbRHFWknWG7NjoWpGM0ZeIr+y3B0t/qr6q8p+lkQEHbnit9g5XTYs+c0zXu0KbWy9SsnGxpNcq+3LBePPzmc1oMOAdYddacjU4jTSsp+eGEgg0Mxk8yIGKlgLkkDQxqZZCwCEJUrFQUfbNXrSCVfommC4HLppTGOhWVsZXySzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YURtGGvQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YURtGGvQ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-747d59045a0so1111308b3a.1
        for <linux-cxl@vger.kernel.org>; Thu, 05 Jun 2025 16:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749166964; x=1749771764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmYgqthAafUrm+FgbTfR2HFhLvifKWfJ9zq0wwfT9zg=;
        b=YURtGGvQgerCUTXjuF4oQdSAIpnTVtxZz3O6RAqLfeZyCZ0zehMlHFoAqOy4Zrmnmm
         WkoiOzxijEth1CTSjjGULms1MO6KQ2guBHL5z/zHUcOcMafrQnAqgSo+EwvECiZWNdgE
         Jpeq+EbhOMoPl/VD9sXsfeMj82ipp2MPvGvV1ESaFCqtS4TJtaRxx+MzFH9rNOFitOlQ
         mZC+epGfCG0YDLNpicHX5YarQK1Cehy+5ZPDP+aEcDl63AC+ExgKclPIq0fmnPC1sOAw
         D1ZLtdqfRYUQuVp03acdLMP6DWjrKpqkRi/I20H0AL8NohsbPip0EC52dDVSihjLvyUF
         OiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749166964; x=1749771764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmYgqthAafUrm+FgbTfR2HFhLvifKWfJ9zq0wwfT9zg=;
        b=SkQVxg0jP19dClh3st4gkPPzEj0To6A6WGzkhAIhBSfqAgsi4azedlZFU5o0ubD3pO
         ufTJr2SnvnYRZGIWOYCzeIxj77Jzrfbaq0fEFkM8i22jvOAF1JBGqf+0ZxoT6ihT+EEJ
         Am44mJh9b1QnwmzXOH4LB51J6RvAe4VTNsZopMDRPlCD4YzVF0NnSEJOGZIqqDCtqYKz
         N3/J9/QmLm1lfm/gP30oBa+FqySa/R9SzAcGtHOil5L7do/ARH1tv9NMpWgcYAP3lR/5
         mZez3PzDMAiWCpSn9Z3428rjwLwA3UZ9VgIHWn9on3r7jidkz7lIH/W/peUbnXMDhUVL
         qh1w==
X-Forwarded-Encrypted: i=1; AJvYcCVwNjmUvr8MfVQdefqaDWgbDWcLSGlcfEZT4k6nabVgjDLpicgqYpL7pE925rVsdbdh0wziElSd+uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6rXkj3sIAOuFjB/z4GDUCUQpAo5blX3gFdMzMZaWoDKhX0wGB
	GtlTiQg0Js8V5g/I/dVU5aBGd3tj+zvrI5b4F1SCYjjawU876o98wwnn
X-Gm-Gg: ASbGncuhBS+N0uZco2himm2fQ0T/KiuWM8wSoT3n7kXzWSym6EYbzleeR9pYwxXeGao
	fSWBhiDgArO8huQPnkpwyjClFzfmP9tPPHvy637Zum0ucpcBTT2aBpdq59pzsvkh9sfrZtGBFa+
	jaZfLFiHDfYJjC+svsuRk8FJIy7+DcSPTHBPAT7d/8KNJEZ2m//Ae4Ti9j9jdTSiTeICov6vHQe
	mlGxNTlGXzhDUxJY2OfhMPGpcvRc1URkXggKCtgMbSoRQeFimo0jlCTUQBr5oFXpFx1NKUN6l+G
	+I/vLHGbemIlKmrzh+vmHzX3MMKcmDEG9yskfhimIdLbSUKvXNrfWAchbQPt5wWNn0FoMiKJx0K
	uQNFepoU=
X-Google-Smtp-Source: AGHT+IG2AXUrLdKYm+w+oLI5Xhyn8vldI70vnD4Eyvy/E39PZh1aBoU5Sck6Nwr7WLv8E8I3Y0W+dw==
X-Received: by 2002:a05:6a20:2586:b0:1f3:2e85:c052 with SMTP id adf61e73a8af0-21ee32b637bmr1538957637.35.1749166964110;
        Thu, 05 Jun 2025 16:42:44 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 16:42:43 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH v3 8/9] cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
Date: Thu,  5 Jun 2025 23:42:22 +0000
Message-ID: <20250605234227.970187-9-anisa.su887@gmail.com>
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

FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 152 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |   8 +-
 include/hw/cxl/cxl_device.h |   4 +
 3 files changed, 160 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 004e502b22..7ee5be00bc 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -123,6 +123,7 @@ enum {
         #define GET_HOST_DC_REGION_CONFIG   0x1
         #define SET_DC_REGION_CONFIG        0x2
         #define GET_DC_REGION_EXTENT_LIST   0x3
+        #define INITIATE_DC_ADD             0x4
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3540,6 +3541,150 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
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
+    ct3d->dc.total_extent_count += ext_count;
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
+
+/*
+ * Helper function to convert CXLDCExtentRaw to CXLUpdateDCExtentListInPl
+ * in order to reuse cxl_detect_malformed_extent_list() functin which accepts
+ * CXLUpdateDCExtentListInPl as a parameter.
+ */
+static void convert_raw_extents(CXLDCExtentRaw raw_extents[],
+                                CXLUpdateDCExtentListInPl *extent_list,
+                                int count)
+{
+    int i;
+
+    extent_list->num_entries_updated = count;
+
+    for (i = 0; i < count; i++) {
+        extent_list->updated_entries[i].start_dpa = raw_extents[i].start_dpa;
+        extent_list->updated_entries[i].len = raw_extents[i].len;
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
+    CXLUpdateDCExtentListInPl *list;
+    int i, rc;
+
+    switch (in->selection_policy) {
+    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
+        /* Adding extents exceeds device's extent tracking ability. */
+        if (in->ext_count + ct3d->dc.total_extent_count >
+            CXL_NUM_EXTENTS_SUPPORTED) {
+            return CXL_MBOX_RESOURCES_EXHAUSTED;
+        }
+
+        list = calloc(1, (sizeof(*list) +
+                          in->ext_count * sizeof(*list->updated_entries)));
+        convert_raw_extents(in->extents, list, in->ext_count);
+        rc = cxl_detect_malformed_extent_list(ct3d, list);
+
+        for (i = 0; i < in->ext_count; i++) {
+            CXLDCExtentRaw ext = in->extents[i];
+             /* Check requested extents do not overlap with pending extents. */
+            if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
+                                                     ext.start_dpa, ext.len)) {
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+            }
+            /* Check requested extents do not overlap with existing extents. */
+            if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
+                                               ext.start_dpa, ext.len)) {
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+            }
+        }
+
+        if (rc) {
+            return rc;
+        }
+
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
@@ -3667,6 +3812,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
index ee554a77be..ca9fe89e4f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1885,8 +1885,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
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
@@ -1931,8 +1931,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
     return false;
 }
 
-static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
-                                                 uint64_t dpa, uint64_t len)
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len)
 {
     CXLDCExtentGroup *group;
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 76af75d2d0..d30f6503fa 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -724,4 +724,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
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

