Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC93358CA
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130215; cv=none; b=Ndc/Gd5RH9Jqbb+ZUS2mz2pRxinMn3xap9kR1Dr06qhMhy1+T2TYdEqSH90ZR+xZcWy/GH4xWtrax9beZwqFRkigeJewlEynVgdyQrj7b/4YLEIGp1pnvijSQp9ySCFmbKOyrDKb90RCCiVFJNKtx4p/2xCZfIUYcnH6nh1kkn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130215; c=relaxed/simple;
	bh=VwvHACguTiv1GiYnuO5xbYjbMx0mlTTO6oYSoR3Y/A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRmSZ0vnlZIzE8ya6ha4TpPLmvC12GgSmottDr/SwfOLkgjO09L9UGbYrAvj72XVC1a3odVDUSptPJ/Gq69AX3uYPrO/FKKd38lndobG1QQhogYW7xMosOEg6+6WfcomdtsIkkfQOkg2ShhV5hhWPlPgmoEC88J3I58Jd7bE9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3FB1F00893;
	Wed, 10 Jun 2026 22:23:34 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v3 2/6] cxl/test: Add type2 support for mock CFMWS0
Date: Wed, 10 Jun 2026 15:23:24 -0700
Message-ID: <20260610222328.2272427-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610222328.2272427-1-dave.jiang@intel.com>
References: <20260610222328.2272427-1-dave.jiang@intel.com>
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
 tools/testing/cxl/test/cxl.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index b00f5161b5f0..e91c125d557d 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -17,6 +17,7 @@
 static int interleave_arithmetic;
 static bool extended_linear_cache;
 static bool fail_autoassemble;
+static bool type2_test;
 
 #define FAKE_QTG_ID	42
 
@@ -384,6 +385,19 @@ static struct {
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
@@ -472,6 +486,11 @@ static void cfmws_elc_update(struct acpi_cedt_cfmws *window, int index)
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
@@ -493,10 +512,14 @@ static int populate_cedt(void)
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
@@ -1824,6 +1847,8 @@ bool __init have_multiple_modparms(void)
 		count++;
 	if (fail_autoassemble)
 		count++;
+	if (type2_test)
+		count++;
 
 	return count > 1;
 }
@@ -2048,6 +2073,8 @@ module_param(extended_linear_cache, bool, 0444);
 MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
 module_param(fail_autoassemble, bool, 0444);
 MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
+module_param(type2_test, bool, 0444);
+MODULE_PARM_DESC(type2_test, "Enable type 2 support testing");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.54.0

