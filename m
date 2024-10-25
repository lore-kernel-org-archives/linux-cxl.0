Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E91D4358;
	Fri, 25 Oct 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729856793; cv=none; b=q1TqtuxY25ctRrZsEtI+Is6seVY6Ja30aujFwnhQXm8v6r94xmDIakiZuQdjJnnrc7Aj3Qh5ahrjGFBNTkBwBzOMN7Bn/bMd6G+fu23BHZqvYiP+Qlt6X8F83e+dYbtQkdVLZhD5a3A7tKdKNYbFMx2CJnyuwB2nzNTY4ygFZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729856793; c=relaxed/simple;
	bh=BOUh+NJK+ySgk1Djv6PMgGN4u+DPdnSGt6l2jKS84vs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBzjVCCvHDIM2CffjhN7mIdtsz6tcsWW0twpbhJnQiGwT0EIlQTVEykQqJYJTfx897WFczvLTFcHK13Gr6Dwh9dIQ6QLoXPyQ4vz9+vUbU0TvB4I7eWzuiSLNVYngEDjdPq3x9TVzzExDW7K6jCF8B1kZWqmvjuDeAjxSpVtWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZgvT04sjz6K5kt;
	Fri, 25 Oct 2024 19:45:25 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 910BC1408F9;
	Fri, 25 Oct 2024 19:46:28 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.104) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 13:46:27 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 2/6] cxl/events: Add Component Identifier formatting for CXL spec rev 3.1
Date: Fri, 25 Oct 2024 12:45:51 +0100
Message-ID: <20241025114555.1363-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241025114555.1363-1-shiju.jose@huawei.com>
References: <20241025114555.1363-1-shiju.jose@huawei.com>
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

Add Component Identifier formatting for CXL spec rev 3.1, Section
8.2.9.2.1, Table 8-44.

Examples for Component Identifier format in trace log,

validity_flags='CHANNEL|RANK|DEVICE|COMPONENT|COMPONENT PLDM FORMAT' \
comp_id=03 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
comp_id_pldm_valid_flags='PLDM Entity ID | Resource ID' \
pldm_entity_id=74 c5 08 9a 1a 0b pldm_resource_id=fc d2 7e 2f \

validity_flags='COMPONENT|COMPONENT PLDM FORMAT' \
comp_id=02 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
comp_id_pldm_valid_flags='Resource ID' \
pldm_entity_id=0x00 pldm_resource_id=fc d2 7e 2f

If the validity flags for component ID/component ID format or PLDM ID or
resource ID are not set, then pldm_entity_id=0x00 or pldm_resource_id=0x00
would be printed.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/trace.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 7305974e2301..b508873ce426 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -268,6 +268,28 @@ TRACE_EVENT(cxl_generic_event,
 	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
 )
 
+/*
+ * Component ID Format
+ * CXL 3.1 section 8.2.9.2.1; Table 8-44
+ */
+#define CXL_PLDM_COMPONENT_ID_ENTITY_VALID	BIT(0)
+#define CXL_PLDM_COMPONENT_ID_RES_VALID		BIT(1)
+
+#define show_comp_id_pldm_flags(flags)  __print_flags(flags, " | ",	\
+	{ CXL_PLDM_COMPONENT_ID_ENTITY_VALID,   "PLDM Entity ID" },	\
+	{ CXL_PLDM_COMPONENT_ID_RES_VALID,      "Resource ID" }		\
+)
+
+#define show_pldm_entity_id(flags, valid_comp_id, valid_id_format, comp_id)	\
+	(flags & valid_comp_id && flags & valid_id_format) ?			\
+	(comp_id[0] & CXL_PLDM_COMPONENT_ID_ENTITY_VALID) ?			\
+	__print_hex(&comp_id[1], 6) : "0x00" : "0x00"
+
+#define show_pldm_resource_id(flags, valid_comp_id, valid_id_format, comp_id)	\
+	(flags & valid_comp_id && flags & valid_id_format) ?			\
+	(comp_id[0] & CXL_PLDM_COMPONENT_ID_RES_VALID) ?			\
+	__print_hex(&comp_id[7], 4) : "0x00" : "0x00"
+
 /*
  * General Media Event Record - GMER
  * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
-- 
2.34.1

