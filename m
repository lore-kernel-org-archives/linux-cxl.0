Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214379DD8
	for <linux-cxl@vger.kernel.org>; Mon,  4 Mar 2024 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581461; cv=none; b=aPZZKTtEkTm14yqMW8+7+NU+yofzeM32J2yW2X6j7iJ6q1sVGffo/bNXs7izOtB7Z7uecf6W/gf0sUEOkJfk/G2Nz3rA2Cz0hCC4njYuG7X4X8XOyXFfw6PYtfw+OBwVBVWm2SSUVUgGAvvUXVn+oX/DEncLsL3pHEb7QgJ4hEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581461; c=relaxed/simple;
	bh=5qNrTOKGQ+usnNUjS3Z59MU3P0kLLq50tv/qxYua/JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=havWlmNZ6Dj+W1/m+gxUm6BNEGT5H5M1BotjT68M/tWTYqY5W6nlBlJIZr4DyJ7MqeUTr0zbkSd8oEopruzyGJXmhiWNIQ2RHsKhyKTv363X18zhGS+XqzH3yjX4i+SvqokKBDS6gZaeEFb0BgH6G/isYLO5bOBJQX13a7Foxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUHnxfgw; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUHnxfgw"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60978e6f9a3so47680447b3.3
        for <linux-cxl@vger.kernel.org>; Mon, 04 Mar 2024 11:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709581459; x=1710186259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8lPD938tgQqBzbyLXCNS0GDAHx1dZoU8O4sZyz4+ao=;
        b=JUHnxfgwXblW98g2dR86brciHYVtUuNOitIgWyYV1pENXoNXzJa/nHt69e1Gs3RwK3
         FtwzF2uAoGxBQn5jlpu4OtaVbiXjaH8q/QLCp0zE0FxHTN/H89a28N4uU+HR010TlcKP
         4fUaFBRmd4gy2XGGQBDrYHXklBv+S4gAGi500Zy0awp1D1nJa5POTLqVOGVP2UetcP6u
         rXaO+4/U4cRA15m32refoUnGvIvltpDaxt2n6lYnVE0TcsRfUQwppoPn1n0ExPSRAHsD
         tDPyCHEfmmj5ntedIBT6Y1NkShTcsz3pIOIkDp6g5ZtdUOOAh3FyodTuItEwcgm9lu5/
         9tEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581459; x=1710186259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8lPD938tgQqBzbyLXCNS0GDAHx1dZoU8O4sZyz4+ao=;
        b=jWVe+LA5Dgz+ycbHSl6K3k8B4fwDaJxll63icNR9/DN67XfsbmqTZnr6B7gab4WsVp
         iYsJQifHswm34HtQaIWxPbNOyPqhxdKf5gRO0X1EZPu0id+zeMqQlkWCZ5FV2ovFUlKk
         iT/xK6Y3/RXxVYZBFQoafiErdWcdb90ew0jfzSd+31EXcJwbxphGL6VEbchDjjPs4VHO
         zr9JNLJRHSyHJqTxzmfOeOCysz14kCeDMKolyY+ZVFbDq4xDnHv/NPcJAiLIknikE5wo
         PmfR8znPKB0QsFF2neaUlC6qEq0RnJ3MJ3b7oogudjF/2obBSumvAxjHS3q5RSjRarwU
         E3XA==
X-Forwarded-Encrypted: i=1; AJvYcCV4E2eXIE7MQR2Atz8SnBdGGTUszV9eFqHF1aoHpIJgQPkeNGH9+45wFJxnYWUUbQavqCit7xpSJMQPwnsd0lfs9GtJXNFcNvZF
X-Gm-Message-State: AOJu0Yx34N0xEpptT5023ERcbfhnznOBp3VTdexursZdvXiwMu5cO5x0
	KTvFC+fHLh84z6KOLKCirwYRh6aqDICey30GlWw5ptXdCxuobH0v
X-Google-Smtp-Source: AGHT+IGMxwD7M3abEPAmA4B7Id72YrzI5ZSRaZbmHCQNrQ/PXng4IFuOLlXZLROHo70LffTiLhR0wg==
X-Received: by 2002:a25:5f48:0:b0:dbf:6267:eba4 with SMTP id h8-20020a255f48000000b00dbf6267eba4mr7589407ybm.27.1709581458654;
        Mon, 04 Mar 2024 11:44:18 -0800 (PST)
Received: from localhost.localdomain ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id h1-20020a255f41000000b00dc62edd58dasm2282646ybm.40.2024.03.04.11.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:44:18 -0800 (PST)
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
Subject: [PATCH v5 07/13] hw/mem/cxl_type3: Add DC extent list representative and get DC extent list mailbox support
Date: Mon,  4 Mar 2024 11:34:02 -0800
Message-ID: <20240304194331.1586191-8-nifan.cxl@gmail.com>
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

Add dynamic capacity extent list representative to the definition of
CXLType3Dev and add get DC extent list mailbox command per
CXL.spec.3.1:.8.2.9.9.9.2.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 71 ++++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h | 22 ++++++++++++
 3 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 8309f27a2b..425b378a2c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -84,6 +84,7 @@ enum {
         #define CLEAR_POISON           0x2
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
+        #define GET_DYN_CAP_EXT_LIST   0x1
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1325,7 +1326,8 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
      * to use.
      */
     stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
-    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED);
+    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED -
+             ct3d->dc.total_extent_count);
     stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
     stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
 
@@ -1333,6 +1335,70 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.1 section 8.2.9.9.9.2:
+ * Get Dynamic Capacity Extent List (Opcode 4801h)
+ */
+static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
+                                               uint8_t *payload_in,
+                                               size_t len_in,
+                                               uint8_t *payload_out,
+                                               size_t *len_out,
+                                               CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    struct {
+        uint32_t extent_cnt;
+        uint32_t start_extent_id;
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct {
+        uint32_t count;
+        uint32_t total_extents;
+        uint32_t generation_num;
+        uint8_t rsvd[4];
+        CXLDCExtentRaw records[];
+    } QEMU_PACKED *out = (void *)payload_out;
+    uint16_t record_count = 0, i = 0, record_done = 0;
+    uint16_t out_pl_len;
+    uint32_t start_extent_id = in->start_extent_id;
+    CXLDCExtentList *extent_list = &ct3d->dc.extents;
+    CXLDCExtent *ent;
+
+    if (start_extent_id > ct3d->dc.total_extent_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.total_extent_count - start_extent_id);
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    stl_le_p(&out->count, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (i++ < start_extent_id) {
+                continue;
+            }
+            stq_le_p(&out->records[record_done].start_dpa, ent->start_dpa);
+            stq_le_p(&out->records[record_done].len, ent->len);
+            memcpy(&out->records[record_done].tag, ent->tag, 0x10);
+            stw_le_p(&out->records[record_done].shared_seq, ent->shared_seq);
+
+            record_done++;
+            if (record_done == record_count) {
+                break;
+            }
+        }
+    }
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1380,6 +1446,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
     [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
         cmd_dcd_get_dyn_cap_config, 2, 0 },
+    [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
+        "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
+        8, 0 },
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 2b380a260b..102fa8151e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -673,6 +673,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         region_base += region->len;
         ct3d->dc.total_capacity += region->len;
     }
+    QTAILQ_INIT(&ct3d->dc.extents);
 
     return true;
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 265679302c..8148bcc34b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -424,6 +424,25 @@ typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 
 #define DCD_MAX_NUM_REGION 8
 
+typedef struct CXLDCExtentRaw {
+    uint64_t start_dpa;
+    uint64_t len;
+    uint8_t tag[0x10];
+    uint16_t shared_seq;
+    uint8_t rsvd[0x6];
+} QEMU_PACKED CXLDCExtentRaw;
+
+typedef struct CXLDCExtent {
+    uint64_t start_dpa;
+    uint64_t len;
+    uint8_t tag[0x10];
+    uint16_t shared_seq;
+    uint8_t rsvd[0x6];
+
+    QTAILQ_ENTRY(CXLDCExtent) node;
+} CXLDCExtent;
+typedef QTAILQ_HEAD(, CXLDCExtent) CXLDCExtentList;
+
 typedef struct CXLDCRegion {
     uint64_t base;       /* aligned to 256*MiB */
     uint64_t decode_len; /* aligned to 256*MiB */
@@ -470,6 +489,9 @@ struct CXLType3Dev {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
         uint64_t total_capacity; /* 256M aligned */
+        CXLDCExtentList extents;
+        uint32_t total_extent_count;
+        uint32_t ext_list_gen_seq;
 
         uint8_t num_regions; /* 0-8 regions */
         CXLDCRegion regions[DCD_MAX_NUM_REGION];
-- 
2.43.0

