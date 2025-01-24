Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C721B21AD
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737714585; cv=fail; b=pxbaqW94JFTBsk4BqFfC9b0O/+lkzaqdc39jwV1eEK1Gc0eRaVNqvcBTqyCr9FqelOgtndVhWsqWBmG6gyR/gMiMNnZueo+U6w3QiXFMBdv/TPDT+9iWJ7HWjreDpOndGnXParIL51GZ9ptoEHNHWvVVKiiboNCTfj8VK4yLEKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737714585; c=relaxed/simple;
	bh=xLHs/662ImNtnvZ3DpzuuA1264BOqHYUJ9raPjR9b+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QTcOrYFPoWpJRpwVREzu7yNdNCPCI5FcvTU31ZuASQP6CYDiEkR4PrKzgZRzlntNhe1c0GVTBM/VwD/7v6VM0bqzpqd1NLRRSgVLL5BeRtdChXuDVOj+8bWGb6L18e1GGpHIwxZi2xcSmAsxwxstkX0sBkSB6d+h+mwu/1E+t28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ig4GJldj; arc=fail smtp.client-ip=40.107.212.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ig4GJldj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrD/urMabgMeJ0tUBHhrjZPzTNMDRyGi1ag+/k7e2UZNewSO++7+w67n1NBDggKVqq4KzxacgfroqdX2+4hArJThnlayWy28+JCeM1xblllMjA8Lz4fOQAELFNYc219oYGyGHILNDi58UDP7uVmMbnFXPHPGFCFyN1wSBAdsh71MjU8K+4KQml9IXuR3ht7MiSCwkCi83OfuIU3auwKZnVrhHGNpWLssLbzQsUNdZg4MHUL/Vg8l+DzQgIdhoKwJWRu/pC0CZ2P7+oCMzx4u7e8Q/hvKRHO+rcBPDEcy+tmT/sMiP6MmuOA6fvsOcbWWmPrw8DcQBpxDktMyXZXWAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3ucroClOnzHUFSIeGjOICOOp0T/XeR0MjgOe7CRaF0=;
 b=B5+5WTjTI+RfBWf0XzUUOawnpmvqoyOLvD1rYHTcK/vKMdodRoAwzFch1pwd0RcmPnH+gMn9bpl2/98wgJpIaszViMcwMpW2z/TYuURhUeUo7jnk9Td+OarX8sLzWN4qkrKdR2T1qreGilSGEA8qPzxgjl2qVtfnrdXeHbPsVy6KioiLxva7WKJ3KTaJ3iSARBFFzAaeWC5z//gU6TknFx5Ct5zczs6WQjXRNh7CaGuFzmJv8L+TkYCrsPy1w6NuSnb5hkEKMlrsSdL+7GkXklIMsnD8KbL3UAxjr6Rjedp1ue/207q2I1K0yUdrx1aV/dXCjBuEcefRYa3WzsYS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3ucroClOnzHUFSIeGjOICOOp0T/XeR0MjgOe7CRaF0=;
 b=ig4GJldjpAPq7eUwXD/NwRql4ei+1y/wek5SCV577kojz49WDO39a8KnPnn6O4hOg7l6x0jHyWqMI9dD5+8RNDn6T6o70mQrkk4jC67AaQHeb+yNEALSPTkfan+EGFpoVMYTZfGG6QFEFaUFGd+xMJdtmoG4c7jLQXa/PqK1+ks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 10:29:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 10:29:40 +0000
Message-ID: <9e1c485e-47f0-c3b4-cce0-5a3c4c395d8a@amd.com>
Date: Fri, 24 Jan 2025 10:29:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan.Cameron@huawei.com
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753636727.3849855.464861650807086965.stgit@dwillia2-xfh.jf.intel.com>
 <0020a489-5002-33a9-fc5c-58e46f581199@amd.com>
 <6792c739cc4b_20fa294f8@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6792c739cc4b_20fa294f8@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: c35155e3-d389-46fd-f96a-08dd3c620298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rlp5ZGZtQ0xWTjVVWWxDSFlBVVZjR0drODYzNk5RS3U0UDJHNERnRnJIbW1Q?=
 =?utf-8?B?L3VwSjdnNlR2c2x5RE1mL0huN01ubkJSWXIybnFZRFdnUkNHSHZhOEtBWHdq?=
 =?utf-8?B?c3EwZlZZRXFMNHk2M1dsV3paOHR4WjF5NGJQMzZWdHVROEw5V252RFJ3NGxX?=
 =?utf-8?B?ZjlHNUYrSFBINVpaK2NDSWw3Q296d3d5eS9Zak5HYVJvSnZkbUN3VkF6ekhE?=
 =?utf-8?B?WGlGSTc5NXlVd3hDbUN4Rk5ZNklUVm1OVUprT1E5NU5JaTU2ZzE3OENiTDY2?=
 =?utf-8?B?cTlYZ2xremFCcWpjSk9YRVRHbWMvaS9pbk5vTVhKNGwrUU12WVcxNER2dndl?=
 =?utf-8?B?ZFU0UnpYOTdvbG9xUVgxUllubjhNS2xPd2psTFF5OG5qYVZYeWlPNTVCejV1?=
 =?utf-8?B?eFFUWEZTVUxkdVh4eXVlRWcrdmIvU2U2di81VFkra2FzNTAvUE0vS3ZHLzRw?=
 =?utf-8?B?VGJsNGtNMkc4eUU0Y0Rzc3lUS1F5YmlTOWdWeS92TldNVmR6TlpHTWRuRUVw?=
 =?utf-8?B?QVZaR0VQdDhjS0FmUWlZLzk1MEhTTUFVYTZGbHh5UEt3Unphc3gydUJJNUl0?=
 =?utf-8?B?Vld0RkkvSmhGUHZTck1HRzd0UHBaY2htV1Bvb0Zxd0dmMmtGSlg3aTlSTXRs?=
 =?utf-8?B?Tk5FcEEwTFBQQTA3aEdxK2NmTk5XcUhLN1U5dG04U1F1VTJ3VEpWbXVKLzZt?=
 =?utf-8?B?MGl3bGpDN3hUWExEVjd4QUZFK3dwZTUvOTNyRE1GS1hJNVpUaEgzM3Z5SHhJ?=
 =?utf-8?B?SkhDNWQ0bnl1Y0x5STlFNjhvcW5BaUNkZ08rcTQ5STFDNS9wQklKcmswekRt?=
 =?utf-8?B?WlNwUXk5LzZmbjRpMmNQLy9xS2lnR0JteVRJVzlHRjRJK3FBd0J1eHl0MVpG?=
 =?utf-8?B?QUUzSFp6SDB6aUlqa0dyd1BhU01ta21uUVppTjZ4RGtUNThIRVNUb1FEK24z?=
 =?utf-8?B?alBRT2x6NWxKWDRTQ2pGZkJSNERKQ2xxdld5RFBJdjBBL2JlZFBVaks2a1FO?=
 =?utf-8?B?UGQ1bVRBcy92OStQa0hPTzRPRFZZMVp4ampKUmVoeis5SmNvdGNMcTZQN1I2?=
 =?utf-8?B?RVFDT3ZGSHJGNFJMZnc0d1Bza0s3eW4vVFRQNjZ6SlZkSGJDV0Zib1lFTmpQ?=
 =?utf-8?B?UXhZaklla1hZamZYblJZN1hsRlFJVHZFSUFyNTBERFFRVGkxazdPN3hkZmI0?=
 =?utf-8?B?OGZLOVMxM1V6cEFRY0lsTkJkM0hUUE4vSmx2UzJxNW10TkVvVDlUbTBEL3Vw?=
 =?utf-8?B?UVRkZjYxNm1IQm90WGVkV0tYcXVsVzVmNXdoRVNvWHlOU3YydFJPSGt5UzRm?=
 =?utf-8?B?YnVQOTBNeFMwREgzYjdQMmQ4d3JWdkQ2dGFiRWw0b01IZHdyY1hPUGFMMXMx?=
 =?utf-8?B?eFFMZmo2elNleXh2YjlUV1I3b2FVN0Q0WmV6cGdaMFd4VmV3S0JGUExlL0d5?=
 =?utf-8?B?ZFdER0N6ajMrWmZkajR3anZ1RkFIVjlDdHRkWnZRZHhuYk8vb3RQOThOdWtp?=
 =?utf-8?B?cUd3NlRsL245d2FMSUttMm1PTnNVU0JjNkdTZDA0Q3Zza0J2Y0hVb3pIYjI0?=
 =?utf-8?B?aHdTeW1sUmhwK2xCbGFHM1NTMWFhM2F0MVZ2SWl0R0V3ZERiSWRidlVtS1or?=
 =?utf-8?B?N2JrZ2VqL0w2T3ZOTlJDV21CUmE3b3JNNVFHdXBjdUM5ZHJSL0FxWTBxOHJY?=
 =?utf-8?B?cnpxMU50STM2ZkY3WEdQb1prYXZEdG1LQUhra3ZON251L0N1dHU1cmIvRmFL?=
 =?utf-8?B?R2xacGVCdkFscGRZaTJLcXlzNllWU3RFNnQ3YWF1NHgxRUVnTHVSSU44K3Ni?=
 =?utf-8?B?QlpLWjNTeWJ1MGF6Vld4MzkzeEovbVB2S2RxMmZPZ1JuS1NTQnVxZ3BlRkxN?=
 =?utf-8?Q?35j/myOzkMQNe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWxxeTc5V01rZnBZNUp5Rzl3ekNGL2MwaWtqMjdPWmFTOHpqc0ZwbWEyTk1l?=
 =?utf-8?B?WUZWUXorcHMxS1NzV2dGTVBvWmdUZFBySjRLOXF1WDV2bk9qTTJyblNmUUZa?=
 =?utf-8?B?UUV3cUkyWWVHWnF0QndsRU1iWm9DNWdiWXljUnE4QnIwbTdHTWt1R1RobEdN?=
 =?utf-8?B?STMrN2p4OVNoN2lyK0JsM0J6RDBMLzU2SUdaTnE1cWczRnVvVEZ0Z3VCT1Ry?=
 =?utf-8?B?Y0liMDFFclA5N3dzTksxNzNpWHRZbmFFWWpZdXlsQWVVREVVanVnWVBzdWtQ?=
 =?utf-8?B?VWxha1VIYTYyZm5oUCsxa3grNHYzNDJXZkFDeWFKMHZWZFhucDIwWWF5b0dR?=
 =?utf-8?B?YXYzSVdRaVpZVkgxQUVVNUd6OTRERVBQeVlOMkNTTmh3anVvVEp4QWJCaHJ3?=
 =?utf-8?B?L3dTbDBsY3lZaytGS2lTQ2phTUZ6VnhZelBRVjdZaC8rNGhJa21YeHYreDcr?=
 =?utf-8?B?VWFiazdxUExxYjU4cWNmQVQ0bDZ6VmR3Y3J5dG44WGRvRmJhY2k5SUpIU2di?=
 =?utf-8?B?dTNMbUtjdjNjVzdwZzRtd3djdnFJZjdTZlJTQm1YenVzR05OOFJDa0V4U1RU?=
 =?utf-8?B?YVZFbHlWQWIwT1QzZCtQSWhVZUdSRjdjUHNua0o1TThxR281ZFk5WnIxN0d6?=
 =?utf-8?B?R0c0bDhkSUJNemhZb2ZwbFkvYTFUQ1JFQlZjUXMxcDQ3aUIxK29DVDFCMHpB?=
 =?utf-8?B?bTk4OHVzelZyenEzeDRnM0dWcmQ5bGEzZVgwbWFhMDJZNWpFam93eDdYNkhD?=
 =?utf-8?B?c1pCOW9TdEF2Q2R4dXZWRFliN3ArVzA1ZloxQUpVY3EzZE02TUtFdUdvUDBB?=
 =?utf-8?B?K3FHc054Q2VOZnRWSE4vaVdNaGtVSEpObGxwQnJxVEVIdzZydDNvSFhucjZa?=
 =?utf-8?B?NktqZS8xdE00Tmx6SEZkaHhMZkw2NENKOC9TdGd5ZEpFaEpIZHZJT2lvL0h1?=
 =?utf-8?B?ZUwxR1ptMzJ2VkNTVXlab2JrVW9GU2FmTzhwUzNkVnF4UzVIc2VGVEhqbSt2?=
 =?utf-8?B?ODJmQTA1MkJRcFVpVFltR3pUN2ZEMWs0M1dlMjVydjBjaE9jTmhvZ1NVdmJV?=
 =?utf-8?B?N1JxQjEydW5JTlNrSlBwN1ZPZUNtU1VaaVl6TmswZU5uMzdnc2MrZi9MM1Fn?=
 =?utf-8?B?MjV4ZUJhY09XM2o0TFBjUlB4WUtzM1NvUUZmbnhpZXRqQjFLTWpKcFByTWJM?=
 =?utf-8?B?Yk4zalAzOE91NXRJaEVsVXAwakcvdVJYSjFxQ04rRGlrdEhZUmo3L05UeUR0?=
 =?utf-8?B?Wm4va3VORDNySGRrWWFOd2RYYjNnOEFQblJPNGJGRHBHTk1SeldGVGFhY2Rs?=
 =?utf-8?B?eTE1akNrYXBRNEVkUnpjeSt4ZEhlMzYzREczN2VyK3JEeVNTVHk5MFhWWlVZ?=
 =?utf-8?B?YmZScHo5SmNHSzlCb2RLYWYzUXJvaGlrd0tGeTFpREJrSGE5VkF2U2J0dU5r?=
 =?utf-8?B?Y1dDSEw3S2Nsbkg4NklYTmVXdTlSN0dZUnFudEJYd2hIa2U3NHB6M0kvL0Ji?=
 =?utf-8?B?K2pkc29Hd3RleFpDMTNrYnQzam1IYjQ5UitkaTJpcXgvdFk1eVVPL0xiZ1Nq?=
 =?utf-8?B?cXBDRmV5WTlsQXhpK2tnTHJlMkhpMFhVM0dKYXpUcGJDQkt4Y3lxR1oycVR2?=
 =?utf-8?B?NDFLd2pPWEVydzdHa3VJMENVUGk3ektDZHZiUWJQUlkrSUwzYlNQSUFFa2Zp?=
 =?utf-8?B?NGs2MTc0WnR6Z1NtcE5vTndybUZMdGUrMWVCZ2J3RENZY0RuU1JnMGFxcGlu?=
 =?utf-8?B?TVNaRitaMTJJZkh4MGF6Q00yYVlrWVpHcFA2b29hTWlldzlMcGpnMzIrV3pO?=
 =?utf-8?B?Y0lHUE83UGMwcUdsSU1oNVdvaUgwcjBqcHFkcXgzWVNQTnVFQXUzZ3EvRE9T?=
 =?utf-8?B?YXRxaGpBcmhoSkE5NmRLbXVIZUFiYkVLVm1iYXZBYnZSejhRRG1MMVdEMUhD?=
 =?utf-8?B?N09aUHp2SnFsMWMvU2wwWmRCeW5YS2tWUCtFQkJvbjhXTms0bEsyRWNuMDZ6?=
 =?utf-8?B?QXl2QUx6Q000b0Nac2NZaHB5V2lHc0UwS0hXbkJHNk9BR2ZXbEE0NFMyeHhn?=
 =?utf-8?B?ZHZEZ2VhbW9mNHZObVFjckFHSmNBV0czTXZIMGFxam9jNDdwUHhSb2FCVk1L?=
 =?utf-8?Q?YjMT3jKbS+zLCrhqnN0jsAFqR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35155e3-d389-46fd-f96a-08dd3c620298
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 10:29:40.6597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMSMhxTtH2nGHnn8Xi/1DXd+ExHt9TzA0ABR+8UZCS7ydaLRdlBzG/j+5GXsIWxjIkhQ4WOva23GuzFVI3hewQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304


On 1/23/25 22:48, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
>> On 1/22/25 08:59, Dan Williams wrote:
>>> The pending efforts to add CXL Accelerator (type-2) device [1], and
>>> Dynamic Capacity (DCD) support [2], tripped on the
>>> no-longer-fit-for-purpose design in the CXL subsystem for tracking
>>> device-physical-address (DPA) metadata. Trip hazards include:
>>>
>>> - CXL Memory Devices need to consider a PMEM partition, but Accelerator
>>>     devices with CXL.mem likely do not in the common case.
>>>
>>> - CXL Memory Devices enumerate DPA through Memory Device mailbox
>>>     commands like Partition Info, Accelerators devices do not.
>>
>> Forgot to mention this one. Mailbox is optional for accelerators.
>>
>>
>> So maybe "but this way is optional for accelerators, implying
>> accel-driver defined/hardcoded enumeration".
> That's what "Accelerators do not" means. I.e. that setting up the DPA
> layout needs to be refactored into infrastructure that can be shared
> with drivers that will not use a mailbox for this purpose.


I do not want to spend time in this little thing, but I understand the 
line above as an absolute for accelerators.

I agree the shared infrastructure needs to support both cases.


>
> [..scrolls to end to see if any additional comments..]


You are not the only one suffering this ... I'll do my best avoiding it 
in the future.

