Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C819ABBF;
	Tue, 22 Oct 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594760; cv=none; b=I0hSDalGxfAHezXja72M8KcRF3daJfHORuFxRImfzq8pGzzEr4avrvoQVqzqowpUWiqvoep/WslZx5GAdIQZZoyRlbawB+1HLDuPxsu3k9sr+1WU5J6qWn3pyztxF/wY2NcUPW9JQIcueMf+3i1YxDru22Zd20ruPPNzzpCfBrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594760; c=relaxed/simple;
	bh=1NmvxqnIX9Ew0mavlAZBVH4EGz94cGJIDrjMBUi0Ug8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IW8Y8s+yjypyyPQd9RYFMeQM0KIVjEyYXrLVBtW9fqOqyyRoMuFfv2FLw2xqkFgYBwSb4aEA6PM9Xo0PFYrfUi7RRL6YfUrNWHzXVTeJwj9R6l31+5nyqGdVb0jmlUrkgcRPA2G0LenkFDYKmzHQ3h6LshxfOxRW7AwFdQ4HSjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XXpw74jxbz6GFhH;
	Tue, 22 Oct 2024 18:54:31 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 61F0014039E;
	Tue, 22 Oct 2024 18:59:10 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.246.16) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 12:59:09 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 2/6] cxl/events: Add Component Identifier formatting for CXL spec rev 3.1
Date: Tue, 22 Oct 2024 11:58:45 +0100
Message-ID: <20241022105849.1272-3-shiju.jose@huawei.com>
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

Add Component Identifier formatting for CXL spec rev 3.1, Section
8.2.9.2.1, Table 8-44.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/trace.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 7305974e2301..81908072c6f3 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -268,6 +268,26 @@ TRACE_EVENT(cxl_generic_event,
 	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
 )
 
+/*
+ * Component ID Format
+ * CXL 3.1 section 8.2.9.2.1; Table 8-44
+ */
+#define CXL_PLDM_COMPONENT_ID_ENTITY_VALID	BIT(0)
+#define CXL_PLDM_COMPONENT_ID_RES_VALID		BIT(1)
+
+#define comp_id_pldm_flags(flags)  __print_flags(flags, " | ",			\
+	{ CXL_PLDM_COMPONENT_ID_ENTITY_VALID,   "PLDM_Entity_ID[5:0] " },	\
+	{ CXL_PLDM_COMPONENT_ID_RES_VALID,      "Resource_ID[9:6] " }		\
+)
+
+#define cxl_print_component_id(flags, valid_comp_id, valid_id_format, comp_id)			\
+	(flags & valid_comp_id && flags & valid_id_format) ?					\
+	(comp_id[0] & (CXL_PLDM_COMPONENT_ID_ENTITY_VALID | CXL_PLDM_COMPONENT_ID_RES_VALID)) ?	\
+	__print_hex(&comp_id[1], 10) : (comp_id[0] & CXL_PLDM_COMPONENT_ID_ENTITY_VALID) ?	\
+	__print_hex(&comp_id[1], 6) : (comp_id[0] & CXL_PLDM_COMPONENT_ID_RES_VALID) ?		\
+	__print_hex(&comp_id[7], 4) : __print_hex(comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE) :	\
+	__print_hex(comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
+
 /*
  * General Media Event Record - GMER
  * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
-- 
2.34.1

