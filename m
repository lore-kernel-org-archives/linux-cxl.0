Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9E423237A
	for <linux-cxl@vger.kernel.org>; Fri, 11 Apr 2025 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389871; cv=fail; b=PhtGeLy6k6EyStZcpRRs/6co2GwJLBRZg7Igq5DiZXGzfo1L/r9mVKzOPa/CwNDki2QcONn8k19t7beq9I9Otk12j4e9jLJUCzCHKgTorqrjL6R58qmiFaQ1dtGl5tkbWxsNqz5365G+A+7ltXO50JU8pBUK0XVmh3I1yIPEq7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389871; c=relaxed/simple;
	bh=MISPFzleyk1vg23nrxyl9BWv0DyctPKM6VDeDq2FLp8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Caj/JIQwLtwlpgDw46hwD73qgWoq0OaKrehyPqM0RPYZ1jOfnzQli5FzFUEVYOyHS9KH9D+HWBi9IPVskwHL6uVpIQVU3bhypPJ9BEAxX+qc9zdmcqxBw2WXs3a6bGsNRAAwd3diLRvK26p8PlrnHNonRw5wEavByXiZiEoOFBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHJI+E2i; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHJI+E2i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744389868; x=1775925868;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MISPFzleyk1vg23nrxyl9BWv0DyctPKM6VDeDq2FLp8=;
  b=EHJI+E2ijsNMDPMb8823WiwRYrGzqMCLBVbN5eIlJXn/2j3+APEwkZgX
   EdbEFfcLqlFcLKlKcktP28PcOzZ1QZflr8s+qyLa8OUg1rna6+3ELPESY
   9STQ5MdCyo9ECz4ErAWs/76H7gQJ4NWeQRdNNhy6mT3ouHwG0tuz2RR65
   5iTcAfWw9Rs0Z4XJapPNCHOLD5giEAA1a+qJBym1C3h1FvbPHNTs+g2Ue
   R8VDwuJOfQFHGYDqv3PPFbc49NK5bMNolNMwGdyVNpbJyuuOYF+78ZN80
   +gKpgE1lmzGSQmtH/gvejh1JPxKUWO2628UqgYhGMR9gLNvC5Lt+J6OsH
   A==;
X-CSE-ConnectionGUID: V+DYQTLnQk2zn3MNi3g59A==
X-CSE-MsgGUID: 0VHMbEhjRMSQPC/pcD/AAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="56612728"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="56612728"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 09:44:27 -0700
X-CSE-ConnectionGUID: NxnECClDSOSWwa/uelTMHg==
X-CSE-MsgGUID: eebptLCbQ5ulTfM8RuhRLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="133344843"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 09:44:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 09:44:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 11 Apr 2025 09:44:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 11 Apr 2025 09:44:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxeTeT8WVLvMptVNla3NpCQiJORrKk2/pY77sZdew3jszmgdXEr5CeAzKEEMpmzmb8DCieX1zPS6RJ2M1o5jcnLB6oYsvuAA1PIKpspEnRSMVmTWtBOiRY0LhSo6TmIiDbK0jtoAynmjfeQyKkBNMvCEL0L+TZQsOt4eabgVL5pj3u8cMUI+5NDmuTWmnxez6DKyTkqpVEKNle1SKGbFV47TPwCyX1EpnisMQpFzCIs8j2SHh/l6F903ovJlHSFT560nDLwoHv7gwIb/N0zEysaiAUk9L89B+3XenB1CzJYKswQNBM4OjmbkOD+ZpWh39IJYP070lYzgrekS9OR6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNtIGqH2tp0jc/ZYO0K+j+7kF7HdoQ6IFT6guBWWVMg=;
 b=co35WtL1i6sn+fJsLovbDG6J1VfiHL58RghEr7ywW0MOCW/g7DUShuERUJxRz6X9kKGCSd/9t8Nyfn2b4DfVCNJzZmlRoka5rkd05VAxWrl9b1mgiuLj1BTH/tDtlkfQVPELJLwQr4jGzP2ux16ObypDOYK8a61/aaliymqVfCE6VlcTc7ugnxArvrUSaotlZJmUpbu5P6ax9mp15sp67bCgiwtA/g7hkEi8gEA3e5vmio2GMNOmBY0ppyudGHu7tX9abD+hBGLGP2AlkloO3c5B7BEaswUG8fFTGDMvgUDMrT9pkg4laNt87o0v4AP0kr0qJO6LRAl/A4dWBn5+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by LV3PR11MB8676.namprd11.prod.outlook.com (2603:10b6:408:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 16:44:10 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 16:44:09 +0000
Date: Fri, 11 Apr 2025 09:44:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] cxl/region: Prevent destroying region out of order
Message-ID: <Z_lG0JsvfS0husxj@aschofie-mobl2.lan>
References: <20250411085218.120312-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250411085218.120312-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: MW2PR16CA0060.namprd16.prod.outlook.com
 (2603:10b6:907:1::37) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|LV3PR11MB8676:EE_
X-MS-Office365-Filtering-Correlation-Id: 65452514-92df-4f3d-8fa1-08dd791814c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kCJRiT3wY1j4Ps9T7qphnKmD8RfNcTKuHdXAZnRFj52TEwoWaf6LdYoIKTZk?=
 =?us-ascii?Q?8fdyOtbCWUa1fY88qG9BY+L5oO4aDFrwcZdkUj2tLPS2ZrcG9gpn0ICy+QcG?=
 =?us-ascii?Q?wubr+uquRlwumFaZK77qCQxoio0nXzcuqiKicE0NQmDD4dyin+Bi5Fkrf4Ta?=
 =?us-ascii?Q?jpK/PB5MXcLu++aZzt5QEGBsHXLjBZp8GNbSpEKo/6fF/9dT3R87d6iJVYPx?=
 =?us-ascii?Q?Lu6oB7BjTIncQjkKjWoqEiWHCaw++OxARDVvxQkTSoULAQX7bTMxwfQ6L5O4?=
 =?us-ascii?Q?1ZN5guTjG/ypmu3v9XXfCSS5ApkJlBbbzVsgOK8UOhoSJIo4KcODYDH6sDPM?=
 =?us-ascii?Q?I2+Rjs0ml6hza2A4Xo8/p/LhkId9SAlwlyQoie8NGQgb2n40O0PFjfglsYhj?=
 =?us-ascii?Q?2ZEo2y08V8KL4AURwiSWGhh9YCaq8TqIyv8HscYSSh5Dsf1QUpPKkuVLhaWM?=
 =?us-ascii?Q?3LBoZpDQkbjYIO/xXMlolxfIhKtEVBod8dpaPlZyGe7KDY1qeWWXoXRqmOpj?=
 =?us-ascii?Q?F4+GrFvvq62nF6sSkUiKNWttu7FwFeXIYaI2wOkzK/vseL5qWamAqo3LOlaF?=
 =?us-ascii?Q?Oe+ePadsAlwBiErAdxPXCTWm6PqgabVwc6+9BpOO7NzLtqhWKnsQaMQ51jfA?=
 =?us-ascii?Q?OsK7lsBxItnyCFdhl8GmHazFhfxNs63KvNfS93B2197CZxh74cxZR9FrqJmI?=
 =?us-ascii?Q?5tD7Yos6A3fOizEmUmh4nCA5XQJnyxecZuWIXlnpMJtX+4cGr2pgsO4NuyZD?=
 =?us-ascii?Q?QYMwq9eAWS9OEaliIzRLywwN6Aa1LRtabqpnTye55CemKHh/nzQNnGv/1Mmd?=
 =?us-ascii?Q?YJU+JnKRasprPmnJdhK/wwJUIu/sYDfTdOuAGtNKhFkHYh8dEd3RN+28OFgp?=
 =?us-ascii?Q?xpEAK9N1ztC904hikiLF+is/8fy5cLrmPX4SEOdVvkBlLnxKC7oJC7EDz5P9?=
 =?us-ascii?Q?4lBKxhkigKb8yjAY29CwGv99QVxnbyoBqW5Dt2rEqht7xxeQtNTnWopF6POV?=
 =?us-ascii?Q?TsRicRYXIPuxaUwLxKAIjmRyWrXeKGorAmS4M/6kWMDOz2quj7e6/XOhg3xY?=
 =?us-ascii?Q?QWVUgI0t8CRPcy+RETJQ0O/hVd8S1043ZOiMTkPXtvufODl9huYP7X0dRrg4?=
 =?us-ascii?Q?2SCtQGjErDrAM+T+F0zIHowjNiQfiseOtR/iFkq6IF10qYhsqi82WC7ufn5r?=
 =?us-ascii?Q?KWQ5FPAvYDO6gaGZC6xtnh7P0n4Gttw8KN8EbdLANtGmejNlIDwGal7mTauX?=
 =?us-ascii?Q?XZ3dGWiqdVWFw9b0Sg24hOyfn7RuML5DwDLi6X4Qh1REG2QQLbSiNzAueLBa?=
 =?us-ascii?Q?o3oxBtNDz90mZhg3wJzMpB43L5JGtaVr7E2IJm4qjzpaLDS846OttFBGBO7t?=
 =?us-ascii?Q?X+XNJJZuIb9JQ0HAy5+5Xqdjl2iBdBl5M0ywuH5aAaOts3fXWIRvwMLOxrFT?=
 =?us-ascii?Q?DJBwCD1yjXw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b8wRVUL2NZm2hzO3aeZhZrcgnEwwLWKHE1aUqAz3sTLjkssCrjodPgnLGDvQ?=
 =?us-ascii?Q?5pnog8/Dd8f3vSeJI9+aT9gHmRqfITISGc4nH0gC364cGyfbTtXcKB3RvEwO?=
 =?us-ascii?Q?2L6yJJv1iaDxaO2KpLwLBxsmvoWDmEZ+kRHsCMtMAVH1mgMbZToqZ8+arUIr?=
 =?us-ascii?Q?XeB0OX/+mw3vbWUFBFQeTSlyR3NcZbDhupXfb+RVgBue1wkSjCmMR9lHC2cO?=
 =?us-ascii?Q?D44FXBCjWfIH/fnVnjaBeJpQNj3oyI4qXNU+m/89MhWD7ek26sIxpJvkcQLK?=
 =?us-ascii?Q?EHoK/lNdDdQrJWQKJ8TebfsrvUMPIOsxmw8ZU6XTFqkceWcFzg/E629vm2Hu?=
 =?us-ascii?Q?LlORYf63UhaxQ5Izws1MwvL4kH2AfRYUp0cBJx7FWjOGEpO7eGK3Ksm7iPS5?=
 =?us-ascii?Q?n2rde0vCmdYptf4Kbt8+GB52rj8pPqhR+jX2mAR6v3PhjzQosqhzpfmUULV2?=
 =?us-ascii?Q?V5fzMZM7NJ3j3UH62MgWkgxdahyqkC+mUncw1cXGZ3vqWC8Uy3niFW+FqPjx?=
 =?us-ascii?Q?NqjWAuixrIRvjrOILbHwcOfZ91gkoEtFwJ74MXZmnpo6DfwDKtnjWyIxRTSg?=
 =?us-ascii?Q?luRh3o0re9h0HX5yXmCp58GqiZ4rRdcqmILCHi5G0xALrpAiZggdwoFEt3+L?=
 =?us-ascii?Q?WJTP3H55sDlaJx8YSPdG9NFA4velkom8AkpGw+2Mu8CA2UXQ16hcBsYQtH3K?=
 =?us-ascii?Q?fYp2pAAKVHOO9PHrZTfGNqFEs86jFUCHO5fVX1Z37mXz3cjfMk+cor3b2ioO?=
 =?us-ascii?Q?ljjxQcjNooOKRB/SBMo2EIlj+GZ2RWpR6vcysY9PiCqS9WbE+NODoZDr/VlE?=
 =?us-ascii?Q?t5AaZlyvpu8RmS+IwGoRStBE6ElZJbjwIo4Ke8I0CQe8e0X/QV6TMHQGoWRK?=
 =?us-ascii?Q?8SuBXcsowraoPJ4Kh66vFBeAQeAI69k4/WTUHSXg/W+aK6YBQmmKipwg+hve?=
 =?us-ascii?Q?cxt3yzMwUePJ4LQ2EWi5+MxidNMEwe5a57vZpAkkDKRipJWph9mK14I+XrIi?=
 =?us-ascii?Q?B+OvDc032Of8mjvubdiFe7i2SbqBnmk62Z5Bb3a3lAZJRnL/VwJirnMd0q7W?=
 =?us-ascii?Q?Tw6dy0bVRWF+MUx88nCi6PRvMwMr1PculSSOyAG81jL4XOfgFLV2w2rKJD6O?=
 =?us-ascii?Q?XzUW9/VleiNs7vV3D6b+/Yu2wSQKfDYL/OJ1g4JXR+fclkompH42Ok5uCgVp?=
 =?us-ascii?Q?pyEDDNRoZWjfkfzutqS45yTdgNhip9iPiwe4SEuwG+J6twtn+o5qrp3/gzPQ?=
 =?us-ascii?Q?88M3yZnfe6zx3jEg/LUKQY7+mJ3vYPZk3JYK6iUTlROJ/oRAat/cQ6duc18f?=
 =?us-ascii?Q?je4SGfOc0ZJm+hQkyT/NFWx8U7VrrNjeDgbMn0ijhfeccXBxpCqx0H3YRC00?=
 =?us-ascii?Q?6ksLS4zR0tGS6e87G9hVJ6Xr+ozGTqskuw7NiZo6jAnGXrxtQJzU4QCbsmeY?=
 =?us-ascii?Q?O+XEhhK8tDHMhf5dNwWxkom9aRw6QEwUDBPja3tpYGx+TYfJiaDi5EziiJDm?=
 =?us-ascii?Q?Gs7E5fOlbVNb42TKM4dut0zURS4A9WxXUb3UOF5+0ZlmBHDxOF+lkCb83yUr?=
 =?us-ascii?Q?aCzUh9m/jV55mUVA7YvxnOqmjj6uwYCVr9dQSxFCmHv1jSpc3tSLGP4rzvN0?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65452514-92df-4f3d-8fa1-08dd791814c8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:44:09.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YoHJQL8RSlQWzQmwFEFgcwJYKpiq9ysB8gniMOje7YZGej5oRCJCtL+c1KW6GSfEGkKVOXBnT1noFRfVQ4Tvvh5q+9BgJpTPtAzCaUAyjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8676
X-OriginatorOrg: intel.com

On Fri, Apr 11, 2025 at 04:52:18PM +0800, Li Zhijian wrote:
> The destruction operation lacks atomicity, which may result in partial
> completion of the destruction process when attempting to destroy an out
> of order region.
> 
> Previously, a out of order destroy will return:
> $ sudo cxl destroy-region region1 -f
> cxl region: destroy_region: decoder4.0: set_dpa_size failed: Device or resource busy
> cxl region: decoder_region_action: region1: failed: Device or resource busy
> cxl region: region_action: one or more failures, last failure: Device or resource busy
> cxl region: cmd_destroy_region: destroyed 0 region
> 
> Then, the components under this root decoder enter a stale state, the user
> cannot create region any more under this root decoder.
>

What's the complete setup here? I'm thinking of the test case we can add to
cxl unit tests for this.

I notice the -f, force. What happens without force?

> The kernel has already ensured that region/decoder committed in order,
> so just ensure to destroy the last region is enough.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  cxl/lib/libcxl.c   |  7 +++++++
>  cxl/lib/libcxl.sym |  1 +
>  cxl/libcxl.h       |  1 +
>  cxl/region.c       | 11 ++++++++++-
>  4 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 63aa4ef3acdc..c13bb9377237 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -706,6 +706,13 @@ CXL_EXPORT struct cxl_region *cxl_region_get_first(struct cxl_decoder *decoder)
>  	return list_top(&decoder->regions, struct cxl_region, list);
>  }
>  
> +CXL_EXPORT struct cxl_region *cxl_region_get_last(struct cxl_decoder *decoder)
> +{
> +	cxl_regions_init(decoder);
> +
> +	return list_tail(&decoder->regions, struct cxl_region, list);
> +}
> +
>  CXL_EXPORT struct cxl_region *cxl_region_get_next(struct cxl_region *region)
>  {
>  	struct cxl_decoder *decoder = region->decoder;
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index 0c155a40ad47..3ce408b9cc55 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -180,6 +180,7 @@ global:
>  	cxl_decoder_set_dpa_size;
>  	cxl_decoder_set_mode;
>  	cxl_region_get_first;
> +	cxl_region_get_last;
>  	cxl_region_get_next;
>  	cxl_region_decode_is_committed;
>  	cxl_region_is_enabled;
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index 0a5fd0e13cc2..9b5657203eec 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -305,6 +305,7 @@ int cxl_memdev_is_enabled(struct cxl_memdev *memdev);
>  
>  struct cxl_region;
>  struct cxl_region *cxl_region_get_first(struct cxl_decoder *decoder);
> +struct cxl_region *cxl_region_get_last(struct cxl_decoder *decoder);
>  struct cxl_region *cxl_region_get_next(struct cxl_region *region);
>  int cxl_region_decode_is_committed(struct cxl_region *region);
>  int cxl_region_is_enabled(struct cxl_region *region);
> diff --git a/cxl/region.c b/cxl/region.c
> index 96aa5931d228..2eb6f5416433 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -835,7 +835,16 @@ static int destroy_region(struct cxl_region *region)
>  {
>  	const char *devname = cxl_region_get_devname(region);
>  	unsigned int ways, i;
> -	int rc;
> +	int rc = 0, , did = cxl_region_get_id(region);
> +	struct cxl_decoder *decoder = cxl_region_get_decoder(region);
> +	struct cxl_region *last_region = cxl_region_get_last(decoder);
> +	int last_id = cxl_region_get_id(last_region);
> +
> +	if (last_id > did) {
> +		log_err(&rl, "Unable to destroy region out of order, "
> +			"please destroy region%d first.\n", last_id);

not so sure we want to make that suggestion and again, not sure
user will understand that 'out of order' means in this message.
Is that explained in cxl destroy-region man page?


> +		return -EINVAL;
> +	}
>  
>  	/* First, unbind/disable the region if needed */
>  	if (cxl_region_is_enabled(region)) {
> -- 
> 2.47.0
> 
