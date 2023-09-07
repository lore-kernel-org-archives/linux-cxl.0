Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FD5EC874D
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Sep 2023 18:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjIGStG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjIGStG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 7 Sep 2023 14:49:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C330CA
        for <linux-cxl@vger.kernel.org>; Thu,  7 Sep 2023 11:49:00 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RhHGv4l1Bz6HJlG;
        Thu,  7 Sep 2023 19:35:19 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 7 Sep 2023 12:36:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 2/3] hw/cxl: Add utility functions decoder interleave ways and target count.
Date:   Thu, 7 Sep 2023 12:35:42 +0100
Message-ID: <20230907113543.19760-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907113543.19760-1-Jonathan.Cameron@huawei.com>
References: <20230907113543.19760-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

As an encoded version of these key configuration parameters is available
in a register, provide functions to extract it again so as to avoid
the need for duplicating the storage.

Whilst here update the _enc() function to include additional values
as defined in the CXL 3.0 specification. Whilst they are not
currently used in the emulation, they may be in future and it is
easier to compare with the specification if all values are covered.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: Thanks to Philippe Mathieu-Daudé
 - Expand both enc() and dec() functions to include full set of values
   defined in CXL r3.0
 - Pushed implementation down into the .c file.
---
 include/hw/cxl/cxl_component.h |  2 ++
 hw/cxl/cxl-component-utils.c   | 59 ++++++++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index bdb3881a6b..ef9e033919 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -226,8 +226,10 @@ void cxl_component_create_dvsec(CXLComponentState *cxl_cstate,
                                 uint16_t type, uint8_t rev, uint8_t *body);
 
 int cxl_decoder_count_enc(int count);
+int cxl_decoder_count_dec(int enc_cnt);
 
 uint8_t cxl_interleave_ways_enc(int iw, Error **errp);
+int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp);
 uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp);
 
 hwaddr cxl_decode_ig(int ig);
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index ea2d4770ec..352d0dace2 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -13,15 +13,45 @@
 #include "hw/pci/pci.h"
 #include "hw/cxl/cxl.h"
 
+/* CXL r3.0 Section 8.2.4.19.1 CXL HDM Decoder Capability Register */
 int cxl_decoder_count_enc(int count)
 {
     switch (count) {
-    case 1: return 0;
-    case 2: return 1;
-    case 4: return 2;
-    case 6: return 3;
-    case 8: return 4;
-    case 10: return 5;
+    case 1: return 0x0;
+    case 2: return 0x1;
+    case 4: return 0x2;
+    case 6: return 0x3;
+    case 8: return 0x4;
+    case 10: return 0x5;
+    /* Switches and Host Bridges may have more than 10 decoders */
+    case 12: return 0x6;
+    case 14: return 0x7;
+    case 16: return 0x8;
+    case 20: return 0x9;
+    case 24: return 0xa;
+    case 28: return 0xb;
+    case 32: return 0xc;
+    }
+    return 0;
+}
+
+int cxl_decoder_count_dec(int enc_cnt)
+{
+    switch (enc_cnt) {
+    case 0x0: return 1;
+    case 0x1: return 2;
+    case 0x2: return 4;
+    case 0x3: return 6;
+    case 0x4: return 8;
+    case 0x5: return 10;
+    /* Switches and Host Bridges may have more than 10 decoders */
+    case 0x6: return 12;
+    case 0x7: return 14;
+    case 0x8: return 16;
+    case 0x9: return 20;
+    case 0xa: return 24;
+    case 0xb: return 28;
+    case 0xc: return 32;
     }
     return 0;
 }
@@ -410,6 +440,23 @@ uint8_t cxl_interleave_ways_enc(int iw, Error **errp)
     }
 }
 
+int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp)
+{
+    switch (iw_enc) {
+    case 0x0: return 1;
+    case 0x1: return 2;
+    case 0x2: return 4;
+    case 0x3: return 8;
+    case 0x4: return 16;
+    case 0x8: return 3;
+    case 0x9: return 6;
+    case 0xa: return 12;
+    default:
+        error_setg(errp, "Encoded interleave ways: %d not supported", iw_enc);
+        return 0;
+    }
+}
+
 uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp)
 {
     switch (gran) {
-- 
2.39.2

