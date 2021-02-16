Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D25C433DB
	for <linux-cxl@archiver.kernel.org>; Tue, 16 Feb 2021 19:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBFC64E79
	for <linux-cxl@archiver.kernel.org>; Tue, 16 Feb 2021 19:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhBPTRv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 Feb 2021 14:17:51 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35898 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhBPTRu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 Feb 2021 14:17:50 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GJAJ8d128995;
        Tue, 16 Feb 2021 19:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=wds/CFrm0BgZAJTZAZqSDi8H94fn36D1M5FogD32eFo=;
 b=MIR1NaCm2FNBmmfDBzdH1qxr86aRB4OVPvB/0xcIV+6Sy/bdAPX2il3HVsy6t0jxf9Dy
 Rb5tJEIK75x3IlrfKNMfamPC9ziWviFtKC9k7lifMYwdB1wJMtq+9ZkCBCK8ikAdQvYx
 Kills83kjcnfT6IVtb9SMdSNXJPM/NbKm27go9rBkvmxIt3uC0QXwPfCvextJz87N7D4
 xbbOIGpb4G4FDgCShbpCQUNvGzTiP2cqpup2io/g0by9txs71MX8mxnoveG1FD+EsnDQ
 wjtzpwqFv2Ae63jyIo1sL7c5lCaBPcX0+otY9cr8eg6a7ZpTpzuJ9kg1WMT5T7BNk71Y Dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 36p49b85ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 19:17:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GJA2av129930;
        Tue, 16 Feb 2021 19:17:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 36prpx71xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 19:17:02 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11GJH0Ww013364;
        Tue, 16 Feb 2021 19:17:01 GMT
Received: from mwanda (/10.175.221.77)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Feb 2021 11:17:00 -0800
Date:   Tue, 16 Feb 2021 22:16:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] cxl/mem: Fix an error code in cxl_mem_mbox_get()
Message-ID: <YCwaIGPd9ktMoYPu@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160159
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=992
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160159
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Smatch complains that sometimes when we return success we are holding
the mutex and sometimes we have released the mutex.  It turns out that
the bug is a missing error code if the mbox is not ready.  It should
return -EBUSY instead of success.

Fixes: cc1967ac93ab ("cxl/mem: Find device capabilities")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/cxl/mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 3bca8451348a..2ebc84e4d202 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -383,8 +383,8 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
 {
 	struct device *dev = &cxlm->pdev->dev;
-	int rc = -EBUSY;
 	u64 md_status;
+	int rc;
 
 	mutex_lock_io(&cxlm->mbox_mutex);
 
@@ -414,6 +414,7 @@ static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
 	md_status = readq(cxlm->memdev_regs + CXLMDEV_STATUS_OFFSET);
 	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
 		dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
+		rc = -EBUSY;
 		goto out;
 	}
 
-- 
2.30.0

