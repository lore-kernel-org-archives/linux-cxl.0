Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB931BDC7
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2FFYecw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FAF90
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698341567; x=1729877567;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=aB7jQwPTZQThKw8XuvcJidpKzcPWOd29QdF/5nkfvh0=;
  b=i2FFYecwNURi/RuOiIohpjT/R/hnZC4oiZkLy9mlc3lWmndldH04gVwU
   9NwIhBGYJkwboeAWh4ROMRrSTLyJMdCaNorOUfFpSIsIJ/XHsdLhtOo+T
   cjxbTHMFhRwkO8uGO4YPlgeZrkcecLYve/8iI9JH6mivA7w16mIsGW34D
   l0fEzFcxTZsYKY9bhzGqGdBouOSiLx8fA86cs8fom55qtGwh5LiPWD5W5
   G9Zc26527Rw24vEsDE82J417WvE9dINQ0F7hrCD2VEcw4muWalydXUC+7
   FhlOMb03uA2PuwxxnxpeCzpJUtGUWGaSHUPANC6HxHqjXeAVWpDEQoRIm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="9153654"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="9153654"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 10:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="568356"
Received: from lsingh-mobl2.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.110.60])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 10:32:35 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Thu, 26 Oct 2023 11:32:41 -0600
Subject: [PATCH v2] tools/testing/cxl: slow down the mock firmware transfer
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-vv-fw_upd_test_fix-v2-1-5282fd193883@intel.com>
X-B4-Tracking: v=1; b=H4sIALiiOmUC/32NWwrCMBBFt1Lm20gepqBf7kNKqM3EDmhSkhiVk
 r0buwA/z4F77goJI2GCU7dCxEKJgm8gdx1M8+hvyMg2BsmlElz2rBTmXua5WJMxZePozbRSeBx
 75TjX0IZLxKa36GVoPFPKIX62jyJ+9m+uCCZYyx20dVprfj2Tz3jfT+EBQ631CyMMsAG0AAAA
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, alison.schofield@intel.com, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1573;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=aB7jQwPTZQThKw8XuvcJidpKzcPWOd29QdF/5nkfvh0=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKlWi/bNqDdWMkhhf6bHbvUg6Wnc88smWWdLTy7VOtzJ+
 nd+10nNjlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAExkYizD/9Tt7bpKJ1Q3Cbu6
 v3vdFJrfIrPYT/qAXcqxnqnPMi32ijD8r+jwbpzSqbh098c1Xx4rHdDu3cbYoCauY1noZb3J7mE
 vFwA=
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

Fix this by adding a delay (~1.5 - 2 ms) to each firmware transfer
request handled by the mocked interface.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
Changes in v2:
- Checkpatch suggests using usleep_range() instead of udelay()
- Link to v1: https://lore.kernel.org/r/20231026-vv-fw_upd_test_fix-v1-1-a6345df5550b@intel.com
---
 tools/testing/cxl/test/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 464fc39ed277..1195369a4e96 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1237,6 +1237,7 @@ static int mock_transfer_fw(struct cxl_mockmem_data *mdata,
 	}
 
 	memcpy(fw + offset, transfer->data, length);
+	usleep_range(1500, 2000);
 	return 0;
 }
 

---
base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
change-id: 20231026-vv-fw_upd_test_fix-533e9a63f005

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

