Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF3328DC4
	for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898962; cv=none; b=JdnmapxQN7Co4Vqe7bCWHqZywPrFIETtUtuyEUJtwd7hIIRFz0MRhq2C9jHZTmuSo2Xy4ffAfIknje3Cnkua28VYTyIlpPDBcT1EO6Zje4zlEcWLS2W08Y8ppq3DBssYN/S8QqviOFdB/TAwU1TFYQjf87MaRBvXndCDbuPmPg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898962; c=relaxed/simple;
	bh=DmWRTOwvlwu7PonTBPNiZ4nu6PmIv84Ijv0O3mdAWZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9SQATeo0OfG4uLU6ib1YShzwcG7AuMxQfUmqVCPWXSteRNijNvURW3pC61rZlNxPACAb1ePUmu3907l/WCeunaiWZ6FaDW40ykvaVwNJiYQuSAHwyIJ5iCuUuMRFat7psCSi7X3W84sFUoILV0xzp/8oCLGtK+98Y4UGN+dPEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B734C19425;
	Wed, 22 Apr 2026 23:02:41 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Subject: [PATCH 2/7] cxl/test: Add type2 support for mock CFMWS0
Date: Wed, 22 Apr 2026 16:02:32 -0700
Message-ID: <20260422230237.2599333-3-dave.jiang@intel.com>
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

Add a module parameter 'type2_test' for triggering type2 test support
in cxl_test. Setup the CFMWS0 configuration to be type2 when 'type2_test'
is set.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index c26c37cef12c..903223013e41 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -16,6 +16,7 @@
 
 static int interleave_arithmetic;
 static bool extended_linear_cache;
+static bool type2_test;
 
 #define FAKE_QTG_ID	42
 
@@ -383,6 +384,19 @@ static struct {
 	},
 };
 
+static struct acpi_cedt_cfmws type2_cfmws0 = {
+	.header = {
+		.type = ACPI_CEDT_TYPE_CFMWS,
+		.length = sizeof(mock_cedt.cfmws0),
+	},
+	.interleave_ways = 0,
+	.granularity = 4,
+	.restrictions = ACPI_CEDT_CFMWS_RESTRICT_DEVMEM |
+			ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
+	.qtg_id = FAKE_QTG_ID,
+	.window_size = SZ_256M * 4,
+};
+
 struct acpi_cedt_cfmws *mock_cfmws[] = {
 	[0] = &mock_cedt.cfmws0.cfmws,
 	[1] = &mock_cedt.cfmws1.cfmws,
@@ -471,6 +485,11 @@ static void cfmws_elc_update(struct acpi_cedt_cfmws *window, int index)
 	window->window_size = mock_auto_region_size * 2;
 }
 
+static void update_type2_cfmws(void)
+{
+	memcpy(&mock_cedt.cfmws0.cfmws, &type2_cfmws0, sizeof(type2_cfmws0));
+}
+
 static int populate_cedt(void)
 {
 	struct cxl_mock_res *res;
@@ -492,10 +511,14 @@ static int populate_cedt(void)
 		chbs->length = size;
 	}
 
+	if (type2_test)
+		update_type2_cfmws();
+
 	for (i = cfmws_start; i <= cfmws_end; i++) {
 		struct acpi_cedt_cfmws *window = mock_cfmws[i];
 
-		cfmws_elc_update(window, i);
+		if (i == 0 && !type2_test)
+			cfmws_elc_update(window, i);
 		res = alloc_mock_res(window->window_size, SZ_256M);
 		if (!res)
 			return -ENOMEM;
@@ -2029,6 +2052,8 @@ module_param(interleave_arithmetic, int, 0444);
 MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
 module_param(extended_linear_cache, bool, 0444);
 MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
+module_param(type2_test, bool, 0444);
+MODULE_PARM_DESC(type2_test, "Enable type 2 support testing");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.53.0

