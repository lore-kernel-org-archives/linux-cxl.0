Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB22F1E51E0
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226605; cv=fail; b=kgWfvDFUQ7pXnSNVJAjjwTtoKGnzXhM4ZF49joPkXtgzpQv8qnfdrQiAHUYWZVSClad7lrKrgncKtBsNT14ed0q5cgB5HOn3YtFfFnsxz1KTDfuC1xO9yAatIDLLLxxPm6QThGX8RrqKNKxinjXnlu5TS2p62gtklaQIHI2nHBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226605; c=relaxed/simple;
	bh=xl2L7sAfu76TgGPR5FddfqsQLRIj7SlDdjXUWGWIEOM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=cC/G+NxYqwbOPDmifVvPFjwiBiJYaYm9z2NOZS8NP4yNOP5sZszMuQ/Zv5aljSaccopWuKicjFuq0mHsVcPl1+46UZ1us6NyS3gCDd94hkxrYuPkw6/8MFtSONydZC0P1N6X+ZlhwaP+fO3r8BdTeX9lgKPWLwtcSFIH6+Mgooc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PTRFQmtV; arc=fail smtp.client-ip=52.101.48.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PTRFQmtV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byjKN1JjQFGaQEsN7u85ERkeo6eQ6tS/yzoCW0+nH0RzSbHlkzYZhCfD4/ZqPsYFMHi2vNy/jOWZTRBCuFxXufwi67ttXlfD+qS1DcZveDMDbeYT5GbTvllHTLkPix9nD8+RwxYX13zAzOWh9zzV3ARN3n7EIw2pi64NBFBW0lzPGEIXeyB4C1Ketm72WpKki8xdWlpfJKgtNEkH4/JonXytaFTzRaWUC9EHIFOu8KUP267w0HArRl71c1t6qgqrbED4XCf0u03qt5schzXRf4syeWA4lU8dO1xoeInvG6EzF1Q6X2lAOlOnXmpKivmIlJP/u4opG3cqREqZO8Q9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey1mQ2ui41qSpMqAzECtq87fXzdWIHMsoCEoGwjCt1A=;
 b=kH5EFBNw6dlnzsRq/s7jTw8fWF3h8k3F5VwLw3d/eSHXz8xTP2gGaSFMwS1HAzRDKBtpwEhf7fFautnX06DeaJFO7QQoaOgABVHRbAKUyw6Jkb43T2cQ1c+pnzvVgkC4ITB1CxQpzv8P19Za9CjZLAV49NWKxS9rhdx4DDRTG8h5wyrcPjXzlR0nARVwX1VCAvtg0hed4er7cgkM2hD7BdcmKxRJ91+lXAJUGSjc1VZ6zF7Vs3FA3a+pULaqjidKg5aRbgyaGBHe9LYJm38iqB0N7G3zL17owgX+PWLlQllYjqOG+H6z+b4bYTMHnFEygPpjdQo6V0r1re+PGgRYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey1mQ2ui41qSpMqAzECtq87fXzdWIHMsoCEoGwjCt1A=;
 b=PTRFQmtV4OQpLww4K+MgMteYUuFeVgTVszTSGgdtDQL3qPFiAeVLoiF6NbK4xLN0op9sr563naLWdnGIU7OdSfYtZgkvGyaRBQlPKO6joYF7ZJwEOTeXcj8+giSdXmZNQQb3Ox2oWiGZYGNvrM+FoNjgLeJmqyz+JcSPgl1vjGg=
Received: from SJ0PR05CA0085.namprd05.prod.outlook.com (2603:10b6:a03:332::30)
 by SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 20:16:38 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::97) by SJ0PR05CA0085.outlook.office365.com
 (2603:10b6:a03:332::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Thu,
 18 Sep 2025 20:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 20:16:38 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 13:16:37 -0700
Message-ID: <dc7189b4-287b-47bb-b7a4-0c02610a6111@amd.com>
Date: Thu, 18 Sep 2025 15:16:37 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [RFC PATCH 00/18] Initial CXL.cache device support
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <2f651b8a-6185-4a68-84f4-1e8dcd9dbcb5@intel.com>
Content-Language: en-US
In-Reply-To: <2f651b8a-6185-4a68-84f4-1e8dcd9dbcb5@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: b36f8676-3783-4c0a-ffa4-08ddf6f0463c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dElNUStqQTRvR3VoeVZzeEVTVFdpS2hHU1hxNGR2ZzJUeDcvOVBQUTk5cFBU?=
 =?utf-8?B?NXRrSThZZlZMbTV2cXRWY1Rza2phTGJwZ3pzZFRYdHNHc3NuQ1VvSXVSOTZx?=
 =?utf-8?B?SzNYY2xFTzltQ2psZVg2cGtFYzZqRmZ0MUt6SXVaZ2R2NkJFOGN3Z045ZHJV?=
 =?utf-8?B?cXhmWkpxRFR1eEVaNHRaMklQZUNtWGxWUnRVeVRFaW94UU9Wazl4VjNPWkdB?=
 =?utf-8?B?bURuNzcrZjZrUW0vQkhEZ1RsNi9LTGdESis5NHVrZjY1Y3FkTld6cjloek52?=
 =?utf-8?B?NjMzYWZLU3JxOG1OSHFzYW5DY0NDeWJ4aGFvUnovQnUwM2MwMk80U09DL1Zm?=
 =?utf-8?B?TmMvOHRuelQ5cHRJeEo5R1dKenpHMUtjNTBvYVNPU3gwZS9VQVJZY3A0eWxn?=
 =?utf-8?B?Y1lvakk2N2d3Znp3SE9mZ2tMWng1dnIrV1ovSlJkZGtUYjNKR0FIWXk3aGsv?=
 =?utf-8?B?SFBPaEowZlJOeXY2SnZFblY1ZGZEZXlPVm1MWVRteDFscldKRHIzYnM0c1E1?=
 =?utf-8?B?REUvNURka0ZPMzRvdWRtVCsrZmdVUHJuVGhTZmgxbWMwRGxjVC9KbC9qU0p5?=
 =?utf-8?B?UVNUdTAwZGpTQkcxMTJnVjdNTXZ1dU1BTStYZlp4b0dYS2d3b1NjaXJqUE9Y?=
 =?utf-8?B?UkFUNFFHdmRQL3dRMTVGQnBOam5FeEwrK3N0Q0t1b2RwTmp4TlFyU1ZLQnAz?=
 =?utf-8?B?L0diMUhnd0JXQXE0cnNmRlJ1UlFBVll6VkNCTkk3ek93UFF6encxalJrcXFW?=
 =?utf-8?B?RmhReml3bUNiTWRpYm9RN0VQL0VLTTFieEZVVFhodndzR2NIVS9SejZjUHoz?=
 =?utf-8?B?cjNOdDhOTjMyVi90VEJBZDUrT3hwek1LU053WUkvRkE1RjVOSVA5YStjbEt2?=
 =?utf-8?B?Y1Z5cVpSRkVUUzhwM1p3Ump4akg1VkJBMjRXamNvblBOQ2ZXdXNHWVE1d2pF?=
 =?utf-8?B?ejBsWStFcHg3VkRlbmFITVoyaWIxV0lQL25rUExmNFZLUFA0eW9DSGxyTmZF?=
 =?utf-8?B?N1JrNU5Gc0ZIejNkR1gwelBlbit2RFJ4ajlvSm1Belhvc3B0K08wZnkvQWtX?=
 =?utf-8?B?VlE2ODk1ZnVQVUJHRzVhZk9ZV3J5TlhFc0Jkd0RHam4ycXhFdHdRam9JNzhl?=
 =?utf-8?B?QzBMZnFnRVRvUk4wb3RaMHpsNTQwYWJTdzJ5aUxKLzJCNjVBV2Nrb09DRzcx?=
 =?utf-8?B?NGNseTVaUVBvaUhsZmFlc2YwMEJBRFl5eHJwenhaa1RCRDR0L0Y3d1R3Z3Z5?=
 =?utf-8?B?b3lPY2pKNEdMTUUvTkdaNktsL2p6eWh4WWNuTFJqNjRkYnNsVXVsRER6c3Ns?=
 =?utf-8?B?RElaSXV6ZitJNno1ZFhYK3BaNi92V3Uyblk1K0hnYXZrRGk3YnNuMmdpN2F6?=
 =?utf-8?B?MHQ5bjIxU3poTFdDU0VvUkxZU3lKeUl1OEI4NlFIK2h5WnFWN3VrTU9MV0da?=
 =?utf-8?B?MDVQWU9ub2xxa0RNK3h1UjFtRUE5NmhPdURPcmxJVTlwZW1ZVmMxaWtCN21I?=
 =?utf-8?B?NHlqVUoyaFpJUkhOMnNCVC9vdE4xaVNKMGhscW1XU094b1l2ckY3SmdXcFBP?=
 =?utf-8?B?OU5BVUZtbXRKN0FaN3N3Wm80SFJxQi9xMDlpTEJLUUVxQmpQeHRuZUxFZzF4?=
 =?utf-8?B?S20vcVgveHZzTGcyb29wbGRkeFo5K1d3S2wzMUR1WGFlY1dvc3VyMkxnRWxK?=
 =?utf-8?B?VDlrL1NGRmF1RUN3MmZqZGk5eWlvOWQwanJUVlYvMDJyM3kvaGRXNmJQOXFQ?=
 =?utf-8?B?YnhGUUpVVHllWGw4VWIxRC9QbE9oeVNzczdLOS9HTnFPbmhNMUdCSWpRLzA0?=
 =?utf-8?B?cVpLRXA5K0E3KzYrd0Mvdk9oQTE1QVJnejZQVE9JQzN6Q0FTU2oxeGtXbWJ3?=
 =?utf-8?B?K3R3b0Z6WjFvVVZUTFNBaE5tZ25yR0VpVExVRHZ1VnYyWGgyenJPNldpcmFn?=
 =?utf-8?B?SmdXcm9yL1RTemk2R21wWis3R3p2aWowV0ZJS2lnV1ZJcFZYVEFFQnNHM293?=
 =?utf-8?B?eVErTTBTR2NGd0gvTk1FVnVBa1l6MFBPbS9XQWE0L0JQRmxYSUlWeWQ1dzVh?=
 =?utf-8?Q?FTQCHG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 20:16:38.6118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b36f8676-3783-4c0a-ffa4-08ddf6f0463c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088



On 9/10/2025 6:12 PM, Dave Jiang wrote:
> 
> 
> On 8/12/25 2:29 PM, Ben Cheatham wrote:
>> This patch series adds initial CXL.cache support. What I have here only
>> allows for adding a cache device to the system, programming/validating
>> the system configuration with respect to cache devices, and some basic
>> cache reporting/management.
>>
>> The general philosophy is to have an endpoint/vendor-specific driver
>> that runs through the same steps of adding a cxl_memdev, but for the
>> cache portion of the device (both type 1 & 2). Getting cache support for
>> a CXL device should be as simple as: get cache information, set up the
>> memory region (see below), and then calling devm_cxl_add_cachedev().
>>
>> There's a couple of things missing from this set:
>>
>> 1) Missing an endpoint driver
>>
>> 	I plan on submitting a reference driver (type 1 or 2) with v1, I
>> 	figured I'd send out what I have before going much further.
> 
> Hi Ben,
> 
> Don't mind getting this all sorted out and discussed. But we will need a real vendor device out there at some point as a user for all the code to be merged.
> 

I understand. I just wanted to get the ball rolling since the other half of type 2 support is already on the list and there were/are some open questions about
CXL.cache support. I'm planning on just sending out an RFC v2 for now, then upgrading the series at a later date when I've got a vendor to work with.

Thanks,
Ben
