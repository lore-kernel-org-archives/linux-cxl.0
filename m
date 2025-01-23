Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FBC212D94
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737647906; cv=fail; b=G447vaZLg4rLWNKw6Lg1ccI/yUW3ANISgYOSjYjRiBiS7bMFGDb7tl7h3upCxztpQsZsrYzNTHKNl07auyba0QOWpQc5pi/Z6Jied1NkwVREf3pCmz0rwCkhNnus4CxXsHMkGKTAJrepSrZW8JPKH9JrfuYNjAu7rS9VGweT7S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737647906; c=relaxed/simple;
	bh=OhYTT54Hvo7sKnZkt/9xwjdbW6fKzY/qBdSvx4S8fd4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ba4fcs8fUJ/LAtaMpryLIrY3vIdfKOzOdLfyS5EXXQdqM7EOgz/ij/CdBxVOoSKiN/vWH0CzUtKDkVrAvQ3b25iTeZCB9zxydttxp4dn0iqPYXUykwbLEsVR0aBmSHwnUzixuHCx8aZMG4CB++PCD/9LsR7KhGZIZs2eeVlB+Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L4lRC20/; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L4lRC20/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsSgfmjSSyYBWjVz70HWKKAUbVJCkKgaprhBYtWIU+vgg1B5aKng5FcHp7rBMOtZotM01/MzSJvFBhMDfSIiTkRxp57a0i8zq9q8lQBnGisrISdUMfp7ITrH7R8IeUt/HzaKrhaJcQGdW55ZrrERFsPjJ4pNvSUR3MwN1jRx0suxj0XAV2HHNW5DRUqwqNyZobGXVmahMmvldnh2RPjpZM1R9J6H5BWhgW9yaizzch1CjRRyY7zUbw6J6DF2IOTJJmxQ9RGC7P6v8K/rgmApzmMau/D8l+ohkWiy/HtBNw51Z5kPLIYh/Zsgd6LnudrGsNzbtCluu+Ms3oTe7disDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqISHU46xNLiiotfGz6qtfJ3q4I8CnZjWLsOI3IT9YA=;
 b=Zk0MnXglYOPwR8iIh4415DJmXcneZEJK3ly97gWQWlTgPHILEeewecJc9YQYFWLRwLpm4ksPavIqwfHaESUi0O62kdDIJ+VkE/13NBHAuqlBpFhOJvPY+0+8XX2RDFsIcRbTVbl/mKAh7lbzbUnKGC4RgxGeTBWGBKOV2Gmsoh+XaYDk9MM6sO4QraES+04ZpMg1Qv5og3/0UCKFdd150x1F12kawD0TBLrB9hcZ+8g7K7A9YQG6EGRBZC72PD7aWiDrFcahlVkT3L+NOe9Wi+82YrUR1zrha56apI5sHYYpHN37GtWVmfIO8pPXDmJJugD2vBPFFcFNd5PhWSIW/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqISHU46xNLiiotfGz6qtfJ3q4I8CnZjWLsOI3IT9YA=;
 b=L4lRC20/oglCkR3HR0M9JVh71dn5+mZyZGsPZzaEnBjzhwSJqbDBtPhJvheq3TOpI/qQSXOTSa9ODx101XXYS0QZTM/s8suRJ/MjzsgtoTRWfp9HRMCz5qKBqrGQeuayj8SIlR7IVMM0eKVg9U8kNRoAWZM0OJgzwrlYq1uQiQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 15:58:22 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 15:58:22 +0000
Message-ID: <6c859ca1-0cfe-589c-7701-ba34d0544a34@amd.com>
Date: Thu, 23 Jan 2025 15:58:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/5] cxl: Remove the CXL_DECODER_MIXED mistake
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com, Jonathan.Cameron@huawei.com
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753635601.3849855.5582594127330525596.stgit@dwillia2-xfh.jf.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <173753635601.3849855.5582594127330525596.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0062.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4cc576-28e6-4bab-c4e7-08dd3bc6c309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEpxOGNoaEFXOVRVcGtRdnMyQytucTk0QmRyQjlmWE85SjVCTytoL3d3YXNN?=
 =?utf-8?B?dzJBUjBCdm9rRnBqZXhmYjMrZHJDRGFRTjdZQi8wd2RpamhQZ3dpUTY1ekIz?=
 =?utf-8?B?NGxyMWszZTFjVWhFeEgxd2JodnB1eE1qRG1LQnBOYzgzbFZaUVlTdWJqemNi?=
 =?utf-8?B?TGZjOEdPbDZXajk1TTNyWm4xZ2xRNXlnY2FvRUJveEphTGpSTGgvNVJPY2dq?=
 =?utf-8?B?bjZqcTNackcrbjIwdEFtRmtuWHc1ck8rc0J3aS8rNTBXRnkrZjlicFIrOFZr?=
 =?utf-8?B?ME90QzdQZzdIUG1yeEl6U1JUVDd2OVZBVG92UHM0cTM5bXlxeEp1NGRDb0Zn?=
 =?utf-8?B?T2xTVUpOb0Y1NVY0SEl5UDJlTXBaU250dUgyUG9uWXVhMVpKQ29DbFA3WHhi?=
 =?utf-8?B?MEJkSisrTDhsWDErWGszNUxQT2xVd29tRG5vVnN6WWdqcTNoQndCcHFhM3V3?=
 =?utf-8?B?TTVxQkI5MktsR1dPRGk5TVBWbGF3WnQvamFWUkx5U1RqdW5vdzltMFhuTnFa?=
 =?utf-8?B?cUVSUi9tNitnR1hLdk4vWFhzM0RpM3dMSWRncHA0U2JKZDkrbWxOTnl4cnhs?=
 =?utf-8?B?a2lXVS81Q1pOUnZHc1lLQXdYVnpzOFJrQXppcDlWTDlIcEVTYU4zL2V2S0Ix?=
 =?utf-8?B?MUhGZCs0ZTRLckdHODVmSGtVbWpSMDZsYUtjcDNsSnBudlorMTErUGJlUUE5?=
 =?utf-8?B?OGVtRTZJcVFiZE90R28xK1FXRnlnaENibkY5bUh0K2Z4VUt3WFV1WXZRUTVt?=
 =?utf-8?B?R3FkcXVEYUkwVU5ZTk9HZDM4TjJNRE1iMW5XYytHTTB1WUdIcGgwMncvNHND?=
 =?utf-8?B?MTdVNFg4OUlxSnMxNTBCTzd4VExaWUNOM2cxQjlxRCt6emYvVDNGcklJckcv?=
 =?utf-8?B?OTFCTUdnc3k5cGd5Mjh3US9oYkFrZ21Hc3c0RjZzNHZOLzRTWUFydTVQQk5D?=
 =?utf-8?B?em50VDRDMSs3enlsdDFma0lsMEN5Q0JhNUdsRE9vLzlmYzlKQzhNTkRyZmlO?=
 =?utf-8?B?ZHVBcTNiSUpiajZ1dlZ3QUp6bGRtUyszUFVBUXFVcGQvZ05LUitNZDNkZU1Z?=
 =?utf-8?B?dUhScmk3WUMwUHFhYzVuV2VCTktDMi9KUElySWh2allkaitHTHgxaEQzRVYr?=
 =?utf-8?B?dElGbkF6K0piRGVlWEV3K1VtQ09zZ1pDQ2tVa2t1Q3NoSWlkZFJNcTlId094?=
 =?utf-8?B?R3pPYTdhUVVvL0hXK0F6YnNlTEs0QlJXQTNpTUUrK1RTQUlnZnlBc3o1c3lP?=
 =?utf-8?B?LzFtVmRYZ3hJQzdjYlhlY0lJRklXM09rUGhiazU1emEwQmJjNkZGK0hXVm1i?=
 =?utf-8?B?OFBDc21lemdkeEFoSTdYQW9YZ2NxYWx2TVNhSlBVT3NJWGorOThtbE91aEp5?=
 =?utf-8?B?UlI3MGtXWUNTenpqSCtVanNJSGZHM0VVL2huVHFiNzQ1NnNTSU9SNlJJZThC?=
 =?utf-8?B?N29sUHpkdmI1b3NiV2dDOWN1VG1DSXg1bTZHNlhTaEJnaElhVFB1NHcvUDJh?=
 =?utf-8?B?RTRocmZseHVNQ2VuejEzWjJLWFhIU0pUVXZIcDB4cG1nY2ZYVURIQXpJUmxD?=
 =?utf-8?B?SkcrbE9ycWF1cW9XT29TMEhHK3p0QWVpWGhCQkxBbjlwMGFSaXF4d2ZQd1lJ?=
 =?utf-8?B?UmNaOHRjMmNNaC9ZNHZUV2QxMVZIMXY5ai8zVUE1K1huVE4xOW5WS2RYamJG?=
 =?utf-8?B?ZnZDaU1OdmpFRTNBMWpHT3VDbVRKWWpoVlVaOEl3WS9VYWNOcGtnMDB5MEti?=
 =?utf-8?B?d0Ivd2FFT2JqdkhDdzBPOGxiblhBSFF0aE45bVhEbEswbWU0Q1dKR2JVb2wz?=
 =?utf-8?B?aWpkY1RDV3VZbk5MSE1NQnA4ZndPeHhoSUhYbkJhMzlpNW81NTJqZGpaditK?=
 =?utf-8?Q?kKTkNFhSxOUoJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDZYSW1aM0h2SC94bnFrNW5QblhpMzJrZ2J0NDBmb1l5RzJQTlFLY1lvd2Rn?=
 =?utf-8?B?RlhqWVdJdTNJOHhKdDVDZjFjaFlxakx5bnpGVmU1QVZXOFQ3MVlTMXRSRHhW?=
 =?utf-8?B?MDdSTWt4ZTU4MGQzSnNnSzNMT2tMc3hVWVlrbmdHWnVsZDZ3ZGFCNzErRFQ2?=
 =?utf-8?B?SE9xWk4wamdWeGhKaEFHWGhOL1JLOU1vMmxRTE5sODhydUZuWlcyV2h6c0Qx?=
 =?utf-8?B?TlJZZCs4S1FKV1ArMGVmRWQvc3plaU1rVzBFL0F3RGV4ZHlpMTFBMS9QWjVF?=
 =?utf-8?B?RVVsQStzZzJ0NDRjWjI5OVhzeVEvd0JtREhqTldDTzVPU2huUzQyK1B2N2ht?=
 =?utf-8?B?ZXh0eHdvb1ZuL3lqb1ZrcFdHaGxYS0VBOTZ0MW9JaFVkWVduRTdwVjR1NWI2?=
 =?utf-8?B?MTY1TytxUjVRWE5JbzBrbDd4UGJNQ2t4S1pOYjBtRUhDaTQxaTFCSEFUdmFr?=
 =?utf-8?B?UFVQa2xFcWk5aDRCczZmeWR3UnJsbEFLbFRaNm1UaENra0Zhc0IrRStMOWor?=
 =?utf-8?B?ZElRanNBN1JLeU9hN2s4SkRka01xZmpvQSs1L2o5SVg3SzVlQW9HOVlVWk95?=
 =?utf-8?B?YmJRdVZXc1N0SDJUbkJyVmNmNEh0aldCQlhyREx5cWRZc3ZQN1UzZkZFWXN6?=
 =?utf-8?B?dVpaSTU5Ykk5NURDSzJZWE9zMXZMeUhIRVpSblBrZDAzdjE1TXN6RTZlNGVw?=
 =?utf-8?B?ei9DZ2dXS29LaHpCbHlMYlVmNEFXVUxkYmJLQ2RFWFIrMHVZZ3FLMDRmcXlI?=
 =?utf-8?B?anBGV1g1VmJmMWZxejVQeVFoOWxzT0FhYlA1YUFhZjBqNE5WNkZXeWNjV2ZY?=
 =?utf-8?B?TXVZeDh2d2lsQ2ZNc3M3ZWpyNUpDKzluRlZ5aGpIOU9QeXBxTW9sVVhRenpj?=
 =?utf-8?B?dTkxazNDcWpJV2EzTmtTb0o5a0JnaDJqY0lLdS9IUFRDOW5aQ2RNc0QvV1ky?=
 =?utf-8?B?RDdWOVVzcDc0cmJLUjZBdE10cU94L25qcnFhZWdPZzhsUHcybEhNWnh1WDdR?=
 =?utf-8?B?UCtJc1FzSkJrK002UjRodS9jNnlqY0NGTm9EbTNhYlBySklUVDRkbjhYaFhC?=
 =?utf-8?B?SEJzdVdydmd4ek9VU3ZhbWNMa0E5Qkx1c3liWkJrcWFKK2U4VUJ0dk93L0Zy?=
 =?utf-8?B?Tk9ENkxGMWlPdmcvNWg0dUZuV2NoZkZsdTZlVjVSR0UvYm1xNHRQN1daN2xE?=
 =?utf-8?B?Q2daelJHN2xlMGhVWVlwT09xVEV6eXFhTStJYTJ1eFkxdlF6aVdSbWV3alFi?=
 =?utf-8?B?eGNKZ2RCVndnSDgzUUpSWmU0Q291eVVQcVBSbnUzbnZUdDZOWnB5eVV3MFZ3?=
 =?utf-8?B?cVpxRU1QNWpWTmdMbzc4UWlpaGIrVWxZUm5sNXVHUlVMdE1yUjJJQU1oYmg0?=
 =?utf-8?B?UVJnV3dzR1hLMm40dlZzOG9nN3ZJNi9TTG1hSEx3aTYxeEV5eWpZakJZMlNW?=
 =?utf-8?B?cHNWSHhOZTd1V21SKzVTZWh5MENzTUErdFk5SnZVZXZ6THY2NHhkeGtoZ0x3?=
 =?utf-8?B?NDdDdWpnclJuazU2Z08ybHRORENpbFEwVnNuSDBBTkpITmlRWng0Z2JBa1I1?=
 =?utf-8?B?ODFNNUJYa0g4WUNUUVI3eXlLdmw4U25xNkdINmY4Sm9POFlqWk5tMHE5TlpR?=
 =?utf-8?B?L0NJaUZIcHFDSFZldEUvOHF2bzFsUmJiWmZtdWJmZkRocHNhQnJmNUZXYXVk?=
 =?utf-8?B?Y3hPY1dXNFJLd0N2aHdZQVRPaEhEb3EwQUQ0b2xkYmxRUWZhbmRRbS9sYS9i?=
 =?utf-8?B?a3pYUVNUOHVVSmM2RVBORDZCQWNWRm51M3ZncmE0VXloQjNxVWJyaEEveDFx?=
 =?utf-8?B?U0tySVN3c3VoWmYxUVRkdm5aVDAxV3kwQ0lScTZkRk9UTjJleFhWSTJFWUVx?=
 =?utf-8?B?NnI4d0NvajNPSjN5Y1M0ZFVUMVJqV29wYXZpWm5NakUraWtHLzNMeUZyVjdP?=
 =?utf-8?B?WlRTQUpjaDVpR3hQUEl4aC9YRHIzSk13UGp1NEJRODNaNTlLS1RleTQ3N2dL?=
 =?utf-8?B?a3FEOFBjYmdLSklTUzNLN3JJM2dxcS8xRTl1ZUh5Z3ZzQTNjMzBnK01sYmtK?=
 =?utf-8?B?RUQvM1F4SU83Uy9ucktLNExkZWh2Z1M3WGE4UWlaZUlsNkNXMXR6RVBJRFB1?=
 =?utf-8?Q?a5GhN2TNwg7pFZROrlnR53qvP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4cc576-28e6-4bab-c4e7-08dd3bc6c309
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 15:58:22.0582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiwIHx2FuAFP1I6dFOFn6Ga+v+BkN2c9n8iv8fvTtQ0mZKDa3KHtccOC0VfZKQ5ONkqSHQUKKGZHYXPKqbd6Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431


On 1/22/25 08:59, Dan Williams wrote:
> CXL_DECODER_MIXED is a safety mechanism introduced for the case where
> platform firmware has programmed an endpoint decoder that straddles a
> DPA partition boundary. While the kernel is careful to only allocate DPA
> capacity within a single partition there is no guarantee that platform
> firmware, or anything that touched the device before the current kernel,
> gets that right.
>
> However, __cxl_dpa_reserve() will never get to the CXL_DECODER_MIXED
> designation because of the way it tracks partition boundaries. A
> request_resource() that spans ->ram_res and ->pmem_res fails with the
> following signature:
>
>      __cxl_dpa_reserve: cxl_port endpoint15: decoder15.0: failed to reserve allocation
>
> CXL_DECODER_MIXED is dead defensive programming after the driver has
> already given up on the device. It has never offered any protection in
> practice, just delete it.
>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/core/hdm.c    |    6 +++---
>   drivers/cxl/core/region.c |   12 ------------
>   drivers/cxl/cxl.h         |    4 +---
>   3 files changed, 4 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 28edd5822486..2848d6991d45 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -332,9 +332,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>   	else if (resource_contains(&cxlds->ram_res, res))
>   		cxled->mode = CXL_DECODER_RAM;
>   	else {
> -		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
> -			 port->id, cxled->cxld.id, cxled->dpa_res);
> -		cxled->mode = CXL_DECODER_MIXED;
> +		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
> +			 port->id, cxled->cxld.id, res);
> +		cxled->mode = CXL_DECODER_NONE;
>   	}
>   
>   	port->hdm_end++;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d77899650798..e4885acac853 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2725,18 +2725,6 @@ static int poison_by_decoder(struct device *dev, void *arg)
>   	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
>   		return rc;
>   
> -	/*
> -	 * Regions are only created with single mode decoders: pmem or ram.
> -	 * Linux does not support mixed mode decoders. This means that
> -	 * reading poison per endpoint decoder adheres to the requirement
> -	 * that poison reads of pmem and ram must be separated.
> -	 * CXL 3.0 Spec 8.2.9.8.4.1
> -	 */
> -	if (cxled->mode == CXL_DECODER_MIXED) {
> -		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
> -		return rc;
> -	}
> -
>   	cxlmd = cxled_to_memdev(cxled);
>   	if (cxled->skip) {
>   		offset = cxled->dpa_res->start - cxled->skip;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f6015f24ad38..4d0550367042 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -379,7 +379,6 @@ enum cxl_decoder_mode {
>   	CXL_DECODER_NONE,
>   	CXL_DECODER_RAM,
>   	CXL_DECODER_PMEM,
> -	CXL_DECODER_MIXED,
>   	CXL_DECODER_DEAD,
>   };
>   
> @@ -389,10 +388,9 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>   		[CXL_DECODER_NONE] = "none",
>   		[CXL_DECODER_RAM] = "ram",
>   		[CXL_DECODER_PMEM] = "pmem",
> -		[CXL_DECODER_MIXED] = "mixed",
>   	};
>   
> -	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_MIXED)
> +	if (mode >= CXL_DECODER_NONE && mode < CXL_DECODER_DEAD)
>   		return names[mode];
>   	return "mixed";
>   }
>

Reviewed-by: Alejandro Lucero <alucerop@amd.com>
