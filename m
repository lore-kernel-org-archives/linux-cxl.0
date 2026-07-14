Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC37442BEA5;
	Tue, 14 Jul 2026 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071136; cv=none; b=W3O/fiU3NMUzt1YBPvdkhTv6Ac5FCqcxTKAo1HjDajDqnwOTY+tR50WUkk8C5cKRwgimqYgGZEA9L8c+KqNQrGAzwfnnPhU9Epio6KqQE6/UvTqIRGPDKtRTBP4z/E/lPy4c7tjcl/DNGgcwCZWZFK8pPJFZrxlybpG1zSZ6w14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071136; c=relaxed/simple;
	bh=6EcYPppljRlRjQTLq9FILKrMiwbZVjXUKH56KnRJcQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pc5nqiBo8C/Ry5N3GxVblyyYSviTLahKq9rNS4/v+sGOT2bS7KK+xxaaBc7uhY3Xo+boABh/D7bXmkG6T8NGEdOa7W1xeAHo++6tdla/OQGikfwdSLi+wi7gmKz0jOcvJhd4UI+pFJiXZYlKfPt11TgyccypOowSHLwFFMMrP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA411F00A3A;
	Tue, 14 Jul 2026 23:18:54 +0000 (UTC)
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
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v2 5/7] ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
Date: Tue, 14 Jul 2026 16:18:33 -0700
Message-ID: <20260714231835.303081-6-dave.jiang@intel.com>
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

"#ifdef ACPI_APEI_PCIEAER" is incorrect. It should be
"#ifdef CONFIG_ACPI_APEI_PCIEAER". Currently the section wrapped is
always compiled out because of this. Use the correct CONFIG_ prefixed
symbol so the code is actually built.

Fixes: 95350effc3ad ("ACPI: extlog: Trace CPER CXL Protocol Error Section")
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Fixed commit log incorrect kconfig symbol.
- Added Ben's review tag.
---
 drivers/acpi/acpi_extlog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 0c440d75d9a7..3e3e388af47b 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -136,7 +136,7 @@ static int print_extlog_rcd(const char *pfx,
 static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 			      int severity, u32 len)
 {
-#ifdef ACPI_APEI_PCIEAER
+#ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct aer_capability_regs aer_regs = {};
 	struct aer_capability_regs *aer;
 	struct pci_dev *pdev;
@@ -176,7 +176,7 @@ static void
 extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 				int severity, u32 len)
 {
-#ifdef ACPI_APEI_PCIEAER
+#ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cxl_cper_prot_err_work_data wd;
 
 	if (cxl_cper_sec_prot_err_valid(prot_err, len))
-- 
2.55.0

