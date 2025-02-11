Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57F1EE7A8;
	Tue, 11 Feb 2025 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260700; cv=pass; b=MBJB/4MU/t5RAcwIHO15Nx6uvKABjgbQOqNoTsuLB9yU+GYvLUfLfWLbkC0ev7mVgKD+b8AbKa37371bzE+Pbr2T0x642qBLrD2kJFqd6J/Q3V54IsUKoBQK3um41cf2rBeMe9nSiZVFaJIvWphsZ2CCbEsJqhzggos2yVcXHGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260700; c=relaxed/simple;
	bh=RsuQC98c5NW6U84oVbbeHbKVBD7J/tzW1jwJJpYjrC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jlZz5L77Kp8CdF6/jprokC2pLPjsWANdpphbuhs2KibaNKxkLfkHV88zKT/cSlt3rfI8Ts/AiulaqTIWoyEd4CTL0EdqHvJ8kDWJ7syvDo41sWskd9ppfmh7ficAMOP66GWXuuGgeiA6/ET9FmryTV578CktlRGmYgx1ZDZp8oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=ZyHbnAoF; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="ZyHbnAoF"
ARC-Seal: i=1; a=rsa-sha256; t=1739260681; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UOTs2AES9maLtSk7dtl1050VL+sdF28M/g3ioT/OAOwDlcHYI1VibbTE29dWLbejqPOieYSsVdonUAtMOn0yzulyIjCTvmdZARNdIZFlYoAlWpcqWbL+nK/xsUBUeEveZG7OXzpEyV5Omc5DigGSRYKdhKktsEv2YBHgNYNDmhM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739260681; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iTjzGUBbZVU0q97UQAcQgUCiMr/iWP/BUtbF9Kswfxc=; 
	b=Bn7JGZFkGHvobwoYr77SpmcPrvfzX7u11lnJs22BiaGuY2JDakvDxN9Tm3hddJ9YIHVtVpDLeDFLkyBoiYhXsN4S1BEKBy7eRchbXSQ1kIBYjF4YfshWtWjrVkQ9PZALc9ZWfcjrZ6InKUIMmJeSpcTSK5kcmZf5qB5gxEMQuz4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739260681;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=iTjzGUBbZVU0q97UQAcQgUCiMr/iWP/BUtbF9Kswfxc=;
	b=ZyHbnAoFT6JUNgBICdLcQnhvUOq3PJ96bQNRLRtSxSpQ7Cg4ay2Y+iD/XtymA2XB
	LQ2QNzp7OdvrqNhgS0SSq888A4Gg+vUcX7KCDXulkqnYm9bORH3wDs/mYvFiBVxhRgb
	aO8nPiGCZodQxf6pH6cmJdFrqGQaBJEsOAqdCV8U=
Received: by mx.zohomail.com with SMTPS id 173926067923043.902923267423944;
	Mon, 10 Feb 2025 23:57:59 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v1 2/7] cxl/core: cxl_mem_sanitize() cleanup
Date: Tue, 11 Feb 2025 15:57:22 +0800
Message-Id: <20250211075727.351895-3-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211075727.351895-1-ming.li@zohomail.com>
References: <20250211075727.351895-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112273f19142c8f53c9d31c494ab30000a09fefd3bf3161f9d1e0589106825e6249b7170274c216cc1e:zu08011227a51294923f275238a6471abb0000f57951747b7652f854e50c3804f1664aa319af59137a43cd1b:rf0801122d861f71ad09848a965b2940d300009fa9f30fb5ad6638fc1116468b195858253e608ae6bb2dd8ab70a1f8b69faa:ZohoMail
X-ZohoMailClient: External

In cxl_mem_sanitize(), the down_read() and up_read() for
cxl_region_rwsem can be simply replaced by a guard(rwsem_read), and the
local variable 'rc' can be removed.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/mbox.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 548564c770c0..0601297af0c9 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1222,23 +1222,19 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 {
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 	struct cxl_port  *endpoint;
-	int rc;
 
 	/* synchronize with cxl_mem_probe() and decoder write operations */
 	guard(device)(&cxlmd->dev);
 	endpoint = cxlmd->endpoint;
-	down_read(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_region_rwsem);
 	/*
 	 * Require an endpoint to be safe otherwise the driver can not
 	 * be sure that the device is unmapped.
 	 */
 	if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
-		rc = __cxl_mem_sanitize(mds, cmd);
-	else
-		rc = -EBUSY;
-	up_read(&cxl_region_rwsem);
+		return __cxl_mem_sanitize(mds, cmd);
 
-	return rc;
+	return -EBUSY;
 }
 
 static int add_dpa_res(struct device *dev, struct resource *parent,
-- 
2.34.1

