Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB58C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Nov 2022 04:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiKREdi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKREdf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Nov 2022 23:33:35 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECA6B1D1
        for <linux-cxl@vger.kernel.org>; Thu, 17 Nov 2022 20:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668746013; x=1700282013;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=izXyuujXaOAexiCDRJBiiQmrN/Pfe/ZOca1M6738Siw=;
  b=Og1+ma09znVG0a/L+XC0m3m/qTL06cjpsuMo3PVjcmrI8xjdy8ycpvj7
   aHQGPGrfHliJkACLp0MTLYh7+xRo9ryhjYuUnd83/L3cwEkm61FM+V6dq
   2G9ZZ6o+/MKEr07tVNaReH5dQ2jgWzSXkHO2WEDywU/iw/sQGWw+hzwN/
   AQg2dcBuCwuZbtVm+MJewlKvcpF31/WqyvfbU0mk717X9x7RoXShQ/Rva
   SBFyJ7h/LtJhEbT7w+Vz18i64FRMW/xMJnaqUPFwj53yu17T5Xq/F5jv/
   NPG6Nc7lc7OjmJTy0hpROtScW7x8oYGB901vDeLfzG2be2omWK+Kv0Ebe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="377321659"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="377321659"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 20:33:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="634304312"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="634304312"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.84.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 20:33:31 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v7 0/3] CXL XOR Interleave Arithmetic
Date:   Thu, 17 Nov 2022 20:33:26 -0800
Message-Id: <cover.1668745515.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Changes in v7:
- Set calc_hb only once (DavidL, Dan)
- Refactor to eliminate the decoder_add goto (DavidL)
- dev_err() and fail on unknown interleave arithmetic (DavidL)
- Add NULL check after devm_zalloc() of cximsd (DavidL)
- Rename struct cxims_data cxl_cxims_data

Changes in v6:
- Rebase on 6.1-rc4, merging with Dan's latest cxl_test work.
- ACPI patch is now the 'official' linuxized version, not yet merged.

Changes in v5:
- Add to 'n' for 6 & 12 way. (v3->v4 broke it)
- Clean up x3 index init. (Dan)
- Remove unneeded HB's from cxl_test topology.
- Remove dependency on stale patch in cxl_test.

Changes in v4:
- Use GENMASK_ULL to fix i386 arch build (0-day)
- Use do_div to fix ARM arch build (0-day)
- Update comments in ACPICA patch to reflect new state of the
  ACPICA patch - pending again in github.

Changes in v3:
- Fix the 3, 6, 12 way interleave (again).
- Do not look for a CXIMS when not needed for x1 & x3 interleaves
- New cxl_test patch: Add cxl_test module support for this feature
- In a separate ndctl patch, cxl test: cxl_xor_region is added

Changes in v2:
- Use ilog2() of the decoded interleave ways to determine number
  of xormaps, instead of using encoded ways directly. This fixes
  3, 6, and 12 way interleaves. (Dan)

Add support for the new 'XOR' Interleave Arithmetic as defined
in the CXL 3.0 Specification:
https://www.computeexpresslink.org/download-the-specification

Alison Schofield (3):
  ACPICA commit 2d8dc0383d3c908389053afbdc329bbd52f009ce
  cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
  tools/testing/cxl: Add XOR Math support to cxl_test

 drivers/cxl/acpi.c           | 126 ++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/port.c      |   8 ++-
 drivers/cxl/cxl.h            |   8 ++-
 include/acpi/actbl1.h        |  35 +++++++++-
 tools/testing/cxl/test/cxl.c | 118 +++++++++++++++++++++++++++++++-
 5 files changed, 284 insertions(+), 11 deletions(-)


base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
-- 
2.37.3

