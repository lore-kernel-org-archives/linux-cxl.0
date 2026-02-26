Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EB23859CF
	for <linux-cxl@vger.kernel.org>; Thu, 26 Feb 2026 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131241; cv=fail; b=QpDs6tNWTQ48qfK62V9PIohFHkyefWhWrjH6H8Byfyj2RG/EwU2wzFBIpGn4rTbo2Z/nCi97DSJrbYheHUn4qa6dhSYlJ/tK4gXKMDNPCpHUKcGeO+2ZucI2TUlAMFPiHdZHU9Mw7EQJL8j7vuEiWqcm/vcoQa0tQgFnKy9obk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131241; c=relaxed/simple;
	bh=9CbfrcdZS6yxqokDNxGFAANfnvZ7Px+flkkiUHm1DYc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mh+TXW3YJF+/q5Jb510/aNC1m23MO23+5Fahh/nf3pshrdGKChyiftpb8OYAmrE+GBoNso6uRKH4envJQPoSgqt11wKZLZMdVB8tFNb7VWouPJ0C1riiCFYpqflJvtJXpKiaFPEXMJRayix7XFuAutoz7+9WYboplSA6179PAVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0LuDPfP; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0LuDPfP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772131239; x=1803667239;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9CbfrcdZS6yxqokDNxGFAANfnvZ7Px+flkkiUHm1DYc=;
  b=K0LuDPfPXeJGFxs4jwAz0grY2UcbPQVF6cVxODgheTcbYRveL1zxfxo0
   voKgXswDuGlAZH+Xg83/FusZAoC5TCqFIK6NVL+oiUUQT8ieeStgLZrU7
   F/ePqAkSn3QLGG+hJue3aKNOcwvghZZKefw3yOwhKQTl0TwqAIqXFt+Fz
   o+YfqUOQOrc2bUAASfaIRcwRPCOZOzAUNqvpJOKc6FrPPs3+tKn+J4rmH
   bTFyiKhk5IqtFSSX1kkySEbxO79HRrDGnF6RSRgW974tesT8LrUVH5i7V
   AvRGiCLTvaZKI1YnSmGBNkqNXUYt8ZYMPTesqC7ZXkDUY7E22EkwACfbl
   w==;
X-CSE-ConnectionGUID: 5Sq2bO+uSOm8CNSl0mBYMA==
X-CSE-MsgGUID: wWk9bGDEQXePRSGa0EYYZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73272538"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="73272538"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 10:40:38 -0800
X-CSE-ConnectionGUID: b+ibY8a6S+WUnLp3C5dcHQ==
X-CSE-MsgGUID: gd5lTJVHQDe4ZyiQA+iwfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="221161987"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 10:40:38 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 10:40:37 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 10:40:37 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 10:40:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sr64z2nID7spHobyRL2wt5/t8iEjr7MioErPh73CrOcO9Pv+2vTZv0uf4jKHcphPObzlHSOa5+QvO8QtTNudVhthSRQTt3BrLAYcT24OQAU/PrdoTgIaPu781+aftKBv8ALxIXK5QBhvtxMVu3ibk52pvDsClAcY+JKNhEtTVIHQrmjW8sM0+FKIhKlFtvZTmlSrKCogHXsIeg/JUffpMTfhCgpsZ5xtyh6rdaph8tx0C3Fx2dDRnTXCeX97zrAF/E+KIHT225m8E3luQCdsR704yrTcrQnitL/tBXFl86phL8xU2VXTZNXWsFmosbcU35NvJNt4PWOV7RDoyzwfOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vslgmqx6nwRkLwl5upfRSQyguS/Ow9CHeq9s95p7bKY=;
 b=PN5L/9/dl1boOdfMTUec6Pct46IH5Fd5F+tD1xiGERgMMlVUiTffZ+1Fm1hw52akxUho/W2MnpxbuD5ZpEIkXuq4br9662eSsut4/jGRwoUtBmjvZW8VtwBrmfPQP4FElCShn4ZpwCgC87V+c+0sKwtJwsz0d6o+LypLpvNftfNMZMb+2jak2EnYyRVfkFZclACXDX60/ZTzaQBQUT+BUUssWF7aLHDbrVwk7vY9XZgLxG7WuXgjIZ8WI83rChcf7Gl07VX9I+u4phLKk0p8v9Ti5Ldg+Tz+ZpRKh+dNxg95BBLjdnEVxj8qzW76Euxgym6E1rEimx0+c/QDA6uqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CYXPR11MB8689.namprd11.prod.outlook.com (2603:10b6:930:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 18:40:26 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%6]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 18:40:26 +0000
Date: Thu, 26 Feb 2026 10:40:21 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3] cxl/port: Fix use after free of parent_port in
 cxl_detach_ep()
Message-ID: <aaCTlYa7XGDTXNQs@aschofie-mobl2.lan>
References: <20260225220251.1708089-1-alison.schofield@intel.com>
 <3a0fb6cb-e293-439d-9977-66b188a2ceb6@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3a0fb6cb-e293-439d-9977-66b188a2ceb6@zohomail.com>
X-ClientProxiedBy: BYAPR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:a03:54::49) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CYXPR11MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: c6304b20-7ed9-42d5-8fc3-08de7566822d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: +WHL4ReIOXkvq8eBvitZMIYfFr24fzzczOu21ZXonLkIPT79dbFhis/xcW68Wkmbj9NBtdybNaa3oLzAI+EH+ndbJcmG2sYxmMVmA0vjaYAwQo47P1lku5s37E6WpfU/NCYIyYjrs/aHV3qt9YVGZDXnMuq/E9wrBfEa9Qu36wtngEAmiQqxIGzBETDWe7igZECRkSXhwWAvrg3b5WRiK0zkKmi9cgbdolq2VN92yfOBzlwpPOGakZUYPn0L6818YDbnu22vmgNvSFUXW0oHEfRBF+/OeaBIbqevSSWwvQKZIpCOjWRrXhobYX+wYw1U0VbPNpZkkDY3PFIIY/EOx8RgXD1uD8ZXlr/bclXxPDTudpmr3HkPsG3HdRzu1JxHwWH12r+wWxJvqQ6M4TuyUzmUnFQc4H1g06kZeajVhFHEDkVmCiWoyXQXPaBO//6Ac7c6iPtU5xNOKIpveOwJMZGpTQpGgjVhmgGlUwJ7HKsg/fA8tFSwZvYsBOsP2ogfq9QdW9fIdfOXF0VhFesGtcowmliJu3ANcybG6ORWJlmL3OwYrp0y2xf6FUtELB27/Sv1EYkVOyzWP4ao5/2UnJIpGBVSb8btWjRSOLD0Kg5MV33Y2RvDAOn9ehEJlzypuQrbryH5ghT3BcROsnPYw3Uln+pZigDyOZZVpIsoIT82jr4LadApCOO783TeHN19E07MjguGpQ3/ii7EVSylFzmvnDg73Kw1wj/i3pNSau0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f97VuxfsWGpzoqXVmnUN25fQK36pCnFWicPj+Fb9kO1y6FkkLowvqLBpuWrG?=
 =?us-ascii?Q?gwPbiK3RP21pFpaTtMKVUv//K4sURUlwk8J3djcpORCkRq3cR12fN3CXBBpy?=
 =?us-ascii?Q?LQC0kYEExkHJgJAaIgDRRSLZi7nEn+f78jHurelt9GmD3EW9WndjV3X2mfwq?=
 =?us-ascii?Q?+3TGTSlnHZQGG3Sam4OxfJe46IK8k8pJVH0Zavd6pYNZ1HdtVMwbfScdWujm?=
 =?us-ascii?Q?CmD5kLay5KChyUUCC9co9t5dGTGCC7n3J8eQj1sPmB5OWKHTcgIipx+w0dRN?=
 =?us-ascii?Q?pOtf62ZxZzRVqcQHWA0je6CPf9W0RcVz5OB1kBZAcXc693ty9vM4Ljb85k4q?=
 =?us-ascii?Q?3V0/rbKMLWbQ4exb7e5Ht9ghjZjo2FPRketqn0liFrClE0Nx8Q5ASntzeeK7?=
 =?us-ascii?Q?vDi+ED96tDD0x0rLTsovNQEpyvoiUAteyEK3+sTAuh/2IqVjAjZVQa0zyTTG?=
 =?us-ascii?Q?aYsGiTWEdmXKsB2GElc2jaOgBhORVwVezjxso/xPDP3T/17luT5FWBpePyeb?=
 =?us-ascii?Q?brHEqpqdB4tYTwLz9yGUzSA1hupgoCEKm6dZ0Uq5tdPUksN026IJbUE6j7lR?=
 =?us-ascii?Q?hK25PhOhdUI2EcaWq7Z3hy2MtmWwCGZyF8q2xTy/XwMNUxZaMyVfyIuKbqip?=
 =?us-ascii?Q?ROjfFshKR5z2fiGfGvSyLOmqKyxMBrMqk4Kb0qIWXsO1dMRILpOjIS3OFxKL?=
 =?us-ascii?Q?7OxOds+o/xpEvi0tqQ1Qf7OlQ4ylRl44dCFZtSc2myHoYwI+f2HEYYMC4J5w?=
 =?us-ascii?Q?Cyw+zLu47mTQq7yNL5iRdi6MPG1nv8+m2QABaf+Ld9wwc4wBE9+rNjNjzl8m?=
 =?us-ascii?Q?XEMOntg2BsGolB+QnbY7NlwtnyscD4FJS/YUh+0aO7SqbawTU/LrxAE+urLA?=
 =?us-ascii?Q?v5O/CgbuLpEesI6/WI7Q6gr9GTUCHdYnTgToY8vDu6DPy6BSTb6BUUP7Baq7?=
 =?us-ascii?Q?l4oJfmvm6Z0XMY1I6YNDhEV7ddNLID9Jr5/KdTFNM+q4DZqUpT4AnpC774+R?=
 =?us-ascii?Q?n5YFDNU0DEM+i+wxxC2+XaLGn8n4ecobBF9gIODpvJF824Vwfmjq/iuW1eIr?=
 =?us-ascii?Q?E4Krd3XlcITmur1odgcTYTqLF/CTjtnQnFJTPEce8nsSGSYOn7szL5KMbsWM?=
 =?us-ascii?Q?RY/SXp0lCNFWSjt6Q9WE/BMjAT+iJXAt+J11gH0MicjMY5dqCWYWoDgTipDG?=
 =?us-ascii?Q?YRn1FvxW418acvt+SI+Owmq9ddq5b09rjjIDGid27k1yIivPoqbaJfbBLdLO?=
 =?us-ascii?Q?uT9cSScPJhHpw8sXjT6r65zvgrVjRF/P6x3l+l8JG9XSDJX+B+kkOVA2ZGBH?=
 =?us-ascii?Q?qe400GodppXDTvT5CW/ECBRFDjRmiBQZdlsSjMp3AQ6ZErOi8uIJ413x3M+2?=
 =?us-ascii?Q?VfnT6z52Ig/9mqHDAJe9b0LOtNays7fJkSWCmoMdJ51gsd0wjBkem94FuZPw?=
 =?us-ascii?Q?KzQ/8uDxJgSBCfG0tTvXrI51TRHfFDZmyj57004v7kIN0vY2BvituXDHT6ch?=
 =?us-ascii?Q?4P/oWX1FMHx51qFuP+qdra9E3mWg5gIuyHvDUHvKTVzCgvl3Ci/vsgSVdVHB?=
 =?us-ascii?Q?wxgBVx6/C2tETtGu+eEvVwLicUbEZSx65TTDwf2QDUjd44PuMIb2ddxTq2GK?=
 =?us-ascii?Q?Au3EfLgdSXFM0vQiXOesaY0h57PdyCs1qSUE6z1QJ0FTJ11drhpfM6A1pRN+?=
 =?us-ascii?Q?lb80Fp8112CCtOVlKD71XwhdpYcVazsxwZcbfW9NGo9rV2PESqajnD7A8fPu?=
 =?us-ascii?Q?xvpdhzLKB954fAI5gIF+I48JKv9XkZA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6304b20-7ed9-42d5-8fc3-08de7566822d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 18:40:26.6500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/cRPwOePQToZMBk+S5uU7TMxamx0h7L4YBm0v65TWqGiu1Jdy//abj9b0NvS42m0nIEU1ZqLTM2XfeZ5sCTqjTh/OaPedgVn/ZGYl1AULQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8689
X-OriginatorOrg: intel.com

On Thu, Feb 26, 2026 at 05:37:42PM +0800, Li Ming wrote:

snip

> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index b69c2529744c..09fc08205ed5 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -552,6 +552,10 @@ static void cxl_port_release(struct device *dev)
> >  	xa_destroy(&port->dports);
> >  	xa_destroy(&port->regions);
> >  	ida_free(&cxl_port_ida, port->id);
> > +
> > +	if (!is_cxl_root(port))
> > +		put_device(dev->parent);
> > +
> >  	if (is_cxl_root(port))
> >  		kfree(to_cxl_root(port));
> >  	else
> 
> There is a if-else block to handle cxl_root case and non-cxl_root case, maybe we can move this put_device() into this else block.
> 
Thanks Ming!  Fixed in v4.


> 
> Ming
> 
> [snip]
> 
