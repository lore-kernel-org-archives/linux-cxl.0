Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5CF1C84CB;
	Thu,  9 Oct 2025 03:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759980884; cv=fail; b=h0rDvoQpqEbaGdEyW5uUiyqEgkjrp55mlMQBmfGphYhWVXenXejh+mzjD8zWd8hyeBzdfuTKSOrWW04GKWc6uu8eo1t7OxF3VVnoSrJuE5c2ncl6slPi89hIdPfqPRkaStAB17mOeqj9u4R6Mu8vy4XiiYHts74HjFnws43Bg0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759980884; c=relaxed/simple;
	bh=u4e3qWmtQLlsbRlb0CE6ek8E8EtBNkp2ACWi0VHjyNU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=csC9N0dFSo8e56beLIsycigLPYKLw9ZmB3twIB0arTxf6WTLErqgti3dOwEDYmOcX5AFDbAn+dd40eeUpOQS3smcPOOLEjOGaZg9ZbkpwXTDca+RDZ/NnV11fZ4txRohyjLAGvmmbkXl0+/CVnFh4+AOnqLjhUQ5A8ofNOJkf68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgRBsFbk; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgRBsFbk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759980884; x=1791516884;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u4e3qWmtQLlsbRlb0CE6ek8E8EtBNkp2ACWi0VHjyNU=;
  b=QgRBsFbkd6CLqJ1VdnTefyfBM1VMGfQk6GkcYkKoS5sDJLn6kk5xPbXX
   a/s6E3HLj0Hh0FVKt+x2Gdl9aRl5/bAwkehvf7se62mCFodK1iW6Cenn+
   VidIJYm2NHJKbGU/oj5ZvhFIrHz7r+e8DU6o9szxXmuYUBUEdtPZE8bGm
   jVz98HfDIDAH58I3GTv5yeLHbOYZoTlSqTd9hVFFKhQKRvj7s4MyLdO/m
   mlcZE8pkUVAGHEAGetQu8FofCX3MK9gwS/dUfZ0ozP5I83eRR2RQioZe/
   j5InuscOJmxeTYmNO01rt0cyn+ee8Oof4izoqb1ZQaiwYccCrAbWSYZD4
   g==;
X-CSE-ConnectionGUID: GsJu4X+uTLSDO70HTqAPUw==
X-CSE-MsgGUID: swI8kVkFR6uyNb4D3nnWDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="65829386"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="65829386"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 20:34:43 -0700
X-CSE-ConnectionGUID: GuYrROSoTMuaEDVmTvjVhA==
X-CSE-MsgGUID: cuc1EwO1QfaGTNneqLDn6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="181014488"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 20:34:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 20:34:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 20:34:41 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 20:34:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbVXxkQUKnOeEgf5PMohC0WmvsBsQuGRwFuXD1lqpjnDwgKf3bbKogdx2E9eGJQ1OqveArBZEXHU6hawMD/9N2E2bCQqiunwN5bQOZ17TKMpFSvQcMS3F34iKW2yw5vsli/6dmihW9FeAcHQ95DVUhPYLhHkcv8u39iC5lflJaSXN33UGv0t1gfugOPjX0Z/dRlDtrcPhbXhm2rLPjdGXXxG9i1uBMbv/sv0zMdH7++69k7K7cnIxeNd1w/qtw8lSNXKlTmpSUkpcwgVB3AZNB8/JT36apYfNTOUY3mDJnc512T/Vr+BL3jSJLEbegvwYnlWo3MPnqFdpMoIY1YgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aa8w+0C0mzF9ZZiPTxVdsXM35dQOeBt2dJ4o+RuExdE=;
 b=LUFEZ88L+Ot1FnVdr1BL3NBhPVXV6r/sey6RzF2LBq0wQddv36Eu3H5pRGA8oFwOhhBYUZZ/BFozFgsNsKFQgQXya+QGp1Xxl56GiGVk01BkWB/FdJu1HEfaUswVCP9nE1KIkJmt+3c1UkJT+RICfqMb20YNUZGab6Mn3A0E98UDRX7pMWfqm3oIFE00Vy3CwitG9khnmi4U0wW6JMuEfvGAKYOGeYebqjOLeelB3otJpHcCOQxOQDO7YVEDGjYIxHx4RjpA8IXrbhA/JoJ7k8LxZHvG8h+tvl4rezhg/ojuUevkvgFzzssetdGcf3V0IpX7fDxVjvbQDHCj5zjZ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA3PR11MB7526.namprd11.prod.outlook.com (2603:10b6:806:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 03:34:39 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9182.015; Thu, 9 Oct 2025
 03:34:38 +0000
Date: Wed, 8 Oct 2025 20:34:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, Robert Richter <rrichter@amd.com>, Cheatham Benjamin
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH 4/4 v5] cxl/test: Simulate an x86 Low Memory Hole for
 tests
Message-ID: <aOctSoq3BKJByF-7@aschofie-mobl2.lan>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
 <20251006155836.791418-5-fabio.m.de.francesco@linux.intel.com>
 <0c3f38f3-0d09-41cd-be4f-d6eb4ab41e6c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0c3f38f3-0d09-41cd-be4f-d6eb4ab41e6c@intel.com>
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA3PR11MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4d7ac7-e4d5-4123-8d16-08de06e4c66b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?euPEiF9rLfkFl9WA0as3+yV4+MnqncvJVvertS7T2xy7iXfyCuBe3RxsmzsX?=
 =?us-ascii?Q?q41jotDQ16xNQgxHRVDVCVvXIL/U5+Yv+MVR2gIg1EK6eUKfB4bKEmEvkoIO?=
 =?us-ascii?Q?NubLJy1NplLNYMH7VJsP7TEP+XOghqs8ogoFhRU1BVW4TyNHTWlrb6fRpOO+?=
 =?us-ascii?Q?GiY430K85DKx7BnK/KFighJ8IXA47phy5MFV6jSCmbZGX1PLhcEyUUJb+4hB?=
 =?us-ascii?Q?0Bdq2MnJFzOVcvGwkePAwawH8Y2OKtVlrr25G8OU1yTiQq3WQCfrwliOWRRd?=
 =?us-ascii?Q?zOA0ik4XbsdWKpNM6htG2BF74E2YOPMMsDFlcVdX2gWW45XESm80Y9U2fZRO?=
 =?us-ascii?Q?MCy2q54zujxsar7pyHkLNh7dET8nB1sU1EOG5eJmuek4hABfT55gnRYog6ip?=
 =?us-ascii?Q?vwrafFICERZlCWLXvSdDs6yvUVtB71v9Wwid2RTl4YPjiR+sa3hBQSqEK9tJ?=
 =?us-ascii?Q?5hJH3s7oSB3nr88zKCYLLpcsRDuNnRIm57NSNjw6lUd36VM07YzqjKv0VS/4?=
 =?us-ascii?Q?ZyUwgPUPDAwVGLy+Rr7QvU3XVLfkJ9QY5hk1hma0Jz/jFqumkm647/gjf4Nf?=
 =?us-ascii?Q?GMRhwgLxaB/qPd92cJlyz0RHGWI62yfqSDRAhG28VwtUBPpS3QAF3atJtcfw?=
 =?us-ascii?Q?cvdD59TUN3f1qCGqg6tv5mNPbIrv3qwGLlNFWJlK8eyLdCWsVrm4G4nwuQE5?=
 =?us-ascii?Q?ZSkbh9k/R0Yw/JR/al/rtX3hpKMH3BptIIgsP8P/6HERyzIoqo9zeQdSt4DX?=
 =?us-ascii?Q?i/vdHQShBbKnGiVT9U0e8/6rkbXumVLT1kXOtBckn6wF6vt50GvryOhBuIbZ?=
 =?us-ascii?Q?+3SGLAPVFNrRxWWcG1l7UxsF7+pGAyCAv1MtG8AdhhqJd+5/mwQPx/hzP8oP?=
 =?us-ascii?Q?yABNKj+/1HrHQYhhc3+OkEmOjvFKgQTPLZG2WAonkfUArj3w2qnUCKRbKVDV?=
 =?us-ascii?Q?DcZ52Fb16m4Zfo6LqcckIadKeawKQBBO4kXMSUpuA1u4MuIJj22F11wPMWWD?=
 =?us-ascii?Q?xXqaJgm1nvOZJ/6v+FuqjunyXGYQoDPZmKthR/G4QVRydgCFDqo7luWPv+8q?=
 =?us-ascii?Q?ZmNOjzuk3A/7vpDpaUSYz93PZGBNYNQcJFvAVyX4rf6Ys9tEDnm3M/Buw7Ji?=
 =?us-ascii?Q?ji3qOdGkqLAxPG0omIjVG446tUM9uSBCBACPXtdQtb2pmJqm3e/9yKhOtzPS?=
 =?us-ascii?Q?BVKpBmuOo/wcw67D3pM3EX88REVRz9jKn2S1IWvsVhkLuEzPNAg+BLsEvsCM?=
 =?us-ascii?Q?h2V5olIxHxMcxYrMjiQbiNiyRm9BevQkPUUhc1/OVVHORnnS3qQvsWTYpAik?=
 =?us-ascii?Q?z2KBlORQK5l6wqcxLOHXPHUO0tLrTRWXb2ztpahvL7hNLlt6OT4ltlCXrab/?=
 =?us-ascii?Q?e3TZQztNtkQ96/BFbMjhfdpu29eTCUdru+oizf9aDrjHYDfNqtizepGqmJhv?=
 =?us-ascii?Q?Cmn9yj+5qqU8F8GKEAhm3JyKDJ1UwINs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PKXuNyN9TIQY4Ybzs6xB9haX2UrWfCGHMw6Xnsgskx60NhUApC0EGkDf+vWk?=
 =?us-ascii?Q?HbMTQ/vW0lMldz4JzNTmg7v/ax4h1nI77C57PltsyZVZr7sip9i4phbw8yMy?=
 =?us-ascii?Q?a7V9ukkTgpTT/97Alc+J72QYUxLi9gztDiWM2fYyEskYuy6sIFZ5rch5fCRf?=
 =?us-ascii?Q?e6pqrWOALG6tMx0I+062OsjKBybLBv3maOZ/FvosmHR0enzMOQFB7ZZl8JnS?=
 =?us-ascii?Q?TBdfkipbpm3k+WDoIWZZ2upUvvhcfJPtMLIYcSJQQ5FNmpo7/dC8MD7Us0oB?=
 =?us-ascii?Q?gBaIiFKe6CxL8azrjkpdynBNVFN7uxf2WY99QY7zWXr2c/dVfkVGES5/gqf8?=
 =?us-ascii?Q?uem3D0/v+97zIhiW46Xd8PdQyUKnRNL6fmQoYBfXb7gJk+5C8HPQEDUzr0E/?=
 =?us-ascii?Q?eS7NydiMN+I4BD4DC6DKFYdXH3h0RFhMwdMhPkhJhC3Xtu3Lz9iHQiuCOUiX?=
 =?us-ascii?Q?f3tyfLBHazNYgQxA/e2GW6P/FxgKYYbCoDXgA5tE+VfDkHnbQiYtEJAT9fY8?=
 =?us-ascii?Q?7C18mHd6E94FKBnrLN8VAfIyZ/REcvxNKaqzaie0IuLVGN5Fs1lLXS0vbe/o?=
 =?us-ascii?Q?jbj9jRLq67JdQbbsj2U0CA9J6bynpau4a+AeFZQnGLRC6Ri8EOqD826YZtIZ?=
 =?us-ascii?Q?fcczd0veB7Bv2x7HsUdao/OPU9ECFNM6+kc1ND5dg7h4anY/ksiLDKrQAXwb?=
 =?us-ascii?Q?/1rZ0kFf5Hm5nmiIp4yOwQ3gAuio5r+4w/GLkuAaDGVJklqeX4Y/5roCSrRZ?=
 =?us-ascii?Q?RD1NFZeuWwstIrHusGI6ph9ZyLaeFGENjReaPd+LofZq3Z7V2J24eaRwoyAk?=
 =?us-ascii?Q?lRvBlNXwtZhNaTZoPgP+RqykgIi8gHTRxA974HXv63w97hKr4EFw0Z7PxwNl?=
 =?us-ascii?Q?lC/pTpMwEQVG9XUI2Cj83p6BQdoCpym7J0nJLncNBIcuKAhemoz+vtgk9+O+?=
 =?us-ascii?Q?9cI88rgiJBpv8zbwDUPVb3MbdiFGXMFupNnJ78Ail1mqurICT8FCk6scN0KY?=
 =?us-ascii?Q?WfcRZIBk7ZtGk3GUhIpQO9lnGgN4OtZJsc8OQKB7tiYia+n4jk6/RS4Hrpbw?=
 =?us-ascii?Q?FOP3pDXacnz0dkGJ3PU5K6hTRoo34+5JIXYFC1mfilMZqfnazjnEW/HoLq3Z?=
 =?us-ascii?Q?VC487Y51lCHf9nNsgyF3MIZZnkHlzfRJotEhwmWDfpXwQFjA1iIN4xSsW/Gd?=
 =?us-ascii?Q?rtkwNdhRQ9GQay3n+jHxezxyqe/saRqMJDkSr2oEfs1OILjARZLswPj0kteP?=
 =?us-ascii?Q?Bpr9jvpIjI38pvf7WghaH825EUQplKcL606pETVAsK7HkWsHYqGAWClO7lIt?=
 =?us-ascii?Q?O4Su3OWfEr8NYaRxHvey/7fEbs7aFsGY21FME5iDkPj21HKim4+5c2CqiEgW?=
 =?us-ascii?Q?VhEwgz8AOLZ5Raj7brnqvjL9BnGqAp8HJbvXcEH0qUMSHM9wCVEZa0A2vtjF?=
 =?us-ascii?Q?92TwmvN+Yg6pCCrbExncYZ2gRdqdE1Nmvm/5vtze/o49OUwcCOXzMjWCnkLi?=
 =?us-ascii?Q?P04rJ8PbutoOWOcVq+H6jXI2y3RLiAM+SmlKoSoMpdVWFBG9qn9H7p0dPSjB?=
 =?us-ascii?Q?Q1W91WTwoDGVTkClt8tDMyyEbc+9nTNgCq411UI1B7ZnUTamizFE4cZZkkgV?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4d7ac7-e4d5-4123-8d16-08de06e4c66b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:34:38.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQjRVLQd/Eq6PRfPlmRC29O8HUnc2y69UiWv7JSEqN+PRWjS/pviGKj6MdWpg+9EEc6gmpRFgwE+AdsLA+vi71MLaTylF055XXPxl/Av5hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7526
X-OriginatorOrg: intel.com

On Tue, Oct 07, 2025 at 01:37:29PM -0700, Dave Jiang wrote:
> 
snip
> 
> > diff --git a/drivers/cxl/core/platform_quirks.c b/drivers/cxl/core/platform_quirks.c
> > index 7e76e392b1ae..aecd376f2766 100644
> > --- a/drivers/cxl/core/platform_quirks.c
> > +++ b/drivers/cxl/core/platform_quirks.c
> > @@ -1,20 +1,23 @@
> > -// SPDX-License-Identifier: GPL-2.0-only
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Copyright(c) 2025 Intel Corporation. */
> 
> This change should've happened when the file was first introduced earlier.
> 
> DJ

It's also a checkpatch WARNING. Need to keep the // style.
> 
