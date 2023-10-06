Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1FF63CC
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jy0601Vl"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A57FE4
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696577248; x=1728113248;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=izer0WWtU2ooSNIjXS5t0PkZBaz2vSUwUJBtOCcSu3c=;
  b=jy0601VlHUJ3/ntIN2HFzTLq1tKJlSsGNq3eqg7CCaChG5DybDpfltF5
   AnPIDhoqkS39nAD82KYqqP3weD6L5E5Zt/g2ETb7wte39zH0SinGnmG5Q
   GljvLU1GQvTAPR1QcoZn+reYmT56LUs+UuLlZL1zwhysRyWYkJAOewPOv
   r5GYOS0TCCqPDIGIVUGpIC7QUnk5iAqlxUZ05m0Ge9C6bWUdOSfb6B7A8
   HKNYUKHg9YR4bSv9nv31l8cZ2OXT5wsky8qoXpNA4uZ1bt0w0EuT7WyBI
   aSooWOYkKWKyIkfEWdASIZtf/vQt2LYWTOXFVy9oj+mh4GHO5v7+K1FOj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="368775246"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="368775246"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:27:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="842735530"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="842735530"
Received: from wbleichn-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.147.24])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:52 -0700
Subject: [PATCH v3 09/10] tools/testing/cxl: Make cxl_memdev_state available
 to other command emulation
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Date: Fri, 06 Oct 2023 00:26:51 -0700
Message-ID: <169657721157.1491153.10282227094664408585.stgit@dwillia2-xfh.jf.intel.com>
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

Move @mds out of the event specific 'struct mock_event_store' and into
the base 'struct cxl_mockmem_data' directly. This is in preparation for
enabling cxl_test to exercise the notifier flow for 'sanitize' operation
completion.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/mem.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 68118c37f0b5..ab311b59899a 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -133,7 +133,6 @@ struct mock_event_log {
 };
 
 struct mock_event_store {
-	struct cxl_memdev_state *mds;
 	struct mock_event_log mock_logs[CXL_EVENT_TYPE_MAX];
 	u32 ev_status;
 };
@@ -150,6 +149,7 @@ struct cxl_mockmem_data {
 	int user_limit;
 	int master_limit;
 	struct mock_event_store mes;
+	struct cxl_memdev_state *mds;
 	u8 event_buf[SZ_4K];
 	u64 timestamp;
 };
@@ -326,7 +326,7 @@ static void cxl_mock_event_trigger(struct device *dev)
 			event_reset_log(log);
 	}
 
-	cxl_mem_get_event_records(mes->mds, mes->ev_status);
+	cxl_mem_get_event_records(mdata->mds, mes->ev_status);
 }
 
 struct cxl_event_record_raw maint_needed = {
@@ -1415,6 +1415,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 
+	mdata->mds = mds;
 	mds->mbox_send = cxl_mock_mbox_send;
 	mds->payload_size = SZ_4K;
 	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
@@ -1447,7 +1448,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	mdata->mes.mds = mds;
 	cxl_mock_add_event_logs(&mdata->mes);
 
 	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);

