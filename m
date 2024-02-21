Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74084FD8
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539675; cv=none; b=jf9OBnWgVhrWjL7/a3omv+D0JJJszEMuNjFxSELEOUa4pQ2I1nim63kq0pcLAyB37ETCj2kVXt4j1GpaV9rTROVjS410O685BCI+TuMBxyU8rrRnU5v4h/7EEJeyB5x/fqUpdcCN3SlxOHMartq5nHiR9LSUQNlUvXjzpoat10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539675; c=relaxed/simple;
	bh=7Gx6/dpcKfqDRLViC/V6lC9RYGe2vAovzz0ElkU9LKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InoY+GPc32bqS2vsmUr15L9zaonHNnw4Q7x7ESPgZ8diEBtfZoaDkhvpR+Bt73qZdftubsLITFtwW7iQ5xsvOPr2Sq38VLJYUX3+/6CW2rx0Ja/qcV4hH1gchjPX7coiuxfyVNT+/ZXtvxhT/sWdTVPRH56VIEVNs07tnI0T8jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7MvtXX0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7MvtXX0"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-290ec261a61so4228011a91.0
        for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 10:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708539673; x=1709144473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=un/ALJ33UJ/4j/7Dwtf0xAxrV2NGLPOZb9LxVVKMbdE=;
        b=Z7MvtXX0Md9PImyrEa61bwrlu71drm024hDWxFOvup3a0LZTgGmQLi48Oa2FmwzcBy
         qxgTRZB3GargxpZZ+aGf+dL6MzN/ICQvzUEr6t9xo48s25oESu/a0F/0wN7aFmfgmkjv
         BJ+ZjDfxjffTHvKXWZR60NKk9UaMUjZ4mXuHEiPBN7DatLR3tz7gYxMa8F3AzfJGg03W
         gxTQ9Ldbq8P28NnvqNP8FyLoij18uy/6bRIcXOrQwHZo8yCzKw0zHW0n2tW63KXWnGwu
         KJcc8K5wdZg7jjESduIp7wq/Zo/tCBVExY9qLL8J4v4Ar3/4d+/0MjxzZBX6mZ16g8gg
         Sikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708539673; x=1709144473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=un/ALJ33UJ/4j/7Dwtf0xAxrV2NGLPOZb9LxVVKMbdE=;
        b=qtE1MD+kNPdDkmIasW6t9qhH2L/tuu186r/73DKa/inuw+AC5BUi9f1Mnu9tyMdx94
         tCaXOCoYRkoTmWHKwkxDuXnSsS8uIcBZotSDrH7G0wrgRGrhBBxj3n+vDKy0CWt2IMtP
         b1vJQuXKHg4/undnMgIsgNnUOHEjUNjiIgH/TgB6z4PX6h+8seoQSX34ycoprMdsbgh+
         QMO960UoEH+1QMin9vRHXB3jSiWiHe3+pxjPKkjnn96DPbxYx0RCVru+a1s1H81k0LXC
         /WTMGa3ffW1VLYcuOqFSPVbWbhsmsEuFQdS5AWbI3Utmyb6aH4xJs3yXD2kpsNxkc4iT
         HCpA==
X-Forwarded-Encrypted: i=1; AJvYcCXCnWWkT4q/Yq+NCT3J2pX6TGaIgGfnZwLvU+P37nJjWv338Ix5EIs+91XrcM4DRKuneOIBfvv/u2+0Y0Lag6nXAeUL8e0YQVdK
X-Gm-Message-State: AOJu0YweYzSjcb3aUss/LQB06RQ9yn1/XYaSwQMojr8VMSoZudApMzS6
	fzZONYHC0KdDA4WqBPHTyUjCizG2HdcYb7qFVIHKuuyvGGkn7yuF
X-Google-Smtp-Source: AGHT+IHZJskgqEMippermGM7haozIZGUI/e1pO3JbuOpb/ZzYlJZuIuyb9dQ1vzD1Ic/ZVpDa2Qq3w==
X-Received: by 2002:a17:90a:10d0:b0:299:bade:ed0b with SMTP id b16-20020a17090a10d000b00299badeed0bmr6854885pje.45.1708539673292;
        Wed, 21 Feb 2024 10:21:13 -0800 (PST)
Received: from localhost.localdomain ([2601:641:300:14de:5692:7e41:13a2:69a])
        by smtp.gmail.com with ESMTPSA id cs16-20020a17090af51000b002992f49922csm9979009pjb.25.2024.02.21.10.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 10:21:13 -0800 (PST)
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
Subject: [PATCH v4 02/10] hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative and mailbox command support
Date: Wed, 21 Feb 2024 10:15:55 -0800
Message-ID: <20240221182020.1086096-3-nifan.cxl@gmail.com>
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

Per cxl spec r3.1, add dynamic capacity region representative based on
Table 8-165 and extend the cxl type3 device definition to include dc region
information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
Configuration' mailbox support.

Note: decode_len of a dc region is aligned to 256*MiB, divided by
256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
mailbox command.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 110 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  16 ++++++
 2 files changed, 126 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ba1d9901df..88e3b733e3 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -22,6 +22,7 @@
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
+#define CXL_SPEC_AFTER_R30
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -80,6 +81,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+    DCD_CONFIG  = 0x48,
+        #define GET_DC_CONFIG          0x0
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1238,6 +1241,103 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
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
+    struct get_dyn_cap_config_in_pl {
+        uint8_t region_cnt;
+        uint8_t start_region_id;
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_config_out_pl {
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
+        /*
+         * if cxl spec version >= 3.1, extra output payload as defined
+         * in struct get_dyn_cap_config_out_pl_extra comes here.
+         */
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_config_in_pl *in = (void *)payload_in;
+    struct get_dyn_cap_config_out_pl *out = (void *)payload_out;
+    uint16_t record_count = 0;
+    uint16_t i;
+    uint16_t out_pl_len;
+    uint8_t start_region_id = in->start_region_id;
+#ifdef CXL_SPEC_AFTER_R30
+    struct get_dyn_cap_config_out_pl_extra {
+        uint32_t num_extents_supported;
+        uint32_t num_extents_available;
+        uint32_t num_tags_supported;
+        uint32_t num_tags_available;
+    } QEMU_PACKED;
+    struct get_dyn_cap_config_out_pl_extra *extra_out;
+#endif
+
+    if (start_region_id >= ct3d->dc.num_regions) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
+            in->region_cnt);
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+#ifdef CXL_SPEC_AFTER_R30
+    extra_out = (struct get_dyn_cap_config_out_pl_extra *)(payload_out +
+            out_pl_len);
+    out_pl_len += sizeof(struct get_dyn_cap_config_out_pl_extra);
+#endif
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    out->num_regions = ct3d->dc.num_regions;
+#ifdef CXL_SPEC_AFTER_R30
+    out->regions_returned = record_count;
+#endif
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
+#ifdef CXL_SPEC_AFTER_R30
+    /*FIXME: need to set valid values in the future*/
+    stq_le_p(&extra_out->num_extents_supported, 0);
+    stq_le_p(&extra_out->num_extents_available, 0);
+    stq_le_p(&extra_out->num_tags_supported, 0);
+    stq_le_p(&extra_out->num_tags_available, 0);
+#endif
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1282,6 +1382,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
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
@@ -1487,7 +1592,12 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
 
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
index 3cf3077afa..6df7fecdf1 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -422,6 +422,17 @@ typedef struct CXLPoison {
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
@@ -454,6 +465,11 @@ struct CXLType3Dev {
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
2.43.0

