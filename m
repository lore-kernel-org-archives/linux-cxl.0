Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B724C1B21AA
	for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229845; cv=none; b=F1anP/TCoUSMBCS8yhXVXh9z4dMZrQgYbNXRu3qpZUWgaVN/5cu5AYZrEht0JTMF7NrZEGBT+epxDwJXHFs6EiApdWaF8flUIauSqrGOgKRZbnGdq1DniuGC83WlqweGd5nirfWIoKoMvus+jBAJdRZRwZFDz02xDjJXhbbcGj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229845; c=relaxed/simple;
	bh=ZfNpZUBJteTbhvSr7+jJSx3vJ2bjSqsuF33Efc53FIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oad6VR4UOWVeFYdEIQXvYGh2BIWxX915X4viO76afkQW+kkmNqjdjWC/BkAtoSE3fVtsllJrLI9uraptBui0TqIdMDWB6elpA6P8eaAHdwCQnOx8nR6qw2utsXMsHx6fsoN2LdrT2AP6HfLYGIn5odMjiYLdYFt3+tPhn/noEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcRIZgS2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcRIZgS2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223a7065ff8so48293115ad.0
        for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 09:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742229843; x=1742834643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hkn8lClrCPRJjRc61OgGLP/RguDNSmf0MEgtbmwbv9k=;
        b=bcRIZgS2ViiNmjVFtXDZyOaO/ezCxLyyVBaGt2oDI8atpiOCeNg3ubTlsZKQQFFFvV
         O/TObHHPK/UoNvQCgvY/vLIUSmCsFk91r8UWHytBVXvsIDi9iMByQKHh0qcZ9/iYx8kH
         uMvBofMZDgf67/yE2iArl2YYTV2T7N/2zvBf6WVll13ma0cN2+XDzhu9AJiW/1QgXb+P
         cYcFr0sAT4RQHpfPw0T424fsgAjsl2aKPj02KSPrlMtfg6erAgswZmN9/WPizhjzt1K9
         1A9JC3rfS1VmgW+UR5CdRmzBfT9Ld2po0OgDH7ApfHsgx/CVtWV3tT2Hoj0CNY+PmW61
         4T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229843; x=1742834643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hkn8lClrCPRJjRc61OgGLP/RguDNSmf0MEgtbmwbv9k=;
        b=T1xNJndaq6RZPLNtWgG/B7wvgutJMdp8z8zfY9/sg43OVmty9F2P5AcGDmZM92RMuO
         mnHuGoGkRUQffrgYFSmq9yhVpsrpMgMLgaQXNBc7fAehBVmtRG5M50527ihKotgq3yEX
         7hRh1fJTzr+cKWxvnvN12Wwnxvz6t4b26ZtataD83Y+XLylwx69+j6NabvAvvRgOsol+
         L/lTKuCEXJhOByEkXIkTkkMXyMyFTWZMyZM/yEJ/p337cc4zkG7DL9AKNfBZ5XRqL3YW
         dVPCwS2degAlnEd466O2lGlOtTfBjiCxZKM4N7QXbudmcMouyx9ZSOo0R57Wj3f8cmUa
         EESw==
X-Forwarded-Encrypted: i=1; AJvYcCWL/m79PfGe444CKrK4NLureYup4Y3WQ9QQcFx+tgjOkRJigDJ1PBap1ZRRuYF319IuHrpzq6kSR8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhSRoyTYAHk5/u57SgQKKjw9ZF4t4KW9RMtn7O16EQECpfFsrL
	nQVXQT4u3tRF3NugeilCdyJVFostG8CmR9OvHT6UeniT8xO3mEwq
X-Gm-Gg: ASbGncvhYzUtE7GBjjJIGHofZnUR8bfhibNmk82LMyKmD+G06mSTb5U/pqXpbR4vfiS
	En2KwybEBEC2kSsPeK3FjcyjTSAJEi2OH+WLad+I4IOaDGaCmv5F+9DJ1bDGE4IBMcsM1Fb2454
	8tJDcsYVPeWW9NbjnkJQdnHWsEfCaMM+i0ryX178Nq3MOuuEhaGMGjhHztSEOJn5GLH/wCLcFpn
	NvJeZ1EsOWtEGKIIbVTyjS12p5wr5fB+xSjPZo0xeXLzyVA7bp1LscRMgOEkNhw3XtcqSnFdhfL
	ZtchW4Y/+vTdlkdLJYzAv95BG07ddPda5cLEHJK0EALKhl8Lyck+d6H3gUa+ndp83A==
X-Google-Smtp-Source: AGHT+IFBkclO4TGHL2gkT3CI6sTdHYNvtYyBsSFqLvPDNhaaWWBtBRtVqvIa0ai7H0IA+fE/Z8x3dA==
X-Received: by 2002:a17:903:1d0:b0:21f:6c81:f63 with SMTP id d9443c01a7336-225e0a89e29mr142478615ad.16.1742229842840;
        Mon, 17 Mar 2025 09:44:02 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:44:02 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 6/9] cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
Date: Mon, 17 Mar 2025 16:31:33 +0000
Message-ID: <20250317164204.2299371-7-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317164204.2299371-1-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 100 +++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c           |   2 +-
 include/hw/cxl/cxl_device.h  |   3 ++
 include/hw/cxl/cxl_mailbox.h |   6 +++
 4 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4bb51bf3e8..51ead2b152 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -125,6 +125,7 @@ enum {
     FMAPI_DCD_MGMT = 0x56,
         #define GET_DCD_INFO 0x0
         #define GET_HOST_DC_REGION_CONFIG 0x1
+        #define SET_DC_REGION_CONFIG 0x2
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3494,6 +3495,98 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
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
+/*
+ * CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602)
+ */
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
+    } QEMU_PACKED *in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLEventDynamicCapacity dcEvent = {};
+    CXLDCRegion *region;
+
+    if (ct3d->dc.num_regions == 0) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /*
+     * TODO: Fail with CXL_MBOX_INVALID_SECURITY_STATE if
+     * device has been locked
+     */
+
+    in = (void *)payload_in;
+    region = &ct3d->dc.regions[in->reg_id];
+
+    /*
+     * TODO: Fail if sanitize bit doesn't match current config and "the device
+     * does not support reconfiguration of the Sanitize on Release setting."
+     * Currently not reconfigurable, so always fail if sanitize bit
+     * doesn't match.
+     */
+    if ((in->flags & 1) != (region->flags & 1)) {
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
+    /* Free bitmap and create new one for new block size. */
+    g_free(region->blk_bitmap);
+    region->blk_bitmap = bitmap_new(region->len / in->block_sz);
+
+    /* Create event record and insert into event log */
+    cxl_mbox_dc_event_create_record_hdr(ct3d, &dcEvent.hdr);
+    dcEvent.type = DC_EVENT_REGION_CONFIG_UPDATED;
+    /* FIXME: for now, validity flag is cleared */
+    dcEvent.validity_flags = 0;
+    /* FIXME: Currently only support 1 host */
+    dcEvent.host_id = 0;
+    dcEvent.updated_region_id = in->reg_id;
+
+    if (cxl_event_insert(&ct3d->cxl_dstate,
+                        CXL_EVENT_TYPE_DYNAMIC_CAP,
+                        (CXLEventRecordRaw *)&dcEvent)) {
+        cxl_event_irq_assert(ct3d);
+    }
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3620,6 +3713,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
         cmd_fm_get_dcd_info, 0, 0},
     [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
         cmd_fm_get_host_dc_region_config, 4, 0},
+    [FMAPI_DCD_MGMT][SET_DC_REGION_CONFIG] = { "SET_DC_REGION_CONFIG",
+        cmd_fm_set_dc_region_config, 16,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+         CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
 };
 
 /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ac74e62875..b742b2bb8d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1686,7 +1686,7 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
     pcie_aer_inject_error(PCI_DEVICE(obj), &err);
 }
 
-static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
+void cxl_assign_event_header(CXLEventRecordHdr *hdr,
                                     const QemuUUID *uuid, uint32_t flags,
                                     uint8_t length, uint64_t timestamp)
 {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 81b826f570..217003a29d 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -806,4 +806,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
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
-- 
2.47.2

