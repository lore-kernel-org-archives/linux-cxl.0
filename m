Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91104178CC8
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jan 2025 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738003611; cv=fail; b=nfNiEeP6dqJUqUKYvimI1/TkvDs73USaLjhxbNniCPolNVmGbphlja4r7dHceYex1yPVMkGJAFHG322GafWpXD4C5siYQ4bLhqZ6yy9el/ZOTK1eUNAZz2nPv4i2WnXC6tKUxoHE328oYB2c1MeneHq9aFiwHF/ixdrG+XDnF2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738003611; c=relaxed/simple;
	bh=nlrQU+6HKS9H/zKeb0/ljQHNLck9FQSIEgeAVZEJNro=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ws4pYJTpUVMOW+DHtP6bNn3w4dFo4saPsfideiklwLfIgRE2UGpOSx2RhNJ2Dgf7B0WR2gkoo91pZ9W9YQBorwQsnoOzsCjpPlYzRGQh7ClvafX7Cb9I7yPmxMFmDPXZTmzW4HnApL6sUf4qyrHWR3GQ8BgZOF6QSwgCJVlT5jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UEhy2QQ6; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UEhy2QQ6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCgpu/t7MRDmFzijTmyZexlwN98bn9Owo6Ml3EHsmGhoXmu2IKvXmmcxD6yD0YRp5FXNnegqo78iIxCSBrhSaNsXuHNa6005Q8t/uWF3M1fwhJMnZxfzn6qgPPAw03ZSgEwTQHxi1wtBbbYrsR8TLb4uu8XPAJzg2Dv2BFUZx5Og6CC6/vA4tIOHtZ0Q8ixsYNA3YA/PohyWNn7ePslVoLjlIFrSD380S7e7iFnl/QGIaNknUZBuJL60fr8DK45n6YplgscE0BaF0RIKpule0zBKHPrC81C0FkfDBkN297F+n5paF42aepdvdyiX7h+xj8rdnIW4ZcND1z2lJLZJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+0rw05+Ll7mVAe2W0Z0/Kd5DtothguHmm7RaxFuK+8=;
 b=bstZvLqHA9hrVeHT3mjatq36uYuJ+Ma6SvTCDNODVOtj2/evIPNJJoH3++625AicW9LECWfLbEAC8MT1blZwebyFZxbSc+eDfDijefOB7TCGE8xv6vy97GORMlP1zGj16ag+G5nNr0WX2LnXHL9VAzavDDiuyx+NuODRthCsi704Z2lCMPDHMqDOhjHgEloTs8EVK8c09WuxS0z3ykgZr7lsignXPyGx8KPBzg01DhBGApbYqTZHim0Fg2XIwjg0MFqftVmyydfb9qC9RzcdKCjpbxRZAJPXtLYlHfkiKBQVCf/zkIDOA8iHCvun8cdL7A+AhrKNluFk6yE74SmjSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+0rw05+Ll7mVAe2W0Z0/Kd5DtothguHmm7RaxFuK+8=;
 b=UEhy2QQ6JvhX426eaeaATSsPe0JmQ6MaNgtiNnEfN11et/Z84K6IuV4x5Y03MIJntLLTP8aBdfBAbgFKGl4bi//is6ZsYvncy38ho5/PGmrBOXx03Vbt2lpENbk9kdHAGdtCRjhF2XtOxTIbK8uA/5MxdrkGhPH7M2rvOulgBrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Mon, 27 Jan
 2025 18:46:46 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%7]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 18:46:46 +0000
Message-ID: <69701a1b-8cec-42e5-90dd-1b1c67c91823@amd.com>
Date: Mon, 27 Jan 2025 12:46:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
To: David Hildenbrand <david@redhat.com>, Fan Ni <nifan.cxl@gmail.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 alison.schofield@intel.com, linux-mm@kvack.org, gourry@gourry.net
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
 <4e556200-c790-4e0a-b103-2a1529c81927@redhat.com>
 <3c7c5b87-f241-482b-9b00-98e2e53d8e9c@amd.com> <Z5CKN57paDmGJH9A@gpd>
 <5067fda1-c2de-4a20-9025-ebdf90ebba8e@amd.com>
 <9b0fa1f7-4133-4111-9142-143c36c42f8d@redhat.com>
Content-Language: en-US
From: "Fontenot, Nathan" <nafonten@amd.com>
In-Reply-To: <9b0fa1f7-4133-4111-9142-143c36c42f8d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:806:122::12) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d0910a-623f-4107-79e7-08dd3f02f369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkhTa0RYYmRMUjhBN2F0MklSLzd6a2RKalA1TEltOHV1NDFQYXd6NytlUTRo?=
 =?utf-8?B?TGF1M0dpOXl0Mm8wa1pIbHoyQjlmV3VVT09Xa0lyeTNMeXh3ZlhKS2Q1eU5X?=
 =?utf-8?B?cFQvVkY1U2cxbXNDS3Q3ZnRVNzhQZTk4ZFJzRHdqdkdyVDJHQ3VQcW5rQUtQ?=
 =?utf-8?B?c2hUYTZyekgxc2tKYUNxVTNmdjY2OFc0cy96UHcybU9MZGRTWWlxc3R0N0k5?=
 =?utf-8?B?SmNlTjdYT0pLSFhNaVFxQi9JZWZNZElMOUJSUGxyMFk2RDM5M2RPdGdqZ0Za?=
 =?utf-8?B?N2R6SzBGMHhxMlYxQVAwZVl6ZVJ3WFordmJrSXpzRlBkUU80dnpuTmJ0MkpN?=
 =?utf-8?B?WnZxYmg4Z3JlcFdBNFl3MVJCVkczWDhyVTZQd3FQZG9Vcjl6TWxWN1J2dXlm?=
 =?utf-8?B?b2NCanliQWdwNkUzWHFMOFMvSTEwZjJhb2lWenQrTGd5K0xEMDc1TS93ZnBN?=
 =?utf-8?B?a3U1ckgzZkRtS3UxN1Awckh2SnJtYjRKbUE4dStyVnc1UjhuUVFFLzlZOXFZ?=
 =?utf-8?B?Nng2RlFNMlg3SlFkb2t2LzNZZmU0b01VS0tGRDZaTHN3dVV5M2Ftc2g0V2FT?=
 =?utf-8?B?S0llVDB3WDc3dHdjanNYVS9tQTc5NFFub0RLc0JzTlIvMWtXYzVsbTVyNEpm?=
 =?utf-8?B?K0hRclZGejlxeEZhZ1RnSEtnR3JxSmFCaTJLUlRoMVFRVWg1SEFTeHRncGt4?=
 =?utf-8?B?Zm41a0NtK3hUelgvc2pDQW1aSHlnUFpyWmNjcUlCQnUyQjd0cVpjR3p1bGY5?=
 =?utf-8?B?VjNuckU5aGRCMVFxNUlFYkxwMUpuNjlJR1dPYk82dzdQWHh1OEtkTjVrTHhr?=
 =?utf-8?B?WDFIT1l5dHM4ckRuZ2lHWVRxdEpBbVFIcXYxY0xyelJzNUNsT2x2NzhqZk5p?=
 =?utf-8?B?dTJFanh6VmlaWVJ6OGoxaUc1ekVBT2ZRZFdlcnhMZWtrTVllOWJKTEFHV3Nj?=
 =?utf-8?B?VkxYVnlpM0s2R040MlMwSDl0ZDZRVTJjU3FMa1pBcE1iVkJSaUZiWjRGNlBS?=
 =?utf-8?B?d210dlhqR3dCZlFaQi81ZUZURFdnc014SHRnYjBDUmR3NzFZNU1tN0VwaUlN?=
 =?utf-8?B?VlJ3dkR1VmQrbmROYTNtVStJWWxKUUZmeHJzNjVaOXBrVDlhanVQSWJGU2FD?=
 =?utf-8?B?Q2ZqVEZiNTNxWWNIUFdnREI3SUhsUUVBRU5xcEdsUmQ3eWd6c2sxNVEzNHps?=
 =?utf-8?B?T20zMWxKa3BJM0lXb2Fjcnp2eWM4V3FwSkg5SDRYc3JUUE5vVXIyY1VPVXdL?=
 =?utf-8?B?U2NPQTBvb0hpOHdBdGQ4dWM1d0JwcUxydWxOMktPb015K0E2M2NNSjFZT2JE?=
 =?utf-8?B?NVMxbjVWcFpHcXNkMzJCb3Q2ZnRoQ09FNVJyQXprSXAweTd6NEdpMlZGMTAw?=
 =?utf-8?B?ZlMzYjZwN0VuSzJ2VDJIZFVjRVFpS0poZ0J1Rkd3YjFCd3VDQVNCeHZ3YW5z?=
 =?utf-8?B?VEQvNjdBakpjVmlKekhCWW9ianZkY3p6NitHcWZhTFB4QlhHMExoV202Q0Vq?=
 =?utf-8?B?U2FwdjRHdHpRb1JPRGdBTFpZTmJIemlCWEN6cXpOeGp4K1Y0N2VFS1EyUEtG?=
 =?utf-8?B?RzVVbEo5bFl2ZnI5UERDUUJZTkpzYU0xeW85bE1zRmwxSFhSQms2REFKZXZE?=
 =?utf-8?B?UndvVXV0VWtJYi9oOStaWHc4K3NWTmFCenRtcGlnNGhXdy8zbVE0QlUyeEpp?=
 =?utf-8?B?VmJUMUp4dnhkamlzN2g5eXJVRjFaN1h1VHNmSm9rYk1DUDZlYTNIZVlZcVBl?=
 =?utf-8?B?dDYxTG5WS1ZaRjkycWJxdUgwZ0xVSkEvZGt2TzNTcHE0eGU2eksxcW1LV2pn?=
 =?utf-8?B?eFZqYTJPWUJQTFBudk1mY1BqYVdhZUxRVk5UOVJBanJTc3dlVXlFZk8rdFdM?=
 =?utf-8?Q?17Yt2sNyXvvaF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjEzeFBBeHpJS3FzaXhZeTZjTFRuODdvVjRDSVArai9qZ21JNW1PZ08waGw1?=
 =?utf-8?B?bElpdjVqTU1mbEg1UzdhUDdidjczSWx5UVZBY1lJdEVHNDZZWVRESTVqOFUz?=
 =?utf-8?B?bkcwSG04TWtTaS9EMDUxSWpTdHNCM0tnWk42em9sSWtxUDFld3diODU2SWg2?=
 =?utf-8?B?WTdxWXZqZVg4Zi9uZFR2NmYvckVxV0JNdHFlS0JUam5HT0ZJdmxleU9IR3lU?=
 =?utf-8?B?RFFaYm8rMWlRVFAyZHBYUTdFM2hRbU0vLzk3b1NBYldDK29OcEpKS2NFTmMx?=
 =?utf-8?B?U0xCaDZPZlVjMFY1ZEZ2dVd6c0cyT3ZMZGtHUjViUzFmczBxTkxvb3BHcmV6?=
 =?utf-8?B?UmlQL3BGSThzcDFBU3FYQnhkWUZYYXNFVHdVempHeUtNUXVDa1crTm45c3g2?=
 =?utf-8?B?ZXV4MmdBclJjRVY3eXFIeDJuM3lxRFU1b0M5ZEZkbGk0ZkVQbDhmRlFvMzZz?=
 =?utf-8?B?VW44MldnR3ZXMk1URjkzQ3Z2cnU4VW54bXA4cUZva1BPNHZFa2p1YVdqMnJF?=
 =?utf-8?B?K2M3cWlFUXhYMml6dG1JNExQWk52KzJKNzA2Vzl2REppNWxtR2xNNFJLdFY3?=
 =?utf-8?B?ZEhzcXB6TXRyL3RROXNPRjlORmphVnR2SWdlcXJwa0RkSXJmbzZabHV5aVk1?=
 =?utf-8?B?bDJZdDh2KzFWOFZySE5pMko4M29ndGZCZit4cm5ORzRKVGJvNStNRnJuek1n?=
 =?utf-8?B?VGVFSDk1NW1uU2hSY3ZSRDU4UEVETVI0TDJ5bE5TY0YvWmRwNXVSSUtmRHpa?=
 =?utf-8?B?UGtDT2gxRUpQTmpYeGZrcFhFZldjalBMdlpxbEF4Skg0cmU3MVFqck5pTlZZ?=
 =?utf-8?B?NTFTWkxvWDZ5VEtEcHc1UjhJc1JJUk4xNXNpNDRDUlFLdWEzZXd0Zm5LbHJk?=
 =?utf-8?B?UkN0VlJjMjBkTVpkRHV5RGlCbFVTOWtTYmoyM0hGUnNYWUFpOHMrYkYvVlZX?=
 =?utf-8?B?aHpiZk8wZjZPM0RoSGJyVDIzMVlPVEs4UElGUGhaVUhTWWtkYWVraHduSWFM?=
 =?utf-8?B?eTMrRWJUakQrTTRJSnRYaVV1VG5SWVNLUjdEN2JuTjBHU0Q3WGlhVy9VZ2Np?=
 =?utf-8?B?QWxGT3ZpNzNweDViVkRGb0ZBblJHc1ZQZXl6TFF2Y2RyS0lneEVRYSs4dDZF?=
 =?utf-8?B?Vk1Jalc2S2JUdHJ0QnZCRWNoQU9sdkhzamtVQU95NlFNaDhqUHFZdU54eGda?=
 =?utf-8?B?TE1Cd0xKaHJ5d0xod1RnL2pQS3ppcDJjSGR6K2dGeURsYW1DL2U4V2hZSEQ4?=
 =?utf-8?B?TVhxWUpKMGZzYjJsa3U4WE5tTjRuY2NKS1lYVmcybmcvMWJuSlpRNy9nQTk5?=
 =?utf-8?B?NWIycW42alo5b3YyRS9reE9SdmEzSlQxKzBlZjVQUHpBSGpzUHZ2TWJJdTdw?=
 =?utf-8?B?SytDM3JXaUQrSWczOWJPOTVRMEpTNWZFRjk1MmxqNEdJMEk4aFpZWUJtdWdQ?=
 =?utf-8?B?aFNubjhOeEFieHNhdElOTWZ0WDlGbWd5bHlYYlZmZ3Q3U1Y4dFhZOUkvcllV?=
 =?utf-8?B?VHdPTGlmaFJ3dUZFU2toU0Z2WGtyWlhadG9SZ1VsdGtzQU8ycncyRjdHRXgx?=
 =?utf-8?B?bStGaTUxRktaUTQ5S3puSTFpMUxzbDFVUEVYUjYvSVJXMTM0eWFYL21jQU9u?=
 =?utf-8?B?WVB1UzlKL052dVlnTDFoelhRWU0vVDZ5RS9tN2U3RmY1WTVGZzRyNXBkS2pN?=
 =?utf-8?B?VllWTWg0R3BCSW52WFgrZ2pyUDBwZm5jS1lObkYzQzYrK2pFOGZOSXFUVEEx?=
 =?utf-8?B?Uk1acWE3b0N6Q1dUVkJsL3p0dFhUOXA4cFVjVDVIOVNvUnNZNmlIdWx0WXNH?=
 =?utf-8?B?OGdTeGE4emFyNjdxL01xY0VKTnRTL2g3QWs3ampMMHVuZkExbXZUNnJzWlRa?=
 =?utf-8?B?ZUttbUhOcWd1V0doY1I2ZGl1T2FldWt0WXVMeUJ2UnVkZFJLSjZYbnl4MG1t?=
 =?utf-8?B?ZnpOVmxaM0ZHMW1WT3dUdzI0OUJIMU9abjIyc3N6OWhrOWR6WCtMZE1BcFR1?=
 =?utf-8?B?bkM5K0tLUzFFbVdyNzdCVDc2dkNQVEp2K1MwdzRacjdkVS8renNxdHJoMm1T?=
 =?utf-8?B?bTNBTHNLS3RmWW8wTTBIMzhXZW5DSVdXS3NXeS9hVTZvM2NoWXI4eUtJd3h2?=
 =?utf-8?Q?7avT5vbC7FegkCKHQLJKiMRmU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d0910a-623f-4107-79e7-08dd3f02f369
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 18:46:46.3997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwtDwqhRFDLsxMq3Hnv7pzEeb/LhN9kLkgAfIgJL8J3w8v40+3ytshhgtzp078jqxxHHGy5xrF1flD0B/umqNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905



On 1/27/2025 8:40 AM, David Hildenbrand wrote:
> On 23.01.25 16:49, Fontenot, Nathan wrote:
>> On 1/22/2025 12:03 AM, Fan Ni wrote:
>>> On Tue, Jan 21, 2025 at 12:57:19PM -0600, Fontenot, Nathan wrote:
>>>>
>>>>
>>>> On 1/21/2025 2:19 AM, David Hildenbrand wrote:
>>>>> On 16.01.25 18:42, Nathan Fontenot wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>>> Introduce the ability to manage SOFT RESERVED kernel resources prior to
>>>>>> these resources being  placed in the iomem resource tree. This provides
>>>>>> the ability for drivers to update SOFT RESERVED resources that intersect
>>>>>> with their memory resources.
>>>>>>
>>>>>> During boot, any resources marked as IORES_DESC_SOFT_RESERVED are placed
>>>>>> on the soft reserve resource tree. Once boot completes all resources
>>>>>> are placed on the iomem resource tree. This behavior is gated by a new
>>>>>> kernel option CONFIG_SOFT_RESERVED_MANAGED.
>>>>>>
>>>>>
>>>>> I'm missing a bit of context here.
>>>>>
>>>>> Why can't we flag these regions in the existing iomem tree, where they can be fixed up (even after boot?)?
>>>>>
>>>>> Especially, what about deferred driver loading after boot? Why is that not a concern or why can we reliably handle everything "during boot" ?
>>>>
>>>> That's a good question and one I should have addressed.
>>>>
> 
> Sorry for the late reply.
> 
>>>> The goal is to prevent the dax driver from creating dax devices for soft reserve
>>>> resources prior to the soft reserve resources being updated for any intersecting
>>>> cxl regions.
>>>
>>> Not an export. Can you explain a little more here?
>>> What is the problem if we only flag the resources as "soft
>>> reserved" in the iomem tree without creating a separate tree, and
>>> process the "soft reserved" resources only when needed?
>>
>> The issue we currently encounter is that the dax driver consumes these soft reserve
>> resources and creates dax devices for the soft reserve resources before the cxl driver
>> comnpletes device probe and can update the soft reserve resources to remove any
>> intersections with cxl regions. We do not want these soft reserves consumed prior
>> to them being updated.
>>
>> If we were to put the soft reserves on the iomem tree we would need to have the
>> cxl driver provide a notification that it has completed updates and others (i.e. dax)
>> can them go process the soft reserve resources.
> 
> Would there be any blocker to that approach?
> 
> Adding them all to the resource tree and flagging them as soft-reserved, to then have a signal that allows DAX to work on these, sounds cleaner to me.
> 

You're correct that this does sound cleaner. I've been thinking about how this could be done
and have started working on a version of the patch that takes this approach. If this works
I'll make it part of the next version of the patch set.

-Nathan

