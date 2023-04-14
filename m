Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F725C77B71
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 18:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDNSyM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 14:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDNSyI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 14:54:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7820A93C5
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681498446; x=1713034446;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=9WofR5/mLDZj6ZsgW6wP7+ESFmi/OjokxKRJmaWJyFo=;
  b=m+XZaFBVr/xRWW6AjC5vrGiEQ/xyFU9iiy2t0aW7IF0JZL14fRypzwRN
   5qxAn5uikAIGyDoM7LvkCkWDUvmcx4oVzyMQf+pPvHK1s/OfPLtlA5dCl
   8H6cUCb/c6PnmfPCLaKW/64dOB02UkgW+JziZjcN+WEtkGn92OjHQKYxA
   GMXfuUiYlKYYbwQq0beEhSEEzmYCV9P2JnpcgZvnEU/i0wrusnF9upXv8
   JoAO8A/Pr6m7oc5xaZT0cJ/OridW7B5Z+ZJU46+t9xf/mtsH5NsM/WqeS
   HxTidckB+5YmKdYeExhQKEwyNXytK9Q99C9CehFvsWD1W+E/jq/dY4CVN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="347270278"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="347270278"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 11:54:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="683437720"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="683437720"
Received: from rkulesho-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.41.243])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 11:54:06 -0700
Subject: [PATCH 3/5] cxl/core: Drop unused io-64-nonatomic-lo-hi.h
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Date:   Fri, 14 Apr 2023 11:54:06 -0700
Message-ID: <168149844596.792294.8273108394688012953.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168149842935.792294.13212627946146993066.stgit@dwillia2-xfh.jf.intel.com>
References: <168149842935.792294.13212627946146993066.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

After the discovery of a case where an implementation misbehaves with
register reads larger than the definition of the register the other
usages of readq() were audited and found to be correct, but some cases
where the io-64-nonatomic-lo-hi.h include is not needed were discovered,
delete them.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c |    1 -
 drivers/cxl/core/port.c |    1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f2addb457172..6198637cb0bb 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
-#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/security.h>
 #include <linux/debugfs.h>
 #include <linux/ktime.h>
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 4d1f9c5b5029..b060757c4000 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
-#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/memregion.h>
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>

