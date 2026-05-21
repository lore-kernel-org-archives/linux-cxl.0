Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A043C2BA2;
	Thu, 21 May 2026 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366235; cv=fail; b=LodWqFVKI9aH68lVwq3umaGxXEwEyrVXyc58rESS6yDoIiye4mSYgS8CyC4bRKxTDbdqKeyhNFobooqe7Xbr++9KT4eAfqZ6SMJI/MWiReDcHX7xjLtxkmk/Z6NAhrgRp89k3w4SRPCka5mRR2VI/KPO2dSXVQlmYlxbyZHbOkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366235; c=relaxed/simple;
	bh=I8KOj3uwgpDwZqNIj4VKyUvN6I5FTh9mcOvXunKHvis=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CBICYBNND0KhJj5pnCkzNwj83Bje6hzqh1ybT0nkuPbgs+E4jxMX5NLx6v861C2HFpwBOh7kn1SOk54BNlZtiW5Vt87J6rL9CmTnXQGECF/qoWz7mp+MwHOnZklwga0s8uzzKixBFwkc0tRKaZMfBFykvR8oJF8DSUw1XOS7QRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lGdFqpVO; arc=fail smtp.client-ip=52.101.62.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lGdFqpVO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5mEU0ZcS2Nqu7MKjs2BFFl5hWg0ZTol2K89+u7qbKw+9ReaLNYkUWJ0ptgtshA3BJSLsPBEoj9N/7nWy9FtGLi6qI9JoYXoIyPcVs2viKz13NevF2knFTBejCYuKPXQPfL6QWWXUB/lFwUUAbRFSUWAn8BjN8MAgJDlYtpX+iDBLLPIkoUBDrkTGeOs8V2wuDbe05uqiQeBkYvIp/FT+MMtRXa913JSe4AyK+hOSsbaBL/QL8sAcfisf761OjhOlDa4mnx/HfjRnbz8Ew3+ieNVe5EtI416syjfZMV+QuT0q2K34gcN3Hp8c7yo9mYWavBNt8KxPor8riatXpya4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCRdwsdiGfi6ry4Y45pDmfmg1Dw7E8NSIr2Lisaw3gw=;
 b=IeElkyDo6XQ8Uyw5HLrbx/6vB2m9z9FcIXtJ0gG0Y1frHtU9KhgREWdzdJvN3mFMufzLlB/Srx3r+ZVqp8y/IrYsXtJi9OF8VR5+VmvfKGb3HZczV1kKqsqt54/yDnbJL+mrcQwwM5sYgxp962rGkcuCuRuAj7tDHsJE96yJjqlOtgrRZNNkQFYCvodJwrarmEqOBGA05TQ/JS506hlQyIoiK/FZob1lnRIs+Vk9PID1ASA890UOl1x0cJRdbMw5Ivm/HcenMX5tYgsn1FdaY7gdhC7Vxnbth/g7owjeyf5yoi84IUBIrOJBvgtUNYq6H+cAr1Z91gfA/LoTi/g+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCRdwsdiGfi6ry4Y45pDmfmg1Dw7E8NSIr2Lisaw3gw=;
 b=lGdFqpVO2nnA/YpUR+Sbw3UGUvWl/bVXJpqCQ+djpPRA81uqVCHm+IyyWaSE5Zb+QVAsRIYkJA9qNknY+FEZ/6i+nx/mAT1PSzKziVKQZsbkAg/n4X4wZQ8CRLxQgURJbPEoiaeJt/ww6lOAdPNjjUIGGuWgnrU+R1PMR6xocxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 12:23:48 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 12:23:47 +0000
Message-ID: <7c9cb682-ec3e-438b-830c-2a5997b69c43@amd.com>
Date: Thu, 21 May 2026 07:23:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: CXL: How to handle trace event ABI break from
 CXL_HEADERLOG_SIZE fix?
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Dave Jiang
 <dave.jiang@intel.com>,
 Smita Koralahalli <smita.koralahallichannabasappa@amd.com>,
 Robert Richter <rrichter@amd.com>, Jonathan Cameron <jic23@kernel.org>,
 Shiju Jose <shiju.jose@huawei.com>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Lukas Wunner <lukas@wunner.de>,
 "PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <51a77746-5199-44a2-aa2e-d04cdd6084e7@amd.com>
 <6a0e33507e961_1717cc100f6@djbw-dev.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6a0e33507e961_1717cc100f6@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0039.namprd18.prod.outlook.com
 (2603:10b6:610:55::19) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CYYPR12MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 021494d5-9f21-47c4-fbfd-08deb733cefd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|3023799007|4143699003|11063799006|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	9m/KBbMLOojJTQkG9CB5HrOpVu+8UFGHe34RJgvKGKNklce9aSZvzoPwAczm/sUTLmQ5puF5jt6ByPfZ85M9bsNs/viylPU8em3eI5034FNSAqgMmMPz1A8+tkiDFzrZ8jAvMjclBm3FZ2lu2vHAkGA1zCqVfpmgQcX9gM6Ld/epx28ctfJCkDSOMaWTXjJniTbO3Z45WNWRPwY42lIA49KveucNsYYN4Zdr4NryyF8U8WU/v40BEgwBNztbXJfbCO+fBcX583xzpcu8vFERRRiWeR/DTjoaGh9iMKXmj2GtglbRWP5uHDrihvbXppCxaYVWFjuT8T+NrLFCXzMTdVD0D5biKrWTT0RT8MDdk7nh5HB4O9txp5iTpuhFg3OPzDKzlApJgNRXqEDztGkA+h++7lxUPhs0s3LLICKGOh5HzNM8+IFpUVyfeHQQR3M80XJXVijbp7zZ+AsQUoV8kNt0mljgBlJixG8F9vB//0KkjtNFS5Vaplfqen2mNAn0NibeJCr7cXES0zHu2pQsw5jEXAAeARpuLkoTG+yExYYg/dvuEYzFoVZafCIof8ZxLpzfnvny3JZJjV3mUKjHDktzGM9gnhtfXnfUkRTq1ln4srFtw0ndNsqrvHJmb182/Rwx9kppYaeh29+6MdPrVqb4JkCllal3Edw2fv4fg2ci9TcBLsYj35uAio1NGlNNAHOx3AAhspXMalygOQTuPb+uAcKsvM4Av/hlh2PM2z4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(3023799007)(4143699003)(11063799006)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkQwSVc0QVRwTWh1REJtU3RLbFRnSjNSQTd1b1hDSzBLeG9hTzBpTDE1UWQ0?=
 =?utf-8?B?YlBKaS9Td1N1bnVrdTJsVHIzY0Y1Q0hSRmRCRFozcjl5MkFEL1FWdEMxdWQw?=
 =?utf-8?B?ak1lMkg2eDJDb1pDcC9PWDFwOHpSdVowUUs4SjkzY0YrU1Q0ZU1UM09OUU1B?=
 =?utf-8?B?MTFaOXVzbGEwWktGRU5aUlJsWW5MdUJJY25ZYmVkWEZYR28yN1M0THAzVm5x?=
 =?utf-8?B?UDRBcldjZGlZTVBnbkt4eStKc3ZMWlNTZUhxSE9KRUh2bzJ2TkxQdzdIc25x?=
 =?utf-8?B?d1ZYWktiUlpuSHlEa055TFpyWFVycHVJcmVSWjkrbUMrZjZZc1JLKzZLanc5?=
 =?utf-8?B?MWNsL2VQY01WQnF6ajJWVVVuVWNSVFlaRHZHdVJja2liYi9LaUxtbTVJZkJ1?=
 =?utf-8?B?blU1M1N4VElQMXJjei9yLy9SdmswTXdFdk1YLzZudWltS2QxY0NjTFY3WnRs?=
 =?utf-8?B?S1ZORGFKTmdpOWtSTmlVdVd3blc3NmFaMnFUcTNHU0Jva1doQ05iejNkSW1G?=
 =?utf-8?B?N0Fpd3hXVlQya3I2a0NSUGJza0g4YkVCS2pHTlllQXJyNFMzZ3BHSlVwcDVN?=
 =?utf-8?B?ckJKaGR6NW85VzZzMDExMGlzbGRDRS9WTzVMVlFIQ3FzeUgrQ09DKzZVMkxY?=
 =?utf-8?B?TzMvRU40R3NsRTFVZGpPMW56V3IrVXpjUGxVdHZPdjZzY3hGMUNUekFMaGs0?=
 =?utf-8?B?M0N5U0l3aGtUUXZlRE10dUJza2g0TlFMM2VMRFlHQWVUMGhMWEZuRlBsNlJJ?=
 =?utf-8?B?M25jbmVrazNvKzA3YmVnZEVsSGhuY0F0MHNXMzlCSVVVWkJqcnkrODBMRXZZ?=
 =?utf-8?B?N2duaWdTakdMSnBsK3M5U3FsNmo1Q2M3b29ua0hNYlZKcEtKb2VCSWs5NnRs?=
 =?utf-8?B?OVdReHNEdzF2bEl2dzB5bjFraVRWZHhRMk8rV3pQSVZrVFk4NktrOVhBRjlG?=
 =?utf-8?B?VzNKWlhiMnRzWXFEalkzUDBPaUdRbS9KMnVuQXZvaWdrV0dpSDhxdnk5emJY?=
 =?utf-8?B?STN2Q3JRbGI2WTl2dkIrK2FVZjdXTmx3UHRNNEJQWnZJQjJOdndqTTVjWHIv?=
 =?utf-8?B?RCtSbHBIZU9DYm5JZCtBRFVmb1FCZWR4cDdpamhHWmtTRmtacDdhdW1hcUJP?=
 =?utf-8?B?VTJ3Y0dQQ1R4Z1BQSXVJS1V1ZTV4UlVwODBqSkY4ZGxSVDNCSk9YZmY2ai83?=
 =?utf-8?B?NXJyZjg0TjdURkxHY1k4b040YkpRWk5XT1J2QWdIUzlLNHpXSGRwUFFjeFRw?=
 =?utf-8?B?czJVQ2FtQnZpcTIwekNXa0YvR3JvajlJMmMvWEptR3Q4L3JIR29CR2xKVnBN?=
 =?utf-8?B?Y3dzVUVZWTJKcEhnWHd2Tm9lS3VPTVVjS09Zckd2NTZoUkwycmxUYTk0TDhD?=
 =?utf-8?B?aE9TTXpWVHUra1hMdDRaZ2pPT3Q0RFdlSnhrK1VrT29icHU3aUlobFpoamta?=
 =?utf-8?B?YWhtQnB6RlA4YjE0R1NYaEZYRHJta1hyL1k5V255cnZpcjVTZHViRnhPc2JF?=
 =?utf-8?B?eEFTWUdlMjBWNUxFRFJRVkxZcS94NDZoL0dkQjZEU2x2azBjc3dDdk1GQ1NY?=
 =?utf-8?B?eURTUXpSMUZVNGhYTU4zeENmcjdIYU9IWForQXp5dGxadG0yWktZWnlpUmZr?=
 =?utf-8?B?emtEN1FqVStFUzZteittM1c2K2M2aXZGdEJlcEo0MWRXa09rMFc5UFBKKzZ1?=
 =?utf-8?B?RW5SeHNWa243dGNTZHRDU09EWStmNXpuZVNheDUrbnVleDRudW1xUmd5MjNX?=
 =?utf-8?B?YzQ0akg1cTVFQ0x2a0VRdCtlL2JibFpRVHg5VFVGSStJOHhwclJZMTFyYmFR?=
 =?utf-8?B?cHBQaFZYTGdVTG9CeFBMcjgyZ2FEaS9UK2hGUXp3SFJsSGhxc3RINTVJYzBJ?=
 =?utf-8?B?R0xiN2NoSUU3UjdnOU95bGQ3VlM5bjZJMUt1MEI0dTNrc0U1MEhjQTFMMEdQ?=
 =?utf-8?B?dGtHVWhmUm9XQ1laSUlZNzN1Z0xjdUR1bmhUQWM5eXZRbzRxY0ZoY2R6bmpu?=
 =?utf-8?B?SVNsaEJMeE9LdEFMM0ljRWJjbmxQQkJtSkZacjViUFFpVW1CRGxlYXVmano1?=
 =?utf-8?B?Q3VTRHdHY2JaNTZBQ0ZHOCtJODBCeVdIUGhpbGZUS0xZM2VHam5xRlhIZTBX?=
 =?utf-8?B?aHN3UGdqdVZtS3pqbWhlZjNsRDNMcUUyWXNRU0I2NUJiTnNjYVZGTk5GZWZh?=
 =?utf-8?B?REFnTGhaNEhqQUxtMkFWcWJpaEdTS2hCMmxHcmZGS2RhU2I1aEkxandSVlJV?=
 =?utf-8?B?TVMySXh4U0RwSUkySThodlNJendaT3d3TFlhempGcG5EcGhLc01VaFFCZUJY?=
 =?utf-8?B?cTdFUjBJaGdLelo4RWxzOW1XTUJ6NEZ2bExZR2JuQndwQlhKRnpZQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021494d5-9f21-47c4-fbfd-08deb733cefd
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 12:23:47.8402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3G+nXPvU91wC7QqnpO9zEXwqBJLTZGECV/8CM2iMW9cYPeJgnfWh77eJPB+ZZHDT20VkUZe9+3i56PpMbijzIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653

On 5/20/2026 5:18 PM, Dan Williams (nvidia) wrote:
> Bowman, Terry wrote:
>> Hi Mauro and Everyone,
>>
>> During development of the CXL protocol series [1], the Sashiko tool 
>> identified an issue in the CXL RAS UCE trace logging for Ports and Endpoints. 
>> Specifically, the CXL RAS UCE header log size is incorrectly defined in 
>> drivers/cxl/cxl.h.
>>
>> The UCE header log size is currently defined as 128 u32s (512 bytes),
>> whereas it should be 16 u32s (64 bytes) per CXL r4.0 8.2.4.17.7. Correcting 
>> this will change the trace format and break the existing ABI contract 
>> with rasdaemon.
>>
>> How would you recommend proceeding to resolve this?
> 
> Split the definitions into one that reads from the register space and
> once that passes the parsed log to the trace buffer.
> 
> Something like:
> 
> u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32];
> 
> ...zero-fill that and put a comment about how userspace has already
> grown a dependency on the buggy size.
> 
> In other words, keep the userspace compatibility, but fix the iomem
> overflow.

Ok, that's straight forward. Thanks.

- Terry
