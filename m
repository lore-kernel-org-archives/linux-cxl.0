Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD48E77347
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Sep 2023 23:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjI2XJ4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Sep 2023 19:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjI2XJz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Sep 2023 19:09:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EABF7
        for <linux-cxl@vger.kernel.org>; Fri, 29 Sep 2023 16:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696028992; x=1727564992;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4mH1m+H45/oAaMzuzdMJu716WCHdaF3Gco4nkLXM1yo=;
  b=F7pWz3/0wZtl+dZ/U/7MOzojDSO4VGd4aoY3lCawAb4OGNb95do2ZLgJ
   yL108lAc3lMV5f6O6cRm1Y94q9P2cfRHpNptDZFXII6mg6EccszQCNeHY
   wehSU8gp5WeP9a1iPMqBGs1ZnZYNSjDL18Z1ee8o1+I6Epv7JY8o/MJSX
   l55jzmws1SF0xuDjt/22JDU7gxR4uIZ+YMLqS54q+NEuqko3tGQ2b+ZJY
   ndS37kQ5jQwE+7isprFUJA0HfP4gaPm2b+68t6+fTjdhpyL0qe/3guWTk
   cY4nceidkCGi/qyg9ZFvY7e0nfGYLnWyYxbumu9tHre75fWA6XcwrARFt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="381279704"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="381279704"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:09:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="743572099"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="743572099"
Received: from thamvo-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.56.79])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:09:50 -0700
Subject: [PATCH v2 4/4] cxl/mem: Fix shutdown order
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, ira.weiny@intel.com
Date:   Fri, 29 Sep 2023 16:09:49 -0700
Message-ID: <169602898991.904193.3059334392093961032.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ira reports that removing cxl_mock_mem causes a crash with the following
trace:

 BUG: kernel NULL pointer dereference, address: 0000000000000044
 [..]
 RIP: 0010:cxl_region_decode_reset+0x7f/0x180 [cxl_core]
 [..]
 Call Trace:
  <TASK>
  cxl_region_detach+0xe8/0x210 [cxl_core]
  cxl_decoder_kill_region+0x27/0x40 [cxl_core]
  cxld_unregister+0x29/0x40 [cxl_core]
  devres_release_all+0xb8/0x110
  device_unbind_cleanup+0xe/0x70
  device_release_driver_internal+0x1d2/0x210
  bus_remove_device+0xd7/0x150
  device_del+0x155/0x3e0
  device_unregister+0x13/0x60
  devm_release_action+0x4d/0x90
  ? __pfx_unregister_port+0x10/0x10 [cxl_core]
  delete_endpoint+0x121/0x130 [cxl_core]
  devres_release_all+0xb8/0x110
  device_unbind_cleanup+0xe/0x70
  device_release_driver_internal+0x1d2/0x210
  bus_remove_device+0xd7/0x150
  device_del+0x155/0x3e0
  ? lock_release+0x142/0x290
  cdev_device_del+0x15/0x50
  cxl_memdev_unregister+0x54/0x70 [cxl_core]

This crash is due to the clearing out the cxl_memdev's driver context
(@cxlds) before the subsystem is done with it. This is ultimately due to
the region(s), that this memdev is a member, being torn down and expecting
to be able to de-reference @cxlds, like here:

static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
...
                if (cxlds->rcd)
                        goto endpoint_reset;
...

Fix it by keeping the driver context valid until memdev-device
unregistration, and subsequently the entire stack of related
dependencies, unwinds.

Fixes: 9cc238c7a526 ("cxl/pci: Introduce cdevm_file_operations")
Reported-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a950091e5640..e78b5ead14fa 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -570,8 +570,8 @@ static void cxl_memdev_unregister(void *_cxlmd)
 	struct cxl_memdev *cxlmd = _cxlmd;
 	struct device *dev = &cxlmd->dev;
 
-	cxl_memdev_shutdown(dev);
 	cdev_device_del(&cxlmd->cdev, dev);
+	cxl_memdev_shutdown(dev);
 	put_device(dev);
 }
 

