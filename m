Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5DF3F1673;
	Wed, 17 Jun 2026 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704558; cv=none; b=ozhshETyLdkipv0eHm+YQGm3HWyHJVkDfz2mH7YPLaP8v2XaifDjd2LR89iQ09bFffHBLQyledlegnjUTPMGW8Rxh94IybYhgviAd1qVRrmz0I6I6KabQmF1jaZyiirVfuDtjFA9ThoFBOUzOhT2KqZftKCOFgRj5R4oseaY98o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704558; c=relaxed/simple;
	bh=v7RUr735rL9PPiaEWfLRbg6MZS8am/SFraXJE7Q/MoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o9T26+RdQy1guGM2ftZ7k8JOt8VrgMLw5/Gy71cuvcItsW52XVCeFIAYUUFPKylNzcwsuB01H9eLjmNj4egQQ4VNnROuEqFhqSBnuiVtGi4rR2XeBVzHiLJFCijF3tW/2MmtIUVqru5Jqm5mnG3pwOZQWQ+Ae27t3JGzH/fMknw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HfqMJSg5; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HfqMJSg5"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5D1A4800;
	Wed, 17 Jun 2026 06:55:51 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EA0F3F915;
	Wed, 17 Jun 2026 06:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781704556; bh=v7RUr735rL9PPiaEWfLRbg6MZS8am/SFraXJE7Q/MoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HfqMJSg51UlNTh9xPK2LWg2zTRMYMD9O1aKZI68+9tsP/BWnFiJLd9vhCfRftteOm
	 VoXEUbIiclZ9P+84q4DR3PL5YWlmvuHqxE5yoteHdq0VBtAd0+xXvEpV9fGNIL3L9y
	 MqVfurRs7DZxlFjzNZ4vRauuwQqtZsBF4KWtOet8=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Wed, 17 Jun 2026 14:54:44 +0100
Subject: [PATCH v6 06/10] ACPI: APEI: GHES: move CXL CPER helpers
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-6-91f725174aa0@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781704522; l=9992;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=v7RUr735rL9PPiaEWfLRbg6MZS8am/SFraXJE7Q/MoM=;
 b=W4vTzMAcyYqig84RTHJ6DZv/TXzUXOL8EYKDJGgf1qbn5f/iL+J3rQevLlnIEJhl+s6RU+5aE
 fhswFgPNmttDZ6BSlyOB1xE0somxhC7auEUCaEnUV1bFmGbRS7eLtyF
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Move the CXL CPER handling paths out of ghes.c and into ghes_cper.c so the
helpers can be reused. The code is moved as-is, with the public
prototypes updated so GHES keeps calling into the new translation unit.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/ghes.c      | 132 -----------------------------------------
 drivers/acpi/apei/ghes_cper.c | 135 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes_cper.h      |  11 ++++
 3 files changed, 146 insertions(+), 132 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 9703c602a8c2..136993704d52 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -383,138 +383,6 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
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
index b26943eafd79..66bf1af4db00 100644
--- a/drivers/acpi/apei/ghes_cper.c
+++ b/drivers/acpi/apei/ghes_cper.c
@@ -12,9 +12,12 @@
  *   Author: Huang Ying <ying.huang@intel.com>
  */
 
+#include <linux/aer.h>
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/genalloc.h>
 #include <linux/io.h>
+#include <linux/kfifo.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
 #include <linux/mm.h>
@@ -336,6 +339,138 @@ void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
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
index d9f9253d8de9..a853a5996cdf 100644
--- a/include/acpi/ghes_cper.h
+++ b/include/acpi/ghes_cper.h
@@ -20,6 +20,7 @@
 
 #include <acpi/ghes.h>
 #include <asm/fixmap.h>
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

