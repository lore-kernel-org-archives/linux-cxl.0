Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E22C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Jul 2022 17:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiGNRCA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiGNRB7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Jul 2022 13:01:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEBF4E851
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657818117; x=1689354117;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tHk5BFH1Cos/EDervPD2cubzgwZ8SswtlBnR3VA2/Po=;
  b=DAdnFXWPzW1i5OZdWWxmUqTutsBF3w9bSjHOpZkD90BZpuCyrJTQ+vZu
   Ak5HLl0lySe9mh2bYmYj1k3qFRE8LE+2XTGWr04bbA01KJqN1UGsnCK3F
   +EbA91HJRkQKh4cUPLPCjK7M5gnaiLcXnJ+Yak87g82y3fRy0CzGgA1Dk
   LeuBto9pZ/HjWL87bYFRSYAksvaJT9+vMrPmE5SUEAVgiJ7silUBjrbwz
   6FpMMtO3vmFMz7MMjlpRAzeDEVljkl3J5cO2cBfPGFRH5Wpo2Iz9ZZa83
   kO6HFHL57XgbEmPdUC8DFyfB5G3XiyYsTZIAC2KXUpLGUoMuadmT3hDZF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="347254223"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="347254223"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:01:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="623499047"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:01:47 -0700
Subject: [ndctl PATCH v2 00/12] cxl: Region provisioning foundation
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org
Date:   Thu, 14 Jul 2022 10:01:47 -0700
Message-ID: <165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since v1 [1]:
- Update ccan/list to the latest (Ira, Davidlohr)
- Collect some reviewed-bys (Davidlohr)
- Add man pages for cxl {reserve,free}-dpa (Vishal)
- Reflow some clang-format escapes (Vishal)
- Rename test/cxl-create-region.sh to test/cxl-region-sysfs.h (Vishal)
- Use $CXL in cxl-region-sysfs.sh (Vishal)
[1]: https://lore.kernel.org/r/165765284365.435671.13173937566404931163.stgit@dwillia2-xfh/

---

On the way towards a "cxl create-region" command add support for a unit
test of the raw sysfs interfaces used for region provisioning. This
includes support for listing endpoint decoders filtered by their
associated memdev, listing decoders in id order by default, and managing
DPA allocations. Those capabilities plus some other miscellaneous
cleanups are validated in a new 'cxl-region-sysfs.sh' test.

All of the sysfs ABI leveraged in these updates is provided by this
pending series of updates:

https://lore.kernel.org/linux-cxl/165603869943.551046.3498980330327696732.stgit@dwillia2-xfh/

To date that review has not identified any ABI changes so there is a
reasonable chance that this cxl-cli series will not need to be respun to
address a kernel-side change. That said, the kernel changes need to
complete review and enter linux-next before these proposed patches can
be committed to the ndctl project. In the meantime that kernel review
can be helped along by having test/cxl-region-sysfs.sh as an example of
how the ABI is used.

---

Dan Williams (12):
      cxl/list: Reformat option list
      cxl/list: Emit endpoint decoders filtered by memdev
      cxl/list: Hide 0s in disabled decoder listings
      cxl/list: Add DPA span to endpoint decoder listings
      ccan/list: Import latest list helpers
      cxl/lib: Maintain decoders in id order
      cxl/memdev: Fix json for multi-device partitioning
      cxl/list: Emit 'mode' for endpoint decoder objects
      cxl/set-partition: Accept 'ram' as an alias for 'volatile'
      cxl/memdev: Add {reserve,free}-dpa commands
      cxl/test: Update CXL memory parameters
      cxl/test: Checkout region setup/teardown


 .clang-format                           |    1 
 Documentation/cxl/cxl-free-dpa.txt      |   53 +++++
 Documentation/cxl/cxl-reserve-dpa.txt   |   67 +++++++
 Documentation/cxl/cxl-set-partition.txt |    2 
 Documentation/cxl/lib/libcxl.txt        |   13 +
 Documentation/cxl/meson.build           |    2 
 ccan/list/list.h                        |  258 ++++++++++++++++++++++----
 cxl/builtin.h                           |    2 
 cxl/cxl.c                               |    2 
 cxl/filter.c                            |   12 +
 cxl/filter.h                            |    2 
 cxl/json.c                              |   38 +++-
 cxl/lib/libcxl.c                        |  167 +++++++++++++++++
 cxl/lib/libcxl.sym                      |   11 +
 cxl/lib/private.h                       |    3 
 cxl/libcxl.h                            |   34 +++
 cxl/list.c                              |    9 -
 cxl/memdev.c                            |  308 ++++++++++++++++++++++++++++++-
 ndctl/lib/inject.c                      |    1 
 test/cxl-region-sysfs.sh                |  122 ++++++++++++
 test/cxl-topology.sh                    |   32 ++-
 test/meson.build                        |    2 
 util/list.h                             |   63 +++---
 23 files changed, 1102 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/cxl/cxl-free-dpa.txt
 create mode 100644 Documentation/cxl/cxl-reserve-dpa.txt
 create mode 100644 test/cxl-region-sysfs.sh

base-commit: bbb2cb56f08d95ecf2c7c047a33cc3dd64eb7fde
