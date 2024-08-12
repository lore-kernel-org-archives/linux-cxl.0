Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AA214EC53;
	Mon, 12 Aug 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463724; cv=fail; b=YNEx0I6bh8N3HxvbpqjnP8DkLbu5agkbDE28KqGIeqeG9da18O8H+SOiwGKZ0fGVG0941NKxyhazq64RY004UW9YytA7PQq5rKbu6JmJCJDesbOUY1tV8Ha3sH50uM2H+Xo4ZNm6c81WoPFNSoY4IKVKUF6HloqBRQRDLQ4gesU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463724; c=relaxed/simple;
	bh=+YCYjaX5glB70OmnyBAgeyQdQpVdkfdzVlBZ58cWrz8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FI5rYbQ07DP2P8mExKuPE0zzTdLAwD96iROeOuf1OAqqZptwCGNFK0yn30pr42Km/1lm7nq4npRvsCWPqlRkEfPp/T+GxMxxlCmCl3V3Zx4PgLrS0+SjEr3WrYrcq+5ZBwevrr1EGB5KXQQciRbUsyz7ynTMOBAmh+OAths6/Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZznnO1I7; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZznnO1I7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Og8PuOkZAE90w/QMMWOMak6xPD/Jhx9VlHtGobGMizD5HwNtUd302ACrGPwNfY+j7+UnpbJo4jbm2i+h2hY1jBc5WgmPn2ps2thL/bH9DMNadUXytLPVscdg9lC6OA2iO2+5pv+DlnUWBJMfKwGlVhNseZbuvHqltsBrIDW03DJyTP1ThpmCO6NS4sU6ggzeOqTubUAncou/teZE/kboP20wrUDgiM/fZOSMH16UYk2JzrUZ2J2/4R+fkHMT+0nxc/djVDyQJvLBDWPkyi2ZXOyHbi1dcxUyj1h7aTeqjEDFDojLAo2KfDn1tspIaMlXlPTeRorLGuY8SDAkHCuMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPONueUWUrgRV8tw3sOmvCymank2fgC75/MMIGzBTVw=;
 b=DaFfmpizBknCS71GU3u7Xu2gXObaDe30usOHaimzoP53wtcgoJLvV/x7UYrsY8pN5gz0iJR6RLkeUrxu3hdsDyiufIO4ZwjDZkU/ggx5Z4rXNnuptD7yj/xPISkgtx2s+6uynUfKed9FH1R7VEtaAaHNOqhU2htrM4bs7rFxNyXaBCmhyZqdjeMjtYF5UN97OBH4j3blGnBhdJfePA+bZ13VQ/+DiQBjzsy3PeDdtiB0Dco5iALwY5ZHZb64wfH+PKDXQmGO08oABDMoLc86WESOCEY9FRV8pZ+CnXHdCXw6ddUAOoDf/WgBV6BO5VllAe6CIJHVJLGKLhSReQhnbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPONueUWUrgRV8tw3sOmvCymank2fgC75/MMIGzBTVw=;
 b=ZznnO1I7pwVeyagT0wsI4lMoyXLN1SIw/QnGLTmFNJpbY94B4qqRs7gC3g9cy7EYK/TaZp7dVwxmdBnvrdBWAHXZbXOE5tJ35/jWaGkQ8UXPJx5fKmPV9Y5nRZEBDc6zQn9KZ2wRfg5zhmeh04kHfeogKoIT3SrCJCztDqF2+FI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 11:55:19 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 11:55:19 +0000
Message-ID: <cba1752a-0b0d-0df0-8526-aed25d81ed3a@amd.com>
Date: Mon, 12 Aug 2024 12:54:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] cxl: Avoid to create dax regions for type2
 accelerators
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <20240729084611.502889-1-ying.huang@intel.com>
 <20240729084611.502889-4-ying.huang@intel.com>
 <20240804173813.00001018@Huawei.com>
 <87v80e9p0m.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <87v80e9p0m.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0645.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8555b8-c6d6-4651-14fd-08dcbac5a333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVVDbzh2M0drQ0tmT01XekFQYUR3MEN4WWN3b2RxSXVFSHJUVmFYM05SUVNT?=
 =?utf-8?B?amwyTkFXY2hMV0Z6L0xaeGxVWXJtVEdFS045cStxOTRCR05rZE5odVp3SVlU?=
 =?utf-8?B?eTNPaTlJZWhncjdPNGFTRmdtdmc0OWhqZUNFc0lsSWtkNHVRUVdyUzlBVkU1?=
 =?utf-8?B?SXR6MUQwek5QTWc1TVVkYlNqQ01CRWpiTUtMOGV5aWluN0FWQ0pKNSsvVUpE?=
 =?utf-8?B?OVpweDdMZHZxNjdMdFFsZEEzc2tHbThBZ1Q3WXdWUXQwSmRNK0w1bGROTkVh?=
 =?utf-8?B?MC8rVHMxd3BEekJIeFRDcG14KzZkOTVCMnpyUlNkMkFMRThnWjQ1dEJkbmNL?=
 =?utf-8?B?ajZOUW1qWmdhV1hUc2piWk4wYStjQlJYT2loc2lKSzRUR3JzUG4rckJGV3hm?=
 =?utf-8?B?OXUyMmdHUlkvVjUyTXd1bnRPUGE1Z09RemdTMFc4ZlpyeEY1azNUUlgvNnNJ?=
 =?utf-8?B?SFQ5MXRuNmlZQTZ1c3BXZFR5NzJtamIrNU9PRGV2MDVaOHJpK21FZFJsa2dG?=
 =?utf-8?B?TitkbVNtTTZMZzR1NDRGNFZEVHE0RlltSzBnS09UaHFTTUQyOXZyVlIwTDBH?=
 =?utf-8?B?dVQ5NnpqeVlid090K01DNC9KN1BmQWloVFZhM0lBNHpPNTNBZVhFclltVFlZ?=
 =?utf-8?B?eS9XUDE1MVdaSnI2eGphbEsyRHI5WG5vdlBRZEx4M2JwRGtuL0FIYk5lc2lN?=
 =?utf-8?B?RXdMb29QNmR0QlJzSU4xa2dMcEV1eXVsQ1NERTdPbDA1VmdNYUo4bWJIejlK?=
 =?utf-8?B?d2k5a3NNaVY4aG00UkVDemJlMUFoSUQvK3F1OG0wOFArK1FIdm9Na3c4Kysw?=
 =?utf-8?B?Rll1TjBDUWcxZVl0QjFuU1JUcjBiNlZQTUtzb3BkK3dNejU2Z0Y2MjZBTTNL?=
 =?utf-8?B?czhwbENiSVprUGxFWE1TVngxYlNxUGI3K0NUb1VwV1JHQWQxRk5weFZ5d21Y?=
 =?utf-8?B?SkJOVVdQRHRDOVJnMGRZUXBleCtzcXlKTU4ydUdKV25yRDVTcUpYcXp6bENp?=
 =?utf-8?B?d2pKb0pUWThwVDEwU3RjeTdIZElxMCs1RUd6QW13cmpLLzVjbmJVbWIwSHg2?=
 =?utf-8?B?SloyYlBKZUhJVkdTZTlramsvdVU5djRuWG1NVW44Y1NMY2VjRTV5aTRVUVJM?=
 =?utf-8?B?Rm9QT0FFVUVaQ3JHdjlxbjhtR25sQjh2ZTdBVTNzT2krTVMyTXIwTWZNd1d2?=
 =?utf-8?B?cWUxZXNNZGtldTdBOVA3b2NzeUlpS3RYbDNKQUhlNzQ2MW1WMkxzWWYxenRX?=
 =?utf-8?B?ZXAxR1p1T3ZsUDJCQ1lFYzZxQ1p5TmNiSXN4Z2lsZmdNcE04WmFrYmhtNUZL?=
 =?utf-8?B?em5IQUtlZnJVcUtnWmU0N0sxVUoxRUFWWkpMOWlDREJ5ZUdDMEpETmtjMHp0?=
 =?utf-8?B?ZlY4bTNGbEcvKzAwMHZGLzd5d2FJQkNwMnFndUhPMmFSaGJ3WGJCTjFLQXM2?=
 =?utf-8?B?MjczREt6VG5GWE43c1l1NXdwTW5XeGxSTDIrdTZYRkJYdEkrb0Vha1VQVFhY?=
 =?utf-8?B?WWdpclN4RFFlRExHemhoMUtaekMzbHExRi83WlBaZ045Q0dwRjdTWkZ5alpL?=
 =?utf-8?B?S0RQYTBBcnN2RW15Q3FoRkV2UnhxbE5zYWhYaG9VMm13K1Y4NDMzaWNCZ2lO?=
 =?utf-8?B?eUV4REp6R0pIejBueHg0N0JqenZiK1Q1OG4zLzJ0d3FnRUFnUEhxTSttNEpx?=
 =?utf-8?B?MkZRSHpubFI1ZzQzaTd0WHpFZTkya1puS1JmaEovMVVPcnhUTkxER3dZem00?=
 =?utf-8?Q?Oi72KeS5+z89biR6Ts=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG56YVRMa2VGbkFWbnljdGJ3ME91WHNiY1ExdHZZb2d2NXhWMHRSR2x5d3Ax?=
 =?utf-8?B?S2NFMnU5a0pBUkl4cGtHY2ZER1NHQ3I2SURmODhSY1NwcWI1RVZRd0tGR2pm?=
 =?utf-8?B?RUwrVHdqR3Rya2FESDJCaVdrdXIrME9SL3ZnWkhzMXMxVk95bWhCVWhFcWZo?=
 =?utf-8?B?L0Z2bFN1dVlYRFJKQThDWDJaeUhrQzRHWWRrZUhhWnJ3Q2FwUXdjU0hXWUtC?=
 =?utf-8?B?TWNyeFRCRlgzZ0tzTmJsamZiUU95aitmTGxFS3NmNXVrMWdBZ3lMTTJhNGNM?=
 =?utf-8?B?MkFGZytWY2xIdUVBMjZlelBRSmwyMUxtekROSmxWbFhFODd2YkJrZTFQV1dh?=
 =?utf-8?B?RytrZWwwaTE2dmNncE95UEIrTjUzSmIxaVUrSDZYSGphNVR0alFZcW1UeFFI?=
 =?utf-8?B?RHJJNGNvTXBWaVZxUlhKSVh2dlphWWJZemhjK09jTGdWdmZCeEkwc3M3NjE0?=
 =?utf-8?B?enF3cFhDNW05Q1l3VDlya2g1WVJpNnlyUkwrOStxUTlxOFFmdjZEZ0h2WGFY?=
 =?utf-8?B?T0tRTnA3YVpzQUZOSDRydXRrTllCOWNFYjlpNW13ZTQ4cEJJK3ZaMXZKenZt?=
 =?utf-8?B?YzFSR0FNTUtFUHNJblNpQ0NNSnB2MHdMZzVKL2hCeUl3WldQbE82L3YzK0RI?=
 =?utf-8?B?cWVGUGZHaXJMOE9HYXpoOFBXYjVDckQ5ZUlDNDdpZXB4WGgyUURMZ01zeHk0?=
 =?utf-8?B?bitycXp1N21uZ2JiYlFXL2tFcGZLR0hWTHhXRkJMNnYxOUJ1ZjVYNlQrM2ZX?=
 =?utf-8?B?Rkg4RVlCOHEwVi83TGg2UUF3MHNpbHpYZzVLNUFSYk1ZS2FJTTdIV1h1OHBI?=
 =?utf-8?B?YldadkM0WmUxdGJqeEJtVFZkQ1h3dU9EeE9kQktJNFcwbExmdXBmdnYrS0xC?=
 =?utf-8?B?c1Y4UFpPcm0zZk9XalNOU1FvaHdFaEtWUGd5QlBxM3VVMXNDWk5lMTFRUFNL?=
 =?utf-8?B?TTFmcllmUGdQOG9Ud0RjYVptekVueHk1a250TkdJdGUxUzFSZm5Ic2N0TlNu?=
 =?utf-8?B?UUJBUTNaRjcya3B5aHZsdGtodzFwMmp5OW1TUDU2bFF5bkh4Y1dyRno4RGll?=
 =?utf-8?B?ZU1Ta293dHdNNFhubFpTbWpRZW1JdVRCZ3lwb2xqYVNNeFNXdjhsYkcyaGx6?=
 =?utf-8?B?OU0zajlsdkRHeTEzNnZLeUs2bENzK0hZSGpSQ09XS2p5Wng4cHgrdHZHZFBX?=
 =?utf-8?B?WEhzQS9iR05EQWNxMFJJSFd6YUVXWGE1bWd0amRnTEgrdFNJWld1Q0NZbzhC?=
 =?utf-8?B?ZS9sZG5yd2g5YTFQSHdtZ1hxWWJwVzM4d05mQndvbHJOUzQ2TlgxNmN2czhO?=
 =?utf-8?B?OXN1THdwRzREbzZPZnp1TEw4ZWt5V0JONWYrL04yeCtPNVN3RHFFUTNaYzhO?=
 =?utf-8?B?ZVM1NlY5UjNhSjk2ZGowYUw0Y0hWa2duV1BuMnBRU0JTbCtCb1g0YjFJVVh6?=
 =?utf-8?B?TkpZZzVLekVZaGRncnlrNFdydUpPNG5uNWZUZjRnSjF6S2g1K203WWVaYm9w?=
 =?utf-8?B?czl0bzJ2S2lReG9KZXFobWQ0bWJPRDFJdFNpYlhUdjhQaEtqWVVQTWRwdzVF?=
 =?utf-8?B?dWRBQUYrWWRRZ2xXWkUxcUR1K3dLYkFxbEE1UklwQWgyelRXc0VKc0xhOGk4?=
 =?utf-8?B?cjJRYVNVQkg3a1dweURaQVJqdzhHdTJlSzVjbEF3Um1pUUdBZnRURThrMUl4?=
 =?utf-8?B?U3hZTEgvRFlkTzUvaVBsMVpvTTdLeGpHUUFwdXBLR0VJYkRtbCtCYzdQYWE5?=
 =?utf-8?B?WnF0NXlXaFRnWEQ3OVZadnk5Z1h3S3dZbUlUVGV3c3VSenpwaXBkNnoyc2c3?=
 =?utf-8?B?bWJSMTlySnZiT2wwV3dmRHNKUTlkbnlFakxpM0lqNG1xMGtJUlZLQVV3NW9U?=
 =?utf-8?B?WER5SEVjaHJuUXREQVpEeGcra1pUcHhBbERqRWpsdEh1TnUwWGFCN2NVSk45?=
 =?utf-8?B?U2MzV0cvS2oxWEpBRWk4b1lXTjFGaVpkYkJrRm1YUHg1STNYVkMyNHBBU2VD?=
 =?utf-8?B?SHVsandiMlVMR0FSNW55VHJXQXY3K05Cd2FiSUg0UzVxSlREcVMvbnIvUVd3?=
 =?utf-8?B?YkRLYk9NczhWR2xQcU5DeDk0REI4ZStEd2phNmFnT3krQmVUWUZmSWxFVGtT?=
 =?utf-8?Q?+C8BW+dscJf+yaXCtq+InlP6+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8555b8-c6d6-4651-14fd-08dcbac5a333
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 11:55:19.1074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I80Mqblh3Q4V4m9fw19CKItpvXwSmkmLa0HIN0hytJB/eADoUPfLVidcFf537UfgRo7e9VBHApdRaYefuryxXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564


On 8/6/24 06:52, Huang, Ying wrote:
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
>
>> On Mon, 29 Jul 2024 16:46:11 +0800
>> Huang Ying <ying.huang@intel.com> wrote:
>>
>>> The memory range of a type2 accelerator should be managed by the type2
>>> accelerator specific driver instead of the common dax region drivers,
>>> as discussed in [1].
>>>
>>> [1] https://lore.kernel.org/linux-cxl/66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch/
>>>
>>> So, in this patch, we skip dax regions creation for type2 accelerator
>>> device memory regions.
>>>
>>> Based on: https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>>
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>> Cc: Alison Schofield <alison.schofield@intel.com>
>>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>>> Cc: Ira Weiny <ira.weiny@intel.com>
>>> Cc: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/cxl/core/region.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 9a483c8a32fd..b37e12bb4a35 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -3435,6 +3435,14 @@ static int cxl_region_probe(struct device *dev)
>>>   					p->res->start, p->res->end, cxlr,
>>>   					is_system_ram) > 0)
>>>   			return 0;
>>> +		/*
>>> +		 * HDM-D[B] (device-memory) regions have accelerator
>>> +		 * specific usage, skip device-dax registration.
>>> +		 */
>>> +		if (cxlr->type == CXL_DECODER_DEVMEM)
>>> +			return 0;
>> As in previous need to be careful as that may not mean it's
>> an accelerator.
> Yes.  We need some other way to identify type2 devices.


Maybe the easier option is the accel driver specifying if DAX should be 
used.

We are adding mailbox and hdm as optional for accel/type2, with the 
driver specifying what is supported. Another optional param could be 
this DAX usage.


>> However, we do need to deal with BI setup for HDM-DB type 3 devices
>> etc and to check the HDM Decoder capability registers to make sure
>> Supported Coherence model is appropriate. (e.g. 11 for host only or
>> device coherency - HDM-H/HDM-DB)
> Yes.  We need to check BI configuration too.
>
>>> +
>>> +		/* HDM-H routes to device-dax */
>>>   		return devm_cxl_add_dax_region(cxlr);
>>>   	default:
>>>   		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> --
> Best Regards,
> Huang, Ying
