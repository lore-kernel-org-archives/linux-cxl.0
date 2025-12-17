Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878FD29E0F6
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765997013; cv=fail; b=Ijl0bw7XVAU0lhN3wCIpYCKTL31224fcr1g1Mym2l1t4rMu72Gs5TVohfZL3N3uh38XE+VFAHz2KlE1LNDRDhkPBWyQRYNmSehKB4AFR/SGhfus/YmLx8Tc2qmDIHocTpS9kCc2FYTW+HOS0ac4vYmU2MIP1mXZg/EvmMtiXrHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765997013; c=relaxed/simple;
	bh=lSte+e+TIANQzfv0GeoKEjNmpeSe8u9R6QcCyt4KOdk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=unWGoqsLtGjtVOEAXK1mnhu166BaT306KpBBst7X8iT3ERC8mNhcaZr6VbM13DjnLA8yDcCOkBFqwR0c1Evq7b3E8aNf6Gsfqq2TaiQD9PPTi96Bme+IXiT9dnuk5xyRT/VYxo7op/lAd/yETbG6Gt0S0kZYfpvOUljE7wZ2JM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2I7AGwVX; arc=fail smtp.client-ip=40.93.194.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2I7AGwVX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/JP5kOBq1uk8BFAV3AZ6aL1YOBMZQGS+Fc/aF9rhifW3AejY93sz3sQVZWfTFcuYeEvdw1coDQsdESuO0uGiOqM80HW9IXgnOf04isxCAUFVJxGhG1JCxwogySaYWw496LYUWIEDqv5fUiutb5oTTUgJjEU614wqBK+kazDddXexTQJ7m30Z82EuxfFB3ajWDQIKERgs8pMYZ6M9ezWusyvYoyTfLG0NWJc8aCIvwVUOUI/rx0mruk3ru9TzVCFsdcCMSv83UJVrdvnR/J5hFWXHOPvc4Fi45IaGPOk29F1TTLa/9oouzi3lmqxyGoGvQliySanawOVYRDmAtKXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Og0mSyij0B5zfkOsQ1GXlEgGrGGdVMgUzGXzzwJJNnQ=;
 b=IdtACPYkfWXkdCHOMfnwq6r18F4KpLQp18HJiqHDdTTBnWQkGCTNmm3MrLTPY7qMIsl0gxvrEYV+3tWRouPm/bjEUbySoI+HaPId12pljpzj+fNe0LG1R4vV9XP5jUZWoebg+0fiyvXJ420IHKIkG/v7hRycW5OOyLW2YvX3BNsfEOjl/a0zoWZOlJBdy1d/wAgQzOO9n+yUkBKDWpqbW5JdrcQHT1LVzQ5Q3GRLn8QSt3wJVO84CE0hN5bzXyFFXikhqFCk1Fcmytbiu+XU+jhN45id6C3EeU0z3AufdJxBINGXGAgRrPG9Jgo0s6M/xxzZQ5D0qi6kpxqGVORYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Og0mSyij0B5zfkOsQ1GXlEgGrGGdVMgUzGXzzwJJNnQ=;
 b=2I7AGwVXMOT2ntlxgIf5WhisOaN+DlVdSIpuIEqUHO1kM8RzTggjt3prFyFXUGuYzXt/YSUTJs/DhwcYq8cZLGBHVe+1EnRN3nuRmG5Kw9lEPj+n0I1kRi+rtXMzLimYacGvEeJYtyJTKvq3NaGl4eMMSUMW1wwBJIWnUHul8PQ=
Received: from DM5PR08CA0057.namprd08.prod.outlook.com (2603:10b6:4:60::46) by
 BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 18:10:42 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::3a) by DM5PR08CA0057.outlook.office365.com
 (2603:10b6:4:60::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 18:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 18:10:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 12:10:38 -0600
Received: from [10.236.188.135] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 10:02:10 -0800
Message-ID: <4e76a570-f0e4-469e-9eb0-723b396f5029@amd.com>
Date: Wed, 17 Dec 2025 12:02:09 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 10/17] cxl/cache, mem: Prevent RAS register mapping race
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
 <20251111214032.8188-11-Benjamin.Cheatham@amd.com>
 <20251217162357.0000209c@huawei.com>
Content-Language: en-US
In-Reply-To: <20251217162357.0000209c@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e790fc-50b5-49f6-9d6e-08de3d979736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?L2RSeWVCT3lsY1RqRlNpR1BPVUdjWTE3aHdmZXc4TGVIaHcvYUpkTC9KYTBH?=
 =?utf-8?B?cWl4a3cvdXJxbDhpNWFZWlhucXR5RkFGbEhBYkV6QjBkSUU5azU0TFhOTkRZ?=
 =?utf-8?B?RjhZMU81azlsMU5SbUtVTnZ1b1ZlQmtUQ00wb0wzRGVkdlhZNVk0RFgwMEVD?=
 =?utf-8?B?VDRoa1dwVWxCc2lRN1VBM0c3NTlXME5oR1JwZnJuMjF5bGxoMWh3clFKVjBv?=
 =?utf-8?B?a3REdlFGTmNFRzEvK2pqK0gyY1k2WDFuSEVYOU5hTTFaMDJDeGhGMWJrL3JN?=
 =?utf-8?B?TDRKWHFHbTBxVU5NVkJBK0ZEbUhqZGprVWlVRngwRlZxVnRMbVZrelFLalJN?=
 =?utf-8?B?anhYdEkwdzYwOTl1c3Bxb0x0YzRYSitDRUNqdGhQc0ZqOVorSjMrMXI2TjRP?=
 =?utf-8?B?Q2cwTlZ5N2JKYmtOaFNkQXJyaHZvODhLbTY4ajBOeDdOR0FmdjNNaVhxK2gv?=
 =?utf-8?B?amNiZjRWdElScVZMZndEdHVvVERFRzA3a3Bsa1BHTndLMElSdlJDL0ljb3Qv?=
 =?utf-8?B?VktkYWJjRW9ua2NyeENCWlFJQThuZDBpMGVOT3VmK0cxK21lSzBmeVhIOW5Q?=
 =?utf-8?B?ckVCOHp1bGY1SUcyZTc5djNtR3pWOW1jQy9MK1RPeFpXOGtzY3NsbmpNL0Nq?=
 =?utf-8?B?bXEwQzg3K0hkMGJ6QXRqRUhTUjdBYkMvQitHMDZEdVJqR2RmeURDRklTQUto?=
 =?utf-8?B?aDYxZUlST0hqanNDSURMVFFsVXljLzYwdlU1TnUzeEh3cjFMdnN3YzVKVnVD?=
 =?utf-8?B?UFYrc3FBRVpkbkJsOGJBbTliV2NnUVBPVDJ1OFZFZ1g3eDZaV2RUS1B5VVNz?=
 =?utf-8?B?clZKaE0wOVh6cFZlZ2E3dWdBcDdLeUlXNkdiUlRqQ2VNUTc0NnRBb2pBQzg3?=
 =?utf-8?B?NDIvbzFUa05FN0tRNmlhVzFzWmltbFBRYTQ5M1Q0WldQZU9JdHVCaFlWMDQ3?=
 =?utf-8?B?SUJ6VmdIT1p4b1FIa1hIRVBqR2dqcDhmY3hiL2pSVUJOWTBCQjhRUjl0SkxB?=
 =?utf-8?B?WXBxYXBKMzlESzlwU2J5Y0J3NVBLc0lRelFVbzJmaWtRRzh2d1htT1ZyN3Fm?=
 =?utf-8?B?YmF4WHpMdkh3eE1yWXcybUlOWjhMRWxVNlQ1SUZHV0Y1M2N1UnJmc2hjZzk3?=
 =?utf-8?B?eTBIVFoyZXQ0bzcxZXNEYXZNNno1Q2J5YXlsWWNVMHFsQVk0S0h4REtIaHMw?=
 =?utf-8?B?dnA3dWhIUDg1QTdWLzl0dnJZOG5sQnE4S3labFdNbHhvbDhxYWFpaVQ0YVZC?=
 =?utf-8?B?OVVqd0JQaWRLb0R3U0htbC8yR2hsMHpBZkxzZDR6WW52TnVWWlpMYSt1Ujg0?=
 =?utf-8?B?d0MyQ2NCRUlUTXI0WTdIbjdzNUVDNmVuQTdESVplci9EeFpqc3hxYVB1Zjlw?=
 =?utf-8?B?VVBZWXpvdFNIVE00MURzREdUc2l6dkk4L1pjKzNVRk5YdEhITzEzTXBWVXdB?=
 =?utf-8?B?U1FsMDQ1Y05RWjVCTWcwRS82TVVabnZveGNsYmZBcTZrd1JHYUg0dmVjZlBt?=
 =?utf-8?B?UEdwTmg1S3JVVDJKQy9XdUozNUxRMXBaVTdiOVNaV0VGdU14V0tTSDdEbC8v?=
 =?utf-8?B?WmNOK21Ca1Fvdk5Sb21NbDhNRW14R0JOQ2VJaWpoR3k4blNXLzYzNmZQRlE1?=
 =?utf-8?B?bFcxZVR6TW5hdVdYZjZZVkhrQzErSlUyTkZhS2ljeDFaMktWTVMzWEQ1OTk4?=
 =?utf-8?B?Sm5wcHNYRlcxT0NLUGhLeU85cmVxQzVBa3BSZFJyRWJuQzY5YnlFRnBIenhM?=
 =?utf-8?B?Z3ZXSzZTenJjNFhDWWoxU2xDQlJZVUdJaXk5eFBQamdoU3hwSTI4cXpReHRG?=
 =?utf-8?B?b2o1QjlvT04zcnl1RHFRcnJVTDBvRzFWT3NSQW9BWXhjcG95RFQ0dmt1dDBE?=
 =?utf-8?B?eDFlWVVKRytZK2N4Wm5UeEhVak1QSGJtQzdvNTVWcDlRVTIvSzBkQW5ReU9L?=
 =?utf-8?B?aEIzTWVsQW1zTGRiZ01GSWg4WmRkZUJ2YVFMaDk2a2o1bWVLOUMvR3Z1bUh6?=
 =?utf-8?B?VHFQeUg1LzQ5c2NMQy9qMjVyL1B6QS9ZQ2Vqb0lORHYwTm5KemxETS82Qmdi?=
 =?utf-8?B?Rmo4L2V4Zlk3Q3lEUEJzekh6TzRyOS91dVlDdSsvcDlkREVUckZmTFplRDlO?=
 =?utf-8?Q?Hmo8=3D?=
X-Forefront-Antispam-Report:
 CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:10:41.8986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e790fc-50b5-49f6-9d6e-08de3d979736
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
 DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

On 12/17/2025 10:23 AM, Jonathan Cameron wrote:
> On Tue, 11 Nov 2025 15:40:25 -0600
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> CXL type 2 devices will register both a struct cxl_memdev and struct
>> cxl_cachedev, both of which will attempt to map the parent dport's RAS
>> registers in cxl_dport_init_ras_reporting(). While the immediate call
>> fails gracefully, an error is emitted in the dmesg log by
>> cxl_map_component_regs().
>>
>> Avoid this error message by checking if the RAS registers are already
>> mapped while the port's device lock is held.
> 
> This seems misleading. The check seems to be one whether
> cdlds->cxlmd or cxlcd have already been configured rather than
> just the RAS registers.

You're right. I was relying on the cxl_pci/cxl_cache probe setting
up the registers, but it would be better to just check the registers
are mapped directly.

I'll update this for v1.
