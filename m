Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0157AC4321E
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Dec 2022 21:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiLAVd4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Dec 2022 16:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiLAVdz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Dec 2022 16:33:55 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49998C358A
        for <linux-cxl@vger.kernel.org>; Thu,  1 Dec 2022 13:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669930435; x=1701466435;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TegZIsam1nSMAQmPeHmk/pxm0gQ3ZGqOoamFiUvGsRo=;
  b=Ok2AV7Y3VDfGKR5WYud8zOv8vO9b3rX6YrsdL/yCFxBMk1qB6s4I23ob
   K3A25h1NDRwe3+uFKy778P6xOw/+6wAqcSetIjoiJNV3RXk5+kKXn/XdR
   YppQ8Zldy7Rc9qh5XzyYM3JiM+L6O8AAR4ueFsnfNZ46oHCIS2U71Ahvf
   auiF8z0MxqN62BYZlVg9R+ohmP+p7MQD/34ezOI33mvzVNeT+qZgLR3Wm
   v4J7y5eEbhWo7xXntaxqu0G9I65yRR5uSVlAuU09CBTg0tLKADU2KhzpY
   TTwnbEXUhwi3WDZTn2aftvuJIUAlJBPg/IYZddM6HKxMw+9l5CJW5OoCg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="313443228"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="313443228"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 13:33:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="675594776"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="675594776"
Received: from navarrof-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.177.235])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 13:33:54 -0800
Subject: [PATCH v6 06/12] tools/testing/cxl: Make mock CEDT parsing more
 robust
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Robert Richter <rrichter@amd.com>, rrichter@amd.com,
        terry.bowman@amd.com, bhelgaas@google.com, dave.jiang@intel.com,
        nvdimm@lists.linux.dev
Date:   Thu, 01 Dec 2022 13:33:54 -0800
Message-ID: <166993043433.1882361.17651413716599606118.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166993040066.1882361.5484659873467120859.stgit@dwillia2-xfh.jf.intel.com>
References: <166993040066.1882361.5484659873467120859.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Accept any cxl_test topology device as the first argument in
cxl_chbs_context.

This is in preparation for reworking the detection of the component
registers across VH and RCH topologies. Move
mock_acpi_table_parse_cedt() beneath the definition of is_mock_port()
and use is_mock_port() instead of the explicit mock cxl_acpi device
check.

Acked-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/cxl.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index facfcd11cb67..8acf52b7dab2 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -320,10 +320,12 @@ static int populate_cedt(void)
 	return 0;
 }
 
+static bool is_mock_port(struct device *dev);
+
 /*
- * WARNING, this hack assumes the format of 'struct
- * cxl_cfmws_context' and 'struct cxl_chbs_context' share the property that
- * the first struct member is the device being probed by the cxl_acpi
+ * WARNING, this hack assumes the format of 'struct cxl_cfmws_context'
+ * and 'struct cxl_chbs_context' share the property that the first
+ * struct member is cxl_test device being probed by the cxl_acpi
  * driver.
  */
 struct cxl_cedt_context {
@@ -340,7 +342,7 @@ static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
 	unsigned long end;
 	int i;
 
-	if (dev != &cxl_acpi->dev)
+	if (!is_mock_port(dev) && !is_mock_dev(dev))
 		return acpi_table_parse_cedt(id, handler_arg, arg);
 
 	if (id == ACPI_CEDT_TYPE_CHBS)

