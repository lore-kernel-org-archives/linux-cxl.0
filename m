Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278203588D
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcY31NN7"
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF57EB0
	for <linux-cxl@vger.kernel.org>; Tue,  7 Nov 2023 10:10:18 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc3bc5df96so44122945ad.2
        for <linux-cxl@vger.kernel.org>; Tue, 07 Nov 2023 10:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699380618; x=1699985418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxa2X/M3i5M/B67pIBM08iOpkqVk5AqzieyHZGjyhtc=;
        b=WcY31NN7vWyO7vMWyvpdGWowIjr3ckL7+cERb+bj5Y+lY7Q/bnAe+SPefjs6K4Bmhh
         B56r7lZc0iqD9ytr9PAMrHJjrmqdQSuntglvUeytAqSbVk3p9qjf0vDLKA5tJYHvRa3q
         kpBn0Op95O6nAL7vNJ/LKoD8T3AOvFsazPkCkP6n6pias4nVCTTD/LjIQwCOmXYqI0Iu
         2f1WDOqZDauo5nWi055TSh+z+jzeLZ7pqypWQXpU4WCIniJirRgfZGY4FFLYJFVkTPY4
         MwD+yTDXfHKIH9atjL1357Z8G/sLrDpEJOe+V11KzvWEkwEeBej4/Bprmgplu7nQNhbf
         m8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380618; x=1699985418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxa2X/M3i5M/B67pIBM08iOpkqVk5AqzieyHZGjyhtc=;
        b=MynyJe307OQjykSXXOH9bAhV15ZZCQmVWIS/vKYUjlH4wsD4WM+9YwCGMkiUp0ZOJL
         0X/WkQY2vumNhz9fS/9UxCF8GII6+slvVEzo6zmMP847j7ZeEAHJuzK0YWUGV2dS/tzt
         xaZ/UfWJ1/oXM+7CYhW4jIvHFFtYDT0K5SUt6pBOt77pNa3JW2gSTXU7buYpdndqwOr9
         r/QJ4DQWqSTeeoWIJpxzfYDIIOI0OPRhMNuHHFI+nH76j0AeqcdrEBc28czAz5ozamZS
         98HUhC0pgGY+TVyk4eUnsqQthIbwp/0uHnuV9ynZyvtk3jdxX1PSoWczxnbNhPmppLo2
         CQhg==
X-Gm-Message-State: AOJu0YznwEfkmG7IbiMA8iADcnVFADc0xEg++sO5lIRQoHTZaVW8qQjY
	oDCjmeO7PR1ftFLMP92ZAYE=
X-Google-Smtp-Source: AGHT+IEQmjibQ784vy6VRNnHQ85xLgjNWXzyE4NL1vQ8Kkz/qut4AdhAt5wqtkfkCdPsz3SW1ZwoXg==
X-Received: by 2002:a17:902:fa07:b0:1cb:ffc1:23a3 with SMTP id la7-20020a170902fa0700b001cbffc123a3mr26987897plb.62.1699380618084;
        Tue, 07 Nov 2023 10:10:18 -0800 (PST)
Received: from DT.local (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id az10-20020a170902a58a00b001cc615e6850sm131924plb.90.2023.11.07.10.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:10:17 -0800 (PST)
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
Subject: [PATCH v3 2/9] hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative and mailbox command support
Date: Tue,  7 Nov 2023 10:07:06 -0800
Message-ID: <20231107180907.553451-3-nifan.cxl@gmail.com>
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

Per cxl spec 3.0, add dynamic capacity region representative based on
Table 8-126 and extend the cxl type3 device definition to include dc region
information. Also, based on info in 8.2.9.8.9.1, add 'Get Dynamic Capacity
Configuration' mailbox support.

Note: decode_len of a dc region is aligned to 256*MiB, need to be divided by
256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
mailbox command.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 80 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  6 +++
 include/hw/cxl/cxl_device.h | 17 ++++++++
 3 files changed, 103 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 8eceedfa87..f80dd6474f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -80,6 +80,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+    DCD_CONFIG  = 0x48,
+        #define GET_DC_CONFIG          0x0
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1210,6 +1212,74 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.0 section 8.2.9.8.9.1: Get Dynamic Capacity Configuration
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
+    struct get_dyn_cap_config_in_pl {
+        uint8_t region_cnt;
+        uint8_t start_region_id;
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_config_out_pl {
+        uint8_t num_regions;
+        uint8_t rsvd1[7];
+        struct {
+            uint64_t base;
+            uint64_t decode_len;
+            uint64_t region_len;
+            uint64_t block_size;
+            uint32_t dsmadhandle;
+            uint8_t flags;
+            uint8_t rsvd2[3];
+        } QEMU_PACKED records[];
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_config_in_pl *in = (void *)payload_in;
+    struct get_dyn_cap_config_out_pl *out = (void *)payload_out;
+    uint16_t record_count = 0, i;
+    uint16_t out_pl_len;
+    uint8_t start_region_id = in->start_region_id;
+
+    if (start_region_id >= ct3d->dc.num_regions) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
+            in->region_cnt);
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    memset(out, 0, out_pl_len);
+    out->num_regions = record_count;
+    for (i = 0; i < record_count; i++) {
+        stq_le_p(&out->records[i].base,
+                ct3d->dc.regions[start_region_id + i].base);
+        stq_le_p(&out->records[i].decode_len,
+                ct3d->dc.regions[start_region_id + i].decode_len /
+                CXL_CAPACITY_MULTIPLIER);
+        stq_le_p(&out->records[i].region_len,
+                ct3d->dc.regions[start_region_id + i].len);
+        stq_le_p(&out->records[i].block_size,
+                ct3d->dc.regions[start_region_id + i].block_size);
+        stl_le_p(&out->records[i].dsmadhandle,
+                ct3d->dc.regions[start_region_id + i].dsmadhandle);
+        out->records[i].flags = ct3d->dc.regions[start_region_id + i].flags;
+    }
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1254,6 +1324,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_clear_poison, 72, 0 },
 };
 
+static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
+    [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
+        cmd_dcd_get_dyn_cap_config, 2, 0 },
+};
+
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 18 },
     [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
@@ -1465,7 +1540,12 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
 
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
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 7b4d1ee774..6c1ccda159 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1075,6 +1075,12 @@ static void ct3d_reset(DeviceState *dev)
     uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
     uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
 
+    if (ct3d->dc.num_regions) {
+        ct3d->cxl_dstate.is_dcd = true;
+    } else {
+        ct3d->cxl_dstate.is_dcd = false;
+    }
+
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
     cxl_device_register_init_t3(ct3d);
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 4f2ef0b899..334c51fddb 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -235,6 +235,7 @@ typedef struct cxl_device_state {
     uint64_t mem_size;
     uint64_t pmem_size;
     uint64_t vmem_size;
+    bool is_dcd;
 
     const struct cxl_cmd (*cxl_cmd_set)[256];
     CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
@@ -417,6 +418,17 @@ typedef struct CXLPoison {
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256
 
+#define DCD_MAX_REGION_NUM 8
+
+typedef struct CXLDCDRegion {
+    uint64_t base;
+    uint64_t decode_len; /* aligned to 256*MiB */
+    uint64_t len;
+    uint64_t block_size;
+    uint32_t dsmadhandle;
+    uint8_t flags;
+} CXLDCDRegion;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -453,6 +465,11 @@ struct CXLType3Dev {
     unsigned int poison_list_cnt;
     bool poison_list_overflowed;
     uint64_t poison_list_overflow_ts;
+
+    struct dynamic_capacity {
+        uint8_t num_regions; /* 0-8 regions */
+        CXLDCDRegion regions[DCD_MAX_REGION_NUM];
+    } dc;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
-- 
2.42.0

