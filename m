Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068EF34252C
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199727; cv=fail; b=figyXrdRMNuOym9CSqRDsJvn3aW9/Pg1qK9denLQs6Gon8EMG2AgRO++ijOOXy94/HOog2iRlgtE/uiT9gcXC5c6HJaHq90qD4Y2zdnsOfNJfZxVkOU+kTh6t1qfi9I5M6oGhsugasF2nQTv8CaFxL+lhT1WSBryAQocxdTaiMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199727; c=relaxed/simple;
	bh=a1iOhmk13AzQeb10WuuRofq+1s6QfyOl7WA171UGveA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FH7rgfuj5FK3qL3j9vDmQ9Ha7q8Sfh0FNW3g3h0/OEljIEGgWh4Xa6GTPTf4Go5iO7lXyiIC97gveAQhHl3B7fQaIRopcMV6Kf0G9i7YlvDjgO/81FCoZefHXQOvjKXKpYo+XAFGK2JjpgIFYZdpbQ0ZmCOMPw4dA4vyssOaZi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kxr++Yc4; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kxr++Yc4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781199726; x=1812735726;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a1iOhmk13AzQeb10WuuRofq+1s6QfyOl7WA171UGveA=;
  b=Kxr++Yc41TAXJ1WaoRu/tVRAqR7raoBn9Pjbl5MWFR83MRCKwg/qVbfB
   dBs/iitBtykp5GEJEvcf36sDfT5mD4wJ4JklVJNcNlMmYMlGIenYdMJ0I
   BQKpz+JAyrQ5f7J3Bti4K4fEmcJkPwBRcua8f46X5tIS7RdUa3BRuwSUT
   tJkO7KkRJTXhw9LU+7Y9slxNAomWYqLH0ScGMt93NIzJQy67LQnNTB5lE
   qtg6Q6ocGc3O5hJlXGirdfdl59uAoXR7g3rri+hsbCNny7zTDc9Qj09xY
   eL8jnE2wJd0GOFbnUe461+3/y2IK10KnmbCNtNZNSRg0/arEhYoOaUtkm
   Q==;
X-CSE-ConnectionGUID: DvEgtN+gRzGWIoICQx1MOw==
X-CSE-MsgGUID: xwD7GUbqRI+D39I5NibkKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="107457077"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="107457077"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:42:05 -0700
X-CSE-ConnectionGUID: 06lTN4r5TQePuVHV6wdXUg==
X-CSE-MsgGUID: M6AtAX7FTr2oJHwxZXAeZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="243613502"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 10:42:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 10:42:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 10:42:04 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 10:42:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUT69ag45RvoJdPsCCMrQOTOTHRl7gHJ3Ki5TN3uVaunc/vDWrSuI6WI2aeef172GbG5/V/w6On/ewdCxnw9eQf0Q9CsuegIRuHERCRwRQ8/wsZje4fDj4LqhPfz50ig9XlaRXocTMymX3Fz7cQ/XOJ4o0v1JQOzPBx+xyUDEfbSEQ7hsmI8a3dXUuAqRGUEhvLNfdN4361AD+GDbHU2wPriVsqEfQQVk0GoAIk2XgtCH8tSmSD4DOyEwWggxCxolobyTZz0us0sQFcExEu7QlGXWf0D/RQ+5PbST5ZH+JnkmMa+QfxyC80udy9wHWp9HXkRMvCQmwcLtf6txz41cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xra1C/ZV+b7tdCh7Fk8PXB9DdcLkcfetTGjDlgLHois=;
 b=t5IURfw9xBuU8fEKo1CqB4geltYOl/M4Br1V9JocDy1n7xGg6ciE3FwJkLtHL8lN7fCTQiIQnCV2HoJBQQCSI3Ymt7L0oQoLEfiFQBuEkpynvk44gGXUCgc/1n3a+Oy/NUgiyzwgoAuHzs3gzVTrVaMT3SMJohTK+0ivBMrup382PdM9Ra3FbXQPRl/pKWK7clJv4WFqaXXTDx38tG3j84qoEsrCW0s5FXheNk821fQj1NmUt/aQh99RN4H8lzU1p2pK5NEsH9WKeGoL84kuRmICEYGZ4eSO8pN0vTYz9SnCoW24fGfkYYTA4cJogmB0ubOVDnVvIfI6LuFvDnWr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 17:41:58 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 17:41:58 +0000
Date: Thu, 11 Jun 2026 10:41:54 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
	<oe-kbuild-all@lists.linux.dev>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 6/6] Documentation/cxl: Add region granularity and
 multi-level interleave guide
Message-ID: <airzYr3NdWYoUDoM@aschofie-mobl2.lan>
References: <ef2ba341a7ed6f754012e11110750d57929575b2.1780095671.git.alison.schofield@intel.com>
 <202606041115.8RwB2Cuv-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202606041115.8RwB2Cuv-lkp@intel.com>
X-ClientProxiedBy: BYAPR21CA0027.namprd21.prod.outlook.com
 (2603:10b6:a03:114::37) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: daa51d7d-61ee-4882-9951-08dec7e0bc7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Klj9NV0ZcanX8mi1tBdRBmAdvMcizeyzcXe0e59KVMG+LFHaERk2P1g9GGcrL4MOwN8UU6UoIZlvxYRK21Z8dgc93ji3afLuVzYmG7lZYNCz5aaUKqjP+6VvIqWN8aErm+CuNlbP+ift8nt9G9hcQByKygfZaQFFJoJ8F99o2UyVGop9JaCLH9TP8XV9WkZ7NFZMKYj1US6J9xQnyihOEle0mia3ezed+DoU75ZYGBSUM/hRIDqz6ydUu55WEIujYRTDSoneBjvDguFfWNfi/95snh0JkF1CQIZ1Q9wANDpF1SaftoeAiuTlXcTaPZxDtliloj4sdZgF0Rd7fzfB2tVXULFvLYRL1PQD2Foj87N0MtNNZDzjbQ4zM6JKyqjuKeGbmBN/PjGRlS93HYxa7DyJ7NVCMt4XHOCOTBtRnMdzlUB2fHqrQy34kINr9tplIj3rh4MsduyoIle0EP2BNSrCefrK7jz+3sw17w1BzvzUu8uInU8Vu1uX6k9ItE5LbTuJFC1opQ8HEpqkdZDW+SSQb3wOMcElhtNg6cKQVkqx/u1I8XRlvzpMkPa6QOiJZsmXxTbYj7F2vafVrSLIrDsUz5CxHIQ2OHuh/lJL9yvhq6SSNQiG/N3mid535shMMgnSm5Iw1X3cLYkPM9RGiFcYR6VQp/EFPlSA8u9UFppRN+r8e4ge1uKM/rff+l5S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NETSxavO26364q0qATYCaKReGgp26KwCZqvxp7pxbRhjCrraQlmTtX/I1FGU?=
 =?us-ascii?Q?9MvMBqKWsTTTiQDAcz61/1wORBczIkljtBnXBi9uRrmVEyiFL+apwTV90Gpn?=
 =?us-ascii?Q?wYFrZyv6EN/1KwV2QzMcfV8U7zj43VthM/NbtKg1kCnJN3hxcvjVRXF3o012?=
 =?us-ascii?Q?EO8RBXs/pYU83fr1pw24FnaVKWftHenSR4Qp4njN2WU8e5B9VX1/JiGK5PUO?=
 =?us-ascii?Q?Jd2sbCZw1+ZFvpIncco8bSMryg4S1t+XvVIZMa/WZa7USfmLbhmK7tR/kBxJ?=
 =?us-ascii?Q?Hdx4f9gQXpXqBogOJ9XN1uza0D+5T8aLKBFatV2oQyQUMKoVGab5ewfWDOY1?=
 =?us-ascii?Q?QTCpySa9gYzlgZ1IHBCb4gB3S/LzRsN5T+W//bC23VoIzk8meGbRiA+Llo+/?=
 =?us-ascii?Q?WfjCgxabGxRQJQe1/EICHN/EoYNhgO4a0xQF1Scn0OQD3DU7G+PO2YTOGLhR?=
 =?us-ascii?Q?pbVOoZbA3W2EAo9YCDP2uvDeJ/hbxPnlHh3SohD2SxPKtJ9JKyfacON/P1x9?=
 =?us-ascii?Q?MohLYn9CrVU/eCA4f1Y+tMOY/kv6h13pH09UHS9GFVfuPsm+0WmCca8rHmoD?=
 =?us-ascii?Q?ZYYNJ6Leh/+2D4g0gicKsf6r569wEDkvblT8L5LgDsrDH35vVchK323OvJXQ?=
 =?us-ascii?Q?CzgTI+Ok9PxkL4vhb/0/+YRj5VojEWjNxbEaPuT+bAS5El8XhUHrZdngKsO6?=
 =?us-ascii?Q?I18UROBod+cL4IVL5R9ZvuinFsuUZX9xadLMjOANfGv9EZ4KZuYqWZ1AROKA?=
 =?us-ascii?Q?ZLGv23gvN2DrWnARmhfKJtzimXIjB/ujLoeoltxu5bJlIIAP+RNdP1S+1K0b?=
 =?us-ascii?Q?up0Qi/2zpAyw9ZPvWOIs6TKPcbGtjM5yZcxnfgZ/CPelMddjiCD9WsUz3srJ?=
 =?us-ascii?Q?S5CCKcdniUoMuQHItmhZuw15WzHVROLG7scKfVE5jEeExj4vC3SGR++5bt7M?=
 =?us-ascii?Q?8DT+am+XPmPID/ebQzWmNwOYOZlEWCgvrSeD4h77W2kXt2wjDxwOuQMQPOjX?=
 =?us-ascii?Q?MSPq3yrtOWGoX3tz7GC0NfswUqGmx14vq4eH9LVyFkNAC3EOTM4pFq6vCH38?=
 =?us-ascii?Q?fg5TgtLpA6moHWRz9KrHgvq7w7uYAZ5Y2wAtUszuQV8t+9by8JCB0cdZm/8f?=
 =?us-ascii?Q?I9gRwokqaxOMAAs1biRkext8HXBecBz7kuC1V0gGrBD6G9LDnJG5zQbhcr5h?=
 =?us-ascii?Q?NV7eK0hWpatQ5C9qxyDBtpI1kmOW5I2g8LEDFgG4fXXvTOEm2LvORlodo1N4?=
 =?us-ascii?Q?84XbTeLmI4RPpVKdMsnJKiJRKmjFoTlC3X6j6gByQwxGxla25gfm6P7siYVH?=
 =?us-ascii?Q?poNPyeCDthtw1CLHYwFwbdPBn1wqPMGQK7h+dBVPguX6dJy9xqoWE4CfSODp?=
 =?us-ascii?Q?dWZO8HmqAzA1gMH5LNSNMm6pdTufnw2eEqQWJKabsG43C3zkS5Sweao5pFqe?=
 =?us-ascii?Q?3q1I77YtX/iO3mRKWNWGrLJuysAgI45Tm3RCLGIUY2ATjewh5xoeQ7hoXOTA?=
 =?us-ascii?Q?h8WMvJRcIej202Nh3/PbTEnc9LEKcmX8CXlavyIoOJiwoCcCoqFLOYVdp9Vk?=
 =?us-ascii?Q?HWq4J8kjL7FHGNEYpJH9D6eTM09tipcgGLEIl2swwWHHb0wqoEovpK1JV3ER?=
 =?us-ascii?Q?BDxB2JhB/3z50NqDlusoiEhoCskcBGQJKHCje6lMbwTLa09a+PdeNkzF3VRo?=
 =?us-ascii?Q?jIMQnP6In6pZn35lLqwRmw3ZSAnx0BXFu2UTRwV38xR4jH7gZ9bVfJkYb5dA?=
 =?us-ascii?Q?LnsOSxCQKXYoYBVbfGbOHhPoxX4lk6w=3D?=
X-Exchange-RoutingPolicyChecked: BT7mmlyQUUphpaUsnqp9X2/4yTzueLdfmjVdLg/cGZtfGEmKC0oc97pKR7YiCYj6xlyROJw7jXVw/b6zo5d7566n97JU+l1IsijGZxXrcQuFsVHzq7+qu8zrKb7xCeb+jOykObBfhMw3f746KuXgObZA4VZmpxCKdn1ZxnT5EtU2eLOyjipJ6fe3JocWy5wtBsySO/MGCen4ROzQxM1B2j3bDQa1jxQz2ezfBMvY/nGIqihXP/1MIo6OuMHP45DSttMIwsmkMoq1pbXUF6/9Gu9qOn54wQbm0rowXjiVT7Xk7blNKrVkRfRrKzlFgk7RhF7av5I5osci+8r1D87fwQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: daa51d7d-61ee-4882-9951-08dec7e0bc7b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 17:41:58.3775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CS73myJO4RBOJMokPvmEkAfU+ojh+p2wzYoD+dE99T/Ziv+C9YCb+YzxtnSWs/oeW8CbBEn0pCKTu7B1OgABuJYNIxc+BTKnK3TXvpojFiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7772
X-OriginatorOrg: intel.com

On Thu, Jun 04, 2026 at 11:47:45AM +0800, kernel test robot wrote:
> Hi Alison,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 254f49634ee16a731174d2ae34bc50bd5f45e731]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Alison-Schofield/cxl-region-Validate-interleave-selector-bits/20260530-080529
> base:   254f49634ee16a731174d2ae34bc50bd5f45e731
> patch link:    https://lore.kernel.org/r/ef2ba341a7ed6f754012e11110750d57929575b2.1780095671.git.alison.schofield%40intel.com
> patch subject: [PATCH 6/6] Documentation/cxl: Add region granularity and multi-level interleave guide
> config: i386-randconfig-012-20250916 (https://download.01.org/0day-ci/archive/20260604/202606041115.8RwB2Cuv-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260604/202606041115.8RwB2Cuv-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202606041115.8RwB2Cuv-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "__udivdi3" [drivers/cxl/core/cxl_core.ko] undefined!

This will appear fixed in v2:
- Patch 1: Make divide by 3 in get_selctor() work on 32-bit builds) (lkp)


> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
