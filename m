Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45102C77B7F
	for <linux-cxl@archiver.kernel.org>; Mon,  8 May 2023 20:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjEHUsC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 May 2023 16:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjEHUsB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 May 2023 16:48:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D82558B
        for <linux-cxl@vger.kernel.org>; Mon,  8 May 2023 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683578880; x=1715114880;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V/wYL8+fOhlUEF9f0RZ8WOxU5SNImHABMY796EVKtuI=;
  b=m0b67sZI+8m3KuHZYjsLwCGlvwolMIwjUUrDl/Yksb28BWGI9j4bj6XN
   gWG6/dHqGf4KmdrIIq+O+9JwovMaSI9vFGVr/ZkGRwfoy0tdSBzbgJ5Bv
   q/L3MOKnsa0gjSzPmbmjgYjNEx+4KPtZTzHkige1C4VfjAVQmcIzJO2ZU
   ZKZ7VW0krqoyHd0UPOOnFiCqCmgS24x5BVeiRbYsTMMN4wnAl2DD8dAFf
   b3LgqOq5BMhrCR0/SksP6RUOJ6HZAdWHD/BMZVU39s1NBFW95B6NLZAPq
   FyNTXKcAxPRPPb2UeN1oCwyBX36bvICP7Y1R1bxka9PUqOr7bPqc2FVVe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="436072443"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="436072443"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:48:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="944996760"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="944996760"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.172.228])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:47:59 -0700
Subject: [PATCH v5 11/14] cxl: Move read_cdat_data() to after media is ready
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 08 May 2023 13:47:59 -0700
Message-ID: <168357887947.2756219.6022306227580486103.stgit@djiang5-mobl3>
In-Reply-To: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CDAT data is only valid after the media is ready. Move read_cdat_data() to
after cxl_awai_media_read() is successful.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/port.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 0bdb9d73a389..1d55c460e1ab 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -162,9 +162,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (IS_ERR(cxlhdm))
 		return PTR_ERR(cxlhdm);
 
-	/* Cache the data early to ensure is_visible() works */
-	read_cdat_data(port);
-
 	get_device(&cxlmd->dev);
 	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
 	if (rc)
@@ -180,6 +177,9 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		return rc;
 	}
 
+	/* Cache the data early to ensure is_visible() works */
+	read_cdat_data(port);
+
 	rc = cxl_dev_state_identify(cxlds);
 	if (rc)
 		return rc;


