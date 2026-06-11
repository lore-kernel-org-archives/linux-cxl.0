Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC793D75AA
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781221460; cv=none; b=eXdqXLgeJm053VmBUeFvQwJGJQaHrZfuOawK7a4bS9tCj3RBZi/2ji77QIsRWfBouQQJQTBFhCRSQVcB3oICUePwAY+FMJ0FUsVNmr73ojpgSGt6HBSgw/pJLEzZeqRjrJLYzqToel6pLrxOs+Yn/EnEdnlRodbaocZeyrXu50k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781221460; c=relaxed/simple;
	bh=RVyUE3cswlXTHE3EgAw+6bsIaJY6nQQZm+EEkID02nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQrC+OI/Ba4/NC3HP0HgyBuWfw3F09ArRT9TUaFrOYsC5DjcKqb5BSlh8xNCuj6X1rgblNyJe5HiY4pLGyBF0QjWSkZx/i0N3H7m0XvktJsCZUxWFBzpV/jqGKt7dSMvi3hzNN1e0GhkNXDikmvUvwNuKQyUs+l8jMltoxOxlFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6161F00A3A;
	Thu, 11 Jun 2026 23:44:12 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v5 1/6] cxl/test: Add test for module parameters
Date: Thu, 11 Jun 2026 16:44:04 -0700
Message-ID: <20260611234409.256765-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611234409.256765-1-dave.jiang@intel.com>
References: <20260611234409.256765-1-dave.jiang@intel.com>
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
v5:
- Add test for hmem_test module parameters. (sashiko)
---
 tools/testing/cxl/test/cxl.c       | 20 ++++++++++++++++++++
 tools/testing/cxl/test/hmem_test.c |  3 ++-
 tools/testing/cxl/test/mock.h      |  2 ++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 296516eecfd6..1c8ac8bdd8f7 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1814,11 +1814,31 @@ static struct attribute *cxl_acpi_attrs[] = {
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
 	cxl_acpi_test();
 	cxl_core_test();
 	cxl_mem_test();
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

