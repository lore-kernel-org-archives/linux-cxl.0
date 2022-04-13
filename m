Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BBEC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Apr 2022 18:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiDMSkR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Apr 2022 14:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbiDMSkP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Apr 2022 14:40:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F0F53E2A
        for <linux-cxl@vger.kernel.org>; Wed, 13 Apr 2022 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649875074; x=1681411074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aE4N3k3trSLj1FrxNaxvn8G0EZkVgDXfaelpiPyEsI4=;
  b=Lo0NsxvWQwaPkLKFkEcYW3qCwJKCZrW5di12WapH4NKUHdkOlCgJd2Zt
   9tN/4Ty4DAxjoKOVNCZiXzbVlawAZmzVEDXPTyz8H6n2YzaAilRqVERSh
   KAt0xl8g0Oc6nmnsDirXhtYR2OSX6v5uDQkxZFswB9/nY+QT5Q0lUBVJ+
   ZWWP8CCcXjmpeJRVt+EQLzcNsT1CPnK01WGlFye4K/M/ibXeIOcuOxkoo
   HGVEGyH/DEQF19Oc8PIdhACmIyO4Z23h6cm9AmphPLDTl8FuHq1i4ACTS
   dY1As0XSsRGpN4Wsx/S+mbU8sh+IAwph417c7jCFU4Wbs1vkU6YFfji8k
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="261591499"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="261591499"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:37:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725013563"
Received: from sushobhi-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.131.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:37:47 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 01/15] cxl/core: Use is_endpoint_decoder
Date:   Wed, 13 Apr 2022 11:37:06 -0700
Message-Id: <20220413183720.2444089-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413183720.2444089-1-ben.widawsky@intel.com>
References: <20220413183720.2444089-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Save some characters and directly check decoder type rather than port
type. There's no need to check if the port is an endpoint port since we
already know the decoder, after alloc, has a specified type.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/hdm.c  | 2 +-
 drivers/cxl/core/port.c | 2 +-
 drivers/cxl/cxl.h       | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0e89a7a932d4..bfc8ee876278 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -197,7 +197,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	else
 		cxld->target_type = CXL_DECODER_ACCELERATOR;
 
-	if (is_cxl_endpoint(to_cxl_port(cxld->dev.parent)))
+	if (is_endpoint_decoder(&cxld->dev))
 		return 0;
 
 	target_list.value =
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2ab1ba4499b3..74c8e47bf915 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -272,7 +272,7 @@ static const struct device_type cxl_decoder_root_type = {
 	.groups = cxl_decoder_root_attribute_groups,
 };
 
-static bool is_endpoint_decoder(struct device *dev)
+bool is_endpoint_decoder(struct device *dev)
 {
 	return dev->type == &cxl_decoder_endpoint_type;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 990b6670222e..5102491e8d13 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -340,6 +340,7 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
+bool is_endpoint_decoder(struct device *dev);
 bool is_cxl_decoder(struct device *dev);
 struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 					   unsigned int nr_targets);
-- 
2.35.1

