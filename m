Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3920163;
	Tue, 13 Jan 2026 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768343707; cv=fail; b=PUBuNf4pSaeI8awx+DW9bLB0ERxguTAoGTiP67lz3CeVZ7yln5BQ8B0uQCz3WNFEqttbCXf+PQMnjuff0j7ukSO0Q7NdbjA4ogsaxN4OI0JD7KTPzn9CAS4GiOf/C9Z+3zXuwusxPJdp72HixMUz13hyPoluNROJAwhkafy/3wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768343707; c=relaxed/simple;
	bh=L2c9Jk/l1d4AiyhCzEpq0kjalcFkxazmjA9wvD0eQ3E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=AI43ie2wgtXd+bmwyZO1dOwJZLA5fqC/nZAvxS8vLwZUy4TVgsBCN7qqL2kDBGfAbPusazn2s38bSn5EZtwGtaJoAIDNQUjphnQ+J4C3ZRe4B8UumuOPKhr2usAhPCMtIJiGezf9gbL4wKA0VlmdYNIctq7/yVatruhH7p2Ojgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tqKu4L1x; arc=fail smtp.client-ip=52.101.85.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tqKu4L1x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MornBDN24c+Q+GQHH2OfLnE0ybDi8gxdF3PcrARPql2NosWRwwp7+4qoCxSfOfrUiGUwXK5R1ik96y4eYL9UB+59s2CkdoSJ8mD+yWkHZ0m8QkW1yw3mhV6uuwB0wTSHlBJgSP7W6/WxzyHH1DzqEdRcHtcHj0kuARMb8nu95/E6X9xSHfUvHJYHsKfSSxbUpQ0Gu0Xw4x3iCL3MeE57W5QkteWDMnJKOlmzSKQalgk/rhcchEU/g0KkoTA2xr+fXnfQfFqzRxGKz2wdaP7P94o3AX/yMG+RavjV/Ug6fOdjkx57XCYxAI70aRQJlwTZR0pIhjngoYajuKtmpnQZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4oCklMNzac+oyDNPfMitwAzlNjHDTCf9EBamkWUuXo=;
 b=LFyTgHecOtnxOuodKX/UEDSOXxKls+1pafTWohvbGk8DIYxNtidsioJziKGIMdeQzNYqq32abGN1eumAJE4W/sZGcptFKxHJxOnvXHZUs6fWJKrgON0MPcVSIw2WuMOQJ8mVux1VN2gu9kcaf4JnDGhQJLIiHl/IzBdS2VmEhuc25DvXccNUiQc+kdleMuuw7qHv+p/fULM5ioFlDC1UCB3rocgH3BQRLKol3WGVsPsDsTmuwB3b0MPSgroNYrBXu9cOgT398MD0Kmz9Iz03pssRzphSccqJOfMji7Ss08edfewR1XIHpIikIc5pXRXnqIE6gLea0A6Jc3bZxa8oJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4oCklMNzac+oyDNPfMitwAzlNjHDTCf9EBamkWUuXo=;
 b=tqKu4L1xFYyK+becm2AsznNplafvFtJLekqPeEwHUFXolCBQ6nf6EUOpzyQrOvmgF5yMso8rTMIahqcdASD3yrw8Ks8dO82Z6YktW6/odT1Mg7bOrJW4ig95URcYLRcMH+7FM9rkcyhQ+rpFGiyhjrvpDqtqTS8i3ksFyYNYy1E=
Received: from BY3PR10CA0027.namprd10.prod.outlook.com (2603:10b6:a03:255::32)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 22:35:01 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::75) by BY3PR10CA0027.outlook.office365.com
 (2603:10b6:a03:255::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 22:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 22:35:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 16:35:00 -0600
Received: from [10.236.181.95] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 14:34:59 -0800
Message-ID: <c7e02935-ef77-4673-ab1c-6d07768bf02b@amd.com>
Date: Tue, 13 Jan 2026 16:34:59 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 2/6] cxl: add sysram_region memory controller
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, David Hildenbrand <david@kernel.org>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-3-gourry@gourry.net>
 <0233bdab-9b59-4394-9ce4-c3a5df2be06d@amd.com>
 <aWV78x2NZd0-iNSv@gourry-fedora-PF4VCD3F>
Content-Language: en-US
In-Reply-To: <aWV78x2NZd0-iNSv@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 3625aee5-2a7e-4564-24d6-08de52f3fd01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFdoSVNybFJoUTdqeGtkZ1ZPYlRUSnVWdzM5empoa0FzdmRVUGo1SHR2RVNy?=
 =?utf-8?B?TFFGWnBzQW42REtiZlRXbTlHdkF1UENBNVFhWlNIRHA5ZVdlNlJ3VHZPSkV3?=
 =?utf-8?B?YXJsd2dnTTlTeTdKU3hvVFlJUDFncVFDbm9JVGJlanpMVW4xckg0bGlFYzFv?=
 =?utf-8?B?STkvd3daaWlKRDkwYXBSZWFqNjFQclJQcXU5N3dZQXpnakowS2xlYzUyajUz?=
 =?utf-8?B?MHpKOFV4L0hhMk51dVZ4aGF2Z0IxUFBralRoZ29EdllPTmdCUTVRdmRZZmdK?=
 =?utf-8?B?L0YwMlpXQXpSc1RUbHJzbDNSVy9oSndjb0piYVd2cHF2OWEvTHEyQjNieFZr?=
 =?utf-8?B?ZzhvY0FmY1NqVTNJU3pyOUVQSGF6Rnh6dS9ZVjh4WDVNOE1BN1FRNHhnMXB6?=
 =?utf-8?B?VEh6OElsalJnTXV1bnVtMlZtVWtJb2tYM211L0RXbXZ3ZXBlYWhlWDB3TTNO?=
 =?utf-8?B?QVNhdjM4Z0EzcnkycHZzSjhsa3BVeVl1eTNIWkt3Z2V4Umpqa0ZIOVZYZHVK?=
 =?utf-8?B?Wi9BUFdjRXlzVU9KRzdVMG5qcWxOOFdoSjM5TERwVXVpa3ExUWJpaU1zaXBy?=
 =?utf-8?B?d25ESDZDaUR1ZGNRWmhQVFphNkxSV1MweUljS0FEbVJEQmFPY0xuVHVoMGQr?=
 =?utf-8?B?aGxKZW43eEhEUEpzVjVpRHpqRnFNN0hTdXA4NnYrb3MxckhtMUlRUk00OEhy?=
 =?utf-8?B?bW9KVkR0WG9tVEdkbWhqdzFNSXZXZGYzaDlaR0EvRkEvZDdkUWNXQnkxQVNW?=
 =?utf-8?B?WXMxVStoRFl3ZkQyTThGa2FwUDVCMFVRSzIvcVNWY1grS3BQb2s0ZWNnMVBU?=
 =?utf-8?B?QVI0WStLWFp3cGFxb0x2WndreWoxY2RjRThkcUNPRmdZcjVXaTBhTDROK09n?=
 =?utf-8?B?cGNjTm5PcDNBZmUxOE9xd3VTUFZ5T3Q2SW5aWWVuWTdTcXZ3SFUrNHdCbS9P?=
 =?utf-8?B?aExNNzNXWmNieEJKM1hHMXhVSksyalM0QlRmYUJ5RzRKMEdlZW5pcWl1MFJp?=
 =?utf-8?B?d091WFBxQnhpNTdWTHhoZGFXM1k4TTRJdWVlMFhaN3dkZzRZRDQ3V1FuZzEw?=
 =?utf-8?B?eHRNVGRNRUkvZjZEU2lIbDBvSzU2ME9UQUFQLzVQU1VFZkpWV1RKUHVHVlFU?=
 =?utf-8?B?aSt2bUhKYUx1Y0FjWUtyRE1JRFFPYVBDakVXRVpmNStEbG1FeWhpWDRGSG9k?=
 =?utf-8?B?OWFJeHhCVURVTkRwYmRxSisrSHBiT2FtR1IyWWcvREJBSi94dUVodDNxdHM2?=
 =?utf-8?B?L0FuaVkybmFCS0dpRjZIcVFXQUowcGNwR0Nka0JycGNuWllFTlkxaEVncnAr?=
 =?utf-8?B?cEhScWdjeStxRURTb0dra08xWWtnTDJMQUl6RGRkajhwM284OWJJZHNzZUNj?=
 =?utf-8?B?Tk5MeTVwSDBuZWVsV0Y2eXlnU1RtY2FUR3ZlUEE0RXVuUzdVWktiMExVUzNB?=
 =?utf-8?B?dHErUWJycVhheTZMS1hJUkE0ZUloV1dtcEhBb3JyK2s2d1d6OHI0UE9IRGU3?=
 =?utf-8?B?cDRyS0dBTjdVKzVYbmJHamJUQk5pazZFS2s5V2pjTnZEa0kxY2szV3R4YzhV?=
 =?utf-8?B?cUZiaTQrV1JCalJjblg1VzBucjFTZ0E1cHVNOFNEcnJtMDNvbGtLdjJvbWJk?=
 =?utf-8?B?SGlhTEpzR2R1Y2p6cnY5eHhISlhMUnRXQUE0NjhRRjJ4enE2S2NtcnhCYzRm?=
 =?utf-8?B?OTE3alJlSUpPajBzaGxzUnU2aklCZ0h5QnBoekh1d2QxODFNc1JRSGxKVXh6?=
 =?utf-8?B?bzRYR1FzVTZtZzdJTG1qOHZ0SzJROTNhZDRtKzBQNkExdmxVQ0dEQWV3clpW?=
 =?utf-8?B?RnhsZVU1Q21uRUljOExVY3pWbkdsQUphWEZMR2s2emExVzl4QU15eHRrb3Ew?=
 =?utf-8?B?MzFMTERUNzN2d0NkTGZQWFZGWllySm00M3dvclVNbXgxcGpobzBncmNCTDZv?=
 =?utf-8?B?MzRrMFZYUStOSStmSTZSL0wwd0QrR2k1eFl0Um1oQ004MUhTeUlKdzRZTjhF?=
 =?utf-8?B?Um0xSk9WRG5vQmJ2MGhhNHV0ZE9uaVZHdFhRQnNZMWkxTE9JN1l0VlNFc1kv?=
 =?utf-8?B?YTM4NEVrMmpsSG44NTdtbkYzVENSellEeEo4RW8ydWdHazNBWHFBSi9ST0di?=
 =?utf-8?Q?AcSA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 22:35:00.7099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3625aee5-2a7e-4564-24d6-08de52f3fd01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995

On 1/12/2026 4:55 PM, Gregory Price wrote:
> On Mon, Jan 12, 2026 at 03:10:41PM -0600, Cheatham, Benjamin wrote:
>> On 1/12/2026 10:35 AM, Gregory Price wrote:
>>> Add a sysram memctrl that directly hotplugs memory without needing to
>>> route through DAX.  This simplifies the sysram usecase considerably.
>>>
>>> The sysram memctl adds new sysfs controls when registered:
>>> 	region/memctrl/[hotplug, hotunplug, state]
>>>
>>> hotplug:   controller attempts to hotplug the memory region
>>> hotunplug: controller attempts to offline and hotunplug the memory region
>>
>> Nit: Would it be better to use hotadd/hotremove here instead of hotplug/hotunplug? The terms
>> are basically synonymous, but I think hotadd and hotremove are more descriptive.
> 
> I will defer to David on this.  I think keeping the terminology
> consistent is better, but also hotplug is overloaded between physical
> and logical.  It ultimately means the same thing to be honest.

I agree, I'm fine with either here.

> 
>>> state:     [online,online_normal,offline]
>>>    online       : controller onlines blocks in ZONE_MOVABLE
>>>    online_normal: controller onlines blocks in ZONE_NORMAL
>>
>> The naming for online states could be improved imo. I understand and agree with the motivation
>> behind the names, but I could see the use of the word "normal" being confusing to less savvy users.
>> You could change it to include the zone for both (online_movable/online_normal), but I think it may
>> be easier to mark which one has drawbacks, i.e. change "online_normal" to something like "online_nonremovable".
>> That way, anyone who doesn't want to go find the documentation for these can understand the user-visible
>> impact.
>>
>> In any case, all of these attributes need ABI documentation as well.
>>
> 
> This is what i was getting at originally, I will consider the other
> feedback and spin a v2 with this simplified a bit.
> 
> I'm leaning towards agreeing with Dan and David that probably we just
> keep online/online_movable since it's consistent with base/memory.c, but
> we can continue to have this argument.
> 
> I don't think we can reasonable get away from users of this interface
> understanding the implications of ZONEs, since whatever they choose to
> do dictates what zone the memory gets added to.

That sounds reasonable. I was going under the assumption that someone may come
along who doesn't know much about zones, which probably isn't very likely. So
if we want to ditch that assumption it's fine by me.

