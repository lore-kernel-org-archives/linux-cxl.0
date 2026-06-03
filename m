Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B72375F65
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jun 2026 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513076; cv=none; b=jX/xgPuVFZndvBfDoXzvWjzO1sNt/Nq7lYht8Ak7m4AQSaMkO4GG+/29v0dHAb3pMrwc30k0d5YDUZMgoX89+TSI9PpF2rzL/jdV7rRhjJlP1uIkEaj8Dd8p4rtmq8aq6rpiuwKCamVGcg2UgCFJwy4bFV1XejspRcfwaJrPRlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513076; c=relaxed/simple;
	bh=MY27aOVQ3W48JriVpllOwzfIIn19G3tl7An5WaDZUZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTOgjHYYcuhHvnl7YW6E+QyASc45VHvLHkJA05auIY7KnEHheOeQ+4e8cDYerg57yJ12Rm1CxBamKjpnazxygRXB50lt10f7iB4mvXl/KInG6wTDVolnHKlwLfmrUjqC5fpEzJHOvbcfZAOrS10w3XX8DEaA5sF8ZxHnNjxCSUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002D31F00898;
	Wed,  3 Jun 2026 18:57:54 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	djbw@kernel.org
Subject: [PATCH 1/2] cxl/pci: Fix the incorrect check of pci_read_config_word() return
Date: Wed,  3 Jun 2026 11:57:51 -0700
Message-ID: <20260603185752.4149725-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603185752.4149725-1-dave.jiang@intel.com>
References: <20260603185752.4149725-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_read_config_word() returns PCIBIOS_* status on error which are
positive values. The check should be for non-zero values to indicate
error. Fix cxl_set_mem_enable() to check for non-zero return value
instead of negative value.

While fixing this, also convert the error to negative errno value when
returning on error path.

Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index d1f487b3d809..43885c59a7f2 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -187,8 +187,8 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	int rc;
 
 	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, &ctrl);
-	if (rc < 0)
-		return rc;
+	if (rc)
+		return pcibios_err_to_errno(rc);
 
 	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
 		return 1;
@@ -196,8 +196,8 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 	ctrl |= val;
 
 	rc = pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
-	if (rc < 0)
-		return rc;
+	if (rc)
+		return pcibios_err_to_errno(rc);
 
 	return 0;
 }
-- 
2.54.0

