Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B7432E64;
	Wed, 12 Aug 2026 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533698; cv=fail; b=ZuWTeH2F97szCDe4zuwWC7RoWpN7rpxvjpslb8MUO3hupqOlYTsSvCi1KhxWw31QJU8hpktwHEh+iDCkoO9LE5eP98nAXfE4KpdJxLCy9ycTJY6os8YuNVGkchqPq1Fcq6kFmH2MQvPew8QG+VAtxwGH/MPaYqpEikgGQ5Lfmko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533698; c=relaxed/simple;
	bh=aQtHP7Ze9GdkDxXl9K5JnPHmo+04QcH3/PQW65BMiBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gRk6oeh1Tih9MIFTxPzoqzvkYuZvfK2HWH7gYUYkaQrfWVZXwZrIHtvtqkaXtTAXKahnrHsKKDX8ni0Ef/rFnr4nSXHc5O0xMJUXgB6UVtd9ekoyWNazFD6wRiAaARTkek7lMsyb3ZKK0/kONf0tNJlxqAAJcG7bcpAZpKfSTrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lYOgf2x/; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lYOgf2x/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u16Z2FPZjRhKMzWrJjJ3qM1MaxxYAwv5M57gB/EKCHTUzcUPlxFeWY43y9agPmMA5cFpMC+jOzXXN7SUwPplqpfPQs5AprAFlj89D0EAdij9Lk2uCuUFcASQ6J65mV8gFZxCjvUtxzKlwddjs99M2iB6eZ6R0CfRlLIkydc0cu1xDLvKEjIQlW4qRARocFtZF6cpH3xl/+PpbKwjaZK9PBykMqSRtYePw+SvpMPy70WVf0XjUOj1pKLR/4HaKGzXlt+xKfm3I6YnUScDW/Z3WZh0wYL9CNz2vHj+MabmvxjCjEiMN4XA/i6kO7NIeSWeSZ+yHdumVB6OPad2d4rElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St0FiUt+ChylOJEPrekuFWzTORS87e7QXIfNU2Fyjbc=;
 b=PGTPJIpl5WrphjM0KV6VCOMZ4iXqK2O2vgTegzQP7mwLLIsPX18UhzTjdQgpzKim2DoAfsGZa/B1YEcX9ypAGxUsLA7WHq0b+jqeHz5IXZ9F6Ruli70A0GllqP6QUBLGKdTTIKXAfU5vuspXaHGqb9G3+Hj2smdc8jOyg9WSremsmf2/QkYpEc74Bh40DpGtM6XDmT1APbapcs4jQL3pKmNNCuEhwUkTqiQNnu+DU7O+HN6AmjvuYw+g+fgayDpVldcUiQ/lHF7MpKo/x/JkVjySYYWX0GM5vMBNhNjZQYNELQCDEOI5raq5soHb3sBiYuSCVTjEyA6DWtap5O4HnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St0FiUt+ChylOJEPrekuFWzTORS87e7QXIfNU2Fyjbc=;
 b=lYOgf2x/g8ubwEcx/avOgeVHJVPuIaPaCA8i03GZdcX5qPfnMazjSEox0+68dEsp0c6z2jFB56KivQIkIFRz2HJH3kEXwZNwYPNwXZNKOm3hGBHUp1dWjeTbY+pV45xyG8CVyAG2nsYGCMdbeqChYq3ffz3JMU2LfeNxcuZ3ncJQvk6wyar5UrnQ+7l6QYmsF/WDLj4GPcJigGWfqS8VZhFXrBLhbLWdS/5+MBOLZhqMDCkldCxw7LDDJhURGkNpN07u5Qp0QfjkN4xatvx7OPQW1iMYsRFGUU2zIaiLnf8XOOX2Q4aeiYgkwIc624n1hXjmnE7SK4kf3dzQ3f5Kag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 11:21:31 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 11:21:31 +0000
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
Subject: [PATCH v4 2/6] cxl/region: Scan all partitions for unmapped poison
Date: Wed, 12 Aug 2026 19:21:03 +0800
Message-ID: <20260812112107.56181-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812112107.56181-1-icheng@nvidia.com>
References: <20260812112107.56181-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:d10:2a::9) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 543bb877-1c5a-4905-3ccb-08def863dbb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	deizEeQb5uI+jlcLLY6GvqK1os4TXsxQILWaijmwJoeKkv3LglRe3oQHn4CPkhKtASrZeebSvJj1Q/6ZhihzzaZvhADelMb/xyC+3SnyDaye08Q46b/7PavKF13BXk6r8rwnZWcy20bgSmjGZ+Ab0eH9FQWYHnkl4FWaSSpDsxq78cYjrFDZEgMJAXuyhItcrO1l2oCCG5wVe6ji4S/0oDd2Qj2R41MJjjo4roEvWa8K6N/81Wt2lqrlVly5qdiiisXik2TqLTQN3gXb1l0fhERdQbMB6oOMmM8qvYwpVuEWr43KTT1qJdydqfWRC9Br+2CGF29/TlDk2iek2vpoxUIfk2C1DNxpDGBgog1sVM8ZAyiLrdX8Gd8s6ms1QVOK99etM5gaK6kU4bb/MOfnQ7vCPlG+l4T8U208BBeY/V9YAFKOmq15OxfERDz4He12NlvBuyWU+4QyMA2KuKhFG7HmIcTar8bbRRNdJ+cNIAGWNJsmbw2XZZArA+JrW0oHAtH6GW2KZNxSEFrKB1mQO9+cjIB9VJeJJQuuqz5hU0oz+2x06e3yGu7U9NuFjooQbp46hvOHlTgjyJdjFhNggMxKj2wdJjRrDBQZ6kTNAuwA5hegMWFUpGf/Xf8knwqMKIiKNz7dAMlPgqt8LkZAdSGrmDuPnIcGwZrpTOrRdBI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SgRccEqSDVnRsYfgauheFYuQBMRCZHbOyOeZiGWMafH210f057qCIZSnBDoH?=
 =?us-ascii?Q?3HMDXXOd1P9UGZgAq24HIpvt6TC86gn8mxD6e1Vgtg8vhjb8sUu0qJZQXnm2?=
 =?us-ascii?Q?HX+U3VIh68A5296Wov05sRitDM4LPU4Y0ertSrB45c7+yjxknFAMrrKVliIq?=
 =?us-ascii?Q?kCgckR66xS5ZvezaWDt6/IhxUSu+Z4NRJFX6FS98AbcIouaZxLaql+uPeP0U?=
 =?us-ascii?Q?y4zm8bLZaZ9E6OmBDh1pPURITo83QNQJ2Zltw86yDfbRLlrJNkMIa/LgL64s?=
 =?us-ascii?Q?aKxE/QtjEcFFuJZL1LuKli8hcln/ILGegTzgY/QRvILUiX8+3HswbAXZ/xY4?=
 =?us-ascii?Q?trRPSpdW7ASwvSSBZMN6wLw1/xoqTtHj1vudFoGG2QbqlFLvyxvlwKIooMPM?=
 =?us-ascii?Q?i5VesTaMfJhLv8CaPmTlIcxXPnupelgjFbBs/7VkPmt5EvonALt1wg3wwe4L?=
 =?us-ascii?Q?dqSdZivYsuYAVUZBDcJ08mk81Wg/dgcC75tbNJrZhTv5fZ3WajEbJnIt/Un1?=
 =?us-ascii?Q?KRu3XmkKozR33n6RXClgQ5JpiDldLCGYOmz0QnJqqIUTKGm6k2eWDajCjVk4?=
 =?us-ascii?Q?lFx6/sKQXITaHB7CbkwVmCpDUqORjGM3rDYiqMSmHk6c5mfoRtGctsJCTDil?=
 =?us-ascii?Q?ZTNhs6bOdyWSSQjjlfTEkDirEA8Gjzu32muGjWmB2jQ8YrZGIBoj6YJ4Ql9A?=
 =?us-ascii?Q?EhZcCx5CLPlbiDlubjvMpwMSkw/iSCOIAi2A6ZZYrNazXQCgXTLbV4GMN9zp?=
 =?us-ascii?Q?qpSS538A0r648gz30V1tfjlls7OEQvtswOp7IklfV5Dl1MP9xQXkOWEir+Mk?=
 =?us-ascii?Q?O0as0+iC3XtkYc7yfwG2WE6cLRzQSDfVhrAZJ+2hXO2ctn2cieRQDRDykK2W?=
 =?us-ascii?Q?o4H8ZIhcm/T0NaEoPDs/IvyJo28oWhP0o/UBIokfkw/i8pDU5C1+RqJpwMJF?=
 =?us-ascii?Q?5ftNjAUJa2cOwO1U/mo32cNbFwGvZ7sKhB2HkqbQJZhN/KTzegm08WZOCcwb?=
 =?us-ascii?Q?WiSPOHjPWHDCTh3BipAX1iSNZVA6NmEk7OAM/IofmkfcfV3GhG+ZVepcsekT?=
 =?us-ascii?Q?e8UICIElQ62VEvorO33iYKH3ZJtd7cFxf1nJx0XlEjPtL5gkTWdWpJxgChQ7?=
 =?us-ascii?Q?hCZZKE30H3X9xkTVVasiTWIsCH2kzj3UGv5LDyuEMllThvav/NP4O9jRCjCA?=
 =?us-ascii?Q?2PQ8HJ/QmEhlSPN7fp6kT3nwTz9gGg8B7kMnO82FFE+c9wg4KX08flzN1JkG?=
 =?us-ascii?Q?z/3xArj529CRFiA+DyBfqMZ4WJrvoQ6NlPDit0GtxmS2M1XmIuVr4YEWRMxy?=
 =?us-ascii?Q?ElwaJTD8oeia26NR84qvDRZbuHWiEIgnvmFT27HdvfgKQTV0KpLNTJUvLbqj?=
 =?us-ascii?Q?PqIsY1h5rE//ytZcwSn2Vm+Nc18WxVYvEubnNkClTisWT9xLhQqWEx/ZxVb8?=
 =?us-ascii?Q?ts0OKAfTQAlZiORLsvXD7G514E6oy27ifYY9PZLo6RPHs+PYxDZZf9u9CcRY?=
 =?us-ascii?Q?NhpAVEdY8na/3FpuNF0egtr+SZFc+zrzV8w18w8Owi/ayzXbyTzLT7EtGxnZ?=
 =?us-ascii?Q?izEQcKyAmLWXzlbQ2eA88xHGKVcnfi2680Gzw/9mTliweBcFQHV6Yk6OjTGK?=
 =?us-ascii?Q?W0FvfogV2SAvktG1vs9GsTMQL8myCrCAUH8QqGftPHpgMQprkJbQSddw9v7U?=
 =?us-ascii?Q?GYHlQfS5ZlQWsZfj8wZH6Po6kDAsLEC1cQ5TfZwWGiZuQSXB7xXtPQw8auBE?=
 =?us-ascii?Q?HtRTfX+ReQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543bb877-1c5a-4905-3ccb-08def863dbb4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 11:21:31.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcoz7wV7ODWDIffeMNF6mGY3bd0WWacnRwP9pC95W7FMAkzvIKSpkIOleqbfXpvuzcoJm8mFN3MqbvZRMrQKNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

cxl_get_poison_unmapped() sweeps the unmapped tail of each partition
from ctx->part onward. A fully-mapped partition has no unmapped tail,
it's a normal per-partition state, but the loop treated it with break,
aborting the whole sweep and silently skipping unmapped poison in all
later partition. Use continue so a fully-mapped partition is skipped and
later partitions are still scanned.

Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1->v2:
    - Tweak commit message
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..b03f30c04d35 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2928,7 +2928,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 			offset = res->start;
 		length = res->end - offset + 1;
 		if (!length)
-			break;
+			continue;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
 		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
 			continue;
-- 
2.43.0

