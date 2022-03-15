Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E530CC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Mar 2022 01:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiCOBXp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbiCOBXo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Mar 2022 21:23:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72099473AD
        for <linux-cxl@vger.kernel.org>; Mon, 14 Mar 2022 18:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647307354; x=1678843354;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y8/1HRUjhcJVTtZMWkAf15PXRh7NExiq21R5cHxxQ4o=;
  b=NHBCD/cDQiK4wrlV7bSIcmV5rqqVlB3ajQouEmrRvUWek4xoOe5e5emL
   pyO8ejyNy+uVIKr6EdcNxexLzAccTbPZLVuRBac4OFZ/fsL5KgkmiknJW
   G1Aj5n8k6n8lUIop/QUpe1U5t3bpOdvek20s+avDKmfVOuNUBX/80pa43
   Zm5ts6CFyymhbfXV8RGXFSzmPCanTE0ebebB0oBeR5AFtZfX0ETCdLauo
   hxvrBOz2zCgH/1hAdTXahWcK4RosRtD9y5CtCB6YdAbzzlJg+T+chNBlP
   9/BmQEURMLzzGDiu0jmAbUSug9UAAtOBBdMgZhdkyj1B0PMJI4+xhedND
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256137493"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="256137493"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:22:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="690031974"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:22:33 -0700
Subject: [PATCH v2 3/6] cxl/mem: Make cxl_dvsec_range() init failure fatal
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ben.widawsky@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Mon, 14 Mar 2022 18:22:33 -0700
Message-ID: <164730735324.3806189.4167509857771192422.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for the cxl_pci driver to continue operation after
cxl_dvsec_range() failure, update cxl_mem to check for negative error
codes in info->ranges. Treat that condition as fatal regardless of the
state of the HDM configuration since cxl_mem needs positive confirmation
that legacy ranges were not established by platform firmware or another
agent.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index cd4e8bba82aa..50704deb2ff0 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -88,6 +88,9 @@ __mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
 	void __iomem *crb;
 	u32 global_ctrl;
 
+	if (info->ranges < 0)
+		return false;
+
 	/* map hdm decoder */
 	crb = ioremap(cxlds->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
 	if (!crb) {

