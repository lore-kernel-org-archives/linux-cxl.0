Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD121D61AA
	for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535169; cv=fail; b=EfGDvgOSeIoRKxN6GgDoZQNuCsyXaBIdXcc6DWlNgK6oQzdnlT4V1wWbmzr4TYj4mke98ZXE/M81n43J4giTMiC72C6+GdkVdkLVN3g6x76MYM6ErvcIog2hoEllToCDwazt1PEEY2ezBtZfCqnHtxy7ezZ3/hmPzX9otNn+tjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535169; c=relaxed/simple;
	bh=BogTPiIRydDn64LXakWSC6BstRgdCNw0uag25uyxxtw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A0mtHF9p5tmJkgv+G9EDJ9SVmxspSNH8tc0GY5AjzxLZKqayZGImq7hQPYW2QeJbOkrL0ZOC9y/0Kf/C6dgrZG71RBTjeJwUBg/0TGDifD0/mlS0Eg7Rzq/vA/IQ9ZtDtmruUX3zc2SNX0v3XJ+7CVYXOEgomVdvnJ4WWcsJT00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R279UNfb; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R279UNfb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748535168; x=1780071168;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BogTPiIRydDn64LXakWSC6BstRgdCNw0uag25uyxxtw=;
  b=R279UNfbrW2Dj7ONhHJDqGCWMVzneAwj+7mq6eTfWGUmd3NEzSp/7XBI
   grziURmnx3eVYNaR5yIWMTFzjMHSl/rF2OQpsARkyoR6NDiYrALb58l7e
   esknLTPKNAD1PGNnL+9hWYOa//w3R0Q9pE/FcCxcHRgzMsFYXLWxuKpko
   wVNE3RsEgS09mbGrQBH+N+ss7Fuolcb8JxI8kWUV62Nh/i6asHCuxeEDi
   yqhYPOoX95iLk5gmS075Wsma1i6N+mp2ye9KHACbjAx014xHF41B+O0nn
   orFtKX3Uui1KqumjT0KwO6bzKlPZfQA3LcZxVz+Ut169Rq8+fq0Tixzwo
   w==;
X-CSE-ConnectionGUID: dH1gGfJDQfSnETPkDteWBg==
X-CSE-MsgGUID: NZn0/q/ARM+6y63RulEcwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="61240905"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="61240905"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 09:12:47 -0700
X-CSE-ConnectionGUID: Xco6JGIMRsqG8i/MhPoDsA==
X-CSE-MsgGUID: 5nzZF8MuRVmiQh7ehCCCNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="144078049"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 09:12:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 09:12:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 09:12:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.48)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 09:12:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TN9uX820yvZSzlR+db18V2I6O5lAjQ1kGceRmRUuP/MVtEel4u1oFtgS9B/llx3aqX+3VQeIPj30GNYzHfxXAh8UaOpRjzRkPPSyCAxBnpgWeLlFYdcZMFnCusFfEss59ARJSbsG4Pl5HgI44kyef0BhqC4jHOOvyd8I+Z5/Rx32L0zK45YC0RqNSZEPdm4POVFFbK6VYIRqxwIDpblSn0L3c2aUMrKk7IW4AKajQX21sYrZ3JeO5oq2IYW593ejmPFjrYEj2/0Q3sD9Ycx2oeHRaXE29AmtTN9g2UaQIwfC1YYd9Xwmr4aklpmZFF5C+QQhV0s0H6NCiuqKDjYWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEsZc+KztTQwB9UHuZ6Pz3/z7MCP/uzV6LHbSWNE8t8=;
 b=LtZpfV2HvbJNIdTbF2Vmau6Y+nK3YJhNr3fUlSzCsN+PaQ6RT2DG9SsYDDNyf67Sv1wcKXHbrZbr1O0vDEou8uQhoOTBYqe1SQtpbGIun7QJ5Pclhs8piKFHmBDfFHCcPCy00NHdlNnitLwgYxaEIP+cV/6HdIRYb2HkO7JvozUvkSN3Djtl3Gpz+iQq84FnU4I/pWiEP+GUG0Vf55hj0MTw7ag4QZOr71c+TcTxrX2HQWa2GAjCgvfaJap8apsH4n01bV36Jh+lrH5+hL4hZMt5dfyWzSx1XysuLilICn/QHRWstwuQVytajY1VtVmJ9nQVEpSEwhYRF0EwOYirEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS4PPF240F42FB7.namprd11.prod.outlook.com (2603:10b6:f:fc02::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Thu, 29 May
 2025 16:12:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 16:12:43 +0000
Date: Thu, 29 May 2025 09:12:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, ALOK TIWARI
	<alok.a.tiwari@oracle.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [BUG REPORT] cxl: Incorrect mutex unlock pairing in
 cxl_pci_mbox_send
Message-ID: <683887784d46b_23b3c6100ab@dwillia2-xfh.jf.intel.com.notmuch>
References: <0d2af1e8-7f1b-438c-a090-fd366c8c63e0@oracle.com>
 <aDh80u_QoyZXEVlw@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aDh80u_QoyZXEVlw@aschofie-mobl2.lan>
X-ClientProxiedBy: SJ0PR05CA0166.namprd05.prod.outlook.com
 (2603:10b6:a03:339::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS4PPF240F42FB7:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e3e7d0-4231-4eda-5a48-08dd9ecba49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?otSZt9ufNBCBDmTOJyVWrblVdBgv8ZSOLbHtXf/i4JMJA0nCXKczT6K9Bo9Z?=
 =?us-ascii?Q?7fLbOiy2RG2B14KytYLGdcH8oV4sH575Kew33MeR5ZAFES24wG4DY6kkKuHr?=
 =?us-ascii?Q?BLgDzWsrqyy8hDHzeFCPxmKok/JqNOwa1PmMS2SJa2hzcwx3SAdav4VTgV8N?=
 =?us-ascii?Q?ekJPPK6I3s1VmckNbzIk1PSM0wmBDe7PBBdZmklYqBoG8M217HaV/kKReSHY?=
 =?us-ascii?Q?OhrQ6dRpXbIxXkFoQOb4DUeQJkD90COYrwE9bS23Bz2jlmKI+c9G0rP6bWNn?=
 =?us-ascii?Q?/Xt6nTAD71sUVeMtICC6uqnBSDSrMUSzFRjqFBa39Odb9tcs8iMCiSlnHBH0?=
 =?us-ascii?Q?IwwEk9sO9QpuVEuUM6AWrRAcVj4YTVlrZeH5cNfBECXBdTVyRpaETpVQlEyg?=
 =?us-ascii?Q?K//zaX8sVNK1/pRLOwyTe/UAYK7pNEedWD9odWSS7XGtpB8qg9KhmBjRkVzd?=
 =?us-ascii?Q?caMSdQTuG6r79DxBVv0IR6HjRdp87I2cZbNlzHXuPvlJsckHAE4/g6bKdP2D?=
 =?us-ascii?Q?znhWL1Zs16aZs+4g9ykw2KCVuDkGO23qu3LR+cDbUu+71bG+VuJaBcMIcR/a?=
 =?us-ascii?Q?M9jQO1WaLMsTsRvMyOWmGlJDsRA4P59Xj4Q90EMeQ3nkK5bpnOOhm0/5kX2E?=
 =?us-ascii?Q?/p2yI8xlvCglIyROrZ1PkdS/lwRhVs19hnkEYk76NFujzwBhbLHxMmb80HGM?=
 =?us-ascii?Q?9IBVu4Xoh0d9r+0v5QCLY7q60fPaRoqashPfeKGti0Bw+eH0+yN3+B5fOfaP?=
 =?us-ascii?Q?bBB43P46oB90mnqzDVyw/Mt3ZfosheiHbnEMEBSWVr6oDepCiwDCDK/AeByc?=
 =?us-ascii?Q?iOIk0xgGQvNYMwqaPdI17z/z9KJIzWCsMf/mt1FtTv+5GYJs/xD9sBdwodEj?=
 =?us-ascii?Q?lvPb9fb12h8wum50P/KOndQ4EW9fZVPZ3HkvAW/ei7Pz/4GMt2N47DukXPxc?=
 =?us-ascii?Q?Wop/2royqvvS1P5a1svZQc3sbv5LFYBTckj02FIUcSPN9rB2nkSm7El9aOE+?=
 =?us-ascii?Q?mjci+EeRRVyl46VPCCdefEe6iy0v+Glnuydb0iuXsmEWzaZUmKq+H1glS1hg?=
 =?us-ascii?Q?udE1MhMgufL1QuIbmVFCTUwYt0Obcqp6wTNEg5CuarRyF6n8doSWDI3Hjf6V?=
 =?us-ascii?Q?EsABqvcaL6sYbjSt8U7j0LQuAmocV7/QMOp2i2tBhTiRfKzaVwXhhMYyIzQD?=
 =?us-ascii?Q?ipsqDM2uJ7PzmQbtBBWuMSdmfHyEzX6h8Y+j5ZYI0U+RowlUl8c4OBKcKet2?=
 =?us-ascii?Q?s4uZZlaVT4RG3Ip4HRFG5p37ykFgmvIjGndx0/xoyrdU7OsTP00ICG3A3AX4?=
 =?us-ascii?Q?4hx4YaTIFw0sKNvLb9dc103RLehqD9/WYSdv1BgOmdP0mQAJG2jU31rtHkXf?=
 =?us-ascii?Q?IFce+MnzmqUEIBs8xLU/UmAHYpZFVAHe9qvS7ZPN/V5Bx1FHPVO2sVuKS0wx?=
 =?us-ascii?Q?lSi3bmG73WA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kltzo5hGxNdtNvCUF4moRM8GQZzrb4dTAbqL25XCPznqB6p5dDTYMmet4cWz?=
 =?us-ascii?Q?HITUENwwwr6M9zhl8lu1/cTlyxsNI/y8BpCTdYam/1ZyQiE0CQya3LZcG0NJ?=
 =?us-ascii?Q?flXi+SK//Wv34jX2OQBuiLDoFQTAQ6d5Pgxk2jFwsgI0Sd9sxQ9ZQ3vbcgAi?=
 =?us-ascii?Q?b+enIFLeTwnHv6VHW6PmnGfiNR+5c1bhI+sWFwC9yUibYsIh6Nneq5OKkuFv?=
 =?us-ascii?Q?3CEMiSyE2wwQ/quWX7nQ7IlYXRNI9Cx4ST45+lro2fVmBfyFgRFKt/6v3c8P?=
 =?us-ascii?Q?kS88cigRd+evnnGGP9rCYx9V25IME/iIhYkvIBoczFWIuFf2YiFJ6BoaWkTf?=
 =?us-ascii?Q?Pmq6JCDRpWKYHNPskaYPPsgdn4exgKAWhR46AVg4pOLAMNx05yN8QWdQyUct?=
 =?us-ascii?Q?OFB6CHjsK5/xPOupjLcM+G1f73vk6rortB8ef7VZ6acQpcPpuPUj2Ud5XzFa?=
 =?us-ascii?Q?gYfLJkJWRkYCZ8ZXG95coG1EYs8nnXaS+2zjiH05qtfy0csaAp2ZXLktBhMX?=
 =?us-ascii?Q?tJgWJzntyFOOV/AwUgq4JfTOxqui7RPNOiq1Yzj8QX0Ysv0jrji1Z7nive/U?=
 =?us-ascii?Q?lZIMNYXyIPhHHsCNCK2uv4w87ZcWIn1kjKmOH6lU+crWRrEvgNywWYOyip2F?=
 =?us-ascii?Q?mShB7L6N+s8KIEdfNyGaREP/zxjn7/vMYNGZZ+yo7FXZDpHtD7f2LED4p0JH?=
 =?us-ascii?Q?P0wWMCasqiUbIbWi3c9Ih1ZG3UcpmUTbqDsQSetPV0En9Muj0FyLmG93ADEa?=
 =?us-ascii?Q?ncv8V1N7rGu9Z3JUJ7TVCrQulLT0a9MywdEMVkM6GeurT/yTmRxKNxrC9aWx?=
 =?us-ascii?Q?y9bmADpguRHvWmfq6IRFf1Hj7s03i4myTTsNyR3zUxvMuwpnNOHhAV5dkHcl?=
 =?us-ascii?Q?8gqO0qx0CDshYhJwq57IEadknCwRI8OCRxKXSixDduYbL+qLUBRyTI44/57z?=
 =?us-ascii?Q?IMIkhk9bbZFsxf/WHbmvQNb+HBIXhUjnPrfkbGFMBx+h7tsWfIMN/MncWdUc?=
 =?us-ascii?Q?eRWPXLocH7L027T4RhW69Uo8ewdySlbIWUnAasBljo4/Fe105F51CXMP1vud?=
 =?us-ascii?Q?ImKNDvXxTQYJMkqSERVre+jTv5E7PYMG4h10lbaX7dohM2u7zks56DkJFZ3t?=
 =?us-ascii?Q?6dnrYl2sf3FWebJstj6uXVVzIx5kS0jUM4Obo8NIM2JkamiKh6aDLHm5T48J?=
 =?us-ascii?Q?1kpgDKKunCiVs8Mrlh+WsgZFmysVs3O6L8XLe01e8CyCrwpC0hjGoPoY94KC?=
 =?us-ascii?Q?wDoNjlgcnGLXeiqYj0edl7AqENxLvoN2VUZCkGZjTV4P02gCwNH/+DWNNK/r?=
 =?us-ascii?Q?H54Pu+DLEW9DJlQeiC/xM7tr43mSw1W5Jsmnx2GvfvnLta9U4w8OqnoELLD5?=
 =?us-ascii?Q?W37iaadGMid42Uwj1kfAt+mlI83W+OcuBZfP8Bb1/I+fz8hInpMMeVANBmbz?=
 =?us-ascii?Q?8jY7gX/X4buwkNcboswGkUryJE0cdmcWogQa1FEbaWn7pYi+Y3YTAccElBDS?=
 =?us-ascii?Q?G7LVCQy/gpqxgZHkpV8SVgU+jGtVJLSdEu5u7b2+FIwzntZTBOBv01P40vnr?=
 =?us-ascii?Q?lf2OI8KuryEyt10f56PLpm0WEBaXCJYPSIk8/a2ARA9YRt3xJyiwbpCqRxUW?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e3e7d0-4231-4eda-5a48-08dd9ecba49d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 16:12:43.5632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5rjcnS7pRtawSvlbGq0mO/BTsptFDQUg7kc5EloJ8rFrJII8+b7T6xXcJM7+HK+7saHcdcYuZpUFercO/WbpHIkKoc3BQBcFOjW0vI43nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF240F42FB7
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Thu, May 29, 2025 at 07:26:58PM +0530, ALOK TIWARI wrote:
> > It is locked using mutex_lock_io() but unlocked with mutex_unlock().
> 
> Why is this a bug? IIUC the pairing is correct. ie the unlock is
> done by mutex_unlock() for all flavors of mutex_lock_*()

While the pairing is correct, the usage of mutex_lock_io() for an MMIO
mailbox is pointless. mutex_lock_io() is a filesystem helper to plug
block requests while the lock is held.

This code has been confused ever since it originally appeared.

8adaf747c9f0 ("cxl/mem: Find device capabilities")

...and the cargo-culted forward ever since.
