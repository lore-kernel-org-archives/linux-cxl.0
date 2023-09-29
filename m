Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4A2E7734B
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Sep 2023 23:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjI2XJb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Sep 2023 19:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2XJb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Sep 2023 19:09:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071DDD
        for <linux-cxl@vger.kernel.org>; Fri, 29 Sep 2023 16:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696028969; x=1727564969;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aM2+he98UA7qY7pmOoe3cPfMSGWs+8p7VFLlR+hRt0o=;
  b=KCjRA3mQXV0fEiA37Gu+WZZPUHwdkz1OArvF7OE+vmXDWrPyunBrC2HT
   Au1OZkc6BVVCm3hIaggzknfvtqJxqNe1361vEt/NHzU6p5pqn3Oaeu6zj
   KE2sq9Es+tx38bmET1NlLX7IMILuCYEtn6B7YOCkiWiNo8oHs79RLeP0q
   eZHmquN76mR3d1sHHJG8LApiV3iKndq/bsYrzVk1LE++1lq2osmGbQKMM
   talna/mye/V7UA4ukducM770GgVXAPvp4DPaE1Tgy14l710vZrI9hijgP
   gBeEPQkzwn1Zl4C6etSoByIKa77P6IyoZhqWpBhiM4gTdOhMEP8hN0Dlr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="381279637"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="381279637"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="743571973"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="743571973"
Received: from thamvo-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.56.79])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:09:28 -0700
Subject: [PATCH v2 0/4] cxl/mem: Fix shutdown order
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, ira.weiny@intel.com
Date:   Fri, 29 Sep 2023 16:09:27 -0700
Message-ID: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

While fixing a crash where the cxlmd->cxlds validity needed to be
maintained over the span of the memdev being unregistered, I made a note
to come back and cleanup sanitize notifier setup/shutdown
implementation. Jonathan went further and noticed that the fix needs
that rework first. So the changes since v1 [1] are reworking the
sanitize notifier setup to be more idiomatic with how other driver
mechanisms are managed.

The special wrinkle of the sanitize notifier is that it interacts with
interrupts, which are enabled early in the flow, and it interacts with
memdev sysfs which is not initialized until late in the flow.

After some other cleanups, a self contained
cxl_sanitize_setup_notifier() is introduced to centralize that
incremental setup work, and leave cxl_memdev_shutdown() alone to
coordinate closing down the ioctl path relative to the unregister event
of the memdev.

[1]: http://lore.kernel.org/r/169596542307.790108.11339208844199665348.stgit@dwillia2-xfh.jf.intel.com

---

Dan Williams (4):
      cxl/pci: Remove unnecessary device reference management in sanitize work
      cxl/pci: Cleanup 'sanitize' to always poll
      cxl/pci: Fix sanitize notifier setup
      cxl/mem: Fix shutdown order


 drivers/cxl/core/memdev.c |   45 ------------------
 drivers/cxl/cxlmem.h      |    2 -
 drivers/cxl/pci.c         |  112 +++++++++++++++++++++++++++++----------------
 3 files changed, 73 insertions(+), 86 deletions(-)

base-commit: 6465e260f48790807eef06b583b38ca9789b6072
