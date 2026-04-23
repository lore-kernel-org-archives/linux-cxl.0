Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EFB33F5B3
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776976762; cv=fail; b=DXDdTi/yA07nvO6BNClZsRVDHbnysxjoFbTsFSnYDO3GB1yhWFfmDnjwXR+UiFDCAwgoDyK2mUzdxXknf/CqC0ouZ72IWQhtQiqofiT891W3QE2CTg4Zq2kTIPeHdK/fVRYUa5LT+9MTJBT15OpPSAom5WG2BRRmxKWNPTsHDdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776976762; c=relaxed/simple;
	bh=4TVew/6Gm4AfgrBt+RTEfdQ6EQGYz8G3H9SaKTEBp10=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QdZEGkYgpEwvgp7p8GGu73dq6FKaaWpsoCr4JKKnO/CAGGbOt4rDkcX5Hxv1wqx6CiQ+G89MfHBIp20U0/uMqF3LvCiZt2Qy6ZHLjuynWALNVj0UPjxRkbWlhuifBHVknK2PZyGQ5hwI8QFCrY2UovKuCpksjd3DRBejQHPV13s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aq5F2MnM; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aq5F2MnM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776976760; x=1808512760;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4TVew/6Gm4AfgrBt+RTEfdQ6EQGYz8G3H9SaKTEBp10=;
  b=Aq5F2MnM2oL2qx3/N44K3auI8XrLP2F4w6NzUJfb5YrGA6K+k3K1rdIL
   bE1SlymuFMsNLJfFP9QDJ8JpeDAIucMCtZT5VPxRkNxwYLD170fujueI5
   +rlrDZiWQjeFFAjiI5MQ1KIIsL1pk36pUr2O++dLzXro6bx79erh8C18A
   DaFSh51zmNZkDp6mJpAZCfHnleGau4mfo5WvKwYQi8coknNMpKEyaJKZD
   wkdtK8HpUMIlGg2XkatOzCropUka/UvD5AsFjKiONHg4EguWzLa7TDiXa
   jgY/7IQe796o7rjaKQDa2Zi27pYm05WJrvWDchHnFgE7rBMuwEPK774c0
   g==;
X-CSE-ConnectionGUID: eYxraVXaRrSKV43GCI9ELQ==
X-CSE-MsgGUID: j8WXiQtbTYyeAzb3ltUd/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89420940"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="89420940"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 13:39:19 -0700
X-CSE-ConnectionGUID: +tk2xQzjSCavUBT50fcD3A==
X-CSE-MsgGUID: 58HWgz+dTVG1xhq/e24D3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="237821287"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 13:39:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 13:39:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 13:39:18 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 13:39:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3Agb8Oo+ODIdOxJrhFVPASqMQhbgP2J/1qSl6QqJBmBJKgHPurQgWju8PoObKmBH/Bca/KNr1yNRxcP8O5XLEF1PlhPe/9P5VpzuvhhpeyJ1kBJfFkZr4TQERvDv+eFuntyj6tzffOJmro2nODGmuIhKsyhDa9UWhXPg0tA7LpK8VKMVU7d74SWXt4oYa6S2SKRKZhHPXYm2Kx3J0FYUHze2+3xuaB92lO1YLcjRtUdlDEVQ5iIb9iHobx+/2XokmoVqVWQlTPzu1NeMMPA1oh2xSIRDRo0vuqsgT91ceRcpBggp0ZGY2fE0a2r0njLHeSPFg8YgMZ4Q/1TRC9fbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPk3BdfBEfEtOWE3LBTaq9zGM2arEowv5ECa6ekDcjw=;
 b=E58Ko6LumnMB7TXCa0wwELWTZ/MjGp/iLyLLZ+tNTllScbujcnCLoQqO+WNp82tV86RHgBWxUslGVSxDq98fHyavFh/zy9ueYKx+ARou0aTHtN++rK1SBd6C74GR9FkzpZA1PlgO1yVEkMof9ebqoKSnSnfPAweuUbz2bGHjUQKu5DOHWWpTTnu3tRkNIhOcVfmKTShgny5H168fJ/yjHI1hznUAcEpfxBHZZ9lFjne/HsSIWbL1aA/Y+pjJ4eBI6pIwRqaXomTCL4pObcQheMG5CbMAf9An0G5wGFpr9q4c4WzMa+Xsl9p6oaIvM4r0vj+2iV5zxYWbBc6WHPdcRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by CY5PR11MB6344.namprd11.prod.outlook.com
 (2603:10b6:930:3b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 20:39:12 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::9618:33dd:29ce:41d1]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::9618:33dd:29ce:41d1%6]) with mapi id 15.20.9818.017; Thu, 23 Apr 2026
 20:39:12 +0000
Date: Thu, 23 Apr 2026 15:43:14 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Anisa Su <anisa.su887@gmail.com>, Gregory Price <gourry@gourry.net>
CC: Anisa Su <anisa.su887@gmail.com>, <linux-cxl@vger.kernel.org>,
	<john@groves.net>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 00/20] DCD: Remove support for sparse regions & add
 tags
Message-ID: <69ea84629345a_a79ab1008@iweiny-mobl.notmuch>
References: <20260411013958.47422-1-anisa.su@samsung.com>
 <adnWg-60uKmduTsh@gourry-fedora-PF4VCD3F>
 <aefGjpCm8QhwWbHn@4470NRD-ASU.ssi.samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aefGjpCm8QhwWbHn@4470NRD-ASU.ssi.samsung.com>
X-ClientProxiedBy: MW4PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:303:16d::31) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|CY5PR11MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad1de59-7abe-4552-25f6-08dea17860a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|18096099003;
X-Microsoft-Antispam-Message-Info: WLjbFclnql61qqB3ZCj7am8YJfCTr/vn2a+gbBzZekgjL2xZtLM6+bk0rM0UV0MnANFSgIyRnqZFlw/of5g2Sb1NEfPIVjeC4JRLuKioJSsQJU0POsY0kXRne7RCg/Ei2lwAsztWP+5lZWFqoiOAv9OIaVr99F5muxD6eh7yWDZK3ejWtEzM7QSor79a3gAhfZiYuGBnhAxnQMtdYgahL1+VLdFJKAC8azrzgcFKzcXCt9laaXv2AaJIzTSfEmhYt2pZcxOmfF3KALjH2h9sN81CVMod3JmM5EFfy0V6vxDd9UaatdGOUOQ2oPPAiY3RWeCAFEdSbRZzS25nthk82P/XanXklaufZTKzbHqHb7kM7D91U4IH1xtAxadME56BDpRL9/Ilcq58xB1v52qii5NyBNE1+WMQIP3t0YPp7oO5kNZUPT9bBJJ7eDzNT6Cpi+gSnpdn16I421QufOBI5HV46AQMJaf6fDADP+AnJhRWyuHqajr/NVa/qI8iAZWQ9fe2kuthzUCVs42mvZ+0GVtWuyDoEAH9B+HYYS/I2HUnQCQ5MOIoZondD/1rOKA1Fy8ge14WvBVvntHxu9aphz2+0R0+NxmwpmyE24mhqaIsOwWQYhw61yu9phqZQP3dfLxxMuG8dLqFCnoK09m/Y/ziaXLgZB5/LeawdqkpWYYIZNheYlErkQdne4cXZZOun7wM39G2Poqvt3eoXxL6b11MUFRSeAaltUn1ydt7BjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(18096099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mcj18qXD5hteZyNowH2y9qI/sfDiQXmRjD0ViUxBXe59coAHNQ0r0prNiT6S?=
 =?us-ascii?Q?cbUX8cFZ0JsM/y926XIfg03WFnS2nbxN/vvBaLd1wmcZLlXi97rUkDysgucL?=
 =?us-ascii?Q?9xq3g4ulB1cYA7k8av9cXmJSAQSLdAfc2EbeyTSKcHbNmnwyXGrJDGLw5kjx?=
 =?us-ascii?Q?NyZGjWOg7AcxdolSAfOU64a2h0PJb9rsaChwh6nrpFhwnlftyzk+wZEvC1gm?=
 =?us-ascii?Q?bwltzEOCUjS1SABjimy+3XgJ/gqNe7lUEQix0QxQLXGROjS1FMO7WRZckMrS?=
 =?us-ascii?Q?5v5rIL6ZJIZFwaJaQPatZxZQ754zCEchKaBSbsK0mBHskZgJiUrPcWB2maal?=
 =?us-ascii?Q?JuBx1JgzKJEOftgE92ETdRVfc1Lfqv3nDbvoSZof6PuphwzZRlq5zm3XpwU8?=
 =?us-ascii?Q?p2IvNbUeISJaaYtqyWMSXimYUhkyY/YFgau+c8NiVL1RhUAYldtFnr6ugYer?=
 =?us-ascii?Q?MtrGVDo2awzTisqG3/E5GqoGYrfI8madMm1Jr73GohIqzJq2U0IGZMr81kJI?=
 =?us-ascii?Q?8esciW9jTyqmcoUiJDcVDw0aLy910GaDcbOPw4sO4MF7FR5t7uPyDUwIRF2U?=
 =?us-ascii?Q?kPtPtAnLrNbnC9DsphM+k4EUAlDBwk+/ndLHbQWSso3z2Z+B8KZaUd0j5fgd?=
 =?us-ascii?Q?F0zs83R//8zkY+YfZRjoS4LyHuZvk9WyUNe9mYJ2gEjI53bbZPSkCpVMK+ft?=
 =?us-ascii?Q?1fyjxY4N1TYEoDDduYL7rUJUpCq4tV5iYYYutr123SxXtJ1ml5p5yPAvXVrn?=
 =?us-ascii?Q?pHc0OoAGQwJfNQzMqK2mXKrmNfxxABsWVXyrW+6sRAUrUnzTiT4EETTYYz+G?=
 =?us-ascii?Q?lWMu/C8J4QfBIAPG73ngukcbDEnAl80II2qaH1Qjw639yAsa/3zZ6ueQeIyC?=
 =?us-ascii?Q?Yljih9xgCCyNO5z2wPEnQxdESRi12x3Sm/swGwz46xCnvzjuKqGSHOvD3WN0?=
 =?us-ascii?Q?AV+gqOx1vpnWq9tYblNdfoKpjEMB75/KCyHikP2rMEKc4/Ho4kc6LMRTk13J?=
 =?us-ascii?Q?e+Erp+4jL4OYFA7D2xoN2CjLxoE/m2vurYsUuzjl95vrgW2syHpS9fDagGFo?=
 =?us-ascii?Q?n8n+pER/bFT7N5rRNTz4RrhhXJ56Ecxz32EOEcVaU0f9gtN9rZq9XuIECgLQ?=
 =?us-ascii?Q?D4Q+3SM+diN2taB4EB6DiH4Py6hRMXGE3bdIJYdzn6lzVQPw/YlwJkJvqCBP?=
 =?us-ascii?Q?4KNlYXiZrLN9C8t9ztS2dab2DHI1UofGYJMivwls108WOLar7ofmCElqeCuY?=
 =?us-ascii?Q?9SDc7A4r/flCXkQsCzZYrAE5XWiLp8b0EBnZgYtqAqkgzWM7TBWlSWvZEl7q?=
 =?us-ascii?Q?SjvkmvoBgjWT4f9aUbMJvlTDWVFb7Gj8+rYRAXOWNDYywzhfCJ1v1ZHBaj0M?=
 =?us-ascii?Q?jXV29G2co9pjUc0FehW1hg+n5SNwvBGRBDaTDAFzzAN2LVsU2abSnkqvn7n9?=
 =?us-ascii?Q?oiK2f4KCop+pbHswoemsN6pCX1RD2unfIusct2GxD6rlSUTFzgH7YEH+/ULH?=
 =?us-ascii?Q?vw352+r1d2oB/y0dJ2Ol6Hnd241M21cpHDmudkAZfPyiYzA0enRkW5oLIcD/?=
 =?us-ascii?Q?dda34Y3vh5eskHtDCC+5DWTVhFF9MKCQI46sx9C7gDhcZphc80vbd4FZG4tt?=
 =?us-ascii?Q?ivfQRERifFlXCKaOVrFsKMbAjWZ7rLc+D9i0b8uoTHBVslO3OrtyKa0c2QC1?=
 =?us-ascii?Q?xxQGHeUh8a4/7QmrZB5rNKtECjEyFxuokPhKK+au0ZpPNVcnJRP9Wf/5IHen?=
 =?us-ascii?Q?EMq9sxajcA=3D=3D?=
X-Exchange-RoutingPolicyChecked: vPA86yN8K1Sf6Ztma7c/tFViEWZz5fb36fXdDrmJevvpogCZMgRonkHbg2gTiVOQni7JdQZDRpETf4mRVZH2POGdjbuk2NTboamYijDf5cAGGhO2GAOsr5VmHA6DBcgSR7NDePkP2rv0sMdW3cCY+hW/vN7GPG2TycG8+E0QjM6F9953Cu08C26AABAupsOwh1eXSjx3Jt5bj9Gj6XDC3MgXIpN5lCt6z4e9jbXz/TooyHz+xH032lDyqO+h3oF4CAYp1pgF3wYsaM32R/GGybo6tTO6nRCCx2NwOyEJl85er9XR3KQD+TOXTOv+2AF1AfoEaKlOLyvfdSIc7I8a2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad1de59-7abe-4552-25f6-08dea17860a8
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 20:39:12.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZB1UAKTFiE64Bp+hfjzhBZCofkeVYbgatqvwxXFRcLrINuc6EnvEP7ejtCj0k8XoBBRq4wzsHAhqshjVZ6HDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6344
X-OriginatorOrg: intel.com

Anisa Su wrote:
> On Sat, Apr 11, 2026 at 01:05:07AM -0400, Gregory Price wrote:
> > On Fri, Apr 10, 2026 at 06:22:55PM -0700, Anisa Su wrote:
> > > This RFC modifies Ira's DCD patchset to enforce tags and remove sparse DAX region
> > > support, which are the requirements that I've understood from the community
> > > meetings, with the end goal of FAMFS as the end user for DCD. Feedback would be
> > > greatly appreciated to let me know if this is on the right track? Or totally off
> > > the mark...
> > > 
> > > Everything is the same as before except:
> > > - extents must have tags (uuids)
> > > - 1 tag per region
> > > - regions must be contiguous (no more sparse regions)
> > > 
> > > To achieve this, the main thing is to change the relationship between
> > > cxl_dax_region : region_extent from 1 : many to 1 : 1. Each region_extent is
> > > comprised of 1+ contiguous device extents with the same tag. Contiguity
> > > is enforced by sorting device extents by DPA order.
> > 
> > Are you saying they need to be contiguous in DPA?  I don't think that's
> > what we want - in fact that's actually somewhat defeats the entire point
> > of DCD being allocator-like.
> > 
> > We don't much care what DPA space the extents take up so long as the
> > total size of the set of extents matches the size of the HPA region.
> > 
> > Sorting by DPA at least gets you extent-ordering for free as a
> > pre-agreed upon mechanism, so that's fine.
> > 
> > Basically: we don't want sparse regions where the HPA space has holes
> > (i.e. an extent hasn't been sent by the device to back the hole yet),
> > but we don't really care what DPA actually backs those HPA regions.
> > 
> > Unless my take on how DCD "should" work is wildly different from the
> > general understand.
> > 
> > ~Gregory
> 
> Super belated follow up to document some discussion from last Monday's DAX call:
> 
> Instead of enforcing contiguous DPA, what we mean by not supporting sparse
> regions means that each DAX *device* needs to be fully backed by extents?
> 
> - The CXL region/DAX region itself can be made of multiple DAX devices, and
>   there can be HPA gaps between the devices, so the CXL region can be "sparse"
> - But each DAX device must be fully backed (non-sparse)
> 
> We potentially want to do something like "daxctl prepare-device daxX.Y" to set
> up an "empty" DAX device? Then as extents come in, make sure they cover the full
> range of the device?
>     - Add some kind of timeout to receive extents that back the device
>     - If not fully backed within timeout, release all and destroy device

I don't think a strict timeout is needed here.  If prepare-device does not
actually surface a dax device until all extents are there a subsequent
destroy-device (prior to all the extents being there) could release all
the extents which were there.  Basically allow user space to handle any
'timeout'.  It could even decide to ask the orchestrator what to do at
that point and either wait or unwind.

> 
> That's kind of my understanding after letting it marinate in my brain... pls
> correct if that's wrong
> 
> One quick question I currently have is: in this scenario, we expect the orchestrator to
> coordinate the "daxctl prepare-device daxX.Y"? Is that correct?

I would think so yes.

Ira

> 
> Thanks,
> Anisa
