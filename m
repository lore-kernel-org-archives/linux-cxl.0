Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB74D18870C;
	Wed, 20 Nov 2024 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095487; cv=none; b=cxfA44aUhynbxpi9Ve+U4WDUjtm5ZNmBtQYrpKQpCYY2CpKuUWoYnZ8KJm1zRIwPWBuJhViy7k1dzqBnasMSt7EQCIeSIM1CzPGjHidQTJAUjsDsNmRe+k6IVj3Jh9PH/8qk268w6PEYuw+syBucQMGrbpUjV2rnGUuSN21CDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095487; c=relaxed/simple;
	bh=gi9hlOJnVS6BZxdFvTjIfRcB1+u4kDNEiCcQxTI0IIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWSyr09Ejz1oj9BJ7rKslHr4VPnfWO4zcmzBHo51F0Og6S3xWcJgMaQhgPwvwD0H2FEEdf7OL2bXlnJ8Qp2JkcbH4MOeL76nYa5bumXW7CCLRC3qf7VuofQ24rqycqXFZs64b4uhCNjSsLDpuKlzFL/zbY8yEhSrFTq9mGzMF0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xtbnt0tR8z6K98c;
	Wed, 20 Nov 2024 17:35:46 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D1D9140AB8;
	Wed, 20 Nov 2024 17:38:02 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.247.212) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 10:38:01 +0100
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v4 6/6] cxl/test: Update test code for event records to CXL spec rev 3.1
Date: Wed, 20 Nov 2024 09:37:45 +0000
Message-ID: <20241120093745.1847-7-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241120093745.1847-1-shiju.jose@huawei.com>
References: <20241120093745.1847-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Update test code for General Media, DRAM, Memory Module Event
Records to CXL spec rev 3.1.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 tools/testing/cxl/test/mem.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 71916e0e1546..94e7534581d8 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -401,6 +401,10 @@ struct cxl_test_gen_media gen_media = {
 			.channel = 1,
 			.rank = 30,
 		},
+		.component_id = { 0x3, 0x74, 0xc5, 0x8, 0x9a, 0x1a, 0xb, 0xfc, 0xd2, 0x7e, 0x2f, 0x31, 0x9b, 0x3c, 0x81, 0x4d },
+		.cme_threshold_ev_flags = 3,
+		.cme_count = { 33, 0, 0 },
+		.sub_type = 0x2,
 	},
 };
 
@@ -429,6 +433,11 @@ struct cxl_test_dram dram = {
 		.bank_group = 5,
 		.bank = 2,
 		.column = {0xDE, 0xAD},
+		.component_id = { 0x1, 0x74, 0xc5, 0x8, 0x9a, 0x1a, 0xb, 0xfc, 0xd2, 0x7e, 0x2f, 0x31, 0x9b, 0x3c, 0x81, 0x4d },
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
+		.component_id = { 0x2, 0x74, 0xc5, 0x8, 0x9a, 0x1a, 0xb, 0xfc, 0xd2, 0x7e, 0x2f, 0x31, 0x9b, 0x3c, 0x81, 0x4d },
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
2.43.0

