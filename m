Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833DD1327FE
	for <linux-cxl@vger.kernel.org>; Tue, 16 Apr 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283156; cv=fail; b=F4uAIcw9WtWNAv56syUBgxjLGtCz14LlOvcxop0SICuc78baeSJVjyDpi2JyT+8CeGsITvEJEtyzbrNMiqfOw+LHFob412zg35YifQOvGFJUar7fGqKBqy82Xl7yIOdsynjTeOt/zOZy+hm8egLhpb+6DdqFwu30/37zkwB7mQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283156; c=relaxed/simple;
	bh=Np6L5hilpE/9qVf1MT3sJxeYFNXqAv3mujpXVSV2zio=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f2a72oAu5xcSXXtgofb7pmLh7ttbNemcL0FS/G2ibDLXVAMd521dDQb1MPSf0+KEG73vYfwkE6Pzin5m0YibCIxhrncDIEBOeNL+5DyJnr46xNjhECRkHrU+QPFnMJZjLFjpyXAHf6QEYlJ4fAeEsuJc6qaGvYI91VuQImCQpcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsMgJVcP; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsMgJVcP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713283154; x=1744819154;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Np6L5hilpE/9qVf1MT3sJxeYFNXqAv3mujpXVSV2zio=;
  b=dsMgJVcPLvpTYz8btz0Up4lvjBBygSrenQwuPK44udtT/D9Tki6R6kze
   bIhZg8bXjBrgSQnQ5IXLrbDg/pi3ZZBmdIjgAp0yebiSbcvYiySqoc9rK
   EGbs1kN8myw9yV/m43fDKSUvhootXkWXplKxp2P/TI0qoC2UPmuP4rN8P
   XS/EafeKu2QaEux/tnLAqUyOHRtR/gpKUbChSi1dQVnfo3W3LFocTCU5E
   hkEa9+Q+VlJleFLRDVW6lLj9DxM+X4qnu5d0TbkbZiVHGyOELM7eWFwBR
   /7lYqmIKS6r3/IK+Hj782uiU4Cy/sMXnArt1DDX0VOikvgb7yJWxB3n2V
   Q==;
X-CSE-ConnectionGUID: cowEco6lQH2EZfrJp3GdUQ==
X-CSE-MsgGUID: u9DRmVKuRXCuJfZ2gIFShg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8597367"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8597367"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 08:59:11 -0700
X-CSE-ConnectionGUID: mOHbEF2eR4+Nj03svH1D1g==
X-CSE-MsgGUID: 62Br6BjMTo2F7ufa5Jb8pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22368394"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 08:59:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 08:59:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 08:59:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 08:59:10 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 08:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfHeVfFiqobLqchq6VptTYcbyXH5GE/u2hh0rLxTAW/LdwHa1BcO3mlzAJn4GV7UYOZWnXshcTj5T+mv+IyK+ekTFOoEuoufpdttQaHgPahfjat7uktQHEZm0+RrUHy+afvlLIk/JawnPXnpBMIqRVUWpJiirYLfytMhoZcmnM5jNPQjZdZKSXTRvGgEfk+IUFkzy2BHvOTk2ED+wvCKLjoLhRnnLxTpms4sxoY4Iru1go+bjLQqIskHncXoWGdMcRD2ZIWy8lSAMstHlfErysg5Iy+penWMAyoRo9NmMx/03X3+6HJcwohBcuAb3MpIwvdJuqJZWLJOorwV1izhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lF7qu1bNw8I8DxqI4jlp0uOZ+jV2IVpv6vCGYQ6KpPE=;
 b=h2qPVmDT6MZFU6KOAJI3JMpiCne8MA4bE14yfESdVjPlLmXvGSKXQrgbBto2oydOdtUMDeTyYUYPM4+Sx0DBkbB7BZJxGUern2pvEQ/nr5M4WB6J/xbshwGnL5tcrwLuo8aejLFLVsocGdc0838UM+bkCk+XXfDOyoQ731xPiH4T0+IglTu+9zAoKKhIeSRbyw06X1vq5YeBYXDaFvllsusxD5gH+315BA9XbyNChdt3eCBh7D01CncvRWrvYWHlwN4nl29rOgct32qKhFxRuxerZkvcxaHshyW7pLVvVjqTEpjSL7XLvHgxm/DiLQ4Hrl2xNUbXLl3fTYrRViY6Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CYXPR11MB8689.namprd11.prod.outlook.com (2603:10b6:930:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Tue, 16 Apr
 2024 15:59:08 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 15:59:08 +0000
Date: Tue, 16 Apr 2024 08:59:05 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/4] cxl/region: Move cxl_dpa_to_region() work to the
 region driver
Message-ID: <661ea04992d54_3f18292946a@iweiny-mobl.notmuch>
References: <cover.1711598777.git.alison.schofield@intel.com>
 <e62889d00f883b804e46a1840454b0c06323fedf.1711598777.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e62889d00f883b804e46a1840454b0c06323fedf.1711598777.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:332::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CYXPR11MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: a574bf25-a764-49c3-4363-08dc5e2e266e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rpagVbU9tJbtf5Rm0R8jcQZ5frL3ch7tzuRupz/SFGMIHb3LZU0SPP0CnOqC9EYRZ0XeRhRX7YxdyrafEleB85I/Nz1lFrGxefdP5L5h9J1RbhgyiA5L32vLDcJxCnsG/YPUHQhKvqZHpbuGquGEunx0XdGuFRLXC1nmG8J7ZXROh3b1HIGt/IkwToxwjMfrQlt0VzjFCBFSUI1P14nJFllrodJ4LyajGbprlTWxfBS6s7M4HIZsWdMNKNMcbmy0ti6C6556NT0u4w1bxRBukOyVpAbvmdUwWMUzrmiPYG3eXEvMuQ/lI+Ogsli0J0KcDE1wMiFrYKR01YKiICfoi8O+f8s73Mi+1TOEX8h/DddEQb29zsRi6uNihEbB0lgmZ6KWHamLL8ks1NNN+dIgASJjIobJ5qjob18Taf5SeALZOvBY0TcukFF+5RuOtK0swl35HfxOtAk3yO+t9Ukv+CTO3AYnFHW2rMTtYvrz44Gd0WDNcOqcjg0PjygXJbmHDZKVmnz+HhcTm9uPCVqfhrsgGPM/DHhiGn+oq7nlzUrNAzqZwlTCPevIryptd33IfmymA6h78X0Wh2r/8ucUPyKKFlIQFrVZLSFgZvntZjRbBW9fAg+NzOucOPZ/CPr8H3WsCJ/qYxyWpsyHU+DBiGytFy99zyyjD/Q8UcrDMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RrovsNGO5+yiFkoqd+ZKqUHfvEdM9rnR76b0lJv01nBE0j2S8fjXxQ/mtV0a?=
 =?us-ascii?Q?DtmoIn6wmMwb2wWX4qGtv1KOOVdBMQ4cQiCv0DRzUXlP/dkia96gFGoKod+1?=
 =?us-ascii?Q?1IeIHPDed08wxgmz3MYHFJbcIeyNoz6/aZLgxFdTvBi5VB+iQ8P3tcK5uZLF?=
 =?us-ascii?Q?XuV/xBUIjTeeXhIOba0BE5CPt55gakB/E3qBinZ5HsMTn5w2gDxDbmD083FJ?=
 =?us-ascii?Q?n0InMQHUUOlTDCu4ctWSENSN1DHSFVL+Bvqp5JL5Hb9Px1DsJNHMwV0CnGxU?=
 =?us-ascii?Q?DhKPqMp2LTSuKRqPV3SPgb1qONB21IxuTZ0b3r7hlElrhli+s25Afj4peoaH?=
 =?us-ascii?Q?Rcj+edIkEJi3PQr+iiGZBzYMHn5NsIxGLRcfRd5/q//WvOGXW0VSKkiMhLvq?=
 =?us-ascii?Q?t/oQ5Nhzeoh7TrjSIuai0MdByEeqGVxpk5ZhJmvJR8me5be49dbs++Z8AZzI?=
 =?us-ascii?Q?6FlQAu9/vYKDaco+yusp/a6UsqeSxQiGA3RhEs+OkWyib1cNhMd9RN62clh3?=
 =?us-ascii?Q?/b5ll4naJSxvusWujzRPtyL1TdDnrSWiCLkAEbRgxcGq1ZEjOTLg9V3xzanV?=
 =?us-ascii?Q?jhyZ3l/8QdDGZmRGC9KSq4Vi7sj9rgb2a4PUBcqtkPVBPxNWUpI5Pef/XjcX?=
 =?us-ascii?Q?BXXwklWEXiQN2TBd3XptW0hopHjSJNx120LgsQBMoDcYTW1GDnfDubbWtvSB?=
 =?us-ascii?Q?62Xkt1HeU22AUAIh4JZ2+EbpkcqlQfYySDh0UI/a9eUTXp7kd91s33rqMPZW?=
 =?us-ascii?Q?PwNj5B7tOl8WMCtDr5bqaQwoO+ygvixhmjEEr+SJvYpcjsVbvMSJETEDzNlI?=
 =?us-ascii?Q?kCF6Z26O0kNlyN6oYo1bS+cmso6zfQ2lew0btgjiD7DoVptpaowKYSJycmAL?=
 =?us-ascii?Q?N/eIEX2EmzYHCkOuajJ90Fi7vb9necKwH0pr9rMTGl8WnHGYPh1lr8gFHxtp?=
 =?us-ascii?Q?AU/qsEQrr/UryZd6IPDfzM2F6vdJ/1Fji1ZgRAyrzqaU3nAMcnxBcHc6/ZWB?=
 =?us-ascii?Q?yM8rEeRPgUzlIehwXoAg1wvCY13nOeoGFKxADxg8DCV2qk5UFwRM9sT4xtOC?=
 =?us-ascii?Q?kzJtYzivUiORmgVO6BsttHGbbjcGKeYW6kag3ygqIGMZbi4D+zSFgjI1XjBj?=
 =?us-ascii?Q?iQMc2ztpGY3wuZC4qcGLnTe5YqiwZilgj6E+0OhRT6CQN+NTPGvMcxvVB+y3?=
 =?us-ascii?Q?CVIISymJQaZbXZ261XaktO0zgy60ieoDDBG1zJBJSYf1QybOYIKKPhnsrRfE?=
 =?us-ascii?Q?6+kVVs6bQZZzouCcaSyXzOGboPxZTDRuCZUeQbcaw8Z8v2uu2V9L90MHX6R/?=
 =?us-ascii?Q?45qEQDSMVu5aaWnThNE5jvooF24yQLpkoYi28yt22OVcVcypaznwKsM2MsoU?=
 =?us-ascii?Q?Iv9BzDzyASCgOVDmLKGcgRe7GEw4AWsbTrveg6hf30BTbJ9cFyB9dZ5pBXW8?=
 =?us-ascii?Q?fZ0hQk53KM5kosrxjFybOX3XM9QN0G58C4DJoxNH4zCpi+gvPjN5UxlS13H1?=
 =?us-ascii?Q?L4Uym47rKj+L2fglA/tJmyQanKlM78rOCQCKNJY2Xudr8rCqFgzqKXG2DvRw?=
 =?us-ascii?Q?T8cVCs+YZnjCeD/yv97IR41tyYC/fVu1ZVtmK01c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a574bf25-a764-49c3-4363-08dc5e2e266e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:59:08.7613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSxaa1umufUGBznqFKl/n0avALFo3FEYh/ca9MnFL4gB+ZP21CoDRtKAtIgaS7oF/FFks8OpdbYHp1eiRNmGPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8689
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> This helper belongs in the region driver as it is only useful
> with CONFIG_CXL_REGION. Add stubs in core.h for when the region
> driver is not built.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
