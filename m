Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B981552E9
	for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622663; cv=fail; b=u6ODVa2a0T6ZhcYLycp2itfRpXdhPhA1Ws2EbrpbQEnCEhy0HdxinXlZXwi9YuCHn5iItnn8mDk1rLLdf6fzjVP65fdtuHVHh/kwqr5f0Wa9bMzaKGG62kNldXBRntrQbOtbEPaGNd/34KNmU949d/EWI+tA+F5L2JhMIY7c3/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622663; c=relaxed/simple;
	bh=tFFMRHIL/FMmElmf5tqgjfm+/do2kohrStotqcvC7G4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9fjbKZx9vDVUyIcOUk2vUmdOUjUgPzcEnYkp0Udp852sDr6JQTFhrsl2xPGC9dCTMxThFtIM0GxF8rki2B1YU+rTGQ77Q9eVwpw3aVOIpBGQMmGpFjp8M76q6n/t/v4J3ijRWP6PFb8o463xpgARL0p8HYLAeZ34CsvRxGDzes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=l3/9EBNJ; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="l3/9EBNJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4W8hbO6gSRnr16mOBTzVuKRUpTzBLT2DFluPPSnNzhlIb8RnhErxZgRLB15eVqTXd9+gC2g+fG3HM9z5ch25mEOzMGVbPqwnH/TzZh4xLii2XqGBzSktjE4N6iQ019b7EIZNnCjn634GLYYFTlQ528TWI+fyKbrPFauZdcPgXkWlOff3J0lkA9IZdhT7au/UeQkmBN2Csfed/3rKO6TPLGTvB1XDkTf6V11se+Wa6nFYgxALFj91VaJvt351tnUfPZ0fF8QyJMwTvJ8FeSSQL1myTT38l7iJLF9U3OTn75imZbu9WVT89TH/hHRAmTr+UOSQd8DMbGzgRL6N+ESDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjjFhrkJwDPt0tiihP60jyoXPkykG5vKkMSLtl3ibMI=;
 b=BjKtnfdA//jIK4TuTwUVcJYwrGyKm0odlNwAqX4mgwUhvUuARqfl3amk+hP3+R4kAiXC5I3aSaBaymGkaQHqCa15u3ESf4SOnVu83frZRrImX9IPYYAmRLqLqrFsmvdSeVtzd4igW7OTfysqLIkuBWki6xrZqSrIxa5vLAol+ZFmAQfP0oztOJ8Q1DutHhMHDMQGnbIou+So2dMBH/Vm02OJfOzxuaqxCuFin6lYWTFzC3JyXmY2+s7Qn1mUEQIQRfyYxvREUXCe0WmdlA1RlHksCAMtIdiHDMfzqEIZmLMs9/K5Uzu7j0NDKkZbOM+3jzs/QPliBxO82FUCSUctKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjjFhrkJwDPt0tiihP60jyoXPkykG5vKkMSLtl3ibMI=;
 b=l3/9EBNJkCShtUFDuZt9c6VDlxExmnpf5vS0dn2J2WvOKdQb5jOIcflu+6ss3jWLa6UnO1qhNnmjYRU8wdu3uyRz4CZmdBn6SbR/Q/Dg+f/QzkteFSrvwdEeXtUcINRPhNZhV2JhGKTkpcRKBzf1BE9gXdP/QIFSYlc9EQAM6OlJQ+O5t3Ps0TABUSZrNDQl9WYS+f70AIndByx4F0fSCokJeaJsNC/FTMKehJlB64AUvgjRhB1n7vHNA4Uvj9PKD1+ga84N+rZgPzWTIN1q9eDHID1/cRbQj6XJkQUhF4a+hokjHNtULutiCRtKr/+CmAkLrvhNgz4HD/6hsGjPHw==
Received: from DS7PR03CA0209.namprd03.prod.outlook.com (2603:10b6:5:3b6::34)
 by PH0PR08MB7713.namprd08.prod.outlook.com (2603:10b6:510:f0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 17:24:12 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::75) by DS7PR03CA0209.outlook.office365.com
 (2603:10b6:5:3b6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 17:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 17:24:12 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 22 Feb
 2024 10:24:08 -0700
Received: from micron.com (10.3.107.163) by RestrictedRelay17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28 via Frontend
 Transport; Thu, 22 Feb 2024 10:24:05 -0700
From: <sthanneeru.opensrc@micron.com>
To: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
	<sthanneeru.opensrc@micron.com>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<john@jagalactic.com>, <emirakhur@micron.com>, <ajayjoshi@micron.com>,
	<Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>
Subject: [PATCH v2 1/2] cxl/mbox: Add Get Log Capabilities and Get Supported Logs Sub-List commands
Date: Thu, 22 Feb 2024 22:53:49 +0530
Message-ID: <20240222172350.512-2-sthanneeru.opensrc@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240222172350.512-1-sthanneeru.opensrc@micron.com>
References: <20240222172350.512-1-sthanneeru.opensrc@micron.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|PH0PR08MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f765c68-e6f8-4b81-747b-08dc33cb163e
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g487PRnBkbqNS1iUlAWoee3n33QJcf+cwS2Oua6YZ7OqoaRMLEaYAdGfJCje/gJhu37hkIHfeXgf6XCtS4wmGdCgITZwyrW8/GIt1jgEQrxiRETB+O74WbKXgZ2Um9+KsIWVd2Nr8jpl+u866ElA4lKgomOZHOI9WRXz84M/AdmFT7rwHOjzHfze+aZvUj81LvfUhK19tdA/apaqtByJq3J7SoVIE3zJylOSqmOY4PJe2cOLREpMHF/2rWv4NHfmMm54EHlO9tp5n4zs8K8UM1V0PZWQpbsnAwe2nbTp1fPvc6om56cxtqm3pYx52AtzpaepOH/ilmIMhwV7BWn1pwOCF3UHbaSETX12DxEous9zeCPgIHoP0YEKaKsTzO3+MPKs/FrvpvAEvgP7o3Sy26KUg5yTXP8IecuErd3c3Ote7uigJ9bm6HQuQr/xuNyrfIxxzxRKgwtJXxUteggj1gkzqKET3U6Az5WxvTfVDnmAFppH46AqJhcy5iPVQzODBZNlQRkgG6to1EqMyresAimqMXQPG2hcnh3oY1G7qcvWoPJ9Z3UPFAgmBtc8fCGC9HICyTsXWfHIr/lnsnD2oNV7gE+mvTZ6Z9fKkZRj6p/Lv1mfSj3C7N7/bpqZw2G/J97p8AoZdaAacUTXYIQ+S6JNSZs3mgezm3swuuB5vUA=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 17:24:12.3400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f765c68-e6f8-4b81-747b-08dc33cb163e
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB7713

From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

Adding UAPI support for
1. CXL r3.1 8.2.9.5.3 Get Log Capabilities.
2. CXL r3.1 8.2.9.5.6 Get Supported Logs Sub-List.

Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
---
 drivers/cxl/core/mbox.c      | 2 ++
 drivers/cxl/cxlmem.h         | 2 ++
 include/uapi/linux/cxl_mem.h | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 27166a411705..30bd8264292f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -56,6 +56,8 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
 	CXL_CMD(GET_HEALTH_INFO, 0, 0x12, 0),
 	CXL_CMD(GET_LOG, 0x18, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
+	CXL_CMD(GET_LOG_CAPS, 0x10, 0x4, 0),
+	CXL_CMD(GET_SUP_LOG_SUBLIST, 0x2, CXL_VARIABLE_PAYLOAD, 0),
 	CXL_CMD(SET_PARTITION_INFO, 0x0a, 0, 0),
 	CXL_CMD(SET_LSA, CXL_VARIABLE_PAYLOAD, 0, 0),
 	CXL_CMD(GET_ALERT_CONFIG, 0, 0x10, 0),
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5303d6942b88..671e46538baa 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -529,6 +529,8 @@ enum cxl_opcode {
 	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
+	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
+	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 42066f4eb890..49c25056c222 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -47,6 +47,8 @@
 	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
 	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
 	___C(GET_TIMESTAMP, "Get Timestamp"),                             \
+	___C(GET_LOG_CAPS, "Get Log Capabilities"),			  \
+	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.25.1

