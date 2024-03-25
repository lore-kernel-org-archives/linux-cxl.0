Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7A5C89
	for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393466; cv=none; b=BjgW8h1e3iYkB773kZZnKeEl8DrnWDhzTtstMz29obsDz8yG9uYSsHCDZ1GPTpZI5LiiIiosCGNtL7n0/IYvo0vTVU6a2DdHuNz1GFl7+a7ljRXWHhKjjdLo/hhcOMTuk7vPtwAVCWOPZy9GYrrTzfJDGPEG76/R7QUbKL8QVng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393466; c=relaxed/simple;
	bh=0dq1W/Glim7fuQ3Y+NS9I1UvHbHTBpf01hrrAwybzj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCijToXXQTv/KiaZel3+cAtWc7x6zugIRyzMmST6delNBKO3d/NLVjzmtUNDrInANVkAqb7/+NB47FpiY9HvCd8QRbRabem+qs8lC2P/o+SeSrCsUU+SI4fPlrKdnrbwRvvTHg0Th6D6OCy9/THNmMem2HoKnnSh6scb3r/Kjlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoeZBGpm; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoeZBGpm"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-366a4bcb2a8so22350755ab.3
        for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 12:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393464; x=1711998264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXGq4qKetnED0Sdh0jI6OjQ493ny9rPgw+BgPnzbFPY=;
        b=AoeZBGpm1yeyYKOP6DfYPgkjPgEQjNNI+4v7rLFRPLsiBpRudTOiZUdvS2ubReYRfe
         5MCgTd39xfz6NZbmnECCD2Sh4ePfcCgIKjvyZywWe7nX1EZ7Dr4tzg2Rjfes8sm8slRQ
         tXsKUzq+hVCpRZ/sSFbakjpEQxd5YKRokBS/1Fmk3ALnv6ykedyo/wtOCjjylDU8oZJa
         fczbIKAQVk635bddFgGe3n40PN603n/nAdWxTOA2zulqBMGIrCC/mMpS3t3vwhm1MnfN
         gxr6RV29F0rgNTFCeEhxp4ApFWWKbKlCGu3VU7wi0KpK2TJAwunr7nAJDOqHyDKZ2Hq2
         PE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393464; x=1711998264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXGq4qKetnED0Sdh0jI6OjQ493ny9rPgw+BgPnzbFPY=;
        b=OcHRjhmI2x5sAl3mv3OX0bY1ntl8efBD/dpsP/BcN2Ir41Aba6lOlHnqk/nOl0Xk7G
         woC4zIhtgKeFJc5cQ7c4Q/9kefp454vrhf/O+/s2nrQnjPzCxSjzbZDjxcw+9Tog2S4m
         qYWq5Bdt/jxst6r4kol14Lm5g37/xJEy68dQnll/2PzDCefmdcKLnzJ3vbM6lW0JrWeq
         YeZdYZ+dHtZAj4nh3Xv8NMRebzThHjfYusaCac+N3y48Qz4qqXzs7hI9xcMjvnDwa6Ib
         2dRIS9elwUE4oOOQ+YLkNoHVShZ0gls1L6ePLz0+Q742CsHl+/ToSC6X/IyvXbrPJVGE
         6Kwg==
X-Forwarded-Encrypted: i=1; AJvYcCWJo2e3DjYcV/+5v5PdMehjiRoZS3p+FRnDJsjDz/2x1ak0H7pznzADXYw3LWMwzkan3u9nDRZmGS78s0PGtSuIBdoKxuCxVqI4
X-Gm-Message-State: AOJu0YySoJKYpqN6AA8AHidgiotAMSpHI92SfmEFjijBQ+7Yj2ezEyzO
	TAB5xu+wmDFcLVRY1AjX81tsmrTZquQfHVN3ss9SzMvnJtg/PnJS
X-Google-Smtp-Source: AGHT+IHZATtdkzshYDchLgt2ymdhu4ahwHp5LnKFx1fYpmUrGGBfyB69XYes6Gd/IMLECJQh81QZ3g==
X-Received: by 2002:a92:2c02:0:b0:368:9b91:4d1 with SMTP id t2-20020a922c02000000b003689b9104d1mr916992ile.15.1711393463840;
        Mon, 25 Mar 2024 12:04:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
        by smtp.gmail.com with ESMTPSA id z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:04:23 -0700 (PDT)
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
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 02/12] hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative and mailbox command support
Date: Mon, 25 Mar 2024 12:02:20 -0700
Message-ID: <20240325190339.696686-3-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325190339.696686-1-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Per cxl spec r3.1, add dynamic capacity region representative based on
Table 8-165 and extend the cxl type3 device definition to include dc region
information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
Configuration' mailbox support.

Note: we store region decode length as byte-wise length on the device, which
should be divided by 256 * MiB before being returned to the host
for "Get Dynamic Capacity Configuration" mailbox command per
specification.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 96 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h | 16 +++++++
 2 files changed, 112 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ba1d9901df..49c7944d93 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -22,6 +22,8 @@
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
+#define CXL_NUM_EXTENTS_SUPPORTED 512
+#define CXL_NUM_TAGS_SUPPORTED 0
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -80,6 +82,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+    DCD_CONFIG  = 0x48,
+        #define GET_DC_CONFIG          0x0
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1238,6 +1242,88 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.1 section 8.2.9.9.9.1: Get Dynamic Capacity Configuration
+ * (Opcode: 4800h)
+ */
+static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    struct {
+        uint8_t region_cnt;
+        uint8_t start_rid;
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct {
+        uint8_t num_regions;
+        uint8_t regions_returned;
+        uint8_t rsvd1[6];
+        struct {
+            uint64_t base;
+            uint64_t decode_len;
+            uint64_t region_len;
+            uint64_t block_size;
+            uint32_t dsmadhandle;
+            uint8_t flags;
+            uint8_t rsvd2[3];
+        } QEMU_PACKED records[];
+    } QEMU_PACKED *out = (void *)payload_out;
+    struct {
+        uint32_t num_extents_supported;
+        uint32_t num_extents_available;
+        uint32_t num_tags_supported;
+        uint32_t num_tags_available;
+    } QEMU_PACKED *extra_out;
+    uint16_t record_count;
+    uint16_t i;
+    uint16_t out_pl_len;
+    uint8_t start_rid;
+
+    start_rid = in->start_rid;
+    if (start_rid >= ct3d->dc.num_regions) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(ct3d->dc.num_regions - in->start_rid, in->region_cnt);
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    extra_out = (void *)(payload_out + out_pl_len);
+    out_pl_len += sizeof(*extra_out);
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    out->num_regions = ct3d->dc.num_regions;
+    out->regions_returned = record_count;
+    for (i = 0; i < record_count; i++) {
+        stq_le_p(&out->records[i].base,
+                 ct3d->dc.regions[start_rid + i].base);
+        stq_le_p(&out->records[i].decode_len,
+                 ct3d->dc.regions[start_rid + i].decode_len /
+                 CXL_CAPACITY_MULTIPLIER);
+        stq_le_p(&out->records[i].region_len,
+                 ct3d->dc.regions[start_rid + i].len);
+        stq_le_p(&out->records[i].block_size,
+                 ct3d->dc.regions[start_rid + i].block_size);
+        stl_le_p(&out->records[i].dsmadhandle,
+                 ct3d->dc.regions[start_rid + i].dsmadhandle);
+        out->records[i].flags = ct3d->dc.regions[start_rid + i].flags;
+    }
+    /*
+     * TODO: Assign values once extents and tags are introduced
+     * to use.
+     */
+    stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
+    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED);
+    stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
+    stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1282,6 +1368,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_clear_poison, 72, 0 },
 };
 
+static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
+    [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
+        cmd_dcd_get_dyn_cap_config, 2, 0 },
+};
+
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
     [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
@@ -1487,7 +1578,12 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
+
     cxl_copy_cci_commands(cci, cxl_cmd_set);
+    if (ct3d->dc.num_regions) {
+        cxl_copy_cci_commands(cci, cxl_cmd_set_dcd);
+    }
     cci->d = d;
 
     /* No separation for PCI MB as protocol handled in PCI device */
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a5f8e25020..e839370266 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -422,6 +422,17 @@ typedef struct CXLPoison {
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256
 
+#define DCD_MAX_NUM_REGION 8
+
+typedef struct CXLDCRegion {
+    uint64_t base;       /* aligned to 256*MiB */
+    uint64_t decode_len; /* aligned to 256*MiB */
+    uint64_t len;
+    uint64_t block_size;
+    uint32_t dsmadhandle;
+    uint8_t flags;
+} CXLDCRegion;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -454,6 +465,11 @@ struct CXLType3Dev {
     unsigned int poison_list_cnt;
     bool poison_list_overflowed;
     uint64_t poison_list_overflow_ts;
+
+    struct dynamic_capacity {
+        uint8_t num_regions; /* 0-8 regions */
+        CXLDCRegion regions[DCD_MAX_NUM_REGION];
+    } dc;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
-- 
2.43.0

