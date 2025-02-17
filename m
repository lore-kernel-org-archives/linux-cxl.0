Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15572222D1;
	Mon, 17 Feb 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803765; cv=pass; b=t9+Vzgnh7BHqVK0hAKTFg1h2z4DDZTpL0BVRSIvjKagcFRnsUl0cLmz3ANtez+/xeVQDu53Uadq9pO0f+rPyGs5dFoLwNCA3ymR5JoGZydL1FTV2Do6RSoiBFeUndjoijB6E3QacnY+ayFrsMVxfaX52b83xSk8705Q2TRue9xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803765; c=relaxed/simple;
	bh=59rRgjb0cfIfcixcA1SyakLEuxESLq0IMjQVuUxKvEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPYdTMSvhSplPK7XwVGmKqFoNR5TsDQ5zEFuaH+gPp6BOGGiRRxJvkDKAXMLi0ubjYztmQ0UmcPgsfn1KM6QEtkDkJh2d0f4Sv6Qm29v3MGF167PZENmMKhwPeyP7qyq0Qk+Xdh33eg90dLI99X6oEzGmS5/JH6jEyUnaERIkis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=dpj/V96S; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="dpj/V96S"
ARC-Seal: i=1; a=rsa-sha256; t=1739803746; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j52ffYrdgTP2eQBJ49pGdUCBSCdvmGLXcPOWdDIKdoQweZa/3/fEak6cCG2HO34iVJuW4C4ZwRDn51NpJdkdcKy8FeyZYMd4hKFo4OyEiiaj/t82Fo9oAJ+ZiYWWpkIHNlOBYZMs+XrMjChdcRyTPzMfFWrnlFlCiIiwLLCXVks=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739803746; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=seuYo98AeaFca7POQcm0B/jpqa2QyKqq1zrS29bL+Ic=; 
	b=N9wPr4aym1nJt/O5rm9WSXCnHq5pX1ae4mSxadF0tN+zoThFPCj/7WJwu/S3lhNTcFWdzYxcQFk+DNG+SO0FQ3w30HffMidEOOZr/NweiPABMp2D7YIaAjAKjPwaK0hyH2Mv51MxAQUABfbais6EQHi6uCKCMz7Ka+qTmOuXlD8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739803745;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=seuYo98AeaFca7POQcm0B/jpqa2QyKqq1zrS29bL+Ic=;
	b=dpj/V96SonBUNgP5Q/TviyDrReB7cTd4/wgvkcHybi/gbn7V9pIaHzl6bdzjDkp1
	m3m/jt1OqeZAfiMAC1kTtpQOjp5rknUw6ta8li1LcgXDsd7Zhutu2R9JC6gyZwi8h15
	BeIn5X6G3tl+tHhiO0BAn9KuUgFO6qDb+ZJnjkiU=
Received: by mx.zohomail.com with SMTPS id 173980374316427.75530296649265;
	Mon, 17 Feb 2025 06:49:03 -0800 (PST)
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
Subject: [PATCH v2 2/7] cxl/core: cxl_mem_sanitize() cleanup
Date: Mon, 17 Feb 2025 22:48:23 +0800
Message-Id: <20250217144828.30651-3-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217144828.30651-1-ming.li@zohomail.com>
References: <20250217144828.30651-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122795f226f8f51db3ff794a656b000046a0d02f0b361dbf095587db9da9ae4d9262013105ee374cab:zu080112278a4417fcfbe9d77a2fc5be2f00007f4a866045a52dde8702c48203cbc2dec658b2337ccca872ef:rf0801122d6cfd8d2233f879107f64026f00005629bf270c07f4fbbc87f232c0e07406174f087f7d105e3af89d565de3a6b4:ZohoMail
X-ZohoMailClient: External

In cxl_mem_sanitize(), the down_read() and up_read() for
cxl_region_rwsem can be simply replaced by a guard(rwsem_read), and the
local variable 'rc' can be removed.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

