Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFDEC352A1
	for <linux-cxl@archiver.kernel.org>; Sat,  3 Dec 2022 17:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiLCROp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 3 Dec 2022 12:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLCROn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 3 Dec 2022 12:14:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1281E3E9
        for <linux-cxl@vger.kernel.org>; Sat,  3 Dec 2022 09:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670087682; x=1701623682;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZHoenSxtC0VU6BasVARjn3V7OVKG8+HtWn2zNGp2CJc=;
  b=ZhJXsrluFtdkMUesdPqseXC+ojvepV/SWY0aGDw9zv0OfTbqgJQUZ0iM
   sLxTWjPzvV4Lx2sm6JjV0aYtC/63PsSM5sfcpiI+hRdxeMfwT5yuFI39X
   tSxNKJTmVDhDTTTbiRw+CAA49z6yLCSUkMGRoCtbUdSKkBzjG4WhH+QEm
   XdWjAzG8jvLwG8azE5EY03mUK6z9d/gTM8mQByMPrmCHSsuOo2mdAssst
   OhV3F0bpDtCzcdy+jt+kbUuUqwRVlHNLFf23/kB4d1zih45sZPGjWw8uE
   GlFgtmyYwgdddh2nZ6Sr5IhYTNjfYbcyLjHn9aDSiNcHr23HhNvJR8jkW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="317990718"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="317990718"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 09:14:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="819753706"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="819753706"
Received: from tstapsal-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.251.20.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 09:14:42 -0800
Subject: [PATCH] cxl/regs: Fix sparse warning
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>, rrichter@amd.com,
        terry.bowman@amd.com
Date:   Sat, 03 Dec 2022 09:14:41 -0800
Message-ID: <167008768190.2516013.11918622906007677341.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 0day robot belatedly points out that @addr is not properly tagged as
an iomap pointer:

"drivers/cxl/core/regs.c:332:14: sparse: sparse: incorrect type in
assignment (different address spaces) @@     expected void *addr @@
got void [noderef] __iomem * @@"

Fixes: 1168271ca054 ("cxl/acpi: Extract component registers of restricted hosts from RCRB")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/regs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 1173912b9cf7..5a812583aee1 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -313,8 +313,8 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
 				      enum cxl_rcrb which)
 {
 	resource_size_t component_reg_phys;
+	void __iomem *addr;
 	u32 bar0, bar1;
-	void *addr;
 	u16 cmd;
 	u32 id;
 

