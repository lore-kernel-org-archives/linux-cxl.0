Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9EF3E928C
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779226669; cv=none; b=maQ6l0dXvxIj4PLXXp14UQKYfkLnXFhvZoebBOfkQIIax2RIH+6+2dubVBP4wwfgp7UDJ82yC8+aNdMp6a6emy6M2vToMj9crs7MLHDWJu79l7NAgUnoFsP58b7ai55tQcwb5/JJHk/cMqjvzwaL0BQxIUVcKlE6g3qhj3cmxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779226669; c=relaxed/simple;
	bh=Vt8myh9grEXTpMaF/5xtWrS878bFEJHpdYEVvkGbmjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ed/3fDg1sMed5MrxvE0mfLN84VGs9NvqlMp5PfM1V0sPbVCAtDnR+64ZhBy+7IljiLz8zMNmQjB7NMoWc2TSC3dw9hgSnehqW81twNDM1ZL3QiYLyUlZwjfDZNt4iQTs9Bw75JCX1Dsg8LrwTSyDpxlMrYSL0qfnkkj7WY/KIZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042611F00893;
	Tue, 19 May 2026 21:37:47 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v2 6/6] cxl/test: Add cxl_test accelerator driver
Date: Tue, 19 May 2026 14:37:33 -0700
Message-ID: <20260519213734.69737-7-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519213734.69737-1-dave.jiang@intel.com>
References: <20260519213734.69737-1-dave.jiang@intel.com>
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
v2:
- Remove unused headers. (Alison)
- devm_cxl_dev_state_create() err return -ENOMEM. (Alison)
---
 tools/testing/cxl/test/Kbuild  |  2 +
 tools/testing/cxl/test/accel.c | 74 ++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
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
index 000000000000..f427383670f6
--- /dev/null
+++ b/tools/testing/cxl/test/accel.c
@@ -0,0 +1,74 @@
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
+	struct cxl_attach_region *attach;
+	struct mock_cxl_accel *cxl_accel;
+	struct device *dev = &pdev->dev;
+	struct cxl_dev_state *cxlds;
+	struct cxl_memdev *cxlmd;
+	int rc;
+
+	attach = devm_kzalloc(dev, sizeof(attach), GFP_KERNEL);
+	if (!attach)
+		return -ENOMEM;
+
+	*attach = (struct cxl_attach_region) {
+		.attach = {
+			.probe = cxl_memdev_attach_region,
+		}
+	};
+
+	cxl_accel = devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM,
+					      pdev->dev.id + 1, 0,
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
+	cxlmd = devm_cxl_add_memdev(cxlds, &attach->attach);
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
2.54.0

