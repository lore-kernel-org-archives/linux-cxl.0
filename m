Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F0DC7EE23
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 17:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjERRcL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 13:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjERRcJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 13:32:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E70F10FA
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 10:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684431109; x=1715967109;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B6XFIPa3+eQYSE6ovQvI57TmhKiWlWhIy0k0aQeSp1Q=;
  b=WOiL4ne04DCuf/4E6NObvo9CrXU51GLQ3gwKAvUig1i3HX9goJ479zdh
   1gduTMOcWJL6AIDXAdqayO1bOKDQ1ur8ksXDKL/y6lXHtXuQVRFH3dTYP
   qzsRtmitanVRNCfqD9HnXpmstx+6ABgUUKZuqV/VB/emuqQv2KhJ/orQn
   tyG8gf+cuxGCQqwpZAHacEAJw+GG0ea8Fwck4qWOXq1kRbHc/2Iimp9IE
   smqS9fqK/CoRPSw//8RG3we4ik2SbjGFCeVcd4QskQ/rjAnQZo9Qi+ydm
   0GTAV9L8dwymtEFOAFHZuNaT3r8u4ts14tV67NH6zU7wCJJ7ZOxGdGLuv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="415590498"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="415590498"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 10:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="814402512"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="814402512"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.136])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 10:31:48 -0700
Subject: [PATCH v2 2/2] cxl: Move cxl_await_media_ready() to before capacity
 info retrieval
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Cc:     ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com
Date:   Thu, 18 May 2023 10:31:48 -0700
Message-ID: <168443110845.2957452.15022248373553807511.stgit@djiang5-mobl3>
In-Reply-To: <168443095459.2957452.1648087475761987955.stgit@djiang5-mobl3>
References: <168443095459.2957452.1648087475761987955.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Move cxl_await_media_ready() to cxl_pci probe before driver starts issuing
IDENTIFY and retrieving memory device information to ensure that the
device is ready to provide the information.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c  |    6 ++++++
 drivers/cxl/port.c |    6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ea38bd49b0cf..fc59ca79b2a0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -708,6 +708,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	rc = cxl_await_media_ready(cxlds);
+	if (rc) {
+		dev_err(&pdev->dev, "Media not active (%d)\n", rc);
+		return rc;
+	}
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index a49f5eb149f1..bfb948e00c42 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -108,12 +108,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
-	rc = cxl_await_media_ready(cxlds);
-	if (rc) {
-		dev_err(&port->dev, "Media not active (%d)\n", rc);
-		return rc;
-	}
-
 	rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
 	if (rc)
 		return rc;


