Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72CDC77B75
	for <linux-cxl@archiver.kernel.org>; Wed, 17 May 2023 00:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjEQAWy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 20:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEQAWx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 20:22:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A3240EB
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684282972; x=1715818972;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zU3tHIo2EztbRNlHV5hIbHQwpFxSw54SkH4mGxXCocw=;
  b=AQ9d3+fa9242zoVA7a+Aye2r0pbcBfZzaAm4Kf9W+7ZB+0uzatnDDEJV
   m132iaBvJasNPKLrnbHO8LQIe/D9JJoZBIl/C+8K1zWq9aFvNr0FXKAWS
   kgukqjXearZu58eSj9dInqdjTNBbd53K+LtpQD1VIVLbLG8Rs8aI+Ty5B
   VMQexEWhdEJAzjc8UlALSbQUyizeYvXXpj5cmf+5XgY7jBL5QnJtiZlrc
   4q7pW3Rdykb4Rc3UbMV9vaR/ebq3fAbHLAKYbrRuYLnw4zZ2EKnzzbJDw
   pGarayq1nSSGTD6wQoTSYDyiH3bq2k29pM9e8x8RbRl8v4H4R99c/4l1u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="350465370"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="350465370"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 17:22:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="679064215"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="679064215"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.5.122])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 17:22:51 -0700
Subject: [PATCH 3/3] cxl: Move read_cdat_data() to after media is ready
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Date:   Tue, 16 May 2023 17:22:51 -0700
Message-ID: <168428297113.2205351.16197713607932380832.stgit@djiang5-mobl3>
In-Reply-To: <168428284429.2205351.8883627879572769367.stgit@djiang5-mobl3>
References: <168428284429.2205351.8883627879572769367.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CDAT data is only valid after the media is ready. Move read_cdat_data() to
after cxl_await_media_read() is successful.

Fixes: 32ce3f185bbb ("cxl/port: Split endpoint and switch port probe")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/port.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 40e7b7de8bf6..bebc297fde5c 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -96,9 +96,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (IS_ERR(cxlhdm))
 		return PTR_ERR(cxlhdm);
 
-	/* Cache the data early to ensure is_visible() works */
-	read_cdat_data(port);
-
 	get_device(&cxlmd->dev);
 	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
 	if (rc)
@@ -114,6 +111,9 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		return rc;
 	}
 
+	/* Cache the data early to ensure is_visible() works */
+	read_cdat_data(port);
+
 	rc = cxl_dev_state_identify(cxlds);
 	if (rc)
 		return rc;


