Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A41C761AF
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 05:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjC0FDe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjC0FDa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 01:03:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646E54EE0
        for <linux-cxl@vger.kernel.org>; Sun, 26 Mar 2023 22:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679893409; x=1711429409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0fuED8H/zsIymaPpbpMXBUqZUJmiyI+xaC/NxmwMEkU=;
  b=dPIs5cvKQWeJGC9cq/73RMtBeLdIDs3pgHFNE3hpCe92HNRu0Vm0yv2I
   BJ+3gFxJSUYyvy34WtO6vkdArmigpqdm6Fu8Czlryu8s98xAen3xAXW4Z
   MGh8WfKNpPltngTKKB+RsusgozWenPEuu7MvIyqYEK8S6F/6XXKErpA+r
   X59hXhR+ARrLtO5YYqXyN4xeiLD/fcxE6s95bK+wuI6U/JilEWX1x0ZWC
   6ClZnOna62IyfF3/4L2kJloSSFz3254zuqPV162nLMjd473o4/mAMEvR0
   1t7dT//qmrP9rek+jSCvFLEnzSX/2PzVdxBnQ8mfdujvMUwC00OVag9Z6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367920218"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="367920218"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="633492294"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="633492294"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.227.2])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:28 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 12/12] tools/testing/cxl: Require CONFIG_DEBUG_FS
Date:   Sun, 26 Mar 2023 22:03:18 -0700
Message-Id: <a9a8a99c4f106ba88ac839d391b83d662d5d2b92.1679892337.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679892337.git.alison.schofield@intel.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The cxl_mem driver uses debugfs to support poison inject and clear.
Add debugfs to the list of required symbols so that cxl_test can
emulate those poison operations.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/config_check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/cxl/config_check.c b/tools/testing/cxl/config_check.c
index 99b56b5f6edf..0902c5d6e410 100644
--- a/tools/testing/cxl/config_check.c
+++ b/tools/testing/cxl/config_check.c
@@ -13,4 +13,5 @@ void check(void)
 	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_PMEM));
 	BUILD_BUG_ON(!IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST));
 	BUILD_BUG_ON(!IS_ENABLED(CONFIG_NVDIMM_SECURITY_TEST));
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_DEBUG_FS));
 }
-- 
2.37.3

