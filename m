Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851A26772D
	for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976912; cv=none; b=aZ4hr7XGFycWCE4B33Cz+DIJ67WzrveWlC94UdPSWbE4UtxelaXiwLPC/v/ONlU/9a+lb0iywn4DM30zdtItG+CG65GbadDVvrgA5oGStRC56esyCyuVFy2VKVed4jVc1LkXPI6UhSNCBZUlr44zKC83HIK5WKKwUmznX985DR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976912; c=relaxed/simple;
	bh=12ltI3fzH3jhWjzRFDCY5OqOVSXHaoQo0/+9i7BTU1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgzZQQg+zkbMMLWHINmNSQqbi2237SOBsCd5ZelDb+eLg7UQ6pTGdfIsUdh3WhBLHmoFgW3ORz2lyUez4KLddMHozuNOCHhbYtyWoKUaePPlrJvOaGM0RnJ0jb4flVKseuUr41uhg8TLxK/MeYZkbyNt2DVwOEFkA/pyI89UwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxK3ZkVS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxK3ZkVS"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23694cec0feso17496145ad.2
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750976910; x=1751581710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0+GG0gjJCw7pfb+JxSIZ+IHUVC7BruErkqzXq+9RoU=;
        b=cxK3ZkVS0ka1N2otiSHJg3lPMzsaXEdMZtRIHJVnA/FVMhQS2ezljwcUCwVYbgVxrW
         21q+HIIKvUuMV9yowMwQODTaIjAOqlGZT3pF9tBbmQHQAiPqBW+NV8cRx0C7etjZl5XO
         Dz4cafS+Af4gr25Fo17u+afxpyJQRtLwmYbpJH6bQXREgsbh/+zjR1qozoKKMDU3Nltv
         I/lWakso74M6I78e+N3+TFwewOCEX7gRh+dSL0AfBM20J1BYMl9cntNk6y9QND1MTczt
         PrZmcrNW5m//HssOykaIOHRPwuKuLPSklkqRyPibZ6BVHynH5ajEaUTbxkDlv+ngruFj
         C/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750976910; x=1751581710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0+GG0gjJCw7pfb+JxSIZ+IHUVC7BruErkqzXq+9RoU=;
        b=N/fGOifEBc3ocY8SASkeiP2zui/19+8/k39JHQuyqR9RFMAnu1Z5fkeBEpluAZ20xF
         CebQhQ9rSoeyNwtmVgedVVhA/98uIR9cTl7CC5jq0mkaMFdRWI86stX1SZovFRWL8yOt
         +U5ezvsLDlO+ozvFbdLkjmzCuqTh3FLsNqPKgjgWHTbN4O58yH7qc7fg58bpDjVJmUqs
         9sdT4uIUNYB8SiutWT9zva4f+nseCizZL3K/As/jQb5MQbp5MZ2iwG69QuSWJnfQo2Y7
         w/qg5GZGwr8KjsgMMbKFsu4uanz0doOui4ORdtGLIrW5MN2H9OxcvSlFKOybdOfk3rFq
         eXGg==
X-Forwarded-Encrypted: i=1; AJvYcCUgtezxS9iEtRfHl6jmzgjpO1H9HN3om1kDlAYGX5Zeqi3Xd3S9zvb1YkxT4LjaSmMuo68uW+1r84c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+JCHV8umMvnrUOWn0PH8rbUogegoemvOtKrSKJ5I6zcoMuiP6
	k/CDLlEYvpsio1DvpT67hxjFA5uQz+1qS99UdjSjScb1defNyqwNIEWq
X-Gm-Gg: ASbGnctZUYB2JPAXphsMkUMYGAvNRlHqsjXhbIE1OWkmNNqQP2edAUnK8pVCipl5ND5
	O4o4i8eMjWu+jZObRFUC3xd5z5ZuxqnSI1LFQihbW7YLXTV0bkYGoANaFhYcCiFgN8uKy2/XEjC
	QN+yiaNi9WfPnB+CXodbI4llgoA+Bs6QWaTxEcxzL6eSso0OTP0bgU+3YRD+wkYgvMswgVzLEG0
	5QURVAr2KVbMczW3Nc7KiRrpdD6xv7kYob58LQyz+9u/wb3epknADm9+OWTayr+I9867+GydfHy
	QrNadDoNVKitMKrilOuEvCzM0F/algm/Qsk1stHwdYJ7eWmD9tWFtNwv+Ml1oTZFEvR+SyUvlXX
	YXPkFcvhwjcuGYvpvmQ==
X-Google-Smtp-Source: AGHT+IGb7C9jfd9dLU4Z2QTBlI1DepmvSTcctPfgZhCBugJCbUg3ZaVrc15bUxaL4S6DLsL6lJyw+Q==
X-Received: by 2002:a17:902:e5c9:b0:234:9656:7db9 with SMTP id d9443c01a7336-23ac4633b92mr13533185ad.32.1750976909974;
        Thu, 26 Jun 2025 15:28:29 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 15:28:29 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	alok.a.tiwari@oracle.com,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH v4 09/10] cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
Date: Thu, 26 Jun 2025 22:23:32 +0000
Message-ID: <20250626222743.1766404-10-anisa.su887@gmail.com>
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

FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 106 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |   8 +--
 include/hw/cxl/cxl_device.h |   4 ++
 3 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 382c41c025..787eeaa7b9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -122,6 +122,7 @@ enum {
         #define GET_HOST_DC_REGION_CONFIG   0x1
         #define SET_DC_REGION_CONFIG        0x2
         #define GET_DC_REGION_EXTENT_LIST   0x3
+        #define INITIATE_DC_ADD             0x4
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3539,6 +3540,104 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * Helper function to convert CXLDCExtentRaw to CXLUpdateDCExtentListInPl
+ * in order to reuse cxl_detect_malformed_extent_list() function which accepts
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
+    int i, rc;
+
+    switch (in->selection_policy) {
+        case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE: {
+            /* Adding extents exceeds device's extent tracking ability. */
+            if (in->ext_count + ct3d->dc.total_extent_count >
+                CXL_NUM_EXTENTS_SUPPORTED) {
+                return CXL_MBOX_RESOURCES_EXHAUSTED;
+            }
+
+            g_autofree CXLUpdateDCExtentListInPl *list =
+                g_malloc0(sizeof(*list) +
+                    in->ext_count * sizeof(*list->updated_entries));
+
+            convert_raw_extents(in->extents, list, in->ext_count);
+            rc = cxl_detect_malformed_extent_list(ct3d, list);
+
+            for (i = 0; i < in->ext_count; i++) {
+                CXLDCExtentRaw ext = in->extents[i];
+                /* Check requested extents do not overlap with pending extents. */
+                if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
+                                                         ext.start_dpa, ext.len)) {
+                    return CXL_MBOX_INVALID_EXTENT_LIST;
+                }
+                /* Check requested extents do not overlap with existing extents. */
+                if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
+                                                   ext.start_dpa, ext.len)) {
+                    return CXL_MBOX_INVALID_EXTENT_LIST;
+                }
+            }
+
+            if (rc) {
+                return rc;
+            }
+
+            CXLDCExtentGroup *group = NULL;
+            for (i = 0; i < in->ext_count; i++) {
+                group = cxl_insert_extent_to_extent_group(group,
+                                                          in->extents[i].start_dpa,
+                                                          in->extents[i].len,
+                                                          in->extents[i].tag,
+                                                          in->extents[i].shared_seq);
+            }
+
+            cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
+            ct3d->dc.total_extent_count += in->ext_count;
+            cxl_create_dc_event_records_for_extents(ct3d,
+                                                    DC_EVENT_ADD_CAPACITY,
+                                                    in->extents,
+                                                    in->ext_count);
+
+            return CXL_MBOX_SUCCESS;
+        }
+        default: {
+            qemu_log_mask(LOG_UNIMP,
+                          "CXL extent selection policy not supported.\n");
+            return CXL_MBOX_INVALID_INPUT;
+        }
+    }
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3666,6 +3765,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
index 9c2b9d197b..7676d785c2 100644
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
index 91ec1ba299..7be68d98c6 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -736,4 +736,8 @@ void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
                                              CXLDCEventType type,
                                              CXLDCExtentRaw extents[],
                                              uint32_t ext_count);
+bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
+                                    uint64_t dpa, uint64_t len);
+bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
+                                          uint64_t dpa, uint64_t len);
 #endif
-- 
2.47.2

