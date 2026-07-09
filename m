Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D93416D15;
	Thu,  9 Jul 2026 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614494; cv=none; b=lkVuKK7bg6lCiDRoUJRsZxnxbmKmmzSlLkHLNMykntOy2pThdAYxuzNGlYf9pGAG8Q/TtqMta2CoZaG15VKuSf+GqKVmfe8oZNiwIl5Flo2cED+cxr0IA64NbB3jGVCXW929mJBGjWsU0/EyxkgaGCkvQ+I3FmFBXQc2VmI08HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614494; c=relaxed/simple;
	bh=sloDdCXreIWg41aT7Vn2C0jq9+eizUSYgDQN31cRLvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umVoeRtX34JvyUV3JKGNh+3pqooZiUPaJb0kNy8B+T8Gkk06efbhUPdjPG6vtybsOnzjlhuFehqf+M+Da6kWfSk3yymwarSCCNaBK7UJ7BxuIzhK4J66bL5U173QGtin3MCi4LzcY98gdjTFOVOFJwY3oK/ySJkzz94e9ijS+lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8724F1F00A3A;
	Thu,  9 Jul 2026 16:28:12 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com
Subject: [PATCH 3/4] ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
Date: Thu,  9 Jul 2026 09:28:06 -0700
Message-ID: <20260709162807.1957783-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709162807.1957783-1-dave.jiang@intel.com>
References: <20260709162807.1957783-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"#ifdef ACPI_APEI_PCIEAER" is incorrect. It should be
"#ifdef CONFIG_ACPI_APEI_PCIEAE". Currently the section wrapped will
always evalutes to the stub because of this. Use the correct CONFIG_
prefixed symbol so the code is actually built.

Fixes: 95350effc3ad ("ACPI: extlog: Trace CPER CXL Protocol Error Section")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/acpi_extlog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 7ad3b36013cc..60c2b90adf0a 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -136,7 +136,7 @@ static int print_extlog_rcd(const char *pfx,
 static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 			      int severity)
 {
-#ifdef ACPI_APEI_PCIEAER
+#ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct aer_capability_regs *aer;
 	struct pci_dev *pdev;
 	unsigned int devfn;
@@ -167,7 +167,7 @@ static void
 extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 				int severity)
 {
-#ifdef ACPI_APEI_PCIEAER
+#ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cxl_cper_prot_err_work_data wd;
 
 	if (cxl_cper_sec_prot_err_valid(prot_err))
-- 
2.54.0

