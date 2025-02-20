Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278DA926
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 05:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029337; cv=none; b=XK1zUW256KoeMknnkH1LFcm018DwBOXeUFMZ+BLWOXEE8o3Yiz2N8RGqVqDWe7hBM/tM+wqsWsI5fevqI1BKas8wLqofvIC1zEtffADi7ZwEFStq0hc8Cm685YeyqZ2xN6TWQLqNgEg8yozTWGJ6Gb87e1quRIrl9TNmzhL0Mts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029337; c=relaxed/simple;
	bh=9h2YqdznPfcL0T6AMh016dwP0vpn+wwZ1fzqlt1vhF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=pRRtB0HqpJ0LcJEbp93N5MFiBshu3f0U7RR6tw4Wfgq6j9E8DQVZVngNb7EXFWSzfwXBQTjJWy9lzyai2FWwVxfporo0mz9+EgooG/zIueDgslCExjnNYQ/aR17PKyzcPhEaL2qU2yN+QSR5iyEURUZXYn2r0rNAr/grwIyEoaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=g2topHd9; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g2topHd9"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250220052852epoutp036099af9fa04b16a580f9b801c842162b~l03WRaT991678216782epoutp03f
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 05:28:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250220052852epoutp036099af9fa04b16a580f9b801c842162b~l03WRaT991678216782epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740029332;
	bh=BmlJV03yYaBKKgYhrQ/WDUvXDtMbqXxJ1FIYxQTvZSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g2topHd9kvVsYn2HyfuoGI0q9/A1gQ+POhTmzLTi7bND0sLhNJL5VLfpTLP50wKCj
	 hnuN+bOp9VMFAZPWty3mJvKD3rjfBOo8Yu4vp5tF3/HE78gEf7dOR4O4VToEUluuXq
	 eDHkdr5A2ZA/WRxRFL62804rMmEl0Gem61cN8so8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250220052852epcas5p27e5d6464f5622f4f6aeccb2642d2f77b~l03V1A-4I0943209432epcas5p21;
	Thu, 20 Feb 2025 05:28:52 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Yz1yT53Bxz4x9QB; Thu, 20 Feb
	2025 05:28:49 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0B.0C.19956.19DB6B76; Thu, 20 Feb 2025 14:28:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250220052738epcas5p24b49106f81b1a621acffe6124eba9e52~l02Ql-I5q2074720747epcas5p26;
	Thu, 20 Feb 2025 05:27:38 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250220052738epsmtrp20847174883054fc9d23e866bc45c1266~l02QlKhFv3134831348epsmtrp2H;
	Thu, 20 Feb 2025 05:27:38 +0000 (GMT)
X-AuditID: b6c32a4b-fd1f170000004df4-68-67b6bd91cccc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F0.CA.23488.94DB6B76; Thu, 20 Feb 2025 14:27:38 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250220052736epsmtip25bfd52223630658332408dce25c46ed0~l02PKH1N21358513585epsmtip2g;
	Thu, 20 Feb 2025 05:27:36 +0000 (GMT)
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Vinayak Holikatti
	<vinayak.kh@samsung.com>
Subject: [PATCH v3 3/3] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations Sanitize and Write Zeros commands cxl r3.2(8.2.10.9.5.3)
Date: Thu, 20 Feb 2025 10:57:24 +0530
Message-Id: <20250220052724.1256642-4-vinayak.kh@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220052724.1256642-1-vinayak.kh@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmpu7EvdvSDTo/KFlMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBYnTm5nB4rNYXfg8tg56y67x5Nrm5k8
	+rasYvSYOrve4/MmuQDWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
	VFslF58AXbfMHKCblBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV5
	6Xp5qSVWhgYGRqZAhQnZGc8fT2ApuOpZMXn9Q6YGxlajLkZODgkBE4lLxyaydTFycQgJ7GaU
	WPdgFguE84lR4vnGRUwQzjdGibV3NjLDtLw4+IkZIrGXUeLr5x1QVQ1MEht77rKBVLEJGEg8
	aD7ODmKLCEhK/O46DdbNLPCBUWLRU10QW1igF8g+7gBiswioSnx+9Qysl1fAVmLzpquMENvk
	JfYfPAvWyylgJ7Hv6XR2iBpBiZMzn7BAzJSXaN46G+wiCYGf7BLdX7ezQzS7SGy70sUEYQtL
	vDq+BSouJfH53V42CLtY4tzFT1DLaiRed62AetNeovVUP5DNAbRAU2L9Ln2IsKzE1FPrmCD2
	8kn0/n4CNZ5XYsc8EJsDyFaRWPo2E2bTl2fNjBBhD4kpx8QhQTWRUWL6lfPsExgVZiH5ZhaS
	b2YhLF7AyLyKUTK1oDg3PbXYtMA4L7UcHsnJ+bmbGMHJVMt7B+OjBx/0DjEycTAeYpTgYFYS
	4W2r35IuxJuSWFmVWpQfX1Sak1p8iNEUGNwTmaVEk/OB6TyvJN7QxNLAxMzMzMTS2MxQSZy3
	eWdLupBAemJJanZqakFqEUwfEwenVAPTvRtTnRw6VuYtEb+8ddPJO1u4OENFcxaKSfEwyb6c
	dYrX84CG4YylvPFZD1aYFYm4nHS1Ffx1JDzyuNH9WtZa5zN/s8wZ05f1BS5nYQq+udCf94hv
	dryBdYTmXAPDiTfMK7tzfn9x5JXa2KTAmmG2z1hYfOKb3GXL3Iw889ep3s11D+VozjrlLPX8
	4MwLvLdS68+ZPXfZu9D17Mwe2efLTq7YO+FjpKJLWvKdTb9fb0iMu79NcOtyxy+NfMV2F3S8
	Kl9IHZpgvCH825n3f5fPa2RyfO5ZbN9m65nGmDInZ1FDTsnx7+nNjjN4OJgnfrh71ubjx3t5
	isbVK+XXJBxdJLTr57w5M11Fzc9cqNijxFKckWioxVxUnAgA5IUt4i8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSvK7X3m3pBvv3MFlMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBYnTm5nB4rNYXfg8tg56y67x5Nrm5k8
	+rasYvSYOrve4/MmuQDWKC6blNSczLLUIn27BK6M548nsBRc9ayYvP4hUwNjq1EXIyeHhICJ
	xIuDn5i7GLk4hAR2M0pce3eOCSIhJXFs5082CFtYYuW/5+wQRf8YJY409IAVsQkYSDxoPs4O
	YosISEr87joNNolZ4BejxNPd98E6hAW6GSV6r3wGG8UioCrx+dUzMJtXwFZi86arjBAr5CX2
	HzzLDGJzCthJ7Hs6HWyqEFDNkv7TUPWCEidnPmEBsZmB6pu3zmaewCgwC0lqFpLUAkamVYyS
	qQXFuem5yYYFhnmp5XrFibnFpXnpesn5uZsYwUGvpbGD8d23Jv1DjEwcjIcYJTiYlUR42+q3
	pAvxpiRWVqUW5ccXleakFh9ilOZgURLnXWkYkS4kkJ5YkpqdmlqQWgSTZeLglGpgkpmceVOO
	6aZN7CWTk6p3bPNL4hK1JK9J9yi7WG7hTlsymVWsvXJP/fs8Yc1z28LWdMwzs7++Ll18ed6a
	xAKxoAfb5Rm4PvMJvjrfUBTbaJKaterFuVlnZY6f/8J+WThnmbz3xDCXbzfEHBjt9sTLWSRV
	33hTzvTO9d1ets2hZqVR217kFN6fseXteb9pvL8FiwXnadxbx3ubw3mB9OqduZMOB2nuq2Hs
	nvDn/uz5e3aEfz67/sDaq/PnZ9Y77lt381e6zzyeNaUhfBs4lp+79tdysWDE5vMb1F/2fDfZ
	e21yqEJSvKe8dNJhFWuH3SzsLXUvQ7M+cMc0vigL/nPr5UudCa3nMhdvX7trVse3o0osxRmJ
	hlrMRcWJAIBurRXpAgAA
X-CMS-MailID: 20250220052738epcas5p24b49106f81b1a621acffe6124eba9e52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220052738epcas5p24b49106f81b1a621acffe6124eba9e52
References: <20250220052724.1256642-1-vinayak.kh@samsung.com>
	<CGME20250220052738epcas5p24b49106f81b1a621acffe6124eba9e52@epcas5p2.samsung.com>

CXL spec 3.2 section 8.2.10.9.5.3 describes media operations commands.
CXL devices supports media operations Sanitize and Write zero command.

Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 210 +++++++++++++++++++++++++++++++++++-
 include/hw/cxl/cxl_device.h |   4 +
 2 files changed, 213 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2428d85fef..7b4e4daeb2 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1731,6 +1731,130 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
     return CXL_MBOX_BG_STARTED;
 }
 
+struct dpa_range_list_entry {
+    uint64_t starting_dpa;
+    uint64_t length;
+} QEMU_PACKED;
+
+struct CXLSanitizeInfo {
+    uint32_t dpa_range_count;
+    uint8_t fill_value;
+    struct dpa_range_list_entry dpa_range_list[];
+} QEMU_PACKED;
+
+static uint64_t get_vmr_size(CXLType3Dev *ct3d, MemoryRegion **vmr)
+{
+    MemoryRegion *mr;
+    if (ct3d->hostvmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostvmem);
+        if (vmr) {
+            *vmr = mr;
+        }
+        return memory_region_size(mr);
+    }
+    return 0;
+}
+
+static uint64_t get_pmr_size(CXLType3Dev *ct3d, MemoryRegion **pmr)
+{
+    MemoryRegion *mr;
+    if (ct3d->hostpmem) {
+        mr = host_memory_backend_get_memory(ct3d->hostpmem);
+        if (pmr) {
+            *pmr = mr;
+        }
+        return memory_region_size(mr);
+    }
+    return 0;
+}
+
+static uint64_t get_dc_size(CXLType3Dev *ct3d, MemoryRegion **dc_mr)
+{
+    MemoryRegion *mr;
+    if (ct3d->dc.host_dc) {
+        mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        if (dc_mr) {
+            *dc_mr = mr;
+        }
+        return memory_region_size(mr);
+    }
+    return 0;
+}
+
+static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
+                             size_t length)
+{
+    uint64_t vmr_size, pmr_size, dc_size;
+
+    if ((dpa_addr % CXL_CACHE_LINE_SIZE) ||
+        (length % CXL_CACHE_LINE_SIZE)  ||
+        (length <= 0)) {
+        return -EINVAL;
+    }
+
+    vmr_size = get_vmr_size(ct3d, NULL);
+    pmr_size = get_pmr_size(ct3d, NULL);
+    dc_size = get_dc_size(ct3d, NULL);
+
+    if (dpa_addr + length > vmr_size + pmr_size + dc_size) {
+        return -EINVAL;
+    }
+
+    if (dpa_addr > vmr_size + pmr_size) {
+        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
+            return -ENODEV;
+        }
+    }
+
+    return 0;
+}
+
+static int sanitize_range(CXLType3Dev *ct3d, uint64_t dpa_addr, size_t length,
+                          uint8_t fill_value)
+{
+
+    uint64_t vmr_size, pmr_size;
+    AddressSpace *as = NULL;
+    MemTxAttrs mem_attrs = {0};
+
+    vmr_size = get_vmr_size(ct3d, NULL);
+    pmr_size = get_pmr_size(ct3d, NULL);
+
+    if (dpa_addr < vmr_size) {
+        as = &ct3d->hostvmem_as;
+    } else if (dpa_addr < vmr_size + pmr_size) {
+        as = &ct3d->hostpmem_as;
+    } else {
+        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
+            return -ENODEV;
+        }
+        as = &ct3d->dc.host_dc_as;
+    }
+
+    return address_space_set(as, dpa_addr, fill_value, length, mem_attrs);
+}
+
+/* Perform the actual device zeroing */
+static void __do_sanitize(CXLType3Dev *ct3d)
+{
+    struct CXLSanitizeInfo  *san_info = ct3d->media_op_sanitize;
+    int dpa_range_count = san_info->dpa_range_count;
+    int rc = 0, i;
+
+    for (i = 0; i < dpa_range_count; i++) {
+        rc = sanitize_range(ct3d, san_info->dpa_range_list[i].starting_dpa,
+                            san_info->dpa_range_list[i].length,
+                            san_info->fill_value);
+        if (rc) {
+            goto exit;
+        }
+    }
+exit:
+    g_free(ct3d->media_op_sanitize);
+    ct3d->media_op_sanitize = NULL;
+    return;
+}
+
 enum {
     MEDIA_OP_CLASS_GENERAL  = 0x0,
         #define MEDIA_OP_GEN_SUBC_DISCOVERY 0x0
@@ -1823,6 +1947,70 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode media_operations_sanitize(CXLType3Dev *ct3d,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            uint8_t fill_value,
+                                            CXLCCI *cci)
+{
+    struct media_operations_sanitize {
+        uint8_t media_operation_class;
+        uint8_t media_operation_subclass;
+        uint8_t rsvd[2];
+        uint32_t dpa_range_count;
+        struct {
+            uint64_t starting_dpa;
+            uint64_t length;
+        } dpa_range_list[];
+    } QEMU_PACKED *media_op_in_sanitize_pl = (void *)payload_in;
+    uint32_t dpa_range_count = media_op_in_sanitize_pl->dpa_range_count;
+    uint64_t total_mem = 0;
+    int secs = 0, i;
+
+    if (dpa_range_count == 0) {
+        return CXL_MBOX_SUCCESS;
+    }
+
+    if (len_in < (sizeof(*media_op_in_sanitize_pl) +
+           (dpa_range_count * sizeof(struct dpa_range_list_entry)))) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    for (i = 0; i < dpa_range_count; i++) {
+        uint64_t start_dpa =
+            media_op_in_sanitize_pl->dpa_range_list[i].starting_dpa;
+        uint64_t length = media_op_in_sanitize_pl->dpa_range_list[i].length;
+        if (validate_dpa_addr(ct3d, start_dpa, length)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        total_mem += media_op_in_sanitize_pl->dpa_range_list[i].length;
+    }
+    ct3d->media_op_sanitize = g_malloc0(sizeof(struct CXLSanitizeInfo) +
+                                  (dpa_range_count *
+                                  sizeof(struct dpa_range_list_entry)));
+
+    if (ct3d->media_op_sanitize) {
+        ct3d->media_op_sanitize->dpa_range_count = dpa_range_count;
+        ct3d->media_op_sanitize->fill_value = fill_value;
+        memcpy(ct3d->media_op_sanitize->dpa_range_list,
+                  media_op_in_sanitize_pl->dpa_range_list,
+                  (dpa_range_count *
+                  sizeof(struct dpa_range_list_entry)));
+        secs = get_sanitize_duration(total_mem >> 20);
+    }
+
+    /* EBUSY other bg cmds as of now */
+    cci->bg.runtime = secs * 1000UL;
+    *len_out = 0;
+    /*
+     * media op sanitize is targeted so no need to disable media or
+     * clear event logs
+     */
+    return CXL_MBOX_BG_STARTED;
+}
+
 static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
                                        uint8_t *payload_in,
                                        size_t len_in,
@@ -1836,6 +2024,7 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
         uint8_t rsvd[2];
         uint32_t dpa_range_count;
     } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     uint8_t media_op_cl = 0;
     uint8_t media_op_subclass = 0;
 
@@ -1853,7 +2042,20 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
         }
 
         return media_operations_discovery(payload_in, len_in, payload_out,
-                                             len_out);
+                                          len_out);
+    case MEDIA_OP_CLASS_SANITIZE:
+        switch (media_op_subclass) {
+        case MEDIA_OP_SAN_SUBC_SANITIZE:
+            return media_operations_sanitize(ct3d, payload_in, len_in,
+                                             payload_out, len_out, 0xF,
+                                             cci);
+        case MEDIA_OP_SAN_SUBC_ZERO:
+            return media_operations_sanitize(ct3d, payload_in, len_in,
+                                             payload_out, len_out, 0,
+                                             cci);
+        default:
+            return CXL_MBOX_UNSUPPORTED;
+        }
     default:
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -3170,6 +3372,12 @@ static void bg_timercb(void *opaque)
             cxl_dev_enable_media(&ct3d->cxl_dstate);
         }
         break;
+        case 0x4402: /* Media Operations sanitize */
+        {
+            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+            __do_sanitize(ct3d);
+        }
+        break;
         case 0x4304: /* scan media */
         {
             CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a64739be25..3c5711249b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -581,6 +581,8 @@ typedef struct CXLSetFeatureInfo {
     size_t data_size;
 } CXLSetFeatureInfo;
 
+struct CXLSanitizeInfo;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -651,6 +653,8 @@ struct CXLType3Dev {
         uint8_t num_regions; /* 0-8 regions */
         CXLDCRegion regions[DCD_MAX_NUM_REGION];
     } dc;
+
+    struct CXLSanitizeInfo *media_op_sanitize;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
-- 
2.34.1

