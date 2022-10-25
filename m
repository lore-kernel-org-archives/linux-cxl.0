Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CABEC04A95
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 10:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiJYKnt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 06:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiJYKns (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 06:43:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE41153817
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 03:43:47 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxT3g1KDnz67PFn;
        Tue, 25 Oct 2022 18:40:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 12:43:45 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:43:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <jonathan.cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>
Subject: [RFC PATCH v2 2/4] cxl/mbox: Change parameters to cxl_send_cmd() to not assume a cxl memory device.
Date:   Tue, 25 Oct 2022 11:42:41 +0100
Message-ID: <20221025104243.20836-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221025104243.20836-1-Jonathan.Cameron@huawei.com>
References: <20221025104243.20836-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Intent here is to enable CXL switch CCIs in the following patch.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h   | 5 ++++-
 drivers/cxl/core/mbox.c   | 5 ++---
 drivers/cxl/core/memdev.c | 4 +++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1d8f87be283f..0835942bcea6 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -41,9 +41,12 @@ static inline void cxl_region_exit(void)
 
 struct cxl_send_command;
 struct cxl_mem_query_commands;
+struct cxl_dev_state;
+struct device;
 int cxl_query_cmd(struct cxl_memdev *cxlmd,
 		  struct cxl_mem_query_commands __user *q);
-int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s);
+int cxl_send_cmd(struct cxl_dev_state *cxlds, struct device *dev,
+		 struct cxl_send_command __user *s);
 void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 				   resource_size_t length);
 
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index dd9e0aac37ae..3823d450fdd2 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -526,10 +526,9 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
 	return rc;
 }
 
-int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
+int cxl_send_cmd(struct cxl_dev_state *cxlds, struct device *dev,
+		 struct cxl_send_command __user *s)
 {
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct device *dev = &cxlmd->dev;
 	struct cxl_send_command send;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 20ce488a7754..62840a6da140 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -269,11 +269,13 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 			       unsigned long arg)
 {
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct device *dev = &cxlmd->dev;
 	switch (cmd) {
 	case CXL_MEM_QUERY_COMMANDS:
 		return cxl_query_cmd(cxlmd, (void __user *)arg);
 	case CXL_MEM_SEND_COMMAND:
-		return cxl_send_cmd(cxlmd, (void __user *)arg);
+		return cxl_send_cmd(cxlds, dev, (void __user *)arg);
 	default:
 		return -ENOTTY;
 	}
-- 
2.37.2

