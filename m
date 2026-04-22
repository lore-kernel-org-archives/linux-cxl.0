Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DA728DC4
	for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898968; cv=none; b=l2GXl7Rmoh3FaaIWnc1C9CsF75oau6Ji+86UFSD8pEWbmBNlyu9yF+0+Tzr4x4t64Pn8TpKmeFGEXW3Nb6Pim7niavxmRvKpQMFsKPF7S9pn2AFakd4EaH1N4WtWqfO9vVEKxeuxyX/jW9PmcNrMqv4tlCZIWNv3kjiaDvqe7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898968; c=relaxed/simple;
	bh=30gGAqF2qBbJLT2lqYDyv2kR8kyTxK2DD0D+jel1LtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2HZNCF/gO8vTYM8OPIpqOfbbu0qfZf5SPTmV7iRTbmzyHXbmaXNqIVlRvbqbxem4sde4jfVJA2ZNnaIjyVZSh4rrzBFOPzlrDo8pnTgN043fcUQ/W2xdBLj93IJgEeKhbas4D7F2EA+FYGpiNF0GR6TZHoRQllWtU3Y8L27BPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B62FC19425;
	Wed, 22 Apr 2026 23:02:48 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Subject: [PATCH 6/7] cxl/test: Add cxl_test accelerator driver
Date: Wed, 22 Apr 2026 16:02:36 -0700
Message-ID: <20260422230237.2599333-7-dave.jiang@intel.com>
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

Add a type2 accelerator mock driver for the platform device that
simulates a CXL type2 device. The driver exercises the same
minimal API calls that a real CXL type2 driver would utilize.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/Kbuild  |  2 +
 tools/testing/cxl/test/accel.c | 71 ++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 tools/testing/cxl/test/accel.c

diff --git a/tools/testing/cxl/test/Kbuild b/tools/testing/cxl/test/Kbuild
index af50972c8b6d..83d88628df17 100644
--- a/tools/testing/cxl/test/Kbuild
+++ b/tools/testing/cxl/test/Kbuild
@@ -5,9 +5,11 @@ obj-m += cxl_test.o
 obj-m += cxl_mock.o
 obj-m += cxl_mock_mem.o
 obj-m += cxl_translate.o
+obj-m += cxl_mock_accel.o
 
 cxl_test-y := cxl.o
 cxl_mock-y := mock.o
 cxl_mock_mem-y := mem.o
+cxl_mock_accel-y := accel.o
 
 KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes -Wmissing-declarations, $(KBUILD_CFLAGS))
diff --git a/tools/testing/cxl/test/accel.c b/tools/testing/cxl/test/accel.c
new file mode 100644
index 000000000000..f21fdd57034e
--- /dev/null
+++ b/tools/testing/cxl/test/accel.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2026 Intel Corporation. All rights reserved.
+
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/sizes.h>
+#include <linux/bits.h>
+#include <cxl/mailbox.h>
+#include <crypto/sha2.h>
+#include <cxlmem.h>
+
+struct mock_cxl_accel {
+	struct cxl_dev_state cxlds;
+	struct cxl_memdev *cxlmd;
+};
+
+static int cxl_mock_accel_probe(struct platform_device *pdev)
+{
+	struct cxl_attach_region attach = {
+		.attach = {
+			.probe = cxl_memdev_attach_region,
+		}
+	};
+	struct mock_cxl_accel *cxl_accel;
+	struct cxl_dev_state *cxlds;
+	struct cxl_memdev *cxlmd;
+	int rc;
+
+	cxl_accel = devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM,
+					      pdev->dev.id + 1, 0,
+					      struct mock_cxl_accel, cxlds,
+					      false);
+	if (!cxl_accel)
+		return -ENODEV;
+
+	cxlds = &cxl_accel->cxlds;
+	cxlds->media_ready = true;
+	rc = cxl_set_capacity(cxlds, SZ_512M);
+	if (rc)
+		return rc;
+
+	cxlmd = devm_cxl_add_memdev(cxlds, &attach.attach);
+	if (IS_ERR(cxlmd))
+		return PTR_ERR(cxlmd);
+	cxl_accel->cxlmd = cxlmd;
+
+	return 0;
+}
+
+static const struct platform_device_id cxl_mock_accel_ids[] = {
+	{ .name = "cxl_type2_accel", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, cxl_mock_accel_ids);
+
+static struct platform_driver cxl_mock_accel_driver = {
+	.probe = cxl_mock_accel_probe,
+	.id_table = cxl_mock_accel_ids,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+module_platform_driver(cxl_mock_accel_driver);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("cxl_test: accelerator device mock module");
+MODULE_IMPORT_NS("CXL");
-- 
2.53.0

