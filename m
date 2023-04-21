Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41365C7618E
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 16:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjDUQJg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjDUQJ3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 12:09:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27E114460
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 09:09:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2zt16Z0zz6J6hF;
        Sat, 22 Apr 2023 00:06:33 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:09:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>
CC:     Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH v5 2/3] hw/mem: Use memory_region_size() in cxl_type3
Date:   Fri, 21 Apr 2023 17:08:26 +0100
Message-ID: <20230421160827.2227-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230421160827.2227-1-Jonathan.Cameron@huawei.com>
References: <20230421160827.2227-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Accessors prefered over direct use of int128_get64() as they
clamp out of range values.  None are expected here but
cleaner to always use the accessor than mix and match.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v5: New patch to tidy up existing instance before adding more of
    them.
  - Use memory_region_size() to access the size of memory regions.
    We may eventually need to allow for larger addresses but it
    is unlikely to be a problem any time soon.
---
 hw/mem/cxl_type3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 1bd5963a3f..2db756851c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -52,7 +52,7 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
         .DSMADhandle = dsmad_handle,
         .flags = CDAT_DSMAS_FLAG_NV,
         .DPA_base = 0,
-        .DPA_length = int128_get64(mr->size),
+        .DPA_length = memory_region_size(mr),
     };
 
     /* For now, no memory side cache, plausiblish numbers */
@@ -133,7 +133,7 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
         /* Reserved - the non volatile from DSMAS matters */
         .EFI_memory_type_attr = 2,
         .DPA_offset = 0,
-        .DPA_length = int128_get64(mr->size),
+        .DPA_length = memory_region_size(mr),
     };
 
     /* Header always at start of structure */
@@ -698,7 +698,7 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
         return MEMTX_ERROR;
     }
 
-    if (dpa_offset > int128_get64(mr->size)) {
+    if (dpa_offset > memory_region_size(mr)) {
         return MEMTX_ERROR;
     }
 
@@ -721,7 +721,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
         return MEMTX_OK;
     }
 
-    if (dpa_offset > int128_get64(mr->size)) {
+    if (dpa_offset > memory_region_size(mr)) {
         return MEMTX_OK;
     }
     return address_space_write(&ct3d->hostmem_as, dpa_offset, attrs,
-- 
2.37.2

