Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9F7199246;
	Tue, 22 Oct 2024 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594758; cv=none; b=Y/sF9EuBVe2kdr5ke4634fMswR4fd1viUhMhPTPBXLLCUOrizYhV0Qs8Ku/hshcYfnZO49vyclY4bxv0KKlZG2R/Idbx9vUYsHz2I645uXoaKb2ASCxRMPxLfDJGW/WaZHa4E2TVGjvEiMMf5RfZY2Y4hsw7tQ0/KTyuDq+632s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594758; c=relaxed/simple;
	bh=NjRxDRY6JZ7568zrmSwrP31IZarXvCmW7z05rVHx7jM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwzXHUx3Og5QhcSRA0hOTJAsVkF34pAEtsxoOYv8mcuPb1YkkCPPtsb9t6Qh8KDbFhWSXQSSOdUPlPRoghoXS1jvIMWcxnEPnCsml0JB1IYKzeStmLacAouj93lWqhe/kaH4TI9Y/ERR6JMTU+66gM3ng4e8dJ5PVQ45vJNGMeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XXpwC4vCdz6GFhw;
	Tue, 22 Oct 2024 18:54:35 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 76EEA140680;
	Tue, 22 Oct 2024 18:59:14 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.246.16) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 12:59:13 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 6/6] cxl/test: Update test code for event records to CXL spec rev 3.1
Date: Tue, 22 Oct 2024 11:58:49 +0100
Message-ID: <20241022105849.1272-7-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241022105849.1272-1-shiju.jose@huawei.com>
References: <20241022105849.1272-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Update test code for General Media, DRAM, Memory Module Event
Records to CXL spec rev 3.1.

Note: Untested. please share procedure to run these tests.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 tools/testing/cxl/test/mem.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index ad5c4c18c5c6..4646d5e3325b 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -401,6 +401,10 @@ struct cxl_test_gen_media gen_media = {
 			.channel = 1,
 			.rank = 30,
 		},
+		.component_id = { 0x3, 0x7, 0xc5, 0x8, 0x9a, 0x1a, 0xb, 0xfc, 0xd, 0xe, 0x2f, 0x0, 0x0, 0x0, 0x0, 0x0 },
+		.cme_threshold_ev_flags = 3,
+		.cme_count = { 33, 0, 0 },
+		.sub_type = 0x2,
 	},
 };
 
@@ -429,6 +433,11 @@ struct cxl_test_dram dram = {
 		.bank_group = 5,
 		.bank = 2,
 		.column = {0xDE, 0xAD},
+		.component_id = { 0x3, 0x7, 0xc5, 0x8, 0x9a, 0x1a, 0xb, 0xfc, 0xd, 0xe, 0x2f, 0x0, 0x0, 0x0, 0x0, 0x0 },
+		.sub_channel = 8,
+		.cme_threshold_ev_flags = 2,
+		.cvme_count = { 14, 0, 0 },
+		.sub_type = 0x5,
 	},
 };
 
@@ -456,7 +465,10 @@ struct cxl_test_mem_module mem_module = {
 			.dirty_shutdown_cnt = { 0xde, 0xad, 0xbe, 0xef },
 			.cor_vol_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
 			.cor_per_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
-		}
+		},
+		/* .validity_flags = <set below> */
+		.component_id = { 0x3, 0x7, 0xc5, 0x8, 0x9a, 0x1a, 0xb, 0xfc, 0xd, 0xe, 0x2f, 0x0, 0x0, 0x0, 0x0, 0x0 },
+		.event_sub_type = 0x3,
 	},
 };
 
@@ -478,13 +490,18 @@ static int mock_set_timestamp(struct cxl_dev_state *cxlds,
 
 static void cxl_mock_add_event_logs(struct mock_event_store *mes)
 {
-	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
+	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK |
+			   CXL_GMER_VALID_COMPONENT | CXL_GMER_VALID_COMPONENT_ID_FORMAT,
 			   &gen_media.rec.media_hdr.validity_flags);
 
 	put_unaligned_le16(CXL_DER_VALID_CHANNEL | CXL_DER_VALID_BANK_GROUP |
-			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN,
+			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN | CXL_DER_VALID_SUB_CHANNEL |
+			   CXL_DER_VALID_COMPONENT | CXL_DER_VALID_COMPONENT_ID_FORMAT,
 			   &dram.rec.media_hdr.validity_flags);
 
+	put_unaligned_le16(CXL_MMER_VALID_COMPONENT | CXL_MMER_VALID_COMPONENT_ID_FORMAT,
+			   &mem_module.rec.validity_flags);
+
 	mes_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
 	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
 		      (struct cxl_event_record_raw *)&gen_media);
-- 
2.34.1

