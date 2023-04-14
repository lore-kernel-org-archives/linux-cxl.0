Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFB0C77B73
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 17:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjDNRno (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDNRnO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 13:43:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2263A88
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681494193; x=1713030193;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LM1J0ddUuYBjvmEvhI/B9qK+l/HeHL1N9yYn79jgzAY=;
  b=Nt7RejF0S4QKDVXE9TuVaNWEGNGX7Tga3YWE3QPpSiI995aOn4TS+qvu
   4O/un+Y2/u0rOAt/LQrC86fwu07rMyW0dXeI2IYTTzXYzOOhOoCsXojBL
   EmsY0keOqyRAhVVkmUZXJgOlbDiKGjIYP4IEUh2sFTzt1iLI8uxAUGXfE
   Szs01GKbcX54F486RNOnQDq4dU1Q98b7+OvzoMMxiGfEW/51TCb26Y8OS
   a1DbovMJKpEcbeEgyHKZyUGg1oTBx9gJRfVKA5ushsBmAf1sJwbFTVLqT
   125cTkxlCTvqKgf1lmnUJ0Y6p5UhpqzzPHODZVmjQbzUn1qQf+gZm0OSQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="347247082"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="347247082"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 10:43:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="801281263"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="801281263"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.122.87])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 10:43:13 -0700
Subject: [NDCTL PATCH 3/3] ndctl: add QTG ID check for region creation
From:   Dave Jiang <dave.jiang@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org
Date:   Fri, 14 Apr 2023 10:43:13 -0700
Message-ID: <168149419300.4013891.8422712235685320038.stgit@djiang5-mobl3>
In-Reply-To: <168149412855.4013891.16386221304030694671.stgit@djiang5-mobl3>
References: <168149412855.4013891.16386221304030694671.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The CFMWS provides a QTG ID. The kernel driver creates a root decoder that
represents the CFMWS. A qtg_id attribute is exported via sysfs for the root
decoder.

A QTG id is retrieved via QTG ID _DSM from the ACPI0017 device for a CXL
memory device. The input for the _DSM is the read and write latency and
bandwidth for the path between the device and the CPU. The numbers are
constructed by the kernel driver for the _DSM input. When a device is
probed, the QTG ID is retrieved. This is useful for a hot-plugged CXL
memory device that does not have regions created.

Add a check for config check during region creation. Emit a warning if the
QTG ID from the root decoder is different than the mem device QTG ID. User
parameter options are provided to fail instead of just warning.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/cxl/cxl-create-region.txt |    9 +++++
 cxl/region.c                            |   57 ++++++++++++++++++++++++++++++-
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/Documentation/cxl/cxl-create-region.txt b/Documentation/cxl/cxl-create-region.txt
index f11a412bddfe..9ab2e0fee152 100644
--- a/Documentation/cxl/cxl-create-region.txt
+++ b/Documentation/cxl/cxl-create-region.txt
@@ -105,6 +105,15 @@ include::bus-option.txt[]
 	supplied, the first cross-host bridge (if available), decoder that
 	supports the largest interleave will be chosen.
 
+-e::
+--strict::
+	Enforce strict execution where any potential error will force failure.
+	For example, if QTG ID mismatches will cause failure.
+
+-q::
+--no-enforce-qtg::
+	Parameter to bypass QTG ID mismatch failure. Will only emit warning.
+
 include::human-option.txt[]
 
 include::debug-option.txt[]
diff --git a/cxl/region.c b/cxl/region.c
index 07ce4a319fd0..6f611799f39f 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -31,6 +31,8 @@ static struct region_params {
 	bool force;
 	bool human;
 	bool debug;
+	bool strict;
+	bool no_qtg;
 } param = {
 	.ways = INT_MAX,
 	.granularity = INT_MAX,
@@ -48,6 +50,8 @@ struct parsed_params {
 	const char **argv;
 	struct cxl_decoder *root_decoder;
 	enum cxl_decoder_mode mode;
+	bool strict;
+	bool no_qtg;
 };
 
 enum region_actions {
@@ -80,7 +84,9 @@ OPT_STRING('U', "uuid", &param.uuid, \
 	   "region uuid", "uuid for the new region (default: autogenerate)"), \
 OPT_BOOLEAN('m', "memdevs", &param.memdevs, \
 	    "non-option arguments are memdevs"), \
-OPT_BOOLEAN('u', "human", &param.human, "use human friendly number formats")
+OPT_BOOLEAN('u', "human", &param.human, "use human friendly number formats"), \
+OPT_BOOLEAN('e', "strict", &param.strict, "strict execution enforcement"), \
+OPT_BOOLEAN('q', "no-enforce-qtg", &param.no_qtg, "no enforce of QTG ID")
 
 static const struct option create_options[] = {
 	BASE_OPTIONS(),
@@ -357,6 +363,9 @@ static int parse_create_options(struct cxl_ctx *ctx, int count,
 		}
 	}
 
+	p->strict = param.strict;
+	p->no_qtg = param.no_qtg;
+
 	return 0;
 }
 
@@ -460,6 +469,50 @@ static void set_type_from_decoder(struct cxl_ctx *ctx, struct parsed_params *p)
 		p->mode = CXL_DECODER_MODE_PMEM;
 }
 
+static int create_region_validate_qtg_id(struct cxl_ctx *ctx,
+					 struct parsed_params *p)
+{
+	int root_qtg_id, dev_qtg_id, i;
+
+	root_qtg_id = cxl_decoder_get_qtg_id(p->root_decoder);
+	if (root_qtg_id == -1)
+		return 0;
+
+	for (i = 0; i < p->ways; i++) {
+		struct json_object *jobj =
+			json_object_array_get_idx(p->memdevs, i);
+		struct cxl_memdev *memdev = json_object_get_userdata(jobj);
+
+		if (p->mode == CXL_DECODER_MODE_RAM)
+			dev_qtg_id = cxl_memdev_get_ram_qtg_id(memdev);
+		else
+			dev_qtg_id = cxl_memdev_get_pmem_qtg_id(memdev);
+
+		if (dev_qtg_id == -1)
+			return 0;
+
+		if (root_qtg_id != dev_qtg_id) {
+			if (p->strict && !p->no_qtg) {
+				log_err(&rl, "%s QTG ID %d mismatch %s QTG ID %d\n",
+					cxl_decoder_get_devname(p->root_decoder),
+					root_qtg_id,
+					cxl_memdev_get_devname(memdev),
+					dev_qtg_id);
+
+				return -ENXIO;
+			} else {
+				log_notice(&rl, "%s QTG ID %d mismatch %s QTG ID %d\n",
+					   cxl_decoder_get_devname(p->root_decoder),
+					   root_qtg_id,
+					   cxl_memdev_get_devname(memdev),
+					   dev_qtg_id);
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int create_region_validate_config(struct cxl_ctx *ctx,
 					 struct parsed_params *p)
 {
@@ -500,6 +553,8 @@ found:
 		return rc;
 
 	collect_minsize(ctx, p);
+	create_region_validate_qtg_id(ctx, p);
+
 	return 0;
 }
 


