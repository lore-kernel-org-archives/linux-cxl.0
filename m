Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4F02AB35
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8005B8
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 07:06:11 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5rwP6H0Wz6K6mM;
	Thu, 12 Oct 2023 22:04:05 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 12 Oct 2023 15:06:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
	<mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 2/4] hw/cxl: Use switch statements for read and write of cachemem registers
Date: Thu, 12 Oct 2023 15:05:12 +0100
Message-ID: <20231012140514.3697-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012140514.3697-1-Jonathan.Cameron@huawei.com>
References: <20231012140514.3697-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Establishing that only register accesses of size 4 and 8 can occur
using these functions requires looking at their callers. Make it
easier to see that by using switch statements.
Assertions are used to enforce that the register storage is of the
matching size, allowing fixed values to be used for divisors of
the array indices.

Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>

---
v4: Use QEMU_BUILD_BUG_ON() instead of static_assert with missing
    error message.

 hw/cxl/cxl-component-utils.c | 65 +++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index f3bbf0fd13..d1997a52e6 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -67,16 +67,24 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
     CXLComponentState *cxl_cstate = opaque;
     ComponentRegisters *cregs = &cxl_cstate->crb;
 
-    if (size == 8) {
+    switch (size) {
+    case 4:
+        if (cregs->special_ops && cregs->special_ops->read) {
+            return cregs->special_ops->read(cxl_cstate, offset, 4);
+        } else {
+            QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
+            return cregs->cache_mem_registers[offset / 4];
+        }
+    case 8:
         qemu_log_mask(LOG_UNIMP,
                       "CXL 8 byte cache mem registers not implemented\n");
         return 0;
-    }
-
-    if (cregs->special_ops && cregs->special_ops->read) {
-        return cregs->special_ops->read(cxl_cstate, offset, size);
-    } else {
-        return cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
+    default:
+        /*
+         * In line with specifiction limitaions on access sizes, this
+         * routine is not called with other sizes.
+         */
+        g_assert_not_reached();
     }
 }
 
@@ -117,25 +125,36 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
     ComponentRegisters *cregs = &cxl_cstate->crb;
     uint32_t mask;
 
-    if (size == 8) {
+    switch (size) {
+    case 4:
+        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_regs_write_mask) != 4);
+        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
+        mask = cregs->cache_mem_regs_write_mask[offset / 4];
+        value &= mask;
+        /* RO bits should remain constant. Done by reading existing value */
+        value |= ~mask & cregs->cache_mem_registers[offset / 4];
+        if (cregs->special_ops && cregs->special_ops->write) {
+            cregs->special_ops->write(cxl_cstate, offset, value, size);
+            return;
+        }
+
+        if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
+            offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
+            dumb_hdm_handler(cxl_cstate, offset, value);
+        } else {
+            cregs->cache_mem_registers[offset / 4] = value;
+        }
+        return;
+    case 8:
         qemu_log_mask(LOG_UNIMP,
                       "CXL 8 byte cache mem registers not implemented\n");
         return;
-    }
-    mask = cregs->cache_mem_regs_write_mask[offset / sizeof(*cregs->cache_mem_regs_write_mask)];
-    value &= mask;
-    /* RO bits should remain constant. Done by reading existing value */
-    value |= ~mask & cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
-    if (cregs->special_ops && cregs->special_ops->write) {
-        cregs->special_ops->write(cxl_cstate, offset, value, size);
-        return;
-    }
-
-    if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
-        offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
-        dumb_hdm_handler(cxl_cstate, offset, value);
-    } else {
-        cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)] = value;
+    default:
+        /*
+         * In line with specifiction limitaions on access sizes, this
+         * routine is not called with other sizes.
+         */
+        g_assert_not_reached();
     }
 }
 
-- 
2.39.2

