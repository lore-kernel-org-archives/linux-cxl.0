Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05728851F;
	Wed, 26 Aug 2026 01:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708734; cv=fail; b=O/lV0/xcIOHF660HcAWg7zmuGX+5vrsGKeRL3O1ZHqpTjt3qbicsXeLT3HZpUxrFNF+2wTDeWERXfAHfdijGhqamvQl1dAXcHDw8RPH3xzgp0Y85kbl9ePAJnP5QGI7dPZ0JwsqV0MHaDRCCT0RiLUAUdpuTiYuoj4DDvDr49zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708734; c=relaxed/simple;
	bh=BVHR0ufqrKrSKizVnep+oJsuiGwJAHGQmYpy1ObZEGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j/tg06LeJ+zoFUlHwI3xHZRnafu+zwViTArM5CdvvkwSCs57Lqhu6a8kJ5N7RsvCtUuuIIvSFZo03lRtIbxfmIjYwmcviOD/Q2cPY335JADaA4IflWiP+bSEUJZuKZKHfpa7Gb6rZdEPkLeDVrG0lRRaWXxzRd2gmiPwo1d36cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PSel6t0/; arc=fail smtp.client-ip=52.101.48.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PSel6t0/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIINtyv4+8jcrc273QERpKSq0HSxFD3jSZUkiQ68vufavXEczW8Q5YDHDnwJAA/UGeob3eKjSHjX62hO/jdWSgi6kF8s8lCvP7yhn3AOgBEsuxcnvxydloS6K90kCMOu1dFG90scl1xDil+nfj/9Gnk+DXDoxXC3Tk1fYCWlLJk/MqpmimpIU2n4/722G1aJiGPCpvn6Wj0XSSRicfFT8PNhtesCGSk5jK/l2Aq33AWmcpHy1qVKsbT1RCK/1gRUfYCF3xw0hSCQlnH95wIGitOXwoUrwo6BxBNlRQLaFkXSoUfTJaDaPkKz8AXRTTw3i0rrRDRkkfax74c0LYA/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPX0hP0cTHccGMcHn8PQ0Bo8SsfahFdlJ3t+MPc9+rs=;
 b=MyrRFi7DuuJw+ufOrL0e/DyCToE/J6n7lu7F0/Cy2XHmLMBPblOEHyTTFa7leA9Gx74T+wNMxWpLx+VlJAFHH+vBlU80YYpMg5fAlGi8ugTn9BEMz+00WndKV4GpwsLEYYrvMqq4YzV/NbWGSPJmVbM8zSJBepHRsPwe+39XlnqX3M9zBPPtuv0QLtB60bdw/f27w7zkodNhoh5q2uDKCJlNUwmp0OFzz91jM5tIB8bbVHIs7s+nS6Mo6ZlgW2lI2XPN5hJ4qowAXs5pvZUgsxVRrwlSUk7BMrL3JZs0FeBogHx/VcaHw/SwV4K92Pz72cKU0mvsf5j0YNbfjQyvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPX0hP0cTHccGMcHn8PQ0Bo8SsfahFdlJ3t+MPc9+rs=;
 b=PSel6t0/aORLp8SG+aWvynpU8hbE8lq2ZCZmxAK+h1McY7sFGPt6vxmSrSzy/APFkH1KB3mXt0jHji/tq9kDrcLpwdjXb/OkHEq+Z0ZXHCZiM+XTdEc/QNXy/byS2wKO8ZYVxquP0p5W2+JU60kdTYH3Y38wdix5uEouG8EV2Tk8rDNhIyXXGcpnclSdbk0H5YjIw2GMKtavBb9W0lwr3lT5gdcas5h7qIrXHaY8pS4dF8IEf90KXB6rij9IzZS/rtcGEsQIG1npSe7waD6mTQQeK1EXIxsNPMAoTo0an8LGgZVkuz+ACrAnm7zce/NfSWKpbs/Y9/IQbW5ATDQjYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 01:45:29 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 01:45:29 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v6 1/7] cxl/features: Reject feature offset that overflows 16-bit field
Date: Wed, 26 Aug 2026 09:45:02 +0800
Message-ID: <20260826014508.9989-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260826014508.9989-1-icheng@nvidia.com>
References: <20260826014508.9989-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 981c2964-d2cf-4e9e-a198-08df0313b505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OPSP4f4gzq1W6CCs21FFzME5ePDMMHjdJK67sqAlKs3KbZ6ejRhaGDyFZwSqhToiYoP6apINz1AGOv3Ouo0EAck1MUOdE3y3znuHC50FsQK/kObPGCDcfLWN7C2UeuedD0TQTX3GYDiF/QjE4IR2L/0f52w3gNZLIDP7Vr3USy8qb6qQUsaRFV003kS3zE9IkK85GgGHblqNiYt6BxO20sy8GL/Nzc9v9j9olreSDma23MEzMDJZnTjRqhuJlK9FLB4VXNWjsJs6cvUJYzGu9lzvUhBC8C9ZXc5k+NUFt79kqDibFgIrq4ReMg3KYElsOmQZVZaJyyrRgwy/s05mAabRWbmpCQjtMg8qhVeLRrulIAVVe3DVUMRa6nEcTMlLwjcQhsSBrF1n2sYZLnctqAZCq6I6zPjdqrGHlSUrmxXPT656ZaSglPeUMl1FW6NGlH+D2c0HlPIVhLCO0RHPMPUeEucbBbZn0e0pEyYt5g6eXFLR8C+7mX0tojg7N4/cjB2qEHgyk65nSS+0/3ZjulqAqjIpvV1l6mzkwts34swubUBq6l+Lo0LuoHbtdCPd/L7iy3VQ4/fdz+1VnndsiJbcXgBFFC5TtQfP7Mg2Gxk9BE9ZBTI6Sxn8V6inpBJpcYjxshtW/PxY/ap8alw48Yzx0P4GuJjp1hUCqcRZJ8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6aIm6j80J/VsnysbDPR6Lhx++cc19irHAfhlohKkRFAoCfxwwfmO4eK7UtVK?=
 =?us-ascii?Q?iVbOy2vs8SOJBbbyE99tfvUocXFXd1OFAiUrBa3TaLyI4Snz6oG8cAbJ/xW1?=
 =?us-ascii?Q?xFF9icH2wxjG87EuETMY/jmDXRJUPcZLo3yiXReY+RcUnrFkxNxVdiNpruld?=
 =?us-ascii?Q?ngy0vDfM5cojayQB2t7GRVaLByEQCWtS+Qg7SMVjQYiQsp988eaUILVlMPU7?=
 =?us-ascii?Q?GcM+TREzaiqJPRci9+P+Y8rBSBRAy5rEFCsnL3899VCVdSf5arzRk+6j6V7q?=
 =?us-ascii?Q?IBO3nuiPUle3N6kDWVXzwLd4d5DioWmFcNgoi+jsZFMtVIVv0rtuuViztotp?=
 =?us-ascii?Q?xVah8xgyTqk11/c6zw2V7OwdZGfrSaJb9+rlBlKdkTJghZR2Um2QL3XQmn9c?=
 =?us-ascii?Q?vhm5osQvnjdx+WdxEqaneg7PnBSpYQqacdRXpjD5VSaTlId+MbZrkl0r53DN?=
 =?us-ascii?Q?Rr6mkKhOfpJKhPe6vRgn4kg3kpPIG/00jtKY8RTzLwlofqo2GLsHFan4L6JT?=
 =?us-ascii?Q?LFdYVZRf3JHHoUbpgLoKtpBY7qS8maqu1r0C8f0PySkPc6cRFnNeSqtWW7Km?=
 =?us-ascii?Q?bVst8D/IHP/kEkpTvajTYnGn6qIeBt4jtzwcjg6hvyia3oZka/H+bgf9mQ6U?=
 =?us-ascii?Q?/rQDvJEhP8udfZ46QcW92slV9+7eGN+7t4JKP39Jn0t8reOtv9MqiIfULdrD?=
 =?us-ascii?Q?q3jizoE1T6rwXygQAF4kdosGH+15G6L603p2XufQBN95Kalsvay1Yr7S8rvm?=
 =?us-ascii?Q?0bFeuYuWhzAbdh44+TUCUwZLKMB1r+8+m3qHTxsCcvOnEND7N4EL/Syhi/al?=
 =?us-ascii?Q?j+Rg9nc0OgZvAVy53ZVkf19rGoXob7ktU6bdoY3/mkCiHwM1nGDqME6dJ9/O?=
 =?us-ascii?Q?sPTmKwGTjp8TpKYPrn7BeN4Weycu2yTkA4L7pfM6B3Q0yz6yjHVYuHFiuuyu?=
 =?us-ascii?Q?AhP4Y1bIIqvhD6r9pNSSH45lLi3hu/5aTkFsvJu/rW/aDHhsBQ2E54+NT61Z?=
 =?us-ascii?Q?hcbTiU/pU0fLpnMuXnkvqnx/uUe3vxxwitszncebuA7HqsPfkAVBFWdZvpWF?=
 =?us-ascii?Q?WBHkowsUh6K+mMnhWI/t5/9pZi/3pozz4Bta8+ULzGi95BUpIJ5k837u6RRG?=
 =?us-ascii?Q?27OxOsNW9fI/+6juqdKBXufIagDi4kCUssgTXd+yMWmMbKmCilmGokCnVJBA?=
 =?us-ascii?Q?FvSODCiNAQG/UlrT2lpBvwtujsxBkw4KVoiLiekNQs8D67JDxEeD2sJu77Bt?=
 =?us-ascii?Q?o5ioroCLO4e8VSNeY7qHtWwDXwd9RWFwSccS+yZ8iQtZv5mDt0G9CBiteAt/?=
 =?us-ascii?Q?Divm7FZHKOM5UdTalAqob2EmFY9S7Xo24Ol0VF/xowHg1SXrX4JPLb6GE69t?=
 =?us-ascii?Q?A+Htu6+ZNOZ6jJHNLq6+N69XYNlbhD4AwvLKhRK8G0PDT480Tp48fcnJHByO?=
 =?us-ascii?Q?LFWy61Bv393xvs8nj7Td6iXeSp6u081r24UZfR4UJ0VJks9EOaWF4go/ce6e?=
 =?us-ascii?Q?j4CeicL9pBcdwzvY7fbPW9SKIT/kVOMF9NMK4YC4wqbPEe81nM/4tMbLQL9G?=
 =?us-ascii?Q?btDJoGzpAdENgCNYblcPmzXwji9xqiKiZeADATgNITs6w5musGgMI4ik0TFZ?=
 =?us-ascii?Q?JEP46sFAgP0DUi6BVTZCNwGXJA2yr6fOQauWj1X5It8/re5E4KH1F5FG1VcX?=
 =?us-ascii?Q?I6zyGSvg3G1EqHriaFwdygUrkCpuyopMm7Q/DPebsC01UT7bRonBdziyqHaI?=
 =?us-ascii?Q?lLV4ONbm3g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981c2964-d2cf-4e9e-a198-08df0313b505
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 01:45:29.2605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlOKy/hHa1NiycB2aUiYnkkTOPA47M/ozY/aGWkPk5bMRLNocRhwpUaPdFfc9Y6imX0Qn7Ly0Jm8Z9CgkTKW5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

cxl_get_feature() and cxl_set_feature() build each mailbox command's
offset from the starting offset plus the amount of data already
transferred, then store it in a 16-bit field. A user-controlled fwctl
offset and transfer size can exceed the feature extent, allowing a later
offset to be truncated by cpu_to_le16() and target the wrong feature
data.

Reject requests whose transfer size exceeds the remaining 16-bit feature
range. Express the check as "size > U16_MAX - offset" so the validation
itself cannot wrap on 32-bit systems.

Change cxl_get_feature() to return ssize_t so invalid input and mailbox
failures are reported as negative errno rather than being conflated with
a zero-byte result. Update the EDAC callers to handle negative results.
Keep fwctl behavior unchanged by translating helper failures to the same
header-only RPC response carrying the CXL mailbox return code.

Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/core.h     |  8 ++++----
 drivers/cxl/core/edac.c     | 20 +++++++++++++++-----
 drivers/cxl/core/features.c | 28 ++++++++++++++++++----------
 3 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 35eaf636adc9..bb380ec6daeb 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -217,10 +217,10 @@ int cxl_port_get_possible_dports(struct cxl_port *port);
 #ifdef CONFIG_CXL_FEATURES
 struct cxl_feat_entry *
 cxl_feature_info(struct cxl_features_state *cxlfs, const uuid_t *uuid);
-size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
-		       enum cxl_get_feat_selection selection,
-		       void *feat_out, size_t feat_out_size, u16 offset,
-		       u16 *return_code);
+ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
+			enum cxl_get_feat_selection selection,
+			void *feat_out, size_t feat_out_size, u16 offset,
+			u16 *return_code);
 int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u8 feat_version, const void *feat_data,
 		    size_t feat_data_size, u32 feat_flag, u16 offset,
diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index b321971fef58..f1df4b5cfe5b 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -78,7 +78,7 @@ static int cxl_mem_scrub_get_attrbs(struct cxl_mailbox *cxl_mbox, u8 *cap,
 				    u16 *cycle, u8 *flags, u8 *min_cycle)
 {
 	size_t rd_data_size = sizeof(struct cxl_scrub_rd_attrbs);
-	size_t data_size;
+	ssize_t data_size;
 	struct cxl_scrub_rd_attrbs *rd_attrbs __free(kfree) =
 		kzalloc(rd_data_size, GFP_KERNEL);
 	if (!rd_attrbs)
@@ -87,6 +87,8 @@ static int cxl_mem_scrub_get_attrbs(struct cxl_mailbox *cxl_mbox, u8 *cap,
 	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
 				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
 				    rd_data_size, 0, NULL);
+	if (data_size < 0)
+		return data_size;
 	if (!data_size)
 		return -EIO;
 
@@ -551,7 +553,7 @@ static int cxl_mem_ecs_get_attrbs(struct device *dev,
 	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_ecs_fru_rd_attrbs *fru_rd_attrbs;
 	size_t rd_data_size;
-	size_t data_size;
+	ssize_t data_size;
 
 	rd_data_size = cxl_ecs_ctx->get_feat_size;
 
@@ -563,6 +565,8 @@ static int cxl_mem_ecs_get_attrbs(struct device *dev,
 	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
 				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
 				    rd_data_size, 0, NULL);
+	if (data_size < 0)
+		return data_size;
 	if (!data_size)
 		return -EIO;
 
@@ -583,7 +587,7 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev,
 	struct cxl_ecs_fru_wr_attrbs *fru_wr_attrbs;
 	size_t rd_data_size, wr_data_size;
 	u16 num_media_frus, count;
-	size_t data_size;
+	ssize_t data_size;
 
 	num_media_frus = cxl_ecs_ctx->num_media_frus;
 	rd_data_size = cxl_ecs_ctx->get_feat_size;
@@ -596,6 +600,8 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev,
 	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
 				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
 				    rd_data_size, 0, NULL);
+	if (data_size < 0)
+		return data_size;
 	if (!data_size)
 		return -EIO;
 
@@ -1264,7 +1270,7 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
 	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
 	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	u16 restriction_flags;
-	size_t data_size;
+	ssize_t data_size;
 	u16 return_code;
 	struct cxl_memdev_sparing_rd_attrbs *rd_attrbs __free(kfree) =
 		kzalloc(rd_data_size, GFP_KERNEL);
@@ -1274,6 +1280,8 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
 	data_size = cxl_get_feature(cxl_mbox, &cxl_sparing_ctx->repair_uuid,
 				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
 				    rd_data_size, 0, &return_code);
+	if (data_size < 0)
+		return data_size;
 	if (!data_size)
 		return -EIO;
 
@@ -1750,7 +1758,7 @@ static int cxl_mem_ppr_get_attrbs(struct cxl_ppr_context *cxl_ppr_ctx)
 	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
 	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	u16 restriction_flags;
-	size_t data_size;
+	ssize_t data_size;
 	u16 return_code;
 
 	struct cxl_memdev_ppr_rd_attrbs *rd_attrbs __free(kfree) =
@@ -1761,6 +1769,8 @@ static int cxl_mem_ppr_get_attrbs(struct cxl_ppr_context *cxl_ppr_ctx)
 	data_size = cxl_get_feature(cxl_mbox, &cxl_ppr_ctx->repair_uuid,
 				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
 				    rd_data_size, 0, &return_code);
+	if (data_size < 0)
+		return data_size;
 	if (!data_size)
 		return -EIO;
 
diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index ba6d2a5acb74..8d44ce829497 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -220,10 +220,10 @@ int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_features, "CXL");
 
-size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
-		       enum cxl_get_feat_selection selection,
-		       void *feat_out, size_t feat_out_size, u16 offset,
-		       u16 *return_code)
+ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
+			enum cxl_get_feat_selection selection,
+			void *feat_out, size_t feat_out_size, u16 offset,
+			u16 *return_code)
 {
 	size_t data_to_rd_size;
 	struct cxl_mbox_get_feat_in pi;
@@ -235,7 +235,10 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		*return_code = CXL_MBOX_CMD_RC_INPUT;
 
 	if (!feat_out || !feat_out_size)
-		return 0;
+		return -EINVAL;
+
+	if (feat_out_size > U16_MAX - offset)
+		return -EINVAL;
 
 	uuid_copy(&pi.uuid, feat_uuid);
 	pi.selection = selection;
@@ -259,7 +262,7 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		if (rc < 0 || !mbox_cmd.size_out) {
 			if (return_code)
 				*return_code = mbox_cmd.return_code;
-			return 0;
+			return rc < 0 ? rc : -EIO;
 		}
 		data_rcvd_size += mbox_cmd.size_out;
 	} while (data_rcvd_size < feat_out_size);
@@ -288,6 +291,9 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
 	if (return_code)
 		*return_code = CXL_MBOX_CMD_RC_INPUT;
 
+	if (feat_data_size > U16_MAX - offset)
+		return -EINVAL;
+
 	struct cxl_mbox_set_feat_in *pi __free(kfree) =
 			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
 	if (!pi)
@@ -462,6 +468,7 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
 	const struct cxl_mbox_get_feat_in *feat_in;
 	u16 offset, count, return_code;
 	size_t out_size = *out_len;
+	ssize_t data_size;
 
 	if (rpc_in->op_size != sizeof(*feat_in))
 		return ERR_PTR(-EINVAL);
@@ -482,16 +489,17 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
 	if (!rpc_out)
 		return ERR_PTR(-ENOMEM);
 
-	out_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
-				   feat_in->selection, rpc_out->payload,
-				   count, offset, &return_code);
+	data_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
+				    feat_in->selection, rpc_out->payload,
+				    count, offset, &return_code);
 	*out_len = sizeof(struct fwctl_rpc_cxl_out);
-	if (!out_size) {
+	if (data_size <= 0) {
 		rpc_out->size = 0;
 		rpc_out->retval = return_code;
 		return no_free_ptr(rpc_out);
 	}
 
+	out_size = data_size;
 	rpc_out->size = out_size;
 	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
 	*out_len += out_size;
-- 
2.43.0

