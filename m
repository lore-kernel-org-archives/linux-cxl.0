Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D01DED6D;
	Fri, 22 Nov 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296541; cv=fail; b=Rx1QFxZXd3nq/yDIeSuay+MxhYqA0mlmAd3MOz8R/6ujh6r/k3IQNUnDwimy+u7g9Ou6SvW7d0qDWArHs8v8N5tS9r6Et874smZS1eUGPFqYOfZoZIp3r4dNcI7zGGLAd9duoEuogMcuINbBeaKj9/HfjSWLFMrxQkw/xiIpFsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296541; c=relaxed/simple;
	bh=mSsTHx5jUJzjnMZ6ObBRsxkBxK2DJvta0CpdS0NyX9A=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i/9NLAVW1POkT4Md1SzIP6dHCGADdCt/Xg0MN0eBkMiEODu5Wokvw6Lh2OxO5Zu/JcKr6d0SvRg1T55I7xbcLvVOxDs6aUeim2pGOloPTW8idh/kGMFOk+BLG4YRszwh9FL+grZODJHk5WuWd+0sQtS9y/86RbG3HAfmzrUTT6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QG/+bLYM; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QG/+bLYM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732296539; x=1763832539;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=mSsTHx5jUJzjnMZ6ObBRsxkBxK2DJvta0CpdS0NyX9A=;
  b=QG/+bLYM9MipHBsUscv0buQp67iTgUlF+ji9MVV9ptHtIRqoWLfRrJJW
   Wj43z01ECCDDr7g4lGW+1niiMey0bfJm8YP36VErjX0jN+h3MMxnaalsT
   yfv9eYfefl3Upvcyo/1Nwm18sOijHfbxNN8FhODSjImgW1Q5AxUfLIj1R
   pWwRkYzTAzOWi6cI6Lv05XClrMtJyn5DfqGQffnnVwUipsKcIm/Nujdne
   legY0M1ICaIF0FBKESLm7XA57MVw9bHUH94VofIaGzKKammoWK/XVM2Hm
   V4ccEZiE36+TwrbiffAiiFAeutgDJZL1AXtOIshhgq3eK5IXwyUlx6MaW
   g==;
X-CSE-ConnectionGUID: eHUNAs1OTEezXg9H2aIiTA==
X-CSE-MsgGUID: FTqOGxJ/TlquqPuEw0Gsdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43860623"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43860623"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 09:28:58 -0800
X-CSE-ConnectionGUID: l/bKUDTHQI+I3tjww4k1oA==
X-CSE-MsgGUID: gbE4fwupQWWlFG4Ieg6bJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="90992055"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2024 09:28:58 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 22 Nov 2024 09:28:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 22 Nov 2024 09:28:58 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 22 Nov 2024 09:28:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0mg3tGVGP7tTrpPAOrUiKpZHyHgvf7O9gjqtUGTl7V8Wk0wNJtRacGRmCpnTkalM1yc9OomyKXcLzQC6uvJhcuXWJIyn+ObvDdN3A2Korqcxi3ccvDENZav34xvvNKCHn70IzA/BuVkDy868+Q7Jx4T/9aToU3u3+XdOCs0qq7UrKMnPEwdoUIVtY+FkTJdbN/am6IVHi8KPWinji6YiyVIhdTAByJ/CBxSWoTtIq7u98fusMpt2IwysGUXmnHSWFYGAY1H+XX3z5D5CLMSORz4AhT0gUUjwv27MQgnXO0FefTaDsLpgZIVGA4qYS+9aACbQsKWprtm7xh77LiDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXd36eJnvIGZssVktl0taYX0fkAYnCuJdNA8YwHc0xc=;
 b=EbK8mBKeWF5WWajI1UHyhW1Aw9cngVqY/TMOI1KgeBEYat37DiwNjvXIPy3ETVmndbGsj0geqHEY2utTJo5/adlR2FfEwbCLyJEYYvvVvO/HtRP34y/XrVKGwY+ie8VKgZmQw9XhZ7OmeavKHH5MUAwe1K8TIqROyhvsjMGpUobOW1U7B5sC3q+XzOGwTaZnITcgTwZO4LQE9NQFWpiXWdETRONk2kVB51G0zsTPqE9BEJcM1xmV5flkRgbza7mu3lgG8U/gYToIOHwtEvEB5cWuJ14dFLxEpGz+ObLJXcXp7KmBQ3ngotP3OsQSQCvQIT2bTPKqeKIirjycrzrnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB7689.namprd11.prod.outlook.com (2603:10b6:8:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 17:28:55 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 17:28:55 +0000
Date: Fri, 22 Nov 2024 11:28:50 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Huang
 Ying" <ying.huang@intel.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>, Li Ming
	<ming4.li@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/core: Change match_*_by_range() calling
 convention
Message-ID: <6740bf52dcde7_2de57f294bb@iweiny-mobl.notmuch>
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
 <20241122155226.2068287-2-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241122155226.2068287-2-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:303:8c::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 1319bb0f-ac60-46e8-82ae-08dd0b1b23de
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PkwFjwDtc3Uaykbkd+nGP3Kezv8QNarUVXULeiqBqciZeblYAQnKw35Feg/k?=
 =?us-ascii?Q?MjMxwqLGhqLx+j4hTYNKamz9F6N3trZheIPY+2EWKW41lcMdK2hfUpjQQPJ8?=
 =?us-ascii?Q?GO/us6t3NJpvyYL+VlFjj3FwXxJ5m8MSRWwlJMUQpSnQ7T5vbGbL2I+sWi1v?=
 =?us-ascii?Q?MnH74XRJCrszBzx6EDSw7dVahem5A1hR9d3/UR9DujIqw1STlLkr/aXSp5fr?=
 =?us-ascii?Q?3hR/gaATf9CGVifOCjUZ8Mu1pWwEz4HeK+i1UqrN9j6ZETlZZBTsM4X/uttQ?=
 =?us-ascii?Q?bLkZGCAz1/T0AALRTjvpoKhOyWiLvQZuaukTOKpBzw55JcOOQB8C7boq6x8B?=
 =?us-ascii?Q?F9/hamMXhTmcUSMEUm1VRYCHTLMpoDpxayCm0/xJITRX7/UclxQL2ebfu2bC?=
 =?us-ascii?Q?2sfyBgd7NgCNW9PCUBQ2wS4cfeQd6+GG07/EBmopRQrdgrofSIkdxAyrha/H?=
 =?us-ascii?Q?blVEW/XAgjmibpkr/JKna9AtYmwXFeh4cUaBsMU7dr4orZrk1r+6RmD+yANy?=
 =?us-ascii?Q?ZZZy72qeT3SvIVoXR9TiDD7ZYDEZk4uK7MMzvhMjgI4y3TJy730VzGc9sxmv?=
 =?us-ascii?Q?XyvLnZkVkWWQ9KNZJd5LyC6XxhrPj9qaUwdHkBLhWJQSukYFJ/nCHwqfEEGa?=
 =?us-ascii?Q?aHFDzLC9z4IniwSVh5xjFAgAg8fjhbB9wjTLOIDv1QqJR6uqmC8E2Dwo64qq?=
 =?us-ascii?Q?1KudIFD3mUvBDojomj+IuFulqlFTjYy3r6tXS1bouHJrMtMD2A7AeqMrTSFZ?=
 =?us-ascii?Q?cVPR+EYjHj24p+gL2Y7+mK6lGHNQ3EC1e+nn8+qKOud8rI5PrbscZk7LppZO?=
 =?us-ascii?Q?JIDzBuDTXNyB3SLbClOrXUyTxRdISTYEWscjUfp4ByIvaoR3fZjc6AXs5mgl?=
 =?us-ascii?Q?0bAE4f4QulDYHYd6o7NoS3DT2XduxQblMzOAFCyjFDTTOamOCTLVZNMYPov1?=
 =?us-ascii?Q?SrnFywpeedyf1CI0iL2ksLmJ9qDEP+1KXgUlZ1lOeffJ9zLlfItbTRKU+2QX?=
 =?us-ascii?Q?u02LCrv/gEFgrPVS5h2ya2blXQSmkl8c47RhALVrAeof1jKZw1lQs93Y5F0b?=
 =?us-ascii?Q?b4aYzW9g6DmOwvihd41DhKblASPVSJ0/8Vd30JdDKKYD/ahoEgEMhKd5AtdI?=
 =?us-ascii?Q?7exhUikQSX3FJluHl/qvAxH3vPRMgEsG6Zcua9+hBvS9R8iOFsnUEmeZ0bl+?=
 =?us-ascii?Q?h2Z1GdTmnqcu6n6KS4ZEa2vWFv+haN8oHIqbdsTDcRP4RUpSDVFUvcEP09ad?=
 =?us-ascii?Q?EgDH8K9rnlPF1ot9EOEjw6nmfDo7fbuxx88lfeH5+ewQCmQbeFUVVq7GiuaU?=
 =?us-ascii?Q?BLEH/SXVb00G8dqPZedRbb6OFu5lnWQd6IUCYbRGTqdHF106WkRvfXkLiBpj?=
 =?us-ascii?Q?jCZF/CY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Hrny+qz41sIajVLNBx/UA6yFPakCE4AQDJ4ScCA52xUWYoirJ2zjw5CGj0Q?=
 =?us-ascii?Q?/gqMmYC4tSOnl46MnDKvJ/ENn5u2NMQwzyglNC7zmbeFoDbFJlusELt4KWVZ?=
 =?us-ascii?Q?fGn8BRhsE7RCyQDhM8GzJ0t42A6Uk1Odi4/dYjTJR4mIAWtuZ2a/hO6C+9k/?=
 =?us-ascii?Q?9CbCMB5yCq2+an5Q59US9G06l1Rdu+LvTWPa1lkTv3cXBYAonoKiOAjchnwT?=
 =?us-ascii?Q?11zOLOA4ueRsl4Wis9+ZI9asjkLVXzOHQ1clKcLwQ9WkZ1VO34i0NF5EuaKA?=
 =?us-ascii?Q?afGuYgoScGB9g3NatiajqBQzuLhmqzurA3R/JfHOYYInglOANOe1LRX82Ll0?=
 =?us-ascii?Q?ycX9FRl5PYosIU48CyahKieSCRw+ZSSyzWzkm5BMHHpN+rBy1yITiiHi9M7y?=
 =?us-ascii?Q?TrNBBsrHpcNFBmUoXWc/6zo4lVMgB3QyNwSp6tPoeNQRV+eGHN8OvxIT7A81?=
 =?us-ascii?Q?8hjw2ERJmraF2ZHPeoFZOFPXTuxeWyRKB5sBGOLE3DvTMbyEsZID2bfXklAy?=
 =?us-ascii?Q?Q4Q+IYmtvqo9F4nZDEfGk2VRthsAazuoiszDWjESVUIgSbvm2P94o4PAdQE7?=
 =?us-ascii?Q?3i6Syyx0e/xFNM133DsaHCyuauoV2seGJkinpJYECOV5zqSgKK2l6vrJZV4y?=
 =?us-ascii?Q?IzVgodPLaPU5E3HZw8KIz51N3e52Vj4/ysh9eMzSlg1ram8/bILeeqNvmidN?=
 =?us-ascii?Q?9z7dsBGkUltKWWXCFjiiY/zc7LQ+j5CkiRxkOYdvYXN8g8e5qhfV5XFFCuzM?=
 =?us-ascii?Q?gMqGoTMPj3hUc8rz8x2ieTYn4nsvWOAIeJl1Lud2p/KL1s1LXHrVy3Qk3YcS?=
 =?us-ascii?Q?NaJ/xy1wu+wrnW2m5VuqpHyZVWcOljk6EXnxJd79wrN8D/YeD9itMs7oxi7D?=
 =?us-ascii?Q?kOlzrd9iaRRdEqi+3OyVsW0FDaSaTeZG4XJ7pdJ71NjWIX2THEJp9uK7rvHf?=
 =?us-ascii?Q?dhfaNslgPJKAMj+momLnW7EvM7VF4Oyae6UFyTELxgIRRAB1k7VVAlBShcSm?=
 =?us-ascii?Q?/XLeK5Q1v2HMKb4vtpgHvemcAx9QcHsr9yA/wcmA9uMhKI4wNYiYWC0aTC9R?=
 =?us-ascii?Q?WWfTbLu7Az7wIIyLO3BhONqY8ECw+UmSb8KOd5zf3UdK4Nv9oKmfOGDGvb4/?=
 =?us-ascii?Q?4tV/BWbr5Kk08s5IaMm6rzqxrePGQMfIZx4F1GtZCYWaZHBWNfWyzXwjJfjG?=
 =?us-ascii?Q?KmEWJJkGfpbKb64vX1A/oUok3MNUnuA9e2xqd88cG7DJ3KZ5azmvaLO0x1W2?=
 =?us-ascii?Q?xd0PAUfWhqO8rEEsVtL851TVTUWLFns0D51xmeqpnFvyCQevIDOYc0YQ1vlv?=
 =?us-ascii?Q?N0WiCrWf0BvIXGQAytq7+ILaoeGjSWUyNZbq5dflc/7RS01lKqqxbO/SgfeH?=
 =?us-ascii?Q?Qi6AYb9taXr7UYSJxeMx6IKbV7V9cO8DGQtVqlnRHFSHh4nOdQU9O5Lmbx44?=
 =?us-ascii?Q?jclQGJdUw/87OYhG7AbY2FRoKoCij9KIbN/VYBpZm0IY3E5NDxLtX7BSmMn0?=
 =?us-ascii?Q?QeJ8dm3SUg3LMQ2sI3bWYU/MYMVS2ptBqE1AhgFZLY9P5/IccW9ryBRLEc1q?=
 =?us-ascii?Q?uD8Z49aQ22LdOjB5eXGEAlZCgw2rvAJy59iUpc3F?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1319bb0f-ac60-46e8-82ae-08dd0b1b23de
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 17:28:55.1522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAYGPtSxHL7qr9zcyW1E6YijtUSz5dEuJjfBP1JpFhVXeo7xPFOKRxLIBqDQ/6jA5T1Ywypgp+VJAucQCa9prw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7689
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> In preparation for a patch that supports matching between Decoders that may
> have larger HPA ranges than their corresponding Root Decoders or Regions,
> change the calling convention of three match_*_by_range() to take CXL
> Endpoint Decoders as their second arguments which later will be reused by
> two new functions (arch_match_spa() and arch_match_region()).
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
