Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012067.outbound.protection.outlook.com [40.107.200.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735428E0F;
	Thu, 13 Aug 2026 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592787; cv=fail; b=ZxcZjXxqzuvv/ixnTNhGi9QWjteYHYs5+ViZ0ZVB9j7VC9kC5e2Qrj6/abOfdiS1jJnqDqkd+bnB2EgaaVWcs2M+nQXldzBZFe1oOORH4SQyt/eDWzHvjQ0sUeQVPhhMe5fvr5sfUz1+AC5drvgWI8D+cg4min9MyiPio5D/X6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592787; c=relaxed/simple;
	bh=TGk1ixv/4Xsxjm/SwXk091TqGoq8daaM4ISGhJYDHIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VRI3OIvbkxAWPEhGPwwY7FxoZRBzgH2FhMYkg/l70ZlZ5V3xukiQmEZiXxNLXRLgFUrPbKXOUtd6Nl7OZY2CsKdHID+RqZlw1a59FbGTIoUmBf2115M8IjcdJkfS0vvUOG0Jv6/WARX4W58yNY8Nw/zxaxMysIbMJbxmkxLkcJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TaJM6d1C; arc=fail smtp.client-ip=40.107.200.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TaJM6d1C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isyz2nvx9Hkn49DiqN6/KSVe+xOMtJtjMI60Cw4WLhw0iZbQBmSwurvf7BmdYxfLcz938PXFRPAoFnyETmJwx8P6Uid5zroeAdph5ijifEEqliQoTm2aEPhKjH5ibwbB+YXJSnCRfYMHZaekaVdhMbKcXkjDaKDlhyEaR/Q+cpSqZ/1qPEt7Nh0+65cfSzZ1qj3AwdHgwZegTkUmgaLlQyFx4rF+hPAl+Htru7PoqkIFsNczh6A07BmFZGZZz3KKEa5CqEZdVp7j+n4jnpo0DsH8El5wnBT6vJF4F+amq1/6bMOSNv70RBQpphKIG1daNZExwhS/eoZb8X6rldrQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eouvKWGNQh96dmqUMkxqaJZQZC8igDESkQGRD0speSk=;
 b=HDZOLtxHyiRZ/4pTiBOV8xhEhtxoME92VseQFAJJ7XhiqZQynAqyJcw0Ci5yESSM9LSjshQ9Hp3udrxv7y2GNcBvAwW3eXxpdlYcmAxMX5NBpHnXxJrpGbsbt7i4jktrF3zUfFcc4zPhNmI88OnNhpNv4PFugXOwrw175o1Hcq3ev2eayrf2urzyzb3Isp3WDg1/HlUN2+Lp7SC9dH4AEMAvlIrOSGZs0ug25w970VYXWBg1EGs/sqZgAHGTq0W1WjNqg/mnOf2OY2sIkeFxdKfZ4f3LPNqgtpKlaASWmYKzoPsCTfFxVWAwucprJmMbBx5il8Y8RAUE1bKkhshxOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eouvKWGNQh96dmqUMkxqaJZQZC8igDESkQGRD0speSk=;
 b=TaJM6d1CPsUNlv5lp5dNQGuJRYfVNVl4p/LhZ34ITq5srQBZRyimGrAhK9dGc99QWy6+O+nSht2AKLEB2AW8pyMfPnk0YICK1m3OFLp7yxeXwNaT5niT5vd8fSqbvW7IfekLf0VKPpgD1SvltTQs9eQFmlwq5JCM8yuKwBLLghsASiXjkdAA8jAnHmSnXhyf+1HpvIj8/7I7zC0O4sx8nOiFnDcvVSGwgNlM8O7kcLhx7W7bOiux7GP6gZyat0lauYwVWXydok/JBOHsjgnreOgj0PSNXkP1+m1VJ9DDZnNM/WlsoYe9c355fhq00UYjy8xAG1CXk1KgFl/4am/cwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 03:46:21 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 03:46:21 +0000
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
Subject: [PATCH v5 5/7] cxl/memdev: Don't overwrite the error from an earlier partition poison query
Date: Thu, 13 Aug 2026 11:45:36 +0800
Message-ID: <20260813034538.13189-6-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813034538.13189-1-icheng@nvidia.com>
References: <20260813034538.13189-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d8acc0-b441-42aa-3077-08def8ed7089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FT9y0eVRbBJ81FnfmLUGOf1GRLA1yExrQDh1549Irm7UYxSpQQu5dDurMSZpwaUcgIQnkocyV/JV+HHZefv0phqAUV1l5YjqU7AsATHlspb19hfhX53GsnAA5rc9u+Gntk2K1EfZVuODKcnz90aLALOU7TnZFnagChme7WH5Qpe49DKjWcgR/LH83JGvIwaD60PRLmCJDlyw4uZ54H5spY+cNAqfQ7hzKWuzRYfJ0LTTuY+XtyQyCSubOHx/wNCxrbnh9MacEItVsPuf77Gaogla4FN1K6CCxJt5RDmQedA3QJbZv8TMPwZkJThrEUq4/u6v9Wlron+g9Y7K0mXVZq8BmfGhk1eTl3QVyIrmfJsR/kSJIf8sfS7GnwbHA+Hyg19dk8EJJRKjmLTl/Uf58aopzq5oZyh5lRJn1tIQfoeX5FFchNnCuVENToUMIkZ63LeiHE0PbQIJHXjJXMHmTGFWLJmyGML8tWPqSRceq1Mtt+SYLd8KWmtNXJGTd5pDUXJ75yUbfQJmeUNQ/zh4rVYRPGfCr1uVeKbGT8GS+5bmA99s4K4EanznBuOnYLfZFAXA/OsJHpSe/JkZnCyJwCztcrGSzIpLbAu6v9shaoOMGmNTjRQuctosJ50BFFy2JwNh8XTGnG6urUq4mVaKGMJOPOkWU1hHP0WVjIZmI5I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DpsEl7F/Ds9D6H7VCLgHVXaOXQxeQ1JrekjKO3zwqtb0vjDv3YOL0CMPUqqf?=
 =?us-ascii?Q?4ngXjD1qnszETPncyG/RPhALC8GkU7ZlMEh8mU/n6FRw/8mC4QEHHAYX9phN?=
 =?us-ascii?Q?Yl9wiHABmQzFLg7fony6+L69LVuRexmJAgnuGtbq4+pHClEpnymn37gBq4ei?=
 =?us-ascii?Q?A9NWyOuaOCu7SjsNc7RtmLSPEXgSzydREOxiZsG0hKPt0JajepVCdX9Q65kl?=
 =?us-ascii?Q?t+NF01pvRZukUNaydgzJB4CrH2HAtGDppWbkzBQyLSHbMKg3W/npjfEvAVaS?=
 =?us-ascii?Q?LveI9xsFIzIfYHYVQn5beCQ7XvjlxHcwAMU8LC5CYri4gCYJhHlpX0TSS2N7?=
 =?us-ascii?Q?azsDyfOpMP9SA5Z6sgSTX142YgGyF48Rjlo14LpoLr194ADN9WM5TCY51+fm?=
 =?us-ascii?Q?/P03asuqosohgX1eHNnjbsE+z0vgqxrJjfZ6/m7BURcnFlChSuK1x5XCedxt?=
 =?us-ascii?Q?t9RwB1iW6fmCe7//Q6OOeF5FSMI+/KhJsM7GabaMaV65rgRWmta2WEw+dwCW?=
 =?us-ascii?Q?mOiLbvqSotPEL7o6hfgluKjg4+RA4KfqOFgvsYmrlocuQCUs4nEPut0vweKb?=
 =?us-ascii?Q?aYKTo/jgVnudi7g/0ZYawGdbqJwc+CrEvMQqjuhvLzW9shyTZSjQlciL5YhA?=
 =?us-ascii?Q?qJG00gLZMzZc9/ADz1i+gpixkvrXQSyiFwQ7Riam/hBV6ph/ACD8gBdNXMDE?=
 =?us-ascii?Q?r/aO9Jva7/jBOGqrqDPb1hNeTZJiMZqO4HQSgJsfI5s1WCe0nT5UhGsJ3mt+?=
 =?us-ascii?Q?1qgFB0SI6Jjzbsjk9Zo0b37IFowRFv7EOosHfnJcEPPg+WwRAKonBwZIpt8R?=
 =?us-ascii?Q?6Gj4fm6APpS+JS0z6tAAI684shEREaigjYPGaSpLCJmJ4rwvIRLwMGhEhvJk?=
 =?us-ascii?Q?m/lyFS0BOdAiLh+9llBMr24sMQbPYz2s5qsRHE4TFyGEObxmm0tpJy9T1tsD?=
 =?us-ascii?Q?phmm1Ak4WNUWpH0d27QgmQ6NexeTnnQk6IQmAZ15dzWwduFBWP2EqqZKqEM6?=
 =?us-ascii?Q?X059XVe4eMNVrrZPTfKiAEgpzhDicYkCiKFKXpIeCoi/YzEfdHOuoRK1Aqx5?=
 =?us-ascii?Q?Scp8VY1a/M27BYYyvHxRONLi8UmxfJ3pkVsWhqu/kcMF/5bylbYAuafXws7G?=
 =?us-ascii?Q?lffRO/GvodF7FYjS/bSJOkh8pP4pw/MYK+Vmoa8PEA6yJSfOIqa8CZlOEN8L?=
 =?us-ascii?Q?/LK4TAUI2X0reVYeSKDL8M1bUSmqGixxUDB+7p2xWmeq2vGZTha5tpclR5sc?=
 =?us-ascii?Q?rU+Imb91cnl5vujdY7bPKBCkulCOgcTicexQRByDIGrBYcr7vwhtGqFuiVLs?=
 =?us-ascii?Q?Gb50tToFgP9HhZD93E8ZYBw9gWuGRoCXz34lCkS/yBxXDmmbhWU6INxrenHz?=
 =?us-ascii?Q?TZqT2XgnmIa7GtJxofbSVMhgXp+oVJaYXxoEB6GJuKGCpkela1PuqdgeKLaE?=
 =?us-ascii?Q?QLCu6DTba9BuA2zaVUU1ahZjmN1gRea4BHluzUzqaDh5rnJbxz7EISHn/vAo?=
 =?us-ascii?Q?KeVYLTudt901jKd1fQESw0ETd02QiNUSlpLh1y51lXNJG7evFhS7w6riyQJH?=
 =?us-ascii?Q?t65OJqINj/aPo1mAxs0fqh5CFnn4jgFSDR3yaiu7nEulxR0Cvzannc4i2nWm?=
 =?us-ascii?Q?6ohKDtmOGC25mVQQmgagnmw6ysBVDtUa51ulCrqNUb2VYxGyDcHkD3s6SEHh?=
 =?us-ascii?Q?vodIl2SNSbMATwz7XQqDWO0eXbtbJ08KIcyRdlHftZ7VpPpYOFZj57fPKc+E?=
 =?us-ascii?Q?/cJHe9k2iA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d8acc0-b441-42aa-3077-08def8ed7089
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 03:46:21.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0xYo7AE78SHgBvfzR8JFahTqObG0xDGgXRZjOhpkZjWz8EnVStD0UPT4t6HUDYIfVEp+wQ1Mmt3HkgRhMXpHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579

cxl_get_poison_by_memdev() queries Get Poison List per partition but
never checks the result inside the loop, so a later partition's success
overwrites an earlier partition's failure and the whole scan reports
success while that partition's poison went unlisted. Before the loop
conversion the PMEM query returned early on error. Stop the loop on any
error not already tolerated as a RAM -EFAULT.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1->v2:
    - New added patch ( sashiko-bot's report )
---
 drivers/cxl/core/memdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b3419df586b9..e39b3d13fd56 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 		 */
 		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
 			rc = 0;
+		if (rc)
+			break;
 	}
 	return rc;
 }
-- 
2.43.0

