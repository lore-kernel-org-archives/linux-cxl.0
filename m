Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38585283
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539682; cv=none; b=L87Qz4Eif9bKQfY+amTS72Q9VfSNytDEWdeKDHQH0DVw9BvIR5Ejw8d59sLxvyIOYk+wQwLjkwFanEWdDj3tZ1XQ0kovZoJm9ko+KcHYMWIPhB9CPcGaM4+wzNKNCQyK8kvhhxgjtqRZecF9lnbpcRWaf1Uivk69YvK2VP2Fr1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539682; c=relaxed/simple;
	bh=VQTaqIV4a3sRbhlW6ABD/sK71o0UgSxK+AhEpeqAvsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dL6NCtPpSQXVx0eV3hI5s/oR0qqNHJzonoRi/KdyKCr7qmgUq4UhcV4ey05X+CANnWDIu08twSmjbL2yMQA1ku42qzoGPaJozmNXsXU1hzxMieo/balYQrzF2aDDqMmM64KwWdioEx3LP9UD2+m+mQBv1WTNX0qTYVV26QZ+UAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nl8SlmJd; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl8SlmJd"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5dca1efad59so6417089a12.2
        for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 10:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708539680; x=1709144480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6VL3c1gI2rozkVMagqzxRAFNNaT8HWGIMmWFgrUxvc=;
        b=Nl8SlmJdGSiHCJWdNxsnJufm/hvPQpscZXbTZgPd/VcdaTinhb1a3W6gP5EZNLrmhT
         M3I2vO9nXJw9eDACzwKI7+ofnu1IB0U1a8rRO5VV/0P9gxFhGDrR7qtNmU2SbGDUnhuo
         Nipj7ns2xH+TGJZLxgMUhU+QVRpuuo1eEOuhfX2Q7u38YunQKDvcjvV3b/aCgBmT9Uht
         Pm2Zu8R+mdd18NXm8CVl9FzS5mbFydDS/h/zJ4s9FoYsKMcg0tqpyjrWoagKdjFcVgiW
         GcXLX3MuRzYXFfZoi86ALQGEtYW1g5OViQonAJ3PZqKOL3GO1pArJbFGyouZU6Nf8Bfm
         SEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539680; x=1709144480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6VL3c1gI2rozkVMagqzxRAFNNaT8HWGIMmWFgrUxvc=;
        b=X7EWcg7y81d12MwQx0rxDM4KXjYlAgeTq503Tm/Wqzqu3sJkUr/C5l1iSeZZn+t4EI
         k3rNzoDpHkcudNOUDsgF5v/IjBb1mtlDC6YrwSOxZwR/0Hgk5EOwFdAzrX3ohlrcN3MD
         gpn4Ni8wL3+XQUDW5i5zkg4EEpIBM4bFhjX21UVhU1oHGRvW4jZRwJWR/pDogv0sIxaz
         XWt9gaUy7jyMoRPhXyuagnR52utkJf2R/O9x5g+GBMgnlgcHaqwy+1/T8eBdtJbnChDu
         TufYC8d2k+Q1eCExMOtL1ALAc3nnsL1SpHmGbaEtPg/kF6Dqu8jj01X7Urzg0iH/bgDs
         Fv2g==
X-Forwarded-Encrypted: i=1; AJvYcCUQzJvzEJWayKFxU5W9EuXE217VMsZ6Tr/E1g8lDRyLjphZbADlo4ZtLxODYoaaBb0+DC+p04xdjB4TqnLha2pokxaUpFWwndgd
X-Gm-Message-State: AOJu0YyUI9IgNqorlYG7JVb6mIOTURyjcV0WWD5GRe3DBU63w11w0end
	TSmTZS0d2JmtCbJQ6mPzc1zrk089aVEOnwLEft+eapsAuXsgnzgG
X-Google-Smtp-Source: AGHT+IFBGjAFI6oKAXvbH/bbeOvJ8OH4HKQWlcBjiXs+PMXpY/3xEh0k13+5pB5wI3icc4F5ofUS2A==
X-Received: by 2002:a17:90a:c706:b0:297:4f1:8a19 with SMTP id o6-20020a17090ac70600b0029704f18a19mr17216669pjt.23.1708539680417;
        Wed, 21 Feb 2024 10:21:20 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:21:20 -0800 (PST)
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
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v4 08/10] hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release dynamic capacity response
Date: Wed, 21 Feb 2024 10:16:01 -0800
Message-ID: <20240221182020.1086096-9-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221182020.1086096-1-nifan.cxl@gmail.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Per CXL spec 3.1, two mailbox commands are implemented:
Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.9.9.3, and
Release Dynamic Capacity (Opcode 4803h) 8.2.9.9.9.4.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 288 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |   2 +
 2 files changed, 290 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index dae7fe00ed..65ed28f700 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -84,6 +84,8 @@ enum {
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
         #define GET_DYN_CAP_EXT_LIST   0x1
+        #define ADD_DYN_CAP_RSP        0x2
+        #define RELEASE_DYN_CAP        0x3
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1412,6 +1414,286 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
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
+    int i;
+    CXLDCDRegion *region = &ct3d->dc.regions[0];
+
+    if (dpa < region->base ||
+        dpa >= region->base + ct3d->dc.total_capacity) {
+        return NULL;
+    }
+
+    /*
+     * CXL r3.1 section 9.13.3: Dynamic Capacity Device (DCD)
+     *
+     * Regions are used in increasing-DPA order, with Region 0 being used for
+     * the lowest DPA of Dynamic Capacity and Region 7 for the highest DPA.
+     * So check from the last region to find where the dpa belongs. Extents that
+     * cross multiple regions are not allowed.
+     */
+    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
+        region = &ct3d->dc.regions[i];
+        if (dpa >= region->base) {
+            if (dpa + len > region->base + region->len) {
+                return NULL;
+            }
+            return region;
+        }
+    }
+
+    return NULL;
+}
+
+static void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
+                                             uint64_t dpa,
+                                             uint64_t len,
+                                             uint8_t *tag,
+                                             uint16_t shared_seq)
+{
+    CXLDCExtent *extent;
+
+    extent = g_new0(CXLDCExtent, 1);
+    extent->start_dpa = dpa;
+    extent->len = len;
+    if (tag) {
+        memcpy(extent->tag, tag, 0x10);
+    }
+    extent->shared_seq = shared_seq;
+
+    QTAILQ_INSERT_TAIL(list, extent, node);
+}
+
+static void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
+                                               CXLDCExtent *extent)
+{
+    QTAILQ_REMOVE(list, extent, node);
+    g_free(extent);
+}
+
+/*
+ * CXL r3.1 Table 8-168: Add Dynamic Capacity Response Input Payload
+ * CXL r3.1 Table 8-170: Release Dynamic Capacity Input Payload
+ */
+typedef struct CXLUpdateDCExtentListInPl {
+    uint32_t num_entries_updated;
+    uint8_t flags;
+    uint8_t rsvd[3];
+    /* CXL r3.1 Table 8-169: Updated Extent List */
+    struct {
+        uint64_t start_dpa;
+        uint64_t len;
+        uint8_t rsvd[8];
+    } QEMU_PACKED updated_entries[];
+} QEMU_PACKED CXLUpdateDCExtentListInPl;
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
+        const CXLUpdateDCExtentListInPl *in)
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
+    blk_bitmap = bitmap_new((lastregion->base + lastregion->len -
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
+ * CXL r3.1 section 8.2.9.9.9.3: Add Dynamic Capacity Response (opcode 4802h)
+ * An extent is added to the extent list and becomes usable only after the
+ * response is processed successfully
+ */
+static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
+                                          uint8_t *payload_in,
+                                          size_t len_in,
+                                          uint8_t *payload_out,
+                                          size_t *len_out,
+                                          CXLCCI *cci)
+{
+    CXLUpdateDCExtentListInPl *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCExtentList *extent_list = &ct3d->dc.extents;
+    CXLDCExtent *ent;
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
+         * TODO: we will add a pending extent list based on event log record
+         * and verify the input response; also, the "More" flag is not
+         * considered at the moment.
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
+ * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (opcode 4803h)
+ */
+static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
+                                          uint8_t *payload_in,
+                                          size_t len_in,
+                                          uint8_t *payload_out,
+                                          size_t *len_out,
+                                          CXLCCI *cci)
+{
+    CXLUpdateDCExtentListInPl *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCExtentList *extent_list = &ct3d->dc.extents;
+    CXLDCExtent *ent;
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
+        bool found = false;
+
+        dpa = in->updated_entries[i].start_dpa;
+        len = in->updated_entries[i].len;
+
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (ent->start_dpa <= dpa &&
+                dpa + len <= ent->start_dpa + ent->len) {
+                /*
+                 * If an incoming extent covers a portion of an extent
+                 * in the device extent list, remove only the overlapping
+                 * portion, meaning
+                 * 1. the portions that are not covered by the incoming
+                 *    extent at both end of the original extent will become
+                 *    new extents and inserted to the extent list; and
+                 * 2. the original extent is removed from the extent list;
+                 * 3. dc extent count is updated accordingly.
+                 */
+                uint64_t ent_start_dpa = ent->start_dpa;
+                uint64_t ent_len = ent->len;
+                uint64_t len1 = dpa - ent_start_dpa;
+                uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
+
+                found = true;
+                cxl_remove_extent_from_extent_list(extent_list, ent);
+                ct3d->dc.total_extent_count -= 1;
+
+                if (len1) {
+                    cxl_insert_extent_to_extent_list(extent_list,
+                                                     ent_start_dpa, len1,
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
+        if (!found) {
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
@@ -1462,6 +1744,12 @@ static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
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
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 12a6fb47a9..6178416cbb 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -548,4 +548,6 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d);
 
 void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
 
+CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
+
 #endif
-- 
2.43.0

