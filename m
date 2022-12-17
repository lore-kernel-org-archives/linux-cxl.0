Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36049C4332F
	for <linux-cxl@archiver.kernel.org>; Sat, 17 Dec 2022 01:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiLQBdl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Dec 2022 20:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLQBdk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Dec 2022 20:33:40 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E080D7332C
        for <linux-cxl@vger.kernel.org>; Fri, 16 Dec 2022 17:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671240818; x=1702776818;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=jubWLOBUyOmhiJkbWEc3d2/yMX1W4/AWN5ZdeNYZllg=;
  b=AFTvg/tZ6PBNiH9kvGm43QeQM0vhpV6hWKs8cmim5qWBWrjL85nYuyEC
   UmP3M2L3sOwYzfVf+To/gI/VmdlnftdDKj3fXIzG6J6m0qEbBxXJ8mdAf
   mWyD973uvXJWDdCQoZ8YsVRKjRb3P02m9TA+f7ashrvkTp/v+TAfZvOd1
   y9qZd49BoHlAA5FmdubxjL/aq7NaTjFfwRxyhyf1AlQSmizt4pAr10sA6
   iZUMM8Ca10NKxYO5ONtXue15oSLFnQKTG07JPPKWP2foIBvvELgiXVHuI
   P5iihR45AdcVnEd+8YKo2ZgGKAzob5Prc1R+PuFK78uwq36KYcdUlIQcX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="302513798"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="302513798"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 17:33:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="649993079"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="649993079"
Received: from smukhe4-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.110.159])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 17:33:38 -0800
Subject: [PATCH 2/3] cxl/region: Clarify when a cxld->commit() callback is
 mandatory
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Date:   Fri, 16 Dec 2022 17:33:38 -0800
Message-ID: <167124081824.1626103.1555704405392757219.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
References: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Both cxl_switch_decoders() and cxl_endpoint_decoders() are considered by
cxl_region_decode_commit(). Flag cases where cxl_switch_decoders with
multiple targets, or cxl_endpoint_decoders do not have a commit callback
set. The switch case is unlikely to happen since switches are only
enumerated by the CXL core, but the endpoint case may support decoders
defined by drivers outside of drivers/cxl, like accerator drivers.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c11a6ab5e48d..60828d01972a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -156,6 +156,22 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 	return 0;
 }
 
+static int commit_decoder(struct cxl_decoder *cxld)
+{
+	struct cxl_switch_decoder *cxlsd = NULL;
+
+	if (cxld->commit)
+		return cxld->commit(cxld);
+
+	if (is_switch_decoder(&cxld->dev))
+		cxlsd = to_cxl_switch_decoder(&cxld->dev);
+
+	if (dev_WARN_ONCE(&cxld->dev, !cxlsd || cxlsd->nr_targets > 1,
+			  "->commit() is required\n"))
+		return -ENXIO;
+	return 0;
+}
+
 static int cxl_region_decode_commit(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
@@ -174,8 +190,7 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 		     iter = to_cxl_port(iter->dev.parent)) {
 			cxl_rr = cxl_rr_load(iter, cxlr);
 			cxld = cxl_rr->decoder;
-			if (cxld->commit)
-				rc = cxld->commit(cxld);
+			rc = commit_decoder(cxld);
 			if (rc)
 				break;
 		}

