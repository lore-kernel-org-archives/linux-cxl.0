Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012015.outbound.protection.outlook.com [40.93.195.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD832B98A
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770324559; cv=fail; b=KyiV7ADY3GCt+cz78cNoJef8DS1J/NL8Y4Dodj1C8Os+tuBU9gs3BOdfjCpayX1hyzUFP2Y0jnmuPqHubEj2t4IvAuv0L2tdKnglcmt3xBO1Q8N9p4ab7jg/y+n5qKdDqf2C2X5PWqzivB9x/rB1Nf+hPJX+d7c4wydbz6mLnyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770324559; c=relaxed/simple;
	bh=+8CcIkm5zMBJ/1z5bLUSNyUvC4yWy5dbo+LMSi56ics=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OmmbaAY35SRVex7fplkB2fwy+GrZDTrd2jVmedHnX6vc/s5ntOCRl6GhUJL71UMuDVHYWRvBYth+YVCFGg5d5gVqLEljmRQIUH5E0pq6HuOBenoj8gPCE9Y3YaiAEn10DzMnEOkRDErb+ewpj+5G1IXu3tEzehr7/b78j6lq/NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bvzLf24I; arc=fail smtp.client-ip=40.93.195.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bvzLf24I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMME/ZD5U040zrDL/I0f7brK+DhIA1DWkzWFmICDv1I8QAUxnwesOPIOxXWWaQ144yp+KztVgIejqvZZgPy3a0q9yRf9iJzRQvOb0EIve1wV3iWoJpYUZqNT8dxT3I/dD6PiLlQmgIpcIBdZlnVJTsSWIUjVfcW2cpL/GjpG0Yud6xYj3YKnRS7Ud3a+0ku30mCYhYQjQhw0pCPwMbbXNeqUGNyb5vNxtmAWvZ030G98nNVREpoJw3SwJjOgkAbJbKrrsrfLxKiGrCPH8PcwvN5CMLoat18TB6/lz4MhSBIrlrW7DeLi4vmHSQY+3jWjLXPLy2aDddsdLRnkSssm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ6nh3XcUeZMAsfWy458poduhmMGgLbKcehvYU+LKfA=;
 b=K0GxVat936Uvc4Coa5UnmfLvI0yyLNQF9eVpGRux/jJjwX6pczgTivIsRICYqPdD/eqhlanxJ6OSu9h/43uwGR1rju97djsz5OafYk7A8aRJVRPaukIc8W+HHX9X/Z4Uv1v7rCucZZsA3JpwYTuK92BSnUWfiHxw+cWSo5rBwj6aiHZj0cjAqzhqzASNiG4c0GrtrOoNevIYmUxTUVYgnfGXnm22HPH0DGd4x7EDOlQ0oEGcLqT1A6TYBNQEQW2W+t0LFS7qwAdqn9xyB2FJ+hnatHFzaX34ie9HM6Z4sxOkGFMka/7X7Pc0JUzOWsgGjlJcekOB/b2bf/opOzWdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ6nh3XcUeZMAsfWy458poduhmMGgLbKcehvYU+LKfA=;
 b=bvzLf24IuGQKOLztSUK0HqQalss+neHkp2tJl62tJZNNd4KB4SzfksIE44P4/n4+FzDQ/6KaB3U36SyRf567d7BKdB2dow7PttTiHRzirwGt9pjugZcgFBYbaY1yWvSjm5zXleUUMym6eUsXVimk5Akn3Th6vW11DeLhS1no7hc=
Received: from CH2PR18CA0056.namprd18.prod.outlook.com (2603:10b6:610:55::36)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 20:49:14 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::4) by CH2PR18CA0056.outlook.office365.com
 (2603:10b6:610:55::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 5 Feb 2026 20:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 20:49:14 +0000
Received: from [10.236.180.48] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Feb
 2026 14:49:13 -0600
Message-ID: <75eb28c0-e696-470f-8cee-c47bae6ee15d@amd.com>
Date: Thu, 5 Feb 2026 14:49:12 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: CXL Isolation Support
To: <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
References: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
 <69810708cf7df_55fa10055@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <69810708cf7df_55fa10055@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a345e5-814d-4da4-db54-08de64f8058e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|30052699003|82310400026|376014|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkpLbEF3Y2taVVZ2MlNpeU9pVjBLVlFRUG01WHlDVXFTaGRpZVBOQTd4NSsz?=
 =?utf-8?B?YWR4Smh5RkJwRjRRbHNyQ2NwQmhOYkVidjE1Q0JpWXZucktJZE5MRmZrU2FT?=
 =?utf-8?B?UzlnVndOcnRTK3A3L2dUNk1najNBYWhGNDBjb2p3NE40Mjhwd2F2VG02UHkw?=
 =?utf-8?B?V29wTHRwU0xCb3lDN2ZxbVZveFRxS29UYmgyK090ZTUvV3hhaG5FQ1hhT2JR?=
 =?utf-8?B?UkVtWnV4aUhrNEZLcE5icGhQRnZjKzhnb0tpaEVSTFB0dDVJbUtKbG1qU24w?=
 =?utf-8?B?N1lPZW13YjRkZjBLOEtyVldPbnkwL3hPUUZpTXVwWW1ZNnAzZURObzI5bmhO?=
 =?utf-8?B?QlZ2c09RK0NaLzhWdTU3TU1tNW05ZTJjRFRuZDl1V2Npbk5Jakg0QjZMN0Fz?=
 =?utf-8?B?ZkxlVk5iMHVpRW1EV1ZEbFJKUnVuZC8zUFllTmJiVm01WG9YNmpNU1lvSkJG?=
 =?utf-8?B?UzdIcUNZNGswRVV5MVc3TnA1M1pQT1h6d2xaSjY2SlhHYk94U1ZTM3A2Z3pC?=
 =?utf-8?B?SzN2YXM3OThGam9kaHRERFVMRGNwUFZmTnJ6OUMyV041SURtYTlFK096Qjdj?=
 =?utf-8?B?UVVLbmVFcDR6RDBLVjBTc1BVRnlhYUdUYzZNc2VpcGNCU2lXc1BKNnNLVTdI?=
 =?utf-8?B?ZDUwTFZxdU16dEV2aFpIcFBFTEhsZnhFb0IvK0tzR3FYV1NHZXQ4K1QxWnQr?=
 =?utf-8?B?ZDNDWmJoNzN4UjhlSXU2VXhWaEFtWHh6TUdIT1N5amc3TCtoYlNObkFkN1ox?=
 =?utf-8?B?dDZVZWk0bXp0cTB6QlhPQ09QbHpzN0ZSekJUN2VQNWRaalhlRWRrTG9DWC9D?=
 =?utf-8?B?a2xxNVF4TFpJOThtdlowSnhKSXowTGk5L0xjMmV3MmpxdjhVdkhocGhvYXIy?=
 =?utf-8?B?Ym93MWVsbG53RWx1dnJIdnJ3aWZnWWNwbHMvb2FQemtCRTRkc1plcEdQZGhr?=
 =?utf-8?B?RGRucEZFVHVhY3VUVk5NUVFMTzFrditIWjY5ZktFSmhnRDk0T1pXVVIrSHBm?=
 =?utf-8?B?aHJReG1zV1M5aG55TGNhY2lCbkJUWk0wb3dqdUlKWElDVi9yUlBYU2Q3d29Y?=
 =?utf-8?B?clVhc0FYOTJNaDM0M0RNdU1YZVc1aEpPcFdWRFRzSmhReFBZbFNUalVkV2Nv?=
 =?utf-8?B?M3g4RFFPY0NnbmNtNjZvN2h0cFdKZUhRdlFKSDN0MHhJYUZFOHY1aHN2Y1lK?=
 =?utf-8?B?VzRSMFFDZ004ZU11Wi9DWlppVVBnbmpFTmNJQU9kZGtMSTBoRE1FYmhyTGMz?=
 =?utf-8?B?Q2NjOGFyb2NNRjlhOG84MDBPNUIvYzB2cUdzdlNDUkdrZmVFbllhVTY1MDhL?=
 =?utf-8?B?R3ljcmJaQmQ2eFNnZ1puM2ttZFpaL2Q0SGw3RVZ4UGtPYWoxa2R1VVZ5WCt0?=
 =?utf-8?B?R0hkTUVUT3EvVEJLWGRjY2trY1V2cTJ5d0J1QktrdTh4R1lpRFI5NHlqRjBS?=
 =?utf-8?B?cUNBWTNGVWt6WEJkYUtxZWQwK0x1Y2dVazlKRUZ2b0tGL2RLY3lmcVkyVmwr?=
 =?utf-8?B?MTN1VXlodmI1alE0SHZmSEYxN1hSUDFjT3hIcjcraGZ0dUlOR09ud2doKzU3?=
 =?utf-8?B?WEM4dm4zNkJwQkVPOFlNeGwrMDJ4SWNnUVNGaVdxR0NEb3IrVXVJMVlUZjZx?=
 =?utf-8?B?NTZCdUtDdTVTL3E1MXllcGo1VXNXemJzcDNIeGt5UUdQT1pDdFpDWWpheVRm?=
 =?utf-8?B?QnhpRnlRRVdqRVIvcDRRN1BMNFgxU0VUWEw3Ylp4Z0RMeDZGNzhkM3RjY3Fu?=
 =?utf-8?B?OEdMSndIeHRyalN0V1IrcUhERU1hK1dOMDhob1FrNm9hVHRBQWM2QS9FL1FY?=
 =?utf-8?B?ZDZST3lhbUczalNhMHIvclUzdUl0QTFkeFd4MHdaZUdaT1g2UTgwY2FLaXVw?=
 =?utf-8?B?d3ZDTU1YandhV0VtSGJ5RWs3aE5OY1VwMlE4RW02MWhmdFpQWnlBV1lCSGdv?=
 =?utf-8?B?U0hhVnpUVlhobHpCUWtTd2ltaEliSk5BVHYvZjZ4cWlJVW9PcG5BMjlWMnAz?=
 =?utf-8?B?OFBZbWIyZ1U2dEl1ZDVUUmt5SFpUUVRtaTd4ejB3aGhVK2R4UnlEWXN2SWx5?=
 =?utf-8?B?emZRcTZxOWhmTSsyOFN0eFpYYWpWYk8yb3A1a1JlcmVwNDZWY09Ld1dyTFVk?=
 =?utf-8?B?K1FNVTk4djRNYkRmOWVVRWtEeXdGTzVWWmhyQlMyc0NmdnhibllrSmpKY1ZJ?=
 =?utf-8?B?UDBzR0RXV3Z6SWkzM1Z4cnVNNEUrcVVZWlJKRmMrVVZ3RGVVbGxWbkVLbkRh?=
 =?utf-8?B?R1Y3dEU2WEQ1dmFKbWtYMVkwa0VRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(30052699003)(82310400026)(376014)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s2tuewsjbEqWMkgYcHOPib0tAJ8t3/0D7gjIeAYJzBBfvLlEGm+gJBUGOJoiTZnuzsQdwC+afnMcpSIJCwI5FdFG+PDPeznTV5DkAHYG7YJcVKZTcjBWroHl2inPN5AAl2232mF3uRDxGI18LsqLwP9MVnbM82+BGf3pR77HKMl48b9cty3Yz9zTjw50onAkizfsC6FwjeVXBAXK2hDsleqiSdiL3mAnT4jNzUmBNvw0YGTqIvGWTo89OMCNvxasBQ+/xRwJ5U7edqydYDrKieYmm/ji/850pQsbRTTaCiz+RrFQnUQSZGUq+GA0iv5SpBpsdFmwJmAbI93TQB2L20JVSXnNcsIUr13GRWJcKY1c2ZxTRiqAhvzCZiNRWTLG41gmB6+UjDUgEyFmSVecGV0kBgCk+tgLBxyoclm42x+rCaY4blR6TIls4qOrQdPZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 20:49:14.0363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a345e5-814d-4da4-db54-08de64f8058e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498

On 2/2/2026 2:20 PM, dan.j.williams@intel.com wrote:
> Cheatham, Benjamin wrote:
>> Quick Background:
>> CXL.mem isolation and timeout is a mechanism that allows the host to
>> continue operation in the event a CXL.mem link goes down or a CXL.mem
>> transaction times out (semi-analogous to PCIe DPC for CXL)[1]. After CXL.mem
>> isolation is triggered all CXL memory below the root port is inaccessible.
> 
> ...and this is unrecoverable in the generic memory expansion case as
> detailed previously [1].
> 
> [1]: http://lore.kernel.org/65cea1bc6ac0c_5e9bf294ed@dwillia2-xfh.jf.intel.com.notmuch
> 
>> At this point writes to the memory are dropped and reads return synchronous
>> exceptions (platform specific, but probably poisoned data). The alternative
>> to this support (which is the case now) is the host system resets when a
>> CXL.mem link goes down or a CXL.mem transaction timeouts out.
>>
>> Why I'm Sending This:
>> I sent out a patch series a few months back that implemented CXL.mem
>> error isolation to this list [2]. It didn't really gain traction due
>> to not having a customer requesting it. We (AMD) have heard from some
>> customers that they are interested in this support, but aren't willing to
>> help out upstream.
> 
> Then they get the status quo until that "interest" matures into shared
> requirements definition, clarification of assumptions, and consensus of
> tradeoffs.

Understood.

> 
>> The main motivation behind using isolation we've heard
>> is that customers would like to use CXL but are worried about system
>> reliability since it's still a new technology.
> 
> That does not appear prohibitive given CXL uptake to date. Isolation
> does not improve reliability on its own. It replaces hangs with poison
> that is fatal outside of constrained use cases.
> 
> Now, all of the push back to date has been with respect to the general
> purpose memory expansion use case. The way forward from there is new
> evidence that the expected mitigations to make isolation useful still
> result in a usable feature. The evidence of *that* is the new use case
> that Vikram proposed several months back in the CXL collaboration call,
> CXL Accelerator error recovery.
> 
> In that case there is a chance that the acclerator error model meets the
> requirements to make isolation useful. Guarantees like 1:1 host bridge
> to endpoint direct-attach, non-interleaved CXL.mem, and limited risk of
> core kernel dependencies on that CXL.mem.

That's reasonable.

> 
> I am interested in the isolation for CXL accelerator discussion. I am
> not interested in muddying through isolation for the general memory
> expander use case without engagement from deployment use cases.

I can't remember any internal discussions about using isolation for only accelerators so
I'll need to check and see if that's something we're interested in.

As for the memory expander case: would something like the N_PRIVATE node set Gregory sent out [1]
be enough to change your mind on this? It doesn't provide the same guarantees as a type 2 set
would, but it does limit the usage of CXL memory to be more like type 2 memory.

Regardless, I (really) won't bring it up again until we have someone who wants to deploy this thing.

Thanks,
Ben

[1]: https://lore.kernel.org/linux-mm/20260108203755.1163107-1-gourry@gourry.net/
