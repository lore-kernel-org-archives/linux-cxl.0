Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A4829413
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177539; cv=fail; b=A86Q03ia/VhBtuFDnnbuXpdd0DRU/5TsBNE2J9NaSOcgMBL/JM9vB56UBibKSSiczafPMP87KRtx0OKREwUpK5MFUf6gveL6XT8epV3ZnKUkMyp0AI4FIvt40eoL10FU5jQI5359eojg6xAOmcTvMrpnGxSv+J2m8KFWqzvFgS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177539; c=relaxed/simple;
	bh=WVWJrFQSm84bXDTBgwKRJZiEDto1GOTaMqiDm7G5OIY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eces+ZCFVq7X9tgYZ54beJdV+jbtGRFmLvAAbeZUeml/LloDPjZ0P/6AJcJjL/kKFmdlufb1MsuQVJUB4G7Xtwt+Sa0pi9kdQLMPsLAijQxfVd0oJKC+8oKFrC7+Dp2q9zZUkCiB6obGgsPt0r34WoRAzX87k+ijglMLvxy19+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LUPWlTcG; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LUPWlTcG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xkdu1z3VYrCspDLstifjWZVKLuohWGckaj1Fo/2HItu5dr9ERZiA0RJI7JxzB88/6mhBAxnQw0YXgOb74ChbJiq4ATv0umhXP0FvYbWBGDijO6C3j4lxofcsLGTJYPh5CVziSisH5G9NiF5qlafRS6qpV6/BbqY4lxlxupqUtbG12g6tfMib/g2yycTm0NdB0Oc5LWp3T0UpXin8wi3+vaTTf8Q9D1qltKaDwt2riOGsJ2CEiDRnue/lfLoo+O+dHinBxg69jvwJ3mwZEbwPi3Ccb1iCmkHGGLnQT5wi7qQfNDvMyAqbsQAaXDdNgRIXqz1UbQjRYaAYR1p6ciNXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbpsONiUIGjBoo/To/ruyTQf1mgv5N/sLlu7+vf3Q0E=;
 b=WI6CQ+RPkczt06guCOu9JHTn4CPtc7SnMIeUopF/HhnaAvhMh29Is2Gn2mmA68zsfj8nNDCNDIkLXCMrvWeVfUqRhcG+MZUim2V1f8yYMDxLPP5K7xRVzkMVab2wB+cK/qMcGWjEixS6vLN9msZ329EIYmvYUxVaMexQI93kiljuNsTAVtEuy/wH1NI2xDGIDkPIt+K1JgZe6UPZ2l3YrHX/4XQAUtWMxqm5GOb/OThwpdwGkciQIgLCDZGX0Ai/WbjZiJFEFJUbQPa8lJ6KfXszgDVPc72py+5eCeHzgTiBFvBqkBGtI4/Pbo5ncrkFGAzXY5YGNCuGlJlqQvSsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbpsONiUIGjBoo/To/ruyTQf1mgv5N/sLlu7+vf3Q0E=;
 b=LUPWlTcGWRv0d/yVM8g9QESjgdDqmHBqWXk11gGr3NG13ZBNnpf2AmshlOCoLJ5/6ffyw+txxyTN8t2BZeXaiQZNhVBQc7hq1xq5Gq+UvjXnvTOM2+JxlYoJzWW5NI+ckrT65ZscqF1Qxif+4oUtcSpdr+93ZrVdtf8+Z2boibM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Wed, 12 Jun
 2024 07:32:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 07:32:12 +0000
Message-ID: <8112d79e-d7fe-a13f-df08-bc2a460f264f@amd.com>
Date: Wed, 12 Jun 2024 08:32:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 11/13] cxl: allow automatic region creation by type2
 drivers
Content-Language: en-US
To: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-12-alucerop@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240516081202.27023-12-alucerop@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0446.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA0PR12MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c7a3d5-4e10-41b8-9b9d-08dc8ab1c6b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|366008|376006|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2QrbzhCOG14djJUajF0VTRrRlFYVkJuOFMwYmU2WlkyMUN3bVlQMWRmcEZx?=
 =?utf-8?B?NFpHeXFZSHovLzBVdnA5UXBaOW9vdk5aS1JOdm82bGV5VnJUdHlQcWJZMU1r?=
 =?utf-8?B?VjRBRFlHNjlmRlJrMDdhdVM2L0VJeWgvaGd4NFJ0bng0dUZhSHJud0xnV1lI?=
 =?utf-8?B?Y29UWUhVSXFLbkJhL1R5RktNUXp5Y29JNWpRQyszeUFHOFdKSk9hVHg2ekRi?=
 =?utf-8?B?cDUrVy9CRlRNdHkwUzMzNGZ6SGNEQjY4andnYjRzcEZseENxWmlKN2pkVDlU?=
 =?utf-8?B?aVNsazlrT2l6aVR1a3lVNGtpSjdJaEFQOWJ5U2p0bUJUMzg1Z05Sc0JkaGxM?=
 =?utf-8?B?b01QL21hQ1JvTnJtUWQrWVpBMXJpNk1JV3I4NHdKb09ZWlpNNGdZeWlHa0V1?=
 =?utf-8?B?VzQ5UGZWQ2o1S0VwMHV0ckxYaUErbjJuWXY4Z1N0bnNwVitCU25lVnBJQmt0?=
 =?utf-8?B?dFB1eWVWcUcrWVhzTDVsVERNb0xpL1hNSGltamdwangxQ2hKVUZOa1NtdTRZ?=
 =?utf-8?B?bmUzZW9sWEpZYmZ0MWNZYlhTdXprMUZ0dEtreUVPbmNiY0VYSXVxdmcxTDBJ?=
 =?utf-8?B?ekFEYnQwVXBXZlVtK1dYS2t0NGhDZnNRQ3V0MDB1ME5LMGFsbi90dFRMaDlh?=
 =?utf-8?B?RXVWeVo3VzBtQkt0TmxwZGNXdlN0TjkrL2QyV2ROTkVYeTEvcDZWN1B3MmRt?=
 =?utf-8?B?aHNoazc5ei9abk1aSURueDBJMmpXZDhnaU9Uby9GM3lsc1ZmMVA1QVlJMUF5?=
 =?utf-8?B?S21iNDZkNEo4bmZBb3RvQVNHSy9MekhUZFJtV0NxZUFSa1Q1Qll0NTAyd0p0?=
 =?utf-8?B?b3JkaTJxMW1nSXlPWVdoN09jdnh5eFRaczJSS1J1SzFxVk40Y3RpZkVlSVpn?=
 =?utf-8?B?dE1NOTY2b1kwMy85b2lMQmpLYVVXS1d4bjNzR0cwRXZhbU5VMzZJcjQ0Zkhr?=
 =?utf-8?B?LzVVZC9yM3JLKzViL25OR095Q3NpQXpOaXlnL2FST0ZueHdXMHBOSDJiK1dK?=
 =?utf-8?B?czBHU2xEamhLZDNLSzdNcjVVblY3ZWRremRlMUhySER4d0JYT21rbFZ1NVhG?=
 =?utf-8?B?R0NHeG04MTZvajVOTWI3bXQxYlkvMDl2Y1EwR3hDd3lnem02NUZBSkFrZFdP?=
 =?utf-8?B?L1NFUDc1Q0R0eHIvOS9CUzVNVzBXcmpEbHhXU0JRd1dKd3RnZUFSNkZaM0lk?=
 =?utf-8?B?VS9pQXk0dUxGNi8zSnJ4bnZoYlAySXMzNGRhUzRBbG1Ga0JYaDd5dlVxbU1a?=
 =?utf-8?B?L3lpQU8wcWVLYmdjOE1CTTR3M0o1d29FM3hkeWhmV0lWMW9wdHk4dGJBR1RR?=
 =?utf-8?B?VWtncFhFdzZXL0VXcStMMDErbFJFbm56MlZHYkpvb3g2YjdtRURtUzhxbGNH?=
 =?utf-8?B?RVhRclZtT0JVZlgyQ2g2RGFnQWVISnRTUHo0cEY0ZmpHNVA1ZGs3Ujd6V1NB?=
 =?utf-8?B?NXpVcm5wUDZXbVA3Q2dETlVkSHppSklrbzNSNjY5SFM4dTRhRVplOWxOcUpL?=
 =?utf-8?B?anJpUDJnN2luV1ROMUhQTllRMW9vdXpQaFNhQTc2RnA1WUFvdnloSzNMQkIy?=
 =?utf-8?B?eDR3UzZzcWc5Zm1MVkdSN0ZKQldTSnAxZ0MvRjRucUtVa1Z1ZmhNZHlNZmVH?=
 =?utf-8?B?djNGMXcvZzduYndHcmppUllDTXVpNHZweUZjODAxUElWQVh1d3BYdE5LWUdO?=
 =?utf-8?Q?f/m3XBZZIyQ4hMXC4xlU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(366008)(376006)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2NiVEtMcWFSbnZsM21pU3VHQzZTeG1yU1RQMzVhbDFScjAyaG4xWkNZdHM4?=
 =?utf-8?B?VEVxNzhyK0FnZ3NQUUtac1FtaFM0YVBoa3BLUFpCSDBpUCs4K2xNb3drbVFX?=
 =?utf-8?B?bElINVgyYVhHYU9DeXFpQjZCdUJTUnNFUXNkUmJFWUU4N0VsZ2xlMlpzQ2JZ?=
 =?utf-8?B?OW1RSnFkbVo4RUJ3T29GU1lMc2xlOVQ1eUFYZXJzYVZJZVo1c2FucmsvNFdC?=
 =?utf-8?B?RHIrcU9RVjlkWUZpUE5OZjU3SlFWU0pvU1VVeVhiQVpUdDgwdTh4dFFuLzY4?=
 =?utf-8?B?Wm1jTmZzYXQ3WW5oMTlQK2hmOTJYZVZyZnFkWmh1YjNUNjIyejA3K0FiSFBo?=
 =?utf-8?B?WXEwM3o0TnJKSStnSWsyWDdwVVlSMFZsajV0MHNPWjk5cVZFZ3ZNZXh0eUEw?=
 =?utf-8?B?ZngrUHZvanVPU1A0OFNQQkt1aUJ2bkJYTXJqQzlZUjhMWG5BWjN1cmpPK1dm?=
 =?utf-8?B?WS9KVXRjTXl4QXNSWG5NYmlhV3NyZ0cyNmV4L2k0VE9iaG1RSEhGSzdBeU5t?=
 =?utf-8?B?TnJYMUd1Y1FwNWxyZWJmZ3NQMWV4ejFvbDJvUVIrU3k4LzJQN0FvY3RuN1Ey?=
 =?utf-8?B?N1pZRU9GRUlCUWh2WUJzS3FQMnIxTmpDV2h2Ykp0RlFuYXFVUDdUMEI4aGV2?=
 =?utf-8?B?c21KNEZJZmtjYVBVYkZwaW5QWUxZdUtwalJoRHljWXdDb0g2UE9UZG5Ja2hN?=
 =?utf-8?B?SG1WcXJNREg3Z2RKQ3hQN2tHeTBHODhlZUw3KzZScHZzcytXVkplUjIzV0wy?=
 =?utf-8?B?aVVQZWpmOFJzUm1WUU94bW9aZVJJM0lBMk5YVVIwdkpDSEZpTWxLMVpuR2xx?=
 =?utf-8?B?RnIreGJ0N0NHTmlOVmFBOXgrTURFYXRUZ3RCRlRFQXZKd3VmUE5FWDBtbWRQ?=
 =?utf-8?B?ZVVrcEQ2RTRna1J6UnFkN0ZUemdmM1RvNFdKZVdUYmphR1V1aVdqK1hNclU4?=
 =?utf-8?B?S0RBeG5PeFBqRVIwWFVkSU5CdVIrSlkwN05MZGs0d2RnYXNXOFBSM2lsMzdY?=
 =?utf-8?B?a3d6Znh1Z1VNU2MzMmFlK3d1U3dMZ2JUeVNDUWpnVGtFRDV4V2dDQ0lKZXA0?=
 =?utf-8?B?RndVaW51NTRTeGhoZytHUE1UbkhFMm1NM0pBREN2YXRVR0JjdUtwUGxtZ2sy?=
 =?utf-8?B?WW5OZnVjTER4SGY4dzFpeG11TzVvdGFQVnM5andpZWFHMWVxaUJMQTk0WDdx?=
 =?utf-8?B?VENvMmYwNnJIeHNndnBuT2llUWJBYktMWlU1dzgrSGxHS1A2SmQrYmltdGJp?=
 =?utf-8?B?RDdsbFhEMVM2QVdsVlNjYTlzL3E3bnBpY2hzWHl2cldwU3NJMkw0OFNRSTVo?=
 =?utf-8?B?TFdXMjV0bEJEYlRWVUt1ZXlzTmhqcUN5T01WSWZDUU9mNlBVY2syRFg2TFF0?=
 =?utf-8?B?NmRqYm45S3IvWjdMNklrc2ZqRFp1S2FoRm4vd3dNWUtPREdjc21ReHlFblBz?=
 =?utf-8?B?dnZ1MmVWaEdFMk9tUUYzK2w4RTUzUWJPQm1RT3Mwc0NaSk4veEVqUmtYMU8v?=
 =?utf-8?B?amFubmtlVFZ0UXpjMnIxSHdwNHd4WE56K00zdlVFWkpPbmVlQ01jNjNINzVZ?=
 =?utf-8?B?Q2kxMVphbEw3WWl0SUkrRDlnbklhTVpTajhmemRYTFptbVJpUUtJNHFYeGhO?=
 =?utf-8?B?NVRpRFhrYTRGYU42WFlla0NjcW1ucnRLRVRqNHd4dVFRVG9xZUtLZTl5Q2Z4?=
 =?utf-8?B?ZUpDR1k3Skg4Njd2ZU5FTHN2Kys2bVVQMU9JQnd2WWt3ZlVsK0I5S0FQQ3g2?=
 =?utf-8?B?ZjhKaDhxWDBYL0lFU3p5ZFNpS1VoamFkK09RR1V5T0oxNG00TVNGMllmSjlJ?=
 =?utf-8?B?NkdEWllCV2l3dlBXejV6KzRoTUdPWDMwTUw3SEtmQlZSdVYvZzAwL3JzdVl5?=
 =?utf-8?B?S1JDOWhtbU4zVWRVY0ZVRUQxSjBQVU8xb09hZmg0bXljV0d6VVZOUlhBMTMy?=
 =?utf-8?B?NG5CVkFCWnQ3NXg2cDNLSmh4TUVoeVhOV043NFJvd0dvVWhnTzI1b3k2cG5V?=
 =?utf-8?B?aTFOd0sycVRQRFp5ZFhaR1pVeC9SZEdXenp3TU9oQWZsTk5PdVdNUStHOXZw?=
 =?utf-8?B?Y0FDZkdjQmVRQVpKQkpjcW9aNjFrWkJSL3IrS05HcmtkTyt1WU4yV0h6QWpm?=
 =?utf-8?Q?qIbwv15Npdk04WJVBTmMCuQUo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c7a3d5-4e10-41b8-9b9d-08dc8ab1c6b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 07:32:12.8644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7mimKnio6+MJ8vf5mzElYSmMQis/Yj1GqFMaflq9ZJqS08+2+NTOIeEyPoWkxIlpJQ9WNe8Rq2lHRlbLCACbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Add that functionality and integrate it with current support for
memory expanders.

Based on: https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m84598b534cc5664f5bb31521ba6e41c7bc213758

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>



On 5/16/24 09:12, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
>
> Adding that functionality and integrating it with current support for
> memory expanders.
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/core/region.c           | 262 ++++++++++++++++++++++------
>   include/linux/cxlmem.h              |   4 +
>   tools/testing/cxl/type2/pci_type2.c |  18 ++
>   3 files changed, 228 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8228b7e96d8d..014684ff4343 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -479,22 +479,14 @@ static ssize_t interleave_ways_show(struct device *dev,
>   
>   static const struct attribute_group *get_cxl_region_target_group(void);
>   
> -static ssize_t interleave_ways_store(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf, size_t len)
> +static int set_interleave_ways(struct cxl_region *cxlr, int val)
>   {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>   	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>   	struct cxl_region_params *p = &cxlr->params;
> -	unsigned int val, save;
> -	int rc;
> +	int save, rc;
>   	u8 iw;
>   
> -	rc = kstrtouint(buf, 0, &val);
> -	if (rc)
> -		return rc;
> -
>   	rc = ways_to_eiw(val, &iw);
>   	if (rc)
>   		return rc;
> @@ -509,25 +501,42 @@ static ssize_t interleave_ways_store(struct device *dev,
>   		return -EINVAL;
>   	}
>   
> -	rc = down_write_killable(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> -	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> -		rc = -EBUSY;
> -		goto out;
> -	}
> +	lockdep_assert_held_write(&cxl_region_rwsem);
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
> +		return -EBUSY;
>   
>   	save = p->interleave_ways;
>   	p->interleave_ways = val;
>   	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>   	if (rc)
>   		p->interleave_ways = save;
> -out:
> +
> +	return rc;
> +}
> +
> +static ssize_t interleave_ways_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	rc = down_write_killable(&cxl_region_rwsem);
> +	if (rc)
> +		return rc;
> +
> +	rc = set_interleave_ways(cxlr, val);
>   	up_write(&cxl_region_rwsem);
>   	if (rc)
>   		return rc;
>   	return len;
>   }
> +
>   static DEVICE_ATTR_RW(interleave_ways);
>   
>   static ssize_t interleave_granularity_show(struct device *dev,
> @@ -547,21 +556,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
>   	return rc;
>   }
>   
> -static ssize_t interleave_granularity_store(struct device *dev,
> -					    struct device_attribute *attr,
> -					    const char *buf, size_t len)
> +static int set_interleave_granularity(struct cxl_region *cxlr, int val)
>   {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>   	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>   	struct cxl_region_params *p = &cxlr->params;
> -	int rc, val;
> +	int rc;
>   	u16 ig;
>   
> -	rc = kstrtoint(buf, 0, &val);
> -	if (rc)
> -		return rc;
> -
>   	rc = granularity_to_eig(val, &ig);
>   	if (rc)
>   		return rc;
> @@ -577,21 +579,36 @@ static ssize_t interleave_granularity_store(struct device *dev,
>   	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
>   		return -EINVAL;
>   
> +	lockdep_assert_held_write(&cxl_region_rwsem);
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
> +		return -EBUSY;
> +
> +	p->interleave_granularity = val;
> +	return 0;
> +}
> +
> +static ssize_t interleave_granularity_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	int rc, val;
> +
> +	rc = kstrtoint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
>   	rc = down_write_killable(&cxl_region_rwsem);
>   	if (rc)
>   		return rc;
> -	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> -		rc = -EBUSY;
> -		goto out;
> -	}
>   
> -	p->interleave_granularity = val;
> -out:
> +	rc = set_interleave_granularity(cxlr, val);
>   	up_write(&cxl_region_rwsem);
>   	if (rc)
>   		return rc;
>   	return len;
>   }
> +
>   static DEVICE_ATTR_RW(interleave_granularity);
>   
>   static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
> @@ -2666,6 +2683,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>   	return to_cxl_region(region_dev);
>   }
>   
> +static void drop_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +}
> +
>   static ssize_t delete_region_store(struct device *dev,
>   				   struct device_attribute *attr,
>   				   const char *buf, size_t len)
> @@ -3135,17 +3160,18 @@ static int match_region_by_range(struct device *dev, void *data)
>   	return rc;
>   }
>   
> -/* Establish an empty region covering the given HPA range */
> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> -					   struct cxl_endpoint_decoder *cxled)
> +static void construct_region_end(void)
> +{
> +	up_write(&cxl_region_rwsem);
> +}
> +
> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
> +						 struct cxl_endpoint_decoder *cxled)
>   {
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
> -	struct range *hpa = &cxled->cxld.hpa_range;
>   	struct cxl_region_params *p;
>   	struct cxl_region *cxlr;
> -	struct resource *res;
> -	int rc;
> +	int err = 0;
>   
>   	do {
>   		cxlr = __create_region(cxlrd, cxled->mode,
> @@ -3154,8 +3180,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>   
>   	if (IS_ERR(cxlr)) {
> -		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s failed assign region: %ld\n",
> +		dev_err(cxlmd->dev.parent,"%s:%s: %s failed assign region: %ld\n",
>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>   			__func__, PTR_ERR(cxlr));
>   		return cxlr;
> @@ -3165,23 +3190,47 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   	p = &cxlr->params;
>   	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>   		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s autodiscovery interrupted\n",
> +			"%s:%s: %s region setup interrupted\n",
>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>   			__func__);
> -		rc = -EBUSY;
> -		goto err;
> +		err = -EBUSY;
> +	}
> +
> +	if (err) {
> +		construct_region_end();
> +		drop_region(cxlr);
> +		return ERR_PTR(err);
>   	}
> +	return cxlr;
> +}
> +
> +
> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	struct resource *res;
> +	int rc;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
>   
>   	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>   
>   	res = kmalloc(sizeof(*res), GFP_KERNEL);
>   	if (!res) {
>   		rc = -ENOMEM;
> -		goto err;
> +		goto out;
>   	}
>   
>   	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>   				    dev_name(&cxlr->dev));
> +
>   	rc = insert_resource(cxlrd->res, res);
>   	if (rc) {
>   		/*
> @@ -3194,6 +3243,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   			 __func__, dev_name(&cxlr->dev));
>   	}
>   
> +	p = &cxlr->params;
>   	p->res = res;
>   	p->interleave_ways = cxled->cxld.interleave_ways;
>   	p->interleave_granularity = cxled->cxld.interleave_granularity;
> @@ -3201,24 +3251,124 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   
>   	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>   	if (rc)
> -		goto err;
> +		goto out;
>   
>   	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
> -		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
> -		dev_name(&cxlr->dev), p->res, p->interleave_ways,
> -		p->interleave_granularity);
> +				   dev_name(&cxlmd->dev),
> +				   dev_name(&cxled->cxld.dev), __func__,
> +				   dev_name(&cxlr->dev), p->res,
> +				   p->interleave_ways,
> +				   p->interleave_granularity);
>   
>   	/* ...to match put_device() in cxl_add_to_region() */
>   	get_device(&cxlr->dev);
>   	up_write(&cxl_region_rwsem);
> +out:
> +	construct_region_end();
> +	if (rc) {
> +		drop_region(cxlr);
> +		return ERR_PTR(rc);
> +	}
> +	return cxlr;
> +}
> +
> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder **cxled, int ways)
> +{
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p;
> +	resource_size_t size = 0;
> +	struct cxl_region *cxlr;
> +	int rc, i;
> +
> +	/* If interleaving is not supported, why does ways need to be at least 1? */
> +	if (ways < 1)
> +		return ERR_PTR(-EINVAL);
> +
> +	cxlr = construct_region_begin(cxlrd, cxled[0]);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	rc = set_interleave_ways(cxlr, ways);
> +	if (rc)
> +		goto out;
> +
> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
> +	if (rc)
> +		goto out;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	for (i = 0; i < ways; i++) {
> +		if (!cxled[i]->dpa_res)
> +			break;
> +		size += resource_size(cxled[i]->dpa_res);
> +	}
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (i < ways)
> +		goto out;
> +
> +	rc = alloc_hpa(cxlr, size);
> +	if (rc)
> +		goto out;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	for (i = 0; i < ways; i++) {
> +		rc = cxl_region_attach(cxlr, cxled[i], i);
> +		if (rc)
> +			break;
> +	}
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_region_decode_commit(cxlr);
> +	if (rc)
> +		goto out;
>   
> +	p = &cxlr->params;
> +	p->state = CXL_CONFIG_COMMIT;
> +out:
> +	construct_region_end();
> +	if (rc) {
> +		drop_region(cxlr);
> +		return ERR_PTR(rc);
> +	}
>   	return cxlr;
> +}
>   
> -err:
> -	up_write(&cxl_region_rwsem);
> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
> -	return ERR_PTR(rc);
> +/**
> + * cxl_create_region - Establish a region given an array of endpoint decoders
> + * @cxlrd: root decoder to allocate HPA
> + * @cxled: array of endpoint decoders with reserved DPA capacity
> + * @ways: size of @cxled array
> + *
> + * Returns a fully formed region in the commit state and attached to the
> + * cxl_region driver.
> + */
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder **cxled,
> +				     int ways)
> +{
> +	struct cxl_region *cxlr;
> +
> +	mutex_lock(&cxlrd->range_lock);
> +	cxlr = __construct_new_region(cxlrd, cxled, ways);
> +	mutex_unlock(&cxlrd->range_lock);
> +
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	if (device_attach(&cxlr->dev) <= 0) {
> +		dev_err(&cxlr->dev, "failed to create region\n");
> +		drop_region(cxlr);
> +		return ERR_PTR(-ENODEV);
> +	}
> +	return cxlr;
>   }
> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
>   
>   int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>   {
> diff --git a/include/linux/cxlmem.h b/include/linux/cxlmem.h
> index caf1cd86421c..fc963c2c2dc4 100644
> --- a/include/linux/cxlmem.h
> +++ b/include/linux/cxlmem.h
> @@ -875,4 +875,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
>   					     resource_size_t min,
>   					     resource_size_t max);
>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder **cxled,
> +				     int ways);
> +
>   #endif /* __CXL_MEM_H__ */
> diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
> index 6499d709f54d..0e7f17c0c920 100644
> --- a/tools/testing/cxl/type2/pci_type2.c
> +++ b/tools/testing/cxl/type2/pci_type2.c
> @@ -4,8 +4,10 @@
>   #include <linux/cxlpci.h>
>   #include <linux/cxlmem.h>
>   
> +struct cxl_region_params *region_params;
>   struct cxl_endpoint_decoder *cxled;
>   struct cxl_root_decoder *cxlrd;
> +struct cxl_region *efx_region;
>   struct cxl_dev_state *cxlds;
>   struct cxl_memdev *cxlmd;
>   struct cxl_port *endpoint;
> @@ -109,6 +111,22 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
>   		goto out;
>   	}
>   
> +	pci_info(pci_dev, "cxl create_region...");
> +	efx_region = cxl_create_region(cxlrd, &cxled, 1);
> +	if (!efx_region) {
> +		rc = PTR_ERR(cxled);
> +		goto out_dpa;
> +	}
> +
> +	region_params = &efx_region->params;
> +	pci_info(pci_dev, "CXL region: start=%llx, end=%llx\n", region_params->res->start,
> +			  region_params->res->end);
> +
> +	cxl_release_endpoint(cxlmd, endpoint);
> +	return 0;
> +
> +out_dpa:
> +	cxl_dpa_free(cxled);
>   out:
>   	cxl_release_endpoint(cxlmd, endpoint);
>   
