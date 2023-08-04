Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83D8C001DB
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 19:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjHDTcA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 15:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjHDTbu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 15:31:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1B25246
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 12:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691177503; x=1722713503;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XAEdGyOS70nuubs/EKXfc77CSv45U5p7a/8LPkh2oJ8=;
  b=GNYDbV9fNpRh3D1HhcaDYJf9/rl6mNOCwUtkIrq5S5qp/NTsSKw6KtK1
   E9oJGabV8Lc18rBmJkhmdkONg3TBKW1KYptBmePeUpL7BoHGRWROesrKN
   Ko+79Nbz1Rn5HAM5JOTdjw3yarj3YqaKb1HHlrrhXBbW4XDQanARTHvjX
   pVvocdQn+OtguMBWfYZRv68IYdV5RDuaI0mJRu3mnkAKhDF9xq9lMNqtn
   y7zxvDJ8sFuxOH2JgGh19bHiVnkfEEvpA3BEmXyGQ9gqfapnOhNuf3ftB
   ev0v/KX31xDAs8WWSArshwe9apoP1xobXLCEPuWaOE8+v5rZpNQRUcmYI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="369128141"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="369128141"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 12:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="759690012"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="759690012"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.168.219])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 12:31:42 -0700
From:   alison.schofield@intel.com
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/2] cxl/region: Improve Soft Reserved resource handling
Date:   Fri,  4 Aug 2023 12:31:38 -0700
Message-Id: <cover.1691176651.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Changes in v2:
- Rebase to 6.5-rc1

v1: https://lore.kernel.org/linux-cxl/cover.1687568084.git.alison.schofield@intel.com/


Make the cxl/region driver handle these 2 observed scenarios:

1) Soft reserved resources were observed as sometimes being the parent
and sometimes being the child of a region resource. Patch 1 clears up
that inconsistency.

2) Soft reserved resources were also observed as stranded after region 
teardown, making the address space the region released unavailable for
reallocation. Patch 2 implements soft reserved resource removal.

Alison Schofield (2):
  cxl/region: Try to add a region resource to a soft reserved parent
  cxl/region: Remove a soft reserved resource at region teardown

 drivers/cxl/core/region.c | 164 +++++++++++++++++++++++++++++++++++---
 1 file changed, 153 insertions(+), 11 deletions(-)


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.37.3

