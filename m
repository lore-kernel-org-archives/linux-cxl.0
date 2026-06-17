Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB403F4DF8;
	Wed, 17 Jun 2026 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704564; cv=none; b=OeRm9KEw7POwrInM8qlwVnbRdt1po+/zAeGrhO1ZW1a5jsk6v8Sjd7IyVqpOzO//IUTdTyQ0okNM4rScgbazF6iHnOls1oQb2Yl7vuIk+Zq1VXdZbkV/lXTp7zvm758zd/R6i6ChwOZ2zIWQPgX8whNvWsiZJXiz/AtkqeOca+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704564; c=relaxed/simple;
	bh=SE5bStAb7vsrTWobe7ySsF8dvuF70BXHOSqTYvhTqMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hEWB6YGsa5wYtbLJ0UpwIlzZFFRPL1px9hU4lViXccfMHVRKPEMRBubSr5Ryc0o66hubCPY5OQk4TNzjzzqqjoQbHjO6t20q4fReZim0fiitQq1bAmXhOFyXBAddWtyA8J36TTyCCNiG/mHbRXH/W47bfuHaWJI1F+7KPjFRf7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RBZNjHxF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RBZNjHxF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C060D32AB;
	Wed, 17 Jun 2026 06:55:56 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAE303F915;
	Wed, 17 Jun 2026 06:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781704561; bh=SE5bStAb7vsrTWobe7ySsF8dvuF70BXHOSqTYvhTqMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RBZNjHxFg0gGMxhvHbI9t9rcmNWQIptCMz0l9Nm8V2NTMXaID0p1V8bPh6yYOv8G3
	 hwhEhgzVq4bWpTFlENfxFb9L/7qWsthFXfwq/R3H5/i0xPd4ysvJlnbldwmHSgR+Hs
	 YDEc3IqvVUS9vofbuOBpnWgxcfmwmymOKxBC+dPM=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Wed, 17 Jun 2026 14:54:45 +0100
Subject: [PATCH v6 07/10] ACPI: APEI: introduce GHES helper
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-7-91f725174aa0@arm.com>
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
In-Reply-To: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Saket Dumbre <saket.dumbre@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <djbw@kernel.org>, Ahmed Tiba <ahmed.tiba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-edac@vger.kernel.org, 
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781704522; l=3795;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=SE5bStAb7vsrTWobe7ySsF8dvuF70BXHOSqTYvhTqMs=;
 b=v0MrLMFTZ1QRfbmap/PQmQ4tTT5xUnV8VurEgHroSkfLx7yYjVudwEAw8jIvl8lsZP9DiWXta
 Qr7Aiy02OwwAWuTzqa9AviHiUxN6jPJxzpP4R7ras0juX+RsrFxdG8s
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

