Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3A23264FC
	for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898965; cv=none; b=b7u/ZEHAHALc+xH5bqPk93lrW5+AEoQk7xhaRpcK5Z6GBowRpi7rttr7jJSXHJRiTRSHNd2dLtTFjfJPhCZe5AOAhhDIEWERR6rq7+3rdLtaaxAQQRnJpgSxSTtLEt8JBLjWp1t7bGSUMMBbRJ1S2e3P/2ScX7xktUcnZ85txHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898965; c=relaxed/simple;
	bh=k6izplsAoOzXeHTBjyyy6dpCCeFnS3VtfZznWfjq8J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLpCPWy5KCdBenEBZ5Zl4q1UHaiIUhXnJfQpE+TaWBpWmEEYTMMokF18TYKM0nM07IbYsxqSVwvwokpIwKa4A7NZZC08zoah0pTH7TH1IcwYDX/cjhBE4mkNDLDOHOVd/yk6Lv6XK0Ifa8mmZyvGm8rkkncgGnewxbj+qtEdzGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C22C19425;
	Wed, 22 Apr 2026 23:02:45 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Subject: [PATCH 4/7] cxl/test: Add hierarchy enumeration support for type2 device
Date: Wed, 22 Apr 2026 16:02:34 -0700
Message-ID: <20260422230237.2599333-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422230237.2599333-1-dave.jiang@intel.com>
References: <20260422230237.2599333-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add enumeration of type2 device hierarchy in cxl-test. The type2 device
is setup to be directly attached to a root port instead of rp -> switch
-> device that type3 hierarchy is setup..

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c | 110 ++++++++++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 7 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 5fd73f0634c6..59a265ad23e0 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1539,6 +1539,9 @@ static __init int cxl_rch_topo_init(void)
 {
 	int rc, i;
 
+	if (type2_test)
+		return 0;
+
 	for (i = 0; i < ARRAY_SIZE(cxl_rch); i++) {
 		int idx = NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + i;
 		struct acpi_device *adev = &host_bridge[idx];
@@ -1582,6 +1585,9 @@ static void cxl_rch_topo_exit(void)
 {
 	int i;
 
+	if (type2_test)
+		return;
+
 	for (i = ARRAY_SIZE(cxl_rch) - 1; i >= 0; i--) {
 		struct platform_device *pdev = cxl_rch[i];
 
@@ -1596,6 +1602,9 @@ static __init int cxl_single_topo_init(void)
 {
 	int i, rc;
 
+	if (type2_test)
+		return 0;
+
 	for (i = 0; i < ARRAY_SIZE(cxl_hb_single); i++) {
 		struct acpi_device *adev =
 			&host_bridge[NR_CXL_HOST_BRIDGES + i];
@@ -1705,6 +1714,9 @@ static void cxl_single_topo_exit(void)
 {
 	int i;
 
+	if (type2_test)
+		return;
+
 	for (i = ARRAY_SIZE(cxl_swd_single) - 1; i >= 0; i--)
 		platform_device_unregister(cxl_swd_single[i]);
 	for (i = ARRAY_SIZE(cxl_swu_single) - 1; i >= 0; i--)
@@ -1721,19 +1733,90 @@ static void cxl_single_topo_exit(void)
 	}
 }
 
+static void cxl_type3_mem_exit(void)
+{
+	struct platform_device *pdev;
+	int i;
+
+	for (i = ARRAY_SIZE(cxl_rcd) - 1; i >= 0; i--) {
+		pdev = cxl_rcd[i];
+		if (!pdev)
+			break;
+		platform_device_unregister(cxl_rcd[i]);
+	}
+
+	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--) {
+		pdev = cxl_mem_single[i];
+		if (!pdev)
+			break;
+		platform_device_unregister(cxl_mem_single[i]);
+	}
+
+	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--) {
+		pdev = cxl_mem[i];
+		if (!pdev)
+			break;
+		platform_device_unregister(pdev);
+	}
+}
+
+static void cxl_type2_mem_exit(void)
+{
+	for (int i = NR_CXL_ROOT_PORTS - 1; i >= 0; i--) {
+		struct platform_device *pdev = cxl_mem[i];
+
+		if (!pdev)
+			break;
+		platform_device_unregister(pdev);
+	}
+}
+
 static void cxl_mem_exit(void)
 {
-	int i;
+	if (type2_test) {
+		cxl_type2_mem_exit();
+		return;
+	}
 
-	for (i = ARRAY_SIZE(cxl_rcd) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_rcd[i]);
-	for (i = ARRAY_SIZE(cxl_mem_single) - 1; i >= 0; i--)
-		platform_device_unregister(cxl_mem_single[i]);
-	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--)
+	cxl_type3_mem_exit();
+}
+
+static int cxl_type2_mem_init(void)
+{
+	int i, rc;
+
+	for (i = 0; i < NR_CXL_ROOT_PORTS; i++) {
+		struct platform_device *dport = cxl_root_port[i];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_type2_accel", i);
+		if (!pdev)
+			goto err_mem;
+		pdev->dev.parent = &dport->dev;
+		set_dev_node(&pdev->dev, i % 2);
+
+		rc = platform_device_add(pdev);
+		if (rc) {
+			platform_device_put(pdev);
+			goto err_mem;
+		}
+		cxl_mem[i] = pdev;
+	}
+
+	return 0;
+
+err_mem:
+	for (i = NR_CXL_ROOT_PORTS - 1; i >= 0; i--) {
+		struct platform_device *pdev = cxl_mem[i];
+
+		if (!pdev)
+			break;
 		platform_device_unregister(cxl_mem[i]);
+	}
+	return rc;
 }
 
-static int cxl_mem_init(void)
+static int cxl_type3_mem_init(void)
 {
 	int i, rc;
 
@@ -1806,6 +1889,13 @@ static int cxl_mem_init(void)
 	return rc;
 }
 
+static int cxl_mem_init(void)
+{
+	if (type2_test)
+		return cxl_type2_mem_init();
+	return cxl_type3_mem_init();
+}
+
 static ssize_t
 decoder_reset_preserve_registry_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
@@ -2008,6 +2098,9 @@ static int cxl_dsps_populate(void)
 
 static void cxl_switches_remove(void)
 {
+	if (type2_test)
+		return;
+
 	cxl_usps_remove();
 	cxl_dsps_remove();
 }
@@ -2016,6 +2109,9 @@ static int cxl_switches_populate(void)
 {
 	int rc;
 
+	if (type2_test)
+		return 0;
+
 	BUILD_BUG_ON(ARRAY_SIZE(cxl_switch_uport) != ARRAY_SIZE(cxl_root_port));
 	rc = cxl_usps_populate();
 	if (rc)
-- 
2.53.0

