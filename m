Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F8F3C8705;
	Fri, 29 May 2026 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048309; cv=none; b=hx4AWYnrc6LJkmV3848huLNsuA0lrJW2fmhIv2VYis6VKJarGjkP5qsW9qDJzTOjIm6BLVKaPGrX6mi9/npFX4bmD1mVWMqDPcAEFNiYgJAxjlhs12EvEMxZR2SPhnJvIVrqAJTMJJ5l2A9I3GYY5e1IX6aM8KREVyvAJnvZMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048309; c=relaxed/simple;
	bh=SE5bStAb7vsrTWobe7ySsF8dvuF70BXHOSqTYvhTqMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VlXXVZHaNyxwxEMloMm8haYcJak66p74mXm1v8u0TiLZfIINPEOEBC1QLcSrh02FwaWQzY5T4gf2kGNK2eV6bX5eh43D2WT2XuvNlJHnkXOBW/PQ+Xt0onV9K3iHkc4P5qT2s7cEoYtU49IvJmaUO5mzcxqBUZ1vI1yNJDUyrlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BU3NXZ6o; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BU3NXZ6o"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F34422D7;
	Fri, 29 May 2026 02:51:42 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C356B3F905;
	Fri, 29 May 2026 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780048307; bh=SE5bStAb7vsrTWobe7ySsF8dvuF70BXHOSqTYvhTqMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BU3NXZ6odiQGKiv4ch3U38/iXXT2G4zVAoLaxd347qKSWfZh2Oex4FNTLIVB1MCoC
	 89syUHZX0VKkV3neV4Ies8q8Rs9x27Qv5CD+986Gs3rJ/vn0EhWq6qKxzJcrGRo/DQ
	 gtv48tUl+Nxj36R7rwGymxgYDnjNFPhF/p2I7Ke4=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Fri, 29 May 2026 10:50:47 +0100
Subject: [PATCH v5 07/10] ACPI: APEI: introduce GHES helper
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-7-2e0500d42642@arm.com>
References: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
In-Reply-To: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
To: will@kernel.org, jic23@kernel.org, xueshuai@linux.alibaba.com, 
 saket.dumbre@intel.com, mchehab@kernel.org, dave@stgolabs.net, 
 djbw@kernel.org, bp@alien8.de, tony.luck@intel.com, guohanjun@huawei.com, 
 lenb@kernel.org, skhan@linuxfoundation.org, vishal.l.verma@intel.com, 
 rafael@kernel.org, corbet@lwn.net, ira.weiny@intel.com, 
 dave.jiang@intel.com, krzk+dt@kernel.org, robh@kernel.org, 
 catalin.marinas@arm.com, alison.schofield@intel.com, conor+dt@kernel.org
Cc: Ahmed Tiba <ahmed.tiba@arm.com>, linux-arm-kernel@lists.infradead.org, 
 Michael.Zhao2@arm.com, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Dmitry.Lamerov@arm.com, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, 
 acpica-devel@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780048269; l=3795;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=SE5bStAb7vsrTWobe7ySsF8dvuF70BXHOSqTYvhTqMs=;
 b=7czOdHXKZ2MOgr/mh/A0OH2WaB60dBSoL3E3nNReSRgpz8/Ku7ZegC1pW28v58DMWM8TA7u/b
 rnEgh4fECQIDGzAudhHAhzqCghhGMc76dqybMf8h0j6h5hL4Gr+yY6H
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Add a dedicated GHES_CPER_HELPERS Kconfig entry so the shared helper code
can be built even when ACPI_APEI_GHES is disabled. Update the build glue
and headers to depend on the new symbol.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/Makefile           |  1 +
 drivers/acpi/Kconfig       |  4 ++++
 drivers/acpi/apei/Kconfig  |  1 +
 drivers/acpi/apei/Makefile |  2 +-
 include/acpi/ghes.h        | 10 ++++++----
 include/cxl/event.h        |  2 +-
 6 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 0841ea851847..27a664cb45ea 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -31,6 +31,7 @@ obj-y				+= idle/
 obj-y				+= char/ipmi/
 
 obj-$(CONFIG_ACPI)		+= acpi/
+obj-$(CONFIG_GHES_CPER_HELPERS)	+= acpi/apei/ghes_cper.o
 
 # PnP must come after ACPI since it will eventually need to check if acpi
 # was used and do nothing if so
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f165d14cf61a..13ef0e99f840 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -6,6 +6,10 @@
 config ARCH_SUPPORTS_ACPI
 	bool
 
+config GHES_CPER_HELPERS
+	bool
+	select UEFI_CPER
+
 menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on ARCH_SUPPORTS_ACPI
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 428458c623f0..ddb62638eb02 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -21,6 +21,7 @@ config ACPI_APEI_GHES
 	bool "APEI Generic Hardware Error Source"
 	depends on ACPI_APEI
 	select ACPI_HED
+	select GHES_CPER_HELPERS
 	select IRQ_WORK
 	select GENERIC_ALLOCATOR
 	select ARM_SDE_INTERFACE if ARM64
diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index f57f3b009d8e..66588d6be56f 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
-obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o ghes_cper.o
+obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
 # clang versions prior to 18 may blow out the stack with KASAN
 ifeq ($(CONFIG_COMPILE_TEST)_$(CONFIG_CC_IS_CLANG)_$(call clang-min-version, 180000),y_y_)
 KASAN_SANITIZE_ghes.o := n
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 8d7e5caef3f1..2ffab36b6154 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -83,15 +83,17 @@ int devm_ghes_register_vendor_record_notifier(struct device *dev,
 					      struct notifier_block *nb);
 
 struct list_head *ghes_get_devices(void);
-
-void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
 #else
 static inline struct list_head *ghes_get_devices(void) { return NULL; }
-
-static inline void ghes_estatus_pool_region_free(unsigned long addr, u32 size) { return; }
 #endif
 
+#ifdef CONFIG_GHES_CPER_HELPERS
 int ghes_estatus_pool_init(unsigned int num_ghes);
+void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
+#else
+static inline int ghes_estatus_pool_init(unsigned int num_ghes) { return -ENODEV; }
+static inline void ghes_estatus_pool_region_free(unsigned long addr, u32 size) { }
+#endif
 
 static inline int acpi_hest_get_version(struct acpi_hest_generic_data *gdata)
 {
diff --git a/include/cxl/event.h b/include/cxl/event.h
index ff97fea718d2..2ebd65b0d9d6 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -285,7 +285,7 @@ struct cxl_cper_prot_err_work_data {
 	int severity;
 };
 
-#ifdef CONFIG_ACPI_APEI_GHES
+#ifdef CONFIG_GHES_CPER_HELPERS
 int cxl_cper_register_work(struct work_struct *work);
 int cxl_cper_unregister_work(struct work_struct *work);
 int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);

-- 
2.43.0

