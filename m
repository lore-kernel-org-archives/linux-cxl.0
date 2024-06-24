Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485751D53C;
	Mon, 24 Jun 2024 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244289; cv=fail; b=dPoK96Ro9rTc5K/fgaC+FyanCZfLG+Q+mBzP7GemB99OrfSAH1QCGOi5LIDL/2iGURa0kw2fcmmvIF02MELY0+jS5jxabm024rETotXGZPQ/VVswJvEmE5C536EHc0MX3qQ4dHLVKPUzq6c61Pvza/1TgPsOK8tpM9SivZIDYwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244289; c=relaxed/simple;
	bh=CmbwPpurFDxdaJxxlYQthjY7RkWnO1Ixc4eOWU1LoAU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r4hZ7r4xXDnp+Wj6o8h/v+BDKXS2RtgKMH334GjZu4a90cfZtxd4zVDu3b1uzzIgy+PqWyBMT1Vp0b9nMjCYvQC3F/9j0GbweydQX/yp0lrJ9IYLqMWaE13iAZvuF80rbDRw0uAOBqizTrs/OeHPbv5auMIENm3gwtRLTmASEnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pGBFnUSF; arc=fail smtp.client-ip=40.107.95.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pGBFnUSF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXUsVpcUpzl2Euc5eKbJoIWyQ101MwAzMspZWLKfgKAhadOuU9sfysMVGh5mUO3nD9gBFOwjRCHJgRWFVjdlrmZTqEaN6/guK1wB+vrI8tXB4mbmHH8r6syxid/hA0s8DZejOiiTtQxNiw+hvA/Jmx8TraZzETMXgkPv1k7HOUjiVx/gIkLkQsxWL69LAcynvZRzU59T2NvqNjtA8IWmEKGNId7IdS8qsR6QPbqKADrgH8jkmqdz+vHZZaGSnTzPKETCp9fI7PfUij/DmoS7+0PL9XrpZXOtXX/C+HJgYh8I1XHzTP5FjfFANqbUH+k4TZc/prkQinnnJnRB54c59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fohj8oxs07B3GUFQUGtigb2kQ/2TL57/WBk5cWS5Vxg=;
 b=atApWt0mcVm3lAV3HQbtDegp3crFToeLuOFaL9O049ogb5E1hfQNXPCYBuW6+G1XhpGSl9VSdSazDHzL0ZtTXEl4VndzSQQGa0H1oFICONpzNQyRg70l5dpeXSCHSqpoOAjmi/fmk6nSxkLlcV5ukNwCjqFeztqQX4UgcseaKNvnQ60zWom1X6gBqVw5RllSOuR68DsTrpDnTtJKeH3JjK05UKKsa5Z3w24CGIGLRL9toiSlhhjPJEV6P0NuxZ6BymZ9W1pr0RyVOLLWL30eQXmEXUKSECNl3sIwyndOr0fXkggimk0Ixp1edYmnXp9ppWAFuHnDWnS7ecFptyx6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fohj8oxs07B3GUFQUGtigb2kQ/2TL57/WBk5cWS5Vxg=;
 b=pGBFnUSFO3FXHP2bDr6BLEYMDcBIDG5xPUhpeKc5lBlcVjGTIv3mA7mGn7fSRHFdYqn/xBJ9JysbEbDPrxnOrazr2dJsjDgdycc9y8SCewdD3OSe2eesDWY00rBQjFRkmoQJTwDBFo+CTyrpHLZYH1ESWDsSL5G24ImyHpHvczM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 15:51:23 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:51:23 +0000
Message-ID: <aba901a8-4d7d-4f2e-9656-7d6b6a1bc4d2@amd.com>
Date: Mon, 24 Jun 2024 10:51:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/9] cxl/pci: Map CXL PCIe ports' RAS registers
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, ming4.li@intel.com,
 vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-5-terry.bowman@amd.com>
 <20240620134626.00004dc4@Huawei.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20240620134626.00004dc4@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:806:d0::31) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:38d::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1230a5-8612-48f9-d0d6-08dc94657f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGwwcFlQU2VRck9lbVdkSWViamUvbDNsdzc0QjhLTGdsbFVqWHhVclJjczRV?=
 =?utf-8?B?TlNpS2ZyZ0c4ZEtuMisvQ29FcHZLVHhKc2VvbWJuL1VPaG1GQ2dYR3ZYQW9O?=
 =?utf-8?B?UkphVDBmbThqajFDMTZWdGdocm15djllSmEzZmxDNk9WSEY3aStuR3dJMEZj?=
 =?utf-8?B?MEFyYWJiY0tBVUVZVzhVU3FsZ0NhTVBBeEkyTEU1bmYxR0lkVXpVZktRTjdv?=
 =?utf-8?B?SzZNYWhoOHpWUnIwaWFTdWJnb2RzNmdqZEZ4Nlk2Ni85YTVGQlRMbEIyQ3Y3?=
 =?utf-8?B?cm5zODA5dVBCNlNSQTFJNXcvN1ZvWndkcEJYYTJGSDQxczRVWUI2eG5WU0tw?=
 =?utf-8?B?U0ZHZkxqOHREanFOR0lSY0wvbU8zQUlBeFR0SFp1dEJ1UXhIZ0lYZnFpMytN?=
 =?utf-8?B?OWNZbWx5Vk1sUnpMbHluVzBmN2d6UjNid3htZmJ2N0QyWXFjY0F6LzBwKzF2?=
 =?utf-8?B?VCtvNlJyWWRoK2tZRjlwMUJlSmNhYm1GUFZzSzkrS0FZK1ppVWFPS0tDcXhE?=
 =?utf-8?B?MVUzVTlYaFhGbWYwWWRKb2lFSTcvOGJ5MEhDZTN3R3U4a084elArY3pmMCsv?=
 =?utf-8?B?WG42Yzk0Y2xQV1NQc2pGbWpob3N2anExeVJEd0ZiRElENjNHVGRLM2hEb1JH?=
 =?utf-8?B?ZjFxSWlrZXZaUVZHWCtvYWNqSVM0QmlCdk5CbmNLL3BlU3BSdXVkQS9rZngw?=
 =?utf-8?B?L1hWdThlNEo5cndjNU5EdlpSWVRTV0FDaUtwNG5wczIrZFRrM2k3NGNQV3pl?=
 =?utf-8?B?eUxwMHNhY3NFNFRyR2owaWhiMlZ4L2hHcExKWG10UFFDcWt4MERZZ1BmNmtz?=
 =?utf-8?B?anhtUk1nUmljUGNyL2ZhRVBSbFY0S1dSbHQ2Tmp5Wk5nek1YM1BIZ3RLbEZ1?=
 =?utf-8?B?aGl3VG82ZUpxcy9LdGx6U2lGOHNtVDJrem1yeEhSQjkySXBFcDJWQll3bENW?=
 =?utf-8?B?QWVnOEEvU1BSVnZLeEk4YU9uMHNnZWM1V1ZsZG1IZ093K08xdURvdEN6OEx5?=
 =?utf-8?B?bUtqbE5EUWxBNU51QzBKVzEvTXhXbEJVUHYrV0dGZlZmQ1BqMWUxeXQxY1o2?=
 =?utf-8?B?dDJoeThRMTBjK2pqTy93OWJkZ01US1FhVm01b1JLbmpBRnN4WTkvcThMRlpT?=
 =?utf-8?B?V3BvTGJQQXBKUGtuUFdtTXdUS2N4WGEvR1B6V3poWFNSSUJueXJ6bnRaVzNX?=
 =?utf-8?B?QXlYOXE2aHpsTG9SYkdNTWxDTzB4aXpmU3ZHeDB6Vy9vWFBxdFI2eGVaRENC?=
 =?utf-8?B?VEdLQWFXL0ZlN0xQTmQ3cTVsc2hBckQ5c0haRmxNWlFzLzRTWHlPNlJtYklS?=
 =?utf-8?B?S3VkWVhQcW8vVlQ5c0JUVnI0a0FXZy9OOGhuVWU0ZzFQNzlvbEJpZWpFTmNx?=
 =?utf-8?B?Z2dXaXNnL3VOU21rYnBaOThGeE9TSFoxbTBhL3pMNnhCUy90Q2poUW1XVmJi?=
 =?utf-8?B?NE5mWkZRMm5PZWxkeWVuMmZ5bmk4NitPbUJ1cDhIYmpmTWFNMEdvZ3F4YzVC?=
 =?utf-8?B?K0I3TnEzRTJEYUp0TVlCNlJNbGhNYTZJMGtKdVJXZ2RVRVA1Mi9CYnY1Tk5l?=
 =?utf-8?B?UlNtWGxNQ2R4QVJpY1pRc012SStOME1GbGVHTkVIZkFyaVBkcitETUlrYUg2?=
 =?utf-8?B?VHFCZXBrOEgvMzBPc1BZT29pRmhkUWN0QW91NE9meVF3STRHYjVFVFFmL2hX?=
 =?utf-8?B?NG5renlwbnBYZU8rTU9IS2RqU0wwY1hQaTdZU2RZZWdvZzlJN0F5MW1xTFRZ?=
 =?utf-8?Q?6JzbB/8ubIQVFANXEvCK7zpq5wJmKTXHP+qTtQR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2cxUC9reTNHZGhVK1FyMmo2Q0ZjZ1k2VDJRcGx3Z1lVV09BVGN2bE9mVVlF?=
 =?utf-8?B?Z1ZvUEE2Mmc5UWZsR1V3ZUlPaDFtS3c5SFR5alFiVjNIVjFaRGZja3gxNVJ4?=
 =?utf-8?B?V242bW1kWlArU25ETnI0NXBpNEVnalFoNzR1N1VnY3NvNlpZUVdkR3NjbjZR?=
 =?utf-8?B?dGZKSlhodW1mTVQ1YlhtMlMxckQrby9MUzB2bVRHc2FyWGNmUzNGMWwvUkFj?=
 =?utf-8?B?NFNjNGR6bm4vQ3NUcVVTR09vMVAwMHVFK1BpRk9oTHJRWEkzVVN6Wm5JUzNx?=
 =?utf-8?B?bDRyZVBNeWxLYjNHb0FRekVSSVBjSWc1MlRncmd3ckhDSHV6dnlqYzJwTHhj?=
 =?utf-8?B?RndRL1hPb3ZWTWtOK0hQbnlWb3dWbnYwWkVHV1czeGFTelhpY1lGM213V29I?=
 =?utf-8?B?ZjllWHZaeGtlSjBzRDVlQllIMHlYb0gzcnlxcmlmQlVOcTdsamFRZ0pybzZI?=
 =?utf-8?B?YlZkVlUzam55NTFUMFpHWFhVdXpzMEVkZEYxSCtGbjRZaEFoTFA3V0E4N01p?=
 =?utf-8?B?dFczS1VhRWdSSEpnL3RIdUUvNnYzN1pEd3NNejNzWWpDNGpMU2htMXh5SHV4?=
 =?utf-8?B?eGc0cWhKK3lldnlWUmJ6UC9IZ1R2NTlOZFJ2d2hBT2pPU3JZUEFnaERVRjN2?=
 =?utf-8?B?Q3d5bVMyTndTTE1XMDNPS3BOYkNndnhKMnRIKzgzb2Q5WWJDem1jS2szaTRj?=
 =?utf-8?B?Ukxqc1pDNHFoSTRjK04yVjFtV2lRL1FkYmluSGFxV2J0RHNUa1lBU2FwMTJ1?=
 =?utf-8?B?NnVxb01iYS9ZRkRydlh5ZGo2MWd4TUZiZlhtUC9CNTRpRGRqYVd3cW84cGdC?=
 =?utf-8?B?N0hVbW43STY4VmFlRGk0bm0rMDkwTlFTNHZZRXhHM1lGMU4wQ2xmKzdDOFpm?=
 =?utf-8?B?a0QrSDkwS3k5dGFGZ0RjTmswZXFWWEZhN2ZrMXVSUEQ2eXV6V0VCaXVYM3BI?=
 =?utf-8?B?RDFMbXFUZERFOTBXWStSUFFYYTllRHRvT1BsWXFDWmw1dDhyVEFiT3N1VjE4?=
 =?utf-8?B?b2VWVmM5NzNyajgzeHdlcHRLeHRYR0RHM204RGZsUFZvRTJqUW9iYk5xaEp4?=
 =?utf-8?B?OEkwRXhBdy80UUJMMEF0ZG9DZ3RKUVUrUld5K1pwYjQwR2x0WG10cFdwWVhR?=
 =?utf-8?B?b3VwTjFWbW01UElJTHJvQ0Nkbk5NSklrWVZ6anZJejR5MlNFOTdEREJhTmo4?=
 =?utf-8?B?dUY3S3ZTbUJiOSswcE55c1RnV1pXa1ZzSGFFQ3ExeE5ERnZiQmZGTml3UElS?=
 =?utf-8?B?N085eGVtRmduOVFMLzREVkNFKzlXS3plZkkzdERzSTAyL2s2OHI1S2JYT3Z0?=
 =?utf-8?B?WmRZMXhMTytuakI2NFpiTmJWMjlKUkovQ0JzcnIwM3lPZVBBUEE2TlF0elRr?=
 =?utf-8?B?cExIL0p6RkUvYjJnMkFvdDRmSWREWHdmVU4zK254VlMvb0F4eWw3MGFLTHQw?=
 =?utf-8?B?a3BRWFRNTW5yZlM0TitvVG5nbWRsU3pSUkdabUsrZ2lrT2krVTN0S1VpNW5a?=
 =?utf-8?B?SW93MHpWK3lBZGtna040Q0hRYVkvMHkxVUg0cDZyMHQ0UUlxS2Zic2YvcTJE?=
 =?utf-8?B?WUxrS2d5bDNvN0Uwelk0TmVhYkdKMVlPUFViUzU3ZUZaMnlWT1ZJMVg0b2Zh?=
 =?utf-8?B?M2pnWFBWRUZuRE1xRCtsNDdWNFlmZkdaM1dxT2VIZzdESGNJeWFjNkNEQ0dV?=
 =?utf-8?B?VzFhcFk0VWRNWVdqZC9kRjExRktvc1pGaFRxSEZzbi9MNXp1VHRlM1JuNnEw?=
 =?utf-8?B?alhYYUxiUmlWeWF4NGpDQy9Vb0hzakZzRDgybUhQTkhFMk8zaGhsSzFFMmlG?=
 =?utf-8?B?Mm5NbjhvSHFVcGZNOVo3SURYam5pT2JYRnRBQ1QwRFdsMGF1b1hYWFVoU3FC?=
 =?utf-8?B?bXByUko3bmlrYitUckNHaXpTVGlJQzd2VFF5RXRYbGd4MFVtQXlOL1ZZb1JR?=
 =?utf-8?B?MFN6NVphd0tlaVVTZXlCUkpJZDZBN3E5Wk5IbkFoS2pOQTJsRnZkMWE1VkM1?=
 =?utf-8?B?M1Jra201RENuUWs2bUdpZCtNNTBUR3RidlA1anVFSzg5WW84N0gxM1h2dU4v?=
 =?utf-8?B?d0VVMFZwZTU2L2RaOVI1UjEvOUN3bHRZSXV4MWNraHlnQkVnbVRQbmV4OGhh?=
 =?utf-8?Q?BtQJNEyoHDgCPso+a2p2YwBmj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1230a5-8612-48f9-d0d6-08dc94657f9b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 15:51:23.4535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLlPm3DLb35fVLjqLgjKJrYeVkVjNANv8RO9THdPM8+vu4Ad2hcq8U4Q4BpHUa84ajlMcaJcNcoVvQ3feC++hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736

Hi Jonathan,

I added responses inline below.

On 6/20/24 07:46, Jonathan Cameron wrote:
> On Mon, 17 Jun 2024 15:04:06 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> RAS registers are not currently mapped for CXL root ports, CXL downstream
>> switch ports, and CXL upstream switch ports. Update the driver to map the
>> ports' RAS registers in preparation for RAS logging and handling to be
>> added in the future.
>>
>> Add a 'struct cxl_regs' variable to 'struct cxl_port'. This will be used
>> to store a pointer to the upstream port's mapped RAS registers.
>>
>> Invoke the RAS mapping logic from the CXL memory device probe routine
>> after the endpoint is added. This ensures the ports have completed
>> training and the RAS registers are present in CXL.cachemem.
>>
>> Refactor the cxl_dport_map_regs() function to support mapping the CXL
>> PCIe ports. Also, check for previously mapped registers in the topology
>> including CXL switch. Endpoints under a CXL switch share a CXL root port
>> and will be iterated for each endpoint. Only map once.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Hi Terry,
> 
> A few minor comments inline.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/cxl/core/pci.c | 30 +++++++++++++++++++++++++-----
>>  drivers/cxl/cxl.h      |  5 +++++
>>  drivers/cxl/mem.c      | 32 ++++++++++++++++++++++++++++++--
>>  3 files changed, 60 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 0df09bd79408..e6c91b3dfccf 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -787,16 +787,26 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>>  	dport->regs.dport_aer = dport_aer;
>>  }
>>  
>> -static void cxl_dport_map_regs(struct cxl_dport *dport)
>> +static void cxl_port_map_regs(struct device *dev,
>> +			      struct cxl_register_map *map,
>> +			      struct cxl_regs *regs)
>>  {
>> -	struct cxl_register_map *map = &dport->reg_map;
>> -	struct device *dev = dport->dport_dev;
>> -
>>  	if (!map->component_map.ras.valid)
>>  		dev_dbg(dev, "RAS registers not found\n");
> 
> Maybe return here as nothing useful is going to occur after this any more.
> 

Ok

>> -	else if (cxl_map_component_regs(map, &dport->regs.component,
>> +	else if (regs->ras)
>> +		dev_dbg(dev, "RAS registers already initialized\n");
> 
> likewise, return if this condition happened.
> 
Ok

>> +	else if (cxl_map_component_regs(map, &regs->component,
>>  					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>  		dev_dbg(dev, "Failed to map RAS capability.\n");
>> +}
>> +
>> +static void cxl_dport_map_regs(struct cxl_dport *dport)
>> +{
>> +	struct cxl_register_map *map = &dport->reg_map;
>> +	struct cxl_regs *regs = &dport->regs;
>> +	struct device *dev = dport->dport_dev;
>> +
>> +	cxl_port_map_regs(dev, map, regs);
>>  
>>  	if (dport->rch)
>>  		cxl_dport_map_rch_aer(dport);
>> @@ -831,6 +841,16 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  	}
>>  }
>>  
>> +void cxl_setup_parent_uport(struct device *host, struct cxl_port *port)
>> +{
>> +	struct cxl_register_map *map = &port->reg_map;
>> +	struct cxl_regs *regs = &port->regs;
>> +	struct device *uport_dev = port->uport_dev;
>> +
>> +	cxl_port_map_regs(uport_dev, map, regs);
> 
> Maybe it will be used later, but based on this patch alone.
> 	cxl_port_map_regs(port->uport_dev, &port->reg_map,
> 			  &port->regs);
>> is more compact and I don't think looses anything on readability front.
> 
> 
Good point.

>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_uport, CXL);
>> +
>>  void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>>  {
>>  	struct device *dport_dev = dport->dport_dev;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 036d17db68e0..7cee678fdb75 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -587,6 +587,7 @@ struct cxl_dax_region {
>>   * @parent_dport: dport that points to this port in the parent
>>   * @decoder_ida: allocator for decoder ids
>>   * @reg_map: component and ras register mapping parameters
>> + * @regs: mapped component registers
>>   * @nr_dports: number of entries in @dports
>>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>>   * @commit_end: cursor to track highest committed decoder for commit ordering
>> @@ -607,6 +608,7 @@ struct cxl_port {
>>  	struct cxl_dport *parent_dport;
>>  	struct ida decoder_ida;
>>  	struct cxl_register_map reg_map;
>> +	struct cxl_regs regs;
> 
> Does mapping the whole cxl_regs in make sense?
> At least currently we can't use the pmu regs in there from here
> for instance - the mess with interrupts means that has to bind
> via the port driver (for now anyway).
> Maybe struct cxl_component_regs is more appropriate here?
> 
> 
Only the RAS is mapped. But, as you point out this can be changed to 
be cxl_component_regs and it will be more precise in how it's used.

>>  	int nr_dports;
>>  	int hdm_end;
>>  	int commit_end;
>> @@ -757,9 +759,12 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>  
>>  #ifdef CONFIG_PCIEAER_CXL
>>  void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
>> +void cxl_setup_parent_uport(struct device *host, struct cxl_port *port);
>>  #else
>>  static inline void cxl_setup_parent_dport(struct device *host,
>>  					  struct cxl_dport *dport) { }
>> +static inline void cxl_setup_parent_uport(struct device *host,
>> +					  struct cxl_port *port) { }
>>  #endif
>>  
>>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 0c79d9ce877c..51a4641fc9a6 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -45,10 +45,39 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>>  	return 0;
>>  }
>>  
>> +static bool cxl_dev_is_pci_type(struct device *dev, u32 pcie_type)
> Naming perhaps needs work to make it clear this is checking if
> it's a CXL device of that type.
> Also, seems like general functionality that belongs in core/pci.c or
> similar.

Any suggestions on what to use for the rename?

Regards,
Terry

> 
>> +{
>> +	struct pci_dev *pdev;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return false;
>> +
>> +	pdev = to_pci_dev(dev);
>> +	if (pci_pcie_type(pdev) != pcie_type)
>> +		return false;
>> +
>> +	return pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
>> +					 CXL_DVSEC_REG_LOCATOR);
>> +}
>> +
>> +static void cxl_setup_ep_parent_ports(struct cxl_ep *ep, struct device *host)
>> +{
>> +	struct cxl_dport *dport = ep->dport;
>> +
>> +	if (cxl_dev_is_pci_type(dport->dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
>> +	    cxl_dev_is_pci_type(dport->dport_dev, PCI_EXP_TYPE_ROOT_PORT))
>> +		cxl_setup_parent_dport(host, ep->dport);
>> +
>> +	if (cxl_dev_is_pci_type(dport->port->uport_dev, PCI_EXP_TYPE_UPSTREAM))
>> +		cxl_setup_parent_uport(host, ep->dport->port);
>> +}
>> +
>>  static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>>  				 struct cxl_dport *parent_dport)
>>  {
>>  	struct cxl_port *parent_port = parent_dport->port;
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>  	struct cxl_port *endpoint, *iter, *down;
>>  	int rc;
>>  
>> @@ -62,6 +91,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>>  
>>  		ep = cxl_ep_load(iter, cxlmd);
>>  		ep->next = down;
>> +		cxl_setup_ep_parent_ports(ep, &pdev->dev);
>>  	}
>>  
>>  	/* Note: endpoint port component registers are derived from @cxlds */
>> @@ -157,8 +187,6 @@ static int cxl_mem_probe(struct device *dev)
>>  	else
>>  		endpoint_parent = &parent_port->dev;
>>  
>> -	cxl_setup_parent_dport(dev, dport);
>> -
>>  	device_lock(endpoint_parent);
>>  	if (!endpoint_parent->driver) {
>>  		dev_err(dev, "CXL port topology %s not enabled\n",
> 
