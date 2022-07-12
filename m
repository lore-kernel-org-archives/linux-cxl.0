Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BFCC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Jul 2022 19:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiGLTbx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Jul 2022 15:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbiGLTbf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Jul 2022 15:31:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A218E4754
        for <linux-cxl@vger.kernel.org>; Tue, 12 Jul 2022 12:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657652847; x=1689188847;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wjsmbeBXwg3Ws8z30RpvRi2AEvpWkmtoACcQP2+Cuu0=;
  b=dVSsX5dQCWDSIrUTdGFQo9Vek+WXXnVSyRKh59p6/YZ7VYjfLlPHlrLf
   CVX1IKlDev1Ej3QkTwhwqALzrktnmGo5Hid54enShW6etILQ3ditXp0Gr
   HeraiXLYck0BwVBrx7NokdKxtw3XUpEj/S7A776DhY6l3Vgt97j5fNF+L
   kq+tWKnKUFPqH6UoVXbSE7omBOeomxuzXjGAmMY1PAYXJx7np1XF3FV8h
   DmBINzFB+l8Cb2CJxI63XCWsomlLanQ4TGrdHod0dPRqvxY6Uby52xXDv
   fAWlJplesCTRxVVQUbJSaoQIf9zmAFPR3HCdX15p7DOTyjKtFAU9Oy8VH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="264810821"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="264810821"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:07:24 -0700
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="599484210"
Received: from sheyting-mobl3.amr.corp.intel.com (HELO [192.168.1.117]) ([10.212.147.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:07:24 -0700
Subject: [ndctl PATCH 00/11] cxl: Region provisioning foundation
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Date:   Tue, 12 Jul 2022 12:07:23 -0700
Message-ID: <165765284365.435671.13173937566404931163.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On the way towards a "cxl create-region" command add support for a unit
test of the raw sysfs interfaces used for region provisioning. This
includes support for listing endpoint decoders filtered by their
associated memdev, listing decoders in id order by default, and managing
DPA allocations. Those capabilities plus some other miscellaneous
cleanups are validated in a new 'cxl-create-region.sh' test.

All of the sysfs ABI leveraged in these updates is provided by this
pending series of updates:

https://lore.kernel.org/linux-cxl/165603869943.551046.3498980330327696732.stgit@dwillia2-xfh/

To date that review has not identified any ABI changes so there is a
reasonable chance that this cxl-cli series will not need to be respun to
address a kernel-side change. That said, the kernel changes need to
complete review and enter linux-next before these proposed patches can
be committed to the ndctl project. In the meantime that kernel review
can be helped along by having test/cxl-region-create.sh as an example of
how the ABI is used.

---

Dan Williams (11):
      cxl/list: Reformat option list
      cxl/list: Emit endpoint decoders filtered by memdev
      cxl/list: Hide 0s in disabled decoder listings
      cxl/list: Add DPA span to endpoint decoder listings
      cxl/lib: Maintain decoders in id order
      cxl/memdev: Fix json for multi-device partitioning
      cxl/list: Emit 'mode' for endpoint decoder objects
      cxl/set-partition: Accept 'ram' as an alias for 'volatile'
      cxl/memdev: Add {reserve,free}-dpa commands
      cxl/test: Update CXL memory parameters
      cxl/test: Checkout region setup/teardown


 .clang-format                           |    1 
 Documentation/cxl/cxl-set-partition.txt |    2 
 Documentation/cxl/lib/libcxl.txt        |   13 +
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
 cxl/memdev.c                            |  304 ++++++++++++++++++++++++++++++-
 test/cxl-region-create.sh               |  122 ++++++++++++
 test/cxl-topology.sh                    |   32 ++-
 test/meson.build                        |    2 
 util/list.h                             |   61 ++++++
 18 files changed, 784 insertions(+), 33 deletions(-)
 create mode 100644 test/cxl-region-create.sh

base-commit: bbb2cb56f08d95ecf2c7c047a33cc3dd64eb7fde
