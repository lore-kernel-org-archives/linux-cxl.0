Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91544C77B7D
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 21:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjERVyb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 17:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjERVya (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 17:54:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CB818F
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 14:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684446869; x=1715982869;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6OIKL1WNR0Om2PDZ5ahp7nHSDk8BAouLWFZjVxMdK7Y=;
  b=NAykGKHz8V2RvF/2Q8I7uskvk/kpINQwt7LhK36eksxTRYri2B7YtBhN
   xDcYukIYmgyESRLj1/oTVKdZtpia2I5mS03K9+GJ4zllE6LQY0wmOc05t
   OAbM11OEJWpVYC1q/bxKmzi7fmZV7eqAYjI0LYaNM3S/A73urwyQ4dzRh
   MmPub/cNfcVGxpmeEmViDfYlf2ldtQSbk0NMEZwEA0kJ1L0VYOjmC/Rbv
   2WsQ8PS8wGcS54rB03HhGLEDjvLrpMUvF072Ep5g36fzU2XQQ9bfq3OZT
   VXjuxqWW9HWWOAatJfh7bhs2axy0q3+GqFZUoCQ0iTu88A7tFSLc6e4mv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="349719482"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="349719482"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 14:54:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="1032358144"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="1032358144"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.136])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 14:54:29 -0700
Subject: [PATCH v3 0/2] cxl: Move operations after memory is ready
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Date:   Thu, 18 May 2023 14:54:28 -0700
Message-ID: <168444678631.3134781.16327910091008427181.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v3:
- Really fix range indexing. (Ira)
- Allow pci_probe() to succeed. (Dan)
- Skip any media probing operations. (Dan)

v2:
- Check both ranges for memory ready (Ira)
- Drop last 2 patches from previous series. Move media wait to pci_probe()
  before mailbox operations. (Dan)
- Fix up fixes tags. (Dan)

This series contains fixes broken out from the QTG ID series. It augments
the Memory_Info_Valid check and move the relevant operations that needs to
happen after memory is valid behind the check.

---

Dave Jiang (2):
      cxl: Wait Memory_Info_Valid before access memory related info
      cxl: Move cxl_await_media_ready() to before capacity info retrieval


 drivers/cxl/core/mbox.c | 15 +++++---
 drivers/cxl/core/pci.c  | 85 ++++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxlmem.h    |  2 +
 drivers/cxl/cxlpci.h    |  2 +
 drivers/cxl/mem.c       |  3 +-
 drivers/cxl/pci.c       |  6 +++
 drivers/cxl/port.c      |  6 ---
 7 files changed, 98 insertions(+), 21 deletions(-)

--

