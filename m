Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EABC32771
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 01:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiIPBab (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Sep 2022 21:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIPBaa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Sep 2022 21:30:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3183D5A8
        for <linux-cxl@vger.kernel.org>; Thu, 15 Sep 2022 18:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663291829; x=1694827829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qd8HiQ8HGnXXohHJR6kh9Dxh8CsrHb6Xh4IY6ubLVhk=;
  b=n+dILtLPGDwJHvnVUGIQDeTLE3bYZGlGAiui9NhxJ42y0ZDKv0KLRLUF
   oBYUru1o/4ufgYLJ8EBLecKYeZle80eU2vKFg56trklHgfFtAH93bAW0V
   bTJW0Och3BCDu5Gx9s8rACG5zPuhVL3ZAhm7I3ELOEpuDooBhNSfngoK2
   W5MeJThV6czefDwPiv1646wpYpBC59vk18c0X8tUttRPzscWgdJnzAiaP
   s8Lg86mTIdmPXDQpu/7ZBPod+5Ws/liGQ7rratPtf0iXJ8euPFI8lnCzl
   R284MHr5fUFpRDyDYJWL4m/yxJerLK6JN8HUJxazD+mU2H//qwEdMPCRZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="281913021"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="281913021"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 18:30:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="617502231"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.120.139])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 18:30:28 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v3 0/3] CXL XOR Interleave Arithmetic
Date:   Thu, 15 Sep 2022 18:30:21 -0700
Message-Id: <cover.1663291370.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

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
  For ACPICA: Add the CXIMS structure definition to the CEDT table
  cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
  tools/testing/cxl: Add XOR math support

 drivers/cxl/cxl.h            |   2 +
 include/acpi/actbl1.h        |  14 ++-
 drivers/cxl/acpi.c           | 132 ++++++++++++++++++++++++++--
 tools/testing/cxl/test/cxl.c | 161 ++++++++++++++++++++++++++++++++++-
 4 files changed, 299 insertions(+), 10 deletions(-)


base-commit: 1cd8a2537eb07751d405ab7e2223f20338a90506
prerequisite-patch-id: 7475f0a9ed0870e85bb4ba2b3eb25618325614bf

The prereq patch is: tools/testing/cxl: Add an x1 host-bridge with 4 devices

-- 
2.31.1

