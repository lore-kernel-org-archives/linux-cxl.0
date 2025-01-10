Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801B28DAEA;
	Fri, 10 Jan 2025 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534811; cv=fail; b=pWuzXPD3X0aOkurecySk/UHCohygkViqsZ/JJZ5MXpIdcETjH9n27ogyrCwjhcs67nMylyZqHGpnY72RpT0e4bHOoxP2hpS7smvtra/6CCpyX352bm1ftALKMX8obvAF6UldoXaVXl3nP53hXUV32LsgtAlBtmEpsy+iZTY89WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534811; c=relaxed/simple;
	bh=b+qK+kY0d8Zrxy8OC/VjmzmRvVKQqYXVQ7u0RvKrdC0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WS+OIRCwLqJaeJF0xM7CVVcFt2hlggn07f7dRgisV6WDtpMrFlNl2USk/w3fKVBfsZNiQm5NTq8snsfrm82ggU9vI3tnOK6ZHQt2t2koisoQSRi4q+b+zFN37H1NHVrR6XpvBf1q/D99NcQcTPniSSg4tPEyh/55MxDImL9Tsqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1Gq5sVp; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1Gq5sVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736534810; x=1768070810;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b+qK+kY0d8Zrxy8OC/VjmzmRvVKQqYXVQ7u0RvKrdC0=;
  b=P1Gq5sVpUUyRNwzKVmyb/JWSVjzOTuP9yE6wONXnWz8uliNxaIqGS0ti
   tFVuDczZh6bx+NhyBLCL0jusLoRo7MCV2gd2qKcBBkLn/fEk80C3YpP05
   20+DQQ31NuUxeHdvXfGVXe4IIIW+BzjOQzygTAncH1rtjqxm9j4fsCcYE
   iA/+ASgZghPKVps9T+Wzj5hxL0XFOSLFCuB4ltgkxFnX2bZfKqMKSSLtK
   S1uQMWHxJfP2URno3pYm7BwlBzVYdvN2cF6FxZ9o4rwov4Ufk8ya2bVVj
   vits5EbBeA+7VltwJNIQK0StczHiofT2tg4Zo5twIWcL+33F1HET6r2xV
   A==;
X-CSE-ConnectionGUID: +kSPIZYhQZ6sOKAdWjxZUA==
X-CSE-MsgGUID: 3E1hqgLiS7SQHQ5ZGdjfZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="40519432"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="40519432"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 10:46:45 -0800
X-CSE-ConnectionGUID: n2VFd5QLTviGgMqSJXYr9g==
X-CSE-MsgGUID: hjXhMjFDRAapbECs/ArYXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="108849655"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2025 10:46:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 10 Jan 2025 10:46:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 10 Jan 2025 10:46:44 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 10 Jan 2025 10:46:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enAQmdKIM1Yg08IbZ1CUu2hrsSReJ3k5ppox3bk4hvcxmewM/LU3S5spy0DK5X1uCZ+o6zwC7ku8WqfijXNJ+8+RMKD7/VbP4nb2ca+z00tJc6l/IySf9ps0pwdz1ANt+EWmqjBr2hN0IrmkZO/Gr0dFgK321Ftp5+CIP4KpzfYcpF4CYttKY+Q4NqDNTvyw46bki5mIefFJERusZWRqqAMI+fW2FXRchFdPSKTZpwi1C/sczJ/Giy1RSBswfEWfLDbdoFgzCPAuGG0WCCqmYvi8I9yk2I3V/5RKB3PGwDPO5gipq3KLuMhjHn9MKUWBnsgjMGH0e+Lszmvk5D4xoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJEuOF6U85tUvJNinVryBGN6p/h9s3wAcULRsktx/fo=;
 b=gBSj6DnXSsqExr1pZeXVQNW/wjFISEZVph4cvLvg5G6G2JM6+Ax72mMimX6yVSoDwgrq7VefS8KvFn7xUPxyLkNo8lca8viZLN2xptX8ic1o2v7g3A6xV3md+kMEPUhR5g2SetBAWi+TmrHldxCXDyQmLH9DVSVNDYhQ6hHwbQX807sEvpJOyXkAlZrF2mcYH8HhS5cQl1pRvXmy8pgdYsPq2mK3YyzubzVmdck7em3kdxqGdbHm1AFqJXSDGBSYe8ENrW2KVbXtZJKH1AduBVHPN932EsAq0rzGsMvKUNomWj4UMoUt4Dhet1H0Beu5z8Hvb4UWhkdR7DDmPMSKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB7301.namprd11.prod.outlook.com (2603:10b6:8:10a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 18:46:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 18:46:41 +0000
Date: Fri, 10 Jan 2025 12:46:36 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <shiju.jose@huawei.com>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v5 5/6] cxl/events: Update Memory Module Event Record to
 CXL spec rev 3.1
Message-ID: <67816b0c869df_177894294f2@iweiny-mobl.notmuch>
References: <20250110115556.1654-1-shiju.jose@huawei.com>
 <20250110115556.1654-6-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110115556.1654-6-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4PR04CA0328.namprd04.prod.outlook.com
 (2603:10b6:303:82::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c01f36e-a06e-4d1b-fcee-08dd31a71f07
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TMuEimMjQxg8SWLXKUnH+A1Pym60GiOKvnZT38O1HZRaNhXFt0Gwx0UpLpMu?=
 =?us-ascii?Q?zTrlqpdJ8mQMYg1yO4va5aW4O66ruKAmGCgZOQm3T5tQBz6B1BfDy3/wl8b7?=
 =?us-ascii?Q?BWRQG/lEgWAp17CloZGwE3ilG0ygawwjAOqo5OHn2rQ7jtNem7Zy5Br/WCWE?=
 =?us-ascii?Q?uJUQ7jGloui9EVamSajsiEQsAd8oPW6kzfJLUX8aXKpJUb+N+bnmPyA1uVTs?=
 =?us-ascii?Q?j611JnsDYEk+jiDOK/U/SlNdRNeepyfZLoeooakZ5COYVTTK5MZ4y375GFl2?=
 =?us-ascii?Q?lz66J8oO7vxP0BW5Fg8wwjAyojP50airfFTREfpgiJHpNSsHNhJxqvYehTpE?=
 =?us-ascii?Q?ezL3Kl0xQQLD6J7zkCbEMM29KOHZjfDmC6T8Yi1+gV0S6aH/RpjkFYKQE1vR?=
 =?us-ascii?Q?ZdGFmNerIMvpZmWYP2jiKtyk7YE1+3IDKm7OlmX+hYUiGYf6gxI/c2KoI4Cr?=
 =?us-ascii?Q?Mh4A8RCHoitzyDN9Va9Awg0Af7xjOUEIEgH9ObyE+TfhbGHZCK/yh6cvwtBa?=
 =?us-ascii?Q?iCG/heqho9cQ8IDXOcgkmgf8TwH6nL4CemHYPqHIIKOotbVTvPOMKk3bVS9m?=
 =?us-ascii?Q?GgEH4BfZiFe+ssmc7KNBU/PcTpejsOUWJG0nTkdkVbNT4iLTjS4KS3pbBA1X?=
 =?us-ascii?Q?6vdrTlSP19Afs3Lz9yq8V6TVGAOFJomPoBTwVshaXVPqZuxzB/DXbQlyjx6w?=
 =?us-ascii?Q?Z7cy694Imc+RfJxuQvrtMfqPGE3u8p867S8uFZ/dp6NkFseZiNJKzOx2Dovd?=
 =?us-ascii?Q?7z0IVDpbzfN037T2KYtsPdC/vB+P2NqZWvZXlkHuJDEMPPQ7H72Q3LzcWTTS?=
 =?us-ascii?Q?RwBK/RxaQKzuDoN4MNCh3ZGsYmWZev3eYSn/sSI8ErRIuT5PjOAWmNkOkj2U?=
 =?us-ascii?Q?R9Oqe2kw29CEjTnKQB3E/4cHIju2H8dwuMk4mkqyclSYwkfzEOSgBAtV9Q9m?=
 =?us-ascii?Q?tz51S1SZJAuTYMG2sC/Y40Fp5osngAcn/YmrZ/IHgxcmywdYjRnyQEUbizTQ?=
 =?us-ascii?Q?B2xzEiZCW9h1nXSktgAfSSDhFvhHcddAqAGc66+ZNNHgMAhRUxM0RTh3p9EU?=
 =?us-ascii?Q?k80xcMYIWKFR3/7Oiwb8RsL80BB+XGgc56atK8EV8MF9tROnYF+BcC+d4LOM?=
 =?us-ascii?Q?3gHcLxiLmpF0n4iFUsQw8FzkZIFu7s8quiQ4HZjSj5Jg9is65bvOMdTAEEpX?=
 =?us-ascii?Q?sONr5Vd00+NvJffA7s7RtvrYybXf4aDtlB4JIM3hGRcSz/SgoGtjaE8wsmZc?=
 =?us-ascii?Q?liX+J5XZLoPWPKlWkiK0iBkfC4gzqLUTp5u75tg2NafKMZywYJhnUsElnFKH?=
 =?us-ascii?Q?c6Rwy4BfT7rGiyTy1Oc9Tk5cghm2WR61iIXcm5u5/rZ+OPEvKAKOHSJsj4bC?=
 =?us-ascii?Q?vsXZbV4l2NNBRE29V5wXxasm4mFDo+Fgeku5n/SQaITI/oVE1FpU9gK/8BNq?=
 =?us-ascii?Q?Ljz97noQOnI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R5p30BOLxQPf1S8LtJLP0ckr2Q3GkXjYbUvQ/miaEEXAQ8d/AnOTiPAsFylF?=
 =?us-ascii?Q?AGz+CVVh7rAzAVnkP6+kfWXoySWGyKpDBYrrpOzhOPMARzDRAIK5CpS4CF7/?=
 =?us-ascii?Q?UsLZvcXv6Spv/ckwqAfNtP2qNNX7pXt9Yt8hV3V0PnIBhLXgnw7/qNxxJ5J2?=
 =?us-ascii?Q?BkoszaonSg8JBC11BwkzvG8ZGRol+RSEcAW4OhAX0Xww9z6KLSeQcfqVqXia?=
 =?us-ascii?Q?IlkZaOC/gbRmdItfIm755dGLn51Y7Ldk6Es7053xYGacSnNE+vJBnTyaWCmN?=
 =?us-ascii?Q?JTmIt2+GDIhQLPuY9ZQhKYCh9311fMDB5edvcEqFy1ky3nMKpRAAfkpsyMDc?=
 =?us-ascii?Q?hbIrMmemjiy69jZbweN57WX9OnXmEUnSS5JDVOFtWlpJdQi17YoEU3Gx84LT?=
 =?us-ascii?Q?nV4D9E3f8xoBVo2I+P515WuiWX23ePo7cobUa9hXlqstUckC+SRjuG7bwjCs?=
 =?us-ascii?Q?XykKYp/mDz1+F47bR9StLgPTjH5q1nB9CRCzpLJyd7wypsmWrN4Sr5DMUEmj?=
 =?us-ascii?Q?+EVnrrXg2stUCcdjQ4hC5lmB4foXZ2YE5+IA2DwpeAgX+4Lfl2V2jkPrCJBj?=
 =?us-ascii?Q?nO1shMlPwBHobwuQtR6yxSRKcrBws0PXSnkF34pT+BzRshZngE5+rv/YBsYY?=
 =?us-ascii?Q?qJ6/nZDlFdSXdVKkJt7+BYVomdfHP+2ZIriCfPQD1ko9bSILHnKoXC3bYMEz?=
 =?us-ascii?Q?E1ASnX8gJmISTo5AWe687OEODQEpbHvIpx4Y0Rv8JpCHgK8apxHSTlbbUwoE?=
 =?us-ascii?Q?/5/1j7TGntl+PsHq08rW6rR3k4pWPneoiNSBT0++7+rvOgybSgtyFmG7PjkX?=
 =?us-ascii?Q?DkT/rj91XBAgyE35YUJF7MvAxhVb07dy38Zbcg+2A3pLS5Tp6tsEIz7e4DWe?=
 =?us-ascii?Q?xwSEAs2VrkWcp2xuKqF0cdgbqS4zogRuxxChjHIk12meiT9/sw59elnpkION?=
 =?us-ascii?Q?E5cSNv4XujwPvTNSvAUG99n+L6IgFX1vN1TbCy1w1twlm/QOSdVwHmUiBcyf?=
 =?us-ascii?Q?8Caltq0K3JDRBX6v/71+sQtGCG+EJ8ArqXK+NQdcCDlp3QmgD3au77Ub9LTA?=
 =?us-ascii?Q?QZo9bACHfX+j+X97b+Bb81T3VG58xtp+jOcUGLz0jRqrwd3WnBiB9vZzYFn2?=
 =?us-ascii?Q?NeG37Lcz1vgAs/H/mQkidm9MP8rPQyDr4WmhCnlXdsMCNZm2/Qp4IfvXHh00?=
 =?us-ascii?Q?U5DD2Z3yzkyWaXPON6LAX1Q+aGnSdgTG+cJBRKDgcUycZquc4gNbQImVewv2?=
 =?us-ascii?Q?iVOr46uHsSB210d23MB8qTp1UnLtFBtajIJkbi1mrz3n8WrBbUSq3CYqzwkk?=
 =?us-ascii?Q?Wt3T53tvWgAJ0iwCupfcUSBb9nhEVcFouAIZc2KjsICkjcmTmbF0cmWVZPg6?=
 =?us-ascii?Q?QjO9KKHRzuJ/pHrXic3U9If3o6TmkVm7WBFf+YQPvZ+lNs49CN2CTe6eiuSX?=
 =?us-ascii?Q?JiY4LlVp9GCCR7MbhXkvyCs3DgUbgtEl6Kge/vHSz2RMfcNGHXFDQOud/KzG?=
 =?us-ascii?Q?uvGrWZ4GgNTXYlsI7rNRKDDWKNzmXIwP7Rm1rJyD0/nM2Q25wmuB/DJeJ+Sk?=
 =?us-ascii?Q?iohjjKoXysiCto03yIPwo3EMn+WA+j0xsXTnOwys?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c01f36e-a06e-4d1b-fcee-08dd31a71f07
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 18:46:41.0494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pT5aJNQqUEQlxsiMDZ+Gdv3DVAR+SN/S2nAvlh9HgPEp46f96x77B3zclIP8uszCU0zTEolsZMznfI7Cb4ZyKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7301
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 

[snip]

> @@ -724,6 +752,7 @@ TRACE_EVENT(cxl_memory_module,
>  
>  		/* Memory Module Event */
>  		__field(u8, event_type)
> +		__field(u8, event_sub_type)
>  
>  		/* Device Health Info */
>  		__field(u8, health_status)
> @@ -734,6 +763,8 @@ TRACE_EVENT(cxl_memory_module,
>  		__field(u32, cor_per_err_cnt)
>  		__field(s16, device_temp)
>  		__field(u8, add_status)
> +		__field(u16, validity_flags)
> +		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
>  	),


With the change of the packing of the record.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>


diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index cfb8de6f9739..5989e5f9f38d 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -753,7 +753,6 @@ TRACE_EVENT(cxl_memory_module,
 
                /* Memory Module Event */
                __field(u8, event_type)
-               __field(u8, event_sub_type)
 
                /* Device Health Info */
                __field(u8, health_status)
@@ -764,8 +763,9 @@ TRACE_EVENT(cxl_memory_module,
                __field(u32, cor_per_err_cnt)
                __field(s16, device_temp)
                __field(u8, add_status)
-               __field(u16, validity_flags)
+               __field(u8, event_sub_type)
                __array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
+               __field(u16, validity_flags)
        ),
 
        TP_fast_assign(
