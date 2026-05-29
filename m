Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC0D3CAE70;
	Fri, 29 May 2026 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048304; cv=none; b=t8Dpp5ypDBPqPmkp9PwtCdaiviXBJOsYyBU8kxBuHSIAaX11hCa5weVs5D5JSU2rt26OcrIAoBmVXiU+LZwxjAmNL0394yKU+9N4igrdWqcrgmEEkb0P+C9CyNzmNLv93jDGOL8oLxaE4iD11MDPzpodLVkn2bGIkD39TOeD5g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048304; c=relaxed/simple;
	bh=qIFFyyy4m0uVoomEtae1wRHS1d2gI1FUMrEpVshS6vY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ROWuqf5pcStzCanBTSYQn9HbspdCSIZxiUsdKclNG31jfSiaxgH37MOpcGs8zdBUos3BUD3M+Juhy57dZ1fg7ixhYseXQYk1TM6spdS51XE5lWMBTgwhDk8pqcEl7InvHOmWaEfKDPUOddyzU4zi+yP6ye+Us2DCtUeO+hczhDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K0yxv1mI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K0yxv1mI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73C0032E5;
	Fri, 29 May 2026 02:51:37 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 195323F905;
	Fri, 29 May 2026 02:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780048302; bh=qIFFyyy4m0uVoomEtae1wRHS1d2gI1FUMrEpVshS6vY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K0yxv1mIHfRIjQVUddiv4tJ9zbuW6NsMf3bbwHp7/QB6+e1pVx2NxzsZxoo/iBOBW
	 3xToFeQhuJb8nuEYEM+nHsEWcuH2e9tQXMj2lgl48cYZzME/Ak9FK+0PAdf7yJxyft
	 YqlFTbgCknX8R95VzGEK9L3u8q5XKJOGye2iLtU8=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Fri, 29 May 2026 10:50:46 +0100
Subject: [PATCH v5 06/10] ACPI: APEI: GHES: move CXL CPER helpers
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-6-2e0500d42642@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780048269; l=10220;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=qIFFyyy4m0uVoomEtae1wRHS1d2gI1FUMrEpVshS6vY=;
 b=uiUZzhRkHQVdWfn4cIK8H6E1iU0KW5AnAh2aXXgcvgvVkBlBmmfqSbvVPJOMWI02ojwvAKzYY
 et16V8aeXI+CsTjoPzXnlgDzEE5hEYhN7QoxF+3BTH3u10y/GHD9g22
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Move the CXL CPER handling paths out of ghes.c and into ghes_cper.c so the
helpers can be reused. The code is moved as-is, with the public
prototypes updated so GHES keeps calling into the new translation unit.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/ghes.c      | 132 -----------------------------------------
 drivers/acpi/apei/ghes_cper.c | 134 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes_cper.h      |  11 ++++
 3 files changed, 145 insertions(+), 132 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 81ac51632f21..85be2ebf4d3e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -383,69 +383,6 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
-/* Room for 8 entries */
-#define CXL_CPER_PROT_ERR_FIFO_DEPTH 8
-static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
-		    CXL_CPER_PROT_ERR_FIFO_DEPTH);
-
-/* Synchronize schedule_work() with cxl_cper_prot_err_work changes */
-static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
-struct work_struct *cxl_cper_prot_err_work;
-
-static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
-				   int severity)
-{
-#ifdef CONFIG_ACPI_APEI_PCIEAER
-	struct cxl_cper_prot_err_work_data wd;
-
-	if (cxl_cper_sec_prot_err_valid(prot_err))
-		return;
-
-	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
-
-	if (!cxl_cper_prot_err_work)
-		return;
-
-	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
-		return;
-
-	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
-		pr_err_ratelimited("CXL CPER kfifo overflow\n");
-		return;
-	}
-
-	schedule_work(cxl_cper_prot_err_work);
-#endif
-}
-
-int cxl_cper_register_prot_err_work(struct work_struct *work)
-{
-	if (cxl_cper_prot_err_work)
-		return -EINVAL;
-
-	guard(spinlock)(&cxl_cper_prot_err_work_lock);
-	cxl_cper_prot_err_work = work;
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
-
-int cxl_cper_unregister_prot_err_work(struct work_struct *work)
-{
-	if (cxl_cper_prot_err_work != work)
-		return -EINVAL;
-
-	guard(spinlock)(&cxl_cper_prot_err_work_lock);
-	cxl_cper_prot_err_work = NULL;
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
-
-int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
-{
-	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
-
 static void ghes_vendor_record_notifier_destroy(void *nb)
 {
 	ghes_unregister_vendor_record_notifier(nb);
@@ -464,75 +401,6 @@ int devm_ghes_register_vendor_record_notifier(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_ghes_register_vendor_record_notifier);
 
-/* Room for 8 entries for each of the 4 event log queues */
-#define CXL_CPER_FIFO_DEPTH 32
-DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
-
-/* Synchronize schedule_work() with cxl_cper_work changes */
-static DEFINE_SPINLOCK(cxl_cper_work_lock);
-struct work_struct *cxl_cper_work;
-
-static void cxl_cper_post_event(enum cxl_event_type event_type,
-				struct cxl_cper_event_rec *rec)
-{
-	struct cxl_cper_work_data wd;
-
-	if (rec->hdr.length <= sizeof(rec->hdr) ||
-	    rec->hdr.length > sizeof(*rec)) {
-		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
-		       rec->hdr.length);
-		return;
-	}
-
-	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
-		pr_err(FW_WARN "CXL CPER invalid event\n");
-		return;
-	}
-
-	guard(spinlock_irqsave)(&cxl_cper_work_lock);
-
-	if (!cxl_cper_work)
-		return;
-
-	wd.event_type = event_type;
-	memcpy(&wd.rec, rec, sizeof(wd.rec));
-
-	if (!kfifo_put(&cxl_cper_fifo, wd)) {
-		pr_err_ratelimited("CXL CPER kfifo overflow\n");
-		return;
-	}
-
-	schedule_work(cxl_cper_work);
-}
-
-int cxl_cper_register_work(struct work_struct *work)
-{
-	if (cxl_cper_work)
-		return -EINVAL;
-
-	guard(spinlock)(&cxl_cper_work_lock);
-	cxl_cper_work = work;
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
-
-int cxl_cper_unregister_work(struct work_struct *work)
-{
-	if (cxl_cper_work != work)
-		return -EINVAL;
-
-	guard(spinlock)(&cxl_cper_work_lock);
-	cxl_cper_work = NULL;
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
-
-int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
-{
-	return kfifo_get(&cxl_cper_fifo, wd);
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
-
 static void ghes_log_hwerr(int sev, guid_t *sec_type)
 {
 	if (sev != CPER_SEV_RECOVERABLE)
diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
index 131980d36064..d7a666a163c3 100644
--- a/drivers/acpi/apei/ghes_cper.c
+++ b/drivers/acpi/apei/ghes_cper.c
@@ -12,10 +12,12 @@
  *   Author: Huang Ying <ying.huang@intel.com>
  */
 
+#include <linux/aer.h>
 #include <linux/err.h>
 #include <linux/genalloc.h>
 #include <linux/irq_work.h>
 #include <linux/io.h>
+#include <linux/kfifo.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/math64.h>
@@ -321,6 +323,138 @@ void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	schedule_work(&entry->work);
 }
 
+/* Room for 8 entries */
+#define CXL_CPER_PROT_ERR_FIFO_DEPTH 8
+static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
+		    CXL_CPER_PROT_ERR_FIFO_DEPTH);
+
+/* Synchronize schedule_work() with cxl_cper_prot_err_work changes */
+static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
+struct work_struct *cxl_cper_prot_err_work;
+
+void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+			    int severity)
+{
+#ifdef CONFIG_ACPI_APEI_PCIEAER
+	struct cxl_cper_prot_err_work_data wd;
+
+	if (cxl_cper_sec_prot_err_valid(prot_err))
+		return;
+
+	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
+
+	if (!cxl_cper_prot_err_work)
+		return;
+
+	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
+		return;
+
+	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
+		pr_err_ratelimited("CXL CPER kfifo overflow\n");
+		return;
+	}
+
+	schedule_work(cxl_cper_prot_err_work);
+#endif
+}
+
+int cxl_cper_register_prot_err_work(struct work_struct *work)
+{
+	if (cxl_cper_prot_err_work)
+		return -EINVAL;
+
+	guard(spinlock)(&cxl_cper_prot_err_work_lock);
+	cxl_cper_prot_err_work = work;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
+
+int cxl_cper_unregister_prot_err_work(struct work_struct *work)
+{
+	if (cxl_cper_prot_err_work != work)
+		return -EINVAL;
+
+	guard(spinlock)(&cxl_cper_prot_err_work_lock);
+	cxl_cper_prot_err_work = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
+
+int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
+{
+	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
+
+/* Room for 8 entries for each of the 4 event log queues */
+#define CXL_CPER_FIFO_DEPTH 32
+static DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
+
+/* Synchronize schedule_work() with cxl_cper_work changes */
+static DEFINE_SPINLOCK(cxl_cper_work_lock);
+struct work_struct *cxl_cper_work;
+
+void cxl_cper_post_event(enum cxl_event_type event_type,
+			 struct cxl_cper_event_rec *rec)
+{
+	struct cxl_cper_work_data wd;
+
+	if (rec->hdr.length <= sizeof(rec->hdr) ||
+	    rec->hdr.length > sizeof(*rec)) {
+		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
+		       rec->hdr.length);
+		return;
+	}
+
+	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
+		pr_err(FW_WARN "CXL CPER invalid event\n");
+		return;
+	}
+
+	guard(spinlock_irqsave)(&cxl_cper_work_lock);
+
+	if (!cxl_cper_work)
+		return;
+
+	wd.event_type = event_type;
+	memcpy(&wd.rec, rec, sizeof(wd.rec));
+
+	if (!kfifo_put(&cxl_cper_fifo, wd)) {
+		pr_err_ratelimited("CXL CPER kfifo overflow\n");
+		return;
+	}
+
+	schedule_work(cxl_cper_work);
+}
+
+int cxl_cper_register_work(struct work_struct *work)
+{
+	if (cxl_cper_work)
+		return -EINVAL;
+
+	guard(spinlock)(&cxl_cper_work_lock);
+	cxl_cper_work = work;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
+
+int cxl_cper_unregister_work(struct work_struct *work)
+{
+	if (cxl_cper_work != work)
+		return -EINVAL;
+
+	guard(spinlock)(&cxl_cper_work_lock);
+	cxl_cper_work = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
+
+int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
+{
+	return kfifo_get(&cxl_cper_fifo, wd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
+
 /*
  * GHES error status reporting throttle, to report more kinds of
  * errors, instead of just most frequently occurred errors.
diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
index 51725f25c516..dd49e9179b63 100644
--- a/include/acpi/ghes_cper.h
+++ b/include/acpi/ghes_cper.h
@@ -20,6 +20,7 @@
 #include <linux/workqueue.h>
 
 #include <acpi/ghes.h>
+#include <cxl/event.h>
 
 #define GHES_PFX	"GHES: "
 
@@ -106,5 +107,15 @@ void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
 			    struct acpi_hest_generic_status *estatus);
 void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 				   int sev);
+void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+			    int severity);
+int cxl_cper_register_prot_err_work(struct work_struct *work);
+int cxl_cper_unregister_prot_err_work(struct work_struct *work);
+int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd);
+void cxl_cper_post_event(enum cxl_event_type event_type,
+			 struct cxl_cper_event_rec *rec);
+int cxl_cper_register_work(struct work_struct *work);
+int cxl_cper_unregister_work(struct work_struct *work);
+int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
 
 #endif /* ACPI_APEI_GHES_CPER_H */

-- 
2.43.0

