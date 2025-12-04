Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B26C1E0E08;
	Thu,  4 Dec 2025 04:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764822151; cv=fail; b=fOLz39/XuKx4RJy5uKNMqY/kJn4EICNgccWrSPyh4WHsC5QQKUzFhQO4Zmbph8qp9rWg4mZgfVrEZz3VGRONtO7SE1xd2LNEKc9AnWWhj/foYK8KBrVjWSfjZMY02YyG1uWY9xqzUmm8S95WlKPd8jE/DkiGZJgGhJvovL9o9xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764822151; c=relaxed/simple;
	bh=VWYFlamQI+y27GhaePA3irnuFuYNPeBgjJFm8nhjdZI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hJFNFVnkSDEUHVDlTdoKmf5PeQr9FQEbS/gNCOi0faimmC+aNhnE5nXQmlVLtXdoYK1j2mjPch9r+CdoEkzMV91uMAMgTKrKczInOvKdseK4ar77dPz7c/4ATza+h+apYnoU/tSFvhkZgAUVhYn4gU46ViCxIpYAjg9tO9kjJDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ih23cd+7; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ih23cd+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764822150; x=1796358150;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VWYFlamQI+y27GhaePA3irnuFuYNPeBgjJFm8nhjdZI=;
  b=Ih23cd+71v+oENAeu1g9/GnxBDjJvHiyYf8w+7UBAXCwgdM3bvxj3OAV
   vlR8KUw3isRKWdKsJFPvcl2Iof/ErKSzR4nMogg8HnXxW/7Li1pxbcv+H
   mJZLLo/Jzj56x3Jj2xk0H6WhGvE2xjCJi3ZfMq06hUdlfMwGxaJLZXbNB
   +xVs1XIZq58xAIA74fj5ewfUvq4IB8NLSm7ChiI9dyThw78bqdDBdqy7m
   rEiY+q5vzImRHjtTieNpwR6rjnE45VUtQ6++re9AgZ5hiha4joR/W5jTB
   Cm0h0wS/p41feDDDijavJmt+k1J4F12cwSA+Rzxks+z2DWmMjntQDyvSr
   Q==;
X-CSE-ConnectionGUID: zbU//hNGQvuVgLClrvh1+w==
X-CSE-MsgGUID: 52P3NLTpQOumeNkTZLfb3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="70685661"
X-IronPort-AV: E=Sophos;i="6.20,247,1758610800"; 
   d="scan'208";a="70685661"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 20:22:29 -0800
X-CSE-ConnectionGUID: aVCCfi+TQs+LRwCR9UKmFQ==
X-CSE-MsgGUID: lbEoK+dtRbSC76Ho4ZvPrg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 20:22:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 20:22:27 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 3 Dec 2025 20:22:27 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Dec 2025 20:22:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pt3gORjLDhFCVfamFVvUnFqAyvkBIKnhfyMMVBvTdhDQvZ2XVlWghosMObG8CisDs/jVf/KhdX9HmzM1pmdEsk11HuGF9q0xG26mPgmp3yS52c9ErJMQFtnYAfI68iuGbFRybtklsPWsmjGhwSeCaO+wwdPYBlqgWZMqJVYRzqxi9CoROT4s/fzBjkJ8VcNVR6msijIAZ5+ttL1fT/TfBPREq8WKB/O7REahhk++1Fge2XPKDOudVjdB8k4jaWZfNjRe1pk3FPjtZC8w1qP+43AAtAeUt+3J71G7oz79CNzWmwqoEceHPGRO1qrGD+jqk7xf+Yz6FJZ3G9MOknxxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzcMG4e8TtqerqWpRkO1mJMVf+WielYj+rgki/oHDuQ=;
 b=Qu6g2v1C7B7ax0JYLUxOboLxRDSdcKrjh5aADI0DUo/t/vXiGn+6fkNLmDa0aWjZkUblk3D/YphNVhcBay3ksnZKk0uPQAiPGK7eTyC7t55tq/p0Q/3pbbs7vnZBd2eDwiGAQzl8Z5a/jHVYMbeStKqOFXvp4voIzciwJ1la/XrwpszJ4T2+KddM/HXVMo1CjKz2iIqBDfzQRltYxkEmDcZRr96csWzUkwCHfWAW84DiDa9Sa6Qmp2fwA+SFZ2qBrZ7KeSVB/cO3s0kfbNnWgCDmP00F3EhVr7A9VTH4+G/Gcvh/Uh0/4bYkmLScDQxXREYuBKU0u81MUIe5XSrbwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH8PR11MB8108.namprd11.prod.outlook.com (2603:10b6:510:257::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 04:22:25 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:22:25 +0000
Date: Wed, 3 Dec 2025 20:22:17 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v6 00/11] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aTEMeRzI0_zcT-S3@aschofie-mobl2.lan>
References: <20251114004021.1310661-1-rrichter@amd.com>
 <aReKmdOeHBBDWMuC@aschofie-mobl2.lan>
 <aRs4ILR8EEwnfOtQ@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRs4ILR8EEwnfOtQ@rric.localdomain>
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH8PR11MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0a5197-8c2d-4219-1b63-08de32ecba53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OqMJXwO3tKndY+x9M42KMI2OboUGkSD5jrT35vU+TwUyP+3/v0FaQvSqa20b?=
 =?us-ascii?Q?r6879tzuT5M6ixadozRLbPty8nvCvM7mSsf7UXbcUgvyfpndgZqyCsdmqw3l?=
 =?us-ascii?Q?Z9nHt9wp1YwyeuK3idnkmmxwyscrN+9VzmHTAAn7SAz0mqAaY403YlPK/8tK?=
 =?us-ascii?Q?7t1PElpCKnDscKV69tPoB6gBshscrYi+eJJcUwb4F2ksyC3RlaJmuRL2JrlM?=
 =?us-ascii?Q?Sgs6Ot2Lye2q/IEg7cAMZttIGGgGwmthujblWYDaYauZtcLCgVZ6sxpS8xUs?=
 =?us-ascii?Q?0xrxVw5WspkuHAjwDkV95klGmvzqDJyQ3yxEodc5zU9USWFpRNroTHYACceG?=
 =?us-ascii?Q?olE1jHc0XZH9LZ6WjFDPLMqSU2sQcEu8RIcYObwlLgzJ/kHkYZG6WYy1jTuN?=
 =?us-ascii?Q?3mKqGxDFJ770/C41urvG4UWKTwddxC5ZvhZeAMqBnX4QxGJsyMD/ihYLE8Tl?=
 =?us-ascii?Q?bkskbDQIQ2St6OWez6lF3VavPCGHnKKWxGG1U7Bzm++TnD63Qwto2ZUTzPB/?=
 =?us-ascii?Q?NU7uAY52tIEe1lpUJdjxjyBTO/0GJkQRs0DIi5GonblOx8cn0tK4SQ2J11kV?=
 =?us-ascii?Q?IU26lYn0blVtrGg063F3l+xw+yl8b8fXYhq3DBm0UIbMV9wFYFE+JxTEFtsM?=
 =?us-ascii?Q?BDv9Vl2iwXXZJhe64wX8ywgmoxoiZ8wyeShj+1dBay5oyxJrqlvTD7hEJHQO?=
 =?us-ascii?Q?F1adxASgmwnRAGhKQmcxBMz+jO5klFaUCroebr4gJqFoJ60++LJcR/IfUnTE?=
 =?us-ascii?Q?kZgbXG66i5oC3Tkbpc5H14QlaJW4ih8obqcL/BbG6xska4msFiLsXvo7I4r/?=
 =?us-ascii?Q?5z49SV6G62GMdUSe5t3nG1K2+jrjxrdONZRfJXnVhHirX5YTU5ozTkLK1XcB?=
 =?us-ascii?Q?Lw3eT65loCrF9YwSp+kdk3d24OGigQ1uKmhVzVxOzqyEOM6TvoEUUFr0k0yJ?=
 =?us-ascii?Q?gYgr4jHg5kE5wPFHV3vjwbsfEYAO3XmORWAYjdjAgOd6Zs4yP8Oe6G2jRARO?=
 =?us-ascii?Q?+rs2dYeZZ08H5eU+/5A+g6HdToZKiu8KE1hICAEFmfeAMYZW7fNOX1kfIvSd?=
 =?us-ascii?Q?eiAUUbDo6v0wphu8uVMpaq0nYep4nxZ73jp1f+cjiUh7MewaJNTe4PkJF1oG?=
 =?us-ascii?Q?tLRrVlkjfCXk3eNU7RmZTfIHCTT7EHKJ1I/ya8ybhvAOSnjS5qAMISNNDFI7?=
 =?us-ascii?Q?koZdOngRP4z5igPS6/WKw2DShBghgHNUAXNgzeExX+yS5oY51zwjKno8qDha?=
 =?us-ascii?Q?oMe8fU+IZbdicaNhdmNsBGQLaErlNUmoa3TR1jOJEv+rUd+M/zkikuz/PnWp?=
 =?us-ascii?Q?4QQ06NXzsadm3TUkF9qKTf1yLCGR1KrjoIvdpY/fTrfIuDZnyUgdSirWy2Fc?=
 =?us-ascii?Q?3gM7NPmePWCX/NX6qCjH6+gn5h+YKG803cAQZLql4t5QKGXbqeRx2kf3T3zC?=
 =?us-ascii?Q?GHPdJmA+gg/qP6/n4mL3iLUF/5ojnJ4b?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pPpO0ZeaeP8EDKJTPWk6r9DW3WdA3D/t+GPTUCRNVeyj74tgVUhYJzQ94M4N?=
 =?us-ascii?Q?ADO+d43a/iefhUXR6abG6NnNx15xfJokUfdLoXC+KwDImzJYX8AUccvyf5XM?=
 =?us-ascii?Q?65jO+ZcR4Iods4vrcaAjEzPcGAWNnqgdBiQ1OrhbaajXsvTG9SkElHQQ1X2g?=
 =?us-ascii?Q?KTII9T0WK56fdvome19PkfDjPREHytpD6G2mxE1zJWpO26JZBkdSKwzO9FBJ?=
 =?us-ascii?Q?BAs1fDV6djm0BOv8JNeW8coikNBjwMryAl7MUsvd0b4PqTenU9MNd2kcJMaU?=
 =?us-ascii?Q?m+7IkxEspeC5GdD4mMZKU/WPceboDoCQzmT1LeZfUiA4f7AUB2I7D9deWllY?=
 =?us-ascii?Q?QQYNOVa1SHE8bj6m3210p++vWjuAKfrlpTdjzrHP4364NQ6ifqTgRzmEAC5Q?=
 =?us-ascii?Q?6bVcrRowvdozEPXSSN6dgm2mmW5gJ0W5X9P7MD1pBLGNpt84Fm8Y7vPsB/1s?=
 =?us-ascii?Q?xrOimyRYuih99RMVm6D7n+aifWlpKffFKZ4ar+a1af4kjdhidIQsRFTzaVe+?=
 =?us-ascii?Q?WgWV86bVLbhjSxmI8gkf12XlzWlTf5xHmDIO11/CSrLGnOl5qYY2zZc0FhtM?=
 =?us-ascii?Q?vojwIJ+132eTmgz9ykQkjhkC/aSwUUjfeM3EIuGLgE4uUvdo4FzTcDcvGMfJ?=
 =?us-ascii?Q?/GqzjbM6xW9UU58kJC/aNidQc72SIqX5oBisK5kOKrnhth3v+5rScDL2pomY?=
 =?us-ascii?Q?0w/ihEvl/ujYGz6gL9LLY3fA3zLpH/8hp/eb/3KEIvHbuIc05wdAi/uS5DZt?=
 =?us-ascii?Q?zwF6Na2zBsEJdMvDIw+ddyQl5eqpFmmCjnxyS6Mwm7aIcTgKZEBGprK9M5wr?=
 =?us-ascii?Q?vBv8HmcKi+8fvzBAtqMXJ3gyFlbvKBoVrwdweftZL3vX5PJSBFE0APeW6nrN?=
 =?us-ascii?Q?zzBm97gdikGlOOkl5CzWvjBPlOwS+uTXzdwpdayeeHSByXiczrtq/1yngT/w?=
 =?us-ascii?Q?j6Nu4kHeED1ulgAPAy7Vb+ACChK881bavKFSG/JNVhqTUyXz+u0ZXKYJP2xR?=
 =?us-ascii?Q?lwyO7coRvLmGgiNdf9STOfwEqGmO816g/Gp1MR+576lv9CQSLz0tcTPphZlc?=
 =?us-ascii?Q?yj+mJS+f/JRes1NvGxXrXEWr19v674+gHJGi7pnhJGHyssrWCoyQZrQ+k8RL?=
 =?us-ascii?Q?DWR+is6vedj3wxs3QSE4PiXORX8UfQRZ1bvlsGgmpExE9KwCN1Dcmd92ex5r?=
 =?us-ascii?Q?OMw9cBagkLDmbJctebKuvMtTePThZHsq7kU4mBkfzEK/FP/z/eErJg2HVffm?=
 =?us-ascii?Q?e1spFgkvuhdXkE1kUalePgqqS5X9Hv74CdJzSm6cZ71fOI7Scgy/qtS3G01s?=
 =?us-ascii?Q?4igNF+ivb4qG+5UfGrNGPngianp/VYukslE6FRDeO6Pow/V3vnqgJxgLyL+T?=
 =?us-ascii?Q?dLLBLbOs4vD69MY//tRHUw/BWjMqppkuSxnU5DbYxwcNLTF3j8BYzfE/BYuC?=
 =?us-ascii?Q?LVsuPp8OvU2qLyKOHcg7hGGRwT83p+YrSJpjSkQY99e3Uw/E4Xhrkncor4Ut?=
 =?us-ascii?Q?tU/Qojc9hV04XAQ/RXlTWOxkWtC+MN7iu11hoCVOxeNr+Z198CmoYN9MnQMJ?=
 =?us-ascii?Q?yH88686ho7+TzbjoPNFdxqhI9Gqph+jepzrH9i/rAa1fLQV5aR1bdn0EjHJo?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0a5197-8c2d-4219-1b63-08de32ecba53
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:22:25.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHCvfJOifEUTAkBWWsyyzoEIqrr2K/kc44n0zFyd2GI6eZ7hWWwIONy2A9czGLFrWm4iHIg0fgUxsODjFkLcZQIfLrXVxM4+ME0YBKR5PfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8108
X-OriginatorOrg: intel.com

On Mon, Nov 17, 2025 at 03:58:40PM +0100, Robert Richter wrote:
> On 14.11.25 12:01:29, Alison Schofield wrote:
> 
> > Does this work 'as is', no changes required, to support DPA->SPA
> > (used in CXL Events) or SPA->DPA (used in poison by region offset)?
> 
> The PRM handler could be used for to-SPA translations, but it might
> not fit well to other users such as profiling, tracing and error
> handling. Those users are executing in a critical path from a
> performance or stability point of view. Performing a firmware call
> could cause problems here. Since the to-DPA translation is missing
> too, a different approach to solve address translation might work
> better, such as examining the region parameters. The kernel's address
> translation library could possibly be extended and used too. That
> needs to be figured out. Also, my main focus for the patches is region
> enablement.

I see a dpa-to-spa prm routine. I don't know enough about the cost of
using it to say it's not worth using for CXl trace events that want
to report a SPA (from a DPA).

If we cannot trust what the address translation code will emit in
this case, forcing it to ULLONG_MAX would be safest.

-- Alison


> 
> Thanks,
> 
> -Robert
