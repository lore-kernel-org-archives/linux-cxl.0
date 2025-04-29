Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB081D7E35
	for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 23:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971195; cv=none; b=Fm2uH6UgMQw+2HOx0cOcQhVmm2B4VqpOA8FkejAoUNDw5CCmZ6TmmYYZBGTsea1pqO6RQyLQ3tRbQYYrp+YTG4xaGSb/5Z3Q998wB8hz8G9DlTaZGNyoAdX+4hdhc4huW9ulipZQQuMw+/0wN9lArCNf0DwIBiLqdXBanwlrgtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971195; c=relaxed/simple;
	bh=qIp0737bzVgKjosLPDp4mEylb1PLlUlb76AG1hJ02nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M3hm8EhjWrX/CeAmeRb6HehxiXWyE4bKmtxgeO17f1q+0XyCzfRQa3sX2fAqObS3UQEE9YUeJ/ZMeu+AZw4xkBpxrzmcCsJTKBlOcaQymxC2p68kmQq2Rtpm5mWQq4Ng0Y7E5pw5jt+M/iHPEeRnMw4W91V0yN2Rjpdg6Wx9rnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC9FC4CEE3;
	Tue, 29 Apr 2025 23:59:54 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH] cxl/test: Address missing MODULE_DESCRIPTION warnings for cxl_test
Date: Tue, 29 Apr 2025 16:59:53 -0700
Message-ID: <20250429235953.4175408-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DESCRIPTION() to address the following warnings:
WARNING: modpost: missing MODULE_DESCRIPTION() in test/cxl_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in test/cxl_mock.o
WARNING: modpost: missing MODULE_DESCRIPTION() in test/cxl_mock_mem.o

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c  | 1 +
 tools/testing/cxl/test/mem.c  | 1 +
 tools/testing/cxl/test/mock.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 1c3336095923..eb36408d287a 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1527,5 +1527,6 @@ MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CXL test setup module");
 MODULE_IMPORT_NS("ACPI");
 MODULE_IMPORT_NS("CXL");
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index bf9caa908f89..32d47e3df22a 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1909,4 +1909,5 @@ static struct platform_driver cxl_mock_mem_driver = {
 
 module_platform_driver(cxl_mock_mem_driver);
 MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CXL test mem device mock module");
 MODULE_IMPORT_NS("CXL");
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index af2594e4f35d..6147f0966ffd 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -312,5 +312,6 @@ void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dport_init_ras_reporting, "CXL");
 
 MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CXL test emulation module");
 MODULE_IMPORT_NS("ACPI");
 MODULE_IMPORT_NS("CXL");
-- 
2.49.0

