Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF94C00140
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Aug 2022 12:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbiHHMV6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 Aug 2022 08:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbiHHMV5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 Aug 2022 08:21:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB66A64CB
        for <linux-cxl@vger.kernel.org>; Mon,  8 Aug 2022 05:21:56 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M1Zvs3YTCz67NKZ;
        Mon,  8 Aug 2022 20:17:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 8 Aug 2022 14:21:54 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 8 Aug 2022 13:21:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/2] hw/cxl: Fix wrong query of target ports
Date:   Mon, 8 Aug 2022 13:20:51 +0100
Message-ID: <20220808122051.14822-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220808122051.14822-1-Jonathan.Cameron@huawei.com>
References: <20220808122051.14822-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Two issues were present in this code:
1) Check on which register to look in was inverted.
2) Both branches use the _LO register.

Whilst here moved to extract32() rather than hand rolling
the field extraction as simpler and hopefully less error prone.

Fixes Coverity CID: 1488873

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-host.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index faa68ef038..1adf61231a 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -104,7 +104,6 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
     uint32_t ctrl;
     uint32_t ig_enc;
     uint32_t iw_enc;
-    uint32_t target_reg;
     uint32_t target_idx;
 
     ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL];
@@ -116,14 +115,13 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
     iw_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
     target_idx = (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
 
-    if (target_idx > 4) {
-        target_reg = cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_LO];
-        target_reg >>= target_idx * 8;
+    if (target_idx < 4) {
+        *target = extract32(cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_LO],
+                            target_idx * 8, 8);
     } else {
-        target_reg = cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_LO];
-        target_reg >>= (target_idx - 4) * 8;
+        *target = extract32(cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_HI],
+                            (target_idx - 4) * 8, 8);
     }
-    *target = target_reg & 0xff;
 
     return true;
 }
-- 
2.32.0

