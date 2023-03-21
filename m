Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAD9C6FD1D
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Mar 2023 06:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCUGIe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Mar 2023 02:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCUGId (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Mar 2023 02:08:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1542109
        for <linux-cxl@vger.kernel.org>; Mon, 20 Mar 2023 23:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679378912; x=1710914912;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AHa71GHGnrZ+xNas5r6VQ2b8MBSS4jouoz+ERx7f0NY=;
  b=jL5Tp3PX/rhRra8u2EIdM2wPFEkd/PD3Q4E5MY6W8vkHsWj62rvAjsiM
   EvGL/qR0S/kWgsnKsBUvOqQoiYPb+WR+haMx8ZSE1uzZGa2pqJWmPMrI2
   TvrPlsrCui5EwQK/2FeuP0tdYUZ8KiZEZNOBBaeuLsmIDvJv14xKmspsN
   P1Fk4BFybhUQAMZWdLLqovnDOQsd3yGUdHv4sXHeNfzmT/4wy+ZRfjQEN
   C+Lk4j52Iu26C8iWkpumbDml1cZ11c8Th/NsdMG+gWm6vACRKN8PFDRgM
   i1sVIs3Fd3E6S+nlun53dow8vtGkG+5DtfwK9Frr3BgGCFFvTmE/OYSbD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="340401237"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="340401237"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 23:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="770494939"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="770494939"
Received: from gpshihat-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.93.231])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 23:08:31 -0700
Subject: [PATCH] hw/acpi/cxl: Drop device-memory support from CFMWS entries
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan.Cameron@huawei.com
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Date:   Mon, 20 Mar 2023 23:08:31 -0700
Message-ID: <167937891122.1510933.11055956062467467440.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

While it was a reasonable idea to specify no window restricitions at the
outset of the CXL emulation support, it turns out that in practice a
platform will never follow the QEMU example of specifying simultaneous
support for HDM-H and HDM-D[B] in a single window.

HDM-D mandates extra bus cycles for host/device bias protocol, and HDM-DB
mandates extra bus cycles for back-invalidate protocol, so hardware must
be explicitly prepared for device-memory unlike host-only memory
(HDM-H).

In preparation for the kernel dropping support for windows that do not
select between device and host-only memory, move QEMU exclusively to
declaring host-only windows.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 hw/acpi/cxl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 2bf8c0799359..defb289e2fef 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -103,8 +103,8 @@ static void cedt_build_cfmws(GArray *table_data, CXLState *cxls)
         /* Host Bridge Interleave Granularity */
         build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
 
-        /* Window Restrictions */
-        build_append_int_noprefix(table_data, 0x0f, 2); /* No restrictions */
+        /* Window Restrictions: Host-only ram and pmem */
+        build_append_int_noprefix(table_data, 0x0e, 2);
 
         /* QTG ID */
         build_append_int_noprefix(table_data, 0, 2);

