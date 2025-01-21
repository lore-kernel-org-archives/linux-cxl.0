Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42F51F1527
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jan 2025 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737485366; cv=fail; b=inLiIqwSK68x7LyOyHz8ZpxMZoCOZ3RY493S77sR3RELxvHvMQtX3pBo0UWmzayCousyv6DW2XDvyLt3FBF0y7Vsd0/dMYKW9nJePog0aWGrPCRziM/0/PklD/bOVe9IpXQEEs0sQVVfeZXe3KF6TtN/Wv8XhsMQFRFcGdw3gv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737485366; c=relaxed/simple;
	bh=nxBGbdH27dL/ODArB4Uv3RoCiTuPv1jk57XMRQak8+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lh41u5oO75Kxzcqoi7NST3M3BnMSQojFJVI2krSVCu5SRvIQaYIqrOGcEpj/WMelOqWli2k2QXGD4OvZy+blfdekn3nLh1/TXERd4hWUXPlRc5y2aTTAg0ZXb0W7stjogrzIdnjXNsl/inAiONifCARcNLXXUS/QYHshAk0lJoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zQn9yTrO; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zQn9yTrO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLDAth7OGSw+owHSndrSWPIo+m3yvItd0/GfhvgltCeKAyewUhU2rdQyRiylqNcnrkxY6xw5ZYRPTyzo8EmGwuJeWzhcP5nS9n4liEby6kew57kijnm6igKplImDZDkpWhCE2HN0/jsaIlrinSJZ0NK/kBOIJnf4AF7O3dJEA3nuVEVx630waU4Khx8haHjP4L7Vd/eG4M/w2vIFOBW2DWk6BJ06rolYkOm7yyhi4ZkM50trq6HZe7Wdv/yNaDlwHgJM31wx8VMaTCQmflMfD9sxKcz4rlcw/MbOSNV5gOSiPOHE1eXVqrdaj79AGixmgzB+CEHUxB6TGRtaMfjUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASUCduUuu0Pg6fV+buxrDDmWkbM8mDU3Y7wnSawCfBA=;
 b=bVTq+kIjjpz4Lt5yzwRE8z62hRfVE+NANOvB6sqg8qVhglMKDK7lMrPjxtbgqA4ifM0/fmlF06r/lDZVm/QPZVB52d9d2P3OvFsVTc7G4JP169a9HJRDK3q3kmp6FwebrUROGgirCwgU/G4IDNrPVibScNR3WRp/ctynCxJVm6k0GlrDFk2MDqa04u13K2dUT5j9zX2k2PvbjzDE+zQV7X+bDs6G31WXpEJbzEHh4pP9AEzOG7MIlIXYEdyUHnkNvb5lrx70re5ljiRC7D/6hcbw0ZBIO9Wn8ZP+Mt/hb/DV9hVpwG1xSGe9QMpcqU8FHtDlRK9YO9QATZsMAPFkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASUCduUuu0Pg6fV+buxrDDmWkbM8mDU3Y7wnSawCfBA=;
 b=zQn9yTrOi//Vr2e7OuKPbazBKzi33ei43eRmIgi1kWjevVMtS0Mb9R9BMNDXbYLIgsswRAvG+tOF+wBvuyPKzFEYwAYve1TlQIE7c3Yv6TFa2gcUBRckw00bvOJtqPoKYpD88g35ctLjpoORBKuvhb4xTaoSYJfezaKD+OT8gVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 21 Jan
 2025 18:49:21 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%7]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 18:49:21 +0000
Message-ID: <fb3eaa1e-0c87-4859-94b0-373ba50e4d78@amd.com>
Date: Tue, 21 Jan 2025 12:49:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dax: Update hmem resource/device registration
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, alison.schofield@intel.com, linux-mm@kvack.org,
 gourry@gourry.net
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <9a41f91ed487ea64e187d84fab3bd69a4a5862f9.1737046620.git.nathan.fontenot@amd.com>
 <67898815e6280_1c3f7529466@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Fontenot, Nathan" <nafonten@amd.com>
In-Reply-To: <67898815e6280_1c3f7529466@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0113.namprd12.prod.outlook.com
 (2603:10b6:802:21::48) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe1df80-63d0-4c25-a3a7-08dd3a4c515c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MklGMm1lNzl5TEVRUTZaZmtrcVhXZkg5Ymp6cVJnZzQ4UEQ2VWl3ZnVyeXdC?=
 =?utf-8?B?RWVQdXFGNHlpenpmMzhZQ0VSdEt2T216bUUzUUdnZmtOTWtBRlZsYmNIVmpH?=
 =?utf-8?B?VjV1UjNFSzlEc09scjZuaFNRVC9BWERLZFhNT2lHTDBoRGNUWWFzanlURnJS?=
 =?utf-8?B?Sm1jV0N4eUhtQmRwSDNHYUlYOUgxb2hYdFpNc1BwajlVTkdoNE9kUURsUGdB?=
 =?utf-8?B?RmRtckdzMnVVNnoyYVk0bHBYdkQ1aUFVd2NNZkZIckV4SkxBZHV2WS9kbGE3?=
 =?utf-8?B?QjNnQVp6emlxT2FBTzltRHJPNVY0OWtEL0NiRElITTN2ZjRiUURVeTRPS080?=
 =?utf-8?B?THJrMTZtem5yR1kxZWVuRkVYSjhPeXg4dFNZc2NwTTFuN0hTUk5FbHJIK1lL?=
 =?utf-8?B?VGNWUVNRbjUxbmd6Smo5bkxOV0VRVFNQYmdKQWxUZ2dPTTJtUXBmZjhkcXBy?=
 =?utf-8?B?eFpwUWVKd01JenJSa3VtZVdnYmVhMENFcWRkTmhxVUtWMFB5amJGVXM5SFJl?=
 =?utf-8?B?ekF0Mmp6VlRQaW0xWUp4UEhRK3ExNXh2RnN5SVZVMnF6b3ZrVHZMNWcreEJ6?=
 =?utf-8?B?S3ZKanpPZW5DSFVhQ1NFUjhOWUpaZUw2aE0ybTJnLzBMMkVDTnFmYzFIZmJB?=
 =?utf-8?B?UmZEcU1LVGZzUjJORWpjd2psSzFDeEJIenh4VmM5bTVvRExKVHNXbFV0aDVZ?=
 =?utf-8?B?S29HRFV5RWxUU2VodTFhZDhjdkFzZ1JWcFE4RmRjSXljVU1FTDl2VWtmS3Iy?=
 =?utf-8?B?TkpWcTJQNGRqK3NOamZMWEhzSi9JQkRUMk0vOW1GN0pZUVdnMkxSWHpEYiti?=
 =?utf-8?B?QitGUFdQcExlYThNREFkRzlxWXB5MktyZ1A4TGZybGp5Z3VRWVBDL1VCN01E?=
 =?utf-8?B?Q0d3enZ5NndMaXFZcWg0YXVzVVdrVGJmU1NKSFNoclFtdnRDODNjNFl3bGEz?=
 =?utf-8?B?dEdDbHBKVllTQytZcGJOVjBvUFdsa0l6YXF5Y3poUUl0TFFzUjJHRzQ2dEZ4?=
 =?utf-8?B?RzgzTEo0UlpjbzBNRkNRbk1GdnFYMkJBZkJ5SlJlaDVrSDgxNS94Y1JnVTZp?=
 =?utf-8?B?NkNWYVhpRGs2WjY1RDVKNWZ6SSs5Zkt4UXhna3ZzR1ZZRnJ3cGRLTE1IQUlv?=
 =?utf-8?B?dVR2bmw3b3NTSGZtVm1BZS9tMG5jS21nNE1FdnNtdUpML0M2TmJHUERoRE04?=
 =?utf-8?B?NWt0amZHbXRuTUJNZHVVdmdLZHhZb3MyZlFUMjVYQjVHN2c5YitadVZSK21q?=
 =?utf-8?B?U3EwVjl3RDNVZmxQRDNYSnpGbWNpc21QWWR2K25zQmMxMnVOejFmNnpyQ1dH?=
 =?utf-8?B?L1RoVWdlTUJYaDdiSWU1aitsaDF2UC9raURXNHhzTzcwbHowc0RISi9PMXlS?=
 =?utf-8?B?U2s2T1Q4MWEvTzRyWjU1dktHaHNPZlo2NUNRSG93WWhBWmJOVVdNbFJ1RGxa?=
 =?utf-8?B?UGIrem5EMDV0d1hMbWxEVGxyWmkvQUI0Y094NjE4OFBVbXpPOTcvZEdDZ0tP?=
 =?utf-8?B?eHFmZnB4UnVGTHNpaHRJSFg3SWdqUnNiTEl0dVZvYnRpejgxb1pIVmpDbnB6?=
 =?utf-8?B?TE1QQVB4Z2RlMVNVT2R4VkovcVMybmtaUDhIaThTUVJvbm1tMGloWitFa25J?=
 =?utf-8?B?ZVpBQVgrUmdXUDJrTm4xMHJ3YU80ZzNGQ1c4bS9UalUvVUJ4eG9BY1VEZDl3?=
 =?utf-8?B?Rlp3Rml0Y2FDTDF5RkRGeXZKaTZCdVE1WUZyczBWSVFjOHFxUzNtRmFUSXBm?=
 =?utf-8?B?bFpTTE9XaFdMNGdhUmtXQVl6RWdlV0J1SVBjZlBJWVRHR2FUaTRiWFFPQTdo?=
 =?utf-8?B?REdwc2JwNVZIN3RUTHAvZjRHang2UkF2SWo3QXo4d2I0bW0vUGpSYlFxU1NC?=
 =?utf-8?Q?UymTXKS72kZMp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVkrVmhrb3BRWmlaNDYrbHZHUjhOelBTZ1J6ZzRBeGFhVnFQSXFBQXRKUThm?=
 =?utf-8?B?RE9kc1VKZUltNkhERVg1RUg5eEVVaDJHaHZkVjdwcy8zMHB1cFVyd3FrVUdz?=
 =?utf-8?B?cTE3bGVEb0RLcWhhRVp4UzZqZ1ZoOERsTDR5T2MzYjJVUlFpMlUxdGhJWU9o?=
 =?utf-8?B?Umd2NWo2c0lVWE5RM2tRU0h3NEJ0bVJBamlMVk4rL0JOMlNOUTVoMVpCNGxn?=
 =?utf-8?B?cjJpenhTWlF3bWhyNVRuclJLYlVKZWs2UnU0Q3ZrUHJGSXdUOTVOUzlFWktY?=
 =?utf-8?B?YmZ3YUVBaHRGMDZzSWtRN1owcC9KRlI3T241QXlPOTd6MmlnM1dKTzBqWG5i?=
 =?utf-8?B?Z2k2WXpVUUpKaDVnNTl6VkV0QmYwMHJoaUpwMzRvMmFDdGJUM0Z0RExCcWdN?=
 =?utf-8?B?b2xqcEtOVmQvWlQ0djN1cDlOU0s3SDRzYktvWXhWaVpUTHBoaHg1OUgyVkw5?=
 =?utf-8?B?cWJGRzZVNEQvQm1UcHBEdUp6djlEUjZxN1d3ei83NUFJd2k2d2VHd2YyQms0?=
 =?utf-8?B?VmN3amhDNktRNTM4aVdjWXFvaGxISThnRzhpZWpDVHZ2OFd3QXE2UmVIaTVS?=
 =?utf-8?B?NnBTOEhLM1JEQmlpNnUvVDFnNVRtQk1VcXFLSHJwV3NUbUVYWjdzSTRiUmZG?=
 =?utf-8?B?Tm16TjlNV0xoZk9WTUc2Y0h1OTFjWWNqNlZRK0I0R2VQMEpnWVpBQ1B3a2xl?=
 =?utf-8?B?Y1ZpYmhBcFZTbjBRcDJNcWI5MUR2UDhURTc5UEsxRVNJV05WdjZJYTlPQm5E?=
 =?utf-8?B?V0RoYXBySHQ5N0R4TXhtcXppZlZVZG9LN2FzYlN2N20zOEtVdExvYTVZdFdY?=
 =?utf-8?B?MXJmbWM1NHlnSlRVcHh6UjIzQStwVFFVa1F5NzY4czBLei82ZXhNVmVZRHB3?=
 =?utf-8?B?K3VyaFBqR1QybUl6aGZyU1FQWDI2ZU5pQ3NxTUpjRXEySzVEVEtkMUlXTS9C?=
 =?utf-8?B?UUROWFNGVmJURFVRRkswVDR5c09GQ3paUVd5VlBhcW5qUGlJaUxBYXg4RGo1?=
 =?utf-8?B?cnV1b0gwWFM0NmVaS1RNck9UVUFISVdoMVBOMUdPNVNGOVQ0bjI4TGlLY3NP?=
 =?utf-8?B?YWtlV2JMWjFhN1NoRVF3c1NjOGZ2TnBscHB4YWVERzdrcHVsazdMZ1d3QWpq?=
 =?utf-8?B?UFpIRWg4cHgzWUEyU3c3S2ZyOVdwMFJyWjVpUS83QS8vTmYyazUxMENySGN6?=
 =?utf-8?B?MGUyRjBkZi9HMHFqRk1GUHF6RGE2MEtvTkRHWThQVTFkYk9ydUgwelI2V2tM?=
 =?utf-8?B?U2tOcGx4aERtWklITzBJRkxrRHdPME9SZTRMRDdNOWw3cGR6a0Rkb2haUjhG?=
 =?utf-8?B?ZGpuaFhTV2NCamZqVHlvYllOM1JYVXRXL1RqM3lBTGF3VnRlODJvY3V1UExJ?=
 =?utf-8?B?NlVlcnl6YTMvbGpOZnN6YzlMS0U1NmhnaWUvNlNOSG5CMzJNazJzVmZENUdV?=
 =?utf-8?B?MzVyMW5hM1ordExXN2diWjkrZmVaL1FuMTlaTVZmS0lBVlNCZU4zZ0w4RnhL?=
 =?utf-8?B?ZVpXcGdJdi9SSkNZRUFiOUZ2NXRmZThEOFAwMWVpM2tqRmkwY3Qrb1kyb1BW?=
 =?utf-8?B?cHBBeVdraDZLTDZ3VDRMN2dZOWFTODhxV2VDZEdPOHNQUkFMTnhTNTNnRVhG?=
 =?utf-8?B?dFBxeERyTkx1cGpUL3lYOUttVElWUW5JTmd5cXlVejQ0elY4SVZQSGIrdWFR?=
 =?utf-8?B?YWxGMkI3MWlQN0xHZDZmQ3dWY0dFa1EzYzExa25UOWYya2p1Y29FZDZTdGhz?=
 =?utf-8?B?aitnUGpmc3RiSUt2bjUvR3RSbG5ORkVGU0l3QWpUUEpqZUlGL1lMQ0VwWVFB?=
 =?utf-8?B?NDVXazVDOG1kVkNLb1k0MGVtb25xTjR3L0hjVEp0YVhyeFRnUzIwNnR6cVdY?=
 =?utf-8?B?UDFTWGdBOVhUM0VNSUo5dFo1Zi81Wi9mNzdEcktjRmNOU3ExRnowYVo1MmtT?=
 =?utf-8?B?KzNSKzhvSVJaQXJVU0FtVCtxcjFCOWV1ZElINjBtajJheHF5aDZXdE1Wdi9Y?=
 =?utf-8?B?b2ZWL2RCdmJ4T1NLTEtNNWNaYTNpVE9VUmNPRzZJMUNJOTlYckRZNytpMjhY?=
 =?utf-8?B?ZlB3L1pCVTh6VGJYMnY1b3ZOS1ZzTHNZZUhvSTJZTG1ORllsVTB6L1VEa2FZ?=
 =?utf-8?Q?MXBpWhh5s1ENcaTr6gO6HrOIh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe1df80-63d0-4c25-a3a7-08dd3a4c515c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 18:49:21.4736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpeQnX9ln7VfWWxn9N99Y1uTyNHs3xqwSReru2m38YTpcghVNLQHp0zvbXEqcLZ9n7Dxv8o/7j0RSssMpxzofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109

On 1/16/2025 4:28 PM, Ira Weiny wrote:
> Nathan Fontenot wrote:
>> In order to handle registering hmem devices for SOFT RESERVE reources
>                                                               ^^^^^^^^^
>                                                               resources
> 
>> that are added late in boot update the hmem_register_resource(),
>> hmem_register_device(), and walk_hmem_resources() interfaces.
>>
>> Remove the target_nid arg to hmem_register_resource(). The target nid
>> value is calculated from the resource start address and not used until
>> registering a device for the resource. Move the target nid calculation
>> to hmem_register_device().
>>
>> To allow for registering hmem devices outside of the hmem dax driver
>> probe routine save the dax hmem platform driver during probe. The
>> hmem_register_device() interface can then drop the host and target
>> nid parameters.
>>
>> There should be no functional changes.
>>
>> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
>> ---
>>  drivers/acpi/numa/hmat.c  |  7 ++-----
>>  drivers/dax/hmem/device.c | 14 ++++++--------
>>  drivers/dax/hmem/hmem.c   | 12 ++++++++----
>>  include/linux/dax.h       |  9 ++++-----
>>  4 files changed, 20 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index 1a902a02390f..23d4b3ad6d88 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -857,11 +857,8 @@ static void hmat_register_target_devices(struct memory_target *target)
>>  	if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
>>  		return;
>>  
>> -	for (res = target->memregions.child; res; res = res->sibling) {
>> -		int target_nid = pxm_to_node(target->memory_pxm);
>> -
>> -		hmem_register_resource(target_nid, res);
>> -	}
>> +	for (res = target->memregions.child; res; res = res->sibling)
>> +		hmem_register_resource(res);
>>  }
>>  
>>  static void hmat_register_target(struct memory_target *target)
>> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
>> index f9e1a76a04a9..ae25e08a636f 100644
>> --- a/drivers/dax/hmem/device.c
>> +++ b/drivers/dax/hmem/device.c
>> @@ -17,14 +17,14 @@ static struct resource hmem_active = {
>>  	.flags = IORESOURCE_MEM,
>>  };
>>  
>> -int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
>> +int walk_hmem_resources(walk_hmem_fn fn)
>>  {
>>  	struct resource *res;
>>  	int rc = 0;
>>  
>>  	mutex_lock(&hmem_resource_lock);
>>  	for (res = hmem_active.child; res; res = res->sibling) {
>> -		rc = fn(host, (int) res->desc, res);
>> +		rc = fn(res);
>>  		if (rc)
>>  			break;
>>  	}
>> @@ -33,7 +33,7 @@ int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
>>  }
>>  EXPORT_SYMBOL_GPL(walk_hmem_resources);
>>  
>> -static void __hmem_register_resource(int target_nid, struct resource *res)
>> +static void __hmem_register_resource(struct resource *res)
>>  {
>>  	struct platform_device *pdev;
>>  	struct resource *new;
>> @@ -46,8 +46,6 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
>>  		return;
>>  	}
>>  
>> -	new->desc = target_nid;
>> -
>>  	if (platform_initialized)
>>  		return;
>>  
>> @@ -64,19 +62,19 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
>>  		platform_initialized = true;
>>  }
>>  
>> -void hmem_register_resource(int target_nid, struct resource *res)
>> +void hmem_register_resource(struct resource *res)
>>  {
>>  	if (nohmem)
>>  		return;
>>  
>>  	mutex_lock(&hmem_resource_lock);
>> -	__hmem_register_resource(target_nid, res);
>> +	__hmem_register_resource(res);
>>  	mutex_unlock(&hmem_resource_lock);
>>  }
>>  
>>  static __init int hmem_register_one(struct resource *res, void *data)
>>  {
>> -	hmem_register_resource(phys_to_target_node(res->start), res);
>> +	hmem_register_resource(res);
>>  
>>  	return 0;
>>  }
>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>> index 5e7c53f18491..088f4060d4d5 100644
>> --- a/drivers/dax/hmem/hmem.c
>> +++ b/drivers/dax/hmem/hmem.c
>> @@ -9,6 +9,8 @@
>>  static bool region_idle;
>>  module_param_named(region_idle, region_idle, bool, 0644);
>>  
>> +static struct platform_device *dax_hmem_pdev;
> 
> I don't think you can assume there is only ever 1 hmem platform device.
> 
> hmat_register_target_devices() in particular iterates multiple memory
> regions and will create more than one.
> 
> What am I missing?

You may be correct that there can be more than one hmem platform device.
I was making this change based on a comment from Dan that it may not matter
which platform device these are created against.

I could be wrong in that assumption. If so we'll need to figure lout how to
determine which platform device a soft reserve resource would be created
against when they are added later in boot from a notification by the
srmem notification chain.

-Nathan

> Ira
> 
>> +
>>  static int dax_hmem_probe(struct platform_device *pdev)
>>  {
>>  	unsigned long flags = IORESOURCE_DAX_KMEM;
>> @@ -59,13 +61,13 @@ static void release_hmem(void *pdev)
>>  	platform_device_unregister(pdev);
>>  }
>>  
>> -static int hmem_register_device(struct device *host, int target_nid,
>> -				const struct resource *res)
>> +static int hmem_register_device(const struct resource *res)
>>  {
>> +	struct device *host = &dax_hmem_pdev->dev;
>>  	struct platform_device *pdev;
>>  	struct memregion_info info;
>> +	int target_nid, rc;
>>  	long id;
>> -	int rc;
>>  
>>  	if (IS_ENABLED(CONFIG_CXL_REGION) &&
>>  	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>> @@ -94,6 +96,7 @@ static int hmem_register_device(struct device *host, int target_nid,
>>  		return -ENOMEM;
>>  	}
>>  
>> +	target_nid = phys_to_target_node(res->start);
>>  	pdev->dev.numa_node = numa_map_to_online_node(target_nid);
>>  	info = (struct memregion_info) {
>>  		.target_node = target_nid,
>> @@ -125,7 +128,8 @@ static int hmem_register_device(struct device *host, int target_nid,
>>  
>>  static int dax_hmem_platform_probe(struct platform_device *pdev)
>>  {
>> -	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>> +	dax_hmem_pdev = pdev;
>> +	return walk_hmem_resources(hmem_register_device);
>>  }
>>  
>>  static struct platform_driver dax_hmem_platform_driver = {
>> diff --git a/include/linux/dax.h b/include/linux/dax.h
>> index 9d3e3327af4c..beaa4bcb515c 100644
>> --- a/include/linux/dax.h
>> +++ b/include/linux/dax.h
>> @@ -276,14 +276,13 @@ static inline int dax_mem2blk_err(int err)
>>  }
>>  
>>  #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
>> -void hmem_register_resource(int target_nid, struct resource *r);
>> +void hmem_register_resource(struct resource *r);
>>  #else
>> -static inline void hmem_register_resource(int target_nid, struct resource *r)
>> +static inline void hmem_register_resource(struct resource *r)
>>  {
>>  }
>>  #endif
>>  
>> -typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
>> -			    const struct resource *res);
>> -int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
>> +typedef int (*walk_hmem_fn)(const struct resource *res);
>> +int walk_hmem_resources(walk_hmem_fn fn);
>>  #endif
>> -- 
>> 2.43.0
>>
>>
> 
> 

