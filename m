Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671C381DA
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5PdfgA2"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B657D10A
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 10:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698340816; x=1729876816;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=eYyIbjKPwlF9D09YzMgAi3QkO5WTycXFQYbeqGqirsM=;
  b=F5PdfgA2bT1IqXeteXc6V0iW6FRDCzEqbIjI1r/DnjWv3rNx/7HpZhx6
   WF6qXl9Cn+VgUuQWZcLRsRwhz+kys1j5JJYIS050gKpP6bBnn+281K6YZ
   cB3UWbrhAy1ie9nlCKO21ZLavvesdkHtClJJ8vaZo89vssYz23tLNPHdm
   AFiCaDljPqNW49nC0kSb/zmSUBcBW2BqosZC+zt9HBf2qxcZMeskbNvw3
   CegVvBHkSPDcNR3b1etS+bUL0PihW96MU12pPhrOm1p/q+7S9QGext48L
   8vkdVmJCbjvt9sEF5MmKa4SaQX5tDYtfDXavrfZ0vxcQgBdzWWEnAHDos
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="387425568"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="387425568"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 10:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="794297541"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="794297541"
Received: from lsingh-mobl2.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.110.60])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 10:20:15 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Thu, 26 Oct 2023 11:20:00 -0600
Subject: [PATCH] tools/testing/cxl: slow down the mock firmware transfer
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-vv-fw_upd_test_fix-v1-1-a6345df5550b@intel.com>
X-B4-Tracking: v=1; b=H4sIAL+fOmUC/x2MQQqAIBAAvxJ7TjBFob4SIZJr7cVCywLx70nHG
 ZgpkDASJpi6AhEzJTpCg6HvYN1t2JCRawyCCzlwoVnOzD/mPp25MF3G08uUlDhaLT3nClp4Rmz
 6n85LrR+kIKDSZAAAAA==
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, alison.schofield@intel.com, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=eYyIbjKPwlF9D09YzMgAi3QkO5WTycXFQYbeqGqirsM=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKlW80+9sN/fGXHrP0Ou8ul9awJEP6w9xW8avvjE5Y8s5
 3O5r93+3lHKwiDGxSArpsjyd89HxmNy2/N5AhMcYeawMoEMYeDiFICJbP/IyHDsWk3RLWkXft5J
 Nkqf8g1SOxsZlvfFP365fKZR58PUBdcYGZ6fEu6cLdH33DP82f/YIMev69IbhIWu7PjJyrazPGG
 PFw8A
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

The cxl-cli unit test for firmware update does operations like starting
an asynchronous firmware update, making sure it is in progress, and
attempting to cancel it. In some cases, such as with no or minimal
dynamic debugging turned on, the firmware update completes too quickly,
not allowing the test to have a chance to verify it was in progress.
This caused a failure of the signature:

  expected fw_update_in_progress:true
  test/cxl-update-firmware.sh: failed at line 88

Fix this by adding a fixed delay (2ms) to each firmware transfer
request handled by the mocked interface.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 tools/testing/cxl/test/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 464fc39ed277..a74da69876f2 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1237,6 +1237,7 @@ static int mock_transfer_fw(struct cxl_mockmem_data *mdata,
 	}
 
 	memcpy(fw + offset, transfer->data, length);
+	udelay(2000);
 	return 0;
 }
 

---
base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
change-id: 20231026-vv-fw_upd_test_fix-533e9a63f005

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

