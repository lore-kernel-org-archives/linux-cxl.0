Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4846E42BE95;
	Tue, 14 Jul 2026 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071137; cv=none; b=Pc+7jlJQQZOYgNSHNq0DXp1F2pFLax0OSzjIcog3kevMd4iwvQsIg6aavAb291UusHD0V+SezN29ZM6qdQwOLKE+v0dDqTZscWks6kS70M9Do9PNdOuti2T17MfP54HYZhkN30AyFUPz/2p9yvq7mGMKi5t1LVlBDgte/ItGo5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071137; c=relaxed/simple;
	bh=M72IAuh/Fa1yyeOSlRlmrylBCKMgnVkurxjOMdx7Z/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AN9i7YwhYtXlPWCawqSDeVxz29ittidsct8+hI2DR0Asvb1+ZhFkYh8EfiH4K0EdqH3kNVWyADeHeXF5zzGEyyruOe1EpPKWJzq7P05N1HwUuGJjSCNWB/8PKM4oiaq1qgs2KX0hXd5WsaqvOTRZ8yX9r7b0/3fJK0UBp4zX76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D3F1F000E9;
	Tue, 14 Jul 2026 23:18:55 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	terry.bowman@amd.com
Subject: [PATCH v2 6/7] ACPI: extlog: Defer CXL protocol error handling to avoid lock inversion
Date: Tue, 14 Jul 2026 16:18:34 -0700
Message-ID: <20260714231835.303081-7-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714231835.303081-1-dave.jiang@intel.com>
References: <20260714231835.303081-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

extlog_cxl_cper_handle_prot_err() calls cxl_cper_handle_prot_err()
synchronously while the MCE notifier chain rwsem is held read:

  blocking_notifier_call_chain()       # holds rwsem read
    extlog_print()
      extlog_cxl_cper_handle_prot_err()
        cxl_cper_handle_prot_err()
          guard(device)(&pdev->dev)    # acquires device_lock

This creates an AB-BA lock ordering with the probe path, where the PCI
core holds device_lock during .probe and cxl_memdev_state_create() calls
devm_cxl_register_mce_notifier() -> mce_register_decode_chain() which
takes the rwsem write:

  device_lock -> rwsem (probe path)
  rwsem -> device_lock (MCE path)

ghes.c avoids this by posting CXL protocol errors to a kfifo and
deferring processing to a workqueue via cxl_cper_post_prot_err(). Export
that function and use it from acpi_extlog.c instead of calling
cxl_cper_handle_prot_err() directly.

Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Export to acpi_extlog modules instead of CXL namespace. (0-day bot)
---
 drivers/acpi/acpi_extlog.c | 23 +++--------------------
 drivers/acpi/apei/ghes.c   |  5 +++--
 include/acpi/ghes.h        |  4 ++++
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 3e3e388af47b..1fbaf134c04e 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -172,23 +172,6 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 #endif
 }
 
-static void
-extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
-				int severity, u32 len)
-{
-#ifdef CONFIG_ACPI_APEI_PCIEAER
-	struct cxl_cper_prot_err_work_data wd;
-
-	if (cxl_cper_sec_prot_err_valid(prot_err, len))
-		return;
-
-	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
-		return;
-
-	cxl_cper_handle_prot_err(&wd);
-#endif
-}
-
 static int extlog_print(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
@@ -244,9 +227,9 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			struct cxl_cper_sec_prot_err *prot_err =
 				acpi_hest_get_payload(gdata);
 
-			extlog_cxl_cper_handle_prot_err(prot_err,
-							gdata->error_severity,
-							gdata->error_data_length);
+			cxl_cper_post_prot_err(prot_err,
+					       gdata->error_severity,
+					       gdata->error_data_length);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 6fa5d3bab1ce..b36f6d268c9f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -752,8 +752,8 @@ static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
 static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
 struct work_struct *cxl_cper_prot_err_work;
 
-static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
-				   int severity, u32 len)
+void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+			    int severity, u32 len)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cxl_cper_prot_err_work_data wd;
@@ -777,6 +777,7 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 	schedule_work(cxl_cper_prot_err_work);
 #endif
 }
+EXPORT_SYMBOL_FOR_MODULES(cxl_cper_post_prot_err, "acpi_extlog");
 
 int cxl_cper_register_prot_err_work(struct work_struct *work)
 {
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 8d7e5caef3f1..4dcbb2c30ea2 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -143,4 +143,8 @@ static inline int ghes_notify_sea(void) { return -ENOENT; }
 struct notifier_block;
 extern void ghes_register_report_chain(struct notifier_block *nb);
 extern void ghes_unregister_report_chain(struct notifier_block *nb);
+
+struct cxl_cper_sec_prot_err;
+void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+			    int severity, u32 len);
 #endif /* GHES_H */
-- 
2.55.0

