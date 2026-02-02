Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7D37F8A1
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053471; cv=fail; b=dDPmDWT2S5jwUWEunKNwUkPTT222edSNP7sHnEAEfS04zcWJLp+RU9u3XRYJUGoZXE8CzYRNavDIwt9iColLvBECl429nIg8Rt7WOcVK5rCc1tApfPXDjMguNWxnlG8lq63BeyF/NgVnbwqPQEcO/q1oLucQNva7g2psko4fA/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053471; c=relaxed/simple;
	bh=5tIRvhPFmPWFbLc7pHYAvg4TWePnkMCUJUOCCRean1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qy74SlgPxioVkoOxymK4J859E+CBGD/vezW7Ghtvgfrh6qBMj+1XSo2cdNASaj2ixP5guCBuM9EbvLYaKW/HwHZzQa68B8IIw3CYTeaVJfjRryJycjWaoko89zlS0Pk+Im3bNOaaqgW/K5GSF3fipuCvpN49rCbybSks7W9292o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x/4cVJOW; arc=fail smtp.client-ip=52.101.193.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x/4cVJOW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ojdp12hsWDP/ZSsPv/ugWAo+XrgtFiILSR/0bdjem83QjtYV+R8BUgD+L2366V138bv5+t/1DUGWOXHtAPJ9zUSt5uzXoLUYz46okiTzof4vD7YjdH5Ddfku9/G4k91+4xf6SS7k+dXNNEspAGFFZwhflGuQAr/pO263WJuFjCyp5B9K8nGnwMhOBlxNYayrmoZjLOvMIahMdaFIQMF6TpTaLq0EsiD3b/qeAioNuacycj2V9CgOGDgUD/ewtDd/FEhJZJqZyReyho2GBXpY11QkEZ7vU9T9ohltmuDh8IIgywK6asiSW5jPginboQlZJtkc59sgsiMHaXe1FGD2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge92cuXPQov9N1Tjx2xBFvgbpIOskuSZQcklVieeFDI=;
 b=jk5Rl31i2uO/Dk9MnENWJ1y44oL/PHdoSCv2QNG8mNYEdphVOIOo5Y9pHehQCMouNUb49OXaIIUl1P+TXtblRvqGCr5032aD+erR/DJFhBekdkH7ozoJlFiigOnWGjJnciMXyPZM61qSOKGVQg4zn6+twdE4PVoymZ8UiXnYWjORWuosx+M9tGHlnp6uV4pxpMXyt+jY7xHRcqvqgYNPaNTSAEoPSeBgFluEq8QQWFW3S640mDZWo2JHPI1Bx4/tBICwPREpFyO11yrF4xn3kINjt1aOhRcXMiJHT0kkwOi2j0ly3uF/iYTv4sRZPNh+tieamWButKos+CHPK/+gcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge92cuXPQov9N1Tjx2xBFvgbpIOskuSZQcklVieeFDI=;
 b=x/4cVJOW2cRagcqdYOHJ+PI+JJrUsUbJM0cCbnPjmhkhEvX+o+MmnKLjAFFf8OvZ25DjwQoCAnBDhLMzuw0wfdAiPpC2rvLeypMV79mlulfB2c6StFIUR5ZHfoHaqgDmi6QmGOZqx56jiRvqs4mCDIUFNIxMT7JzCEgQNPgsRIY=
Received: from SA9P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::27)
 by MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:31:07 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::fb) by SA9P223CA0022.outlook.office365.com
 (2603:10b6:806:26::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 17:31:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:31:06 +0000
Received: from [10.254.59.95] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 11:31:03 -0600
Message-ID: <157db8f0-c8b1-49b1-8641-ccc07471a791@amd.com>
Date: Mon, 2 Feb 2026 11:31:02 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: CXL Isolation Support
To: Gregory Price <gourry@gourry.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
 <aX0jC3DEqcnyrg7x@gourry-fedora-PF4VCD3F>
 <20260202155905.00000cb0@huawei.com>
 <aYDV8EwSx8pM_Fw8@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <aYDV8EwSx8pM_Fw8@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MW6PR12MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6a3766-9b13-42da-3c92-08de6280d87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmpFZk1pMDMxR1p6cDE0dEJkK29VU01aTWFNajNoRmhJQUpzN0phSTY2T0o0?=
 =?utf-8?B?UFVKRzNPckNjSkZsd29LcTNyQm9JREJYVjlnMURoeEV5TXYrMWM1TXoyTm5H?=
 =?utf-8?B?R3ZlL0dIbCtDQmtmWDdZdXd1RUNQZ1pvOU5vQ09NSjZiVU1wMWd0S2xreEFj?=
 =?utf-8?B?YzNhQ093OW5mcWlUQnFVdHo4WTFrWnZKMm0vV2FGdzhOSHJNdlJ1enJrN1VZ?=
 =?utf-8?B?VGdHL0xZdTJrekMvMzJ1OHIvNTAyQ1hSRExoV2NhV0NwSVQ0ZGxsRjlneUw5?=
 =?utf-8?B?MXNGeW0zTG9PdEF3Vm5Yd1dkckptUUc0SFE5LzVtc0FEWXNEbVdvS0ZmT1VS?=
 =?utf-8?B?M05jQTdGZVRPaCtNYVVtY1ZFTG04clZ4bllzcXplNVA2enRuc0R2ZWZmU2Nv?=
 =?utf-8?B?cldpek94MVRabkE3VG9hNFladUM4QU1BMnB2ZTlOWURFY0JMVEhEdDl6M0NR?=
 =?utf-8?B?clAyMXVSQXhOMXdmdklWZ3FJOTRNR0dSQXRFRHI5NnNvdlVubVJ3SHhBWGRo?=
 =?utf-8?B?S2EvYmJ5aFlQbXlFdXBudzNEN2pxTWxyL2VrQXEzQzJsS0F3ekZFNHpCU08x?=
 =?utf-8?B?MWFISmE0R21URDRrcnpRNGNXaGlFYU40WVVXZWcwWmZqL0VnaDFkTkdlQUFX?=
 =?utf-8?B?a0ZZclVleG9NcHdxMVZ1N1JOdDJvUjhMSVR0aTdJVURsUE9YRm01U1FQOFF5?=
 =?utf-8?B?NzUwaWQwUmVGSjVKc0ZFZlJuS3p0NElrcnpvTEoxenpoQ0UzU3czZllQU0U4?=
 =?utf-8?B?SWE1bU00MDZHOXdnZ3Q4Ulp5OE8wdGxOeUZjWUxqRFJVRVREWjZNSGxlc1Vl?=
 =?utf-8?B?TXN5QW96bm9vNHVMeFVadHhnOXVvVnB1aTdpUzJSWG9NZmI2dzRFWDk1UEt3?=
 =?utf-8?B?TWdsYUhsZWpyZ0RGYjhJQ1lKOWJSTm91MmNRSndMb1BZeERuRUxvR3lUQlhy?=
 =?utf-8?B?bmFtQURJeDUwRG01YXZQZ2dpeWs1b2U4czd5R1hiSmZXWTk2R1ZqQU5CbjZE?=
 =?utf-8?B?dDVkUVJkNkNNblRRdFg3NWlPdnRCR0RVWG9Pby9xVk0xUEYrSDBmUExzeWdw?=
 =?utf-8?B?K3R3bzJNZEtZQmJNM1UvUXBXWTNSUGZISzVLdi85SXcvZXovTS90TFJvRTdm?=
 =?utf-8?B?TitKbUc1L1dVaHNnUVFkdUVybnJIUTI1YXFKVzgrKzRLVit1amc3UTdDS0k1?=
 =?utf-8?B?MFpGMncrTzVQVDRjRHVzRmw0ZFdVVXd2YUN1cmY3bjdxZnVSK3FqZTdnellu?=
 =?utf-8?B?T0VKS2pIb3h1ejRWeUxrc0l4N0tBRVBIbUc3dGFxYko2Sm92OHdLQTNrNXk0?=
 =?utf-8?B?SzZhVGJTV2h3bFZlZlM4VTQvOENNaEtSUVd4cFdKd1Q4dmhxWDIvMEdZZ2I1?=
 =?utf-8?B?QmFVQ3NnTVpzY1pMMUIxdXRrc29ORmx4Tit2T0tyRDVwQ1B4UDViaWdncnJE?=
 =?utf-8?B?eUFsRzZLakd4VG5JZ0hlTkNya2hNSkowYkVXazZGdFM2a2wrOTB5N2hId0Y0?=
 =?utf-8?B?cmVrMFhacXZDVkdXaWtoYXQ5OU1RWG40UDdRcHJjQzdqNUlFNkdNOUJvVFVr?=
 =?utf-8?B?dmNXdGg4VWI0TGpFM3B3WDdHb0lpQ1l1MTNLU2Z2VUpWNzlJallmMFF0OVJL?=
 =?utf-8?B?R0NyNGhQUDBXeVN3SjREKy90S1hvT041QmhEQWMwdElFbG1sREc2dWJma1h3?=
 =?utf-8?B?c1pKdnNta1l3eUxTT1dmVDY1Qlc0SDBYWEZiOGhkdUZaY2tCbnFzSTQ0QVpp?=
 =?utf-8?B?NUNFSVZqY1lpeTNwL21RMXcydVQ0RWcrTEVaT09qTjBMVUhaNEthejRqS1hj?=
 =?utf-8?B?Z1lIMGxFaHBsZjV0dWRnZXYvdzBpVTAwSThFYjJCUnB6NTlwNDJ5YndkYis1?=
 =?utf-8?B?cnNJeEZWaEEvVjQzMFZtYXhYWkhrWi90RVNFMUplaFMxWUhFK0VPR0kwNFVZ?=
 =?utf-8?B?VkR0Z1ZyM01ZbDNhdHNnSXNzOXpRNEJMYkVad0JHQm90VnlkaENTVS81amVx?=
 =?utf-8?B?cFMvQVlpZDV3aFQ3bUFyeDRROHhWR1l3V0FsL0RFTXpaZ1kwWFd2dHR6K2Q2?=
 =?utf-8?B?cW5ZWU1vdVZKSDVPQTJxdS9GRDAyK3p2MGwrN1JYUVRUTXROQ2pvVDFUWWNP?=
 =?utf-8?B?aHIrRElncU1TRTVja0VQZXVPZzNmRk1hOUc0NjM4UjRiNk9UaVZhd2o0T2R0?=
 =?utf-8?B?RzIzM3RkbGxDM1BQT2Y3L2xUN0hXWUZzS29hb1REeDQ4U0V5S3BWNTNtYVIr?=
 =?utf-8?B?LzFWTnc4Lyt4NmM3RE5ZTndtaG1RPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GcWwyk4txqcTcKQCTUtc77OyZT9qQE1P+CkxQKhmlaoEtE5IJwlu+OSxsxBDWDmu1299LBdtaGVIvlk9B7WbIzUoTz74XIG0bGHnv3vGZRLMJtVu0vcMZb1bky2XYfVjkO4SC7uqYwcWM23P3ihhcbCunwISst/TBSEMxjzFsbDe41kPpN7TObUfRAG42mCOQeFYrMShTQXSmWAZnDCZCu77JK6+o5NZ9SsIin4jZ4IgW+yZ21vhU3Ci8JtI7RIwCh+dGqHGc8WEUbtYXDEMKtN9oVyUZknc/qw+u8vwlLqv383mkFXXcQrQiUmMOT+dCXBimvvb7Kb3WJ879r5bCkAc5Z1Rr3KMUp6bVJXRfMg3F5w6lquzlzrsTv9/ODx/Fsf/6dapkONfnbMdXfwx73fIaVR4RouMDxUc+wacsOMVNOgALa3PveiOY0MjAoAi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:31:06.0117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6a3766-9b13-42da-3c92-08de6280d87c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7072

On 2/2/2026 10:50 AM, Gregory Price wrote:
> On Mon, Feb 02, 2026 at 03:59:05PM +0000, Jonathan Cameron wrote:
>> On Fri, 30 Jan 2026 16:30:51 -0500
>> Gregory Price <gourry@gourry.net> wrote:
>>
>>> But even then, you have bigger issues for shared file-backed VMAs.
>>>
>>> e.g. imagine libc gets demoted and comes back poisoned: kabloooey
>>>
>>> But, you can at least get data from the system that the link went
>>> down and even have a chance to investigate before nicely blowing up.
>>>
>>> Which is at least much more helpful.
>>
>> Let's pretend it's tagged (just for ease of thinking about it).
>> So shareable that happens not be shared ever.
>>
>> Application specific memory isolated to one application - using
>> famfs or similar.
>>
>> Then it's safe enough, but maybe not that useful.  It's a possible
>> path to get to a world in which type 3 mem an be isolated.
>>
> 
> Absolutely.  I agree any kind of explicit-use isolation is feasible to
> implement large-scale recoverability.
> 
> But I suppose to clarify my concerns - I think isolation guarantees
> require much more clarity on how involved BIOS can be.
> 
> Auto-regions online memory as nodes by default.  If CXL memory is online
> as a node (in the current kernel) - then isolation is broken, even in
> ZONE_MOVABLE.  No amount of desire for recoverability is feasible.
> 
> This obviously changes if the exposure is limited via some explicit
> mechanism (FAMFS, N_MEMORY_PRIVATE, etc).  But this is already true
> of those paths - users of FAMFS will get SIGBUS'd instead of MCE'd on
> poison, for example.

I should add that, at least on AMD platforms, if the CXL link goes down
the system will immediately reset (AFAIK). So this use case would require
enabling isolation just so the hardware doesn't rug-pull you.
> 
> So if isolation is desired, then the default opinion should be that all
> management of the CXL bus (endpoints, decoders, etc) should be deferred
> to the driver and not programmed by the BIOS.

I think we're slowly moving this way, but it isn't feasible for current
AMD platforms. However, I don't think this is too much of an issue for
our platforms since recovery isn't supported anyway.
> 
> Auto-regions are basically incompatible with this feature.
>    (for more useless information - see: $REASONS)
> 
> ~Gregory
> 
> --- $REASONS
> 
>    This is partially informed by the fact that auto-regions are defined
>    as BIOS-programmed decoders - which the current driver auto-plugs
>    into the dax_kmem driver, and we're stuck with that unfortunate
>    backwards compatibility story for quite some time.
> 
>    And the platform which use auto-regions may not adhere to expected
>    programming patterns due to some subtle deviations from the spec.
> 
>    So tearing complexes down and reprogramming them may not even be
>    feasible.  ( cough Zen5 :[ )
> 
>    But more generally, proposing additional features for auto-regions
>    creates an incentive to push ever-increasingly-complex policy down
>    into the BIOS, which will just lead to sadness and heartache.

I agree :)

Thanks,
Ben

