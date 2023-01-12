Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EFEC54EBC
	for <linux-cxl@archiver.kernel.org>; Thu, 12 Jan 2023 10:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjALKem (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 Jan 2023 05:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbjALKeG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 Jan 2023 05:34:06 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B128DF7D
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jan 2023 02:28:48 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nt0zb6Z4Jz6J75t;
        Thu, 12 Jan 2023 18:24:59 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 12 Jan 2023 10:28:46 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/8] hw/cxl: Add CXL_CAPACITY_MULTIPLIER definition
Date:   Thu, 12 Jan 2023 10:26:40 +0000
Message-ID: <20230112102644.27830-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230112102644.27830-1-Jonathan.Cameron@huawei.com>
References: <20230112102644.27830-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Gregory Price <gourry.memverge@gmail.com>

Remove usage of magic numbers when accessing capacity fields and replace
with CXL_CAPACITY_MULTIPLIER, matching the kernel definition.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2:
Change to 256 * MiB and include qemu/units.h (Philippe Mathieu-Daudé)

 hw/cxl/cxl-mailbox-utils.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index bc1bb18844..3f67b665f5 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -12,8 +12,11 @@
 #include "hw/pci/pci.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
+#include "qemu/units.h"
 #include "qemu/uuid.h"
 
+#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
+
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
  *  1. Add the command set and cmd to the enum.
@@ -138,7 +141,7 @@ static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
     } QEMU_PACKED *fw_info;
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
 
-    if (cxl_dstate->pmem_size < (256 << 20)) {
+    if (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -283,7 +286,7 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint64_t size = cxl_dstate->pmem_size;
 
-    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
+    if (!QEMU_IS_ALIGNED(size, CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -293,8 +296,8 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
     /* PMEM only */
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
-    id->total_capacity = size / (256 << 20);
-    id->persistent_capacity = size / (256 << 20);
+    id->total_capacity = size / CXL_CAPACITY_MULTIPLIER;
+    id->persistent_capacity = size / CXL_CAPACITY_MULTIPLIER;
     id->lsa_size = cvc->get_lsa_size(ct3d);
 
     *len = sizeof(*id);
@@ -314,14 +317,14 @@ static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
     QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
     uint64_t size = cxl_dstate->pmem_size;
 
-    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
+    if (!QEMU_IS_ALIGNED(size, CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
     /* PMEM only */
     part_info->active_vmem = 0;
     part_info->next_vmem = 0;
-    part_info->active_pmem = size / (256 << 20);
+    part_info->active_pmem = size / CXL_CAPACITY_MULTIPLIER;
     part_info->next_pmem = 0;
 
     *len = sizeof(*part_info);
-- 
2.37.2

