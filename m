Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793197117;
	b=erEseiXy/ldQLGtqYpOA9mMNtf3LDSAx6U/cCVFm5EuBj2EhXH/Qj+T5CdHhgi4Ka6dr
	 7BqSaHtH06c1NzBevivSdZ6q/0ecJVLFlqSazE7G94vLLdg4/jBbQ9rbs2hswHvVloSQ+
	 CZLoFiiAxviSNcMfKRulV/7r6uVJ8i2Z9EApMLPZoCGJ3Tas9OMjwlDZV71NecxoTtTp6
	 CD7Vk/c/CGlCUaGNxeEc+Khv0NR/f/VRSx2XkXiDLLQCfvJfkdEJkvY/+mtx0AVPSDcND
	 iguiv7mg6j7oD8iHBA/yRUhAeIiDc7z9GikGW7wb+mDHExm2nyfBXGtQ1YuCUZhV92A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197117;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BxehCA7IYZnQk+b0qQOOfbCvLMzNoT9vnM3IImanrKU=;
	b=NAT1pF87jGQ81/hPvilC5AGwXc3XUAirxTBwXrbep6aJFq3/FsSrYV4QSEECEtjnJrIS
	 0A4GjDPYjWAy8Ofvoua1eYEmNxiV/roEZxo6/Ov4kpryMvZWSUYYYHsFBg1DUySI0imzu
	 y3YZy4GBR1G+CEz0G9ubzeZuUCqkUnS5Z0Rl/5deBsxZATF3YXe3b8/7Hoc6nCgDOyrNY
	 yuxbSUDQ/W/xpy8iaZ0Sowlb4pdC/SZmi4v8FD2BPn4/x1MTzzw9O7Pun+5D08PzrrXm8
	 3wGYijc2gmjCk+lXPHnmWpXjc9jwiurv5ty9nvBVEzRA+2Nz8U3732hurFMJjYeyWVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fK2OdPUy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.57
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974EC606A331;
	Wed, 28 Oct 2026 14:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 974EC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fK2OdPUy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGhQtc9FYZKksariluq3OszDArO44/U5fOAe/fYqpBRtTDk85hRWm0OQJyUX0l5vi+tNCL7BW/gEMc0aETYgzJjAf9X6R5MJNFbsQvl3P32IJppRkGvFTWBAiTTLmDOHCDcMHmNHuAdp7NCM06RJJujNXIr9DOCHAV4pepbARXwackD3nf60UbmbNeQO1N9KgJ4c4JQRoobXk3MLUKcsOCnPAiSYhANsCzbaBcIPsVCZMqw6n6ug3n7OziGf2pqQpJGbgOW/D/9cIJM3esSa6XkCj6k/scarxIOsh/ZvuZ0dBZqyG1stNSwCyg+cEIewUGc2ZWl8STg5u5e+52W8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxehCA7IYZnQk+b0qQOOfbCvLMzNoT9vnM3IImanrKU=;
 b=W22ax6DMf37Iuq1ImYHB0IWAPB9TsB7genI+YjR+UvykgZQWMVuoKK1c69t2GSzUN940n+fBe2Eu1YeeCnip5WnAOXa5NOxVI5PVy9vQ9G3cAxzcgbXiXf7GIb9kWvpWY8Jz6EuljTfNnkKJSHgEDq3utrHJelHp+d+elfXFT2VItnPXBJwQ+3JOSOVKmP6seOZJ+E4OJMN3u6IGKmu89kdJyc7AM6X+Lpfamu55PfvDWe9zHJvm8taWhqDNTlae6wb025rI8tqIQx5d6yX69hYicUti5+ieLZMLoLBZMMmQsrdDRb7YBu/7uuN9ekpDZws/wDcUV8WFMgcdtZnLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxehCA7IYZnQk+b0qQOOfbCvLMzNoT9vnM3IImanrKU=;
 b=fK2OdPUyp7s84wLJEroSiVemk3NDUkBy0ku6NJMTK0K9RQ3JIEbXP++AF7iFxeKBjyMeWsIKqrMbsGhZdkebZK1+fhRhwmkvveg6RRsHAw04GFPDRV3ZIH6APn9TaKViT1x0rfpRySKf6AaeT4XmDxF2oexfi1B9usYm8xn+3kQ=
Received: from BN1PR12CA0014.namprd12.prod.outlook.com (2603:10b6:408:e1::19)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 14:18:30 +0000
Received: from BL2PEPF000352CF.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::a2) by BN1PR12CA0014.outlook.office365.com
 (2603:10b6:408:e1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 14:18:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352CF.mail.protection.outlook.com (10.167.249.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 14:18:30 +0000
Received: from [192.168.86.104] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 09:18:25 -0500
Message-ID: <d65d524d-49a0-4b5a-8df0-68ef63a0b1af@amd.com>
Date: Wed, 28 Oct 2026 09:18:19 -0500
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/edac: Fail ECS threshold read for reserved
 encodings
To: Jonathan Cameron <jic23@kernel.org>
CC: Yili Zhang <zhangyili01@baidu.com>, <alison.schofield@intel.com>,
	<dave.jiang@intel.com>, <dave@stgolabs.net>, <djbw@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shijujose2008@gmail.com>, <vishal.l.verma@intel.com>
References: <20261021152053.85322-1-zhangyili01@baidu.com>
 <099f0eea-1ff6-4e1a-91cf-682fd7609808@amd.com>
 <20261028011640.6f2b204d@jic23-hlaptop>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20261028011640.6f2b204d@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352CF:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 840f8f87-765b-4690-3996-08df34fe5747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|23010399003|7416014|36860700016|261026140227099003|11063799006|4143699003|56012099006|261026121527099003|261021135927099003|261022075727099003|261021121427099003|10067099003|261022105027099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oHKSDMghm19KaCpZhw2KsvvWuz2HO8dGgqqN8inPHwDmK1uzfwqKSeBnij3PESoFALp1d9Hhc3tpSkm7MBJVWCBrX8BQVzRPgO+tUTJzF2NENsmpAZaR8Fp97ZNuJA9ESBP5f3Erd2SOQTHqOZiZ59qkJtsMi1xsdR9Kh7vMGmwwFz5njFixASE1QBKiaTvA15nySxEXNZpux8Oww0nnlSUjbyT5Hoz77maN/oNjrcNLRVwaPRdGhwHG+iDaAUpK+JG276wkdJg04v9crX7HtgKoBudHMVC4ATLTiqE7RBLwcx0LooaYiSZtKx8ZmWT9k1plymNhy5O4FDsVJlLDhaehj3cgXQv68M4CYE56YxmlUCbhu3ogoVj8C8sTD+l49p8Uc5knkrjWoecWJLumE674dhh8em7e5Kd9FAY40RCySPfvSaM3maMv0bFoKNwSdOPWamFqgmLeJhfE7OR+Rl+jdr4CfozLxciykWLQtxHLFvmGA0R7Xf5Mh51hnrWzkYZmwJaPUwyLNUaScCnEeZPunF/3E6LP4mIAgXyBr8DOFFvo3lV/tr3PlFhP8kv+v81pKfBqzRD9QEwkUwG+HHXSecVDEP/q0+xrzfszrnROCPs3djnoRb8ueROq696wpbAOx8ApUVYsSjqR+irP4R4gjiAohHpf13PlUmVVHXuAKSZL2Vqxuz5xqisGByR3J75ogTRYu+nSUMQ5PtDWeg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(7416014)(36860700016)(261026140227099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261021135927099003)(261022075727099003)(261021121427099003)(10067099003)(261022105027099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WuFGLXD7VNNLPXxR8cK8lRQtHWLD40mwSrtNnE0sszwwRgn81He918WD5VUUHEEXNs1KfI6QmFmI8SnOuaS7c3Cass65JUrqkDMaMT0d51kWVV1e3khdTlT3slfmFbtxcxDYAzsJWhGIhjd9+lrGzYBUUbqGSI10CknYDQviGPA+2W8gRNK2z9DA/9C6P1yfoIpR49BGiFmDQ+GUA+mFGTMFCmLsGMA1VFS+LnDkAgUl6JSyUU4B4KaSPhgOQgARVE5wrAR61NHbT/yudSUFpWgN5PWnB5X0IEkVO1/5VycJcQ860AExhU5VIoBbAbhKdIwRmJXd+5+OVV3nnTK1Uca8I8rxH8WXkKKTqccgI+0mGHxPczN9bmWSD4XaJuT7cmB525gpaIA/GiauSJJMc7kMDfeZp2g88Og9HL0qb7mXBoSc6sv6jKLkwLnQBXvK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:18:30.0092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 840f8f87-765b-4690-3996-08df34fe5747
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL2PEPF000352CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369

On 10/27/2026 8:16 PM, Jonathan Cameron wrote:
> On Fri, 23 Oct 2026 16:05:27 -0500
> "Cheatham, Benjamin" <benjamin.cheatham@amd.com> wrote:
> 
>> On 10/21/2026 10:20 AM, Yili Zhang wrote:
>>> cxl_get_ecs_threshold() extracts a 3-bit index (0-7) from the
>>> device-supplied ECS config word and uses it to index  
>>
>> Nit: Should probably spell out ECS here for people (like myself) who don't
>> know what it means.
>>> ecs_supp_threshold[], which only has 6 elements. A device reporting
>>> index 6 or 7 causes an out-of-bounds read of adjacent .rodata, whose
>>> value is then returned to userspace via the EDAC 'threshold' sysfs
>>> attribute (small info leak and wrong reported threshold).
>>>
>>> The threshold count field also has reserved encodings 0-2, which
>>> currently read as 0 from the sparse lookup table. That behavior is
>>> not intentional; it is just an artifact of the array's implicit
>>> zero-fill. The ABI documentation only lists 256, 1024 and 4096 as
>>> supported values, and the write side (cxl_set_ecs_threshold())
>>> rejects everything else, so a reserved encoding can only come from
>>> the device reporting it. Rather than documenting 0 as well, make the
>>> read fail for all reserved encodings and only ever report the
>>> documented values.
>>>
>>> None of these encodings can be written through the sysfs write path,
>>> and no device is known to report them, so this is hardening against
>>> a device returning values not covered by the spec rather than a fix
>>> for known hardware.
>>>
>>> Convert the cxl_get_ecs_*() helpers to return an int and write the
>>> attribute value through an output parameter (u32 * to match the
>>> macro), so that errors propagate through the shared
>>> CXL_ECS_GET_ATTR() macro to the sysfs read.
>>>
>>> Suggested-by: Alison Schofield <alison.schofield@intel.com>
>>> Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
>>> ---  
>>
>> I was going to make a suggestion about updating the documentation to mention
>> this new behavior, but noticed the other attributes in the ABI docs don't mention
>> reads of reserved values resulting in an error. The doc mentions that these attributes
>> are implemented by the device's driver (duh), so updating the general docs doesn't make
>> much sense.
> 
> It would be unusual to document what happens in a hardware bug situation
> in an ABI doc.  Tends to be noisy and hopefully never applies.
> I don't mind it being added if people really think it adds value.
> 

You know, I thought about it to hard and forgot that this is a preemptive fixup. I think
you're right and that it probably doesn't need to be documented.
>>
>> So I'm going to take it a step further and ask if we should be failing the write at all?
> 
> This is only the read path I think? I guess documenting that
> writes can only be of allowed values and otherwise you get an
> error return would be fine but to me that would normally be
> assumed for a sysfs parameter.  It is nicer for userspace than
> alternative of just ignoring such a write.
> 
> 
>> It seems like other driver implementations probably don't, so it would be weird if just the
>> CXL driver did. I haven't looked for any other callers, so if CXL is the only user then
>> the docs should probably be updated so other implementers can follow the same convention.
>> If not, then it may be worth looking at the other call sites to update their behavior.
> 
> Far as I know, today this is the only ECS control driver.
> Maybe someone surfaced another whilst I wasn't paying attention though
> or someone has one in the works.
> 

Cool, then this looks good to me. For Yili:

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

And thanks for the response Jonathan!

Thanks,
Ben
