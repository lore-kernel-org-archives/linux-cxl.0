Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5988817ADF8
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jan 2025 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738003486; cv=fail; b=IgTi6KOGxaJjEq7i6BVLqtcylGcz76NiZBt2L6uHehw9u5lzjDqzmWjuEm8jwrd3wHnclOpcP/QnEpnTuQTpXAWW8rk9A8FNVRtA1a8StBtHwkPkj+S7K7eu1BD8zVu87H20q8TdcqRKhamEwQ9fiXZlo0nfl0SPx7wShFsmXjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738003486; c=relaxed/simple;
	bh=+0gla0mmV6qnI7fsJjB7szwEz6QEQOjt4lzkgjinxwo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qNM3iIsuBkmBUKiFkniEiVUXfnLy5g4YsSrjEFfIff2uaDupLXD91oQRaQzNKxksaNyfkQ25w8rjgA8494NkvNOOR+oj1+fP2hOyxH0TzsjNrcUAxkhgitmxtKVL+9uX9dyKRBhkXJH94M+Xk4YhEuR5WgKCAiL5CMCqL09MLKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z7UYx6a2; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z7UYx6a2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1zQV+HMvyOIQqvyQ1Ky0Wraru1EBEb7TkdBmNeGe9Fc7WTQ9N6t772+i3UPeoDpqqGgTDqwR+KLmeYntTfHzz99b9AiVDvqEOpk6U6F/nR5VE7dKHIceMI3W65XoQrh31TfhRBOjVzF7ChGI3oO91YZEi1IU4fv2e8EwT+aR4B2ukhE0tE0doE6+LwX9kh6JmxAbmTgFFKf3HXVrbLBv3WkjFXYqUPPFBGTXA13jfGLk7rVbWtIS1mRXS2VbFQd3OF+sfzo/CTUJ+NwI/QskS/ip/+ai7ngbGKhsv3yCM0QLUQeVXRpZk6AWrve+7LWYVZR46445IQ5jRBY4gCZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBkN3IcX4RSbnM/qpEs1+OZNdnaMhlyqB4tjZVHrONI=;
 b=shmrOsaSbGqXpDrxlTImdR4Ct0dKHLZX7Q5Nq0xIwp/zFBglgImUV4ZsneiQKL7QqtQ/6b2AXD0bQlGMWVqkRKfdllrIw788LMcc3q7AnHHs2rSg5hSxZIOds48cbsXzj3Z9TOjJvbCBs/lQ/sMfSxRlcGJmqWt2J0vd5Lzvx+6jzh2UYuItdkrd7Q34KiLuudpV/ddpGhGyGzLnafN5yjCVlP7KGTPRsr/q6ab+lTHGjLRbGwXNW/9bf5uZArUiCGFvTr8W4zVtt4Rnu1JnmA8Q4Mao8w+iPLukdCw4bxpoG/1xf1iT3drS7jyVrgQjr0Mqv1ckQUyfR1kzEDLm3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBkN3IcX4RSbnM/qpEs1+OZNdnaMhlyqB4tjZVHrONI=;
 b=z7UYx6a2d6glPEoPRhP/vcsOLPjTn2QZspEOg1iuTBYPeCH1SEErZ1vBVMGDPpY3lTeQ5Ys0LYyDgkVY3MICKlhyPzZJy1t+yX4L3818fBJFqu7Wc5tFZgxyW0AIyIUEvl1PiCQ9/KGfD/7234R+MZ+qGbOW/wyscJfJ5jR3OkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 18:44:38 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%7]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 18:44:38 +0000
Message-ID: <2cf543d2-9d78-409f-a567-4df021e3b45a@amd.com>
Date: Mon, 27 Jan 2025 12:44:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dax: Update hmem resource/device registration
From: "Fontenot, Nathan" <nafonten@amd.com>
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, alison.schofield@intel.com, linux-mm@kvack.org,
 gourry@gourry.net
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <9a41f91ed487ea64e187d84fab3bd69a4a5862f9.1737046620.git.nathan.fontenot@amd.com>
 <67898815e6280_1c3f7529466@iweiny-mobl.notmuch>
 <fb3eaa1e-0c87-4859-94b0-373ba50e4d78@amd.com>
 <67902a5bc53eb_e5f72942b@iweiny-mobl.notmuch>
 <621df885-d80d-40b5-9fe2-d6235ebfe0e5@amd.com>
Content-Language: en-US
In-Reply-To: <621df885-d80d-40b5-9fe2-d6235ebfe0e5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::33) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb72e70-b42e-4b03-15eb-08dd3f02a741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlBObTRlTWdyQ05SRW5VblRNTmlNa3doSlNpNDFvbzd2cG5IRmhkdHArZWhh?=
 =?utf-8?B?aTdjbEcrWEx5dzVQMENwL1ljWWlFK3ltSkY3alZuYkE4V1BHbS90eE1XbHdQ?=
 =?utf-8?B?bC9nKy9uT2h6MjJXMkNlS1RsZWhRRU81NDhqSWhNNThyRkVORmhpdzRYZ2th?=
 =?utf-8?B?ZVhjRWFYVktRWno5U3RKYmRZcHB6em9UL25adXJQZUFNdE1KaURVYktlNUJh?=
 =?utf-8?B?UEZubS9VZnhFS2VDaEo4ZmxHV0pNdVM0NEdxK3Z4NWNhZFdnNXZhSkdvUGZa?=
 =?utf-8?B?QmdIZ2Z5dFF3SjFsZHhLRE1ydDgwUGVjc2YyQ3dpLzBNbU5LSVJmRVlFUEo5?=
 =?utf-8?B?MXRJcEE2TUl5NFJYMWRHb284N3d0a25ubWxMd0ZpdTNnUStlYUNFd0p2K3gr?=
 =?utf-8?B?MDVlQksxQ3Mxcm5SLzNSQXVMa08rMVJXQjJhWVJTcDZuQ3VhcHBHbUVFV0Vn?=
 =?utf-8?B?V1FnekdjYng4eFBZajRKcTlRZWRqK01ncGYzclpibjBNTmFHMXBNS0hYeERL?=
 =?utf-8?B?SUFydTRLWkFKNzZ4a3Q1elpycXhpemcrQjZZcDYxVERkMVpMb0g0OTJDZGJi?=
 =?utf-8?B?ZHZzLzNmczMzRWpQTFZuT1BEK1pzQ05QQjNqWWl0OHd4cDlneDNoRFpHUEtQ?=
 =?utf-8?B?aE50dFcrSk5oNTlvQml5bFN1YU91MGtUOC9Fd1F2L1R5eVNSTXpwcHV5WlY5?=
 =?utf-8?B?ckZDREx3a2l6eE5SN3NnaDNiNDJzTVlWZWZaSFpkZzZlRmhLcHVUYmI5d29L?=
 =?utf-8?B?VlpmM0t5ZjNUWHNjOG5tNnBxNFhPWU5aaks5V0g3WEZDVUF2U3NoM1l3ZExk?=
 =?utf-8?B?SkpKcUwrUmlCOXJtaWRpTGtJcTA1bEx0MDdHSy85Wkh3eDZsdXJST3orZ1N5?=
 =?utf-8?B?SzF3VUorbXJ1YVROcnJKa3VNTnRMUy96M2o0QXk3bFA2VVk5QmtaYmhYL1Bp?=
 =?utf-8?B?Wi80bjg0YkFOelZFWDRjL0E1SWEzcE9UWjdpTklZb1lNRk5CTGRDV1ZjUTlC?=
 =?utf-8?B?YmYvS29wcWd1Tmp0SXVxUkVZTlJLRXE1b3lFdUZGRW1nSk93SElhRGtIbTcw?=
 =?utf-8?B?TjhuTnRYcmVtY3krMG44UUo5UGVHdHVmTDliSGs3TzhNNFlwVWJzcFFvbHc4?=
 =?utf-8?B?WUxpcjhXTkRra2xHVlYvNjk4T1N2ejQydjFpTDlsSWFIZzNwb2VuSWwzQm1W?=
 =?utf-8?B?eTFxUlYzN0wwSGZLZkFPRXViVG9LT0lrZXdEL2JGRnVVcDZGNzh5NVArMXdP?=
 =?utf-8?B?QmlkbFpuY3B6VWFST1BqM0FBbUVEeFdDVXNxMFRHOFg3OHFXMk9keGVBd20y?=
 =?utf-8?B?dWlGRkNGVlF5N3U0THdoYTVKQnlZZTZJQ1ZXTHVwVHlwZGt6NTF4K2twaEhv?=
 =?utf-8?B?d08zNWRIOHM3WTl2MTdBOGZlUkhSVlA5S2o2RWEyQlJpNlVvWVY2aVhSSFhj?=
 =?utf-8?B?MzBZdDkxV1REelcvU2xYcHBzUHk1YkpDTFhUek04c25wSk5ERGRZYjMvVmxC?=
 =?utf-8?B?WnNjdm1tZU1iT3EvTmlTYVQrUFIvVUl2bkJFeDVxOGxGMTNYZGNvQm8xVE9T?=
 =?utf-8?B?M1JRMHNzNWpBeTNKMGVDZlo5WFlBK0g4QStObXVOUGRxNFlTME80azc4bWhI?=
 =?utf-8?B?eUw3S1NsVW1IcnJEZDBGcklMZjdkRmNDVFJzM25rb21QZXQxMjd3ZmFjWVo4?=
 =?utf-8?B?Y0o3WG9QcUJLQkNUczFUN2pXR1FQZEVRVjJFZDVxbmFpVGJieDdjdXdOeERW?=
 =?utf-8?B?SVp0clp2by91YlZUZjRCZ3RNM0JPRHFDRStwLzM4OTl5NkRFTzBubWF1QUVX?=
 =?utf-8?B?UmF4UnJKRndXdkEvZi84RkR2cm1XZ2dRdElnSGdKYVpvbENoWkk0VTdVU2dP?=
 =?utf-8?Q?9pAIOfnEjTmSB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHNINGhpM3RiVW5LWEhFWU1heW96YmZsaTI0Y2ZBZjdnTjNNUDh1QVliRnZK?=
 =?utf-8?B?dGlMUXUrY2FXY0g1SHlJcXRjTHJDRTVxclliRlJLdlN0dml5TVJMZGl6QkNV?=
 =?utf-8?B?ZnN2SFloeC9iSmttL3A5UStFbFlHZndLell1Vk03Wmx4emhQcU40b0dObDZr?=
 =?utf-8?B?cHFla0xmNzE4cjdYOUN6R2J4SDBUMEVvTEpDKzkwZXBWV3FOVGl4WWU5eEhs?=
 =?utf-8?B?UWNrQkMxNGw0eWhTWXJ0bzZoSVIwajlGaWVlQmpnb1EwSHVOdFlUbm8vR09r?=
 =?utf-8?B?dHo0dHJXN2s0a2VSQ3JxNHNKQUhLRTVlcExXL1RDM0VPMGc0ZmNaNXdHUzBs?=
 =?utf-8?B?WG5keC9VVjBkdndvZ1VTSDNma3VJRUg0aU5ZYmpLeW9SdE5FZTdYQ3dyWXg1?=
 =?utf-8?B?OTJuWDJoZEVDdGFsY0c3WUZDN3RWbW9FdVE5bTFObFZSRENxSmJpcThWUm5Q?=
 =?utf-8?B?TE5DY3k5Y0ZsN2M5d2R2Q1dGNTN2RDZ3TWM3Tm9ocFZCZTZEWjFJeW8vSEZr?=
 =?utf-8?B?WDRXVUtTZi8zNTExL3FIS1hxQTA3clppNG03Q0dmOWdXZ1JzTFZndUNGVmkw?=
 =?utf-8?B?U1pFRFF0YWVmL1NtUDU4SW9BWk5wdUJ0VkJmMElRM2NHRVY5QmNJWjR1bWw4?=
 =?utf-8?B?a09EU1FxNzlXR25hc3h5V3ZWekRHWUhTQjdOdzJqeGdQU3lxbk9mdTNaYnV0?=
 =?utf-8?B?WjlDakMxbEcweXFIZlgzTnRJMnFaWlJoK2x4RVg0eldFOW9XckxNS05NQ3R5?=
 =?utf-8?B?SUhnenhGTDdzK21XZGF4NnVuMy9teXhaV3JpQXZBdVM3YnBxMGs2UGNmZENy?=
 =?utf-8?B?MlVmRWZONGNVRDZOL2wreGxvUHgvbDFZYVZWM1k4bXJ0TUZPbHVIYVcrRW4v?=
 =?utf-8?B?QkoyVmQrc3B0SlBtOWZQaldEOVhRZnZDeGVzVm1oY2Ywa05xc1U4eGh2OVFp?=
 =?utf-8?B?c3hPREJ1R3IvbEczQjhTTmVUYWtBZGFMOUVOb2FTZXBhYUZDS0VMTHJYUEFr?=
 =?utf-8?B?cFhYMlNMNW1EcktDOEU5OW9pQ3hnb1lNRHpaL3paWWFvaUxad1JZd3NqOTZy?=
 =?utf-8?B?b3hpMHVHSWpmdlg1L2tjbjAvRGVQQ0owQ2cyN05Xb3laOWhZS3pTU3RPOTJw?=
 =?utf-8?B?Ri9jRUd0MG5QMlBQYXVXL1ZpSFVFMDk4NHdUMmxuMXVCNXFQRWlocTdMU20x?=
 =?utf-8?B?YkE0eDBMUjRiREx6QzhSU0ZZemIxWnFnODhnbUVsSnFLZXA2M2dPbWdDWkRR?=
 =?utf-8?B?T21NWHRBa25BYnJPK3VlZWM4a241akxqeERxZHMwTnkrK2RLTEJoeUU5UGEr?=
 =?utf-8?B?NEQrU24rdkZuNUhpQmVRR1l3QVh2em5CaVJDZytBWUoyL2V4M090ckJuZlpX?=
 =?utf-8?B?QVNXV2QzQUNnbHQydE1ydk5qTGlHMXQzOEovbmd1VElhKytIQzF1bXlPQnVl?=
 =?utf-8?B?Y0thN3FZQVEwcjBnZWQ1N0htOEIvWm9CNjdKZWFXbjROZDFpdkhKZEZLWkdm?=
 =?utf-8?B?ejRwWUNRSEpUWllsQVhSakoxZWRXUEFkZXVYZlQ3cU1BRVdzeUcyaUQvdmxE?=
 =?utf-8?B?TE8rcHpQYW1Uenp1WG82OEgzM0JzeER0NVdpVUlXanYyUG1uaWMrRjBqU0Rx?=
 =?utf-8?B?ays2ZWt6V0R2Tm1SSTdrVXBsRS9SL1hJM1VLbGY5UEIrNm8zeWFmZklJVDE2?=
 =?utf-8?B?KzBIRE1TdXBYTUo1ZkdFdGgybngxbWtDWDBCOUNmNkVselVCUWRxTUw5T1lh?=
 =?utf-8?B?S25md1AyNnlEU1Npb3R4YkJselNrRTlMRGR4M3RESkd3dHM4S0RtYThyWVRB?=
 =?utf-8?B?RVUxcU4rT2Zmdm1keit2OWJuTVhvbXYrTit1RERjb2NaWnJ3b0FMUkFPR2x6?=
 =?utf-8?B?VkhHT0pQSDBBUXNPdlpFNjQ0MDFONVRodWtmUFJGV2Z5YnZaeGdmajV2elNH?=
 =?utf-8?B?T3piVEh2VHBjTWp6TlJ4aW40bmtraXo4U21HWEpmK2VtSkVpV3VJcVBPMi8z?=
 =?utf-8?B?SEJoSTBhajhQWUsxcmJOTmdRM0tmUEtKQlVCZmZTMjNkczRXZW1Mamp4ZW0y?=
 =?utf-8?B?dGNzODRlcDdDVWQwUmdCM0oweGhoTldUaW1OeG1LWHBGSUpqaTFXaS9YZFpu?=
 =?utf-8?Q?UbNX1dfl8fxaHOyFOBWO6K2gI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb72e70-b42e-4b03-15eb-08dd3f02a741
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 18:44:38.6656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzv/fvqM8PDCTiGvc6+61x2cobWqLwaUmJCrQSp7MuSeEbdCGTZIu2NuqAhXTLLPDzIJgjyoe/rBrOXOfbTJww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452

On 1/23/2025 10:01 AM, Fontenot, Nathan wrote:
> On 1/21/2025 5:14 PM, Ira Weiny wrote:
>> Fontenot, Nathan wrote:
>>> On 1/16/2025 4:28 PM, Ira Weiny wrote:
>>>> Nathan Fontenot wrote:
>>>>> In order to handle registering hmem devices for SOFT RESERVE reources
>>>>                                                               ^^^^^^^^^
>>>>                                                               resources
>>>>
>>>>> that are added late in boot update the hmem_register_resource(),
>>>>> hmem_register_device(), and walk_hmem_resources() interfaces.
>>>>>
>>>>> Remove the target_nid arg to hmem_register_resource(). The target nid
>>>>> value is calculated from the resource start address and not used until
>>>>> registering a device for the resource. Move the target nid calculation
>>>>> to hmem_register_device().
>>>>>
>>>>> To allow for registering hmem devices outside of the hmem dax driver
>>>>> probe routine save the dax hmem platform driver during probe. The
>>>>> hmem_register_device() interface can then drop the host and target
>>>>> nid parameters.
>>>>>
>>>>> There should be no functional changes.
>>>>>
>>>>> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>

[ snip ]

>>>>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>>>>> index 5e7c53f18491..088f4060d4d5 100644
>>>>> --- a/drivers/dax/hmem/hmem.c
>>>>> +++ b/drivers/dax/hmem/hmem.c
>>>>> @@ -9,6 +9,8 @@
>>>>>  static bool region_idle;
>>>>>  module_param_named(region_idle, region_idle, bool, 0644);
>>>>>  
>>>>> +static struct platform_device *dax_hmem_pdev;
>>>>
>>>> I don't think you can assume there is only ever 1 hmem platform device.
>>>>
>>>> hmat_register_target_devices() in particular iterates multiple memory
>>>> regions and will create more than one.
>>>>
>>>> What am I missing?
>>>
>>> You may be correct that there can be more than one hmem platform device.
>>> I was making this change based on a comment from Dan that it may not matter
>>> which platform device these are created against.
>>
>> If that is true I think there should be a big comment around this code
>> explaining why it is ok to have the platform device being allocated in
>> this call unregistered when a different platform device (host) is
>> released.
>>
>> IOW hmem_register_device() calls two devm_*() functions using host as the
>> device used to trigger an action.  It is not entirely clear to me why that
>> change is safe here.
>>
>>>
>>> I could be wrong in that assumption. If so we'll need to figure lout how to
>>> determine which platform device a soft reserve resource would be created
>>> against when they are added later in boot from a notification by the
>>> srmem notification chain.
>>
>> I see that it would be more difficult to track.  And I'm ok if it really
>> does work.  But just looking at the commit message and code I don't see
>> how this does not at least introduce a functional change.
> 
> I'm going to go back and take a look at this again. I went this direction
> using the approach of having the srmem notification chain. The dax driver
> then adds soft reserves outside of a probe routine and don't have a
> platform device associated with them.
> 

Digging back into this, the dax driver only creates one platform device.
During hmem_register_resource (which is what hmat_register_target_devices()
calls for each resource) the dax hmem driver will only create a platform
device when the first resource is registered.

Each resource that is passed to hmem_register_resource() is added to a
resource tree internal to the dax/hmem driver that is eventually walked
by the dax hmem driver probe routine.

Now that I understand this better I am confident that saving a pointer
to the dax hmem platform device is safe. I'll include this information
in the commit log for the next version of the patch.

-Nathan
