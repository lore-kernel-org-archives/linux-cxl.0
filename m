Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639E82F852
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737602112; cv=fail; b=OuK71PX4GpTIhy2Wxnoq7G4NXwwFb/OxXiCbFQ0JV5mIBhv3UGVqYL6jV94UIUIE2YgC3xudfi4rXCyc1WzkdClaVFHjq5PE1TQheosbV/xvPhmpad2xJJUxDoROjaY2avLz0oZThaDo1bNqNcxC6ITcL7Ov3hJ0YqEs6Ip7LhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737602112; c=relaxed/simple;
	bh=zGpcscjNO2CAa3hQv24b52OK0d9IcsGTw3DoYkuAZvo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SPNjojNfQVGN1HtfNMoS19MmYq2LEh6b0Dy/ry6sAHABb0DMzAB8eu4EtR+KLUoC3JlbcZIJlXJDifVvBN+HVu1OLHPW9HYUhG9Itt6hliGOj4GT/+IFVnjAsQMoIHgYrZqnHrPtc8vMbRdOTevIMjq1W1jxQjHz3vP9N5ERJp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MORUqO3n; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MORUqO3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737602110; x=1769138110;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zGpcscjNO2CAa3hQv24b52OK0d9IcsGTw3DoYkuAZvo=;
  b=MORUqO3nc8VmtIxyO/ajhebwd2FhoOqMguk5briQy4rF7WxaUbeq2scg
   d9ftD1wkfQJpcuM9xON73II8T/MlXMZcCHyOuEGclNmozwlXurEoGVLAJ
   iSvl52sCRwBqriSUH+NJHl1JnUUz65SME1kT1sIWhApaN2ehvUIqjPwEu
   auY2vDMy6sjMITk/EBNTKHx6BZ1eJp9IxvInSenoTVnmrw5y0U7bRLaTD
   ucXddkHhmLV9OT4AHVndQwiAgUenUJIvfGGJfs3VeNFhwOiXWn6pEMEhJ
   36W+rIliiyx4XvkMqo2SVG4gH52xkd0jB05dgEIjUVKzJJ2ZPyw7BMeUc
   w==;
X-CSE-ConnectionGUID: VC4XAN6ZQPGwDsnQWCO9kg==
X-CSE-MsgGUID: TG48FHzZTOaHZOh+V6ezwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37974659"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="37974659"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 19:15:09 -0800
X-CSE-ConnectionGUID: mhNIOYf9SG6smGUohoXbQQ==
X-CSE-MsgGUID: /9fhgZ05TSG+NSllK+RGiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112302539"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 19:15:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 19:15:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 19:15:09 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 19:15:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGf0CiZokh6B3tpXhqy+8wShCeAR5Hiye9mlaPvTRJUoG1F6rQ2/1c8YEns51MRofPAOecoHHOMoI7MfrMZ7FfOph22xT4Fx3CGCSgTw+DW/vC/BQwd7jRRx81USdZZ11oX5WFFDw35h9dhSYzjtrDhRe+rUBZFU2VZEZ4XQGkdoNyh2u9LpO+9NuX/5x8jNz8Vb3Jkd6y9qVKm5QqXWT4cWvJ6ohDN27K8wjNfoGfSDiAxf14AAaLD4MRdQq8qtR/bHq7i0dAwF9qBSh6XDdNsxXW3GpPb12bOPUpDTv1eH3wSzHoctWqIdoHdh2EZtspzzrVqhMHI8UR2uUtUWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jm26B7rRmnXl5azQxJmhp60mAkEr/oRfKXRjqb0imI=;
 b=NwAVNdrsLFnG7/5+CBDP6eFF8tKrN0bahL/tUC1Aw1kpxtb6JjpF3KvwNG/UT5x2m3SdGbKsT3hdHoY/Ci2fkPhhkIYLAARNpGvevQxCkUdbSd6a0/pztBWcWbU1Y0jl5FR0da8lu4YIrQY8RSv1igWfWdEIuX3U7p5n1Bc9RQp7H5JwAy3lgrKksDFeW6/Q96FfjzHGLJsndxfHHrUqal5214iP38z8ZjTuwOiowXx//4WmDGwiyHxo3grzHH5miP4qfu5zNe+Cu/0qWjdCK4U1TePJv1/5dlrLVhFbqOnr+sRDsNKCRIfjurCjrvukqMK895enejrqSF+Vo9tpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.22; Thu, 23 Jan 2025 03:15:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 03:15:06 +0000
Date: Wed, 22 Jan 2025 21:14:57 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 4/5] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
Message-ID: <6791b430ed4f6_5584029448@iweiny-mobl.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753637297.3849855.5217976225600372473.stgit@dwillia2-xfh.jf.intel.com>
 <67911d0578ce9_1eafc29428@iweiny-mobl.notmuch>
 <679172a7ac00f_20fa29442@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <679172a7ac00f_20fa29442@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:303:8e::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM3PR11MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f779ae0-e39e-4aa0-c7ff-08dd3b5c22f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dycWvU5+mBulhdGhW+9+0f764jBYxY0po12F0i3VtpffSG9ZarW2vCqUGavZ?=
 =?us-ascii?Q?DgEea3X+AKmI4wQsS9o8dciLxqy4lSh0VVmOSeuB2SIqaHZW/j7+0GjqPkt6?=
 =?us-ascii?Q?oY+oW2xZ0gJMQZU9J7opCVYkj/D84z61XM1/KzJE3CJXnkA1XkrlEGJ1lZrP?=
 =?us-ascii?Q?Hd3ZhB7yINQ6juHZYoq4TA2WLfPQgwyfRcUZ+bxrQwFGripWdURp8UnEZib6?=
 =?us-ascii?Q?Gx+1hev/dIxh0ZtvuLN0+d/Sy0cLoEVVPDuGs0MZ3hCtP6gIH0Vcz6Kq8OXs?=
 =?us-ascii?Q?xhgn5kMU3Kzm/QV4ZPgrV+yf3X1WWpRcGoQtAAHqFu4P/5su45v4q4D5IDEu?=
 =?us-ascii?Q?XX+3wml0MoxQc2up1i76LOtgd0H5InPlbev8zPl1SDFawTdArzhVjp38vrf2?=
 =?us-ascii?Q?NjAK1lHp1UKo4bQv/4IjDB5ZWOJryDpN+K0tqCMStWFwYVbDHeUhnNWAJLmB?=
 =?us-ascii?Q?1kpUwosKjtOHpbVfB8AwHNZPZHuY/rhx/ntlLuTNQQMBw/+gGwXphaXNAUW8?=
 =?us-ascii?Q?9zNB21KADb5YicE9NGgkQcB33Ev7lSg1X0Cqb2vakPPNkpGIhMMO6mSJTJUV?=
 =?us-ascii?Q?aAGDjbGgneKakKlBjohpULCHReNE1JNTLQPANQnAwWOEBYkMDxweNKXzB9v3?=
 =?us-ascii?Q?WQDjrCK86HJMpQmv92ToTXHSikM4g5HFH2ZjpsHvH+Wh9EBzuVTxSOra88RZ?=
 =?us-ascii?Q?g2Hr2atiY0ihbmjt1KUv5X4Ji9s7NHFLTo5X1QqNfLFJ+YiXgsl9idCqHQoa?=
 =?us-ascii?Q?wDz4Td5TNPtfkG72c3FcZlrhgg6RB+CdhOjVUoTvDn7oleeuK52DBHqWGpd3?=
 =?us-ascii?Q?Pq6XVbQQAiUxa96Cz0x9k4opObPcM5qlt1UEWdUIRVUCzBi3ketAGDx21jZS?=
 =?us-ascii?Q?YF5v86K3TcT15Zs89i/aB5JdCFo1F83Y1nvn/1zz38b62xmh58EDdnmWsE3r?=
 =?us-ascii?Q?aTeKxKSBBpVu0iYSZwYh+1YrXi1lz3uLPhnciTwEAoKkg8J/YjX3u39O29PZ?=
 =?us-ascii?Q?GdOBobH9+4KC/PB/WTMHBngDXX6Qx98sD0rtsDCB+lr8VD69y1+OlQq1jDWd?=
 =?us-ascii?Q?JN0y2zhKkxgk+yIjGx7Y4N1Tfne1BydNESw//ndu8J/QBgn9SoHbWAnKIZWa?=
 =?us-ascii?Q?MYUZdb+F7wiN/jeWicaIfHyRdrW2rV+hKxa1lGOLw5P3yFATyAfH/B4At8ol?=
 =?us-ascii?Q?Dz0PX/ONFmxcEipI0FMjB5ZfSLvzTE96k5U/6dX3cpHIz4HFNqKWEgHOLZBa?=
 =?us-ascii?Q?1tsMz62H77mIwUCxsc6IWW9x69PHVG4794OUDJeGIkpzPAGtcx696qKE54IU?=
 =?us-ascii?Q?egyUWTVUfWBN5Js6JMnbqDqjMsR8Dx0zjF+2bUQab+bdRbOHVOMZ8NpBkiML?=
 =?us-ascii?Q?TW6iE5t82tIw/jbbSk7tjxSBeb8/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hkJk8e1kopNmyTSMmkPzusKiZ1jpn+wNzgJ4DHLfSB2qecX+LcskTCpAj0Go?=
 =?us-ascii?Q?APS5jOi4TgwA7dP94jdE4ZLN04eY1tYNLAxt65gjVFNXzwY29YMx6Trvk4G9?=
 =?us-ascii?Q?5fjPkuOm6EXGvw+kBLQAAX5IPgaI7c5z0shl4Ia6IEaqbd6nlZoDKPWC8qa4?=
 =?us-ascii?Q?LbiMqGseud0/Djx9sC2+aqNnFLGTff735KJH/Tjz6Voxyzl7ijrUeqAreSVD?=
 =?us-ascii?Q?fEw3gR6ljhvHk+dfySxqLydJX79/UgdZpjdDMnGPmpYtdr7wrLcJN4o9oVzR?=
 =?us-ascii?Q?jf9t+MBEfqXVycQBuWO6k6v+rkAarUvAKC5WujyOvtv6jmqeueyPUMPyBWxV?=
 =?us-ascii?Q?FdgBOXsJ2erfRXkuPBbv51y5smlJzOpkIKog4ceiDa9YT/MjS3swr8qtPNtj?=
 =?us-ascii?Q?RNCGWoZAmxJogq8H1esM36ji5mhcOP8obtB7pz4F5r2mgbe5FRxZcCw5/Ww4?=
 =?us-ascii?Q?RiqGGp5gsWjkqQWZuLHEmVsUqhurqEFAObyqeMvuGsxOjR4AQqKg25y76ciq?=
 =?us-ascii?Q?7ulfSb5IMQMUUFzI2eisb/UQ8xozwX1+Wsyfeuq2j1zugX7zkm2WmC/GX2Yy?=
 =?us-ascii?Q?+pmVvW8wbxl1WQ6wtoRTm91o8EOBekTtkHmhSqGcFAsWBRSyrjD7dz0XCrUQ?=
 =?us-ascii?Q?RTJHmWA3HFUIS5QopcO+SuKWZqFyLs5uIdemKNvifM7dPOoHIcz2nxwXi+jA?=
 =?us-ascii?Q?5Dtw1N/SWz4xPTXZ2m3DALOkKIIdy/B9RYYFIPvXkXH7CYLKTUaDG7gm4B3v?=
 =?us-ascii?Q?twTVARKwG656Zq2DdfkB6HAu9EF77rmYkonThtEI3gQsyP+DdljbSYX8E268?=
 =?us-ascii?Q?cGyegYqtTG37ICoodThEqesnPIfe3tsVO+Yxs/4f2TraFq1BOov0R/25s15F?=
 =?us-ascii?Q?p7skdCG37qRj7+jaXFtGzuLFEsNSsJwon8skN7CWd0kwQbKHMbTJJPTCD4QA?=
 =?us-ascii?Q?QBlAq2AWug4EylpkDL27mbKu2uZR+Kwsiv35BR9DvNMaoFNgoANKQQO1t/N8?=
 =?us-ascii?Q?MNRI2qqC7dFfl+HuTi4NTKYYjtr/L3lW8BYBbyJycDXVDG70Fgo4kMeVz+6C?=
 =?us-ascii?Q?rw5CSPhknkoHR/keXGb/NEoNZc/zpq8sUiVnc85KOhKmxjfUzyQwDH7AEtz5?=
 =?us-ascii?Q?ppE8SFz4p4hYI2gKBYM0P+1mcWhnELBkN5LO7NvixW3gq6KVi8rMgVxLQp0J?=
 =?us-ascii?Q?4clW3+o9J6/9XdUFMG3spmmabaQ6yugw3xh9SwqjtLjIJsDbGfSRSaRHwh9Q?=
 =?us-ascii?Q?Gr1Gg3+ensQdcifVig3glFVbxfmwRYwu4Q9xu+FfVXzB8ho2apJSgCnTTsoo?=
 =?us-ascii?Q?POcXOwDpHMoNWloTLsMR31Eqvs3fS7fdBkYp4reWDKTjiwF1A2cRPTgkXM4+?=
 =?us-ascii?Q?aYtTHciw88ewqGENktBJr4TS724jKzmtDaQc/o+HpcHMWEDbfU8hhoJzPjgK?=
 =?us-ascii?Q?9gHqpl2spyoHV4E3fPilNbxrQhPT4K0fQCGSJFw2xhASVO6wVMFdjR4cyWOD?=
 =?us-ascii?Q?+9FyZbTOzsh0mi9cciiHbp7XKn3KI05RVVxGHHuIPfbNc9HFf+jVlufAxfwx?=
 =?us-ascii?Q?sm8wOU+YNeQSOnRRSv5voA7tKEPo9REXzlcEkSUR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f779ae0-e39e-4aa0-c7ff-08dd3b5c22f5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 03:15:06.8325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oqxz6YQwG4VqF21FT4FsHHDk2UXd/th28co1sDCENfj1RDqM6LErvXCPSVe+vJ3hwb7cXOcrjwsW/Q36exzmeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8736
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > Dan Williams wrote:
> > > cxl_dpa_alloc() is a hard coded nest of assumptions around PMEM
> > > allocations being distinct from RAM allocations in specific ways when in
> > > practice the allocation rules are only relative to DPA partition index.
> > > 
> > > The rules for cxl_dpa_alloc() are:
> > > 
> > > - allocations can only come from 1 partition
> > > 
> > > - if allocating at partition-index-N, all free space in partitions less
> > >   than partition-index-N must be skipped over
> > 
> > I think this is a bit deeper.  The partition index must also correspond to
> > the DPA order.  The DCD code verifies the partition index's are in DPA
> > order when reading them from the device.  Therefore, that code will add
> > them to cxl_dpa_info in order.  But general device driver writers may miss
> > this point.
> 
> We could save them from themselves with some paranoia in
> cxl_dpa_setup(), but as Alejandro said accelerators are typically
> single-static-RAM-partition devices. The risk is low that someone builds
> a multi-partition accelerator *and* builds a driver that messes that up,
> but I would not say no to a comment that notes that expectation.
> 
> > [snip]
> > 
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index 3f8a54ca4624..591aeb26c9e1 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -223,6 +223,31 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
> > >  
> > > +/* See request_skip() kernel-doc */
> > > +static void release_skip(struct cxl_dev_state *cxlds,
> > > +			 const resource_size_t skip_base,
> > > +			 const resource_size_t skip_len)
> > > +{
> > > +	resource_size_t skip_start = skip_base, skip_rem = skip_len;
> > > +
> > > +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> > > +		const struct resource *part_res = &cxlds->part[i].res;
> > > +		resource_size_t skip_end, skip_size;
> > > +
> > > +		if (skip_start < part_res->start || skip_start > part_res->end)
> > > +			continue;
> > > +
> > > +		skip_end = min(part_res->end, skip_start + skip_rem - 1);
> > > +		skip_size = skip_end - skip_start + 1;
> > > +		__release_region(&cxlds->dpa_res, skip_start, skip_size);
> > > +		skip_start += skip_size;
> > > +		skip_rem -= skip_size;
> > > +
> > > +		if (!skip_rem)
> > > +			break;
> > > +	}
> > > +}
> > > +
> > >  /*
> > >   * Must be called in a context that synchronizes against this decoder's
> > >   * port ->remove() callback (like an endpoint decoder sysfs attribute)
> > > @@ -241,7 +266,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> > >  	skip_start = res->start - cxled->skip;
> > >  	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> > >  	if (cxled->skip)
> > > -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
> > > +		release_skip(cxlds, skip_start, cxled->skip);
> > >  	cxled->skip = 0;
> > >  	cxled->dpa_res = NULL;
> > >  	put_device(&cxled->cxld.dev);
> > > @@ -268,6 +293,79 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
> > >  	__cxl_dpa_release(cxled);
> > >  }
> > >  
> > > +/**
> > > + * request_skip() - Track DPA 'skip' in @cxlds->dpa_res resource tree
> > > + * @cxlds: CXL.mem device context that parents @cxled
> > > + * @cxled: Endpoint decoder establishing new allocation that skips lower DPA
> > > + * @skip_base: DPA < start of new DPA allocation (DPAnew)
> > > + * @skip_len: @skip_base + @skip_len == DPAnew
> > > + *
> > > + * DPA 'skip' arises from out-of-sequence DPA allocation events relative
> > > + * to free capacity across multiple partitions. It is a wasteful event
> > > + * as usable DPA gets thrown away, but if a deployment has, for example,
> > > + * a dual RAM+PMEM device, wants to use PMEM, and has unallocated RAM
> > > + * DPA, the free RAM DPA must be sacrificed to start allocating PMEM.
> > > + * See third "Implementation Note" in CXL 3.1 8.2.4.19.13 "Decoder
> > > + * Protection" for more details.
> > 
> > I think this is a great comment here.
> 
> Appreciate that, never know how these things are going to translate.
> 
> > 
> > > + *
> > > + * A 'skip' always covers the last allocated DPA in a previous partition
> > > + * to the start of the current partition to allocate.  Allocations never
> > > + * start in the middle of a partition, and allocations are always
> > > + * de-allocated in reverse order (see cxl_dpa_free(), or natural devm
> > > + * unwind order from forced in-order allocation).
> > > + *
> > > + * If @cxlds->nr_partitions was guaranteed to be <= 2 then the 'skip'
> > > + * would always be contained to a single partition. Given
> > > + * @cxlds->nr_partitions may be > 2 it results in cases where the 'skip'
> > > + * might span "tail capacity of partition[0], all of partition[1], ...,
> > > + * all of partition[N-1]" to support allocating from partition[N]. That
> > > + * in turn interacts with the partition 'struct resource' boundaries
> > > + * within @cxlds->dpa_res whereby 'skip' requests need to be divided by
> > > + * partition. I.e. this is a quirk of using a 'struct resource' tree to
> > > + * detect range conflicts while also tracking partition boundaries in
> > > + * @cxlds->dpa_res.
> > 
> > Another great comment but it does not actually cover the DCD case.  This
> > is because in DCD the partitions might also have skips between them.
> 
> I think that "just works". The allocation will be bound by the
> partition, and the skip is calculated from the "end of last allocation
> in a previous partition". So, the distance between "end of last" and
> "allocation start" will naturally include inter-partition holes, right?

Not without a change to the algorithm I came up with.  We could create
phantom partitions which represent the skips between partitions.
Otherwise the skip resources need a different parent.

From my commit message:

    Two complications arise with Dynamic Capacity regions which did not         
    exist with Ram and PMEM partitions.  First, gaps in the DPA space can       
    exist between and around the DC partitions.  Second, the Linux resource     
    tree does not allow a resource to be marked across existing nodes within    
    a tree.                                                                     
                                                                                 
    For clarity, below is an example of an 60GB device with 10GB of RAM,        
    10GB of PMEM and 10GB for each of 2 DC partitions.  The desired CXL         
    mapping is 5GB of RAM, 5GB of PMEM, and 5GB of DC1.                         
                                                                                
         DPA RANGE                                                               
         (dpa_res)                                                               
    0GB        10GB       20GB       30GB       40GB       50GB       60GB      
    |----------|----------|----------|----------|----------|----------|          
                                                                                
    RAM         PMEM                  DC0                   DC1                 
     (ram_res)  (pmem_res)            (dc_res[0])           (dc_res[1])         
    |----------|----------|   <gap>  |----------|   <gap>  |----------|         
                                                                                
     RAM        PMEM                                        DC1                 
    |XXXXX|----|XXXXX|----|----------|----------|----------|XXXXX-----|         
    0GB   5GB  10GB  15GB 20GB       30GB       40GB       50GB       60GB      
                                                                                
    The previous skip resource between RAM and PMEM was always a child of       
    the RAM resource and fit nicely [see (S) below].  Because of this           
    simplicity this skip resource reference was not stored in any CXL state.    
    On release the skip range could be calculated based on the endpoint         
    decoders stored values.                                                      
                                                                                
    Now when DC1 is being mapped 4 skip resources must be created as            
    children.  One for the PMEM resource (A), two of the parent DPA resource    
    (B,D), and one more child of the DC0 resource (C).                          
                                                                                
    0GB        10GB       20GB       30GB       40GB       50GB       60GB      
    |----------|----------|----------|----------|----------|----------|         
                               |                     |                          
    |----------|----------|    |     |----------|    |     |----------|         
            |          |       |          |          |                          
           (S)        (A)     (B)        (C)        (D)                         
            v          v       v          v          v                          
    |XXXXX|----|XXXXX|----|----------|----------|----------|XXXXX-----|         
           skip       skip  skip        skip      skip                          
