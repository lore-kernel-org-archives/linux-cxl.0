Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010026.outbound.protection.outlook.com [40.93.198.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C04D2C327D
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995944; cv=fail; b=ttTq0y+DGiYe9WZJQs/H/zcEcLXFGnXLmp0lnnB+g+aV0NJETmv6usabOtHrfBQGHYgdaYPBuZsyK7owpc2OdNopXNDuc6wcXFMbsA+i5kiSawTeC1s8gkJyGJXEh4xIa/4tKoIF3CPwum6G+6tMH1L/97LOnfEsrkmVte6mDaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995944; c=relaxed/simple;
	bh=v6IrR0zkga6wtsSF1GNbbkBH66z46e6hO6hP8oZLnfY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=iwaAI4dveb1ZFO7DYhQVjYyVmeWIRPayi3amABxevwm9qIF/ppZ8bbZB4TgB282IoexHok3sskreBwjcMpd0RS+DRWTQfB9aKetEVaZv4sMHDiM57SQyrFzEFAfA3MAMT3imipiNrTtKKALWbe3TMT5zCzlVw/TzdKn1PuWOCJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OFHC7eE7; arc=fail smtp.client-ip=40.93.198.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OFHC7eE7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeJEGr/bxl7ErG1m8rG/WRah4sv+Rq8TiCuvSfGwmvVH5mXQlOH74frR8irBFF7Y4VNyO2yfen6PPbcFcd8tyN3yGrLGfRFqOOr+5Xyw4OkK9TEFJryqk/uxQ5U22ijR/awmTTO/XKAimh/J6fR80DuHeE4PH6WalC0+i6MEYs6azKAJQwQ9b0vGcCIHF3UiHQ9gEiJo5M6NJzuGAjGlAGVRH50+qn7h5Bef1mRBQK8j9Pvp2cYWJIOro6E3yT44V95CurDzXseNNn6uPwqJ1dBBm6MUeqysxuTilqjE3qnYNnIj3dvZ+zHuEepYA98OfbFHInsSozDCRz1/VcT+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPZfDZNQKXzhNvAV18qeGD1Kl7SmgoYcEyfgMwcJf44=;
 b=nb4ieZMrPVcDwrJs26XgkQ7+5InT62PZBQ5kGFehblgI19I/Dz/ii9HSrw+LzeSOQtDsd2jvPQKC7nAFEX04GZvSEtKFnLP0Lhn/FrUwSizDg9t+8A6JHU+g3oPaXZziGdxJoKEFtwcPaWp5MvmOtpkNOKweHRlia2TisOoXCqmfKG1npRT6WMt7qX2G3JQ5ylldAcV84ZHk8hDFxowN7yyxcdEPRHuVnjvon52xo+NfvPgk1CyrJHtljm47caUqDK6kYqYMJVDQlW+Z76F7gcIBU4c2VyK+odqzsQ6+Ub0ExyExEPDL3ve9FrvfTta+ZFvgmrO5h3+WPxVdf1M1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPZfDZNQKXzhNvAV18qeGD1Kl7SmgoYcEyfgMwcJf44=;
 b=OFHC7eE7oVWioVtWwKXJhBGAQ+rx+d10FwtOmCx5S6njtu7HjRJWM6xqtLfKn2UvknZJmon2+ztyz+9OPS4c7qws3ZKMObRdrpZC47rMDEtI8hVdIr3gmYGwg7Om4I0e2zali3O4Wr7sAaWgPemwUxuqEvjzG2IUavbJrVDkGh8=
Received: from SN7P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::17)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 18:10:43 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::13) by SN7P220CA0012.outlook.office365.com
 (2603:10b6:806:123::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 18:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 18:10:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 12:10:36 -0600
Received: from [10.236.188.135] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 10:01:35 -0800
Message-ID: <e073fff7-1423-443c-a4c6-502315331276@amd.com>
Date: Wed, 17 Dec 2025 12:01:35 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 05/17] cxl/cache: Add cxl_cache driver
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
 <20251111214032.8188-6-Benjamin.Cheatham@amd.com>
 <20251217161718.00004005@huawei.com>
Content-Language: en-US
In-Reply-To: <20251217161718.00004005@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 078ab382-635f-417b-3af7-08de3d979752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|30052699003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmxDVStaRGdJNnd0TUhaSlhkRlVoWkw1NlIwN1kvVWFJaEtUQm9IUjhCL2Mr?=
 =?utf-8?B?UDJlVWhxTE1aM2hNb3lvbkM5U25oYWY4Z0x4UU5QL2xmcUZreWlEc3FQK1Nh?=
 =?utf-8?B?R0JIdDNNekpsQktNQklwUmVrT1BRMHhWcHc4OUlNTTd6elhQMlFrUGlPTDBk?=
 =?utf-8?B?M2crZDJQc3FocW9wNjh6SHBzZDhzMHlmQWMyRmV3cXAwU0JXUURkNHhheTRP?=
 =?utf-8?B?NHg3cDBTOVBBY3BQU2FrdDgrb2kyZEdXUTZsdzRTeWltZ2htK3B2dEJDVDFh?=
 =?utf-8?B?VnFibUtZOUlGbXZ6VTRvMTcyNDB0SWRFVm84V3ZjMjd5cXhsTC9KNXlHbHhY?=
 =?utf-8?B?cDJHN1Vma3RDbWt5cUdUQ2ZsUFloWUtQUXc1bzUwUnBrT2M5QXEzWWlaTmh6?=
 =?utf-8?B?bDBFQWZaOHBTVnlpeHZSc3FVK3BMYk5vMU10Wm1JMnBtRjAxVnViVUs1Mit6?=
 =?utf-8?B?QVRDdGY5Z2xuemYxdVpYbHlTb2cxcFVBN0pMdzZDaFQ2NUlPdXRObk1YaUs0?=
 =?utf-8?B?Q201d2ZzZ2o5TVEveDQxcFpsc1ZoRHZFOC90N2c5Ti8ybnAxcGhPcFFUZFAz?=
 =?utf-8?B?ZUdGSFZabWJrazR5R2N3RkJRdXhxMU45M1R0a3Q3dWV5aXJTR2d3VWp3TFNh?=
 =?utf-8?B?VHprOHJxZnE4OHlLNU9PRzVzRm1QelM0N2pIL2lWYWFWR3h5ck9oU2Z5T3hJ?=
 =?utf-8?B?YkEyQWpXczRMVGRLeDB2Q3I5MDZ4R2thcWZaekRETFVSRFRQT2laWW9melhO?=
 =?utf-8?B?b3NrOE1TOGZ3d1owQjdjemxpRGRNT08rWDZhbkNmWkJWV002b0VuZ2wxT3BH?=
 =?utf-8?B?cnJUT1VHOEVWN2RqZGxoWkVPaVZ6b08vSWVwRGpodmFKZmFGaTBBcXEyZE5S?=
 =?utf-8?B?Y0NJbGREY3RyS29Sa1lPS256U3VBOUNiM3F4emJNL0Q2Tlp0SE1yWXhrOUJB?=
 =?utf-8?B?RmFlVUJ5Wkd4R3RUQmFZK1RtYy83VStWT1QwZ0dIUjF4WnI3L2RRcUZ2T2pC?=
 =?utf-8?B?WEJKMlJBTkF6c3ExbGJzL3pRbVBsRGRxQ1RoMEVxWmppRUJqeEE4eE9Qbnpi?=
 =?utf-8?B?OGZkTjNHQVZXUDJBQkx6ZDQxbk1sdlJHTDBCaG5LZGdiRitPOXFQektZRXV6?=
 =?utf-8?B?WVYwMGVRSytqWHNHUThxZ1ZBQ1RZQVhrZHk2ZmJWQ0YxMnY4Sy94bUFYWEo3?=
 =?utf-8?B?RncyZlpUVnZmT0FLL1Z2Wi94SUlUTjN6UDVzMDN2a0hrWTRMV3FPK3k5aEsy?=
 =?utf-8?B?UG5JaGNNZzZQZk5SS1NMRzB2Ny9Ud1RoVFh2T21UelNqNmU0Y0piTHhOOGV0?=
 =?utf-8?B?bHVwTysvcVBZUkFzc243bkxZeGpMNmJhaHNHT2pwVC9TTXhHaXRRUVg3aXFG?=
 =?utf-8?B?c2lCWkRTaWJncVAxVjM5WDZmb3Y2QlI3d1ErUisvcWxET0VVTmlYTEdlR0wy?=
 =?utf-8?B?RjhTaGVydXhTdjFhT1dWNVFOejAzTHd3VjdDSnFDR0pNa0VCWVNnM2VhVXQx?=
 =?utf-8?B?d0lBZ1ZsSGhsTjBYanMzVVhKQ1hSU09veG51MG9QY3o3T3FCV2hyUUxBNUZE?=
 =?utf-8?B?eEswQk1Wb2x1QmpKU01PZEZQSm1qMk1qdXRTTUFTNVhja0hxc0EzT3ZaQUJw?=
 =?utf-8?B?dnIrRE8yRm9ydUJtUjg1ekY0alJkcFhzNFdtb0c3L3U5d1p0cXBZL0lCcXpT?=
 =?utf-8?B?SFpJcGhFRTlNOHdxREIzZWprR3NhcTVQOXFWbGVrZUNEVnAxRjV3ZFQ1UGIz?=
 =?utf-8?B?bkZhdDZDVmhYS3hBRWxhZ05iL2hIYUY5N0h0cXpxL3pzTGxmUU1ZSlVYdkNH?=
 =?utf-8?B?M0xzR3Q4OGpHR2doVjhaMGliQWIveFcyQ0llVmF4R2NrUElmOUN4UDA1eVpE?=
 =?utf-8?B?VW96Tk5zMnJablQwd3BaR1N3N0NjR0ZRS2ExYWE5UWtwRXdYM29UM3JkMjRL?=
 =?utf-8?B?aEU4OThaek94ajl1eUMyUFI3YmkzWHRkM2s3M1lOQ2srUEl3RytXeFVYUUZw?=
 =?utf-8?B?dWRUcVBqOUdDRCtEYjdOU21ERFRDZGpiUW1JcDZ2TzREZ0hkRVMveDhaYkNL?=
 =?utf-8?B?QUxjWThZOWNXZHUwRmhCdTYzYjg2TFR6SGlqZHE4d3lzMnE2aDdsZFlZRDlw?=
 =?utf-8?Q?tFxQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(30052699003)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:10:42.0637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 078ab382-635f-417b-3af7-08de3d979752
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452

On 12/17/2025 10:17 AM, Jonathan Cameron wrote:
> On Tue, 11 Nov 2025 15:40:20 -0600
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Add the cxl_cache driver which will manage struct cxl_cachdev devices.
> 
> cxl_cachedev

Will fix.

> 
>> This driver will provide common management functions for some of a cache
>> capable endpoint. This driver will also be responsible for validating
>> the system's CXL.cache configuration.
>>
>> The driver expects the device's cache capabilities to be prefetched by
>> the endpoint-specific driver. The required capabilities can be gotten by
>> calling cxl_accel_get_cache_info().
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> Trivial thing inline.
> 
>> diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
>> new file mode 100644
>> index 000000000000..6f410fae9437
>> --- /dev/null
>> +++ b/drivers/cxl/cache.c
> 
>> +
>> +/**
>> + * devm_cxl_add_cachedev - Add a CXL cache device
>> + * @host: devres alloc/release context and parent for the cachedev
>> + * @cxlds: CXL device state to associate with the cachedev
>> + * @ops: optional operations to run in cxl_cache::{probe,remove}() context
> 
> Run kernel doc over these as it will point out there is no such
> parameter yet.
> 

Sure thing!

>> + *
>> + * Upon return the device will have had a chance to attach to the
>> + * cxl_cache driver. This may fail if the CXL topology is not ready
>> + * (hardware CXL link down, or software platform CXL root not attached)
>> + * or the CXL.cache system configuration is invalid.
>> + *
>> + * The cache state of @cxlds needs to be populated before calling this function,
>> + * use cxl_accel_read_cache_info() to do so.
>> + */
>> +struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
>> +					   struct cxl_dev_state *cxlds)
> 
> 

