Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C5EE77347
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Sep 2023 23:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjI2XJi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Sep 2023 19:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2XJh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Sep 2023 19:09:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AF0DD
        for <linux-cxl@vger.kernel.org>; Fri, 29 Sep 2023 16:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696028974; x=1727564974;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I+pGIPYdvlTDz4UX+LrZQ0OshunMoGGi5Wn+AimK7UA=;
  b=WnTn7Pg53Xqan5HGOvImCiW2GEzNQqK5QpJk9nJWjxIpoq4e7XuEi0j7
   J/gg65kYURaNibmCI0oNzJpIl4S2tn3OHzbID0kpro0nWZ6yQFi+HrK9u
   DzyAL+5oovDygDXdhQvaPDLFVj49ol92tf6bWUBvG7RRHsgaSBk5nRjUW
   5VHZe6+OiKeQJtFUvm4sKoWbouICEx6NAZEzklp8YOhcYmAso6b+yfsSy
   8o7QKM8iwU0ZZuWAUlnGyEXP+ADTCP6pCmoNAeJGCbrq7nT5E8PJPp3Sz
   aH/EO9QpiT/nW13xzjYPdJWZ3xPLF42paOKT2Dk45cX4sWh00mUzgPH76
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="381279649"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="381279649"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="743572005"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="743572005"
Received: from thamvo-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.56.79])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:09:33 -0700
Subject: [PATCH v2 1/4] cxl/pci: Remove unnecessary device reference
 management in sanitize work
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com
Date:   Fri, 29 Sep 2023 16:09:33 -0700
Message-ID: <169602897366.904193.9449207727775648546.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Given that any particular put_device() could be the final put of the
device, the fact that there are usages of cxlds->dev after
put_device(cxlds->dev) is a red flag. Drop the reference counting since
the device is pinned by being registered and will not be unregistered
without triggering the driver + workqueue to shutdown.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 44a21ab7add5..aa1b3dd9e64c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -152,8 +152,6 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
 	mutex_lock(&mds->mbox_mutex);
 	if (cxl_mbox_background_complete(cxlds)) {
 		mds->security.poll_tmo_secs = 0;
-		put_device(cxlds->dev);
-
 		if (mds->security.sanitize_node)
 			sysfs_notify_dirent(mds->security.sanitize_node);
 
@@ -296,9 +294,6 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 		 */
 		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
 			if (mds->security.poll) {
-				/* hold the device throughout */
-				get_device(cxlds->dev);
-
 				/* give first timeout a second */
 				timeout = 1;
 				mds->security.poll_tmo_secs = timeout;

