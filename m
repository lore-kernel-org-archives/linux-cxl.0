Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C782040B5
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067951; cv=fail; b=NB7gSl1usGgI4UVBwTRll/nbzuusgUgGxFivvaYiQpRxWNk0R1WBIWAtoBd9Y079qPDTu6dIvOc7hOgzw3E5yZ6Ai9Mq+zoPwu39lTCI6riEXZiFcJzAZEtZ59C9SVnbbAOpN2LcwXJvFfzTZm0RLT6Gg/0hQoSVJKjkcIr6Gc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067951; c=relaxed/simple;
	bh=PvKdIZfyL5Wp15kAML7haX92ZH7Fp9IhLWW79Dz0uA4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rpANy0FEVzosIORG3ER20lqVQjAPnDE6jjHlbMvs90jlPeTuDdRgmQ7nfdCxLi/ej0fuB/92TnVYRHINtRD7CYt6X42EcHWnz6LeqHOdqLJGWvT/HyY+pS9U2nkUkUUq89AgFYmGdififI1HcDMjoPIUmqG7Fp/I66i0YM1JgNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnUWWlYn; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnUWWlYn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740067950; x=1771603950;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PvKdIZfyL5Wp15kAML7haX92ZH7Fp9IhLWW79Dz0uA4=;
  b=dnUWWlYn4on21r4mhh5jHNHqNVM0zrjNA836wgDu8m8HoGYEaiFTvu6z
   w88yhiYakO6pSm6+V3EntygjLv7aI8r/YyjsU3+aBnJ6LLiOf7Wrq+Re+
   WnDcFyuBJ/U1xgLGAFTIGJTzGz3ek1gFOW4GxmcbhwbYChdAKTkcllTwy
   FwdTGik0U+9gnu0kjT6LfzCC8ZZfOrSrS7OrBqkx6BU8CFdfc0dM19uQd
   fJSRB+Mq1Yfin4VFYw6cjv3kPEq+ykiyNxdXCASpiB0BUs3D/+PJTkNBG
   ZXd+MScaJQKYDhGp28HC/AC/0UmUFcYs1BVkl5iwejoW8kRyJIjRN//PJ
   g==;
X-CSE-ConnectionGUID: aaem07cSSGCxKrtHFs/hmg==
X-CSE-MsgGUID: kgLUpBriT3Oy4cdazVy+Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="43687003"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="43687003"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:12:29 -0800
X-CSE-ConnectionGUID: v43SNKbJTzi2oO9e1k7CXA==
X-CSE-MsgGUID: +L7kLwVySxKoZT98u+22Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="115612382"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:12:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 08:12:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 08:12:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 08:12:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKF713aOIFxt8eje5NEhDRJXrBh9VfbtKvj5m47sBscwzCZOqq/8qRtrK1IxWSaXNCcDp5ttjqEruH/ql3MVuo65HvQ8ctaIGWmgUxviNxMH5QmxyZx6o5wRqkuBQuW16B+Ji9PxxRKItAiMtdF+bf03FhTXD16mz/R7TeaM1Tcdr39xncS5b3v6GvX77dgB1vGEMbOreXZEmDpUdK2dmevds92ZxfgP/e9vtmtDAcbfUL617aP3/c4JzPaExvgH9vmwBscIeqM2eRPdMQOy2kaot2J2Irjcaz5YnbYLo4CvuU1kRGkTUWS7Bq0G+yMjPHRKeBQfP9DE9jlGRTVA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ksgOY3iYI+jhNJ989gf3XJ6r2mFNdxKk4mj/3APi6g=;
 b=fCqrtGj0ur4oMsiB5YGEpO75fTc43OVqQjKkEZkQHQvdy3Ps+tL1lcIp6HzQEbySLc1qb+OiYbIiCZlHXiocnar7EOB9HHxrke/o4gaTcBbOthxctKoKPtDjlZ4xVGfeS9RKojooJEPL5Hng3cy5m6/K7UOxFE22CnuER4LZEJ+trLgJFpGo3R3X3L+P4cN9yQBLhNKuHB0CchLvDSUDTvz59gMJJ4xz463gwiG4VuYYaV7Oj9rfaPM0YcpgvXGP9w7YQ4/SimPdhFjy311MdIewJJJOKP5J7nLXgxIc6C+5DDzlxNkFxm/lReTDSp4D0Q4+2Dh4zK3F4G0hsaEcAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA3PR11MB7534.namprd11.prod.outlook.com (2603:10b6:806:305::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 16:11:57 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 16:11:57 +0000
Date: Thu, 20 Feb 2025 10:11:54 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>
CC: <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>,
	<ming.li@zohomail.com>, <a.manzanares@samsung.com>, <fan.ni@samsung.com>,
	<anisa.su@samsung.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/4] cxl/pmem: Export dirty shutdown count via sysfs
Message-ID: <67b7544a7464d_2e08a1294ee@iweiny-mobl.notmuch>
References: <20250220013604.263489-1-dave@stgolabs.net>
 <20250220013604.263489-4-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250220013604.263489-4-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:303:b5::10) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA3PR11MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7ba2b4-4f0e-4fcb-cf6d-08dd51c94cc3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UnqndiRr1YTo7sEY0DyKzpXn1zwRAxbl+VrOt4FraF08ib8IEWNbyyTimlO6?=
 =?us-ascii?Q?tL8nRxeWPOPT2X7MLYW5oikIthZyliN+o3x8iA2Y7JEVJqseyxz/RPELs8Mp?=
 =?us-ascii?Q?DCILBgcCA5CL5DuJx45nf53+o6Uk6FNE5g7dNuYva6g0DJE5/UjszOVBbCbl?=
 =?us-ascii?Q?e0wjGXBh3ug19hwPpiIUZ1qWeicfJzbCLtRSIKNKm+LQ9qSOPcgvpdS71pPp?=
 =?us-ascii?Q?zR4S0/Klm19vLZKHI0t1/88TXaW2g5RqGqX00MB33WRhjwZvbzpSirAzmj++?=
 =?us-ascii?Q?qf05k55JpMkAWsRziH9R5fqpTGI8vLUhvhMYAj2MfTA6yNxOl9FZZQVMMmB7?=
 =?us-ascii?Q?Eck7wQ4g8UUFwiuPYJXwKMgWoPjaqXV1BRX7oQ/ACaIcjrWRkTqBQxnPR7Ur?=
 =?us-ascii?Q?wAiYjFknwMKksmeGiDKPxK2mR3VIhnsooDbsWRTUJWMFTa9RXOSVAtTMsJw8?=
 =?us-ascii?Q?FkdKF9C18YqeGdAmWtar8OfDZnW/MyKv9zBAAAo/XkK7Ynyy4xvOtA4AGniQ?=
 =?us-ascii?Q?ZfCWnhd3FNp6AX7UoquZnxgFqtqTHiejSBvccofSS+NriMYHO5Tz/5eV+AfG?=
 =?us-ascii?Q?pz6US1NmnA4dop5MrIs2UOCCRQW5EudruwcglMVsCHffyTAXvkk2BtAB62LU?=
 =?us-ascii?Q?hpSbJ4n6ViXRAy3fQED6AdLDYefVwYb+f+z/D9ZXdAfhizV4wW1msbicHZ7S?=
 =?us-ascii?Q?YcpJ5Ae0aTvVhKsdEqyxH+r+w4Hl5p13FS8L03PmKidl2/XgkYebA4FnmIBE?=
 =?us-ascii?Q?Ldi/bBbHqdLxi4TiL+y6fgOvAueaylOOu029ghGIS54l84F4A6mNTkwJDDnX?=
 =?us-ascii?Q?6/wlwsBaAtF0yBhIfgrCEpkDEwDI8rSof/2Pp1jdcsTDDnTefbXvz295UyxS?=
 =?us-ascii?Q?Kc6I9EzaDdni11sePTGAI8EOrmOKbZBXGNwHnQSLuBnNAzmVRPKn4P0JRiZV?=
 =?us-ascii?Q?BUgtuDn8nMuPh6TSETLY3qM2+mVjec4iMdhSu7DG1huqm3vAnIsfz3nv/tRt?=
 =?us-ascii?Q?WHWe00eBghkfCHmxoBBlzTljyV57QsPWkvI8TYMwY0vr+kBmjOcpKbUcq7/3?=
 =?us-ascii?Q?I50hBTzcuXo71wNKZpvC6hZgIzl1D6neWQPuSOPKyA1gVEmyhHGdKflmCAXP?=
 =?us-ascii?Q?nIe9gGNkxZbgfg4CCTTmZD5WglAtdnF0tngP4auwQSC5VEpNzwNreGydh6jg?=
 =?us-ascii?Q?FCZ8hKlR2mKFDi9at7uMluQ2GTbdcYnAlunRJD1FDLKhQ2sAQKOoOtGFMbha?=
 =?us-ascii?Q?c8swDRdqbAR8TjB32fa2nQdCfyNNQH2BCZ0hNCGEYx0PMcSE1zM1RPUbU+9X?=
 =?us-ascii?Q?EB1yirhvyyl3B+UYDXA7hXDCcmr9+SmfzRHLZf00aSOmIq0kuvU+2+xIhBMz?=
 =?us-ascii?Q?zDVeE/PHY+CQSGkB+RD3bmqiXVzl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I3308oqCWIrcF+hwZr447J/IrlF3nLwNE0Opkcz+p8Y2ETTsMHJSeHhy2M3q?=
 =?us-ascii?Q?s+aMUHr4kqd9V+vrQLzLZIRGPMfoDznYEO7CVRPK0Br7AAl33CNx1EtgNnrJ?=
 =?us-ascii?Q?VOdo2bXBOrzfjCSGXTtExSF6dnnLi0Y6rbG9QwrtNDWs5jjyXnLxW5MEoo+X?=
 =?us-ascii?Q?9oZ1c3G2l0fBe8BT4tOjh62zFH9qU/UviPjcBYM28VcAp+v1iiAtyQm5bXez?=
 =?us-ascii?Q?BOsAQpgVKK/YVJzxkHtnUfI8r864idoA48Pc/qvL3n5TjkS1M3hB3JhaYedz?=
 =?us-ascii?Q?Vv1pbvgQr5xoWqnwvUPal3HoHM4MuMl2PWzKlHrWa4ylNsY+Dk9S9pRgVpBO?=
 =?us-ascii?Q?gXXLKmYyvLDgQKMBLv0Mao9Q0xUw6D9F4PyTdBsx6J78XfByk4wg7rEu+0mv?=
 =?us-ascii?Q?d3dQH7yD38EDOUMQyZ+fuhXs0S0e1K1PYGfu9K67OsyRm8wxrGN0ZS1yypY9?=
 =?us-ascii?Q?aXP3qgDHhRoHbTsii14YaO2FbSG61LzsDphoBWczIN60GgJDg01/0qjhmHCz?=
 =?us-ascii?Q?BjEiAgKJh7z0ivnfW4AliPmIFVtADSxqibZTQEoC87/r8CYsxMtKONS1BNk+?=
 =?us-ascii?Q?+EHOnUNGyuVVZkum0pdeaTQBURvf/VUTCexXhB/QwJxH03j+Mqpt5gJ0+zZu?=
 =?us-ascii?Q?pdGEVGnmu1nwOADFzsBOvpj+/jBJDudGtr+KfyyinFd3NoeU4SYZLE3DNg08?=
 =?us-ascii?Q?DZGgiVsups85K7pMWGgQNZzSzZeqqBAVmGLqG9LaRQX8HLC4yht6Do6z1QuN?=
 =?us-ascii?Q?qD+VI91euqdTrz8a1DqPsDE4FARjEfUZyEwc0phqd+rvOnIvHKfUfA5jLUSi?=
 =?us-ascii?Q?8M3tVFdHMV6wtNk3jyuzQhI0rFXvoINtcN0iXYmBzXTMuzx7LqsQolZWuXuo?=
 =?us-ascii?Q?RbCQUxmcnGf8Im2qGxGbT0NXaiaq/OjV2SrxIWtMBMy3VNRSDttP6YTZUke0?=
 =?us-ascii?Q?mF2rthkcUHRjSOUt6FVmrnXLH7TonaBziv87e1fE+ECHOiNEhjr+aNVIHrPO?=
 =?us-ascii?Q?HTlo9n5QhtA9yFpygYtud7EbBt66QQ1HY4s1bj86TawiOYFvIN+4nS4TerxH?=
 =?us-ascii?Q?Hw6dzghERXJtzSJOJm9Nr76HPD4LcjWsfZZOXfZOrL9ATBS32HPHuEZXRY9M?=
 =?us-ascii?Q?IlGWbOnqKLvbu2fHb0ijohnn9l3AQ8HqQFERh29WkaxCS4UITa+nMggWBlqc?=
 =?us-ascii?Q?jcmElMHMuTYB7efkFTnqftVd5G8+FN57yYtHGxObQBEJnnRtkELI7XcfP2sQ?=
 =?us-ascii?Q?GzWE2PrIOl/FFN/NdzsRTmf/MQQgSJvMD9nJ4Zi/FjxfiEq5jhUMMhdygnir?=
 =?us-ascii?Q?9Hs7Pq/aDJy6gYMGshBiFANPy8EaEiMKJJp4rdOZx/zRYo7zsD9Mm8SoVkMH?=
 =?us-ascii?Q?bqpdUm+5pHklJCjrenRpKUgE1DxVTdNxkyuROD8tGMnB6oJRcnGQ4Cb1OxGR?=
 =?us-ascii?Q?LvXjnz4G9FJDe05tW0sp5sqjNvpcP2VVCWQa47RRM/e1jfFu/tCwrbOet7n6?=
 =?us-ascii?Q?gk7YuPpr+bZjlZX/IIxi7XoN2iu8v+HphUgHX1oIn/EO33FuwH+xaen/ZCiN?=
 =?us-ascii?Q?8jjJTIwqtSNr5zb52lvcUSctHBrMaoeVv8QO6Y0/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7ba2b4-4f0e-4fcb-cf6d-08dd51c94cc3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:11:57.5887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMHJAvCzNYZjkrUKt5iSNQg/+XXsskETA4iVKGJMojBg33Yqb67TOthU1BbW/08RWjg5LigjjcwaKQ6fCdIYQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7534
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> Similar to how the acpi_nfit driver exports Optane dirty shutdown count,
> introduce:
> 
>   /sys/bus/cxl/devices/nvdimm-bridge0/ndbusX/nmemY/cxl/dirty_shutdown
> 
> Under the conditions that 1) dirty shutdown can be set, 2) Device GPF
> DVSEC exists, and 3) the count itself can be retrieved.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

[snip]
