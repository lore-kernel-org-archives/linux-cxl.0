Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537A34887E;
	Fri, 17 Jul 2026 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305016; cv=none; b=PPY7xNXKmiidrXKRdR13MlsIZEgGx+12uzWNJjAN9XF5l24PcnOhqilPbM+CKxgzWWYYCXRk6m7S+8CZR320N8vFmTZSQ4XckQByGWT8YXYycHetX5kVF4tnWRxO0slYSK10GLyis5CRyNHBV4mpSG10yynAhdG+PCjrbaUpv6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305016; c=relaxed/simple;
	bh=n9NWo8KBDMISxEjflNlef/1O59p14ocltPjQDCSqBCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSwhWiXFwlAAEKGRp3+QecbmU1wKKpcYQVvfV8K2B+FyTAUeCeq9bwygNFNJrOiwUSu9N1da4beSs7PKrFPzhdAUbb2wTOxWJ0M+04+diua+NZrzi2ycZH48WxRAoVCOhHjmvVui6h1Phcv+Z+Dwf563Ayz7DwTv/kXmzDovOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D381F00A3A;
	Fri, 17 Jul 2026 16:16:54 +0000 (UTC)
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
	sashiko-bot@kernel.org,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v3 03/10] ACPI: APEI: GHES: Validate CXL protocol error section length before RAS cap copy
Date: Fri, 17 Jul 2026 09:16:40 -0700
Message-ID: <20260717161647.1493259-4-dave.jiang@intel.com>
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

sashiko-bot flagged an out-of-bounds read driven by an unvalidated
firmware dvsec_len.

cxl_cper_setup_prot_err_work_data() locates the RAS Capability block at
prot_err + sizeof(*prot_err) + dvsec_len and copies it, but dvsec_len is
firmware controlled and never validated.

Extend cxl_cper_sec_prot_err_valid() to verify the section can hold the
header, and that the header, DVSEC and RAS Capability block all fit
within the reported section length.

Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=6
Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
Fixes: 315c2f0b53ba ("acpi/ghes, cper: Recognize and cache CXL Protocol errors")
Assisted-by: Claude:claude-sonnet-4-6
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/acpi_extlog.c       |  7 ++++---
 drivers/acpi/apei/ghes.c         |  7 ++++---
 drivers/acpi/apei/ghes_helpers.c | 21 ++++++++++++++++++++-
 include/cxl/event.h              |  4 ++--
 4 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 7ad3b36013cc..06a944dadbc1 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -165,12 +165,12 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 
 static void
 extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
-				int severity)
+				int severity, u32 len)
 {
 #ifdef ACPI_APEI_PCIEAER
 	struct cxl_cper_prot_err_work_data wd;
 
-	if (cxl_cper_sec_prot_err_valid(prot_err))
+	if (cxl_cper_sec_prot_err_valid(prot_err, len))
 		return;
 
 	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
@@ -236,7 +236,8 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 				acpi_hest_get_payload(gdata);
 
 			extlog_cxl_cper_handle_prot_err(prot_err,
-							gdata->error_severity);
+							gdata->error_severity,
+							gdata->error_data_length);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a752e152a5a0..17e4ef555292 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -753,12 +753,12 @@ static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
 struct work_struct *cxl_cper_prot_err_work;
 
 static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
-				   int severity)
+				   int severity, u32 len)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cxl_cper_prot_err_work_data wd;
 
-	if (cxl_cper_sec_prot_err_valid(prot_err))
+	if (cxl_cper_sec_prot_err_valid(prot_err, len))
 		return;
 
 	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
@@ -950,7 +950,8 @@ static void ghes_do_proc(struct ghes *ghes,
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
 			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
 
-			cxl_cper_post_prot_err(prot_err, gdata->error_severity);
+			cxl_cper_post_prot_err(prot_err, gdata->error_severity,
+					       gdata->error_data_length);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
 			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/acpi/apei/ghes_helpers.c b/drivers/acpi/apei/ghes_helpers.c
index bc7111b740af..d625ec98a24c 100644
--- a/drivers/acpi/apei/ghes_helpers.c
+++ b/drivers/acpi/apei/ghes_helpers.c
@@ -5,8 +5,15 @@
 #include <linux/aer.h>
 #include <cxl/event.h>
 
-int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
+int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err, u32 len)
 {
+	if (len < sizeof(*prot_err)) {
+		pr_err_ratelimited(FW_WARN
+				   "CXL CPER prot err section too small (%u)\n",
+				   len);
+		return -EINVAL;
+	}
+
 	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
 		pr_err_ratelimited("CXL CPER invalid agent type\n");
 		return -EINVAL;
@@ -23,6 +30,18 @@ int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
 		return -EINVAL;
 	}
 
+	/*
+	 * The RAS Capability block follows a firmware-controlled DVSEC of
+	 * dvsec_len bytes; verify it and the header fit the section.
+	 */
+	if (sizeof(*prot_err) + prot_err->dvsec_len +
+	    sizeof(struct cxl_ras_capability_regs) > len) {
+		pr_err_ratelimited(FW_WARN
+				   "CXL CPER prot err section too small (%u)\n",
+				   len);
+		return -EINVAL;
+	}
+
 	if ((prot_err->agent_type == RCD || prot_err->agent_type == DEVICE ||
 	     prot_err->agent_type == LD || prot_err->agent_type == FMLD) &&
 	    !(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
diff --git a/include/cxl/event.h b/include/cxl/event.h
index ff97fea718d2..912305bee3bc 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -321,13 +321,13 @@ static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data
 #endif
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
-int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err);
+int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err, u32 len);
 int cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
 				      struct cxl_cper_sec_prot_err *prot_err,
 				      int severity);
 #else
 static inline int
-cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
+cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err, u32 len)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.55.0

