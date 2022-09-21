Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08178ECAAD8
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Sep 2022 15:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiIUPia (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Sep 2022 11:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiIUPiE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Sep 2022 11:38:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4999FAB9
        for <linux-cxl@vger.kernel.org>; Wed, 21 Sep 2022 08:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663774446; x=1695310446;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z/sRKR4Uf1Fd3fhu2JpYBo7PYIXroMMKfcS7nGGM09o=;
  b=QHc1VPbzYLVVglSvWTN466e0hmH6PAWepmYQV7J50LYImrbQGGTC+b+D
   +NPlchWSkZLoeIOxOyAxG6iwKE93tLTQ22ajEkP5OIhhjSTiZpkfD6fw1
   0P4AAAupapN66hyR0UjJe/+fv/1/bodR4Zq1aNJJd9OvTwJGwXBmfV6bA
   nGTuKEVzbrH8Au4w6VMa1/JQFMKWkwaeBQxJdb7+P0tZ0emy7rUtBTOtn
   rKVJq0fyQKMqEFCH0u494g6t4pS2UgXPnaglg16icAumyDc8e6RGgmgMo
   0CcD3gLdgKC0oG4fFtGVgafyd6Os6nJGMQ9c7YPZ35Q/ClJwbsAU84+EF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="280407737"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="280407737"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:33:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="597034890"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:33:03 -0700
Subject: [PATCH v2 16/19] tools/testing/cxl: add mechanism to lock mem device
 for testing
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, dan.j.williams@intel.com,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dave@stgolabs.net,
        Jonathan.Cameron@huawei.com
Date:   Wed, 21 Sep 2022 08:33:03 -0700
Message-ID: <166377438336.430546.14222889528313880160.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The mock cxl mem devs needs a way to go into "locked" status to simulate
when the platform is rebooted. Add a sysfs mechanism so the device security
state is set to "locked" and the frozen state bits are cleared.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c |   52 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 6dd286a52839..7f76f494a0d4 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -628,6 +628,45 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
 #define SZ_512G (SZ_64G * 8)
 #endif
 
+static ssize_t security_lock_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_mock_mem_pdata *mdata = dev_get_platdata(dev);
+
+	return sysfs_emit(buf, "%s\n", mdata->security_state & CXL_PMEM_SEC_STATE_LOCKED ?
+			  "locked" : "unlocked");
+}
+
+static ssize_t security_lock_store(struct device *dev, struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct cxl_mock_mem_pdata *mdata = dev_get_platdata(dev);
+	u32 mask = CXL_PMEM_SEC_STATE_FROZEN | CXL_PMEM_SEC_STATE_USER_PLIMIT |
+		   CXL_PMEM_SEC_STATE_MASTER_PLIMIT;
+	int val;
+
+	if (kstrtoint(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val == 1) {
+		if (!(mdata->security_state & CXL_PMEM_SEC_STATE_USER_PASS_SET))
+			return -ENXIO;
+		mdata->security_state |= CXL_PMEM_SEC_STATE_LOCKED;
+		mdata->security_state &= ~mask;
+	} else {
+		return -EINVAL;
+	}
+	return count;
+}
+
+static DEVICE_ATTR_RW(security_lock);
+
+static struct attribute *cxl_mock_mem_attrs[] = {
+	&dev_attr_security_lock.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(cxl_mock_mem);
+
 static __init int cxl_test_init(void)
 {
 	struct cxl_mock_mem_pdata *mem_pdata;
@@ -757,6 +796,11 @@ static __init int cxl_test_init(void)
 			platform_device_put(pdev);
 			goto err_mem;
 		}
+
+		rc = device_add_groups(&pdev->dev, cxl_mock_mem_groups);
+		if (rc)
+			goto err_mem;
+
 		cxl_mem[i] = pdev;
 	}
 
@@ -811,8 +855,12 @@ static __exit void cxl_test_exit(void)
 	int i;
 
 	platform_device_unregister(cxl_acpi);
-	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_mem[i]);
+	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--) {
+		struct platform_device *pdev = cxl_mem[i];
+
+		device_remove_groups(&pdev->dev, cxl_mock_mem_groups);
+		platform_device_unregister(pdev);
+	}
 	for (i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--)
 		platform_device_unregister(cxl_switch_dport[i]);
 	for (i = ARRAY_SIZE(cxl_switch_uport) - 1; i >= 0; i--)


