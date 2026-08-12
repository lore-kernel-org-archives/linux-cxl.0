Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6055E41CB2D;
	Wed, 12 Aug 2026 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528695; cv=fail; b=rxj9kPGkdHtfmg9MI/GvE0lqUsO0YsQwZUEehCP69VjQc41HSN2vt4vNoPbk/wdyWy3fiL7nSVcP3azbKCKGWTNmTWKcKJFNq33NtGvpXbROU+jaG+aJc534z7RZMnSRyRpXNOftmce/IAOuvsNmnzBy4eYpNEOF63nxRnxXyI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528695; c=relaxed/simple;
	bh=88Dcs9el1IsiTRLDWXKgwAmuu6KOQ8TIpsyFoD7lk48=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HxQcCmAXOtyII5hzBo4HaaIm2p90BcwBYRXfW6CGlrpOG5aQjz6Rbarsqwo82aXqAxJcbGN2LZuwfLkCI259y+shbLwzTGW7Kt13AQzlYyNLuD7yPaARDKXxp36P33AveIBddRZEgwNlNOzWvlUkh12/Tdv3BsrKDLVji5YLf8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uZkbQcXa; arc=fail smtp.client-ip=40.93.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uZkbQcXa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlQxmL3tGYOAxWTz8E+Z/4xrm65WiYUCQXqMC/qRaATaEo2ooP/XEIaaUQo1AJQ8gNMa1U2WQg5bkKHtgec9EJUHhnf0TFAqYiqwvQQILdxtbqZ7fZyc4u8upnLhajlPXzOBEKY1+uISyLG9NOqeg0d931nbE21TsgSBBDbZsZSBgBbv4mp+H3Sy1qr/AQDYZdw2082bPjM8PfTRXserq7HxgkUsOEBuMuMpt+oID7i55b0wOzK0EjI3j3lyywXIddj1Y1NYEVHlH1WkwByqSq+0SXOSUPjNzU/LIlN950ynDFNTkWUB7GGXG4laipCQcVuvgMEuK9jgp8ZMbPlNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgDe4nMkE1MMvw/RUlExGMHKunG6EcTmoiG1rvuSFmI=;
 b=QQGw2Zk06/p8iFidGSZyHYqC9aybx/54cq20BX0iwVOmJJEqbtnY2fQT34qoszl4Ize8R/Lq9ZtpVBz3bdYgTJN+b+aTMIak/pMiRXsqImIqZyvujjdyhXvqNf/Sn/Bw8whHe67fAhftEM62cQMNc0g7euVXc7/PbqE7Kc+NdYBo/fjj+up7TNVDF4s5FRd3nBpxVg1JBL6BbDRRcmYvhNi5qqsYDFetMpuMeWF+W1HtRB9TIMUHdF2t4cboTRVEPzQ57lwdkB13VXQCxx+Z3BukFL0ykJc64fos1O+ym8vyueF96pnJongMd35plIHBQEByUvHMX7ed/fhsgVwwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgDe4nMkE1MMvw/RUlExGMHKunG6EcTmoiG1rvuSFmI=;
 b=uZkbQcXa+zGbaa0fdC8ZqPwiIdTb+x/wVer6cVQd8Uzda5DgDO1fi7dILMtf5lokbd4JUMh2JMW00uJjC7W0etzKcb6Fm7z6JrDYzITSktv0AiTyij/pcLmTALr0I3gen0otRwzae95CFChNFW7HL2iaKX5wLNUVLXyYjPmhWCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 SJ2PR12MB8883.namprd12.prod.outlook.com (2603:10b6:a03:538::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 09:58:08 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 09:58:07 +0000
Message-ID: <a3978557-59d5-49bc-bdb3-9ef2dfa025d3@amd.com>
Date: Wed, 12 Aug 2026 10:58:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] cxl: Auto-create a region for Type-2 memdev
 attach
Content-Language: en-US
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 djbw@kernel.org
Cc: iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com,
 kobak@nvidia.com
References: <20260805074042.30173-1-icheng@nvidia.com>
From: Alejandro Lucero Palau <alejandro.lucero-palau@amd.com>
In-Reply-To: <20260805074042.30173-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0552.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::14) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|SJ2PR12MB8883:EE_
X-MS-Office365-Filtering-Correlation-Id: 5147b9f6-5eb9-48b6-d505-08def85835b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|56012099006|11063799006|5023799004|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9uCSwAJnsCRY+XEuHR13IluWtoRLNGSZCX7pXeFbejlZYGQYeTcJj+ke4my5viENseYKNP4+lH95S9yzxdDdeXl/L3gpTDf9qaGGc5vxGvputcySnZnNZ2sF8aa8YK0E0S6jcF11IzpkXrgP/lOxNkHI+szzzz5bAZkTpgK5OMzC0m1zS4nyTuGVOsjNAW4MxMGHB/YiA+jwlEf/iSzdylwtXboNiA1vuEXcWHEtnWSh+tkrAszcmJXIB+gsImVNZVEMZl0ukF+iCc+3UffYPlEiauGzV24m9Z0RXSJOaE/EVP4sr96HnOGSYW9lBpT8J/BZcoYgjSmN2XuXuMpNUqagSL40XRceg8i3A+v4S9Oboh+LGeOHuLXGnRoFQl8Mq7mogBJh7FM3HsQzTx36RNbvNE22T4XojdbjeyL0EH1NaTdk+NuByTOZtXLT+islc8r6luaYGq8PfCUtEh1k+Mcd2x5iKWUWlNJJqn7p7O18s+dutmgp+4pdu3dJdLUneKw9wKkmkF1kxzfiC0PyaMR96eFDSlOCeF66XTDd96aayqzvRXeOUcNG8uIF9jnkLV9Nhup1Do8booLo8DdMUfY5izGSobv6zsbs1VTJpYj/i8acNgWCdQdW4aitsMU2/Qqn8Sm3lXkd/g0sYMXLw7HLcVsDuK1hdc5TwH3LZ40=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(5023799004)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWsraG1nejNEaXlrZ3ZSM05BV0hjYXFjcEhwRU92ZzZScmJncWwzSEhzSWRT?=
 =?utf-8?B?aXdRVkMyVzU0UXBBRzB5NkhoT3RGbjBNd3BqRGZobE5kbkVsZ09peGlEQlpr?=
 =?utf-8?B?bm9TaDcra3czZlVyTVFSa3UyQS8veHRHZUZnZHhxMzdjM3Y1OFpiRVV5WGNn?=
 =?utf-8?B?a09iUW1kQ2NFbkxvUVB3Zk05ZEJXRHJjMmhqTGdjNWh5cG90TjJ1eHVxUWM1?=
 =?utf-8?B?WFVldXpaZWo2Y2VTNnJWWEZReE1MV1FpSzJmc3p3N0s3aTlZQ3ZGem5PT0ZO?=
 =?utf-8?B?Tk9DbEdoMTVySkNrU0ViNmZqbFh5SmpNWEwrc0ZYM3JTMkxFaVp5OVZnQmh3?=
 =?utf-8?B?ZUYzMFM1dXA5Q2VRZFFZTUV2cDlmRkw2N1IwcUhYV2o1cHRxOFo2RWtqbFZn?=
 =?utf-8?B?aG45RVA4SzdqeVhBTWRXb0pQV1E3azEzTUdCYWhmOW9IeWwzeVRONm9ENVNX?=
 =?utf-8?B?a242Q3NKNzU4YXkzWnk5QXVXaWFlTWNhbGZRczg2RGdNRS9leWxUcFkvWFIv?=
 =?utf-8?B?QlVYS25lY3dVVzdkQWRqMllvVktPM0czdGVILzlsRFVhRFdDeUlEUzNkcmIx?=
 =?utf-8?B?TldqYUdPM2ZTVTFLRmQzNnZGUm93NWF4OUdDc1RPR1hja2w2UXliZ1plMGZl?=
 =?utf-8?B?SmwzWS9RWERTL280enIySGxpQmJhTjlrM05aUjlrKzhVZEJWZHplN1VBOVZu?=
 =?utf-8?B?eTdlQVFsdmJONFBnNFJxd1NHamRCTkNKYWQ2WXpqVmlia0x0b2hUU2R4WTB4?=
 =?utf-8?B?R00rdE5vWUV2TXNhcE40bmdJL0lxUkxxSms0QkVWR3BTSDB3RXZjUm5VeVZB?=
 =?utf-8?B?ZXZrUjVsZjJLY21wRUwrTDViWDJqaEZ1cE1qTk9RWHZSbklHbGM3aGFEbE1R?=
 =?utf-8?B?WXNIOXVNOGYrMUh2bTcwM04vdElxQ0NNZkdLVXU4anFmQWRLYnNKVnBNMjM1?=
 =?utf-8?B?S3c4SmlRZ1kvMzUvSlMzMXJ5U01iM25MdUVYajJiZjBIdk5hY2x2b2VtT24w?=
 =?utf-8?B?VDlmTUo5M0F3V3pxYnZBK0phbm0vOC9FMWZZUjhPNHVUMTNBK0ZsRUFqZnR2?=
 =?utf-8?B?NlBxdElOY0JaY2MvVXZhbXZmZkFFQURBOG1QeFUzS0o5VjF3VDk1Skk2SUtv?=
 =?utf-8?B?Y2dYRTlqVGZ2VEpFVFBqejdHSmxiQ1pZVnBDeU00cTlsbk93aGhCeFlra21H?=
 =?utf-8?B?ZEhrVjNNTzUzSkdZWUNsbElwU3cydGR6RVd3TG93MVM4WWx6MklvdVBrcTdn?=
 =?utf-8?B?VDQ4NklOWWgybWN1ci8rQ2pyNnJUaU9MRVJKQnM2RDBMZDZ5VWVSaWFBcmp6?=
 =?utf-8?B?RUIzNzd0WXBzRm82RzdxdzB3c3QvQ2pwdFQwdFI5cEU3YU5acFN3UnJYdzhK?=
 =?utf-8?B?T2hEVFVwbmNSdVB2TWE4RmhPcDh0NUtFUXY2eGRKR0tVY3N2Z3VrVXZpNWFi?=
 =?utf-8?B?V2dxT1cvWWFEcENFWVdINUVpQXVpZzl1RWtkU0xmZnNndWNjVmNjTnlGTGc0?=
 =?utf-8?B?aVM2TERMSG1DdlJHY3BwWVdKeEV0R2dUODYwRW9CaXlVNU1lcWhHTEJ2MVpD?=
 =?utf-8?B?QnQ3VllWTkJITUU0ZFZZMFdSSThnT1JPS1htS0IzMkVKSTZSM3lSUmpFblB2?=
 =?utf-8?B?azMzcW94bmhZTlRIdnRQR1ZWWXZOLzQvLzRIdEswaUU1cnN5aXlmYlpuOFFF?=
 =?utf-8?B?aHdjaHMxNUpyQVFQdGlwRDNUazNFS2ZaRkpmbjhaa1B1KytoVTlPZlRLWmVs?=
 =?utf-8?B?QUp3WmN3Nlk0TjRocWRES0E3ank0VCtnWHZDRlRwYlJBalJLdjRXRDVFakgz?=
 =?utf-8?B?alNXMFRCOUpPZU9xUUMxKzRlRXFnMk1palorUHFvTmRMNGhaZ3hsaFFHdkJr?=
 =?utf-8?B?dlltOHkyQVdJSHNWOU5QdjU2REs5K2drdzNWN0VBK2R3K2Y1cWNTQm5JM3pp?=
 =?utf-8?B?b2M2SUE3QUlhOW1pN3Bad2oxWkZZNmo2cWp6dDVaTmNEaU8xN3VKQ0dBSW5J?=
 =?utf-8?B?N2lDbnRmcGg0RmdpWWlCRVdjdDVMSFEzdnNaMmwxU1lNdlRla0s5K0RYUG9T?=
 =?utf-8?B?Z00yZFFncHBqbmpGNWlBK0dmSEtRRFlCOFpUYUh5alM1cTZFbjNCelZid1Jz?=
 =?utf-8?B?dlJSenhXR0dWamZPUnpIRTFsaHNCaUxjUnVwM1RxdlZOU1E4aWViK0t5dE1Y?=
 =?utf-8?B?Z2x3VUxySlBubCtURkphM2pUdzBTSTVDR3l5V21jbWl4M0N1ZFdsU04yTVdE?=
 =?utf-8?B?OHNMRHRDcXR6cWhYODJ1UFRqS2Y5NmdwQW15VCtITjVNaU1Xd3UvY1dIek10?=
 =?utf-8?B?UnVmRGk0aURtR2FkVWdmQS8yam5Vcmdka2wwVDBWSWNFcTBLQTJuUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5147b9f6-5eb9-48b6-d505-08def85835b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 09:58:07.6414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Evg3BrrrBU9LGhyYQHajyUNR7/bmugl5gzqwO/krax7CgQgAINxUfW0bq6ke35LlBeJ2+EBWXzk5W7INesEbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8883

Hi Richard,


Some comments below.


Thanks!


On 8/5/26 08:40, Richard Cheng wrote:
> A Type-2 accelerator driver calls devm_cxl_probe_mem() to register its
> memdev and get an HPA range, but today only if FW already committed a
> region. Real accelerators can have usable memory with no committed decoder,
> so get nothing.


The previous paragraph describes the current situation and the next one 
is about what the patchset tries to address. Maybe to explicitly make 
the difference would help people not so used to the subject.


> If no FW region is mapped, the core picks the device's unused manual
> DEVMEM decoder and a compatible x1 Type-2 RAM root


I had to look for this x1 reference ... and I would say it creates 
confusion. At least it does to me. Not sure if you meant interleaving, 
because I do not think you are referring to link lanes here ...


> , allocates the full
> volatile DPA and HPA, commits the decoder, and returns the range.


This is something requiring discussion or clarification. I think it 
would make sense the provider/driver specifying a DPA size instead of 
using the default full size. I think there is a good reason for this 
non-default size use: why would the kernel create a region from a CXL 
Type2 device using the full DPA size when the FW/BIOS did not do so?


This leads us to wondering why the FW/BIOS would not do so, the use 
case. Current Intel/AMD BIOS (I think you have the aim at ARM servers) 
are not allowing this case ... for a Type2 device having all the bits in 
place. If something requires to be specifically configured, would not 
the driver do so before using the CXL mem? If this logic makes sense, 
the auto-creation should not be the way to go.


The first 15 Type2 basic support patchset versions supported the case of 
a driver specifying the size for the cxl region to be created. And it 
was through a specific API call after the memdev was created. Last Type2 
patchset and the functionality finally merged only supported the case of 
auto-create regions from committed decoders, and using this final 
agreement for region attachment by the Type2 memdev/driver. I think it 
makes sense in that supported case to have the auto-create region but I 
can not see the reason for the case you are addressing now.


>   Unbind
> resets and removes it. Strict first cut with single decoder, IW=1, minimum
> granularity, first-compatible root.


I'm lost here.


>
> The design intent is that the provider F_LOCKs its region against userspace
> but must reset its own software region on detach. A plain flag would also
> allow reset on generic kill/delete paths, so we thread a reset context
> through teardown and commit rollback. devm_cxl_probe_mem() may now commit
> decoders.


If there is a real use case for this auto-create region from 
non-committed decoders, I think your patchset makes sense. But I'm 
afraid we need to discuss this further.


Thank you,

Alejandro.


> Testing result is in the following.
> - Built clean with clang/LLVM on arm64
> - cxl_test, type2_test=1. accel0 takes the unchanged attach path. accel1
>    drives auto_create -> a committed 512 MB RAM region. The test asserts
>    the 512 MB HPA range. committed state and 256 byte granularity confirmed
>    via sysfs.
> - Unbind tears the region down with no orphaned decoder, rebind re-creates
>    a fresh committed region.
> - Mock test only. Real accelerators whose FW commits a decoder take the
>    attach path, and vfio-cxl binds only FW-committed devices, so auto-create
>    has no real-HW caller yet.
>
> Best regards,
> Richard Cheng.
>
> Richard Cheng (3):
>    cxl/region: Reset software-created regions on memdev detach
>    cxl/region: Auto-create a region for memdev attach
>    cxl/test: Exercise Type-2 automatic region creation
>
>   drivers/cxl/core/region.c      | 422 +++++++++++++++++++++++++++++----
>   tools/testing/cxl/test/accel.c |   7 +
>   tools/testing/cxl/test/cxl.c   |  61 ++++-
>   3 files changed, 439 insertions(+), 51 deletions(-)
>
>
> base-commit: 1c6b4ceafc3b994871c29340e0c1ddb0af5800e7
