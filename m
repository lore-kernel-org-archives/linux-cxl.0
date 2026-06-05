Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B887C3EEAF0
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627146; cv=fail; b=U3CXjGydnfIXMb9Z9ANFfVzGaq/tjg4O5u4c/PZN+ynFaNCbXSu6RwPENTEDRqbTKS0GK3Z6W5ywLRsLR9v+tdkTNcUuFbNtgXMjuAao4t1IZvCkWbhknayjtP6mCZ4or+EioLI11W557F5/9mwzV3NlxYU86+jkSrjpADfOM3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627146; c=relaxed/simple;
	bh=9qRSSq55gwgy6HaIIGWHaHuaScn96x/8o0mjH6HRvk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TRLAK3oiEhYbRG/Ul57xTepGok1xMg5WE3bCsVqm/H09Upf1u+bqBZQWVBB6wijc0U3hMkWQ/CmtjWjTiN7+hI9F1GjWCLgOdwjis1wPROBA10Q5sLZIBdMTnyqTRZjnkGVzGjxBlO7udcX693+VJLHka1ljVjkKNzOOTOQRdmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V+t+gqw0; arc=fail smtp.client-ip=52.101.48.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V+t+gqw0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3g4QLJ3Evf7DfJil4RlLKVaNdBAWVO7uqeLWsMTr5ni9I3lbgh92AeYOboSjkp/fRZVVLe68cISu1Mti/viTxoczYQeTJMqu4Ob+mikYu1MpA3OYC+MdODC5tujNLrjom/NOdY1+Uv6ywK1SzH8+fWDSyrAA+QglNNyG6fdiDWQcrn6WuMA8MEadAb+DJ+oOqakX08CkbKpX7cIn+wYufxvlGcTmlPqItzBF9trOc1QuyhJRIkqC+vHa3q1vcpPlBF5syfO4wnW64DqhVMnXVNGuGLtIuHRC2i0lqEQyQ3qAWQpqK0AU/PiUSs33GVkfQmRY8t751m/7cHsPPBXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6o5UdOBZhxRPiW69CQuy13EcklEFLktKSZ+0Ndf6+BA=;
 b=PzDjhTtEZAGsT+s6Jfx4IIGJTiZMGiFbyEHJ/SkRSam7oP9ElJ5ZHqg/ymx4wM5sFR/+9PyXyYdFpUzqOyj4x9F1bJ7BCfy//Ubx68pBaN6/qvShnWWCfHcqY0oQU61YZb/R93OCWCZM/dfoCrfOF80UQACZZ4dYz5+KKryjB5qZdiuPIzdKzeDBvq7qMNxYOL+IBsEaslsDL9Tatbkn95wBVLmBz4qvfk5njL+GwaIcqtWqh3rY1LeHa4CzN14orHBJLk9L5oD+msnonU2Xbzpgunrp1YYXiT9cTBhI3ASPIPVbonV6G4YIZPPM4WpGCLapKIE6GSK+nDoR0PwmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6o5UdOBZhxRPiW69CQuy13EcklEFLktKSZ+0Ndf6+BA=;
 b=V+t+gqw0uUbpKv8kYR9hD4I2lgwqen5CS5ZClnXNlOcOchAwUTKgv7LpF5RybaFTbtiaKOlYoftm0bDsvTacf/6qE0buEwlUwY4I7Fzgx5KULAmVD6AW5hvBbUG9nJtZzZXHwRpgJzV2X/AEMXq7JMkook3aeim9NjavnjoxJ/VrmNlaf6Nbq1rkfsfu/yKT2BOcAJX4OknK1RQbz8GGEMdzLgUGLKRNbNlfzB64MpUQ5s++eCod1qPJqcTm2yViJNPPYCvZcwqD25LghfpxDezFhuwdHGhtv+Qj8vK02r5WeWZqUpFV98kGyPI4hZxFD5Jjq2xz6M9k1jQjGRm4RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 02:38:52 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 02:38:52 +0000
Date: Fri, 5 Jun 2026 10:38:45 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org, 
	benjamin.cheatham@amd.com, alucerop@amd.com, alison.schofield@intel.com, gourry@gourry.net, 
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 0/5] cxl: Support Back-Invalidate
Message-ID: <aiI2Y6su1iAmOXxL@MWDK4CY14F>
References: <20260605003329.2584012-1-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605003329.2584012-1-dave@stgolabs.net>
X-ClientProxiedBy: KU0P306CA0083.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::14) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a2751b-2fa7-4c57-384d-08dec2ab94af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|56012099006|3023799007|5023799004|11063799006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9cRs9hK3CLx3b6LZnUmUZlBEWlyTAF1yQsGRQ2XQQ1O1DnhX80Sa34zOnI9gPlGSHvLxoPpPp8EDSziqdtLa7/Iz3FS0VjYry4ajRUvkZezxNYV2td8hda2N5sXJHg35HvuS2DRbds+aLLPrCzAMrMW997HhIqUO5mi6DEPGWxQHB7gs8v1kzvw2ShEv1sJdwloUjVq37jdAU4EYPYtfsuDIJJsulqPSCTG6vH6wyWljJgkeFMEwX/61ETQQJQVb/5gf6G5xY06rAuvsxE+S/phzGvBldnX6GODrjyFD17UpEe2vMa/XvBZ81m71viLRplY+Dbt2cfVAMNm7pe7AIMHTOaushsPs/n8BBzlNCdmpu9gX+/sDdr0DFzDr+LT+b66C7KJdnnrmjjwdqcM9RwFeP3jHNeL4mxc/wbMYIotjjcLPi/fRCYeh9FeIrdUSRxfIV97mMrBvZjrGxUrZ+dlZ+To98n36VKThXwisJOdT7oosYTttaKmPyEc9Yz/GWVXEeKWmKoyG4FNla3pWXdOeuF3tlH0p8qGKsXUizUKhqXM7lAeP/Ni6bd9eA5linDKm7/aS0cY10PMP5Q7+zkitWSol46K3EIgxX2d27VKjJsrhXolDyFBfY3xkrtbWoGKlMzvBDbC7xIbJGGy4yGTQlPgpwAw7W5hiELd42MkV3MKzICmWle7TDROuc+ysA20eczb0jqfx5XYylgxCFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(56012099006)(3023799007)(5023799004)(11063799006)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8sbs3w3Gp6m16XnBKY+W1iRadTkBvI+/aiZfmpmzGKc0ZW4dGpggRvRW05EX?=
 =?us-ascii?Q?Rhn38yZuMZIV8COB0iPOHqFV5W+F/SGkRXt0F7mhmPcYIHKyrZ2PogjZiVyD?=
 =?us-ascii?Q?9O85O8tFVxvBDiUXUpwvx49ZVRiO1nkgSHaJCvAxbyFdmSkvZKBZA64qTNHC?=
 =?us-ascii?Q?TbNdIQhP6fXMaxr2lL5NYt3f8RKGYOcSwaHrN3Qy7sIFPkd7C0/vDdjx+6eh?=
 =?us-ascii?Q?npVOIt5yRAEMOYia/NqMPame9U6rNqykDfUyTKmBB7yvKnIi97NTmDX6ZwYp?=
 =?us-ascii?Q?SzWaa4C0lF+GmuUeDdd8z4ZkRYYA6zUVIklRWnzJT1UdTLoLHvmOx2x8Nn3B?=
 =?us-ascii?Q?3pSA5Y3dUU8rLCeojBIbPFzNUm49Q+6mY5XXJkupY/9VQrQIhfDPtW2HDH5a?=
 =?us-ascii?Q?AS98h7LHowNUTPprsQH5VENItN4KtQKx67IdbArhDTi8qRtnN/C71hT+w7n7?=
 =?us-ascii?Q?8dWTVLp4LTJXA5uVTHSdtYISKyNxdbfzO1LjmgKwlJaep1NDKUhpMvbLGhPc?=
 =?us-ascii?Q?8pd9Gp8tnfTjsq543yFAbGOeL2QmeFszChKkwg1kAVSKJUKnsaRSaDlPf0bn?=
 =?us-ascii?Q?j5i2VDYzxL2O4xa97QL8KyoYLQHkU8HksvNpv4Rab0LFRjd7yJg87q+veQFo?=
 =?us-ascii?Q?AxlkhIqGqNkxA5exLkdxpxCWefJcu/0CjIxFpHHTVijXkPWG7XvY2WmQDwTA?=
 =?us-ascii?Q?ZD/6W8Q98ux5QVPQImIOKX8/9cwTm6B677/g8i/rI5yKWDhL3hpprMFYrX4m?=
 =?us-ascii?Q?hVsnxNnAMWq4eoe7mAMTe+LHFHMxI5SvsjuL5D1mGL3Jx4whx2blyHVVmcBW?=
 =?us-ascii?Q?On1fM8TMe7TPdyUdLD0BG39jjdQlMqWAi44O/LAFpUxKPTqm2bqCRNL1Pzvl?=
 =?us-ascii?Q?HGwUPXoBlLZszLb0cG9CxXy0XEPJOooratbnUt2dCKpv79Rtl/d5y0TWnm0G?=
 =?us-ascii?Q?64fXaqWPxwSwwjhCzyL/HnvQnw1h3iEBjdAy3JGfXGJEJliB/lgdjtHiKfNF?=
 =?us-ascii?Q?RrhtXbgDbW31N4KP0csimxTnAxtvl9U4EV9DPmBTYE4wsZh3Tw+0DxBeoUSZ?=
 =?us-ascii?Q?uFhQdiexeI/rmfLmyjz/KMPj+L6Uo86zNWjd9O9Gq71kK3Q5MvYd9nyz6j+U?=
 =?us-ascii?Q?Jmh0ICcslCemI1hxxkY6O6hZBghcCxa/kxOpO7oIEVW9tcvP0gKLy94jufb5?=
 =?us-ascii?Q?UTNEZ0KAImuNomDNfvGTult75Q9T981I1JeYRr6w0MYJSU5LiuLGqMWekj3c?=
 =?us-ascii?Q?JDr7ntOLWqwb5i3BFaknyxnxwoX2QVCjqauBW3TGLsrPpDytkpt2hCBkXzss?=
 =?us-ascii?Q?g0vBemRtWmfANmzuhRDVXq4ynpng/tldR4c0m6Lg6ql/0w2+XIX7CHoiCZJA?=
 =?us-ascii?Q?yxJ4ghrOP/40TYpyZxtqgI6S6Sz+jHSRAQS5t0Hg1BCck0HNX8hidKmiUdyZ?=
 =?us-ascii?Q?kjzN7doVoWwaSwEB/luthXSZWYgV6R4RwL8IXVnM9X84Iuq26+I05EGiFVpu?=
 =?us-ascii?Q?rA76OXPz1OX3+rV4YFyyAsB7vfISbnBEP6BrocYNL1jETnbUtkJfJlvaqESa?=
 =?us-ascii?Q?pmb1t13VxcXF24RD4DgVbiRP/9r1UdqDKWCBKNS/8bRavmCCOW7uvdnczCya?=
 =?us-ascii?Q?x7l1jSOp8ohLbdBBOUzlYRdspu9w1H06w92X/t9imK96WF7+V+RqIPCgBA1n?=
 =?us-ascii?Q?BJHg0YZdVNhR+X6Exi/oZ/Kyb3/2TAyCiPBYxaaz5HZDNQmmmy1oHVkl7Ttf?=
 =?us-ascii?Q?wkFKbGnTog=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a2751b-2fa7-4c57-384d-08dec2ab94af
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 02:38:52.4710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TbvsgIQeH38a+5/hCluMyo6h0rdxjMXA2hSjV1x9HeeQ6Pdgst4mLbk1bWWsGfH4X5Vb7f/6evCMh4BNLQhWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638

On Thu, Jun 04, 2026 at 05:33:24PM +0800, Davidlohr Bueso wrote:
> Hello,
> 
> Changes from v3 (https://lore.kernel.org/all/20260516022037.1761453-1-dave@stgolabs.net/):
>  - In patch 1, map BI Decoder of root port/DSP at dport creation time
>    in cxl_port_add_dport() (Ben).
>  - In patch 2, BI rt/decoder commit logic to be a function instead
>    of a macro approach. (Dave)
>  - Patch 4 is reworked to have endpoint decoders use the coherency
>    model based on the root decoder's cfmw restrictions (Dan).   
>  - Folded patch 5 into patch 2 (Dave)
>  - Moved 'nr_bi' counter from port to dport (Sashiko).
>  - Added a new patch 5 for a trivial flag rename.
>

Hi Davidlohr,
All the above patches lacks of v4 tag,
small nit pick but it confuses me at first,
maybe add the tags to every patches in the patch series.

Best regards,
Richard Cheng.
 
> This series is the initial plumbing to enable HDM-DB in Linux. The
> model allows Type 2 and Type 3 devices to expose their local memory
> to the host CPU in a coherent manner. In alignment with what was
> discussed at 2024 LPC type2 support session, this series takes the
> Type 3 memory expander approach, which is more direct. Further,
> afaik there is no Type 2 + BI hardware out there.
> 
> A flagship use case of Type 3 + BI is coherent shared memory, and
> there is currently a big gap in this regard (ie: GFAM). Another
> is P2P via PCIe UIO, which is also lacking today. Media Operation
> (4402h) for ranged sanitize/zero also trigger snoops and there are
> some patches out there[0]. As such this series focuses on BI enablement
> in terms of discovery and configuration.
> 
> The idea is for Type 3 memdevs and future Type 2 devices to make use
> of cxlds->bi when committing HDM decoders, such that different device
> coherence models can be differentiated as:
> 
> 	type2 hdm-d:  cxlds->type == CXL_DEVTYPE_DEVMEM && cxlds->bi == false
> 	type2 hdm-db: cxlds->type == CXL_DEVTYPE_DEVMEM && cxlds->bi == true
> 	type3 hdm-h:  cxlds->type == CXL_DEVTYPE_CLASSMEM && cxlds->bi == false
> 	type3 hdm-db: cxlds->type == CXL_DEVTYPE_CLASSMEM && cxlds->bi == true
> 
> Because ->bi becoming true does not depend on auto-committing upon HDM
> decoder enumeration (port driver), for now an already-committed BI
> decoder during enumeration is unsupported and the driver errors out.
> 
> o Patch 1 probes BI capabilities during register discovery, and maps BI
>   Decoder registers.
>   
> o Patch 2 implements the BI-ID allocation (and deallocation).
>   
> o Patch 3 adds coherency support for endpoint decoders based on what the
> root decoder restricts.
> 
> o Patch 4 adds support for HDM-DB region creation.
> 
> o Patch 5 trivially renames some coherency flags.
> 
> Testing has been done with the qemu HDM-DB Type 3 counterpart + this series:
>   https://lore.kernel.org/all/20260602231806.2469011-1-dave@stgolabs.net/
> 
> 1. HDM Decoder with BI through ad-hoc region creation.
> ------------------------------------------------------
> # cxl list -D
> [
>   {
>     "decoder":"decoder0.0",
>     "resource":4563402752,
>     "size":10737418240,
>     "interleave_ways":1,
>     "accelmem_capable":true,
>     "nr_targets":1
>   }
> ]
> 
> # ROOT=/sys/bus/cxl/devices/decoder0.0
> # EP=/sys/bus/cxl/devices/decoder2.0
> # echo region0 > $ROOT/create_ram_region
> # REG=/sys/bus/cxl/devices/region0
> # echo ram > $EP/mode
> # echo 0x40000000 > $EP/dpa_size
> # echo 1 > $REG/interleave_ways
> # echo 4096 > $REG/interleave_granularity
> # echo 0x40000000 > $REG/size
> # cat $EP/bi
> 0
> # echo decoder2.0 > $REG/target0
> [   53.495224] cxl_core:cxl_port_attach_region:1290: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps:1
> [   53.497758] cxl_core:cxl_port_attach_region:1290: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_ep1
> [   53.499892] cxl_core:cxl_port_setup_targets:1608: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
> [   53.501233] cxl_core:cxl_port_setup_targets:1633: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
> [   53.502985] cxl_core:cxl_calc_interleave_pos:2003: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x110000
> [   53.504895] cxl_core:cxl_region_attach:2226: cxl decoder2.0: Test cxl_calc_interleave_pos(): success test_pos:0 cxled->pos:0
> # cat $EP/bi
> 1
> # echo 1 > $REG/commit
> # cxl list -D
> [
>   {
>     "root decoders":[
>       {
>         "decoder":"decoder0.0",
>         "resource":4563402752,
>         "size":10737418240,
>         "interleave_ways":1,
>         "accelmem_capable":true,
>         "nr_targets":1
>       }
>     ]
>   },
>   {
>     "port decoders":[
>       {
>         "decoder":"decoder1.0",
>         "resource":4563402752,
>         "size":1073741824,
>         "interleave_ways":1,
>         "region":"region0",
>         "nr_targets":1
>       }
>     ]
>   },
>   {
>     "endpoint decoders":[
>       {
>         "decoder":"decoder2.0",
>         "resource":4563402752,
>         "size":1073741824,
>         "interleave_ways":1,
>         "region":"region0",
>         "dpa_resource":0,
>         "dpa_size":1073741824,
>         "mode":"ram"
>       }
>     ]
>   }
> ]
> 
> 2. Type3 device does not support BI, but CFMW has BI restriction
> ----------------------------------------------------------------
> # echo decoder2.0 > $REG/target0
> [  104.557797] cxl region0: mem0:decoder2.0 BI not enabled on device
> [  104.561014] cxl_port endpoint2: failed to attach decoder2.0 to region0: -6
> 
> 3. Type3 device supports BI but CFMW does not, create HDM-H region
> ------------------------------------------------------------------
> # cxl list -D
> [
>   {
>     "decoder":"decoder0.0",
>     "resource":4563402752,
>     "size":10737418240,
>     "interleave_ways":1,
>     "max_available_extent":10737418240,
>     "pmem_capable":true,
>     "volatile_capable":true,
>     "nr_targets":1
>   }
> ]
> # echo decoder2.0 > $REG/target0
> [  124.712027] cxl_core:cxl_port_attach_region:1290: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps:1
> [  124.714329] cxl_core:cxl_port_attach_region:1290: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_ep1
> [  124.716407] cxl_core:cxl_port_setup_targets:1608: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
> [  124.718269] cxl_core:cxl_port_setup_targets:1633: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
> [  124.722076] cxl_core:cxl_calc_interleave_pos:2003: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x110000
> [  124.724454] cxl_core:cxl_region_attach:2226: cxl decoder2.0: Test cxl_calc_interleave_pos(): success test_pos:0 cxled->pos:0
> # cxl list -D
> [
>   {
>     "root decoders":[
>       {
>         "decoder":"decoder0.0",
>         "resource":4563402752,
>         "size":10737418240,
>         "interleave_ways":1,
>         "max_available_extent":9663676416,
>         "pmem_capable":true,
>         "volatile_capable":true,
>         "nr_targets":1
>       }
>     ]
>   },
>   {
>     "port decoders":[
>       {
>         "decoder":"decoder1.0",
>         "resource":4563402752,
>         "size":1073741824,
>         "interleave_ways":1,
>         "region":"region0",
>         "nr_targets":1
>       }
>     ]
>   },
>   {
>     "endpoint decoders":[
>       {
>         "decoder":"decoder2.0",
>         "resource":4563402752,
>         "size":1073741824,
>         "interleave_ways":1,
>         "region":"region0",
>         "dpa_resource":0,
>         "dpa_size":1073741824,
>         "mode":"ram"
>       }
>     ]
>   }
> ]
> 
> 
> 3. Unbind + Bind
> ----------------
> # echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
> [ 64.553865] cxl_core:__cxl_bi_ctrl_endpoint:1163: cxl_pci 0000:0d:00.0: BI requests disabled
> [ 64.557464] cxl_core:cxl_port_commit_reap:898: cxl_port port1: reap: decoder1.0 commit_end: -1
> [ 64.559529] cxl_core:cxl_port_commit_reap:898: cxl_port endpoint2: reap: decoder2.0 commit_end: -1
> [ 64.563576] cxl_core:cxl_detach_ep:1541: cxl_mem mem0: disconnect mem0 from port1
> 
>  echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
> [ 5073.975585] cxl_core:devm_cxl_enumerate_ports:1856: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
> [ 5073.978125] cxl_core:devm_cxl_enumerate_ports:1862: cxl_mem mem0: found already registered port port1:pci0000:0c
> [ 5073.980013] cxl_core:cxl_port_alloc:752: cxl_mem mem0: host-bridge: pci0000:0c
> [ 5073.982601] cxl_core:cxl_cdat_get_length:488: cxl_port endpoint2: CDAT length 160
> [ 5073.988634] cxl_core:cxl_port_perf_data_calculate:207: cxl_port endpoint2: Failed to retrieve ep perf coordinates.
> [ 5073.991824] cxl_core:cxl_endpoint_parse_cdat:423: cxl_port endpoint2: Failed to do perf coord calculations.
> [ 5074.016377] cxl_core:init_hdm_decoder:1112: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 4096
> [ 5074.021643] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
> [ 5074.023072] cxl_core:init_hdm_decoder:1112: cxl_port endpoint2: decoder2.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
> [ 5074.025527] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.1 added to endpoint2
> [ 5074.027751] cxl_core:init_hdm_decoder:1112: cxl_port endpoint2: decoder2.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
> [ 5074.032182] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.2 added to endpoint2
> [ 5074.033535] cxl_core:init_hdm_decoder:1112: cxl_port endpoint2: decoder2.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
> [ 5074.035690] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.3 added to endpoint2
> [ 5074.036904] cxl_core:cxl_bus_probe:2281: cxl_port endpoint2: probe: 0
> [ 5074.038017] cxl_core:devm_cxl_add_port:960: cxl_mem mem0: endpoint2 added to port1
> [ 5074.039153] cxl_core:__cxl_bi_ctrl_endpoint:1163: cxl_pci 0000:0d:00.0: BI requests enabled
> [ 5074.040168] cxl_core:cxl_bus_probe:2281: cxl_mem mem0: probe: 0
> 
> 
> 4. Discovery behind a Switch
> ----------------------------
> # dmesg | grep BI
> [    0.628477] cxl_core:cxl_probe_component_regs:102: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
> [    0.737987] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
> [    0.747784] cxl_port:cxl_port_map_bi:109: cxl_port port2: BI RT registers not found
> [    0.755151] cxl_core:cxl_probe_component_regs:96: cxl_port port2: found BI RT capability (0xaa8)
> [    0.790106] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
> [    0.943920] cxl_core:__cxl_bi_wait_commit:994: pcieport 0000:0e:00.0: BI-ID commit wait took 101750us
> [    0.944767] cxl_core:__cxl_bi_ctrl_endpoint:1163: cxl_pci 0000:0f:00.0: BI requests enabled
> 
> 5. Corrupted hw (commit timeout handling)
> -----------------------------------------
> [    0.617234] cxl_core:cxl_probe_component_regs:102: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
> [    0.706959] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
> [    0.718585] cxl_port:cxl_port_map_bi:109: cxl_port port2: BI RT registers not found
> [    0.743932] cxl_core:cxl_probe_component_regs:96: cxl_port port2: found BI RT capability (0xaa8)
> [    0.783715] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
> [    2.994821] cxl_core:__cxl_bi_wait_commit:985: pcieport 0000:0e:00.0: BI-ID commit timed out (2000000us)
> [    5.010606] cxl_core:__cxl_bi_wait_commit:985: pcieport 0000:0e:00.0: BI-ID commit timed out (2000000us)
> [    5.013423] cxl_mem:cxl_mem_probe:155: cxl_mem mem0: BI setup failed rc=-110
> 
> 6. Mixed Configurations (BI-capable Type 3 but DSP 68b)
> -------------------------------------------------------
> [    0.837902] cxl_mem:cxl_mem_probe:155: cxl_mem mem0: BI setup failed rc=-22
> 
> 
> Applies against 'next' branch from cxl.git.
> 
> [0] https://lore.kernel.org/linux-cxl/20260428200410.705675-1-dave@stgolabs.net/
> 
> Thanks!
> 
> Davidlohr Bueso (5):
>   cxl: Add BI register probing and port initialization
>   cxl/pci: Add BI topology enable/disable
>   cxl/hdm: Add BI coherency support for endpoint decoders
>   cxl: Add HDM-DB region creation
>   cxl/hdm: Rename decoder coherency flags
> 
>  Documentation/ABI/testing/sysfs-bus-cxl |  18 +-
>  drivers/cxl/acpi.c                      |  15 +-
>  drivers/cxl/core/hdm.c                  |  38 ++-
>  drivers/cxl/core/pci.c                  | 365 ++++++++++++++++++++++++
>  drivers/cxl/core/port.c                 |  33 ++-
>  drivers/cxl/core/region.c               |  51 ++--
>  drivers/cxl/core/regs.c                 |  14 +
>  drivers/cxl/cxl.h                       |  45 ++-
>  drivers/cxl/cxlmem.h                    |   2 +
>  drivers/cxl/mem.c                       |   4 +
>  drivers/cxl/port.c                      |  71 +++++
>  include/cxl/cxl.h                       |   8 +
>  12 files changed, 631 insertions(+), 33 deletions(-)
> 
> -- 
> 2.39.5
> 
> 
