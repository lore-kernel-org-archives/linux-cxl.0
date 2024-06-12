Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA9C83A12
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227106; cv=fail; b=ff4K44Spt5fooqa26PFrayzMBpGw+7qBxjBcxrUtEOJ+zIJcq3IoUEM2QivdrYU6y1nGn6yRL3abWxDH0CYfG/FIeQ1YCEeLrilB6xFIzgAEHfba0ZxpMFvYu6lnoczhz8W9A7h4RdqGbUqETKbteYPmzyCMhpfv5irfTUpjlOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227106; c=relaxed/simple;
	bh=UT5lXKeLyZFUShHgYeBtykrsZ7ubxHYJqa5V9HAxud0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m3PVQIFeyEx6jID8lm4Tw5H0VTaaw/eJ0iZuH+kAFlgyMfupYagKpXo4So3bf15dOUBINjPYb56KzaeVN9Cng35SGuYPitTLL8si1V6SsS7bCVHjTip8ymICKEOnt2DA7Tb8+IIoZDoWCTr84d7GqCougy9tEvLP9Hy3cn5EUUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1nEORiW; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1nEORiW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718227104; x=1749763104;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UT5lXKeLyZFUShHgYeBtykrsZ7ubxHYJqa5V9HAxud0=;
  b=U1nEORiWfgw3Hd8AfHiKw9kYhBQ1aDW9JbcamPPGregYlpWysO4AL5tZ
   GkN1PlOVUBqu5qfG5YYCc+vygBZWzFpC/H9x+MiGQApMMBYT9pb4BNWlj
   mUXEWQZ6qt/Lb8gOA6R5jA2/7P4nBf3w8yUamaMe0v5ZA6A7SMiIPyxJF
   4Ledgta2AmxZknJEA4T0uyX5WMLB17xY3zTE4FslHYnm8xXB+N5LUp1hv
   v0D/OiK4pUNSMI5zDCnNtaDWe85+J69VdkP/DDpkSGukm+fOfQfy1ynPY
   lzwd8ZoHSfwNqDow7njaLDx4saRpVu4q0zU82ib5OIT/oz6tZpcnDzpf7
   Q==;
X-CSE-ConnectionGUID: OYeTAJrYTZuTJMm3MJ4xNw==
X-CSE-MsgGUID: 4mtUJ6+DQeSIWr4YoiaROw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15145004"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="15145004"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 14:18:23 -0700
X-CSE-ConnectionGUID: pFnrBTm2Shiz26DLGy1TLg==
X-CSE-MsgGUID: AEgzOXghS+S9B39gvwgVjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="45045111"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 14:18:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 14:18:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 14:18:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 14:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5YOWwc1FsFRhV9p0jEr6x0bkmhWLhlKn3Hq5LcHVvhhyBcI+czUZ6b4QJW7UMa5x5A+XihRWQsUzVlW0fpwllcEja4XJqWkZgbgHjvh8cO3AVUCZLzNkZiWZzHouxDYREdDnmvt3dNP5uL78ebN0eu6Lj/jQaG4rwZHrfnnpzmY5vz2IvUOsUCb0Spfasn62TYMPnHsJ9Xl15mh8hHcmbLMkLKx0ainWIwQAoDR1KKFPCOERuUQ6BYWxOyEBPrGfQQ1qgp/Xrul0Q44cHrmE7uUQsua1aIaiksYOyfGYsxUDin/RMn2hKP4oLDrkQdunq+q+67/+I/bqr0aGEnO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tliFPYaedxcqPrn7I5lpyK3Snqbm+EAn8rGEmMEwWA=;
 b=g4H5f+1X4izwElWSCi0mnFj45evS/550gmqCXbJjB8NsXq0sm4nFZX0XObw7OF7OPjGLBR0X5ZnbJG90XpxfnDFc3taCIUAxdFG8ow2lMMT5JOrf6ZQsI5r9l5+/h0SnJEIjbBnueO8c6EgkhBpvOVXE6CrjjPpaAGGVd4+9fxQYO67lfjfCuc5MPlDV3GAS15oHnc34EJPOMRHQPqPunbr/WyBS2NTU477XTwe+l8tOH4BnnbViZHaR2P9/VzMuYh0kznFElhrw/3M+UFfBEEtb9k2bRwOmnFIHVXHeOE2YY7BDbzEXnVhOYX504am26Krr7qFfw//e+u8D8CEvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7955.namprd11.prod.outlook.com (2603:10b6:208:3dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 21:18:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Wed, 12 Jun 2024
 21:18:20 +0000
Date: Wed, 12 Jun 2024 14:18:17 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Christoph Hellwig <hch@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
Subject: Re: [RFC PATCH 01/13] cxl: move header files for absolute references
Message-ID: <666a1099c94e6_1fcf294e9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-2-alucerop@amd.com>
 <666923ba32ac7_3101294dc@dwillia2-xfh.jf.intel.com.notmuch>
 <ZmkkaOTUFuzIr2cG@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZmkkaOTUFuzIr2cG@infradead.org>
X-ClientProxiedBy: MW4PR04CA0173.namprd04.prod.outlook.com
 (2603:10b6:303:85::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: a62a507c-cfc2-49d7-e4e7-08dc8b252f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h3howN/RWSs/uyIjGHqs8lcrwVbiZ8Xfdot1ySYuXuWLstwe9XjrmSX/MT9v?=
 =?us-ascii?Q?+KtZtjFfZhPn8+YHfIjovSwXmeKorFRqayu+j/V8tcuQ8vdNpI+eEtlPvS5C?=
 =?us-ascii?Q?saQNOQ86UL1BtlDnRfIqWu/kclekR+Jt8ztwKVPtl4SJDtnqKo1IyB2kzHsl?=
 =?us-ascii?Q?4PNJffJp1n4lBXWD9MU+77m/h3mTkmCNlzxySug9Gnkx0DmJCo7NoQsDWOsF?=
 =?us-ascii?Q?VWUp+MKndimOvT0Gc3rFSiMCuzdR6ipM/30G22Fv77vR3Ko7gWtXt+E6zDqd?=
 =?us-ascii?Q?ZhZ5zgT5hLG+QjwsSCPJyAsZNZJBgtY6TqEUK4eOrwRNBbDMxyEtColoQdMJ?=
 =?us-ascii?Q?RyiUR3JpSJEYLB9tNRUCmZ2sXIzARwfQEpsqFrrTYoIY67NBoTBSVNfYUli4?=
 =?us-ascii?Q?tCOBqCY/gF7qMz61BxANSf6jsYkLzD6iKTthpMoG12K8cxon5U18IQu+LpIU?=
 =?us-ascii?Q?iy+3ZuoXwZE7hOXJ49lZuF1JAa4YxOBEHbCruPdGzGoqRRTKq7lcpOClHROO?=
 =?us-ascii?Q?gLOjd+O47zxuUqTYyuxbcJWfiDl/bNXHP9fl9d6M3Z+vocs2abtUfiQ29qB+?=
 =?us-ascii?Q?3mpCHpmSDRkrLgdx0S9poba+sSljt2KvtGn2301GJAasbVt//vY6UG1mDCiJ?=
 =?us-ascii?Q?jlUea6Pv1HRQwSIi7dNvg1inewM8IkT/HDM1iUmpv+m+YrBoU5TrLXSXL9p1?=
 =?us-ascii?Q?gwkGanpV7Q3Bb7b/BnZayhgUDorzgYyzVNQX5j+xpjzqVQIr8vqEDQgXFggI?=
 =?us-ascii?Q?gzvecwVDgGRAukp65K7goAGmzamDEm2akTjcChsAuL7bNSA2HxniBqSMbNu1?=
 =?us-ascii?Q?tR8ux+L6xkX/ZuKiTGPEeg2jxcsOecBUfVDyN5TegCUxYaz58TyZdCBe2JpV?=
 =?us-ascii?Q?oxrHJAeWO90f28tTb4Wt47OQBsNf73vK0tL0dH0S+6fPeihCTe1f3QdsvOPJ?=
 =?us-ascii?Q?HyLAjCk3BGuPEhiGb94OScXZ8nifejEe7insjogC6ymDap0jd8R1R1HHrRXq?=
 =?us-ascii?Q?OiJDO2Ef2XujSyyFc/qN/cPpjghy2Rd7IL1nHIZdrzf6fmue1ITLNenSO9nI?=
 =?us-ascii?Q?pUa2XZWg/LXQXoZO54rd+y/W2w5go+Yp8DaDCqNqeFC1MowF20KSFGkE5zPQ?=
 =?us-ascii?Q?fLzE7HURskzAPe5upnj+FkBzjw1YPnvICFGgtzbQtgQjKij/oZamq3j4y/Du?=
 =?us-ascii?Q?BHh17RTjguynK0qmfoaByRFHMXXQ61sJ+V9SUih+fJ0nODhI/eCaW8uRULOu?=
 =?us-ascii?Q?2jfeWNYVtpOtBFJz0x7OC+0Jm+MXODtxqTWlR/FkP8N8mI9FbTuebSJSnfOw?=
 =?us-ascii?Q?OBWcS2NGRyrvZfY4XfqfBOR/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?usfxa/emU352nz+QKjv6GRbPhWBrSHIxlg+UIzwsjhUVt00VjK4GDbEiiM3y?=
 =?us-ascii?Q?ocWMDcIorQp2UiOm81b0ObkCEw+6kMDK0+YNiOSEBFHkV9XxgYmtuRh2NKrw?=
 =?us-ascii?Q?0mNI02axmWHcuy4TJE2opjocn18OfZQ/z481Mudu7AV3ALlqgCaJnHgXweYC?=
 =?us-ascii?Q?jrBZVrJVZT2Bw+fNfBSo6auf9LCypAvQkBlyPiSTXWmZTLIVLaPpZ0JNKYRY?=
 =?us-ascii?Q?4UExkNubRzTep0PioLGgN4m4ZX4Gxw4Q5EhCyTMzWgq/tKoLC/Ax4u70jsKh?=
 =?us-ascii?Q?1Ns1RPDhy/cwKeVt9RjAz+NK+IgjfxOX6Wi8/yaWOdQiacrD5n+cRMO5ba9U?=
 =?us-ascii?Q?XpY9OHqFb82Q+B37Sh/tGhf486Z992AkvrEe4Ay2Hyzdo4zODq1ZBPrTvthS?=
 =?us-ascii?Q?UPurZ1NVe7egblboJ2aTAIEx5bCS/mulnLJVOHM58WzvwO/L6S8+tabp1p/c?=
 =?us-ascii?Q?u9MNxzEfu4R7iUSGWPpPdi4xWzEon6ftTNdCtFWIPYnwlLOT8JBCXxPYEbWg?=
 =?us-ascii?Q?cIYL1IV16J6CXG1diH9zEd/ftD+F+EuNNOXof0YZjwzgQ0Kz8N9O6sqe1ldn?=
 =?us-ascii?Q?FzCR+ER+w9XW5rr0935JGXXzQgqBIXWWkPNS9Ql/KTkHedS2If6UZ1tocdgm?=
 =?us-ascii?Q?jb+LW8W0r788bJYfMQ2fceRiCcUpJuCio3pm5kKeVYvA149UE1crkEu4V4y6?=
 =?us-ascii?Q?TsDX/9WUR7Lko5Zseexg/pd2NJ0BTJWWD3DTJdKPXdDpswWMkMfho5j31ALn?=
 =?us-ascii?Q?GPcp2BnULbuhZP2LPvxNJo920Sy92W/qcZtmIVn7HiTjXOnOji2fVdv7tW6R?=
 =?us-ascii?Q?wXX3u62EuFDGunDByD+uGtnxr5ZUtHwernD0GdFEQJ+Ameavjzxcf39fQ1d8?=
 =?us-ascii?Q?IdS4V5RDP4ns/MFj9uwZUBLm+CdErW6MalT3/xJFJsCNsbZNx5DQMLXs6W7B?=
 =?us-ascii?Q?d1ERjxUdZNvnUDqYsBEqqfKYucORQyzmI852VuZ7J6Z1CGbhuFMLtf0teAKl?=
 =?us-ascii?Q?GCsxcgMgmHh/nzs6M/fUFoAy+BBlZCu5NhKjSpxtRffxh+zvVDNCnqa/Yp1c?=
 =?us-ascii?Q?D2oGzzHxnCTMzZ1tqpSYoYmVDalSRlaKIrSCQSdhhwN6IroitowDcwXNuJhL?=
 =?us-ascii?Q?JMD1thE9yNVQkEE7FAgnxhJZO/S6lIWVnB8q2Q5Yi4DiB5Onb4zsC7zEUWJ2?=
 =?us-ascii?Q?0FMREu/i5goLJALOOYxQiNCHAJ3r3ItWN2vLsdfSGZEKATw0WNQIwzvAu1mp?=
 =?us-ascii?Q?AmrUmaC2K42OaH3n2hCohkPVFXm1v9+GzNGaaRp8b414W82lsRoWl8oRNVtV?=
 =?us-ascii?Q?xYHQqgx0ApPqTDZtd+yOMcRfPQHr0zvNhJQa0Cn4b2UqilJ1yH+YiJbR7u6G?=
 =?us-ascii?Q?UW3xszR9XRu76MsPFpg9t6JEzGyRraOnuQKNRR83T/K1aaN11+UqXZ8AifOn?=
 =?us-ascii?Q?9jd+RmEfkkkMjundNomCLJV2xX7DoZv62sO/Gtoiok43U+3IPxMDCF74byQR?=
 =?us-ascii?Q?qyRk935+2/Z1J5buWFFfNWS7MvkJtOsEktJ7UhMHDKZA1UDJfYyIkevD1UYL?=
 =?us-ascii?Q?FGf1k2evhv1q5RuiocYPFn4KUk3Bo64lIJySY8v57z+TbDLbZdoxCbTy1tuq?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a62a507c-cfc2-49d7-e4e7-08dc8b252f11
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 21:18:20.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHchIyBkZ1dCJ47tU+JBSadWWJmjaKuuHn8UjwUgf6/+knpnUCQrQlkxo8cDKDaRawEU/jcmPBMqWTvY6Aoc3++5rI+yssrq8eTkncRwH3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7955
X-OriginatorOrg: intel.com

Christoph Hellwig wrote:
> On Tue, Jun 11, 2024 at 09:27:38PM -0700, Dan Williams wrote:
> > alucerop@ wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > CXL Type 2 devices imply specific vendor drivers binding to those
> > > devices instead of generic ones offered by CXL core like the PCI driver.
> 
> No, it absolutelt does not.  There is no such thing as a vendor driver
> in Linux.
> 
> > So I don't like this approach, there are details that are private to the
> > CXL generic memory-expander use case, and some that are suitable for
> > CXL.mem and CXL.cache capabilities in other drivers. That distinct
> > subset should move to include/linux/. I.e. I want to see the incremental
> > conversion of what 3rd party drivers need compared to the generic
> > expander case, and consider when and where new shared infrastructure
> > needs to be refactored.
> 
> And I'd much rather keep all these drivers in drivers/cxl/ anyway so
> that we can keep a tight control over them.

Yeah, especially for the common pieces like CXL memory where the
endpoint driver is responsible for registering a 'struct cxl_memdev' and
the existing 'cxl_mem' driver just grows to accommodate device-memory
alongside host-only memory expansion.

For CXL accelerator use case that's where more specifics are needed
because CXL.cache operation gets entangled with IOMMU / DMA mapping
policy for ATS.
