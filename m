Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671A8C77B7D
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 17:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjERRb4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 13:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjERRbr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 13:31:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26A0198E
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 10:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684431098; x=1715967098;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2gk7NVV/LMijzXPmP188kf6A6zTmxM12snbw64nfWDc=;
  b=KP/QzdrEb3v3AN2LBsq85COUnl/8GJmXtBuWCoCDTGBjfKapmcj+t0YF
   iM56jiy/KUeUWr+ZaqsZyo7XZ/mKA75ifSJi1B7Q93PkDXXodmTnicArF
   qYtPxYTnGZQ7RMN4mtMmVm3PL7hTI0R5G7WqDeyNWvC3fSk4EU52TDIaI
   MOfIcSWwt5yHEgjbmSOjNH/a5oXOkezgQZiaGjvEJaN9W/Ei5YcL/SSzQ
   VUD7YkHObmyDIaRnc1HEkyFp4YYKtHM+OKKfWRuYzejzQZMeFyRTz2bk9
   ju5WwRhWwckuS6dXGzd+0XuG2GwxIolqdvy+ivPvyRia3g73Car2KDSwa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="415590420"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="415590420"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 10:31:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="814402487"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="814402487"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.136])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 10:31:37 -0700
Subject: [PATCH v2 0/2] ] cxl: Move operations after memory is ready
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com
Date:   Thu, 18 May 2023 10:31:36 -0700
Message-ID: <168443095459.2957452.1648087475761987955.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

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


 drivers/cxl/core/pci.c | 85 +++++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxlpci.h   |  2 +
 drivers/cxl/pci.c      |  6 +++
 drivers/cxl/port.c     |  6 ---
 4 files changed, 84 insertions(+), 15 deletions(-)

--

