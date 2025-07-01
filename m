Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4031A0BF3;
	Tue,  1 Jul 2025 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386395; cv=fail; b=s1nxts0y3frx+dfV4fW6iOwYA3SMrtDiuogFczTT2n0Z0U2Q4JHDPEiBRHpkJVQSObG9ZtXUD7psFUmCPUYtEq1vRfsLsK43EnLtuUc0iYN/WD0m1nc+M2d4ia3j3HR8Fo6CeRF2aJfx8jDbBLdTIzBY0P8dfbz6pnHgZ0iqRI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386395; c=relaxed/simple;
	bh=seHDL4sVLZgDTCeAvjna6gx6SPEDCpJqUXkz9iPcTHI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=spKe6lAOjyhhLn9F4Hcczlq6ZWnRP41z58+8IrnSajXMMShhWimVWpBUjmis07XTwxQcnT12JfF9MiJMo/xdlisAOR7Ean+Rc2pYMFGYefQARE7HgUVbTijIWY03dSMHxqNxyxWtBJ7W+gV5Jf6lRpcpR6zntKcaKDyYbcnH+Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+0hhs4d; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+0hhs4d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751386394; x=1782922394;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=seHDL4sVLZgDTCeAvjna6gx6SPEDCpJqUXkz9iPcTHI=;
  b=F+0hhs4dlPy2VGzZg+9S7cjYcJYDFaKCc4pAHbVn4hcnvg0c+VVzA2Je
   RpoqSS051/8EY80HM3e7/JD8JU1tox53rC3s2sqxdoVqZxkcR18ijTWpE
   z5uBG7L4+G6PlYek1MIszVReU5ROcgzJZZTTZrXmIGsy8RLjGLc0P2/GZ
   HeehznQ05OObr7aFcIS5aRXcB/X7EH8YhO77s9muCC6JoJ5B0u3DfB8Ob
   Eq86o28FtQDzwA0MIz0ymdZy+JK8eEWTIuyT7LBbQ7ad0rfMRNd6AndNf
   RKmFVx4oEzROzsIrdoD0GV2pNJviuWDZymp3O6vEx6yeyHKmwmPpFvaqH
   Q==;
X-CSE-ConnectionGUID: Yd9fJeV/Sp+QWswWdfMUBg==
X-CSE-MsgGUID: nJUGGdMsRKGeImgrR/xY3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53766639"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53766639"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 09:13:13 -0700
X-CSE-ConnectionGUID: KMgMoCe/Sh20RhhnZbXEDQ==
X-CSE-MsgGUID: j6hOedBhSQecCy6UZs6d2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="184752957"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 09:13:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 09:13:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 09:13:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.74)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 09:13:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYfazKfwkyynKyvlh2gf/bbDpmWMUqLycfkrUzYiTvT8Tg+boFPYHbYf4Q2VVVwvH+HnilWvCzj+OEr9pevraPE1E4irN9qzLBbRGr2BxiXqIskKvvENQm6oHCDxt7P5xfLpMW4uwxwlOKn7jdnfwHnoXym44DqiKJCHnaHkwW3DPdE1ZEy/6hYwz6IeEhSRReAPG6uQP+teHlPRsm+Xus8nWU1tNA2rC+RQoRf7go8yDCbQ67CckJbnu03WTVwcK/LkZvmK4+CZkIpAtZ5vk29QIEhRjCFjqDKDgtHLiOqX79zwRBYpRFEtrmJbBAyICiI6cnImBudEQiJELhn97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/u1Xt0aWQcq+hs8Oy0oItxXScVt/Mld2TdpcxwmzRs=;
 b=dU1b+xRx8TxNR3J7cd4djEtwF4DbFJkHJmTBLzJbAIpexHq5JQV2I5FIAq74qRiISeUldYZezT/GwcVhzlnfwOWMGu8wYINgVtUzVBwoEE2i8tAJroajYDv9zWwHIlj3rs+Ff9IbBRqseYM/PWtMSscNy0gdXi/Xgchezpax9aYo+ialFYsNHtxfWe6lQGBKH4p0jw6ju9TA9m3Cr0WhGgi9N6jtW8iHUwMekdUO5Oylr8Q3w4oBHAZ7/C+bTtUL42gX5TsS120aye7/BgIXyYM4P7DyBl+yeflN5k5xHuHN+yTTIkGnz6i/rabjOR5QGEUm17DEg7pbhUvpzWxgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by PH0PR11MB4902.namprd11.prod.outlook.com
 (2603:10b6:510:37::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Tue, 1 Jul
 2025 16:12:53 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Tue, 1 Jul 2025
 16:12:52 +0000
Date: Tue, 1 Jul 2025 11:14:19 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Nathan Chancellor <nathan@kernel.org>, Ira Weiny <ira.weiny@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: Include range.h in cxl.h
Message-ID: <6864095bc5ecd_30815d2948c@iweiny-mobl.notmuch>
References: <20250701-cxl-fix-struct-range-error-v1-1-1f199bddc7c9@kernel.org>
 <6863fcb649c0d_2ff1fe29428@iweiny-mobl.notmuch>
 <20250701153820.GA3922159@ax162>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250701153820.GA3922159@ax162>
X-ClientProxiedBy: MW2PR16CA0021.namprd16.prod.outlook.com (2603:10b6:907::34)
 To PH3PPF9E162731D.namprd11.prod.outlook.com (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|PH0PR11MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: e635b635-1de2-463d-92f1-08ddb8ba21d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BRSaKhGZjdh0TB1eECJfs+LXM+a7ZA4q+tjCAnlA9CRcJYVrkf01FSVbTuTP?=
 =?us-ascii?Q?i/1TgeNmZzLP1hL/6PmEWWamJiWU5ixYWh0uhoXvwPX4QbNKDopLcgkBfpd8?=
 =?us-ascii?Q?KKksMAZV582zcRj+KUIeap4JVonMBLCvT1xBFXSfvPmWGni44VoLFmje6oa4?=
 =?us-ascii?Q?fHTbGKQJKB55rjhzQg8fbEanSsvwhwAg/jP5vVcJxxEGDXTZBh5nsTbgXhqz?=
 =?us-ascii?Q?6E0bzRZu3almGXYQJUa+ob86p3KJ2zxVwxWCepX3LyVMudyU5WJSJWIrQnEP?=
 =?us-ascii?Q?gsRJvRftqsWObwKUw+84kEinPdiSvw8nZjEvU7d2NqM6Duhe3EyBUmjLn+oj?=
 =?us-ascii?Q?0MIqHjcwvIww96Q8juq8VmmqkCW6mmvOI2EwfCbIeYJ876r7vzfB9FNxQAXo?=
 =?us-ascii?Q?L8jo7ZXYc3+udhIUuQQS2IUKs0VAjxCIaIsnknR9o+TPZ3cUi+fY1kGfjk8q?=
 =?us-ascii?Q?LcKpL9cjsVXjWune3/qrqyU4IfDjpAA7MobMzWVUSsan6mGu3Tcg2Iw74Mab?=
 =?us-ascii?Q?iP/VlOw1BMQLBjH68U1HHl0aauuYClYpd8gBHiAFfpvxA6CGRJw+PE6DVFfs?=
 =?us-ascii?Q?vQ9xs/jZcCKX2JgzBqeeXGbmJ2cs5QRl0YI0hJmsne0+XkanU0WRONC6M7ct?=
 =?us-ascii?Q?FEskh12rVbgoGavwkYoqMDPheVtdgnXxaV0V/85o+Ufs4XKfGOl37jjk7Ctf?=
 =?us-ascii?Q?Z6hmAm7zWSZRgMAzSdhCDpik3ftAd8hZQ1comPwVuN8kQoqlB90BhwwgSQyT?=
 =?us-ascii?Q?5IRtuxkYuTsDGr3ePKqrmMr+gPWprq8FV3qZOi0uIV6MwNh8Bz4WygHBtWOo?=
 =?us-ascii?Q?r8VUqtjD8WqAvUhbtrVGX6b1bjCT1COjiiYs5qUsuK0J/R44qQB93TvTQIb+?=
 =?us-ascii?Q?Zg/1FSSVojlSww6TSZSQyJB4X8x9sxDmk0hrL4LI+ns8GK0507ni41YmXAYu?=
 =?us-ascii?Q?qy9bbuymLHQUmHejN+XBop7Pr8Xk/TRk/p6d+015piQGZ5ipbbIhqtGh+kMZ?=
 =?us-ascii?Q?7FSx+V6UdAicUhPIwXTJEueb7HfAZJNSVm79+LShA37h4OFuK37ptHNUU+jc?=
 =?us-ascii?Q?i6gJFWeVav4+QGWGUnKdwIPPx5lCusV7t5Fn/k2QJd/IGgYO7YA0yaxyINUz?=
 =?us-ascii?Q?J8IyXZPPziA/gOHoNtOCigxSQxYnw0cpQTwNNrrIAewOhU1V1xnqUMFJukvw?=
 =?us-ascii?Q?SQBYSRL/lYhjZHb+lvdbyAUwjl4OOrdwnMo9liZjyxPTi6CnkNsk+76urv2l?=
 =?us-ascii?Q?Iw5xOId3QWdMF3GwagkG27/VD/fz1eIRor5TSVBjtaJhJHVHyEacVDGd3oMa?=
 =?us-ascii?Q?CNSaSompCZoI+sr/iNmXStaeK3Rd1JiWgBVMiM+tInMRsYYL+DiWG9lLv5Bk?=
 =?us-ascii?Q?Q/xyFaI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M0E6CP0JZo1EJ0P5e13sb0d7uyKAUr6bU9KnwB/NYKVedYh+wbnv6+zUYqzH?=
 =?us-ascii?Q?udTvF7zBZwkIaEJh10KY7a7csmd4CNugP7pluURcfd8hgj3AB+5sROJMIX2b?=
 =?us-ascii?Q?Z3EJPT3odGPwJcaeK3IhmLjmRIlipF5WyfXx/onxiF1Zc1aQLBLQvrZEE12/?=
 =?us-ascii?Q?Nt/T1kCB8uR+CsE3gIzKf2tUwEsN8FiYcHrqw10mazUbZVIiI71XHhIbEUld?=
 =?us-ascii?Q?Y8cOai0qnnAEUfuZ2RryyaQccPXe+sWmCMtU3WiKBuQmm2XsgFw0BNEYFANG?=
 =?us-ascii?Q?ZC9frKjRA4JncVW0rVmyOCS6a+vpXVqEiDM/8QmAQRpvvPzKpA0AksbUaBBd?=
 =?us-ascii?Q?lP7iExauctiqeoqR33d71FnkFbFNKwiQCOMsla+vzFViyA7GHUhAVYDbiNGj?=
 =?us-ascii?Q?anQ+rD3vIjwqAUbRw+XdzfyzNXzash2k+1AAqPACopu8qPJqgkGF5+sPdG1+?=
 =?us-ascii?Q?CuZfrHrOEJEvemWU3PcykwoATM6O45DnaF3SgJ0RsKnHC6eF8ZC+8F8kg1WQ?=
 =?us-ascii?Q?kQLesvJ6bay8Qtj62/NEzBX0u/DzQSzoHm0hRHlHuc0oHLQVkkBpjL5DKKNM?=
 =?us-ascii?Q?2BOYJ8GNNe5nohVP4YQglIRKjGuojYhvYM8Ig07545sB/iDbYVbVR+nu5W2B?=
 =?us-ascii?Q?xiPKgfHZmFl0BIoKzUoBr8lkDuHsdWKrLJ6KcNK12esNNsOmAQeqi/s493lC?=
 =?us-ascii?Q?BfuyLHvik5wugDLiAI19/Gp+TkpuAU7VEiDRksGZF8tX4hPvTqMjSxBVDvjx?=
 =?us-ascii?Q?hnetUtnZwBVNsPN0UhgJFRp5IP+6L1MxbgsBsE7owikwFp2dqo7dbppg8S13?=
 =?us-ascii?Q?DraKSWkinuF961+YkJ8o3pNcTMsnjXkUi5RsKj/FokT5RHcxJH4pMIzjyFmV?=
 =?us-ascii?Q?H8MBtVkL9+2wZlUqVcS01GguxUhc2oX7dwvt2gbcY/L98Lyy53MhnJXaqxmt?=
 =?us-ascii?Q?GusSyDKokYk6Vbu5R4jS30Wm1EgkIf9Lun9jlrtfD9dHz0pP+8yM2VO9r4bF?=
 =?us-ascii?Q?1dTGPFVUyLv1b9iSYELY75rASYG5PuBx+ddtcW62uGk/5uwyjSmDtC4wMLg0?=
 =?us-ascii?Q?+7MsHHG3+Q0nlA/ifLPySf9tBlB/cqMaONWC42QWTErB+mD2D9mZX5dGZP6Q?=
 =?us-ascii?Q?UiKr8/FRCZbBhBeRVxCeZxiOrhymR4WqLapMor/lYni0IcaG1mbxnYuaqouV?=
 =?us-ascii?Q?MZQy6RnGEOQRoS9amrYfNJd6o4aQqoutBGpeP2lckUlfYyVbLrp0qQwIIGA4?=
 =?us-ascii?Q?tL1HfpNH34wgEcAeEfOoRqz+lrGPlEz9fIN8giWjPIiYi1VuAwG8xmr0UHVb?=
 =?us-ascii?Q?mqENbPK45QFGfZMgyauIOoi+5IbG5HKLVA22vA9MVSkhW81crN4cJvTgVo1J?=
 =?us-ascii?Q?0DjZArGELBoD2TAmKn+96aE53ofJRsFeyEv0j0jQEa19jtqxo+edaHY5hKCn?=
 =?us-ascii?Q?LS/pOFcNWuH3Pb15XogBMShAGR/MSlSHf+WEhmDqARko4X1lNFXG22PeHb3a?=
 =?us-ascii?Q?e88hX6unyOohKPaGsIU611jqGGfxxstbgYD5tToKm9kBnHc4dRWnTxVoux7e?=
 =?us-ascii?Q?MMebwWswR+R21B6u6N3t5ayhpX3vtgQEBnamOXPe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e635b635-1de2-463d-92f1-08ddb8ba21d1
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 16:12:52.8607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+SI5bkG5MhXU9G4wZ7kY5EahtCzrO4Ek4ifA8ULi9BbhT08IvPCB1O8nMA2o2NUahlAWnGFJrrUkOgCYwuVow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4902
X-OriginatorOrg: intel.com

Nathan Chancellor wrote:
> On Tue, Jul 01, 2025 at 10:20:22AM -0500, Ira Weiny wrote:
> > Nathan Chancellor wrote:
> > > After commit aefeb286b960 ("libnvdimm: Don't use "proxy" headers"),
> > > range.h may not be implicitly included, resulting in a build error:
> > 
> > That said, I'm not seeing this issue.  What config caught this?
> 
> Fedora's aarch64 configuration [1] is where I initially noticed this.
> Fedora's rpm site seems to be under the weather for me but I have it
> mirrored [2] for my own test setup.

Ah, I suspected it was a non-x86 build.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Dave, I'll pull this in right now.

Thanks,
Ira

> 
> [1]: https://src.fedoraproject.org/rpms/kernel/raw/rawhide/f/kernel-aarch64-fedora.config
> [2]: https://github.com/nathanchance/llvm-kernel-testing/raw/refs/heads/main/configs/fedora/aarch64.config
> 
> Cheers,
> Nathan
> 
