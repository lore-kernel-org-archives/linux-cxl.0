Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795082448;
	b=doKwYYogNrPHBr9yhSQhcZ7tWzHvFBtU2Sri/owoKKUpLUBRSUCb+2GZf2TJBWwiVlG3
	 rLYAySL11kvGK85Ounj6282Se/LD58+2amf0x/6cG79/Ghtm0RMzxPuQotpVFOcxn98dO
	 1HLdJ26DYR9L5l9Zboee9Mnp7ldru7PUwwIxD3SxLTQa0SjrYSV5Hp4ODVpAhD+tUEghP
	 PV8hQK4BcY3Q4+z+oB09bzWL1PqRHJjoMg6R16Fv95M/WgSj8RCEaLW91I0W4fdpbXffn
	 C34Ro6dAnjJ9WiZd5gJzd3bUFA8ZATJJcZnDsvctb5Vn9XIKVS+rt7pIhI9hdiBZzpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082448;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fd0CCS3wubXOsmk2ThfbnrKFnfPduPyydNSsSs14n6o=;
	b=BlMDqZDQRwXJjahm686ZWIk6fktk0/u/aKcAyaemAgestSBakL+fFG44OPQ8KE5Vdwy+
	 +53caaqceRcvO4gV5UgHIdIxSc4NQhiRjoey9P8mkiQs6oyYKjfYLZBjjlL9i7RnVY/Zg
	 DM0SJYuLHVEFP5Lfzv+xwKlbJw9+29PZe0NvT6gBT3UHJiT/ctq++IH84h4WCv5Sw0yeD
	 E5nyBulrWrAgs00oqUnydOAyStxTiCQdik5ZbChazILEsKaQMtYkNt23CQdXXGy4wgbQF
	 mJ9Vlz4ZM4bTPoS7r4m0h3xAh+NlDXHa8CuN7n0+LszZ13lOmhYk5vNST10YJqvKwcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="CT64PF/y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.1
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98E606A33F
	for <linux-cxl@vger.kernel.org>; Thu, 19 Nov 2026 10:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C98E606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CT64PF/y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZwsETmA3+qsxJMnk6SbW5SpOTFNCz+tDxK0sW3gPe6AjKKtgJeNyzxjJoUDBgvNQ8/tn10idnQ1UtjleMcNnlbhEx8uyvlP48sBco67qtpq1uqGZrzB2A97BcZpGsBpuJd/w9fEi5zklWx0pVqctIh+HaNutTDvShLXz9w1qm4TVHfqvCYA1/ouihlTBO3dz0TTlPFdrcLW0depEiZ3OIPKCiUETCsBj10ThLgL52sOHJpVjNwak+c46A1Q9vxzSqpoh21mDmKzL9zR2KD3/GnN7F8XwzETEi2RcmO0heHezJQFtdB94IjCLu0y+FGeVUditZZIiHZDAgmD6nak4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd0CCS3wubXOsmk2ThfbnrKFnfPduPyydNSsSs14n6o=;
 b=R4NQhs8ZsfkBvCJmdV58j123T9n0o6a/1v4U/elQxjI+h/fEv7t2J5JrC13lW18KgN5tpn17tf5XFIQz9MA+Rhev3AvehDM4WtAzJe6ZchnxuNQFNVODvOnwNqRdGseIc94D4Z0M2BdiQnKQ9QSrObJp2uBa8XRsV9MgjyIThzoBa+qiQTOgCcEw7DILzJUYA3VJceanJ5fkc4/MnrNN+KhxsKuW+LVzAp8Fz8aSwT7IPz+YUfND3+qyIhxXBTup+IjLpwziQTwFpRpsAO7Vqj/fd6e6gZFKyVv4IZAlOp6Dm9QVcJhkAjSow8LWkZo3CtU5Kfrjr7ynDH+Kqf2W3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd0CCS3wubXOsmk2ThfbnrKFnfPduPyydNSsSs14n6o=;
 b=CT64PF/yjL6h3vrDiLxQENh5601UnSsgDNLrRO30QUtDrvj1JgXWqW9Iu0huBiHzGgsMtA/YwmsEorY3Zk7YQeS53q7y9QUjoWr3fF/ufcnRjLRu0gxKLsZVvJZXOLCTzYIIwS9k+gG2vurQlm7vSiaZGc8aR8Iufp+uQYX024Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Thu, 19 Nov 2026 10:00:42 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0639.011; Thu, 19 Nov 2026
 10:00:42 +0000
Message-ID: <a212d5c2-d9ff-43c6-b817-b8dd1dd189af@amd.com>
Date: Thu, 19 Nov 2026 10:00:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Type2 unwinding ordering change
To: Dave Jiang <dave.jiang@intel.com>, alucerop@amd.com,
 linux-cxl@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20261118191431.21781-1-alucerop@amd.com>
 <58fdf73a-a33a-44fa-bd35-a9610624d3b3@intel.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <58fdf73a-a33a-44fa-bd35-a9610624d3b3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0604.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::13) To SJ1PR12MB6244.namprd12.prod.outlook.com
 (2603:10b6:a03:455::18)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d62ff90-df5e-4f4c-b2f6-08df4623f841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|3023799007|56012099006|4143699003|11063799006|261102130727099003|261026121527099003|261102123227099003|10067099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	klPczoAQUpRJjbK2Df2jB7vYYPqCW70U47s4F9mPwSryceh3jSHMsFWrQ9FO1msZxOaHDadobS36ppX5GheE8RvdzeWMNmDuCakfz67JNvjNM/40XUmrnPUrSGPE+XKn2Euif8Y049zw5nhdFeeuHwP5JHqTHmPquAj4W0Swf3N1lZqylzkftQ5arc14s30HoZvMNHw/wNoDoWcO/oxmxSeIaMfmL8t0sWqnZ8pjIpPiKDYiEP+hgVsGho9kUxdl7RVS1uIlEGoMVdb+syLTPeCgUpCNuDf2D+uGWN9pUlNyqtxSx81SEBQrhqtjzBxpCvE+h8qCMDOr2LPv0UhUJyqw34kLypgfCVtfNUjSPt/UyHow2O2EKijHjrBMMXo++vZP8MAlkDR2egYYbNCDk6fSss7zjM39wQ31JpJrCFzl+S7vu9KAIpt8l+k4we+x8aJB65vGMZ1zA36ac2Cg5fUA4lDl3ufFBatSV6xoNsK9vG2bNupacpTgnDT4muhEXnLzEbMI96lt6WUyUSL7YV+OYRBURbqPOCbjwfFpf3UKCu4yvfCm4E7ImqzkBYBxIivRT8tj6ux60nAq5vbIYrB6nqbFjshYatDZcCPpHIV2ZLxLOtQRJsRoW6Wngy0f3jPhwK0VipMkErNUWPgqT2kRUN6k14tMwHQW7Cn2rzQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(3023799007)(56012099006)(4143699003)(11063799006)(261102130727099003)(261026121527099003)(261102123227099003)(10067099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlZDVGNBZTViSWZLdCt6Y1JZMFlva2Nqd2NQYjdadFFYZTJ3YXpoZmhHVnhG?=
 =?utf-8?B?MmlQeVB4SmNTQWtBajE2aFh5TU1MYUdkSGtuS1lNS1NXMEVpeFdaK1FUTi9L?=
 =?utf-8?B?bUNWaHNldnVXRVRSVERoSjhkODV0YkdZZ1g1VEdOR055Y3R3UzlVMytEbHFS?=
 =?utf-8?B?RFZHYmhqM0FmTlA5Rk1oU0ZRYWJRWXFNNU9tUExKTTZjL0dVMEtDL1dBQzdp?=
 =?utf-8?B?SUkvR3JrUEdWT0QwNUFhMWNWSCtGVHdkNkpaMFFWazZEUHdoS01RUjdQN2Jp?=
 =?utf-8?B?YWRMZkM1S0taWnhCd2h3T3VCVjBZN2pnVW9SZ1NmbUVyalU5Nkdmd1dWT0w0?=
 =?utf-8?B?SkdXWGxzb053ZytERVdQOHYrcjlONUJNOUM4bHp1WmJoZGJ6Vy9oM281d0xi?=
 =?utf-8?B?cVVuWVZ5MndjWE1MRlk3WjdHWDFNVXV4VlptNTM2emFQQ3NJbWF1V3dMcWYx?=
 =?utf-8?B?Q1V2eHRaMFVMcXJMZVArMDlWZ0wvZWc0dm9lNWhpN1hiTWNyVVhyVXZ1Mzhs?=
 =?utf-8?B?QTl4L2hzY2lnU0FwTXBHTXF3OFhZb2w3ajlXT0FlR0RzOEpUV1pkUkJaUmhH?=
 =?utf-8?B?QjR3aXJmVHlCb2hTZnZhM0JBWS9oK3ZsSXM1eG9ta2pHV1F0eFgyZ0RjczJW?=
 =?utf-8?B?N2N5SnZ2S3VWTzBBaWt3NGNYSjhiMkhaRGorQk9sTXZBT2M1bWZMbXMzUUNl?=
 =?utf-8?B?TlAwdXVrZXA4SW9YN2x1VUo5eGFIT25VV3AvL1RNZmRzSGxGWmUxRytXek8z?=
 =?utf-8?B?OWdKL2J2R0tJRHFxZkdDaFk1SmtsRFBoM1BPZGdmNXVKWG5pQmx0N1B6MFlv?=
 =?utf-8?B?am9HS1h0ejdOc3pqaVNWTkJnVVNiTk1rY0lrNDVyY0w4N3Y1T1BsMkIrWHdW?=
 =?utf-8?B?TXNjQTU1dnZnY01BVVBNMlVzR0dqR2tJWnFsU1BWcVhKRGhMenZMYXBHOUwx?=
 =?utf-8?B?aFNzZGRrSWwxYXVKdDFYTHI3MEVCa1pDSW1ibWxLWjV2aVFLcXlvV1hPZ2FV?=
 =?utf-8?B?QjI5WktZaWFrLytTMGgvMmVVWUpob0VSaW02NUMwVEljUyt0UzlYcnRYOE10?=
 =?utf-8?B?RVJTdWNDU2pKckNqMGJaRGE1WUo4a0dIQUZTNE5Vc3Q2Z2QwQ0dKWWQ1WkZ5?=
 =?utf-8?B?c0Z2cFl5YWtuQmFFeTgxRHlJRnJCOEpoOFpURXNLODBaRExHalJUSHpwblh3?=
 =?utf-8?B?djlqSlNWcFNucGlVd091YW9GTHlIc2duWDJhSXBzOVV6NkRBU1J1S1FveXFN?=
 =?utf-8?B?cTNKUUZmSUR4Z0NNMGJJZTlKVGhGd29ZUHVhdUU4SUt6WldrQ09mWXNMTGQ4?=
 =?utf-8?B?dkprWEVheHNDMk5RaGhRejRYcDJ2cjl2ZDg5QkhKQmJTSVRjbzdQcTVLeXhJ?=
 =?utf-8?B?emR1cnovM0w3M2FRWExkdUxLZ0lVVWRYYXZvVHl5Vk1IWFFKZ3o3bmlFb0hH?=
 =?utf-8?B?QjRBMHBGdU92L0lVemRIWXpJUlhkWjFkaE9OV0E3Z0lDZHpKMEJHUVFTTnNW?=
 =?utf-8?B?M0QzVDJnaEgyWEpPeHYzQUlJbmxDT2R1UitlUnpja3BJd0N2S2VBWXR2WGtH?=
 =?utf-8?B?TTFmdTJUYTN5anlna01zeWNtSFBQdnNQOVhnU1pGbWNFWjYyOUhkOC9IcHM1?=
 =?utf-8?B?c0FoVk1YU0VCbS9Zd2U3SGQ5blIwT0c5R0xNbkpqUHlBZGVqV01XYzMrU2k0?=
 =?utf-8?B?QjU3OFl0SnNvVTlVRW96cWprNVRBcnlYSE1WSTMvTVpyUytENkxCdE1KMk4r?=
 =?utf-8?B?a2JBTGh1NzRwM280ZnVsRlpVNWhTU3ZuZFRuMlZxVVdra2ptSG5PbEZ5aysv?=
 =?utf-8?B?UElnS3FyUDlxM1ZOQStlYmlPRGlvbFlkS3hXRXdCY2cxQzRFYm9JUUpPOUhn?=
 =?utf-8?B?QnpQTktKeVBkUXg2Ymt3aXMyTVFEK0F1dUFqZ0lVeVJhdjcrczJETU5IRHpK?=
 =?utf-8?B?NExGMmxnWklOL3RYQWN1V3pOTzlYZytRRHJCK1RYam4zNnBCRUMxODRtUDYy?=
 =?utf-8?B?dDlTKzN3eUY0WFJuelN4TThwY3NNWVRFWno0MzR5VjFHYU9YQWVTUlc0cm5M?=
 =?utf-8?B?YlR1VGVYR2N3ajRkUVdhQUtMWnlac1FoemZtOGdtbmc1OWZtSEgrRzVFbHFK?=
 =?utf-8?B?eFMwSm9oSU5lZHlxQnpCdmhhWEhDa25HbzJ2OWVrdGxrejQyUWZvZDFVY2lR?=
 =?utf-8?B?V1dka0I5MWNSd1ViNElheDVWdFpCWVdoT05SdSt4MzNJcTFYekJWdmkyZUVV?=
 =?utf-8?B?K09henBFTWNmckNPdStBWWVaUGNUclZqYWhJRExHYTZjRTJPUG51K1EvN1pW?=
 =?utf-8?B?ME4xMitPTkxYSFYrdHRvbDhmdjRibkxkRk8zNE9GTG8yQmxXdFRIQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d62ff90-df5e-4f4c-b2f6-08df4623f841
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:00:42.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsmQ+uE15yuRIl8SxFiESan9AotU6XaPoNKvbS7ZFeSAXStn/UWuqxigZ37EzcZ3V+Sroqwf8/6e2wy6Qg8OTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420


On 18/11/2026 23:39, Dave Jiang wrote:
>
> On 11/18/26 12:14 PM, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> This RFC requires more work mainly with the tracepoints and surely with
>> documentation which, I hope, will get better with help from reviewers.
>>
>> Regarding the solution proposed for the described problem, I know there could
>> be other solutions, so I'll be happy if someone comes with a better one, but
>> my feeling is the current design based strongly on devm actions is adding
>> complexity which would be desirable to reduce somehow.
>>
>>
>> The summary
>> ===========
>> Current Type2 support is safe but semantically wrong: a Type2 driver could not
>> be (temporarily) aware about the CXL region (the one creating the Host physical
>> range to work with) is not there anymore. It could because it depends on the
>> unwinding triggering point which changes the ordering of CXL objects unwinding.
>> It is safe because for current Type2 expectations the physical mapping will
>> remain: those HDM decoders building up the path and programmed by the BIOS will
>> not be reset.
> Hi Alejandro,
> I ran the series under cxl_test with type2_test=1 and KASAN. A plain unbind of
> the accel driver oopses. delete_endpoint() unregisters the endpoint decoder,
> then the devm action from add_hdm_decoder() unregisters it again. Binding the
> accel with no CXL topology also oopses, on an ERR_PTR endpoint.
>
> There's also a Type3 regression. detach_scheduled is never cleared, so after
> one cxl_mem unbind/bind a Type3 memdev no longer detaches when its endpoint
> is unbound.
>
> With the crash fixed locally, the endpoint is never released after a Type2
> teardown. detach_memdev() puts cxlmd->endpoint after delete_endpoint() has
> set it to NULL.


Apologies for being so clumsy. I did miss a change required:


diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index de109fb60038..27137a7032c4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2322,6 +2322,8 @@ static void cxld_unregister(void *dev)

  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld)
  {
+       if (cxld->target_type == CXL_DECODER_DEVMEM)
+               return 0;
         return devm_add_action_or_reset(host, cxld_unregister, &cxld->dev);
  }
  EXPORT_SYMBOL_NS_GPL(cxl_decoder_autoremove, "CXL");


With this most of the unwinding possibilities should work as described. 
Looking at the remaining issues now.


>
> The ordering isn't fixed either. schedule_detach() is async. On endpoint or
> cxl_acpi unbind the decoders are torn down while the detach work runs the
> driver teardown in parallel. A trace shows the two interleaved. The detach
> can't run synchronously from the endpoint unbind. The PCI unbind takes the
> PCI device lock and then needs the endpoint lock to remove the endpoint.
>
> I don't think the driver needs to be unbound first. It needs to stop using
> the HPA before the region goes away. Every region removal goes through
> unregister_region(), so how about telling the driver there?
>
> The diff below shows the intent. devm_cxl_probe_mem() takes an optional
> revoke() callback. unregister_region() calls it after the region device is
> deleted, while the decoders and HPA are still intact. A bus notifier disarms
> it before the driver's own remove(). The async detach stays as it is.
>
> Under cxl_test, mem0, endpoint, port and cxl_acpi unbind all call revoke()
> before the first decoder teardown. If the driver unbind starts while
> revoke() is still running, remove() waits for it to return.
>
> I also tried your multi-PF v2 on top of this with mock functions under
> cxl_test. It doesn't look like it needs a deterministic order either.
> Deleting the region unbinds the other functions synchronously in
> device_del(), before revoke() and before the decoders are torn down, for
> every trigger above. cxl_get_range_and_link() needed changes for that. As
> posted it can deadlock against PF0's unbind. The fixes are on the branch
> after your v2 patches.
>
> The branch [1] has the full set and the cxl_test changes I used. Please
> take a look and see what you think.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=type2-revoke
>
> DJ
>
> ---
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 787988e92965..50c2fcee54b6 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -752,6 +752,13 @@ static void cxl_memdev_unregister(void *_cxlmd)
>   	struct cxl_memdev *cxlmd = _cxlmd;
>   	struct device *dev = &cxlmd->dev;
>
> +	/*
> +	 * The attach owner is unbinding and has already stopped using the
> +	 * region. Don't call back into it while the region unwinds below.
> +	 */
> +	if (cxlmd->attach && cxlmd->attach->disarm)
> +		cxlmd->attach->disarm(cxlmd);
> +
>   	cdev_device_del(&cxlmd->cdev, dev);
>   	cxl_memdev_shutdown(dev);
>   	put_device(dev);
> @@ -834,6 +841,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>   		dev->type = &cxl_class_memdev_type;
>   	device_set_pm_not_required(dev);
>   	INIT_WORK(&cxlmd->detach_work, detach_memdev);
> +	mutex_init(&cxlmd->attach_lock);
>
>   	cdev = &cxlmd->cdev;
>   	cdev_init(cdev, fops);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 038233dfb142..e8a8843c2ddb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2559,6 +2559,41 @@ static struct cxl_region *to_cxl_region(struct device *dev)
>   	return container_of(dev, struct cxl_region, dev);
>   }
>
> +/*
> + * Tell attach owners (Type2 drivers) the region is going away while its
> + * decoders and HPA are still intact. Every region removal goes through
> + * unregister_region(), so this is the one place the owner needs to hear
> + * about it.
> + */
> +static void cxl_region_notify_attach(struct cxl_region *cxlr)
> +{
> +	struct cxl_memdev *cxlmds[CXL_DECODER_MAX_INTERLEAVE];
> +	struct cxl_region_params *p = &cxlr->params;
> +	int n = 0;
> +
> +	lockdep_assert_held(&to_cxl_root_decoder(cxlr->dev.parent)->regions_lock);
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.region) {
> +		for (int i = 0; i < p->interleave_ways; i++) {
> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> +			struct cxl_memdev *cxlmd;
> +
> +			if (!cxled)
> +				continue;
> +			cxlmd = cxled_to_memdev(cxled);
> +			if (!cxlmd->attach || !cxlmd->attach->region_lost)
> +				continue;
> +			get_device(&cxlmd->dev);
> +			cxlmds[n++] = cxlmd;
> +		}
> +	}
> +
> +	for (int i = 0; i < n; i++) {
> +		cxlmds[i]->attach->region_lost(cxlmds[i], cxlr);
> +		put_device(&cxlmds[i]->dev);
> +	}
> +}
> +
>   static void unregister_region(struct cxl_region *cxlr)
>   {
>   	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> @@ -2568,6 +2603,13 @@ static void unregister_region(struct cxl_region *cxlr)
>   	xa_erase(&cxlrd->regions, cxlr->id);
>   	device_del(&cxlr->dev);
>
> +	/*
> +	 * device_del() unbound any device-link consumers of the region (e.g.
> +	 * other functions of a multi-function device), so notify the owner
> +	 * last. Its decoders and HPA are still intact.
> +	 */
> +	cxl_region_notify_attach(cxlr);
> +
>   	/*
>   	 * Now that region sysfs is shutdown, the parameter block is now
>   	 * read-only, so no need to hold the region rwsem to access the
> @@ -4182,14 +4224,42 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>   	if (rc)
>   		return rc;
>
> -	attach->hpa_range = (struct range) {
> -		.start = cxlr->params.res->start,
> -		.end = cxlr->params.res->end,
> -	};
> +	scoped_guard(mutex, &cxlmd->attach_lock) {
> +		attach->hpa_range = (struct range) {
> +			.start = cxlr->params.res->start,
> +			.end = cxlr->params.res->end,
> +		};
> +		cxlmd->attach_region = cxlr;
> +	}
>   	return 0;
>   }
>   EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
>
> +void cxl_memdev_attach_region_lost(struct cxl_memdev *cxlmd,
> +				   struct cxl_region *cxlr)
> +{
> +	struct cxl_attach_region *attach =
> +		container_of(cxlmd->attach, typeof(*attach), attach);
> +
> +	guard(mutex)(&cxlmd->attach_lock);
> +	if (cxlmd->attach_region != cxlr)
> +		return;
> +	cxlmd->attach_region = NULL;
> +
> +	dev_dbg(&cxlmd->dev, "%s going away, revoking %pra\n",
> +		dev_name(&cxlr->dev), &attach->hpa_range);
> +	if (attach->revoke)
> +		attach->revoke(cxlmd->cxlds);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region_lost, "cxl_mem");
> +
> +void cxl_memdev_attach_disarm(struct cxl_memdev *cxlmd)
> +{
> +	guard(mutex)(&cxlmd->attach_lock);
> +	cxlmd->attach_region = NULL;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_disarm, "cxl_mem");
> +
>   /*
>    * The presence of an attach method indicates that the region is designated for
>    * a purpose outside of CXL core memory expansion defaults.
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 35268d1c387c..675d7e21f6c1 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -44,6 +44,10 @@
>    * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
>    * @endpoint: connection to the CXL port topology for this memory device
>    * @attach: creator of this memdev depends on CXL link attach to operate
> + * @attach_lock: protects @attach_region and serializes revoking it
> + * @attach_region: region the @attach owner uses, NULL once that region goes
> + *		   away or the owner unbinds. Lives with the memdev, not the
> + *		   owner's devm state, so a memdev reference is enough to read it.
>    * @id: id number of this memdev instance.
>    * @depth: endpoint port depth
>    * @scrub_cycle: current scrub cycle set for this device
> @@ -61,6 +65,8 @@ struct cxl_memdev {
>   	struct cxl_nvdimm *cxl_nvd;
>   	struct cxl_port *endpoint;
>   	const struct cxl_memdev_attach *attach;
> +	struct mutex attach_lock; /* protects @attach_region */
> +	struct cxl_region *attach_region;
>   	int id;
>   	int depth;
>   	u8 scrub_cycle;
> @@ -97,14 +103,30 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>   	return is_cxl_memdev(port->uport_dev);
>   }
>
> +/**
> + * struct cxl_memdev_attach - memdev attach provider operations
> + * @probe: attach the memdev, runs in cxl_mem_probe() context
> + * @region_lost: @cxlr is being unregistered and @cxlmd is one of its
> + *		 targets. Called with the root decoder regions_lock held, after
> + *		 the region device is deleted and before its decoders are torn
> + *		 down.
> + * @disarm: the attach owner is unbinding; no further @region_lost
> + *	    notifications are wanted. Waits for an in-flight one to finish.
> + */
>   struct cxl_memdev_attach {
>   	int (*probe)(struct cxl_memdev *cxlmd);
> +	void (*region_lost)(struct cxl_memdev *cxlmd, struct cxl_region *cxlr);
> +	void (*disarm)(struct cxl_memdev *cxlmd);
>   };
>
>   /**
>    * struct cxl_attach_region - coordinate mapping a region at memdev registration
>    * @attach: common core attachment descriptor
>    * @hpa_range: physical address range of the region
> + * @revoke: driver callback, stop all access to @hpa_range
> + * @unbind_nb: bus notifier, disarms before the driver's remove()
> + * @host: device whose unbind disarms @revoke (the cxlds->dev)
> + * @cxlmd: the memdev, set once devm_cxl_probe_mem() succeeds
>    *
>    * For the common simple case of a CXL device with private (non-general purpose
>    * / "accelerator") memory, enumerate firmware instantiated region, or
> @@ -113,15 +135,25 @@ struct cxl_memdev_attach {
>   struct cxl_attach_region {
>   	struct cxl_memdev_attach attach;
>   	struct range hpa_range;
> +	void (*revoke)(struct cxl_dev_state *cxlds);
> +	struct notifier_block unbind_nb;
> +	struct device *host;
> +	struct cxl_memdev *cxlmd;
>   };
>
>   #ifdef CONFIG_CXL_REGION
>   int cxl_memdev_attach_region(struct cxl_memdev *cxlmd);
> +void cxl_memdev_attach_region_lost(struct cxl_memdev *cxlmd,
> +				   struct cxl_region *cxlr);
> +void cxl_memdev_attach_disarm(struct cxl_memdev *cxlmd);
>   #else
>   static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>   {
>   	return -EOPNOTSUPP;
>   }
> +
> +#define cxl_memdev_attach_region_lost NULL
> +#define cxl_memdev_attach_disarm NULL
>   #endif
>
>   struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 702ae9ebdcde..cd3db7646c64 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -219,10 +219,39 @@ struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds)
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_cxl_add_classdev, "CXL");
>
> +static int cxl_attach_unbind_notify(struct notifier_block *nb,
> +				    unsigned long action, void *data)
> +{
> +	struct cxl_attach_region *attach =
> +		container_of(nb, struct cxl_attach_region, unbind_nb);
> +
> +	if (data != attach->host)
> +		return NOTIFY_DONE;
> +	if (action != BUS_NOTIFY_UNBIND_DRIVER &&
> +	    action != BUS_NOTIFY_DRIVER_NOT_BOUND)
> +		return NOTIFY_DONE;
> +
> +	/*
> +	 * Sent before remove(), or before devres unwind on probe failure:
> +	 * wait out an in-flight revoke, block new ones.
> +	 */
> +	if (attach->cxlmd)
> +		cxl_memdev_attach_disarm(attach->cxlmd);
> +	return NOTIFY_OK;
> +}
> +
> +static void cxl_attach_unregister_notifier(void *data)
> +{
> +	struct cxl_attach_region *attach = data;
> +
> +	bus_unregister_notifier(attach->host->bus, &attach->unbind_nb);
> +}
> +
>   /**
>    * devm_cxl_probe_mem - Add a CXL memory device and probe its region
>    * @cxlds: CXL device state to associate with the memdev
>    * @hpa_range: CXL.mem physical address range result
> + * @revoke: optional callback to stop HPA access before the region goes away
>    *
>    * Upon return the device will have had a chance to attach to the
>    * cxl_mem driver, but may fail to attach if the CXL topology is not ready
> @@ -233,12 +262,29 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_classdev, "CXL");
>    *
>    * The parent of the resulting device and the devm context for allocations is
>    * @cxlds->dev.
> + *
> + * @revoke, if set, is called once if the region backing @hpa_range is about
> + * to be torn down for a reason other than @cxlds->dev unbinding (CXL port,
> + * memdev or region unbind / delete, cxl_acpi removal). The region, its
> + * decoders and the HPA are still intact when it runs. On return the driver
> + * must no longer access @hpa_range. The driver is unbound later,
> + * asynchronously, as before.
> + *
> + * @revoke may run before this function returns, so it needs to synchronize
> + * with the rest of the driver's probe. It never runs concurrently with or
> + * after the driver's remove() or its probe failure unwind. The driver core
> + * notification for either waits for an in-flight @revoke and blocks new
> + * ones first. @revoke is called with CXL core locks held, so it must not call
> + * back into the CXL core nor take the device lock of @cxlds->dev. It may
> + * sleep.
>    */
>   struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
> -				      struct range *hpa_range)
> +				      struct range *hpa_range,
> +				      void (*revoke)(struct cxl_dev_state *cxlds))
>   {
>   	struct cxl_attach_region *attach = devm_kmalloc_obj(cxlds->dev, *attach);
>   	struct cxl_memdev *cxlmd;
> +	int rc;
>
>   	if (!attach)
>   		return ERR_PTR(-ENOMEM);
> @@ -246,12 +292,35 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
>   	*attach = (struct cxl_attach_region) {
>   		.attach = {
>   			   .probe = cxl_memdev_attach_region,
> +			   .region_lost = cxl_memdev_attach_region_lost,
> +			   .disarm = cxl_memdev_attach_disarm,
>   		},
>   		.hpa_range = { 0, -1 },
> +		.revoke = revoke,
> +		.unbind_nb.notifier_call = cxl_attach_unbind_notify,
> +		.host = cxlds->dev,
>   	};
> +	if (revoke) {
> +		rc = bus_register_notifier(cxlds->dev->bus, &attach->unbind_nb);
> +		if (rc)
> +			return ERR_PTR(rc);
> +		rc = devm_add_action_or_reset(cxlds->dev,
> +					      cxl_attach_unregister_notifier,
> +					      attach);
> +		if (rc)
> +			return ERR_PTR(rc);
> +	}
>
>   	cxlmd = __devm_cxl_add_memdev(cxlds, &attach->attach);
> +	if (IS_ERR(cxlmd))
> +		return cxlmd;
> +
> +	/* Don't hand out a range whose region already went away */
> +	guard(mutex)(&cxlmd->attach_lock);
> +	if (!cxlmd->attach_region)
> +		return ERR_PTR(-ENXIO);
>   	*hpa_range = attach->hpa_range;
> +	attach->cxlmd = cxlmd;
>   	return cxlmd;
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_cxl_probe_mem, "CXL");
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 348d7404cd7a..a82a0e2fc609 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -74,7 +74,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>   		return -ENODEV;
>   	}
>
> -	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
> +	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range, NULL);
>   	if (IS_ERR(cxl->cxlmd)) {
>   		pci_err(pci_dev, "CXL accel memdev creation failed\n");
>   		return PTR_ERR(cxl->cxlmd);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 1c04a7823f64..c672ec83d820 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -252,7 +252,8 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>   	})
>
>   struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
> -				      struct range *range);
> +				      struct range *range,
> +				      void (*revoke)(struct cxl_dev_state *cxlds));
>
>   int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>   #endif /* __CXL_CXL_H__ */
