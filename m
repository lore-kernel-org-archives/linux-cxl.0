Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25F4C54EAA
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 15:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjA3PfY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 10:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjA3PfY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 10:35:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C683FF04
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 07:35:02 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P5BzT4z04z6J9YS;
        Mon, 30 Jan 2023 23:33:41 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 30 Jan 2023 15:34:39 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: [PATCH] cxl/mbox: Add missing parameter to docs.
Date:   Mon, 30 Jan 2023 15:34:37 +0000
Message-ID: <20230130153437.3153-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Kernel-doc should be complete, so add documentation for the status
parameter.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Fixes  ("cxl/mem: Read, trace, and clear events on driver load")

Bad fixes tag is deliberate as patch is currently only in the cxl/pending
branch. Feel free to squash this or drop the fixes entirely.

I'm odd and for various reasons run W=1 builds. The resulting
warning has been irritating me, hence the fixlet.
---
 drivers/cxl/core/mbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a0bd2170af48..03909b6cef55 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -913,6 +913,7 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 /**
  * cxl_mem_get_event_records - Get Event Records from the device
  * @cxlds: The device data for the operation
+ * @status: Event Status register value identifying which events are available.
  *
  * Retrieve all event records available on the device, report them as trace
  * events, and clear them.
-- 
2.37.2

