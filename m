Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3744176AC5;
	Fri, 16 May 2025 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406091; cv=pass; b=sdK9VWQQbpHqccB5CvRNk8pAk5s+Xlz0yM0VF8RwAh07kWDpJgXqCm3hbcn7b2w/rCIzmSC0TIGODlhjRvOoJFYx+DQs8s2XTTP5xX9VVqt10SBRxFAWCyboAN+QwS6B4f+pjGELarmHJzoRiw6jJiWE/th14gu2ORpGcBuTGFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406091; c=relaxed/simple;
	bh=8fUO6jPaZ/ma/cN8vVRzKW391bHTzvar0NuldUhDY/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GYjqnrEH8dvaiV5bHVyvOErs4dk4zCXxyx5bsVsuK9HvZU7vsq0/IiSYdU0JysFSy/vKuWo+KqJqfjjiKpufDcZzqmkv0C7JJDJOdgdumDWkQCJ6R2aBKPDJN1zowI16zwokxD79NPUTV46u6knRQUHq8cr4mM5GOHZKaGab2BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=RAZb5Eb0; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="RAZb5Eb0"
ARC-Seal: i=1; a=rsa-sha256; t=1747405956; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Sn9D1aVfzOgg5utsKrvxPQLR8NyYhxPV1Qq8zNxfsZwNAmMJavZAfo3xjFpRuPyLYRWdOweUZ2WGIbGgXffny8QaeaPpid+S6THbXwPlT+s0gJSytwFByYeRClZ2N3w30zVlF6d/jesSaiQi5muYYbTzC0DRMHgE+dRZqwRiPL4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747405956; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QG6uFSzxyEei3bUylVnUIeowJOAePKE8Necwb37H82Y=; 
	b=cV/MS31gf//LmSfnS5cPNEC69gq1ncUBAM9RpwUiuOd4eq2Gv7ovOhWyct68ggH7kEb16DkcHRZ+OgzxqSXkbS3LtQm1jjg5tk5hKWpIctGe0TfmsxaJNHvRcrEEb7Fn3woPElb2dmOhYIpROKLDT1d73BpetAfRekYaXwl5drA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747405956;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=QG6uFSzxyEei3bUylVnUIeowJOAePKE8Necwb37H82Y=;
	b=RAZb5Eb0o+vYx/PqMiaEyhZIJaiuYlYKIxpRbdxz+Ul6cH2zW3HRTKvbMiIDMRPk
	J5nIFp+7zomqyvBsmzJuDWqrk0joMaaHNxklzo5uzeWbxw+SOj1BuXCsuEkRS56/SMV
	P2L3FH11BAQ+jNGIfUE2n4BBngLZW1X3MAud2muM=
Received: by mx.zohomail.com with SMTPS id 1747405953239802.7434673395758;
	Fri, 16 May 2025 07:32:33 -0700 (PDT)
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
Subject: [PATCH 1/1] cxl/feature: Remove redundant code of get supported features
Date: Fri, 16 May 2025 22:32:20 +0800
Message-Id: <20250516143220.35302-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122736b0a90ac7aa7ae7c66564610000d4e64de8d563496a159a562e7199d7c0f442ffacf5fb3418a1:zu080112273ed26e78e4eb1dc602937c60000034619157c702490e839bac1796efc2e414ff88cdbce4e212cd:rf0801122d63ef59ad5cedc4732de2e9ff000029912dacb55ea11af706d424c59425f8bf728a5aefebe23c7fb2b8930c23d2:ZohoMail
X-ZohoMailClient: External

In cxlctl_get_supported_features(), there is a code block that handles
the case where the requested is equal to 0. But the code following the
code block can also handle this situation. So the code block is not
needed.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3 v6.15-rc6
---
 drivers/cxl/core/features.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 1498e2369c37..2d3a6d36a761 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -416,14 +416,6 @@ static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
 
 	rpc_out->size = struct_size(feat_out, ents, requested);
 	feat_out = &rpc_out->get_sup_feats_out;
-	if (requested == 0) {
-		feat_out->num_entries = cpu_to_le16(requested);
-		feat_out->supported_feats =
-			cpu_to_le16(cxlfs->entries->num_features);
-		rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
-		*out_len = out_size;
-		return no_free_ptr(rpc_out);
-	}
 
 	for (i = start, pos = &feat_out->ents[0];
 	     i < cxlfs->entries->num_features; i++, pos++) {
-- 
2.34.1

