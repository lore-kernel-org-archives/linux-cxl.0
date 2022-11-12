Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593DFC4332F
	for <linux-cxl@archiver.kernel.org>; Sat, 12 Nov 2022 04:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiKLElg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Nov 2022 23:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiKLEle (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Nov 2022 23:41:34 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ECBE0AE
        for <linux-cxl@vger.kernel.org>; Fri, 11 Nov 2022 20:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668228093; x=1699764093;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xQ/WKYwoH1ok1JRfNeZ4JRwVhlqwp5E4ZOKm/sfjGEQ=;
  b=Viw3UXt3C4WjA7lzFMw+sCTkVSGyhrdo+Ihj8cyDCiU+v2pXqbyv41x0
   JJrl3Dn+G5LAHUo4U1c4jU5Fm7EQF62M0+9UaRuQTN44Ezn4XYcKLABhX
   XDlC6EWc7iKxHKa4aZYQ2uRgDD0bPCESUIvE67jqh1ohqiKd4shYg86YE
   CYbDDqPG9+02nt6ifgEh0uefTZ9MeoIrZS27/w2d/nZKyWu0LHFsOf3fl
   fGlK3M+TbK3CbAoSFNRutkvCQNek/WN9p85dFrSocWzzwQ/4/fnIP9X1p
   FZG/Z1T2bpnibJkpNXLDksO0fiWdBa8xgQpYcjtq77+SbeKiQlD77B1n4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="375968587"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="375968587"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 20:41:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="670920043"
X-IronPort-AV: E=Sophos;i="5.96,158,1665471600"; 
   d="scan'208";a="670920043"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.134.249])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 20:41:33 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v6 0/3] CXL XOR Interleave Arithmetic
Date:   Fri, 11 Nov 2022 20:41:26 -0800
Message-Id: <cover.1668227077.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Changes in v6:
- Rebased on 6.1-rc4, merging with Dan's latest cxl_test work.
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

 drivers/cxl/acpi.c           | 129 +++++++++++++++++++++++++++++++++--
 drivers/cxl/cxl.h            |   2 +
 include/acpi/actbl1.h        |  35 +++++++++-
 tools/testing/cxl/test/cxl.c | 118 +++++++++++++++++++++++++++++++-
 4 files changed, 275 insertions(+), 9 deletions(-)


base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
-- 
2.37.3

