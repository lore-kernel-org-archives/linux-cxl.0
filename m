Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C088C25B08
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Aug 2022 14:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiHQO6f (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Aug 2022 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHQO6e (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 Aug 2022 10:58:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A479E2D1E0
        for <linux-cxl@vger.kernel.org>; Wed, 17 Aug 2022 07:58:33 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M7B3G11lSz67bZ4;
        Wed, 17 Aug 2022 22:58:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 16:58:31 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 15:58:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/3] hw/cxl: Add stub write function for RO MemoryRegionOps entries.
Date:   Wed, 17 Aug 2022 15:57:57 +0100
Message-ID: <20220817145759.32603-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220817145759.32603-1-Jonathan.Cameron@huawei.com>
References: <20220817145759.32603-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

There is no checking on the availability of a write callback.
Hence QEMU crashes if a write does occur to one of these regions.

Discovered whilst chasing a Linux kernel bug that incorrectly
wrote into one of these regions.

Fixes: 6364adacdf ("hw/cxl/device: Implement the CAP array (8.2.8.1-2)")
Reported-by: Bobo WL <lmw.bobo@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-device-utils.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 687759b301..83ce7a8270 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -141,9 +141,15 @@ static uint64_t mdev_reg_read(void *opaque, hwaddr offset, unsigned size)
     return retval;
 }
 
+static void ro_reg_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    /* Many register sets are read only */
+}
+
 static const MemoryRegionOps mdev_ops = {
     .read = mdev_reg_read,
-    .write = NULL, /* memory device register is read only */
+    .write = ro_reg_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
@@ -173,7 +179,7 @@ static const MemoryRegionOps mailbox_ops = {
 
 static const MemoryRegionOps dev_ops = {
     .read = dev_reg_read,
-    .write = NULL, /* status register is read only */
+    .write = ro_reg_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
@@ -188,7 +194,7 @@ static const MemoryRegionOps dev_ops = {
 
 static const MemoryRegionOps caps_ops = {
     .read = caps_reg_read,
-    .write = NULL, /* caps registers are read only */
+    .write = ro_reg_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
-- 
2.32.0

