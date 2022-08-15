Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAB8C25B0D
	for <linux-cxl@archiver.kernel.org>; Mon, 15 Aug 2022 15:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiHOPmB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 Aug 2022 11:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiHOPls (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 Aug 2022 11:41:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9489717588
        for <linux-cxl@vger.kernel.org>; Mon, 15 Aug 2022 08:41:47 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M5z2t1yt9z67lcR;
        Mon, 15 Aug 2022 23:38:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 17:41:45 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 16:41:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: [PATCH 2/2] cxl/pmem: Fix failure to account for 8 byte header for writes to the device LSA.
Date:   Mon, 15 Aug 2022 16:40:44 +0100
Message-ID: <20220815154044.24733-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220815154044.24733-1-Jonathan.Cameron@huawei.com>
References: <20220815154044.24733-1-Jonathan.Cameron@huawei.com>
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

Writes to the device must include an offset and size as defined in
CXL 2.0 8.2.9.5.2.4 Set LSA (Opcode 4103h)

Fixes tag is non obvious as this code has been through several
reworks and variable names + wasn't in use until the addition
of the region code.

Due to a bug in QEMU CXL emulation this overrun resulted in QEMU
crashing.

Reported-by: Bobo WL <lmw.bobo@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/pmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 7dc0a2fa1a6b..115a7b79f343 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -107,7 +107,7 @@ static int cxl_pmem_get_config_size(struct cxl_dev_state *cxlds,
 
 	*cmd = (struct nd_cmd_get_config_size) {
 		 .config_size = cxlds->lsa_size,
-		 .max_xfer = cxlds->payload_size,
+		 .max_xfer = cxlds->payload_size - sizeof(struct cxl_mbox_set_lsa),
 	};
 
 	return 0;
-- 
2.32.0

