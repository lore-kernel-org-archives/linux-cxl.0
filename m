Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107B4371D04
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 23:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781221468; cv=none; b=MA68HuzTNV0P4JRV4lcJpgDQVnbliE6QOA1MVOioMOyaaY5cnbuQkRPIBkLsXFRcAz8W4wi0PvU3dY051ncSiAhWPKfQDMeK8aol78X9WQhbR178auc+Vn0UdryzncGJ6B+BTjrzbiR4hNB7O957djlZ71xJxW67TVOl5SVTXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781221468; c=relaxed/simple;
	bh=heAIxVv8upH0jeEcadAsN5YWH/mW2inaG5hRxrJ3F54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzSU2PGTqGhuykpwXCgCig5hu1YmnkXiTcWGoBkXHHAovLuRGCLk2Th3DAf3uXSOIPmasqnLIiuG8uH3JIurAzEsMRS6KLKpvR0ERBdMzjGSCbPQ68Rt06k+pjUcsxUWwS3/dkm9NA65FnTLsMxG6vVigBj39+qwVqVX1v2/HtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2922A1F00ACA;
	Thu, 11 Jun 2026 23:44:20 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v5 6/6] cxl/test: Add cxl_test accelerator driver
Date: Thu, 11 Jun 2026 16:44:09 -0700
Message-ID: <20260611234409.256765-7-dave.jiang@intel.com>
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

Add a type2 accelerator mock driver for the platform device that
simulates a CXL type2 device. The driver exercises the same
minimal API calls that a real CXL type2 driver would utilize.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/Kbuild  |  2 ++
 tools/testing/cxl/test/accel.c | 66 ++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 tools/testing/cxl/test/accel.c

diff --git a/tools/testing/cxl/test/Kbuild b/tools/testing/cxl/test/Kbuild
index c168e3c998a7..9a24ddc28488 100644
--- a/tools/testing/cxl/test/Kbuild
+++ b/tools/testing/cxl/test/Kbuild
@@ -5,10 +5,12 @@ obj-m += cxl_test.o
 obj-m += cxl_mock.o
 obj-m += cxl_mock_mem.o
 obj-m += cxl_translate.o
+obj-m += cxl_mock_accel.o
 
 cxl_test-y := cxl.o
 cxl_test-y += hmem_test.o
 cxl_mock-y := mock.o
 cxl_mock_mem-y := mem.o
+cxl_mock_accel-y := accel.o
 
 KBUILD_CFLAGS := $(filter-out -Wmissing-prototypes -Wmissing-declarations, $(KBUILD_CFLAGS))
diff --git a/tools/testing/cxl/test/accel.c b/tools/testing/cxl/test/accel.c
new file mode 100644
index 000000000000..9c8235f9d97b
--- /dev/null
+++ b/tools/testing/cxl/test/accel.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2026 Intel Corporation. All rights reserved.
+
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/sizes.h>
+#include <cxl/mailbox.h>
+#include <cxlmem.h>
+
+struct mock_cxl_accel {
+	struct cxl_dev_state cxlds;
+	struct cxl_memdev *cxlmd;
+};
+
+static int cxl_mock_accel_probe(struct platform_device *pdev)
+{
+	struct mock_cxl_accel *cxl_accel;
+	struct device *dev = &pdev->dev;
+	struct cxl_dev_state *cxlds;
+	struct cxl_memdev *cxlmd;
+	struct range mock_range;
+	int rc;
+
+	cxl_accel = devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM,
+					      pdev->id + 1, 0,
+					      struct mock_cxl_accel, cxlds,
+					      false);
+	if (!cxl_accel)
+		return -ENOMEM;
+
+	cxlds = &cxl_accel->cxlds;
+	cxlds->media_ready = true;
+	rc = cxl_set_capacity(cxlds, SZ_512M);
+	if (rc)
+		return rc;
+
+	cxlmd = devm_cxl_probe_mem(cxlds, &mock_range);
+	if (IS_ERR(cxlmd))
+		return PTR_ERR(cxlmd);
+	cxl_accel->cxlmd = cxlmd;
+
+	dev_dbg(dev, "Probed mock accelerator with range %pra\n", &mock_range);
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
2.54.0

