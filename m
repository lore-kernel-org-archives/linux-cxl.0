Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FD7C4321E
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 22:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiK3Wrg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 17:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiK3Wrf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 17:47:35 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014A691369
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 14:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669848451; x=1701384451;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GbqJW+5DBoU/gul+oWbjUVYC1rkA2hpxZ3IZ9fYOQME=;
  b=YXLl+7IoXxEpkmw6DOPQcz1zfddH2jfNbadqGMBgKjz3BFBpBvODmF1+
   xqzH0eHXDt+Hn5BiGv+ldllhraI14PRSigxpBJzf8YZrArWJbJihKopEJ
   Nlhv3U/6cJSL0F+NXG1FljFRH8+/FM26YzwPF7aLaZpfSiLXaSA4X2fAF
   KE9IZfynecLr8mCgKPvCLMoCcneLeITt70tBkmfEcrVapx5PKIbmkHm3X
   UcasqDN8x4TBU9h9vUlzIGeXI3uLXYqXn28ovms48Zpt/UE0rcQvKkPDm
   PsS6I62YUO39wkxKOe74hRZg2MJ8vATklTRMIseLmi73VEieLrGkZc5Mu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="316682630"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="316682630"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 14:47:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="769003135"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="769003135"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.3.88])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 14:47:29 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v9 0/3] CXL XOR Interleave Arithmetic
Date:   Wed, 30 Nov 2022 14:47:23 -0800
Message-Id: <cover.1669847017.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Add support for the new 'XOR' Interleave Arithmetic as defined
in the CXL 3.0 Specification:
https://www.computeexpresslink.org/download-the-specification

Changes in v9:
- Add Jonathan's Reviewed-by tags to Patches 2/3
- Move calc of n to separate func (Jonathan)
- Use ways_to_cxl() for self-documentation, despite overkill (Jonathan)
- Use the #define ACPI_CEDT_CFMWS_ARITHMETIC_XOR in cxl_test (Jonathan)
- Tidy up whitespace and trailing commas (Jonathan)
  *I went w trailing commas, because we should always expect more :)
  
Changes in v8:
- Move typedef of cxl_cal_hb_fn in cxl.h earlier for use in cxl_root_decoder
  (It's a bit soon, and a bit small, for rev'ing without awaiting review,
  but want this to be in sync with the address translation patchset
  that follows.)

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

Alison Schofield (3):
  ACPICA commit 2d8dc0383d3c908389053afbdc329bbd52f009ce
  cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
  tools/testing/cxl: Add XOR Math support to cxl_test

 drivers/cxl/acpi.c           | 136 ++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/port.c      |   9 ++-
 drivers/cxl/cxl.h            |  11 ++-
 include/acpi/actbl1.h        |  35 ++++++++-
 tools/testing/cxl/test/cxl.c | 118 +++++++++++++++++++++++++++++-
 5 files changed, 297 insertions(+), 12 deletions(-)


base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
-- 
2.37.3

