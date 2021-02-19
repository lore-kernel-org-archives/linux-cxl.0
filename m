Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F77AC433E0
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Feb 2021 09:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C516B64E92
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Feb 2021 09:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhBSJ41 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 Feb 2021 04:56:27 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54680 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhBSJzk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 Feb 2021 04:55:40 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J9suD7069315;
        Fri, 19 Feb 2021 09:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=zFeZlCMv0GcrrKfoJN2RHKvkvjn5aO1djUUFAyQbRH0=;
 b=MgyCFFnBes08tvnLwmSXGhoGVFVw3qoiWVcd2xTWgWnc2/yzOFKunVEaOBVJsQafmT5z
 dG6PukapGDdTsJrS85e/8tKxB3yT1zux8OlB/uyNaZrMJYsejGsNLe7A83aUF70nd044
 Y3COTZf+VaEAPCS5wwFpO+hKc1n1eyTlRPUAxAQlNOiGLvVz3/LUUn4h1keNZLfO4CAb
 KHmn55qNJYcpvAFiYSocNGXW96cPiNvMGL6ueZIlyFnL35SiEK/hZRXXH+Pmu86tTITc
 j8D5wL/OHfYeImj0L2/wxRbWM+33FBk9EZm0hrncR0U1d76sx3xXGq2a3Q3dMWfkT86w ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 36p49bh2n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 09:54:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J9oCRj180246;
        Fri, 19 Feb 2021 09:54:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 36prq1q8fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 09:54:54 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11J9srff003650;
        Fri, 19 Feb 2021 09:54:53 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Feb 2021 01:54:52 -0800
Date:   Fri, 19 Feb 2021 12:54:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] cxl/mem: return -EFAULT if copy_to_user() fails
Message-ID: <YC+K3kgzqm20zCWY@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190076
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190076
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The copy_to_user() function returns the number of bytes remaining to be
copied, but we want to return -EFAULT if the copy doesn't complete.

Fixes: b754ffbbc0ee ("cxl/mem: Add basic IOCTL interface")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/cxl/mem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 8331a2fc7667..d73ab363ad71 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -745,7 +745,10 @@ static int cxl_send_cmd(struct cxl_memdev *cxlmd,
 	if (rc)
 		return rc;
 
-	return copy_to_user(s, &send, sizeof(send));
+	if (copy_to_user(s, &send, sizeof(send)))
+		return -EFAULT;
+
+	return 0;
 }
 
 static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
-- 
2.30.0

