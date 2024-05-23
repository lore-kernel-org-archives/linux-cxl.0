Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E6417C77
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486534; cv=none; b=ih6Rp4iSmlRtLE3qxDC44nv6jNQ2iDqeB6C401j4vKQXNrE3SxBdKNUtY5TXsOHkphz3J0tuauhgXKQXkT6DkgCnhjYl1/zX3vx5rXOET5KfWloTdBqRPsziShyMl7JiUByaRh8Q4SvKVGNFM8WpYnv7n0QRftHrsBeuWiXKWIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486534; c=relaxed/simple;
	bh=S07Cc+ivVychnNzLAQ0PaaLobgJYLglbmd1FzRsFQys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/sbV1LKueWGkKG6dxVKpMOEWcXY3i6Mp9xDhhAe8mBUs+up+0bLWB0qwuEMNQ46TYHNE2nLgY4yYePA5uZyrQub+MWt5efBEv+0hqojYBEGeUGXm0WKHhekFWB9BlgjPVR8OAHKB9NKYlE7M+dM5NNHljkkkWhW3iaimH3IRlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4DutURR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4DutURR"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f335e8d493so5412325ad.1
        for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 10:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486532; x=1717091332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3Dkdm32lp5f6RMYNOcQ/PPZ87Y6R6yDh0BiQEry7hs=;
        b=P4DutURRjaKcBnQCtWxzhzI4BkbdnCLBKx7qFEhfnOu7aYu2gcxD5PrGpkSP1MR2uM
         x0wfnQIIawu0r93fsdgjo2d3kKg7TutPjPqsjhOoww/RvT4fV+wbIz8OPo0/pGgr3wMh
         +BSvG1rd/jPMG29s0QQVoAd8FPFRxbwFX+EE7GXvyhNRHZTqCXld10T75z9amCGopeYZ
         z5of4HrywEMBjv7arWh8VJEUJ6GdjIO4kbo71P3TXTPzgcVqOP7GfU6AcYt3T5m5DE/O
         AgVhEopUri8jTwjqelHLt7De9j2VrROODzklFi6DKcBTIfThr54YuI3+D9LDPL6jMzTi
         4/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486532; x=1717091332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3Dkdm32lp5f6RMYNOcQ/PPZ87Y6R6yDh0BiQEry7hs=;
        b=SFRxRok9KxpVvf4QSZihy2uKrUcZuquN66cy0NRllGP/3LLKF7fp5z1WpNj87mvYuJ
         DYmrYPpVT7inQJy/ik/rQVhSIYNxbx3fCTuTqvZDMhGtjHZXTiriLZtOccJXqSEx5KdJ
         sKerIJfsAB/aLR7CKmSQ8cPkHVDYa23SNEdKbvnck3XBK5Uw3snVxLFQ0+e3ESJQRLSP
         qOXV+K787dnxHMpAXGroPpx/rkG7sEO7kmQNR5f9zoQ/iLn7duEw/7WFD0fc5Um/sIFG
         fNwFwZBzNMxQXrk5/EXuVqQIWG/5fJmYzvMeHUddKaz4vvoOq6afy4LcjagtCgozVzt9
         tncw==
X-Forwarded-Encrypted: i=1; AJvYcCWmFEpOd2SA33IEKQjUKrzz2OYfXTLFf2yO6Dk0YhxlhNkHv41Lud6WizdUYB8RGN/bQ/8mfiamvF3xM4LEbEyWgovvoSL/60sd
X-Gm-Message-State: AOJu0Yw50dEPsSeXnHHJ8+VuH0ZLWliWg/r6aKzhxYpgfAJZJZemfchY
	fh997MSzmHzQ/69bSfMoybNcifaziwmmj2dI5U/isHN4Z7gjxvyr
X-Google-Smtp-Source: AGHT+IGe9DW+u5d7YhtV2coNCHdsuIuR4Bqp6Ytu8BryQ+8TGFuT5OoaEd8kf5HHcxnPPNVRtLlf1w==
X-Received: by 2002:a17:902:e892:b0:1eb:d7ce:1946 with SMTP id d9443c01a7336-1f4497e5828mr430865ad.52.1716486532351;
        Thu, 23 May 2024 10:48:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:48:52 -0700 (PDT)
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
	armbru@redhat.com,
	mst@redhat.com,
	Fan Ni <fan.ni@samsung.com>,
	Svetly Todorov <svetly.todorov@memverge.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 09/14] hw/mem/cxl_type3: Add DC extent list representative and get DC extent list mailbox support
Date: Thu, 23 May 2024 10:44:49 -0700
Message-ID: <20240523174651.1089554-10-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Add dynamic capacity extent list representative to the definition of
CXLType3Dev and implement get DC extent list mailbox command per
CXL.spec.3.1:.8.2.9.9.9.2.

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 73 ++++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h | 22 +++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 831cef0567..1915959015 100644
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
@@ -1322,7 +1323,8 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
      * to use.
      */
     stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
-    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED);
+    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED -
+             ct3d->dc.total_extent_count);
     stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
     stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
 
@@ -1330,6 +1332,72 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
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
+    uint32_t start_extent_id = in->start_extent_id;
+    CXLDCExtentList *extent_list = &ct3d->dc.extents;
+    uint16_t record_count = 0, i = 0, record_done = 0;
+    uint16_t out_pl_len, size;
+    CXLDCExtent *ent;
+
+    if (start_extent_id > ct3d->dc.total_extent_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.total_extent_count - start_extent_id);
+    size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
+    record_count = MIN(record_count, size / sizeof(out->records[0]));
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+
+    stl_le_p(&out->count, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        CXLDCExtentRaw *out_rec = &out->records[record_done];
+
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (i++ < start_extent_id) {
+                continue;
+            }
+            stq_le_p(&out_rec->start_dpa, ent->start_dpa);
+            stq_le_p(&out_rec->len, ent->len);
+            memcpy(&out_rec->tag, ent->tag, 0x10);
+            stw_le_p(&out_rec->shared_seq, ent->shared_seq);
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
@@ -1377,6 +1445,9 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
     [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
         cmd_dcd_get_dyn_cap_config, 2, 0 },
+    [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
+        "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
+        8, 0 },
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index f645a3f2e9..f6ab885270 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -672,6 +672,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
         };
         ct3d->dc.total_capacity += region->len;
     }
+    QTAILQ_INIT(&ct3d->dc.extents);
 
     return true;
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c2c3df0d2a..6aec6ac983 100644
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
@@ -474,6 +493,9 @@ struct CXLType3Dev {
          * memory region size.
          */
         uint64_t total_capacity; /* 256M aligned */
+        CXLDCExtentList extents;
+        uint32_t total_extent_count;
+        uint32_t ext_list_gen_seq;
 
         uint8_t num_regions; /* 0-8 regions */
         CXLDCRegion regions[DCD_MAX_NUM_REGION];
-- 
2.43.0

