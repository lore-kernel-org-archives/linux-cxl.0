Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD62C4332F
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Nov 2022 23:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKFXqs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Nov 2022 18:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKFXqr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Nov 2022 18:46:47 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71021D2C8
        for <linux-cxl@vger.kernel.org>; Sun,  6 Nov 2022 15:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667778406; x=1699314406;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uHK2YYam8c0ncpmQvoPPHnkfE14o3EJbSBCJT0s93Ak=;
  b=f+r70VwIGw1MuPI/dEqBuLovhgbbN+PV+VDWVF5VNcx3ZqMMATTxfr1l
   XzbtvCnB6izLIWKA1rC60T/eDCKPR8sM+QI2qw2L183HCPqCEPSqMpxSa
   sXd8I7vfyylqQnEu0GFCkbUlvBWeRQIjUaF8wVIMygZosMQA8MRPAlnh5
   jXcAcBCaZylpvdQgnXxFFKyyjSGA90mg6nreVa/iXBUQUsMiXdO2uGYC0
   buANjHlH1c/tkzlScQ7KH4/fOz3g/FpSumFXk2HVPEgYJgt+VxGDcvrvO
   Fi8pCX5wpc/C37clAVZORxaOUiSHbOEKptzXpBkXi4sZqnwcMtTnyIzp0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="337007897"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="337007897"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:46:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="638172114"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="638172114"
Received: from durgasin-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.240.219])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 15:46:45 -0800
Subject: [ndctl PATCH 00/15] cxl-cli test and usability updates
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 06 Nov 2022 15:46:45 -0800
Message-ID: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The v6.1-rc4 kernel picks up new cxl_test infrastructure for a switch
attached to a single-port host-bridge. While extending the region
creation and topology tests for that change, some additional updates
were identified. The main one is the ability to elide the "ways"
"memdevs" arguments to 'cxl create-region'. Those parameters are now
derived by the result of a topology walk under the given root decoder.
I.e.:

    cxl create-region -d decoder3.4

...will internally perform a:

    cxl list -M -d decoder3.4

...operation and use those memdevs as region targets.

This also updates 'create-region' size detection to be maximum free
extent in the decoder, or the available capacity in the target memdevs,
whichever is smaller.

Some miscellaneous fixes and updates are included as well.

---

Dan Williams (15):
      ndctl/test: Move firmware-update.sh to the 'descructive' set
      ndctl/test: Add kernel backtrace detection to some dax tests
      ndctl/clang-format: Move minimum version to 6
      ndctl/clang-format: Fix space after for_each macros
      cxl/list: Always attempt to collect child objects
      cxl/list: Skip emitting pmem_size when it is zero
      cxl/filter: Return json-c topology
      cxl/list: Record cxl objects in json objects
      cxl/region: Make ways an integer argument
      cxl/region: Make granularity an integer argument
      cxl/region: Use cxl_filter_walk() to gather create-region targets
      cxl/region: Trim region size by max available extent
      cxl/region: Default to memdev mode for create with no arguments
      cxl/test: Extend cxl-topology.sh for a single root-port host-bridge
      cxl/test: Test single-port host-bridge region creation


 .clang-format             |   38 ++---
 cxl/filter.c              |   36 +----
 cxl/filter.h              |   22 +++
 cxl/json.c                |   29 +++-
 cxl/list.c                |    7 +
 cxl/region.c              |  346 +++++++++++++++++++++++++++------------------
 test/common               |   10 +
 test/cxl-create-region.sh |   28 ++++
 test/cxl-region-sysfs.sh  |    4 -
 test/cxl-topology.sh      |   53 ++++---
 test/dax.sh               |    2 
 test/daxdev-errors.sh     |    2 
 test/meson.build          |    2 
 test/multi-dax.sh         |    2 
 14 files changed, 363 insertions(+), 218 deletions(-)

base-commit: 1d4dbf6ff6eb988864d154792aaa098a2b11a244
