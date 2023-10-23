Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D481B26B
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42C010C1
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 07:03:13 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDcJ74pK2z67DRW;
	Mon, 23 Oct 2023 21:59:35 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 15:03:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
	<mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 2/5] hw/cxl: Use switch statements for read and write of cachemem registers
Date: Mon, 23 Oct 2023 15:02:07 +0100
Message-ID: <20231023140210.3089-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023140210.3089-1-Jonathan.Cameron@huawei.com>
References: <20231023140210.3089-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

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
v5: _Static_assert() is a declaration in C, so may not follow
    a label. Hence wrap it in {} to ensure it doesn't.
    Issue seen with clang builds (and in some cases at least older
    GCC).
    We can't wrap it in {} in the QEMU_BUILD_BUG_ON() define as that
    is used in a few places outside of functions.

hw/cxl/cxl-component-utils.c | 66 +++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index f3bbf0fd13..9d4f4bc8d4 100644
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
 
@@ -117,25 +125,37 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
     ComponentRegisters *cregs = &cxl_cstate->crb;
     uint32_t mask;
 
-    if (size == 8) {
-        qemu_log_mask(LOG_UNIMP,
-                      "CXL 8 byte cache mem registers not implemented\n");
+    switch (size) {
+    case 4: {
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
         return;
     }
-    mask = cregs->cache_mem_regs_write_mask[offset / sizeof(*cregs->cache_mem_regs_write_mask)];
-    value &= mask;
-    /* RO bits should remain constant. Done by reading existing value */
-    value |= ~mask & cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
-    if (cregs->special_ops && cregs->special_ops->write) {
-        cregs->special_ops->write(cxl_cstate, offset, value, size);
+    case 8:
+        qemu_log_mask(LOG_UNIMP,
+                      "CXL 8 byte cache mem registers not implemented\n");
         return;
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

