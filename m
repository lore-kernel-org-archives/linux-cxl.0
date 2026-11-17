Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794902941;
	b=IRaWSQ7f3vLQWCyIknbRA7q64Begy9RbFX9jhA/lyUYdDSh7TUNcxKmUbF2SdFGiPbcA
	 B++EPaDP4lBIUGEldGTYSGmjT5D1M4XU+CIc16i5DSrk9BWEeebFZ3R992Qle3b1oOicB
	 fDageMMjBS0MFc7Qla+EBhZAknEHJV7AO18K6y/JSrYcEhwlkCN+AaM/eLI4a/53lyU5a
	 RlBeCin6MobE2xKCg3LMNb5Rt8XroSV+1uQik16ZGsI2HXnC/iY8ryrAYPU0Dqv5Fuex1
	 Q3ib832JbfcPF248LbM29yKkJSUkHKH2DQS+6+AqwqyXFMiyw6NHAqQ4DJ55ZvonMSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794902941;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=qgSOdcsRyIiBdWvhuP+VQ+DjvGcEf7SFfaQoSxlt6AM=;
	b=jJL0ljP1NH+tfCxh6MGSOSXXvlnst1Zn+M8HkoEEdcsB9j2d66IMbGkDYZQd7B0OTlO+
	 A3ww24k6WxahwUUDja+EeVpEw0AsOlvkw92vRErDW2JTuTsotbSI3cTiZQIjbKOce6Mqr
	 VCM0ZCZ8rOUshEU1kHBZMFUKmERq5tA6JyygjVlSH1TveTdKUQiGj7AXgXzPMoE2hdYSy
	 XtHAKpkRLSBB/lQ6Zu9JWIhug6rZJIvZ0R9q/w+KU2wvtPQYuTguYIQW34unwA8fdjSNo
	 37vBJ+rTS9XMLB7WBZ9ard4irEyytc9+XljDldT4xJsZ3ACVclQIeCtW8uWDf+z5c3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=11Ij8QrD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.24
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A0606A330;
	Tue, 17 Nov 2026 08:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E1A0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=11Ij8QrD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBShlqckBty+dY/3LcSf+AlhlWMERPcuLXRXa7H+xAwZMxAVk2WlUovAIDEhSK7wouNsAx2UwewnK1kRSKd6aofOXd8l43a5RtsUcfI/mM9cYazBabo1x99wAQzn3V0R8ArozcXNlvLYJd7eS0sbGafYul/pA0aRbn+ZkCEb4L2hkq2gM3oyy/gi89nMvOKAJXk1/eytNHMGQlREexaF5gPqzShmNVgAHe6RdzW5o9mZ99uYpt/Yy1tvPlBC5rot6aLXE2rAR4rcGoxgK+TlTToQfrHOgfHUTqjelWd1oTI9lo00+ebTy8C8ny6uwDnlR2sqNZlp1EvTvuDm3QAUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgSOdcsRyIiBdWvhuP+VQ+DjvGcEf7SFfaQoSxlt6AM=;
 b=jQKn/MgmXmAmbO5eRaUjxSFT4Njj/uj4L3+/PQ0fqAyJJbZQTka6xk7UegcHCk0tttSb2CnBKVX9WUzERhz91zHRywP+zCTYLNd6Gq5I5kGeuB7FNRgPFS4qHQIaceg3BJX5IJ5beNHFo0dZ0ZuVV4ZQformsMWs1HYOBrfHQSHWNUnFW46FyTnAQyDFPsrPVykwYopqwGJ9kiIsd1/Ba+YIP9cXBLdmtWw+iSKGRjbAG4DDMwwqmPvnFnaDMq5UiUPb1NtRcoARmvXL/QIFd9IJjb2o4JsoJPZIE6pwACvUAGBtYFoLANTB7TP2iK3qARN83WUbrEybIDwoYCjh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgSOdcsRyIiBdWvhuP+VQ+DjvGcEf7SFfaQoSxlt6AM=;
 b=11Ij8QrDqXm1OftYziLeE62TEMjchc+xb9Q5/d+lvxWd73+m1vUTq7A4iJlBSdc4DndE+jsESHOWm8xdQIIYNnSqoJA1QUTR8O1b0XSoo7uKmFb7HENvz6q3AZ0k4hmVsNUVt0CgAnrjFdAHav5J42EyRLlypPrV4tfSoVb16jY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Tue, 17 Nov 2026 08:08:57 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 08:08:56 +0000
Message-ID: <4b58aead-fbc8-4102-9eff-7e1bc5a8c994@amd.com>
Date: Tue, 17 Nov 2026 08:08:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Fix self-deadlock when
 cxl_memdev_attach_region() fails
To: junho.cha@xcena.com, Dave Jiang <dave.jiang@intel.com>,
 linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Alejandro Lucero <alucerop@amd.com>,
 Richard Cheng <icheng@nvidia.com>, linux-kernel@vger.kernel.org
References: <20261117-junhomax-fix-cxl-attach-region-deadlock-v1-1-f373a135edd2@xcena.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <20261117-junhomax-fix-cxl-attach-region-deadlock-v1-1-f373a135edd2@xcena.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0205.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::19) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ed6f67-7586-413d-6ab1-08df44820726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|261102123227099003|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261022113327099003|261028144727099003|261102130727099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Vgpbqv5T6fkC9A4vwcl1gYzoJskqyPfEk+bpN6wYX+Tx1O7RioMXMJ8DMR5G0jmxUzEZRJ0gkEgk43udI4l997piUv84prBfFiMH4Tu8DJvNV6MeMcoSU4Zf+5R20GytQdK2dALdNyLxny5wmyLGnZC3lPFPBixs8aQ8PIMJDwms9eEHKWcQbM1WDUlBE/c2BMGWpm3qn15iTkR/AqiaIjOCWnXH7W/8okNm/uWjMbnRGUUqmD+FrFJaz/cNqB8Z0WWzmwohLeCLBu6kI80M90ECC2e3ghKX7vWY2pzi/KQUsIdq68shyM/mHNBK+yu3ibHpQ8xP2AxMFqxn9fhkTlhqPmMZRy1Vhd0iT5WYS77cUd4i0fQW+uZ8RpD+W4m/JNjaNeLHGJlWmlzfaHsDAja5KKgca3xkJF+SrD0fs6CplWQdkm5q/SDNqisIN9VaFylIxXr7BbGRo31z+DZH/gAhpOk6E+0bcSdwMkFZRalZQifql5DE+IDwlYB/WinaflnBgIKoO2WNKY/OvHqFDO8gGBGiLcMP6U6iNC9ytjOkUVuc5PZpB1PyqRa6LqKYdPOfR+Gzr8Xll6Nkd+OeeNElris+Y4vyuT9NLTSyCgAikGwCPY2AKT0oUQP1nOcW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(261102123227099003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261022113327099003)(261028144727099003)(261102130727099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SklFWXNxOGg4eXNsT3RCLzFnLzNIdTFnVC80L0U4UEJaTUV1OXZmTEttUEx6?=
 =?utf-8?B?N0RVbzFFWVM1d0pQbkM5Q1IrekpKbzlqQXFma3lDWmdkSUxpRDZyUmJKWng2?=
 =?utf-8?B?R2doWUhxRVE3ZmlnMDVtU0RSYlBZRm91U09uZnFRQjZIeHE5aE9QYkIwL2Iy?=
 =?utf-8?B?bEVoWFk1VUk4YXBBZEgwdGpFOEFZQU55aThsRjk4SnA4dWRBZnRmM2VOU3pC?=
 =?utf-8?B?VGlqaEY4MUJTai9Qd0YxVEJITnNTZnZnRUdFU3RXNFVOemg5UkMxV3JIbjNL?=
 =?utf-8?B?ZGxOUHVSZEVMOUZPWUxYZFIvMHdnSDArajV2MVpXVnEwcGxtY1dsQnNsVVAz?=
 =?utf-8?B?SEZWcy94eU44K1RvVWJEaG00NHNwc0NTUTRiaGtJOXVPZzhWYnJNa1ZXUVpH?=
 =?utf-8?B?U0ZnN1pwZXZQdWx6ZktIaUJTNnYvaEFjeUVWeU42akN5YnBIekhyMnJzbTVz?=
 =?utf-8?B?akNxZUhEQTQ1cDVlcXVmTHNGREYveXR1Y05KQjV6cmtkUmE2R2NnajgyNmpW?=
 =?utf-8?B?UTBkUjJkQXFEMk5mWGZIYlg0YXE1TmkwN2o3OEFndXhvK0NqTFZVbFhwRDdX?=
 =?utf-8?B?TElMTWtlazhDRVRYRkJhakp1YzRkMmJoei80Q1gwdjVyWjJQTThtSHoxVlo2?=
 =?utf-8?B?MmhncU9sT2pyU21hUjFubUpESnNHRG1TbzRodHcxYVFrNTRScWFXdXJ5MFl3?=
 =?utf-8?B?OWRkZWpLdk5JWlpOOWF4UjRvbFQxcVdTaFdZcGExY0Vjc2x5VVZpUUFaVnRq?=
 =?utf-8?B?U3EyMGJYc3E3MnNreEl4cm8rK1ZnZGJVOW5NaFp5U1p3aUpxMDF6K20wRVdy?=
 =?utf-8?B?aTF4ZFR5U01hT2pkL2VCcnlDeTQyeVUwNmVMR01wNkhzUGNGNmJNUEN0WDNh?=
 =?utf-8?B?WkRJZGxZbGVIbm1DendCcUp1U3ZQVzlSZXVJMWRqSFpqeXZVRUMybFc0YnRG?=
 =?utf-8?B?eWFZZXE4TEpWZWNYTGRhY0kvSm5UT2RnUEk0WVB5SGtaNGRWcEVQTTdkSE8w?=
 =?utf-8?B?WkR0R3RFSXR4a1dDcithQmtyTytsdUFyU0RydVY3bE5XNjVQL1JHb2tzZHA1?=
 =?utf-8?B?MS9FN21neGlRTXJ3YTUwYnJBQm5wV3pwajJOZzY5NERocGdvMlNGaUJLeXhS?=
 =?utf-8?B?dlhWSmRlQUFvcUxxSG40V3JoNXlDckNFRlA3UEdIdHcxMUhoN3AwS2RXeDhW?=
 =?utf-8?B?SDhvY0xCMFk4QVByNTA2emI2S1Y2ajd4MytwTy95WWlqTWU1bXNDM0F5MjAx?=
 =?utf-8?B?a1BPNWpwQWJKQ1VLaXlZVjZOa1RyMC9HY08ySVVhR2tTT3FxYjhwK04ySDlY?=
 =?utf-8?B?U0VPTUI2L0EzSXZGYy9oMWxFWVpIUTJOT2tyZlVYZkxoTGhEa09oNW9YMHVX?=
 =?utf-8?B?VzBzTk9TUUpaNTNpOFl1YUZIOVk0VWtGc2xOYVB1NnM2TGcxTmtvaUpZR1Jx?=
 =?utf-8?B?bjh3YjJpYzFIUENCVWNMVy9teXdhaUM2V0JxSFg0YlJHMmxSZktXQTErR1Jl?=
 =?utf-8?B?SCtxTi9FWGJPM25xcHFhNFh6MXMvK1ZudkI4SnhmZjYyc2gvOXhUY2kyRlNp?=
 =?utf-8?B?ZG96bitYTnd1WlJlUVVBckUvRGcyYzdydFJscHBjamNiZnBOWk5XOGh0NTUv?=
 =?utf-8?B?VHZnUWVMb29SOFJxZUZJV3R2UGJ5ZUdNTkNXLzFRMU5DZWtPR3hNOXZ6ekk1?=
 =?utf-8?B?NEpiS095QUVTNjc1cnloOS8xZkVjWE9DRFlMZy9hYlFZUEh4TFpxbG5JZ3J4?=
 =?utf-8?B?RW9ZRE1SYkIwZXVQeFJCTFBKUUxNaTkyVjkrQ3R2RUE1aVk5d0d4Tmh2OHJn?=
 =?utf-8?B?dmtGc2VQbFhDcWtpRXEvdStCNDZXZEJpYW0rRDZqa2lNQnU2WTVxekNWTkJV?=
 =?utf-8?B?TC9DMDVJMWZwSXdTdmgyMzhsQ1labzFHejE3Nll0TExZL1lkMm5JR0Y1Ynla?=
 =?utf-8?B?OTFRMWxOZ0VEaG4zd1RmK3RRdHZLQWIyUnRDMVFEQi90b2E3VWdCYlAzSkVt?=
 =?utf-8?B?dlM4dUprR1lsZE10NXRFOHBPa2owdmErSlQ4Q21HTVpPbS9lUnNDcFQ5MGQ1?=
 =?utf-8?B?RTU2QjQ2emF5VFNDNU5ua25RUFJzZERldU9aWmQ5b0xOZE0yQmNKM1JlelM5?=
 =?utf-8?B?b25WZXpET1RKZ0o1YWRXOGtSVTExd3JCVnpoN1dzVlFkM0pLQ1M5T0N6eDJz?=
 =?utf-8?B?RVNSN1RyakZaVkUwL2t4QllXUGVPYWpBVXFvZzdlT3lyNkVTWWJ2MTB3R01z?=
 =?utf-8?B?ekszTWkvazFsa1Qvc3oyRzF2bDJmKzhoNVZMQ3VONzdVUjlES01wSnF4YUtp?=
 =?utf-8?B?WksyR3VDL0RueTVVMVBidXRSZ24vS3I5c3huREJDeUJ3VnA2b0ZqQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ed6f67-7586-413d-6ab1-08df44820726
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 08:08:56.7990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maHFGDfgokc+NKI/av8Qgt9sBX7mqItEGrjB9syfCUKNYeP85alLG1tKFTiDa6DhL7mMao9w6KPywKf9Ffzl1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056

Hi Junho,

On 17/11/2026 02:59, Junho Cha via B4 Relay wrote:
> From: Junho Cha <junho.cha@xcena.com>
>
> cxl_memdev_attach_region() holds cxl_rwsem.region for read while it
> registers endpoint_unregister_region() with devm_add_action_or_reset().
> If registering the action fails, devm_add_action_or_reset() runs the
> action at once, which reaches cxl_decoder_detach() through
> unregister_region() and detach_target():
>
>    cxl_memdev_attach_region()
>      down_read(&cxl_rwsem.region)
>      devm_add_action_or_reset()


Thanks for giving visibility to this issue.


I have been working on something related to this complex unwinding of 
things, not when an error during initialization happens like this case, 
but under expected unwinding through the different possible cases. Apart 
from being complex and hard to get everything properly sorted out, the 
way the unwinding is programmed is semantically wrong for Type2 and only 
safe due to the restrictions with current Type2 expectations which will 
be overcome soon. I am close to send an RFC about that change implying 
this specific action will be different. I need to study the implications 
for the code I have, but as this will take some discussion and versions 
until is hopefully accepted, your patch is the right thing to do now.


Thanks!


Reviewed-by: Alejandro Lucero <alucerop@amd.com>


>           /* fails with -ENOMEM */
>        endpoint_unregister_region()
>          unregister_region()
>            detach_target()
>              cxl_decoder_detach()
>                down_write_killable(&cxl_rwsem.region)
>
> The task then waits for a write lock while holding the same rwsem for
> read, and never makes progress.  Before it hangs, lockdep also reports
> a circular dependency: endpoint_unregister_region() takes
> cxlrd->regions_lock under cxl_rwsem.dpa, while cxl_add_to_region()
> takes cxlrd->regions_lock before both rwsems.
>
> Hold cxl_rwsem.region and cxl_rwsem.dpa only while finding and
> validating the region, take the region reference and the HPA range
> under them, and register the action after dropping them.  The endpoint
> device lock stays held across the registration, as before.
>
> Reproduced with cxl_test (type2_test=1) by failing the devres
> allocation through failslab, with the stack filter limited to
> cxl_memdev_attach_region().  Without this patch the probing kworker
> hangs in cxl_decoder_detach().  With it, the cxl_mem probe fails with
> -ENOMEM and lockdep stays quiet.
>
> Fixes: d8dcb0b74b04 ("cxl/region: Introduce devm_cxl_probe_mem()")
> Signed-off-by: Junho Cha <junho.cha@xcena.com>
> ---
> Dave pointed at this reset path while reviewing the Type2 multipf
> series [1]. This is a standalone fix for the existing code that keeps
> the region teardown when registering the action fails.
>
> [1] https://lore.kernel.org/linux-cxl/6bc33514-8bfb-44d6-8fde-28f45dff5eb9@intel.com/
> ---
>   drivers/cxl/core/region.c | 73 +++++++++++++++++++++++++++--------------------
>   1 file changed, 42 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4cd9bb5dfd61..b7471a3aca12 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4424,55 +4424,66 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>   	struct cxl_port *endpoint = cxlmd->endpoint;
>   	struct cxl_endpoint_decoder *cxled;
>   	struct cxl_region *cxlr;
> +	struct range hpa_range;
>   	int rc;
>   
>   	/* hold endpoint lock to setup autoremove of the region */
>   	guard(device)(&endpoint->dev);
>   	if (!endpoint->dev.driver)
>   		return -ENXIO;
> -	guard(rwsem_read)(&cxl_rwsem.region);
> -	guard(rwsem_read)(&cxl_rwsem.dpa);
>   
> -	/*
> -	 * TODO auto-instantiate a region, for now assume this will find an
> -	 * auto-region
> -	 */
> -	struct device *dev __free(put_device) =
> -		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
> +	scoped_guard(rwsem_read, &cxl_rwsem.region) {
> +		guard(rwsem_read)(&cxl_rwsem.dpa);
>   
> -	if (!dev) {
> -		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
> -			dev_name(&cxlmd->dev));
> -		return -ENXIO;
> -	}
> +		/*
> +		 * TODO auto-instantiate a region, for now assume this will
> +		 * find an auto-region
> +		 */
> +		struct device *dev __free(put_device) =
> +			device_find_child(&endpoint->dev, NULL,
> +					  first_mapped_decoder);
> +
> +		if (!dev) {
> +			dev_dbg(cxlmd->cxlds->dev,
> +				"no region found for memdev %s\n",
> +				dev_name(&cxlmd->dev));
> +			return -ENXIO;
> +		}
>   
> -	cxled = to_cxl_endpoint_decoder(dev);
> -	cxlr = cxled->cxld.region;
> +		cxled = to_cxl_endpoint_decoder(dev);
> +		cxlr = cxled->cxld.region;
>   
> -	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
> -		dev_dbg(cxlmd->cxlds->dev,
> -			"region %s not committed for memdev %s\n",
> -			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
> -		return -ENXIO;
> -	}
> +		if (cxlr->params.state < CXL_CONFIG_COMMIT) {
> +			dev_dbg(cxlmd->cxlds->dev,
> +				"region %s not committed for memdev %s\n",
> +				dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
> +			return -ENXIO;
> +		}
>   
> -	if (cxlr->params.nr_targets > 1) {
> -		dev_dbg(cxlmd->cxlds->dev,
> -			"Only attach to local non-interleaved region\n");
> -		return -ENXIO;
> +		if (cxlr->params.nr_targets > 1) {
> +			dev_dbg(cxlmd->cxlds->dev,
> +				"Only attach to local non-interleaved region\n");
> +			return -ENXIO;
> +		}
> +
> +		/* Only teardown regions that pass validation */
> +		get_device(&cxlr->dev);
> +		hpa_range = (struct range) {
> +			.start = cxlr->params.res->start,
> +			.end = cxlr->params.res->end,
> +		};
>   	}
>   
> -	/* Only teardown regions that pass validation, ignore the rest */
> -	get_device(&cxlr->dev);
> +	/*
> +	 * On failure the action runs immediately and detaching the region
> +	 * takes cxl_rwsem.region for write, so add it without the rwsem held.
> +	 */
>   	rc = devm_add_action_or_reset(&endpoint->dev,
>   				      endpoint_unregister_region, cxlr);
>   	if (rc)
>   		return rc;
>   
> -	attach->hpa_range = (struct range) {
> -		.start = cxlr->params.res->start,
> -		.end = cxlr->params.res->end,
> -	};
> +	attach->hpa_range = hpa_range;
>   	return 0;
>   }
>   EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
>
> ---
> base-commit: 2101c39473a06ee551a8cb4d549a1112aed324ad
> change-id: 20261113-junhomax-fix-cxl-attach-region-deadlock-fc0a425f7265
>
> Best regards,
> --
> Junho Cha <junho.cha@xcena.com>
