Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3721A4AC;
	Fri, 25 Oct 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869274; cv=fail; b=ID/6DPtH5OAKBEzq5QaxQF00XTvZV/hlSYITbjcwKVf2nJCFcaz1o4ZLTjELd5qYryg9RsHXmFrz5qCJerSJzkLBnvz9Mv9R3w4hFppl4yg681XcIo0UwgMXf4orEH4G4JxLDfPI9vOi8PhvQWr9DMKr7jGkI05r8UMvj/PKATc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869274; c=relaxed/simple;
	bh=lmsOTlBNkkbvaIodOBo+/oM0y4fE4X5E+kJVleVvsxQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b8e1qwb7CVnTNtDVmc6mDmqkv3cuNl37roHgRzMzhyRHUinzPDeLzmemdNZgPvgBXS5QPERBlca+f5MEHkpy4rOUQKRlasYBWGZKnxBWreLJ/6T6+KfcnUYpKCH+3iXhsWAtaRfL46cfvJQf+3DtoJCQzAqPN4hJNyJi+FYVteQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqnLE5ts; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqnLE5ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729869273; x=1761405273;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lmsOTlBNkkbvaIodOBo+/oM0y4fE4X5E+kJVleVvsxQ=;
  b=HqnLE5tsYkt7B5ceCbHzeBUi1wTglSctbU2SUks6Y/+YxwBut7jyRAiH
   BZMUeOLgtKGs0jc6VjhwGp59equTJIKRvcGFEiRmnRlfv+iYREC1TIIO5
   vmW695sIrpd1KTPXTDi4Js5Mkz6ND/LaF4a5iDbZAQ/DMHbqAqsmMg6Ft
   l6wR+YyoBLekIw05liup4g3PcIcPNLdRtmdAHz9Eq8s7Lg+F/B5Bvqe4x
   35M3bPZWnNAcKWjMF4PJ14WWs8dO9snHGH7vvGCkXzoimBd736ErMqQNS
   h/+YRRN/OwRN0TamTc+WS3ZhwnLegZgAHq5TqroqffXc02wIf7B8ptXH6
   g==;
X-CSE-ConnectionGUID: Y5dSWBsyRQGdKoqUBFvYTA==
X-CSE-MsgGUID: +FInClbyQ26qwurN/vCegA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29659317"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="29659317"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:14:32 -0700
X-CSE-ConnectionGUID: YL+MCiRxSeWZOkLGKq96YQ==
X-CSE-MsgGUID: O1GCSY/DQ6CWZlZSxWI4vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="104241845"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 08:14:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 08:14:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 08:14:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 08:14:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdEDwvItA2O4g0btcx8It07eY963v/B6t9o+SfK5QEPainaQsQSBFFitx0sr9KAUG4WbCCGkbBr+zqS2DlhgSOzDYlVoIe71lMH1VvPFVfXRIL1zPyAGF34jKLtRwasQQxLV43h0FCu5po5Fh1q5kFvLfrEV+8bUdyu/yqSiX7rAPjIoWmjrZpyicLyMLpwc4zBsE/8e5Rx2PK5npfVi9GsOWFANTeJXW4WRnjtJ2AG2GpJHUEbgpa1ZhnekExcz2Kz6phqmLRsaZ+ErRUMQsY/lLTJaeiqaNhSitMvh8TmTCCpasrzH8d4mg5oqYxiOjxeRib8WFDTNSedE7h9vgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ4veQmQu37vRf45nONERBFuuMX+sfvnXkzWlxtVKhY=;
 b=vWgvY5wiV97r1hUdWzL2g3NY5AIcewUeNw3cEjsqCEet7EQAJ9I/1AIm8mcwE0GNuYBlLs8F+Ouj/sZthKit38IqrMZxshDDn7L+JEmFG9LXoQEZqGMHB80DrEWHbQWNtdbkpH0Y2IFf7SaGqtA+bnczS86V3/Xxtep42Sp/gkWZauij+VbNCxzf7aUs0MeI9O5xOho6hOVBt8483tU7tm0sR93vhrXTsfU6/1dyyktlVpl2eUgrvZVJh/QYu/GFuZExoMfB1wYgYXkOBcyuJ3k3G1q97K7kxM5lFDgLkH/JCJsIwDyf3p4pdf3EgJMdDuTIXfpn9aobXVeXTMSo+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 15:14:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 15:14:28 +0000
Date: Fri, 25 Oct 2024 08:14:25 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand
	<david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Alistair Popple <apopple@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>
Subject: Re: [RFC] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
Message-ID: <671bb5d165_10e592941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241010065558.1347018-1-ying.huang@intel.com>
 <d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
 <87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
 <671965a8b37a2_1bbc629489@dwillia2-xfh.jf.intel.com.notmuch>
 <ZxnvyIme98Q8ey1c@smile.fi.intel.com>
 <87wmhx3cpc.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZxpFQBRqWMDjhtSY@smile.fi.intel.com>
 <671ac2d2b7bea_10e59294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <ZxubhuEwL5GrhBdu@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZxubhuEwL5GrhBdu@smile.fi.intel.com>
X-ClientProxiedBy: MW4PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:303:8f::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa529ec-f30d-48d0-5fa1-08dcf507b805
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xpDkTr+ObOE2F1dFAl08GJPsXopXSaz0HWTQdokKIc4X+UnRNHg89ARqGVOg?=
 =?us-ascii?Q?Q9UagEmMi5Gi0zfqBuu+w1SEc5jkquaiQl5YrACpzc9UpPQBIdb0JhDS1tqo?=
 =?us-ascii?Q?evCSPzNyoR6ite41wOJsLws4B5hdZMi2LkZRNDoUFq4zxi75onJJkA3Iepr0?=
 =?us-ascii?Q?pumWajRmOXF/4V4rH7EMRUbYhU7LuPFtAyij3kfG/h8pCh1yc+7oUG2ccO1i?=
 =?us-ascii?Q?+XUIEhjmr/hxKCMD9QEfEOWlx6p/QVu1DmLpyHxMWvzDWGze1feNK41MTXao?=
 =?us-ascii?Q?x5PvNYUs/9PTZlH5GEj9Dz8DgAmQa0tE/S4JkkvDFJ2zZqSFTBZ3ETN8SoZx?=
 =?us-ascii?Q?DSV9qpbXUz3o06BgkHwMrRnsyc3Gaw2XcOCeN7m/EePGmIQPA5T30rIMbADO?=
 =?us-ascii?Q?+xlTzRj2wNH9CSvXM0pG1MqpBjJUJJkW0cUlGshVvvKNXr62GGaE07nS4H21?=
 =?us-ascii?Q?bv74SThM6SlQkNLAdTEHtcu8TJsRFkNGIFhDwMskmCGayxeKEu68UNC2e841?=
 =?us-ascii?Q?d8IDBROVCZYDy8MlDR+meQddF4aBCVqu5KwwLahlGiTTk/wRMK56ArP4UVFv?=
 =?us-ascii?Q?z3jiYFuX6kLsYqg7Ua/5HBe81i0yiQXU+eGUJUGxqyJbzevYYwQZybImhnB5?=
 =?us-ascii?Q?RobeEIgZ6GFWSideHqyRdhckW2XowJH5CR4PLJA99P0Ty0fPlm04/7/gLlVA?=
 =?us-ascii?Q?8645ZpyUAp/BpdauGJR77gwaNKBcVdfzqHOYVF+/k2CYg/XaRfoV83NAoKgW?=
 =?us-ascii?Q?l94s/ewqK+L/uuAdLz7wriJJTyl+NSNxl4VFyRquK6Q7T5z4cuB6n78DZ/PZ?=
 =?us-ascii?Q?ZZNlcBkxT1ERCGhQAQ+KYKVoVZIQF2TvJ7Tq9i9HvLwbTxmc1Lw4XCgoXxoP?=
 =?us-ascii?Q?431Yh1pFIntq8SZE/mgb3NsV2yQU8HrllF/o56plt6RTbIkBLdbaV87D+5IP?=
 =?us-ascii?Q?2Uc7EwSWbMIEJvve1BlPGh96DKvEcmb0NLMxEjmNlVQ5gO0H811se1fjktRm?=
 =?us-ascii?Q?Yu4SkW8NnQnXkwZzyYjBQDWW+Ks3qRR6g6BPgHW0lu/UPN9gUISHIbRK0UjT?=
 =?us-ascii?Q?Rf4oAHOtDB2qOfXRDmfMtCUq6RjSCfM/eZ3hUA/a6fEXm5FSMvU2GfTTZi39?=
 =?us-ascii?Q?p/zpLihT9QvpNRpNBantvdsonUsSCbACcW2XDjrC/o9Tx/9l7u9yDsXLAkRl?=
 =?us-ascii?Q?4RbDPe1tWRCco1m9ZQXW1PknQ9pz24sPqEIL35UN3SAkeyEjeGEEeL+wisYj?=
 =?us-ascii?Q?8kZC3ISPp6pMvZEiE/opoHhgTPt5em741eJ5wfVxEJW1/xGqP/hP8g/cTIX5?=
 =?us-ascii?Q?R2oMRBiAOsB2A/1X1H11NWmP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nGBUkoyMdTFaX03HFcdS2k5kcanzAGnopkMKXYbl4xlGMNHATEicraAF5G71?=
 =?us-ascii?Q?znJWyK5REU5uBLveQwGIw8Z0HLEuc4IRrXUsQo1ItIWI+E44ejJBTHbIiCbJ?=
 =?us-ascii?Q?YkPQ42019CafuYAXzQWnXx75hFhZEVda2iy6yHTXiKE07wpacAXBJf+oHEF0?=
 =?us-ascii?Q?MuoOjTjPCiUE/aZ7ZE+MEsh+iIYN90d2XodhOODI9bV3FKOhRjWPtwzbf8Zv?=
 =?us-ascii?Q?IdD1JvO55Sgn9TT65bK6vF8L4y/wfszI54++/PlyJCz0FBMxJTLizqEXMfBy?=
 =?us-ascii?Q?5ig4QjlQqZDTygqeBeHu+oc4OLMbUDsK4ERwLomSKoYvYB9azpo/qgHLyruZ?=
 =?us-ascii?Q?BbvEGv2iMf/G/HNM+pA6kunKlfn402+vAyPVhEtbRVN2W1y/lX/CPlI/g92y?=
 =?us-ascii?Q?j9wBGFn+2GwTwZJdm9a/oe/lv+MdmKSV3ewGe54/OIIWK4T5VmQRPjiBEwGj?=
 =?us-ascii?Q?/8SqFH1imHgjXH/IA6hkWvzAWBzRBcDsOIL5Gup73Yf5EIeEYpd1C5v1e4yd?=
 =?us-ascii?Q?qIijDeRm2Mj1uRUR3gJbjV71FSuXHXtraXqKMEKctK5jjW7bTsBPeIYEfrTt?=
 =?us-ascii?Q?3N85NvQc94THwT0lTU6T8q3xHgN07oCIO/2JhFxRDjCGl3QE25cPlA1niP2s?=
 =?us-ascii?Q?HglRrrmYS4C15FcG4FlRlpWNgy5nDDsvuVqFQ2QGKNpbBu+aLFW2CoiiLNUP?=
 =?us-ascii?Q?OYUw4Nw3iIT8qFhuwSEbS41oHWRN2xGZ1c3rL7XrznyOrJbENy1C4OYcDeLa?=
 =?us-ascii?Q?s9a3YKoiy52ZUBxbJh2zPqkrZKZM26OCetkRT0OScAQ38NIumkDSulcms1wv?=
 =?us-ascii?Q?2Wg99CW5GQX9BoHK3INW/3BUjCPmZ5DoUMRxMoUWHUpCNYAR8u5tvk+/58s1?=
 =?us-ascii?Q?B+uw3lx4c7kHOyxGg7ASG1CjhvKTCNAVLGE7ezOoeBgS0vN+khGROV7S0ceR?=
 =?us-ascii?Q?2ZP16vjiuzMB+1xgwzSoqYPAx2aNsRpLQhBq35EwNos9iGUDIh2NL1ZwZw27?=
 =?us-ascii?Q?TsQ4+2hwYIydc96vBaPJVIo8eOkLYI8ZkyprCWNMJqOLthqCgsTgozvzXzSd?=
 =?us-ascii?Q?ep+cU/7f4RzHQPQVIbr6xRBOBoKpeIewZR5p7Syv076EZvc8THQLH7WjqobE?=
 =?us-ascii?Q?QSorifQW1zpSeUGTKAbirS1lto9EnRwunzRXAZ5jWOOoLjNpQgEgnRb2iLRA?=
 =?us-ascii?Q?9MrHvzt/wTjvwrjfi8NgKppNbYROvgCqcnQvrxCHZe0Kmvd5hh4BwO7B5MBp?=
 =?us-ascii?Q?AVvSNEZ4MAQuQq7FIdud6CZ3SDRj8Ike9GRQJagW0uTBlf2unA+ohETb2aSG?=
 =?us-ascii?Q?Feu+sD8NxZoBZGfbLOL6Wj2W7xqaENR9otJZwll8BG8zaUYwnd9Kd67I9k9L?=
 =?us-ascii?Q?veOwkxzXbKXSkjEp4P5Sxdfb1REX+SkDv8CF6WGCm+af3UGuDYm1qaM1xDOD?=
 =?us-ascii?Q?lDH86wEz48ZYt049ZzCqZxW2NKLeRPbgO6MAUFPyWDeyVRJ6PNepnp6oeQpw?=
 =?us-ascii?Q?jmEEhzSz+SrntsUn7z2MWN6m/zc70c3f9f6h1dQmS4DvLMOPrq+i98NzGzu+?=
 =?us-ascii?Q?yqUtLyAOb3ttJZ18vLhw6lsOBguxK8hn9DWFI4WOFSKqwuvPjGagBQDeZ+G1?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa529ec-f30d-48d0-5fa1-08dcf507b805
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 15:14:28.2604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zakw20X3VwbicLZ5nUnmY9Hby+rJolPNGAMRjQ78gK+eQv8uYuA1ARuUJXAWxmtxalHOSK4dNbtN07J5Ta8G7CA1ZKlbs+aDkUYWIBpGk50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
X-OriginatorOrg: intel.com

Andy Shevchenko wrote:
[..]
> > > but if you want to stick with your variant some improvements can be done:
> > > 
> > > #define for_each_resource_XXX(_root, _p)				\
> > > 	for (typeof(_root) __root = (_root), __p = _p = __root->child;	\
> > > 	     __p && _p; _p = next_resource_XXX(__root, _p))
> > > 
> > > 
> > > 1) no need to have local variable in parentheses;
> > > 2) no need to have iterator in parentheses, otherwise it would be crazy code
> > > that has put something really wrong there and still expect the thing to work.
> > 
> > Why not:
> > 
> > #define for_each_resource_XXX(_root, _p)				\
> > 	for (typeof(_root) __root = (_root), __p = _p = __root->child;	\
> > 	     _p; _p = next_resource_XXX(__root, _p))
> > 
> > The __p is only to allow for _p to be initialized in the first statement
> > without causing a new "_p" shadow to be declared.
> 
> If people think this would be better than the existing patterns, okay. fine.

I think this case is different than the existing patterns in that the
iterator variable needs to be initiatlized from a declared variable, and
as Ying said, my proposal is busted.

To your point though, lets add a comment on why this macro is a bit
different to avoid people like me making bad cleanup suggestions.
