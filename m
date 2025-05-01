Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A144EEBD
	for <linux-cxl@vger.kernel.org>; Thu,  1 May 2025 00:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746060423; cv=fail; b=c+dwd50UHlyS4Zd+eORwBWS63GEhhxHc3w38vnr0DgPcq2h3kd95tiiX/U3pBX2T4nR56DLttKcOd+RABpNxQYzl+oqKjn8c6vTOAqz/uNvx9Juj/3nojvdRT+3kE7L9nHji4FjUCd45C7lVk71K3KqgY7ftKlIGc8/gfvP8eJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746060423; c=relaxed/simple;
	bh=h7t6ZYtHWHy3lr1lN95eTKSmitnnVjMmqrQoho9zHfo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iSRZkGKcdIpCAd+QJskPtU3wMEQ+bPzdrZNSIOApfYja+Oaiq44hdxZ95BkLCaV7PlPJp5Gg/oX56c62LL7I00nr82nH97ArDI1FD4doOc8hwFPN6PArOGrGnksJPiriUabLgaAfIBADFR64Wv0A3xolNRVxjE+G3iObTR6ZZY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1QScEb/; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1QScEb/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746060420; x=1777596420;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h7t6ZYtHWHy3lr1lN95eTKSmitnnVjMmqrQoho9zHfo=;
  b=S1QScEb/PmYeASBFJIq16p5UaxMHplRTr00CaR9H75o6qkNoByxhNE6I
   y0WLk6xCeOjCOUij5j8z/4/w1etpHC6UmyjtEkIfVAqSAkVxza6Qpsfe9
   QOS8Acx1eWaQUou/DVWIeRk7UPTFUYDbCghd2aMLWGAUo8A1vij80Utdc
   vCledWI5sU9vxM2M0+sqvxww7rN61P8nbFl9i1rxkHu4vZqdNFYmLnCcv
   UgLXXWSB8Hr3AUVURxsHj5G+fqe8Zt3R5kqv/KNG+m6+agtfUA2ye0TaE
   OAP6BpIAG+Rewgx6AR9PCXDPo4K0On6l1sdKhGORAder54ZtMBdkRt09L
   w==;
X-CSE-ConnectionGUID: 4zU7ndGqTxejDK5Hh1lUNA==
X-CSE-MsgGUID: YcQeuzORQzucB7IEoHsiug==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="47825279"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="47825279"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 17:46:59 -0700
X-CSE-ConnectionGUID: tQPzrf9uTweKM64KQau2GA==
X-CSE-MsgGUID: xn59A3yRSgGan7HCaHhO/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; 
   d="scan'208";a="157504440"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 17:46:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 17:46:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 17:46:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 17:46:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1cpaRNRnFDVUc3gyRKi66eLJEr7I0+DTcAtl8W2mA3+dRWXXdD0TsPYSXcexhkgVvEb49uXLUYnjfSN+pzH+74INTc3BJye1ryzLYi6/D1vdsT68edSKjQYU8hb3ZBm86N1oNP0Fj8F8ufzm9lOQTiEM2xUIaELk4YcciY7y+JfyENo/XRIjmAOUVCx6m3C9erNUoMsUtPnhp+1yMQ30ml6dfHxphoUVrRH3sZnH0RyLLCpaqLFT57KsT7vNhX7pwlWmF4KphQd0fTUEBc3iNF+SFdvNeJFurVdC406aw9gz3QP87EkasZHAYBXXj5jNKewJSQ5ACxDTgMhWsFxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIwhKmAFV+XgmBMKsQtzXTdaJPHY71WcrJGsFTRFZ7U=;
 b=vg+qQKFFJXH13e8w5O5CoR87ReQbYwp+di4ZXeCRaLyoIpajLqk/SldF152lMPe5vifd7nHoPrVJ4RhQyxiKhi0i8S/tnFIUuzuTkYU+LfE/vK+C4bJBSv04NKpIAZgFm7B9EfRBu9eJsfbhPGSjrTJo183GGq16gj5JZ1iy+BlgzdHrjYNJtWSBx/Zr99xG2RyCRg9OA5CyCFAMFmWwa63hVpWMzZs57gD90h9AAP5ZjKr+jnrh7LjmUp+BHQBCXcA2HEL3Z0KGLHug6ZndRZtWqO2B3aZUAPPzmZb6QMsh5q7820DpGfLN8FogfSxXc2w6bkEutevXX23GZnSOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 00:46:50 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8678.028; Thu, 1 May 2025
 00:46:50 +0000
Date: Wed, 30 Apr 2025 17:46:46 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/region: Add decoder check to check_commit_order()
Message-ID: <aBLEdh-X_x-3dSko@aschofie-mobl2.lan>
References: <20250430213653.1904302-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250430213653.1904302-1-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:303:8c::6) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|MN2PR11MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: fc66d187-77b0-4bbd-d5f1-08dd8849a895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vPWW1ljySErWBipGc4EmWemSeYEKLu+xIEA5nmA+MH7ia1EYCxWAkhEy1jhI?=
 =?us-ascii?Q?ik4DOiYYrAwETzc5DYUagJcXwY/ol3sajSfnzDbU8gL83je0ra9ezFYVRybc?=
 =?us-ascii?Q?t0P1nngp/SmMZw1o38rlqvMOb6XrAOR/tvdd+E9047JknnNHjrP2IUemQD+/?=
 =?us-ascii?Q?J1CjuXNOyMwZFgEjBbkCbJKOo67P5xf1hWyhEUszAZYJ8D/mVHjMOkTNdWOy?=
 =?us-ascii?Q?WQj6jUO5y4eE92HQ7j5qANLai4N2a/srmeBoDosL6zYgrczDFC1IvwTK5Yvw?=
 =?us-ascii?Q?l9TZ+frGxAcsmdjZzUpoC894hJtlD5PudrsuVrDzyLTrad0HdBJA/CF5sI6+?=
 =?us-ascii?Q?E5HzMBHiGgbs9cyxd9sLZrUKK0QfjzY3WGbhuFSOmzulVzmJ8FqqdhFCtxoM?=
 =?us-ascii?Q?HwoUlPXx2mH0v6gmwJYd7MPZBVXGaeSgh5C1F4zPxZRMY+9Ypg6kFQWGsNN5?=
 =?us-ascii?Q?mHUbfz3sJwWCnPR8apA8hx2C0K7deHkiR+nbpDAHM96iaSqEedlUasINfMzF?=
 =?us-ascii?Q?G5vjeBD9PIm9vnQAsWvD92t3Os/3oQseGv5AvHpV3jnzZzt9kFy2iA1Pssze?=
 =?us-ascii?Q?i/tN4eTMObbyJmuoVPjP0y/VksBJBR6dmEfIJSSrprqmGhNJDK+RskmkOSVU?=
 =?us-ascii?Q?7bchrP1M+NiIcVY5BhMDAN0kObXFCbRRdOrBYDpiJmvDZVVWfESMjoY4tkFp?=
 =?us-ascii?Q?VUSG8tdoxuVqPx01dtHNNRJfIMRjN4+UUXqhmTUmA4UMPDMtwRbMQhWHrgaS?=
 =?us-ascii?Q?9OUlugGuUmsCCqFLwTzkpO712JkfcSfP4ffrV3jpXG56D3VTr59G3uKSXOMl?=
 =?us-ascii?Q?q8jZRkDlp87qMlJPkCSh5cun1BoJws9W2rljfXkW4YYhxum6bK/LjZQP5N8O?=
 =?us-ascii?Q?FlXDc3qrL1S6/WAAkslXF4kYyCgirmEkSqpRxeOsF5w4eLDZM66+58colzT4?=
 =?us-ascii?Q?qTksKVfXtelkDy+RGpTiXhNLvDwffvkP1m2Qa9Q9CRbIpCplZPpFnJA6TKGb?=
 =?us-ascii?Q?moKBYVHGjBJgRKy+P0hRqPSFLh3qA6WL2/0qiBsA/3z5jVdosEpwWriYmH8w?=
 =?us-ascii?Q?MZbYHvFV052SjuE2PNedjo6xKDdyNKXnYr9fG3VzEMyedj6zB0LFwFjaSKgq?=
 =?us-ascii?Q?zLCf8j1phW23ChnSTInKhxeQ7cSgmQ+U2+PCIMc9+WZB7aHVKOKdmQ1A4W3p?=
 =?us-ascii?Q?6nZhgLtFhHc+sB69Tvcex1JzY68DD0hiyucxSnJ3rhnzztFZjXBCRzHiGAIi?=
 =?us-ascii?Q?CpBgUBfX1n+MJPS2rhgO/DHudynUYyEnP+oEmrppHFQma8i7bjcYsoI3f3Xk?=
 =?us-ascii?Q?Yo+5HepGGBpb51FhdttEj2Sw9LJ9VZm7amOiiblRFuX75loOhPTYvWJX4kUo?=
 =?us-ascii?Q?ks9SjnegufJPrFMQuRBFd3eKZedxx67aG7fhqF5/0vTIjU8iHy/wA4QijYxl?=
 =?us-ascii?Q?6TGlL5oXP9s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cIUhJrIpACH26hL83hnHEVB6vCWdhTzX392r6rsdqTjevOaoe39cM+Dz/5D5?=
 =?us-ascii?Q?yAkb1Eroeb7E1hU8ZoLjvT0VDLAg9YQosGmRhsiP4NvjZDX5vb/Ps5fX0uV7?=
 =?us-ascii?Q?/C93DSxXTGpP52qKz16NWbjFcdZxagFdQa03TkTRiX3V2JDieYyjCO33TQEi?=
 =?us-ascii?Q?6/vXGaHGny4STVXjpm+GiPRBQR+pulQyTvdfxbwNUcPaMizKlOxxz0qWTCi0?=
 =?us-ascii?Q?/1flEXZSRJDiPPEDDKIrX0wE/J+jIQa1xQLID8Fc2nf0gzlnsgk3gB6aXbb5?=
 =?us-ascii?Q?wV4XfXdg2+tpc6p8H4e17Quz4x7ynkXpUVMJgmumAcv/0QCzU4i7S+9tnxYe?=
 =?us-ascii?Q?FAiaghjxYAFIxwslAe72gJc8U6qwsakg71e74mHPi82leBvLw6mAZ9a9aUFU?=
 =?us-ascii?Q?j0nRjOe+l+OGFIk4Lca4TkaoOngB/vrFtfxtdnwdGzwrostFOVpcUBQFDEBP?=
 =?us-ascii?Q?yNK6gE+pTOB7hN0Rf9oDTRfWqmPvmCLaIzL1eVOVMa1GZNf/vLe6jt5ipU2Q?=
 =?us-ascii?Q?BGM4v05R3jWconSiCxZW2DkVTuaDWcSEP17LHqsw0vLNhyLFVpQj4bqOA3Je?=
 =?us-ascii?Q?OR8SKsxgm4c4HuvOsmLNegCtyjc2OafglabiC8PYLTwLsVsD4tM1u/AURqVa?=
 =?us-ascii?Q?xFF8eBIvAHh2Ar/xkeI4ojMfv15iZKtnX88YuwlsTofUBSRmC7x4wauh6bCC?=
 =?us-ascii?Q?omGXVFg2SWmfIYuVYb05JKIM9V1jIx7bn1jENqrFHvFwgFQjYGv4uMKlhDsV?=
 =?us-ascii?Q?UsI+ZNxrVqKBodMHll0iONEfgv273ipObQZzxwsLV4isOPe2xEkifhnk+tdX?=
 =?us-ascii?Q?kpm18SNvx58a7nHsco829q9waCX0bHzgcnmL9s1X3aY63ASSg+b8AIMQTeCu?=
 =?us-ascii?Q?Bh7/BkihxC0/uEglDkp88F4tn8kZa5i9OP368nYdsUKvxVrs9LJASUiD0X6a?=
 =?us-ascii?Q?A+Lkm1+gXjKD73f9SWY05sJtk7wgVAZJzGhgEfq94HeQymiDVE/GVlPZ/3e1?=
 =?us-ascii?Q?Op8jhlV9FtUTLpeBUK9Fvi8T58Ga78HF+wZfyRimvgxO7JKUR8srq4DKC4Og?=
 =?us-ascii?Q?9PFoC6g1u6Bb+8fvMVYyNOHZN+Y5dgSS6tqUxwzxJxEYVQ252ZrDRJBswfuG?=
 =?us-ascii?Q?LhwwycNpaQKk4euOg0LzTcqFaLXTDJlonITnzbJpaL/v3ZRjXVIM0EoR37Dv?=
 =?us-ascii?Q?wAXJiTTMzoG9Rndns1raSDGezrfT/hnormfl7clLj6UuZjSwS8dt5RjYNKIm?=
 =?us-ascii?Q?YpaA94N/In1NXU/VvhCccEvE/z9z12MxDJiIfO50rNOFE/DgDOl6RKxklJiR?=
 =?us-ascii?Q?skUarPFxVDFhFPZScQ4LUxVu+BXUJhr/YpFY+GXl9uPJAXHB1UKrTlPIyKQq?=
 =?us-ascii?Q?r5wAYcYBPsNRZetsvabubxj/YIlE2eMdriE7DCIxvmmrVN+K7loyoTF6VvHm?=
 =?us-ascii?Q?oELwRpLW9e01D0ovzUMEvtjEvF2ndAKOXmNtzoqCj0MhMKcF+y21Bu4lGQDm?=
 =?us-ascii?Q?ya5GdVItuXWQyKxOLS14WtJXRZkRyTGJlEMOK+u5p34jC9LJE8Tb2oeETpq3?=
 =?us-ascii?Q?DzlT2AmG8KytnEsKfqa9Y8MssecStqReSW8k2xk6kSMw3ukLMVlhzewl6vvY?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc66d187-77b0-4bbd-d5f1-08dd8849a895
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 00:46:50.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdOOi4tkx0qVU5+vrkUrRyVNzWUeDZt7HbyxF6BTVwtM4t9tRbrVCN79w1ojVt5zSAFHpws/9xFEGlm3B2DDRL4SoBA1W2h+o3MFpMcFTeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
X-OriginatorOrg: intel.com

On Wed, Apr 30, 2025 at 02:36:53PM -0700, Dave Jiang wrote:
> check_commit_order() attempts to convert a device to a decoder without
> making sure the device is a decoder. So far this has been working due
> to pure luck. Issue discovered while doing deferred dport probing when
> child ports are now in the midst of decoders due to ordering change
> of child port additions. Add a check before attempting to do decoder
> conversion.
> 
> Fixes: 105b6235ad0f ("cxl/port: Prevent out-of-order decoder allocation")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Update the commit message to mention and paste in the ensuing NULL ptr
dereference so other unlucky folks can find this.

with that -

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

