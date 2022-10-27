Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78675C38A2D
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Oct 2022 04:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiJ0EH7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Oct 2022 00:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiJ0EHw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Oct 2022 00:07:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509D36B653
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 21:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666843671; x=1698379671;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MRtq6Gvgh1kfNpDUKtcox8hSGIWCkNm43rtYfOFBkBY=;
  b=DdQb4p0xE8+7oRalQ8bvPEH7yZiWo+Acpxd0rjT4tkoc4agatGncN+Mp
   B/J5fEYcZoGAzBsgt5z2YlbTjs/E8EihIG40+vJKXNwcCInptUAnfdqaZ
   J2ZTPC9+mM7GVdnNApT8buLfOpuyk3D/1XUiO6he1kPHpymkx7MweK3l6
   h8aUUuP0S1eMeC+SGgmqRg2NWqHTreYlqhc/AdB4YaL16WplO7zq+51V0
   74V+jMGZFI7Tv37zXZXTBoT49F6FC+n9/KR7ubltK9hHPD/yMUjp1T8vB
   FGgM2XJvVXeazLZzqB4g8tetmxuzkPh6vCHx90+K5YSPoYhqD2Ukp+3C2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="295533028"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="295533028"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 21:07:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="961475570"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="961475570"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.1.141])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 21:07:49 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 0/3] CXL XOR Interleave Arithmetic
Date:   Wed, 26 Oct 2022 21:07:40 -0700
Message-Id: <cover.1666841669.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

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


Alison Schofield (2):
  For ACPICA: Add the CXIMS structure definition to the CEDT table
  cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
  tools/testing/cxl: Add XOR Math support to cxl_test

 drivers/cxl/acpi.c           | 129 +++++++++++++++++++++++++++++++++--
 drivers/cxl/cxl.h            |   2 +
 include/acpi/actbl1.h        |  14 +++-
 tools/testing/cxl/test/cxl.c | 118 +++++++++++++++++++++++++++++++-
 4 files changed, 254 insertions(+), 9 deletions(-)

-- 
2.37.3

