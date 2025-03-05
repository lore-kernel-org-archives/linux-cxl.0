Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61A92045B0
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166861; cv=none; b=Qas6nCygrcxTdC+eYRaYh3D5jhQ3as4GA/wpdRhD0z/fFuW7nyQR5w8a+VCvm5fWz7Da6eDF8q8XRtHz/ni3CMqg6HuM7OA/NY56Qz559gc9I1uvCsLLWTmhyIpu13Ym8zDQSOwJ7pXCVnkqNMJlqoh06ZwQPMjaQX9P1SeHnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166861; c=relaxed/simple;
	bh=ND0b/ZBQxo53Kjtw9exCuEcClic3EfG6U4M0S/JMybE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTUklgx1zIXUUefqz0dnyOCaMp7r268b4ic6poHN+o0AyLzj0G0mVuUzBg4qi2uHAl1KwZeKn3/1ZF0fY427Q8qMxd98S4Ll0IfWTEbizbOre5zU1GV1efS0X9qKJ1S6FIRLISNKnX8adlreNV7yhREZEKPTAX2fjWD1JJv9VB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z76Zc5FzDz6M4lD;
	Wed,  5 Mar 2025 17:24:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B55C11400D7;
	Wed,  5 Mar 2025 17:27:37 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 10:27:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, <fan.ni@samsung.com>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Arpit Kumar <arpit1.kumar@samsung.com>,
	Sweta Kumari <s5.kumari@samsung.com>, Vinayak Holikatti
	<vinayak.kh@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Ajay Joshi
	<ajay.opensrc@micron.com>
Subject: [PATCH qemu 5/8] hw/cxl/cxl-mailbox-utils: Media operations Sanitize and Write Zeros commands CXL r3.2(8.2.10.9.5.3)
Date: Wed, 5 Mar 2025 09:24:56 +0000
Message-ID: <20250305092501.191929-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Vinayak Holikatti <vinayak.kh@samsung.com>

CXL spec 3.2 section 8.2.10.9.5.3 describes media operations commands.
CXL devices supports media operations Sanitize and Write zero command.

Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |   4 +
 hw/cxl/cxl-mailbox-utils.c  | 204 ++++++++++++++++++++++++++++++++++++
 2 files changed, 208 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index d21695507f..3ec7be3809 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -540,6 +540,8 @@ typedef struct CXLSetFeatureInfo {
     size_t data_size;
 } CXLSetFeatureInfo;
 
+struct CXLSanitizeInfo;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -606,6 +608,8 @@ struct CXLType3Dev {
         uint8_t num_regions; /* 0-8 regions */
         CXLDCRegion regions[DCD_MAX_NUM_REGION];
     } dc;
+
+    struct CXLSanitizeInfo *media_op_sanitize;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9f9d475678..2c6db70e5f 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1715,6 +1715,131 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
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
+    MemTxAttrs mem_attrs = {};
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
+    int rc = 0;
+    int i;
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
@@ -1799,6 +1924,65 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
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
+        struct dpa_range_list_entry dpa_range_list[];
+    } QEMU_PACKED *media_op_in_sanitize_pl = (void *)payload_in;
+    uint32_t dpa_range_count = media_op_in_sanitize_pl->dpa_range_count;
+    uint64_t total_mem = 0;
+    size_t dpa_range_list_size;
+    int secs = 0, i;
+
+    if (dpa_range_count == 0) {
+        return CXL_MBOX_SUCCESS;
+    }
+
+    dpa_range_list_size = dpa_range_count * sizeof(struct dpa_range_list_entry);
+    if (len_in < (sizeof(*media_op_in_sanitize_pl) + dpa_range_list_size)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    for (i = 0; i < dpa_range_count; i++) {
+        uint64_t start_dpa =
+            media_op_in_sanitize_pl->dpa_range_list[i].starting_dpa;
+        uint64_t length = media_op_in_sanitize_pl->dpa_range_list[i].length;
+
+        if (validate_dpa_addr(ct3d, start_dpa, length)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        total_mem += length;
+    }
+    ct3d->media_op_sanitize = g_malloc0(sizeof(struct CXLSanitizeInfo) +
+                                        dpa_range_list_size);
+
+    ct3d->media_op_sanitize->dpa_range_count = dpa_range_count;
+    ct3d->media_op_sanitize->fill_value = fill_value;
+    memcpy(ct3d->media_op_sanitize->dpa_range_list,
+           media_op_in_sanitize_pl->dpa_range_list,
+           dpa_range_list_size);
+    secs = get_sanitize_duration(total_mem >> 20);
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
@@ -1812,6 +1996,7 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
         uint8_t rsvd[2];
         uint32_t dpa_range_count;
     } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     uint8_t media_op_cl = 0;
     uint8_t media_op_subclass = 0;
 
@@ -1830,6 +2015,19 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
 
         return media_operations_discovery(payload_in, len_in, payload_out,
                                              len_out);
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
@@ -3147,6 +3345,12 @@ static void bg_timercb(void *opaque)
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
-- 
2.43.0

