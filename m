Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5857EE6433
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Sep 2023 08:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjIOIHh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Sep 2023 04:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIOIHg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Sep 2023 04:07:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE7AAC;
        Fri, 15 Sep 2023 01:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694765251; x=1726301251;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Aw14QSkQOzC9U3vKgp4DV8yAM3v9B78YoEosEEXM5vw=;
  b=AwRRIyvnfSgrhBs4bMD0uH1ktQT7GM5LVNR6rBka88GTYyJd7x2zU3wp
   pKY6PpA925a+l2+z2PftkoBytfI93oaClvteplV+YdFSlW73p/HbMEMfK
   K2MH9n1bzCkg+2/VF3qbZ38KRai70AZDSpuIprLldtWZTOF8AasgYxsoD
   HYP6lHtKWlzEwlNfZUouVskx2BfX1NBDfh2fE1u6ODQlVGhIxpfEIbqvO
   n4KhYe9AJZEDA6SGXcVU3Dg/cAhq1PdApc9xy9npxhc86kgnOL07VAfZq
   T4lj6tn7aruTeGq533KfkSWeW1KmsTYwK/ZwHcGiXCYpF14FQSY3v1K3D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="410130470"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="410130470"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 01:07:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="744883219"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="744883219"
Received: from bkakkar-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.252.139.205])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 01:07:30 -0700
Subject: [PATCH] cxl/port: Fix cxl_test register enumeration regression
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     stable@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>
Date:   Fri, 15 Sep 2023 01:07:30 -0700
Message-ID: <169476525052.1013896.6235102957693675187.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The cxl_test unit test environment models a CXL topology for
sysfs/user-ABI regression testing. It uses interface mocking via the
"--wrap=" linker option to redirect cxl_core routines that parse
hardware registers with versions that just publish objects, like
devm_cxl_enumerate_decoders().

Starting with:

Commit 19ab69a60e3b ("cxl/port: Store the port's Component Register mappings in struct cxl_port")

...port register enumeration is moved into devm_cxl_add_port(). This
conflicts with the "cxl_test avoids emulating registers stance" so
either the port code needs to be refactored (too violent), or modified
so that register enumeration is skipped on "fake" cxl_test ports
(annoying, but straightforward).

This conflict has happened previously and the "check for platform
device" workaround to avoid instrusive refactoring was deployed in those
scenarios. In general, refactoring should only benefit production code,
test code needs to remain minimally instrusive to the greatest extent
possible.

This was missed previously because it may sometimes just cause warning
messages to be emitted, but it can also cause test failures. The
backport to -stable is only nice to have for clean cxl_test runs.

Fixes: 19ab69a60e3b ("cxl/port: Store the port's Component Register mappings in struct cxl_port")
Cc: <stable@vger.kernel.org>
Reported-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 724be8448eb4..7ca01a834e18 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <linux/platform_device.h>
 #include <linux/memregion.h>
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>
@@ -706,16 +707,20 @@ static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
 	return cxl_setup_regs(map);
 }
 
-static inline int cxl_port_setup_regs(struct cxl_port *port,
-				      resource_size_t component_reg_phys)
+static int cxl_port_setup_regs(struct cxl_port *port,
+			resource_size_t component_reg_phys)
 {
+	if (dev_is_platform(port->uport_dev))
+		return 0;
 	return cxl_setup_comp_regs(&port->dev, &port->comp_map,
 				   component_reg_phys);
 }
 
-static inline int cxl_dport_setup_regs(struct cxl_dport *dport,
-				       resource_size_t component_reg_phys)
+static int cxl_dport_setup_regs(struct cxl_dport *dport,
+				resource_size_t component_reg_phys)
 {
+	if (dev_is_platform(dport->dport_dev))
+		return 0;
 	return cxl_setup_comp_regs(dport->dport_dev, &dport->comp_map,
 				   component_reg_phys);
 }

