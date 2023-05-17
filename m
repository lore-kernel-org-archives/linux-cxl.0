Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8DDC77B7A
	for <linux-cxl@archiver.kernel.org>; Wed, 17 May 2023 00:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjEQAWr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 20:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEQAWr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 20:22:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7089D40DF
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 17:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684282966; x=1715818966;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=avMnNhmARAneon5v/HkaiGOdg5+omArqL7jmxg42Yg8=;
  b=Wg7Xh4Aw1dQSFVeWMf2gaCu+eA9gmmD7K8qCbvB813GFwbfhyUspCkNs
   VJDAiSC5Va/I2u2NpyVasYpRjowww7B92RY6tT7OJFDd3QxueHRdpEw5i
   +F9gIYWO5TySCPnu+IvkCB6wWYCPDqopHlP0wJw1jNoKnTXp/WovxcHiy
   FquG4X/m4iD8bJDWF+RMw/+ztieNToYh+4JhS98P6vkR7z5ftCv2YzbTf
   Y0IUWBeSEL5m/+cq/mCtSIUaimXuHCqYDETTrq/oo5f8ZsM/g/73ElSGh
   FtOZ5Hkg9bKd9V5veQz5nLS6/s/GxZ0WfeneW7xKmZWrGtMsQy9bX8q7F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="350465356"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="350465356"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 17:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="679064164"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="679064164"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.5.122])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 17:22:45 -0700
Subject: [PATCH 2/3] cxl: Move identify and partition query from pci probe to
 port probe
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Date:   Tue, 16 May 2023 17:22:45 -0700
Message-ID: <168428296504.2205351.15006863208285686036.stgit@djiang5-mobl3>
In-Reply-To: <168428284429.2205351.8883627879572769367.stgit@djiang5-mobl3>
References: <168428284429.2205351.8883627879572769367.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Move the enumeration of device capacity to cxl_port_probe() from
cxl_pci_probe(). The size and capacity information should be read
after cxl_await_media_ready() so the data is valid.

Fixes: 5e2411ae8071 ("cxl/memdev: Change cxl_mem to a more descriptive name")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c  |    8 --------
 drivers/cxl/port.c |    8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ea38bd49b0cf..0f85e59eb60f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -720,14 +720,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_dev_state_identify(cxlds);
-	if (rc)
-		return rc;
-
-	rc = cxl_mem_create_range_info(cxlds);
-	if (rc)
-		return rc;
-
 	rc = cxl_alloc_irq_vectors(pdev);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index a49f5eb149f1..40e7b7de8bf6 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -114,6 +114,14 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		return rc;
 	}
 
+	rc = cxl_dev_state_identify(cxlds);
+	if (rc)
+		return rc;
+
+	rc = cxl_mem_create_range_info(cxlds);
+	if (rc)
+		return rc;
+
 	rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
 	if (rc)
 		return rc;


