Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ADC1D5AAC;
	Wed, 18 Dec 2024 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534343; cv=fail; b=pu7yq4KttL4Ge4SWLgjVOHYC8ltdzV4YDRos3l1gW0jF86fobCZ5fbX7nCnD0of9+yaOfwN2D9xEUNXlQ/pSV5B/0I4UwWnZqKJDH2pTCzlE5EGawNYrEXkpOyKkDvKDY5zbpzrgxONOvyir/5HwvMzDLVAnB7RQvpJlwBzvKgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534343; c=relaxed/simple;
	bh=PuTB/WN8vikrrOedKI4z6wgJgkWVsMsWGgkYfeUP4Nk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=TwRmU5jro7KOQvnc07S9tXvI8bUP4JBNFqM9Hit12XlevvEzwuHGDA4z62EMUOTPSOTBgxdWir9MlQ29PecuI5oXWSyxJOfS+RKUauBmeN1irEKqaBJ7Bi+HUzjPmDE+NLvLJeUgaTLtlevfGXuwtzF4MfPmaXzyMyPgv/y0T4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfklAZ6c; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfklAZ6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734534342; x=1766070342;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PuTB/WN8vikrrOedKI4z6wgJgkWVsMsWGgkYfeUP4Nk=;
  b=HfklAZ6cAqcKzPPrXo2qzVCImVWH4D8iBYMsz3Xk4PeOjePolJTH5H1V
   TeBsDEgxz6nyVwCoS0iV0t2Y6F+V3xfBt2vRTJD5hcFihnzYUtQr9rWIZ
   0kJ2Ou/G8uAm8O+1EFR1U1eTOm/T9ZsT/Ry08RxDqKhGHGvatvQtyxDmH
   IzmCETpAorbKtrKRr1njvg49NEdqhwC/YRhu76olZY73EaclqJtQo8qSa
   sMSw4yRO9xYb8EzyzqVnI+rWz177M99KdYpp+j6HWRSD3RU2wHqdC0l/t
   IzwRK/apQUT2dyL/9fTD3NYFQfftUMGKnroxFk2foq6DTwLAh1Js5kZNF
   A==;
X-CSE-ConnectionGUID: tEBO6IapR+GKW6WucMc9Qg==
X-CSE-MsgGUID: 3ONdspyRSrSA3DOY1EGYQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="57489539"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="57489539"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:05:28 -0800
X-CSE-ConnectionGUID: UQdROQJfT/2itRyjfY1f5g==
X-CSE-MsgGUID: hbzFwVajSquTFOvsnKwjcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="128681127"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 07:05:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 07:05:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 07:05:26 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 07:05:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqXcqrZZ7SuIPiw/v71fvio9eSsExd2qNFWqfCOdTBmtgof7ejT6DlQ3CV0380FBgF+YetgGwQ6adrWyOuSTOpzAvscrGNQ31GiDSDLJX2WiyEpnNuaoxLUnXzv2MOT0ZN8xdfuGmLYaP9K7/Aki3VTCOaW7gMLSzeRuIO8U7mpkc5aZGj3M7xn3pAm9gAyAEU5/9jzNKP81pN3REVvUYjbeDKgs+aLHvCyhJ1+pgk9ED3NB9G2XwZh41uIyzQDX0hnuhRzg3eKI58DrwktbtDJHWp1YXnqoNmGpeuiPgevOF6smG6TBpW7KHQjXbWKaFdszMGuytC5OlXQ6rrpAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi56wIQU9AUS3TJFSjSzqjE2oxlEluGBpKX2pSNfC00=;
 b=Fm1/m+m2tXNJKobja1GHorKSLEZyBx2NT+KGNXdoIOwClEL1cYrSR75O3MjyuXR1VDi+LxWni2zNhLrcK0Lx9Brnb/2EczJFwomqBRxoNg+KFGq3OtBT0Y5plX5US/QG55HyZexSm86plYDpUp6Ml4zz542sxa1QFiIIzHBh8WpZWuwUeGqhPqUgcqYgpb6UkCGWs2T1LtpIASGycJyp71Q0hjEyteuqXX9870AuCTgMoUEathGsgDKfx1uUOUXCUxzaTxXuPcV5J+l2O0bhGjSbh/1dEQU7inhj1SaOKXcvNl02dlm+qdTJCaaN0XKc6Kbq7uolrQll+rk1T0ujPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19)
 by SA1PR11MB8541.namprd11.prod.outlook.com (2603:10b6:806:3a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 15:04:41 +0000
Received: from MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::a7ad:a6e8:fced:3f24]) by MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::a7ad:a6e8:fced:3f24%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 15:04:41 +0000
Date: Wed, 18 Dec 2024 09:04:38 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, "Li Ming" <ming.li@zohomail.com>, Huaisheng Ye
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.13-rc4
Message-ID: <6762e48637297_2bb90329432@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:303:6a::25) To MW4PR11MB6739.namprd11.prod.outlook.com
 (2603:10b6:303:20b::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6739:EE_|SA1PR11MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3ea39e-b67d-4a9d-b1af-08dd1f754c8b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YGPNFOyjFLlfU8ppL14vkZBuDQCJs7mq9rdjjssCW0lX+YoyRCPcWk4y287e?=
 =?us-ascii?Q?Uyh9O36otQ1SZ92fj2gAWsOaGg2iAS5rcJX2FkNp9ytt50I4It35NgLqtWSF?=
 =?us-ascii?Q?VcRYnLU2/UHUEZSVBdEiUDKsJo/TJxukJnkXuAZ/rhww9r0z/5Q6R5OM5kkM?=
 =?us-ascii?Q?GpW5aJpTO5a/FrFKPkGF2SzheTyI2Yg1ti8OUhTAUMP3F1qt2tycRPn42IRC?=
 =?us-ascii?Q?kI0O3QX6pwFCOCuyAhq30amWArUSpkHtRhynJmR+jc3A84KeG3bXVJuRxAiS?=
 =?us-ascii?Q?5gYwXzrTugF51IhvnkYyqWYBWfGNjYkbvq9ifPItx523YbMe9Kk/TPMayZMr?=
 =?us-ascii?Q?pi0nTRr+3MVq20lMewc+27vtH9niLqHC437rqi6gySp2noh70T6/Vjg79XP3?=
 =?us-ascii?Q?PKWV47LxMR9/Ci5rWnD2cuxFIRRHFoB9BTZKeh6MDPkavAtMNquol7pVbIMi?=
 =?us-ascii?Q?eDQlvh94wgeMrFFLB6w//BHKDi3R0sfb26mxkqNpUnNe1EoR5+RyTN2GzNoJ?=
 =?us-ascii?Q?WFY9qthDVz73pucCD21ku2Cc7JasC47PINjyrdfKaoKvta6VtGQ71efo8XPu?=
 =?us-ascii?Q?r0cmmrzYy07ZnyqX5ry+bd6srhRADlRr2dUsA62iQsO9qucIv+10ntaRMOSW?=
 =?us-ascii?Q?/oJBu5bYBcJfhGNzsBYKoaXvl1nyMErs6r+g0A4lMp1WWBUjZZp+TH0k0kHP?=
 =?us-ascii?Q?UODgRHE8gbX8Qs9TD55WNvCjG+Gt2MUS+TVHDssyA7rw5U70/khgNb2e/P0W?=
 =?us-ascii?Q?gP0HyRYYiLNJMPH1yGZ0oMNHCsdVBO6MAi8tip2f9c5XxPv7uPqbWaDbQa7B?=
 =?us-ascii?Q?YdjzeIS0OqsULQGZmUNsB8zRib6Rz0BTbbJZGT6L9EdfeMTufIx5RklliP3s?=
 =?us-ascii?Q?TwoNl7DFIyGT+boC3S4H7AKCnKm2qjliU3xUYo5A8fMYxz95e25vYB/8byMK?=
 =?us-ascii?Q?R7LJTOJDPeVjWdVUarN+XUtSYOTj5ERdSwjFqZX41ypbwHjw5RIQGnlJ+uDC?=
 =?us-ascii?Q?de/FNsr1buw35Rw326kqB04qjOcazhl7bFkQ1d5kBP6Qa/sneSgS3LmjG9oK?=
 =?us-ascii?Q?ThA0nD+HGqk4kPm8ohl8Xhh/yOnPeauLfmgK2CjFvx4dlSES2jHDssGn9Gkb?=
 =?us-ascii?Q?XjQlbvL7326MAg3qodhhDyLJFk/T1mkg2wBGQC0LYzMUGLTKOh41vjffr8CI?=
 =?us-ascii?Q?ftyRtD9zbmbLBGusXWiPxwC3cAYRfRoAqk+vNoH/NCJvkZ6h+W+dbOZP0hlZ?=
 =?us-ascii?Q?9dTp8jDtnMvqM6AQNGjYXWrVgJGoWUGfOnowEbYhuuCFcDzGf3C15DUGkglx?=
 =?us-ascii?Q?Kc2qX4mI7EJ1/4P1F+U8tsxzCUxYOo0lNM7J+V8FipRHjJvoIm6iT9/u2jEF?=
 =?us-ascii?Q?Fffv4kS5rE0Pb2muPoSOvNFS6G24?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sN3M53Bot8MCg6pQ5AJdlBYXCU4omWQFIZnq1pEY1OLWgoauoi+wZpSaMIho?=
 =?us-ascii?Q?t7ZvnOPz8BMlGcapxc/lQu1cwO1yoGnC2VQlE/7hqhxBz9v/MpysspdxOfZh?=
 =?us-ascii?Q?5jdUe77n8Swbzd1w9Qboud44u2vWnGF8jUEd48vLLfk7aHL5nrZCse+bW0jA?=
 =?us-ascii?Q?bBkjrC0QPdJ+8qN5x8tQyydnikq2NYqiQ7fxkIxfQSN2mSucpC3hAvAqbSZe?=
 =?us-ascii?Q?wPCppNktGP7dOBAATScXQISSpHLPPGtPyCLqiB6kQ+UggVjgDm1UQy9TgC+M?=
 =?us-ascii?Q?1nw3kSDowtKlMV+ffeLe15dfry7Ul03lEZf1HmwKVMyGTg9yBf8nkFWe1Rkq?=
 =?us-ascii?Q?ybAi8kyk58R5ilXZSYu7mF3k0JABlI5MfnTkoKwfHshIEag1VMVlyLevXdHi?=
 =?us-ascii?Q?CSsIVLBgFWEJwhvwJ476LfFvhTYdhAitKscUUrf5VQ2f1+3jpjdW2Rj2Kw9S?=
 =?us-ascii?Q?+SGxPky1gJcZMyXotGNAFC9ze69SdY1sHZmatIkPItinam3XNy/WnwNuyr+2?=
 =?us-ascii?Q?KQLhfOUGyFfetCi4W547yHqO+5aFj9+6JLv8h/FzM64HDLZ504gQ4oRDpXSR?=
 =?us-ascii?Q?6hrNq1w9w+WpvS4LN+K3ojpPsaMqiCVuCj8+Z20wS4+0/ZmLlgXcJwBQN1O6?=
 =?us-ascii?Q?HB28bNdWRVlR89hlzpCbVoyF0gvzrP92B7S4Fvhl9OfUPeArxYvO6iopVmEc?=
 =?us-ascii?Q?b0cx2PNlrUEpdLYnD2c+tmE1PtHViJajTaZXr99zUerBR4I5n3+ULgqbeDth?=
 =?us-ascii?Q?VyhHb5EpCPEYS3buWaQ7gj3GSL31nGhqpIk2SX38OkkNvIvSsEry2lX5pfBY?=
 =?us-ascii?Q?+Kg+IYvXEIrTYJlk9i274gLkZwL7qwqMhM5bx7Pk2WrWaWRslkOGF/14Ykle?=
 =?us-ascii?Q?yu+lo4S+VwQ8f3LAT1upi2nAvI8aHRk83saj+MyGMcH/ZM8XgUG9x1Mnejdd?=
 =?us-ascii?Q?Qohe4aA6m8L0bpDU9Qx7R5EfY9KjqHGq2AO7wRO/y9XHIy7JePwdnsJDWSOq?=
 =?us-ascii?Q?ddulBrnIJt5vrcNfda+trUhOoWefSR8NO5HGGqC1Mtc+uqJEjrk5IOfzzM2h?=
 =?us-ascii?Q?BoI+6UBGe/fKW1Eg/5E+1jNkqLsCD9T7cOZJOQcmcpZR2vXDqQBcO+fOJhds?=
 =?us-ascii?Q?uU7f09eRfcd/6L2QHyV8GBugGH52uzfEMxB1Ksuna746z2Mc93+2tFnM2I2j?=
 =?us-ascii?Q?FYJwAKXtaDbUL3upLXPrKlC1r+7izc9NAC/vKgH24nGnRQpr+YortUWbu212?=
 =?us-ascii?Q?sepxZdejpgFYerDNz2Hm0tqTkKB8Vu1+SaBebb8gz77U3z8pbifOxcSymv9y?=
 =?us-ascii?Q?RUxuZJtsoBQ9EbHh+9kWBDrFW1pP9TQywzymm8Ge96owiNGjdZTIm6Q51uKf?=
 =?us-ascii?Q?5T3b1sI9Z/tT35k+y0AwlxTxBijz//r0QaKGaDmMSK6TgtbIbVSNNGeNc4l4?=
 =?us-ascii?Q?wx5DViYth5r6Ud2UZChljZ7GjQrac6yQH/ech8jl/+e6uBO93V38M+MWe7gz?=
 =?us-ascii?Q?zyf5YFIrOXyICwNhJhW0vIWtfO7ZA941YZiS8Un9RXtpAPkmQRmIB21CqP4j?=
 =?us-ascii?Q?unHTAdTHrJBdYyKBaLpaR734rkspTO5TSJdQPiWO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3ea39e-b67d-4a9d-b1af-08dd1f754c8b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:04:41.4781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0s33y0CTaIgTOhFpNJpwTRZEyWWaz5ae7Wk/5EbHPsQMYPKKjGIV/oY2w8nb/KaOkTNeN7thEwhLVf1thjq5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8541
X-OriginatorOrg: intel.com

Hi Linus, please pull from:

  https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.13-rc4

... to get 3 fixes for the CXL tree.  I'm submitting these for Dave Jiang
as he is out on vacation.

The fixes include; a fix for device probe, a sysfs issue on CXL 1.1
devices, and fixing region creation on greater than 4 way switches.

They have been soaking in linux-next since Dec 12th.

Thank you,
Ira Weiny


---

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.13-rc4

for you to fetch changes up to 76467a94810c2aa4dd3096903291ac6df30c399e:

  cxl/region: Fix region creation for greater than x2 switches (2024-12-10 14:50:34 -0700)

----------------------------------------------------------------
cxl fixes for v613-rc4

	- prevent probe failure when non-critical ras unmasking fails
	- fix CXL 1.1 link status sysfs attribute
	- fix 4 way (and greater) switch interleave region creation

----------------------------------------------------------------
Davidlohr Bueso (1):
      cxl/pci: Fix potential bogus return value upon successful probing

Huaisheng Ye (1):
      cxl/region: Fix region creation for greater than x2 switches

Li Ming (1):
      cxl/pci: Check dport->regs.rcd_pcie_cap availability before accessing

 drivers/cxl/core/region.c | 25 ++++++++++++++++++-------
 drivers/cxl/pci.c         |  6 ++++--
 2 files changed, 22 insertions(+), 9 deletions(-)
