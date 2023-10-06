Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463D1EA1
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NE43Njcl"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB276E9
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696577165; x=1728113165;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vk4tx+csN7fnrFRQFovjtKXGsT01perxiVyqKyByoUE=;
  b=NE43Njcl3Aq+l9XstnLy9EMLQ1lFDRFeBXAjnKQz4Zlrzw08/0pwArsV
   Ku3AlLpOmeYKX1UfKxJgfeb9FAK7SiwUEaj9ky/xKM8YUzHmeODlC8LIu
   gDzC0mSlVPQmc+bTRj5+KsdMKzgQhm3F5WlF6SLROxApYuoZI4rAFLjvt
   Dj19EdurRIz1oZqInphthiKfYfmsSseQgEt+fkgTg8wIymCcmUheFyNnl
   LS5hbKQSncWrC87GLGboNJgqE1lq9a+lh3oUsdvcRikUuf8jPI+RlB3rs
   jktZcZ/ETBh+CBTd2QtZ0oVgAkEHeZvC438VaNhzfnXxobSW8GELmF4rt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="368775169"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="368775169"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="842735409"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="842735409"
Received: from wbleichn-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.147.24])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:04 -0700
Subject: [PATCH v3 01/10] cxl/pci: Remove unnecessary device reference
 management in sanitize work
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>
Date: Fri, 06 Oct 2023 00:26:04 -0700
Message-ID: <169657716434.1491153.11640655683077170158.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Given that any particular put_device() could be the final put of the
device, the fact that there are usages of cxlds->dev after
put_device(cxlds->dev) is a red flag. Drop the reference counting since
the device is pinned by being registered and will not be unregistered
without triggering the driver + workqueue to shutdown.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
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

