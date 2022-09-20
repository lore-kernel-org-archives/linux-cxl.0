Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF27CC54EE9
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Sep 2022 15:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiITPjc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Sep 2022 11:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiITPjb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Sep 2022 11:39:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35DBC4E
        for <linux-cxl@vger.kernel.org>; Tue, 20 Sep 2022 08:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663688369; x=1695224369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dR+OUngDEbq5Sw5dXETSZjroyS68c4hTN5ho9O31vrM=;
  b=AKH3g1c1Zg5y/qqb+n1G3tiEhhueccJJclWcYON1/mLxLGqogQI2yuHc
   1TXpAzqYOOAStL4gK5Z7LY2MeCRoIbsW1MbHO5OFOQlwRxqiIeuudcVNN
   TqHvf2ouoYLgky4Th72D7gK7lAaFOkatGpW323E6MBKLaYo3U94Z2dcYi
   lbwmEtagx2t09r14AmZsckO0zFrfrpFJyK88XHCU3XQ5A0RrZIyJ4+Cai
   PYQ0sTXE7QX8v1PPjb9uL6npAIsd7yXQF65NkBlUIkeVaecZsXVHl6nTB
   F0EWWid9m7gdNwZXuR+K2ThW8P5qmBdQJfNILTHI7Fv5JhxIzEgn+SGsU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="301110854"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="301110854"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 08:39:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="794302313"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.139.149])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 08:39:29 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v4 0/3] CXL XOR Interleave Arithmetic
Date:   Tue, 20 Sep 2022 08:39:23 -0700
Message-Id: <cover.1663687681.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

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

The prereq patch is: tools/testing/cxl: Add an x1 host-bridge with 4 devices

Alison Schofield (3):
  For ACPICA: Add the CXIMS structure definition to the CEDT table
  cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
  tools/testing/cxl: Add XOR math support

 drivers/cxl/cxl.h            |   2 +
 include/acpi/actbl1.h        |  14 ++-
 drivers/cxl/acpi.c           | 133 +++++++++++++++++++++++++++--
 tools/testing/cxl/test/cxl.c | 161 ++++++++++++++++++++++++++++++++++-
 4 files changed, 300 insertions(+), 10 deletions(-)


base-commit: 1cd8a2537eb07751d405ab7e2223f20338a90506
prerequisite-patch-id: 7475f0a9ed0870e85bb4ba2b3eb25618325614bf
-- 
2.31.1

