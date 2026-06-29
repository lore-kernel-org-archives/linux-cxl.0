Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D8D1DED4C
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764847; cv=none; b=d2nRW58wz3s9HiB86ur4PIP1d7h1ZW6k6NzLsrdUlp7PLeL31SPwaFSwv0pjSO6MY36xX8FylPVX1DUpU5SrTnnWG1bZsJL6d6WsxELhZyI3khKPIBiW07+g0uz7D49Qp2JuO7FlS32MdTTr8pQxZZOxmmSwtXu3OeK/CJGiDFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764847; c=relaxed/simple;
	bh=DhNUv9UMuGWvJu+/i626oRmoHTI/066DQWS6C6jXKIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGjy+WNiG9iXkDYMktZvj9c2OpMpIE+cw9pUlneaS/De+UZZeAqB/dDdGDr+HaYt9gu87KmK0wUdH4d9EC6quUagPRxrTPU1GBSmv/1uC6ERsdktLBGpqA+si18dLy6r+oykUkJpTsHycD1xafliLy0HM5dof1imG9O19lq8bpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59BB1F000E9;
	Mon, 29 Jun 2026 20:27:25 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v6 2/6] cxl/test: Add type2 support for mock CFMWS0
Date: Mon, 29 Jun 2026 13:27:16 -0700
Message-ID: <20260629202720.3658117-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629202720.3658117-1-dave.jiang@intel.com>
References: <20260629202720.3658117-1-dave.jiang@intel.com>
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
v6:
- Rebased against v7.2-rc1
---
 tools/testing/cxl/test/cxl.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 198a128181b9..32964420e470 100644
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
@@ -476,6 +490,11 @@ static void cfmws_elc_update(struct acpi_cedt_cfmws *window, int index)
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
@@ -497,11 +516,15 @@ static int populate_cedt(void)
 		chbs->length = size;
 	}
 
+	if (type2_test)
+		update_type2_cfmws();
+
 	for (i = cfmws_start; i <= cfmws_end; i++) {
 		struct acpi_cedt_cfmws *window = mock_cfmws[i];
 		int align = SZ_256M;
 
-		cfmws_elc_update(window, i);
+		if (i == 0 && !type2_test)
+			cfmws_elc_update(window, i);
 		if (window->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
 			align = max_t(int, SZ_256M, PMD_SIZE);
 		res = alloc_mock_res(window->window_size, align);
@@ -1839,6 +1862,8 @@ static bool __init have_multiple_modparms(void)
 		count++;
 	if (hmem_test)
 		count++;
+	if (type2_test)
+		count++;
 
 	return count > 1;
 }
@@ -2069,6 +2094,8 @@ module_param(extended_linear_cache, bool, 0444);
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

