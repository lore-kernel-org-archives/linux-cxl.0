Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6421CAA61
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737668117; cv=fail; b=cblP9urAUbQhZe1ZNR7gpi+n/PUBrnCZ1yVZoi5u0cDPSqJHjqQjSu/yFo4iJDKRPMOv2SssZtO7M5gJXd7OkXvXJByV/WQf6lK9JgSwBrCjR9cpeUOG7u4NIIqZ7nV4qvyHHRXCiJwNQdHPabf5sJOWZuU04lgfsPcmMvR5YsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737668117; c=relaxed/simple;
	bh=Xn4Bwf67nMAACgyrQOYuG5aC587et9BKg0+SoBG/wXw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=duUvGWcQYBu6QaRGx119j5HEOFEn7is7+UX75ag4s9MJW8GiA4rVDS3Ujk6YLRH/TfHGsWUw2AxSdbJSPqUz+oeuPlysirtpMr/xUmjJqk4Zx3FoPxPXJpFkW6W7H8oIbR1XvUN4wnrmliAQs6czvsBvqlY0plVJuH2IallPCkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=leYWQBfE; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leYWQBfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737668115; x=1769204115;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Xn4Bwf67nMAACgyrQOYuG5aC587et9BKg0+SoBG/wXw=;
  b=leYWQBfEorUEYxCHoZ9TgnlZmeEBHlpAMeqiB80zXK7ue2m3XX+AYYRP
   TrBoi0AR2/LKA6MuX/pj7sJm6M37jmh6HYzuSL/5NEEVqcYtfdAm2vpKt
   KdepT26rQech9+H8ajGgNB3BW+EhhkK7fx0MP84Y89BJmrqAIxJUT2swl
   aeywb+3glvkyE0mZzqmGnISziK+jebVTrAuGCquT4vyclOhckwLAeS8E6
   fQBUJGZxB5W/N8E68u7L7Lm/JUUiRpjC8FXCjZlU0aWMCqKoiTM5EiUUA
   J5xrs/xSuGlvZDc9Sj1/1/El77JSiSe15EMCP0cGhEXZa/aQFvltvIUVM
   g==;
X-CSE-ConnectionGUID: /RSjNMPcQEy6L5jIZi1/LA==
X-CSE-MsgGUID: om1ISu6YSvqi+xE78esaxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="37448836"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="37448836"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 13:35:14 -0800
X-CSE-ConnectionGUID: lClbRCHZQ4OR3OnE++D3OA==
X-CSE-MsgGUID: LSK+KAv4RuOyyP2c/M1ymw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108017826"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 13:35:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 13:35:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 13:35:14 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 13:35:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8uS83GZ0DE5dspWUnvJJZeWC1IsKipCS5V66h1CB0PsuCsyQORnJtp+IHYi0SiHzZ3fIOpUP17qwv2WDE6uro3Uk5liQKfjSUTmm2o10x5JPcdGegv7cWicKJjZxQzdHoxrMyUwTH/DxsHtqNoODDXhQgy7huasAvkUXZYvStUCxvIom9JHxvsTooQZLi+awqPo0BpGxyUyNCNOPitWk3F60/4Ecs+j9G77rfHZLAieeLexQih11RZ1Ke3wngumsT4XfoLe3l8ZX7qmXbxpSi+nJOLesuZpRzTfpVpwcknaIEZOLnPF4fKWgPjzwmx3BmWUfXKjZaCT0fL8SQ1ptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=678///rPw7V6K4tltCcFsVgVfdyyh6kGTtqz0DmV6fg=;
 b=lUjSK/Uk3fMJNAGQgKml0YNv7mOOcoW+eEs2LChHfi8cg5KaUthi7A8ZQAecDbGOeXpBk4w9sp+NNrH29QJHgv1Km/CQUdQ01FYihcyPMhgVuj94BcvjpP3YeFoDiTbHxjczNneyWZ/+gzm35DFB6/9xt6OihJkus/L93/VsxMrFZs9Wc+HWaYwwL3thXjiuJ6nfUZ3hLhmNbZi8WZeT8dJDSmM5uq23rW4aejOtTT5RmpShjISzW2uDBpwJ0Ge0mpftbnWdqEP3yb0MYBPWn23kzR5jdIpL5xUWfMtz8MP4bRWPrd6QMoD/U0DY4gkb5bIFJc8xX9OwIvFYusCQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 21:34:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 21:34:56 +0000
Date: Thu, 23 Jan 2025 13:34:53 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 4/5] cxl: Make cxl_dpa_alloc() DPA partition number
 agnostic
Message-ID: <6792b5fd83fbb_20fa2949f@dwillia2-xfh.jf.intel.com.notmuch>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753637297.3849855.5217976225600372473.stgit@dwillia2-xfh.jf.intel.com>
 <20250123164112.000028e3@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250123164112.000028e3@huawei.com>
X-ClientProxiedBy: MW2PR2101CA0003.namprd21.prod.outlook.com
 (2603:10b6:302:1::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 22964b67-2565-427b-4b0d-08dd3bf5c7aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KX6sZwW8GZeULUIb1hKt8ByVi90f5kDmtoiAGHpQ6jzQ6spb08ZfyicgXBlR?=
 =?us-ascii?Q?IhEPJi1JRf3k+aL4UZlZTXT0JogyB76qyE/AJcnXtM+ew727TykmrNQe8TXp?=
 =?us-ascii?Q?y8G0kv8fPWUULRb//GApGkLsEkMFS614UPbLSg78XSdAF7X81w4i8Lrd6FAF?=
 =?us-ascii?Q?VHcL2c09DeJIOzbyTtxahtRn+Nl0tOpt8Z5hYbSIuQQoPnudBEsfUxa6CXCu?=
 =?us-ascii?Q?bvS8svM9bSfnpE5Tcvc6r0cY6MhTCSgb72/Oa/IDqfGiT+N2cb0ozcq7GA72?=
 =?us-ascii?Q?L8qHdC7dO3ZcTNqMQVqzhXwPPMT93j73TOKlcGpLvTV6muVeVfeJCSeo9ia+?=
 =?us-ascii?Q?XFENvUogtF71MXNjSoB9HqoTxzQiunEyAFNUvKflxVIH0qpXPlcHperGgxvs?=
 =?us-ascii?Q?Fz9+TdHxUKj3Fm5Q5ZBgWYTeMwHiuepz8J9xbtR1UnB0zk+/iOBHMYuJ3ynv?=
 =?us-ascii?Q?2VgJyOprdtAuw0am4uvtu6I1I1nzRfVt2QbDHFiJMpkhBY/AXibm+UuqXzVu?=
 =?us-ascii?Q?06iSe2KKSHc9CwAljaWZ3eTTorZJvZyVxWs4KCOBXqsqpcwskOS7v8+FFuEA?=
 =?us-ascii?Q?Aog27iopyDsrOGQU3+Wt+5iDEA4MQ6rjGICwEvwzPfqhmdxlZT8l5WSX16PS?=
 =?us-ascii?Q?ylJGvC/jSbyOVIusHY7VdQK+2HVPoL/ACBR8+L6NFqlTSsyHiasfeoIeUxUm?=
 =?us-ascii?Q?iWma42E9fvgk4Anwtt5+VfkwmD6afsm9kN/u4yd427GhcbwGJL/UlMB2bMI7?=
 =?us-ascii?Q?SL3TSdeKRMMVUCPGjkNGMu8zqI2TCc25kSp6YEGJaCUF2RH4VlQNMO/GGTJu?=
 =?us-ascii?Q?DHr0aERKuyFeZ47+aeJsNdf7dS+XTUFFxXKupYqjkd4Gm+5H3Ya5QVPrgRXy?=
 =?us-ascii?Q?9QiMhHYP0jgavEQY9Q47ftXOcSrLv0xLLcnBi7VgUaXsvuRdtHnppI2Ox7k8?=
 =?us-ascii?Q?YFd2YkxBFH/UWKBVgb0LMlHKIXWqTiiPo4XSW4deMicnQrxlFqVP4qLGWWGZ?=
 =?us-ascii?Q?ogjto0DFuWf9+QAlTwk6abPgFa1k6CrJ0zW1+2w9NDF3ubPe4bBUuxzLUA8d?=
 =?us-ascii?Q?LpFQmsAX/IqkUyESgQoeWIgXk0AZTW0um11e98SSeuw0vN9FakCSfBLIFe76?=
 =?us-ascii?Q?h8s4g70Dvw9NgoFosG4IN3H/b77IjuLBZtFWyejcbtZmItdPFOlKOoPeTgUp?=
 =?us-ascii?Q?POihawtHGaq7iUL9Iq8lNTXNC+3kT1hlKdVcLWTQ2thjzh/chOpFVfExUL1/?=
 =?us-ascii?Q?J9et0RRVtgH8QIBFwuzz9fy7fo/71ThcZLSo6WDY2lkBbt2ei2SMoy+ITrLd?=
 =?us-ascii?Q?2Kn/1PfsLyNLqnitJBewByMKYAtxfYe7GYTqkNRmo31WNu485R4MR483VqgR?=
 =?us-ascii?Q?gGXTMoCEfYCFqO/QtLV2y+vBhWJc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?maw/LHfFtMqxUW3W+vnutuajFkXudzV5yrQe2H4UOxgIMC9ZQl4oDaSs1ksv?=
 =?us-ascii?Q?7wsLJVAJxh2fjjgO1he5W2eGXibEdCzzFRiYxntqWI2aMlnnCxhJ9bXhZtnw?=
 =?us-ascii?Q?2OBKb2eDjbncN+LfW60CqGflkoR0jJaxZsKRV7OKmqdvjqGuraB5t0zJM4Vp?=
 =?us-ascii?Q?huKbBbiQ0Y6HS+YOT8xzzFSf794sjLrvuf4qNEstugUoH7VR4CX3K/P8rKk1?=
 =?us-ascii?Q?HpaNDnaZvNditrVWvf7y1jGL3PJ3IuqlfQBpS1ZKg0uttv9aKhY0LaV8VqW/?=
 =?us-ascii?Q?BqgUGQNT2yPB1BPF6HeiQ0mVSA6RG6hxEAhd/lxVjfG74YrS8GSmjRCUybHW?=
 =?us-ascii?Q?rdA8RjKIlbTDGw3W8KjMptKOK7iyoG2vEpBvmfi2DJN9eDfApAms9fPNkdNS?=
 =?us-ascii?Q?a9MFjEFOwsAw/hD+rqWoBxvuCHKdbUL8k6cPrUawJsXvVx93ZTZlpwYvVCW8?=
 =?us-ascii?Q?amcppl622em+PgV4Gnf/G+RY8aiFQVnz+9dAG7aJrjoB6wzhFL+jUlV2dcbT?=
 =?us-ascii?Q?u36PCn3LmuUNXEPNLlb221o5T0GyVwqyk9T8zrjtFR/TPCyQXiMVNiUb+pLC?=
 =?us-ascii?Q?Ks8m3ZGcORXbTCq1LCxsPgFscq7Pzc2A6YkgiVyQlaXBoRAdqXfoHAR7jZQy?=
 =?us-ascii?Q?RRQIKE9HwXLxEhWzDb5RaRnsXUVdfMCDsOCk7ffduG6mXRzyZKa/XzzHWyhX?=
 =?us-ascii?Q?0BIOOHGkjUEE+usIq1MKOmd80AJGihK0b1QNbCG3pz6+1tHtpbLRdBf3AfSv?=
 =?us-ascii?Q?Ge+Ly3CPPYN34SOguAupeagKNtoQ9C32lV0mGfGHBKTO2jIAC/We8LN3xY9L?=
 =?us-ascii?Q?IOjAjtZtUBHS0lM5pcwiTKcTIhkTttOxkdo1cvDB+wfwiIlJ+MRpbKz02RMC?=
 =?us-ascii?Q?BXBryl8T0CMO2368ABdu0VfCysmka0OI/ROqwjlZ4SbMqaUo4vR4kGhiTF+3?=
 =?us-ascii?Q?zxBnNGmgZX/1X3sxEjzRizP/uzmYLOutlVzMewktivhBh5bJEucWVSlkaKE+?=
 =?us-ascii?Q?G2vu7yds44mGSo1btEVBTy+k4I9eib6OBUgeJTOhL5orgJRl1smkbos1qN9k?=
 =?us-ascii?Q?ZmsQY5mjVGrhFZkMwZsPKe8DlrMkwxj0E9qXLVFcDDmps/5ezvonHE5j+YSy?=
 =?us-ascii?Q?13IzVZOYXQJNve+V0nGcEUrrBwzMErXY8adSZ1K6CVTXX4bp7SHs8F4znKYE?=
 =?us-ascii?Q?nGqy34oXWHZybRrzIbcvJqIHbV8HkTCXR8auOhqYdYVftE+9cFjBJX3JPY08?=
 =?us-ascii?Q?XE1eROkU7GPjdd3zq9/6T05m3hQQvt6a1qHmPqUNoOyK6EOXdJLVhKjJbKsj?=
 =?us-ascii?Q?0f9ks56WflSzf7bjp304mJPsFhYhYqeDr4pLj/n0xd4apLNjSCMsiz6XgnLl?=
 =?us-ascii?Q?tTccVzo5QJidRFoue2inI+o4TSYeiPN9uukKJVby5auEtCtalX9gAC+0KIaO?=
 =?us-ascii?Q?oyeuzz48SBQq5Bec2e9qu/mUUrQjmDsPagjh8qJcDXgmXxKqym/anUN1/Dlt?=
 =?us-ascii?Q?vsAXUVRvTvLrrNa4iDcYblBAErTN4tKq0+IbnjhOjNjhH6D/6v/4LlQLwln9?=
 =?us-ascii?Q?Y5CeBUe30pgb9rE5ivmt5x8NJopf4RZg1em8ZKZc2UsD/3j/XV00xAPADY3i?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22964b67-2565-427b-4b0d-08dd3bf5c7aa
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 21:34:56.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8WGOtFFoDax9S1ke7mYU79xPhtZyywgLvQ9hAqTI0MY/AL6UFo60u7FoLAnDvA9M/Ja3VCtm/fF7sAcxImG7xmdCnt2Uqb7/OUWNbDkYTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6522
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 22 Jan 2025 00:59:33 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > cxl_dpa_alloc() is a hard coded nest of assumptions around PMEM
> > allocations being distinct from RAM allocations in specific ways when in
> > practice the allocation rules are only relative to DPA partition index.
> > 
> > The rules for cxl_dpa_alloc() are:
> > 
> > - allocations can only come from 1 partition
> > 
> > - if allocating at partition-index-N, all free space in partitions less
> >   than partition-index-N must be skipped over
> > 
> > Use the new 'struct cxl_dpa_partition' array to support allocation with
> > an arbitrary number of DPA partitions on the device.
> > 
> > A follow-on patch can go further to cleanup 'enum cxl_decoder_mode'
> > concept and supersede it with looking up the memory properties from
> > partition metadata. Until then cxl_part_mode() temporarily bridges code
> > that looks up partitions by @cxled->mode.
> > 
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alejandro Lucero <alucerop@amd.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> A few possible simplifications below + a trivial debug message printing
> a useful value comment.
> 
> Jonathan
> 
> > ---
> >  drivers/cxl/core/hdm.c |  215 +++++++++++++++++++++++++++++++++++-------------
> >  drivers/cxl/cxlmem.h   |   14 +++
> >  2 files changed, 172 insertions(+), 57 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 3f8a54ca4624..591aeb26c9e1 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -223,6 +223,31 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, "CXL");
> >  
> > +/* See request_skip() kernel-doc */
> > +static void release_skip(struct cxl_dev_state *cxlds,
> > +			 const resource_size_t skip_base,
> > +			 const resource_size_t skip_len)
> > +{
> > +	resource_size_t skip_start = skip_base, skip_rem = skip_len;
> > +
> > +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> > +		const struct resource *part_res = &cxlds->part[i].res;
> > +		resource_size_t skip_end, skip_size;
> > +
> > +		if (skip_start < part_res->start || skip_start > part_res->end)
> > +			continue;
> > +
> > +		skip_end = min(part_res->end, skip_start + skip_rem - 1);
> > +		skip_size = skip_end - skip_start + 1;
> > +		__release_region(&cxlds->dpa_res, skip_start, skip_size);
> > +		skip_start += skip_size;
> > +		skip_rem -= skip_size;
> > +
> > +		if (!skip_rem)
> > +			break;
> > +	}
> > +}
> 
> Could ignore all explicit ordering constraints and have perhaps simpler
> (Even simpler if there is an overlap helper we can use)
> Assumption is we want to blow away anything in the skip range, whatever
> partition it is in.
> 
> 	for (int i = 0; i < cxlds->nr_paritions; i++) {
> 		const struct resource *part_res = &cxlds->part[i].res;
> 		resource_size_t toremove_start, toremove_end;
> 
> 		toremove_start = max(skip_start, part_res->start);
> 		toremove_end = min(skip_end, part_res->end);
> 		if (toremove_end > toremove_start) {
> 			resource_size_t rem_size = toremove_end - toremove_start + 1;
> 			__release_region(&cxlds->dpa_res, toremove_start, rem_size);
> 		}
> 
> 	}	
> Can track skip_rem or not bother with that optimization.

I like it, I'll switch to this.

> 
> Mind you your code is fine so I don't really mind.
> I think we can build similar for request_skip based on ordering assumption, though
> there we do need to keep track of how far we got so as to unwind only
> that bit.

Will give it a spin and see how it looks.

[..]
> > @@ -553,47 +647,54 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> >  		goto out;
> >  	}
> >  
> > -	for (p = ram_res->child, last = NULL; p; p = p->sibling)
> > -		last = p;
> > -	if (last)
> > -		free_ram_start = last->end + 1;
> > -	else
> > -		free_ram_start = ram_res->start;
> > +	part = -1;
> > +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> > +		if (cxled->mode == cxl_part_mode(cxlds->part[i].mode)) {
> > +			part = i;
> > +			break;
> > +		}
> > +	}
> >  
> > -	for (p = pmem_res->child, last = NULL; p; p = p->sibling)
> > +	if (part < 0) {
> > +		dev_dbg(dev, "partition %d not found\n", part);
> 
> how is part useful to print here? it's -1

Yeah, another thinko likely because I was already thinking about how
cxled->part shuold already be set before entering this function in the
next patch.

For this one, I'll just delete the message because in the next patch the
loop is gone and only the following remains:

        part = cxled->part;
        if (part < 0) {
                dev_dbg(dev, "partition not set\n");
                rc = -EBUSY;
                goto out;
        }
