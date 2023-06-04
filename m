Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463EAC77B73
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjFDXdA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjFDXc6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:32:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0384AAB
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921576; x=1717457576;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wUCpKLvYj7CL5n3McIfuu3Q3A7p3nT4v3uUTrZHWAiw=;
  b=NQX/Q8jTxvmfsTjQrvtyWwcEdF3SGxnU0a2AbmoC+5fASN7IlAjuIjM+
   QF+tPuJGCeEZoPGJOrygBozfWGfuZvZwLqoXRoK1GFWsR4riXCe6MN7lu
   nTpV9n0GtFOAqs4qs7GGJz205niy+VbWRkWgQHWb9fxQpkOn/HMJZiU6w
   FX3hXu757BdaoHGkqFbCybfEhBsQphNNyVxnB0gnzbAhKWhajJAeTDUnU
   8H/rXsLPRaaN3zD9e2Rt10GkaZ6Y4E2Y8Dm7pPa13kv27uUJNcBEHJST8
   n1pC8sKsaaWyxKEQlIWKN8V5+OAt9aUfgSXKOFZHIGbiltinCIlEq2YQv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="336596824"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="336596824"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="1038572012"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="1038572012"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:56 -0700
Subject: [PATCH 14/19] cxl/region: Clarify locking requirements of
 cxl_region_attach()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:32:56 -0700
Message-ID: <168592157618.1948938.9911784721014622223.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for cxl_region_attach() being called for kernel initiated
region creation, enforce the locking context with explicit lockdep
assertions.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4d8dbfedd64a..defc2f0e43e3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1587,6 +1587,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_dport *dport;
 	int rc = -ENXIO;
 
+	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_read(&cxl_dpa_rwsem);
+
 	if (cxled->mode != cxlr->mode) {
 		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
 			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);

