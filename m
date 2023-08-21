Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F474EE49A5
	for <linux-cxl@archiver.kernel.org>; Mon, 21 Aug 2023 18:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbjHUSOu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 21 Aug 2023 14:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbjHUSOu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 21 Aug 2023 14:14:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94136113
        for <linux-cxl@vger.kernel.org>; Mon, 21 Aug 2023 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692641688; x=1724177688;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uhtifdQlDYZnjzRj0dtFoyGkpYPWeKmOQtAn8p1d7XY=;
  b=YTkFnm6bypdG8YUDWZe9rUdlkp1If4JtFU67QihXHZTRGpwtWmmUul2y
   +d0EL6la8EhJLlzPAXQ1yXZOoPdcOCyo96qgzFm7py5AJeGT8hdexr6/Z
   chHxIbrfMHkzOBLVhsyME920ayujZjwREs1sra9RYGFuT4fYp9qapy4dp
   AaD7CV9L+HpYREFtmnS5ggQ6rCldSSrrZxYqyrHCRexrIJ6E0hGjovKgl
   odl+rao+jkRlgkswDbIfbxGAy15rW+aXcgfoYbB5+gLCGLWjH9AOwnH8Y
   19LlCwncjJs9xHBsq3a7U7w0an5XQnOWWsD2lbXd15x3ByJZg22pI7y1Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="353978356"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="353978356"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 11:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="859569969"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="859569969"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.106.94])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 11:14:40 -0700
From:   alison.schofield@intel.com
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: [PATCH v3 0/2] cxl/region: Improve Soft Reserved resource handling
Date:   Mon, 21 Aug 2023 11:14:35 -0700
Message-Id: <cover.1692638817.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Changes in v3:
- dev_dbg() on failure to insert resource to a soft reserved parent (Jonathan)
  Continue, as in previous versions of this patch, to insert the resource
  to the root decoder if insert to SR parent fails or SR parent does not
  exist.
- Replace goto/unlock with guard(mutex) in remove_soft_reserved() (DaveJ)
- Use automatic resource cleanup in add_soft_reserved() (DaveJ)
- Fixups to commit log grammar (DaveJ)
 
v2: https://lore.kernel.org/linux-cxl/cover.1691176651.git.alison.schofield@intel.com/
 
Begin Cover Letter:
Make the CXL Region Driver handle these 2 observed scenarios:

1) Soft reserved resources were observed as sometimes being the parent
and sometimes being the child of a region resource. Patch 1 clears up
that inconsistency.

2) Soft reserved resources were also observed as stranded after region 
teardown, making the address space the region released unavailable for
reallocation. Patch 2 implements soft reserved resource removal.


Alison Schofield (2):
  cxl/region: Try to add a region resource to a soft reserved parent
  cxl/region: Remove a soft reserved resource at region teardown

 drivers/cxl/core/region.c | 187 ++++++++++++++++++++++++++++++++++----
 1 file changed, 168 insertions(+), 19 deletions(-)


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.37.3

