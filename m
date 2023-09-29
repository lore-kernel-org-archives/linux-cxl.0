Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A61E743ED
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Sep 2023 05:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjI2Fa1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Sep 2023 01:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2Fa0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Sep 2023 01:30:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6C2195
        for <linux-cxl@vger.kernel.org>; Thu, 28 Sep 2023 22:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695965425; x=1727501425;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2QlXSzCrhD+1pY+xnTXcqQVMW0sVWi8ud0y2kmXOCG4=;
  b=V1pjbI+k2ufnkyq76CmAha+UluR+2YSSrkxhtsP8Bxsh+ua4sgvxOEPA
   WMXpsAIlaL8p2tWNo+mKcq9UZ6yBbrcVPULVbEsrRVz6vjePj5/fnt3ja
   7kNOGj5VRHetKoQzcAR0Syw6pglVBomgVr5Skk6LhGYxTCtG/mhGwQKJv
   Zw8bsRx4tvAqROEYSwksNIpRvDAzU2Dd312U44jr4YhEJaFl4V1XDNqBU
   H0dlsDcHdTsE0wnAmvAZncTWPJgb7vIPMWyFBwqbikHQjmyJPBE3lDkVF
   YzjdKOJTckvjhejFJwEQ6XJzxNX1ik+9Dt2K0CXuBIUOQ0Y1kWr3Oltp9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="361613083"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="361613083"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 22:30:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="815497669"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="815497669"
Received: from mathewsj-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.193.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 22:30:23 -0700
Subject: [PATCH] cxl/mem: Fix shutdown order
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 28 Sep 2023 22:30:23 -0700
Message-ID: <169596542307.790108.11339208844199665348.stgit@dwillia2-xfh.jf.intel.com>
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
(@cxlds) before the driver is done with it. Fix it by keeping the driver
context valid until device unregistration completes.

Fixes: 9cc238c7a526 ("cxl/pci: Introduce cdevm_file_operations")
Reported-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 14b547c07f54..92d40c5e7efb 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -580,8 +580,8 @@ static void cxl_memdev_unregister(void *_cxlmd)
 	struct cxl_memdev *cxlmd = _cxlmd;
 	struct device *dev = &cxlmd->dev;
 
-	cxl_memdev_shutdown(dev);
 	cdev_device_del(&cxlmd->cdev, dev);
+	cxl_memdev_shutdown(dev);
 	put_device(dev);
 }
 

