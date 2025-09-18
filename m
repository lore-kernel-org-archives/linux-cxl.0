Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296B2C028D
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218756; cv=fail; b=U8B+qspo8Yt/8UuIPm4FXigRc/ZxUc1Mt/MpzcYNeVjBA5qyMkR/Kko4iE/RMgdFrMUQs/bxwPuWkR60WYPBfEICQigWTRFzRKPcaR3IdLHxPH+Vu3oDAWWuRmpS4MeIMcB3oMwEbDHjCQpk/fRQ9V0sukLk/nlN1qVs9xzlnUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218756; c=relaxed/simple;
	bh=jSUODxAUB1qo69mKXZitEWMLaxaYytlmonX4RhdOFgg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pEXHzeWzCrH7qxu40MkMALouWyPBWu3l4WdHeaQ8WJtXRhO1JibJAXt1tii1p8IVrwv6xWC8VY9Dz7GYz80aZjkzMqTN1KDRgDHghUGHvjPpCxHZjausg3TEi0vW2WoeGDOLIYWj4I5rPJYgo8XAuQ8pyHgqLSWjRJ4OhbS2GJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7rp4U5n; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7rp4U5n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758218753; x=1789754753;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jSUODxAUB1qo69mKXZitEWMLaxaYytlmonX4RhdOFgg=;
  b=K7rp4U5nhaNjOW0vxCrLe/9jEHlYjhgFGVFHcVMjtf4nPYhbIbp7F1hk
   5fKeCpS1jOpsvjWViHukiWNcbXs6MeeAurwXe7+sFqGs/BTDeJ0QPd1Gv
   OHlVHQ3t7LAZpjKm8JsafwbW1cp4SgbitpKouAvVKD38e/JuWWM0ixcqH
   KMu73rLH2oZyf1TysH4n3E0sY5DS7zdTlBM7SD2LBGniL8moCLiQjLoEi
   nqjFR6hd14seiwP0PGSCRCTBSklTOjorbu6a7D8rPzhvOou4/LGBCgcCD
   Ao5CQ9kFH3j6hZ1HoIqVrIkk+tI4M0ZhYg6DmdvgViQctDQQDV1JzMXEM
   A==;
X-CSE-ConnectionGUID: Xb0PLT1wT1SbiBZ06tG35w==
X-CSE-MsgGUID: oNFa4oqXSkisu80aI+8QHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60449760"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="60449760"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 11:05:52 -0700
X-CSE-ConnectionGUID: Hq93VmZtSXajt3UW/wZ8Fw==
X-CSE-MsgGUID: ddO/qHaITQeq33ps8Kghow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="175434248"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 11:05:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 11:05:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 11:05:52 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 11:05:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddfH89twiuIw5DP8O/Qa8BhPyoGfZYOcRhmJAIhO7vhpCw9q5h/rQYFp/dKJaVYPaoCmLKRgDOYGuMCWq+9691onE4wa7gi2IW9DtbN1BFZM3bopk/+L2TuAHdJ+Q7h59saD68Mxx7+A/xCinio6uUs+GMVzZbNUDC8a0Z60r5DREl5NJGbStgpP3t9TueyX2WfiDz4ySUuOqJul4C49eEgfDhPWG6WW1Olg8Qv3c0O6Uw2uxKamZGVf+6uaJW/zB/Bawz7cLddEJ6CzOTcs/+4GlltaXZ19JX+whwz+eawYQcsPwp8auL9Wt98ylm0NQoQAdqJIzhdaKZYPNZgYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e29rpc81ywu6DE9KU0bTmvlzw0GSBiTico2EgY2Riak=;
 b=jhz3Xm1hSTEOoIbK6zVqeZYZ/394gGDtAiBq7VOUn9rqU395oqiQTEpOCW4FpH6zfLmD+oaUtV1v75AVWFpbEIDxaqWYh0ywsqDsImGf4XV1qpvLvUvz7rcw9SmPHzFJ7OYLYJ+RJ1giClOnoxry0KnqFlUeAnRnC0eRvUtU37clL/vqEmGNpJv5cTHNFcU+sSO1KyU7o6u85uJImgBbvTEOep2Kk2vkqNDNBAOTodNOdhbceXKq24jHrCozGvDNwqdYAr5Pex1P8fuonM3mdZ9Dcox17dc2JFakQrGSEkG+xDN7oFeOwqZmRcaGscdvk44PnHKfDnHILwkjIspwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB6424.namprd11.prod.outlook.com (2603:10b6:8:c4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.14; Thu, 18 Sep 2025 18:05:50 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%7]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 18:05:50 +0000
Date: Thu, 18 Sep 2025 11:05:46 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Robert Richter
	<rrichter@amd.com>
Subject: Re: [PATCH] cxl: Move port register setup to when first dport appear
Message-ID: <aMxJ-hx0qC_Hjyya@aschofie-mobl2.lan>
References: <20250911204406.2454689-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250911204406.2454689-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR05CA0114.namprd05.prod.outlook.com
 (2603:10b6:a03:334::29) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 964690ba-3967-40a8-2955-08ddf6ddffde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qk4L9v1XgjzZj50UB8b2ZhwfVwJhTZxvDCtWZOBle6+dLjt/YJIaTFznpate?=
 =?us-ascii?Q?X3crTvdLgKVaFjPnC2upZp+LAemxYh0/aLsFQy820O+1oUrA+Pkb82gS0LxB?=
 =?us-ascii?Q?QSIreNeT8WLPnkR+zaGOZBtV8m54St/mzAdhZWJJY9/xueOZGA67JwhtjYwC?=
 =?us-ascii?Q?0ORP9Gi7T8WL8+ZCAEcD5okP4aWztVnNNFODQWc4lvDMGZ1emmycpg9dbeSA?=
 =?us-ascii?Q?jWmhRahr1kOYp6W7lZcdbIbamwBdRODRWuSZfKpYQtsKfL3Upaf898b/AfNi?=
 =?us-ascii?Q?/reOUFwiIEb4515wio5mmwP+X+NJaU6YNvx1LU8Ye1yJYiANyaUOIRsN5Abs?=
 =?us-ascii?Q?lwBLePrOSj5jufF2TOc8TpTq8D8GVNHHoLIAZJOcjG2HtvP4zJFWzUVDElc1?=
 =?us-ascii?Q?dgDq+cQeP8Pl4ltprOXZw3mtmkxmjuig6i34OfMSGZ1Wg+gsBzDQGc+P04qP?=
 =?us-ascii?Q?kLT5cVXCwgoPmj0zbCO3wprNxs0ApLFeurQEj9eIm3hlXv/1J+w35Tr0Yfhw?=
 =?us-ascii?Q?6GtQLedHFb/odcQoFxWgW/RDY6GHLeqnp151SiRm5mAleNFE0tLIlTWRk4MA?=
 =?us-ascii?Q?OhuFjo+IhVAR1L9xYBOGf+JHa7vGwhX8IyCOEFu9jKeHon65A59UNL8Jwwmz?=
 =?us-ascii?Q?KBowWHmNA/aVAbiL22HbUr5vLtrg8zp8twswtyxkhMRW8ewkURhjeoC41etN?=
 =?us-ascii?Q?uyveIJttLLcyYmLf4AgCZP2oZSBbRF89z9eNuM3PU+y9lPAHYxwenwvpxeSm?=
 =?us-ascii?Q?A0m/JVmi8ZnLNhlA2GWoFf98/0yIoCc++K3LRs82hqJDLCriRP0KqaSOnsN+?=
 =?us-ascii?Q?3kZcesiP1WBg/Mn+Q44h/SNTPehlku1b0B8NcLEXPSfsF97g/GJpTQ7cBNCV?=
 =?us-ascii?Q?UzEcW1IJd+XEbeQXOfFQcbSK75Ii6nvAZNBPJ4lAzPVQD2Mu7Weiz+h8xijC?=
 =?us-ascii?Q?vfrdo7ho2cWw6NnzCmVWAg7mX4ANF6TrHLuCu4S8QJUPkVhHPyDCfXRellM7?=
 =?us-ascii?Q?skXNd6UdJXTitCu/RqcgRlsweh+0xjXnfd8ENw2EjRelNZlfkXJQUR7jPuju?=
 =?us-ascii?Q?373wpGN6j4nOF1WYGxZpTVfSCDfJq6AbLsZTCsEsJYrZ5of4XzjsskHHAHlz?=
 =?us-ascii?Q?SLnLUqPkDu1pldTaDhp4PktCt8Qc0ctEKH6xnytgmkASMPqu7imJH+KV+SXq?=
 =?us-ascii?Q?T+Rrpbdz0597tW40VgTw7zaSYKMfiZL08asW7BWQlqUwXuSGFmfekSo6Ezhl?=
 =?us-ascii?Q?QaROu4yFoeoyLEDOsYE9rmicKbbkXPFDfPPrrLKIT8qQiW/jJWvWe1Z9o+y7?=
 =?us-ascii?Q?Pm+9wR470oqdU7PP5kzTTt2odoooUoyeOBlvPxrQH7Ak6ZX1oJ3dJ6bJrPst?=
 =?us-ascii?Q?l4//76qYBZxxM49qpD244kV9zhZbFr2w39FXOSAePOrda92GeI1iTTl/ruWd?=
 =?us-ascii?Q?flIDkPAoIjc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U3Zbd3giYJzfOpmg9VTBxc2QNaEX4T2ofNKnbzmw8G772mwMYdXcIRk9yfEd?=
 =?us-ascii?Q?WHF40pOek1MS+rtvL+R9HWFycdi4EsLGir+5VgENzgrfohIQIvk6qzB2CiEa?=
 =?us-ascii?Q?5LZQ2JVQwCJq3+d8+ptIXAzf2Yw7G4BMhpoe2eSwZdkvMz6EkrHi8k1WEjIy?=
 =?us-ascii?Q?ISAHM3u7lBLP1ue8ISQdtcZFE99Y5v1xCY7W5H41m3JJ5QwoSzdONNJcNU6G?=
 =?us-ascii?Q?QWOCjlUW8WykeLRJxk5o8s8gAYRGTpFvbrOAwc4GKiGWxUVpU3N0L6vREgob?=
 =?us-ascii?Q?3P0hYBkp37FZ4fnpCn/A1Ob6CVF1Dr84iObyAR/kXU6YZl2E2KP/IboFRPhe?=
 =?us-ascii?Q?p/bX9PT9VXD51EuxEXX+GRKEmsQ/4huj/3YhQuvpmP6Hx/BIQwJty2YgdFj1?=
 =?us-ascii?Q?JWal97L7XxL01BH3TBCiAjIGbS8GvKP/gRkOGByBZDtJE1QuaS/DSK7dq/sD?=
 =?us-ascii?Q?syh4YtlDLfFpSqcgncwLDqTfpgRdql3tbZzG7RJJNH94AZ+DgDTzeqGRkb6S?=
 =?us-ascii?Q?PG34nmXv5uYD0JpKWKuEHz8cxOP2udgnOw4nTM5dGt+Vwsm3LK+/hGAwyVQN?=
 =?us-ascii?Q?KIlV8EeIyI2jNM4SYX+LdMj/eKXfON1JHPEaznmjDONXwftoqCX/7tOv7e+y?=
 =?us-ascii?Q?hE5xU65GDTin0uKnU2g1LWY3dVtKmeWySFmmegWFEljEytPUhC7QoAtFYOWj?=
 =?us-ascii?Q?WPnoHWxhLG2Z3Ask+pWj/aEdMEW9p3NoAcfPAWexYcNf5WR4CFDVy7ZiQhV0?=
 =?us-ascii?Q?i3EpU3kbmjr1nwMSzC3uDjflOWJ1US1L8sOE1Y1drgMpIaVPPStxfDvWnT8Y?=
 =?us-ascii?Q?oIrROGivijtqMDUwvS2VpgSI7SLhUauzSeuctjRIHanyxpJTMhXvO6LqOoen?=
 =?us-ascii?Q?ADRNAeJKnLe35IWDDBtT6/GLvltkziufqQOhVKM/YqBHk+Tyziy+6EPAhiTh?=
 =?us-ascii?Q?zTRXXxjPmWaP44mcB7Q/bFdxRS4mMuB4i35uTFiOPixSA3tAc/FCOEVcOy0l?=
 =?us-ascii?Q?zTVSdUF5d/vA0n2jDtYV2xWsTCZ5n/EAnLt3MJ2WGMWbELPxJTFaGyaQ/jLF?=
 =?us-ascii?Q?Wf74JZ+d3OHnX+E2T3rV+RTRp/PT4UbzPv6G2w0t5z8ukjHHInzkbKkuu25o?=
 =?us-ascii?Q?XI/i3MNYGEWbYrPIWJSkNp+wOuTwCTSJmXGXSuoD8Y4q91FMM+LSVlCK5RJp?=
 =?us-ascii?Q?g/PPRONAnEfULuFNX9wuexuUAYnxFBCf+30x3jz8FKbu8HhGU74ZhN3IqKhU?=
 =?us-ascii?Q?4iHsbZZUHBPfeAeyr0vFGRI67tZdIYQWd4PrIwsSE9Jm/w+dp52U3X9OOLGD?=
 =?us-ascii?Q?eOpgqEdHSXmo+nRauhPKVcFruUAFd6NLRg9YkDwVGAMIhgLXIgvnyBI0Gy1b?=
 =?us-ascii?Q?vEIFRrhfWC6jULvFqqy9DzzKjwYSUiLfbch09n0ZxzonFVWbwVf5wKlPM6uc?=
 =?us-ascii?Q?4xOMhwlrjeP2yuZLFDIqDxunZtLzCfilHV+SfKii+6orgAx52Ha7sSprukrf?=
 =?us-ascii?Q?9IcJVJWxdnlpnBFNCdXzXKw7lO8MPs0jF+fzgRkGDzUK/mmpDm7Hv7n3WlRG?=
 =?us-ascii?Q?lkEMDLxXTLk/kgvz8Qp4ojoj3jmOIXkpJF5lKaUlxwgLLElgt5hzyMNg+qQu?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 964690ba-3967-40a8-2955-08ddf6ddffde
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 18:05:50.0509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: An1OGDSaRCj8Q+L2wVTGY7pkKq75ZXwtMkFmgqMZbgwfnt3TbazYU7IrETgL83iqh3CE2o+ZDRWKsXcDOc9g0mF9DBas255QBK6ioA3yZlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6424
X-OriginatorOrg: intel.com

On Thu, Sep 11, 2025 at 01:44:06PM -0700, Dave Jiang wrote:
> This patch moves the port register setup to when the first dport appears
> via the memdev probe path. At this point, the CXL link should be
> established and the register access is expected to succeed. This change
> addresses an error message observed when PCIe hotplug is enabled on
> an Intel platform. The error messages "cxl portN: Couldn't locate the
> CXL.cache and CXL.mem capability array header" is observed for the
> host bridge (CHBCR) during cxl_acpi driver probe. If the cxl_acpi module
> probe is running before the CXL link between the endpoint device and the
> RP is established, then the platform may not have exposed DVSEC ID 3
> and/or DVSEC ID 7 blocks which will trigger the error message. This
> behavior is defined by the CXL spec r3.2 9.12.3 for RPs and DSPs, however
> the Intel platform also added this behavior to the host bridge.
> 
> This change also needs the dport enumeration to be moved to the memdev
> probe path in order to address the issue. This change is not a wholly
> contained solution by itself.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Suggested-by: Dan Williamsn <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
