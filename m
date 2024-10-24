Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845141F669F
	for <linux-cxl@vger.kernel.org>; Thu, 24 Oct 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787534; cv=fail; b=p7PiAKyvHa7+L8GP3qNuUHLRJTIDKBUH2n0sXfw/LilVRh2BSDQuwa0qCPENU30Ook/sFARUqt7VYVm+zCCYj0EANrdeS9+aSFmu9O/1cd4doUrHSgZ6Ompy6UjA8M/xBbdV/z1c+RKHsi9F1j0f1MhOoPhwSELQVQBSJU2N/yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787534; c=relaxed/simple;
	bh=ZKkQPkaTRpWM5mD/Xv/ZDUdyfGcYmMjYLE4goQoGtzU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uqgaZqyjqIRTkDD8iIErBjtbXLNLKnh6ErFSVyUMVT7jhdnHKec18mG+WYtFozNocy8B5g3Rbcj0LxEC8lBbBShSvnrWcJdOoaeH7Dp8kHD+V4Je6/ndNByVdVrcvq8Wvr3gNQqLntPp6iQaPCwEf2Gfd3I3bZiZIkHIg7gtCN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cadjTxlh; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cadjTxlh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729787532; x=1761323532;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZKkQPkaTRpWM5mD/Xv/ZDUdyfGcYmMjYLE4goQoGtzU=;
  b=cadjTxlhK7f2Ynib220sioMxENdJEaFksF/HJA2nRfNkpnal76Ylbso8
   066x0wo8wU7dj/rAehqt1jFQumfTURM177Ml4Q0gbIfUOFOsAqk144x7E
   Cycw2qPgmpivAKSVJU1N5aKiN1+PZLImKYIdu+sLYiK+pjSOL+mjvMflB
   KSfWkMOfkxFCc/NsJEUAEK+gp+xdDfuBZDzfRAZCcX3avgoRSTeVJgynE
   8XpvB02cFkT055wHKQKPXdOMvyKnaKz0R5+BQdmVLjeu+p0DECjY0wQkQ
   H8CkSuiABskuANwXsTnd+yBWFvV4iI+MUvipPb8iKtN6e6vXZGINRm3AL
   w==;
X-CSE-ConnectionGUID: EJ918mo6Q8OaJEJ/g2lk1g==
X-CSE-MsgGUID: E/B9GaHjSNmLvKNxnQMEsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29293904"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29293904"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 09:32:12 -0700
X-CSE-ConnectionGUID: HXsmfUOoQR2+wTSaPK3BRA==
X-CSE-MsgGUID: 5tV738xvRFiXQ5t9zD25MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="111450713"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 09:32:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 09:32:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 09:32:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 09:32:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nv9gIzaAs98kvann1ta3VHC8KCVQZlluSaNus8d6iwJSAVBt9VDBEYa3oxP5Yo1YTeJKRNjXWkuLfrWU4IaM3tZhv5/daVQCUMBqnsVXg0wQZCikrPw3bzRgTtw7wPCDbSGK3mZu1UXHCHpiEFUoMaY+8c5x2mj3d/0O3c1VrgSETTS0QP1csx6IVYRnF5YJWVrHxzhS+GslbeWgxgx47WyUcigJhvlQzDSFo6APXAidg6V0kHaGLI688/abH1xS9/a6RfuFGzGDAHHVZHwFFZoRP6uKxl65iEoEjD+0rzfEWZXlFdBV1zckSjiB4dIS9fGfdOu/8FIkJKwom2psrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eVt4mmO5wIExdO/Tk8MCRJ+Uy1PWwVzkMKuOIyf8pc=;
 b=F76ow956v46iJk4lMPJLdkuNBU9OQsj9FVEbI3snRfZVpLA2Dj+lVMdHbbOv/DW4M8Lv3hUc1uoKR1Lm8yiZqtDDPaM0ijZEbfR7vZrM5jacvTo+UvTodG3ZIqCPpvgoj7MsiTVBRYX77AkX5AMS+JmdcFs7FU3W8E8iXae1UrXeTB6dCJPQhxv8tOCd/Le05p/wHTjaCG2nN3JmIw5feJ/2odS+FO/vEOmQnPA5ok3ZkG7IjHBxzx2haRzPDCyrr5vr3qKoh7FwgHoulp7NyV2uiC+nA6llD7GpC8MinRgQvXAifHxcsjK3vFk3iCA6Y8HGzVZ1HNppky1T3qzalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV8PR11MB8558.namprd11.prod.outlook.com (2603:10b6:408:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Thu, 24 Oct
 2024 16:32:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 16:32:05 +0000
Date: Thu, 24 Oct 2024 11:32:01 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] cxl/test: Improve init-order fidelity relative to
 real-world systems
Message-ID: <671a7681341b5_f5b2029484@iweiny-mobl.notmuch>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <172964784521.81806.15791069994065969243.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172964784521.81806.15791069994065969243.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:303:8d::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV8PR11MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd5acf5-4c53-4957-39be-08dcf44965b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WEWyYnSAfpC0qejQ3AHLUR0cPeJ/zzQPpJkqyPaH670zGVCxtvpbrOHWGrf/?=
 =?us-ascii?Q?E726B2U/ckiWmMk1edVZ85dCy12wXgtVnZdGl/DbdvpeIgQumKd2OrIqO0Ia?=
 =?us-ascii?Q?FBjUXzt4bbT31bl9vSNUxw1JGqua5ANGA1ENoc9ncTFwhuMIrNvPB0AA5XGx?=
 =?us-ascii?Q?lzxpixRxYb/00mzzvNTANteuoYZCokarwdhb/gjji/su4DhUQMA+CjWpz7cP?=
 =?us-ascii?Q?aAGeQ7LgifQS09eaDSvNl9Z0LqBYnFaFL7FgFPtakl/bcyTTA9aN9WjknUw1?=
 =?us-ascii?Q?flRnIPTNJiQPIx7BrLCFIv1Wlweih1xmK8Pzf2WqkBHXwpXqmeEw1pZ2gN4Z?=
 =?us-ascii?Q?WWOqtCr78ql8e3Jj3dvUckDracTvZpNb4TWM7EmQM58QA4JCrYBddIWANRb7?=
 =?us-ascii?Q?gDGL0RH29FMNx3Nl9qbZYDgRFk1vOjuvmWDb5yEJc9ZLNs+tYe92f+FqnbNW?=
 =?us-ascii?Q?pFJDK//U4KKDUwOzPToR6LieJ8gFAW8sxSojlm/GaHSKNShaLKxnYQ0XeuA3?=
 =?us-ascii?Q?HmuV7v1MeEl4J1+w3sZUow5izMxldb6UYv4sPw2HEPIH55b3oOWmhvKUnaNB?=
 =?us-ascii?Q?zpXtr6PN9i9BXzeVVj5z1F5qKON2Z6Z71/d/erH1Azi0YKDzC6Dj1sQpq2v8?=
 =?us-ascii?Q?dpRMxAf+cO/xwNt5VB+V4PCmhlXkhNfgovJyayPjOmfZLEKzeb+hEj8cnRvZ?=
 =?us-ascii?Q?pA2KBCTuNYizqounubBDa3J38NdONAgcM19TioWipRAf1av1a16J5IGcm9ST?=
 =?us-ascii?Q?MOhYxLCaYN76YMPR3vaKKEWAvBOB/4o6fzrib7bfINl+bF5XIHY8Ojx5nvTa?=
 =?us-ascii?Q?TnMu1dtXOJd+HoidYGv1zbukEcUSsB6HN5oj65ItBPEgenldmlUgGbwuBN2w?=
 =?us-ascii?Q?SOzKmq2ztWW/VkrES71MuR/30ItN7OH5sCBV2zOnL+e+7Zrx7PYtmm7ct4N9?=
 =?us-ascii?Q?LGzSzv3xTIc4AUnqOsbY6t5DLeaTIdR4akohH5PRS8Ijs6Wz5C6DukCyoC8T?=
 =?us-ascii?Q?K+51cgt8io32CB4JGSKGltp0O+zYvmwPJ6f7lppR6TvKvokQtuNDH/TXjaXS?=
 =?us-ascii?Q?8IyN8oWF/zP/CYawsON3xiiZ5UIx5MjqCUtr6CPVW5Gb7yCHBpcwEs4HjCoq?=
 =?us-ascii?Q?wHOcyQgJgyw/Ghc4ABz4RX8TPt6bLX8G7RR8lWhqMPpfT8RooMN8bkIcUD5d?=
 =?us-ascii?Q?B8nNGJAcqLb2tGuNm3SKx6wOODA9AoFIJrd5O0bnqfXyE5No4LwvzKJ+dkpI?=
 =?us-ascii?Q?jeks45ybf0JliTf4j40EJzPD3lQqvyKB2Z3jr/TGoWApKoQwyGi7gpznpGru?=
 =?us-ascii?Q?V06ZBKYHf4QYjx8eRX04UWfw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZoVOv5FJ9+odIMagTveso1QDmSo0EYjjTw4wRCA5WzYhXgReDXmE8WNmggw?=
 =?us-ascii?Q?P2Ihi9J5xcFyaSN9Ye41f0n2J/+sEoGxt5ANoKMTdVGqwZxBa3lpBH/xHQy1?=
 =?us-ascii?Q?knktIpwBGoUYl/ZlKPBkvx702I6FrujYJuyJQZAJ4RAilNqyKaQBSCV3Pjac?=
 =?us-ascii?Q?SgDURp62RCbPh71AHwF5VT6xWwTQ97zcqWulzZpa1u+Ln3J69wJ/Inp7fqpT?=
 =?us-ascii?Q?MxOTq3t07Gs17JMjF/PWTlDguEjwjkLAwB/8FRJJdKaQAsNGoA+eTrJUB55w?=
 =?us-ascii?Q?RRm2yWNzoUOpSBCOvcuN51hdHPv5OP3AAqNRL0Yg34cNZt5SkidSpQfCztEp?=
 =?us-ascii?Q?HYTmpgwR3TwnQ433bV2AIX/f9EpI9nSyeOAv3mRq5oG+Z6R84iztoCv67hiM?=
 =?us-ascii?Q?qUYIy+EHiZHec+spbZ5GKAmtD6VMLiZ2Emc+z+4xSuegAKjFyazqW7NFL86/?=
 =?us-ascii?Q?7oeHy8ybqfsQwuHTSt8s1Mo+BN5H2G4r0hmPVVoc8f3OnBPxEIwBEFYF/V2R?=
 =?us-ascii?Q?f66w3JVQIOLmEIsYGj+n+PXzXIqE+oyc4w3YOt/3RMkEOKW7XHNsuKY+X8JY?=
 =?us-ascii?Q?/udU7fyXsTLq/9eK9ZAIccNbSGU3vuuXU2hPC230kEIIpr5d5NEi8DqNRoes?=
 =?us-ascii?Q?vwh0HhsGflmNxa93LRRbIkEbAHlRwh/Bn5gWU5/mI6zgXfehJMpFFopCapqP?=
 =?us-ascii?Q?wYRIPV5gQm9RPl1WfE2ymYzVz2oBDHbKOOQ9zPhFXVs242PpHtALGRlyqaJs?=
 =?us-ascii?Q?rBxBgTE5+xLxLZdF5kt2QAYHcjzM3MgUvhdD/XWSujo5WX4HpPJ86gdc5lPi?=
 =?us-ascii?Q?kYhAoD4c+omQycQLto25CpAYNeJGenjmpSr1lxDSsFmv22RMAqh0j/ic4GU9?=
 =?us-ascii?Q?BzKlXwGmImlPXaQrHOSoZuo/hw2N/UYaAOu4LAy6kfII5+NUH6vUlU3Ebpf1?=
 =?us-ascii?Q?6iD15GZH6ehu6XgU+J3I+yPcrORfcgdARkN4tPhx/b+vjszWlLpbG+H3JOsr?=
 =?us-ascii?Q?Ofwm8XTcH6Uql9sLcWVmbv9dNKZ4JyIVzz5gc61sP2Bi7X1cDlhgX5xhTMTD?=
 =?us-ascii?Q?NRolJWNvfoKpUHsLl4oiVrwHnEBQqwl26Xv5yrTSObbLKZd6oFX1rZoA+Wt0?=
 =?us-ascii?Q?iPn56LiqoCgD8/60DACyhv/K/R6S1IrTICA9KR34eby3yywp31JfgwYwbecv?=
 =?us-ascii?Q?lojjYFvtfhH2faERpUWOSa4riSZtX56q+xF5FXEv6iZyrlDixJp8MiDT31cn?=
 =?us-ascii?Q?owNYAcL3wgiJhbgGgpeGcT1fWkpsxJ7kk9bYTVAaa0tlQgjt0YcpK22t4DcZ?=
 =?us-ascii?Q?SUYZYG6Ky/Cy1OlwTgxbhH4HZEFxF2tzlyyyB00CdhLBuikjwVT+v/7zWAwH?=
 =?us-ascii?Q?+PHjmco2nzU231FekVfTpG1TXeAnP+2PsoDth6LLn0ri0VeTvQNWUuCpPZuq?=
 =?us-ascii?Q?QskbwT9zp5ms8DoRz7OUFTkIYRMQSMTISbcc4TdT0xoERNdQuSKUESVO0nOd?=
 =?us-ascii?Q?i3wMcGAH8y38o4rD7BDD1wUgGAOW0bXgz4knIoXLN/Wf0BdC3JHL6HJddVeV?=
 =?us-ascii?Q?P+/XIdM+EYss144K6aO5DnA2TAPTxm96IxPc/eGj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd5acf5-4c53-4957-39be-08dcf44965b1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:32:05.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alKnJsJ/7HvmZ2m4SOWT7/UId4z55ksEGYP5vWR4yqudh4ZAluL8r6MRFxwzqM4/FceRO+W+NrhIf8FQyY6jRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8558
X-OriginatorOrg: intel.com

Dan Williams wrote:
> The investigation of an initialization failure [1] highlighted that
> cxl_test does not reflect the init-order of real world systems. The
> expected order is root/bus first then async probing of the memory
> devices.
> 
> Fix up cxl_test to reflect that order. While it did not reproduce the
> initial bug report (since that is dependent on built-in vs modular
> builds), it did reveal a separate latent bug in the subsystem's decoder
> shutdown flow. Fix for that sent separately.
> 
> Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
