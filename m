Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520124501A
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847153; cv=fail; b=njqDLY57Jzvj701jUgeIjJtmd/9Ex+g77H6/hS3IVQDM4V4rbVqsZYH7mrpxRz9Ls8cveL3J93BFxlfB6humRSpLR/gKI/8Xh5R1KEk7tEFmekdit9KKSEdeYrM5cpC1oT1GXdT8iy7mdlnd6oQFHZLV0PWEDiRtTmM9fRYhyZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847153; c=relaxed/simple;
	bh=4ENH8M/svyPBhozMWmUfxr8bSZwHnL8k/bme3JNYbI8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsyRqK9I4NXNnU2kMLK3YTRjiNoNtxYpt0JX1/cDorHM/1T+PLsHY97u3i+ZUVlO33KJRSUKDMCEEEGyLnjNctVbzEBXN2OfOT9JZENr+0JkdoKBvelRVIboZ5UePKzrdqwYe3v1N5y9QHhZxUVbFbGIpFiAgeLgAM248CGzuqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IyTu4gJV; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IyTu4gJV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnOX/doajjW/rKm+vI6zNzOPQDLGUFkDNsvC644I4j/GEwt+khr5qesOldITWiHbMHHlS8QKP9tVtkNOI2RvWziUnfqikL9QhEqTyDnprXrqqzPbyx3b0JXipYMiDaG55bRlU+XsDjJHj9c4IyaJgnLDozw6QkcQ/+UYLqgnt772hLzoXBQ9cmz3ZxbkKQq4LfpBaCbsNKhFHUrsRjCd4P8YNbYw2FwUJH2BKDIBsY5OLkCBhPziSMZX501OYZRbOzh60tVe05jvbWpMqMatSqDd/BWfCR65P2shUKZp+2P6MPxtbJrCVxLYyHAO4ZpRUg8s5Cc7uY1PYPjHTjDQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmnjvseB8bTB3S4md4pa9zy/uapqJ9cY4/yJ+TPhQlY=;
 b=nG2GHjT0EwkdSil41X2u+5Q/XzlNUiCdKXfRTP7ZWm6n2Ed6QOlTESprgK6rIaRhCGqzZ4SGpBkFWk5mENe+PCn8wcfgP97ABWpIbMbeufn7k4CNWrY6+9GMjnFUdVCyruEqhSj94Njf5r1BYeKGnwvt/b2HMcwfw6b8KwGRIqoecDmdJEVArydj1G0U6L+SPmo9fASZbH0LhNbj8g4mU9x4NBEIvyNFL47AAk+XuzNKf6OwK+JkbOSpQmJE/6mpmIKRJA3V4Izra1RaTHrF5u0C1DnF3fDpkDpkmdgJHHv0GaBO3+UprDToSDakAkhbQlZBMNF4lP7h7aoepxnqxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmnjvseB8bTB3S4md4pa9zy/uapqJ9cY4/yJ+TPhQlY=;
 b=IyTu4gJVXNVgtTwWAPx/yPyziUjs6Q86ona/6RL8fWDSDGYGl3VRuz1muR1y2dR/AnSVtopNW9vyQdRI1CF+TUjaiF3jdD1C17epR8Xed169EiqSHD3k9LIub812a93N+HVzI3f5Z9qtNnXB5sqcof6bsxYsWE3ukkIzDP5v1Js=
Received: from BN9PR03CA0495.namprd03.prod.outlook.com (2603:10b6:408:130::20)
 by SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 08:12:28 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::a3) by BN9PR03CA0495.outlook.office365.com
 (2603:10b6:408:130::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 08:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 08:12:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 03:12:23 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 03:12:22 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC PATCH 07/13] cxl: add functions for exclusive access to endpoint port topology
Date: Thu, 16 May 2024 09:11:56 +0100
Message-ID: <20240516081202.27023-8-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240516081202.27023-1-alucerop@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 40de3214-9247-4957-4baa-08dc757fed68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y7qN0+16Alv+6EkOqGHC4KBl2Wh2xJnkgje8RjqilDgPrPQ/FCEe+DhM0h7J?=
 =?us-ascii?Q?+RL5iWcYSTNIhZ7zX+MpSwoi/ivzIEAvQ2YqGkXITAprVv6jP5TZizUYCqRE?=
 =?us-ascii?Q?vTUS2RGrtCpnDNq0FNqLbOLhZ16gLpmd+dXsONNRA0yKVjByAyPNCvceFnw9?=
 =?us-ascii?Q?5L5t6/RF79YWVaMBl0kXPbS5Nzu6w19MYVKg7PynX3Bqpj6lUrymD9qaxXnY?=
 =?us-ascii?Q?fYq2XeN0SJXE0TuOvRuJW8JVGqS/aYwU19OgRAoVAl3UGdnGrBoe7FxtIO1z?=
 =?us-ascii?Q?wyYGhnUIhDmuTgvo7QAbVOWoHw1vMR56CBHCEoGgw8dORfJQp4vlXdZv5GzS?=
 =?us-ascii?Q?5nSHRNIU2qgIZwSr3F63RDgkImU2wlXHcxb0bhm6miynpwv3PNC17OHIi9hV?=
 =?us-ascii?Q?mK0Kfi6czznnTEq/QxPCzGfAfCk/aV+2BkKFKQ/8zQBJ7cdsGTutTsVznUJK?=
 =?us-ascii?Q?jogJpzt6k9YkF05a6jxxVKQRWQcoQkz4UmjJQbCIwebWp6YWskjN/gbCBnEw?=
 =?us-ascii?Q?mEW2q2v158C0mcuMp3bVyv/9TL1Yis0+035vYP3ViHxh17eLLK7WLXnAt6i3?=
 =?us-ascii?Q?cXX/n6SXu6wRJSMEM6IjuHftTm4FWFXkAFpVwabsImQNKY9ihVUJ9oe/DJ/x?=
 =?us-ascii?Q?X9TQWMnZgYIPVPfDpbhvw427pOYNFk87VaMrYfSEgMAxJBeyuTKgqtmLoh0v?=
 =?us-ascii?Q?S/5rsARgP3RrQ3H0ve/Pv3Zzs/A7HjDWBb7bLWDS4vxSO98cZAGUgr5qG9Qw?=
 =?us-ascii?Q?Hq4StN5PWaowyLQz/s1MigP/bEYVm6VQvoQEk6Jlju5B+xcbuIaX1Dg1FBIY?=
 =?us-ascii?Q?72NaN5S9R0M8ssFoRgTWy1i4J3OzhXOMKDXUjkNGXehw7knrQ1wTC/sjrdRo?=
 =?us-ascii?Q?sRqGute0hA5m8VzrwAk+xfprcrRco4nZnhjKVAj1XB5dLpNCZytC5wsOZjVR?=
 =?us-ascii?Q?ijVZraC4x5t+HEP4HpAjsXnmqdwSNOYmyyUGa6PfW9CEw8dZ4a2AHj/p/AoX?=
 =?us-ascii?Q?rsP2aOaiS8StBEN2BXtLh/s1pqJ1wyTPg7pzjGusmnxcmK2toZHDFwqyhaKL?=
 =?us-ascii?Q?eEQa+zIZnjTz8WSOECY4N20cPlmnk/to7tcQhi/TypCFCgsskv3LKjgBsLIS?=
 =?us-ascii?Q?zpQBN2iTIMC8p7ioFXD9Z3EZqZWa3UGtbMCRhhdxVMa6QERkbMOX3cPgRk1t?=
 =?us-ascii?Q?9J9UpNt6/F2Z4X8izaqLWE6UEwaxKBPHOPSRPQbbAZuo/lJoXu0lZwJ+Nuju?=
 =?us-ascii?Q?68IzItyykHDHoCoU4DD5K5bsPqKHQLe//eD60Xu2743DV4S3bU4wQJZBorCn?=
 =?us-ascii?Q?nNE6oEuXnDzZNujA5pchUsytiLgXXuq9sx9y01puP4EGRUjzks15UjC1I/1Y?=
 =?us-ascii?Q?i48DE/qB+FlrKnegexJd3BQ8Hogf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:12:28.3630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40de3214-9247-4957-4baa-08dc757fed68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274

From: Alejandro Lucero <alucerop@amd.com>

Prevent concurrent access to endpoint port topology.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c           | 41 +++++++++++++++++++++++++++++
 include/linux/cxlmem.h              |  4 +++
 tools/testing/cxl/type2/pci_type2.c |  9 +++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 27063cd4ea73..16e356ef5b6d 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1124,6 +1124,47 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
 
+/*
+ * Try to get a locked reference on a memdev's CXL port topology
+ * connection. Be careful to observe when cxl_mem_probe() has deposited
+ * a probe deferral awaiting the arrival of the CXL root driver
+*/
+struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint;
+	int rc = -ENXIO;
+
+	device_lock(&cxlmd->dev);
+	endpoint = cxlmd->endpoint;
+	if (!endpoint)
+		goto err;
+
+	if (IS_ERR(endpoint)) {
+		rc = PTR_ERR(endpoint);
+		goto err;
+	}
+
+	device_lock(&endpoint->dev);
+	if (!endpoint->dev.driver)
+		goto err_endpoint;
+
+	return endpoint;
+
+err_endpoint:
+	device_unlock(&endpoint->dev);
+err:
+	device_unlock(&cxlmd->dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
+
+void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
+{
+	device_unlock(&endpoint->dev);
+	device_unlock(&cxlmd->dev);
+}
+EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
+
 static void sanitize_teardown_notifier(void *data)
 {
 	struct cxl_memdev_state *mds = data;
diff --git a/include/linux/cxlmem.h b/include/linux/cxlmem.h
index e8d12b543db1..11fe8367b046 100644
--- a/include/linux/cxlmem.h
+++ b/include/linux/cxlmem.h
@@ -88,6 +88,10 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds);
+
+struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
+void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
+
 int devm_cxl_sanitize_setup_notifier(struct device *host,
 				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
index f157139b712f..948cc95c5780 100644
--- a/tools/testing/cxl/type2/pci_type2.c
+++ b/tools/testing/cxl/type2/pci_type2.c
@@ -6,6 +6,7 @@
 
 struct cxl_dev_state *cxlds;
 struct cxl_memdev *cxlmd;
+struct cxl_port *endpoint;
 
 #define CXL_TYPE2_MEM_SIZE   (1024*1024*256)
 
@@ -72,6 +73,14 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	endpoint = cxl_acquire_endpoint(cxlmd);
+	if (IS_ERR(endpoint)) {
+		dev_dbg(&pci_dev->dev, "cxl_acquire_endpoint failed\n");
+		return PTR_ERR(endpoint);
+	}
+
+	cxl_release_endpoint(cxlmd, endpoint);
+
 	return 0;
 }
 
-- 
2.17.1

