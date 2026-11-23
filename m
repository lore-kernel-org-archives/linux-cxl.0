Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795438406;
	b=DLqIzZKanTu2U+KizztkI7EjYyrXpiwSuH5iG4mYJ7ytMO4ZtPGQLZvfgmb/1cmdeU9l
	 1Hhu/4r72dL6Muj9gX9il3Bai3Erb4JNs6Sn6k7dWR1QQ5k/9OVtjoqL4PFL6U9ZbxSX+
	 i9Zhi2jUsp+PcfC/w5gcFW+qGyvuD61GLELyd9SjgTGxcPXptDkloCZExLuSZNHfB5Nrv
	 1m0Fphsfk/QKrMAGiDCxuX2yoEwv1Jj7Q3JmF/iqnqWpx1qh7eEqVLQ6ZS7lDBwTuRL3B
	 5QMmjq5cQrANG6+u1H1LtBrK0SXu6WESdIrTh6wddokIKQTIg4Fm0miwZhl/alhlI9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438406;
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
	bh=ix5u0l2NQ6bnvvD6fw31RLQldhX1eJyTGBv1HmaAeE8=;
	b=ZzKbynCsEr7D9i2s7Yk15M5X0Zmu3CXlmO245NhKV2X0HTvBITMtoSK4KrR/014O2JI8
	 Qb4wp1RkseJD22HDjFCqKfpiZwbh3jA2BMapc0H36arClp8juOCWi6BWGBteP+CggAbxw
	 LbkfcSIJWIW3eZIgi9YMcc3zJ8GhfiImdqXC4lcV1FqmbvntKvRxlKZQS6TfCABBbU46W
	 dBO+kEzBVkSJdnbV4JMxgJ1hGDIma3lQxUOL/ZRdaCUZIGHqs4+S5lfogL/i5KlMdMAm2
	 JkAkRRQs6ks6biWj4XxYlTDfUh3QcFx1MaVc15YM2LqCqQNVb1+1L9BNadnGsSBQZNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uXYZp6J0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.23
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2ED606A31F
	for <linux-cxl@vger.kernel.org>; Mon, 23 Nov 2026 12:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B2ED606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uXYZp6J0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUX4k0l7gWuUb+Tyx/d/Ao0VDyOEbI8NPLHPyAZpNbxHtravQN7y2Nt1Mo7M1wnFQhst3KqDB4PG9yQQCneK0YnShRHyoI4j2kIGh9bH8hP1YjZcUNsShUK7epJWPolV/YjPBDXXvs3MoBzB5DGsuTDvmCMrGHbbQLt9HtGB55h2PHaM5RyHA+OTUJUXKO72Ivc9DqiMxsvXJLlw2AvBf36laEI890PNY1UKqRjTPZOyOaZCnj5hAMhCQAq4tW1rLwvvkDlcRdcrQ2RUuYKJXRs2VT/82y6n8UtflDtpBBiTPWt66c78XBlrtLIpS/BsiU8JHCEoWy87UmYPqOtJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ix5u0l2NQ6bnvvD6fw31RLQldhX1eJyTGBv1HmaAeE8=;
 b=HoJ51I8vwPNKaT1ob6W5e7elIfzj8IxBpMfB5ex61PILUTd3cx2vXspMvbKmMAkrD9i8/Tqs/4KkAgS/cluIk8b+tqW4wkwGjz1DoiH82hHWB9oGw7SyUBb/Fr1DItulcsJH0spqk3+w8C4KK9HRX3/kcuq2AIe9s3MphVS47AZq4XW08Gtwh/oKMgpVeMPUcgirSHFmTVaAclXJKaH+7h1DMU2XGjzqKrQDFCGva9yWvoXUOQxRkzXPtJuSBQdFwRuNsHqtb/LsgqW+5wrHuUGCAZeutWKXwt09Df/ZJp3woJ9WtScG7MigJuKkTawZmwArZEhr4fFz9PHg4R7qhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix5u0l2NQ6bnvvD6fw31RLQldhX1eJyTGBv1HmaAeE8=;
 b=uXYZp6J0t87b8Wj2YWMDhl3DR3wc8uPStQqDYgrSWXWR9VqmYpg1Hms6S6277aWVPpRpQL3jcgz3grBytL321kPvJuZyeNmo1T4tO5QEVuDrC4E8pWKNA1eN4n63Hq27Ab/KN6/Y6XoKWA/cuRB4VkKtnUwgt+Wll1O4Hh2n0Cw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.14; Mon, 23 Nov 2026 12:53:22 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 12:53:22 +0000
Message-ID: <3fabb5c9-68ae-40e7-ba02-c22d91eaf1c4@amd.com>
Date: Mon, 23 Nov 2026 12:53:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Type2 unwinding ordering change
To: Dave Jiang <dave.jiang@intel.com>, alucerop@amd.com,
 linux-cxl@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20261118191431.21781-1-alucerop@amd.com>
 <58fdf73a-a33a-44fa-bd35-a9610624d3b3@intel.com>
 <c887f9e4-7636-49fa-86cf-152bdf76c13a@amd.com>
 <ce29f556-6e04-4041-a9d4-255fd54c3389@intel.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <ce29f556-6e04-4041-a9d4-255fd54c3389@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::13) To DM4PR12MB6254.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ccaf869-ed5e-4b34-c486-08df4960c162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|5023799004|11063799006|4143699003|56012099006|10067099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	z+6S9LERl2aYqH5aqHdkDKZjrP2rwtJit2mGxIc+1pG49MiI/G9qPQ0tfPkdG7w0R044cnaWSK1O2mnWJOyepy1n0saKQT/d6NKXNmTDzyhaMjKJ+XRfJ8kzeMeKdCN9M3renN6E+xIbeP4riOLnIfrlh3Zu/lA7oU22lli6Qhi8rTilou+RRa1Bo2CuXhL+DjCw7ySW5qIHuy1GzfSo/pBqacWnfJso34Va64eSTCX0CTAROW1h+A3ZORHc3+8OKMf6iaNmJzwswiek+sDkwydgobMo3hBF55otY6TJNHx/X3UsdYtsobeCOXS7F3E1u8ZgpIohIfr5njVcchWP98QzKQp2CKXUw1c8b06Z2NRfoI1ichYlog6jDM0RTWyo9MxwR3HkyUUpebQCrAY0CJYeSsBviHDlq8XHv7NM3Loy7oqqV0UdGtuxVeAIl5XLf4g2D3cnWQNI6wD+kCjIY5B0aTCHzAEm7BhZMRyPAozOs4O2A8xpoggZ/QYGjRF1Pw5mrPzB/SKm+m/OoiqVaVM6LkTN+udFzndws9ZhA8Lxi8fYqfY+f2aMCDvOkvEccqocLsu6reXKQw7yRsd5+RUttzWR5cF0pdrzbtqoD2/ShCWBQqJ2tQ5AyTwi5B90
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3NCV0E2cnN0VFZvQzRxV054S3QyWk9acjZIaWdPaTF3T0NwWkNSYktZRE14?=
 =?utf-8?B?Q3crMkpvZnVKU3dtZy9GQXF1eTRVZ09oMXc4VHRUSEhjUEV2eFlxRnJVdkYv?=
 =?utf-8?B?SFN6alhUS1ZtUHpTYnlYNGtLL1M3Z2xUQlp0QlVoM2VyK1B6OGZZR0R3YXI0?=
 =?utf-8?B?UmVoMWhzZ3FXZEpId2RBSi9VTDdZUFd4SHUxZjdXVUtZYXAvNm83bGErc29B?=
 =?utf-8?B?ODVoSjdvbE9WTjRkV3Iyc3hmcVZDSENTdFdFbFVEREZPRG9ZTmN4cWdTUjJZ?=
 =?utf-8?B?M2I5MXo4cmZGUFdRdnVxd1hMS0t6NEVTVGdGR0Y1TzE5NmtXZFRXelh3ck9z?=
 =?utf-8?B?U05Jall6YVpacmVDVStneTl1MmFRTkVTMTh0QUxKSTdNYU8wdTJRSVpuZ1Fs?=
 =?utf-8?B?a0lUZTVGMEx0VW53dCtYN2NFU2dadkJIWGNQdmNTazRidlh4cEpJQksyZlBF?=
 =?utf-8?B?ZU1zaVpJR2lDNjlDNzFNRDYzZGN0WnlDZFFnZ3Nld25tMVBtNkFxbTFGb3J2?=
 =?utf-8?B?OFVFNk95TzNsSVZza2ZuU2tNamgyckVydk0xWTBLeEVnSVRyVUllaDgrUFR3?=
 =?utf-8?B?SHUxZjhGY2NUOXpYeHpiRC9xUlIzc0Y3d29nWnJmM1FPemhKakh5MkQ1UzZr?=
 =?utf-8?B?KzZ0Y21lTnNLanBsK2d1NHJaaXNteXh0SlcvNFFVbFV6V3ZydFIyZVJHY3l4?=
 =?utf-8?B?aXpYaW94K1cxWTNNMWhHN3oxZndrK1RLdEREYkhyeFJpRmNPUlU1SkkweFV0?=
 =?utf-8?B?MFdUUks4YTBVUjI1WUp6QXMrSnFuVHZjbWhYMmxkMzhsMGpBaHF1eERDUlBu?=
 =?utf-8?B?R212ZGtSZ2tGZWRyck1wZzBGS0syT0JOT2M0OCt2d0J1Q296TWZRYUN3ZUdG?=
 =?utf-8?B?SFpBekM3V2VRUEwycEp2dEhEbHBCUzVaNnlSSWwyS3ZsQ2NaQklibzhaVkZx?=
 =?utf-8?B?K0hwMmhYV2E2VlhpSm5Hc0kxWm9yemMxSUhOakJ1OXNUS1hiWnFkc2ZFS3pJ?=
 =?utf-8?B?dWdRUVJ2dGhNVmgvemlQOEszQmpZTFBKaUEwTkpNK2NUbFU2dzlnOEFncjZL?=
 =?utf-8?B?UDJBblFqUmRNK0phZ2RKb0RkVUZDU0Z1dHhpV2FDMDFCc3U4ejFYMFVmdXBF?=
 =?utf-8?B?YzZVd09kQ0RCTk9EOWpwKzhXaHFyNmpyRU9xYnJrTUdGQzYvNEM2WnNOVmhG?=
 =?utf-8?B?bWl0NGFtaWhNNkRDVFF2MlBaT2VuOUhPbE1FR2Y2Si8rNGEzYzBTWGVQb3NG?=
 =?utf-8?B?bmtjL0ptTUswUHR0TGlGdmhoSmk4aGVMUnlNUTNuaFM5U2pFRkFMNGwzaGt5?=
 =?utf-8?B?TVM4bkhtOGQ4aHU4c1Vua09SdDhEMVoyRUl4cFJyMDRqRk9xQ09uRkQyVjNP?=
 =?utf-8?B?NmFLd2FyeVFZWnJTQTJzT01SeE1DbW1PcGJtTnlsS09TQXQ0T3p1ZklEVTc0?=
 =?utf-8?B?L09nMzZqY0x5U0ZTNmthUjhudmFIMFRTaTNTamcyV3lPR0pOem5kYTNybnpV?=
 =?utf-8?B?eWNQNHkwZUtMbkFBbVE5aGJkbGluODdNNjkvMEpwOGFxc3prR0lEQXZsVEdY?=
 =?utf-8?B?Qk4xZm1sNmVQclE3Zi9kTGJvNHBEaWl3NW9tbWt0dkhpQkZqRlljYkY2aU1w?=
 =?utf-8?B?MVVEd2djL2doU3ZsVG5nMVo4aDFUMXRFRFhlL1hLczZiMnphdjdhTHpGWFdB?=
 =?utf-8?B?eFZCeE0waGFBVTZBdUp5Z0lPL3FNbWIwd0NJTFNDQUx2Wm1pdS8zVWQ4dEZR?=
 =?utf-8?B?QyttaGdoZGR6cU05c3Q4a1RFeXNITldEWEFjUm0yb0xwaEp4SjBrQW9oTkYw?=
 =?utf-8?B?OUwyRDVKYjhoeXR6c0Ftb2YwR2JTTWpoTW9jbkN0RmJMVWhiWEpiajdUZkt5?=
 =?utf-8?B?UWpwRTR4cEdPN0lTM3J4VlFza3ZnbVpjSEdxWWlCN3dhbGFYRjM5NldBV1FU?=
 =?utf-8?B?ZjR5Wi90SHJudGFONzRmUFJYOFdkZVBYZHpSZDJvS01uN2FpQ3lzanNzVGx4?=
 =?utf-8?B?dVB3ZWtRU1pvTlZGblg4ejdOSHg5bHV5aVZIaVdrZlB6STl5anYyU0hhaFhs?=
 =?utf-8?B?OWNDMkM2ajFZUk4rSUFyZ2orUVFoNVE1dGFsdDdQVkRZaG5FRHk1OVNhK0Jw?=
 =?utf-8?B?NExNeEhuV1Y2YmdUWnZnRldLa1UvbUlUd3lOLytwenZEakpnNFBkUmdsK0Ni?=
 =?utf-8?B?dFYzQmtRUFR0U0xiaEVXZ1VEL1BCMC80aDY3aXk4OFl4NlJHVHpRQk12QjZQ?=
 =?utf-8?B?R0lneGt5dis3alJmWGF5cXRyRHlHbVBJdXV6aG8zUFBFRTN0RGNhWXhYN1hx?=
 =?utf-8?B?a0l0eHM4bUg0QVJuUHlpNGpKMjRqZ0lUZW04Ti8rYUh1dTMzUXI5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccaf869-ed5e-4b34-c486-08df4960c162
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 12:53:22.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xL1TeVN3kqKkgceEzolVlaFU6voF0/VKcKzhGJngvGxH3IthXheK3I0gwFre09HIsw8G+YaYkoCv9PhK3F90/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927


On 20/11/2026 23:54, Dave Jiang wrote:
>
> On 11/19/26 1:13 AM, Lucero Palau, Alejandro wrote:
>> On 18/11/2026 23:39, Dave Jiang wrote:
>>> On 11/18/26 12:14 PM, alucerop@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>>

<snip>


> I don't think removing the driver first can be made to work for every trigger. I ran your RFC with both fixes on QEMU, with the cxl-type2
> device from Manish's RFC and a small test driver. With accel, memdev, endpoint and port unbind, region unbind and PCI removal, the driver's
> remove() still finds its HPA under the region. With region deletion and with cxl_acpi unbind or rmmod, it finds the HPA no longer reserved by a region.


Not sure I understand this, but if so, your results are like mine except 
the region deletion case, but not sure what you mean with it as you say 
region unbind works with the type2 driver exiting first. I know there is 
an issue with cxl_acpi removal what I'll try to address before a 
potential new version of my approach.


>
> Region deletion holds regions_lock and calls unregister_region() with the driver still bound. The driver's teardown needs regions_lock too, so it can't run first there. Dan made the same point in the v17 thread [1]: "The difficult part about that is that the remove path for regions and CXL ports hold locks that prevent the accelerator remove path from running."


Right. And this points to the complexity I refer to ...


> On cxl_acpi unbind, the CXL window is already gone when remove() runs. endpoint_unregister_region() then drops the last root decoder reference while holding its regions_lock, and the mutex debug code warns in mutex_destroy().
>
> Skipping autoremove for every DEVMEM decoder also leaks the ones the driver doesn't own. The committed host bridge decoder was never
> unregistered on any trigger I ran, and its port was never released.
>
> I'm trying a different approach based on Dan's guidance. It doesn't try to order the teardown. It works whichever runs first, the region
> teardown or the driver's remove().


... and your approach, IMO, does not help for reducing it adding this 
new defunct state. I say in the cover letter that there could be other 
solutions and you probed it, but the changes this approach needs are not 
trivial. Compare it to the changes I introduced in patch 2, as the other 
patches are traces and doc. And if mine works (addressing current 
issues) multipf support comes easily.


Let me just study yours with more detail and try with the mocking you 
rely on. It is something I wanted to master and this is the right time 
for understanding your results and hopefully help in the future with 
this testing code.


And thank you for taking the time looking at this issue.


>
> When a region goes away while its Type2 driver is still bound, the region goes defunct. The region device and its targets go away as
> before, but the HPA stays reserved and the driver detach is scheduled. The HPA is released when the last user detaches. Dan's reply [1] expects this: "a region can go into a defunct state if someone triggers removal actions in the wrong order".
>
> The decoders stay programmed, since attach regions are CXL_REGION_F_LOCK. So the HPA keeps decoding to the device at least until the driver's remove() returns. It needs no driver callback.
>
> On "all-right-state or no state", the driver uses the HPA after probe, and it stays valid until remove() returns. While the region is defunct, a new user gets -EPROBE_DEFER. While a Type2 driver owns the region, writes to targetN and size return -EBUSY.
>
> For multi-PF I dropped the device link. With the other functions as consumers of the region, deleting the region unbinds them from
> device_del(). If a function is still probing, device_links_unbind_consumers() calls wait_for_device_probe(), which waits for every probe in flight. Region deletion runs with regions_lock and port locks held, or from PF0's own failing probe.
>
> I hit three hangs under cxl_test. With your v2, cxl_get_range_and_link() takes PF0's device lock, and region deletion during PF0's unbind waits for that function's probe.
>
> With the lookup fixed, PF0's probe can fail after devm_cxl_probe_mem() while another function is still probing, and the teardown ends up
> waiting on PF0's own probe. A memdev unbind can also wait while holding the host bridge port lock, while a second accelerator probing on the same host bridge needs that lock.
>
> Working around them inside the link scheme got worse. A trylock on PF0 avoided the first hang, but left functions stuck in deferred probe in 2 of 6 loads. Linking while the region was unbinding hit WARNs in device_links_driver_bound() and device_links_driver_cleanup(). Avoiding those meant checking the region's dev->links.status from CXL code.
>
> Instead, devm_cxl_add_region_user() registers the function as a user of PF0's region and returns the HPA. I renamed it from
> cxl_get_range_and_link() since there's no link anymore. On success, the only CXL lock it takes is the memdev's attach_lock. When the region goes away, each function gets its own async detach.
>
> It returns -EPROBE_DEFER while PF0 is still probing or its region is going away, and -ENODEV if PF0 is bound without CXL. PF0 still reads as bound while it unbinds, so a function probing then gets -ENODEV too.
>
> I think this is better than the link. Nothing waits for a probe while CXL locks are held, and all three hang tests pass. PF0 and the other
> functions follow the same rule. The HPA stays reserved until the last of them detaches, in any order. It also needs nothing from the driver core.
>
> I tested everything with cxl_test and on QEMU with Manish's type2 RFC and a small type2 test driver. On QEMU, dummy PCI devices at functions 1 and 2 of the Type2's slot act as the other functions, and a Type3 bound to the test driver stands in for a second accelerator on the same host bridge. The sfc patches are build tested only.
>
> The branch is at [2]. Please take a look and let me know what you think.
>
> [1]: https://lore.kernel.org/linux-cxl/6892325deccdb_55f09100fb@dwillia2-xfh.jf.intel.com.notmuch/
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=type2-revoke2
>
> DJ
