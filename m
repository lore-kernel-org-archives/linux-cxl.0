Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8135AEDEC50
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 13:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240877AbjIMN0f (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Sep 2023 09:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240915AbjIMN0b (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Sep 2023 09:26:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD4B19B6
        for <linux-cxl@vger.kernel.org>; Wed, 13 Sep 2023 06:26:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rm1Ly2SPPz6D9BV;
        Wed, 13 Sep 2023 21:21:46 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 13 Sep 2023 14:26:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        <linux-cxl@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH v4 2/4] hw/cxl: Add utility functions decoder interleave ways and target count.
Date:   Wed, 13 Sep 2023 14:25:21 +0100
Message-ID: <20230913132523.29780-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913132523.29780-1-Jonathan.Cameron@huawei.com>
References: <20230913132523.29780-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

Add a spec reference for cxl_interleave_ways_enc() for consistency
with the target count equivalent (and because it's nice to know where
the magic numbers come from).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v4: Add specification reference for cxl_interleave_ways_enc() as
    suggested by Fan.
---
 include/hw/cxl/cxl_component.h |  2 ++
 hw/cxl/cxl-component-utils.c   | 60 ++++++++++++++++++++++++++++++----
 2 files changed, 56 insertions(+), 6 deletions(-)

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
index ea2d4770ec..5f38f2016f 100644
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
@@ -393,6 +423,7 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
     cxl->dvsec_offset += length;
 }
 
+/* CXL r3.0 Section 8.2.4.19.7 CXL HDM Decoder n Control Register */
 uint8_t cxl_interleave_ways_enc(int iw, Error **errp)
 {
     switch (iw) {
@@ -410,6 +441,23 @@ uint8_t cxl_interleave_ways_enc(int iw, Error **errp)
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

