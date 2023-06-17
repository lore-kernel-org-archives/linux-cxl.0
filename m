Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A44BEB64D7
	for <linux-cxl@archiver.kernel.org>; Sat, 17 Jun 2023 01:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjFQBYZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 21:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFQBYZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 21:24:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430E43AAE
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 18:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686965064; x=1718501064;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F2vmgFrxJtnx6UtekeXOBCWyhlhdaEetBiFYdtIpjcc=;
  b=aMf5KM5SY6ps9pZkR464+chlhzn42b3ShvNwsIH7e7ZuoGPO/by0+hyz
   HSsBQh8FXSftsWiTi052OnpRU9tkht89dvhWxz0wASto7CtH3YNWS2DsX
   dEowHigKkNNfH4OIFGEHtWF0/VeXRUlu11geTPxVPqIs+ZRJ2RQVX1zTm
   xWWBhNIBAhvaMBBl1//vHH7KOFr3vBEc/qs7vGVHEPY3/d1O5/VnWyYYJ
   Kg/fzFUwCvxOdigiULzd/w/zoQKFC4jZR55mwNrppcbi3A2eamdh77evn
   b4eZsY09lpSCsCeRoGIoxSqarHbJZjE0E1sh3434xVUd2/x64HBLF3ozR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="362762324"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="362762324"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 18:24:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="713073278"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="713073278"
Received: from slovely-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.23.80])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 18:24:23 -0700
Subject: [PATCH 0/3] cxl/region: Cache management and region decode reset
 fixes
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vikram Sethi <vsethi@nvidia.com>
Date:   Fri, 16 Jun 2023 18:24:23 -0700
Message-ID: <168696506332.3590522.12981963617215460385.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A recent conversation [1] highlighted the fact that the current location of
cache management could cause problems for reconfiguring persistent
memory devices, or accelerators in the future.

As that touches paths near cxl_region_decode_reset() it reminded me of a
pending bug in that area around handling reset failures [2]. Further details
in the patches.

[1]: http://lore.kernel.org/r/BYAPR12MB33364B5EB908BF7239BB996BBD53A@BYAPR12MB3336.namprd12.prod.outlook.com
[2]: http://lore.kernel.org/r/20230316171441.0000205b@Huawei.com

---

Dan Williams (3):
      cxl/region: Move cache invalidation before region teardown, and before setup
      cxl/region: Flag partially torn down regions as unusable
      cxl/region: Fix state transitions after reset failure


 drivers/cxl/core/region.c |  102 ++++++++++++++++++++++++++++-----------------
 drivers/cxl/cxl.h         |   16 ++++---
 2 files changed, 72 insertions(+), 46 deletions(-)
