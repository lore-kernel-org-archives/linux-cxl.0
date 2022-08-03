Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AB7C19F28
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 07:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiHCHYT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 03:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiHCHYT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 03:24:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BAC1CFF8
        for <linux-cxl@vger.kernel.org>; Wed,  3 Aug 2022 00:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659511458; x=1691047458;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mxX8Yjz/W3pkKIcG1rQ4RjVbBD9Kv2sVw8P/ffdrju0=;
  b=cHMF5oZ8t95t7P1wmedwu1x4Mt/Zxin/wgHpf45pCKf2LlQnV40CDzmE
   gn1sKL2FaxRb1795G/SZiOb7JKfyPa7pVS7r5oZR39TsZY8GwE11RntBr
   0sUmaj49v8YK0LbJ9B9wM/J6aMhuFUmCjyvQ08AgSDkMGx0x5RLku2563
   ZALUIP71kPxzTE3thoRVO3d38Cq1/T16NqVqnqNkLgVKnlpU0bMq7Cfje
   zhqeisxXOWAC6bNcb9e+SOO9YM8+oHWuMpE2XLZVoNrsPBkyVf5/I4XWR
   GSPXMm7XfJKTwhDqyjWeutjn6FfofPBLJjp8epYmdkYEGYXoKx5hZDeVE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="289618867"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="289618867"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 00:24:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="692146251"
Received: from jplumb-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.28.212])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 00:24:17 -0700
Subject: [PATCH 0/4] cxl/region: Endpoint decoder fixes
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kernel test robot <lkp@intel.com>, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        dave.jiang@intel.com
Date:   Wed, 03 Aug 2022 00:24:17 -0700
Message-ID: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

It turns out that the driver was only programming "mid-level" decoders
and not endpoint decoders. This was missed because the default settings
still allowed traffic to flow, just not to the expected DPA, and not
without aliasing.

The following fixes address that problem, but this still wants a test
environment that validates the expected DPA relative to a given HPA.
Jonathan caught this bug while trying to develop such an environment for
QEMU, but this likely also wants a cxl_test scheme to do the same. In
the meantime here is the fixup to program interleave ways + granularity
and some miscellaneous fixups for build robot reports.

These apply against current cxl/pending.

---

Dan Williams (4):
      cxl/region: Fix decoder interleave programming
      cxl/region: Move HPA setup to cxl_region_attach()
      cxl/region: Fix port setup uninitialized variable warnings
      cxl/region: Fix region commit uninitialized variable warning


 drivers/cxl/core/hdm.c    |   17 ++---------------
 drivers/cxl/core/region.c |   36 +++++++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 24 deletions(-)

base-commit: 65fc1c3d26b96002a5aa1f4012fae4dc98fd5683
