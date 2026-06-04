Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4F45000
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596122; cv=none; b=YMTaEOSPfbvdOjJM+K1sAxkhY4LLBaiY/YRcqz3xtjhKow7BhjzliIz5a+p0GeIBzY5VkNFz4PA3e11kOWh1kLO4FkywPbaQjE3eJAOXq0BRZZhnfjTo0920IfiHoGBBclhJQ+sGeP4UdMvjsKqUySbzkvmP8SGeBTX97zJ/148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596122; c=relaxed/simple;
	bh=5IHKlQM0q9JrxhUEvDCvIxXyxUS5Q+x5XPKYwVdDzE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQOlekzxNwSlcVcQNDeW80l8cq9bC0wLfnfS0cwVvgY2p+kO6j7evvo7/tZI68pntZeUOtwXy4EEpQGV7HLbXEmhgcf7L8tOgjF02KP61BnpkQvKC0/B79c25zF5x4owR54+XDYRV8+t8beeaTlj/j2LE+3qvOV8d54Z2ziX1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F7C1F00898;
	Thu,  4 Jun 2026 18:02:01 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	djbw@kernel.org,
	icheng@nvidia.com
Subject: [PATCH v2 1/2] cxl/pci: Fix the incorrect check of pci_read_config_word() return
Date: Thu,  4 Jun 2026 11:01:53 -0700
Message-ID: <20260604180154.1925149-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604180154.1925149-1-dave.jiang@intel.com>
References: <20260604180154.1925149-1-dave.jiang@intel.com>
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
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
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

