Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A1EC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Apr 2022 14:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377991AbiD2O5y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Apr 2022 10:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377995AbiD2O5x (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Apr 2022 10:57:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4096C0E6F
        for <linux-cxl@vger.kernel.org>; Fri, 29 Apr 2022 07:54:34 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kqb6N4B80z67J5F;
        Fri, 29 Apr 2022 22:51:40 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 16:54:32 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 15:54:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <k.jensen@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v10 26/45] hw/cxl/component: Add utils for interleave parameter encoding/decoding
Date:   Fri, 29 Apr 2022 15:40:51 +0100
Message-ID: <20220429144110.25167-27-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
References: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Jonathan Cameron <jonathan.cameron@huawei.com>

Both registers and the CFMWS entries in CDAT use simple encodings
for the number of interleave ways and the interleave granularity.
Introduce simple conversion functions to/from the unencoded
number / size.  So far the iw decode has not been needed so is
it not implemented.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/cxl/cxl-component-utils.c   | 34 ++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_component.h |  8 ++++++++
 2 files changed, 42 insertions(+)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index afc97b17c2..69cb07171c 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qapi/error.h"
 #include "hw/pci/pci.h"
 #include "hw/cxl/cxl.h"
 
@@ -329,3 +330,36 @@ void cxl_component_create_dvsec(CXLComponentState *cxl,
     range_init_nofail(&cxl->dvsecs[type], cxl->dvsec_offset, length);
     cxl->dvsec_offset += length;
 }
+
+uint8_t cxl_interleave_ways_enc(int iw, Error **errp)
+{
+    switch (iw) {
+    case 1: return 0x0;
+    case 2: return 0x1;
+    case 4: return 0x2;
+    case 8: return 0x3;
+    case 16: return 0x4;
+    case 3: return 0x8;
+    case 6: return 0x9;
+    case 12: return 0xa;
+    default:
+        error_setg(errp, "Interleave ways: %d not supported", iw);
+        return 0;
+    }
+}
+
+uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp)
+{
+    switch (gran) {
+    case 256: return 0;
+    case 512: return 1;
+    case 1024: return 2;
+    case 2048: return 3;
+    case 4096: return 4;
+    case 8192: return 5;
+    case 16384: return 6;
+    default:
+        error_setg(errp, "Interleave granularity: %" PRIu64 " invalid", gran);
+        return 0;
+    }
+}
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 7d8f395cbe..4f69688c47 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -210,4 +210,12 @@ static inline int cxl_decoder_count_enc(int count)
     return 0;
 }
 
+uint8_t cxl_interleave_ways_enc(int iw, Error **errp);
+uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp);
+
+static inline hwaddr cxl_decode_ig(int ig)
+{
+    return 1 << (ig + 8);
+}
+
 #endif
-- 
2.32.0

