Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C741F473C
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 23:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738797186; cv=fail; b=Kmecq6Chcx5lcKCjPN3i72x+deHNlVpgnYBqL7ct3TbsU1IZDXEYrulLSbu48WKTMYDYUFY0YE02rNZ8TFTDDmJp6KFqtH8SjSN8xzASdx2TeIf0Ag/t7lRfRJ/jg09yzdvwyqmIBW5YG8fyWT4k5fbcY8AaClNQ7xk+XtrD828=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738797186; c=relaxed/simple;
	bh=ODnWqg8tbXSoy/dNZT8iWU0Xvoz45SAZHySmhv+Rqfk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NJks8geQKedY0CZiNzswZ4ipqyIvXMiwCcfvTf7DZpEQZQLCYQcc6205hYf6IhbmpwK7fwZHDgofggSRwzg2X6BTokcgVuHYzavakTT2pKeZAJsNRhZtxGYF39wZlLD1v6n3GYZS6kVI7TqCCV+Aj6fVFQKN0Rb3MhNVLLOzG/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQk4/RPs; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQk4/RPs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738797184; x=1770333184;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ODnWqg8tbXSoy/dNZT8iWU0Xvoz45SAZHySmhv+Rqfk=;
  b=aQk4/RPsdusobdS625niFThyTB01hOSmzgFhBT9xLnaU5h6vGgA+ljJN
   xysUiJl719yXCRcO5IFGtajOpros/8WOUTxGSgGPDUiW8YRhNjhve6xHa
   b5OYijEaxF95gcsWry/tIt/XS1GxlaytehLge+q2amytaCAkczUKD1/E5
   zQWznRHMVzVu3ufSgpr1s69coC3mkgelvvRGO3mwg18wjgfCeeGNy07Qe
   7kU7pGFs6cpllih3LLztew1u5sXdQQT6l+ixxDt2y8aS4AbdV6kHCr4J2
   yQns+dRi7GMIFCf3yW1exXvxe6cHITNjrntRAS67r0ur+F5TvUUhYmqnT
   w==;
X-CSE-ConnectionGUID: uvwZPJh+TO6/uWiOReBgUA==
X-CSE-MsgGUID: gBT/+ADkR2+xGooXkUiRYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50004735"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="50004735"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 15:13:03 -0800
X-CSE-ConnectionGUID: mlmrYnLRRlmek2hSpMBZyg==
X-CSE-MsgGUID: SrnQcVZmQmGWqG0B0fYMlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="116039207"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 15:13:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 15:13:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 15:13:03 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 15:13:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wC4rkxNsmfOPmDq4lvZlOdPHwuZf+7zLXYKT2dvVg+lZHuMRgyYSp0iWLmj4eAqWQEND1WKSR/tpThcZJaXpzwujk9L7IgwTL7zcTXmICpzSzUuxQoHYF5n72ZizFeYGVzNSQpEy8ATQL3eVhkWRmHXOn/aq/my7nVpZ4KAHOZOmmGMjsPC4jK8Id0KkgXmpbHzMLjbsJaMDv33JWPtM3+Ffd1MY/I10rncYddOyugad0XDQ94+7MoKRy9LeHDvCKhgkTz5BVXqUqCSgH3lhAQR7zm8Y96UgmhPbg9KBbUPf5yEdsT4EGXBHZPmMalelRmPxdgHrA42CQhjEuL/dlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPyObmrSdTjvpm4gkHUYyLt29SOS8FEmIWC5wJ8ArZw=;
 b=J/ZJ0UwW/YeIX6Gmvg1TKXRb5eXzcVOLZhr4vF1N2WGwmSA7BTD3O8C1OTV00qDFWQgNrKR1E5abZTkugQKVeYNqpy88jaDu3tcF5eyc7eQdrS/ep9htwaJ6NhmK2tbf3ncjVlL81wNYb8+augpOuHWH20BzGxcc/9b3ZXEgHxDxHQmTnpkTbPQOPsuctXh2k64stylNhIH7gNOZeMm/zlbQCnMlaQXn3Klfh0RO9csVeK8xK8pJfGJVaZ4VS1NslWcKS8yJnqdx33PHANTzse77zZBya9CUCWfa0XcQ77tQes/r4xQbQRUGtKoJt0JHQ8cr8OMZuI9cdw8gQVlQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7697.namprd11.prod.outlook.com (2603:10b6:806:33a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 23:12:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 23:12:18 +0000
Date: Wed, 5 Feb 2025 15:12:16 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v3 05/16] cxl/mbox: Add GET_FEATURE mailbox command
Message-ID: <67a3f0502e793_2d2c29496@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250204220430.4146187-1-dave.jiang@intel.com>
 <20250204220430.4146187-6-dave.jiang@intel.com>
 <67a2b6d345b61_2d2c2943c@dwillia2-xfh.jf.intel.com.notmuch>
 <20250205175740.000079ab@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250205175740.000079ab@huawei.com>
X-ClientProxiedBy: PH8PR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 8edf81d8-19cd-4da4-c0b9-08dd463a892b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sZ0hQ6SATiznjZdKcxLILQilWhfaYrtwkrxA0kEbT2/P1agjAOiwazPtArMC?=
 =?us-ascii?Q?tTL7hewJLSYra3zP0Nn35jjWiBVsNqbLV3BryJASR39a93cZlEsiAE3naXvj?=
 =?us-ascii?Q?WLELLqUUy+ibimExo6Ps5fDYcRHvw4kax6nsnDvtHhaPpb7DE+qq1zQihUBn?=
 =?us-ascii?Q?W2I3u8WALjWedvp+cEFWvdPzCOYlEl/0v1X3bZ0Vm5NCDozxtsfrKpJX47fq?=
 =?us-ascii?Q?/CHFSNeyG3ij7Eks1sDQdywc1k0TaFQ8caFZuotz8NqH5d6UK+FySiriBxch?=
 =?us-ascii?Q?xXGAP6GS96cxfSMHhtcBgdI9+Fa0CINgq3iJOxgtReZPISNeIW9OIACmfVVv?=
 =?us-ascii?Q?izbWxVOzSp/ly+R0gKJ2F571f6WoutFVGeSeevw/2DBxPgF6vzz0n/SE/txb?=
 =?us-ascii?Q?m9CNvQTj9vyotujAmc34YTGoncwkNE7VzIzmAJYC6czingnYJ5FK1n0g0qc6?=
 =?us-ascii?Q?869NNnWAqyxoIq/4+Jnn/YB6/79QoF6p4pxgRbe9PLTUsap483L86m3vBjLx?=
 =?us-ascii?Q?3etf41rp17qJWHMp6PG/7hUplhKl3iFZQuhUZbNkHzrzcgu53s+t2b2y0hFQ?=
 =?us-ascii?Q?MEZWKE7z8RwnI9L08ucsI/zb+lUnYnnCFUxyMvHFaC0jegc58ha2D5RaIqDk?=
 =?us-ascii?Q?cSgh7Iw63MoKQZuUtWH0o05FskhFOlOO0k5YW3SBZvrAU9GLnfMJiWellz5V?=
 =?us-ascii?Q?La0sP3Hwqhh1Z7r6u5DQuEJXLi8y1x0c0YDH/QqkGLjR/aRx6sXiQJK6uiiE?=
 =?us-ascii?Q?K1LCa1CD1AIVGWuQ+o6/C8P8jeWbYbqB3BD+bsrzIjsMnXM/lDk1JZxS7Um9?=
 =?us-ascii?Q?k7spvC9Dc+f1YJ3gdpdvpibkw5EmTEVBI/5eU8/NY3PtY4vszHGQNz7t+Xd8?=
 =?us-ascii?Q?Z9AYQIDC8oPj1CHPOr5HWQhl4nrVUjkUEml+QvUpeb+Bse3Iey2/wnQM3Qhr?=
 =?us-ascii?Q?f2zNp0fZJ9xPlyK5xj8FgDJLplV1BRExbW6NG0kua/8iOGgMbKrNLqQfq8Vw?=
 =?us-ascii?Q?RyBIoT9tRRoXTNsOdXkPNdW2CeQl0jf60GAWrQ99Sr8YxvqKVkx/w9JKcA/w?=
 =?us-ascii?Q?z7Bf5rCNQE0lPcPzgR0WSuBp02j+0Ty4BttU43pineowImH6L1iCFh92oo6z?=
 =?us-ascii?Q?MjdbxJWVhLHj9v20rPqqojn6t5cgYGk1egRroFuGTfiVsfEcRUjMIBWveVcP?=
 =?us-ascii?Q?LRM/gna+jqo9+/A3yxizUHRaq57RUd1vwTKDzXjOG7llm/4mTCxtgcQxJ4yE?=
 =?us-ascii?Q?z8ecBe+WTlY7Iumasd/uSDIjudoRTRiqtBQ0XmlYk/qgHLIuzQDSh5H3Ityl?=
 =?us-ascii?Q?qb8OXlasD2wyPvxVaUnU8/NjVI8VUgzJ9IcheGVL0bs6K5wtEgPBHhGWchDj?=
 =?us-ascii?Q?DJQ4LSYFjpt0TBQwOy4wTJ+SSzcb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rJJmCCJJ4ygLc7viSILF656K0QxKXk87pkJjTRFtXqIS+Zyi9xgSBRGpOILh?=
 =?us-ascii?Q?FY7U5UZ316D9s8P81zlZpTvTx9V3Gh1OAvY72wFCNkzjVWuGcSr2CBCmiIDN?=
 =?us-ascii?Q?LlL3/Zdj0aRMEFjON1h8SvAWC5oErnA41gF6TlzBLYIzAjG0sgRa1zGkVg7h?=
 =?us-ascii?Q?EL/JPTWtHG0qIFRlJBpvkCGMeSkT9G5gAN0RM/GI33+6xrK02M2gsB6CR03a?=
 =?us-ascii?Q?95vke5fX/uvAMbV3n1c0i/k1jQ16n8ItWziKM7EEL7+KLLpXoeC84X0+Ds5j?=
 =?us-ascii?Q?uUk8hhKW1dcWzej9CdXZfDZT3/KZWMkPLRyxIl7IByyheoPp6EluI27ZOdv3?=
 =?us-ascii?Q?CT+iJC7ybqVZu7RSvDy0jWOUADHK5csPfAR4p2da+PQOJ/8eC1RZ/GyuBCQJ?=
 =?us-ascii?Q?gmiVpypuzb+fWK9ysX5RhiLyECtIvr6+LjzvE485zsb1udNFfHjV6l6SANdH?=
 =?us-ascii?Q?tYxCr6ECCiHtOKYKtQzT+ZTxbXbEsdcewXkp7jU+kZbU7BiQQ9WjEfTDcYzY?=
 =?us-ascii?Q?aVlRJgMkKJNsh9oEzGBF0aCoRKNqSJQ1UMNZWfEFjryWIN3C998XmTCTRnK7?=
 =?us-ascii?Q?4nnB2lX3lSO71NYdgDs322x6XcFxK6wLoLQk9nUR2EtTXpnv3mNc3Q8tnlbG?=
 =?us-ascii?Q?YzgTlAD0tm2kCIwB0l8nGVR+Zsc1tytaUIPMOWmLg5+slVbSe9SpSsY/Vyy2?=
 =?us-ascii?Q?4G3JS76VZT7kUL6H9bHaPetixBbESLCE7hqJ3rhCeS9EsbLF4cvGxaxcAkiJ?=
 =?us-ascii?Q?kiOmB36cKz2eBN8dnl9oXKYLLl4cxlYQFkf5G8lDmQkwt0sZo58ZrGM/WlAZ?=
 =?us-ascii?Q?lJckRbWWDjCRgZ9DMrbLVN40/q2LebPVLt/2/dbGnwKsSsIk2o3C3L7yAPgG?=
 =?us-ascii?Q?o9NcEDOpxD/yDY3wsSEooiLU5ko7IQOA0Cnx4mqXWQmdEYaZk7K1JuIFxyqI?=
 =?us-ascii?Q?7j0IPOlzEcj9ZliOHHJqH9CqUePZu5i8Gdb8UD+GyacXY+RTuuEhYjO6qIxp?=
 =?us-ascii?Q?k89gjgYPk94yFExMWgU5khDedUZjB33ayxVtuOmw2lAzNEv1DKG8PWEbn/Ow?=
 =?us-ascii?Q?V0GVsvWC96dSTum4awRQe6oV7Z1eZR8EgX9JvV0ZifldByuZOuXEHhnzha7P?=
 =?us-ascii?Q?kXs4O4psAUsZcCXGp84Bu9LxGK4mtuFtysgFADcj0CMUrqlQXByHqqdthGFw?=
 =?us-ascii?Q?j+UvEgCKZkGBKIFYUXVqgeJFiwL3bWVmRVxB2mJLDV7YHSuPRDFxRppBcDms?=
 =?us-ascii?Q?9mE8cI/4LybsHBAdiiy370Nf+6AKdBsQbzxUus77ETUkAE0HBZstFAxfNmXt?=
 =?us-ascii?Q?bcugFJiktwmYImcI5es6+eclmpqVjJH+VIuljYJ7Ao9MF5KAh1BVETo5giOo?=
 =?us-ascii?Q?nxS34tx0jKxxFRvNph2zR1/gSk4V1gYLipapuA0c5VIRtfzokYHrK0N8muaQ?=
 =?us-ascii?Q?DEh8B7HKVKwtpHAcYFZAdPMuyLhO6rON5o3ovijIdjIjqcm0HALzZT8wv6QK?=
 =?us-ascii?Q?Ja2BYQKACCnq9AQCYwvhvEwbHn1D3WDCRT7n/BZNZoCEwTjnlfK36mf9ufPs?=
 =?us-ascii?Q?g/uzRCBQYqPRJUVW+lZTTiyfFKw3IUoDYPc50gbn+8lYvLvHzP3ayh3R5YBd?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edf81d8-19cd-4da4-c0b9-08dd463a892b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 23:12:18.1399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFZUE5iKHxQtDd2Lp0yGAEdz8yFfHqbimdJ9Yu60GLN/RX4nL7yklp0T6a1RDFmGZOO7ZZ8SqOgaqu+PEXLU9d0xn7D6gRAIrRVqCLlfd38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7697
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > So I see this is exported to a new cxl_fwtcl.ko module, but I think all
> > of this can be core built-in functionality similar to memdev ioctl and
> > firmware upload support. As long as distributions can opt-out of FWCTL
> > and Features at build time then this is no worse than
> > CONFIG_CXL_MEM_RAW_COMMANDS from a proprietary use case / security model
> > stance. With that software only needs to worry about finding a
> > cxl_memdev object and not manually loading a cxl_fwctl module.
> 
> It'll get exported shortly anyway as it's used by the EDAC series
> and that should be separate modules.  

What additional modules are needed for EDAC support? The registration is
done by the cxl_mem and cxl_region drivers. Are you thinking of a pure
helper library module to the CXL core?

Does it really matter if it's a separate module if cxl_core.ko is going
to demand load it always?
