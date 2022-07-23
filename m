Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3A1CCA473
	for <linux-cxl@archiver.kernel.org>; Sat, 23 Jul 2022 00:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbiGWA5t (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Jul 2022 20:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237168AbiGWA5j (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Jul 2022 20:57:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4AFC1989
        for <linux-cxl@vger.kernel.org>; Fri, 22 Jul 2022 17:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658537759; x=1690073759;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j8uqVWeBPSXupKOtq7g+mKN1164j2dCDA74jCfUCico=;
  b=hx6MpC0HgKQpMSgXbAismVtDeXd9f4QdR+7cdc+IFqPKdBN5Q8HycOa5
   yFZu4fWIdUH8JII/x2403UoIjPL5D/cZuXtD/pBDHer/Jmg8XLLAv9oPs
   FqGflLsCrchXjSAOzf59LK+BF2/x8Hx4bCgy6XaGMc70JPmBfIG90od1y
   2soVxwSyMsBj1JolpJFhAMAIYvW7uzsGfjs/p5QZjNuNMeXelOAUD8El9
   Nmua/sGpRiC2WT6UPw1WfxOkkGTSldQhBLiHigV683O8CBKeeGDM1Cq7K
   hQzLzxOlABA3vR2DOF3A8NBfvynwG4wyWDluehIrYmtH47hUqryu+PXuT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="351427774"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="351427774"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 17:55:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="626761469"
Received: from jeescalx-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.116.64])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 17:55:58 -0700
Subject: [PATCH 1/5] cxl/acpi: Autoload driver for 'cxl_acpi' test devices
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Date:   Fri, 22 Jul 2022 17:55:57 -0700
Message-ID: <165853775783.2430596.13637998086505316619.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In support of CXL unit tests in the ndctl project, arrange for the
cxl_acpi driver to load in response to the registration of cxl_test
devices.

Reported-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 64004eb672d0..eb436268b92c 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -515,12 +515,19 @@ static const struct acpi_device_id cxl_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, cxl_acpi_ids);
 
+static const struct platform_device_id cxl_test_ids[] = {
+	{ "cxl_acpi" },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, cxl_test_ids);
+
 static struct platform_driver cxl_acpi_driver = {
 	.probe = cxl_acpi_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.acpi_match_table = cxl_acpi_ids,
 	},
+	.id_table = cxl_test_ids,
 };
 
 module_platform_driver(cxl_acpi_driver);

