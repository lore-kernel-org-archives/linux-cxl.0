Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013068.outbound.protection.outlook.com [40.107.44.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1692D3A63;
	Mon, 11 Aug 2025 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915134; cv=fail; b=iTC2AfTuA1cGc3/UUN08KCn5ieSxPs2snEVySOFxDIc2kNtjN21xVUknAqUINKMNsqti2WJokronWS/wP9lCrG4eD8GoKm4Clf0eoCre1Nj9IbI2CQuCar+58f7AN4UZIXcfO6WYE7wVJ5nfDMxRfEgbic0CS63BQii02pymf9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915134; c=relaxed/simple;
	bh=PFC00rWORgInl0rO+i6xaWcBmJRtd/GKUE589vWJbiA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D2B6pr0iXvoHkTd/dwE/jYExKi2tqxTlZc+sr0zTsF6YtB4uY37eZQRJwI3DwAL786gIGY+Y6KPG/gh3c3j7E0sfHJOiVUTl2bYhWmGXbXmbdpNxyg37uadpufUU6P9oZy46foBJqvSf2eP68cQpKqGvHGEw9BBIqT1tkf2EFVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ENaGkSBF; arc=fail smtp.client-ip=40.107.44.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ENaGkSBF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GinTWjvCmUqO4mH/4jp6VWj9jM8K+Ex+YYwnz9J+B8RNU9bX9Kd1xpurgERkVgmbEJZC/IcUgynPl7ULpVuQo62GWbTet8IzC1h+FMj7Vv70k0+yLo2D9HykyUEKPO4dqNu9R9bjFG5j6rYcVYGuuUKqWAkizLedUr8K27oB+jFt9PeYFZ3NIpH77l7UfKSgA4ea7L5yObQFembgLAMb53DCT1dHjcRf0iomy8bHTTIkXIb4ryXktO0cNqYbOU2mCW9orxot6353Jx6dhl91uflF3qqRQ2vKHlB3BRH6uwUc0pMlUs0nopQfd+6B6INVDImkOkqdNWgEXWBVwzxFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZpkpdyr6PyPmXDQWh+yXGa/bH/ZVjibCsMbWwMCkZU=;
 b=rOKs97yUwAf7x1EQlY8yt6xEdFKnUEh6bHgt7LZQTHuBxnEhWbRjr/ccnkS0aGvjOP9IXlxJ36bOxWvZ7wWWu6xiOPizC+3cyFXXaD1WfUrPXbAYbbqSsHl2+nVvbpczZqZ7NrMOqKGizGpyTu8MHeo68kx1Y0qKKPyi8sALOI1PXu58or61dNdg/fR+SHTeBiA5CszAjGfkGD46x5J85Q5qQ8AKGoSJmaNGX0S2hxYmL8bBGKlLkNND93JlCp9xOtZlF+zpNe3dCvBxe8q41Q97MAAp7vGS8U+ohau3xcZlPyNlnGSS0tNHDpsmRl7i7gv+s7vSuHryKmyKh3d/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZpkpdyr6PyPmXDQWh+yXGa/bH/ZVjibCsMbWwMCkZU=;
 b=ENaGkSBF+sXyjtFNiuI6WWQPmBN/IhVNT8DstEBj+qwxJUs8KxhqH6R0OvdFrv0KcTxEP01sbgnlF3QuQxrKra6v18FNuIo3UklM6PopphwdGnF6MNWrBoZ7w+gHo9hxjuA9NyItMuuip0YW6BPYicoai7lmsAKsDyEuLz1Jx/wW8YDZmVWzKVSVjoEWnW9wvYdzeBEdxJcRhQX+UQQVjd0Q6tfk2qPVGPL9RJ9nOEGxvNDRCN5ZM4qWgXnKSMaLlJjhxAiZdG+AoXYxOHyQICeiVLPL/djM48g8ZADLLh4Ar7MXiDkq2tkLSd6y7Y79sH7HopgTNb8M6iwxqXRVGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB7172.apcprd06.prod.outlook.com (2603:1096:405:b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 12:25:30 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:25:30 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] cxl/hdm: Use str_plural() to simplify the code
Date: Mon, 11 Aug 2025 20:25:19 +0800
Message-Id: <20250811122519.543554-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0120.jpnprd01.prod.outlook.com
 (2603:1096:405:4::36) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 1baeb316-6be7-4802-8b91-08ddd8d22924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o8Z5c3DP23Ftzp/S15I4NtlTyErUnpDHcFZ9+oygj1b80yLwdoh7u8Fu9tEs?=
 =?us-ascii?Q?5VmsaI8xnNxVDpipeTSWYjMs8OBkvWAcEovqmQbXju3im9p0KQx47mYxPdUF?=
 =?us-ascii?Q?8x0yDPX4/amdYJ9pxox8Fn9+lfN/VbzNbiCFYOa6YZap2mNHHct9+DwC6tcI?=
 =?us-ascii?Q?fI42QmNhPv3szTDBeXsexzS/nXQe8Qy331RtAjwDVR+Hdodm/jwCv1u+1Lyz?=
 =?us-ascii?Q?7swMKLzxKYd7pqvENHbDrVTxzYkMx54re9F+AywwRhC8GLsqT182IGVf98Lb?=
 =?us-ascii?Q?qUtQEafvb3P8oAf5ZQCanbzwfSQd7kNy7+EvMAEH3e9KAF8x3Ba9r+DP2+wd?=
 =?us-ascii?Q?bCASQ2ma/Ffat5NpgcXva6TVq3hoUYNz5hqxvQa5MzPsavfxwVEecJbK1QE9?=
 =?us-ascii?Q?9m9N+LuckTeFgcjbneij8KVVNF+xs0hZcJCAX/DMePsKS9hZi6mryg9exGMj?=
 =?us-ascii?Q?lgbrj9dGa79gYw51UlH3YZBy3VGXEbrC8lFwb3K/G5lVLFVTfcSuTBec046T?=
 =?us-ascii?Q?cRqVYbpfJvQmDqiAEqXqr08Cq+SsdKSJunkU0jdz/4K97Ca5sKCaAk15qq+s?=
 =?us-ascii?Q?u93OFKWbqG9k8/hN3vmMah1Lk9Zgn6Ls8jha3qZoY7ayTiLDr6TGHcFnce69?=
 =?us-ascii?Q?l4NFQiQ8TgP9TnIHr6ROd3IQpe4+RVvZb/ec7BVcc83NQVEDGsjag92ZF4P0?=
 =?us-ascii?Q?OOWIFjqyNn9xFsuz+JOM7PKgvPnlUfAmTZw7KsfBj3ky5y0ZqeB0XsSqQimU?=
 =?us-ascii?Q?pB+NNg1KwJTXkuDxwETMr1Z+VejKI34yKMJgwDALLSQzUyNOth6fuZsjRH6M?=
 =?us-ascii?Q?/iBaVPySXKislpOy/CD/J7b+wd4pen8g7nG43aG47ZoY6CgIddRDw/LIi2gQ?=
 =?us-ascii?Q?I/qEC8tZ8JwgavRzQRmyjC3lMObUD9fqFHP6DXS/VHKpzUYEqB0mc3lR0f9p?=
 =?us-ascii?Q?xN8fwWpPOLGemKbVbgt/bj7LKq9oGg0a2SSN5VNHRgLFAR1oa55FkQKvJ/R+?=
 =?us-ascii?Q?4bcOhd3lOZpjFIbuVpONu2zMsrS9o9mCBKEWP1bAgKquXixGowbwY9n3D2cv?=
 =?us-ascii?Q?g+qATd/eNfCUS3tDoie5L5VQrVJtpE8LArLuvXi+0fXB4hG3fMQhWUiBjT+8?=
 =?us-ascii?Q?PyXjk/zqOe7fiMLpD8Awe2cdGMqSGVD0OH/e2xXU8aPM1RsFzFIS2IoU8T5X?=
 =?us-ascii?Q?fZulInPHvR+E2wdTWk1j9r0YqrUaGFv9V1pFzIUBFiuygKgS9w/CeloTWlf1?=
 =?us-ascii?Q?DVDWETHnp42Oaef93DHq2e3MUkDvcSWy22mD9UayOZhURen6pnRZPzHTUY+2?=
 =?us-ascii?Q?LsNT9yo+1r3s1v/ZE9lc4BAJ49GiIdBJYJ4NiO5sWuTGu1rK3M2Chmh2i6HN?=
 =?us-ascii?Q?bAjCRUXcatm3YirH3Wls9C/JWmhXmNMtNF7SBw0enIdN/R41RjgrZhSm4HAD?=
 =?us-ascii?Q?5XPALyIRM63CAVWzriZ0e630ksH3a8rzaDdvebyKeHmfyWWsbqQEww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3akqx6cvM4/esFf6sBGBp+lBgAsu6gha0+a4z7wEVmUNbDig+Fr601J248ns?=
 =?us-ascii?Q?i7qAzsJYLhsXQAKjVpGws3bTptITmPSKH1POvBj0fASRUTmVplLOHW3QEF9G?=
 =?us-ascii?Q?/98dvtMdbOwwEkozPFrqFaoT0dmLH5zgJrrR4O9g7oONF9LoRUqIu25+XiB1?=
 =?us-ascii?Q?4vj7EZy8NXMcIO6tWa2eoT3S/V19IGt/O2TWw+vuxS4O+OPkDvSGM4uqdCjC?=
 =?us-ascii?Q?Xvk0YRLoaW6ej26c+9iEf6tQCSvfn1P8x1ERFtRGBZRKfI7k9eOSzI1rTwBp?=
 =?us-ascii?Q?3rJyIcDQD95bi8RZmoqy/nPjO6+nhc+23Rb4kdyqO0ACBzWfs9Asoi95D8Dw?=
 =?us-ascii?Q?2bmevvnRAl0ym+xZfAV91SnzWnxQeDmNSJlee67aegAUMhrMKfa+YRLsPrU3?=
 =?us-ascii?Q?LY5Qn9UgXpck7QHbiO8cVj7cZ0tNz3BmeNsw3mZi41EgO2TYv68groB7F+iR?=
 =?us-ascii?Q?JYIpBAonFgevgoHA2obkJBMSYIespYAGi3kB1xgpVA/8StBciQilAO/iJhPC?=
 =?us-ascii?Q?lZ1dy1Uop+7lg254INsZTdsDRO+AIseIdUxLXm4QCoKhl7cDhYAwJvjms9SI?=
 =?us-ascii?Q?Qr9zgUkbKaJUZPyydkLe8OQd+YjRPF5LgUGTV2Zbw7UmPiQy2C76q8fKmXtT?=
 =?us-ascii?Q?ZWT84lmsaztIepmwYloCBL+AUSMlno1k2bwVKcXHgpEajKScP8DrzRTwHFFD?=
 =?us-ascii?Q?Rs+724buT+oNPk4gAJrE+jcBbhJpM9WGHheSQAdk5GCKZ1rTt736OmM7owjX?=
 =?us-ascii?Q?1WHX3VtE6dVR6UBc9/WqWuNfUxFLKQpRgNIIaYIAuH1BvPX++ztNh/kg2rE9?=
 =?us-ascii?Q?zFNWRQA8qu81CfMZHS51bYVip03Vt/MaYrajsn5Ofd/esv+KHUFSZqsN3O09?=
 =?us-ascii?Q?cmKjikWUpM9zjRp9esbH0vSHwTK3l8x5FesfYL+72Wj45SDxjk/Gberc7mM5?=
 =?us-ascii?Q?Wn9yXXzo4Lcvr7VMxR9qbKzP55zrkWjW8UeisFIrFOUKqBzdeuodKAzLYGxc?=
 =?us-ascii?Q?wlKiVTuCD0bbRBeIRetzrWLZO1Y7aHhbNpGYdCNKXD0yPg7zbHyPhaJBkpLU?=
 =?us-ascii?Q?ZibsqKmjfPknYipRgFdxOlBrUkwNOXRke8l0bQBOA4/eFKgyPbPn5dZ5QPSY?=
 =?us-ascii?Q?aie6xDc6JXEU5DJn5w9JhaGgzjrraIcVHwvLJpqVo0jUevqytvbZs8UVbfk+?=
 =?us-ascii?Q?KF0etHGMv3h7xYsWqmB0KXQ7b2o8XWD9a7josT/+4WiyRDtOrod+aJKDV2x9?=
 =?us-ascii?Q?vVrH0Az9mNBNdlglAM4njDDDaEMto5bKd4oObpUZMXDQuOW9zP7vLinCGrKZ?=
 =?us-ascii?Q?flGGBRJTjbPevVv3F1xzI4pgbqTN23pQD+3CarzpJPGH1migG/s1XbW5oGrx?=
 =?us-ascii?Q?ATlcsMo84b8zfpgYhM6cqOLpzs6iqjgnJWO/Q0oGJxBAjEQ38Pr9uROQaAty?=
 =?us-ascii?Q?6+EFek8wSJTmZo/yGz46CcrA2LWPkotQDGURrXXgAF+8qAfJU75b+QY03IWH?=
 =?us-ascii?Q?DqiaoC29FEd/o8DQr3Q5rTjjUhbVMlDb8IzkwxBkXn1anvqovtLUxWdFwmWT?=
 =?us-ascii?Q?8ClfqJ7B0q/wfZ3GS+7xv7AJfKNFgZclADhLxNYn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1baeb316-6be7-4802-8b91-08ddd8d22924
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:25:30.4159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIMaAhjqV0fslqHR9FRKVcgo8ZTq+aMzh/TGEJN+eLfyXSciEUg7MQwEAZaNEoMKf3weg8FCOBxM32UFUQrmZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7172

Use the string choice helper function str_plural() to simplify the code.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/cxl/core/hdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index e9e1d555cec6..37176c0a781f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -197,7 +197,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 	 */
 	if (should_emulate_decoders(info)) {
 		dev_dbg(dev, "Fallback map %d range register%s\n", info->ranges,
-			info->ranges > 1 ? "s" : "");
+			str_plural(info->ranges));
 		cxlhdm->decoder_count = info->ranges;
 	}
 
-- 
2.34.1

