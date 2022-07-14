Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEF0C43334
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Jul 2022 17:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbiGNRDH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240133AbiGNRDC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Jul 2022 13:03:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83D75C37C
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 10:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657818181; x=1689354181;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d6ApsR6hlkYxBPeMgixmyfChQYOVY7n3l02N3ta4pdo=;
  b=LXyivYRETwIMT62m+GpTOJjWmp5cN0vokS4zjHzpdgJWeAog+gVr160l
   58R2VIUK5TUjb+bzJJObVDYtH0opGY0Tj9MjcTsoWOGWEs3AIJCWp8F8i
   vtq8AlmW8N5HlifxwWBdKv9PMX5qnwSUvjESBK8J5TildIG0T1A6pvgyY
   /KkmKRGWgN58UabUE12Td2Dd6umEDlnc02cBhJAnB1VYhawn+LW5EyJzE
   X2d8LPBcIwBzEee5xbAelhPIBmP2EiznaqoBT3WvyVnvM1ctKuba4nd8o
   IIOaJ4VXiemMWCQQnJgP+a0ddfexl6TcNfMr8DC/win3W+mKQ2ohluhnU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286316862"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="286316862"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:02:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="593438298"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:02:39 -0700
Subject: [ndctl PATCH v2 09/12] cxl/set-partition: Accept 'ram' as an alias
 for 'volatile'
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org
Date:   Thu, 14 Jul 2022 10:02:38 -0700
Message-ID: <165781815878.1555691.12251226240559355924.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com>
References: <165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

'ram' is a more convenient shorthand for volatile memory.

Cc: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/cxl-set-partition.txt |    2 +-
 cxl/memdev.c                            |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/cxl/cxl-set-partition.txt b/Documentation/cxl/cxl-set-partition.txt
index 1e548af77da2..f0126daf808b 100644
--- a/Documentation/cxl/cxl-set-partition.txt
+++ b/Documentation/cxl/cxl-set-partition.txt
@@ -37,7 +37,7 @@ include::memdev-option.txt[]
 
 -t::
 --type=::
-	Type of partition, 'pmem' or 'volatile', to modify.
+	Type of partition, 'pmem' or 'ram' (volatile), to modify.
 	Default: 'pmem'
 
 -s::
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 9fcd8ae5724b..1cecad2dba4b 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -65,7 +65,7 @@ OPT_BOOLEAN('f', "force", &param.force,                                \
 
 #define SET_PARTITION_OPTIONS() \
 OPT_STRING('t', "type",  &param.type, "type",			\
-	"'pmem' or 'volatile' (Default: 'pmem')"),		\
+	"'pmem' or 'ram' (volatile) (Default: 'pmem')"),		\
 OPT_STRING('s', "size",  &param.size, "size",			\
 	"size in bytes (Default: all available capacity)"),	\
 OPT_BOOLEAN('a', "align",  &param.align,			\
@@ -355,6 +355,8 @@ static int action_setpartition(struct cxl_memdev *memdev,
 			/* default */;
 		else if (strcmp(param.type, "volatile") == 0)
 			type = CXL_SETPART_VOLATILE;
+		else if (strcmp(param.type, "ram") == 0)
+			type = CXL_SETPART_VOLATILE;
 		else {
 			log_err(&ml, "invalid type '%s'\n", param.type);
 			return -EINVAL;

