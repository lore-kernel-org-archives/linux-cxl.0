Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB7BD2FE
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 01:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716944936; cv=fail; b=GzIOuEEmFwZbnQP92g8sL3NijBFitPwvtn7xJM34LySJM+ufw2qRSwt7ak1pJ4UrismyYTqFbhSTOXHOtXCM8L13f6df98aL7d9WTjq0nh4DPahjVqG9dguzq3E6l/yy7nJMt4h5unybV7Mp9YECaw8lmGzI2O3Hbh6RR/9DH4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716944936; c=relaxed/simple;
	bh=++zLYdnx3snrQDBczQaFM806QztG5FXVamC/biPDH78=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=drKlCxZj3JDN8q7V6cppQX1Fn1MbswQQ2WKvAovWdStqrQK34j0b4kZwYIDBiYGTjoV9up0cgZfjO3NNtTq3GjuJhUsc7h1vrkio19lQgDZUGTL+yAciSHKBdTIFfI38Vs+irWds4TBE4y5qPHaa1A52WBLkM32UIAitejTwccA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CX/tOeXD; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CX/tOeXD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716944935; x=1748480935;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=++zLYdnx3snrQDBczQaFM806QztG5FXVamC/biPDH78=;
  b=CX/tOeXDkcuyrAGs+RLT+xy1RvcBMRfn+1wXLq/uHGL1e3SZH0HRD1pD
   tfAn1FcIEH/X1OQ4oSf5HCZATt/deCRLFsH2+YtKYHDUrd9LHtvMwSAtl
   x8XameC9PRPAfg2+yB/68Q7kife6KtidPyMx5/BAPUKaDVW00LHnCag5S
   S21coVO/Dmn03RGrBf5SqUfkdkz7NvQARkocaPzlRgN+JYA70YN9aF/GR
   jZlsc/KXk/ImYdzA8/aop43Dw6Oo8XR7qON8xFV6tiw/l2CgxnfIxjbPf
   PNEI5uX4MHIpJRy9DI6by0FVqFB6Ewm2wRIoYc9HUE5JcDWUxUbwnJzWq
   Q==;
X-CSE-ConnectionGUID: EJL+soBJTIaJAH1lQ8UiLQ==
X-CSE-MsgGUID: LyB1MVsOQlqwpMC3sk1QfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24738949"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="24738949"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 18:08:54 -0700
X-CSE-ConnectionGUID: MyF4MuFlQvykJuFbVScWdg==
X-CSE-MsgGUID: +vsDR5BRSG2x8t8v6XyKvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35319881"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 18:08:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 18:08:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 18:08:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 18:08:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 18:08:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt0Hv6OA1/gErr69Rxt7Thm98m61Etqb33hZNEPun1u0JTR3T0ASkrrV6YoqZvk+aS/WXtUagkBzE2wRFT3Qjivp171fMqqNRiNlLIgTpZf87MooxtSfjxpQYAzWncE9GyOlPJI1quw0em99biiG5gH+PscvHmwCgRCrRMI/kC6YBydvPNITFdh0CqUP1VUv5D5/K9BO8LHDlcq9EGzDMsdJP61OQH3MunkyLwM4hFWGD0PjAX6WM1/1zjHtvsSETIB7GWZ+MrdiOT/RMWnOYE7EYBQYE74lvY0rGZ6Z6gYSR6lBIqtsxauXOInQ0Zvx30oM+drrTKq6zsut2YIiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa+USEYe2YzGaiheCiilpAHrgI8y7Sa8U4OhFgNbO3s=;
 b=VanmbAFLK97CSxgNf672icCahysWbYKu13AdE9KyENkWc28YXWhMxC6qkISHi3ufrb8tJCodVq+zmd8IexAQZRI95QzYcoL3G6RvwlK3CCAQRh2yPaY6atRTz+UPIbNwwFzeRE/dH8eWxN+JMttJuPbuLm394oI1c6VcSNFgU9jww29fiRXOJwiZh3mKuITrWd7IeLMRzdBlC+XYzNlP7U/RkZB9EEpoZ+OPBepiCVeYsgMRKW0iO4bk3Q2MiTfN8nJWwmsJY6mDSgO8itf/ZKDanr9gCcq/h1tN8/HyGAU3NnKV/xEXMDCk3TAOAXdkwdjVGQJ8inEWl2VUSlS6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 01:08:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 01:08:49 +0000
Date: Tue, 28 May 2024 18:08:47 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: CXL volatile memory: How to restore the previous
 region/Interleave set
Message-ID: <6656801ef0dea_1668729484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <36106fcf-1062-4961-8918-4471fd313a74@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <36106fcf-1062-4961-8918-4471fd313a74@fujitsu.com>
X-ClientProxiedBy: MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e163fda-44fa-486d-d336-08dc7f7be58b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hLrv6xZM84jZUnviYjsmnYS/rQfk6J2L9Hz8gIvTRTIFc21AGlU3bUgFZzPZ?=
 =?us-ascii?Q?0sUQop5TE4q0Gve7Q9LgrIj+AqmJw5RuqrRglu/Hc0ceeAwa3V1+ybRF7aYr?=
 =?us-ascii?Q?rlfY8C3Cq7Jo1EsxUlcN1t7khbwsvCtD/wHCueT7venRGbAuGMfxXcKzwo0f?=
 =?us-ascii?Q?ZZ6YJM1gw12u9kv5+0OFmF2lAfI9aGWi60mdeBwESmWiCmL5HrKrH802aJ/n?=
 =?us-ascii?Q?WJlQc+BjMPSv+woKDp3sWVtjqTxA8UhtxHRhPecUcqI9L8qLiA7khrYvL0A+?=
 =?us-ascii?Q?yO1s349QuXkvsedOCEAN8esKYTQIxiGuaWpRhhoJS4zpokTLr9t73gW9iz/l?=
 =?us-ascii?Q?4dXBnvjCrak16lYSZ2ifCULC50z0wudxdkLKVgTPR0aWu0M+yWxA3tVfm405?=
 =?us-ascii?Q?433jK0IcSrVuZXD8TqLzldh8M5A2/5S4y2B2BC9Iy93loPstQ2HIwDRM/waU?=
 =?us-ascii?Q?25U6mGe7AgsjnERkUMQHKz929W3vsLdJiOagd2acufbbiXLR0v/19eGiqqX3?=
 =?us-ascii?Q?9Jyjx+S3YUFTsX8f4o2r8rnHMjmeufYpgyXNfKC45E4FOo5FnaryxY3VD4NF?=
 =?us-ascii?Q?4rwthhXQvKP/y9WSjfm8jNXgY1gBRfEg8e6G8MI6OHRjQL8qeugjMjgNWUYY?=
 =?us-ascii?Q?Ts1naAsPpi3PhoTXYb8JJJJlq+4ahH7AzJQghaBFQieYUVbULX/3PjSEJUbB?=
 =?us-ascii?Q?KH9m4LzO+16pRntglE40VEx2Mj2cZz6wRdca5tbrFtqxBn5LQr6Ml/8rlU7u?=
 =?us-ascii?Q?vzcuaruxhIx2x4kByqJg9nsx0gQHhhjtFMuZypnGsrLrTE4FvyNbeKz6cQA8?=
 =?us-ascii?Q?G+gs5qyBTgImXK4eRFIGPOqdM12NIuQVGiXR/LcKPffH3op8nvu8uh2z3It7?=
 =?us-ascii?Q?OaVpkpmpx43JE18sme9BoQmsNinuu2Xox9XikJM75hQowNtONLQZcx/ybyqh?=
 =?us-ascii?Q?EnJ2FK4gOp48KVYiWiPr2ORfBDcyyRr9bpWDeO6KErKRarKQhU8JjLaRJlon?=
 =?us-ascii?Q?PDOk4nyWpc97jdeIdAuXRePIXBVtXiBYvLyiXQPNtqoKU5Y1e1sYgdQTjDiU?=
 =?us-ascii?Q?rMMCR7Wd0oZ7yDo+/1ns1N9CGUbpfNkxA1z0uRyNEsuDwuYEtIFORnAD0zk8?=
 =?us-ascii?Q?/TgVH25SdWNBW9lLk8ZicoPifbHGJ3nTPWamVtpeDiK40LXYfjGAd/67k1vO?=
 =?us-ascii?Q?HN/wuaIfimdmqUA3FC8/aTyyeCjNg+Zy3+LXB2C9f+xXoU5qUwI9nyKTcc8?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+TiD1ERDl+nJLQ6UWnPweFsOP5Mfy9Rk47M8MDzPS7agV8WoNTDIdjo9JBMZ?=
 =?us-ascii?Q?AnT2nIvnelqorFohbyDjMZYehZ5s3vhPs8WuLKYee4jPTfCblFo8awoEVB9A?=
 =?us-ascii?Q?JHPPmkkSZbMA11a3sTP0w5aM14ImD7H9snOt1gyJz2t2ZGi6k/Z4oQA2T/9R?=
 =?us-ascii?Q?vrAzNb2zl8COyJIb+rWsiBXM3Xhzos17bZLwbD+62QKZaEhuVduY3AJmbwwX?=
 =?us-ascii?Q?jaJNb+zcq7lrPdnsIHErpoRRBCjlnguiCi5u3+vJvcVFLuYNk6iasgUWk5Z7?=
 =?us-ascii?Q?NQKU1ONmY3yxrH8KzCRBdEpiE3Wgxu9uMmHiXlRLl/4OVu/jZ0PDU+96tPjm?=
 =?us-ascii?Q?kN1mJxvSyfE2jCPvrjlHQ/87w4i4Hvd28fHM4UskgopSwZn8bE1DRPP40g/y?=
 =?us-ascii?Q?6Y1YDOHcQNt69m7mdNk6Pi57t7bDZ8xlVctpSVyyqAJGiaiGscGLwg1aB+5W?=
 =?us-ascii?Q?phPzWetMIazW95YKB5tRE7xERmpkVcfmcOi1J151+3quZH0Wb9wx+jwwtsol?=
 =?us-ascii?Q?Z7mJjIRfdjpcTPrlLyIeIxRcuavyttfUSiBK22xzAr2O9xXsI5ONsoDhIUQq?=
 =?us-ascii?Q?Q1jvZDQPhKodtnwbbxroUvJERrqDkFUvsAcesDFu0ff9fMDoTzt/JMsvdSgK?=
 =?us-ascii?Q?bMWZV98zDjv4FYnzW5nExzO5GBc0+8LfLT/QmZ5d/9+jk6FrwQVRpaFin8Yw?=
 =?us-ascii?Q?LtPuL12ezSzDRk2G9vLPTLw/2A6ikQHDOJyZdPC3OjBz5BO+K6EqR8/Y+s/A?=
 =?us-ascii?Q?M2kYFJr9cy3BXMUqWYI3gfzjrM8/UoJYhLzxGIujNtTdX4IrXZZ2ChL9Pj+u?=
 =?us-ascii?Q?VWZI7/AQ6Q/se15hR/gnSYJpU2Wr8tkNYniYFA7TQPDl00tiV6Ge/O6/PEGq?=
 =?us-ascii?Q?17QmmaF2Wz9WUXJ7xkOzzNxByl1IeLWRRhrthaMkhvQYGRjT5MQTGwzd1kUO?=
 =?us-ascii?Q?9V9z11WKn3fRhrI4rJC7+cxJgpicYtaOP/TDIHSXQ20+G5hsLYlycRdSXKPA?=
 =?us-ascii?Q?E2RkPFdoBD4Mf6nT4NdvIdQAurVf/RNUzDsZKqcdMH9p2S+3I3IRy2WEJ1M8?=
 =?us-ascii?Q?Isw0/AGnKn7+dFwbRyHb8CpacfxfZls+cx5ov6/dhtuy9ovm5aZNUDamr9aA?=
 =?us-ascii?Q?D1K5UjEMtlW5Hl+uNZu/MdOSRnyHhQq/ql+14iE4nnNnKpouIntJQ3V+JVfQ?=
 =?us-ascii?Q?YL0tJAeFFC69wk8Vu2tnwU20G6KbPxncvwu1avACZCixkCFVU4rs14Wm1CaR?=
 =?us-ascii?Q?5xWf7AaXCogDGKol/xCDoHJsnaS73NJx9iI0n18vSww+bKRGo80TLETCcHwA?=
 =?us-ascii?Q?0R2skj+LyHpl4vfE6GATYJ5ZBRpZhkfNkD7/GneB43/nVrFp8zzi1ElsUMZ7?=
 =?us-ascii?Q?OaAwlWCLkk23T3H5xQkB1rWBtNS1Je1x52Y/xLuzuId792hS0oglaZH6OrbC?=
 =?us-ascii?Q?jd6CR/cgqNTONtO3QO1g4H6gWM/nEuEUJ0q6KvNF6Bnq1S5m82guxhPBvR/f?=
 =?us-ascii?Q?7dxISGEnuCztSnP2O+8efm912mfBw7HZy+m4o8r5jyuyvPyQqOV5G13CcKxx?=
 =?us-ascii?Q?WxHpYf5Vdfe8cyLFkrOLiypvf/0Pf/0XsN2/IN+R95ACqfFVkPzCYWy/zCXj?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e163fda-44fa-486d-d336-08dc7f7be58b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 01:08:48.9924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +67IDJ7PGd/y0uF3R4PT0HSQEfffJNbfjxjrl5SGyJHRomYy2SMdZgF5LFxExg6azB7qoiRdjWCbg9RdsVk+HGQL5UphPa1/jkf0vx8xIeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5889
X-OriginatorOrg: intel.com

Hi Zhijian,

I dropped members@computeexpresslink.org from this thread. If those
folks are interested they can follow this discussion here:

https://lore.kernel.org/r/36106fcf-1062-4961-8918-4471fd313a74@fujitsu.com

Otherwise, the way the wider Linux community learns about consortium
deliberations is through new published spec revisions.

Zhijian Li (Fujitsu) wrote:
> Hey CXL and Linux-CXL communities,
> 
> I am trying to understand how the current hardware and software can work
> together to restore the previous region/Interleave Set configuration for CXL
> volatile memory upon the next boot, but I don't have the answer yet.
> Therefore, I have several questions and hope you can provide some suggestions
> and thoughts. Thank you.
> 
> Q1, First, I would like to ask about the scope of LSA. According to CXL r3.0
> section 9.13.2, it seems that LSA applies to CXL memory (including volatile
> memory and persistent memory), but it does not explicitly state whether LSA
> is mandatory. My understanding is:
> - LSA is mandatory for persistent memory
> - LSA is optional for volatile memory
> Is this understanding correct?

I would say it differently. LSA is mandatory for persistent memory, and
irrelevant for volatile memory.

> Q2, Per CXL r3.0 "9.13.2.4 Region Labels", it mentions "Region labels describe
> the geometry of a persistent memory Interleave Set". What does "a persistent
> memory Interleave Set" mean here?
> - a persistent Interleave Set for CXL memory device (volatile and persistent)
> or
> - a persistent Interleave Set for CXL persistent memory device only.

Peristent only, because persistence means getting the exact same content
as was previously available. A volatile region configuration can be
restored by recreating the region.

> Q3, For CXL volatile memory devices without LSA installed, if users expect to
> restore the Interleave set to the previous configuration after reboot, the
> questions are:
> Q3.1 Where should the Interleave Set information be stored?
> Q3.2 Which component is responsible for restoring the Interleave Set?

The expectation is that BIOS, or the OS for hotplug devices, deploys a
default region configuration policy. That policy in the common is likely
one of either maximizing performance (maximize interleave across
host-bridges), or maximizing error isolation (create an x1-interleave
region per endpoint).

What is currently missing on the Linux OS side is a default policy for
unmapped volatile capacity after all initial device probing has
completed.

> One scenario I understand is that in clusters using an Orchestrator, such as
> K8S, when a node (worker) restarts, K8S is able to read the Interleave Set
> from the database and sets it for the corresponding node.

Yes, for sophisticated environments a configuration database could store
and replay region configurations each boot.

> However, for a single-node machine, how can the kernel restore this information
> immediately after startup (before /init executes) without user intervention?

Linux needs a default policy. Likely the best place to do this is with a
udev script that waits for PCI scanning to quiesce and then creates
volatile regions.

Unlike a PMEM region where the exact config needs to be replicated each
boot, devices can be reordered and replaced over reboot without needing
to rewrite labels on the device(s).

> Does the current Specification define this, or do other CXL-related firmware,
> such as UEFI/ACPI/CFMWS/Fabric Manager, have enough information to reconstruct
> the previous configuration?

There is already enough information for something like:

    cxl create-region --continue

That would automatically create maximally sized regions until all
available capacity is mapped. As it stands "cxl create-region" is not
yet enlightened enough to do its own capacity search, but nothing more
is needed from the specification side to enable that.

> PS.
> It seems that LSA Region Label has not implemented yet in linux kernel
> Region/Interleave set are saved in the running kernel memory/device registers, will
> get lost after reboot in linux kernel.

For PMEM regions there is support for routing label updates from the
nvdimm subsystem back to the label area of CXL-PMEM devices. The full
end-to-end support for recovering PMEM regions from stored labels was
deferred due to the lack of PMEM CXL devices in the market. So, similar
to Type-2 support, it awaits an endpoint implementation to arrive.

For volatile regions there is no expectation that the driver would ever
need to consider labels because "recreate regions by policy" is
possible.
