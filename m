Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFA0C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 12 May 2022 18:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357367AbiELSOm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 May 2022 14:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357498AbiELSOj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 May 2022 14:14:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C2625F7B2
        for <linux-cxl@vger.kernel.org>; Thu, 12 May 2022 11:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652379279; x=1683915279;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dBgBgy4pOXd+QDY25scfl9Za5Fp+BzOhmlMMwOvxE/g=;
  b=h/GBgr/C29L7r64X5GFLdc9NduDuqKnILOZ8cnEIYen5aXErEZ4ttCBf
   ku1xzaLLAxwGlrjCRGYzUyfLgMLa/dxx0ckIkG4na+q6d42pFS1seZJH/
   BReMOShIPVn2flvY4cvYyI4zSQPkpavp+1eOnwpRhnBrbOZ+6Z1TbZgBy
   YK7z1aOPzZxaIAjsZCdmqQe5da9QIfuW0uD6X64nuDc2hS7KOTfGCjODG
   yQsZyYHDPEH9vJNhHAGtjT8DjOYEixXCq568W5M30a7yfHAwX0hnWnoJ6
   bMfJ4FYOuFf6D5KXzVvj0GW0QWgclLdfgqeWjzCDZw1ndingl2CGvte3f
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="333132630"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="333132630"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:14:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="712038123"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:14:38 -0700
Subject: [PATCH 04/14] cxl/mem: Fix cxl_mem_probe() error exit
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan.Cameron@huawei.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com
Date:   Thu, 12 May 2022 11:14:37 -0700
Message-ID: <165237927776.3832067.18030972182050637940.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The addition of cxl_mem_active() broke error exit scenarios for
cxl_mem_probe(). Return early rather than proceed with disabling suspend.

Fixes: 9ea4dcf49878 ("PM: CXL: Disable suspend")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 7622cfefa1b0..fed7f10ef9b2 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -178,6 +178,8 @@ static int cxl_mem_probe(struct device *dev)
 out:
 	device_unlock(&parent_port->dev);
 	put_device(&parent_port->dev);
+	if (rc)
+		return rc;
 
 	/*
 	 * The kernel may be operating out of CXL memory on this device,

