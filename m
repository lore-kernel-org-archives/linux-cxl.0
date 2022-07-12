Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B639C43334
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Jul 2022 19:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiGLTcm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Jul 2022 15:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiGLTcX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Jul 2022 15:32:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92622E306D
        for <linux-cxl@vger.kernel.org>; Tue, 12 Jul 2022 12:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657652890; x=1689188890;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZvrC3mmiPP30mAag7bEeXLiQg6Z2z4V+u6rk/1eZaa0=;
  b=IiJbJ7IzGYa0SzAjREDMsKf+9vOF6D9DgxXXx9z31o15/P7j+DMGEf+C
   3BSng+MQVXvxh/p4eCFjMMiYs2sSBiCH6UVXTkBOjtobID0xQQK953C4c
   yt68QrIiKtkTZqYx2RBBYXsIgJtAuFm3pmXcOyymvZIbmdPZ7+jAZQqqT
   D9XcnAsxwCxuAvgYr233SSl9LhAGGr1AWWBXBLQ3K2xfiqx5Yz/1DoQPH
   1P+Jr+nUG9rNdrHsG7Twp+Vtk78SPA9hnFE/bcjhO35dpEFblNQ9FIgH+
   3WSutcd1xYpYK3sxDkcXrnK31Zpj2dA6b2oWFQ6/FoLG6X3/Alc7ttZCw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="285047602"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="285047602"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:08:10 -0700
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="653039516"
Received: from sheyting-mobl3.amr.corp.intel.com (HELO [192.168.1.117]) ([10.212.147.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:08:10 -0700
Subject: [ndctl PATCH 08/11] cxl/set-partition: Accept 'ram' as an alias for
 'volatile'
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Date:   Tue, 12 Jul 2022 12:08:09 -0700
Message-ID: <165765288979.435671.2636624998478988147.stgit@dwillia2-xfh>
In-Reply-To: <165765284365.435671.13173937566404931163.stgit@dwillia2-xfh>
References: <165765284365.435671.13173937566404931163.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

'ram' is a more convenient shorthand for volatile memory.

Cc: Alison Schofield <alison.schofield@intel.com>
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

