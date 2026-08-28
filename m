Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A4233920
	for <linux-cxl@vger.kernel.org>; Fri, 28 Aug 2026 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787877210; cv=fail; b=BClVXUnsyA3MGsIz4b05f5gegn+qn6Oc98iKSAQIqrffjxMFa0JxmAu0/hvAf0O7bE1qQExHnuHRAawwiF7H5UuhzBjpyTz4HP5YKS+pq0L7n30odWEuJTqBLdkqHnLfCxVfvmgo+h8oi/yQU019BwBY9EAW4il938wdkHzNZBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787877210; c=relaxed/simple;
	bh=ToBlZGcYdo/H8cBzBwd7ZpZ3AuJqDEiwkMp9pqH0enc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JGkS6VqmosPPfiJ+0gNdB2X0tjR1c5dKuBZD6BaJiV+0xCWn4uWtTK6tahoirIcz0Yew3ktZH8ybERZ81FfwYmn7n0kdhYCsvymLXP3uRXV/dHU3IpxEUxHvMRto3u/ZtFueM3OovgMzFcofd8HbfGc4wfQSXN46N6ne0wQbpEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgoPlj7J; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgoPlj7J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787877208; x=1819413208;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ToBlZGcYdo/H8cBzBwd7ZpZ3AuJqDEiwkMp9pqH0enc=;
  b=KgoPlj7Jtxn7xBbdpmRTcZKLyslniTDgAL61NENlOgeFz6D0hPj49+mZ
   SDvP2gSTDGdAVK84J5utVGssm7qWWxdL4uprLfOZyq6ODz98wWYiiTLH+
   0ONJMdRSN2yXHFRmWcwaVk7zgGIY6LE51t5UJLqS6akqnPAki9pG8IKZD
   VJGxrlRr/IMEXFpojp3hS+Ok+fhh9eaeb+GfXndkoya15bo++hb7Skwv7
   6PbCsd1U5LkgKEitUpD55LiDZGQnxSjoaTuAaTPlNqfrkDTV3qNRSH+7u
   OpphaIu2ICdmBkn2wUzozKKAmQ40zKSePWVjzi7yYUSS/UqUzipoIJ6Zj
   Q==;
X-CSE-ConnectionGUID: ROBQ4s47Si+1Rtap/sXDnw==
X-CSE-MsgGUID: r+AniITNTmC8SOlgP5v1cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88592085"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="88592085"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 17:33:27 -0700
X-CSE-ConnectionGUID: YVNGaziOSKO4TI4OHWbdsA==
X-CSE-MsgGUID: KpyYrJRFSO+odaL0mVndvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="263728165"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 17:33:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 17:33:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 17:33:26 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 17:33:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyGH4H/S2eoPoZkrIt4ZVEb+xbzD3/pEEjL9IDG2vT5DEoyL4QmkClZCIGyApHVBDNSPYarD2Z9XGMaUHPhK7rgiTPxRtVAKCR0wDP8431tOpm1u+UnxEJDbhPdU7CTsZvB5grmolMuaWd1liidXYjsoZVodvgXHo6KkAqGHHxJJlrX7WbjPNtVk4ah50p3loCNqgYE9oAp+xtLJqW+W2U3DyYfO810VVRPyZjxjH9VrAv01tD85UMjtLg/mH/THseOXHJLldSN7DArA98K0B4SizjHWFZZRCkvILV+H1gIdUdODU/5p6hpz/aHMWo6S/jMdFeGgVS9twAKrg6xseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtziwZQr7cuvB6S1qbP7vpDlvCdZnU1adRbnoVbSy4Y=;
 b=cAOYviMohNJZgRs4esP8zxBo454wgG8a7zavsdsSJPQ+6gifwZcDsRG7pX0u4CY8RDetNUHK9o99DNREjMP3Q0sVNehQvO7ZtugawlVKmMX6YfUFMApmql9EayXwlYgbHOqa0edqsfT+3EBvRUP3AoVrxhbOswoOlDDnKo3pFVPrk9c5e+Z8ME+yEyRdhchhItX/0ZQNAmjrKoEK8HXtkW3zG6qQxZPw1D6SbXbfDGw29bdyo73KEq2hX5tzIeWrMKsF96xZEHITGBAN6H7Ks+7gA/hWsh+LLsssvgqRdgDqV2tPT1PA1/xnkV0f/SZ87OQTLZ1NJqjJ3LaIrjVMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV2PR11MB507586.namprd11.prod.outlook.com (2603:10b6:408:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Fri, 28 Aug
 2026 00:33:23 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 00:33:23 +0000
Date: Thu, 27 Aug 2026 17:33:15 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/core: Fix dport use-after-free via the
 einj_inject debugfs file
Message-ID: <apDXSzSZVcjQ027J@aschofie-mobl2.lan>
References: <20260812060943.56246-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260812060943.56246-1-kanie@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV2PR11MB507586:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b41937e-292a-43c5-62ea-08df049bf7b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|3023799007|18002099003|10067099003|56012099006|5023799004|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: Fgc6cqxn2CXvK2z/r+Wsz8/wIizvERnnAFh4lNfiVZBYV6fKakBIFtHVdBhcLOXQ0wY5Df+M29hqUPXti7ind3sbbQQb6AQTs6j7tIMZZgQ0J6BCXZH64z1IYvioMwaQgMNAU9dDmTBlnVVEgRptKkKCM1G0bwjbW55Ik16Tv0O2w5DOdUz+KAeSyaor9k7RRETRMUav7Um+8hx2MEaSwiMRVxls7BHv8RQMJ7XZHWXfQH7u5z8PZkh3fNfRSSm+cBX+xRi78tyADyKroS7cDkHqZc8Qx72NxAJkXAnkO7I098gOJlc0o5cK3wxgB5bX83CdNeCGCrf52y/4XrvF1EzIHmU4pRuLktf4lyFGhSMA943rGuw6qW+uoTkOUwlXgRh9HTYVoTgUYJShsu2UeG2CzmaB164XjCijV9dl86bghY9rZrOpMH5ADeBk8Ujn/54H3HbYCoEo3t5qvFlqzTRUjmV+icTzI26IS0F6BA6d7wzSyAlrjrYO7vpWyZf0zJnX8X0uSpwdkPvDVGtPwiZuPp8PVQLn64FWGVhD/PJy0+Ex+kX0dxu4pDJuy2otDa6twz4kCwTmaK6eBWlSdSzEaQJOxpyGXsq/oJZH350+7gYphjHx3mI5kjbkSzlENau+esCwHCgnvfsHFNNMB2BFuiTV1t6qxUHQay2XqMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(3023799007)(18002099003)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iK01k+3682iPxhzJJicdr8uTsCXAo+HTpc6K54Tyw/p0YOkgHB2Nrp6V/yj0?=
 =?us-ascii?Q?QT8rGsSmmf+uGojnMgVgkSYMjyNodQkLnbCiuIyHMgPuB9SrzKnBSdF8ON7U?=
 =?us-ascii?Q?Lq5NO+XsMcA0Hv0dZs9QVGwfT62KvZPDAi3BCPE4tNWNIw9oZ/NGFYLkeLuD?=
 =?us-ascii?Q?pAkXHVZduFe1EBGSAPRo+DCJebgv6Ujzoh3eeLwS6atKCcf42VZIVOtB7XGI?=
 =?us-ascii?Q?9i/ffQ7d4PvawGUrKExfIt5Pk0C/yOsZ9fU+AtM+cHyb6ZX75UDJVTU7ZcyG?=
 =?us-ascii?Q?4yUz6UaqOJkR6XJKgND+HIBO8WrCqdjoVc3pBBysSFaTs5QPL0nl6Bc0FLxy?=
 =?us-ascii?Q?DxrSYjSraEdqGFMY3PWbImBhw7EbGDQHA6/alUmIps8El1Z0j7uhZzuOcWpE?=
 =?us-ascii?Q?yxjUhdkHHsUQ6fnvlOx1iNseKHXQ+IaFIRtmCDljs9fwKvvTqr6OUE0gNikp?=
 =?us-ascii?Q?TRO8n/b/zEFUMBb69hu/f/Yj34a3h6NlH3o1nPyQ4Bxd6e3c/j+Y3vn2hxkc?=
 =?us-ascii?Q?gKjW5t8Gb+lc7VO5KYZoZX1BbLI0QRzVpE984+vtpxYRzqWw3IDjcEIbtlL4?=
 =?us-ascii?Q?km/NGIqMlONdPZ7edbDC36QIQjA2nH60/u1Q5gAS528fSRRa+Ad+1+wCSBQq?=
 =?us-ascii?Q?8kqN5VgSiVVOcen5Bz/oOhTMYD+385diNuKl2Lq4tOKTEy6RX3gAdfW7Jpv1?=
 =?us-ascii?Q?EgzVuHsqIUngDMjjBZ1jWY3CARgqgohFgJB4QAjoRdQ8bqJkk2tL+AIK2fho?=
 =?us-ascii?Q?Wsu9ybkcylZuEt7LguuaBkZ1MsrE8XMoQEEAnRsmLHUA0WMXJghQccVYr4zr?=
 =?us-ascii?Q?rAW3uiyjAie+PQTcJ6XPIWMkAjboAFLyEPYjrr+fhesXJrmGXtfHQeFIr2k5?=
 =?us-ascii?Q?VKrZzR04jA0cD3I3yWm5x+EHcSPmIgbS0vXEQfJ5t9SLxus/pGEIH95XcOw0?=
 =?us-ascii?Q?RU96OsisblFFL+iBn0GSFmD+MnEVOdG3pSNYFpFwg/CDcpgIc9/IDv+7j7i9?=
 =?us-ascii?Q?ZAxufeSiZUwXadpRHTBo1sE7zgfbjgkt20Ah1oTQLTdux298lQZ+/AexsiHf?=
 =?us-ascii?Q?zSFONPK6CDb+aWvCw/Gl52TOvpDpM8GE6ibXeUFjIhZZSo8S09OsJ7KMfx7l?=
 =?us-ascii?Q?iw1ERvj7h0mYe3fCbWrdnU60TFvQsVU1OwVLj3zDMoNE1q68/tr+9xJrPxBf?=
 =?us-ascii?Q?5HKRbNVyMkhTcKLlvcVP4gzs8Vh3gXkH4LslKgLE6pSayAGfJmoJ1WOEd2aS?=
 =?us-ascii?Q?zmUcpnHptzAnAk60nnczlHnKvX4asxaLvE7Spv9Kw2tQ2xlthJLDyz99iqmJ?=
 =?us-ascii?Q?ASxV1Lib2F2vXTYthoJpKcWt5i00POwSUnjRBXs4OgXUDZneUW/pbTxhe0Kb?=
 =?us-ascii?Q?+eDe+1USHQLOXKxax2fWedEP/zvYtftwd/cXmLv5n7xvY+QTZaKhXOAjsEi2?=
 =?us-ascii?Q?iX7ETcVVyGErDAGE9xEp3paFwVu8G/ZqtjANj4qnGGmqJsmL0C8K6iGrM8qu?=
 =?us-ascii?Q?09yH31kvoFzuiC9oxUlBChjVJuv1U4GlhTnxcQY9tM/0ENJ3SQIxpNW3O03R?=
 =?us-ascii?Q?EB2tMp0fQzdwMQQbjSu6LaT9OfDPztsHn0HKRdtygcYsYSutApmLqY4jIldl?=
 =?us-ascii?Q?3v1XOKXFcMsy6Nj/HyuiHnXmpIkCNlss0HY12se79lZnEWfYEtsqw/FKiuA8?=
 =?us-ascii?Q?gLBvfi6mNkqOMQS3KdWJtwCgdXt204CPdcaJVxV/tNZTB3zyaBXYzZz2lUXV?=
 =?us-ascii?Q?drCBRhjyeshmpY0vZOIIxQKh9hi4mX8=3D?=
X-Exchange-RoutingPolicyChecked: bAcEwuCJaVidJrN6asR+DASkor+T7pN/q8Og6G6M4TDBtg+tjpUHvKq7KOmQ6CGKdwf3uhUXGKtlYi/xvHR1FyuUDGweCK0/vJaSNDfjQ2KKX++p1VhHEXshNFuLrv4lnt3oUQhwArCxGGMkaCFYFvzCXF2ZITf6tAPoXO5aLe2qzMuJLdGYD54OwdUl7j0z2aE59HZqnCxF6AzpSMY529WM5UymGiNbcRWtoLgpNQ1zY1AJrXgM99DivN6xAPNxMUOvHMQ7MIpDeoQhhIIQHN4kGSSGvv3NKpHoWT3Z9GjhsR1sc+sMLo8YjsS2a8SeUNNOCUZsf/Hy1QUIUqQCTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b41937e-292a-43c5-62ea-08df049bf7b9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 00:33:23.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBlDXmDhTJ9Wg51is0RiRt8JR1V07CgsryfQnjVy4OrMtUS9YirpaK9rc4Smj9O1wUvC+Ka83qrkJh1x8Ec37Z3MB5inT6tEX8xUO0oAi6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB507586
X-OriginatorOrg: intel.com

On Wed, Aug 12, 2026 at 02:09:43PM +0800, Guixin Liu wrote:


Hi Guixin Liu,

Skipping ahead to the changelog, you write
> - rewrite the commit message to describe the behaviour rather than narrate
>   the code change (Alison Schofield)

I went back and looked at v1, and somehow the commit message got
substantially longer and harder to understand in response to my request
to make it clearer. V1 was actually closer. It needed to be simplified,
not expanded.

This reads more like a forensic report of everything learned while
investigating the bug than a commit message explaining why this change
is needed. It is dense material, far too detailed to the point of
clarifying nothing.



> cxl_debugfs_create_dport_dir() publishes a debugfs directory containing an
> "einj_inject" file whose i_private is the 'struct cxl_dport', then discards
> the returned dentry and registers nothing to remove it. The other per-dport
> facility set up next to it in __devm_cxl_add_dport(),
> devm_cxl_dport_ras_setup(), binds its resources to dport_to_host(dport) so
> that they go away with the dport. The debugfs directory has no such owner:
> it lives until cxl_core is unloaded and cxl_core_exit() tears down the
> whole cxl/ tree.

Most of the above is unnecessary. The comparison with devm_cxl_dport_ras_setup()
adds nothing to the description of the bug. Neither does walking through the
eventual module cleanup.

The important background is simply that einj_inject retains a pointer
to the cxl_dport, but its lifetime is not tied to the dport.

> 
> The dport itself is freed much earlier. free_dport() is registered in the
> dport's devres group, so the dport is freed when the host device is
> unbound, which is an ordinary sysfs operation on the host bridge port or
> the ACPI0017 root, not a module-teardown-only path. After that unbind the
> einj_inject file is still there, and a write to it calls cxl_einj_inject()
> on freed memory, reading dport->rch and dport->dport_dev and passing them
> to the EINJ code.


Above, the important point is buried at the end. Unbinding the host frees
the dport but leaves einj_inject behind, so writing the file can
dereference the freed dport.

That is the issue and impact. The devres mechanics, specific devices that
can be unbound, and individual fields subsequently accessed do not make
that clearer.


> 
> Re-binding the topology does not recover either. The stale directory keeps
> the dport device's name, so the second creation finds the name in use,
> debugfs setup fails, and error injection is silently unavailable for that
> dport for the remaining lifetime of the module.


Above is useful as a secondary impact, but can be one sentence: the stale
directory also prevents the debugfs directory from being recreated on
rebind.


> 
> Keep the dentry and remove the directory from a devm action on the dport's
> host device. The action is registered after free_dport() within the same
> devres group, so release ordering runs it before the dport is freed. Its
> registration failure is deliberately not propagated, following
> devm_cxl_dport_ras_setup(): a missing debugfs directory is not a
> functional failure of the dport, and on that path
> devm_add_action_or_reset() has already removed the directory itself, so
> there is no dangling node left and nothing to gain from failing the dport
> addition.

This is implementation narration. The resolution is simply to remove
the per-dport debugfs directory when the dport host is released. If
there is a subtle implementation choice that needs explanation, put a
short comment where that choice is made.

If you want to give your LLM some direction, ask it to first reduce the
commit message to something like:

Background:
einj_inject retains a pointer to the cxl_dport.

Issue:
The debugfs file can outlive the dport.

Impact:
After unbind, writing einj_inject can dereference the freed dport.
The stale directory also prevents recreation on rebind.

Resolution:
Remove the per-dport debugfs directory when the dport host is
released.

Then turn that into a short, flowing commit message. Do not expand each
item with everything learned while investigating the bug.

Being able to summarize a change this way is important beyond making the
commit message easier to review. It also gives reviewers confidence that
the submitter understands the problem, its impact, and why the proposed
change fixes it, rather than simply forwarding an AI-generated analysis
and patch.

On that point, please also say how this issue was found. Was it found by
you, by an AI analysis tool, or by reproducing an actual failure?

Also, how was this tested? Did you actually unbind the host, access
einj_inject after the unbind, and reproduce the UAF? Did you then verify
that the patched kernel removes the debugfs entry and that it is
recreated after rebind? Please describe the actual test performed.

That information gives me considerably more confidence in the patch than
several paragraphs of forensic implementation detail.

-- Alison


> 
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> This was patch 3/8 of the "cxl: Assorted fixes" series [1]. Per review
> feedback that series is not being reworked as a whole; the fixes are resent
> individually instead. Patches 1, 2 and 7 of the series are dropped, as those
> issues are already fixed in cxl/next.
> 
> v1->v2:
> - do not propagate the devm_add_action_or_reset() failure out of
>   cxl_debugfs_create_dport_dir(); a missing debugfs directory must not fail
>   the dport addition (Li Ming)
> - rebase onto cxl/next
> - rewrite the commit message to describe the behaviour rather than narrate
>   the code change (Alison Schofield)
> 
> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
> 
>  drivers/cxl/core/port.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 625e4aa427db..62a9c2038d1f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -814,6 +814,11 @@ static int cxl_einj_inject(void *data, u64 type)
>  DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
>  			 "0x%llx\n");
>  
> +static void remove_debugfs(void *dentry)
> +{
> +	debugfs_remove_recursive(dentry);
> +}
> +
>  static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  {
>  	struct cxl_port *parent = parent_port_of(dport->port);
> @@ -834,6 +839,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  
>  	debugfs_create_file("einj_inject", 0200, dir, dport,
>  			    &cxl_einj_inject_fops);
> +
> +	devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir);
>  }
>  
>  static int cxl_port_add(struct cxl_port *port,
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> -- 
> 2.43.7
> 
