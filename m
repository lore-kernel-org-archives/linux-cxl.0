Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED91C4321E
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 20:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbiKNUek (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbiKNUec (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 15:34:32 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD13645C
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 12:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668458072; x=1699994072;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aT/N4vJYhzqu7GWpD+8er9SbNffP59hfQbIFnoGY+l4=;
  b=nVhVDkIa4avO5q+liFI8USSi33EpNKqJm1//LZWLQltSIa7jlxDD3F0p
   wcoW8+cokI43/ugK+9DvTKUzG42HUgiupoDI1UWOuNmjXL9K1fKavpVbl
   PW/DBourU1QHEevpBkPMFli+jiMdIjfmPviac+hWF66kEUPxs1c7nuRuM
   ADUDX2e+FNBpngtRl9dmGTlEUXpREVs8LYAHrX/3pEJIPr907HMl/VG4d
   a7rwMg0EYIGQf553SzaFSSDOon1XmOgZwyc5E/HMiJyeLYyV4NJmr4an9
   ztAv9oF8D7ZwiyaYI1Fgh0/i1DRiSR75rpRen3eEvVLis0VPWoM8SRVJk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="310785284"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="310785284"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:34:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="702155092"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="702155092"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:34:31 -0800
Subject: [PATCH v4 15/18] tools/testing/cxl: add mechanism to lock mem device
 for testing
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date:   Mon, 14 Nov 2022 13:34:31 -0700
Message-ID: <166845807137.2496228.10272288401181625166.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166845791969.2496228.8357488385523295841.stgit@djiang5-desk3.ch.intel.com>
References: <166845791969.2496228.8357488385523295841.stgit@djiang5-desk3.ch.intel.com>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 6dd286a52839..7384573e8b12 100644
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
+	return sysfs_emit(buf, "%u\n",
+			  !!(mdata->security_state & CXL_PMEM_SEC_STATE_LOCKED));
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
@@ -752,6 +791,7 @@ static __init int cxl_test_init(void)
 			goto err_mem;
 		}
 
+		pdev->dev.groups = cxl_mock_mem_groups;
 		rc = platform_device_add(pdev);
 		if (rc) {
 			platform_device_put(pdev);


