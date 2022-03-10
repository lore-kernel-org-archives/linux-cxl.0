Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E822C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Mar 2022 04:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiCJEQM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Mar 2022 23:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiCJEQK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Mar 2022 23:16:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E544E7807B
        for <linux-cxl@vger.kernel.org>; Wed,  9 Mar 2022 20:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646885709; x=1678421709;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jdLPY0y3XynU1g5emZ4uHvT4OzljvdrkmeJN7yiaP3M=;
  b=S8L9uAz67etwqVE3wLkckMkD3Gyif5zom6qaUBSyCLXwVq4T8BadHZg0
   ggymjzkqB5L42oYqs07bpvOKfLZQDzKvhqnpAiL2nVEpA8fJyoNhLzqvA
   NYKoSh5GvD7RBWUQecT7RnPVAnf5keb3SBtLRk010jJ0jnK5lI4Cq+h9C
   Y0kirkCo9dI8UHEESO6g377RX8XhAcNRe6eYlUcjBbmdCylU7KvBMYGRw
   9mpvR4tccQsxkLdhuF2xXEShZ95yZbcRt63vMkByo2KWwplOBeian/6vq
   YbRRuvq7UvL2RhNA28yog4TUEmA3SNkQ2FJUXLvCdmzqSWmD9mwkPdLy1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255100274"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="255100274"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 20:15:09 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="510749995"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 20:15:09 -0800
Subject: [PATCH] cxl/acpi: Autoload driver for 'cxl_acpi' test devices
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan.Cameron@huawei.com, ben.widawsky@intel.com
Date:   Wed, 09 Mar 2022 20:15:09 -0800
Message-ID: <164688570904.2880359.5500188707517352931.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 218c4367c39f..b51409275866 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -355,12 +355,19 @@ static const struct acpi_device_id cxl_acpi_ids[] = {
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

