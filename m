Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F4220320
	for <linux-cxl@vger.kernel.org>; Wed, 17 Jan 2024 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503943; cv=pass; b=HgR8Gg+qOHgoycVpHKEbzO2Jr7fELsHxSLaJTlEuOMuiihRRxhkgIJI3rYIttTqMSTZjMHOaQrjLntJBrU7Mxq+dbgL9Hw0JmHx8QuUoBAB6ZD0TbvF5zvRspB+0meR7bfyBk2sdveQQwcYJP3GFlqw/ju9pOvh6abs0z+q3NJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503943; c=relaxed/simple;
	bh=E3S/T4W8+nNvoRm5UcOSgBVSxWkxgGA1HTTYSnHBfm0=;
	h=X-Sender-Id:Received:Received:ARC-Message-Signature:
	 ARC-Authentication-Results:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Interest-Print:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding; b=gYRQvDlNSN81CWpUo6z49wi4L5xRQuyeRjmejl+DnubxHUjPITcbhlWOyRudYbNe6pM0uJlpmswsm4r+5YItbQYPHcnwONIZj3GBSHiQO10TposQtqUtYeecD0/t0kpjpkO+tYQAX6HGDGt5Ux9lvHHx1Y3vv+ETR0HLZ6u6vTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=K71p64ql; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="K71p64ql"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C3C3C942E1E;
	Wed, 17 Jan 2024 08:25:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a309.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 55B4A943560;
	Wed, 17 Jan 2024 08:25:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1705479901; a=rsa-sha256;
	cv=none;
	b=UdnKC/x9K8mU8cMQkTerx2V3OeJqerKfkP2+eSVXfFb6PVaHdlxAXOPsylNLZ4ZeCGsztJ
	TIzHL64OWu7LulGnMHydA+faThk5zlb5ZsDsk1X0SbTkZkTPy5G6XMorCHLL6XR5YDd5WH
	kOtvC2Oa9fJyZdgghMoYkLox6pDjg+QwcDY8bzD9MsCleX1Wmq94yRuKlBOXzx7SgxrGYF
	uRDFvDGfFlj1zf57J534fQijcRsowVZ5l3z3LWWKOf7pqMKC9ecclUwe5yZLsS7bVCAJwa
	SJV5wyPz1fUcfwqOpSv8Jka/OR8Ig0QCrrXEYgf5fhQ07BTUi+u97sUV9jLoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1705479901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=UNjH/SI+91e/1/x5n/nVjIrrp2z/EZZd79WiHojFOMw=;
	b=GvjZ3LH3j1Xi+5Ophu/5Yf0TkbPUaWTj1RVVWBvMwG6Z5YkQe6lB5+a00z2cRMNY1TR3lT
	TRnHXrCtfuYR1z3/K3vCOwTEq1TfKaTFDV5HeIGXanbJXIj6meYqcKzGPEJb/NGrMaW8lv
	jTmeegBww1k32GyRHQpQlJQz5mAhQjtagvKHfJ+iwtZjO1wucarS1Cu0Zp5hLtOU+RlIPd
	pa1gGgwTxCgdjIEE6PAsWuCnxRUnnFOUtADnwm1GP90HzSjdIRnSo+lroqJjotT9APQKri
	KN9v3p1MkRndAIAOAVkrWXWAPBvSSw8etGEDSdj98+J3Lmf0IG1zQgpUWQAOIg==
ARC-Authentication-Results: i=1;
	rspamd-568947cb6c-t8d4c;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Interest-Print: 7595534d78a3bf6e_1705479901670_3904412535
X-MC-Loop-Signature: 1705479901670:2845310478
X-MC-Ingress-Time: 1705479901670
Received: from pdx1-sub0-mail-a309.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.169.71 (trex/6.9.2);
	Wed, 17 Jan 2024 08:25:01 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a309.dreamhost.com (Postfix) with ESMTPSA id 4TFJpN41jnzM3;
	Wed, 17 Jan 2024 00:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1705479901;
	bh=UNjH/SI+91e/1/x5n/nVjIrrp2z/EZZd79WiHojFOMw=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=K71p64qlnyup9SFQpuTRTt4Q5CY+43STiwvQvYV2bLcRkTGQrNWdrE4IizBWw7AhS
	 8AGCkLAP00tvDAh7tzkCt3pR9tiKYVBEPCjvo88U9ULZHIL6izQpB7RiscFja3hiwt
	 OkUxtNbIUrNUwuTMsIBppYeXegeJmIzlGdIoUFI1FCSPK6KnbCjvUSHwYQMygYYWW+
	 hiu6lIy/f8IDl0koka96BQxzLK8Cz/SfTkwUEKQzaSupb3aFdWv3xJB9CY+6qIyI8o
	 fUY0hI3WuhpnFKum6r1DIJEGnhefGNEH91dAsyNUdxGJ9izyFlHa1ifvZhO+GewcwO
	 UocKuJ9X+Awsg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	a.manzanares@samsung.com,
	mounika.k@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH -qemu] hw/cxl: Add Maintenance support
Date: Wed, 17 Jan 2024 00:24:35 -0800
Message-ID: <20240117082435.11348-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds initial support for the Maintenance command, specifically
the soft and hard PPR operations on a dpa. The implementation allows
to be executed at runtime, therefore semantically, data is retained
and CXL.mem requests are correctly processed.

Keep track of the requests upon a general media or DRAM event.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Only mildly tested through qmp event injection.
Applies on top of the Features machinery:
	https://lore.kernel.org/linux-cxl/20231124135338.1191-2-shiju.jose@huawei.com/

 hw/cxl/cxl-mailbox-utils.c  | 233 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |  52 ++++++--
 hw/mem/cxl_type3_stubs.c    |   4 +-
 include/hw/cxl/cxl_device.h |  15 +++
 include/hw/cxl/cxl_events.h |   5 +-
 qapi/cxl.json               |  18 +++
 6 files changed, 314 insertions(+), 13 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 67bfcadf8b49..9df3d2894a9f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -100,13 +100,15 @@ enum {
         #define MANAGEMENT_COMMAND     0x0
     MHD = 0x55,
         #define GET_MHD_INFO 0x0
-    DCD_MANAGEMENT = 0x56
+    DCD_MANAGEMENT = 0x56,
         #define GET_DCD_INFO 0x0
         #define GET_HOST_DC_REGION_CONFIG 0x1
         #define SET_DC_REGION_CONFIG 0x2 /* Why not host? huh...*/
         #define GET_DC_REGION_EXTENT_LIST 0x3
         #define INITIATE_DC_ADD 0x4
         #define INITIATE_DC_RELEASE 0x5
+    MAINTENANCE = 0x60,
+        #define PERFORM 0x0
 };
 
 /* CCI Message Format CXL r3.0 Figure 7-19 */
@@ -989,6 +991,8 @@ typedef struct CXLSupportedFeatureEntry {
 } QEMU_PACKED CXLSupportedFeatureEntry;
 
 enum CXL_SUPPORTED_FEATURES_LIST {
+    CXL_FEATURE_SPPR,
+    CXL_FEATURE_HPPR,
     CXL_FEATURE_MAX
 };
 
@@ -1029,6 +1033,46 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
     CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
 };
 
+/*
+ * CXL r3.1 section 8.2.9.7.2.1: sPPR Feature Discovery and Configuration
+ * CXL r3.1 section 8.2.9.7.2.2: hPPR Feature Discovery and Configuration
+ */
+static const QemuUUID soft_ppr_uuid = {
+    .data = UUID(0x892ba475, 0xfad8, 0x474e, 0x9d, 0x3e,
+                 0x69, 0x2c, 0x91, 0x75, 0x68, 0xbb)
+};
+
+static const QemuUUID hard_ppr_uuid = {
+    .data = UUID(0x80ea4521, 0x786f, 0x4127, 0xaf, 0xb1,
+                 0xec, 0x74, 0x59, 0xfb, 0x0e, 0x24)
+};
+
+typedef struct CXLPPReadAttr {
+    uint8_t max_maint_latency;
+    uint16_t op_caps;
+    uint16_t op_mode;
+    uint8_t maint_op_class;
+    uint8_t maint_op_subclass;
+    uint8_t rsvd[9];
+    uint8_t ppr_flags;
+    uint16_t restriction_flags;
+    uint8_t ppr_op_mode;
+} QEMU_PACKED CXLPPReadAttr;
+static CXLPPReadAttr cxl_memdev_hppr_feat_read_attr;
+static CXLPPReadAttr cxl_memdev_sppr_feat_read_attr;
+
+typedef struct CXLPPRWriteAttr {
+    uint16_t op_mode;
+    uint8_t ppr_op_mode;
+} QEMU_PACKED CXLPPRWriteAttr;
+static CXLPPRWriteAttr cxl_memdev_hppr_feat_write_attr;
+static CXLPPRWriteAttr cxl_memdev_sppr_feat_write_attr;
+
+typedef struct CXLPPRSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLPPRWriteAttr feat_data;
+} QEMU_PACKED QEMU_ALIGNED(16) CXLPPRSetFeature;
+
 /* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
 static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -1052,7 +1096,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
     uint16_t feat_entries = 0;
 
     if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
-        get_feats_in->start_index > CXL_FEATURE_MAX) {
+        get_feats_in->start_index >= CXL_FEATURE_MAX) {
         return CXL_MBOX_INVALID_INPUT;
     }
     req_entries = (get_feats_in->count -
@@ -1064,6 +1108,62 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
     entry = 0;
     while (entry < req_entries) {
         switch (index) {
+        case CXL_FEATURE_SPPR:
+            /* Fill supported feature entry for sPPR */
+            get_feats_out->feat_entries[entry] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = soft_ppr_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(cxl_memdev_sppr_feat_read_attr),
+                .set_feat_size = sizeof(cxl_memdev_sppr_feat_write_attr),
+                .attrb_flags = BIT(0) | BIT(5),
+                .get_feat_version = 0x2,
+                .set_feat_version = 0x2,
+                .set_feat_effects = 0,
+            };
+            feat_entries++;
+
+            /* 100 ms */
+            cxl_memdev_sppr_feat_read_attr.max_maint_latency = 0x5;
+            /* only start maintanance when explicitly requested */
+            cxl_memdev_sppr_feat_read_attr.op_caps = 0;
+            cxl_memdev_sppr_feat_read_attr.op_mode = 0;
+            cxl_memdev_sppr_feat_read_attr.maint_op_class = 0x1;
+            cxl_memdev_sppr_feat_read_attr.maint_op_subclass = 0;
+            /* dpa support */
+            cxl_memdev_sppr_feat_read_attr.ppr_flags = BIT(0);
+            /* data is retained across maintenance */
+            cxl_memdev_sppr_feat_read_attr.restriction_flags = 0;
+            cxl_memdev_sppr_feat_read_attr.ppr_op_mode = 0;
+            break;
+        case CXL_FEATURE_HPPR:
+            /* Fill supported feature entry for hPPR */
+            get_feats_out->feat_entries[entry] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = hard_ppr_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(cxl_memdev_hppr_feat_read_attr),
+                .set_feat_size = sizeof(cxl_memdev_hppr_feat_write_attr),
+                .attrb_flags = BIT(0) | BIT(5),
+                .get_feat_version = 0x2,
+                .set_feat_version = 0x2,
+                .set_feat_effects = 0,
+            };
+            feat_entries++;
+
+            /* 100 ms */
+            cxl_memdev_hppr_feat_read_attr.max_maint_latency = 0x5;
+            /* only start maintanance when explicitly requested */
+            cxl_memdev_hppr_feat_read_attr.op_caps = 0;
+            cxl_memdev_hppr_feat_read_attr.op_mode = 0;
+            cxl_memdev_hppr_feat_read_attr.maint_op_class = 0x1;
+            cxl_memdev_hppr_feat_read_attr.maint_op_subclass = 0x1;
+            /* dpa support */
+            cxl_memdev_hppr_feat_read_attr.ppr_flags = BIT(0);
+            /* data is retained across maintenance */
+            cxl_memdev_hppr_feat_read_attr.restriction_flags = 0;
+            cxl_memdev_hppr_feat_read_attr.ppr_op_mode = 0;
+            break;
         default:
             break;
         }
@@ -1104,6 +1204,32 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_INPUT;
     }
 
+    if (qemu_uuid_is_equal(&get_feature->uuid, &soft_ppr_uuid)) {
+        if (get_feature->offset >= sizeof(cxl_memdev_sppr_feat_read_attr)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(cxl_memdev_sppr_feat_read_attr) -
+                                             get_feature->offset;
+        bytes_to_copy = (bytes_to_copy > get_feature->count) ?
+                               get_feature->count : bytes_to_copy;
+        memcpy(payload_out,
+               &cxl_memdev_sppr_feat_read_attr + get_feature->offset,
+               bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &hard_ppr_uuid)) {
+        if (get_feature->offset >= sizeof(cxl_memdev_hppr_feat_read_attr)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(cxl_memdev_hppr_feat_read_attr) -
+                                             get_feature->offset;
+        bytes_to_copy = (bytes_to_copy > get_feature->count) ?
+                               get_feature->count : bytes_to_copy;
+        memcpy(payload_out,
+               &cxl_memdev_hppr_feat_read_attr + get_feature->offset,
+               bytes_to_copy);
+    } else {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
     *len_out = bytes_to_copy;
 
     return CXL_MBOX_SUCCESS;
@@ -1117,6 +1243,106 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                                            size_t *len_out,
                                            CXLCCI *cci)
 {
+    CXLSetFeatureInHeader *hdr = (void *)payload_in;
+
+    if (qemu_uuid_is_equal(&hdr->uuid, &soft_ppr_uuid)) {
+        CXLPPRWriteAttr *sppr_write_attr;
+        CXLPPRSetFeature *sppr_set_feature;
+
+        if (hdr->version != 0x2 ||
+            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=
+                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        sppr_set_feature = (void *)payload_in;
+        sppr_write_attr = &sppr_set_feature->feat_data;
+        cxl_memdev_sppr_feat_read_attr.op_mode = sppr_write_attr->op_mode;
+        cxl_memdev_sppr_feat_read_attr.ppr_op_mode = sppr_write_attr->ppr_op_mode;
+    } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
+        CXLPPRWriteAttr *hppr_write_attr;
+        CXLPPRSetFeature *hppr_set_feature;
+
+        if (hdr->version != 0x2 ||
+            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=
+                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        hppr_set_feature = (void *)payload_in;
+        hppr_write_attr = &hppr_set_feature->feat_data;
+        cxl_memdev_hppr_feat_read_attr.op_mode = hppr_write_attr->op_mode;
+        cxl_memdev_hppr_feat_read_attr.ppr_op_mode = hppr_write_attr->ppr_op_mode;
+    } else {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
+static void cxl_perform_ppr(CXLType3Dev *ct3d, uint64_t dpa)
+{
+    CXLMaintenance *ent, *next;
+
+    QLIST_FOREACH_SAFE(ent, &ct3d->maint_list, node, next) {
+        if (dpa == ent->dpa) {
+            QLIST_REMOVE(ent, node);
+            g_free(ent);
+            break;
+        }
+    }
+    /* TODO: produce a Memory Sparing Event Record */
+}
+
+/* CXL r3.1 section 8.2.9.7.1 - Perform Maintenance (Opcode 600h) */
+static CXLRetCode cmd_media_perform_maintenance(const struct cxl_cmd *cmd,
+                                   uint8_t *payload_in, size_t len_in,
+                                   uint8_t *payload_out, size_t *len_out,
+                                   CXLCCI *cci)
+{
+    struct {
+        uint8_t class;
+        uint8_t subclass;
+        union {
+            struct {
+                uint8_t flags;
+                uint64_t dpa;
+                uint8_t nibble_mask[3];
+            } ppr;
+        };
+    } QEMU_PACKED *maint_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+
+    if (maintenance_running(cci)) {
+        return CXL_MBOX_BUSY;
+    }
+
+    maint_in = (void *)payload_in;
+
+    switch (maint_in->class) {
+    case 0:
+        return CXL_MBOX_SUCCESS; /* nop */
+    case 1:
+        if (maint_in->ppr.flags & BIT(0)) {
+            /* resources are always available */
+            break;
+        }
+
+        switch (maint_in->subclass) {
+        case 0: /* soft ppr */
+        case 1: /* hard ppr */
+            cxl_perform_ppr(ct3d, ldq_le_p(&maint_in->ppr.dpa));
+            break;
+        default:
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        break;
+    case 2:
+    case 3:
+        return CXL_MBOX_UNSUPPORTED;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
     return CXL_MBOX_SUCCESS;
 }
 
@@ -2366,6 +2592,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
         cmd_media_get_scan_media_results, 0, 0 },
     [MHD][GET_MHD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_info, 2, 0},
+    [MAINTENANCE][PERFORM] = { "MAINTENANCE_PERFORM",
+        cmd_media_perform_maintenance, ~0,  CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+        CXL_MBOX_IMMEDIATE_DATA_CHANGE | CXL_MBOX_BACKGROUND_OPERATION },
 };
 
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 85fc08f118d0..ad1441e89407 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1679,12 +1679,15 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
 
 static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                                     const QemuUUID *uuid, uint32_t flags,
-                                    uint8_t length, uint64_t timestamp)
+                                    uint8_t length, uint64_t timestamp,
+                                    uint8_t maint_class, uint8_t maint_subclass)
 {
     st24_le_p(&hdr->flags, flags);
     hdr->length = length;
     memcpy(&hdr->id, uuid, sizeof(hdr->id));
     stq_le_p(&hdr->timestamp, timestamp);
+    hdr->maint_op_class = maint_class;
+    hdr->maint_op_subclass = maint_subclass;
 }
 
 static const QemuUUID gen_media_uuid = {
@@ -1724,9 +1727,25 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
         return -EINVAL;
     }
 }
+
+static void cxl_maintenance_insert(CXLType3Dev *ct3d, uint64_t dpa)
+{
+    CXLMaintenance *ent, *m;
+
+    QLIST_FOREACH(ent, &ct3d->maint_list, node) {
+        if (dpa == ent->dpa) {
+            return;
+        }
+    }
+    m = g_new0(CXLMaintenance, 1);
+    m->dpa = dpa;
+    QLIST_INSERT_HEAD(&ct3d->maint_list, m, node);
+}
+
 /* Component ID is device specific.  Define this as a string. */
 void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint64_t dpa,
+                                        uint8_t flags, uint8_t class,
+                                        uint8_t subclass, uint64_t dpa,
                                         uint8_t descriptor, uint8_t type,
                                         uint8_t transaction_type,
                                         bool has_channel, uint8_t channel,
@@ -1760,11 +1779,16 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
         error_setg(errp, "Unhandled error log type");
         return;
     }
+    if (rc == CXL_EVENT_TYPE_INFO && (flags & BIT(3))) {
+        error_setg(errp, "Informational event cannot require maintanence");
+        return;
+    }
     enc_log = rc;
 
     memset(&gem, 0, sizeof(gem));
     cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            class, subclass);
 
     stq_le_p(&gem.phys_addr, dpa);
     gem.descriptor = descriptor;
@@ -1797,6 +1821,10 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
         cxl_event_irq_assert(ct3d);
     }
+
+    if (flags & BIT(3)) {
+        cxl_maintenance_insert(ct3d, dpa);
+    }
 }
 
 #define CXL_DRAM_VALID_CHANNEL                          BIT(0)
@@ -1809,6 +1837,7 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
 #define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
 
 void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
+                               uint8_t class, uint8_t subclass,
                                uint64_t dpa, uint8_t descriptor,
                                uint8_t type, uint8_t transaction_type,
                                bool has_channel, uint8_t channel,
@@ -1847,11 +1876,15 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
         error_setg(errp, "Unhandled error log type");
         return;
     }
+    if (rc == CXL_EVENT_TYPE_INFO && (flags & BIT(3))) {
+        error_setg(errp, "Informational event cannot require maintanence");
+        return;
+    }
     enc_log = rc;
 
     memset(&dram, 0, sizeof(dram));
     cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate), 0, 0);
     stq_le_p(&dram.phys_addr, dpa);
     dram.descriptor = descriptor;
     dram.type = type;
@@ -1908,7 +1941,10 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
         cxl_event_irq_assert(ct3d);
     }
-    return;
+
+    if (flags & BIT(3)) {
+        cxl_maintenance_insert(ct3d, dpa);
+    }
 }
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
@@ -1951,7 +1987,7 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
 
     memset(&module, 0, sizeof(module));
     cxl_assign_event_header(hdr, &memory_module_uuid, flags, sizeof(module),
-                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate), 0, 0);
 
     module.type = type;
     module.health_status = health_status;
@@ -2015,7 +2051,7 @@ static int cxl_process_dcd_req(CXLType3Dev *dcd, CXLDCEventType type,
      * Event Log.
      */
     cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
-                            cxl_device_get_timestamp(&dcd->cxl_dstate));
+                            cxl_device_get_timestamp(&dcd->cxl_dstate), 0, 0);
 
     dCap.type = type;
     stw_le_p(&dCap.host_id, hid);
@@ -2197,7 +2233,7 @@ static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
      * Event Log.
      */
     cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
-                            cxl_device_get_timestamp(&dcd->cxl_dstate));
+                            cxl_device_get_timestamp(&dcd->cxl_dstate), 0, 0);
 
     dCap.type = type;
     stw_le_p(&dCap.host_id, hid);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index d913b11b4df9..8101eaf0ae49 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -14,7 +14,8 @@
 #include "qapi/qapi-commands-cxl.h"
 
 void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
-                                        uint8_t flags, uint64_t dpa,
+                                        uint8_t flags, uint8_t class,
+                                        uint8_t subclass, uint64_t dpa,
                                         uint8_t descriptor, uint8_t type,
                                         uint8_t transaction_type,
                                         bool has_channel, uint8_t channel,
@@ -24,6 +25,7 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         Error **errp) {}
 
 void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
+                               uint8_t class, uint8_t subclass,
                                uint64_t dpa, uint8_t descriptor,
                                uint8_t type, uint8_t transaction_type,
                                bool has_channel, uint8_t channel,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index b2cb280e1631..82b93974b837 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -426,6 +426,11 @@ static inline bool sanitize_running(CXLCCI *cci)
     return !!cci->bg.runtime && cci->bg.opcode == 0x4400;
 }
 
+static inline bool maintenance_running(CXLCCI *cci)
+{
+    return !!cci->bg.runtime && cci->bg.opcode == 0x600;
+}
+
 typedef struct CXLError {
     QTAILQ_ENTRY(CXLError) node;
     int type; /* Error code as per FE definition */
@@ -434,6 +439,13 @@ typedef struct CXLError {
 
 typedef QTAILQ_HEAD(, CXLError) CXLErrorList;
 
+typedef struct CXLMaintenance {
+    uint64_t dpa;
+    QLIST_ENTRY(CXLMaintenance) node;
+} CXLMaintenance;
+
+typedef QLIST_HEAD(, CXLMaintenance) CXLMaintenanceList;
+
 typedef struct CXLPoison {
     uint64_t start, length;
     uint8_t type;
@@ -520,6 +532,9 @@ struct CXLType3Dev {
     /* Error injection */
     CXLErrorList error_list;
 
+    /* Keep track of maintenance requests */
+    CXLMaintenanceList maint_list;
+
     /* Poison Injection - cache */
     CXLPoisonList poison_list;
     unsigned int poison_list_cnt;
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 4f8cb3215d30..ec3157829f51 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -29,9 +29,9 @@ typedef enum CXLEventLogType {
 
 /*
  * Common Event Record Format
- * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
+ * CXL rev 3.1 section 8.2.9.2.1; Table 8-43
  */
-#define CXL_EVENT_REC_HDR_RES_LEN 0xf
+#define CXL_EVENT_REC_HDR_RES_LEN 0xe
 typedef struct CXLEventRecordHdr {
     QemuUUID id;
     uint8_t length;
@@ -40,6 +40,7 @@ typedef struct CXLEventRecordHdr {
     uint16_t related_handle;
     uint64_t timestamp;
     uint8_t maint_op_class;
+    uint8_t maint_op_subclass;
     uint8_t reserved[CXL_EVENT_REC_HDR_RES_LEN];
 } QEMU_PACKED CXLEventRecordHdr;
 
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 1b134680239b..3e168d306b42 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -43,6 +43,14 @@
 # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
 #     Record Format, Event Record Flags for subfield definitions.
 #
+# @class: Maintenance class operation the device requests to initiate.
+#     See CXL r3.0 Table 8-42 CXL r3.0 Table 8-42 Common Event
+#     Record Format.
+#
+# @subclass: Maintenance subclass operation the device requests to
+#     initiate. See CXL r3.0 Table 8-42 CXL r3.0 Table 8-42 Common
+#     Event Record Format.
+#
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
 #     Media Event Record, Physical Address.
@@ -75,6 +83,7 @@
 ##
 { 'command': 'cxl-inject-general-media-event',
   'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
+            'class':'uint8', 'subclass':'uint8',
             'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8',
@@ -94,6 +103,14 @@
 # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
 #     Record Format, Event Record Flags for subfield definitions.
 #
+# @class: Maintenance class operation the device requests to initiate.
+#     See CXL r3.0 Table 8-42 CXL r3.0 Table 8-42 Common Event
+#     Record Format.
+#
+# @subclass: Maintenance subclass operation the device requests to
+#     initiate. See CXL r3.0 Table 8-42 CXL r3.0 Table 8-42 Common
+#     Event Record Format.
+#
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
 #     Event Record, Physical Address.
@@ -134,6 +151,7 @@
 ##
 { 'command': 'cxl-inject-dram-event',
   'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
+            'class':'uint8', 'subclass':'uint8',
             'dpa': 'uint64', 'descriptor': 'uint8',
             'type': 'uint8', 'transaction-type': 'uint8',
             '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
-- 
2.43.0

