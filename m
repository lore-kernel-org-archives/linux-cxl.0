Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BBDC433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 20:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbiKNULi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbiKNULQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 15:11:16 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839F11A07B
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 12:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668456675; x=1699992675;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0gzDFXM5TUyGWZMAJXpEPh985GnFX9qB0GK8cJZk4tg=;
  b=C1bOH5DpnYJvcV/8wHZLTeVONsI2fl9rKHjVTLzeSJhYtX8K2VSU7RXR
   jugGOQObcnVL+k7dIjCZLKUIFFHbLi2y6BgEf4NC795nauUjtueOd9sUt
   /HSkdBoMqXyr/CDikrGuxGiXMHvAnc8B83fJ7UgBMn4a+DkMW6Lap0XQN
   xrB337bZfg4GgbgyUvpxyIMBqg92TZbftmNtfvZhwHl60DBapDtSwcs4Y
   uR2HUgayHdnNBfdf7DNmkyRylBV5a2N6oC+IicVjhEsJjoFEHYTKlwV7k
   wtpBsupsX8xFN9cfo9fdmCQ2xLTBLHVNB/xILmxd4onnjBXu/ol826Oan
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="374201838"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="374201838"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:11:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="707454201"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="707454201"
Received: from shahr-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.78.174])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:11:14 -0800
Subject: [PATCH] tools/testing/cxl: Add bridge mocking support
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Robert Richter <rrichter@amd.com>
Date:   Mon, 14 Nov 2022 12:11:13 -0800
Message-ID: <166845667383.1449826.14492184009399164787.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <20221018132341.76259-6-rrichter@amd.com>
References: <20221018132341.76259-6-rrichter@amd.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for cxl_acpi walking pci_root->bus->bridge, add that
association to the mock pci_root instances.

Note that the missing 3rd entry in mock_pci_root[] was not noticed until
now given that the test version of to_cxl_host_bridge()
(tools/testing/cxl/mock_acpi.c), obviated the need for that entry.
However, "cxl/acpi: Improve debug messages in cxl_acpi_probe()" [1]
needs pci_root->bus->bridge to be populated.

Link: https://lore.kernel.org/r/20221018132341.76259-6-rrichter@amd.com [1]
Cc: Robert Richter <rrichter@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/cxl.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index a5146d80ecc4..facfcd11cb67 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -439,14 +439,18 @@ mock_acpi_evaluate_integer(acpi_handle handle, acpi_string pathname,
 	return AE_OK;
 }
 
-static struct pci_bus mock_pci_bus[NR_CXL_HOST_BRIDGES];
-static struct acpi_pci_root mock_pci_root[NR_CXL_HOST_BRIDGES] = {
+static struct pci_bus mock_pci_bus[NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST];
+static struct acpi_pci_root mock_pci_root[ARRAY_SIZE(mock_pci_bus)] = {
 	[0] = {
 		.bus = &mock_pci_bus[0],
 	},
 	[1] = {
 		.bus = &mock_pci_bus[1],
 	},
+	[2] = {
+		.bus = &mock_pci_bus[2],
+	},
+
 };
 
 static bool is_mock_bus(struct pci_bus *bus)
@@ -744,6 +748,7 @@ static __init int cxl_single_init(void)
 		}
 
 		cxl_hb_single[i] = pdev;
+		mock_pci_bus[i + NR_CXL_HOST_BRIDGES].bridge = &pdev->dev;
 		rc = sysfs_create_link(&pdev->dev.kobj, &pdev->dev.kobj,
 				       "physical_node");
 		if (rc)
@@ -910,6 +915,7 @@ static __init int cxl_test_init(void)
 		}
 
 		cxl_host_bridge[i] = pdev;
+		mock_pci_bus[i].bridge = &pdev->dev;
 		rc = sysfs_create_link(&pdev->dev.kobj, &pdev->dev.kobj,
 				       "physical_node");
 		if (rc)

