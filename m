Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F818FC91;
	Fri, 13 Jun 2025 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749777439; cv=pass; b=S+UoIVAVee2HClZq7zwq/DrcuyW1aCKSZ4WGPGPesgjRHoB4j4cKAvs/pBYwKIyvQa8dAvz73gm5tllGfbql/aeI/Lshn1bZ85jGd4PoKBKdHoKaUDcxPS+TX4ErHXspdHFi/C5nSxYU/5obGAm4i81y6cebXX1qOemJ1NpWqeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749777439; c=relaxed/simple;
	bh=SE2gMvs69KJwEeMw4LVG+uxkdQffyaxBJ1kUt7qde/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WA8DJBO9HhIM/UpbSsmbq1Hw77c9QBazYE9rWRTIB/4iNLqkWelRZhALp5Xbv5eUUh52ZQcEPelyeKE5MZF5Beik5PRHHxDWSutLZdhHLE/f9GI1YXtfCjaEM3e1v/f556woCmBbCrvrmhU65DiBMp03+FwP02hT8vjMq86WXdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=EbNxmQTG; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="EbNxmQTG"
ARC-Seal: i=1; a=rsa-sha256; t=1749777420; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Db5ZLSqEvxz/mh/pQ3q9oRJsi//zI1yZf/QM1J0jhr4PRO3j1lE6qKbTLavQy4fZK1/fRIY6ZUa610w2YZQYcHtOHRnDhy3PlOYuRLNxYcytOko9ElizJolihIzYp6o6ZxrOvd20zNom8Ijnyv1xVVaEB8YDAWBG3TIpuePDoJg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749777420; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0L7BKWvOuvfVDSg+VJCsKrEDpK9Jj14ttaNHAKYRQHQ=; 
	b=aeHYIC7nsPoP4Q0HIcN82gYUys2YCzkIv+jDsAOcrP7tPT7JzIIDIW24AclzwLKeZT6ejs2q97yK+HsCmma7uoKANpGqDJy4GuiWyg1KwFbQR1QLEE2M15V7lJm7ZYZBh8urdhAwGdf/eVSR1hvWfMfN9oW+fx4N+WJqUDlzpow=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749777420;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=0L7BKWvOuvfVDSg+VJCsKrEDpK9Jj14ttaNHAKYRQHQ=;
	b=EbNxmQTGcve2F9r3TJ3mWwMIFzeyynWBOE0t68u1TchLLfTzX7RD0Iq7B4FacLsM
	/JAyhS3JcypGgHpXXTTdMoXinP5cPlG0IVbwvqZRtoj2XHvRF675hB8A3cWNNtX4Ygn
	IWjQsQApt1RJct+euNEyb99TT5E9gr1YlnjSPmHU=
Received: by mx.zohomail.com with SMTPS id 1749777417445827.3026025740155;
	Thu, 12 Jun 2025 18:16:57 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v2 1/1] cxl/edac: Fix potential memory leak issues
Date: Fri, 13 Jun 2025 09:16:48 +0800
Message-Id: <20250613011648.102840-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227ff1cd31c31c3086469305e060000dd3b71e465ed97275de562b51b202c59a863dfd2c3f51342fd:zu08011227b54d31b1826e7d32de7773280000d77a85a4d1c2189b604832687dc28b70bdb85ab02935fabd17:rf0801122de8fac3f0d9d5f5827a75cffe00007d19148ccccaa9f940ed8e926b7502348fcbb750edebe5f7c88f2e37fe28e7:ZohoMail
X-ZohoMailClient: External

In cxl_store_rec_gen_media() and cxl_store_rec_dram(), use kmemdup() to
duplicate a cxl gen_media/dram event to store the event in a xarray by
xa_store(). The cxl gen_media/dram event allocated by kmemdup() should
be freed in the case that the xa_store() fails.

Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
Signed-off-by: Li Ming <ming.li@zohomail.com>
Tested-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
---
v2:
* Use kfree() instead of __free(kfree). (Jonathan)

base-commit: 87b42c114cdda76c8ad3002f2096699ad5146cb3 cxl/next
---
 drivers/cxl/core/edac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 2cbc664e5d62..628786def464 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -1099,8 +1099,10 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
 	old_rec = xa_store(&array_rec->rec_gen_media,
 			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
 			   GFP_KERNEL);
-	if (xa_is_err(old_rec))
+	if (xa_is_err(old_rec)) {
+		kfree(rec);
 		return xa_err(old_rec);
+	}
 
 	kfree(old_rec);
 
@@ -1127,8 +1129,10 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
 	old_rec = xa_store(&array_rec->rec_dram,
 			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
 			   GFP_KERNEL);
-	if (xa_is_err(old_rec))
+	if (xa_is_err(old_rec)) {
+		kfree(rec);
 		return xa_err(old_rec);
+	}
 
 	kfree(old_rec);
 
-- 
2.34.1

