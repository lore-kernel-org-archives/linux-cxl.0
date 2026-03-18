Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3235015B998;
	Wed, 18 Mar 2026 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866974; cv=none; b=ESI6rcqc72OiJ5iXghgplHw66/4/o9d+4wzIeuyzjfuv/+dkUqwo9aEtdJiLeZF2XAowyhZXLSvcP0Cwk8zWJleOuKH8/cpE6H+UVviJJE9PNKTYv1XH/SRDwAnF7Mx9iWrwrAAxgURWY7slrTuPV+vqkdmNZWR4/Ml4/SuVEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866974; c=relaxed/simple;
	bh=LjcMc9LSHuiGcgxjPGNQzty3WY+CFykBJXDQtNgOAaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fb2hqUD+CNOIgbqD2n9AqmhZueovVeyurqTwKavrOOupeBI6kkSfZVPhHR5YoNH+ZDCToemUZKLwl6v6GJATkef3Wi5ZNos1gOdk2ukjuyrXZ9Q4gjQ+Wq4P9jK/p9M/MfmcAupXXV9orFy2PrFjyVWgg2RN0zSFzPqHaYHoOZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9339A1C00;
	Wed, 18 Mar 2026 13:49:26 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 874393F7BD;
	Wed, 18 Mar 2026 13:49:30 -0700 (PDT)
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Wed, 18 Mar 2026 20:48:07 +0000
Subject: [PATCH v3 10/10] RAS: add firmware-first CPER provider
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-10-48e6a1c249ef@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773866948; l=12767;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=LjcMc9LSHuiGcgxjPGNQzty3WY+CFykBJXDQtNgOAaQ=;
 b=rFHUTc4AbFOFD68FMC/Dxdt7+kiUKPz9fM6iXRBXTSKts8qOfB+glKLCa8TfCOwGRjpumDu35
 ALiMaPe4PhiCeadPTRElTHyjI65bautyDOUIp7q2hYrH8YfO485gXLD
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Add a firmware-first CPER provider that reuses the shared
GHES helpers, wire it into the RAS Kconfig/Makefile and
document it in the admin guide.

Update MAINTAINERS now that the driver exists.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 Documentation/admin-guide/RAS/main.rst |  18 +++
 MAINTAINERS                            |   1 +
 drivers/acpi/apei/apei-internal.h      |  10 +-
 drivers/acpi/apei/ghes_cper.c          |   2 +
 drivers/ras/Kconfig                    |  11 ++
 drivers/ras/Makefile                   |   1 +
 drivers/ras/cper-esource.c             | 257 +++++++++++++++++++++++++++++++++
 include/acpi/ghes_cper.h               |  10 ++
 8 files changed, 301 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/RAS/main.rst b/Documentation/admin-guide/RAS/main.rst
index 5a45db32c49b..84219d25a072 100644
--- a/Documentation/admin-guide/RAS/main.rst
+++ b/Documentation/admin-guide/RAS/main.rst
@@ -205,6 +205,24 @@ Architecture (MCA)\ [#f3]_.
 .. [#f3] For more details about the Machine Check Architecture (MCA),
   please read Documentation/arch/x86/x86_64/machinecheck.rst at the Kernel tree.
 
+Firmware-first CPER providers
+-----------------------------
+
+Some systems expose Common Platform Error Record (CPER) data
+through platform firmware instead of ACPI HEST tables.
+Enable ``CONFIG_RAS_CPER_ESOURCE`` to build the ``drivers/ras/cper-esource.c``
+driver. The current in-tree firmware description uses the
+``Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml`` binding.
+The driver reuses the GHES CPER helper object in
+``drivers/acpi/apei/ghes_cper.c`` so the logging, notifier chains, and
+memory failure handling match the ACPI GHES behaviour even when
+ACPI is disabled.
+
+Once a platform describes a firmware-first provider, both ACPI GHES and the
+firmware-described driver reuse the same code paths. This keeps the
+behaviour consistent regardless of whether the error source is described
+by ACPI tables or another firmware description.
+
 EDAC - Error Detection And Correction
 *************************************
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 69756fb61a98..7a2df54872bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22013,6 +22013,7 @@ RAS ERROR STATUS
 M:	Ahmed Tiba <ahmed.tiba@arm.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/firmware/arm,ras-cper.yaml
+F:	drivers/ras/cper-esource.c
 
 RAS INFRASTRUCTURE
 M:	Tony Luck <tony.luck@intel.com>
diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 77c10a7a7a9f..c16ac541f15b 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -8,6 +8,7 @@
 #define APEI_INTERNAL_H
 
 #include <linux/acpi.h>
+#include <acpi/ghes_cper.h>
 
 struct apei_exec_context;
 
@@ -120,15 +121,6 @@ int apei_exec_collect_resources(struct apei_exec_context *ctx,
 struct dentry;
 struct dentry *apei_get_debugfs_dir(void);
 
-static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
-{
-	if (estatus->raw_data_length)
-		return estatus->raw_data_offset + \
-			estatus->raw_data_length;
-	else
-		return sizeof(*estatus) + estatus->data_length;
-}
-
 int apei_osc_setup(void);
 
 int einj_get_available_error_type(u32 *type, int einj_action);
diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
index bd172b769953..f7326ddc056b 100644
--- a/drivers/acpi/apei/ghes_cper.c
+++ b/drivers/acpi/apei/ghes_cper.c
@@ -46,7 +46,9 @@
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_ACPI_APEI
 #include "apei-internal.h"
+#endif
 
 ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index fc4f4bb94a4c..3c1c63b2fefc 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -34,6 +34,17 @@ if RAS
 source "arch/x86/ras/Kconfig"
 source "drivers/ras/amd/atl/Kconfig"
 
+config RAS_CPER_ESOURCE
+	bool "Firmware-first CPER error source block provider"
+	select GHES_CPER_HELPERS
+	help
+	  Enable support for firmware-first Common Platform Error Record
+	  (CPER) error source block providers. The current in-tree user is
+	  described by the arm,ras-cper DeviceTree binding. The driver
+	  reuses the existing GHES CPER helpers so the error processing
+	  matches the ACPI code paths, but it can be built even when ACPI is
+	  disabled.
+
 config RAS_FMPM
 	tristate "FRU Memory Poison Manager"
 	default m
diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index 11f95d59d397..0de069557f31 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_RAS)	+= ras.o
 obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_RAS_CEC)	+= cec.o
+obj-$(CONFIG_RAS_CPER_ESOURCE)	+= cper-esource.o
 
 obj-$(CONFIG_RAS_FMPM)	+= amd/fmpm.o
 obj-y			+= amd/atl/
diff --git a/drivers/ras/cper-esource.c b/drivers/ras/cper-esource.c
new file mode 100644
index 000000000000..83f7a910e50a
--- /dev/null
+++ b/drivers/ras/cper-esource.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Firmware-first CPER error source provider.
+ *
+ * This driver shares the GHES CPER helpers so we keep the reporting and
+ * notifier behaviour identical to ACPI GHES.
+ *
+ * Copyright (C) 2026 ARM Ltd.
+ * Author: Ahmed Tiba <ahmed.tiba@arm.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/panic.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <acpi/ghes.h>
+#include <acpi/ghes_cper.h>
+
+static DEFINE_IDA(cper_esource_source_ids);
+
+struct cper_esource_ack {
+	void __iomem *addr;
+	u64 preserve;
+	u64 set;
+	u8 width;
+	bool present;
+};
+
+struct cper_esource {
+	struct device *dev;
+	void __iomem *status;
+	size_t status_len;
+
+	struct cper_esource_ack ack;
+
+	struct acpi_hest_generic *generic;
+	struct acpi_hest_generic_status *estatus;
+
+	bool sync;
+	int irq;
+
+	/* Serializes access while firmware and the OS share the status buffer. */
+	spinlock_t lock;
+};
+
+static void cper_esource_release_source_id(void *data)
+{
+	struct acpi_hest_generic *generic = data;
+
+	ida_free(&cper_esource_source_ids, generic->header.source_id);
+}
+
+static int cper_esource_init_pool(void)
+{
+	if (ghes_estatus_pool)
+		return 0;
+
+	return ghes_estatus_pool_init(1);
+}
+
+static int cper_esource_copy_status(struct cper_esource *ctx)
+{
+	memcpy_fromio(ctx->estatus, ctx->status, ctx->status_len);
+	return 0;
+}
+
+static void cper_esource_ack(struct cper_esource *ctx)
+{
+	u64 val;
+
+	if (!ctx->ack.present)
+		return;
+
+	if (ctx->ack.width == 64) {
+		val = readq(ctx->ack.addr);
+		val &= ctx->ack.preserve;
+		val |= ctx->ack.set;
+		writeq(val, ctx->ack.addr);
+	} else {
+		val = readl(ctx->ack.addr);
+		val &= (u32)ctx->ack.preserve;
+		val |= (u32)ctx->ack.set;
+		writel(val, ctx->ack.addr);
+	}
+}
+
+static void cper_esource_fatal(struct cper_esource *ctx)
+{
+	__ghes_print_estatus(KERN_EMERG, ctx->generic, ctx->estatus);
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
+	panic("GHES: fatal firmware-first CPER record from %s\n",
+	      dev_name(ctx->dev));
+}
+
+static void cper_esource_process(struct cper_esource *ctx)
+{
+	int sev;
+
+	guard(spinlock_irqsave)(&ctx->lock);
+
+	if (cper_esource_copy_status(ctx))
+		return;
+
+	sev = ghes_severity(ctx->estatus->error_severity);
+	if (sev >= GHES_SEV_PANIC)
+		cper_esource_fatal(ctx);
+
+	if (!ghes_estatus_cached(ctx->estatus) &&
+	    ghes_print_estatus(NULL, ctx->generic, ctx->estatus))
+		ghes_estatus_cache_add(ctx->generic, ctx->estatus);
+
+	ghes_cper_handle_status(ctx->dev, ctx->generic, ctx->estatus, ctx->sync);
+	cper_esource_ack(ctx);
+}
+
+static irqreturn_t cper_esource_irq(int irq, void *data)
+{
+	struct cper_esource *ctx = data;
+
+	cper_esource_process(ctx);
+
+	return IRQ_HANDLED;
+}
+
+static int cper_esource_init_ack(struct platform_device *pdev,
+				 struct cper_esource *ctx)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	size_t size;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return 0;
+
+	ctx->ack.addr = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
+	if (IS_ERR(ctx->ack.addr))
+		return PTR_ERR(ctx->ack.addr);
+
+	size = resource_size(res);
+	switch (size) {
+	case 4:
+		ctx->ack.width = 32;
+		ctx->ack.preserve = ~0U;
+		break;
+	case 8:
+		ctx->ack.width = 64;
+		ctx->ack.preserve = ~0ULL;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL,
+				     "unsupported ack resource size %zu\n", size);
+	}
+
+	ctx->ack.set = BIT_ULL(0);
+	ctx->ack.present = true;
+	return 0;
+}
+
+static int cper_esource_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cper_esource *ctx;
+	struct resource *res;
+	int source_id;
+	int rc;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	spin_lock_init(&ctx->lock);
+	ctx->dev = dev;
+	ctx->sync = device_property_read_bool(dev, "arm,sea-notify");
+
+	ctx->status = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(ctx->status))
+		return dev_err_probe(dev, PTR_ERR(ctx->status),
+				     "failed to map status region\n");
+
+	ctx->status_len = resource_size(res);
+	if (!ctx->status_len)
+		return dev_err_probe(dev, -EINVAL, "status region has zero length\n");
+
+	rc = cper_esource_init_ack(pdev, ctx);
+	if (rc)
+		return rc;
+
+	rc = cper_esource_init_pool();
+	if (rc)
+		return rc;
+
+	ctx->estatus = devm_kzalloc(dev, ctx->status_len, GFP_KERNEL);
+	if (!ctx->estatus)
+		return -ENOMEM;
+
+	ctx->generic = devm_kzalloc(dev, sizeof(*ctx->generic), GFP_KERNEL);
+	if (!ctx->generic)
+		return -ENOMEM;
+
+	source_id = ida_alloc_min(&cper_esource_source_ids, 1, GFP_KERNEL);
+	if (source_id < 0)
+		return source_id;
+
+	ctx->generic->header.type = ACPI_HEST_TYPE_GENERIC_ERROR;
+	ctx->generic->header.source_id = source_id;
+
+	rc = devm_add_action_or_reset(dev, cper_esource_release_source_id,
+				      ctx->generic);
+	if (rc)
+		return rc;
+
+	ctx->generic->notify.type = ctx->sync ?
+		ACPI_HEST_NOTIFY_SEA : ACPI_HEST_NOTIFY_EXTERNAL;
+	ctx->generic->error_block_length = ctx->status_len;
+
+	ctx->irq = platform_get_irq(pdev, 0);
+	if (ctx->irq < 0)
+		return ctx->irq;
+
+	rc = devm_request_threaded_irq(dev, ctx->irq, NULL, cper_esource_irq,
+				       IRQF_ONESHOT,
+				       dev_name(dev), ctx);
+	if (rc)
+		return dev_err_probe(dev, rc, "failed to request interrupt\n");
+
+	return 0;
+}
+
+static const struct of_device_id cper_esource_of_match[] = {
+	{ .compatible = "arm,ras-cper" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, cper_esource_of_match);
+
+static struct platform_driver cper_esource_driver = {
+	.driver = {
+		.name = "cper-esource",
+		.of_match_table = cper_esource_of_match,
+	},
+	.probe = cper_esource_probe,
+};
+
+module_platform_driver(cper_esource_driver);
+
+MODULE_AUTHOR("Ahmed Tiba <ahmed.tiba@arm.com>");
+MODULE_DESCRIPTION("Firmware-first CPER provider");
+MODULE_LICENSE("GPL");
diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
index d7fe71bd67bb..be383653e42b 100644
--- a/include/acpi/ghes_cper.h
+++ b/include/acpi/ghes_cper.h
@@ -83,6 +83,14 @@ static inline bool is_hest_sync_notify(struct ghes *ghes)
 	return notify_type == ACPI_HEST_NOTIFY_SEA;
 }
 
+static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
+{
+	if (estatus->raw_data_length)
+		return estatus->raw_data_offset + estatus->raw_data_length;
+	else
+		return sizeof(*estatus) + estatus->data_length;
+}
+
 struct ghes_vendor_record_entry {
 	struct work_struct work;
 	int error_severity;
@@ -109,6 +117,8 @@ int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
 int ghes_estatus_cached(struct acpi_hest_generic_status *estatus);
 void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
 			    struct acpi_hest_generic_status *estatus);
+int ghes_register_vendor_record_notifier(struct notifier_block *nb);
+void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
 void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 				   int sev);
 int ghes_severity(int severity);

-- 
2.43.0

