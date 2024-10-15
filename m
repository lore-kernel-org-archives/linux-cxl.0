Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F598C8F0
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 02:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728960124; cv=fail; b=SQtAb7cfO4CrcIcyJ2Vzt0NtE40EchQ3lRZgsaYGP1vcpcUCR0M2al+xpRNUFkQSqU6BIl/PTns417o/lxT+L/HIGM1kS6mK30NuQ78bAuIDipTW2EXSMUBQ2kZkVeqMyFSWpmuaoK9qzvc0HbIRrbmB4XkG45AHrG41bQ+D+FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728960124; c=relaxed/simple;
	bh=F5ETmnei4AQczW3S9gDtR0n1xrdB0zGLBGLvJ2TAt94=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jQbkEZ+5b46LcpUf9au2l4+SMdx6DJwbV+IZPkjuQNsoDIEF6WmDtDFJ3vh1MjT0wNPGf3pmv84lEEl356iY5QgGgilvb+785kmLnVod4c8VJ/EVL1elICJNzLxkbOqmgNc8n+6SL6l+RB09AsMzwYzGYDm9ECfLRtKDb1Kj/KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bllLIOLB; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bllLIOLB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728960123; x=1760496123;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F5ETmnei4AQczW3S9gDtR0n1xrdB0zGLBGLvJ2TAt94=;
  b=bllLIOLBRjvYABYMzRuEF6xotnQTLLXmEgn2Kk/iWg+mWwllJAxQ22py
   gkVm/hLBXxYNarmhtHRGMD1F9j6fpysDJXYWJgHfUHbm73mjozubi9rkK
   OFmiAflOEkr4VF1oISs4VkWz7KJb84+KpWxLwazvAfldb6UORfVvQbG9L
   ROgZPPbhPr0FnQ8hSgwA3kt/iMvbrAo/IsOpWWeDNOr+Kbsge57cRy4j7
   FNJw9Fd+KlXAOuW5BKP4o/nKOPGZBBrK3xTtAr2flHQfIJDMqy70+kyDS
   AHbTk2OGVvCTdtojhYdMdyZa1eVOr5IJyUE1ElFvp3lcOI2CNaGj28zzu
   Q==;
X-CSE-ConnectionGUID: AfNazaPjT2KRv07MTlJiYA==
X-CSE-MsgGUID: q0eU+1JYQkO2+nLd2Ph/bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39723434"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="39723434"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 19:42:02 -0700
X-CSE-ConnectionGUID: 5oZX/5ItTqibd9aWpv5CUQ==
X-CSE-MsgGUID: uS9OmY9oR026t7J9sPcB2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="108522843"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 19:42:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 19:42:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 19:42:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 19:42:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 19:42:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPToTvYhvPiHKX+MMZsbnHtdAs9VqH9urQczU/aGi0XWZHhh1AGdQvZU8GCBEf4yV03U2gtXds9O0BlQkrq0eLCkRj+Un6lOUrJ6PZhnByjlgUN1tlpGTBRdSuSjkXcTaf0u8io9d15TGP2eAp2JnDr018tl5haigWXEGSJhhRXPNlLA3VvQwXKJ6r1gbB+ElTLrw1G4R1pojg2gF7jpZkiZXMwFCgP+PK12PR4tw0d+u8oNKj9btHKLsg+exYOBkjxI19ZuJeqj+ncREufRMRAhsmlmQIvWP+lKxvCpPSvOZK+QtuqMuGghC4Ial9XTrQz85e+dj/wbjL/W0lsBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ1K10tOOP1paaw9yrWyPRXmpO2or4Y5HLg9Jqmq5LE=;
 b=fEdb8n0up/vByOCWSBODqX+NdeGXf1CyBFI3fIAg1nnuyGGrJFMDD4CtLSkJXajL8cyUsJV53CO4tOSz1kR5eatczV4uIu6K9mlzx0nlFwfQGFVd8/nBhM79S5by9/rsy9H/QFqsOXCAPHG01VtzNuvbp84LWs9zAnASocSriJy6H4xHjZDfTCx6gneDury8MaKZQe6c3SNcptKvqKqNgYPQ4Sq4hk3gEt/P1HMcN+NFY30i2kD8rpeufJZo62g2ybpirAeBeuZWkratn+rtOndfa6CG71b2CNHhAIjbQXPMTu05oTelRS/E9M4qRftJXG7aurVrUla5l0Est5l/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7652.namprd11.prod.outlook.com (2603:10b6:8:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 02:41:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 02:41:58 +0000
Date: Mon, 14 Oct 2024 21:41:51 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: KASAN error when insmod cxl_test
Message-ID: <670dd66f2d05c_1357e229415@iweiny-mobl.notmuch>
References: <87y12w9vp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87y12w9vp5.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: MW4PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:303:b7::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8afc7f-e1ef-461e-5b5e-08dcecc2f011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M/MkXnBWf4xuE8Hxboft+grBKZTkTlFEreLw6m7ULGuXm9GoHyXoJl77s7Iv?=
 =?us-ascii?Q?PRc9W5Gv3zWStoEh+BCR4XI28E2LGtdhiP8U6JyS3tSGfzr/38dOVX3kA47f?=
 =?us-ascii?Q?AS3lYUaITtB/kcjqNaFve4dSeSGSJSQiuQODDsZ0vkdb1Uq2fyvTm4zeEOv5?=
 =?us-ascii?Q?l8dw0/O6YJjNPVdtB0FEXNmrsHzHAIcKdbM8LOQdR/FHSArP1Mu53VwedDN8?=
 =?us-ascii?Q?fk2HCJR449tZZKZ/AekXIitpKGgeV2osSHJpuQ5LjVEuJbXQgGu6XN1swrNx?=
 =?us-ascii?Q?RosCz/tg3GcaHzP5BBIRP17IpYPnfTLSZw7suwD3px87QQfdrKkuqB58S6Oh?=
 =?us-ascii?Q?Q7LXotKGYRDfX1/odq0bqhoZNVpjXPt4jH+Pbd8olN4RmdZRE4YFCyXAruUH?=
 =?us-ascii?Q?b+mLYuQhaHTrMNss1jocoaXHe8lTkUGN7ktPKyfTMKWQi3rRP4DqUiWIcf6m?=
 =?us-ascii?Q?YyypH+SuXzUXZoAb8xwWwL7KeSYWSdHE73a52QNe7PGZ4Y6o2FVliS386NFU?=
 =?us-ascii?Q?P0ttNdD+2V7NtDQYAuxoPgIYaY09sN0BNL+4r8nKUpsd4BPl6eQ7TXClF3e9?=
 =?us-ascii?Q?gxtsYmcZXDocvvZuYo+W0UZ20RV2W3R5W1oLQGmPtyU+zJLP80DSkiaNDtxY?=
 =?us-ascii?Q?qsRFV1FfkvqGaRv5asV5va1TEMxvqH0+0mF3uwujGu2RmJ+9dcEaHyJDozmb?=
 =?us-ascii?Q?jxUeluYQS0qDN18IA1YNErCkDS/QV+qFfbFVkJneKJJVUPuq0M1b5MM4Nyaz?=
 =?us-ascii?Q?BXhn5mK6dFeMtudF082LdFalL3STxcBCWgYKrGzv2a+mXvmcUtaKXvCDCRj6?=
 =?us-ascii?Q?QIY/IStD3Yp5S60OeHGwa9YZ7jklSyNo0qrOrzDpzdhnBltOV3ubO70+eBI+?=
 =?us-ascii?Q?9qtRtTDndmkm3hXJPOENt8fgAQ9x/xsX9A7Mknhm/AWLbSyq79xmsJ/14PBB?=
 =?us-ascii?Q?m4iNtt6/Os9qP0ExfnB4M6X5Jzu2VUh2tJTx7Wv/6q0wvgLpzATSgUStBMNv?=
 =?us-ascii?Q?sEaE5xfp57sbIq/3O5+XCavZ/2lsBtJdFgQ/RNos5G9iNYoecMrXJN2yUVmX?=
 =?us-ascii?Q?6FOwQ9N0qAwLz/A6+TJzRrusZJf41fyAhURUMkEqeZUWeV64xZ1YeBqp1coz?=
 =?us-ascii?Q?X0AdD0Azme21Nv+sTSo8mHABmaAL53Ilxnhm7JHMNba5PxudPzzKfTZCutBI?=
 =?us-ascii?Q?wDiAYMSf0aolxLnNM4416LeQilvpIFRl+Z/29lD3JPK8uue2QvaqmXZa4uyd?=
 =?us-ascii?Q?RdVS+YbySfV0TzWYyLljsWL7pdTlNOwrmwdOJCDyjQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8KeNI0GjI6H8ViKW1trh2MahIMzy+jzO6980JFGzQ94joHY7kfd4eU9s3NM?=
 =?us-ascii?Q?FBJEogQVDHNXvsSNn1EzveQYPLdbg+kMKayVE/8Bx8tRbdGtn3Y1FfOp4XfI?=
 =?us-ascii?Q?ujFrmosPphLynpkJ59COXDm3wgBfeQG/sHAesBddLtjwFzxqy/exKV3bR7Qc?=
 =?us-ascii?Q?TDnIm3tj7mRniNaHeK91gYHf5Miwa0HUgNHHl4+gTOpWtvmZ0D4G7gyFEPRO?=
 =?us-ascii?Q?VasHmk6nS4Z/R4YpMJeYiMo9sGWx5AodUcUJ1DSEsgWeytO+SpGQxxxUo23V?=
 =?us-ascii?Q?n1mi9Tt888dkBep6AU8Dlb4Ycxkd0p9tq21MAlPbdDK6uU8UFWwC4Nvm84KX?=
 =?us-ascii?Q?1Fjf82JuUO8G/RQncxCja1Ss8DdVuOjCFVzph3bNi+JumsssTOeIyt1g9TZX?=
 =?us-ascii?Q?rIw9A6a4S8AuwNY+mc9HDI864P718GXQsihyl+fEvfYwUYGJslv2rDW22FTy?=
 =?us-ascii?Q?BwEb9kFJXvNiOhny1JwbkvsVjYsoX+bhuzDEbkZF190qzlB9/Yq9w4CLo9S5?=
 =?us-ascii?Q?CtE3SkUpDWAjfet2FEpVUTCLzN89wNEjTZfY3nbi/RdA13mrJMw3dmryMk25?=
 =?us-ascii?Q?ScUx7H/hF+PL2qdL5hy4qiRsS55kZNWnCeCFPdn21NYdgpnwma2N1kILlnLO?=
 =?us-ascii?Q?YI4iJHXyssCB74LYG+iBQHU9RIgKw55T+3qC0cYF9MkoS80AMfQigZyc8lls?=
 =?us-ascii?Q?jDtC6DzId16I0AgmbypCHUCNO5/5f9eZedwy/RPrZ24kzhaFPqhvuoCmjWvw?=
 =?us-ascii?Q?/+Rr5mO2ivrZzp+oU0Xt2KMg70K2AIcgYtysJC2jHDXJXkhkNI+ypPL8SohT?=
 =?us-ascii?Q?D258o4EmjDVbzOjWjGpUhRhT1oW0YyOHmUiZSBR87uZfmwKuGHu2Hnofdxnl?=
 =?us-ascii?Q?trXTsTNmOSzhpfP9d1Cky+2hwhQ5rlTHjYPJLyH8NF2clxjJa/Riybirydca?=
 =?us-ascii?Q?kV8VkkOw2loY5Il7vZYy1HUWUeiIQobhJsUwMvHEoUNZkP697dfhU1oiadi6?=
 =?us-ascii?Q?o6epgEBwVacj9yyktQiFnBXcW7oMx6ZqUXR3sdVt+SRvzOe5DnCfdvEoUCcR?=
 =?us-ascii?Q?yShiGD2CqQvTq/MZFwERL8gI22Z0YfwJsxRF09+T/utDWjXmFga/NReAMVLO?=
 =?us-ascii?Q?A50+qu8Ts3AX2MAgFkrZ1+E+HhLR/BNsKceozUyt30HdNKB525cTmJK0x50r?=
 =?us-ascii?Q?2tLsBcbb+LooCAsvE+07WIbZ2iv85AFt6x2tKpeOqAKh+/rUAjP1g3XxXs7g?=
 =?us-ascii?Q?PlJzX/q0tPa9vGqaRw1LgXnFDhLjmI8icG7+w3C8PqVIPmOlblg8j8QL9mgP?=
 =?us-ascii?Q?CGv43UJDUzVZcQC9zbja4gOSJcvVJn3US5y8CmNsrguEoOg355sP2KHxTT0p?=
 =?us-ascii?Q?yC05gNIlF1zADQlum/+r/RqyWmxu9d2Khi+qKtuF705lKhyU9nvqP9dqNRsB?=
 =?us-ascii?Q?X7S3769ChReh9uYJmcgNRiE5OhYM0WFJqWug/rWRCCvYE5TJtyo2yWm7Yf2J?=
 =?us-ascii?Q?M85/i1SDGAPxJeQZZ3L2NFsiClTWWouxgdqIQECnfJD1DtyfDxb8I5CPNMIz?=
 =?us-ascii?Q?iIG4R5hAvbG50dshz75wo2YUUj8rxevM5/tOZnj6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8afc7f-e1ef-461e-5b5e-08dcecc2f011
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 02:41:58.0913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3k+tQTQm/wqoN3QoApb6qi6O3IRuRvIAPkf0ukmPvonhXUlsIh+r2VDAtIn37dFE5qO4N7bw0Hv6dO8OqS6Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7652
X-OriginatorOrg: intel.com

Huang, Ying wrote:
> Hi, Dave,
> 
> When I tried to test v6.12-rc2 with cxl_test in qemu, the below error is
> reported.  Revert commit a5ab0de0ebaa ("cxl: Calculate region bandwidth
> of targets with shared upstream link") can eliminate the error.

Hey Ying,

Dave is out on vacation so I'm checking on this.

I thought perhaps this was related to the Initialization errors Dan was
working on.[1]

But a quick test with his patch set did not make the error go away and
I've been side tracked with some other stuff today.  Best guess is t

I'll dig in a little more tomorrow.
Ira

Link: https://lore.kernel.org/all/172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com/ [1]

> 
> Can you take a look at it?
> 
> The kernel config used to build kernel is attached.
> 
> -----------------------------8<------------------------------
> [   28.103428] ==================================================================
> [   28.104078] BUG: KASAN: slab-out-of-bounds in pcie_capability_reg_implemented+0x18/0xfb
> [   28.104635] Read of size 1 at addr ffff888008a79fb4 by task systemd-udevd/408
> [   28.105137] 
> [   28.105261] CPU: 4 UID: 0 PID: 408 Comm: systemd-udevd Tainted: G           O       6.12.0-rc2-kvm #5
> [   28.105868] Tainted: [O]=OOT_MODULE
> [   28.106201] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   28.107115] Call Trace:
> [   28.107339]  <TASK>
> [   28.107526]  dump_stack_lvl+0x65/0x8c
> [   28.107803]  print_address_description.constprop.0+0x8a/0x309
> [   28.108223]  print_report+0x136/0x20f
> [   28.108493]  ? kmem_cache_debug_flags+0x16/0x23
> [   28.108836]  ? fixup_red_left+0x17/0x27
> [   28.109262]  ? pcie_capability_reg_implemented+0x18/0xfb
> [   28.109806]  kasan_report+0x85/0xa7
> [   28.110184]  ? pcie_capability_reg_implemented+0x18/0xfb
> [   28.110693]  pcie_capability_reg_implemented+0x18/0xfb
> [   28.111211]  pcie_capability_read_word+0x38/0xaa
> [   28.111653]  ? __free_kfree+0x9/0x22 [cxl_core]
> [   28.112194]  pcie_link_speed_mbps+0x54/0xae
> [   28.112594]  ? pcie_get_mps+0x6d/0x6d
> [   28.113037]  cxl_pci_get_bandwidth+0x58/0xd3 [cxl_core]
> [   28.113645]  ? cxl_pci_get_latency+0xac/0xac [cxl_core]
> [   28.114192]  ? _raw_spin_unlock+0x1f/0x2f
> [   28.114683]  ? xa_store+0x3b/0x45
> [   28.115109]  cxl_endpoint_gather_bandwidth.constprop.0+0x2bf/0x352 [cxl_core]
> [   28.116017]  ? cxl_hb_gather_bandwidth+0x205/0x205 [cxl_core]
> [   28.116967]  ? __module_address+0xe7/0xff
> [   28.117673]  ? is_module_address+0x11/0x26
> [   28.118419]  ? static_obj+0x7f/0x90
> [   28.119016]  ? lockdep_init_map_type+0x22e/0x305
> [   28.120557]  ? __raw_spin_lock_init+0x73/0x83
> [   28.121707]  cxl_region_shared_upstream_bandwidth_update+0x12c/0x491 [cxl_core]
> [   28.123434]  ? cxl_endpoint_gather_bandwidth.constprop.0+0x352/0x352 [cxl_core]
> [   28.124622]  ? check_last_peer+0x228/0x2c5 [cxl_core]
> [   28.125273]  ? xa_set_mark+0x34/0x34
> [   28.125717]  ? cxl_region_setup_targets+0x3a/0x1b8 [cxl_core]
> [   28.126417]  cxl_region_attach+0x8cb/0xb05 [cxl_core]
> [   28.127049]  attach_target+0x49/0x6f [cxl_core]
> [   28.127631]  cxl_add_to_region+0x15a/0x1d6 [cxl_core]
> [   28.128262]  ? schedule_detach+0xa/0xa [cxl_port]
> [   28.128790]  discover_region+0x5d/0xb6 [cxl_port]
> [   28.129327]  ? next_device+0x20/0x2d
> [   28.129767]  device_for_each_child+0x8f/0xc0
> [   28.130243]  ? next_device+0x2d/0x2d
> [   28.130644]  ? kobject_get+0x47/0x75
> [   28.131051]  cxl_port_probe+0x19f/0x272 [cxl_port]
> [   28.131573]  ? discover_region+0xb6/0xb6 [cxl_port]
> [   28.132117]  ? kernfs_put+0x19/0x2b
> [   28.132509]  ? sysfs_do_create_link_sd+0x7a/0xbc
> [   28.133016]  cxl_bus_probe+0x27/0x54 [cxl_core]
> [   28.133611]  ? really_probe+0x194/0x43d
> [   28.134064]  really_probe+0x1e4/0x43d
> [   28.134483]  ? driver_probe_device+0xc0/0xc0
> [   28.134969]  driver_probe_device+0x4a/0xc0
> [   28.135430]  __device_attach_driver+0xd7/0x102
> [   28.135932]  bus_for_each_drv+0xf2/0x116
> [   28.136374]  ? bus_rescan_devices+0x15/0x15
> [   28.136849]  __device_attach+0x10c/0x19c
> [   28.137300]  ? device_bind_driver+0x39/0x39
> [   28.137787]  ? bus_to_subsys+0xad/0xb9
> [   28.138213]  bus_probe_device+0x4e/0xd3
> [   28.138656]  device_add+0x55b/0x791
> [   28.139056]  ? get_device_parent+0x20a/0x20a
> [   28.139539]  ? rcu_read_unlock+0x51/0x5b
> [   28.139996]  devm_cxl_add_port+0x20a/0x49c [cxl_core]
> [   28.140642]  ? cxl_port_alloc+0x430/0x430 [cxl_core]
> [   28.141271]  cxl_mem_probe+0x3b9/0x47c [cxl_mem]
> [   28.141806]  ? __devm_add_action_or_reset+0x26/0x26 [cxl_mem]
> [   28.142447]  ? sysfs_do_create_link_sd+0x7a/0xbc
> [   28.142969]  cxl_bus_probe+0x27/0x54 [cxl_core]
> [   28.143540]  ? really_probe+0x194/0x43d
> [   28.143999]  really_probe+0x1e4/0x43d
> [   28.144418]  ? driver_probe_device+0xc0/0xc0
> [   28.144902]  driver_probe_device+0x4a/0xc0
> [   28.145353]  __device_attach_driver+0xd7/0x102
> [   28.145629]  bus_for_each_drv+0xf2/0x116
> [   28.145865]  ? bus_rescan_devices+0x15/0x15
> [   28.146115]  __device_attach+0x10c/0x19c
> [   28.146351]  ? device_bind_driver+0x39/0x39
> [   28.146614]  ? bus_to_subsys+0xad/0xb9
> [   28.146839]  bus_probe_device+0x4e/0xd3
> [   28.147069]  device_add+0x55b/0x791
> [   28.147306]  ? get_device_parent+0x20a/0x20a
> [   28.147568]  ? kobject_get+0x47/0x75
> [   28.147784]  cdev_device_add+0x31/0x89
> [   28.148015]  devm_cxl_add_memdev+0x26e/0x2d7 [cxl_core]
> [   28.148369]  cxl_mock_mem_probe+0x2f3/0x33b [cxl_mock_mem]
> [   28.148694]  platform_probe+0x3d/0x7a
> [   28.148914]  really_probe+0x1e4/0x43d
> [   28.149133]  ? __device_attach_driver+0x102/0x102
> [   28.149420]  driver_probe_device+0x4a/0xc0
> [   28.149669]  __driver_attach+0x19c/0x1bb
> [   28.149912]  bus_for_each_dev+0xc7/0x101
> [   28.150152]  ? bus_register+0x2d4/0x2d4
> [   28.150387]  ? bus_add_driver+0x137/0x2cc
> [   28.150648]  bus_add_driver+0x19d/0x2cc
> [   28.150881]  driver_register+0x12c/0x17d
> [   28.151111]  ? 0xffffffffc0ac8000
> [   28.151307]  do_one_initcall+0x139/0x2da
> [   28.151538]  ? rcu_lock_acquire.constprop.0+0x25/0x25
> [   28.151826]  ? unpoison_slab_object+0x1b/0x38
> [   28.152100]  ? __kasan_slab_alloc+0x37/0x41
> [   28.152342]  ? rcu_is_watching+0x1c/0x38
> [   28.152572]  ? poison_kmalloc_redzone+0x44/0x65
> [   28.152835]  ? kasan_unpoison+0x26/0x31
> [   28.153058]  ? __asan_register_globals+0x55/0x60
> [   28.153338]  do_init_module+0x118/0x388
> [   28.153576]  init_module_from_file+0xc2/0xe4
> [   28.153838]  ? __ia32_sys_init_module+0x40/0x40
> [   28.154127]  ? do_raw_spin_unlock+0xce/0xd6
> [   28.154370]  idempotent_init_module+0x1ea/0x3c0
> [   28.154634]  ? init_module_from_file+0xe4/0xe4
> [   28.154892]  ? __seccomp_filter+0xf5/0x4f2
> [   28.155135]  ? files_lookup_fd_raw+0x40/0x4b
> [   28.155386]  __do_sys_finit_module+0x68/0x82
> [   28.155636]  do_syscall_64+0x9a/0xfd
> [   28.155848]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   28.156145] RIP: 0033:0x7f2239ce4559
> [   28.156355] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 77 08 0d 00 f7 d8 64 89 01 48
> [   28.157428] RSP: 002b:00007fffd30e95d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   28.157858] RAX: ffffffffffffffda RBX: 000055fd0ed12110 RCX: 00007f2239ce4559
> [   28.158260] RDX: 0000000000000000 RSI: 00007f2239e67e2d RDI: 0000000000000006
> [   28.158661] RBP: 0000000000020000 R08: 0000000000000000 R09: 000055fd0ed13b28
> [   28.159063] R10: 0000000000000006 R11: 0000000000000246 R12: 00007f2239e67e2d
> [   28.159465] R13: 0000000000000000 R14: 000055fd0ed13180 R15: 000055fd0ed12110
> [   28.159870]  </TASK>
> [   28.160003] 
> [   28.160098] Allocated by task 385:
> [   28.160298]  stack_trace_save+0x7c/0x94
> [   28.160523]  kasan_save_stack+0x1c/0x34
> [   28.160763]  kasan_save_track+0x10/0x25
> [   28.160997]  __kasan_kmalloc+0x3a/0x43
> [   28.161222]  __kmalloc_node_track_caller_noprof+0x1fd/0x22d
> [   28.161562]  kmalloc_reserve+0xe6/0x130
> [   28.161797]  __alloc_skb+0x109/0x1b8
> [   28.162018]  alloc_uevent_skb+0x55/0xe2
> [   28.162254]  kobject_uevent_net_broadcast+0x11d/0x265
> [   28.162565]  kobject_uevent_env+0x534/0x6d3
> [   28.162806]  device_add+0x4da/0x791
> [   28.163011]  platform_device_add+0x248/0x2dd
> [   28.163258]  0xffffffffc0b40708
> [   28.163446]  do_one_initcall+0x139/0x2da
> [   28.163673]  do_init_module+0x118/0x388
> [   28.163933]  init_module_from_file+0xc2/0xe4
> [   28.164312]  idempotent_init_module+0x1ea/0x3c0
> [   28.164665]  __do_sys_finit_module+0x68/0x82
> [   28.164992]  do_syscall_64+0x9a/0xfd
> [   28.165295]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   28.165634] 
> [   28.165767] Freed by task 168:
> [   28.165968]  stack_trace_save+0x7c/0x94
> [   28.166207]  kasan_save_stack+0x1c/0x34
> [   28.166442]  kasan_save_track+0x10/0x25
> [   28.166669]  kasan_save_free_info+0x3b/0x41
> [   28.166912]  __kasan_slab_free+0x18/0x2a
> [   28.167150]  kfree+0x206/0x26a
> [   28.167388]  skb_release_data+0x152/0x16e
> [   28.167636]  __kfree_skb+0x14/0x1e
> [   28.167834]  netlink_recvmsg+0x2b2/0x503
> [   28.168066]  sock_recvmsg_nosec+0x48/0x80
> [   28.168305]  ____sys_recvmsg+0x10c/0x1fa
> [   28.168542]  ___sys_recvmsg+0xc7/0x103
> [   28.168762]  __sys_recvmsg+0xb7/0x113
> [   28.168978]  do_syscall_64+0x9a/0xfd
> [   28.169188]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   28.169504] 
> [   28.169599] The buggy address belongs to the object at ffff888008a79800
> [   28.169599]  which belongs to the cache kmalloc-1k of size 1024
> [   28.170285] The buggy address is located 948 bytes to the right of
> [   28.170285]  allocated 1024-byte region [ffff888008a79800, ffff888008a79c00)
> [   28.171055] 
> [   28.171152] The buggy address belongs to the physical page:
> [   28.171487] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888008a7f800 pfn:0x8a78
> [   28.172060] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [   28.172539] flags: 0xffffc000000240(workingset|head|node=0|zone=1|lastcpupid=0x1ffff)
> [   28.173104] page_type: f5(slab)
> [   28.173343] raw: 00ffffc000000240 ffff888001042dc0 ffffea0000226410 ffffea00002f3010
> [   28.173822] raw: ffff888008a7f800 0000000000100008 00000001f5000000 0000000000000000
> [   28.174308] head: 00ffffc000000240 ffff888001042dc0 ffffea0000226410 ffffea00002f3010
> [   28.174733] head: ffff888008a7f800 0000000000100008 00000001f5000000 0000000000000000
> [   28.175177] head: 00ffffc000000003 ffffea0000229e01 ffffffffffffffff 0000000000000000
> [   28.175631] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> [   28.176074] page dumped because: kasan: bad access detected
> [   28.176391] 
> [   28.176484] Memory state around the buggy address:
> [   28.176746]  ffff888008a79e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   28.177121]  ffff888008a79f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   28.177612] >ffff888008a79f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   28.178011]                                      ^
> [   28.178286]  ffff888008a7a000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   28.178671]  ffff888008a7a080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   28.179183] ==================================================================
> 
> --
> Best Regards,
> Huang, Ying


