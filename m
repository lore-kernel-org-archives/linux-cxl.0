Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E191B6CEC
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jan 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737375890; cv=fail; b=lSfq1F2Yc91NIOPIZh1j9ADuWYLw4lVWYHlV4AHCmYEZwC73rfZ09Xbu+Tsp8vdct0j9Xl19Mg9jERPbXu4M+jBfDJ2MXa7gctJREnhcZxuuZZXRfMQhbcPEjYdFjshOnf4JgdduzrsHmmyMY7cdwtKekqoGmjyhCtgYIrsQdno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737375890; c=relaxed/simple;
	bh=LXADlfuVgBJa9XP95ROg74VJbpMYxN5+Oc5++5ko+6s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M17jruiMYtqLQMiQ7hbXrOww2Sx/uZC6udTn0hHDOpbIJ9zBrf7XuyW2cmhRCd6FNhEkNHATNl+SzeQST3mLhsq4OyJ1plzHY/Q+d/HWCjr3rEv6LTPBbjw4ogBSiV6j78xTrJhq2wLYcTbp/9kjzFUN5kSid9i+jFOXHO69zf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E20g6JG6; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E20g6JG6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VScKCRpVul1byT9cxhnlA37gOwLvdhvNF8gLGdygGNjVZJYo3pZNcsdNtRRE1y3y2FmW5zORX3OoxBGix4DF1p79GNHvo59ZEetyyMDLFyu78y+GdPCEyf2cm2d3vM0cgu60faTml0YKQ1/OpdYzMOu5jMHNBmwD8r/T20iJORBwRLqffhDq1e+fN8Ljx5AdiM1pBS7ZVuY+N9bKqadDZxXpzXYfMo+vzMSPSu+EzH/gs4E5ASSa+v+I2/rh00zQAoMPQsSZ7/b8jMRd0BSiD8YlZmDi+0W/qsiaYe3klLxx65dHuy1RRPUG88VFtXcqHQC6jFI8cdH0I4MSSgLWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3d6Y1M6Gb6tzt1/4hb2ZINB8uFSKRkHucenBFgs1MPY=;
 b=UMtHgk5T0AjFwNUEZXtYpF8/Te19/g/MBSqj4bNxUacbtH9JUXCAnyzuu/MSsnWPN2bksXvs0t6QAt73V6IPpAn6+HThwPsyoWU6akI1BfFtaT7BxbQEw2d9GkMWvyKZi1OuOHqsaAB/YN0X1S/HHWGi+D1myB+GmGOcifqoBejtlvzkuKA/UCWTILJHSIiXw09Pkb/y4xHXhGD0njS3j1Lw5NjMRDdTEsLMtG4YXP15SDcVQ+7vEIYtjcWbHP6hvjkG4zz4X/Ru/lYJb/Gb7fFJgS5MKlnLgmC6dcBotYkvGheyxgKgEXnNlRQCf5HcRBpPqL/kXXXvVMFuGMoRUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3d6Y1M6Gb6tzt1/4hb2ZINB8uFSKRkHucenBFgs1MPY=;
 b=E20g6JG6+7W/O18hRTp9CHRWzJCQ1jwwlGVt2WfiJKdJwipACFLbM9F+ZVs59ErqVAtivW4M6c1kO5Q1Re8ZX+Ux+mXhclHi3zRpbI4no6iWLVHo+Wuac1iWoLxPRbfaWOrT8xRNoE3KWtT5RfhQvOoRuDYS/Mwtnbny608uoGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 12:24:46 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 12:24:45 +0000
Message-ID: <30ba3e11-0ba7-6bc6-38ac-1ba0c577f651@amd.com>
Date: Mon, 20 Jan 2025 12:24:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] cxl: Introduce 'struct cxl_dpa_partition' and 'struct
 cxl_range_info'
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
 <20250117105254.00001dd4@huawei.com>
 <678aa0381324e_20fa2942a@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <678aa0381324e_20fa2942a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR0301CA0076.eurprd03.prod.outlook.com
 (2603:10a6:6:30::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 19156947-2d68-481c-bd68-08dd394d6cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajN1cHN5WUgwSzFEYjlCaGkxSnd1azNDWmpLMUFTMnEySmtHR3pEQ0NpWXF0?=
 =?utf-8?B?aGYvWjZPcm5yYkJpaTV0UWc4aCtoT0dWdUZNWlBBdC9ITFcwSlRzdk5kaFBH?=
 =?utf-8?B?VngyMk9Wb0kxWWM2VDcrQUc1cEF2RVVrZlFmbGQ1Yml0TzlMdW0rQjlTSjBt?=
 =?utf-8?B?OE5iQU81Rmtwd3BvZ2Z3SFZDc2lsUVpKdjNJYlJoNTBpRWJuUk15dWxjYzhG?=
 =?utf-8?B?cGs5S0FTbTZqRnhGeW01eVJMaE15MWNvRUp2VWtTNHYxemFhVFBseHVjSUg2?=
 =?utf-8?B?ZW8xYkVRa3JiQWhnOTl6TmlpQmFIeGorRjVSUE5VbmQ2UjBnVFpZRVh0d2JP?=
 =?utf-8?B?dHVmVkh1aFc3eVRHVUpFT2JMSVRUSWc5RnhoTm0rSXdIc1oxZURnTlpucmZp?=
 =?utf-8?B?ZDlyLzdHV1VSeVloOHkrUHlZTkZ0QnFaL3lKeVc4SXNqano5SFdBM2I1QVJS?=
 =?utf-8?B?M3ZoeStrY2VoSWl3MUt2UU9JRlByNk1zMlRPL3cxWlNCWXhpcE1TY0NqUytG?=
 =?utf-8?B?TGtLTXZIaVoyN2gxYnFVSWtoeVQ4OCs4ZytadWJuK1NWcEtJYzlobnRZNDgr?=
 =?utf-8?B?S0ZhS00rWDlLUHJDREdhVHVUVzJITWp3dGdDR1plbkJ0Mk81WVdjcEpDWUJ6?=
 =?utf-8?B?aWlHTFVaU2JTYXcyY3h3dEh5aEJ0b0dxZ3JHcWZYUGdNNXFoZ09qTzh2eHdN?=
 =?utf-8?B?cWN2SUVDSkNvaGg1WkhueXpzVFNFSmZORWdpcEZ0NlhpeG83V2pFQ1RwdHlr?=
 =?utf-8?B?QnJJelFVTFo3UHVZM1hNQ2txUXU2L2NqcVNkT2lMUDFSNFAwQTVLUW1wTEFv?=
 =?utf-8?B?ZEFpMThyL01IU2x6TlpadENSSllyQ3hHOTFnUjFkUlNFWXgvdE91RjYzZEJ1?=
 =?utf-8?B?Zmd1TE0xODd5ZExZRldNK3U2TUQ3NmtkUWR5VHhwbHBuTHpkMC9LcmdvTVBM?=
 =?utf-8?B?Vk9FeG1wUWhTU3ErbGRZTSs2K3hKTDBKQThVYUtibitGSURwL3EzRy8zMUt0?=
 =?utf-8?B?bENuK2phbWxKQk8xWERRUWlKSXJFWDBibWdmVGF5L09QYVE1TzJxQjRzd2Jl?=
 =?utf-8?B?ZkU0Qy9ybUxoQm9rQk5COFFHVHp6QTFGN3BWSG5adzBlM3VSVVIxQ1N5a25h?=
 =?utf-8?B?MFRid0JtcEYrUUYrTTIwaHJBV0xrTHhwNm80VW1sdXFPVktaR0M1VEdRT2RE?=
 =?utf-8?B?NWJwbTBHMnQ5cU80RHg1T09UZngwQXNqTjFRRWVFbGMvWDdKNTQ2ZXhHUGtK?=
 =?utf-8?B?WjkydkVMMXRqd05nYUQ3Uk1HT3RlMytic3lPd1lDNm1lblAzK2dveXVDUFpu?=
 =?utf-8?B?ZGpLZktKYnBiaFFhZlRMR2NtWUVDOS90UURSd25GOGNURnRYazVPbUNqbFFN?=
 =?utf-8?B?TWZsTi9XeERPTWcxblZJQkdMeEplRHp5MGFJZ1k3Qm5yRXFibE1ST1B1TlR0?=
 =?utf-8?B?c0FGaVNNc20yMEJKVVFQdms2WjVQck0vSTZwYTVUc3hxbmE5SEJuR0RWOUpr?=
 =?utf-8?B?aEpNQWFlMHV2Sk9tVHlHSnFORjRKd00wUWtpdU5qYXY1cm13dUFUbHAySjMr?=
 =?utf-8?B?VDk3S0wrOEE5TWc5TytraXdWOXBGTFoyeG5CWUI2WTVRUHd6T3pMWTIxSWxi?=
 =?utf-8?B?MndpVmxIdFZEckNsK0w0WkVHbUo5L3RYblo3NDNuRStzSG9ORU1GbzlONGEz?=
 =?utf-8?B?MDl3d0s4VU50ZDNvcHo5TFV6MWEzM0R6aXEyRjJtT242WlpBWU1Td1ZTYXBC?=
 =?utf-8?B?d0tlYmhkN2x0dTM3dkhRZHVDM1ZLQ2FlRW9HWEEyc3dzNVNnYWIzR3BhQTlr?=
 =?utf-8?B?R1Jpa1dsNjUyRUFNa3JWdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFptdU9ncDB5b0ZIdDJPWm9iOXNGNjVvWitKZnRPNHdEdDNtd0VCaWp0VEVY?=
 =?utf-8?B?NXNzaGlmaC9rYnVIN0FMaUp5NjBZSlNIbCs2Wlp3ZXRESDMzZ01meXZHUDZh?=
 =?utf-8?B?NExrS0pvTVVYaVRHRjV2NUw0T3cwQ3pyVVNBU2Evb3RLVkFGcnVlamVhbUs0?=
 =?utf-8?B?ZXc5VGtHelFudnhnTjJNdjM0MDZQNUZoUWJseGdPeU1YWS9hYmlJZ3JadWFG?=
 =?utf-8?B?TWNSRGRBSHFmSXczcHJZSDY4UXJwM2I5bS9vWmpsODFUYk9idmZWOVQ5VG9N?=
 =?utf-8?B?WWV2ZEh1eUNMcDVtOXc2RXlvakRuUnZNZ0R5Skh5OWRzRnNTMGxuYi9RdWU5?=
 =?utf-8?B?QzVBN1NHdEVmbi8zYjRDVXQ1TUQwZlA3eGQxcjZPVURrU0xROXFSc2dZZFdV?=
 =?utf-8?B?Z2wxQ2lpWGVscUNlVVJrY01WbjFNRUJZUytjWkhkdTNxY2s2MHFhRkYrWWU5?=
 =?utf-8?B?SjlTTUZ6VjFOUncrWjhRWkNuME82MzgxZWJnQi9zOE1vSTFiQlZhNTMxWm5H?=
 =?utf-8?B?UEU2NmluYTBscGdGK09CMk42UjQ1VHlnOXY4SC9sMTdxbFpPNXRBNHh2Wi9E?=
 =?utf-8?B?bFF5WEN4a2dpcmhmRGlFZGdONk01Rjg1bCtWQjA0R3NlQU9ZMTVVOVJFVFlE?=
 =?utf-8?B?a2w0ejlPNHV0dWF2Wk9EZk9GSTNUbUJBdXNzZ25aRHUxN3FubXZyZlpWRHhl?=
 =?utf-8?B?VkdISlRuWmFoQnUweXZObTNLZjBzNFd0eEJzRk5TS2VNdUhLaHY0dXVxd3ZJ?=
 =?utf-8?B?eFZhUkRmQjhIT1A2Y2VsYjlwTWcxNTh6Z3FmUFNRVFlQZjFtYmUvQVpaOFJt?=
 =?utf-8?B?RjNsams2MFgwRTdwZVNuTE43MVZpaDV1VzF6amFKYUZlNDJ5dTNrTVU5Z0dw?=
 =?utf-8?B?N1dQRlc2dCtERnlqMWtvUVUydjIxY2pyZjJpM0V3S2E5dkJYKzN2U2tjSUxx?=
 =?utf-8?B?V2hJaWxRZjJYbFVWRDNjbUdhYU9MbVR1cDBQczNQcFZvK3dPc0JWZy9oOWdp?=
 =?utf-8?B?REt0d2pibllWdFRPM1Q0aDJCWngwamhQQUFPM0k5SkhyTEdxY2tZMFdRN1N3?=
 =?utf-8?B?cllDQ2NDTldjNnRuclNmbU9BSkdzd3NjaFVrVS9GdHR0RUxWQ3RPbGU2YTM5?=
 =?utf-8?B?L2tBZWlyV2pycnUyck55Uk9EQUFESi9wK0MzT0FONEhLVjVwZ09Dd1NqVzhw?=
 =?utf-8?B?UE1CdlNjWURYbmZhbkZYd25nQUlhSlRVV1ZTTWJQYjM0bFZJSVlnQk81UW5Q?=
 =?utf-8?B?Lzd0SFRmSUVQUmxMbzJwOGdnSnduVmFtVHdpL1VGREJGZXl4M20zY2Fnb2tj?=
 =?utf-8?B?NGFmWmowbDJOaVYwZVZRTERPZ1h6ck5DdjNEQlVJejJVTDBrZ0szTHh3aTNB?=
 =?utf-8?B?RjhzTDdCWUtZRVZMZnZHWTczMGpSUU90ZW5qRkRTZ3RrWWJlL0VGVGw4L0t0?=
 =?utf-8?B?T1NJRU5FUnJjYzlqWS9ranhmc201REt3Zi96Z2x3c2dhOUMyNFJmQ21UaHUw?=
 =?utf-8?B?VDhDRGIwR0FOTjlLZWV0SmxtZkZnaGpBdXJJVjNIOG80UHNheGYrejIxWFpJ?=
 =?utf-8?B?M3hzNEQzUjd0V2tESzBsdWs2UlFSaW5rMHVKSHdXbzNMbU9DRFFxY1lsZlVX?=
 =?utf-8?B?VkJ0OHBjamVZTFFYZjM2dFRlckUwbWZ3cjNaeEZFaVRKQzBZRnRmQmdMc3l3?=
 =?utf-8?B?MlVlenVEbjl3MkJZRHl4cEFBNUh5NHpDK1p3aDRYTjFTSEM4cUdFSTl6a1Zz?=
 =?utf-8?B?WVhiek1DWEdZMWhkc05sL0I0WHFWbzM2OTFyTVdKNGxrbDFoNlFUVVdqMEpr?=
 =?utf-8?B?TjNBbUdKdmVNVWdGbG5ISmdLU3pQOVgxQXdXWXpRSGljNFVWSDY0QlAwamg4?=
 =?utf-8?B?SklMcFJhekxoNDJCS2Q3OGRzbkdHejdQd1NSQS9JNW1zdGNZYnArTm1VVmVn?=
 =?utf-8?B?UjZGdWNoZEpwQlRKOVN6cmNBYnU5aTE0ZGZIM3lqR3krWEVyK2F1NEZ5NUZi?=
 =?utf-8?B?NFVjSzM0VjJ3cFRUcnF2QVB6eDg1Wk5Sd2RUR2l3Y3pOcnIydnl5anhGaTNp?=
 =?utf-8?B?TWNUdWwvWTh4SFlEUFY3YUQ3MGt1QytsWjJVT2JYRVNoQWZoZjdoZGJ2bUdw?=
 =?utf-8?Q?Xs1BV02lXssOaGRkv9Fa32QM9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19156947-2d68-481c-bd68-08dd394d6cb6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 12:24:45.7261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sn6N2oZjS1h8+8Uw2lGmDF0GpxmP+4HBxbTF0EIroECCnMSU76dq348NnHbyYOkvIB+e1hxXGehDRVeNkDaB4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117


On 1/17/25 18:23, Dan Williams wrote:
> Jonathan Cameron wrote:
>> On Thu, 16 Jan 2025 22:10:44 -0800
>> Dan Williams <dan.j.williams@intel.com> wrote:
>>
>>> The pending efforts to add CXL Accelerator (type-2) device [1], and
>>> Dynamic Capacity (DCD) support [2], tripped on the
>>> no-longer-fit-for-purpose design in the CXL subsystem for tracking
>>> device-physical-address (DPA) metadata. Trip hazards include:
>>>
>>> - CXL Memory Devices need to consider a PMEM partition, but Accelerator
>>>    devices with CXL.mem likely do not in the common case.
>>>
>>> - CXL Memory Devices enumerate DPA through Memory Device mailbox
>>>    commands like Partition Info, Accelerators devices do not.
>>>
>>> - CXL Memory Devices that support DCD support more than 2 partitions.
>>>    Some of the driver algorithms are awkward to expand to > 2 partition
>>>    cases.
>>>
>>> - DPA performance data is a general capability that can be shared with
>>>    accelerators, so tracking it in 'struct cxl_memdev_state' is no longer
>>>    suitable.
>>>
>>> - 'enum cxl_decoder_mode' is sometimes a partition id and sometimes a
>>>    memory property, it should be phased in favor of a partition id and
>>>    the memory property comes from the partition info.
>>>
>>> Towards cleaning up those issues and allowing a smoother landing for the
>>> aforementioned pending efforts, introduce a 'struct cxl_dpa_partition'
>>> array to 'struct cxl_dev_state', and 'struct cxl_range_info' as a shared
>>> way for Memory Devices and Accelerators to initialize the DPA information
>>> in 'struct cxl_dev_state'.
>>>
>>> For now, split a new cxl_dpa_setup() from cxl_mem_create_range_info() to
>>> get the new data structure initialized, and cleanup some qos_class init.
>>> Follow on patches will go further to use the new data structure to
>>> cleanup algorithms that are better suited to loop over all possible
>>> partitions.
>>>
>>> cxl_dpa_setup() follows the locking expectations of mutating the device
>>> DPA map, and is suitable for Accelerator drivers to use. Accelerators
>>> likely only have one hardcoded 'ram' partition to convey to the
>>> cxl_core.
>>>
>>> Link: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com [1]
>>> Link: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com [2]
>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>> Cc: Alejandro Lucero <alucerop@amd.com>
>>> Cc: Ira Weiny <ira.weiny@intel.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Hi Dan,
>>
>> In basic form this seems fine, but I find the nr_paritions variable usage very
>> counter intuitive.  It's just how many we configured not how many there
>> are, potentially with 0 size (so not a partition).  I'd be happier if we
>> can avoid that by just prefilling the lot with zero size and filling in
>> the ones we want.  So zero size means doesn't exist and use an iterator where
>> appropriate to skip the zero size ones.
> The PMEM-only device case did give me pause. Is that 2 partitions with a
> zero-sized first partition, or is that just 1 partition?


I was wrong about the code being broken for this case.

The code would create two partitions, at least for the case of partition 
alignment being 0, with the first one having 0 size.

This is all based on data/code based on mbox commands. Without mbox this 
partition info needs to be hardcoded or created somehow by the accel 
driver by its own means, so it is good to know the code expects such a 
0-size partition for the pmem-only case and the nr_partitions should be 
set accordingly. Not what my type2 patchset needs now, but I bet this 
will need to be set properly by a coming accel driver.


> Ultimately I do think the code should further evolve to treat that as
> 1-PMEM-partition, but as far as I can see that depends on 'enum
> cxl_decoder_mode' being eliminated and teaching all code paths to search
> for the position of the PMEM partition.
>
>> Without that tidied up, to me this is more confusing than the previous code.
> I was going to save PMEM at a partition other than 1 for the DCD series,
> but let me take another pass at adding that to this series.
>
> [..]
>>> +/* if this fails the caller must destroy @cxlds, there is no recovery */
>>> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
>>> +{
>>> +	struct device *dev = cxlds->dev;
>>> +
>>> +	guard(rwsem_write)(&cxl_dpa_rwsem);
>>> +
>>> +	if (cxlds->nr_partitions)
>>> +		return -EBUSY;
>>> +
>>> +	if (!info->size || !info->nr_partitions) {
>>> +		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
>>> +		cxlds->nr_partitions = 0;
>>> +		return 0;
>>> +	}
>>> +
>>> +	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
>>> +
>>> +	for (int i = 0; i < info->nr_partitions; i++) {
>>> +		const char *desc;
>>> +		int rc;
>>> +
>>> +		if (i == CXL_PARTITION_RAM)
>>> +			desc = "ram";
>>> +		else if (i == CXL_PARTITION_PMEM)
>>> +			desc = "pmem";
>>> +		else
>>> +			desc = "";
>>> +		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
>>> +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->part[i].res,
>>> +				 info->range[i].start,
>>> +				 range_len(&info->range[i]), desc);
>>> +		if (rc)
>>> +			return rc;
>>> +		cxlds->nr_partitions++;
>> I'd just initialize the rest to 0 length similar to what is happening
>> if we have pmem only anyway.  Then this nr_patitions goes away and
>> stops being a possible source of confusion.
> Modulo teaching other code that wants to ask "what is the size of the
> PMEM partition" to use a helper that hides the "find the device's PMEM
> partition".
>
>
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(cxl_dpa_setup);
>>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>>> index 3502f1633ad2..7dca5c8c3494 100644
>>> --- a/drivers/cxl/core/mbox.c
>>> +++ b/drivers/cxl/core/mbox.c
>>> @@ -1241,57 +1241,36 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>>> -int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>>> +int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>>>   {
>>>   	struct cxl_dev_state *cxlds = &mds->cxlds;
>>> -	struct resource *ram_res = to_ram_res(cxlds);
>>> -	struct resource *pmem_res = to_pmem_res(cxlds);
>>>   	struct device *dev = cxlds->dev;
>>>   	int rc;
>>>   
>>>   	if (!cxlds->media_ready) {
>>> -		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
>>> -		*ram_res = DEFINE_RES_MEM(0, 0);
>>> -		*pmem_res = DEFINE_RES_MEM(0, 0);
>>> +		info->size = 0;
>>>   		return 0;
>>>   	}
>>>   
>>> -	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
>>> +	info->size = mds->total_bytes;
>>>   
>>>   	if (mds->partition_align_bytes == 0) {
>> Obviously nothing to do with your patch as such, but maybe tidy this up
>> by making active values == fixed values when we don't have partition control.
>> That seems logical anyway to me and means we only end up with one lot of
>> range setup in here.  I can't immediately see any side effects of doing this.
> Yeah, I mentioned this in another thread. There is no reason
> for 'struct cxl_memdev_state' to carry these values at all. They are
> just temporary init-data.
>
> So, cxl_dev_state_identify() becomes cxl_mem_identify(), since
> it is a memory-device command. Move it inside of cxl_mem_dpa_fetch()
> since it is just temporary init-data for 'struct cxl_dpa_info'.
>
> [..]
>>> -		rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
>>> -				 mds->volatile_only_bytes, "ram");
>>> -		if (rc)
>>> -			return rc;
>>> -		return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
>>> -				   mds->volatile_only_bytes,
>>> -				   mds->persistent_only_bytes, "pmem");
>>> +		info->range[CXL_PARTITION_RAM] = (struct range) {
>>> +			.start = 0,
>>> +			.end = mds->volatile_only_bytes - 1,
>>> +		};
>>> +		info->nr_partitions++;
>>> +
>>> +		if (!mds->persistent_only_bytes)
>>> +			return 0;
>>> +
>>> +		info->range[CXL_PARTITION_PMEM] = (struct range) {
>>> +			.start = mds->volatile_only_bytes,
>>> +			.end = mds->volatile_only_bytes +
>>> +			       mds->persistent_only_bytes - 1,
>>> +		};
>>> +		info->nr_partitions++;
>> This nr partitions makes some sense though I'd be tempted to add a type
>> array to info so that we can just not pass empty ones if we don't want to.
>> Makes this code a little more complex, but not a lot and means
>> nr->partitions becomes the ones that actually exist.
> Agree, that's the end goal.
>
>>> +		return 0;
>>>   	}
>>>   
>>>   	rc = cxl_mem_get_partition_info(mds);
>>> @@ -1300,15 +1279,24 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>>>   		return rc;
>>>   	}
>>>   
>>> -	rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
>>> -			 mds->active_volatile_bytes, "ram");
>>> -	if (rc)
>>> -		return rc;
>>> -	return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
>>> -			   mds->active_volatile_bytes,
>>> -			   mds->active_persistent_bytes, "pmem");
>>> +	info->range[CXL_PARTITION_RAM] = (struct range) {
>>> +		.start = 0,
>>> +		.end = mds->active_volatile_bytes - 1,
>>> +	};
>>> +	info->nr_partitions++;
>>> +
>>> +	if (!mds->active_persistent_bytes)
>>> +		return 0;
>>> +
>>> +	info->range[CXL_PARTITION_PMEM] = (struct range) {
>>> +		.start = mds->active_volatile_bytes,
>>> +		.end = mds->active_volatile_bytes + mds->active_persistent_bytes - 1,
>>> +	};
>>> +	info->nr_partitions++;
>>> +
>>> +	return 0;
>>>   }
>>> -EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
>>> +EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>> index 78e92e24d7b5..2e728d4b7327 100644
>>> --- a/drivers/cxl/cxlmem.h
>>> +++ b/drivers/cxl/cxlmem.h
>>> @@ -97,6 +97,20 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>>   			 resource_size_t base, resource_size_t len,
>>>   			 resource_size_t skipped);
>>>   
>>> +/* Well known, spec defined partition indices */
>>> +enum cxl_partition {
>>> +	CXL_PARTITION_RAM,
>>> +	CXL_PARTITION_PMEM,
>>> +	CXL_PARTITION_MAX,
>>> +};
>>> +
>>> +struct cxl_dpa_info {
>>> +	u64 size;
>>> +	struct range range[CXL_PARTITION_MAX];
>>> +	int nr_partitions;
>>> +};
>> blank line seems appropriate here.
> Added.
>
>>> +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
>>> +
>>>   static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>>>   					 struct cxl_memdev *cxlmd)
>>>   {
>>> @@ -408,6 +422,16 @@ struct cxl_dpa_perf {
>>>   	int qos_class;
>>>   };
>>>   
>>>   /**
>>>    * struct cxl_dev_state - The driver device state
>>>    *
>>> @@ -423,8 +447,8 @@ struct cxl_dpa_perf {
>>>    * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>>>    * @media_ready: Indicate whether the device media is usable
>>>    * @dpa_res: Overall DPA resource tree for the device
>>> - * @_pmem_res: Active Persistent memory capacity configuration
>>> - * @_ram_res: Active Volatile memory capacity configuration
>>> + * @part: DPA partition array
>>> + * @nr_partitions: Number of DPA partitions
>> This needs more. It is not the number of partitions present I think, it
>> is the number that a particular driver is potentially interested in.
>>
>>>    * @serial: PCIe Device Serial Number
>>>    * @type: Generic Memory Class device or Vendor Specific Memory device
>>>    * @cxl_mbox: CXL mailbox context
>>> @@ -438,21 +462,39 @@ struct cxl_dev_state {
>>>   	bool rcd;
>>>   	bool media_ready;
>>>   	struct resource dpa_res;
>>> -	struct resource _pmem_res;
>>> -	struct resource _ram_res;
>>> +	struct cxl_dpa_partition part[CXL_PARTITION_MAX];
>>> +	unsigned int nr_partitions;
>>>   	u64 serial;
>>>   	enum cxl_devtype type;
>>>   	struct cxl_mailbox cxl_mbox;
>>>   };
>>>   
>>> -static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
>>> +static inline const struct resource *to_ram_res(struct cxl_dev_state *cxlds)
>>>   {
>>> -	return &cxlds->_ram_res;
>>> +	if (cxlds->nr_partitions > 0)
>>> +		return &cxlds->part[CXL_PARTITION_RAM].res;
>>> +	return NULL;
>>>   }
>>>   
>>> -static inline struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
>>> +static inline const struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
>>>   {
>>> -	return &cxlds->_pmem_res;
>>> +	if (cxlds->nr_partitions > 1)
>> This is very confusing as nr_partitions is being used not to indicate
>> number of partitions but whether a driver has filled in the data for them
>> (which may well be empty).
>>
>> I'd rather see that as a bitmap, or a 'not set' value initialized by
>> the core that is then replaced when they are set.
> ...or even better, not require PMEM to be at partition1.
>
> [..]
