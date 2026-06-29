Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939CB1DED4C
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764845; cv=none; b=ORNxEWGK8CDJNS+ZJoS3mtTQa7UyWqoI3s5B37/+4RnySlbXZzK7ePMWBGdU47OpAq09yRL9ZlXuYQnh16AfetxSu2me2jAHo0jzj75OAtj5SSFjFlC0pWFql2aiSvppaZsV95dbWhACb75dzllMbX4mwN04CY990h0k7yGx0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764845; c=relaxed/simple;
	bh=scloLsF4TWlwOZ8KzZf/BvH5KwBB0XFLctp/TnIznKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvStCjLPmRtv2/ckeGaOyURAYPAi+9BrfC4umi+fQjEyEdx+I/dq3KCReWeGsU4/OINqrk7izBdj6i8rN32PkZrEMroXT7ESmTMR+jE7jutHmw1slYa/DVCJn7TeFHGM5mKz9lk38KH34JSf0pi0ztY92Kn6hG4Wr+91SfjhHVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3A21F00A3A;
	Mon, 29 Jun 2026 20:27:24 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v6 1/6] cxl/test: Add test for module parameters
Date: Mon, 29 Jun 2026 13:27:15 -0700
Message-ID: <20260629202720.3658117-2-dave.jiang@intel.com>
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

Add a test for module paraters during module init to make sure that
only one is activated.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- rebased against v7.2-rc1
---
 tools/testing/cxl/test/cxl.c       | 20 ++++++++++++++++++++
 tools/testing/cxl/test/hmem_test.c |  3 ++-
 tools/testing/cxl/test/mock.h      |  2 ++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index ef92dd35e030..198a128181b9 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1827,11 +1827,31 @@ static struct attribute *cxl_acpi_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cxl_acpi);
 
+static bool __init have_multiple_modparms(void)
+{
+	int count = 0;
+
+	if (interleave_arithmetic)
+		count++;
+	if (extended_linear_cache)
+		count++;
+	if (fail_autoassemble)
+		count++;
+	if (hmem_test)
+		count++;
+
+	return count > 1;
+}
+
 static __init int cxl_test_init(void)
 {
 	int rc, i;
 	struct range mappable;
 
+	/* Enforce a single module param active at a time */
+	if (have_multiple_modparms())
+		return -EINVAL;
+
 	if (!IS_ALIGNED(mock_auto_region_size, PMD_SIZE)) {
 		pr_err_once("mock_auto_region_size %d must be PMD-aligned\n",
 			    mock_auto_region_size);
diff --git a/tools/testing/cxl/test/hmem_test.c b/tools/testing/cxl/test/hmem_test.c
index 3a1a089e1721..0fa00f7e16db 100644
--- a/tools/testing/cxl/test/hmem_test.c
+++ b/tools/testing/cxl/test/hmem_test.c
@@ -3,8 +3,9 @@
 #include <linux/moduleparam.h>
 #include <linux/workqueue.h>
 #include "../../../drivers/dax/bus.h"
+#include "mock.h"
 
-static bool hmem_test;
+bool hmem_test;
 
 static void hmem_test_work(struct work_struct *work)
 {
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index 4f57dc80ae7d..846d7c5d6eaa 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -5,6 +5,8 @@
 #include <linux/dax.h>
 #include <cxl.h>
 
+extern bool hmem_test;
+
 struct cxl_mock_ops {
 	struct list_head list;
 	bool (*is_mock_adev)(struct acpi_device *dev);
-- 
2.54.0

