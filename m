Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F41267B15
	for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976909; cv=none; b=Cpc7HTj7JYFxiHD2o2GIyZ61sEcqmA0LclKIbI8oH4cp9ReJJSd1ly15M/pllDfeIKG2UCGmagsMeQ3IIyjQZyKOurKHmNc+4YnbD7tOHngqZs7OTUU4zmSX8DGUXAGcc9A+JMxiwZP1T6qjaPkQxx6BkfY7tflNvVPOMQTzrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976909; c=relaxed/simple;
	bh=EW3ZpmNvi13I/YgACSqcSuu9OiYwWLtqb+XfD7S2/l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6fVCDlAGnOOqVa+e/ccJEu8+JRHQ+9yaZkoCrJIGOcs7kP6xSP/D7/5/yt5lVCPeofFtYg0MVX2KCe0lA1A2Yfsasb1WKUnqfFMvw3nElg27NBQzgOkuFDVlRuPoSij8Pp4ziAO9mW0VtJO3V3tXIo0qtqvzUbm+sw5ihmJxHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBe5TwFx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBe5TwFx"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2366e5e4dbaso25055625ad.1
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 15:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750976907; x=1751581707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3OR2sM5Mt73qc/RceEmvVlGIx7XFJ60NMbMeF9QBhw=;
        b=aBe5TwFxzZQK+y5jzSFgUVGw+DtknSKeVI34MDP+s3N6fGDE0LEzJckpbXCBjOY/GZ
         iYxHTqo5cEi9rs8yO35G8e31xVeT5Q7SHOeLMOjAUUBry6z3CnFqYwMbw+Ixxgj+x94z
         NNzwywGwh40gGuBuSkwOwk/GL0705xW5B0baKgODGSXnMbmG78u227lDAIV8Vg7PtOM7
         4esyUlmISEm/GU7SxmUkoVCBfa9qSgfbvfU0bkRwn9qQFHjjGVQywa+H59emqmcZSeSN
         9YZO0htriIavQcK8bnUErmPU/wBjor+cjZDn6h5vQlglnS2YKh6IBR4FleJHH5fNaYcr
         G/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750976907; x=1751581707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3OR2sM5Mt73qc/RceEmvVlGIx7XFJ60NMbMeF9QBhw=;
        b=paUr2MILckUHKXnGuzBqulJi0g1EJEyvyCaY2ntmmTmdfolzno4kqCZ0TwM+V8Wrn+
         sN22S+6mSFyTKDiL4+TxM818YfGl39DtNJgtJyqlyuj6t516Ax5W/cdMycnlavJF/EPo
         S5sdwTZ25WkMZqpSBHYws4CwoyP1PxUvvmn0enoyOXrJazSlRHsw3ETkaIqxxi4F9O99
         pgI7QX/vQo+QNFBy0UvVtm8cx1d18g28n6y4wmcmpwvfs0pFRlGny/pcopIvCHnriuuV
         pjBdrkHqNhMhGhA1WOshgidvjndULTk5UFPUGtwnXGsICqM/G4XMQt5wuN1uF68rXnLl
         Xkxw==
X-Forwarded-Encrypted: i=1; AJvYcCVBA4Om6HSbDljfJ2UG1vDRAVTSrhggviZwQ4F1baLq7VuMfTebjZfdQ9uwcSo+BbE31IuCyWwMXds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3dZ2sTbZhMqP86p35KUs8bt1rroGvobiEmMTyadZPv/pwypu
	PIIcEhitUafmxRP/URJJXY8AUJMOEfF3x+HQe1v7jJU29Qh2AvQ+xHdh
X-Gm-Gg: ASbGncs7zhBVZD5wuvMk3hHhYY3v3dfZn974G/pksZVK4shvFjPe6z9WbYwc5EAyIEz
	2vGELrlqvZ652B92ifsZUXC9oBrvc7xCk8VeGeU35OSG9b/2nhwl+mK91/0AuFfFU8chRW52zi7
	ak2/kluki6IdnyuKi2zL31Q6Es08gU92445tdCW4yL3o/S1UNBfp+dANTMSaC9eGNfwXZ6q0r6m
	/fy35QtDeUvNucFi+1/eiKdjpT8siC7q/8YddM03RYYF8EGrlFuJuLa9u4OH0Qjbc/7YPX6P7TB
	h8HNLLxg6j57mlZ3pQ8F0xv4nX3YdHYYtMZCsdwA00YmdLUSTJLt6+6PQ5vIok0htaXavZwgpsl
	jpgY4paw=
X-Google-Smtp-Source: AGHT+IFu9sX5qahTX6pLMUGmJOeGYzCNgXfj800wA7YwHPMovd/dEXpPsBTFkpCCcZuKHYFr7c+Ndw==
X-Received: by 2002:a17:903:8c6:b0:232:59b:5923 with SMTP id d9443c01a7336-23ac6375c83mr10666695ad.23.1750976907058;
        Thu, 26 Jun 2025 15:28:27 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 15:28:26 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	alok.a.tiwari@oracle.com,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v4 06/10] cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
Date: Thu, 26 Jun 2025 22:23:29 +0000
Message-ID: <20250626222743.1766404-7-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626222743.1766404-1-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
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

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 86 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c           |  6 +--
 include/hw/cxl/cxl_device.h  |  3 ++
 include/hw/cxl/cxl_mailbox.h |  6 +++
 4 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 7f0709a27f..69c618383a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -121,6 +121,7 @@ enum {
     FMAPI_DCD_MGMT = 0x56,
         #define GET_DCD_INFO    0x0
         #define GET_HOST_DC_REGION_CONFIG   0x1
+        #define SET_DC_REGION_CONFIG        0x2
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3387,6 +3388,84 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
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
+    CXLDCRegion *region = &ct3d->dc.regions[in->reg_id];
+
+    /*
+     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
+     * This command shall fail with Unsupported when the Sanitize on Release
+     * field does not match the region’s configuration... and the device
+     * does not support reconfiguration of the Sanitize on Release setting.
+     *
+     * Currently not reconfigurable, so always fail if sanitize bit (bit 0)
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
+    /* Return success if new block size == current block size */
+    if (in->block_sz == region->block_size) {
+        return CXL_MBOX_SUCCESS;
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
+    cxl_assign_event_header(&dcEvent.hdr,
+                            &dynamic_capacity_uuid,
+                            (1 << CXL_EVENT_TYPE_INFO),
+                            sizeof(dcEvent),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
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
@@ -3505,6 +3584,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
index b872a26173..ee554a77be 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1590,9 +1590,9 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
     pcie_aer_inject_error(PCI_DEVICE(obj), &err);
 }
 
-static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
-                                    const QemuUUID *uuid, uint32_t flags,
-                                    uint8_t length, uint64_t timestamp)
+void cxl_assign_event_header(CXLEventRecordHdr *hdr,
+                             const QemuUUID *uuid, uint32_t flags,
+                             uint8_t length, uint64_t timestamp)
 {
     st24_le_p(&hdr->flags, flags);
     hdr->length = length;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 6a5025200c..82e3bc1a71 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -729,4 +729,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                    uint64_t len);
 bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
                                   uint64_t len);
+void cxl_assign_event_header(CXLEventRecordHdr *hdr,
+                             const QemuUUID *uuid, uint32_t flags,
+                             uint8_t length, uint64_t timestamp);
 #endif
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index 9008402d1c..a05d7cb5b7 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -8,6 +8,7 @@
 #ifndef CXL_MAILBOX_H
 #define CXL_MAILBOX_H
 
+#define CXL_MBOX_CONFIG_CHANGE_COLD_RESET (1)
 #define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
 #define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -15,5 +16,10 @@
 #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
 #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
 #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
+#define CXL_MBOX_SECONDARY_MBOX_SUPPORTED (1 << 8)
+#define CXL_MBOX_REQUEST_ABORT_BACKGROUND_OP_SUPPORTED (1 << 9)
+#define CXL_MBOX_CEL_10_TO_11_VALID (1 << 10)
+#define CXL_MBOX_CONFIG_CHANGE_CONV_RESET (1 << 11)
+#define CXL_MBOX_CONFIG_CHANGE_CXL_RESET (1 << 12)
 
 #endif
-- 
2.47.2

