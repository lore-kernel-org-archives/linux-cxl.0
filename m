Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64185229B02;
	Thu, 14 Aug 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187740; cv=fail; b=YyThvw9jkUcrjyrMzHl944MiWSQS+6wPYY8U8OlkZzLOVF+3Mw0iJHCZ0U0panVV++TVgkgnMKZdZpHVE0hglxAo6fd5mTHs3sfV70GFn0t3w4yOcfQhGNedPrkmOThU7WuQ/blfC2riVc+n8UM9EPbQ2wa9P6ySMotH/zvvmB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187740; c=relaxed/simple;
	bh=SVvpj+3mTpHiG7LD67VBqGvihtivTHqmy/G44mnFCbI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k64ZUCTuispjtoiVnWsn8uVugG6T3l5Iaxc09lNupPGyk84qadEFazez3AVNVFFCaYO8lOMmmoy6HSQArdnzbazHjYC3ToqlftaDJPJ7kDMpT0Xy+jIuTw/7juLfySk2Ds4ZocxtlzP2ha6sRLoUnBnNxd2PqMVB0fIa6Bk5IH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIkiJAnk; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIkiJAnk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755187738; x=1786723738;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SVvpj+3mTpHiG7LD67VBqGvihtivTHqmy/G44mnFCbI=;
  b=GIkiJAnk9tCKWAVt1PSAcFaOEkIZ4hO2ZdcXhk9sTaz0qTd0RdFxyAt+
   EAuHdK48jSvm93oWuN+YinusuDPuj1kJLpnAkxcDLzKeSvVs5wgUlIuDP
   nz6UzZ2139rORem2Ph9Q6bcNb2aH9J0V5bQrnKBcfHtPpWTgoyVAzcdYw
   FzZywkqSBDuzZRCcUaLCJ5vDShbxH3WJJx8cuh8gZUFa6DxB7UAze+c0u
   Rz6v3iHXhjZ30Ldezk9x/JM0PEN9bvZHE8Adqyx/fTiywaK3PTLdpndMz
   ju29RW4lYDO96bOe8AXOV/0VoZJxZccDxZ6LhMZiAuwmNnkJ+eCDeioEL
   A==;
X-CSE-ConnectionGUID: RK0QQ0gVQO+tXa4cy5Oj0w==
X-CSE-MsgGUID: dXSHKPdKSS+MRAU/+s23Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="74959536"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="74959536"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 09:08:57 -0700
X-CSE-ConnectionGUID: f9IG/0WZQi+Xp/EaXEVRkw==
X-CSE-MsgGUID: KvONspzERmenw4p7csYiCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166296324"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 09:08:57 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 09:08:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 09:08:57 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.84)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 09:08:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmlaNMrt2CBp1y4vIkbBclDmWvJh6aOBjdRuurK44OuJmN2oL2d9pw9PLTYjXoNu59Pj+vnHnIdOli+makGzauAfvZw6h0BosKzq1ikcQTR188X+90yYNvAhvq1xpwfNaCLB+rja/Ue6ttnq8QoW2EI7Giykg5TmHCKY3epoAEZqf+JtLcpIzCWg10R6uuk0acQfljJFsBrcFX/a9wyHfpxBNPnnEfeNNLSbJ8fkp6/ZHNMXn/w8scIMgAqBWRHT9860f/68KCH1d3QHpFKQG44OvBzPq6zM1KW1e1sJUfDAEGAXjgp6AwO+qbiNmREsnplFC7DewV5hQvMYQmrywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVjV2+5P3YHc0dyBHUOgADmU3Eorvnz6RQQNJZYM8lA=;
 b=ue5B/CV1UFHwsm/66z5xUKSn+V4QP8Ioj3CSt9nS4ISbmQRmUQVHkgQU4yNZ1G4SjNW0TpdihhFm9A1l2g8OtUgFEpHLqwNh6l9LasKiNC7Yk/cPbcbZqQBYxKq32uVDDODtjrGoPvCtJPg47p5xAsuemXthUWxany3+KHx2OyoZTBdL1Qmu9n0HoUhXnfug5/b5+8cUhmJuSuqIevyWpnDaWn/T30g9ofuj3jdc/cU9YsSlX3Yz91GewZLL1pduDQLUHueNNd3X5cmG1MqS5X5FRO9jnjOTQUSCPkkL6SiTSVSn4r8EWAVrqLUZIXQblAK+e8suQzoGwaOEK0AYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 14 Aug
 2025 16:08:52 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9009.018; Thu, 14 Aug 2025
 16:08:52 +0000
Date: Thu, 14 Aug 2025 09:08:48 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ranganath V N <vnranganath.20@gmail.com>
CC: <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <alim.akhtar@samsung.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>,
	<linux-kernel-mentees@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<vishal.l.verma@intel.com>
Subject: Re: [PATCH] Documentation: Fix driver-api typos
Message-ID: <aJ4KEKHn351vQXe_@aschofie-mobl2.lan>
References: <20250814114245.16399-1-vnranganath.20@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814114245.16399-1-vnranganath.20@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e69c36d-9435-4f02-b9c2-08dddb4cdcbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6hovoRhyR59CZPbXVHvctaIB+0lcEpixG0tFgs0z/2mlZOKY1lERWlovKUcv?=
 =?us-ascii?Q?1jPmnNkx4l9IuSoxDflhujEWhLbNSVxOkOVdydWpVLD+gFwNShMtL/QDKx5o?=
 =?us-ascii?Q?eq26+t8fe+YwQE5pIbbFYvdCRsjucGLZvcUeao2P28ZbYPRbh+deY7S9bwOq?=
 =?us-ascii?Q?ff0AksaG0mTps/Nd27WN5F1bfpKE2kL/P7nWe9HudKFkLx9ZbcNh4o3zgWmT?=
 =?us-ascii?Q?fEooUKkGl4uihemxdFOD89kG8xisxr2ouqetcAiyfqzMffygRJROEplMUdsZ?=
 =?us-ascii?Q?PwzTXIBQGzLv5atJzS9N3LDpFI6THZhix2EfNLShbFDTgKt72H8R/FFPMz39?=
 =?us-ascii?Q?4VAgs4ZKNUe9RGT3qZ0MFLHpKMXz7X8t7Gwy5XD+OG03Yw+mkVsSAmzW2dXw?=
 =?us-ascii?Q?Z4v1cJLcLMXrJAFJgZOU8syEmr5vDrc5O8SmmMAvk1qCRj/ImwdvS/lEcR4T?=
 =?us-ascii?Q?JXLAClnmJVLlaP3Xdsb3iUHFO2Io986pjdx0LX6N1phwya/Clcy7+B+kn4Wb?=
 =?us-ascii?Q?hN91I1sL8QoIZh34Ll6/sS9RZq/hN9ngq7wMSxyiLiPwKuBb6z1ZfbVHTvLF?=
 =?us-ascii?Q?zNRmWOWMcJV5hnfARA2oP1k2ys20OMjgWksa2s0GYa+D86UVOyoo30+Q5PWw?=
 =?us-ascii?Q?l7EJJoQJZay5GDPp5ilXlQSkisygSD8N1SFriE8PtKd8wAXCzsYVd9h/rM8C?=
 =?us-ascii?Q?/lmuXGjnAUdiMOBHxFh79FwA6XbOpR8CwhKcSnKVUo4k2pbeGTmUej88sHWM?=
 =?us-ascii?Q?9gLflKKjrjDirGRmxHf0pSiQ0RGSBXH/nDbI5VOiomRmFU6QKskl0DpkxJyv?=
 =?us-ascii?Q?tzklPZcm9lv7i2jshOiQNKCNVtvUJUFZL9A66bt0Rxz6jQ1QN6in0EsoqM8H?=
 =?us-ascii?Q?9ZeY3bayUj77JuGvr5EEjjHOjA4NtYjAQZuzr5u64m+WJzA/746Kh2nHqhzn?=
 =?us-ascii?Q?dFyaK1cuXSS26aiXmd2LPLeTaT/5gE5RJr2RBY8BraU99NB0OrmFN1dKo6T3?=
 =?us-ascii?Q?YZOls2PgB8H9tFauTF5x1kTszeJ54tyT0ML8eJKIyn9LYU2obpb5sKe6H0uS?=
 =?us-ascii?Q?P2vRhTYHpYjeRI6IOM8OCOefjl5n0dpWnirIONFVQaUTDn5CFEE9839qgJLH?=
 =?us-ascii?Q?pk5Vh/GfZZp6ksdTfnXBMaSG9Q5oDumyJSThmwLz0p/qB10ORfwkKWz3bAMQ?=
 =?us-ascii?Q?h9C2lxu6tZFu/T2wXLxzICqyqfGqcubWK7UZzDxg/w+rlZvtXVMSiyn/bzHG?=
 =?us-ascii?Q?4/r/z6pHvEWKvIxKdvawATfu+a7rURmCDLoHNnrYBjxi2X7OBf3ytTuKa5RG?=
 =?us-ascii?Q?JRj4u9HGcQY2Llsf+jqEvzElgCVVUlqE6nwHqTxQ8HB8yJFAAIzgJgZVtbkr?=
 =?us-ascii?Q?Cgz/6NhHCfn5DOOGHyHIFudZbh4DMleZsYWJFpJil66+m0A+Lg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WcxwydvNVoXjqpL2OhvHBTUvhuXqk21PJMZV7dJQaqoDGLHIF7WPFgFl3Mn8?=
 =?us-ascii?Q?fyFrsn+Tq6tjx3bOCIAKHe0j0dwPzEQjQsI5SC/vkjyPl8o/xn5uRvWi4La0?=
 =?us-ascii?Q?v5IiGCGYP4SP1EXt9hfQlMPUtOUhyHaL9U+JA+GPK5Tgx9knMXQLUQH+eBOI?=
 =?us-ascii?Q?Vs9/+OuMSS8eMP4bLe8qTXx284hJrtXw5MB3er9+Q8lrJ6EMU293mYtldLzY?=
 =?us-ascii?Q?oJGtieGEEr3O1UNCaCjC88eYHcvbPoiU46y3xLImGFkkG5HHl2lFeceI3NlE?=
 =?us-ascii?Q?EAHuW5Rj4R+a7iwsUM0dwbK0/nXiNZi2Bqw8ZqL32KZcs5RUO5ofDqgCctSP?=
 =?us-ascii?Q?KF/Rup2ZfH3U5G6WNYY38VdEQ3UD3MHkb8tWVtGCwWAO9SYoQ1+sDthU47gu?=
 =?us-ascii?Q?ngw33hYNdMZj9shouuu/UQd1Yj8KJvA3vg1OjFSd1Gshw9u9Bn+IKmCJvX8l?=
 =?us-ascii?Q?lDIYiPjCJ9PPzBnAGtJ7WVy/8RRvAnRtVJ7vTh9M8y3Kv6W9TVWwVGC4CvWT?=
 =?us-ascii?Q?NVgx5ow87rochcg/mzcz07a9Ql9cAvduPdt2YytujKrzbWFgArrrqR0yT/+w?=
 =?us-ascii?Q?knVFxZvt4Jd9y+575AppjwMazFTTB/GcnXb71X70JAp7Lh3Y5NyIP0bWqF2J?=
 =?us-ascii?Q?ksaYrp10WLDS1DDx2alFncnBbxMP1/923Jf/2XqFKQY7/jc9dkwogFI5rfAp?=
 =?us-ascii?Q?qyRMXFhZP8Bj0T8gFYc3N6xAKccds2DJrHAp887M8koUwrg4VbZVnSdsnjDj?=
 =?us-ascii?Q?MB4LURQe4OY0eoK660zFKMWLVof5h21E4/SNef4a9Y8vQ5pnBe47IBKC1JFd?=
 =?us-ascii?Q?FdjN6Foaq5uuhg+u/ychhk/vNvG4oQvsmcnPhh4K4e6+mdjAg9259h68t1/j?=
 =?us-ascii?Q?vX+JHufhA+unj0suwr4hv9JD6U0eL62PMVoQ7oIXDSO21CfQ5zfJUecMBjgX?=
 =?us-ascii?Q?xy+vqXVoYWeyllYq7tlyOu6LkWNjxW1ORjGi+v/2emhL05JamVHFDXy1ma10?=
 =?us-ascii?Q?n/xw1x9sVbU0bPF4LM6l1egbxq3OR0xUXekeIo+JI7Lqi3WB1jmieJJCKd6W?=
 =?us-ascii?Q?mp+ZLzFG+o7T+qzPA6tdbi1i5mt5B9iQYsQ0/EIyQ+5copJKojfNDiCVs1Uy?=
 =?us-ascii?Q?qPLFjPwZz/c3ZgL+ekzLyQANpofOqcDuaSgaFKoZCKz3i2yqlF10gAYpsCBq?=
 =?us-ascii?Q?1UmuAIlPC19y9vUa04DghPWdjqM76MMyEXAhzXJXdFTmdpixv3zzamgXXtcO?=
 =?us-ascii?Q?xjz+vudOJsFrEM1nLuKsULtvjTis+BNysetH27lxFMH7QzFmk0gJnqZX9zI0?=
 =?us-ascii?Q?9qWlj/tE7MxXd5mnTyCnvAfNMkYazRXfebdyFZZ+ZP37pbgf38w7Wxcq7MU3?=
 =?us-ascii?Q?5PHeNmXkYY3K3a2b9QFnxU/2v4OTY5McjWC8YcNGJmnltyV0Hkryq/+9j9/Z?=
 =?us-ascii?Q?EkmkvDJi/OteKs2Bv4T57dsH2dr37jOCV117Ezg4DaZDN98y9vM2PxTh2Od0?=
 =?us-ascii?Q?xrg6LA52WbqkIaq0bRnNMaL+w7u7BBhVS8eZQkVq/n+cJCf5B/g2BCH/iSye?=
 =?us-ascii?Q?el3F4GSFRoKJCxeNP3GJgdnMNbs2NyNbe2knBeOOTHZA4qmLiTy6rPzdCeng?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e69c36d-9435-4f02-b9c2-08dddb4cdcbd
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 16:08:52.6046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilIh5V4xkuXoI/JoySfpeK4Mp73PthlE+dUAfbZcTcxV2pZzPZ+oy8rtW9bJV6s2BaoBpHo0reXVDu5TGfuUZvWiAfyJiaSENMip+mEXOaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-OriginatorOrg: intel.com

On Thu, Aug 14, 2025 at 05:12:44PM +0530, Ranganath V N wrote:
> Corrected a few spelling mistakes
> 
snip

>  next temperature, then you have to enable emulation mode at the same
>  time. (Or you have to keep the mode enabling.) If you don't, it fails to
> -change the value to updated one and just use last succeessful value
> +change the value to updated one and just use last successful value
>  repeatedly. That's why this node gives users the right to change
>  termerpature only. Just one interface makes it more simply to use.
   ^
   temperature 

BTW - I did not run any spell checker. That just caught might eye
scrolling through this patch. It's weird that a spell checker would
miss that one. Maybe check your spell checker and recheck these
files. It's nice to fix up all at once.

>  
> -- 
> 2.43.0
> 
> 
