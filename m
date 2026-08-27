Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBC0362154;
	Thu, 27 Aug 2026 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863068; cv=none; b=Mv13WBjsCc0+eLtC0BRqUm7eVcSFy/mH+gsOsLcvx2bp/UUErGHm9u4YjFKDps8ugVl4cBHhLFu9XI25Mwuspag6Bc3oLA/EoMnnZNlxwuFsAsy8yTdWk56URP2aMJzIIAyskJzweatV/O2KCcRI6WeVgTNRy7rL7nYyAdoA8gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863068; c=relaxed/simple;
	bh=7Mc/0mC+h80MgAUX/QIvCK0gbbRLJAGiM9qQ7w9osQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOoWdx4W5W8hkjmmRsgGbuq7PxvfWpnuwesMB68MVLR/o2h7BK+SfJzkYoQdn498Rro5a4EFoKZnr2jqPtF6gg80uSBuKJbWjhFfDXfDA2RmeJ9Pa65quvkqhoFSRWU8uNeCkqkoaRRhPAV/ryiVhObIMvkZJD/XyB3He271jnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0701F00A3E;
	Thu, 27 Aug 2026 20:37:41 +0000 (UTC)
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
	sashiko-bot@kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 09/13] ACPI: APEI: GHES: Validate CXL protocol error section length before RAS cap copy
Date: Thu, 27 Aug 2026 13:37:22 -0700
Message-ID: <20260827203726.3027541-10-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827203726.3027541-1-dave.jiang@intel.com>
References: <20260827203726.3027541-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_cper_setup_prot_err_work_data() locates the RAS Capability block at
prot_err + sizeof(*prot_err) + dvsec_len and copies it, but dvsec_len is
firmware controlled and never validated, so it can point the copy outside
the section.

Extend cxl_cper_sec_prot_err_valid() to check that the section can hold
the header, and that the header, DVSEC and RAS Capability block together
fit the reported section length.

Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=6
Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
Fixes: 315c2f0b53ba ("acpi/ghes, cper: Recognize and cache CXL Protocol errors")
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/acpi_extlog.c       |  3 ++-
 drivers/acpi/apei/ghes.c         |  7 ++++---
 drivers/acpi/apei/ghes_helpers.c | 18 +++++++++++++++++-
 include/acpi/ghes.h              |  2 +-
 include/cxl/event.h              |  4 ++--
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index ab46fa2adc53..3e0d21fb287c 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -244,7 +244,8 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 				acpi_hest_get_payload(gdata);
 
 			cxl_cper_post_prot_err(prot_err,
-					       gdata->error_severity);
+					       gdata->error_severity,
+					       gdata->error_data_length);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e5f8dbd17017..b8dbd99da47e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -753,12 +753,12 @@ static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
 struct work_struct *cxl_cper_prot_err_work;
 
 void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
-			    int severity)
+			    int severity, u32 len)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cxl_cper_prot_err_work_data wd;
 
-	if (cxl_cper_sec_prot_err_valid(prot_err))
+	if (cxl_cper_sec_prot_err_valid(prot_err, len))
 		return;
 
 	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
@@ -951,7 +951,8 @@ static void ghes_do_proc(struct ghes *ghes,
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
 			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
 
-			cxl_cper_post_prot_err(prot_err, gdata->error_severity);
+			cxl_cper_post_prot_err(prot_err, gdata->error_severity,
+					       gdata->error_data_length);
 		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
 			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/acpi/apei/ghes_helpers.c b/drivers/acpi/apei/ghes_helpers.c
index bc7111b740af..df41b993f413 100644
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
@@ -23,6 +30,15 @@ int cxl_cper_sec_prot_err_valid(struct cxl_cper_sec_prot_err *prot_err)
 		return -EINVAL;
 	}
 
+	/* The RAS Capability block sits after a firmware-sized DVSEC. */
+	if (sizeof(*prot_err) + prot_err->dvsec_len +
+	    sizeof(struct cxl_ras_capability_regs) > len) {
+		pr_err_ratelimited(FW_WARN
+				   "CXL CPER prot err DVSEC (%u) overruns section (%u)\n",
+				   prot_err->dvsec_len, len);
+		return -EINVAL;
+	}
+
 	if ((prot_err->agent_type == RCD || prot_err->agent_type == DEVICE ||
 	     prot_err->agent_type == LD || prot_err->agent_type == FMLD) &&
 	    !(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index be496bc0386f..7acf209061ea 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -88,7 +88,7 @@ void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
 
 struct cxl_cper_sec_prot_err;
 void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
-			    int severity);
+			    int severity, u32 len);
 #else
 static inline struct list_head *ghes_get_devices(void) { return NULL; }
 
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
2.54.0

