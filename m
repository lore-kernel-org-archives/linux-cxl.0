Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E4C1CD3F;
	Fri, 22 Nov 2024 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296330; cv=fail; b=ZiZoPXr7P78wvUpK9rLeNCyAigOQIjxm+rLgRi07ZsIQcoLrFp15x/a3dNsO/m02Cyg009+/iobtTdiibLVgBZGmxMXhEJPLwfUjC/9MPKTiBHSxKfZRkoPUpaiIEiZa/rs7ZxlYPDhqCPtFRiyWWerKdG+AIi/UEmCgSXL2DoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296330; c=relaxed/simple;
	bh=jlpU133/+sanPewGK9KNpzL8Cdw6kO+i/MJL2SGM1Xk=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AW1/eqlP2uLkSDWt+kw9wJ2GdB/qL6TihEGK+ol/YX8W0SWCNEwvGg7RSe1j2JW6lxLbPw1iV0G3HhK49S9zESOI7x8iTiGTzr3kVYyohhymFILVh4OV/8XkmBiqUuJblUOCrifxDyen19pJgZiJqluhyfwGqzZecxtvpU2CD8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V94bI0Fc; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V94bI0Fc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732296329; x=1763832329;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=jlpU133/+sanPewGK9KNpzL8Cdw6kO+i/MJL2SGM1Xk=;
  b=V94bI0FcNtPK0rSjEz1cFD1qfSocCUmwz3uO19wNBhQXeM2fdOYlLRUN
   X1zb0eOEG3DWFIrOws9NDHBrvUAviD+BvUrnE6r3sFUc/ZJX7kr1wI+/b
   yNZKVRbfK08s2XcBkuzaeyU59EZNW4WNFJMIjLOt8cy/u9WhY5LeT1VoT
   0rOZxgaxEW3+KBLBuPHYwmo9WrjeiNNcZ7qNGZvJ+8dvZ5JLSM1Wbwoff
   rADMLna/n6GpNSN3GChdxGJtxONxFWbie6RFSMdSn9kYILnlHnRuKerYX
   hWsDV7fbxSA3Z7b49YR7yJhL8u/yGzHs4NDjXRTvU4H5CuZMRAo+LfPZM
   A==;
X-CSE-ConnectionGUID: 8J/n6dCeSwe+dZPPJa1UrQ==
X-CSE-MsgGUID: YeOJSG+hQ1mGRhSDFqp8rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43838526"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43838526"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 09:25:28 -0800
X-CSE-ConnectionGUID: 3bMGhne3SUOW4eHtJ1mM/Q==
X-CSE-MsgGUID: yhOpX+WyT1K/YNxhlgMMzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="91059028"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 09:25:28 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 09:25:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 09:25:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 09:25:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o854HqUVMmR698iu6aAdAacm9325uvREWvnzvqnSdK0cTZBjN8b6adFm07O0aVu4p1SFbRx1lnKemEN+d9s2SVDzY8P3PAZvOtdrHgAvyZo3hVb8Q92reSAu9/qRuv6a31dKBA34v0nChGdQxCV2Y5hJl2+AbDkKnWUtsHNWExiJhOehkUoA6157o7o85XdWhePzLPrPynCLdS0brPi6qSv0eAh2P7X6Zr7U8P5FnsGt8DQZqHBKWybjr5QT608qxz2/J/SpPgDbI1IXg1gbbxopEhKfNom1YqDWkBqzsELeHdNx39ZQR+ehBWnbxUlyUbSFa2PlNp6X6J+ptV4xbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mi961wzTe+JBtl8onBTn0/MwXavUjeN4lexfZiJYx1M=;
 b=oZCgMRdhITLCm/ePQBxfdznm3EU0slfvfDZMbL/TEGU2sKPNNY6SIPSzzD80eeBsax+eG8UyoboFGJ749PU+N351thHl9DJBGhOQdpMLL54ZqeOiC7owZaWM3XpCd1pHDEFbe50pz9U4qMW3lzBdkxwDsK+gqOYyVdQ5fEQLxu8VmDrSfO+yM5zd4nDzYgEhd0RBpNeFA9ldRyvVtyssUbo51r3uWiViLuKzHc/JndRt1V+4QgS9cGXaEEmh1nz3lSTQ5y38FUO87N7BmA7ueXs4YT1l8Ai+3kV3Y7xyCaYXJufawyAG9ba9a2VOf1XrwlerkVSZx6AZ+mTC28yC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB5795.namprd11.prod.outlook.com (2603:10b6:510:132::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 17:25:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 17:25:22 +0000
Date: Fri, 22 Nov 2024 11:25:16 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Huang
 Ying" <ying.huang@intel.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>, Li Ming
	<ming4.li@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low
 Memory Hole
Message-ID: <6740be7ca4bc3_2de57f2944b@iweiny-mobl.notmuch>
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
 <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW4P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: ddda808a-fcd9-48fc-6710-08dd0b1aa535
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NRORFxcnsSbBYcnkKpGKSO/4gTuUGZjZ7ecTBcu6CcL7D5uM6+br4XNlHdSv?=
 =?us-ascii?Q?u9IDyANq7wQdpeTB4w5Mm5F+MMp21gyvf0CbzdJdi+O6xDbt/8jpxAYdkH1o?=
 =?us-ascii?Q?RFAzehM+Cz3CshjYxZTrFA4juPuNBIxZpvyAVEB3vnlPiGkbDv2AkGzOwAFA?=
 =?us-ascii?Q?v6DONNkzRPDRliPJcKFCgdMwHX2JNQAQsmjz32X+NiRFc12ui5EoA2E1uTK2?=
 =?us-ascii?Q?H5RqPcCHj0bQ43uGxSqT4Q91KrHz2JJS4ckw065EnaZTWuLJW/KDVh6MzpTP?=
 =?us-ascii?Q?ZFNppipQaBBgUbFiaLWfk8EnpbEOJ5vpiU+HwDJ13T8szRDKbNnp5wLjaH/h?=
 =?us-ascii?Q?wtmrbIMA8eK2SJEOAF8B5uCFVRyps/DKor1/f4hCQVFRSmD8ZkQUcIVxLhv+?=
 =?us-ascii?Q?uYOOfdp53+gbuLtLyLWOigc1wCLp+vWIA8bo2aTYUKnlpY1Q3xPiopQmlHja?=
 =?us-ascii?Q?SFxgbHmyVxC+eaXyBubHUH/XrD12YUgl6mGdtv6ABoW0GcDEfmq/t1XxOgPY?=
 =?us-ascii?Q?LfIjPWlp6i3IK7ZA7TtA9/Eumdagms7A6ivlHuYfKBarV1XSwKMB02QCRWTM?=
 =?us-ascii?Q?q2JUKc/8SXpNPLw5TPNHiMRYV9yAHKz+n5va68xAqvaQcjHQyMod29jEJMhP?=
 =?us-ascii?Q?D18MSlzy5Qm9pm8Q/vG82EBAzblfBT1fb/brSJ6HlWX3uw2f/pZv7g1PNirt?=
 =?us-ascii?Q?KH76GJhvjrzv8L3tn2AoVmBqT+iUOjgJr+QDiTYe5McowoGb6Lgi4JSpsP8y?=
 =?us-ascii?Q?+QeB4SL/OYoZePK2qN6bF9Fr2B1ZYp/2tdYlnl7OI5hFtjIfvgo5P6woR4Xv?=
 =?us-ascii?Q?nCbDjxz03Ot2ng6dsk3WO1FW3WinrJLhq2FHP/3WecW7FjwG1hPFsBCbe2XX?=
 =?us-ascii?Q?nrt5u4XvsdwoRRmNQTmEk6VDezHKZpP9UjQZhSP7/Oc7ovyyA9jRELhQM1S8?=
 =?us-ascii?Q?4d3GUHYXpqrrO6YU3GvMRgdE+416XxGqdDP45IG+LU0O8oRZcunMKRj+FpY5?=
 =?us-ascii?Q?/ILzvh8+zaGQGItJ/Y/P28c+iwzfTaB4uShMDDQeeemI0OVi0wEGRLYOx0lA?=
 =?us-ascii?Q?OAzpWCfbZw2/1qRQOMARDKQvt08wcJtQTxauWTRUZh+e2ghM6OLaknOG+XXs?=
 =?us-ascii?Q?uNYCwdXQKzjk5Fv0Pl/PMmqW6SVQyHhwg/Cj9eoRTvvRqp5DXP1kIfpzzC8Z?=
 =?us-ascii?Q?uJOw1+iRaXXiQhv9kPCAKf+lqdxHq2FRtSSwUiqfTBIQvhyF/IFFl1qxf4q8?=
 =?us-ascii?Q?lLne7unwe9mw9h77/htnBf7culW0BQo/wz7hZmcL4VI5nVD+b2Kx7VOq0Ro2?=
 =?us-ascii?Q?uf9wKSyhZ1dgYDb1m5rxf+R5M3D3rqSUSnTxJ/9naSdBYcTNdkn/uQb61071?=
 =?us-ascii?Q?8CpYkXI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cgYKIflHECwXxamni93kTv/0KCQ/2yLrg0VkvTuDXquVJvyiCAJuP4OWxVlO?=
 =?us-ascii?Q?nE1GlSJcmdmwJ/P8D7LD54ZRXhBQ5JKUInKiUiGaN/1Dx0Cu4CW745j2tCLn?=
 =?us-ascii?Q?XbDeT1j8uwt01ozGdmWne9IGttdsp/ioY15bSDD/9zEwm/c98WHu2iT5bX+/?=
 =?us-ascii?Q?o4LjNaVgO5PSzn/LUKz30rs7zUr+F1e0xLlrmttHhOyzxVdGl5KgUKDT8dLX?=
 =?us-ascii?Q?nVsSdoQ2FY/XPn6waEjSW7qwGWbNYSX3TxEc8to5Ia9Csf6LLE5IRzcL0tAy?=
 =?us-ascii?Q?5hCLK8IeyvqCMQD6Z1a/lykQCtJR2L5vjVeI6V/Q4fU+2pMDJJPlc0JGuRUk?=
 =?us-ascii?Q?rD+7vROha/8qbdTcNv9b2VksJcs8ue+8aqaeps384Sh126jMHTidLLM9U755?=
 =?us-ascii?Q?/kWkktZMdxwBfBwAY+eawXJ2QzdwUCMcv3dGKZ3RKK790NZc3q0xOQpGjkLU?=
 =?us-ascii?Q?QE1pVI+6Sa/2j7JRv/PfQHbBehNo5NLkOKGMql671GaQWnWAcnSF/nu+VekX?=
 =?us-ascii?Q?RfU41o9ZL1WrOUXjoZ7Wha66JKUvo5cMlhAwcvfVOhE+zK4TPMIOekpPjivB?=
 =?us-ascii?Q?91WmMkafygQyogDDGW8Vl+5X2yrRXJUsXSJpsPo7YAeAqA5llR10M0IBn6g+?=
 =?us-ascii?Q?HXfLja+yCg0wG1n+Zg378g4qJThRLPLdh3OGUR3l8ABquGFYzkFYFuTpi4lW?=
 =?us-ascii?Q?Bb+CJxCpk0rX87pZ+gvVxG4rXibc+qBiYU+hy46E4z8EHzaJ+R4pPYT+gGDN?=
 =?us-ascii?Q?08cXkjrOE85iVRRD0ux1bOLBtNPR3trz+BKTijDK7hbLgYPFQ3fJFZCfPULM?=
 =?us-ascii?Q?URUlVXI7//n2/PkWDfuNAX3Ms0Bv1jCTrnn23xENHxaHCE6sOaSbgcQ40WYA?=
 =?us-ascii?Q?t7sfLJ7ky0T4o2ZEZccE/b0Q5SZDpEIyGZ4fpQb0+qOrzMSfAp9ukuPywN5L?=
 =?us-ascii?Q?lpQNvEOCrJnEBvBRkbnPYgOR5ipk3ya1I+o0Bx6qoG62wbUcVhzRmcKg8Xqh?=
 =?us-ascii?Q?52kqvBSFnEtXLwHDjwqijT5uUCYcoAorI0kiCz8+qASdbaYLTOkMcdy6px/v?=
 =?us-ascii?Q?SXpztFbETA3k8TveBeQ+xdprfgxKeI4sHw/FzsGaYs7R3rx15rB4VOe0Wnqk?=
 =?us-ascii?Q?/qnvHRgAtoetKjhdSJBOo9ByrkCw9F9vj9YVNPlW5ajGr+OjyYud0KSJMzon?=
 =?us-ascii?Q?XrUjhkIA4+7uGWQbMY2qvirs7zxJMCG6EeYIyGY4WB9mbhIX+b/Nmh6gJ+UT?=
 =?us-ascii?Q?lw/M3aOOVAEla0vsK8mUGBVrAsp8XMeZpHtUpkaUHm5+E8mCV0HzsL900J+e?=
 =?us-ascii?Q?k6lnos9jWCD6F9zLF+nO2mZ6wYDwJ432JTrlBF5u7Ht3m4SjDPYSVUvq+tJt?=
 =?us-ascii?Q?yOJjtPHTXdLw6KIyWXrEm+HrKRlPW+BZTGUWJUs6odRToWg42t/piRPdd+LJ?=
 =?us-ascii?Q?R0qyah2HxAIyOeOBOQQu+pgx/FKVP2WJRA1G+EnTDSn5HqhJeVf0L9TJWdz4?=
 =?us-ascii?Q?QIN0PQzOKmeK1OOFsh/DtMncRn/EV3cwtMb+Uqnr9QWjuF7K5YmuMdFCw76p?=
 =?us-ascii?Q?nwptLMpSpE2Bc4OdRX5ctKk38pocu6FNIiAPaFhi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddda808a-fcd9-48fc-6710-08dd0b1aa535
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 17:25:22.8002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvxyHYbR6hjN8MQmSitovTQsSU0d09iZJeJ8atTIQnwQJuJ0qfEHe4yWSEhjZIrAXUVsmixMRsf6q3D9YGrEiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5795
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> Physical Address (HPA) windows that are associated with each CXL Host
> Bridge. Each window represents a contiguous HPA that may be interleaved
> with one or more targets (CXL v3.1 - 9.18.1.3).
> 
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. In some cases the size
> of that hole is not compatible with the CXL hardware decoder constraint
> that the size is always aligned to 256M * Interleave Ways.
> 
> On those systems, BIOS publishes CFMWS which communicate the active System
> Physical Address (SPA) ranges that map to a subset of the Host Physical
> Address (HPA) ranges. The SPA range trims out the hole, and capacity in
> the endpoint is lost with no SPA to map to CXL HPA in that hole.
> 
> In the early stages of CXL Regions construction and attach on platforms
> with Low Memory Holes, cxl_add_to_region() fails and returns an error
> because it can't find any CXL Window that matches a given CXL Endpoint
> Decoder.
> 
> Detect Low Memory Holes by comparing Root Decoders and Endpoint Decoders
> ranges: both must start at physical address 0 and end below 4 GB, while
> the Root Decoder ranges end at lower addresses than the matching Endpoint
> Decoders which instead must always respect the above-mentioned CXL hardware
> decoders HPA alignment constraint.
> 
> Match misaligned CFMWS and CXL Regions with corresponding CXL Endpoint
> Decoders if driver detects Low Memory Holes.
> 
> Construct CXL Regions with HPA range's end trimmed by matching SPA.
> 
> Allow the attach target process to complete by relaxing Decoder constraints
> which would lead to failures.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Over all this looks good but I wonder if there is a slight optimization
which could be done.  See below.

> ---
>  drivers/cxl/Kconfig       |  5 ++++
>  drivers/cxl/core/Makefile |  1 +
>  drivers/cxl/core/lmh.c    | 53 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++++++++-------
>  drivers/cxl/cxl.h         | 25 ++++++++++++++++++
>  5 files changed, 130 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/cxl/core/lmh.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 876469e23f7a..07b87f217e59 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -128,6 +128,11 @@ config CXL_REGION
>  
>  	  If unsure say 'y'
>  
> +config CXL_ARCH_LOW_MEMORY_HOLE
> +	def_bool y
> +	depends on CXL_REGION
> +	depends on X86
> +
>  config CXL_REGION_INVALIDATION_TEST
>  	bool "CXL: Region Cache Management Bypass (TEST)"
>  	depends on CXL_REGION
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 9259bcc6773c..6e80215e8444 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -15,4 +15,5 @@ cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
> +cxl_core-$(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE) += lmh.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
> new file mode 100644
> index 000000000000..da76b2a534ec
> --- /dev/null
> +++ b/drivers/cxl/core/lmh.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/range.h>
> +#include "cxl.h"
> +
> +/* In x86 with memory hole, misaligned CFMWS range starts at 0x0 */
> +#define MISALIGNED_CFMWS_RANGE_BASE 0x0
> +
> +/*
> + * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
> + *
> + * On x86, CFMWS ranges never intersect memory holes while endpoint decoders
> + * HPA range sizes are always guaranteed aligned to NIW * 256MB; therefore,
> + * the given endpoint decoder HPA range size is always expected aligned and
> + * also larger than that of the matching root decoder
> + */
> +bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> +		    struct cxl_endpoint_decoder *cxled)
> +{
> +	struct range *r1, *r2;
> +	int niw;
> +
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;
> +	niw = cxled->cxld.interleave_ways;
> +
> +	if (r1->start == MISALIGNED_CFMWS_RANGE_BASE &&
> +	    r1->start == r2->start && r1->end < r2->end &&

Should this be 'r1->end <= r2->end'?

And could that simplify the logic in match_switch_decoder_by_range()?  See
below...

> +	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
> +		return true;
> +	return false;
> +}
> +
> +/* Similar to arch_match_spa(), it matches regions and decoders */
> +bool arch_match_region(struct cxl_region_params *p,
> +		       struct cxl_decoder *cxld)
> +{
> +	struct range *r = &cxld->hpa_range;
> +	struct resource *res = p->res;
> +	int niw = cxld->interleave_ways;
> +
> +	if (res->start == MISALIGNED_CFMWS_RANGE_BASE &&
> +	    res->start == r->start && res->end < r->end &&
> +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> +		return true;
> +	return false;
> +}
> +
> +void arch_trim_hpa_by_spa(struct resource *res,
> +			  struct cxl_root_decoder *cxlrd)
> +{
> +	res->end = cxlrd->res->end;
> +}
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ac2c486c16e9..3cb5a69e9731 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -836,8 +836,12 @@ static int match_auto_decoder(struct device *dev, void *data)
>  	cxld = to_cxl_decoder(dev);
>  	r = &cxld->hpa_range;
>  
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> -		return 1;
> +	if (p->res) {
> +		if (p->res->start == r->start && p->res->end == r->end)
> +			return 1;
> +		if (arch_match_region(p, cxld))
> +			return 1;
> +	}
>  
>  	return 0;
>  }
> @@ -1414,7 +1418,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		if (cxld->interleave_ways != iw ||
>  		    cxld->interleave_granularity != ig ||
>  		    cxld->hpa_range.start != p->res->start ||
> -		    cxld->hpa_range.end != p->res->end ||
> +		    (cxld->hpa_range.end != p->res->end &&
> +		     !arch_match_region(p, cxld)) ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>  			dev_err(&cxlr->dev,
>  				"%s:%s %s expected iw: %d ig: %d %pr\n",
> @@ -1726,6 +1731,7 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
>  {
>  	struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
>  	struct range *r1, *r2;
>  
>  	if (!is_switch_decoder(dev))
> @@ -1735,8 +1741,13 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
>  	r1 = &cxlsd->cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	if (is_root_decoder(dev))
> -		return range_contains(r1, r2);
> +	if (is_root_decoder(dev)) {
> +		if (range_contains(r1, r2))
> +			return 1;
> +		cxlrd = to_cxl_root_decoder(dev);
> +		if (arch_match_spa(cxlrd, cxled))
> +			return 1;
> +	}

If the logic in arch_match_spa() was changed to allow for an equal end
value could this block be simplified to?

	if (is_root_decoder(dev)) {
		cxlrd = to_cxl_root_decoder(dev);
		if (arch_match_spa(cxlrd, cxled))
			return 1;
	}

>  	return (r1->start == r2->start && r1->end == r2->end);
>  }
>  
> @@ -1943,7 +1954,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	}
>  
>  	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
> -	    resource_size(p->res)) {
> +	    resource_size(p->res) && !arch_match_spa(cxlrd, cxled)) {
>  		dev_dbg(&cxlr->dev,
>  			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> @@ -3199,7 +3210,13 @@ static int match_root_decoder_by_range(struct device *dev, void *data)
>  	r1 = &cxlrd->cxlsd.cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	return range_contains(r1, r2);
> +	if (range_contains(r1, r2))
> +		return true;
> +
> +	if (arch_match_spa(cxlrd, cxled))
> +		return true;

Same question/simplification here?

Ira

> +
> +	return false;
>  }
>  
>  static int match_region_by_range(struct device *dev, void *data)
> @@ -3217,8 +3234,12 @@ static int match_region_by_range(struct device *dev, void *data)
>  	p = &cxlr->params;
>  
>  	down_read(&cxl_region_rwsem);
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> -		rc = 1;
> +	if (p->res) {
> +		if (p->res->start == r->start && p->res->end == r->end)
> +			rc = 1;
> +		if (arch_match_region(p, &cxled->cxld))
> +			rc = 1;
> +	}
>  	up_read(&cxl_region_rwsem);
>  
>  	return rc;
> @@ -3270,6 +3291,22 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
> +
> +	/*
> +	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
> +	 * platform
> +	 */
> +	if (arch_match_spa(cxlrd, cxled)) {
> +		struct range *range = &cxlrd->cxlsd.cxld.hpa_range;
> +
> +		arch_trim_hpa_by_spa(res, cxlrd);
> +		dev_dbg(cxlmd->dev.parent,
> +			"%s: Trim HPA (%s: %pr) by SPA (%s: %pr)\n",
> +			__func__,
> +			dev_name(&cxlrd->cxlsd.cxld.dev), range,
> +			dev_name(&cxled->cxld.dev), hpa);
> +	}
> +
>  	rc = insert_resource(cxlrd->res, res);
>  	if (rc) {
>  		/*
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5406e3ab3d4a..a5ad4499381e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -902,6 +902,31 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +#ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
> +bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> +		    struct cxl_endpoint_decoder *cxled);
> +bool arch_match_region(struct cxl_region_params *p,
> +		       struct cxl_decoder *cxld);
> +void arch_trim_hpa_by_spa(struct resource *res,
> +			  struct cxl_root_decoder *cxlrd);
> +#else
> +bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> +		    struct cxl_endpoint_decoder *cxled)
> +{
> +	return false;
> +}
> +
> +bool arch_match_region(struct cxl_region_params *p,
> +		       struct cxl_decoder *cxld)
> +{
> +	return false;
> +}
> +
> +void arch_trim_hpa_by_spa(struct resource *res,
> +			  struct cxl_root_decoder *cxlrd)
> +{ }
> +#endif /* CXL_ARCH_LOW_MEMORY_HOLE */
> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> -- 
> 2.46.2
> 


