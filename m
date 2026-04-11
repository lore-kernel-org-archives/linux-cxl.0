Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE76214812;
	Sat, 11 Apr 2026 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775949379; cv=fail; b=YZfskUVKk9TGzhJ1ewrJiFRGFPHyLpnVwv94R+x7rtywZUY2GblgEbntblIYMa3wRZZ5M15io8XwLshfwS7GT7Ljbshf5n+o0Q+ngMW0UKvRsFKLvfXLw5Zz9IxYVTItgVq/JuePnwBwWcKzGFlWUiEkbnmXjC6oAGh3S0c/9M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775949379; c=relaxed/simple;
	bh=xHujJ82Gj65c61qAFWWKfj884WXCdMrn1BhOQ1BEf88=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k8/RXdEZ/LmY/57gjFaLa/CRbQ3o+voOT+UkeJabjrJlMshrXV7sxPUpLeLp7mZh1KsqaNVy0FofUw+rJCt4Dlz7/FIxXowXOnjfFzyYVK8FuXcuISSjv2JJ5HAIx0f9mScIblZy/TDrUQgwdcGul9A79jB63+hssytXBqzunOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XrvZe9fV; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XrvZe9fV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775949378; x=1807485378;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xHujJ82Gj65c61qAFWWKfj884WXCdMrn1BhOQ1BEf88=;
  b=XrvZe9fV2e1L+7kxgK/G9RCuZs1QvAjaJ519y//emExEx+udI4jjtwWx
   mFZBPMg+fNc/DSMR6jEas4WdtkoPnAaPg0jfUFrhA8qm/bv9ttvfbVJjJ
   wW3xH8U99YrjPHS9zOPQxV04RXqBDj0oqvLIwMadEHvOIDgEiGcjnyMTB
   35FMxFwS/pVIZtXKilKLzAb0SDMnfwHME6Q6vFBYLLIywifHxiu0cT2OO
   NIAKeWXqphkEVKagtXjMXn6Rjpo9J3pSiNRjsIe97vAJdgWnxnonYUh2e
   iZzjsBz1Nc2bXsXyIoGuuWzXE72M/JLAOtEyOh0j4JEFhykR3y8Wh5JEP
   w==;
X-CSE-ConnectionGUID: SBkw7X3EQJmjBYybgMFITg==
X-CSE-MsgGUID: LVJsTQyzQQKLJ3GTZPzF8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="80814236"
X-IronPort-AV: E=Sophos;i="6.23,174,1770624000"; 
   d="scan'208";a="80814236"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2026 16:16:17 -0700
X-CSE-ConnectionGUID: iVulnMDDTyy+0gNrTyDdKQ==
X-CSE-MsgGUID: 2fW/FO1FQWa2MGtNfzG4PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,174,1770624000"; 
   d="scan'208";a="226264072"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2026 16:16:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 11 Apr 2026 16:16:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 11 Apr 2026 16:16:16 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 11 Apr 2026 16:16:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGYWxv2zS+1mfnjCs6ZQWkPRMlnM2Am+uSvZEo6ijOaPwbqDLZ/LNhCjnV9aaMfzZXlspsF43OPXSREtCSNY5XQ5ADJj3HDT/fNkeZq+lJz5lOoXinBdyU8fGyHFPXhUvl7IFnyMYkmur2T5Bxw/CQETv2wzMYkFtBdLzU1YmAUc4D9aPltdp6/wifktVriXlTDZX+y5fxnqoLVGlZkrCaL2feMK4IuiC3c6fbkWB3xBWpfL2XAAm5w/n3dOgICUXx1U5tgGyJ0xBYQ425FmJw0K+Tg6BW6DlV0o4ndQLxM7dWlPMvmkphLdpt8FurnPNlKGrA9QZj8tem2RN2lXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3hqHCv4vKuEvkwa1KMWJwViOlhh1EJXBDxjWbXcd20=;
 b=LzUnkdr/uLjpt/0yDtheqsHa19tFQvJaCMMwym9HFM4VhuDqlkTHE/9tZpLsAuBICKSpPKRCvOjVVAqbMfx9FSOj6Cbe6I+rQWIbz2uqxrnv4QR9vm0Jl69OCCSj3uw+5sT/R9SRTJkXQ3f1EcjiBLxn7m2bRgY1m/9NCp9CYFjVg5E65VXY3VwCKNBUrNbx9OldvfZ72ZgXPSyyD6Gh2Lute9uOAPf9Poz26zJWBLQnbOzVtmBC5dyAwNqowOFyiMW2Jna3tbth2ZZjMpAZnLpnJILuqXw04tAjIfXPt5BnQdVBub0xH2uviArOpCC3j6M2rgx3XEWkIILfviGFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB6844.namprd11.prod.outlook.com (2603:10b6:930:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Sat, 11 Apr
 2026 23:16:12 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026%6]) with mapi id 15.20.9769.014; Sat, 11 Apr 2026
 23:16:12 +0000
Date: Sat, 11 Apr 2026 16:16:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: KobaK <kobak@nvidia.com>
CC: Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Validate partition index before array access
Message-ID: <adrWNiO-KeTIqBbL@aschofie-mobl2.lan>
References: <20260409154445.2416120-1-kobak@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260409154445.2416120-1-kobak@nvidia.com>
X-ClientProxiedBy: SJ2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a03:505::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 66939892-a8d8-4d11-2d08-08de9820513b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mt64F+psOPjrM3MEfr0FN3CIKzdixG1HaBpIfWz0A/nnws2jNJH9Nw8JzRHpscvGpGpix6KEhb/pBegrLNeDavvXeywtHWVV2KCU6ZCRbYhUScImL0UVFD2g2t+ZFgb17I3NhHLFM1bBHOb+8IGQ7uqM8MvQoMBQmTjOT06QenKEXBWtAyV8TCfElFeabHw7edBfIMTjPInKW20JOd3KPvoZuIhQMYkhYCVpi+kW9NzoUodrXkd+vScWZcthra9cPTbLoAlQzt3m2cMvOBhN+hSYcHZRjZlHsUBDAeCnv8s39obrJH5NR+ZTM14uUjzUDfTtXAgGeswcxAEP3qEApIFGZ9W2CSIaYKnLxZXn+xgTR34x+jXwrqCDM+hqyCvBjnef9igfx/cEoxx0MzwDYlHLw1ghHDX73PdPfjRsNBDmeNeVLH7Kn/vRoTensFsCI4RuDlYZWd3y1gentQJOwKr2dAeEo/NPF9zVYB9yT3ZRrN6QgRw1iNvu5wWC6eWkURI0jEgWp/U7q/Uk6jhKJOCFEDxlAIrQXxYCrSpqDsUk/NvoJSrbiqEium+Dut5GgOZSNHt31jP5Pgbs5iwHxewS6H8vMbF32+Pc/oyy2d7kxCKFVuh431X8AVuey2aHB/j6Y/H4+/UPJT9OMjsluFSy0OvU5W8tO4RAIYThAohNFdC/TAX5n5mI8DjcsEYhF2yPKqMqdneIJWzrTvt7Jrg0jlipNQZX8uHCrPIr7Cg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AoNCstzvMWMtwYWL5bSqwwyz9ozfhQ8sjgJkB4SmzTlZNjWQK6pS1D+X2i9+?=
 =?us-ascii?Q?/NlZh67jYP0YQwxp4V/1xaNzkHx9RSrOmIXghS62vin1O2RSUCis2eViemeJ?=
 =?us-ascii?Q?8GvE0K5PskM2Yf7mdgmZ03kclfgWRIoSehU1odHcETBguUpL/wg57X7swIkO?=
 =?us-ascii?Q?EnrRjojePx5FssHPSqyXN504Tt7YqznlGYIq1rGkmazsJ0/zu6rU8ENQIWdO?=
 =?us-ascii?Q?zgVcNzdY/bvN5wJXHJyZpXerMdLeqQFwPcG6C3g3Z+LNXR7M/0iPp+MqhToa?=
 =?us-ascii?Q?x8z/6KtGPT0BiLltgDRK6G7sUVC4u6PA723sZE5EooLKaXAPbT93EAFiGFAH?=
 =?us-ascii?Q?DWljnL6xzprE1fO+34Fyfc78Jl5SeMTmsizloZKQeMyEkHq/yegUM+owUCSR?=
 =?us-ascii?Q?ssPxG83uBesLKXkTnSVsfItJxp7gP9Dkm8YPeK9BWMNk1dlfEsBn+ayqhCnl?=
 =?us-ascii?Q?2wRxJzWt8eRE7cbMzR8daBdlk3CsDp6GMunS/dTDtzXZw6ZnFJG7tzwuAjhn?=
 =?us-ascii?Q?33onC8b6P0hMa0IQACBvy6WIyHzYAoqv2n6G6YMpuJgh9qoAQuomZnRe+GgB?=
 =?us-ascii?Q?EJvvMiGT7Ip+JGCwMpATkNR2n5bzGP9PspMDXP2elY2keBAjDaX4C+rEBVMg?=
 =?us-ascii?Q?f218U2AayVCRQ4YHix86BmdM9m+sP/z9ZeS/R1jNd/zZgAvBhzKE2EmoeIsj?=
 =?us-ascii?Q?MTqimVKZJ1Z1Bh6yGIecaIUNhM058lTvMpipo/uFPNoIwqtUv8RvdL0OO+6+?=
 =?us-ascii?Q?FCc/KdNxXT2VbHHl//RMuwdiYDWdQQzFTrvRudLN8M6I8fmX0UvqmolU2Enw?=
 =?us-ascii?Q?zQh42tEbSoW0SZiAE2U90ijU7h4P5Yemb9fCZaPQHsmqC2Nbtv6is7v7RmIM?=
 =?us-ascii?Q?JLdmywfQTKtzjP3jTvnZatxki7KPjW3GGwsQXFexBpKujd/ENLT3otqUlNDo?=
 =?us-ascii?Q?tr6iVxm9kb8LFfvuHuQSaJTBxZWBwp8EnbeOMh46QVGYHH4Xog/p7sumD2AC?=
 =?us-ascii?Q?3Hc6pb/xoQSUDkity3glytpGht02XNMBsj/2abtItEHUvcRPuLxLx7kSdcti?=
 =?us-ascii?Q?w87wlg3UnF9wju/gPTBJllEvzfZFIUHQj79LgxkXKnaiC4Zh0fTWL955/gXK?=
 =?us-ascii?Q?3QGFm1N20E59IiqPZEIAhqWkxv7IOZlhnVViG7XcI+QiFvlQEMf5w01jZqKk?=
 =?us-ascii?Q?4aqOqMXYuRMfK3AKcjjJ2pqLNbqdRw475y0UuMbeYaR7L+T8mYpGDpzvOJ6b?=
 =?us-ascii?Q?RNRxaWIPoQQQ54BqKcm9vFFWBA8axDQPLdQYGZl7ZpdcULi4Bn5AxVKpCKPW?=
 =?us-ascii?Q?fFxXgr8SBNF80BcHAqzaMoH7wtUKCZwz3OW2wJfpIL0VtQvy1cEflTuciUR0?=
 =?us-ascii?Q?+NMdsxCCIyzcg5OZP6X3kbFwRwYGe8A+rNLyRRxYdxfrInhAROj8jjcKcVPZ?=
 =?us-ascii?Q?oIWan4VMIPcApNFg5ISgfooghDCxSaV/SOZVHZiwSq/K5+pSDdA+NLSKYh9N?=
 =?us-ascii?Q?LScSxhjnPctfIeHSq7/C8xXcrEUbbb8wyXU4yVG/XpDe+otRWArdiyU38iIT?=
 =?us-ascii?Q?sj4EmEQZHS4ecaEZ2WEpSDmd0Xnu2qvsCimkndNd0CyHqUVdcSgnVJrQNwwC?=
 =?us-ascii?Q?0SQysqE12uQSB3tx1gCBqRNLjgvMMqgSXYYONWnuQT1fwrVvEyAcdA7ykOv9?=
 =?us-ascii?Q?68QRUzIL51tWwlO8T1XVhbrnPwAO0P6CMsPdNXKyaTEtZ6beF9EkTlgx16o1?=
 =?us-ascii?Q?kqkw/LNq6GIKpbg+JekWoBj/SrWEJhU=3D?=
X-Exchange-RoutingPolicyChecked: THeAO3xTbcZJpWy2pA7Cd8vPEubOGYrzof5t4EH1CAxkQrW6++O20ZubnZ8KLx7P1vxZkyOb+9lWniBE7Ccg+fNrjoDmVBEKkTkN/PNwgtwzOyIY80LuA0OAs/ofqPoQdA5LTxSEUmcOxx+xxz0KNPExCMaGNvjE/SSrsHumr3pMTtbI9S37SJdUwwRPGKhIpyc7+a/27jhMd/O29lEheQxyD04ZRSDN3j7agrgJPtSyf3gEWLp9n9Lv+tIyJzJ+8pP5V1wpbItv1pSOsZqV3noaDnKnQ3xHvOCsqhI6y4muAIi5V3jgwf0iaTguOZ/q4HyrdARzbfu2STf5hi3I7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66939892-a8d8-4d11-2d08-08de9820513b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 23:16:12.1916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cC9eev5IcS9ITuML9N05p/JY7s7z/R1CguTfVvPf7uWjilAhnELtgFUtTkQasGjDsgGKQw9LrA7PIJRVRANPDB3G0zKIF62HpEcCmxD1vcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6844
X-OriginatorOrg: intel.com

On Thu, Apr 09, 2026 at 11:44:45PM +0800, KobaK wrote:
> From: Koba Ko <kobak@nvidia.com>
> 
> Check partition index bounds before accessing cxlds->part[] to prevent
> out-of-bounds access when part is -1 or invalid.
> 
> The partition index is read from cxled->part without validation. If it's
> negative or exceeds nr_partitions, accessing cxlds->part[part].mode will
> cause out-of-bounds array access.
> 
> Fixes: 5ec67596e368 ("cxl/region: Drop goto pattern of construct_region()")
> Signed-off-by: Koba Ko <kobak@nvidia.com>


This bounds check need is overstated. All writers of cxled->part either
initialize it to -1 or assign it from a bounded walk of cxlds->nr_partitions.
There is no path in that code that produces a positive out-of-range index,
and the only invalid state is part == -1. So, let's focus on the -1 case.

(If we did want to defensively guard against out-of-range indices, that
would need to be applied consistently across all accesses of cxlds->part[part],
not just in construct_region(). I don't think that is needed.)

The Fixes: Tag was a bit perplexing. The cited commit does touch any lines
related to partition indexing, at least based on "git show 5ec67596e368".
However, a close look suggests something else is going on.

Commit be5cbd084027 ("cxl: Kill enum cxl_decoder_mode") which previously
reworked this code included the needed check:

+	int rc, part = READ_ONCE(cxled->part);+
+       if (part < 0)
+               return ERR_PTR(-EBUSY);

And that check is indeed preserved in the final lore posting of the patch
referenced in the Fixes: tag:
https://lore.kernel.org/all/20250221013205.126419-1-ming.li@zohomail.com/

The version that landed in the tree however is different:
5ec67596e368 ("cxl/region: Drop goto pattern of construct_region()")

This suggests the check was not removed by that commit directly but instead
lost during a merge.

At this point, I suggest a v2 of 'this' patch that simply restores the
missing check, no added range check, no debug messaging, simply:

	+       if (part < 0)
	+               return ERR_PTR(-EBUSY);


It would be useful for Ming and DaveJ to take a close look at the merge
to confirm if anything else is off.


> ---
>  drivers/cxl/core/region.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index edc267c6cf77a..6be46636db7ee 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3712,6 +3712,14 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	int rc, part = READ_ONCE(cxled->part);
>  	struct cxl_region *cxlr;
>  
> +	if (part < 0 || part >= cxlds->nr_partitions) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s: invalid partition index %d (max %u)\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			part, cxlds->nr_partitions);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
>  	do {
>  		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
>  				       atomic_read(&cxlrd->region_id),
> -- 
> 2.43.0
> 
