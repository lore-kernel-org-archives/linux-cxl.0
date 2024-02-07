Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615D21426E
	for <linux-cxl@vger.kernel.org>; Wed,  7 Feb 2024 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302236; cv=fail; b=QfNVqHKcx3t0q/YxtGsdZfdFmZXlm2kS3kZJab+gc3HVSnY0rMC5yzCTf/UqdMAaV3tlt7e5qkMlCgG/gssc0ARgkE7aZMJAbgU/DBaxrzLpGByEuFNZx/Cnhy9hO9NtJ9aiANcmQO2s8fFwV04QLb2PoQdNK1p7PKL6b1bPJA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302236; c=relaxed/simple;
	bh=kGqNwtvKf7Doatid4LP/6XdM599C+FQsg+Fn2uvj8Xs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X1ElQOZkVtxHsOpEx5UkA/J5NNjG6xgnDiN7RdlF5rsTl+EwD5wyv+poDKrFtBNWypyf/E0Aikpr5pQlSUjaOczCYr8xA+BOy+kzNn6/VBxIWKC+RhrbpojRBNb1ZHleAzrpaYuc8SE4B6WQ8M2ypRe9J5+EU5sFAkFeMT+BQ0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=qp138m44; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="qp138m44"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWdvkwLsnsh4uvtthsqUVa+lxx5MZo6w0tVYfrEQ82HjRtCmmyMBjoL4haU7pqyee2Hsg8sTSt5QMVgMQnQWsdWx0EAk5S5Ezdus9IQXZPjGzXfb8KJYokFZkiqWdjMmQsXZANdYLOxtyTig2rGD+nEgxE/G4ulg3NmHQkH4MujE36ZNxYiRrozAo2IWvJBqLSginyoP9hCIiQe9SBdr+Z5JN9t+gyKEfAfTU6rN8J4S0E+d1ZurqV/S2KprNOrECBEOy6qG/Ksj7LFPlRZ6t6n9Pl7k3M69++fEy8XdaWmkiwCr9MQbsPZgM0UM1LUrJP6bZrh5MUJDSESD6UFVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgbkdJYZ+/arm6NgqwuC1BzrXJc7sq+ju/SYSBOpeFI=;
 b=I9wPq7lvMX6fVKQAt/pA3nZ2/8sFmCYoKel7bJ142uz+vlbZPSlV2jm2kFJ2x1aOvYHkND9YKn/Csmf7QjnervUDIMRC371uXTipikfW7OujeK5ufpWUuDvvIqeBMSPMeMxt9EtQtevFBMAAwl8cP3f2vBlYZWkAkeAIbTtKj2Zgh4K0v6lCKloAcJESr4Er3MvG95SxASDN9uzGS1u2dCjsbH8151yzZyxAwpfDyf2xaqxcspd0byfBz0It0DBeYrNoXkI6eZQ6Umc4/If69eIUBgy38uC/C2rNP+APdCb3GQZlhluHQZ50hTOknPWGgUSgsu0iSzr9KGsacvI0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgbkdJYZ+/arm6NgqwuC1BzrXJc7sq+ju/SYSBOpeFI=;
 b=qp138m44EJ56q+dPxW4Mx93nTPPNsOkAEbTSJqXuXuWonSIWrCUI3iEOGQdxv5+wn0BcxJ+zSg9O7VFGDMpvQWhihbIDN2zoLCpb8X7F5bqTag9BMHmVoyKf3QIuencpMhTwdzqiGuv05/3pEw6LjSWUCBt1X35ITQ4DQCZzqKLUh/GtEwjbltJpiqrMPvLYS56u0vasNd0X0ET3Kr/y2S4mdvMsnsz61AAJ9myvjvrxThTgkJj8Lv4tP1ewNoivM/wXI0fUdygY1ETM4w8eQT85iJxnbVKf3AbpVxsbyMwFlUtkkgYSSM2ho8XxRqMArJ/6BhtRc04CebqRp3U9OQ==
Received: from CY8PR11CA0039.namprd11.prod.outlook.com (2603:10b6:930:4a::27)
 by SA1PR08MB8365.namprd08.prod.outlook.com (2603:10b6:806:331::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Wed, 7 Feb
 2024 10:37:09 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:4a:cafe::78) by CY8PR11CA0039.outlook.office365.com
 (2603:10b6:930:4a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Wed, 7 Feb 2024 10:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 10:37:09 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 7 Feb
 2024 03:37:07 -0700
Received: from micron.com (10.68.133.96) by RestrictedRelay36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28 via Frontend
 Transport; Wed, 7 Feb 2024 03:37:04 -0700
From: <sthanneeru.opensrc@micron.com>
To: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
	<sthanneeru.opensrc@micron.com>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<john@jagalactic.com>, <emirakhur@micron.com>, <ajayjoshi@micron.com>,
	<Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>
Subject: [PATCH] cxl/mbox: Add Get Log Capabilities, Clear Log and Get Supported Logs Sub-List commands
Date: Wed, 7 Feb 2024 16:06:34 +0530
Message-ID: <20240207103634.199-1-sthanneeru.opensrc@micron.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SA1PR08MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: ed42a200-751f-4e59-7b20-08dc27c8bcc9
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7fxZDp21KizugKHbj/jwssMDsaDlGAuqSrtgImxUm0sfNTnUCvU8whQ8KU5Ui2P7VAP+SmF99/tsrEDC5c24u+Clw9ldQlkTAz+3DDInenl2qfuFt6qd5U+qKMIVAtU4MX23jK66DWooJyXdq8dN/YgwzaZc06FX/S0De25VBSLN9nXp7KOHPV/DyjwNa3pvgEBg3iKv6NZ6Ei5m/yyvrFHg62nXzIG0rLl8LrciO+ysg7jqp0oiezSH5qQL3TaECKpPdLNSOWKatNgKOnqe8009yupEEG3dkV8kRGqaq3eI7+px0ldM2LNNvi8TGMmwt5OM4UqC7ytJfbVBvGOHUm1jCc0ge4Dav6mZn99CLYVcyBPsOXfRFvG4MNEIFBC7/UZ9ae3ChcHCJ7QUO0Hn2rKxwxG20ZuhpyAV66/0WLI70ldMn+HI7rGS6AFnH2PwYBU6Rj2sBAcBob+dv/cnMZIo5INda/+vtrBXIXaAgaxQpsW0ZSLCnt5DxGeJGxwEYwXpAl7KdoqVfrCGxiCktLsHmUNXTZYo+OlWvoOD+j5Xe+GtIpLelA8BiWcYM+WPTXVRzBvtdV67rkQn6wBayGqb4ByUqqrYcTCeUejsJlyJLPrwDhai2gKWYiS2kue7K7ewi1lX40qsIPH8hYuZqyJgnMcFL66dsd9rjF2VVQ/ynUhoD3qIMAazI8+rLe2CuJci5B5zDG2dj0s0L1su1lk4Xr09zibu99sZRNFlCOXnOrcRsGlWAG3ajskghVxtboKP+HSxYeOb5psDGEm2pQ==
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(41300700001)(54906003)(36756003)(70586007)(70206006)(110136005)(7696005)(478600001)(6666004)(316002)(8936002)(82740400003)(8676002)(4326008)(36860700001)(7636003)(356005)(426003)(336012)(6286002)(26005)(86362001)(1076003)(2616005)(107886003)(47076005)(5660300002)(2876002)(2906002)(7049001)(55016003)(40480700001)(40460700003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 10:37:09.3093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed42a200-751f-4e59-7b20-08dc27c8bcc9
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB8365

From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

Adding UAPI support for
1. CXL r3.1 8.2.9.5.3 Get Log Capabilities.
2. CXL r3.1 8.2.9.5.4 Clear Log commands.
3. CXL r3.1 8.2.9.5.6 Get Supported Logs Sub-List.

Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
---
 drivers/cxl/core/mbox.c      | 3 +++
 drivers/cxl/cxlmem.h         | 3 +++
 include/uapi/linux/cxl_mem.h | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 27166a411705..64a44e286488 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -64,6 +64,9 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
 	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
+	CXL_CMD(GET_LOG_CAPS, 0x10, 0x4, 0),
+	CXL_CMD(CLEAR_LOG, 0x10, 0, 0),
+	CXL_CMD(GET_LOG_SUBLIST, 0x2, CXL_VARIABLE_PAYLOAD, 0),
 };
 
 /*
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5303d6942b88..4128c810051c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -529,6 +529,9 @@ enum cxl_opcode {
 	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
+	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
+	CXL_MBOX_OP_CLEAR_LOG		= 0x0403,
+	CXL_MBOX_OP_GET_LOG_SUBLIST     = 0x0405,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 42066f4eb890..d2df9782a5ef 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -47,6 +47,9 @@
 	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
 	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
 	___C(GET_TIMESTAMP, "Get Timestamp"),                             \
+	___C(GET_LOG_CAPS, "Get Log Capabilities"),			  \
+	___C(CLEAR_LOG, "Clear Log"),					  \
+	___C(GET_LOG_SUBLIST, "Get Log Sublist"),			  \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.43.0

