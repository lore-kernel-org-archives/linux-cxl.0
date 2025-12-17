Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF125771
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995055; cv=fail; b=jwSDUNEAdLlXnotFV5eGE5zEDFT80sW2ox9vw95QintFQZ1GpkN5vaOaZd/zeBM3mjxKHN2xgXPS47oCmpmUFfKTPshFmals3yeJgvqD3pTvMEn7yC+VZjpbZZ4lMeTXlRkdmfA4IguOJ2yr19siLfTZKpD8Y48jjykwHSqoumc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995055; c=relaxed/simple;
	bh=ueYIKbbXxXBiAmrM6dV8zhoZIivWbdXNz+cXVxQf2Ao=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=MVUO5Mi0/qlsCJ+OGAmDaUBbEDP9iDYGe/VFcSYfRrTbMJZSvdtAg65fsVARjQg9c1I93Sikp4mZVslrA9z02W+jKJHybuiwaq5tAlJPWMyzkPW7MbF9AZJIon+9YUykmwEdFdwN+A7/UgFt9+C71ti1AnL8Z6NiOGarFSiJroo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BSoXc1tA; arc=fail smtp.client-ip=52.101.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BSoXc1tA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkscXq6fpjpjH6ehb1MbNKID6/4kvbEMrYx5cyPKJ/143RSrcblFH9trVu8cD7cvtaZECBABAeUg5kV5g1AuuFKgznxqdI8vN25C3/5Jz3EpIJiVRIi87kJEF0l6kPHzc4+CcHr99/YGkPCalHDseGTyIsP7lQqCnwhaSRok1HEU2rwjZWVvA1y3w96u2bF1pALruffGBTw2k2TOMgWME27JFno6KcXEN3W8p8QeL1QJF7mjkeDPzniRSMuLSuhw/9+2WWM3zXRKNSFEwUHz+C5Dzv9LcABtmndovHM+Q4ZPerFHuk8dvOR47wJh3++LknydDll+7TXf1daYTnK8jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBl0tgKpcLsw2lVX5zntMVYbtF8C7BVt8OuAe4nkXqE=;
 b=MlCxiBBxu0Gyj5IL/OajdF3rqM59xYjpylXj9EwipmFh/0PuwpwhV98r31qAB2VmEzfrYAClarchV6SPfZKRe5FLL56RZj8HV36kLxmCICEarwQgU/0Q5adp0mnHK4CBmR7akkjEz8kq/6ecJITfBqcBrLD65A6y8A3Eg1eITnCFIQZWED55hRonBvvMavu2OSn68/12CV2/Ahq9dBbic4kAUX6KqgOJar/PvMTDfohrL6mc5b5N5D5rl1/ESHZ8WNSRdkNptFY8cKf/QchhL+Rm8g94KbcJHnuaV5pc/Nt/7g7hv4MzwxobPS6HlZN6xgxz9d7CbOLjnpON/+5PmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBl0tgKpcLsw2lVX5zntMVYbtF8C7BVt8OuAe4nkXqE=;
 b=BSoXc1tAasP5TrnDtImFcUYYYJI2AiTZLcWXzZHXn4n/GfuY2CGU4f0VGcdYE8aH4RxRcbZSmCqXndveGJL/Q3KErqO8ngzchVCv1RU2TobQbeh2ifNDVaL2LgIF2orQRwOTypcag2FrBV5JAPS7bKUpRxR/sA4Dqmrajli625o=
Received: from CH0PR07CA0004.namprd07.prod.outlook.com (2603:10b6:610:32::9)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 18:10:44 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::a) by CH0PR07CA0004.outlook.office365.com
 (2603:10b6:610:32::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 18:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 18:10:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 12:10:38 -0600
Received: from [10.236.188.135] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 10:02:28 -0800
Message-ID: <0f8c5027-7adf-4891-a287-e9e085842ebf@amd.com>
Date: Wed, 17 Dec 2025 12:02:23 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 12/17] cxl/core: Add CXL snoop filter setup and allocation
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
 <20251111214032.8188-13-Benjamin.Cheatham@amd.com>
 <20251217163556.00001f58@huawei.com>
Content-Language: en-US
In-Reply-To: <20251217163556.00001f58@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3f5f56-54b9-4677-5f6b-08de3d97974b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ulp6SENTWm9mUG5MY3IyVlZ2Q0Jnc3BCdFVsNkZEYm0yWnlGblVhdDA3dmow?=
 =?utf-8?B?dnl4U2xncm9hRzhLdEtDRDZDRTJjOVNZb1NDMEZoQ2kxTDdjRENURzU4MGNW?=
 =?utf-8?B?bXptN0E5Ny9wNTcrYWUxbXV6cTdFdjZLL2VyUzNYZHRCUEVkckxYUVd6eURG?=
 =?utf-8?B?R3JZd3RtUzBKMHFqN1JwekFDWXNHajVyUjVoeXR2L1ZkTW9va2Q3cmpwekJG?=
 =?utf-8?B?SEl0N2hIUXhMc2hlTmMvTno0RlppbjdISWQyaHcyNnltRjJmTVNqNjdGa0p0?=
 =?utf-8?B?OXB1d0t0QWZnTmpVbXJ4cGYrc1BWa2kzb2IyU3FNMXhRTmQ3c1lNZ2Qzcnc2?=
 =?utf-8?B?SlBMZlhnRWdOK1BoUFQ4TGMvMENtUWo5bGJVZEFZd1hYNERodkhSSjk0TUw5?=
 =?utf-8?B?SHBvcFdVdGFLVWRXVkg5YXR5SzlDbXY2UWx6NVZXVUtYeTQ3UEdiTVdSbDFM?=
 =?utf-8?B?eWpVOXFOOFlwei9Sc0J2RG5pSzU2Tm9XUUlhcTA2dElSM2UzTlZjYzhaUjh1?=
 =?utf-8?B?SW9IckYydVVOcFp6WXh0VEszanlsTVRwT3I1TklQR3ZNYnlBMmZxZURJaEFo?=
 =?utf-8?B?enFNTTZnek9FR0hEVnloSHNybml1eHBBNThCL2k3RG9OUDJhcEEzdVZkcXRT?=
 =?utf-8?B?TVdyb0RBMVVxSm9ocVNDOTM4aHlHZGlPdHFiU09abE1mMlNpaHZJTktBZ0l6?=
 =?utf-8?B?aWEvL0dkYm1lanNLb3FsRGZYY0pjQkhFSGY3VWZPaWllc3BDaUVPZ1dianBv?=
 =?utf-8?B?U3BWMWNQYnJhT0oreGljM2JsbHNsNXBIN3hTOU5BazNRaXdyOExhUmQzOHpN?=
 =?utf-8?B?dWE4aW80R2NvK3F2aW5saWNueXByV2lTK1QwenpNdTBjcTQzbmhKb0dxaHdB?=
 =?utf-8?B?RGxxOVVmcnYwbDFUbFp0VFZnZXhEUFJ3Mm5FalVVWVBlbEZKUzQwQjBWTExY?=
 =?utf-8?B?a2V1cVBPS25nNWtzZFJNek9KK2RRaW1xcGJPMTFkRE92VGN0VFN5Umx0cC9J?=
 =?utf-8?B?QmM3VFdsVy9MTVFSQnFiUTV3UWE4alQ0RnF1MEtoOUdOTW0rY3gxV1BSaEpz?=
 =?utf-8?B?R0k1aDBOVkVab3Z1djFEd3ZCd1hoZG05UzdhM05iL2NiWUR0UTVsMjgyVEE0?=
 =?utf-8?B?bDA0TThxL0E1UWcwWjdPUmUxTE1DcU5lVjluTDNRUXdWK0JCVThHeHZPSUR5?=
 =?utf-8?B?aEQ3WXZ0NGt6WW1lQWphcnJxaG1vYnV5SGpMNW9DTTJMN3d5cjBSSjZRS091?=
 =?utf-8?B?UCt3dGs5aTRPMVdLRXRwYmREcFVVRm0wUjVhZHJHckJETzBDMXo3QWZZeWl1?=
 =?utf-8?B?ME5BU21sd2dBdVRxcEtDbW5EalpBR25sOGMxaE9jZGw3WllkZGZHWlBwMmxE?=
 =?utf-8?B?WWd3dnJyUXZ0NFVJcVZWdTNzR0J5bE9uUDhXdWdzR0g5cGFwZ1FSWGt2QUJI?=
 =?utf-8?B?ajVvVnVtbGdnTVdRYjN5dGpYUWFIMnNNNXJUaTNvdWlLRC9OeERuMUR0UWgw?=
 =?utf-8?B?MXJCcVpJOE9HUUJBS2xTRzJFcVE3L1BlaTVWakNsYXJJNEpvanY2VTdpUThM?=
 =?utf-8?B?R2F4NE9BVDN1bVdTeXRCWEl5K3J5eWFURlIycS9mYjJhK0JZemlYRVowYTdW?=
 =?utf-8?B?UU9kd1NXa2dpbS93ZHNzWFcweVNOTEZSdTlxTkY5TWJOQmgxajk0N2pwL0tI?=
 =?utf-8?B?TnJlL2pLd2lCT3VGQzlmMVZkc1NJT21EdldCYzVBWk82NzRxSmZtWXlhMURj?=
 =?utf-8?B?d2JWWldVOEpkVTAwYVcyN3Q0aTBTb0Q1TE8yeDNiQlN0THdUOTh4dzI0WlI3?=
 =?utf-8?B?VWY0dTFhVUNDQlNWdUVFeHkyTDBHUnpISkZnUEh6SktjOTdlMksrRFE1Z3ZX?=
 =?utf-8?B?SVphcTZaNS9Vdk9TZlBKRzBmK3ZEeWczSmZWRk9HaktyZklzYXBTMEo1cGd6?=
 =?utf-8?B?OXByRmVRdlJxREE2cVdCWGVEQTZhMG9DcEdEVWN3UUlEVDRRNkVJK1VVaDJs?=
 =?utf-8?B?YnRBbXdFRGpmN0hJbHcrb29xT2NyejY2YnR1QmpDanhMWXU3azdoMFU2dm5m?=
 =?utf-8?B?OElaUVZlbExDbENtc09aZTNBeGNrNEN0TmxuUVpROU4yLzdSMWhZTzlza0hu?=
 =?utf-8?Q?xKH0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:10:42.0282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3f5f56-54b9-4677-5f6b-08de3d97974b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400

On 12/17/2025 10:35 AM, Jonathan Cameron wrote:
> On Tue, 11 Nov 2025 15:40:27 -0600
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> The CXL snoop filter capability (CXL 3.2 8.2.4.23) is a mandatory
>> capability for CXL 2.0+ root ports that is used by the host and CXL
>> devices to manage CXL cache coherence.
>>
>> Snoop filters may be shared by several CXL root ports, with each snoop
>> filter having a unique group id. Create snoop filter instances as CXL
>> root ports are added to the system. If the snoop filter already exists,
>> add the root port to the existing filter instead.
>>
>> Snoop filter instances are used to keep track of the amount of CXL cache
>> space active under the filter. The CXL specification allows rejecting
>> CXL devices based on the amount of filter subscription, but determining
>> when the filter is oversaturated is most likely implementation specific.
>> To address this, add a cxl_core module parameter to specify whether
>> adding a CXL.cache device's cache to an already full filter should fail
>> device probe. The default setting of the parameter is to allow
>> oversaturation of the filter ("strict_snoop=off").
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>
>> Jonathan asked about the allocation policy when the snoop filter is
>> "full". I had the device fail probe beforehand, but it got me thinking
>> that it may be worthwhile to add an option to over commit the filter
>> instead, hence the module parameter. I'm game to other suggestions, but
>> a config symbol didn't feel right since the setting probably varies by
>> platform/user.
> 
> Doesn't feel like a module parameter is appropriate as may depend on
> specific devices as well. Ideally we want the capacity and device requirements
> to be exposed to user space before deciding to bring it in and how to handle
> minimum vs ideal levels.
> 
> Tricky topic and once we get a little nearer merging this + have some
> device drivers to poke at lets revisit. Maybe on one of the sync calls.
> 

That makes sense, I just wanted to add something to get the ball rolling. I'm
fine delaying it until this starts being considered for a merge and/or
discussing on a sync call.

>  
>>
>> Also I'll add Cache_SF_Coverage support when this series goes out of
>> RFC (I forgot to do it this time around).
>>
> 
> On a related topic, how do we know the right Cache_SF_Granularity for
> a given system?  Might be a specification gap (or I just can't find it)
> 

That's a good question. I guess I just assumed that it would be programmed
by the platform firmware, but it may be that the OS is supposed to program it?
It's pretty ambiguous, so a spec clarification may be needed.

> Jonathan
> 
> 

