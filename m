Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E320B20B
	for <linux-cxl@vger.kernel.org>; Fri, 14 Feb 2025 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525760; cv=none; b=jtNFSuyXXJi2KpEcph76EJMdGNxkmdoG5Md4whDvs/I0aabp3Al346wMTUf5T7DKYd8DT900RpO1HlWflvFsUudCC6whpIas6TRAhblc7ARbDC/sC2IfFdN8bjwb2u4tFAl5g44CyGWTZnw9VbtWL19Udr4F0JvFXet0R3xz5eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525760; c=relaxed/simple;
	bh=6+ZzGC376dH2gCa0QIpRG7enq/QZwFBJJuu7uyWMZcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=qRbPVEvWrujeRHVJWi83R2m9B2S9dqsfoxkWexYP8mD03MKyDWnqowp9RoLUg4i0r+3NMY4+sWuk6lQUFw02Q12vyhITgA9LzSRouUyiQUVmYz4NHzUmrZextf5lPUO5kqxvlJzOE5xVgZnoI0v5rCI/UotC/ivdOwvc38pj5yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZXnfyRLt; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZXnfyRLt"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250214093556epoutp0439f02685560a3a9970bf20fd3cac6c97~kCXVy7o5t2711427114epoutp04V
	for <linux-cxl@vger.kernel.org>; Fri, 14 Feb 2025 09:35:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250214093556epoutp0439f02685560a3a9970bf20fd3cac6c97~kCXVy7o5t2711427114epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739525756;
	bh=Vc97jgJbEviaDj/yLkE6JZXsHnH63oK5DVgY2B1eEi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZXnfyRLt0q+LWJKVFEnBMGGh6e0ploPubRu3RbTx8kYPgg6ozR7sID/EGk8HPe+Ky
	 46vINlCUM10cp+VO6P5P6y3M8rrgLzjnUkDeAtiNIXpXwZeq1g7x5I4js/tpULKNZm
	 2Q9CIstPjbfCdP8gJIkwXaasepz31F5K4DpmDiT0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250214093555epcas5p3fbde7fd7f0983c29a6efadc643d594d8~kCXVcxxbx0837108371epcas5p3B;
	Fri, 14 Feb 2025 09:35:55 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YvRkK6KjHz4x9Pw; Fri, 14 Feb
	2025 09:35:53 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4F.CA.29212.97E0FA76; Fri, 14 Feb 2025 18:35:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250213091632epcas5p2726909f864b50cc2d1b7ceb2415698c2~judIOkc5M2873628736epcas5p2H;
	Thu, 13 Feb 2025 09:16:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250213091632epsmtrp1e5710ca8428766a8f316e7aefd770d66~judIN1gbd2265722657epsmtrp1X;
	Thu, 13 Feb 2025 09:16:32 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-dc-67af0e79aa48
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	41.74.18949.078BDA76; Thu, 13 Feb 2025 18:16:32 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250213091631epsmtip1bf345230d70212fb28cf55d27cd81da2~judGyghYr2196821968epsmtip1T;
	Thu, 13 Feb 2025 09:16:31 +0000 (GMT)
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Vinayak Holikatti
	<vinayak.kh@samsung.com>
Subject: [PATCH v2 3/3] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations Sanitize and Write Zeros commands (8.2.9.9.5.3)
Date: Thu, 13 Feb 2025 14:45:58 +0530
Message-Id: <20250213091558.2294806-4-vinayak.kh@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213091558.2294806-1-vinayak.kh@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmum4l3/p0g8dTDCymH1a0+HJ6D5vF
	6ptrGC1uHtjJZLFw4zImi/OzTrFY/N22l9HieO8OFosTJ7ezA8XmsDtweeycdZfd48m1zUwe
	fVtWMXpMnV3v8XmTXABrVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
	qq2Si0+ArltmDtBNSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8
	dL281BIrQwMDI1OgwoTsjKs31rIXvA2oePLhB3sD41yzLkYODgkBE4nlWwq7GDk5hAT2MEpc
	OVXbxcgFZH9ilHiw5y4bhPONUeLP5TtsIFUgDUem3GOESOxllPh5oo8Zwmlgknh18TMjSBWb
	gIHEg+bj7CC2iICkxO+u08wgNrPAB0aJRU91QRqEBVoYJS7+OgaWYBFQldj34SETiM0rYCvR
	cfUa1Dp5if0HzzKD3MopYCcx7WU2RImgxMmZT1ggZspLNG+dDXaEhMBfdolpa45C9bpILLvW
	DWULS7w6voUdwpaSeNnfBmUXS5y7+IkRwq6ReN21ghnCtpdoPdUPtpdZQFNi/S59iLCsxNRT
	65gg9vJJ9P5+wgQR55XYMQ/EBgWpisTSt5kwm748a2aECHtInLpXAgmqicBw23CWeQKjwiwk
	38xC8s0shMULGJlXMUqlFhTnpqcmmxYY6uallsPjODk/dxMjOJVqBexgXL3hr94hRiYOxkOM
	EhzMSiK8wMBIF+JNSaysSi3Kjy8qzUktPsRoCgzuicxSosn5wGSeVxJvaGJpYGJmZmZiaWxm
	qCTO27yzJV1IID2xJDU7NbUgtQimj4mDU6qBSam7vru2+XTLPt8/T8zXGjkZOTJXL7HIU97w
	LpLJpvNbZPGtxsuHRXZUR+em6tb++XRkxdz+m7a+i2piHeMTt3Vb7lhg8MBoicyrAzfrdmQu
	5U3O85mxbMZpe4PAis45znKl79nfqX1UXdgW0HQ+NbFu7+UeiZpL7+8sFprs8dFk2o7ljxyT
	/n05EWsm3v72pu/KQ5VtjX81U+Teh/RY9WrEvZofKf7p4OSOu43lt6czznTYeIVPm7N1VpCG
	6DYDLt053278WbTdOmi96d66N4Vbz13veP5nGmNF8dLZyw/FHf7xeKYt+/6F1y4cUNBIMo8q
	61x73/L4MoVTf+R6n+prMMqb1Jhnb2G7xMv0SYmlOCPRUIu5qDgRAEU6Sg0uBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSnG7BjrXpBsu2GVtMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBYnTm5nB4rNYXfg8tg56y67x5Nrm5k8
	+rasYvSYOrve4/MmuQDWKC6blNSczLLUIn27BK6MqzfWshe8Dah48uEHewPjXLMuRk4OCQET
	iSNT7jF2MXJxCAnsZpQ4/XcNG0RCSuLYzp9QtrDEyn/P2SGK/jFKfDw1CSzBJmAg8aD5ODuI
	LSIgKfG76zQzSBGzwC9Giae774N1CAs0MUqsWfSFCaSKRUBVYt+Hh2A2r4CtRMfVa1Ar5CX2
	HzwL1M3BwSlgJzHtZTZIWAioZHfnNahyQYmTM5+wgNjMQOXNW2czT2AUmIUkNQtJagEj0ypG
	ydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOCQ19Lawbhn1Qe9Q4xMHIyHGCU4mJVEeCWm
	rUkX4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvvtdW+KkEB6YklqdmpqQWoRTJaJg1OqgWnSTYuf
	rGfWm0wNCJvQZxtzM35abNzsGZs5BNtni8+9KqYsNdOf8XXxPOWv1uf35ga1/8o/y//7Tdfk
	Qxl20+fs+rLz6Qa2OPmsA8d33pr5Qv8d+7vtfH8d7KMYbv11W6m24emkN5xtdmUf532+cNPf
	uzhv75T2xOXG2ZVHvfJnGd7vP/prQdFlhQ1HOzcphhomdi4xd60L/WCc3BjTvff9W/dZm3/3
	fph5+/m91c4pPIrxz1y6T6/q/vDi8JGmv1frzoUGnNh7o3Rxxsp3p9Itd0gtDFy5t/r/vLdL
	b3LE6RWt578pNdPbftO6E2n+f272yEU+SG2/kio9pesIT1D+fsVfUlPeJM3X3stzRs3tgBJL
	cUaioRZzUXEiAKYhZ0boAgAA
X-CMS-MailID: 20250213091632epcas5p2726909f864b50cc2d1b7ceb2415698c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250213091632epcas5p2726909f864b50cc2d1b7ceb2415698c2
References: <20250213091558.2294806-1-vinayak.kh@samsung.com>
	<CGME20250213091632epcas5p2726909f864b50cc2d1b7ceb2415698c2@epcas5p2.samsung.com>

CXL spec 3.1 section 8.2.9.9.5.3 describes media operations commands.
CXL devices supports media operations Sanitize and Write zero command.

Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 217 +++++++++++++++++++++++++++++++++++-
 include/hw/cxl/cxl_device.h |   4 +
 2 files changed, 216 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d58c20842f..2d8d1171b4 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1732,6 +1732,130 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
 }
 
 #define CXL_CACHELINE_SIZE 64
+struct CXLSanitizeInfo {
+    uint32_t dpa_range_count;
+    uint8_t fill_value;
+    struct {
+            uint64_t starting_dpa;
+            uint64_t length;
+    } dpa_range_list[];
+};
+
+struct dpa_range_list_entry {
+    uint64_t starting_dpa;
+    uint64_t length;
+};
+
+static uint64_t get_vmr_size(CXLType3Dev *ct3d, MemoryRegion **vmr)
+{
+    uint64_t vmr_size = 0;
+    if (ct3d->hostvmem) {
+        *vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+        vmr_size = memory_region_size(*vmr);
+    }
+    return vmr_size;
+}
+
+static uint64_t get_pmr_size(CXLType3Dev *ct3d, MemoryRegion **pmr)
+{
+    uint64_t pmr_size = 0;
+    if (ct3d->hostpmem) {
+        *pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+        pmr_size = memory_region_size(*pmr);
+    }
+    return pmr_size;
+}
+
+static uint64_t get_dc_size(CXLType3Dev *ct3d, MemoryRegion **dc_mr)
+{
+    uint64_t dc_size = 0;
+    if (ct3d->dc.host_dc) {
+        *dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        dc_size = memory_region_size(*dc_mr);
+    }
+    return dc_size;
+}
+
+static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
+                             size_t length)
+{
+    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
+    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
+
+    if ((dpa_addr % CXL_CACHELINE_SIZE) ||
+         (length % CXL_CACHELINE_SIZE)  ||
+         (length <= 0)) {
+        return -EINVAL;
+    }
+
+    vmr_size = get_vmr_size(ct3d, &vmr);
+    pmr_size = get_pmr_size(ct3d, &pmr);
+    dc_size = get_dc_size(ct3d, &dc_mr);
+
+    if (!vmr && !pmr && !dc_mr) {
+        return -ENODEV;
+    }
+
+    if ((dpa_addr + length) > vmr_size + pmr_size + dc_size) {
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
+    MemoryRegion *vmr = NULL, *pmr = NULL;
+    uint64_t vmr_size = 0, pmr_size = 0;
+    AddressSpace *as = NULL;
+    MemTxAttrs mem_attrs = {0};
+
+    vmr_size = get_vmr_size(ct3d, &vmr);
+    pmr_size = get_pmr_size(ct3d, &pmr);
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
+    return address_space_set(as, dpa_addr,
+                              fill_value, length, mem_attrs);
+}
+
+/* Perform the actual device zeroing */
+static void __do_sanitize(CXLType3Dev *ct3d)
+{
+    struct CXLSanitizeInfo  *san_info = ct3d->media_op_sanitize;
+    int dpa_range_count = san_info->dpa_range_count;
+    int rc = 0;
+
+    for (int i = 0; i < dpa_range_count; i++) {
+        rc = sanitize_range(ct3d, san_info->dpa_range_list[i].starting_dpa,
+                san_info->dpa_range_list[i].length, san_info->fill_value);
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
@@ -1760,9 +1884,9 @@ static const struct media_op_supported_list_entry media_op_matrix[] = {
 };
 
 static CXLRetCode media_operations_discovery(uint8_t *payload_in,
-                                                size_t len_in,
-                                                uint8_t *payload_out,
-                                                size_t *len_out)
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out)
 {
     struct {
         uint8_t media_operation_class;
@@ -1811,6 +1935,66 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
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
+    int secs = 0;
+
+    if (len_in < (sizeof(*media_op_in_sanitize_pl) +
+           (dpa_range_count * sizeof(struct dpa_range_list_entry)))) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    for (int i = 0; i < dpa_range_count; i++) {
+        if (validate_dpa_addr(ct3d,
+            media_op_in_sanitize_pl->dpa_range_list[i].starting_dpa,
+            media_op_in_sanitize_pl->dpa_range_list[i].length)) {
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
+
+}
+
 static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
                                          size_t len_in,
@@ -1825,6 +2009,9 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
         uint32_t dpa_range_count;
     } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
 
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    uint8_t fill_value = 0;
+
     if (len_in < sizeof(*media_op_in_common_pl)) {
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
@@ -1851,15 +2038,29 @@ static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
         return media_operations_discovery(payload_in, len_in, payload_out,
                                              len_out);
     case MEDIA_OP_CLASS_SANITIZE:
+        if (dpa_range_count == 0) {
+            return CXL_MBOX_SUCCESS;
+        }
         switch (media_op_subclass) {
+        case MEDIA_OP_SAN_SUBC_SANITIZE:
+            fill_value = 0xF;
+            return media_operations_sanitize(ct3d, payload_in, len_in,
+                                             payload_out, len_out, fill_value,
+                                             cci);
+            break;
+        case MEDIA_OP_SAN_SUBC_ZERO:
+            fill_value = 0;
+            return media_operations_sanitize(ct3d, payload_in, len_in,
+                                             payload_out, len_out, fill_value,
+                                             cci);
+            break;
         default:
             return CXL_MBOX_UNSUPPORTED;
         }
+        break;
     default:
         return CXL_MBOX_UNSUPPORTED;
     }
-
-    return CXL_MBOX_SUCCESS;
 }
 
 static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
@@ -3173,6 +3374,12 @@ static void bg_timercb(void *opaque)
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
index a64739be25..b391a293a8 100644
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
+    struct CXLSanitizeInfo  *media_op_sanitize;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
-- 
2.34.1

