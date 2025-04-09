Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A85278F3E;
	Wed,  9 Apr 2025 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744164784; cv=pass; b=PASTiaWSWucxRiXCSzKMBRFlwLeB5LAmzuYb9kcwmtxeF575C3iz3OGaaMvn79LJDZiVWFyAU1yDi7JVd7Tin3YnWQUYoCp1n07nq+mh4nggnDlyT3piuckPPIr6NbiGFoQOLVopZ8G5zzqBiCdYsaVMUDnorrrHwS7VE1Xis54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744164784; c=relaxed/simple;
	bh=Oc3kCfcLnXiva7EyTdzP0lqyMdbyP0m/rNbeRDveptw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c7Uc24OLWhVd4qsiP7zMAhJZXEIB4m/KNwuQIDis9qtREAyBr8wjF/u8hIsODnXvaeeKFUAHvsAvHV7unbT2fyFlPFo3Tfkj+OdefxUwZZxTWtMSEipb4gJM0joekYEp+SjfrWsxxmO0zte1rVHsIkKE8rBtOpqY99SNF+zg4+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=TDTNBAly; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="TDTNBAly"
ARC-Seal: i=1; a=rsa-sha256; t=1744164771; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b4jL/RsAzjnCBQcMW4mroV/L60hftAl4wI2JO3RJMNJ3f394gLdNlxjhYPAcKFRJSHfzY0ZWmr6bFsIieo3qMlhPUpNgqSap7GKxRMdh7yvTqB1LByHAT6uoJkXj0tedDHGs2HHngJMGGV/AmJCfx9yHl1nP20sHbQElZZGw8XE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744164771; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VtmoODMN4oZY2af3oMdedj6EwBx72W+e7Ni+nc+Q+RA=; 
	b=edO5PBxgVdH15gIyYmm/lbHCkN1YDdcXFrX76EHN+ZJN5xyJYBCi9D9jHE0CTF8SClTSXQHw13Jvqwauw448GqGWboyDYWsnFxfPU5mREO49uGLyBqdDpmS5ub8iufNqNrVHq1Ux1vt04xW6hQLNpwBsWVe6M38gb8QqAMMaT5o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744164771;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=VtmoODMN4oZY2af3oMdedj6EwBx72W+e7Ni+nc+Q+RA=;
	b=TDTNBAlyGV0nIcBxaRQ6XcvdKIabyHdofzGy77N3gUAnegBolNmZuCPZziaFhdUH
	rk+qFs+nTWmvvIWzP2JGJv/RGv4Jl1Sr3CSFzbrcJ0hQ9eXUNxnIgfXBBJDE21n1vgm
	IwYLYFIuXFPBKeNbdOLXSTwPOAgUxhri4zoO7Bvc=
Received: by mx.zohomail.com with SMTPS id 1744164768709177.01988685105823;
	Tue, 8 Apr 2025 19:12:48 -0700 (PDT)
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
Subject: [PATCH 1/1] cxl/feature: Update rpc_out in set feature failure case
Date: Wed,  9 Apr 2025 10:12:34 +0800
Message-Id: <20250409021234.509565-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112270c6dbb2efba043b9c186b1c3000002ab7819d18931879caca5a3226c169da9e0c454e2ae424f5f:zu08011227079f898d2fe267e6ddda0be6000049376610a57505bfcf6560b577a582016182924d704387ded7:rf0801122dc42346f019fe77167560f87900006ef9f181c3e29f18a393959246cc4122457585bbd8e7f98381ad5119f5ad30:ZohoMail
X-ZohoMailClient: External

CXL subsystem supports userspace to configure component features via
fwctl interface, it will configure features by using Set Feature
command. Whatever Set Feature succeeds or fails, CXL subsystem always
needs to return a structure fwctl_rpc_cxl_out to caller, and returned
size is updated in a rpc_out parameter. The rpc_out is only updated in
success case at this moment, it should also be updated in failure cases.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index fcc624cefe89..63f24f032209 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -540,13 +540,13 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
 	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
 			     feat_in->version, feat_in->feat_data,
 			     data_size, flags, offset, &return_code);
+	*out_len = sizeof(*rpc_out);
 	if (rc) {
 		rpc_out->retval = return_code;
 		return no_free_ptr(rpc_out);
 	}
 
 	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
-	*out_len = sizeof(*rpc_out);
 
 	return no_free_ptr(rpc_out);
 }
-- 
2.34.1

