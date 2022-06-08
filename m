Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CB3C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Jun 2022 13:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbiFHNIP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Jun 2022 09:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239925AbiFHNIO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Jun 2022 09:08:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D37D250E5E
        for <linux-cxl@vger.kernel.org>; Wed,  8 Jun 2022 06:08:10 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJ6py3wWJz67lbv;
        Wed,  8 Jun 2022 21:03:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 15:08:07 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 14:08:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v4] hw/cxl: Fix missing write mask for HDM decoder target list registers
Date:   Wed, 8 Jun 2022 14:08:04 +0100
Message-ID: <20220608130804.25795-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Without being able to write these registers, no interleaving is possible.
More refined checks of HDM register state on commit to follow.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Widawsky <ben@bwidawsk.net>
---
v4: (Ben Widawsky review responses - thanks!)
 - Expand list of matched types for 'skip' usages (with more restrictive
   write mask) to include all CXL device types (type 3, type 1/2 and LD).
   We only emulate type 3 so far but good for the function implementation
   to be correct for the other types.
 - Added Ben's RB.
 
 hw/cxl/cxl-component-utils.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 7985c9bfca..3edd303a33 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -154,7 +154,8 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
     reg_state[R_CXL_RAS_ERR_CAP_CTRL] = 0x00;
 }
 
-static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk)
+static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
+                            enum reg_type type)
 {
     int decoder_count = 1;
     int i;
@@ -174,6 +175,14 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk)
         write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20] = 0xf0000000;
         write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20] = 0xffffffff;
         write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] = 0x13ff;
+        if (type == CXL2_DEVICE ||
+            type == CXL2_TYPE3_DEVICE ||
+            type == CXL2_LOGICAL_DEVICE) {
+            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xf0000000;
+        } else {
+            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xffffffff;
+        }
+        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20] = 0xffffffff;
     }
 }
 
@@ -239,7 +248,7 @@ void cxl_component_register_init_common(uint32_t *reg_state, uint32_t *write_msk
     }
 
     init_cap_reg(HDM, 5, 1);
-    hdm_init_common(reg_state, write_msk);
+    hdm_init_common(reg_state, write_msk, type);
 
     if (caps < 5) {
         return;
-- 
2.32.0

