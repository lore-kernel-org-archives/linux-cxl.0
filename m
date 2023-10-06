Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA8763DD
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HM8jTEPW"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AC6CA
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696577183; x=1728113183;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=tkFaQhN+VJ0Xplg8crH2zRv6PXnDOOnympUFHN3vBqs=;
  b=HM8jTEPWyebDasBU/Mq/4LbihVI06x0vSoKmSRedkxYvwYV9wmcoJZCK
   D4zQ7jeJOZJ5L83eMCiyKklkT1q91Oz0f2P1pEDD+5y6cK/wUOUt5YWRo
   yiGqsFwOuZ5UzY/14yI0ImWyFgwV28LZUFEA83H8HphztEVSVfNHupDpQ
   wprq89NIEz+qu4I4Vd/VXTa3lrbhj0FOTK8G5CL10KECwd/lHolDM2RvM
   MH55ubxiDNDf0NO5Vft7p7r7CEHwe6j8WAEnR7LN8zrq9IMxWSmW+gm2q
   PaCUqkzsG8keLPqdGhkmRZqsAxD3/k+wrJVWlpZYxnLDwPsBP6XJlXw50
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="450192229"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="450192229"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="817923204"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="817923204"
Received: from wbleichn-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.147.24])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:22 -0700
Subject: [PATCH v3 04/10] cxl/pci: Remove inconsistent usage of
 dev_err_probe()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Date: Fri, 06 Oct 2023 00:26:22 -0700
Message-ID: <169657718224.1491153.11083952431204965077.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If dev_err_probe() is to be used it should at least be used consistently
within the same function. It is also worth questioning whether
every potential -ENOMEM needs an explicit error message.

Remove the cxl_setup_fw_upload() error prints for what are rare /
hardware-independent failures.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 2a7a07f6d165..6efe4e2a2cf5 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -970,7 +970,6 @@ int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
 	struct cxl_dev_state *cxlds = &mds->cxlds;
 	struct device *dev = &cxlds->cxlmd->dev;
 	struct fw_upload *fwl;
-	int rc;
 
 	if (!test_bit(CXL_MEM_COMMAND_ID_GET_FW_INFO, mds->enabled_cmds))
 		return 0;
@@ -978,17 +977,9 @@ int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
 	fwl = firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
 				       &cxl_memdev_fw_ops, mds);
 	if (IS_ERR(fwl))
-		return dev_err_probe(dev, PTR_ERR(fwl),
-				     "Failed to register firmware loader\n");
-
-	rc = devm_add_action_or_reset(cxlds->dev, devm_cxl_remove_fw_upload,
-				      fwl);
-	if (rc)
-		dev_err(dev,
-			"Failed to add firmware loader remove action: %d\n",
-			rc);
+		return PTR_ERR(fwl);
 
-	return rc;
+	return devm_add_action_or_reset(cxlds->dev, devm_cxl_remove_fw_upload, fwl);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_setup_fw_upload, CXL);
 

