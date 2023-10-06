Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EECA6FB6
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7aAAKOV"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA67F1
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696577207; x=1728113207;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eBR2cmL2NYIOonh4VvZWdAhYxEFKkkvfvPzj5dqaF+4=;
  b=W7aAAKOVzqViLPsIW1H4mxp7z/sgwVJqjvkKg1FdRoT8AJbcXjIsUKRB
   W/uiB9pgbgv19ee2gIbDEJ7tpie7DM1a6HL7u1w1YSXnlSBGEDl75JNeF
   P5ysIoX0XwIckCnTMg6IRC3ejx4P5LxXle8irpJ8ps/u3wqBBDP1x6fv0
   yr6WkvTWdLF4xSmrJkVvTofZstpYEqMNewZplTC2fbxFGSWfmNaTtjTXt
   RzLJ2ZLuZIo0RwFkIV2QuWPHvmW8Ea8G9f8BIze5gSKIRceHSTgbMKRhE
   zuoQnQqoQUzGK3Z/v3n7eiNR/dmUI2Fix4K/LBnjNmtbam1LMo96VcjfG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="368775202"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="368775202"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="842735507"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="842735507"
Received: from wbleichn-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.147.24])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:46 -0700
Subject: [PATCH v3 08/10] cxl/mem: Fix shutdown order
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>, Ira Weiny <ira.weiny@intel.com>
Date: Fri, 06 Oct 2023 00:26:45 -0700
Message-ID: <169657720558.1491153.15670462991242849575.stgit@dwillia2-xfh.jf.intel.com>
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

Ira reports that removing cxl_mock_mem causes a crash with the following
trace:

 BUG: kernel NULL pointer dereference, address: 0000000000000044
 [..]
 RIP: 0010:cxl_region_decode_reset+0x7f/0x180 [cxl_core]
 [..]
 Call Trace:
  <TASK>
  cxl_region_detach+0xe8/0x210 [cxl_core]
  cxl_decoder_kill_region+0x27/0x40 [cxl_core]
  cxld_unregister+0x29/0x40 [cxl_core]
  devres_release_all+0xb8/0x110
  device_unbind_cleanup+0xe/0x70
  device_release_driver_internal+0x1d2/0x210
  bus_remove_device+0xd7/0x150
  device_del+0x155/0x3e0
  device_unregister+0x13/0x60
  devm_release_action+0x4d/0x90
  ? __pfx_unregister_port+0x10/0x10 [cxl_core]
  delete_endpoint+0x121/0x130 [cxl_core]
  devres_release_all+0xb8/0x110
  device_unbind_cleanup+0xe/0x70
  device_release_driver_internal+0x1d2/0x210
  bus_remove_device+0xd7/0x150
  device_del+0x155/0x3e0
  ? lock_release+0x142/0x290
  cdev_device_del+0x15/0x50
  cxl_memdev_unregister+0x54/0x70 [cxl_core]

This crash is due to the clearing out the cxl_memdev's driver context
(@cxlds) before the subsystem is done with it. This is ultimately due to
the region(s), that this memdev is a member, being torn down and expecting
to be able to de-reference @cxlds, like here:

static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
...
                if (cxlds->rcd)
                        goto endpoint_reset;
...

Fix it by keeping the driver context valid until memdev-device
unregistration, and subsequently the entire stack of related
dependencies, unwinds.

Fixes: 9cc238c7a526 ("cxl/pci: Introduce cdevm_file_operations")
Reported-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a02061028b71..fed9573cf355 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -559,8 +559,8 @@ static void cxl_memdev_unregister(void *_cxlmd)
 	struct cxl_memdev *cxlmd = _cxlmd;
 	struct device *dev = &cxlmd->dev;
 
-	cxl_memdev_shutdown(dev);
 	cdev_device_del(&cxlmd->cdev, dev);
+	cxl_memdev_shutdown(dev);
 	put_device(dev);
 }
 

