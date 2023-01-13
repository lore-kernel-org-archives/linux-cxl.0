Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8486EC54EBE
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 15:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjAMPtx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 10:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjAMPtc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 10:49:32 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30637D25F
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 07:41:59 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ntlyh0VvBz6J9Z1;
        Fri, 13 Jan 2023 23:41:48 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 13 Jan 2023 15:41:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
CC:     <linuxarm@huawei.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [RFC PATCH 2/2] cxl: Add tprintk support for header log hex dump
Date:   Fri, 13 Jan 2023 15:40:58 +0000
Message-ID: <20230113154058.16227-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230113154058.16227-1-Jonathan.Cameron@huawei.com>
References: <20230113154058.16227-1-Jonathan.Cameron@huawei.com>
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

May not make sense in general, but very helpful when writing multiple
header logging support.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/trace.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 20ca2fe2ca8e..64f6ad13529d 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -62,10 +62,13 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 		 */
 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
 	),
-	TP_printk("%s: status: '%s' first_error: '%s'",
+	TP_printk("%s: status: '%s' first_error: '%s' header_log: %s",
 		  __get_str(dev_name),
 		  show_uc_errs(__entry->status),
-		  show_uc_errs(__entry->first_error)
+		  show_uc_errs(__entry->first_error),
+		__print_hex_dump("", DUMP_PREFIX_OFFSET, 32, 4,
+				(char *)__entry->header_log,
+				CXL_HEADERLOG_SIZE_U32, false)
 	)
 );
 
-- 
2.37.2

