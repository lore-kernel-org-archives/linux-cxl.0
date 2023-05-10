Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A28CC7EE22
	for <linux-cxl@archiver.kernel.org>; Wed, 10 May 2023 18:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjEJSot (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 10 May 2023 14:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbjEJSos (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 10 May 2023 14:44:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201FA5B84
        for <linux-cxl@vger.kernel.org>; Wed, 10 May 2023 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683744273; x=1715280273;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YYdrKttIWl9JFsoooHEG0a12gPW+jEjeYGoNJGfpn7s=;
  b=fI4fIsJauJgQ5OyBsXZw0t/mibAU14LKLFoa8q66ZML033KsruRjF5o6
   Q17MivWd4hdM2uhXv5ebMfQicaBdJoAEmyK6v1cFjKnWyaZ3mNU7wJb50
   xiwslTsappsPPoHBLHpF/kIqe93lI+9gxJW57E7nnSNaFD++oECxtORRr
   sEJPOiU+KEAlv9l5vM0JdO7XzzBenZK71pQ3OGvEnL+I3V8DspI/7Z/So
   5wcCzp+8JSJrc9kCqbNGpjPJNeJhSLQ8Bq4hY9F6xxDiSIBS/TDMkT4w2
   YgP6bhrvoteXi5CcP6TCpuZYmOq5A9wds/pxBHqXzr/3CjRParAa/y2rb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="353370140"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="353370140"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 11:44:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="769004628"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="769004628"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.34.89])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 11:44:31 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [RFC 0/3] Apply SRAT defined PXM to entire CFMWS
Date:   Wed, 10 May 2023 11:44:25 -0700
Message-Id: <cover.1683742429.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The patch that created fake NUMA nodes for CFMWS windows
not defined in the SRAT, made wrong assumptions about the
SRAT defined entries. Specifically, it assumed an SRAT entry
using cfmws->start, uses the entire CMFWS range, start through
end. The assumption is wrong, and so the ACPI driver, needs
to examine the SRAT created memblks more closely to discover
partial definitions of the HPA range.

This work-in-progress addresses that issue. The first 2 patches
introduce numa helpers that are used in the 3rd patch, where the
ACPI drivers parsing of the CFMWS is updated.

The patch commit logs, especially Patch 3, describes more
of the approach as well as other approaches considered, and
questions. So, perhaps, scan 1 & 2, and dive into #3 and 
confirm or refute this approach.

I did not include our NUMA or ACPI friends in this posting,
because I want to get a direction check from CXL folks before
addressing how the helpers can get merged into the NUMA arch.

Thanks for looking!

Alison Schofield (3):
  x86/numa: Introduce numa_find_node(start, end)
  x86/numa: Introduce numa_remove_memblks(node, start, end)
  ACPI: NUMA: Apply SRAT proximity domain to entire CFMWS window

 arch/x86/include/asm/numa.h |  2 ++
 arch/x86/mm/numa.c          | 36 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/numa/srat.c    | 32 ++++++++++++++++++++++++++------
 3 files changed, 64 insertions(+), 6 deletions(-)

-- 
2.37.3

