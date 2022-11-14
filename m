Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D55C43217
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 20:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbiKNUes (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbiKNUer (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 15:34:47 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A798E093
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 12:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668458084; x=1699994084;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CqgCGQz11NkCovLWB0kPCFwffgPt/26j60AmAr1EC4g=;
  b=E29r8+NOAOzeHZ8qE4WtkIjJ2aYI8dHX4sqmA2z2CQijXbUwh836ajet
   S7JWAycGGRj2xnh04lA+PFkmlQq/X/JNGWtp8bw3xPxjpZ3yaZyep1pCp
   CA36+DhbeUUSRNYXRHMsfOIZu1HGP/JzxKvFVDJRwxsbYbIpy/lu3ALU9
   bpx/gUnCpvneLTHrBxVU9t0jtHvHN1JXaQS13rncRy2DdfXJl2qJPXVUf
   TG3ar9r0gG4kHytoU5Yv8xNqzinVIQjZj30qmqtvlS7e2TciTJMHq4yWG
   qGESq8Ct8zjPUHRLWWpVCvk2B00EBSFaSIxdR/RvERF65nuhwcGZn7XFX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="299596991"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="299596991"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:34:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="702155122"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="702155122"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:34:43 -0800
Subject: [PATCH v4 17/18] libnvdimm: Introduce CONFIG_NVDIMM_SECURITY_TEST
 flag
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date:   Mon, 14 Nov 2022 13:34:42 -0700
Message-ID: <166845808282.2496228.12090787281878969752.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166845791969.2496228.8357488385523295841.stgit@djiang5-desk3.ch.intel.com>
References: <166845791969.2496228.8357488385523295841.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

nfit_test overrode the security_show() sysfs attribute function in nvdimm
dimm_devs in order to allow testing of security unlock. With the
introduction of CXL security commands, the trick to override
security_show() becomes significantly more complicated. By introdcing a
security flag CONFIG_NVDIMM_SECURITY_TEST, libnvdimm can just toggle the
check via a compile option. In addition the original override can can be
removed from tools/testing/nvdimm/.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/nvdimm/Kconfig           |   12 ++++++++++++
 drivers/nvdimm/dimm_devs.c       |    9 ++++++++-
 drivers/nvdimm/security.c        |    4 ++++
 tools/testing/nvdimm/Kbuild      |    1 -
 tools/testing/nvdimm/dimm_devs.c |   30 ------------------------------
 5 files changed, 24 insertions(+), 32 deletions(-)
 delete mode 100644 tools/testing/nvdimm/dimm_devs.c

diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index 5a29046e3319..3eaa94f61da6 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -114,4 +114,16 @@ config NVDIMM_TEST_BUILD
 	  core devm_memremap_pages() implementation and other
 	  infrastructure.
 
+config NVDIMM_SECURITY_TEST
+	bool "Nvdimm security test code toggle"
+	depends on NVDIMM_KEYS
+	help
+	  Debug flag for security testing when using nfit_test or cxl_test
+	  modules in tools/testing/.
+
+	  Select Y if using nfit_test or cxl_test for security testing.
+	  Selecting this option when not using cxl_test introduces 1
+	  mailbox request to the CXL device to get security status
+	  for DIMM unlock operation or sysfs attribute "security" read.
+
 endif
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index c7c980577491..1fc081dcf631 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -349,11 +349,18 @@ static ssize_t available_slots_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(available_slots);
 
-__weak ssize_t security_show(struct device *dev,
+ssize_t security_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
+	/*
+	 * For the test version we need to poll the "hardware" in order
+	 * to get the updated status for unlock testing.
+	 */
+	if (IS_ENABLED(CONFIG_NVDIMM_SECURITY_TEST))
+		nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
+
 	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
 		return sprintf(buf, "overwrite\n");
 	if (test_bit(NVDIMM_SECURITY_DISABLED, &nvdimm->sec.flags))
diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 92af4c3ca0d3..12a3926f4289 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -177,6 +177,10 @@ static int __nvdimm_security_unlock(struct nvdimm *nvdimm)
 			|| !nvdimm->sec.flags)
 		return -EIO;
 
+	/* While nfit_test does not need this, cxl_test does */
+	if (IS_ENABLED(CONFIG_NVDIMM_SECURITY_TEST))
+		nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
+
 	/* No need to go further if security is disabled */
 	if (test_bit(NVDIMM_SECURITY_DISABLED, &nvdimm->sec.flags))
 		return 0;
diff --git a/tools/testing/nvdimm/Kbuild b/tools/testing/nvdimm/Kbuild
index 5eb5c23b062f..8153251ea389 100644
--- a/tools/testing/nvdimm/Kbuild
+++ b/tools/testing/nvdimm/Kbuild
@@ -79,7 +79,6 @@ libnvdimm-$(CONFIG_BTT) += $(NVDIMM_SRC)/btt_devs.o
 libnvdimm-$(CONFIG_NVDIMM_PFN) += $(NVDIMM_SRC)/pfn_devs.o
 libnvdimm-$(CONFIG_NVDIMM_DAX) += $(NVDIMM_SRC)/dax_devs.o
 libnvdimm-$(CONFIG_NVDIMM_KEYS) += $(NVDIMM_SRC)/security.o
-libnvdimm-y += dimm_devs.o
 libnvdimm-y += libnvdimm_test.o
 libnvdimm-y += config_check.o
 
diff --git a/tools/testing/nvdimm/dimm_devs.c b/tools/testing/nvdimm/dimm_devs.c
deleted file mode 100644
index 57bd27dedf1f..000000000000
--- a/tools/testing/nvdimm/dimm_devs.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright Intel Corp. 2018 */
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/nd.h>
-#include "pmem.h"
-#include "pfn.h"
-#include "nd.h"
-#include "nd-core.h"
-
-ssize_t security_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct nvdimm *nvdimm = to_nvdimm(dev);
-
-	/*
-	 * For the test version we need to poll the "hardware" in order
-	 * to get the updated status for unlock testing.
-	 */
-	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
-
-	if (test_bit(NVDIMM_SECURITY_DISABLED, &nvdimm->sec.flags))
-		return sprintf(buf, "disabled\n");
-	if (test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.flags))
-		return sprintf(buf, "unlocked\n");
-	if (test_bit(NVDIMM_SECURITY_LOCKED, &nvdimm->sec.flags))
-		return sprintf(buf, "locked\n");
-	return -ENOTTY;
-}


