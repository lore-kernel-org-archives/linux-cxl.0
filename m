Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DC3C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Nov 2022 23:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiKVXH7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Nov 2022 18:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiKVXH4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Nov 2022 18:07:56 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B502E54B2E
        for <linux-cxl@vger.kernel.org>; Tue, 22 Nov 2022 15:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669158476; x=1700694476;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HW74G/YNTModXcfXIwIgnzgfJmYnxjKxEn4oXUR5PIM=;
  b=l8RXFJBP1W1cZ3thuVMKNbaj0kinAw/Xef2ehgxQIICnxS2jSCtO5975
   YaMjpBWxHjhGrbFJJRZELvNDcEWl+BVLvs4YNo+Nmzr9X5y10B28adbET
   Pf0VjRNVIxr0jGdDE06DnWdMZ1OQNdB/GJLYD3lqamZztiZcYalgfooG/
   oRK4Mxxkjm5R72DipQPviw94iD7QaN6nzzqJJtHGc+nPr2huVBnG7FVsS
   QdzwMvO98WfgQSRn3Zze3Ex84QDX1/XSL0EprSg8J5IZcgAxH4jl3KBWv
   3BCHZgc7wZKYBXOJhrfAlCt7C3DfsOrUA/VSsU9HNgdmVGz/A70i6x0Pp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="376079334"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="376079334"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 15:07:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747542484"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="747542484"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.144.204])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 15:07:53 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 0/4] CXL Address Translation
Date:   Tue, 22 Nov 2022 15:07:47 -0800
Message-Id: <cover.1669153711.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Introducing CXL DPA->HPA address translations. User space requires
HPA addresses when CXL devices, participating in a region, report
errors. For example, a patchset[1] adding trace events for media errors 
is in review on this list, yet it only provides userspace with the DPA.
By adding this translation, HPA’s can be added to those media error
trace events.

Patch 1 performs the translation and Patch 2 gives it exercise by
translating a small sample of addresses at every pmem region creation,
in a debug kernel.

Patches 1 & 2 deliver what is required for address translation, and
do not depend on Patches 3 & 4.

Patches 3 & 4 seem like a good idea, however, the value of that idea
is not clear. The idea is to add another level of validation to address
translations for regions using XOR arithmetic (as opposed to modulo).

Patch 4 runs the newly constructed HPA through the existing XORMAP filter
to see if it maps to the expected dport. While a valid check, it's not
clear that it offers anything more than the range checking already done
in the generic translation. That is, if an HPA translation passes the
range check, how can a match on dport test ever fail? I don't know.
I’m looking for help in proving or disproving the usefulness of 3 & 4.

Using cxl_test, existing unit tests that create regions exercise
the address translation and the results can be viewed like this:

# meson test -C build --suite=cxl
ninja: Entering directory `/root/ndctl/build'
[109/109] Linking target ndctl/ndctl
1/5 ndctl:cxl / cxl-topology.sh             OK               4.19s
2/5 ndctl:cxl / cxl-region-sysfs.sh         OK               2.69s
3/5 ndctl:cxl / cxl-labels.sh               OK               5.85s
4/5 ndctl:cxl / cxl-create-region.sh        OK               5.35s
5/5 ndctl:cxl / cxl-xor-region.sh           OK               1.62s

# dmesg | grep -m1 "Address translation"
cxl_core:devm_cxl_add_pmem_region:2006: cxl_region region6: Address translation check: Pass

# dmesg | grep Addr | grep Pass | wc -l
46
That '46', is how many regions are created and their addresses successfully
translated in the existing cxl unit tests.  (No Fails today ;))

TODO in ndctl: If the check on region creation gets merged, add watchers for
it to cxl unit tests that create regions.

Alison Schofield (4):
  cxl/region: Add a DPA to HPA translation helper
  cxl/region: Check addr trans at pmem region create (debug only)
  cxl/acpi: Move the target entry(n) calc to its own function
  cxl/acpi: Add a match on dport check for XOR addr translation

 drivers/cxl/acpi.c        |  91 +++++++++++++++++++++++-------
 drivers/cxl/core/port.c   |   5 +-
 drivers/cxl/core/region.c | 116 +++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h         |  11 +++-
 4 files changed, 199 insertions(+), 24 deletions(-)


base-commit: f0c4d9fc9cc9462659728d168387191387e903cc

This is built upon 6.1-rc4 plus CXL XOR Interleave Arithmetic [2]
If Patches 3 & 4 are discarded, then there is no dependency on [2]

[1] https://lore.kernel.org/linux-cxl/cover.1668115235.git.alison.schofield@intel.com/
[2] https://lore.kernel.org/linux-cxl/cover.1669153633.git.alison.schofield@intel.com/

Gobble Gobble
-- 
2.37.3

