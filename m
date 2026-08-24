Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CA737EFE3;
	Mon, 24 Aug 2026 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593785; cv=none; b=LDgtf3uSOtqG+jGrNu6S8D2cuD1gZ8Afsrv/LUqvmIRv9UexvTjI+dhPKs8Zko7WBLorOElKGbJRmlVgBPUMb9lgMVLrwSGkmp/iH7rwozRN0xQo1B7xspz650EDnSS69OQ4WdqIRJ9hDDuBm5Vvpy1qZkdBLKh1+lwJMiyIIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593785; c=relaxed/simple;
	bh=KIKSIiU318yLehVOQuUmyyakuVIan2KSnuIBrMUYD5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0Lgw23aaVxhVyB22lrtdExS64lkBhoMxMvaHb5kbHZReCm/RbaEABxb02xMwp3igRI26diTv7t3dBYv6wAjQt4CRgB4hwfkU0Crg9r2pWtXBz/LmdgVrJ6358Swt52XMbR4m/GWqcHHZuYSUYt4oy67Dl/gajYEqxj4BetXrPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484431F00A3A;
	Mon, 24 Aug 2026 17:49:44 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	terry.bowman@amd.com,
	benjamin.cheatham@amd.com,
	alison.schofield@intel.com,
	sashiko-bot@kernel.org
Subject: [PATCH v4 04/13] ACPI: extlog: Defer CXL protocol error handling to avoid lock inversion
Date: Mon, 24 Aug 2026 10:49:27 -0700
Message-ID: <20260824174936.939059-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824174936.939059-1-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

extlog_print() calls cxl_cper_handle_prot_err() synchronously while the
MCE notifier chain rwsem is held, and that path takes the PCI device_lock
via guard(device)(). The probe path takes the two in the opposite order,
holding device_lock while mce_register_decode_chain() takes the rwsem, so
they can deadlock AB-BA.

ghes.c already avoids this by posting protocol errors to a kfifo and
handling them from a workqueue via cxl_cper_post_prot_err(). Export that
function and call it instead.

Declare it with the other CONFIG_ACPI_APEI_GHES exports rather than at the
end of the header. No #else stub: ACPI_EXTLOG selects ACPI_APEI_GHES, so
the only caller cannot exist without it.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Moved the cxl_cper_post_prot_err() declaration inside the
  CONFIG_ACPI_APEI_GHES block (Shuai Xue).
---
 drivers/acpi/acpi_extlog.c | 21 ++-------------------
 drivers/acpi/apei/ghes.c   |  5 +++--
 include/acpi/ghes.h        |  4 ++++
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 9ad0052aa20c..f6e3da4e13e7 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -163,23 +163,6 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 #endif
 }
 
-static void
-extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
-				int severity)
-{
-#ifdef ACPI_APEI_PCIEAER
-	struct cxl_cper_prot_err_work_data wd;
-
-	if (cxl_cper_sec_prot_err_valid(prot_err))
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
@@ -239,8 +222,8 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			struct cxl_cper_sec_prot_err *prot_err =
 				acpi_hest_get_payload(gdata);
 
-			extlog_cxl_cper_handle_prot_err(prot_err,
-							gdata->error_severity);
+			cxl_cper_post_prot_err(prot_err,
+					       gdata->error_severity);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..a382aabf9835 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -752,8 +752,8 @@ static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
 static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
 struct work_struct *cxl_cper_prot_err_work;
 
-static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
-				   int severity)
+void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+			    int severity)
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
index 8d7e5caef3f1..be496bc0386f 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -85,6 +85,10 @@ int devm_ghes_register_vendor_record_notifier(struct device *dev,
 struct list_head *ghes_get_devices(void);
 
 void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
+
+struct cxl_cper_sec_prot_err;
+void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+			    int severity);
 #else
 static inline struct list_head *ghes_get_devices(void) { return NULL; }
 
-- 
2.54.0

