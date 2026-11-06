Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793946345;
	b=F3FCP7gmtR/sdxmKIv3M55ZB/3wuMNmPfQh2AJSr/9BneUbkPdJATHvRokfToIidpbfY
	 5/CwlPEGTERlgACpo5p7zr4dMinUXiPWwZzEZE05GLS37dHVwiW83fxGSTZ+BxmK9r6Au
	 RBtl2b2tbQbkrY+wsZQOdSwWi60ulpOtihlCa6cnutr539+CbIzkC44AtLauc8K2xzp5y
	 AmIQnM5u1Zp/PAB3eKlJZODRIWt6WIFxadRao/NicsXcAdLDO6G3W6G5Zzt5GqqpY85IA
	 V1qV9ghQoZWBgw1UFTuw5I4XhBVdTNFbRwwHKFf3hkBxyPROoEBv+iCLbUS+05P34mQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793946345;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=CywTj5VjmHeTvWjCmwUDgmN/ksA7pB6+xWdBrF5q/dQ=;
	b=4w4VJKOLLRgbyG6k7OD6/DPejF2bGGG04b/bs8muxCWrenYqNY007HCgZjOjJyckAMMb
	 WaZ2PQerEebPEigj5T2AF8ymqkyZVEZZC8YETzOGo+w26+Ifnod98QEH3fTl2qtxgUg3A
	 XOG1jyEm7Cdn3zUgUTFRthimYOPl0XFabE5N4y79GZLSDdKdrFVFvsMLX/ZYKNhbSK0n/
	 ihd2LwqyUOwlx6jUP6v9JmkjNRPUSQxP+NDQT+/SYBGCRwg4TtPtxWwRrWYV2+8IhZI4m
	 Guvs9QmpaGVl5Q4CUgIoE3pOLGPQkEwW9N3arsxOHsCA458+ZlOLY/onJZAdLpc+e0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KJ2qhYGR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.19
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5352606A326;
	Fri,  6 Nov 2026 06:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5352606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KJ2qhYGR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRZE4maQBiZ5r0+9LfxemNvqAVsS22V2aTfUZumB89kfpQVyZCqJioRJ1/jIXio2rvdzNPN9RWbOBNaj1ndc1sFM4GtHHk+IhZ+oSCfFUFH5UyqAj2moedoGkvDUgSG5hL8PqUwdU8AIlHQ9cHbLMBO1BlGmeVIRzuP+MesKjXXJ0FVRlHY+xMbg3J0wPfNRFgHBCbbHNoxUlJcGdk7LvIBfhSscr16J6rvOeKatKNGX0DhoCnSqoN3CvrZ4dIhGHwU+z4IhckigBpbocGjShBFgx1h82KZfCSl6a8pzeft49Lt+ruYg+IBcinQSLN72BHB4bh0/0R/E3yjq35AL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CywTj5VjmHeTvWjCmwUDgmN/ksA7pB6+xWdBrF5q/dQ=;
 b=lo0QZW2EC2E5gxTTwcUBcXanvp7GwEieDok9EzuuhH5qEsnzRCnezcpazK2wAZcTT5o9pjxrkRbwUJBkuHkPBPt5cG6kgafs+Po4tqaBERKcTKoRpSafu3stOOdYnu61UcjMB53b9N4qoPaVsHIH4yY9H0qhk0XHpw9W1fA6m0BzNzjArr8x6LbX9AAdF1ed3KmsHdfLr5z/zj5eFvC+WuXtcE7N8xTo0qyVQzvn6JMc5VmG0KwWVselZRqiOxzKYPovVQJc+aA2tYZqOvgA8Ma83rheTmDVrrWttJoLLIJmx+4t5bfQa/vD9gJz6PuQ3hbt8hiw0/HfL/PeNu6XdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CywTj5VjmHeTvWjCmwUDgmN/ksA7pB6+xWdBrF5q/dQ=;
 b=KJ2qhYGRLZKpEWcXPpeB1B79bnv29/5c1eLfAyvXnUpxOCUpKKw5OtCpiLPc8XnaAgyDDlia/g6G4WSJYHP4Zzb1m3wTSpBEGBWm/vQVwXlmsphfHegYcXU3gJGHcJbuGAF1GJxloto6BNiHQsu594griL33v3BM+XMMiSEJ/NRpl4+vcuyRmJ77ldFJJRAnddKUZVWiwk9YgAtko/ZKUHl+ceNqhMcCwBzhkkJCd0iQDE3vh4MfaEu4g8W/+Fl5/o+/KVSLRmMId71AuVOlT2FH8m1WrPJRTxWT8GJCVc/vVjL7IFSEe96EifpgnhuvPHziBpZdnZZU3uGHCQbtsQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 06:25:41 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 06:25:41 +0000
Date: Fri, 6 Nov 2026 14:25:35 +0800
From: Richard Cheng <icheng@nvidia.com>
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
Cc: jic23@kernel.org, dave@stgolabs.net, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org, 
	ming.li@zohomail.com, kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com, 
	kristinc@nvidia.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] cxl/mem: Separate provider registration from
 region attachment
Message-ID: <au1yQOR0-vNj27NJ@MWDK4CY14F>
References: <20261007090540.43817-1-icheng@nvidia.com>
 <20261007090540.43817-2-icheng@nvidia.com>
 <fb16beb4-5816-45ed-ad74-3338ee698791@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb16beb4-5816-45ed-ad74-3338ee698791@amd.com>
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: a604f010-3db5-4fcd-eb3f-08df3bcec7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|261022075727099003|261022113327099003|261026121527099003|4143699003|11063799006|261102123227099003|261021123027099003|261021135927099003|261021121427099003|261021130227099003|261009223027099003|56012099006|261028144727099003|261026130827099003|261022115727099003|261026140227099003|261022105027099003|261102130727099003|10067099003|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Nea/o1olJ5q/eO04wpv8K42/SpinQGPHOLMXd9U/PSNABFI/ZLmbxBqJJtsaD285dq0JuQewxAfY2FO4w6lx9gc56soD25alYWkgS4EJ06gNeytspksLANcCzaeVpDhQ8BCBwPp4hmlP1mbzSBfgfhiFepug+m5EcIgGMBzWn+FwaRvhwqXeo9ntD7szx7T1wQuoRwqf4Bt+AU7H41BhZPAqeOik8yJy2ZWdtARY3Bd+vD2bCU2gKZksxWcIevC9kUXvZRprrthMLJY+gUfdAQg/it0mGzKyRU0WBYBjxyFrKX4qrg3jpNsRZjF4SxdYCUlHW9o0F1UC6trHWIOKpsTtBLKN3gJDZa7JxHc6v+cVaIHP3F0zbQfQs0vNLxh1X7IiJ/l7RmGa0mQUAA0JIdOxia3lq++RelaTcU/mtM7VWxtz6ZTG0jTS1fSDy8EB2Jx6QZIzCOCqPovstf1PKUcKM8mCvX4YGWX3GNK8yRegUBaiD22i6VYqFRRqE3gST8z63jrXjiTc1jjfqeVtPvc4sxDMkI/d973t5wrpt3117IvlL2GmNbWthjVuhM3a14yvy5uU2h6opVPpSY/4zfn1UXXPXAac6oOmONkKN2bBCc3IhnY0cM7w0Ai6rZBE3rrClqdvx0ZKp3SEWfxGW5gGeqBMnOOoNi56RYObBFI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(261022075727099003)(261022113327099003)(261026121527099003)(4143699003)(11063799006)(261102123227099003)(261021123027099003)(261021135927099003)(261021121427099003)(261021130227099003)(261009223027099003)(56012099006)(261028144727099003)(261026130827099003)(261022115727099003)(261026140227099003)(261022105027099003)(261102130727099003)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dwbom89HzDrlmhwKMvs84HHyKpVoJcGcsEwbbh/3oGI1oQ7q6w+hG+a+xLEg?=
 =?us-ascii?Q?IgdHbbrKwEzkUHxHg/nrokxJ2LrIV3+GmxEyQ5GfGIUXjbKgFR4wcGSN/vlR?=
 =?us-ascii?Q?+aVbfg4/dMYeYkwdWI9Tb2CZpQGnMmfUJJU/SX5NQLqf2c33Kl/0HsQOAgek?=
 =?us-ascii?Q?+IlYbRiEudbOp7WZsZJxFpJ5dfx3LEfcTXAfH8DEQwW3m9scbQonh7zyV3qA?=
 =?us-ascii?Q?h+srCHgq3GXuIP7iTMRwyUACg4bib+r3ehgQ/7A7Ulf9Q6IhFbFLmFEM3IHB?=
 =?us-ascii?Q?ofXB1hWdSjL+fPtOE5eCPsD6Oq8d3phdmo8vwuK5tTi7k2BihlOyZvebrC1A?=
 =?us-ascii?Q?h3TlzvlF1HfVifLovzPBNDR3iEowmsFVPwGx5/mwz+l+XDRC0j0fzCI7Hd+T?=
 =?us-ascii?Q?n76M9WAR464kCc9LIDjs2eRsPF/6D3AMGZ/+++DyOdh6tQRrykK2rHMnKA/J?=
 =?us-ascii?Q?8bnp5tO79tvsGofuqyFADIytv43wT01/sHkvCmsQQgaAqMopxRMvCPA84NOt?=
 =?us-ascii?Q?gp9K6imhHyhMhWZtLC/NysJM1D0eHeKqygva8KKmJFyGvWZHJKGoeKC33XNY?=
 =?us-ascii?Q?6BmvhUVraGPjLaSvHN7mddEwONMAzaA/s/z6E41jZCMSswkmhgcScXrdLarA?=
 =?us-ascii?Q?qVuJAOgrvjXxafrsoC2vFNAkNAkHYmMgSoUuRS6Y2V9Gv0TmSTUjeLH27mMt?=
 =?us-ascii?Q?8vGYL+9RvibA3IyTsJRVWpywIdbNb4/MR4qLs1NPRqJPcYugGfBHCzG3Citz?=
 =?us-ascii?Q?NfUgl/LcR/K/A7JiH8jLLP1fE2RBVFzTidBZDeOpL3LzopPjpCwwv4WCdYIC?=
 =?us-ascii?Q?Z3B6xbs5F+Z3bdq/SSq1rQZVILINjG4Po+vpaaY6pVJ4Z4dIUxuOi9zbxGb9?=
 =?us-ascii?Q?mSi4wtP52jk5fgrQUvCyMaj5p8jHK35ebu8t+dr1IlknRNcPYaeHPYLKgtSN?=
 =?us-ascii?Q?yrBjxVR+x0SfhHVOSTE4FvkuYY/d+KSkwxc0n7al9viuAZkfdmoRw5xm6oAx?=
 =?us-ascii?Q?0PqWJtrjGAP7TnMPSE8suLf3ZHF7p+6hOW2eiwqUPM0r12/K1pNtNUsAToO6?=
 =?us-ascii?Q?qIn0hdWNwCRKI/NMwYdx8rID9yiY8eGfxgoIJteYOTDtWqA0T3ixX4mIfKkR?=
 =?us-ascii?Q?9DQWNokD9weQoUVXYo+fXV6b5QrH+QXdyZSVdUUNrWuv/fDhbb81hNc4V+qO?=
 =?us-ascii?Q?yeakYrtUHhYTsn2qMijCscavzRBu5GyuTm3SBLwGeWCPEr3ThfbNksifNd9r?=
 =?us-ascii?Q?JU8bWIZA7gySX04Apox0ZwD2uniKBzQaHmi2JADWBV6UrwqcfolVWtmpAUw4?=
 =?us-ascii?Q?rbGwe5BrANP+2ygJkeA2ZKm2H1RXV7N7fIGEsXRrx+1ThUzwC/Fi5YkqIYWH?=
 =?us-ascii?Q?payyeSRP6E98Bt6iTs9SkF+jzwisFadPzlON/0ziTdviU/2zVbK3Qa6Hu4b5?=
 =?us-ascii?Q?pUF3ksUEgSycB+g8jhhRTfIuZEsnA+iwndlfWfu40WjJf3NRzd6qQ187exrY?=
 =?us-ascii?Q?voimOGZ6tLsg2Z11XA81QsyavAFsz1gz8pKqSo9n8zCrnZjEn8OVXVB4KLFS?=
 =?us-ascii?Q?WIiU4sJyFwG5eBLnG/H2Cx4Pam/Yl9D0BPSZ77CjpGeTXvQbwIstiRIreAiu?=
 =?us-ascii?Q?sOOIz/nd94W/H2U81Ipjwc6mJdursz1lbqCoEvvRdQffW/HuatyxxKWqZkhv?=
 =?us-ascii?Q?W98+H/qOZIbMFcPgS+dl+G2HeftTasHoZw0Wc4V5i8tFcu2SflLnkTqbykTO?=
 =?us-ascii?Q?etgUGBfcjA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a604f010-3db5-4fcd-eb3f-08df3bcec7ee
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 06:25:41.6638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eseJDHLEOt+D1q4Ki2hQP9dNWi19xUQXCiK0W5wfqoKh8RunEanZCh9sSC2vKVwu7TUAKaPx32qhiZDlKA4UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

On Wed, Oct 14, 2026 at 06:17:44PM +0800, Lucero Palau, Alejandro wrote:
> Hi Richard,
> 
> 
> I think this is good stuff. Just some comments below.
> 
> Thanks!
> 
> 
> On 07/10/2026 10:05, Richard Cheng wrote:
> > devm_cxl_probe_mem() requires a committed region when registering a
> > provider-owned memdev. If FW has not created a region
> 
> 
> This is mixing kernel parlance with BIOS potential actions like setting HDM
> decoders.
> 
>

Hi Alejandro,

I see, I'll rephrase them to be more precise in v3.
 
> > , registration
> > fails before the provider can use the endpoint topology to provision
> > one.
> > 
> > Make the attachment probe callback optional while retaining a non-NULL
> > descriptor to preserve provider ownership and handling of CXL link loss.
> > Install endpoint cleanup for FW-discovered provider regions even when
> > the provider never requests attachment.
> > 
> > This establishes the registration and attachment APIs needed for
> > explicit region provisioning without introducing region creation or
> > allocation policy.
> > 
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> > Changelog:
> > 
> > v1 -> v2:
> > - Rework the patch into a registration/attachment refactor, following
> >    Alejandro's request to separate region provisioning from memdev
> > registration.
> > - Add devm_cxl_register_mem() to establish a provider-owned memdev and
> >    its endpoint without requiring a comitted region.
> > - Add devm_cxl_attach_mem_region() to obtain the HPA range of an
> >    existing committed, single-target region after registration.
> > - Make the region probe callback optional while preserving provider
> >    ownership, synchronous endpoint setup, and hdling of CXL link loss.
> > ---
> >   drivers/cxl/core/region.c | 146 ++++++++++++++++++++++++++------------
> >   drivers/cxl/cxlmem.h      |  22 ++++--
> >   drivers/cxl/mem.c         |  69 +++++++++++++++++-
> >   include/cxl/cxl.h         |   2 +
> >   4 files changed, 188 insertions(+), 51 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 5ef0ca0694ff..7a64a730587d 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -4111,67 +4111,123 @@ static int first_mapped_decoder(struct device *dev, const void *data)
> >   	return 0;
> >   }
> > -/*
> > - * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
> > - * simple case of single mapped decoder per memdev.
> > - */
> > -int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
> > +static int unregister_memdev_region(struct device *dev, void *data)
> >   {
> > -	struct cxl_attach_region *attach =
> > -		container_of(cxlmd->attach, typeof(*attach), attach);
> > -	struct cxl_port *endpoint = cxlmd->endpoint;
> >   	struct cxl_endpoint_decoder *cxled;
> >   	struct cxl_region *cxlr;
> > -	int rc;
> > -	/* hold endpoint lock to setup autoremove of the region */
> > +	if (!is_endpoint_decoder(dev))
> > +		return 0;
> > +
> > +	cxled = to_cxl_endpoint_decoder(dev);
> > +	scoped_guard(rwsem_read, &cxl_rwsem.region) {
> > +		cxlr = cxled->cxld.region;
> > +		if (!cxlr)
> > +			return 0;
> > +		get_device(&cxlr->dev);
> > +	}
> > +
> > +	/* Unregistration needs the region write lock. */
> > +	endpoint_unregister_region(cxlr);
> > +	return 0;
> > +}
> > +
> > +static void endpoint_unregister_regions(void *data)
> > +{
> > +	struct cxl_port *endpoint = data;
> > +
> > +	device_for_each_child(&endpoint->dev, NULL, unregister_memdev_region);
> > +}
> > +
> > +int cxl_memdev_setup_region_cleanup(struct cxl_memdev *cxlmd)
> > +{
> > +	struct cxl_port *endpoint = cxlmd->endpoint;
> > +
> > +	device_lock_assert(&cxlmd->dev);
> > +	if (IS_ERR_OR_NULL(endpoint))
> > +		return -ENXIO;
> > +
> >   	guard(device)(&endpoint->dev);
> > -	if (!endpoint->dev.driver)
> > +	if (!endpoint->dev.driver || endpoint->dead)
> >   		return -ENXIO;
> > -	guard(rwsem_read)(&cxl_rwsem.region);
> > -	guard(rwsem_read)(&cxl_rwsem.dpa);
> >   	/*
> > -	 * TODO auto-instantiate a region, for now assume this will find an
> > -	 * auto-region
> > +	 * Endpoint probe may discover provider-owned firmware regions even if
> > +	 * the provider never requests their HPA range. Run before decoder
> > +	 * teardown so those regions are unregistered, not just detached.
> >   	 */
> 
> 
> I would put this as a description for the function instead of a comment
> here.
> 
> 

Sure thing.


> > -	struct device *dev __free(put_device) =
> > -		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
> > -
> > -	if (!dev) {
> > -		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
> > -			dev_name(&cxlmd->dev));
> > -		return -ENXIO;
> > -	}
> > +	return devm_add_action_or_reset(&endpoint->dev,
> > +				      endpoint_unregister_regions, endpoint);
> > +}
> > +EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_setup_region_cleanup, "cxl_mem");
> > -	cxled = to_cxl_endpoint_decoder(dev);
> > -	cxlr = cxled->cxld.region;
> > +/* Caller holds the memdev lock; attach to a single mapped decoder. */
> > +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd, struct range *hpa_range)
> > +{
> > +	struct cxl_port *endpoint = cxlmd->endpoint;
> > +	struct cxl_endpoint_decoder *cxled;
> > +	struct cxl_region *cxlr;
> > +	int rc;
> > -	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
> > -		dev_dbg(cxlmd->cxlds->dev,
> > -			"region %s not committed for memdev %s\n",
> > -			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
> > +	device_lock_assert(&cxlmd->dev);
> > +	if (IS_ERR_OR_NULL(endpoint))
> >   		return -ENXIO;
> > -	}
> > -	if (cxlr->params.nr_targets > 1) {
> > -		dev_dbg(cxlmd->cxlds->dev,
> > -			"Only attach to local non-interleaved region\n");
> > +	/* hold endpoint lock to setup autoremove of the region */
> > +	guard(device)(&endpoint->dev);
> > +	if (!endpoint->dev.driver || endpoint->dead)
> >   		return -ENXIO;
> > -	}
> > -	/* Only teardown regions that pass validation, ignore the rest */
> > -	get_device(&cxlr->dev);
> > -	rc = devm_add_action_or_reset(&endpoint->dev,
> > -				      endpoint_unregister_region, cxlr);
> > -	if (rc)
> > -		return rc;
> > +	scoped_guard(rwsem_read, &cxl_rwsem.region) {
> > +		guard(rwsem_read)(&cxl_rwsem.dpa);
> > -	attach->hpa_range = (struct range) {
> > -		.start = cxlr->params.res->start,
> > -		.end = cxlr->params.res->end,
> > -	};
> > -	return 0;
> > +		struct device *dev __free(put_device) =
> > +			device_find_child(&endpoint->dev, NULL,
> > +					  first_mapped_decoder);
> > +		if (!dev) {
> > +			dev_dbg(cxlmd->cxlds->dev,
> > +				"no region found for memdev %s\n",
> > +				dev_name(&cxlmd->dev));
> > +			return -ENXIO;
> > +		}
> > +
> > +		cxled = to_cxl_endpoint_decoder(dev);
> > +		cxlr = cxled->cxld.region;
> > +		if (cxlr->params.state < CXL_CONFIG_COMMIT) {
> > +			dev_dbg(cxlmd->cxlds->dev,
> > +				"region %s not committed for memdev %s\n",
> > +				dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
> > +			return -ENXIO;
> > +		}
> > +
> > +		if (cxlr->params.nr_targets > 1) {
> > +			dev_dbg(cxlmd->cxlds->dev,
> > +				"Only attach to local non-interleaved region\n");
> > +			return -ENXIO;
> > +		}
> > +		if (!cxlr->params.res)
> > +			return -ENXIO;
> > +
> > +		/* Only teardown regions that pass validation, ignore the rest. */
> > +		if (!devm_is_action_added(&endpoint->dev,
> > +					  endpoint_unregister_region, cxlr)) {
> > +			get_device(&cxlr->dev);
> > +			rc = devm_add_action(&endpoint->dev,
> > +					     endpoint_unregister_region, cxlr);
> > +			if (rc)
> > +				break;
> > +		}
> > +
> > +		*hpa_range = (struct range) {
> > +			.start = cxlr->params.res->start,
> > +			.end = cxlr->params.res->end,
> > +		};
> > +		return 0;
> > +	}
> > +
> > +	/* devm_add_action() failed; teardown needs the region write lock. */
> > +	endpoint_unregister_region(cxlr);
> > +	return rc;
> >   }
> >   EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index c401e3a1af06..8c050bc308bd 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -97,6 +97,13 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
> >   	return is_cxl_memdev(port->uport_dev);
> >   }
> > +/**
> > + * struct cxl_memdev_attach - provider ownership and CXL link requirements
> > + * @probe: optional region probe callback, called with the memdev locked
> > + *
> > + * A non-NULL descriptor requires successful synchronous endpoint setup and
> > + * preserves provider ownership even when no region probe is requested.
> > + */
> >   struct cxl_memdev_attach {
> >   	int (*probe)(struct cxl_memdev *cxlmd);
> >   };
> > @@ -107,8 +114,8 @@ struct cxl_memdev_attach {
> >    * @hpa_range: physical address range of the region
> >    *
> >    * For the common simple case of a CXL device with private (non-general purpose
> > - * / "accelerator") memory, enumerate firmware instantiated region, or
> > - * instantiate a region for the device's capacity. Destroy the region on detach.
> > + * / "accelerator") memory, enumerate a firmware-instantiated region and
> > + * report its range. Destroy the region on detach.
> >    */
> >   struct cxl_attach_region {
> >   	struct cxl_memdev_attach attach;
> > @@ -116,12 +123,19 @@ struct cxl_attach_region {
> >   };
> >   #ifdef CONFIG_CXL_REGION
> > -int cxl_memdev_attach_region(struct cxl_memdev *cxlmd);
> > +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd, struct range *hpa_range);
> > +int cxl_memdev_setup_region_cleanup(struct cxl_memdev *cxlmd);
> >   #else
> > -static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
> > +static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd,
> > +					   struct range *hpa_range)
> >   {
> >   	return -EOPNOTSUPP;
> >   }
> > +
> > +static inline int cxl_memdev_setup_region_cleanup(struct cxl_memdev *cxlmd)
> > +{
> > +	return 0;
> > +}
> >   #endif
> >   struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds);
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 3959ec963026..aa08d88ab104 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -172,7 +172,10 @@ static int cxl_mem_probe(struct device *dev)
> >   	}
> >   	if (cxlmd->attach) {
> > -		rc = cxlmd->attach->probe(cxlmd);
> > +		if (cxlmd->attach->probe)
> > +			rc = cxlmd->attach->probe(cxlmd);
> > +		else
> > +			rc = cxl_memdev_setup_region_cleanup(cxlmd);
> >   		if (rc)
> >   			return rc;
> >   	}
> > @@ -215,6 +218,68 @@ struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds)
> >   }
> >   EXPORT_SYMBOL_NS_GPL(devm_cxl_add_classdev, "CXL");
> > +/**
> > + * devm_cxl_register_mem - Register a provider-owned CXL memory device
> > + * @cxlds: CXL device state to associate with the memdev
> > + *
> > + * Establish the CXL port topology and endpoint synchronously, without requiring
> > + * a committed region. The provider retains ownership of its memory, including
> > + * any firmware-discovered regions, and must detach if the CXL link is lost.
> > + *
> > + * The parent of the resulting device and the devm context for allocations is
> > + * @cxlds->dev. Returns the registered memdev or an ERR_PTR() on failure.
> > + */
> > +struct cxl_memdev *devm_cxl_register_mem(struct cxl_dev_state *cxlds)
> > +{
> > +	struct cxl_memdev_attach *attach;
> > +
> > +	attach = devm_kzalloc(cxlds->dev, sizeof(*attach), GFP_KERNEL);
> > +	if (!attach)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	return __devm_cxl_add_memdev(cxlds, attach);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(devm_cxl_register_mem, "CXL");
> > +
> > +/**
> > + * devm_cxl_attach_mem_region - Attach a registered memdev to its region
> > + * @cxlmd: provider-owned memdev returned by devm_cxl_register_mem()
> > + * @hpa_range: CXL.mem physical address range result
> > + *
> > + * Attach to an existing committed, single-target region. This does not create
> > + * or program a region. Repeated attachment to the same region returns the same
> > + * range without adding another cleanup action. Failure leaves the memdev
> > + * registered so that the provider can decide how to proceed.
> > + *
> > + * The region is removed when the endpoint detaches. Returns zero on success or
> > + * a negative errno; @hpa_range is empty on failure.
> > + */
> > +int devm_cxl_attach_mem_region(struct cxl_memdev *cxlmd,
> 
> 
> is this devm prefix required here?
> 
> 

I do think so, the helper here can install an EP-managed region-unregistration
operation, so attachment has a managed lifetime side effect in addition to
just returning the HPA range. That's why I used the devm_ prefix.

Is that acceptable ?

Best regards,
Richard Cheng.


> > +			       struct range *hpa_range)
> > +{
> > +	if (!hpa_range)
> > +		return -EINVAL;
> > +	*hpa_range = DEFINE_RANGE(0, -1);
> > +
> > +	if (!cxlmd->attach)
> > +		return -EINVAL;
> > +
> > +	guard(device)(&cxlmd->dev);
> > +	if (!cxlmd->dev.driver || !cxlmd->cxlds)
> > +		return -ENXIO;
> > +
> > +	return cxl_memdev_attach_region(cxlmd, hpa_range);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(devm_cxl_attach_mem_region, "CXL");
> > +
> > +static int cxl_probe_mem_region(struct cxl_memdev *cxlmd)
> > +{
> > +	struct cxl_attach_region *attach =
> > +		container_of(cxlmd->attach, typeof(*attach), attach);
> > +
> > +	return cxl_memdev_attach_region(cxlmd, &attach->hpa_range);
> > +}
> > +
> >   /**
> >    * devm_cxl_probe_mem - Add a CXL memory device and probe its region
> >    * @cxlds: CXL device state to associate with the memdev
> > @@ -242,7 +307,7 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
> >   	*attach = (struct cxl_attach_region) {
> >   		.attach = {
> > -			   .probe = cxl_memdev_attach_region,
> > +			   .probe = cxl_probe_mem_region,
> >   		},
> >   		.hpa_range = { 0, -1 },
> >   	};
> > diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> > index 802b143de83d..3019e3ea5f09 100644
> > --- a/include/cxl/cxl.h
> > +++ b/include/cxl/cxl.h
> > @@ -224,6 +224,8 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
> >   						      sizeof(drv_struct), mbox);	\
> >   	})
> > +struct cxl_memdev *devm_cxl_register_mem(struct cxl_dev_state *cxlds);
> > +int devm_cxl_attach_mem_region(struct cxl_memdev *cxlmd, struct range *hpa_range);
> >   struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
> >   				      struct range *range);
