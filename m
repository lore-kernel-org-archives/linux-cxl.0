Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8020F087;
	Thu, 17 Apr 2025 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744929748; cv=fail; b=WJaMmu3UQz5/cQkzWiWfepmx2OSwnjUHv3Wh/FXF8YATPaKC0+B7MuXQRSsULIDy99fw+XagUKk2pItpI0yDqw/yCTVxv1gA+F6yYwDXvyPRw0RdtrqhD8/sebT/0rhL+XWcyP4eHuWXYmEB8TZ4t9CHjfBGBe4mhE/kMyDkmEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744929748; c=relaxed/simple;
	bh=EH20hB6OpaZ67MUBmUHSxpjHKKRFfdvR5sBQ/RuTABo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VIErqeD+gwSwpc+9rxhGzQgMJXtqAWIkv4Jnwe9jVp4h8oroYM3xb9SfRYK3Yi7ZlJk79Vfjcl61RUkula6+cydcErF0yIZRt53XSv7k5AjiF3fKLPXRu6EZyfZfDrQQP1Cwt8zEZMBNalP5iCwBtbNMGkcriv6uDz8PFHJd544=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQiBgerP; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQiBgerP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744929747; x=1776465747;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EH20hB6OpaZ67MUBmUHSxpjHKKRFfdvR5sBQ/RuTABo=;
  b=PQiBgerPDuqlM7iijnRQ9hXAPejJxWCOScYworm4wpny67L4isRxvYHG
   NH2VgA+FkvFQQa4kfVrynnkDLhAOKLS6XF43Nla1/oERnLT1CRI5JAsGo
   wYSflwR+fmZ+//03hmPNWE28gi+pS+oOwltt+OgQdNXdRbChrYAHt0R4o
   ZwvUdAoUD6MLKd8DS6umFlPEDBcKmL7W3Y1PtUsV2J/Ur85diafmLZXqz
   BPyAVfG4bGV2MgJra8VV6p6RZ6EPWi4lw267eWTsg3nTVtCL1KJJq9fz0
   K8mM7ONweHj1iXHiG20zW2N1ZS3uqoJ/vXz3MXXTQapfONc4Gwosn4kyu
   Q==;
X-CSE-ConnectionGUID: Mewu5FjSQnK7tXPVkRuoXA==
X-CSE-MsgGUID: Ajq+HeJpQTqvbrRNwkYDfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57539317"
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="57539317"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 15:42:26 -0700
X-CSE-ConnectionGUID: Sm9dp4v+RnygEQqpTZCVPA==
X-CSE-MsgGUID: PjPRFmqIS9+UDjsTEJJHZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="130960020"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 15:42:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 15:42:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 15:42:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 15:42:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOQzURWI9FoM8xoOCDZh6NyCNvJMw+2VInFPshiMccidaVeHXyNLa+esMViZ1hGoyYNO6HPkrHCKNQoxHy5YH+OXyw1GEsta2UFqWtH5Ov5lzouua6HGFWOt1/IB8cN4B9Gg+GSlTjpeOm6h640BoXA4byxx5nYLxjbd+jaO7t2QGUGu7it91SLAk2N0gR/vwAWFnp/fFWUhn1V929lItSEYqJGmeTXRhNMCfycbiZ7hHEM1O85Sk5O7ycLWglCJEfOX7/xSU0nE9xNvTF3Tb2Vnm9ippgn4MbuxNeFqRJI70Lxx5gQ4Mk6nRT0StyxXRbngA89Fa6PK/tbUErDGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4HZK0+UMCGOYSt5yoY/jPCnNhRidUdKahDR8FM3OoE=;
 b=vYjRj30OiPojeKBuOv0Utj39+Y+j82yZ7VDKxZp4slpwQbZ05nVbeMRE/3gfphsz2FeJx7r4SvpYBsVVyWGQWpfce+V641nrOJ8lRW4lGj/nwiEUIKxaeE2laNSdpvNskEMb7h7rKU/khe/P4Q9+rg+Ms6o+NVAiX19GEKjHpc3VCcrR13GTKPjVXD2nQVppi/J4vR5qXigzhcrz33doCWgPBJwjRIdp1Oc5BWKg+t7nudTiZL2LiOChXUUDmey7TYDed+c7A6kucEg18yuesRfV8ljzGpGbVf4ycpZxNW2IX2pPYwfyhz5VYtLEQBLERii8oZ4KPrYY3mPbOeH2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5088.namprd11.prod.outlook.com (2603:10b6:a03:2df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 22:41:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 22:41:34 +0000
Date: Thu, 17 Apr 2025 15:41:30 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, Rakie Kim <rakie.kim@sk.com>
CC: <gourry@gourry.net>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <joshua.hahnjy@gmail.com>,
	<dan.j.williams@intel.com>, <ying.huang@linux.alibaba.com>,
	<david@redhat.com>, <Jonathan.Cameron@huawei.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>
Subject: Re: [PATCH v9 0/3] Enhance sysfs handling for memory hotplug in
 weighted interleave
Message-ID: <6801839a2481_71fe29462@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250417072839.711-1-rakie.kim@sk.com>
 <20250417081106.732-1-rakie.kim@sk.com>
 <20250417153505.c921f75a035089906bb38fe6@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250417153505.c921f75a035089906bb38fe6@linux-foundation.org>
X-ClientProxiedBy: MW4PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:303:b6::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5088:EE_
X-MS-Office365-Filtering-Correlation-Id: c362de7e-767f-4dda-3694-08dd7e01015e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dSnqlVCyeaZ8pprZqbjQjacvCfMy2aozxMRVduMDtHT4oJG20f4Mca6pRtZV?=
 =?us-ascii?Q?8b8D6sWgx6kQ8Abxipn03f4Fkt8YJp4bbX0LreY22vWopscaRropYR0yXA1l?=
 =?us-ascii?Q?73bbNLoI3pRwWtmAqQs+JrxAwEVS1CQXzLmh17zk4FEXmcCE6uu/CRkFDQoR?=
 =?us-ascii?Q?4D1nP6EGiBaCAeLBvuyNSCyGGZ2onX5yO4/4nGu+ONjMHPjPoZcR3mEgO0IP?=
 =?us-ascii?Q?6rSaD1NmalmPzPbfQGIg7F+F7b4pLWeSYggA9+AzdvkFuNVGtxm2nj8fU7/y?=
 =?us-ascii?Q?XY3OlN11CuC+UtbWLzF3rHAiIRZzcuV2meJjXid2g8TmCxHaTbucd191xFvu?=
 =?us-ascii?Q?+kwppiNwZ8R5NRXDHqduQBPzgOMq184OIoE75ccywBXyonQUKwM75aKtHCh2?=
 =?us-ascii?Q?H7br8s54+wP6QCTqbNzQrST8B4o5JXbfdrkacKI5VxbjVGQlsQDwy9ytE8Rk?=
 =?us-ascii?Q?vIOLXiCpRkriCkdOkLxz5edsXWJP0dub8PKOA1PJ+TOv3m66es8YsfRZwPI7?=
 =?us-ascii?Q?03xH19GuDhej9qAXTrERz8ZSRtri5VFWw4B69JBJKUUeBleZHy7ey09PKNAl?=
 =?us-ascii?Q?KGt8gY7l/JEQ5n37pU1a5iX2Xb6/0wF2/vHAJPEsAZxLkwlqhvkGvYf3h11v?=
 =?us-ascii?Q?OizJwc9st1Gejdr0IAoBV+0gJI0d7EIv1gQ74s/crayXmpb44Qi3WlbVL2YD?=
 =?us-ascii?Q?AEgyBdF/XCdCa2JYvI83Lfh4UQkaGkmSv8qldn4sjVtj7BqajdSDJwLxDvfM?=
 =?us-ascii?Q?iiUFArbYVcT0tByknvwoNBPp701LA17OmaCr23Dzst+jG0P6vA3W6ihZxoaR?=
 =?us-ascii?Q?jI/UUIhxWagkkqzaeBUSOhjAAlBg5Nu3xV/cu3znD19moxm7ZQs7okDT+YJ6?=
 =?us-ascii?Q?8mCPpCeuTsksgfkWOQRP+9cdB+jGWMgD/ke8db6riY6TSGvBXMofae8MNtdU?=
 =?us-ascii?Q?Net+22KgNSWY571pqdqcEuuD++PN7U7U3lSFWGkrtlJOwLgxghHOhCrMBx+I?=
 =?us-ascii?Q?mOV81Dq1Z4JBSgLT1DApOhPlivaUE8uouXv4kWXWH5BZTK97PVZEvzarG+Gq?=
 =?us-ascii?Q?e0yiMDhGLLsjWsy9yZ7Gl9XB3pn76K1ZFl7jRXkSFBXaJOpWJMzOsjuI+cC3?=
 =?us-ascii?Q?cuzcYrHKdEF16XzTJQeoHWzh4zrI9AzNMkaVjuCcIXOCui5M0EAz3Rh23Ito?=
 =?us-ascii?Q?KkH2b22eFx2L5KYH8VFO1ZDhMKs4YfeOxNW8xn7oZxZcOEJIlhRS2/qwWLGh?=
 =?us-ascii?Q?VAj1CWq48WJ91Z4wjbvRoLdl/PNpQuHVHh6sluMIbsfJzjNU4siF0jOFsc+J?=
 =?us-ascii?Q?q9R4oFzf4AhH7hD1I/dBHY4bgxmkK0BlZfsPWRtx6dZ5fFA/a50+ebJ4sSP+?=
 =?us-ascii?Q?oBf1lIGeYTkCNUJKrDDGJNg6BqAM/3p94GB5ThTHim88HPRAK9qqtyL0o8CH?=
 =?us-ascii?Q?9xk/m2Ce6cM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LltekvVGX9hsWPunNySZGjI3NQ8eFLQIuQ5IG2KlYNvkSLxBWDmFPJ2TMInJ?=
 =?us-ascii?Q?K9q0b9X+HXS8jUT5y6zV+jq2b+XRFZR+lna1m0RzjNT5CjZfn0QDWx51hei0?=
 =?us-ascii?Q?fhamOgNftn+q234EihbLqAIRS81cO2oJlOU+JFHfDFCzezTHuaInlUCKB3Xz?=
 =?us-ascii?Q?W17xLF0fNKqbLW0WtnbpJVX5vh/TjbptTxf3tHNVvVOZx4xcG5OP4yc257Gn?=
 =?us-ascii?Q?CLX1mOPyF0pG/6pirEthEVnWFzSwugAEvYePNMr+9HVJCOXHSMpaHO2iWndj?=
 =?us-ascii?Q?Mngu4fRlYjYr23vTVeaxcxouFfIPWszgTbxqkqfmp7QqUihCSaB6DYfDDXWU?=
 =?us-ascii?Q?zxpIB6ZBtJEHuF2TMIAWAZzRgsq9DLAw0737AoOcI4rgwKO1NufbCQ1bWQA2?=
 =?us-ascii?Q?8v5CxkTk6KZwZaJeor7c/OrfaSA1owuHyafpxhAcPDewVx5NNpW4AsRYA3Rm?=
 =?us-ascii?Q?ulxT/8ILQY+NVgTCkC7mP0ynrNO4zjKKb4J8O+EYAhDOevOKMSEHE88DEUmF?=
 =?us-ascii?Q?mTbtqnDgGaCWVemxkKxGGVkPyaMEOm49omsis2wpnjF1ErUYxBGTxRCDXiAD?=
 =?us-ascii?Q?osAiTTrCwo2YqZ/2BmymB+3FxqXR81t5Q7VXer9tqihq9PZCumjWxzcoyWBY?=
 =?us-ascii?Q?VEVuBQE3beLUOo56ZGGGDgr/qul+6ELWEYoQuKH05mp8JzNE782ZCt6MQqvb?=
 =?us-ascii?Q?y+ocf2GgHhc3QQXr5wuhHE4m4wCL7U00ZVUSnhLFlQR+XLv8Ew9DocNy3rs1?=
 =?us-ascii?Q?fjFRBjaCFuddijUYFjqq3vKZdWdYlXQOrjVfdojhBdF90lfNdspLY9KLiHd/?=
 =?us-ascii?Q?ri9K/LmCqzBy1kgnmEGlQCN6O5pE7NeVMIovYVmyRQP5+jgrKKqJOZ5Xdy2m?=
 =?us-ascii?Q?b32ql0wZHDrEUWYkl9ZoBaEjyIR42jroRpuDI3XA1qmhFi4DOusSkyiCuhAt?=
 =?us-ascii?Q?PVDfWdXGBGLJAJpNaa9g5dIPDyutmcFndQOaMMG9apcRtE62IQ91Boc0Z1oo?=
 =?us-ascii?Q?Q1gDFn/QNJVHJ23I5dz3rKMv4X7smHMRP0Qqo0yAKhGD4dMjNsrTvA9hh+DL?=
 =?us-ascii?Q?YI1ine7yDStYRJNXOZeQYdcbORHk6YwPhNm/gWJAVnmeL3IIKi6Q6WQlq9zB?=
 =?us-ascii?Q?wxpMMd+Lsp+O3Hpp8mFgGSo3n8XXDD9sDeiOBZWXhqEnwMwgVqAwcmIi2Lzs?=
 =?us-ascii?Q?7635yEa0fT2JicJ1Vr5St/H/q5aelVJgtJJXupAxl+AwHCLXIemAimwZEalk?=
 =?us-ascii?Q?zATuTyhk5mhOI8//C8SNV4r/Dmy7gLRGcUbl8HtVWz4uK6uBiI0ZoROasJk5?=
 =?us-ascii?Q?03yi5urPR3v952csll90jj7Qch/9YeyLi0zaodj84IkKdgYp9AhADohMGuNE?=
 =?us-ascii?Q?hQqw02JIR+xBwaFSyAgRUzvXedvROFW9SP+qW21yzQBYVOHJuTFWSJ5G+75G?=
 =?us-ascii?Q?6rAFpxHChbpU/ORIXBuKhILb4k+ubCeZT5C2H4d2rL6Sjuy9xSdkkuYxqw4D?=
 =?us-ascii?Q?Ojypd8NmcLPZtgCHAt0rPzIBU8oSNF/aOi+R9557JPfyEO2SCiVc+IOpXKUl?=
 =?us-ascii?Q?hGo9tgqc+ujou7Q+chEOUUzF9t8Cth8Y/pxWAUQx7mVsXx1DtF9woywV/9kI?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c362de7e-767f-4dda-3694-08dd7e01015e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 22:41:34.1332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJ0yvfC82fC37BNGy5zMXZ0bGFlbxZahyWEL2+X1tfvzyvVVMMXIgm5W7j97C89HLoK5mijXfP+mryvkDZ4phfbRWbXvA/3vg1nqIwibYdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5088
X-OriginatorOrg: intel.com

Andrew Morton wrote:
> On Thu, 17 Apr 2025 17:10:08 +0900 Rakie Kim <rakie.kim@sk.com> wrote:
> 
> > I sincerely apologize for causing repeated inconvenience. The series of
> > patches version v8 that was merged into -mm, mm-new today needs
> > additional corrections.
> > Link: https://lore.kernel.org/all/6800742de6315_130fd2949c@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> > Therefore, I have updated a new version v9, in which the problems have
> > been addressed.
> 
> No probs, this is why mm.git workflow (mm-new -> mm-unstable ->
> mm-stable -> mainline) operates as it does - to easily permit revisions
> and replacements as patches move towards their final state.
> 
> Please note that I added a cc:stable to your [1/N] patch - sysfs leaks
> should be fixed in earlier kernels.  I considered this to be low
> priority - if it's higher priority than this patch should best have
> been separated from the series, so it can take a different merge path
> from the other patches.  

The risk of leak is low because it only appears to trigger if setup
fails. Setup only fails due to -ENOMEM which is unlikely to happen from
a late_initcall() when memory pressure is low.
