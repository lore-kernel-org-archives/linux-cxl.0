Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9254F295DBD
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885743; cv=fail; b=Mte7hl9njwgAeXN9AbSP3LPOf9zkYh3ZafP+gS0CumFN42f+uPsZFNIFt+SNbUuVNP08GrLC8++NESvKi4H1DqLOqrudN6qxVsOAfXsT/vVB9UMuA1UqQEGY950SR0z/cJXl72iLozbFZVmbFZ43gwqaj/Xj/cvW3JXyudr4KIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885743; c=relaxed/simple;
	bh=jxCnco27Cg03knqAmMQI9A/T7tGwJnEUmLjGgPuubks=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jxtuABCJ0PsCbyWf+3e7ROeBxmtU1zdP57p9v9feh3GcgenjcZ6WVq6NiPYsOyhb8JxtYbtRKLwCOKfqfhfNXkFAho4wZEI33TFcrXduTeJkoix0GBLouhxdMlg21CYmIX39ABypizNxLaH+FruTPKnuERsGD9WX/EefdL2HA6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zw8Tmbjg; arc=fail smtp.client-ip=40.107.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zw8Tmbjg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pko9lyXwZ0ODAgzeYyAH9BEWD/AndE+JZR1VJUI0fPMQQxKbPcbG/On6qLEoKbPUGZuik4vZVBU8u+dmPoKlW6k6p3BHnNHPHDoKl/3J65asvzW+TDcX6ha3vANpAaULl7oky9TXvpJhggBKzUkTw9hcATxyOWoaM68ojzhtub37pxmYCKwBT3ZpW7leXmwvzBLo8fZbhdEFINF1RZUkYe+hTMYOyatZl+KKGOTzNBNLmYc0Glbd6qWe6jV2Qapog2IHHGyRlSV+8N3EEBuuWeiVW8M5FjaLWoQ/dpQO1QDILB73z4zimQ15kvvk7AonCsDcSEFjh+2lNsWpqWIwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xS2O86r4wrndB2O7TAFRsX7H/uQRnSjn/CHe+wjGvo=;
 b=vwtJ1gmC58tPWslZrNJQoQlKyNJxcyNtdZkwBYoIgfD2+O+o+0YRLg97xYgP8qJkJYo9Iw6y9BsPYV+8phvhrmx9nDZqPjX7U+6nlg9YxCpyDJMNijaTQOftjQ/yS9NiAWUqXQxvVjmrJC4igyaq6VynROHSp2szJvlQtaqqW/YTgZeoE8cs/GzuZtehn+qev3503idhzVXxI1iDH9jjtSSDowY4JvEeQSthHbvxUYTXiFtyk4POC1/WigoDGNYMQJHmwGaP/egjteXOIGA7rK0ZirPB+AZ1dFZ/2uO0paMbh/EKw9oLgW+hSKoAab5fNs0xsXlwlL+lZE725V+yXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xS2O86r4wrndB2O7TAFRsX7H/uQRnSjn/CHe+wjGvo=;
 b=zw8TmbjgBfcyLli1VEqNxTngPugdWr+MX4SMUKtd158WhXh1PspG02mdeAiprUqqAITGLRKaKmBOvhlVARfkZYmlu13yjekFPoMvzozEVkC0cDJI3HfFmPxmy9FJeEM3VDPBdg+osjogKxqlwraoCKq2v2WU0ki9XDrnJHyElTs=
Received: from BN9P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::29)
 by SA1PR12MB9469.namprd12.prod.outlook.com (2603:10b6:806:45a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 18:02:19 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::1c) by BN9P221CA0030.outlook.office365.com
 (2603:10b6:408:10a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 18:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:02:19 +0000
Received: from [10.236.176.149] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 13:02:19 -0500
Message-ID: <c8995205-2b5e-440d-a2d9-98240a8aa89d@amd.com>
Date: Fri, 22 Aug 2025 13:02:18 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/18] Initial CXL.cache device support
To: Alejandro Lucero Palau <alucerop@amd.com>, <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <f3ac894b-7c8d-4f9d-9bfb-d05c7d7c5650@amd.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <f3ac894b-7c8d-4f9d-9bfb-d05c7d7c5650@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|SA1PR12MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: dc65f70b-78c6-42b7-66c0-08dde1a6096a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFZKLzZoUmVOVmUxRngrSnNpS3Q1dFhyYXNwbVE2OE90RmVsUVhMZm5HbHNv?=
 =?utf-8?B?c3FvV2hzMlI2U2NtMXVQTDloWEtneDhuU0l6OXBabkFndVVyT29ncStJWGZy?=
 =?utf-8?B?UVVwbGsvNVd3WGRhUUZRL1lmN3pmUnVId2FzUjRsWUdrdjdGaG9kaDE4c2dN?=
 =?utf-8?B?QjJHQUtDUDJFVkxPd3FlbnIxQlFua1FubzV5NkNsZ3J0eWYvdlVjNUtGUXFR?=
 =?utf-8?B?VDlWcjdHWXZFa0g4ZWVYTnB4bHVPMjFBeS94aTdsd3VpK0NiZk1tdXUvdVJ4?=
 =?utf-8?B?VjZpejdYcEl1cGZ2d0VUVWlYMXBOQThXVjlkakJEM3FLTGc1bC9pNkZwV2Uy?=
 =?utf-8?B?ZU1nbnNYZWZPQkJDK2x4a3h2cWxkVkErSTM5OU9zODRJdFdDOGRva05UMXlH?=
 =?utf-8?B?ZnM4OHFYVVd4SG9CM0lLWmRCOXhlT1FLLzlqV1YvQTROVkFMd3NIQWNuKzVi?=
 =?utf-8?B?MU1zK25YUlNjdnZDMCtnekFTL1FvQUtVdjV2RHVhTVhwTmNXamp3eXJRbEFW?=
 =?utf-8?B?eHdtYTZFRnNlaWNkeHE1aGhkZVR4OW1Kak94cyt0d2Nva3FCQ1JZbTlMNkRQ?=
 =?utf-8?B?cS82TWFCdUFSeXZUNk1QMTFYM3RRUmpTNWlPc2p1d3BFbDNuZzQ0VmlCNktF?=
 =?utf-8?B?bWpvSW4xMy9BT2VTaWk1endNRzBEVXVWTHBoczZiczI4TzZvVXoxOEdJMW9l?=
 =?utf-8?B?Nlk2b09VdW82QkFSVnpmTzJQTi83b0NrN2ZDRHB6RmluM2E2Z0dFeUxCbkk1?=
 =?utf-8?B?UHlHMXl4RmsvNGh4VFVIc1Nvb1BHdWJXOVNzUWNuU1VPOEtaZFRidThkK1k4?=
 =?utf-8?B?b0RxWEtoNko5cldGSy81Uk5OcmJULzQ1OGdlRzBVbXhwYkJhaGJZRHRiT2M2?=
 =?utf-8?B?SkxtUFZtcEhDQkdWNWY5RjNYVXJZNGQ5L0dXME8vZUtBZlFhZGMxY1h0KzZi?=
 =?utf-8?B?ZnJlQVhYcWJ1cGhSdXg2dVFQK0pacFNjb3IvVGZMR0JnaHBITWwxcFhpNys1?=
 =?utf-8?B?cWJRYUJvVnhOTGltWDNpL0JJTUpFczRoMzFIVVFsMnBJbkRQNEhSTTdMcEtz?=
 =?utf-8?B?cldUT0F3R3Zzc1pCZ0t3cC8vV1lIMHE5T0ZWdGJnTG1WZVJqVHRuQzB6UVJ1?=
 =?utf-8?B?VlI1MG9LQ1hWeVd4YjNCS21FVEpTNUNYekpNYXF2bFdBSWV2SU1BRk9pNXdl?=
 =?utf-8?B?ZzdRQWYva1VwM2ZIaUxwaFpmTzkwZnNFbkprZ1lCbDMyeXJaRmQrYlh5c3V0?=
 =?utf-8?B?MnN6ZmRrV0xEanJBZ2Jpa09kVEZYa3I2NEtxYm1GK1JTM3RodFBtN09IRmNQ?=
 =?utf-8?B?N3dzblo2OCtway9YMlU2SEl2OWRMUC9tN1RCazFpOS93aDBmb0xPWDhOZkVN?=
 =?utf-8?B?NXZ6bzVHODVCTzN3Uk5pMDNDYWM3cWxNenZwVVltWU1MWkpnNnoyWHJuTUUw?=
 =?utf-8?B?ZThnN1g0clJwY0ZKNXlvalgwa1dIbFZKS2FhaGt1Nlh4Ym5lU2xWZHhKSk1I?=
 =?utf-8?B?SStuVmI5K1RIK3FWdVUzY1BuZEViblIxOHdQWm9yMHc0MGlwUi9GVHI0R2tz?=
 =?utf-8?B?dE0xQ0hjUEptL2lEU1d2eGpoN2pGWklIdGtVdG5qcjU4NEE4RjIyc0tLRlJJ?=
 =?utf-8?B?Y0J4bU9EYlc0MXFFa0NkYW9hUU53S3VNVTd1ZFFCS29lTVY3azIwa3pQQ3Zh?=
 =?utf-8?B?SlhiZWZ1eTc5YU4xTnk0SGVNU2NsYkhKaC9KWCtaTDBNSStVeTQ2bDBqSzdC?=
 =?utf-8?B?dy9uazJiaW5RYk5RazNOZDRHc3ZKRTltV01Ib1VYQVRCazI4a2d5cXh3clVF?=
 =?utf-8?B?ZXE5aUVjMnlpSU8wNTlBZVdLa1ZXVUNtZ1dyZDlxeC9tYTZ6MVdXY2x4VlNJ?=
 =?utf-8?B?OEZOQjlQQjNYeXdaeHRjRG9nQVlWU3JSRThTZGlBL2N3Tlg1N2ZSemZyM1VJ?=
 =?utf-8?B?ZHo5Q1JpZEVwWU9KSEZLSHBONHdncHRzQnJYNjkrSDEyOU8raE8rdlNSbFVJ?=
 =?utf-8?B?L29MUzZRdlpidEtoUnpaNytra3dXaHNpMTdma0pPbUxXeDFTaDRTZmZ1NlFE?=
 =?utf-8?B?NEpFaEhNeWxyL2dueVliVkRYc3F4ekdMRTdLdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:02:19.4836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc65f70b-78c6-42b7-66c0-08dde1a6096a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9469



On 8/13/2025 6:25 AM, Alejandro Lucero Palau wrote:
> On 8/12/25 22:29, Ben Cheatham wrote:
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
>>     I plan on submitting a reference driver (type 1 or 2) with v1, I
>>     figured I'd send out what I have before going much further.
>>
>> 2) Mapping/Reserving host memory used for CXL cache(s)
>>
>>     I'm thinking this will be handled by the endpoint driver, but I'm
>>     not sure what mechanism would be used and whether to integrate it
>>     with the cxl_cache/core. Any thoughts/ideas here are appreciated!
> 
> 
> Hi Ben,
> 
> 
> Good to see you working on this. I'll go through the series these next days.
> 
> 
> FWIW, I did send a RFC last November about my concerns for properly/safely supporting CXL.cache.

Yeah, I saw Jonathan linked it in his reply as well. I've read it but didn't really have anything to say about safety/iommu schemes.

This set is really just for the first part of the summary at the end of that email ("CXL core handling per device CXL.cache enabling...").

> 
> 
> I had no time to keep thinking about it. Also, I sent a copy to the kernel iommu mailing list, but it did not get traction then. Anyways, as a summary, I think mapping for CXL.cache requires not just the endpoint driver doing it freely but through the cxl core for ensuring it is done properly and safely. But I have to admit this could be a misunderstanding about how the hardware is going to allow CXL.cache.

I agree! I just wasn't sure of the approach to take here so I opted to leave it out until we came to a consensus.

Thanks,
Ben

> 
> 
> Thanks
> 
> 
>> 3) RAS Support
>>
>>     Same situation as 1) above.
>>
>> Some quick notes: The actual cache parts of this set are untested due
>> to problems with my set up, but I did make sure nothing here breaks type
>> 3 support. I'll have this fixed before sending out a v1. This series is
>> based on the for-6.18/cxl-probe-order (commit 5e29cbd1077b) branch in
>> the CXL repo, with v7 of Dave's deferred dport probe set on top [1]. I
>> added Dave's set to help with getting around constraints with HDM
>> decoders in CXL.cache device only configurations (see 08/18 for more).
>>
>> Patch Breakdown:
>>     - 1 & 2: Preliminary changes for struct cxl_cachedev
>>     - 3: Add struct cxl_cachedev
>>     - 4-8: Preliminary changes for adding cache devices to port
>>       hierarchy
>>     - 9: Function for getting CXL cache info
>>     - 10: cxl_cache driver (mirrors cxl_mem)
>>     - 11-16: Checking CXL.cache capabilities for system configuration
>>       validity
>>     - 17-18: Cache device attributes
>>
>> [1]:
>> Link: https://lore.kernel.org/linux-cxl/20250714223527.461147-1-dave.jiang@intel.com/
>>
>> Ben Cheatham (18):
>>    cxl/mem: Change cxl_memdev_ops to cxl_dev_ops
>>    cxl: Move struct cxl_dev_state definition
>>    cxl/core: Add CXL.cache device struct
>>    cxl: Replace cxl_mem_find_port() with cxl_dev_find_port()
>>    cxl: Change cxl_ep_load() to use struct device * parameter
>>    cxl/port, mem: Make adding an endpoint device type agnostic
>>    cxl/port: Split endpoint port probe on device type
>>    cxl/port: Update switch_port_probe() for CXL cache devices
>>    cxl/core: Add function for getting CXL cache info
>>    cxl/cache: Add cxl_cache driver
>>    cxl/core: Add CXL snoop filter setup and checking
>>    cxl/cache: Add CXL Cache ID Route Table mapping
>>    cxl/cache: Implement Cache ID Route Table programming
>>    cxl/cache: Add Cache ID Decoder capability mapping
>>    cxl/cache: Implement Cache ID Decoder programming
>>    cxl/cache: Add cache device counting for CXL ports
>>    cxl/core: Add cache device attributes
>>    cxl/core: Add cache device cache management attributes
>>
>>   drivers/cxl/Kconfig         |  14 +
>>   drivers/cxl/Makefile        |   2 +
>>   drivers/cxl/cache.c         | 276 +++++++++++++++++++
>>   drivers/cxl/core/Makefile   |   1 +
>>   drivers/cxl/core/cachedev.c | 292 ++++++++++++++++++++
>>   drivers/cxl/core/hdm.c      |  31 +++
>>   drivers/cxl/core/memdev.c   |   2 +-
>>   drivers/cxl/core/pci.c      | 134 ++++++++++
>>   drivers/cxl/core/port.c     | 518 +++++++++++++++++++++++++++++++++---
>>   drivers/cxl/core/region.c   |  25 +-
>>   drivers/cxl/core/regs.c     |  28 ++
>>   drivers/cxl/cxl.h           | 193 +++++++++++++-
>>   drivers/cxl/cxlcache.h      |  42 +++
>>   drivers/cxl/cxlmem.h        | 121 +--------
>>   drivers/cxl/cxlpci.h        |  10 +
>>   drivers/cxl/mem.c           |  14 +-
>>   drivers/cxl/pci.c           |   2 +-
>>   drivers/cxl/port.c          |  54 ++--
>>   drivers/cxl/private.h       |   8 +-
>>   19 files changed, 1569 insertions(+), 198 deletions(-)
>>   create mode 100644 drivers/cxl/cache.c
>>   create mode 100644 drivers/cxl/core/cachedev.c
>>   create mode 100644 drivers/cxl/cxlcache.h
>>

