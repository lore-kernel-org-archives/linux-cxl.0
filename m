Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9E615B998;
	Wed, 18 Mar 2026 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866967; cv=none; b=kFRq3gp4S7uAmz1xhwmN/IoDCr6I8ivmO4sxHzA1Gx78X+tkRiDmhx18CjmBVFwDieFADRScl1qvu7GVTfmonSB/R1RrJVnspWtr9Lk/2xcHpdwh2PkvZSTYpOcQEYjSrPGGBgTQbcRjhNj2nMEnin3NPVryyAcLekNpMbrv+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866967; c=relaxed/simple;
	bh=Ikx3djp0cdHdfyGsJjRElKAVimsA13qLWznkQoD/KOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/dElmwk8B1TVBVuJqh5sK9G/b2BV6jFhorG1KVwVJHIhuH4VdSoyeFzuGNKnUYJiAabuG5i5mn9xTqHmFz5s1Vv1U97fPiWkSHilkGsz5KvDAGitXMBD9TTgbmYZMsEsJB+NZUgdwG0s0udMtGhxwkXkRBxScB/eEDxnCikSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A94441BF7;
	Wed, 18 Mar 2026 13:49:19 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D24DB3F7BD;
	Wed, 18 Mar 2026 13:49:23 -0700 (PDT)
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Wed, 18 Mar 2026 20:48:04 +0000
Subject: [PATCH v3 07/10] ACPI: APEI: introduce GHES helper
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-7-48e6a1c249ef@arm.com>
References: <20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-0-48e6a1c249ef@arm.com>
In-Reply-To: <20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-0-48e6a1c249ef@arm.com>
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-cxl@vger.kernel.org
Cc: Ahmed Tiba <ahmed.tiba@arm.com>, Michael.Zhao2@arm.com, robh@kernel.org, 
 linux-arm-kernel@lists.infradead.org, Dmitry.Lamerov@arm.com, 
 rafael@kernel.org, conor@kernel.org, will@kernel.org, bp@alien8.de, 
 catalin.marinas@arm.com, krzk+dt@kernel.org, linux-doc@vger.kernel.org, 
 mchehab+huawei@kernel.org, tony.luck@intel.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773866948; l=3831;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=Ikx3djp0cdHdfyGsJjRElKAVimsA13qLWznkQoD/KOM=;
 b=TggKBKHDmHY1IptgqfjPqCQaWyQvdsjh9oHW680ltDT3+owIOmsZ5eCnaWjce1Ay0m91Brp9M
 iCoZ0WIY1G4BV/UP0IahNun66wG/K+tTfS0+/Z56BxK5UeW+iK3QcQQ
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
index 53fbd2e0acdd..3b98d3b44a35 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -31,6 +31,7 @@ obj-y				+= idle/
 obj-y				+= char/ipmi/
 
 obj-$(CONFIG_ACPI)		+= acpi/
+obj-$(CONFIG_GHES_CPER_HELPERS)	+= acpi/apei/ghes_cper.o
 
 # PnP must come after ACPI since it will eventually need to check if acpi
 # was used and do nothing if so
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 6f4b545f7377..14a2b5333d3b 100644
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
index 070c07d68dfb..2f65070b4ba3 100644
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
index b3774af70883..1a0b85923cd4 100644
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
index 7bea522c0657..fb9d53537b1e 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -72,15 +72,17 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
 void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
 
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

