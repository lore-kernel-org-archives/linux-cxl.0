Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F3EC433DB
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 21:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A910A61A2A
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 21:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbhCXVCM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Mar 2021 17:02:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:37999 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238274AbhCXVCI (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 24 Mar 2021 17:02:08 -0400
IronPort-SDR: 3mSFtaHGFVhN7eJi/9sQnHnnYnpWREreVgvonCZctDvkAqYt/e4JLWvwr4rfhSBYJE8FXtx0SN
 l8AYESwuVL/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="275911419"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="275911419"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:02:07 -0700
IronPort-SDR: uPn7bLlOSm7iA8LC2fNNvQHT3Li6FIjKf8lCMfiF5IOfUkpWMo2/IQrkeDgvrzvvpEk5WUG0/4
 EcxqC89tD9pg==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="374788401"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:02:07 -0700
Subject: [PATCH 4/4] cxl/mem: Disable cxl device power management
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 14:02:07 -0700
Message-ID: <161661972722.1721612.7220170912347353657.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

There is no power management of cxl virtual devices, disable
device-power-management and runtime-power-management to prevent
userspace from growing expectations of those attributes appearing. They
can be added back in the future if needed.

Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index d615f183520c..338923a6b2ef 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1204,6 +1204,7 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
 	dev->type = &cxl_memdev_type;
+	device_set_pm_not_required(dev);
 
 	cdev = &cxlmd->cdev;
 	cdev_init(cdev, &cxl_memdev_fops);

