Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71913B813D;
	Fri, 17 Jul 2026 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305021; cv=none; b=UVB6eVb9SwIFBXdf9sx5Z+zL6Q/z6/MHFAQkuNt2DL/QP2ys/TrfnhcUPMCyVR6xOkg0kmWmvfAbPTAhKDojmGPdoCRABTS7G0MSlUU7h6QA9XTYZaOQjmBe8lhGzu/EDXZR23vXDKWODzHfW3I+9lAHuIgK9K8Pabu++DlkEiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305021; c=relaxed/simple;
	bh=Re8EZYXMW10gTeoQR6+OrqLdJQWWAbOI7jIgl2McEUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsvIB4IAW0ddA7HjxnwNTgcw7xkFNSN/pRHOIwfQrwnIsPldWjsYiD+V+V/f/Kvjiz58AdlMlz2kc7l2ykx1ol0AVYO7/uQR6V49Cmo4W7YGYP12xey6DjenDzxipJM/BiFb3ruEcZtQQBvJeu2zQyKsmx9BNZZrRJgOHMjCdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9383E1F00A3A;
	Fri, 17 Jul 2026 16:16:59 +0000 (UTC)
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
Subject: [PATCH v3 07/10] ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
Date: Fri, 17 Jul 2026 09:16:44 -0700
Message-ID: <20260717161647.1493259-8-dave.jiang@intel.com>
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

sashiko-bot flagged that a Kconfig macro typo compiles out the extlog
CXL protocol error handling entirely.

The guard reads "#ifdef ACPI_APEI_PCIEAER" instead of
"#ifdef CONFIG_ACPI_APEI_PCIEAER", so the wrapped code is always compiled
out. Use the correct CONFIG_ prefixed symbol.

Reported-by: sashiko-bot@kernel.org
Fixes: 95350effc3ad ("ACPI: extlog: Trace CPER CXL Protocol Error Section")
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/acpi_extlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index ae79d090de33..1fbaf134c04e 100644
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
-- 
2.55.0

