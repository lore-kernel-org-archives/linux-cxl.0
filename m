Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB404D599;
	Fri, 21 Feb 2025 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101178; cv=pass; b=fzCSnZKVmEU/64j4V8pgHJJQsPztTDkirsQF+5eW11q6vPF/NwFvncDorr60r3JrS1wJzU6XoWAphVDh8jgYL4kOu1uIorbbVawIOzHudh67RVdxzO9CiMrJe3lWTXSr8j606hFb0lFWtgo50n+Wn0KZrDAUWdQWEwbgVCFWTlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101178; c=relaxed/simple;
	bh=FWfKaOo1y23KEKjaFozPERfVS/SxsYIJZFM77jFwkvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iKohrfwIUg1/IsXG5ibyHxffH02GxyjWDkvSHFcCpVJkXH9DPvzWP5nmQs/yLOxl06Nc5w0+axJyA/P5wS7E3wW4vCFZnZQwV/HJSk1Ax3zuk45xn0l14NJPncOLKwilSRCetV9ilE9+mQyyLAM3LSjg8+PDzQmicmvQYEro4sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=eIs3UcHN; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="eIs3UcHN"
ARC-Seal: i=1; a=rsa-sha256; t=1740101148; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iU1JWN3iUcMH6e3whEYgTgyXFiwsTxodOrgSwNIGCXFfDFAWlhuSWjVcv3alFo/8LkM5oAvdiHRCxyPhrjckMBMs8qhyt1m9ILMe45jsQcfu/Fgk21fNwVE0Lw9wjrXT6+FTNFoWqPEge3kF7R9rHU45LmmtERfQJyPzDeoId4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740101148; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vNpP+jFLz7Le9b+c7WbpRmlylQtNwb6oUyih0UJYig0=; 
	b=CKWA5qtmhR4TricfHKEFqwoL72mBwNCmGUEECSDsxsrju8nrYIJ1YIbNuDMsn1vEgOiDTtUAcoDEHDLkvHkj4+zh2YTAnkvPyM6ZCwtN803gIOAAzWUwBF+i7unBrlMeU2yluYb99sxfpbnQy+vDzbsbhac8q5Im7pc0eE+3tYw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740101148;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=vNpP+jFLz7Le9b+c7WbpRmlylQtNwb6oUyih0UJYig0=;
	b=eIs3UcHNV6qWBU+ocF6qFjb3ZVq+wApLv+X3eC+f34Tb10o1cKAiOZsKmVuO2TSC
	EqEtRmLE4VyBAwtHdRHVW9CpIFzGWkYyHstmz39N+fV9JBngMJ+IbJkrKhqgzkdR8wl
	zVBj/nANKoXOvr5ucKaDFYgSB9itCDEfAlv+rNgs=
Received: by mx.zohomail.com with SMTPS id 1740101146430807.9817218628841;
	Thu, 20 Feb 2025 17:25:46 -0800 (PST)
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
	Li Ming <ming.li@zohomail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 4/7] cxl/core: Use guard() to drop the goto pattern of cxl_dpa_free()
Date: Fri, 21 Feb 2025 09:24:50 +0800
Message-Id: <20250221012453.126366-5-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221012453.126366-1-ming.li@zohomail.com>
References: <20250221012453.126366-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227fac667d5fa5d7055e8eceeee0000b6a36affab8dd0d65b3bc32131df84a9b6aa717461fd2fa892:zu08011227c7a7528d03021328db03e30f0000bc5d4632132a394568e7f2e9c6ad2b6dabae8e60eb574e034d:rf0801122de56a3d291f76d0cb1883c34f00003fe8a51674e843bac2bec1f3a5d6bca2406dbc0f5993c8b50ecc4dd7ae428e:ZohoMail
X-ZohoMailClient: External

cxl_dpa_free() has a goto pattern to call up_write() for cxl_dpa_rwsem,
it can be removed by using a guard() to replace the down_write() and
up_write().

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/hdm.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ad74b46d3e16..e1d1fe5492ff 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -550,35 +550,27 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct device *dev = &cxled->cxld.dev;
-	int rc;
 
-	down_write(&cxl_dpa_rwsem);
-	if (!cxled->dpa_res) {
-		rc = 0;
-		goto out;
-	}
+	guard(rwsem_write)(&cxl_dpa_rwsem);
+	if (!cxled->dpa_res)
+		return 0;
 	if (cxled->cxld.region) {
 		dev_dbg(dev, "decoder assigned to: %s\n",
 			dev_name(&cxled->cxld.region->dev));
-		rc = -EBUSY;
-		goto out;
+		return -EBUSY;
 	}
 	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
 		dev_dbg(dev, "decoder enabled\n");
-		rc = -EBUSY;
-		goto out;
+		return -EBUSY;
 	}
 	if (cxled->cxld.id != port->hdm_end) {
 		dev_dbg(dev, "expected decoder%d.%d\n", port->id,
 			port->hdm_end);
-		rc = -EBUSY;
-		goto out;
+		return -EBUSY;
 	}
+
 	devm_cxl_dpa_release(cxled);
-	rc = 0;
-out:
-	up_write(&cxl_dpa_rwsem);
-	return rc;
+	return 0;
 }
 
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
-- 
2.34.1

