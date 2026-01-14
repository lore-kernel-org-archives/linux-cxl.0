Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB348221FCA;
	Wed, 14 Jan 2026 03:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361587; cv=fail; b=LqhMQODM4vzLtaXevK0m5+MRZxiyadwBl0jTP8T+aw6W+nL4K/avAA0OcYDR+GUOLmH2vH6/skkO3EyUtdDlXLtDSprNtT/XpXegnVyT71wnGXr2A5HMT0RQBIS0g9ASf15wSxOMD2o8KFRksDmCN2KzkQvL8PJHOruwuGhWf2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361587; c=relaxed/simple;
	bh=FFkgQsJ14mYRFq1xm13BBd683oUzp7Qw0aKXyLwvtSk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O1Y0+MbprElInihnJ6gMATdvJRR+hF/sGzTwsUicB1DggaRVpuybSkPIEEz+yWyvRww4iwdtyIe+cQZm2u7PEiPv6ZtbhQHHGtCjh2WlJYkjVovfs4bMaV0qisR9qGOfBhkWWPV925jOkAG9AdLy3m8RHYSEb0i2OdeP0bPzMjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/uyYzRp; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/uyYzRp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768361585; x=1799897585;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FFkgQsJ14mYRFq1xm13BBd683oUzp7Qw0aKXyLwvtSk=;
  b=S/uyYzRptLGf7/tSpuNZ1cem4q3PwVSrWTr0GEaZHYfbR7IyiEcWXavD
   4+H6ltW7+BWAE+R3K9fL9o7vRricFxkr+V+o+xLC/j4fx5xjzV1xTm7Dp
   22MBI7IHecYJjEODwaMPFUKj4dlOGc58WZRKE/Cp5+td0te5kD1O+r7nr
   +d3BvRCQ/d592XiaQ8bikDcPAGxpDLk5ICeUn4e6ygUEVtEf/tUVc8Zgc
   qcR7M09XLBHaModhYOEH12nUlII1azvme/V58Ea/NI5j/wx4NNM7hr42X
   lQVbMWZLfIzyO4eTybwq/1QY78AQiqBzh/eYKIxciNAyWfRyd97Tln2mI
   g==;
X-CSE-ConnectionGUID: LX6f/vNeTAaUYv+Vxp5IOw==
X-CSE-MsgGUID: AA3DNzABTouUeDsdZpbXLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69714380"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69714380"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:33:05 -0800
X-CSE-ConnectionGUID: E4OOF1reSfGCQ+WhBk6l7g==
X-CSE-MsgGUID: W/gAZpBERMCJ9Xg9if1fBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="209021958"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:33:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:33:04 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 19:33:04 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:33:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH4M6Ehu909AX9hmx1nB/VUI+einKzp3rxdWGwD/CkMRRhwQMlPHhyAqGTS58iVXRuNbMTT3JGMhbM6V0OeOX4E/PTSwSvAbncaI2yzlNSdglBAJz9qM9HQln/11+GrLwOIjbiKJMMRyR+GhcwPLjO7gpoF5P1jf8LEp/O7QfZrW3e/O0CgBsVJjQ/FcbH65Hphq2f7n6N+8LxE3f48B14W0ryPpNcPE1Zjuyb5s2xxJtVrgQk88DJw8lKDfawKbVmwpIuOE6ZkYrimFhk57G1N0C2RMsK+PjI0yw8S3QP91GWipHqoaOPkcrNS3d55rKs8D3tq1+pTVZP3JAggCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sE+pPz8Lkl1C/jGmgSRAswQqqLMcG7Hv7xTP7iw+UJc=;
 b=h2SIzTBvEat0XdwvZ2aSxePzG8lnsGq90ZxajDqikGinRJXifJDgbSuT3SnUTNaWLhDIP8xzb+vps2Q+IU8t6AnF0bZM/7p3EN/jwJBGzaTdlXGq9IeNtkpNzmCdhvH4haXoCUfs2jFPM9OZpWa9M4c2GJj4GiEVyM2dml6Re3u/i5+HHrLosM6MUJwNfx/mI0RAtiklwinxhEb/IttRZfHEc16t3+Nn8I+xLMW1PeL7Ulbc//3gKe2/G5CxLjpwt3t8Hnu/+jxB01nYy7ZEKHySedOlLa04DJnfvFaCq9jLYKGFTg+hvtsBIcykL3WgMvXOI8KbVC9CspuVqsaknQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by PH7PR11MB6452.namprd11.prod.outlook.com
 (2603:10b6:510:1f3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 03:33:01 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 03:33:01 +0000
Date: Tue, 13 Jan 2026 19:32:54 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 12/13] cxl/region: Factor out code into
 cxl_region_setup_poison()
Message-ID: <aWcOZi7hP3qksmBh@aschofie-mobl2.lan>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-13-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110114705.681676-13-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|PH7PR11MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f6147d-834a-4131-40ec-08de531d9e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ciVd3kNKnF0NkbfyZWBGkH8XI2+qT2cPw/ZSE7+prWwzl8zAkH4J5h3WzaP0?=
 =?us-ascii?Q?LdZlHRuZKiS8UxPrVM4c+5GeBkoAGslweLfA7pBfh8M42NSz4OzWKENSl4sT?=
 =?us-ascii?Q?TZrPFtE4cR29giFDC1O+MV0QU6g71+Ws8n1k2A6wbCnS03eNaIndMqsfSSuL?=
 =?us-ascii?Q?hAWGkzvTgcn07ROokZ2Mfv2l9EmRlett5iPCdJzT1sftrRxLaHxWaaUUqLNB?=
 =?us-ascii?Q?v6/C87e93wx3VpKhXsdvBFBPzJTylhLAZo+gYidKp42sIrevj7khSEV6zODf?=
 =?us-ascii?Q?TpmKhoRUrxQOTT/ZhWBA3ODFauZGSJOIHjbYxEusp/aXwstUBa5AGMtUVbr5?=
 =?us-ascii?Q?wjzOWLIX5DsdSIFssDWxe7y1gxft3y5hLWxMRr9oEnnToTz/L0kPtiDZM51n?=
 =?us-ascii?Q?iqqtrRAYZxw+ChTDzhzVUoi30FmkV+Ti5Mmp07oGzKzU44I6CIbH+AikXSMU?=
 =?us-ascii?Q?Wfho1UwMO/fBIy2/PtrC3/RXTh3OxdAVKn8/y+idvT56IvQyyKuX5PPAp5T0?=
 =?us-ascii?Q?RUPlH8N2uZ8pscAA3AZ++JshHuXAueuyNM5K0rROyJys7ODp2CXfZa7fcKGK?=
 =?us-ascii?Q?uys+Dc6Yzb7OMFAwg15cG7XPNHp5YHhrUjs51zSZ910WKHnqEk/JhIIyP1BO?=
 =?us-ascii?Q?ndbL/JAiuMIpNRJju6UBsezEFc6RuIVDI8dqtWunLQrGsWpzy+jw2MVegPI7?=
 =?us-ascii?Q?6H/IinKBB/DXht7mK1mPe9EJuylvNB0bD3XPHu1toibFlc+8hV77wHqfp/X5?=
 =?us-ascii?Q?5OFuVu23noIlnoXpsKneYXEggTRSrCv8oEypD0zSDv9EsLoCYnATwKHqPUWy?=
 =?us-ascii?Q?vc3a58hcHERA0KY7beL2Vo+hi6a9mpVFdimV55tx2Nr8kE/8Z1OHk1krGZfY?=
 =?us-ascii?Q?yKP2rhCLBEIMzyqxvn55zjV5ShpwXillrE9CptuIi5aqNxuv5M2ExYPxGfC9?=
 =?us-ascii?Q?Ih3IAEgJSdA3UPe3StinhrsSXdJCWTB0d7eSJMWM5MtSJAzMOggSNenV5oGB?=
 =?us-ascii?Q?7NQ3r0kmYrYdsQifkItLZNzn924fb8YHC449AgaL5UunYXY9TxrUHMqrkySC?=
 =?us-ascii?Q?AUex1FA/ymY8gknZnF8QXcCH7L3m4Fp1/sYrGjCVhhN2QvDzLleLnySITXRA?=
 =?us-ascii?Q?aSyXX/tl0qqQV3AUBskcgsGVGtAwYOczb7/jm/Bo52DQzZUthicdf4HQyGvn?=
 =?us-ascii?Q?VbTDx41eoO7Iogq/4dZXw84vHzKR/9WVOD7dzMb+KyQDH8GK0WjvqwDTgN8o?=
 =?us-ascii?Q?o9Dc7VLUGDwZqBhVO1BpoqdVepk5RexHAjOfxiyA9K5K176dGRXnKMEtT95o?=
 =?us-ascii?Q?goe/Locn2UHqyVBHM4W8xlr4jv4c0hY7iPbR8fmn0dJMilJsZCJQa6FYurXt?=
 =?us-ascii?Q?ZGelN45MkhP+KgEEhe0C+tMpaMvs8mmqFa6P/O17LaJtNLbqZ4BbcrhMe4L5?=
 =?us-ascii?Q?qZY4fC1VQ5KUsYM8LAwZB+oF6wXS9k2w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IegCSEIPWZGFiRQjjwBVHG0/PfH5u+jUZ56ZA+M0itxlAGfZhT71FoFN/o34?=
 =?us-ascii?Q?N9MH2n81ETqNo4VPc54FL23Mgd9uXPLYFw+b/+76tK2BUuI1TbivON1ZfJI9?=
 =?us-ascii?Q?JilUtyR5FoQ+X7o8GqSZ9LI+OKshpiDkoNz97rJABYrOBXSVORtc4Kwniw8W?=
 =?us-ascii?Q?aMgr8g2xoF56ntl956E12i4aiu52JuO+UAxuv2WgDwNmdFeCp/SCsWEvk2Aw?=
 =?us-ascii?Q?LXQiZNq97zWWuzUZzebQVKJi71PT/wjbZClpT1UBmrRsk1hOQFFVJ4DXQbS0?=
 =?us-ascii?Q?E7Szyz9vprqwyMpQyq7Ba9IqyPYV/Wx9SDxBvy6YaRtbTha3kPpMbQQxHfkm?=
 =?us-ascii?Q?wI6ln8IM6xtmA878TV5BAZEFQY1T4AYta46SI18lSlgtgNeVnfM1zEa2+QvD?=
 =?us-ascii?Q?XcFbGRQBtxjFqVTPHrUoaZdrBuWIo8I3iHu/UxtQv5iogdw1ZefFq89zivGv?=
 =?us-ascii?Q?byvYk6U7SM7P8191Ol5+u0NClZNg2qZ+Ob1od0ttpo0nrBfBfDY1P+wyGM/f?=
 =?us-ascii?Q?pzrv3ONOgKhbW10TNtNuc/PE438LwTdeV32rkJGnuE+uzIqUaFf2dFuFj1Fb?=
 =?us-ascii?Q?EZxG/TV+KTSzlZniDk8giFBmlTWI9VvgH2PPDYirdewY8THyoe8Um6+rRrL0?=
 =?us-ascii?Q?NGgFcrlQMTS+j2lrnrEGLbOb2O2ffR72MG9E46SxEX3yKfcwBYYR9cBUCJkN?=
 =?us-ascii?Q?2lH9GTIdS4i83bLDjion4STsP5ITSxaK2wBOE9sKgCnSTfXThNh3CgKAr7PY?=
 =?us-ascii?Q?Mt45raEuxq2NBl/rGti7ie/FUnU08CS+6m1v4iglXOEF4t3nmQRz+N6i949F?=
 =?us-ascii?Q?agfUqu0n3Em+3+je/4GtQGWqHdJwdPbTLGyBbJt4HBPPrLixq3boKuT/lUMs?=
 =?us-ascii?Q?LLPJ0Q1YFPzkm2wLptJVi1zrZfZwl/VQUqcEx6ECK7u4thWRRFYc3OCqVnLp?=
 =?us-ascii?Q?16wIeVI6uzDGLv8EgrxzAYSQc1bav8cyLszwAH7btf/y5zyluH+BOx/X6m40?=
 =?us-ascii?Q?lCHx/qOobv8gHRtTbugjFUYZEyxiPYS91EoHlPsUOWaPX//d/zssiDRYJGYS?=
 =?us-ascii?Q?YEzCMNMct2MFuWPA38nfiY6tG/lxLzgVKjseNYtkbYluq/Ko833pir8kbW2y?=
 =?us-ascii?Q?pXntfLoUoyAaA3ceK/PV563Jm9n5OmMOjSpeR3Nf2UybwE8r9x8/aqeeboWm?=
 =?us-ascii?Q?jL/NueQ7U1W0UnkL5886DY39xgZ0n//R95FKn9sEaTHgj00yZGu72q+evjnS?=
 =?us-ascii?Q?Y5y+UH9DwZo45TXXB+8EpsmHiTKtowGgqEwLUx0VvK0UWuvl+xoWE0PhIXyR?=
 =?us-ascii?Q?4xDM8HrKxwY84XFSAugLATT78bR+YEEluKZAAIO8xzYMcpLzOce0ccdIa3vP?=
 =?us-ascii?Q?eywfY1RBNSGsQ1Gisfnd8eM22f3zT9MWbeE6oi2KGNRkB2MlC/BLLJZHcewq?=
 =?us-ascii?Q?u9z4g56ptXEmdQN91vqSkpnx6WVhoq716WmW3+ZP82kbge7izQMAc4jZ04r/?=
 =?us-ascii?Q?1gsepnV30LwHX4CP7wpPT7uhKFeSZ8LPhd3v6E4ThR+7esCF9c0v2hn2ct6x?=
 =?us-ascii?Q?3TCbd7e/VLu7uZt6PypkruzmBBX52GIFADJS0Xakbwe7kJ2aRcvqCUikaLZm?=
 =?us-ascii?Q?Lo/FjGD4kleBqxHR5pPWFy9ZGAW/0ZIuE6nWRo1B5x2WLrktbEYVz+oCxUan?=
 =?us-ascii?Q?5VybrMgaWuW1jAFY+/foCXBjnSq7GBGWQTiumwmH8gM1jWOYd1Ard2h/eHJi?=
 =?us-ascii?Q?3nQfxeYYyzO3qLmvW2m+st02/XTkdnU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f6147d-834a-4131-40ec-08de531d9e75
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 03:33:01.1736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WeyTd1C8uOv4I5m+AIKqkOcI8PZRqAodTXBFaygsM3BpCZ4Ycdx5jYJo3/7tnXyA1UeFL7yTpLkbNR7kPGNSv8V3Qav1CRrnGrioQt3ogWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6452
X-OriginatorOrg: intel.com

On Sat, Jan 10, 2026 at 12:46:57PM +0100, Robert Richter wrote:
> Poison injection setup code is embedded in cxl_region_probe(). For
> improved encapsulation, readability, and maintainability, factor out
> code into function cxl_region_setup_poison().
> 
> This patch is a prerequisit to disable poison injection for Normalized
> Addressing.

I prefer we be clearer about intent. Poison injection altogether is not
being disabled, only by region offset. 

Replace this:
> This patch is a prerequisit to disable poison injection for Normalized
> Addressing.

With this:
This patch is a prerequisite to disable poison by region offset for
Normalized Addressing.

With that,
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

