Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A795C433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Nov 2022 22:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbiKVWxb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Nov 2022 17:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiKVWxU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Nov 2022 17:53:20 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D583F53
        for <linux-cxl@vger.kernel.org>; Tue, 22 Nov 2022 14:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669157551; x=1700693551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fV5HACXgZRnHtpmEBzrZL7s0BGnKiaTozFlaeUC+xBE=;
  b=fiIODKyeT6IIaCKx6ULqMuuOuuFVj6/js1ZvC45ql4WAndpmqn52LwIC
   EtEn5MugKTU6brXqp1IY7ZRK118b2Uk4IdvhDRb33JdbNZWGVhGyrlUxE
   DnlwEeswzz2MOdOrpx4jjYvnx7UCNg0QwOWVOZ4mrf51S5u9YZbll0b7u
   YfCpW37dD4kcNaPLy6pNl+lyZUiw7mbTxHHQLBt0H9K0fJE0KPyVWFD6C
   0Y4v0lrrezxTBDldEi7Lsg7J1glA9MJ4h5P9gRfvghZL/G76BcVrtv7qQ
   x0yhHVynDU2jl7MdKTcoLYdBB8ldNMYLfVlOOQT6SS3ID6R9ZgiG0/QB4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="301487472"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="301487472"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 14:52:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="674506289"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="674506289"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.144.204])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 14:52:29 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v8 0/3] CXL XOR Interleave Arithmetic
Date:   Tue, 22 Nov 2022 14:52:22 -0800
Message-Id: <cover.1669153633.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

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

Add support for the new 'XOR' Interleave Arithmetic as defined
in the CXL 3.0 Specification:
https://www.computeexpresslink.org/download-the-specification

Alison Schofield (3):
  ACPICA commit 2d8dc0383d3c908389053afbdc329bbd52f009ce
  cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
  tools/testing/cxl: Add XOR Math support to cxl_test

 drivers/cxl/acpi.c           | 126 ++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/port.c      |   9 ++-
 drivers/cxl/cxl.h            |  13 +++-
 include/acpi/actbl1.h        |  35 +++++++++-
 tools/testing/cxl/test/cxl.c | 118 +++++++++++++++++++++++++++++++-
 5 files changed, 289 insertions(+), 12 deletions(-)


base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
-- 
2.37.3

