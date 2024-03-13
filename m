Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D285914A8C
	for <linux-cxl@vger.kernel.org>; Wed, 13 Mar 2024 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710313955; cv=fail; b=Sr5yLid+QwYtacjKrdPVbaEui+x6OtUH25DBjd/Ybsq3qBCKpiXgoI87uc9nBuLk6j+qX5on7JLBtFeoUyU354JYxKY/VHw3Bmd8wb1SD1ZWGRMHt/b8L/k4fBQzZsGS2JjqP6uYT2Z6vqEo4PcBGkX27KTYmQyWy11rJhQkGTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710313955; c=relaxed/simple;
	bh=tFFMRHIL/FMmElmf5tqgjfm+/do2kohrStotqcvC7G4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9wSAkf6TKe/Zo88A7FOQYZA2V6iia3as7GvduqVeVlkJ1324ANQAhKNjPDgdUAA4tXoBGSHxD0QdS69XxCtuHArM+bblneCFUiz+ZPtxXWv/hxHAk1Z0ttYmKO2XCiAAPUnM102gFgjVrgOBUIvVn1IYkoab8gxRW5uVu1VnBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=SpLLOXa2; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="SpLLOXa2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6ZX+PewTv55B/zw6y/hoGkN7c/jKAjfOLo1ixuFeDL9TtX+g906Pv5oIXJ9kXo0bjcPxBj/tirI+qW8eQpQH4iUogHpqYPmLZKLA8N+WhCO5S8KoLj3TpUvRe/Ae2cefzqmShdZ8kjZP9u8C9k0Ls8zf/1ChcpDhsWpIBIVA0lsPcMi4O8gkMbNFA2UrQxWwWa0jsenOx1QsfRNz7Tcq4h073bvRobjgEWx1Ct9C0rocCziErhYQghFwXuIzEdZbAk/RhwOFFHr/SxyWrIuEy43QFWjtu7p2OPMjvCUn1I5+CqPmbZzpPGAdSeRZmZqGB8N/duMsDaILsJv8ZPg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjjFhrkJwDPt0tiihP60jyoXPkykG5vKkMSLtl3ibMI=;
 b=H9CvGmrvinNIOFBQ4u71eJNxLoagG4gWReGIbbuf/aVUvhgWaaJq6Qp+TZ/9Weh7LwI1ISlN0pKAu4YSgzz8Coob4c84WB7BJKMUGkLbCLu9hZnTdfPar24OF2E5Ci6bi3zDyq2ds6fTUEtVC8tfvoLuBlmGP4EpXD6nHU2R9UF5twiEymUiBZMedO2mSsVURzeq6y7o5ROo5aafoMt7HQ4aZSztwJZly+HLT1QItpN1TaSxUv6zHeKYJpkLQJuR4YsUKxgWEIGYvbh6Lvp7XD8oG3lfxiqO+kgIKMVjSp8myhO0UcGEfMOZFaVVF/gLVR7pjK1lqZbyCJgMY8YyEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjjFhrkJwDPt0tiihP60jyoXPkykG5vKkMSLtl3ibMI=;
 b=SpLLOXa2sOcbc0OJdWOmVUqrtgDAlldM8Sg2C9X/hgBqlDJzC/A75JzrRPmB7xlrjdmgCwJyaRUc787IgcCg9vGrIxq4pn3p7DkywdnPtPHR0RcC22pGsWkPF8cBAK3B+etf1vb8HYxS6MBQz3W3HL+3lw+RkCUzLYU3PLEmNrcEaFM8FcfCrct/kndFg393oe0bXG8WXM9ay5w08aZmHyX6jNisiLIZWQreIbSB1nU3NlkvA8lf8pZpyJS//gDZqjngI7/8zOYpdwdU04fsPJSAKCo04GAbXoLKWOkf10Vo8sz27HSetI6Tx9bB1DExFRkg6Lg7E+ddy6L4KhiSHA==
Received: from CH2PR02CA0001.namprd02.prod.outlook.com (2603:10b6:610:4e::11)
 by SA2PR08MB6666.namprd08.prod.outlook.com (2603:10b6:806:fa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 07:12:30 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:4e:cafe::c0) by CH2PR02CA0001.outlook.office365.com
 (2603:10b6:610:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Wed, 13 Mar 2024 07:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.0 via Frontend Transport; Wed, 13 Mar 2024 07:12:29 +0000
Received: from BOW17EX19A.micron.com (137.201.21.218) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 13 Mar
 2024 01:12:27 -0600
Received: from micron.com (10.68.136.12) by RestrictedRelay17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28 via Frontend
 Transport; Wed, 13 Mar 2024 01:12:24 -0600
From: <sthanneeru.opensrc@micron.com>
To: <linux-cxl@vger.kernel.org>, <sthanneeru.opensrc@micron.com>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<john@jagalactic.com>, <emirakhur@micron.com>, <ajayjoshi@micron.com>,
	<Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>
Subject: [PATCH v3 1/2] cxl/mbox: Add Get Log Capabilities and Get Supported Logs Sub-List commands
Date: Wed, 13 Mar 2024 12:42:17 +0530
Message-ID: <20240313071218.729-2-sthanneeru.opensrc@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313071218.729-1-sthanneeru.opensrc@micron.com>
References: <20240313071218.729-1-sthanneeru.opensrc@micron.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|SA2PR08MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3179af-b471-4cd5-d7d0-08dc432cf21c
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YUkJ2hASK+BeOtN6j5Q7SLU4ZqBu7oApDoYYHesqquzRYVp0sanSEQQJFp0O121FEoYUkGZTpKtiFVksrJc3OAmfEZIzjsfYQspF9gvlVmm2d6BiB6LGiBQxjs2Hv08ThfL+zOlQa4+PX2B6xQek3bqNloQcbxFswQvtujRF7fJr9NaST3fVRM0T0Bi65EydLE991StbU4YoalGfE/ZzIHWYErSlPciaofueT2FmHslrBslKPrfk3yZU4uYBAsOWhdb3MXTR4USddrJxbb9Dlc5tkzlN9UTphODYtANK+f1mnE/Q895eQ8dteMELnfysoKpzA/oMFt8pFpYGgXdV+Rf/0/0qaLY23Lg7PiReFup/dxB4HR0ZlUKH5eTjG4kGTI9zOgjKMewZoT7/OGGH18qjAIHLrDyrvtzFXGfHkevL8xykt+yyUWiv0JiivRtDEzjFJXLg9A91CgS7GeWADYdz0aT1Nsq7AyDg8MtgS1iNkTLBJH6BfFVdtu6rmTG8vpEwLA9ldzXwpKh0FAyhRhUegYxHNJs8YUndKzIUUd+Lbs90/2Jls1/DquJZU+Ntfve5fm6C7YWqEA3H0c9hCUE1vRe4Xns224xbQXzIjKM11wCxGLYw2VgQvhWimv6AMxOC5D2MqfG6q74aW6NIF+A7shqVP10otlxQJmcC7ukL7wyvy8Cum/E2dOBdv6mWkP7pUZUlvpHZRzocjxOpsb+xEa2NrUUjrKPxjYPaWbxCkplJ/NzlOHa8aWpdQfx+
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 07:12:29.7960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3179af-b471-4cd5-d7d0-08dc432cf21c
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6666

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

