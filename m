Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFAF235061;
	Thu,  9 Oct 2025 03:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759980583; cv=fail; b=urCf9pVAhHWfj/egtbwtDwljljpJBPsY3eJm5I4Y/sQiXUxgFaewu5k7Gz8uSKWenxxTzGW1HXdj4HCQBBeN0ID+DdP51jtmbqxXP4iUzDQSxXsG4cW7kfPYQVGiQ5IWe0HWZrYmnXdXiLBK8/BgsaYzxmlGvMKhlVmBcJQrDJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759980583; c=relaxed/simple;
	bh=PO9eVN+znBSilkH3z2ADqpovSO0vO9clqxhN2QKn6uI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NDp45fIPljl+72SeRoXIB508FoOYH+dqKwfrZ0ulh0cSbsEzH5Mtt53oWO1SMJub45yHwtxTYcY+OGr/x2yg/2Gh+ND12u1wYEjPmWPIY1EzHK2s6IrrtOvSTo698jc35+YrElzfPqKolHzPKMmYVl5PKAnZmi0XM8iUsDa4BnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBYQoajv; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBYQoajv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759980582; x=1791516582;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PO9eVN+znBSilkH3z2ADqpovSO0vO9clqxhN2QKn6uI=;
  b=XBYQoajv+xYd6cOLAzRr+/jkKbKNK1j9hdw1GMNO22SLWso6UkceccSO
   alSMctY/lJoo4Zgk0KARmnbDguXo8QxosYgzBv4Q3/Pn3Jkxwrf8itZnN
   RlZKKx3045nGsNlyCdhw5mWCJTjnYvpm2WiE2r4wh7QMw3C00801DyM4f
   nk47LqWoljbZYAfWhslBWUWRjJpN0jfsc10wTip8q3pkUdxpP/2RAhVT6
   Kl0U+fRcZ7/ys3HZUl/YZ4P5LESlPpbFVy37ex0g5vaRi1u4MRYQQ4G+B
   5GZLXOlQYyXns1a6r6S+Wgh1Sdf5h7TzFQP6FPNHXthHe3O0qPwHl1rGa
   Q==;
X-CSE-ConnectionGUID: IXSe5fVJT+ypEIuxC898XQ==
X-CSE-MsgGUID: uvezVLgER76FKox6vGcwjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="65829041"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="65829041"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 20:29:41 -0700
X-CSE-ConnectionGUID: uKaAmHNCRR++zB9lie2dng==
X-CSE-MsgGUID: fwUF+sFgSImWzQPJuHjD9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="181013464"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 20:29:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 20:29:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 20:29:40 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 20:29:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLFfv+5Bbu1PleBSzRZ4JuiDYiUFsDMJupjAtQmfSpQwbQiYJ18TOnyr0svY1Kx18L56byM17Hpw3sx0IFHnatSdQIVCHc/Q7WgMbEMrv/tHchyA34UOh4r2NplgNIhScSHq1rz75vDe2tjm/aBQI1GKl38F1KWSYFy5xXVACVjgbu6wENdGi3/qRLjwBhyijUE7DixIz5Xp9fmrbviA7NOHGm4n2PRD2GAHFYwn6JwXnX5ywcfQcCHGHqoVv87Y6nYaBNE4WClly+TQf9MD2/i5ZgxNKDG6jk+nRG2LZf7jb0w9JxvYaM2akLlYky98Uhy5/ErSEvpwMSlgkJZHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDEyfYT3u8/9PI2pE4KUNtttP7Bdm/RjarXsMhIGK3o=;
 b=ueQ2g359SdWyRy4qUw0/l+t9eJ1IbgjumZn8kOeaW53BaF5FRUgJ0Sa6KwyXCoCP/ic0YILtyLFQ3jlVLOALcJgBVimHCAKxCQ+hwQjwID1i4lesNxyobinAvuKCPWosv4vb3wP8K1kg3N1d5S6gK+yAa9bICFIx5t5zAbNspeZOv8h7l1E68r7O5lIrzm269ORl9QZiabYzJByAIv+m5zVIg3m643BLNMKVKcQFn+qXqF/6KdkiKJYZM+Kanz1wLcCxRJmo2tN6HXh20MftxlwK65mQgRnTFUSn3Cq0uIAI0W8YHs+p+RA29ONDeUgXDUYWHqA0WOYDZJj+2TJnzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA3PR11MB7526.namprd11.prod.outlook.com (2603:10b6:806:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 03:29:37 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9182.015; Thu, 9 Oct 2025
 03:29:37 +0000
Date: Wed, 8 Oct 2025 20:29:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, "Dan Williams" <dan.j.williams@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, Robert
 Richter <rrichter@amd.com>, Cheatham Benjamin <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 3/4 v5] cxl/core: Enable Region creation on x86 with LMH
Message-ID: <aOcsGbRlMesYgAyV@aschofie-mobl2.lan>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
 <20251006155836.791418-4-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251006155836.791418-4-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA3PR11MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e8b823-0e39-40ab-8c78-08de06e412d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5wFNQRuBHb4uIgdDQtmUV8beIO80uEKZxAlcwZepS9ci5Vb1yIMB2GoszGnu?=
 =?us-ascii?Q?4QQbSGul4VO5ifhh/bkoGy5k3oaseKIb3IHSMnMmbETIY+0KbWkK/udA/MhW?=
 =?us-ascii?Q?5ZfkEclI0UwWzqyFSn9NQ4/MuN0PMR+JmdsXehuPklf9enWQPCCp4OHdBkH9?=
 =?us-ascii?Q?4HxkKzfMRj6D7jbFjeGbEIRnXa1d2q0tRx0vEw8dr1Yl7ePDC+uaZfnDJFzG?=
 =?us-ascii?Q?Tr1fGLBHeJcLEzKjcvuEuKfBhPTaBh6Kdurs17A+EtxZkqAsCtIa2mhDYb8z?=
 =?us-ascii?Q?fe5113ul9P1/RVEqnE2MlEBQqey0eF9x91uBHuG1Cog0YpUJpYstz+V04sUI?=
 =?us-ascii?Q?gMh47BYjNwvpQNmHwUtpBDK/Llp019Z41ysnJg5Z5UREHksqZHY21PojrKpp?=
 =?us-ascii?Q?bqnskAjYzVkO554ua2DXFNYWiMCPIIa6exTDhnwU9pHyznx54nQSAHlJGswp?=
 =?us-ascii?Q?8SIFq9VTg1rh6T0XbgnhsDp5cTJwVzrZdHDsj1bR7gLderas7yS8nXsqA42+?=
 =?us-ascii?Q?I6Aqmp8LmR4JzHIfhaMWulDRDvZnY6AhzUnacPkuiqJG8F2rwMZI4PuU0n0n?=
 =?us-ascii?Q?nnUduyf5aqxXuaFcKEIbHzHIuSpe1KCJnITnZua0EHCeC+yHl83PXBfIhqpg?=
 =?us-ascii?Q?Wo6mrsPz7J36/aQ91H08eh0CF4PHQxFpadWmwzJIxq+gm6gP/+aLEzhcSrnA?=
 =?us-ascii?Q?2wTVDu1jCn2R38YN/CC+RN8D70CLHsWKCIb/DU6f00DrTUAgQKplr196zwLV?=
 =?us-ascii?Q?0mI8ftUoywge13u6APJsEuf+C9VS4zz/2I3bgBFak/w0JJuCv3m6TDf/icib?=
 =?us-ascii?Q?ZKhWb/RstN0HuqsffO26kvCB6sKNpPtvUyLAXrE6L8lBKNDZKoj6/p9TUx8g?=
 =?us-ascii?Q?eUUD7kEo75iOa2H7yYVeOYrOTH4Ks8jZ8pGY3TBuVeLIEt5m/KzRhCv6JVVU?=
 =?us-ascii?Q?1NKY6H2peIYf9KsucM1JNV0K7e9joOH0pC69vbI5otJoxpiP6qROi+LDnoty?=
 =?us-ascii?Q?vIKR+uY31uh4wMZ5uq1yFe//7x6QUm6RhOObvel+ypt3xsWTVFyZ58dbjTrp?=
 =?us-ascii?Q?7wVFSg0U416q6LlD3PCXsl2WfRXqx+1T3mIkXJX66o3VvLJ4xE4/wultgbKi?=
 =?us-ascii?Q?0mcJSuiM7abaq/FeuDT81JNjMGBTkRo0Dy7E6g+ALn1BSAOv+I8xEaGgo6R8?=
 =?us-ascii?Q?r0RiPmj4GWOMpIC6kvs1dltGmGIKigzUYZxReC8FSc32frJWjatEmvCjJxh2?=
 =?us-ascii?Q?84O1jJ8m2hd3RpVu1qWxS+ZEMgit77Zr3NH7jqTKS/WwIamCcfgE/Q17VWRA?=
 =?us-ascii?Q?2/Pcp9I4pG2ZKiVzZtMVi7suYfJ5VlpcLIDcs8oilYwwiJGLF3qvwJ/BrARw?=
 =?us-ascii?Q?w/8JBnMqNhez9lAWwUb6RCliMQEU9FG6x9s+0wFlarKxGhY270ofaF1uVF0e?=
 =?us-ascii?Q?/TRRYEbirhWXBRHmwGOMOitUNgg3kjWl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?30PWflxsEw1OYMMXI9jhwYlTJWB/v1GUCsIDPHNm72WvUtWg0/VoT9lPUw7b?=
 =?us-ascii?Q?NQbcXn7a2y1Alxgm6HnwPoZ4Q8sieuQH9aLD2ZjgNq8uHupioBWVY2v8kRra?=
 =?us-ascii?Q?mMUnK/PnK8JTxdm00PWH6amMquBc00XIVc4DQ9rjpM/pIODQ3ve8p0l5Lixr?=
 =?us-ascii?Q?+3oQmEtSVcxgm1kuhJqeplKhAvjMZYqjvrGNx1keXbk+fjw8iycwCDULY73Q?=
 =?us-ascii?Q?kfs6I67U4KL8gO63JFVZIGO2hV5ch5PZuYWMzz2utRf16342SoeSDxUy2Ko/?=
 =?us-ascii?Q?TiusFxsVVfxaAxVunIevRiPxi4txXi6J8hLpi9yBRMC0leqNiyDgC/dhZLix?=
 =?us-ascii?Q?vaWiUn5Hh4XLpYD/A7QJMcgELfTzYv8rb9BggQ7NAqBa5tzuo8vOuNOjrE/K?=
 =?us-ascii?Q?+vA4WDcsyVSbcmi1+kQSSQMCQcOtYtkYfJVuvVQYqwL8y8R8sKqRdP+exB1L?=
 =?us-ascii?Q?dLjOs4gEstIu5KT24fiBZK4XumYd7t4QOw40P1WR6GUOJ7QbTcaAQHzMEvob?=
 =?us-ascii?Q?W8FCnRutWxBFlh04qez2VpPDlv77JBKDIp+6VbJWLzqSDbO58FkKB8KgyONb?=
 =?us-ascii?Q?wKnqdAjN06wNaPMPg0G/yALAaA4H9RmxChEGbUVI3g2qLY7h1cTPIlMRfxQJ?=
 =?us-ascii?Q?JHd5wI8S4sNXrDfmcT+rp9Njfldz9DbIs5x7z9fMgAhK4IsjsCH9Qd4uZafY?=
 =?us-ascii?Q?2X/FjoFor56jzPvEaAUTFTUS10igu66GUWnVIj+dY+wAn1rxovxJ5Puur/cL?=
 =?us-ascii?Q?5LUn2aKfN/3pItW2bfAOGhZS1scYYbH15mWDtF9PfFy3vn0qdVC/LsEMYHP+?=
 =?us-ascii?Q?oT3BFvV6vBfJxCKVvdGPupIC5YDB4GrMrcwFid0yqLctwwIE2rQVC0ATwWZf?=
 =?us-ascii?Q?5tVani0L9/Ndgj0gzGNUVmQAZSAaOyFIuKsXWNaCV1d/XV3t+NHxa8lepbrC?=
 =?us-ascii?Q?YUl1L/uarUEmmtlvBPkd742ObIhq8JQZsRDB8dIcEHFejDdVt7TZl0aeYntp?=
 =?us-ascii?Q?Z2XUueuwwHET+rHX8BniD2zYfEvs/jjTZ5Qfhnfs4fn782hTxQfe9XtBEXm/?=
 =?us-ascii?Q?1Ed5Ym0/lDW6iZPqWpUXc6IFtYyOibNtOMUU3eUJCjX6YVYvumKy3MPecWzC?=
 =?us-ascii?Q?hc3Su/MfOMH4UDkSCi7nd/rwOsuiCEByiB67B0I0Zeh/Kt/RRO+aSsjGg5eT?=
 =?us-ascii?Q?vO5xQ4fPPcbfCsks2NFW2JTwzAFLEMJHqvssKzIUaJL/DMWAWnTXlJmI7ufV?=
 =?us-ascii?Q?GgsoeAaBnuZXM+wRvTOiSgdsVbMxf9gShXh93AJUuXw9bIpVjCXvj1engmst?=
 =?us-ascii?Q?CyenwwtvCtmqoOuXOTCTDhAL3wzTUIfYNMb6sOArEmN12HGalqdri2L3LWx+?=
 =?us-ascii?Q?2D1nXak1pAuD9LBulTPaWzDmcmxLGf34s3qiKQ3HFp8pZ7bwFb4nJUBwSKr1?=
 =?us-ascii?Q?4kX8iQJrHSj2gyn2xDfa63H6E/j6WYaQU1jkCF8pl2kREKzz3iUdc39TQaoI?=
 =?us-ascii?Q?aiPTAQkQclueeBevYiDQH+AsgqI1RRlUzpEylp1ZIwSjKdy0BV3qUwifkOEI?=
 =?us-ascii?Q?ohncpxCq7nkAhTqyjCIwf/SVjV0Fllb+bqFJSHr9bya/olFCW811o40K6xS+?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e8b823-0e39-40ab-8c78-08de06e412d3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:29:37.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcjClfmTpTEFKVisrcm7gvhUhNVgL+XSbmXdF4AHcsuHbPCxzFF8m2wbU/jHM4VbDcMF+CHthRbGqYGapAmKqRdpcCA20f94EBGX3P2Vx6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7526
X-OriginatorOrg: intel.com

On Mon, Oct 06, 2025 at 05:58:06PM +0200, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more
> Host Physical Address (HPA) windows that are associated with each CXL
> Host Bridge. Each window represents a contiguous HPA that may be
> interleaved with one or more targets (CXL v3.2 - 9.18.1.3).
> 
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. In some case the size
> of that hole is not compatible with the constraint that the CFMWS size
> shall be multiple of Interleave Ways * 256 MB. (CXL v3.2 - Table 9-22).
> 
> On those systems, the BIOS publishes CFMWS which communicate the active
> System Physical Address (SPA) ranges that map to a subset of the Host
> Physical Address (HPA) ranges. The SPA range trims out the hole, and the
> capacity in the endpoint is lost with no SPA to map to CXL HPA in that
> hole.
> 
> In the early stages of CXL regions construction and attach on platforms
> that have Low Memory Holes, cxl_add_to_region() fails and returns an
> error for it can't find any CFMWS range that matches a given endpoint
> decoder.
> 
> Detect an LMH by comparing root decoder and endpoint decoder range.
> Match root decoders HPA range and constructed region with the
> corresponding endpoint decoders. Construct CXL region with the end of
> its HPA ranges end adjusted to the matching SPA and adjust the DPA
> resource end of the hardware decoders to fit the region.  Allow the
> attach target process to complete by allowing regions and decoders to
> bypass the constraints that don't hold when an LMH is present.[1]
> 
> [1] commit 7a81173f3 ("cxl: Documentation/driver-api/cxl: Describe the x86 Low Memory Hole solution")
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/region.c | 47 ++++++++++++++++++++++++++++++++-------
>  tools/testing/cxl/Kbuild  |  1 +
>  2 files changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 43a854036202..9a499bfca23d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -14,6 +14,7 @@
>  #include <linux/string_choices.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> +#include "platform_quirks.h"
>  #include "core.h"
>  

snip

> @@ -3479,6 +3498,12 @@ static int __construct_region(struct cxl_region *cxlr,
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
>  
> +	/*
> +	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
> +	 * platform
> +	 */
> +	platform_res_adjust(res, cxled, cxlrd);
> +

Noted this a bit in other patch, not so sure about that comment.
But anyway, do we really want to say what it is doing or let it be
a mystery of the quirks. I'm really not clear on where we are going
with these quirks and the naming of the helper functions.

If you split into 2 helpers, you can try something like:
	*res = platform_adjust_region_resource(...);

And then later, do the endpoint adjust. See below:


>  	rc = cxl_extended_linear_cache_resize(cxlr, res);
>  	if (rc && rc != -EOPNOTSUPP) {
>  		/*
> @@ -3588,6 +3613,12 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  		cxl_find_region_by_range(cxlrd, cxled);
>  	if (!cxlr)
>  		cxlr = construct_region(cxlrd, cxled);
> +	else
> +		/*
> +		 * Adjust the Endpoint Decoder's dpa_res to fit the Region which
> +		 * it has to be attached to
> +		 */
> +		platform_res_adjust(NULL, cxled, cxlrd);

Following from above, would it work to skip the else, and knowing
that the region resource was adjusted in construct_region(), only
do this here for every cxled that attaches.

	cxled = platform_adjust_endpoint_resource(...)

snip to end.
