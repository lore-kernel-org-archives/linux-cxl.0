Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437D358A2
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScBFOnEe"
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2B0B0
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 10:10:23 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc0e78ec92so40282245ad.3
        for <linux-cxl@vger.kernel.org>; Tue, 07 Nov 2023 10:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699380623; x=1699985423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUg/SG54upIHtQz6IlNDfZW8H+6HjCMvwHk2jyDUo0c=;
        b=ScBFOnEegY3ntxOukrfzKdhHk8cqw2F0kzeHTAB3BiYWupsrBNYvOpP+RhkZAhEr05
         jKE80hlawoEw/BgaDYl9bY0ZDXmWuqmsl7KKQojfAJVJsfGbmFovJxW/0Iho4cg2xmAf
         7hKavJfKb8yZwu694pn4wvyCxwmkK+XHjwXsAZrgTdDWv6d7P/mQ8f+VriRshIEeXY/1
         4F5gdbDzCyaEbGPcZlG/u7NYetkCmB5hBQSRsEuEFgV3hcRyxek+uGtOtTNa1/oDTj/J
         2PMKDr+wdRTgInJBDY5sU2LzUIxHNC1pn/mWYiULw09/QDXJJlfHHZIrMp99uHPBSvoj
         NGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380623; x=1699985423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUg/SG54upIHtQz6IlNDfZW8H+6HjCMvwHk2jyDUo0c=;
        b=cMxeHyT8GhL9T3LYlgRVyoP7ncqxpcRC7zxuz6Ebp0v42NV4dI0KDRbumfV2nNadlp
         DIzTpwfoKoGb/SrxxEw7sWhF+mJ9agQiScAb17VLExWKdfyf81FYzGeZQnVAfKLbf9Mr
         +4GgPfG+TnzRq4l+3fHx5ZjRysc4QG7WBsL70V7yO+7Z5xN+hA164fnPx+ImWprsqQPS
         wW5nR+FUxu3EgkzcR7WgQZr146yjIqUYCv1A7G0CJH5XMy/0QPgAZUthmdE4QqwN+fiX
         f973Uy4dqXd/y4DWYfdpKN1xA2aESmQoPFtuqsLL56UikM5FMqHMCBA0CfYQLD+0A6DT
         KZBg==
X-Gm-Message-State: AOJu0YzW4sNPFZkKU7yZX4TTTntwVCg6t2m/RJvm7m2vV9S+DRm5xsU3
	fh5zWXkoeIRWTRPzBlo8bG8=
X-Google-Smtp-Source: AGHT+IHquAmXxcjrVWrbCx9nCMe2dbsGzG8XJwXYiCLO2ckHcrK2QKzgao7HwzetjQuOJ44GGFU3pg==
X-Received: by 2002:a17:903:1210:b0:1c9:e4f2:a39d with SMTP id l16-20020a170903121000b001c9e4f2a39dmr34722916plh.49.1699380622885;
        Tue, 07 Nov 2023 10:10:22 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:10:22 -0800 (PST)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan@outlook.com,
	jim.harris@samsung.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v3 7/9] hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release dynamic capacity response
Date: Tue,  7 Nov 2023 10:07:11 -0800
Message-ID: <20231107180907.553451-8-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107180907.553451-1-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Per CXL spec 3.0, two mailbox commands are implemented:
Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.8.9.3, and
Release Dynamic Capacity (Opcode 4803h) 8.2.9.8.9.4.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 271 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |   3 +-
 include/hw/cxl/cxl_device.h |   5 +-
 3 files changed, 277 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 56f4aa237a..9f788b03b6 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -83,6 +83,8 @@ enum {
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
         #define GET_DYN_CAP_EXT_LIST   0x1
+        #define ADD_DYN_CAP_RSP        0x2
+        #define RELEASE_DYN_CAP        0x3
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1356,6 +1358,269 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * Check whether any bit between addr[nr, nr+size) is set,
+ * return true if any bit is set, otherwise return false
+ */
+static bool test_any_bits_set(const unsigned long *addr, int nr, int size)
+{
+    unsigned long res = find_next_bit(addr, size + nr, nr);
+
+    return res < nr + size;
+}
+
+CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
+{
+    CXLDCDRegion *region = &ct3d->dc.regions[0];
+    int i;
+
+    if (dpa < region->base ||
+        dpa >= region->base + ct3d->dc.total_capacity) {
+        return NULL;
+    }
+
+    /*
+     * CXL r3.0 section 9.13.3: Dynamic Capacity Device (DCD)
+     *
+     * Regions are used in increasing-DPA order, with Region 0 being used for
+     * the lowest DPA of Dynamic Capacity and Region 7 for the highest DPA.
+     * So check from the last region to find where the dpa belongs. Extents that
+     * cross multiple regions are not allowed.
+     */
+    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
+        region = &ct3d->dc.regions[i];
+        if (dpa >= region->base) {
+            /*Should we compare with decode_len or len of the region??*/
+            if (dpa + len > region->base +
+                    region->decode_len * CXL_CAPACITY_MULTIPLIER)
+                return NULL;
+            return region;
+        }
+    }
+    return NULL;
+}
+
+static void cxl_insert_extent_to_extent_list(CXLDCDExtentList *list,
+                                             uint64_t dpa,
+                                             uint64_t len,
+                                             uint8_t *tag,
+                                             uint16_t shared_seq)
+{
+    CXLDCDExtent *extent;
+
+    extent = g_new0(CXLDCDExtent, 1);
+    extent->start_dpa = dpa;
+    extent->len = len;
+    if (tag) {
+        memcpy(extent->tag, tag, 0x10);
+    } else {
+        memset(extent->tag, 0, 0x10);
+    }
+    extent->shared_seq = shared_seq;
+
+    QTAILQ_INSERT_TAIL(list, extent, node);
+}
+
+/*
+ * CXL r3.0 Table 8-129: Add Dynamic Capacity Response Input Payload
+ * CXL r3.0 Table 8-131: Release Dynamic Capacity Input Payload
+ */
+typedef struct updated_dc_extent_list_in_pl {
+    uint32_t num_entries_updated;
+    uint8_t rsvd[4];
+    /* CXL r3.0 Table 8-130: Updated Extent List */
+    struct {
+        uint64_t start_dpa;
+        uint64_t len;
+        uint8_t rsvd[8];
+    } QEMU_PACKED updated_entries[];
+} QEMU_PACKED updated_dc_extent_list_in_pl;
+
+/*
+ * For the extents in the extent list to operate, check whether they are valid
+ * 1. The extent should be in the range of a valid DC region;
+ * 2. The extent should not cross multiple regions;
+ * 3. The start DPA and the length of the extent should align with the block
+ * size of the region;
+ * 4. The address range of multiple extents in the list should not overlap.
+ */
+static CXLRetCode cxl_detect_malformed_extent_list(CXLType3Dev *ct3d,
+        const updated_dc_extent_list_in_pl *in)
+{
+    uint64_t min_block_size = UINT64_MAX;
+    CXLDCDRegion *region = &ct3d->dc.regions[0];
+    CXLDCDRegion *lastregion = &ct3d->dc.regions[ct3d->dc.num_regions - 1];
+    g_autofree unsigned long *blk_bitmap = NULL;
+    uint64_t dpa, len;
+    uint32_t i;
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        min_block_size = MIN(min_block_size, region->block_size);
+    }
+
+    blk_bitmap = bitmap_new((lastregion->len + lastregion->base -
+                             ct3d->dc.regions[0].base) / min_block_size);
+
+    for (i = 0; i < in->num_entries_updated; i++) {
+        dpa = in->updated_entries[i].start_dpa;
+        len = in->updated_entries[i].len;
+
+        region = cxl_find_dc_region(ct3d, dpa, len);
+        if (!region) {
+            return CXL_MBOX_INVALID_PA;
+        }
+
+        dpa -= ct3d->dc.regions[0].base;
+        if (dpa % region->block_size || len % region->block_size) {
+            return CXL_MBOX_INVALID_EXTENT_LIST;
+        }
+        /* the dpa range already covered by some other extents in the list */
+        if (test_any_bits_set(blk_bitmap, dpa / min_block_size,
+            len / min_block_size)) {
+            return CXL_MBOX_INVALID_EXTENT_LIST;
+        }
+        bitmap_set(blk_bitmap, dpa / min_block_size, len / min_block_size);
+   }
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/*
+ * CXL r3.0 section 8.2.9.8.9.3: Add Dynamic Capacity Response (opcode 4802h)
+ *
+ * Assume an extent is added only after the response is processed successfully
+ * TODO: for better extent list validation, a better solution would be
+ * maintaining a pending extent list and use it to verify the extent list in
+ * the response.
+ */
+static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
+                                          uint8_t *payload_in,
+                                          size_t len_in,
+                                          uint8_t *payload_out,
+                                          size_t *len_out,
+                                          CXLCCI *cci)
+{
+    updated_dc_extent_list_in_pl *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCDExtentList *extent_list = &ct3d->dc.extents;
+    CXLDCDExtent *ent;
+    uint32_t i;
+    uint64_t dpa, len;
+    CXLRetCode ret;
+
+    if (in->num_entries_updated == 0) {
+        return CXL_MBOX_SUCCESS;
+    }
+
+    ret = cxl_detect_malformed_extent_list(ct3d, in);
+    if (ret != CXL_MBOX_SUCCESS) {
+        return ret;
+    }
+
+    for (i = 0; i < in->num_entries_updated; i++) {
+        dpa = in->updated_entries[i].start_dpa;
+        len = in->updated_entries[i].len;
+
+        /*
+         * Check if the DPA range of the to-be-added extent overlaps with
+         * existing extent list maintained by the device.
+         */
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (ent->start_dpa <= dpa &&
+                    dpa + len <= ent->start_dpa + ent->len) {
+                return CXL_MBOX_INVALID_PA;
+            /* Overlapping one end of the other */
+            } else if ((dpa < ent->start_dpa + ent->len &&
+                        dpa + len > ent->start_dpa + ent->len) ||
+                       (dpa < ent->start_dpa && dpa + len > ent->start_dpa)) {
+                return CXL_MBOX_INVALID_PA;
+            }
+        }
+
+        /*
+         * TODO: add a pending extent list based on event log record and
+         * verify the input response
+         */
+
+        cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
+        ct3d->dc.total_extent_count += 1;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/*
+ * CXL r3.0 section 8.2.9.8.9.4: Release Dynamic Capacity (opcode 4803h)
+ */
+static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
+                                          uint8_t *payload_in,
+                                          size_t len_in,
+                                          uint8_t *payload_out,
+                                          size_t *len_out,
+                                          CXLCCI *cci)
+{
+    updated_dc_extent_list_in_pl *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCDExtentList *extent_list = &ct3d->dc.extents;
+    CXLDCDExtent *ent;
+    uint32_t i;
+    uint64_t dpa, len;
+    CXLRetCode ret;
+
+    if (in->num_entries_updated == 0) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    ret = cxl_detect_malformed_extent_list(ct3d, in);
+    if (ret != CXL_MBOX_SUCCESS) {
+        return ret;
+    }
+
+    for (i = 0; i < in->num_entries_updated; i++) {
+        dpa = in->updated_entries[i].start_dpa;
+        len = in->updated_entries[i].len;
+
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (ent->start_dpa <= dpa &&
+                dpa + len <= ent->start_dpa + ent->len) {
+                /* Remove any partial extents */
+                uint64_t len1 = dpa - ent->start_dpa;
+                uint64_t len2 = ent->start_dpa + ent->len - dpa - len;
+
+                if (len1) {
+                    cxl_insert_extent_to_extent_list(extent_list,
+                                                     ent->start_dpa, len1,
+                                                     NULL, 0);
+                    ct3d->dc.total_extent_count += 1;
+                }
+                if (len2) {
+                    cxl_insert_extent_to_extent_list(extent_list, dpa + len,
+                                                     len2, NULL, 0);
+                    ct3d->dc.total_extent_count += 1;
+                }
+                break;
+                /*Currently we reject the attempt to remove a superset*/
+            } else if ((dpa < ent->start_dpa + ent->len &&
+                        dpa + len > ent->start_dpa + ent->len) ||
+                       (dpa < ent->start_dpa && dpa + len > ent->start_dpa)) {
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+            }
+        }
+
+        if (ent) {
+            QTAILQ_REMOVE(extent_list, ent, node);
+            g_free(ent);
+            ct3d->dc.total_extent_count -= 1;
+        } else {
+            /* Try to remove a non-existing extent */
+            return CXL_MBOX_INVALID_PA;
+        }
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1406,6 +1671,12 @@ static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
     [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
         "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
         8, 0 },
+    [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
+        "ADD_DCD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
+        ~0, IMMEDIATE_DATA_CHANGE },
+    [DCD_CONFIG][RELEASE_DYN_CAP] = {
+        "RELEASE_DCD_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
+        ~0, IMMEDIATE_DATA_CHANGE },
 };
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c9d792a725..482329a499 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -789,7 +789,7 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
     int i;
     uint64_t region_base = 0;
     uint64_t region_len =  2 * GiB;
-    uint64_t decode_len = 8; /* 8*256MB */
+    uint64_t decode_len = 2 * GiB;
     uint64_t blk_size = 2 * MiB;
     CXLDCDRegion *region;
 
@@ -803,6 +803,7 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
     for (i = 0; i < ct3d->dc.num_regions; i++) {
         region = &ct3d->dc.regions[i];
         region->base = region_base;
+        /* NOTE: Should be divided by 256 * MiB before be returned to host */
         region->decode_len = decode_len;
         region->len = region_len;
         region->block_size = blk_size;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 5738c6f434..b3d35fe000 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -130,7 +130,8 @@ typedef enum {
     CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
     CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
     CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
-    CXL_MBOX_MAX = 0x17
+    CXL_MBOX_INVALID_EXTENT_LIST = 0x1E, /* cxl r3.0: Table 8-34*/
+    CXL_MBOX_MAX = 0x1F
 } CXLRetCode;
 
 typedef struct CXLCCI CXLCCI;
@@ -548,4 +549,6 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d);
 
 void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
 
+CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
+
 #endif
-- 
2.42.0

