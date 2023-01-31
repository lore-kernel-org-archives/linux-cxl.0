Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC75C54EAA
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 00:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjAaAIZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 19:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjAaAIY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 19:08:24 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6991164F
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 16:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675123704; x=1706659704;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5geeVliYXDeYDCzZ6l9mASuwZfkJQmf7MEL7gS9eZNw=;
  b=L7JV921QwnIs/VGLTVL/I328P2LziQ2mZuPrpjkgKt8H6K49wHKRE29P
   HedNNvJh0NkAL0li0VLQdcRHXl3p1eNTJv6ZgkUnvgQuydqWD5IICM+Hz
   FhzlnXJ9cE8GD/h1nxiR3faarMdYpoKfZUvFYtfzl+2xQ2Xrfc0s2jTdz
   ZsKuL5LyBiZGTfRzItBo03TNXSdzOqkiq8jGhs6GF+9597ojPHXEkFUnj
   PIixKI0YwrgCL6TWfRTpdFs7O8olbpWXJc1iUJ3j9LmoKZJT+O/D1Cd4c
   rXQ6R5vzMr77vbLlGkqAT/WmmONZUQ2OW7LsSUmIrQKdP7nKoWcC1VWgN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="326374321"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="326374321"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 16:08:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657646697"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="657646697"
Received: from cbinionx-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.161.189])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 16:08:23 -0800
Subject: [PATCH] cxl/pci: Fix irq oneshot expectations
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 30 Jan 2023 16:08:22 -0800
Message-ID: <167512370284.2509057.12212781340425308386.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The IRQ core expects that users of the default hardirq handler specify
IRQF_ONESHOT to keep interrupts disabled until the threaded handler
runs. That meets the CXL driver's expectations since it is an edge
triggered MSI and this flag would have been passed by default using
pci_request_irq() instead of devm_request_threaded_irq().

Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ad2ebe7bfaeb..4cf9a2191602 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -509,7 +509,8 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
 		return irq;
 
 	return devm_request_threaded_irq(dev, irq, NULL, cxl_event_thread,
-					 IRQF_SHARED, NULL, dev_id);
+					 IRQF_SHARED | IRQF_ONESHOT, NULL,
+					 dev_id);
 }
 
 static int cxl_event_get_int_policy(struct cxl_dev_state *cxlds,

