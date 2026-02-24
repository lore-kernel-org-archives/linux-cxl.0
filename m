Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E31C01
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950621; cv=fail; b=itFg+thbiVj0pr6b7YpmUWLufunloA29T4/DafidYTL9QPQP7bMWcp9RNFASsZs32sZlpNx5K/ssKi3PQcVI8JrLRu8h08rcYFE+iZEP5X6QYhkVmM7Z+zBSdC31/Zxf1PzzgGqUHZN0Y19vyy1odyPg0nRgueNKA6kxqNtSiD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950621; c=relaxed/simple;
	bh=2dZkXVXx7asgyInkDFtYcIi532RqfRHNrx+qa1+p/2o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G3cwcMkpERSuwxxlpQvLPq4W6DazwWeowSuM1VhYyngJqn3fbalKPGrPeW5JZgcTY3b5QJNV56k1F50H6f0+KDlMTdE2d2YmG99H9D+VnFLD4k9xwox2npxG491ZIYTTUBPSAYqR5LmtQfUoOvV1OtqU61kaA4lbi6lk+ZQJg7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yzGUyoEI; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yzGUyoEI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmrbuxebdwCttKpYW36pMeBzkFVJtoJdxgxDpWvUF2/WVf2Lh0JwXtoos1DtUhF00ZQfO0jwZdX5Bslv6BHAqw/+2jIOg84SRfhYXaImLEIt5+YnDbfO4sH5ZdxUaLVlkq+MohtfrW9zb9SvQLwjRT84B/4B1lc6U5/c7Vkket4HIb1+Jer8qbjv2Pb9y7kUS8lt2pxaDKeedyPc898N5aLTo+33WE7ojDffo+g8WmhcdxlIhV6PuE2xmIrlhDRky/yrr++gV5PkkW/+jLht5moHVwDFG42DrWMoCDCRV32VIOuNbNWbUU8wOBIhGjqCNSzPa4TkCtngKnBVd0xqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb4RPh365WBoqAgDxN7ZV8Azqvj/1okNFwpa61mjCI0=;
 b=CkxJ0srkdz4tPR9kgUfozoDM1tayYUtKIiD4EhuUGTg0neieqmNU+HDaHpjGtRf7DiYevFxpZ+AFzLJTJ3TXops11rZudYB1JVNppZd77fsNquK0J7ugBeqdnlMcQpsJ5AxEoYwW3sOr3HJeLduM9RnM4m12j5BQl2kpUZYCttIKltQxikIqJa4Cl6LKT94DO00aIGkQw3cO6N2TpzQD6JFAr/QLZmP3Pg0okC0GTRP7ycUC87SRIVZO1S3Afa6exMDWgG1TvB3m8GITvQ+zhJw4GAJaYv0lZsKj81MkiY2XoJ1ndlncDuqLOmwBLjz3ahEAjz8T/mgbCrL3MFzYnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb4RPh365WBoqAgDxN7ZV8Azqvj/1okNFwpa61mjCI0=;
 b=yzGUyoEI2qh6ebkHC+mkLEygWTQ+U3JjzdLkr2i5edSf7snd/GyZhoIfF2uVbrGdi5vokzcN1upGOnMUh5ou86mqICKgqdDJJywDIAbGUdOLv/NQ5REDYfZ/VS26OIkpxulzcUJtu6XU/4XFI7tCbR+szco4YOGXSKQweQG+dpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 24 Feb
 2026 16:30:17 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:30:17 +0000
Message-ID: <44ccf9e6-d39d-4926-a6ec-35e900d5ec5d@amd.com>
Date: Tue, 24 Feb 2026 16:30:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] cxl: support Type2 when initializing cxl_dev_state
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com
References: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
 <20260223142633.2994082-2-alejandro.lucero-palau@amd.com>
 <aZ0GzfdM5i24ymFr@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aZ0GzfdM5i24ymFr@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0663.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5c3b92-d288-4ba9-d8e4-08de73c1fed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjNGZTFxWW9DQUg5QnNqSWxpdnljSjNQZW9sNWV0cGV0VjhKNWRhaUNqekdE?=
 =?utf-8?B?ckUzZzEwOWd4YlM4cC9mWWJpdXRVUWx3NS9wYnVYdWdGUjZWcVBlMVp4Qngx?=
 =?utf-8?B?NE1iaXdqSDZEZE0vdEV5OVNuOUlqQ2NvbEl3Skk0THdoU3ZuanRPTFo1Rncr?=
 =?utf-8?B?ZHMyN3NRT3kvYWkwUGtWL1l4YThGZ1MxcFYxUkVCeWpaNTFKT2tpcW85TzIw?=
 =?utf-8?B?aVdneDE4RjdkS1RsZVlKUU5ocGNzNTRJcGRWOG5tTU4zdytaeTdtOWY5d1NL?=
 =?utf-8?B?aWdDeUprUTNLcVhEOFQrY29JeU9SZStOeTJpeVpyZHlGZHNHR0F3VW5aNSt0?=
 =?utf-8?B?NlJjRkNnb2l0Zk9QTHFmRGxtTE50TjRFa0QyQ0t3bWNXK1U1L05NcUQ3eHJl?=
 =?utf-8?B?cUVFUUJMb1ZzTi9BMjJKbk01MHE2OWI0WWtXdzlFV3RjQnJrTFFzT2I5RmhY?=
 =?utf-8?B?elN1UklILzFxZHROdTJQVUNIUEdpSDY2TGIwRm9naU9rUi9UV0pBOWF3K1Y0?=
 =?utf-8?B?K2NDS1BLSTRQazc1QnNLMVpPRTg1amRPZVJnMWtnT0dvcmlpWSs5YUY2SVYr?=
 =?utf-8?B?cWRDeEFsbFVrSEJxUDgveTFpUFJ1OEkySWRoaGRwZnhsZk9UQ3M5NFJabFJ0?=
 =?utf-8?B?OFRtRVBXbFVGdDIzeG9ndGV1NDBvckx3SDN5QXRJcm1PY0VJSHd6M3hUNysv?=
 =?utf-8?B?QmI0ZTlMRHVPYWxzcjhqd0ZMdlQ0ZjJMYTc4VW9yUDJBUkR5dlFaT3hqSnBu?=
 =?utf-8?B?b0d1dVN6dFN5NG9nZ2o4S0VFQVRYR0FTUVkrb3hxZUZ2RlIxUnNTMm44RlZl?=
 =?utf-8?B?czlMWWZ5cWg5NkxhN1hVNnZOeFl5TFRNY2F5Z3hzYjFZWmxPSEppNy80VURQ?=
 =?utf-8?B?NzY0VjlMejlnSFN1VFppeXhaVGI1NXI1NTFUOGNiT0x2SnpWdHVmc1Myd2Y5?=
 =?utf-8?B?bmh4WUU1TC9YbXF4OFMrcDd1L0lIY3NETjE3QlNLZ0VKRmNFRVNCa2NPSVAy?=
 =?utf-8?B?aGVjZHNKT0M5Z2JMbVVzaTNtcDNjb0hsODFyREZ4V2czalBFQ2NDbFpHc3Jp?=
 =?utf-8?B?MHFpdVZtUUY3SHp3NVd1T2FGbDBheCs1ZHBzVU9ONXYxTHFXempldFM5azg1?=
 =?utf-8?B?VVBwOXpCaWd4K3JTMm5xNForRko4WWl3cWJKVHdwVDlhem1XMllrdXh6cG1R?=
 =?utf-8?B?R1dKN3phaXo0aDYzM3UvUGF6Y0NHMXNKN2VqVXFBZjVhRXNsUnlLVWJZN1FF?=
 =?utf-8?B?ZWdmVE1GRzREdGJnaE5IdVBmeFlMbzRhQm9zQUpLVUZLbUwrWTRab2ZXUnQ3?=
 =?utf-8?B?TEdzWGxoYnR6UDVpSkZsMmxLZ1ZzWXRKTlZWQ0V1cGhkdUNGdHBZU05zK3RQ?=
 =?utf-8?B?Tm1Oby9vZ3I2T0M1dkl2UGlubjBLdDVveUt0Y2ZoeGVFV1RGUnpZNXpZbzNZ?=
 =?utf-8?B?bmQvNjJhOUZWL3lMd0JEQnppdmprd0RLSTQyYmwwOVZVeisrMEFwUWFvNEpv?=
 =?utf-8?B?UFphcDdLM1dJT2tFY0hmWVFsVVJVanV3STcvK29KVVUwSDk3UDhWY0NwN24x?=
 =?utf-8?B?WXpMK2g5Q01DSjc1QWlZRE1JY3RFdWsxSmEzdHp1UnVKSDhqb3UrVHlzc1l4?=
 =?utf-8?B?Zk5uVDY0UE82c3RoSDZqQ1lDVG9lZEV3ZGxVTzFVYThUbEkzL2V3U0xnTDJX?=
 =?utf-8?B?UW9wREUwUm8rT1FqMWwyUTdKL2ZJN3NoSGFjUjdJVHF0SEtmMGhPTFl4d0p1?=
 =?utf-8?B?Rk1FOUtDMVBGUXFTZC83Yjlic2loSk9IV0RoTm5BMEdDOGdUUmduWlptenMv?=
 =?utf-8?B?cUcrYm15RG81NTRRa1Y4WGpRdVJMbVFoaEMxOUxZMDJzWmV0dnFtM2wxcDdw?=
 =?utf-8?B?MWlNMkxjNjBPZ24wcGtVa0xUU2ZTUDVNR2xTZ2VTUVdkemRvU21BVmdwZU5F?=
 =?utf-8?B?c1ZFSisvWFFWbis3MzdOeVhxWmhaNGNmcEFVcGdydkREN1RRNDBObHRMNjhu?=
 =?utf-8?B?RUhMRUxhQWNQdHRlVkx1ZGJObWluU0MvTytLY2pUdlExZWpRa1lCNUpPWE1T?=
 =?utf-8?B?ZVpFS3l2Qldma2EwRVFETDBNWTEvcUtXZk1BUWQyblhCcEMwaDVqZ0V5alJq?=
 =?utf-8?Q?/a70=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzZEdzlRa09vM2M4YWNaZVo4ZGRXS0tGdWg1bkpoM05QOG80ZmNJN054VVk5?=
 =?utf-8?B?MGc3YnZJVmRJU2xXVEVrM0JmUVNzWUhxeFBTcjN0eVFtTDE0aGwvRmM5d0ow?=
 =?utf-8?B?OW9oYXVaVTY0UkhtZC8xTDBnSjg1VWluRzVZQjczdjh5T2dpUEdndGswcFRK?=
 =?utf-8?B?K3orQmxlL3AzM1QzYWY2YTVwUzRHSllzQTVxVFBPa2VhUHVtNEU0N0pMb0cx?=
 =?utf-8?B?TFJoQzc0eXppVWluRmhSaEVrVnQ1ODA1U1lqdGhDbW8vSkRPN3NyVVVvYkxV?=
 =?utf-8?B?elRIeXBCemVJMEFMZkRWM0NTY2lhNlAwTWcxVlpNQzFZbVpxK3ZZMkdmWnpz?=
 =?utf-8?B?MDlVU2IrWDZYb0plR0VLVnpORGtmaXhONUZpQTJBYUtkSXIwdUhFbUI2UnVZ?=
 =?utf-8?B?RmNhZmVNS2x1aDN1UnJxdFloMFZiV3UzMk1wVnYwMFN3MlZSdi8xN3dBZVE1?=
 =?utf-8?B?WGVzVk8xYUFlTG1wWmE1aGhzcCtmelk2dENiYS84WG0wNFJHSDdNY01LVEtx?=
 =?utf-8?B?MHJiTmxpanJEdmd5T0IvVGRQa09wL0NaMnVhcFBZNWF2cUJXWE1Jb1p3R3lI?=
 =?utf-8?B?OUhzcTFSVXJWODI3VEhINWpJMWIzVlVHc1hkbGZja3NOSi9YRFd6VVF3Vncr?=
 =?utf-8?B?MS9XdEt5ck9Ib1hrcmx6dEwwUnpUUFhha1ZJekw3T2JwOW1FYzNlNGFySW1q?=
 =?utf-8?B?MGlKTXBrOXFvek5FUE1JZ1phSkNOaHRIM0t3OG1YZWVSU0xyZjhpT2R5Unpo?=
 =?utf-8?B?eGtnUWR1K0RCMHpUTDd6ZWQvelp1NytnNFU0M3haYWZhaW9hb1NLRURXcHE5?=
 =?utf-8?B?WWIvTGR0NjJuYmRuWWI1Ynp6VzdlN2pXSk8zVERqNmxtd2paU01LcHNQU0c2?=
 =?utf-8?B?T2pxVzV6QnJaaDg1RWRneXIybWZSdnRrUDJJeHRMU21CMENkeDBRMFo4QWpY?=
 =?utf-8?B?R200WjREeW9kbDM1cHh2VVBla05ERDdtYks2K3RVMmoyeUVlZm9nbzU5ZWRP?=
 =?utf-8?B?N1ZzZG9KMlU1a1BMWmVJRXZwSUlzbGZ4T0lQS1p1V01oTkZZZU5QOFh6QTBI?=
 =?utf-8?B?MjFvQ2Qyc0FFVlpnajhQb29BR2E3NVNSOVpyRld0RG9USnhJV0grTTFSWFgx?=
 =?utf-8?B?Z2Q3YzhUM29xQXlXbkN2V2U2WUpoVnZKeDVqVkhjbjJweXQyVCszRGtUQmRQ?=
 =?utf-8?B?VnFwbFlFV3lFTnVWOFNMcnAxcUdLV1Q2RFlNY0JuS0o4RlFtTWgxNzV4SzlG?=
 =?utf-8?B?VVVXMTlvZnZST3d6MnJWbE5HUUw2cFBWQXdoUGtVNVhWaGUxQ0Eram14STBv?=
 =?utf-8?B?V2dNQ2U0eG1naFdRQ1ZhTVNCM3RyamtkbjJ4azQrR2dNK3lBVXlNbVp3T0RJ?=
 =?utf-8?B?ZmNadUpQM2gwQjBDcWNaOTJTMUlleHpUSFlzenU5UUFGQ0RDTzlTY2dFV1c4?=
 =?utf-8?B?VDRmUFhGVUlFSUJ5bHhLU09DdEZIbU9DS3JwWVJORnBaNXJMWjlSdUE2YXli?=
 =?utf-8?B?c1Z3ZTdFNzN4SEZSUkFoa0p1OXJOZXdYalVoVU9RTlAwSXZBYUpWa0d6ZVNF?=
 =?utf-8?B?aGRiTmF0MUEwUWJQanNhM1VMUk5BU1FxdXp1eHl0K1llcmMxMWIxc2lvUSs3?=
 =?utf-8?B?cUJGeEIvb2g0YWVQcWlJZTVjM3ZtckdyVHpGdW9oOVh1V2d1bTdEMmttc2d0?=
 =?utf-8?B?YUFaejVyeGJJbld4VTJUVm9zdE5ZelhoK2FrMUFKdmxpNHNweHYwVzlmVnpx?=
 =?utf-8?B?Tm95OG5CbHRSdnlXWU9kN01qRnlDUFZ5WU43YVhHQzRTdjZ0bWpyZWN5ZEU4?=
 =?utf-8?B?OG1DSTBsek5vREdhUitpSkdQNGIxSnZUYm5kOXRoZndkbjhZc2hTUzFDS0k1?=
 =?utf-8?B?OElyZFNrbnB5QTluT2xkZVY3TjJFWm1pcmhzQml5OEdORERqUDVlcG15dlhr?=
 =?utf-8?B?bCtGRHJKVWZOaUVleHJKSTBDVGxOVEROa0ZFSitiVlAvQzhSYkhIWDBYU1Zm?=
 =?utf-8?B?T2h6N2JTcHd6aTV6WEN5UzJTRjlNelpoRmVNUVRldjVxVktxZ3c2YWpCWEVj?=
 =?utf-8?B?MllKWEhmcmEzaStDTTg1YmZBK2lOYzR1UVF3Q2VMWnl0MHpqVHpUTTFBUnFi?=
 =?utf-8?B?MmxLYnRRZVBSK1dtTU1XOERFaHVscS9obVpNVjhtUGJxdVVyL1pCbEV6dkZD?=
 =?utf-8?B?QjJpMFFUenlCUndIekJCSkdOWkQ5OXIvZnl5SGRMZ1JQQnE2OElYOHMySTYx?=
 =?utf-8?B?SWFBTXdaMjJ5N2U2OVQ2UDNzWWEraVBTVXpuak1weVFScVhZa1hlL0VMb1I0?=
 =?utf-8?B?T2oxQng5M0htZUYzZDZjSDJLQlNEOUx1SHQwenlhRUI1YnRMOGFYUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5c3b92-d288-4ba9-d8e4-08de73c1fed2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:30:17.6766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNrXtbvU3A93j0Rfkn0T0FRXmup+IQDW3PZbky/47OoFTcZTuNRNq99KQO46Hhqlmi/eUvmNvclJkVqL3wEmMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222


On 2/24/26 02:02, Alison Schofield wrote:
> On Mon, Feb 23, 2026 at 02:26:31PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> In preparation for type2 drivers add function and macro for
>> differentiating CXL memory expanders (type 3) from CXL device
>> accelerators (type 2) helping accel drivers to embed cxl_dev_state
>> inside a private struct.
>>
>> Update type3 driver for using this same initialization.
> I've got 2 simple nits that could be fixed-up upon applying,
> and one question below.
>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>


Thanks Allison.


The nit one will be fixed.


About the second one, I think it is not a problem as commented below.


> snip
>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index f547d8ac34c7..ad131f053bf5 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -656,6 +656,30 @@ static void detach_memdev(struct work_struct *work)
>>   
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> +struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>> +						 enum cxl_devtype type,
>> +						 u64 serial, u16 dvsec,
>> +						 size_t size, bool has_mbox)
>> +{
>> +	struct cxl_dev_state *cxlds = devm_kzalloc(dev, size, GFP_KERNEL);
>> +
>> +	if (!cxlds)
>> +		return NULL;
>> +
>> +	cxlds->dev = dev;
>> +	cxlds->type = type;
>> +	cxlds->serial = serial;
>> +	cxlds->cxl_dvsec =dvsec;
> Nit one: space around =


Ups. I'll fix it.


>
>> +	cxlds->reg_map.host = dev;
>> +	cxlds->reg_map.resource = CXL_RESOURCE_NONE;
>> +
>> +	if (has_mbox)
>> +		cxlds->cxl_mbox.host = dev;
>> +
>> +	return cxlds;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(_devm_cxl_dev_state_create, "CXL");
> Why do we name this with leading underscore when we intend to EXPORT it?
> Thinking leading underscores are meant for internal helpers?


Because the idea is to use the macro and not this function directly.


>
>> +
>>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   					   const struct file_operations *fops,
>>   					   const struct cxl_memdev_attach *attach)
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index e21d744d639b..9daf4bc42692 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -523,6 +523,37 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>>   	return container_of(cxlds, struct cxl_memdev_state, cxlds);
>>   }
>>   
>> +struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>> +						 enum cxl_devtype type,
>> +						 u64 serial, u16 dvsec,
>> +						 size_t size, bool has_mbox);
>> +
>> +/**
>> + * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
>> + * driver specific struct.
> Nit two: function name is actually devm_cxl_dev_state_create


The macro but once translated by the compiler the function name with the 
underscore is used.


>
>> + *
>> + * @parent: device behind the request
>> + * @type: CXL device type
>> + * @serial: device identification
>> + * @dvsec: dvsec capability offset
>> + * @drv_struct: driver struct embedding a cxl_dev_state struct
>> + * @member: drv_struct member as cxl_dev_state
>> + * @mbox: true if mailbox supported
>> + *
>> + * Returns a pointer to the drv_struct allocated and embedding a cxl_dev_state
>> + * struct initialized.
>> + *
>> + * Introduced for Type2 driver support.
>> + */
>> +#define devm_cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
>> +	({										\
>> +		static_assert(__same_type(struct cxl_dev_state,				\
>> +			      ((drv_struct *)NULL)->member));				\
>> +		static_assert(offsetof(drv_struct, member) == 0);			\
>> +		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
>> +						      sizeof(drv_struct), mbox);	\
>> +	})
>> +
> snip
