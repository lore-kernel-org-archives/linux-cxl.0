Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8F2628D
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486526; cv=none; b=FRjHGtT/QNbiHa6Z0/XNJdv/k6JHGuaZGEqAzTbV6z3bm3X7X/f2ayOq7SUKymGgph+kYzSqH4ty2neBzbI7ioWZK+YhvvEsbF9Q+58pnzAs38w4n8/lJegeLf0ACya28J0T4xmPE+GtsgrsDepodyIVz9AfGKXGScjsJTgUH0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486526; c=relaxed/simple;
	bh=TdV36bNfdHmbhePUv2ShRQC9/L2OpD5UeHBuqlqNzCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXay0hW0zA6FO0wnqokvSckJkFNooBLVPX/3ZzSJFMzyHTYvfU/qGJhCCv5VxANmpw8vCncjINuLrNqavxwka5t9pQ5Y63Jx++PvcYtc9zs+RxgyCqn+QYQADpGHNbLelfThEMCn9uEmF0+i9TifX9a2z2vSAyIDwI5dEjELBKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVR53CvN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVR53CvN"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1edc696df2bso23584365ad.0
        for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486524; x=1717091324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp25PInGES4IUM+v+nVRXcyaxGTzommY3tewIcDpIDo=;
        b=UVR53CvNXxERBVROuDnpWAHUUeaJbM4tzwluo9J9Wx+j4CCEcC/Oq1XEAsU/xAVIbg
         iv5x7N4m2kJvwIs633Yn1AVna6If9BTjrvIgdQXlRIQCk+n95wYFvINc4xGbPoeLsRY+
         gaHZYOAX0uXm+cImigpqQrhKZYiKf8AvmD9wommXvx4m6q/I9J85ObKZzcfwjVeOuuiQ
         FgN1we4B7ZQ5+pKxhDiPZ2o79528m9s7fsLeoFrXNAafJ8RyU4tNSwIT/I9d2SOQWZob
         6mbX2G0zBQKB03ieNUlagq6WgkWvJHvVE4cjCN/rcSY5EJ1Gre/CnDDGLHpO8BkYFRJi
         Na6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486524; x=1717091324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cp25PInGES4IUM+v+nVRXcyaxGTzommY3tewIcDpIDo=;
        b=ZNPUawnXxRhHVw/SoGveR6y9+QdfVMfk6PM0tY8853CNNgllYIXA3KsU++8DhcnGQV
         4Av0By4LeQ4IyNT/TrmBaUyoLJQkJRBYPeCsCEM2sL62WiJnyZZv35LQCWpPtBJcKtgL
         nC8zUVgbz2Vw/KkGCXfjfBuq9QU44tu9OMgrfbumjIlMoKG7d1fIObTOEbUI7A54G98v
         3+YF12/tU2IALk2mGOv8ph9/Z4KgdjMmfBKlPON3ZElVEQRPcclqCACnEQniILtvniVw
         eYaa/2b7K1lfDFg6nPPhejRKoYrSyfdgkUIrwuYOr/0vtwx1YeJI3gFWOjQJZK72POjL
         HXnw==
X-Forwarded-Encrypted: i=1; AJvYcCU1PsX1zk2hbB0+9hSetEaHyaTsIE5V9ue9JtHTTl3wz0xHR5hhgFLWFszpOiRzP8GVU2QeDa2u9XwyJ8iNAbhBKQp+54Qaz+O1
X-Gm-Message-State: AOJu0YzOzpS4m4iaqBWuULLkFjve1HLCWVsIFWH0VZrcwa49pU0iIAV5
	RGoBN6CGMgvYBlmHHkfKY7DqyPGRpteRgUjjmlcp2ZCPbQybDjjQ
X-Google-Smtp-Source: AGHT+IEwb7i78es7w1BShGgBFOsxchjdLVobvlyYQPez+6o4mmBdh1arixP9GXMY4IHPKtYxmiDIRg==
X-Received: by 2002:a17:902:e848:b0:1f4:4631:d6aa with SMTP id d9443c01a7336-1f4486b5c83mr306735ad.14.1716486523994;
        Thu, 23 May 2024 10:48:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:48:43 -0700 (PDT)
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 04/14] hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative and mailbox command support
Date: Thu, 23 May 2024 10:44:44 -0700
Message-ID: <20240523174651.1089554-5-nifan.cxl@gmail.com>
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

Per cxl spec r3.1, add dynamic capacity (DC) region representative based on
Table 8-165 and extend the cxl type3 device definition to include DC region
information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
Configuration' mailbox support.

Note: we store region decode length as byte-wise length on the device, which
should be divided by 256 * MiB before being returned to the host
for "Get Dynamic Capacity Configuration" mailbox command per
specification.

Reviewed-by: Gregory Price <gregory.price@memverge.com>
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

