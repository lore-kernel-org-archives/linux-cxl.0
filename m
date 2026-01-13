Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DF0163;
	Tue, 13 Jan 2026 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768343713; cv=fail; b=JAUhmGe8W3qPnsJ4U9UufESJbYA+Ctf//tfRmgSTm+4bKpf/2k5lHX6XEfYTZVJtiGi326hqNfy78tyz0w+27saRDGczaG2FQ5OHWmZHWJCXuA1T20dblbv8fEUMng7exehQMtLqRn2VjaY2aYh2YwCa6Ba8oSciP6A4Me5rF4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768343713; c=relaxed/simple;
	bh=QwNnmIq5I4OCq8ZR5ceyu4txV+SsyvtxDQhNzySsGjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n5qAq8MSCdVMjbRoqvx9gt40DSnFr0l1dVpvi2Bx1iIKxEc3qMK8YTpZy0XaH7CZFJTV98SnUVEQEXztG7rj1DbN+T8dIHQPAvv8Yj52SW4nKiXr/BLI5i1C2id8ZJvwBz6f+iFQkbBVDcRi4z4T1AwJfgV7AbLYcmBaRsNxRpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rFGy6p7E; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rFGy6p7E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUnbzznPtX/sJkDn6OOBG2kQzSxQIsRNFXXm94wVpWEpX63F2owL1fKfZ3uq7wnkrVWocrKirnDFITOMTUJ0HZpORNqJKCSxrQKoBQ3ECoCFFwn+TrAodJXqzhv4yPKamgG5drT4+m5bRYCbk4TdgadH+RrtmE9quCaiwTk3y8p85vRFWE0gWqGv4uCTV1emFbWGO3I31tDjzFkgbFEWq8YdsEscNVuc/NvkUIi1aA7lV0DHOwBzB/rGI1ADHeVW41YyAqaKQQSZsZ9vk6EfbASiQijtRQeRRwLaImoBGqDt1heLTPgVZfdTbOU2kdwZ2ypQmUvrTlT2qXY1i2QDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL1Uypk14AS3cQlULd1ReaGrc0ALbPbsQ53KbGkh224=;
 b=puQB25d4hg5eK5yjSO/TQbd7R7q/IpitDcgIfEIKtGQDfNROQfmEudmq1F+uPp/GwikM4AmCwDDWvNpsah1nUHsFFANU08PEKm3LqCjlF+PYPBZBhJxpHwtzzHkyqpPZTnMyNHT6s4nlPadPvtj7JvpJ/CE4rVQYvsyYfNu8nQqBsvRkc0m9BtLrerOFL3KSunu6hvR7Le0kBA0kI9u6Gr6cAjyVwVdw6jEWXnPB3LWO53vuqNlFgyi9sr0es4Ot0xXiDxhOZhkV5/yiMTA5AbiV2VSFFfAtUxZy1jiL4jW43MTpH+kezKHwifApp0xcdQdT7uBhgT4TuthKGcOqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XL1Uypk14AS3cQlULd1ReaGrc0ALbPbsQ53KbGkh224=;
 b=rFGy6p7EX031hc6+dsfodJ3rlW1+e1cMbkhtqMnSD91rGSq2XoeD5Wj3pT317II/Gp8GziGdXJoFqxUxXUdW80aFnJf/g3WzetdqCgd32//2wY//3cku8fUAhtIt7r/bf1d3HZt+5+aVTHEabCbk+V8ESoPQfBOUmIi8BvsJ/BA=
Received: from BY3PR10CA0005.namprd10.prod.outlook.com (2603:10b6:a03:255::10)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 13 Jan
 2026 22:35:07 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::58) by BY3PR10CA0005.outlook.office365.com
 (2603:10b6:a03:255::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 22:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 22:35:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 16:35:03 -0600
Received: from [10.236.181.95] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 14:35:02 -0800
Message-ID: <988ca415-ea91-4509-8552-5b8829d9e8f0@amd.com>
Date: Tue, 13 Jan 2026 16:35:02 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] cxl/sysram: disallow onlining in ZONE_NORMAL if state
 is movable only
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, David Hildenbrand <david@kernel.org>, "Hannes
 Reinecke" <hare@suse.de>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-7-gourry@gourry.net>
 <9c975c63-2668-4283-a326-292e50bfbfec@amd.com>
 <aWWAaDK91qAVLRLz@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <aWWAaDK91qAVLRLz@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d3502e-e941-4f78-1372-08de52f3ffea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eW8wOUY5Z0xYeVRIN01CS2lyczVraFFjd1V0ZkhZK2RFbGNWNVN5TlU5UkZV?=
 =?utf-8?B?WDlCTzUyQW02VGx1cXRYRGhvNm95WGpxM2JORFBxRGZyUk9EMno5RDM2WWdz?=
 =?utf-8?B?QWU0NTJsSlpLNVh1WnZMZG5zckJXeS9weHNsdWoreUhESlpSS2s5MmtjbWhk?=
 =?utf-8?B?WWhSNi9DaUdhUC9qaVMzeGovK3FhVDF3cHR2dVZhc2UyZERRMnZJVW9LeGdr?=
 =?utf-8?B?YTlKVGx1SWNHZlpoVlRNekFoc1JEY2lLVnI5eXNTOGUxZEI0clhXdXM0T0w3?=
 =?utf-8?B?cCtWUE12TmVPWlpKKzJXVFU2OWpuZWhDVEVvL29Bd3V5QzJHQjJLRERCeDFM?=
 =?utf-8?B?Slhpd3dzMlNnKzVodjN6eXBCaFU3akRubnNQTERDZmlZaDhtZFhkUXllSTda?=
 =?utf-8?B?VUh2QmlyYXNlUHdMUG11a0ZSaFVRNG5uZ0ZiaHlaMjVFOWcxdko0d2xrb2F1?=
 =?utf-8?B?UTNoZjFGaXBLTk5qeGZjTzZYOXMreEprRUM5Z01EN3k5SU9iNEVmTFlYM1NU?=
 =?utf-8?B?THg5R2xDZVYxYkVBdFRJRUJyNHhrMHZKK29jRkFodnVVTWFxMnlKTHgvVWxV?=
 =?utf-8?B?Y01JUWhic0ZGa25TYkZjSG9acFc2K3BQU1RKWWg1Wm5qcFRyNC9DdzJEbmM2?=
 =?utf-8?B?Wmw0REx3RWRiYTEzdGptaWVESE9JNFJtQWJ6aTV3TzhrajdkUEdWMUFIWnFU?=
 =?utf-8?B?VldKTUVtZnBIbHBBbE1zUmVnbHBsa2VBN2FOLzdyVlJjTVVaWHdvbm1rbGxq?=
 =?utf-8?B?OFEwRzI5TEVDMGRqblFyT0VTY1dXTmdiQ2xTWUJYSUdoM3gzRmFDNFZuZElD?=
 =?utf-8?B?aytJVnZ1NEhnNzhGY1ZlMWpiandjOEFlZjlWY2xnZDFaS2RRbVdBcTFoVmt4?=
 =?utf-8?B?ZWNRaUxiNVhLN1ZSVElDMnh4WEVrajEzT1hJdERac3MvS1NpSWlxNDcxUkpk?=
 =?utf-8?B?ekxRcGF3N0FlOENqWjBZSExpRVBtczZPcTQ0ZUFPMk5JRHVxVWtDa0lvMlFn?=
 =?utf-8?B?bmNCZUVma2NqUHg4dHBoNllQRkVZUFZvc2RRVzlPdXJkQlE2cEhsZ0xqMm5k?=
 =?utf-8?B?OW1mR0JXQ1FIRlVBby9PUDFpVkc1RVFaWDJIZ1JQbXpzT29adU8reVBJYUdX?=
 =?utf-8?B?RGs5ZGtCYi9kOXFIM01TVjZVTklta3BJOHV3b2U2eDM4ZDJNKzR3aSt0ZTdU?=
 =?utf-8?B?R3JvNWE3QVVpMDlTeHRJZk1mcDRidXY2bjlocjN3SEFvc25BVkpzVTB0Q1Jj?=
 =?utf-8?B?NUdES0NQNlJNRmFoMXQvcjJEZ3RGWHY4c1pJT0ZqM2w2RzRRVEY0MENJVWk1?=
 =?utf-8?B?ODIwb3NBc3FESE1VV3hHN2Zuc0ZpTDhpSjhSSUF6MWcrZHR4a1NScDBFOGhp?=
 =?utf-8?B?YmFmVmVwang0TGlpTHl6bFBDYWt6bldIYkl4WGh2elExb3U2WmxsQTNMZ1Rp?=
 =?utf-8?B?VmkxM3hIS3N6MDZxN0FKR0FXbXpRemhlS1ltZFhTdGZ5UUNYWEtCWjVqdkFn?=
 =?utf-8?B?RjdaVmMrbHV0MGNTVTFrZnlCY3duZ3VYM0hIZ1YzWURVZHBMK1ozSXBqK0Ra?=
 =?utf-8?B?THZwQXRtUlRSTWNWbjRnKzNYOU5FZzRPcHE0MUg0SGJScjg5ZmhvekFVeU9M?=
 =?utf-8?B?TmZUMHR2M3Z5ZzJHM0Yxa0pZU0tWOStXbHlSZkRIN3Z3T1dLeUwzV0dWNHFa?=
 =?utf-8?B?VEtQM3k2N3pwQ3ZtSWVldjdxT3lwMVljbjdIeURvWnNHWFBLWExyRkg3QVVr?=
 =?utf-8?B?OGcxM2x2dzhXZWNheG5RRUxPa0FsVWZ5MDNiZFFweDQzc2RPd1VaQWdia1JC?=
 =?utf-8?B?Wkh5K1B5bTdmUWo3U241TFpuQ2xDSnNhd0tLM2lVZjY2M0gvMUlVYktBcjJy?=
 =?utf-8?B?dGtlV0NCL3pjei94SVFyZjVxRElPMWdPNkdPTzZNU01nSS8rUjFGOTgyZk0z?=
 =?utf-8?B?aUZQeXdIS0tTYlBZSXhwMXJvT0VqRFp4dFM1MVpPLzBTVkVZbXl2bUllSG90?=
 =?utf-8?B?bEkrU3F1azhKYUg5Q2E1WkZxcDNLVnU3cThCbW90bnpqdkNFWkVRQVpsbktN?=
 =?utf-8?B?VlFKZ3BXYkpYUHd6Q1VKeE93MHk1UExNZjVhcmVoRmtDcHNycmpPVDBsUTRW?=
 =?utf-8?Q?tHqc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 22:35:05.5898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d3502e-e941-4f78-1372-08de52f3ffea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153

On 1/12/2026 5:14 PM, Gregory Price wrote:
> On Mon, Jan 12, 2026 at 03:11:05PM -0600, Cheatham, Benjamin wrote:
>> On 1/12/2026 10:35 AM, Gregory Price wrote:
>>> If state is set to online (default to ZONE_MOVABLE), the user intends
>>> for this memory to either refuse non-movable allocations, and/or intends
>>> to preserve the hot-unpluggability of this memory.  However, any admin
>>> can write `offline` and `online` to the memory block controller and
>>> bring that memory online in ZONE_NORMAL.
>>
>> Is it the expectation that the user will never want to change the zone from
>> MOVABLE to NORMAL? I can't think of a reason someone would want to off the top
>> of my head, but I also can't think of a reason to restrict it either.
>>
> 
> It's more to restrict this pattern
> 
> echo online_movable > region0/hotplug
>    -> creates:   node1/memory123/
> 
> echo offline > node1/memory123/state
> echo online > node1/memory123/state
> 
> The result of this would be valid_zones=[normal movable], which would
> break hot-unplug.

Ahh ok I think I get it now. I wasn't thinking about bypassing the memctrl/ interface
and using the memory block sysfs directly. Thanks for the explanation!

Thanks,
Ben

> 
>>> If an actor attempts to online the block into ZONE_NORMAL, it will fail,
>>> but if it attempts to online into either NORMAL or MOVABLE, only MOVABLE
>>> will be allowed and it will succeed.
>>
>> I'm not sure you need this paragraph. I think it's a logical conclusion of the above
>> that if someone attempts to online the memory as NORMAL or MOVABLE it'll only be onlined
>> as MOVABLE.
> 
> in the above situation the following occurs:
> 
> echo online  > region0/hotplug
> echo offline > node1/memory123/state
> echo online  > node1/memory123/state
> cat node1/memory123/valid_zones
>    normal movable
> echo offline > node1/memory123/state
> echo 1  > node1/memory123/online
> cat node1/memory123/valid_zones
>    normal
> 
> 
> echo online_movable  > region0/hotplug
> echo offline > node1/memory123/state
> echo online  > node1/memory123/state
> cat node1/memory123/valid_zones
>    movable
> echo offline > node1/memory123/state
> echo 1  > node1/memory123/online
>    fail with EXXXX (i forget what code)
> 
> It's a little confusing.
> 
>>> +	switch (data->last_online_type) {
>>> +	case MMOP_ONLINE_MOVABLE:
>>> +		return sysfs_emit(buf, "online\n");
>>> +	case MMOP_ONLINE_KERNEL:
>>> +		return sysfs_emit(buf, "online_normal\n");
>>> +	case MMOP_OFFLINE:
>>> +	default:
>>
>> You're missing the MMOP_ONLINE case. In that case the memory would be reported as "offline", which
>> I doubt is the intention.
>>
> 
> Blah, i originally had all of them and just reduced to
> MMOP_ONLINE_MOVABLE and MMOP_ONLINE (i don't see a good use for
> MMOP_ONLINE_KERNEL), but i'll fix this up.
> 
> Thanks!
> Gregory

