Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A191A202C46;
	Thu, 26 Jun 2025 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750931733; cv=none; b=IPsp82BM+4oYPNAB3OQC6N35c9eTDeDfmH8kxAAd5Vxp+l/S+fzc/kl6r1VuYDDdRDyXRsUNKHHyNprTwRwhAOAeBtmG8q8uAJfIfUEnG+mnhdbmAVpc7GqbEX/p+g96zRxz4x2E9+VpLkKj5gb5t/x17f8BOCBTnNdlMCdPb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750931733; c=relaxed/simple;
	bh=Pl3DbRJOh3EPOC28gCvS6+Vd+hF9nKKs9fb4+dHJijI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HR5vuQcOQ8Eot/PXRtZ+3tyoA9XMH1YbzJzzLk8rcK/Xym2hgVlVkGfItWgjGdbyBGbpZzuAZZuLTiVHue8F2OKYRJOu9R13C6J7Lm7lyt+76nvaeN7ruohMNwvRfCSOqi6fFLGo9KkjQciifFr6PvMUIJV5NH4GC3VQhQy0tJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwC3Dpf7GF1o43VPBA--.62245S2;
	Thu, 26 Jun 2025 17:55:07 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwB3CyXzGF1olRFeAA--.236S3;
	Thu, 26 Jun 2025 17:55:00 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH] cxl: Add CONFIG_CXL_DEBUG to drivers/cxl
Date: Thu, 26 Jun 2025 17:54:42 +0800
Message-Id: <20250626095442.1254840-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwB3CyXzGF1olRFeAA--.236S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAMAWhbAiIFpQArsU
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWruFyxAr43XFyfCryftrW8JFb_yoWkKFcEka
	ykAryxG34j9ryqgFWIvF4fZryFv3Z5Zr4xZF1Sq343Xa429F13Gr4v9rn7Zw1rta4jgF1D
	J34rZrnYvr18tjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

CONFIG_CXL_DEBUG=y adds -DDEBUG to CFLAGS, which enables pr_debug()
and dev_dbg(). Users can use this config to open all cxl debug
messages.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 drivers/cxl/Kconfig  | 10 ++++++++++
 drivers/cxl/Makefile |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..b7e5225e9d7c 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -233,4 +233,14 @@ config CXL_MCE
 	def_bool y
 	depends on X86_MCE && MEMORY_FAILURE
 
+config CXL_DEBUG
+	bool "CXL Debugging"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here if you want the CXL core to produce a bunch of debug
+	  messages to the system log.  Select this if you are having a
+	  problem with CXL support and want to see more of what is going on.
+
+	  When in doubt, say N.
+
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 2caa90fa4bf2..9c0151a2b201 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -19,3 +19,5 @@ cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
 cxl_mem-y := mem.o
 cxl_pci-y := pci.o
+
+subdir-ccflags-$(CONFIG_CXL_DEBUG) := -DDEBUG
-- 
2.34.1

