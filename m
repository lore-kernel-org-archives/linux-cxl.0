Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E5E239E70
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470878; cv=fail; b=ESA/tomfX6dm6hLA4bq0SMb5cf+jWebJbBcUO36L5RUamSc+CC4F0iKLUY2Ld8rJwHAzlYmGR3EqJvBa+b+eyLV+oq9bm4deUw/Tl7sQG6X38UF2MVHNORtErR1NyzWFlI6WdXmoDL8NPn8U9E+trg1HaKL92v4AfzrYTzxvEIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470878; c=relaxed/simple;
	bh=Y12ickOHI6UxhARYdfgBDCU2iwCPEGO910Xw5MHE0Ew=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DczzJMXwNJLwCy+mNNm60qMfNnIi3xP1pFKYf288ZKsitSMuAg2lW38tRMivUE4wdr8jVQuTHF1eVkZFpJVJ6gSyiBdhzW+mkwQdwdxqvgEq1/41lhRkpe8lys2hbtjFX8v5+aghOlB9p7Glhn2/Ih70XeTZxZvhUlTrjQ9dpes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PyghmASQ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyghmASQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757470877; x=1789006877;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y12ickOHI6UxhARYdfgBDCU2iwCPEGO910Xw5MHE0Ew=;
  b=PyghmASQvlqgQ7YY5JMch9vCGrh7AuiQ91aNatomgSU8vFa9xxj0mRCn
   7aOJZkQiBob8eN7n+GyKVMW4PZgd63kuJkztGhK9evQ5UVURmGMnT6GMS
   LbeFN1lYj979XYGl39KgY8QjYsC4XZkKTd97YsqE7p+rMPvHAa3C/Elz4
   vw7bNdB6o5kqMv2G34u3clxNY3LSkobrWfYTJ6WidZ3+raaWEQggGDWBG
   wrrUbPYjUBxAip8ypMDrVR6SLaoHWGsGZu/ifGmxdmrpwv8VMQhFL1p/x
   fGZa+rb6LLjiS/3Rkpf/Ao+7DdYKyIr/MOegDTnIyFpdWU6jXm/LAPwE+
   Q==;
X-CSE-ConnectionGUID: dpYxeRgeQ129XPaAaHKxTA==
X-CSE-MsgGUID: Q1FVZQ8fR5OK2QyItkkjCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="70462696"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="70462696"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 19:21:16 -0700
X-CSE-ConnectionGUID: s52SGqTDSd2BSH4zPyZzbw==
X-CSE-MsgGUID: i1oYbuRZSVmvg9WrE5L6JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="204240802"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 19:21:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 19:21:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 19:21:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.81) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 19:21:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8P+s4DjvyHph14vnbedbV0hjLIHd8VMk5ST+nuN7hLJJp3lIpgrNYVfwXQOObTyIgFIW9uA7xG4KOSzhq1zZ4GTHOO0w/Q1jVzaXr6pBFT+LqVIrOzvU3Oc+YYYr6/8gbu2c+CqOH2NYRasziKnBq+t12hoOVA7hE0DXzmWsU0u8ypOVeyP63Km0Y0tFKp5GuxOpCZsHNMUO3GtMqQZeuMdoOH4IKxkmF8G8XjwBj4j3XMMkxtoCotSVyrdKbsRGnafFC2E5nlAGFuYP1owOdwDJ/bxMmVkwX7pq0O5yehhj/rZRLZFIwxO+UnlFyjGRvqZuugLznjARy75GwtERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMC2IH5wHdcjG55JuSmlztkr5IBp5Y1TwcdpKANnHek=;
 b=FWhCk0GpxhyeUUMBzZW6YD8sLfsU761gI7bpjyvB6VOuoDExAFuWcEq+eZbrjuIUadec8pJy6juqrmydaz/tmj0W91AJiW10crOAVgkpMpGq/mw83nsdunrnGd72eK9XciPh4mCpZcLJILf9iPbgWanciWNek85Wqk03bmJUDa8nY7dLOK4n4CUx6RvsroOjZtnX/y6ok42VKE6se5HrvfkRsoRqH/tKvqepPVeBmnvqtNNbTEBbPCVpATVcLjyBufXzOYGmELlIJZDlSx4/UyDmldVjQqYrj1aSPZtdECUYtObPum/bLr9sp8stUyjmS2OGOiumnLxgriAav6l1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 02:21:13 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 02:21:13 +0000
Date: Tue, 9 Sep 2025 19:21:09 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v9 04/10] cxl: Move port register setup to first dport
 appear
Message-ID: <aMDglXCRLDzk4KxA@aschofie-mobl2.lan>
References: <20250829180928.842707-1-dave.jiang@intel.com>
 <20250829180928.842707-5-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250829180928.842707-5-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR13CA0185.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: fee2e6eb-b2be-47dc-c1da-08ddf010b6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YkJx9hmBr+3+c74VSRrtsCccw0tnYjk7s59zRa04dTwF6CBlZFHZcdb720lX?=
 =?us-ascii?Q?/zFZTXWgK40ztoswiMI5NgBcz0BCsNQ8c6eMqNn8pO8llP5lWvqdSkTjjIft?=
 =?us-ascii?Q?gytCFzMW0OPlkZt7Pz4qitd+6jFt9RzNCAg4aGZFXgWGNxgBY94E1BhFzdiE?=
 =?us-ascii?Q?Rko8oS2t+THZ0K0krsohMbD5iC55riuFX+TusmEjhOsKZMXqnu8ImBgu8OnD?=
 =?us-ascii?Q?g34RlhrSAjdBYr1layQYQ4QTxiX2dL2pxICu+z7BqAnLy9DH5taq2cWb4Auv?=
 =?us-ascii?Q?gdEEBUf2v6P7gRNePF2MTP5BKjFOgGcb8ccjRomkHL6iaAXQ9n9RlBb+F8jh?=
 =?us-ascii?Q?i4s/iYpyoAMVqMRSM9mNN2VHWVKP5vqWXVEiXLZ7Gi0Lm1+q4Kp8jct8D6tM?=
 =?us-ascii?Q?xsdIirgM2QQteJmkvSZDAO9ejgtayJXIkLngiimlIbzzgVURjCgiNRfnouqJ?=
 =?us-ascii?Q?3EUz3mA+qVyr4jKyopM4X0y5pVNhQvM3HbHNcoVECZuu8kFYsUPTs6LYlTif?=
 =?us-ascii?Q?2gGTELIvGMaxOEJ3Hzy19LF8iSNVjAh8EQqnC67b4hCcNOdkc1u2kaKbiERh?=
 =?us-ascii?Q?wM3fZ2tgVEu0M6kYNo3WOVUutWo1AlQe6pF7YEUGaIDUOzuop4TEdgM4k+A/?=
 =?us-ascii?Q?mKZz085oqe/cs4j6MA9nEZSFp6TPUQDaXi8qiz+yrR1sDPq6CKy7P469xD9v?=
 =?us-ascii?Q?vVhdcG+n7SEyWGZTyc6KXZEFMwC/NjYlmy4XX7LZqWbykOcYl19cWmflESB+?=
 =?us-ascii?Q?WY+dH9mbKKdesz1WnY3extPzfmwwUCyi755rf+iMt9LTugE9NfchWNvng+5U?=
 =?us-ascii?Q?32O/lz1ruhPqkPm5bQ+No1JuotPywootLc2xVUxZUMngsMp11EVC2zCqkz0j?=
 =?us-ascii?Q?2xdDCRSK3ZvZdZMCnLAGe333Ccj3Ie1S1TwP4me1vx4MLKdwuIaaEdIpjTYB?=
 =?us-ascii?Q?J2B4UYxqML0g84SpiemZX5w+sgowPoXSk4tRTlSqXdoK6HYFlaFCoAY52vf1?=
 =?us-ascii?Q?KiPltNNXqEMLXHIrP9WafpKQFmsVeabxDpqndwPQFz0fvZUuw873OvlvCycK?=
 =?us-ascii?Q?UC7FgYLF9F5+iyu/erGIt8Xn5qqqgcKnSA5IiU5lnmPRIBTkYFDH+Af4A1ru?=
 =?us-ascii?Q?B7rrcyBH+GAqnfqxGQikp6oE8lNbmP0nv+FUjae7ZFwVaE0qNK9fB6z52/eQ?=
 =?us-ascii?Q?BlTdFAUVJY483PC0YlA2R/wsSB0eait7PtKsmcYiAPAdWH7Oj+1/6fCNjVzB?=
 =?us-ascii?Q?Ui4Qr0UbHB5Yx5vRJeNKPqEhKUscpFcz+2qzirgW8JerBgxn1iuYaI5ijlHY?=
 =?us-ascii?Q?Go+i4+Pi4LwDLnMJgDq8rNIJ7gNKlB1jSiV6fv/XehVWK7l8BlePyedKU6MX?=
 =?us-ascii?Q?QcUxbp+1VvQjw78z5PTqcy4/jKiBoX1IVTzjQ+93gxutu5VtMLNrb1yx+sdn?=
 =?us-ascii?Q?sqtve9NyQ8Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B8Yo9KX0bfbOXloMZx3XHY/vENy4UgVGWBomcuQLtYqff4py6Q43xer6Y8Ak?=
 =?us-ascii?Q?ONfA77ze7A96pr2VetSICBoCOJwpby1uWBgqZTxPRdcWsWHPixxu2QmNarlV?=
 =?us-ascii?Q?cKjUHlcecIUzxcjUiMto7N4pEZUsvZFyy+8mIQ3Lq5S9fXmIL+1znNGt1dPn?=
 =?us-ascii?Q?UjyiUplTAC9BdtAjR2A/QfOKqAzxbLpJtpIG23p0mNf8F63HISdGa3VltUcz?=
 =?us-ascii?Q?aP0kfxW9f0RvGckSuH7ZHPD1uKrogPK5dCBzJq/pLIt0ohVqwOqhgKS7Yix7?=
 =?us-ascii?Q?v9JvUkTEnONE0C7tBvxBQXL+xJL8DVW+nB/NuRHLpx5bh8gKNpzdrORuiTM6?=
 =?us-ascii?Q?L0vMPo4sISjFT6VizZk5FT8Eqk9pHL5tlwlfM2bnoXtwyyIMLsEEDtIzd1qp?=
 =?us-ascii?Q?CI+R40dM8s3Oa1uMPTaT/xD1+WG35uA9XC88WSrpduTPqvqELe3iE7nLp6j2?=
 =?us-ascii?Q?eC/klPTPbfL5rihczEIq0AiiTf9YYfZ3YH9xmmJK1KVk6eWuHDtgYhmVcBw/?=
 =?us-ascii?Q?rUzbA7i7Dx7Nv6hq3nHe2uQEdbcS5nbEUYJOwTllT2Igl59S1FUUItf7HGv0?=
 =?us-ascii?Q?FuyvVu7FomQdsXkIAJ5xwdsbbogm5Pjc7qOCXTrwjfjeBjBRWlbyePKUefDK?=
 =?us-ascii?Q?KsfCd74o3sXxgW+9YbACtXR61VmoHwBteVVG+g//TyqVT39bnTtC3WJ4bl34?=
 =?us-ascii?Q?nLxex9VoZQCA59tW93kbIZMtNtgoQkc5HfWL/b3FEi5DgX+68A1xKAFNowfz?=
 =?us-ascii?Q?5kvelmzE84gYdbeM9GMtBwelwHCvvvicR8hRiTLG+6+rGz5STRC8jai5dYRV?=
 =?us-ascii?Q?FVZYfvLK2N9ExxLYyFMUSEtul1+I8shOJWlNL7bX8TMk7c/dEjo6wmNl9GaP?=
 =?us-ascii?Q?AZ93utnxIK3NMDCCcLc2z9bnZmaTnS+SrCpkj6BhZ8ILYnQwjHpUpSKxxVdd?=
 =?us-ascii?Q?j0vnMLXBxGX0nsvlQv83oITjHyHNjiPA7C5wYLGabyyBSwnfOi6eOftwSjvy?=
 =?us-ascii?Q?KBH4/gTG58e926Ejewfm67HllK3uYIeCju5RN19TZStbrHWdVbYqQN54fS6O?=
 =?us-ascii?Q?13omzXRtMpuj7T5YibDFnxNPjM+A+QKthMPg4TJMnZqqz4FeHKByOmjSo6TZ?=
 =?us-ascii?Q?5JaUkHm/kWsWK++0GDe6r6lCSC8E+e+oy5FWBVGcPaFJ/OOAR+GG+gUq1dff?=
 =?us-ascii?Q?NMA7lpBI6QEQ/5zWOO8s19f6aWOWqsf/u+fDCDYqGGsRz6wgW+XcqfLPWI8n?=
 =?us-ascii?Q?8cQBFOSVpEmLpXDUZ8MINU+B2X5p4JNU0PMf3rGK0bllvTP851npZ8ASojzM?=
 =?us-ascii?Q?VFaBr9yuOIsAQ8VCONdiWPOQX0JHqKYpGwyvsnt0KeQpGiPWBIR+1G8Mvbi4?=
 =?us-ascii?Q?17xSraJLoSX1ya8wxmeSIGeRoGSlDxN53H9UNqvDMs+RPLhQ5c5SRLf2Kgop?=
 =?us-ascii?Q?HL54JqldyiAWyVntBrmoHI6UvXkY0L75RDbQ0OvFehcePDr9D9v9jUZ2kXWo?=
 =?us-ascii?Q?JKg3MAiff3X1osuhnjUpBmCYerlD3FbvyvEe7GoRkeb1MBJWsfdEeGqmu9Y/?=
 =?us-ascii?Q?A5/mkr4xpDkopBt3pr7HvzlC9sO8Usg6uHU7lT7uzDIwKSlD3vIz5kDOwo4T?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fee2e6eb-b2be-47dc-c1da-08ddf010b6a0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 02:21:13.2491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rzT7Apqer5KspGCA7Akbq4UZgT8J4Vtbpwle/J+YY69mZl0j2e4xigdMgS8goTdZ+PBgvhfvbSjiZYE+UtmJFzNFEXARUTsLyJ6H5zaRk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6771
X-OriginatorOrg: intel.com

On Fri, Aug 29, 2025 at 11:09:22AM -0700, Dave Jiang wrote:
> This patch moves the port register setup to when the first dport appears
> via the memdev probe path. At this point, the CXL link should be
> established and the register access is expected to succeed. This change
> addresses an error message observed when PCIe hotplug is enabled on
> an Intel platform. The error messages "cxl portN: Couldn't locate the
> CXL.cache and CXL.mem capability array header" is observed for the
> hostbridge during cxl_acpi driver probe. If the cxl_acpi module
> probe is running before the CXL link between the endpoint device and the
> RP is established, then the platform may not have exposed DVSEC ID 3
> and/or DVSEC ID 7 blocks which will trigger the error message. This
> behavior is defined by the spec and not a hardware quirk.
> 
> This change also needs the dport enumeration to be moved to the memdev
> probe path in order to address the issue. This change is just part of
> the code refactoring and is not a wholly contained fix itself.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

