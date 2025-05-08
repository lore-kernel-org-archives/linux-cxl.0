Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F128691
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663536; cv=none; b=sgmGkOH+VHKXrxH9OV/dHXJder3Cxllst7c90fIzesTP3wq/FOWbL33hFG6g++a6dhWSr5NcXhXNmz6ke0mYyQ07MyI+MKPeHJjI5YmUN8wq3u/3IlibVfJ2VdPWu/BJNzh3h1RxrTimXixJOBBNgvKHvOgAlNVlvYQ22cV5DFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663536; c=relaxed/simple;
	bh=wdjrhXA8g5bo6cAZj5UvTAfiN25PICszA49jnbq2KIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcnxTGu1FQ6wvP9TGDB7SzgPZYZ+mwM2vAISglmUsOIwQ4zybNfa41zzRCGdWJuDxnuPgC2lSOJS4XUNSY4EDGuUTuiFOQKqkirCw4T67TVEcsAG4gqinvxNQpCj2TJhkFV6CDt3DAfZOZBHgYi6uBuRuTF5t9UuQgLFxm5xwDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbX8jGDR; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbX8jGDR"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736bfa487c3so434468b3a.1
        for <linux-cxl@vger.kernel.org>; Wed, 07 May 2025 17:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746663533; x=1747268333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6cBqkRIN/p93Mp6T+47qwI49pgayI1pu+8Iku9SCaA=;
        b=LbX8jGDRSO+rfBBXQb+bLx32sRD2k0PsqvbJ7NgZzku1cBpBdMP9zgz/hsxkVghgFz
         jbqSXcgFDboEK1TzZ8tpes9sD1lNRrjS1obXQZ/SL1mMaeD7sqgpiUC8GOLla0+CeZOh
         IY06fVmHz6oVFneBr1MNfCasEgdvVKy7bSkszdmNSHfSOw2a6yDeylPT1QFFgrnERxBb
         w72rwnbrRGoYWlSvVI6VuubV0kGZW8WQ2Rm+Zt/lFLOlNYDfK+fcNz8Xy735jVZRYyGD
         o1RBKiL7Zu/OgfBtQTOrKI0oM4P0ZLa/F6289jECStpaH5/rQ88R1oYCG+OAds5S24SR
         eX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746663533; x=1747268333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6cBqkRIN/p93Mp6T+47qwI49pgayI1pu+8Iku9SCaA=;
        b=TBBnlh7rRFHzb8oLJ00cYhu43P2nwOl8UpycXejoV31gNr92vxDcV9aOpynO24l/w+
         pjAQTFO9Y3vYzlHHS55i6/9yCL5zfJa2gosmf3ljBMPgi7W0sjF0pNtLy132UB6Z/KxD
         0VMB7TTXcFf5EVK+AT9YVIl9xoyVgUxwpXJe3SE09QIbPA4wkso38GEdEincf4RO8xo5
         RcNr/Vj/6R06DOcb137FuuIBpaLflRF2h7PbFt7/mMNoEYwOnm3yHug4Q5Zu3ab7/I6R
         g2BMGzdB/Wr6n/er2zjg1+YAxi52Sy1glpvxYH1pC45R9IsRIYX7rzsl3zVSmLaXlpvo
         1owA==
X-Forwarded-Encrypted: i=1; AJvYcCXovu44koynkX9a87arG2jQWMhJac2ehkuh+tDU7GjGvzEJwWQ50dn9aROFRyO1QzOtsfFIE8L9tWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoBm6AjiZQJJdP9slaZtEQ3x5OfeY4og817VKCyDfpFy25E26n
	UwplDR3QIm8Tg0UsMbflYlmzBAwJPzOmS7Wn3paIhBtMepDcb6kB
X-Gm-Gg: ASbGncvVhA9YnBh9J68/PUsqa0xUtLmO8f/V3U+w/16esfQtufrhDWKLbDPX6zlD5ar
	nuXHzFvWEGuDcAy9ptl/6ANElUOcD2WLJzg3cDk4GBbrkYCwpXhgVCNgKhOs9JcJfgtcTva3P1G
	FkmvFPoHjPK6L2Es2el82uI9A1QQ2MrqOQk0D/+QY+Eq1SKN1CeYkWyQkc8hsOq/8MGrcUGl+eP
	e+/6KZaBKZr6O8Ho+tLRuFAudajDIAgaV0bPnnNQ5S5qg+kSPnid3glF5WxwOtEnjlmr+btDoh9
	YJyG0zbk3F+T1iJUPYgt2HcdRmrzpLWr8APpFTZ5rEqgMbCNL+Rfrpt/9lEINg==
X-Google-Smtp-Source: AGHT+IFtkrcVBX6ObZonU424FPrWqjFZpGx77nj+3pAk9SRgQxByIsqorta/xrxBeb2ObdUJyUJqsA==
X-Received: by 2002:a05:6a00:2e0e:b0:740:9d6f:a73b with SMTP id d2e1a72fcca58-7409d6fa83bmr6306683b3a.17.1746663533512;
        Wed, 07 May 2025 17:18:53 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 17:18:53 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 07/10] cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
Date: Thu,  8 May 2025 00:01:03 +0000
Message-ID: <20250508001754.122180-8-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 97 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c           |  2 +-
 include/hw/cxl/cxl_device.h  |  3 ++
 include/hw/cxl/cxl_mailbox.h |  6 +++
 include/hw/cxl/cxl_opcodes.h |  1 +
 5 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6afc45833d..fe38a13f71 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3426,6 +3426,96 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void cxl_mbox_dc_event_create_record_hdr(CXLType3Dev *ct3d,
+                                                CXLEventRecordHdr *hdr)
+{
+    /*
+     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
+     *
+     * All Dynamic Capacity event records shall set the Event Record Severity
+     * field in the Common Event Record Format to Informational Event. All
+     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
+     * Event Log.
+     */
+    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
+
+    st24_le_p(&hdr->flags, flags);
+    hdr->length = sizeof(struct CXLEventDynamicCapacity);
+    memcpy(&hdr->id, &dynamic_capacity_uuid, sizeof(hdr->id));
+    stq_le_p(&hdr->timestamp, cxl_device_get_timestamp(&ct3d->cxl_dstate));
+}
+
+/* CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602) */
+static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
+                                              uint8_t *payload_in,
+                                              size_t len_in,
+                                              uint8_t *payload_out,
+                                              size_t *len_out,
+                                              CXLCCI *cci)
+{
+    struct {
+        uint8_t reg_id;
+        uint8_t rsvd[3];
+        uint64_t block_sz;
+        uint8_t flags;
+        uint8_t rsvd2[3];
+    } QEMU_PACKED *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLEventDynamicCapacity dcEvent = {};
+    CXLDCRegion *region;
+
+    region = &ct3d->dc.regions[in->reg_id];
+
+    /*
+     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
+     * This command shall fail with Unsupported when the Sanitize on Release
+     * field does not match the region’s configuration... and the device
+     * does not support reconfiguration of the Sanitize on Release setting.
+     *
+     * Currently not reconfigurable, so always fail if sanitize bit
+     * doesn't match.
+     */
+    if ((in->flags & 0x1) != (region->flags & 0x1)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    if (in->reg_id >= DCD_MAX_NUM_REGION) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /* Check that no extents are in the region being reconfigured */
+    if (!bitmap_empty(region->blk_bitmap, region->len / region->block_size)) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /* Check that new block size is supported */
+    if (!test_bit(BIT((int) log2(in->block_sz)),
+                  &region->supported_blk_size_bitmask)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    /* Free bitmap and create new one for new block size. */
+    qemu_mutex_lock(&region->bitmap_lock);
+    g_free(region->blk_bitmap);
+    region->blk_bitmap = bitmap_new(region->len / in->block_sz);
+    qemu_mutex_unlock(&region->bitmap_lock);
+    region->block_size = in->block_sz;
+
+    /* Create event record and insert into event log */
+    cxl_mbox_dc_event_create_record_hdr(ct3d, &dcEvent.hdr);
+    dcEvent.type = DC_EVENT_REGION_CONFIG_UPDATED;
+    dcEvent.validity_flags = 1;
+    dcEvent.host_id = 0;
+    dcEvent.updated_region_id = in->reg_id;
+
+    if (cxl_event_insert(&ct3d->cxl_dstate,
+                         CXL_EVENT_TYPE_DYNAMIC_CAP,
+                         (CXLEventRecordRaw *)&dcEvent)) {
+        cxl_event_irq_assert(ct3d);
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3552,6 +3642,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
         cmd_fm_get_dcd_info, 0, 0 },
     [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
         cmd_fm_get_host_dc_region_config, 4, 0 },
+    [FMAPI_DCD_MGMT][SET_DC_REGION_CONFIG] = { "SET_DC_REGION_CONFIG",
+        cmd_fm_set_dc_region_config, 16,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
 };
 
 /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b5b3df5edf..edc29f1ccb 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1695,7 +1695,7 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
     pcie_aer_inject_error(PCI_DEVICE(obj), &err);
 }
 
-static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
+void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                                     const QemuUUID *uuid, uint32_t flags,
                                     uint8_t length, uint64_t timestamp)
 {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 9cfd9c5a9f..22823e2054 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -821,4 +821,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                    uint64_t len);
 bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                   uint64_t len);
+void cxl_assign_event_header(CXLEventRecordHdr *hdr,
+                             const QemuUUID *uuid, uint32_t flags,
+                             uint8_t length, uint64_t timestamp);
 #endif
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index 8e1c7c5f15..820c411cbb 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -8,6 +8,7 @@
 #ifndef CXL_MAILBOX_H
 #define CXL_MAILBOX_H
 
+#define CXL_MBOX_CONFIG_CHANGE_COLD_RESET (1)
 #define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
 #define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -15,6 +16,11 @@
 #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
 #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
 #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
+#define CXL_MBOX_SECONDARY_MBOX_SUPPORTED (1 << 8)
+#define CXL_MBOX_REQUEST_ABORT_BACKGROUND_OP_SUPPORTED (1 << 9)
+#define CXL_MBOX_CEL_10_TO_11_VALID (1 << 10)
+#define CXL_MBOX_CONFIG_CHANGE_CONV_RESET (1 << 11)
+#define CXL_MBOX_CONFIG_CHANGE_CXL_RESET (1 << 12)
 
 #define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
 #define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)
diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
index 68ad68291c..ed4be23b75 100644
--- a/include/hw/cxl/cxl_opcodes.h
+++ b/include/hw/cxl/cxl_opcodes.h
@@ -64,5 +64,6 @@ enum {
     FMAPI_DCD_MGMT = 0x56,
         #define GET_DCD_INFO 0x0
         #define GET_HOST_DC_REGION_CONFIG 0x1
+        #define SET_DC_REGION_CONFIG 0x2
     GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
 };
-- 
2.47.2

