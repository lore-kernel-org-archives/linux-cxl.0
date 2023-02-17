Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6A1C05027
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 17:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjBQRc0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 12:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjBQRcY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 12:32:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02E371186
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 09:32:21 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PJJfq6FX8z6J6QX;
        Sat, 18 Feb 2023 01:27:47 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Feb 2023 17:32:19 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v4 6/8] hw/cxl: Fix endian issues in CXL RAS capability defaults / masks
Date:   Fri, 17 Feb 2023 17:29:22 +0000
Message-ID: <20230217172924.25239-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230217172924.25239-1-Jonathan.Cameron@huawei.com>
References: <20230217172924.25239-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

As these are about to be modified, fix the endian handle for
this set of registers rather than making it worse.

Note that CXL is currently only supported in QEMU on
x86 (arm64 patches out of tree) so we aren't going to yet hit
an problems with big endian. However it is good to avoid making
things worse for that support in the future.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-component-utils.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 3edd303a33..737b4764b9 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -141,17 +141,17 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
      * Error status is RW1C but given bits are not yet set, it can
      * be handled as RO.
      */
-    reg_state[R_CXL_RAS_UNC_ERR_STATUS] = 0;
+    stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_STATUS, 0);
     /* Bits 12-13 and 17-31 reserved in CXL 2.0 */
-    reg_state[R_CXL_RAS_UNC_ERR_MASK] = 0x1cfff;
-    write_msk[R_CXL_RAS_UNC_ERR_MASK] = 0x1cfff;
-    reg_state[R_CXL_RAS_UNC_ERR_SEVERITY] = 0x1cfff;
-    write_msk[R_CXL_RAS_UNC_ERR_SEVERITY] = 0x1cfff;
-    reg_state[R_CXL_RAS_COR_ERR_STATUS] = 0;
-    reg_state[R_CXL_RAS_COR_ERR_MASK] = 0x7f;
-    write_msk[R_CXL_RAS_COR_ERR_MASK] = 0x7f;
+    stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_MASK, 0x1cfff);
+    stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_MASK, 0x1cfff);
+    stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_SEVERITY, 0x1cfff);
+    stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_SEVERITY, 0x1cfff);
+    stl_le_p(reg_state + R_CXL_RAS_COR_ERR_STATUS, 0);
+    stl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK, 0x7f);
+    stl_le_p(write_msk + R_CXL_RAS_COR_ERR_MASK, 0x7f);
     /* CXL switches and devices must set */
-    reg_state[R_CXL_RAS_ERR_CAP_CTRL] = 0x00;
+    stl_le_p(reg_state + R_CXL_RAS_ERR_CAP_CTRL, 0x00);
 }
 
 static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
-- 
2.37.2

