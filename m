Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A323546C6;
	Wed, 20 May 2026 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306947; cv=fail; b=dJ0O6Pw1LNTQQxlUpBhX3VHIH8tsQRjB/UVaZqxucVqJn1SsNBppJPfNM3KnI2yNXF8PWFfV36Andb3q3MCQjFWHZtePGGfMeiA6cImIBusYfPT+0aSsMNvrDXdj1HEHmp04xHn37gdekQVaIpehqs2jf1muLC/PdTHefPRamak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306947; c=relaxed/simple;
	bh=AXvPch0xjwJj24S5Hq1ssc3DBSNu4+Ne3X3ton/kgbU=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=UHC4//RQSIQjz3y8LKfjYtWfafoY+C+xDc9WP7W9qkyMOjq/75EG58qurqRrC2B9iDiwzL6aiWSBRBFj67QoZh8DYpOwl3JWXU2Nfb3mwpy1upAB/5WG++YynmkG8T0xawwt93Hkag+OHe4qXDKvQv26auujdi7ZSs9nr1CJub0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k5zmtaf/; arc=fail smtp.client-ip=52.101.62.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k5zmtaf/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ln1TYRqQvbY6jex3yu+bx6SPDjqgZUphkGRCb9BmhwwLrz3QwSmkqQoSdnbs05PJ65EChysq+xuNyDyF1/oqVBBe3bJGtDssA7Rt4zlIt8fBkMP0V6xYb+MyGJhVGxSy8ww/LrY2rfpt03dEY131eRgkKt8z2lRNWKX47jxMQ7O/bpAV6zmw3FIqJMe7/FMSsmHaZYRb0adKb8F6PySWReCuok3axosNKG8Y9QBkhGNqNCmK6WC19ZGuJ7CdAMDQXggxLlSK9snzEqvFztlkrJvtmg2FL7QBMU3q6rzq4hGa63F2Y2DuB5LjqrSsBv0tPrXAr84i/5Pi1wrSgEbSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XARKEHI9b6GEaVuRB5au2AyGWv8RosDAQmvKjcDv+2g=;
 b=DZmTHMt5VDiosvQhFePiyzt1uhul5s0G/Lb9pzuwgOfBEvxtoTIvukPMgf7Iy0BGm7b4f7Kv2mAbZl5LOAu3infEmsc67P3goLry8QdTxpLEtcihZHc0PRnsITB6LUQkK9jEhKeIgx3ZNsLDgxqOgatEEddDyxyv8vbeg9g3ksnTR/b4c/jVe4e/c4EBuzghZ3vlFwmjKewmpAq8KiAXshds2plb+leuiwXwau2ENvGPrRAazQ5q8wdC5qGeLMJdKtesJPsdJIVckim2WEyDT2lRwmxY2Iv+Ncirl7IOqJ3aBStfLex5fGTjLmpPJY02hi607d0P4Pe6U/+XmT5eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XARKEHI9b6GEaVuRB5au2AyGWv8RosDAQmvKjcDv+2g=;
 b=k5zmtaf/6/liN1n/Br78fkyf/4Ix5wSKhzrwoBiwPnhR3tWqhNWVoPpOeToCxKTcyUQzCQKxP9WauDQYTm6YfYRRWPkSiQLVQaOVHkPqMsNUOJGmyHe50nYR7t8CXaQyC8jxPU6Bc5zBqsZhosJ745SCqMBZhjHrjFtKzP8FffY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS7PR12MB9549.namprd12.prod.outlook.com (2603:10b6:8:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 19:55:43 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 19:55:42 +0000
Message-ID: <51a77746-5199-44a2-aa2e-d04cdd6084e7@amd.com>
Date: Wed, 20 May 2026 14:55:40 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Smita Koralahalli <smita.koralahallichannabasappa@amd.com>,
 Robert Richter <rrichter@amd.com>, Jonathan Cameron <jic23@kernel.org>,
 "Dan Williams (nvidia)" <djbw@kernel.org>, Shiju Jose
 <shiju.jose@huawei.com>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Lukas Wunner <lukas@wunner.de>,
 "PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>
From: "Bowman, Terry" <terry.bowman@amd.com>
Subject: RFC: CXL: How to handle trace event ABI break from CXL_HEADERLOG_SIZE
 fix?
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::8) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS7PR12MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: 303a042f-05b3-4bbb-3a69-08deb6a9c662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|921020|18002099003|56012099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	tQw4+wsi2rjVKlRkhR6ogWj49ZNzrAW6vHXQYKg1ZCzbSN2DZYcVGJbsXfrJ74o/u8nj91yVE/fsrxLRLcAEiESNj+I+veS9ATCJmcXw1v0cH7YP24MvTvbL02m0FfZnhSfjKOqdw/OlyyPCqtVaOULl+BXcc6HMmjkUG+yOzrQ+x3Ne9bzMte5FhOhThiVRqi9+EMtvAM885nyc1GBYttHTWmeqhFfIW83+pTgXfklBmgPOIdWa8Db51T8BWdtpeaTlBjv8TtG/RQ/jnbfknkMEPBn0kIrSKlNcfy0Hx6M/UJBplqS5IeTLA/YToHu1jf/+IoxKM4GmByJc8oUyQ6Av2S4bd1lRHwDRYYXDUJMLogQwe9Mk406HJPrMq3HbIW+Qe99zIocO92/0VXn06mKFH003qKmPK9PfYSCe7FqLaMXWHniBgnz5uZFHEnbbhSN6YHJ2ycSBBBqQMfMXQZxs2Z7mYrOQh1kYCaLsuTG+x0yeg+wTez7EAGo8lMLrobOPmN9JnD+b9Jt5Kmg/58NNVtsy9YqEjq9hZM9dHpsqqgfu1UQYuefaslaEdPRnSW5hoAobmjlOy4bQ8EXkPeI9Ww2phHaUSYxCNzT919TiKkJwAWWFpSetAqAdoUI2rK6EwmZJe8EBDPppfrBzhG/JKxhCK+1dEfopGhuXO8owo1jhRtBHLhpU62dHku9XJhC956vccY8g6BqzKrmKcLj8aUCRx75jVQRm80dEXT0HncYPLIJkW/Cey3CYLxwc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020)(18002099003)(56012099003)(3023799007)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm02NHBtZ0ZmWHdISWdGOW04SmVGSEVOenIwcWV5WWhXcysrbkdaQnhTOG42?=
 =?utf-8?B?alA2M2RwZlByN1FWYTBLaG4vcGN2MXRhYWdPUFdCallFUkIrdnVQWDl3Vkpu?=
 =?utf-8?B?eEVzVjkzUUlqY2dDWGh0TVJpR3JLRFdqSklIQmhPRVJzb1RIUHBQczZWd0NP?=
 =?utf-8?B?YnBtMTJ4Qjgyc05CSTVCcEorZDhDZHV0Wk51UE9LRjNxSjVyZi9GbHNaTHph?=
 =?utf-8?B?S1VtdDdaNGFGWUp5SE5ldjR3RnQ4MU9PUE5PdmUzYUxlRE91UW5mcE5pTGpY?=
 =?utf-8?B?SXo3bUUydVZuTnRCRjY1M0tUZlluR2pmM0Y3QWkzS1VWSXF2QzlOSlBRVFBp?=
 =?utf-8?B?Ni9PLzZxQTZVS0VTc2ZvNVhDRlhDb0tIYlhsSkJBQ2hDc3pqZDY0NzdmQjdy?=
 =?utf-8?B?T2RpUHZGUnVYTUJ6dC9YZm8yOXM5VmhDWTdlZVJ3OUxOVUdlbFUzZTVDMDgr?=
 =?utf-8?B?MkJJUXZHNmpBbURWT2ZROHhranZjYnZ3OUxLZ2hEb0JTUlFKcGhrWUx6VnpR?=
 =?utf-8?B?Y0ZnaWV2UWtPR1ZWTjBUMjJvc1dzZk5INmovRk1IRjQwRkR2WWEreWI3TUhY?=
 =?utf-8?B?dWVvR0taSHY5REFVc0d1WFhBbkVoZVU3MC83VUNpbEc2YW9qY0Q3RTRadm9O?=
 =?utf-8?B?dnMxUHZzcmUxa0wvblBDc0lUT01kb2xzQzVOMnh5WjYyM2V4MWxBL2hlY0hq?=
 =?utf-8?B?cUx5VkxQa1VpaG5Kcnh1dGxVcFRVK3ZqdXQwRVJ6OVQrQ3NjWG44WkRJRDlG?=
 =?utf-8?B?Z0UvcnF6Y05nZ05Db0NTZXhoNkFHU0dMUlZxZkR6bjlYNlpmNERJeWZoK29v?=
 =?utf-8?B?b1VXRmN1cnppWXl4OUlNZUpWblNvbU1Nc1ZLakEwVjU1c28vTjBQVjZJOU5m?=
 =?utf-8?B?UFlGa1dHWHFZS0dVRnR0R0ExZTBXYnVROVRJNS9hdStrRGJidVBxYXRlNVMx?=
 =?utf-8?B?eURjdi9jQVVLVXFrT0ticFU0SjJJZWwySDV4bVJ2OGJmNklmUkcvZElWaDlx?=
 =?utf-8?B?RXBUSjhNdlM2S2wvUVA2L2FhMjZybTJHVE0vZ211Uk5rQjZKVkhuajBtTmor?=
 =?utf-8?B?V1pmS1Y2dlpQMWMyOEV5ZEdKRUk3dmlyYThVbWtYVVh3SmUrd1hCaXpXYWMz?=
 =?utf-8?B?VFUwV1VJMW9rV3ROWTBOOHNDVkhONnM0cFpwbjN2NFpxaXhweXJjVWpMMDhl?=
 =?utf-8?B?MnJiSmNEcnc2T3F2UDczd3M0bjE0ZGovZXVKeTdwbEpiVzNFTXRnUFVJYS9Q?=
 =?utf-8?B?elB0S2x6ZkpqYzFmSVVuM1Y1SVRLcEVVcy9VcUJiTXR5UGlSWkgxSXJuNVFo?=
 =?utf-8?B?L3pxV0wvK2V3dDkzL2lta3ZwUlNHV0I1bDNpQmdoaEJNZncwTVZud3hZRHVv?=
 =?utf-8?B?Wk5kR3l0cVRaUk5ZaVZQTnlFYUNxRTJXTUVEV2tIbk5zL1cwWXN4R3FKVGI5?=
 =?utf-8?B?aGx5QUorSkhkZmNjbTI3THV2MUpHVlVQWnhRZk0ySENVUjR1dWZ0MTQ3NW1s?=
 =?utf-8?B?ODBFNkx0SlgrR1h0VWxDUzBTK2FWVlA2ZXl5bVRsdVhKRmtiVE4wTmpPSURx?=
 =?utf-8?B?UVIzQXc2Q2NEVUpFVUoxNzVCbFVMY2NJMExpVFRZK2UyaFhuLzNZNlFqSW0v?=
 =?utf-8?B?UmYwWDlmK1FUaGVseGtMZ2owQ0NldUxXclFjZEdlVDFVc0s2L3ZIR0xyVEQ0?=
 =?utf-8?B?M2FwcUJPd0x6SmNiOStWMStNNGJXN1llMklLdTZXZVRtcnlITzFsand4V3ow?=
 =?utf-8?B?MXpmdUErbUJ5MkMvakswOVd4ckNDSmFJQWU3VGlHWDV2K1p6S0xnK3N4L09E?=
 =?utf-8?B?U2RBSXZqKzdPS2M0Rm1rRUlUbkovdGJ2c1VidGN6d2dJUUJpR0lLV1owSUdp?=
 =?utf-8?B?aFA5Y0N0ZUViV1lmK2tpZEtNdE5jcmFYREpLUnZYMjR0YzVJWFc0Y2VqTkM0?=
 =?utf-8?B?Q3NFUWJtdXR1U2FGeHE1Y21wejV5b1Z5MnU2NXBxditnaE4vdFgrNlprcjkz?=
 =?utf-8?B?ZlZIZTYwSHcydDZhMldMUFVPOGtZQmNLVXowazBWcW1HcG9mdVFHTXVYcTRZ?=
 =?utf-8?B?Qk9LOTZrUDBNQm03WHF1dVVpWXVYbHNsempsVEJSVk83aWhaRGlPeXFYMlV6?=
 =?utf-8?B?UnJGUE95VTRaUVZnaU5keERZVVFmaHNFenNRSU5QWFFlMHZaVnBuZ3JjeUdR?=
 =?utf-8?B?aTJ1bGFFYTZvaFhrcUh0eTZCSUhiWlpVcGxnVllybExJODh5TzZSbTl4d3Fm?=
 =?utf-8?B?Umd6TG4zOUNYelFIVDlJRkkrNDZBZE9NZHJxZEVidmsxTG1ZVm50dVlvcUJ3?=
 =?utf-8?Q?Jj+pmzMc6bLEfQXF41?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303a042f-05b3-4bbb-3a69-08deb6a9c662
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 19:55:42.8690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqTTe/GjhW1dbO7Iaj/TckgO460Ye9s7joVVacwPwdI3g4IWv/7sN8AqLdww1Fj667gU1Zrd6UD1uemLeM3nXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9549

Hi Mauro and Everyone,

During development of the CXL protocol series [1], the Sashiko tool 
identified an issue in the CXL RAS UCE trace logging for Ports and Endpoints. 
Specifically, the CXL RAS UCE header log size is incorrectly defined in 
drivers/cxl/cxl.h.

The UCE header log size is currently defined as 128 u32s (512 bytes),
whereas it should be 16 u32s (64 bytes) per CXL r4.0 8.2.4.17.7. Correcting 
this will change the trace format and break the existing ABI contract 
with rasdaemon.

How would you recommend proceeding to resolve this? I’ve included the Sashiko 
review comments here:

commit 07869896095a6c3e7f10bf70e3c8c7b3f11530e1
Author: Terry Bowman <terry.bowman@amd.com>
cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size
This patch corrects CXL_HEADERLOG_SIZE from SZ_512 (512 bytes) to 64
bytes to match the actual size of the Header Log field in the CXL RAS
Capability Structure. The old value caused header_log_copy() to overrun
its iomap mapping, and caused the cxl_aer_uncorrectable_error trace
event to memcpy 448 bytes of kernel stack into the ring buffer.

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..3e69bcdbbbed 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -158,8 +158,8 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
>  #define CXL_RAS_HEADER_LOG_OFFSET 0x18
>  #define CXL_RAS_CAPABILITY_LENGTH 0x58
> -#define CXL_HEADERLOG_SIZE SZ_512
> -#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
> +#define CXL_HEADERLOG_SIZE 64
> +#define CXL_HEADERLOG_SIZE_U32 (CXL_HEADERLOG_SIZE / sizeof(u32))

[ ... ]

The commit message acknowledges that this shrinks the header_log array
in both cxl_aer_uncorrectable_error and cxl_port_aer_uncorrectable_error
from 128 u32s to 16 u32s, changing the binary trace event ABI.

The event format exposed at:
  /sys/kernel/tracing/events/cxl/cxl_aer_uncorrectable_error/format

will reflect the new smaller layout after this patch. Userspace tools
such as rasdaemon, perf, and trace-cmd that were built against the old
format file and hardcode 128 u32s (512 bytes) for header_log will
silently misparse events from a patched kernel -- reading the 448 bytes
of unrelated ring-buffer data that follow as though they were part of
the header_log field, and computing wrong offsets for any field after
it.

The old 512-byte size was always wrong per the spec, so no correctly
written tool could have fully relied on it. But does the Cc: stable tag
risk propagating this ABI change to stable kernels where production CXL
RAS monitoring tools may have been written against what was, however
incorrectly, a previously stable layout?
Is there a way to accompany this with a tools/ or Documentation/ update
to help userspace consumers detect and adapt to the new format, rather
than silently misparsing it?

[1] - https://lore.kernel.org/linux-cxl/20260505173029.2718246-1-terry.bowman@amd.com/

Regards,
Terry
