Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A16C83F2C
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Sep 2023 16:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbjIDQrl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Sep 2023 12:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbjIDQrl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Sep 2023 12:47:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB29199
        for <linux-cxl@vger.kernel.org>; Mon,  4 Sep 2023 09:47:38 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfZK55Vgjz6D95m;
        Tue,  5 Sep 2023 00:46:17 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 17:47:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     Dave Jiang <dave.jiang@intel.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        <linuxarm@huawei.com>
Subject: [PATCH 1/2] hw/cxl: Add utility functions decoder interleave ways and target count.
Date:   Mon, 4 Sep 2023 17:47:03 +0100
Message-ID: <20230904164704.18739-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
References: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

As an encoded version of these key configuration parameters is
a register, provide functions to extract it again so as to avoid
the need for duplicating the storage.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_component.h | 14 ++++++++++++++
 hw/cxl/cxl-component-utils.c   | 17 +++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 42c7e581a7..f0ad9cf7de 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -238,7 +238,21 @@ static inline int cxl_decoder_count_enc(int count)
     return 0;
 }
 
+static inline int cxl_decoder_count_dec(int enc_cnt)
+{
+    switch (enc_cnt) {
+    case 0: return 1;
+    case 1: return 2;
+    case 2: return 4;
+    case 3: return 6;
+    case 4: return 8;
+    case 5: return 10;
+    }
+    return 0;
+}
+
 uint8_t cxl_interleave_ways_enc(int iw, Error **errp);
+int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp);
 uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp);
 
 static inline hwaddr cxl_decode_ig(int ig)
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 378f1082ce..e96398e8af 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -392,6 +392,23 @@ uint8_t cxl_interleave_ways_enc(int iw, Error **errp)
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

