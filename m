Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB23AFAE3
	for <linux-cxl@vger.kernel.org>; Thu,  8 Oct 2026 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431197; cv=none; b=BI2iys9fcG4OsNJDEr6zlKJGuy97ebXs8rBiaL+gEOAiHIh11QboewAbpgmkKKZ/1xY7nMINnpXKcRI+3xI+e/ewTcGJJ158nHfRLVC13pmo4Se0sFRPUoLjUA7yg0ooGd6vUGkvquxTOsx2U4MGkPNQckXw5xRdK0x8qMgS2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431197; c=relaxed/simple;
	bh=bAzzfFTKvrqL8kHJ5VT/Z4rBth8N+sfv8YfE4K6prOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bq3rlPSCGyTG2lRu5p638LmExCxIo4B4X67JoiA2M955j6lPtxlef2ff1DSTPvKvMjvQYcvuB3mtKS0Z+Tvp8d5cswe6Y6LrYU6B0XUlqu857dknPiDJ/3sxlbX5TrxkXOLsChPgbvwy4nlfR3uhXYCy6nJDRLcBVtelh8i5/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CHyScC3Y; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CHyScC3Y"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791431190; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hU6dkFzB7dnNObaLlm5PvVs1ajmWWADrslxPo57cMsY=;
	b=CHyScC3Y9omTD9p/F3GTMSB689KRRlRnpjZvNuwLX7O9yV52BenTmmqitgitJ4lDfXQUfxMAsyXWA0PgdAKbXtTOJdere7C5VMUAb2KxxDJWKY4eKj88wY5kZNeLr9y2/BQEFPv31UiI/zr1qqgoe6Tgy43764l55LrSbK487/M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XCJFh82_1791431189;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XCJFh82_1791431189 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Oct 2026 11:46:29 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/3] cxl/pci: Program the Port GPF timeouts before caching the DVSEC
Date: Thu,  8 Oct 2026 11:46:13 +0800
Message-ID: <20261008034619.28059-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261008034619.28059-1-kanie@linux.alibaba.com>
References: <20261008034619.28059-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_gpf_port_setup() caches the Port GPF DVSEC offset in the dport
before programming the phase timeouts, and ignores the return value
of both update_gpf_port_dvsec() calls: the function always reports
success.

A failing config write is therefore not only silent, it is also
permanent: the timeouts stay at the hardware defaults instead of the
maximum flush window the kernel is asking for, and the cached offset
keeps any later endpoint attach from retrying the update.

Propagate the errors and cache the offset only after both phases are
programmed, so the next endpoint attach retries the setup.

Fixes: 6af941db6a60 ("cxl/pci: Update Port GPF timeout only when the first EP attaching")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e31aad7a525a..1f470ab0df3b 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -840,7 +840,7 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 
 	rc = pci_read_config_word(pdev, dvsec + offset, &ctrl);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	if (FIELD_GET(base, ctrl) == GPF_TIMEOUT_BASE_MAX &&
 	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
@@ -850,11 +850,17 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 	ctrl |= FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
 
 	rc = pci_write_config_word(pdev, dvsec + offset, ctrl);
-	if (!rc)
-		pci_dbg(pdev, "Port GPF phase %d timeout: %d0 secs\n",
-			phase, GPF_TIMEOUT_BASE_MAX);
+	if (rc) {
+		rc = pcibios_err_to_errno(rc);
+		pci_warn(pdev, "Port GPF phase %d timeout write failed: %d\n",
+			 phase, rc);
+		return rc;
+	}
 
-	return rc;
+	pci_dbg(pdev, "Port GPF phase %d timeout: %d0 secs\n",
+		phase, GPF_TIMEOUT_BASE_MAX);
+
+	return 0;
 }
 
 int cxl_gpf_port_setup(struct cxl_dport *dport)
@@ -864,16 +870,22 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
 
 	if (!dport->gpf_dvsec) {
 		struct pci_dev *pdev;
-		int dvsec;
+		int dvsec, rc;
 
 		dvsec = cxl_gpf_get_dvsec(dport->dport_dev);
 		if (!dvsec)
 			return -EINVAL;
 
-		dport->gpf_dvsec = dvsec;
 		pdev = to_pci_dev(dport->dport_dev);
-		update_gpf_port_dvsec(pdev, dport->gpf_dvsec, 1);
-		update_gpf_port_dvsec(pdev, dport->gpf_dvsec, 2);
+		rc = update_gpf_port_dvsec(pdev, dvsec, 1);
+		if (rc)
+			return rc;
+
+		rc = update_gpf_port_dvsec(pdev, dvsec, 2);
+		if (rc)
+			return rc;
+
+		dport->gpf_dvsec = dvsec;
 	}
 
 	return 0;
-- 
2.43.7

