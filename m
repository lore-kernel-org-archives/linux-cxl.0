Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5441E72621
	for <linux-cxl@vger.kernel.org>; Mon, 30 Jun 2025 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312227; cv=fail; b=cOhHkcVNOsPVpKM+dy1JzQLWbN8m8ThVo+Pd5z/uVWlY87LqsahvmJ0uZIpFGRt5ahVF8mrs++No2uDx2D1F7f7WigAm+5bz+XgupQxQoIBicD3t896JczHz6cUMVi4umz1Ylc3qyuLrrJwMvMw8BE0FZA1uQvm5pRxupvxXalE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312227; c=relaxed/simple;
	bh=spCUmhwhOuZKqnhZ1K0fjO+jkWk/GeNBk6ansJB4YTs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OxBK+Qq9mtEvcR973a6t9y0L2gxm6lrn4pG6zi5BRxQeX+wDkW6vBqNwDhRq6OKtqgfyjIzzS8dPiaFle0KX6dmJrCVcgyJJmfybJxrpZvoYJcqOSdAdhqWtuLjmqiDSfzemmJgk2kQas8jycZ2cdU50Fb1wCzrfQXYWFoIoDQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YabuwZnR; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YabuwZnR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751312225; x=1782848225;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=spCUmhwhOuZKqnhZ1K0fjO+jkWk/GeNBk6ansJB4YTs=;
  b=YabuwZnRS5OEcauPlCAiekINcYkLFbGbXCdcKIh4HEoEC3BJHmAlT/KI
   zqmvlIte0t6H8tgj83gQmI4VXOVUbR401+DXtPwwwN/bv2vqo5pytso2O
   L4kalQw6AN3gQ9YG6xaavA6X4L69tPADyUxidHkVLlN+O0WT7YPbC81JL
   0duLGDNfn+kFee3NGkmMFV+lfZMWUIMdqS6rigNBGTuTwvZqYZj9F6T/l
   vFZgyp/BFXMs4ZXNUcPiY0XFvdtkOi6ClXMYjQHVfONG4kX95HHIZui9L
   tBqsTEzrlUHmBu2Y5Doe1zZTfucKH9r1XNf4LY9n93QOdn2/E/9pfaLyd
   Q==;
X-CSE-ConnectionGUID: 2aAjr40GRGeAKdiO0in/Tw==
X-CSE-MsgGUID: 9uxwn7UmRwKG93tCKvUKNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53659947"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="53659947"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 12:37:04 -0700
X-CSE-ConnectionGUID: b67TvrA9SKSDZ3HwLO4L5Q==
X-CSE-MsgGUID: 3JAoXaoERFO4pYEK6cSYsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="158089923"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 12:37:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 12:37:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 12:37:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.75) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 12:37:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmsc7EkAXxOJAKl21IhwN7j1CUr1KQYyCOrlz1yRk202nse5Z2iiMzUPCsF+cGrNaEbBiBxSk0Vt3+o3gFVyZL8iDPU0FMyS4MTde+XiIUm68H4a35fJGFmhn0mLS2h2p4XHuh2iBlNP7uuBPa1ppKuxpbF4PdqF2kALYQ3DwoKAXNI8gf7vBhSoRxG7rDzknkA1DH+X9g8IBAh7my0KmWo3N/kKcGAY2A/x/LVSelwUnibtpUDPHeToRgpdA9WqA1MYWnxbxddBTdztGezb0Vg4QJAnkATOMbWtE8PuVTrOtqwod3ijcaiCFz6ytV+q5An9Kpz+oDeOVvLpS2o6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZ/83FK8a5m8O48DKYX5TqIv+D8oadACBP1wR6Tnd18=;
 b=N4nIFsJdynrOgv8o0ksE0dkwgasOXuYNUlD0vLa6fcARF+76+W9WEyUn9ZnkgllfTt2HwxOZ4+a8XMBw95SSE6JQqvPF2MNkF3YL9+7Vi65kGvTEtiH7YJpMQluba/pyQo1VDWhIVO5ZYPZ6J33ZXLXN+2Xe37EDoy8upEHMzIyRePt22L8v7khlLy5XmAXsYtDnkU2QP80sKQmCbVPOEQFCzrVBRRc15Vc3TjvI7x0mEeR9kuiNVsKz1Ven2D9vXBY6DB4+m/fA75UCTAbl4LL2+FMK1mlOyoY8dXdpYSRaz1O29lpywv22ZpCGVKENY1vBTTbCDcXWGEWGoS36hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA0PR11MB7933.namprd11.prod.outlook.com (2603:10b6:208:407::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 30 Jun
 2025 19:37:00 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Mon, 30 Jun 2025
 19:37:00 +0000
Date: Mon, 30 Jun 2025 12:36:57 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/core: Add locked variants of the poison inject
 and clear funcs
Message-ID: <aGLnWWy-DoiRcBmT@aschofie-mobl2.lan>
References: <cover.1750725512.git.alison.schofield@intel.com>
 <71f51bcc7d335c9f558441bb68f05f546230696a.1750725512.git.alison.schofield@intel.com>
 <20250624143822.00003256@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250624143822.00003256@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA0PR11MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 8906e939-dffa-482b-4e2b-08ddb80d7b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Ox7iU6AyOT14AbSOKsoqsGewcUPcyzFeyKUR90A5YbsOrYB2FD3P4DzgAdw?=
 =?us-ascii?Q?0425edWMqYMQW7KAYVXjBWnAszV/Xq0zVIm5Hy6ucx2PYmQJ8DxsQiUvID4z?=
 =?us-ascii?Q?tESZMFTIIZWcZSAVRtCvBkB8LS/AAi3KsJUeOp39pvFaE293aLW2ENBSn2/f?=
 =?us-ascii?Q?FrKKr3AIu1YCt1Aa+eNq0XOLiI6xkb0Jyo9Ced3bnkKss4QwhYHMfaE7EhFP?=
 =?us-ascii?Q?+ix+chPx/+oeqLBCRVyOmv5DCc7W6YodvpY8Q6rLYZ0Z+mkgoMvuWJ35Xr0v?=
 =?us-ascii?Q?WBlJK41rSPTWB36ZC+n3gMfShKgHkdybyM1CpLE8RW6x3nm+qtl48qIhdtdo?=
 =?us-ascii?Q?Gi/jRcstbaLTW+Gm6A0U4yNOijqaLNyTuN6v3oeG4X0AejMyn/3r7xj2d1Fs?=
 =?us-ascii?Q?hTH1RmmL+Geo6G7+baEXCzTZ7LigQgVS3xH8OPJMlFkvXmxK9v3h5/iefrXZ?=
 =?us-ascii?Q?p1aLv3ngWgla5nDB0sa87GtmK/vRDnW0pQmA03NqgVENVUayymY8F9lWLwE8?=
 =?us-ascii?Q?W7w8ZlZ7zsSXa3t6HKLhB4QsoaEZfZHSVlTz7j78QPIsp7tfNtNRwXsvCv8T?=
 =?us-ascii?Q?mrtyIe1xVfn02s8lujXjYibCxVkhcVHoySNEdiX2D0a8/5aCoTO3IaihKY2W?=
 =?us-ascii?Q?AzhGWaiP/5lSGbKTWdaa3IC/ajxpPzEmqcdSlmmgyJIav59AOKGxeKEewEHh?=
 =?us-ascii?Q?1ooi8pmHzY9M8Kdwl4FFdK7Hx56SHFzaswjRusuFSKpNo8h9sYX/sxZDi1+i?=
 =?us-ascii?Q?zTYAGdUepIQ+UM5MmOziOI5dzGEMwO/1B9Fs01VxM1yfBwk31/IMOUDq9mWo?=
 =?us-ascii?Q?pmR3WwM88Bh29WQIp89IX1u7YLnipwdLfuqkkPBuPFNRbxvfc9nZleaP022I?=
 =?us-ascii?Q?j7t16pFpfl5phq/4nMj4/CT/R4VhdVa2BYR3FDVsG9qczCZmQPszTtPyk7F+?=
 =?us-ascii?Q?SfCPRnVlpoHQL1ln7yUPbj714h/Y4a+AtQGLpSgCL8k2lDtZMYSxAjgvbyq3?=
 =?us-ascii?Q?p2v+HLsUqudLx9vl4t1p+OiycpZLjHo3mmowQfsZFhoRBGOV3+BD3wzDn0Et?=
 =?us-ascii?Q?3JxhEpKQAAMGl9s61JPfRxyeKC0QD4+PIbz9s3VRjhQCBzaw/SpaK0HaY/BX?=
 =?us-ascii?Q?5CcBGW6w9tGSNIofur45uKo8FdM+5RH1GmI1917Z+slUXbttlJPz1X+HGalm?=
 =?us-ascii?Q?eha5jNhsafJCNPtQnH53K0ZerjMsxbXX79AydRL/W6DkCy9IMsUUQQycLXsx?=
 =?us-ascii?Q?dH3NXiQdQcRdJxdQk9WZ94I04yvOal/Dd1yNohncttyoGLxKtlXLCemjsn6N?=
 =?us-ascii?Q?wvgMW4oG8kUkYwSwPc394FlLr4wE6/gmaZOp3Cr5lMJitYAHlENwQ7sz527G?=
 =?us-ascii?Q?8tJMt/piNivzzH5onk20PSsaflDoVmFzU9Hajiza1hvRxJU4If7k8ukkF84S?=
 =?us-ascii?Q?OYRjRVs/6fw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a9alPRLTJl8RKlsO/i5vfjA+o2usH2lYozlCuoTT6mmf7wTS1Ccx4sk0bv9I?=
 =?us-ascii?Q?98kN1k7YbntKm5Ibmu9+7rk6gFcUc2f/ckAEi8uPWMZFk26GTAm5q7BHc/Dw?=
 =?us-ascii?Q?156MbU2wspqO6BXmH1PpDhqh6iDLyyVqJJK8gnSaGUWWgzwm7fNF64+M+vQ/?=
 =?us-ascii?Q?wAxnYphN7o+J4rjoBbF3Bq5jRUEMGwmiCDpTof3x+hqF70CzAt/LTcBvTXbJ?=
 =?us-ascii?Q?cbisQFTSxrNeuHdIg2cWg05hBOChTr0ailOowx8yi7Gvk/6d7drRwQVMi1iR?=
 =?us-ascii?Q?ODXB52/uS5JY+vjqHdYUnmTm8Y4A9LPhJmrsHPL0qnnECes6lM7JuJ65VBtH?=
 =?us-ascii?Q?LyBYThhllLT42K/zTOCEAjDjc2gYMcvaZUqNo3s15Ed2O0yeqW1FMs++GNp0?=
 =?us-ascii?Q?FNv3Z32B+k3iXrrG4B0SUpl6tUcUoXX7f0Em2Q6J9DbYJZyyR9S3TY/9AxkO?=
 =?us-ascii?Q?6HHTth83UtGOlmHDPe1SDCECgy0Ft/lyYJQdmQItX1w+ZoX9QWZp1gocS6wN?=
 =?us-ascii?Q?fZJYIz0BdwN7eW66UPcDFDmAPoqoH8/PaFESts/r6VEBCPU9K+6/fS16fAnM?=
 =?us-ascii?Q?o3gDL9c9OMaB5nLtF34RghdgBVIeJCxj3ZHEoDIxVCvIGHydrFtebOp6J5Yt?=
 =?us-ascii?Q?UyajR2f3P3MR223jNO+eBKKf1A1Y5U7P3Pec23JMoKiIZYrARn/NuIRn5yoY?=
 =?us-ascii?Q?Av6W73SOTV/n4ERoEhEleZ4b9Iq2gjySX4TvLl+YBEWU1S11wzwCDZDlfyZ0?=
 =?us-ascii?Q?GLVsOo+hQtWRO1mvohxOaAd8phXUIms7iK4eo7Etruyp/cqQZS4cGhm06LVy?=
 =?us-ascii?Q?/x8e3as479prX+XOQQjEzOdufZhj+8gtty9FLY/T3+FUCTzPgJb8hKcj5qb7?=
 =?us-ascii?Q?rIhrmq54PbD66ApXcr7InmCIJa7WHaQsEjFupPYE3Q93RoRHc/LHhAMh71+8?=
 =?us-ascii?Q?DnhqhUDygYOdP9uWv5kZEkGkKZl8NpWsHYkJIB2cVaE/Bb+bNEqjUrdbVLsD?=
 =?us-ascii?Q?2yHxRC2uhd5qDpKy6QWYORKHTnA7sOBBqGolY0qHProVghkROItVzDZN7+Sh?=
 =?us-ascii?Q?Q47Rr8IEWiAUIqn256pVnsVAQUzZ+K28BDkw7ZyNGCvkVKmFgZp7S99APzzg?=
 =?us-ascii?Q?sR7PRS4GG3BE5BiCG60z+Cm0N9KLsgmZuLXz/yl2CFtky+xvyid5pXRiw58n?=
 =?us-ascii?Q?P1B/E2eVwIc/kC71K7Rnoj+EthdyMHj43wIPHeUpJy5TA+6GvYysgCHF1EAz?=
 =?us-ascii?Q?wiI+ERjZ+hkfHbvUQAouUdBMEwv6eax+7bsxzjSiNlWYsTJmNa1DUHVk2wNq?=
 =?us-ascii?Q?FZx3IruKgKYArhTqPXIWBEuIKnQsuCSJqFcpXcFAPa4bOhAtnMEabn8WP8Rx?=
 =?us-ascii?Q?OqLkQ6CNbtRTB8OYeHleOAfXiwQLFliKYmuQ+EjV2m+9RVrxNfsbZ9h2gTyI?=
 =?us-ascii?Q?CTbF9CfL5WEG79+h1aIoB9rA4lK+OJTwFYLiuo1ydQPEb7YNGdw4Mpxy6rLb?=
 =?us-ascii?Q?WkO6FT4eoheEoMcF8rgINNmiMSS+EvobZr+8vkJCC2V+Z/P0OrK89VPvCGAA?=
 =?us-ascii?Q?oK4gX0r8rKLE23fPMH9vd0yGLlnBgu3hIEOWE651Fdj4oYuzFBhPki/B+IO/?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8906e939-dffa-482b-4e2b-08ddb80d7b84
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 19:37:00.5353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UU/O/V0pvWgfv+F/n6dSQjFE7p8Olmt/kGnI3ZL+Mcg7pBDQaHVS/+vcQ9GKtJEgKfhU5eQhjFBm/r95CR6lDiqaXTdM1lnNTlvGvPt4S3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7933
X-OriginatorOrg: intel.com

On Tue, Jun 24, 2025 at 02:38:22PM +0100, Jonathan Cameron wrote:
> On Mon, 23 Jun 2025 17:53:34 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The core functions that validate and send inject and clear commands
> > to the memdev devices require holding both the dpa_rwsem and the
> > region_rwsem.
> > 
> > In preparation for another caller of these functions that must hold
> > the locks upon entry, split the work into a locked and unlocked pair.
> > 
> > Consideration was given to moving the locking to both callers,
> > however, the existing caller is not in the core (mem.c) and cannot
> > access the locks.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> This will clash with Dan's ACQUIRE() set.  Up to Dave on how
> to handle that but my gut feeling is that if we want to queue much
> else this cycle and that we should ask for patches on top of the
> ACQUIRE() series.  The risk being that gets some later push back.
> 
> Ah well I'll apply the someone else's problem field.
> 
> Given reuse of these in patch 3 this looks sensible to me.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks Jonathan - but I'm going to omit your tag and ask you
to take a peek at v2, which I'm rebasing on for-6.17/cxl-acquire.
(I'm not pushing to get this queued for 6.17.)

