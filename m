Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CBA37F8A1
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053468; cv=fail; b=eemao16vVUUorEzv7tNSU77qpyeIQVQ/BqIVugJpgiSWpiYGgFqNPHAV8E4GsMdElZeMRCGY0YstU1uzCpKQcyMYb84UCtad/xbPvyAQA7dzXvvGYmsgH6nUHX/eQHrUFO9G+nb4hkEIZIQDWUi0flCwOndomw/23q6YPPEGKB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053468; c=relaxed/simple;
	bh=c2s7i+2LNHIKqwuGkcnILa1o4inlJER0VqiggfBV5sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=udkVOPL5v44bIqiUkC2dG7f423UnZd0kqqTOeNPS2mQH1EUj+ylbROuwZErlEoFAVZrczWFfViFVAWgOkr7XdBLoBIe5pMqVeeR5584CTSDFEvcxuNs6NDTUMn9h7ZmHhds62XnNMsdHAFeeXo36dR60aRv9bIBugEfcJXHm70s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aR1x9esJ; arc=fail smtp.client-ip=40.93.195.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aR1x9esJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhjH7/EgY/chN8kgcN/q3uM1XrKf87rZDiLoSFRUmXjm1mjpHotqvUNArNSlHbZYLEvhB4w9js2Gvu5HkRFflThMdq4XZd4n+/SaP4tL3DvEuYHwMZed+stCZOUSCw3gVNKU4jIOFL9QXQHxGe15/sDz3Cyu9n+kO2vSGQYfe2cKsCUpas07iOxXeR0GxyFXBshZ4x36V16dqKSblrVrfEb0xzldZVWn6xugWArB9+v2PnwX2oaCPAVdvjpXXhQOEL2KIPxejm+V4IwCViWHr7cYkHg4DBinN4qE5m8BEFJh8fCB2GcHeeXVmDD+isGZxXHG6TTS5Ks8iW0IKVyc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSmiNJr6WV0PX3mUqzll27CGBjtJxmCqKbpQ9ey4XyM=;
 b=EZyiBdS1E9GSSsLnUbYdM3IgzCk/aW8ZZhi4nAb5NTG+59bqRMAl58lSaJI5SW/CJaZr21pmao47d0FTJd6/KtqFTLhKy8rkosz4QvPBL6mk1LZY/BflrTBz01klRwGisEg2Ls832wIFavOKbDumO7kWR/Fu2Qsmt9HGsF2syAfzu6JEMbexEF3f9P/BnhKRPSQPwYYbJKkv95axpSeOBKi39JkVTZGduoSSJQ6mEOFMNJeqBKE4f4PKKGNaWQYZpc9D7hFHoFDeYbNyoBHaRWABE39JcJz4sD5M2LFf2FLMJJoY59yisxm3fohsaGlYOPSPN3/v4NTshya24o0qHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSmiNJr6WV0PX3mUqzll27CGBjtJxmCqKbpQ9ey4XyM=;
 b=aR1x9esJ4iGgR4EA3z+g87PTvg6jPwy734AAqsPcAGRYm24qEiR+jeMMV+MQjnJpDHL99DYduZwI2uFT6ACF2JU1b3eM8uhwREKg5Ly0+GlH6TrjCjgVkVMJPkTleA9EOaK7ulWvWrgJE4sw3m2PlvKbOhjc7NFTXgHbH4Aemgo=
Received: from SA1PR02CA0017.namprd02.prod.outlook.com (2603:10b6:806:2cf::23)
 by IA1PR12MB9497.namprd12.prod.outlook.com (2603:10b6:208:593::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Mon, 2 Feb
 2026 17:31:00 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::a) by SA1PR02CA0017.outlook.office365.com
 (2603:10b6:806:2cf::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 17:31:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:30:59 +0000
Received: from [10.254.59.95] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 11:30:59 -0600
Message-ID: <df6bd8d3-f11a-4b19-af56-1593e5c87298@amd.com>
Date: Mon, 2 Feb 2026 11:30:58 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: CXL Isolation Support
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>
References: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
 <aX0jC3DEqcnyrg7x@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <aX0jC3DEqcnyrg7x@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|IA1PR12MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: 11500312-d455-4d32-0b98-08de6280d4d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eThOMlEwOGJTMk91eVgvMzBnZ0U2d2VDc3hNeUJBNE9lY20zeGtUWmxQeUF4?=
 =?utf-8?B?d0xaK0NvYkxGUXFvV3BCMEFvK1lybm1UQnYzOE9TTEZaNjdBYUdsaHNqMm1P?=
 =?utf-8?B?NFpFNmw2S2d3eW90U2JVL0p6a2dObk0vTGQrN0p5ZlZFS3hKa2hXOS9xSG85?=
 =?utf-8?B?ZmpiYU5JaW5GblNGekdINThOd1ZiNDlKcmtEVTBBOFY5VWowdzFiT21vY1Mv?=
 =?utf-8?B?NXhYendyalB5TEt4ekFSTDJHWVA2YzJiM1hXcWxqcHJqVU1SNEI2TUtaa1ds?=
 =?utf-8?B?SXdzcWcrSldXeVNZVmJsUnVBNkROZ0hWNm90RHYwWlFqUmpEeEVKT3IwZE40?=
 =?utf-8?B?R0FrUU5XTVdNWmpMbWxXRTQ0aUFZbDBqeVV6MDBCM3JMazNtMXRMUlFIUGNN?=
 =?utf-8?B?T1NsMVZSNGM3bXU5amtuTzM1eFJWbmdHY0lVcjRsNDhVWVk5WGtaSXF6SGpm?=
 =?utf-8?B?N28xckpsNWtpaE1Bd1NkcUl6cy9yazhoZEpTUlB0Y0lJQzV1RXVFUjRTN0Fy?=
 =?utf-8?B?bGxOaC9jbWJzZk1iT3J4b0l1V2hEcWxQOWlHRmtoQnBRbkFvcEdNcHBrRVZY?=
 =?utf-8?B?NXkwUC9TWncrbzkrN0owcC8wckVxV3VZdkxUM205SHRyU2tVcitRTDh0WG0v?=
 =?utf-8?B?cWpFMmZ3UkFoazNQRWlpQ3pvOGdvZERQWlNMcUFxSXpPNDZ3aDdWVE1GQnlu?=
 =?utf-8?B?NU1FR2llRlZrb2RBb0hkcGNmUThPeXlRb3Q0eldhUW11bWxNOXA1OEpuL0tO?=
 =?utf-8?B?RHpqVm5CeVFVNjMyQ1JUMnlVTVJDN0FyZlRNa1hOWmovT1p1MitZOWx3R2RR?=
 =?utf-8?B?RUhDbkVLQVI0c3k3MmNkUDg5UFRQbjVqTWhYWlRNeGJtZWRiQitscllLT2RI?=
 =?utf-8?B?TG5aUWJZd3dHK3ZDUFJpQUM0VmxKVU1tcjRJbVBaV2owUGRBTkpFcXhIRjd3?=
 =?utf-8?B?K3pXWDl0U1dIQ0xCMWZFRlIxU2Jrb2VyVWdYZ3ZiWEc0R3FvZERQRE5uRUZV?=
 =?utf-8?B?WTRIb1BPck5xd1hrUHZmUXdQcGREV3JsTUpFVTQzejVqVHpkK3ZQc2JLUXZO?=
 =?utf-8?B?VE1UZEdobU5TUS9Kc2NSSXdIdmNycSt1NWZZaGdHSzc5Y2xKWEhrL0dRekVx?=
 =?utf-8?B?UXdacGFmMDZRN2ZvRTNuUUNOaDltVG5qRGFtNURSa2IvSytKdmNzUzE4NXI3?=
 =?utf-8?B?MDM2cW1JVFlSMmRXWUVSd0hUY3dBUzFxTEhzRTNnZ2hHUnY1TGlLSjRQYzJB?=
 =?utf-8?B?UC83Q0xhUDBTUURvYXBaUTZaUVNLNklnRGJieTlNdjk2NnhpTTlPTWwzcXpK?=
 =?utf-8?B?ODdMMjJnUFphdWN0dVROV2ZydDhwS0x1dTN2SlcwZzhabzhTZFZCTytjeEpL?=
 =?utf-8?B?ejBZcmlHeGNrTEp0bjQ0UTNLcEFYVWhqUjRMYUg5QjEwdUd5bTlHYXlYdWVV?=
 =?utf-8?B?c1hDY0U4ZTFLamw3QWxtRlYzYmx0MDBLajdrZzhPeGtmNkUwY1JYbHMzTkRX?=
 =?utf-8?B?WEpURTlEYi9FTU1veGtpMk13RFh0THhGTDBocmlQVEpQYUlxVGJsWDFwNXVv?=
 =?utf-8?B?ZXFTb1dZM2NDZU1aZ05BYktpOUswMlVzNEFpdWQvNFcrRk0vMHZqVG9KMUJV?=
 =?utf-8?B?RlByU2pGNE5LdFpPdE5nWFRiNlhvdkQ3TzBmUDdOT1p0MTlwRUpWbTNINjhz?=
 =?utf-8?B?TUt2cXpRR0tDVmNxU3hTNmhMTnNBZWhkUFRaWHMrN2YyeCs4ZktuR1VGY2hJ?=
 =?utf-8?B?MjFTbHRKdDVFVFpacnhvZnFxTm95VlB3bnRrYzVRK3U0SHg4cXd6ZWplYUQy?=
 =?utf-8?B?M0pzTklmdUNTZko5YXVtNW1CeFNyeDZOdENXRm8zWlYrZmlURFdtWmk1ZVpI?=
 =?utf-8?B?OEZrbSs5VTdncU1sb2xTbUhvVGtVRk4yR1JodnJaaFphNDFDNUt3VTRaRWlP?=
 =?utf-8?B?UlNQODBpOTZDWm1qOUt5S2lkM1VRbElEbjh0c0V5VmpERzBjSjJNQnRFRmNl?=
 =?utf-8?B?TlcyTHFLdDhQT1ZDSjdDb0ZqWWFhR1p0YlNKSW5CNjZXMjZ1UHc4V0dIa3Ja?=
 =?utf-8?B?UCtrNEg4cXpWWXlUeUNuK0xnZFlYL1RHL2U0NFhUNzNZWkhJQVBuRzBxTjJQ?=
 =?utf-8?B?V0NCbm1aR2lzeisySXFEUEhVOTh1dS95ZGJXWWhMaUNOcUVVYWZ4WU5qM1VJ?=
 =?utf-8?B?TVpPZ0JLdmgxV0g5Y1RTakF3bnozcHFRQXNrcXV3WSsrMCtRUloyNHoxemF3?=
 =?utf-8?B?emlOZVlvNTdkcm9jeHk2bUpuRWlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/xsQkKtotyesyCfT5PRTul97tGvwLdDS5ZPxwPyI91tNferbZ8HyxrY+I2f0qiLueYq0WgcifLb4ttckjBf/eyT0T2rRw6VVP0ZxHV0Kiv6yKGn9xHbsfksQ5B5DRoN1CN/zh6ckBJQW9zMdxqYZdf+NvgP0m7zJ0gvj7Knxyu0wNiSImgU/RWTbbEzAxHwfJXv/6iDcBpNg3D5TCxzqYAnuCXKaMdXbHgaCMjuaUdqRQ/zTwbAxKyVFsycmx7kpfRv/V84domRFmiZ/LqprcCv8MseRkdG9h9btkfqrfqCS/BiIBBfzIBZsn3fQ/dcLdof636nOiEOJumlvB5DEym5KIqmr0hz71rKRG5YP5UqcFSIuhkabeq0x4wWK4ta7Gp1/9KhbP/EQzk2fynT1MtbIDyMNaj1PNtB1kahlr8ObwGJkQpd0FgFe9avXC0P2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:30:59.8573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11500312-d455-4d32-0b98-08de6280d4d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9497



On 1/30/2026 3:30 PM, Gregory Price wrote:
> On Fri, Jan 30, 2026 at 01:47:08PM -0600, Cheatham, Benjamin wrote:
>> Technical Details
>> =================
>>
>> 1. CXL memory may be used for kernel allocations
>>
>> Kernel allocations in CXL aren't a problem at the moment because if the CXL.mem
>> link goes down the hardware resets. When isolation is enabled, this isn't the case.
>> The kernel can keep chugging along until it eventually errors out trying to access
>> the now inaccessible memory (possibly causing data corruption until then).
>>
> 
> Two points:
> 
> 1) isolating the normal native sysram usecase (N_MEMORY node) buys you
>    less reliability than you think. It only buys you kernel safety.
> 
> Keeping kernel memory out of CXL only helps the kernel report problems,
> it doesn't necessarily guarantee any particular system state in
> userland after that occurs.
> 
> It's entirely possible (and altogether likely) that a large swath of
> userland will become inoperable if the entire link goes down and a bunch
> of that memory was used.
> 
> So if the goal is to have the system fully recover, this would require
> much more isolation policy than just keeping the kernel out of CXL - you
> would need most of the baseline distro to set cpuset.mem policies for
> core services that ensure the userspace environment doesn't completely
> blow up.
> 
> But even then, you have bigger issues for shared file-backed VMAs.
> 
> e.g. imagine libc gets demoted and comes back poisoned: kabloooey
> 
> But, you can at least get data from the system that the link went
> down and even have a chance to investigate before nicely blowing up.
> 
> Which is at least much more helpful.

Recovery is the end goal, but not the immediate one. AMD platforms don't support
recovery from isolation at the moment so the goal is to just keep the system
from immediately resetting when a CXL link goes down. All that let's you
do is a) choose when you reset the system for a repair and b) get more debugging
info, which you already highlighted.

> 
> 
> 
> 2) if N_MEMORY_PRIVATE nodes become accepted, this is a different story
> 
> In this case, the nodes are *completely* isolated except for *explicit*
> use cases.  So a distro can in theory build a policy that dictates what
> types of memory actually land on a particular device and how they can
> get there.

Yep, this would make supporting this *a lot* easier. It would go from a
heavy lift for the end user (configure memory & guard against critical allocations)
to something you just leave enabled unless you want to hotremove a card.

> 
> The example would be using mempolicy to opt VMAs into private nodes,
> while defaulting any given VMA to N_MEMORY nodes only.  This would be a
> more reliable way to enforce isolation of critical components.
> 
> ---
> 
> From a reliability perspective, my opinion has always been that kernel
> isolation is a way for the kernel to deliver higher quality debugging
> signal when an issue does happen, because when you're trying to figure
> out why a million machines with CXL blow up - that little bit of signal
> can save you many weeks of trouble.
> 
>>
>> Gregory Price has submitted a set that changes the second part of this flow to instead
>> use sysfs [3]. With that, the need for udev rules is removed and users (or their tooling)
>> can set their CXL memory to devdax mode before it's added to the system. At that point,
>> all that needs to be done is restrict enabling isolation to CXL devices in devdax-mapped
>> regions and make sure the memory mode doesn't change (i.e. devdax -> sysram).
>>
> 
> Just a clarifying point - the sysfs entries are representations of
> kernel objects.
> 
> You can still do what you describe with a UDEV rule, just now the
> sysram_region provides a step in which you can set the ZONE_MOVABLE
> rule *before* the dax_kmem driver is engaged.
> 
> UDEV still possible, but now cleaner.
> 
> detects(region0)
>     probe(sysram_region) <-- or cxl_devdax_region for device-dax instead
> 
> detects(sysram_region0)
>     write(online_type="online_movable")
>     probe(cxl_dev_kmem_Region)
> 
> tl;dr: Now you don't need a weird unbind step.

That's what I meant to say. It's possible, but would become easier.

Thanks,
Ben

> 
> ~Gregory

