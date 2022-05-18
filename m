Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86290C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 23:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiERXef (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 19:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiERXee (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 19:34:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BDE9CF61
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 16:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652916873; x=1684452873;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s57FUjOIhGjLsGAx6krjXJnND402hlxxzp6RopffrMY=;
  b=BITGeZqucVf69PAo5aCCJwJ6dyfsdwWNSjqdW1QmO3RD6dS5VdH2RMxT
   c8MZQZh5g9RSQrRZdcAldRDqjsN23XEjPrnWp91mv7XmxgHKckW2w5jS4
   NhOCHOW8bP0pS0UcMB/CL+iQRi0Y1nFcYYOEOyr/LU/BIFxZztMPRF9Qt
   so4PPamK71QVEPFe2nI/pj3FQ4uwn8eSdSdpM4lgJdEKah9euwSo8ZL68
   dXotveWPEce0DgCzNO8YaQ2/0/iKyFitJ2cGV05IOePEmbNWXWwB00QYi
   BxM/dxQvSRHV5geGN+QUY3q/EgMjsa5P6UiBNsX2gigDEsHKLwy/3qjjk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="334986007"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="334986007"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="714712876"
Received: from vgarg-mobl2.amr.corp.intel.com (HELO [192.168.1.101]) ([10.209.5.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:32 -0700
Subject: [PATCH v3 04/13] cxl/mem: Fix cxl_mem_probe() error exit
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 18 May 2022 16:34:31 -0700
Message-ID: <165291687176.1426646.15449254938752532784.stgit@dwillia2-xfh>
In-Reply-To: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
References: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The addition of cxl_mem_active() broke error exit scenarios for
cxl_mem_probe(). Return early rather than proceed with disabling
suspend, and update the label name since it is no longer a terminal
"out" label that exits the function.

Fixes: 9ea4dcf49878 ("PM: CXL: Disable suspend")
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 7622cfefa1b0..184549e5093f 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -171,13 +171,15 @@ static int cxl_mem_probe(struct device *dev)
 		dev_err(dev, "CXL port topology %s not enabled\n",
 			dev_name(&parent_port->dev));
 		rc = -ENXIO;
-		goto out;
+		goto unlock;
 	}
 
 	rc = create_endpoint(cxlmd, parent_port);
-out:
+unlock:
 	device_unlock(&parent_port->dev);
 	put_device(&parent_port->dev);
+	if (rc)
+		return rc;
 
 	/*
 	 * The kernel may be operating out of CXL memory on this device,

