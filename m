Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDAF3ACF17
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522797; cv=fail; b=kEUirWqO+CanhlMcRIYOE1Pu3inSQE6N5M8tkMxB3yCN0OLZMleYhaePMrS4fuO5UIZ02lJa8VZ9CGsNEclJwCvxI10Lecmj0oZZ+T7A4ROoqN8fU66rSM66w4ZUmT4aZM+Fcs8u0p+xvfwXWzgbin6ADjLNznL+1uhY8TesEkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522797; c=relaxed/simple;
	bh=MCeuAexWWyiE+qY2oTLQG+evzXWmxiI8lAimUsL4s5Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IML5VunnxG+H3wwdCRT6NqMk5MBULeum2hNtjaUKjJPKi8ESEHZ9/Cm6Ekyszw4s+e1DODnEETGxM0NgpdtC8G8y46JFp/W5ULsF5IoQfg+kCa8O9hpbXFR25lX/rd/JTxLaGZt4MukOjbSmX7u4MtxZWC3CEjRJnifsAGZ+Rso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKsJJbRy; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKsJJbRy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789522786; x=1821058786;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MCeuAexWWyiE+qY2oTLQG+evzXWmxiI8lAimUsL4s5Y=;
  b=PKsJJbRy4HpV7aKtuHtayAGibXKjtVg9jKn8Qmnxh2NbNbXWhHhI8dlK
   aG1SL6W7kc7wZM6d0z9pfUSJJxmjaw5pQ8hWLQ1tNBgoJZd23PJbZMebd
   NHSVfdACtSm1M/CKL16qnfJbPD4BPYhQW9/6I2D1N5qG63/bdFEut5mdo
   y+7srSHV41UyZP9LzNvKpE1xoUeC8qcXTYEheEzO7pl03Aq8vooxakkBY
   UFy8NNLMp5AP4PRDSUwJqPqc42wrxGFbq0/77F1IJbtLZ+R/HS6OgBya+
   mGnKc39obm97RO/vYWisUBytxcc+JgsJsr5pg9hPlqBcn2sYmxmALRYiT
   Q==;
X-CSE-ConnectionGUID: w+1HabEDSVue3QBbJIcY0Q==
X-CSE-MsgGUID: hr81eli2RdWUXA4Q2qe03Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100494730"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100494730"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:39:43 -0700
X-CSE-ConnectionGUID: 1y96ps8CQ0yUjHg2BqW3yQ==
X-CSE-MsgGUID: N/VFdYPERC6XdA1JBGTRRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="296689187"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:39:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:39:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 18:39:42 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:39:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvoD6Rq62GpjRcjDUIKGNeMATf4sJ7rOL1BsVFhfqrQPmBIphP3x4HBKvp8zhZPQycgxJAeXwh1M2AgGAAYhx1XIQUhIAKA8tznTIIdjLhwgN+awT3NIX+LSuv76Wak8mMizMRAXFVVEEnpYAkZN7asoIS2ZiQyL608bQaFzyzNgbbJgqx1S6YmxwbX5xf2OpnBks8MSt9xtGsHT7r6e6H2ojsmEfO0BqjFRO64HsbQkshIS+wDQ7XIhejGYiA+R3IPhOFWrzzX7hGYgV8RsB7lMj88lCAEIsUs9JWlWIogI6s+pZChpPQUK2Dw96OMUsT3LsNr2HtHzF/TcGEgIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCraIwdcrazASXAtCCYo+l1wxraVB/nghSm0D4CFwG8=;
 b=zOtz+5O4Jb+arBLl7nOapEIoSPkyL1j2m88oIiX8oTwrptFhUjtMdQKKjf4aAJ1Vn7GLfk8aMQ+BGywIW+2aTVPnTI+vkoecstl80rMjq7mn4Fq66pooWZVxjnfGYnPxVVYmUhXRKOSwKcxk/l2Vuszfo6fYUJXbGiOoz/EbOpAyPgXarnGxl4feb6oaiAyb/VbGlRqRo5OtFtv3W9qJpmW06r5f0JeL5GhN4hEeObb4R25AurbS3TqaJC0MSm9r1OwvJ417g82b4lNMZyhrHI3/s0kRmM5xwMsBRX72xJJxFJ9alqhUNJBUDOFFvzaw/G1qMDRe4HE9HNkZg3x6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB6431.namprd11.prod.outlook.com (2603:10b6:8:b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Wed, 16 Sep 2026 01:39:38 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 01:39:38 +0000
Date: Tue, 15 Sep 2026 18:39:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<gourry@gourry.net>, <icheng@nvidia.com>, <ming.li@zohomail.com>,
	<vishal.l.verma@intel.com>, <dave@stgolabs.net>, <benjamin.cheatham@amd.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [RESEND PATCH v13 8/8] Documentation/cxl: Document DPA partition
 layout and ordering rules
Message-ID: <aqnzVg316RrzM-nU@aschofie-mobl2.lan>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-10-anisa.su@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908102124.2231730-10-anisa.su@samsung.com>
X-ClientProxiedBy: BY3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:254::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e514d2-85f2-4455-e6c1-08df13935ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|5023799004|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: opucrOwpZ00xh/EIBdYVJn+8cu7NuLtTzEx6Dz6oP1QSUjfM9MNo2SlRde1sLnq2wgilXzyjwnO7PleXUdz+6tKpNMtbE6rtDc2/krG7lZ4a/6dA2tIABYkcjmW2aHBtQmeMCCKsX6ZytStQVSo1oQ0/xFT4D3lAICE9o2T65iz5IZ+VerZIw65uokim/Iain0gYjJseSGm3aS0r2f3DCQNRo+49Y2/j9peP0YesLZwkj+hnA+2qRHwIXdjW7aEQwNR6ZZr5wqFFpNItZsA7eyvR2gjJUQPx/WkC8xrUm0v3MgvTJ2bAsMmruR9eLOblSOz9zzE7X4ZKM/4XUA5bykvSohnrP6CWOYeodrZvcBFhX66zAG95RGWfgZDuCz095ZeiGgFM4eQ5Gr0Rj8ww5UiG7xOHyYe/gNDBknbzaQ9eGQtc+jGm3xfuCbC9eGdKPfIL+z2ofcmXoN84VEiIssVlElAxGZrkU31upLLanagji7UiQCKiSkWBpbOFUba8fx4cwJNYMvQCshH47mE3rUUXKiowx4fbfYURtnWFDh1qeakWrWtF7LxDmOtPmcB5IrG4RABwRrLgeDkRVKXXYQph9ChW/W9gHALSvM9ouISWg+uSv7pEPap9HGeUPKhFvvPjPYH46m+ArrTMMPtPpmpEMJgUu6MiXmlUMwssH6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(5023799004)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F6mfl2Mna0b8eo9JQi8fQab9iPuj3Jasx/0f8fn+wbpkENIZj600mzVeVlir?=
 =?us-ascii?Q?4BtRVeYb8K+D1+IVFHLNx8/B7N9P9Y+ewTaqHYQRCZE5OOuH7GWWOdYshamd?=
 =?us-ascii?Q?NLiOMkjcsqnd99P+annunPd4iMYiWLJXb6FATPU6b4WEkJpbtB1IZZDtgbF1?=
 =?us-ascii?Q?+F355eeVbs0aKmXaZoFMRo5V30KnWLSp8UyzvRkasOUJyilBBkT5+oglyZA2?=
 =?us-ascii?Q?FGvL61OO8eX+IxfdlM12gQUE7+JNjaE5RL4oujlo7pr6siZ8uJge7QtYC91/?=
 =?us-ascii?Q?gfmOE1USQRzFpwT83SLOaVOL56K6TVRZUXCf/ocJNccbjYs59l3YnWESOL97?=
 =?us-ascii?Q?o02ir6IFAu/ASXxqPWca4iOg6ThpmaFuD6OiLkQJIYmylI99yd18AkSqg8n6?=
 =?us-ascii?Q?NvwZPpDI+7EcYNm3BwQYQOVxzchhxHb1nj+7VZdulWlQQY4CsQWyDdOYyD1+?=
 =?us-ascii?Q?HOdpeQ5GJQ0nLlifizUwJxiwigSJsj9QkFI0s93dtz2l0nduBLa++9XiIz69?=
 =?us-ascii?Q?EJ1HXvouhC7r3CtjZxfiS1pkAAsyFYZEl7Vl2wVw+gFoWODkUFjRx534pI5r?=
 =?us-ascii?Q?o/JmRNYPcVqrC+KGbarRz5hefckkR92NDg2UZB7KziOc3jCrQ0SbLIn0NRit?=
 =?us-ascii?Q?ju48xb10ZKu8d5PuVvG58YV5Dn/v2eRucULeyLekd6fHQzfnrq1sUL3JoF3y?=
 =?us-ascii?Q?vTLT6dKxEB/I2QMWhQo8z1GBQbz2FcMPWKLcxfk4VeqQZxWJ7enhRkTV1//A?=
 =?us-ascii?Q?7mE8xUioSIwb3nNc8g7O+h0+JSYIoLcYJ7NEjRvJ7aKEBWNMhdUq1F0IXqEX?=
 =?us-ascii?Q?Ck0ZwCcFQWDpeS7fTxf5zUdf4P4oZ/mi0FwiQglKV/dmTmSPRMn1Vx3xAPOn?=
 =?us-ascii?Q?wbgaJ2grIEwhpAmPiXMmCpXMt5JvTZTtRxKyILNo0gBJnMuu/QcOMkhKxWcj?=
 =?us-ascii?Q?CdbiEpci/o/1Cr6jHFsJtZHRcQ+zK7+JnOK2nhMLvGIpBEvEZh4WJaenjfOj?=
 =?us-ascii?Q?ImjBznc65PFxMG/njaGIDhumfl9LytJqLNZXOrsDKyQtZtA4tfZAcK/ENV+6?=
 =?us-ascii?Q?OFkiEwEIiwwOFWCu/qo332zs5PrzyI19/hwJ2xS6pdQa3/Bfob5lg8SXD50v?=
 =?us-ascii?Q?zIKIdelyyoi9cmkMSKhjIh9BWWtxy1y3LWiFanJcdTXgDxUfsW2OHirBqdkd?=
 =?us-ascii?Q?+HjxkwDBetmjQ3nUPcul67k1l6TSBNVFVOIUwRsFqaWF0Soz7rPX0Io9F0KP?=
 =?us-ascii?Q?MrmYLrQ5q0hbJha60ZMQLG17D/HXGQ1QK44ME4agSULFcANkvwKZ/3OeNJqf?=
 =?us-ascii?Q?t2oPzcZSCQMbf0s+VrvvhWh+nMOgZKpOVNUPELyIWPyywAOHw2IGEnPQLGEk?=
 =?us-ascii?Q?mIpfH1XeAKXEaasOaHKoX3oPAFPcGuDc3y15jqmR1Dz8BRrrb389LLVhiJ9y?=
 =?us-ascii?Q?t291moh2yVTKepXIJsagxfTLCx1uWBaoL8GlDniMFdOqNkgARjuwa8JcQdYI?=
 =?us-ascii?Q?IBvOHWg7e0Q+/TGqo3HI/eD4+4ALUrA0DZGNZJm+M2KmoTQmT0oeSPxgtT9F?=
 =?us-ascii?Q?vUOiN59rkkj9J9V64xu55h19le4ZWGaXYFh8AQwIz06pp2sbmh7wwoluZ4lA?=
 =?us-ascii?Q?cb8kCOleK38u7LhPoM3Xnxg//lUDAiyCrDfEzAlxf6JOUp+30fO2Bd1pVdd2?=
 =?us-ascii?Q?bToHASNGea8tlds2MJJVPN7RAnOvzJv4NOyCgEODS+gVX9ZGUh1MX1TScJhd?=
 =?us-ascii?Q?VYpuVOG4evH7yvsIazFMpyjAGVgKSG4=3D?=
X-Exchange-RoutingPolicyChecked: J6dC6AgAntyVEIcGkV8jGRAPM9GXLb0eibGU19S93+XjNBu1gXZO+LYWOBNX7xqrrVR8C6oA/8MhQgNlmBgOQWd4pPWuH40HrgijE+j9+hQ1XaIe/lGf2X4q7T4w5iu8sgWsI7OlqI6Xh+QhxjnRG51zEQ055hUY5jIQDGIsnJQwpjmF3ee9v4r7KBRkXOgd+D2ScnGYZ0Q05m1R64hOPIsv0l9buYXgZY7HLjI15pgW4J2C0Yq2KoiusnlbZfna5Lxc9GGCRQYPK8pmC4IAhr89AdepK5qzbFJnngvGqKZw21p8G+DWSVu/enCG+4ixvrKSqEiQFcue1mnikmVbvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e514d2-85f2-4455-e6c1-08df13935ecd
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 01:39:38.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMNcRRCHrboeQOIcRrjKNEW2NCblwS+u2qlpWebnX5waxEFNHCQbEDEk84eoLF3mKrMrLQVd9n2D1cJsYAqDzjukG+9v7g0EaOu9XLgOPis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6431
X-OriginatorOrg: intel.com

On Tue, Sep 08, 2026 at 03:15:12AM -0700, Anisa Su wrote:
> DC Partitions complicate DPA ordering. Add a DPA Partitions section to
> cxl-driver.rst describing spec-mandated and Linux requirements for the
> layout.


Reviewed-by: Alison Schofield alison.schofield@intel.com


> 
> Suggested-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> 
> ---
> New patch in v13.
> ---
>  .../driver-api/cxl/linux/cxl-driver.rst       | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> index dd6dd17dc536..f0742d6c86c3 100644
> --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
> +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> @@ -181,6 +181,44 @@ A Memory Device is a discrete base object that is not a port.  While the
>  physical device it belongs to may also host an `endpoint`, the relationship
>  between an `endpoint` and a `memdev` is not captured in sysfs.
>  
> +DPA Partitions
> +~~~~~~~~~~~~~~
> +A memory device presents its capacity as one flat `Device Physical Address`
> +(DPA) space divided into `partitions`, which Linux lays out in a fixed
> +order::
> +
> +  DPA 0                                                     end
> +  +---------------+---------------+---------------------------+
> +  |      ram      |     pmem      |       dynamic_ram_1       |
> +  +---------------+---------------+---------------------------+
> +  part[0]         part[1]         part[2]
> +
> +Part of that order is required by the CXL specification and part of it is a
> +Linux choice.
> +
> +The `ram` and `pmem` order is mandated.  CXL r4.0 section 8.2.10.9.2.1 "Get
> +Partition Info" (4100h), Table 8-310, mandates that volatile capacity starts
> +at DPA 0 and pmem starts at the DPA immediately following it.
> +
> +Dynamic Capacity partitions only need to be 256MB aligned according to
> +CXL r4.0 section 8.2.10.9.9.1 "Get Dynamic Capacity Configuration"
> +(opcode 4800h), Table 8-347. So a device could leave a gap between ram/pmem
> +(static) capacity and its first DC partition, or between one DC partition
> +and the next.
> +
> +Linux follows the static precedent anyway for the partition it maps: the
> +first DC partition must begin at the DPA immediately following static
> +capacity -- after pmem, after ram on a device with no pmem, or at DPA 0 on
> +a device with no static capacity at all.
> +
> +Currently, only one dynamic partition is supported. A device may report up
> +to eight (CXL r4.0 Table 8-346); Linux configures the first and exposes it as
> +`dynamic_ram_1`.
> +
> +Support for additional dynamic partitions may be added if devices appear
> +that need it, which is what the `dynamic_ram_1` name leaves room for.  Until
> +then a device offering more than one is still usable, just not in full.
> +
>  Port Relationships
>  ~~~~~~~~~~~~~~~~~~
>  In our example described above, there are four host bridges attached to the
> -- 
> 2.43.0
> 
