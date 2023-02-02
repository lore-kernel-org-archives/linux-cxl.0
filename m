Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D346BC61DA4
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 20:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjBBU4w (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 15:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBBU4t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 15:56:49 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74FA8692
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 12:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675371408; x=1706907408;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZFUwU3TZtHxOAeWJmjwXZ5BEGZIVE58r8GafhRWlncM=;
  b=YwwsoE7+E0ezWpsntQJpTC4P7VSS+60dC4HOnKQNAw1b9xnSB7GBnGl2
   ykNuuOvhVCYeRyDt8mMxetc/AjWQeqjLek2DlToDl3PaTkxH5hxEbw9AG
   cyOQXKJENXFFx+M7zGBx1LD9OJz7QIe/P6jcdTQcolwe8YE2IAJlAdHkd
   pZdegRg116lXOeneFHuILAu/Y0/mEo2VDFqSiZ4VvxsD4X6tOwvQaGXut
   HvMn4T2k5y5T2RQFOM4yKRv+XXZdgoaPTuYKO+ypKJUxh9P7OvbgEqkl4
   CAn3hFZIa7hruq1KQ8CnKABiSpCEnJf95xVXUKZruDCMHCBvA1SyZDiyJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="328586545"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="328586545"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 12:56:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="754204483"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="754204483"
Received: from rcoolman-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.163.245])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 12:56:48 -0800
Subject: [PATCH] daxctl: Fix memblock enumeration off-by-one
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Date:   Thu, 02 Feb 2023 12:56:47 -0800
Message-ID: <167537140762.3268840.2926966718345830138.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A memblock is an inclusive memory range. Bound the search by the last
address in the memory block.

Found by wondering why an offline 32-block (at 128MB == 4GB) range was
reported as 33 blocks with one online.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 daxctl/lib/libdaxctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 5703992f5b88..d990479d8585 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1477,7 +1477,7 @@ static int memblock_in_dev(struct daxctl_memory *mem, const char *memblock)
 		err(ctx, "%s: Unable to determine resource\n", devname);
 		return -EACCES;
 	}
-	dev_end = dev_start + daxctl_dev_get_size(dev);
+	dev_end = dev_start + daxctl_dev_get_size(dev) - 1;
 
 	memblock_size = daxctl_memory_get_block_size(mem);
 	if (!memblock_size) {

