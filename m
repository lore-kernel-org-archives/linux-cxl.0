Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7151AC43334
	for <linux-cxl@archiver.kernel.org>; Sat, 23 Jul 2022 00:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbiGWA5s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Jul 2022 20:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbiGWA5j (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Jul 2022 20:57:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63F4C7AFC
        for <linux-cxl@vger.kernel.org>; Fri, 22 Jul 2022 17:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658537758; x=1690073758;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4YQNS3F0xSySUbTQo6X6JyG7dbd/gPpCRqhIcxlx4Y4=;
  b=n2jFuUfHG5lGEbNXpebn6iey0Il55415hAr74xkVrqz/CAnGFu8kC4Je
   qoaRbFvaU2h0aRkWhxpD+anaeLqmabsd+YkBWeg7LNMCd5TsfH0ezO6+t
   Kks4C4xw4fd4L6l2Lr7hIkNez8T0HM7BU3oLRuexEjBD1n8/QN7MtuD0n
   3EwVhHZtO4oVbuetHLa32XfAlCuTlmM+oTeGVs3Qc/5hpLd6WD5RNAGD6
   2X4JGe+khzO7PbrAVStuCcEhfz/BL/Ubp3p+LpxmuKhd0imGBlnXdHikE
   vkA2nmIoCFcJFUdxqx6bZTF+YXIf5c28Fit6bVpyATqV+Y+1m3HyOSOj6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="267206907"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="267206907"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 17:55:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="657415706"
Received: from jeescalx-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.116.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 17:55:52 -0700
Subject: [PATCH 0/5] CXL Region Provisioning Fixes
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Date:   Fri, 22 Jul 2022 17:55:52 -0700
Message-ID: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Here is a small collection of fixes that have cropped after cutting the
new cxl/pending baseline.

The first is just a module loading fixup to make it possible to run
cxl_test on a system without an ACPI0017 device to preload the cxl_acpi
driver.

Patch 2 cleans up an attribute that is relevant for all decoders
*except* root decoders.

Patch 3 cleans up ACPI CFMWS implementations that specify a region
granularity other than the minimum when cross-host-bridge interleaving
is disabled.

The final patches are the meat of the fixes to constrain the interleave
granularity settings to ones that do not cause aliasing or DPA decode
gaps. See the details in patch 5. Expect more of these fixups as the
testing continues to mature.

---

Dan Williams (5):
      cxl/acpi: Autoload driver for 'cxl_acpi' test devices
      cxl/region: Delete 'region' attribute from root decoders
      cxl/acpi: Minimize granularity for x1 interleaves
      cxl/region: Stop initializing interleave granularity
      cxl/region: Constrain region granularity scaling factor


 drivers/cxl/acpi.c        |   13 +++++++++
 drivers/cxl/core/port.c   |    3 +-
 drivers/cxl/core/region.c |   65 ++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 75 insertions(+), 6 deletions(-)

base-commit: b282b26d11c50d48b336fedb5f74b2eca3f7b94c
