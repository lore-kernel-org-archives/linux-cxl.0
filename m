Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A5B3F54D1;
	Fri, 17 Jul 2026 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305020; cv=none; b=MFeIAMOtGYsSTiPN5b8eE66Ba2e9IpaeItgLuDLoIJkjcWyiHOyUp6bdOppuPcb8Ri0j8OJh3ZoKmHcurNAleqNziAtXOSw7KNnDqJhg5hZr5yNc7udL84xyyp0Lpm4p9r0KdvKsa2s52lZBvMD1VdCnwrTybcqH03406ylArIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305020; c=relaxed/simple;
	bh=4JjeIpxBlZ+GPpVcSFG1ZahrnkRPBqsc8j77dwfAtYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EILGf4pJbuYihQvGaB2J2dJBtygcOZdDI7k4k7IJDkYxOIOPqfuNMHdeV4Rk21pvO7eIHXTPXoWBzNdFki4Km8sYTImhk3yourGyP/0t3h/mA0exZ/advn3QNUD7XTNFgSZD6msbdX4sQfPNUzShbVibNzIShagiU7ILpIlj9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411461F000E9;
	Fri, 17 Jul 2026 16:16:58 +0000 (UTC)
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
	sashiko-bot@kernel.org
Subject: [PATCH v3 06/10] ACPI: extlog: Defer CXL protocol error handling to avoid lock inversion
Date: Fri, 17 Jul 2026 09:16:43 -0700
Message-ID: <20260717161647.1493259-7-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717161647.1493259-1-dave.jiang@intel.com>
References: <20260717161647.1493259-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sashiko-bot flagged an AB-BA deadlock between the PCI device_lock and
the MCE decoder chain rwsem.

extlog_print() calls cxl_cper_handle_prot_err() synchronously while the
MCE notifier chain rwsem is held, and that path takes the PCI device_lock
via guard(device)(). The probe path takes the locks in the opposite
order (device_lock held while mce_register_decode_chain() takes the
rwsem), so the two form an AB-BA deadlock.

ghes.c already avoids this by posting protocol errors to a kfifo and
handling them from a workqueue via cxl_cper_post_prot_err(). Export that
function and use it from acpi_extlog.c instead of calling
cxl_cper_handle_prot_err() directly.

Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/acpi_extlog.c | 23 +++--------------------
 drivers/acpi/apei/ghes.c   |  5 +++--
 include/acpi/ghes.h        |  4 ++++
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 0c440d75d9a7..ae79d090de33 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -172,23 +172,6 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 #endif
 }
 
-static void
-extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
-				int severity, u32 len)
-{
-#ifdef ACPI_APEI_PCIEAER
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
index 17e4ef555292..b8dbd99da47e 100644
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

