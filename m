Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026F1534F7
	for <linux-cxl@vger.kernel.org>; Fri, 13 Dec 2024 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107634; cv=fail; b=VJYcqtY60aFAkbfUfqFkNqdF4e/THbHiV1u/yvSYvpJO/zwp/IluELps6PxJd4pcqdL26IVUCWQeXyF8IxLRQl7UjDEmAvuulAXu2JIrTfStkzqCweLuWEmv4U9VS8gR/7Y4Tkh1JhC+o+yFnonsToArTt4A8laGNNdebaJRiWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107634; c=relaxed/simple;
	bh=8xaahFgIF0mPOFuXVtw4GF4DW8lbjWztB5M/0Ph6nyI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=je9Gf3G5pQp1nRhm/Ebi+7WIkZPPJfUyDCkFGRVITj5j27aldqOisvRYIsFrz9/kCbMku5b8ol+QhdA/kk8Q7G9xruxCw39ZW5uMXEeY5a355yx9Mxi8SlPChkfoCC4WcUbG5lZekRBb0Kr/XERuryaAl20EUyFPJTYTdornjCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tJVGsOgr; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tJVGsOgr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTjnSOpqnvQyH4zn6B87EGydcBu9ggHUUAW5RkGqECFWXwynJVqaq3bYiUPXUSPN5opYWd1HaWPvqTxuqFHdrwmcz4BUPmzlxjGt9npHTdjY2pWMUKUlEKcJsoCDI9AJ958Ip7z6PVBokT8wmf95Rkc+2LrOmoOElNjzyzzmtam065fpfQNqzQV930ajPVhEon/soPeQ4UoxzLwyfZFtWKW2d6kWK/mFU9NDeRTjD8aX0MNCCCrXP+CD9vmAGtvlFU9gXLhxuhmoCNBFMPNxrrwJ7t8RzqhILJr15fyPS3WLPwl8Szs42JZsP1POtOoONjgrBO2Q142CpXYgDpCYTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+ZCxC8wBGsFmMhpTVvD1RV1q69XlU7RxnMQIBtfBaI=;
 b=iySH/jd1gYoO3sWY9NHDzg22wDICIej1OlvxYvSDZVEd64K1welTWWAqG56m3HJbErQPK/xwM9Z/1VlUn/1lxe0ZZqtig+yGqG1ZcLVnXpC+JUb4iD/xpr1Fx4wr6Eq76lalLjjhNLBlNaxCEzYkXbvCQpdVXV5pqDyFHtBcQNhYtzJNRav7Xv7FydWxoFNiQ1owRvrYBWlqShl9gloZRwyIpT+QAlfsrp7m7cXwfculkqS/9rZ7ttNBY4LAznMUOys2hxAgRD6pVsvGcdfTfTOm/sNvWxEvtj74Hb+kqN2xA8eXzWoDIiv+FUW6DQPX3sGELHdSXkVfSab709eRPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+ZCxC8wBGsFmMhpTVvD1RV1q69XlU7RxnMQIBtfBaI=;
 b=tJVGsOgr7O+rX0RZkvjtj4mC4xiq11/9+bZY+sJHbf2fgq3FEQtCQmBzdE7hmH7lZusNA11lKi5Eq8yElWbaLrVGQSqeU7majtKwao0eWVYWJcFagIWJ0eHwp2N+h6mh+WH1Qi7T5WQp0LsNco/MTAxuU32JwRo9k6AJlRqOb5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Fri, 13 Dec
 2024 16:33:49 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%3]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 16:33:49 +0000
Message-ID: <2824f9ae-64e0-4173-a295-a98b7ae46cde@amd.com>
Date: Fri, 13 Dec 2024 10:33:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
To: Alison Schofield <alison.schofield@intel.com>,
 Gregory Price <gourry@gourry.net>
Cc: Nathan Fontenot <nathan.fontenot@amd.com>, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org, linux-mm@kvack.org
References: <20241202155542.22111-1-nathan.fontenot@amd.com>
 <Z1tmwOsAtL-wBR3Y@PC2K9PVX.TheFacebook.com>
 <Z1uHgePW0T81r3xC@aschofie-mobl2.lan>
Content-Language: en-US
From: "Fontenot, Nathan" <nafonten@amd.com>
In-Reply-To: <Z1uHgePW0T81r3xC@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:806:6f::9) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|DS0PR12MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f36697-84a9-4dac-099e-08dd1b93ec2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3BNOGdBY0w5dk5maHcxcEo4NVQwZlBaMGcrOG9NWXFUWStZQ0FyRHF2QjF2?=
 =?utf-8?B?RE9iaWNjZW8rT3BRS1JvektkZFBiT0Rza3hmSEY0RU5vZllyTTRBblVmT2NG?=
 =?utf-8?B?eDdITVA3T1lLSHBEMnFxMU0rY3VIZWo3M0htVjltU2diaUVTR0hNOE45ME9i?=
 =?utf-8?B?ckdOZFlQMC9ITC9TUWNvMHFtZ2wzVmtpTFJZa2JQQzVaelgxeE5DK01ucSti?=
 =?utf-8?B?S09VWi9ianVNOEhCVTlXMmVpcnVYMjMvMW9WZUlEZUU4NkZ6N2xRRmp3OWt6?=
 =?utf-8?B?d0xkMlptTE9IUjFyVHFQN2pyeTh0NzkwRjRZVFF1L1cwV2dtTEsreGhjREta?=
 =?utf-8?B?WXdwcGVQak0yNFR6UnN5VFFJaU5EL0F1UW1zMUw1aTNld1lwSHZOVzJycXZj?=
 =?utf-8?B?RThOdnFUOTRtNzZYbEhLOHlJVWttR2YyOTBBQm5YV202ZCtOMXd6VzVlbDdM?=
 =?utf-8?B?REZ6RjlTYis0MUlwNXhYUlR4eDRNclBzVGVtZitZc2EwbGs5QUNJUW9oU2sx?=
 =?utf-8?B?bXFod0pTNEdsZkRwN2ZpRVFJY3RJZjRJeGQ3MnVqZlhFTENKRmp4YXVOMU02?=
 =?utf-8?B?bXhHOWRlQUVueUpYNG54M0RSU2MyL0E1UlZtQzhscTU4ci8xQTdtOEI4R1cy?=
 =?utf-8?B?QTEzUjdXUWhSUnJoK3NjYUJFbTE2a09KaklFSUszT3JQaTBJNncvUm5DMDA4?=
 =?utf-8?B?Z1hiY2VjNGlSTGRZaGVaSXZLUG1JRzJKaUNENHVKeThDenlSTEM3dFJvRnVJ?=
 =?utf-8?B?Vjg0N2xtOElXRmh2aFVqRlR6VzZueVFaVlV5SmxyOE5DWmkzK1R2MWNiSVRz?=
 =?utf-8?B?TFNHRFFvY3pFN3g3SGw3czhsY1Y4ays1SXlHSGQ3VGJHY1hxLzcrTnBTcEV5?=
 =?utf-8?B?T0oyVXBUcUxOUUdINzZYeTIvZDc1MitaeDhhUmNYOFJpNHZ2aStidlVDWnY0?=
 =?utf-8?B?Y3pCbVJta2R6cjc0YWF5eTNJZHRTNXlWcHpQK0srY3V6bjJMOFZpNk5lYjhl?=
 =?utf-8?B?UDM1d2ljM2ZZd3NhRlBGeFN3a1BXMkgvbWRxT1pHMUtFUmlEbkFscjQxK2po?=
 =?utf-8?B?V2JnNDdGRFhzRDBZYlVxakVvM1p2VUYya1hqRGhpcndYalpkSGhyd3g4NFEw?=
 =?utf-8?B?Mnk3U3Z6UENuYUxDbm1KM0NOOFRLa2FWWGIyZ3hOTW1LWW5wcFhSRERqNE1E?=
 =?utf-8?B?MGVPZnUzM1AxeE5aeXY1YXN6S21oUVNvNm9ZSEx2ckhwYmRuSEpGcEJsTVc2?=
 =?utf-8?B?WHZ1eWxQMm1BWmFDT3pTTmxDYkJvMkU5b3JMTEQ2ajUrd0lZenRETXF2NmRI?=
 =?utf-8?B?amdzR2tkMndkU2N4Rm13d0d1U2ZpYnBXNkJjZ0k3V2hYbGE1Z2pXZ2lwdy9P?=
 =?utf-8?B?ckJBZjl4S3g2dzZ5Y3RrY3luMjdORjFtMFd5N1ppekh4QVAyMkVPdlZNdU1P?=
 =?utf-8?B?dG1WYmRab2pMTDVVVEhEU0tNcERodkluMEhBWnFkOTRqWFpjT01ZYVpXTmM0?=
 =?utf-8?B?RE9NSmU0RU5ZYkpQUEF5OFhDb2ZzNzJaTmp3NzlFRlZCc1h0T2lMZEI2OUpu?=
 =?utf-8?B?ajM5NkpOczV4N0g0UEdyd2UzL2QvSk9nSFdaZk9wWnpRNDMwaHV4dXMzYW90?=
 =?utf-8?B?SUh2RC9LMXltaE0wZE8rODlONlFTTVhKekZDcFY5dE1FYkJBR3kzTllZUFp1?=
 =?utf-8?B?VXdFaW8xek16bWxkdGJEdzc0TmE4L0RFdXFKdXlBTUlZb0tQOU8rUkNTeER3?=
 =?utf-8?B?Nzc2K1ZwM0F3RGpkMUZkeXdsUEFLVkE4L1RoYzlUMWo4cFdBd2JsOHhtWFo0?=
 =?utf-8?B?WnVDd2tsRWJuak10cWwwQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVlRTU4wQ3BXN2lmUXdaS3JkMTJFcFFFNUZuZmJOeDlHNXZlTUFJZjF1YTgr?=
 =?utf-8?B?NHJvNHRQaUZDVmJWcFZKby9IVS8yMWk3Y1VoZy9jd0xnRllZUDhQaWhFOXlx?=
 =?utf-8?B?YVNPcVJyK2FXSnNCbkNqdlZjbG81VkpCQ2w4SCt6Z0VOUWF1RmI4USt5YkpN?=
 =?utf-8?B?elhVTHc3T0tjRjgvRTZTWUJxdWFWUTVUaXhzdWN0WUdJcmE5cm1qRXNTenRw?=
 =?utf-8?B?VDMzcFU3WGt5WFpRbUZrclNtS1h6QnJLS3doK2tSajkxQ2g5ZzZ0WnhyVlNh?=
 =?utf-8?B?WFU2cXRPdEFiZ2ZHeTNHdW9lb2xvdTlBaXJUYzVSV1lzQ0g3ZGpRcUlIRUM2?=
 =?utf-8?B?Yit1dWdReUtxdVlRRmlYNThzMkZWY2JnYmZHSVhPdE9wYzBPOVBNS09YNUpR?=
 =?utf-8?B?TjZPZFBMWUdzdTF5b1FUaVJWUzdjTmhVSXdaN3BySGZWNnk4ZTJ0K1ZYNHdt?=
 =?utf-8?B?QUx6a0RaUktqbFlISjFYUGJGTVd2SnphNUhsK0gyUXIycjRyV1htT0pyMlZ2?=
 =?utf-8?B?QUhmWGNCaTJCYmhqUkY0eXlzRHRFdlpyNzZ2UUtKNnY4T0RkSmZJamlUdzZT?=
 =?utf-8?B?QzFZWjFacE1XejNJNU9tN2phTEwvZjN3M0U0cUFwNmd1Q1pPbnBTVGxUVDBM?=
 =?utf-8?B?U1Yzekx4b2oxQmFCcnZhaWJNajU0VElpLzR0SkJOZlFjcU9vcGUzSGRHaDlS?=
 =?utf-8?B?aFVOV3l1TXN4T1RZanYvYjZFbTU0MDRnSjRkc1B2eGY4bG9UUGRhcnRTVm1I?=
 =?utf-8?B?M3ROcmZyLzFVc2x3bVlTVFppWVJ3c1plM1NhV21CZVRyb25IT25sNndXSm9L?=
 =?utf-8?B?T2lGclVibXJmMVY1T0o0b1JpWjEzblYrbjRZTk1qYXEvNndrdEFSUXV1c3RP?=
 =?utf-8?B?d1R4cGJXeERIT1BBcFNYNDJRQkkyazVXak04aTRadUlSUkM4bnNlQkNiOVB1?=
 =?utf-8?B?RFNjOHhRUVlHa0FnaFBqR1VBUVFpOUp4bEQrb2lrUG84UnVDZ2hsT1dIdDVJ?=
 =?utf-8?B?MjExL080WVBwNVdJUzVzVEF1V2hjT2JoTUV0TGdkVTV2a0tzVlJwa0xCTm5o?=
 =?utf-8?B?aDJjNkxDWXZsZFhlZi9CWTU5ejBNVGY3V3JtRHQzZDVyS1paejYzelhDc0xO?=
 =?utf-8?B?U0tTSlBGaHVWb3htK09QRDJRTFYzNkZ3ZllGSjNsYUx3ZU9uSWtIczdieEht?=
 =?utf-8?B?TVNjK0hzZ1d1d0Z4TGFqMjNFOCs2U3lJN2xvaC9pNTlwN0FXdysvR2laSnk5?=
 =?utf-8?B?U0lkalcvV2kzSUZ4V1EyOE1oUXRoamM3QWpvYUw3MldKVjFvV1I5Y3Flcnpp?=
 =?utf-8?B?OVQ1VXB3YUlQR2Rzb2xUQnFjZ0k1NmVjZDRPcld4WHU4Q01HYTJaYVhpdTJQ?=
 =?utf-8?B?OC9BREtDWXVabzJadjJIOWY4OGxSMzNDWlRMWDhranYwaUhIbytjU2wvUFdW?=
 =?utf-8?B?cWJQZE1kZm1YcFFKNUxRMlRldm5QMFF1clFNeHF1ekcrWTZSRnJ0a0o1a1RB?=
 =?utf-8?B?THBHWlVHZHk5bG9nMC9DSm1VNmlOWGp2b0UvQkVDYWxLUTZIeFRERmJmM3RQ?=
 =?utf-8?B?c1VLN2twL1lzSEhaNFd4R1RTbGp6NytHUGtyV0NWaGtRMlhtUldieUJzNmFJ?=
 =?utf-8?B?OXFmMytNZC9Wais3U3hVYXpXRzJLQzY4cEpHSHo3SnNRbEZPaXRPNGNaZi9B?=
 =?utf-8?B?VGgxQjJ1QkVpcm13d3RVL1lDK2ZBcVVrUDU2MWdSc3hZL2svN2gxTElQa3VI?=
 =?utf-8?B?QWdaSGlCempxTGVBWXJYWWd4SVM2NkpwZWRpczlhZGduS1RSeXFaZ0MzT3hw?=
 =?utf-8?B?VGF0M3JnNW85VDM1SlZtMzg2b3ZwSXIxUTkzcFZFTm84c0tnWWw1ZlBkallh?=
 =?utf-8?B?eGlHb1Z5T1BmY1FZb3FWWGhDVWRWSG5BM0JjeXJHVzVEODlweHpZQXFEcVk1?=
 =?utf-8?B?cXdQbmFjd3FFOSt1d1o4SnFsVWxtSTliTXBPV2hZQ2FqbjI2T2JuM3pVOFFJ?=
 =?utf-8?B?RUFDNjdEaUhaNTdyK2tMYW02RHhndzlMZXNidVJndUZYekw0VzQ4MDBEWkcw?=
 =?utf-8?B?Z0lMbnpXS0hOeGZRaWZuTk9yK29iRHRucjVDUlZOMVUzOEFOSnlFU1prakxM?=
 =?utf-8?Q?VjC4zyqExSTXxRTpYqW5Vt3t8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f36697-84a9-4dac-099e-08dd1b93ec2e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 16:33:49.4389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAQGiUvSfO1GfB/nkDE1F0uOEpBjJudaBYuEV0gUfrFn5EfnGge65DfodhZUnN9CWZMRUb1bxHh/sFsi6nZvDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218



On 12/12/2024 7:01 PM, Alison Schofield wrote:
> On Thu, Dec 12, 2024 at 05:42:08PM -0500, Gregory Price wrote:
>> On Mon, Dec 02, 2024 at 09:55:42AM -0600, Nathan Fontenot wrote:
>> ... snip ...
>>> diff --git a/kernel/resource.c b/kernel/resource.c
>>> index a83040fde236..8fc4121a1887 100644
>>> --- a/kernel/resource.c
>>> +++ b/kernel/resource.c
>> ... snip ...
>>> +static int srmem_parse_cfmws(union acpi_subtable_headers *hdr,
>>> +			     void *arg, const unsigned long unused)
>>> +{
>>
>> Chiming in a little late to the party here
>>
>> I don't think encoding CXL-specific terminology and functionality
>> directly into kernel/resource.c is wise by any measure.
>>
>> The abstraction here is completely inverted, and this is probably
>> in line with Dan's comments.
>>
>> The comments in e820.c allude to a similar issue
>>
>>     * Prior to inserting SOFT_RESERVED resources we want to check
>>     * for an intersection with potential CXL resources.
>>
>> This is similarly inverted - e820 doesn't know anthing about CXL
>> and it shouldn't have to be made aware of CXL. Mucking with
>> e820 is *begging* to be bitten elsewhere in parts of the system
>> that depend on it to be a relatively stable source of truth.
>>
>>
>> This tells me that this patch is trying to solve the wrong problem.
>>
>>
>> Your changelog alludes to supporting hotplug replace
>>
>> """
>>   The current approach of leaving the SOFT RESERVE resource as is can
>>   cause failure during hotplug replace of CXL devices because the 
>>   resource is not available for reuse after teardown of the CXL device.
>> """
>>
>> It sounds like we should be making the SR resource available for
>> re-use through proper teardown and cleanup of the resource tree,
>> rather than trying to change fundamental components like e820.
>>
>> If the driver was capable of using the SOFT_RESERVED region on
>> initial setup, it should be capable of re-using that region.
>>
>>
>> Is the issue here that the hotplug-replaced component has a
>> different capacity? It it being assigned a new region entirely?
>> Is it exactly the same, but the resource isn't being cleaned up?
>>
>> Can you provide more specifics about the exact hotplug interaction
>> that is happening? That might help understand the issue a bit better.
>>
>>
>> Much of this sounds like we need additional better tear-down
>> management and possibly additional cxl/acpi features to handle 
>> hotplug of these devices - rather than changing resource.c.
> 
> Hi Gregory,
> 
> Never too late, and it serves to revisit and remember to carry
> along some of the why behind this patch as we adopt it to do more.
> Admittedly, the more, has also become the more important here!
> 
> I'm not sure what Nathan first saw that led him to this issue.
> For me it was - 
> 
> BIOS labels a resource Soft Reserved and programs a region using
> that range. Later, the existing cxl path to destroy that region
> does not free up that Soft Reserved range. Users cannot create
> another region in it's place. Resource lost. We considered simply
> removing soft reserved resources on region teardown, and you can
> probably find a patches on lore doing just that.

Yes, this is the same problem I was seeing and looking to solve.

> 
> But - the problem grew. Sometimes BIOS creates an SR that is not
> aligned with the region they go on to program. Stranded resources.
> That's where the trim and give to DAX path originated.
> 
> But - the problem grew. Sometimes the CXL driver fails to enumerate
> that BIOS defined region. More stranded resources. Let's find those
> too and give them to DAX. This is something we are seeing in the
> wild now and why Dan raised its priority.
> 
> Dan is also suggesting that at that last event - failure to enumerate
> a BIOS defined region, we tear down the entire ACPI0017 toplogy
> and give everything to DAX.
> 
> What Dan called, "the minimum requirement": all Soft Reserved ranges
> end up as dax-devices sounds like the right guideline moving forward.
> 
> Hope that answers some of your why questions about the SR reuse.
>

Thanks for the summery on where the patch started and where we're
currently at. I think it will help everyone.
 
> It seems the worst problem, failure to enumerate a region, kind of
> drives the solution now, and we should handle the soft reserveds
> all the same. Even if Nathan doesn't implement it in one final
> sweep through the Soft Reserveds, one way or another, those SR
> ranges must end up as dax-device resources - either CXL managed
> or BIOS Soft Reserved.
> 

This leads us to how to design the handling of soft reserves from
a larger system wide perspective, not just the CXL specific focus
I have come at this with in my patches.

If we start with setting aside soft reserved resources on a separate
list from iomem resources at boot, we could then let drivers use that
to either remove pieces that the driver uses and release unused pieces
to the iomem tree. One thing to consider when setting aside soft reserves
is when to do it. If CXL isn't configured we don't want to set these
aside, Dan mentioned a possible config option to control this.

For CXL, I think the approach Dan is asking for is to wait for CXL
probe to complete and the walk through all created regions and remove
the intersecting pieces from the soft reserves. Any soft reserves
remaining could then be released and used as dax devices. Dan, please
correct me if I got that wrong.

-Nathan

> --Alison
> 
>>
>>
>> ~Gregory
>>
>>> +	struct acpi_cedt_cfmws *cfmws;
>>> +	struct srmem_arg *args = arg;
>>> +	struct resource cfmws_res;
>>> +	struct resource *res;
>>> +
>>> +	res = args->res;
>>> +
>>> +	cfmws = (struct acpi_cedt_cfmws *)hdr;
>>> +	cfmws_res = DEFINE_RES_MEM(cfmws->base_hpa,
>>> +				   cfmws->base_hpa + cfmws->window_size);
>>> +
>>> +	if (resource_overlaps(&cfmws_res, res)) {
>>> +		args->overlaps += 1;
>>> +		return 1;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static bool resource_overlaps_cfmws(struct resource *res)
>>> +{
>>> +	struct srmem_arg arg = {
>>> +		.res = res,
>>> +		.overlaps = 0
>>> +	};
>>> +
>>> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, srmem_parse_cfmws, &arg);
>>> +
>>> +	if (arg.overlaps)
>>> +		return true;
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +int insert_soft_reserve_resource(struct resource *res)
>>> +{
>>> +	if (resource_overlaps_cfmws(res)) {
>>> +		pr_info("Reserving Soft Reserve %pr\n", res);
>>> +		return insert_resource(&srmem_resource, res);
>>> +	}
>>> +
>>> +	return insert_resource(&iomem_resource, res);
>>> +}
>>> +EXPORT_SYMBOL(insert_soft_reserve_resource);
>>> +
>>>  static void __init
>>>  __reserve_region_with_split(struct resource *root, resource_size_t start,
>>>  			    resource_size_t end, const char *name)
>>> -- 
>>> 2.43.0
>>>

