Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C59A92F
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675708; cv=fail; b=sBknY2XeJn84n95ByhqPlDOVy9j5V3fYGumnbHG1UBcc0E0nZJz4zsp/alFov1m5FPo/tET7UcU/5g1rYAtqCPfin6aIiRuRqYjpUMLz0tTqOUKwjFdmKKrXiG16h3poom3NsBYwUHpCvs0SLMh7Bc8fdop/cd2zps+Xh7tiw24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675708; c=relaxed/simple;
	bh=ctKLrEIhxSKAjeEUlcvdcjfj1WRsyTZZxPnbvxk1nB0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZZNpgL3ccpf8YTjsA64s2oN0q9dKCZS9hCrCm3Ed0wFWaNQz6gyl2O9Mzn5eBagzwuKhn/5PJs5JTZkT37H7yHBW8TLXKsLToeaWcrjMFHM4OUiLq/ppOC+aC5davaKJDG4BojkTYp0VEDDRT75suAVeZSvRG1q0tT5/gqYNZHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUOsnhR5; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUOsnhR5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711675707; x=1743211707;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ctKLrEIhxSKAjeEUlcvdcjfj1WRsyTZZxPnbvxk1nB0=;
  b=LUOsnhR5zh8KlKf/T3aFVEFjYbq7mLENldrUasx+bbuCVO7XTVtMG+Rd
   vjVdNKQfl83ihJ2urqsQC7U989tQ0dursa2iSUzl74wTCXz80ElEh7gdp
   8twV4+H3izo6Lz0ceVi9OA97k12F5ggduxGl0MXt1TB1jFtByrkLq/E17
   Zl8nIQi1zhvqoPimf/+1hjuUQ0fFclzdDdgGb9RGxHr8mZ2WlJjj20I/B
   Ywyls4Uyk1ZcYh3TI34HfqzFRJv8/VqiuFg7cx9GMgtmc63H9AyMJvM63
   /FH96gNC8rFiZxgvzRUxuG0E+u7Kq/1Zq6so4vlmwXMLBalK3dKxFaWIo
   Q==;
X-CSE-ConnectionGUID: b7hfoo6DRNWZL1j0isG0qw==
X-CSE-MsgGUID: fYvxiQuSQUSYqVkj2dMA3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="32263928"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="32263928"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 18:28:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16866141"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 18:28:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 18:28:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 18:28:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 18:28:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEzKY47pWKlSbU7BQWukig+6I47xSaB9Tb5vBjawQoUiQTI/6qxvmPCUjHxmg4UpoOkbDpXEgrm8JZNYJCaNg/1Id9fzEM21WwYLH62dWaZZ4o73Qq3TurJGoRN8czcXcRhGqN5RxIGvLz2YkSjxMmkZmFIF3Vgd9FYd+ljqgOQ+KHQqRHlRaaM0k2KKB30KXqeQJCQ+QBi/aluWULiJh9g9t/wMcto5G9aEKrfV0/SPk+yVinMkmRCMr+o8f8J9qKz1XrgkSXZRNqSkgssxIjN+in2a4SQVX0e3zlyJ0lMotXF0IBTOHlT1OZV/F9KRPYCmHLo6Xd8CLCW1IyMMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtJ8+npQbtHJu0ePDjhanLS2xcDiSF4JWRHvY0UPzrs=;
 b=oGVm4D4/7im+r0Ikj7DcHK+/FkfjF/xQiVoAgjL/H7zb06PAzI7GgAlty6xxSSz2m9+GG+L1lAhJSinzaGtyJSVhtggwtYTovjbh8x+x4O7lSFdy5Ud1/fGx44phSJ3F6ZU2nFQncObGsnLMyogQXW/nSovbMkqEcOKp8Y3Lny8MGIgohOon9rBE2tAzTQy8WFpMTojFPVC8wNpWk1BbMuWazoO1FWbM5o1fhlSswT19JFtoSSclhfpsLdhp6Eg4y1ze9/xv7AHAgrID+SRuPAzwP+tTrnFw6CsM44zDPFYTi0lMwwUnjttDj5KNDFCRxh4ALztBXpgZ+XuBO2v49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8694.namprd11.prod.outlook.com (2603:10b6:408:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 01:28:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 01:28:22 +0000
Date: Thu, 28 Mar 2024 18:28:20 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH v5 2/4] cxl: Consolidate dport access_coordinate
 ->hb_coord and ->sw_coord into ->coord
Message-ID: <66061934a5ae_1fb31e29459@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240325230234.1847525-1-dave.jiang@intel.com>
 <20240325230234.1847525-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240325230234.1847525-3-dave.jiang@intel.com>
X-ClientProxiedBy: MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8694:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGom21IGxW//IdqAthzaGScbzyMgnM/ZJSTnvWuwAMABDy33bmDwI+dMKuW+sU0GDgQB5xjJB54te2qGLm/n8f2AlgNlpajDCkBGwB5+uAgcV6xaNnytKbYFsWawKkXoUPeiPDlwGcZOUdWlJd3sc6iiChWGRieOjzGnM++senzmbW2tLRTk0zFBy6x4lyNr/eo3+J1aILzI6AwlupY402ljl9mprIYdnAtIThl9o+3w6TR3Y8X6KPlZ0chbniAC9jGx2XdE5qWDs1MYMesdlH7LdFcCVY0CClihLYSAN9gRwdvX69XCzxTGucnEI1pzvsB04XAF5zqMy1UyfCv3kXA34Qc4g84aVYJ/zRSHe39rhFI950NbjH/PFTJZDWq5HYrO9JHxy3litSaWZjLRGkWaU7qTIQfc/Ab3Qdo/Ap5+C94KjEN6Phfc2ACRuehLsNZGrcUfi+zRjpoAMwiBOzCKIzpXw2j21e5LgM40YxfyWM/DSLgYR2hbBvtZ0ixVRSMDSh3lV1jZhXBPYhx6rjGZhEIP/pqlI9/4nMhQOdmBtEi7CNkWCyoNXSEYUZKLN0Fbx6VFRX8PWOrH+Y+gpEK04RZE/J/yJ4sKCvW56GNZtTBzyvDYN/9qGbXSZ2nvmAmWculoq0cPDKE5PO0B7KdAPzwNcHC7sfwFGu0QNlI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8LYCBw3t++JabVUjoBEzWcG0+AxWgDoXf5T6GnY43FTwZDaY3XVXqBUKlQO2?=
 =?us-ascii?Q?LcSJRzizXlNPJXBMyIodcVt1Vp58L1TwN77bL30ESWSiAWa7eVlWUjCcZ9DR?=
 =?us-ascii?Q?mJgicwAdWAPs+YnEzCRaih7/PRgnQbCp3eZ4Fm4qf+TozYbW6/iPdOnNJzW6?=
 =?us-ascii?Q?FsTw+CTay5dqh/+fW4a7qApiDA7CdwTs+ouEYZzvJ/4dLvX/F2VZ+q5kJSGs?=
 =?us-ascii?Q?k1aN36i6aIZ/+phSn9rSiPXZOHbKKiqPCmw/QLxgLeblVNbMa74a9akIgVLD?=
 =?us-ascii?Q?QuRZsg1zxbMZehjh9de5crFIg6BlWNdgvL3k35qEZeyJx1TgZrG9Fs2pNqfQ?=
 =?us-ascii?Q?qWXnzTNGYZ1VbTnUSKybHl7ReeUvCc02U9Es8TZMb1L/oarp+PHIklrKDZbh?=
 =?us-ascii?Q?uRdacDJ6aYpECXa5kK2nSAj3WpMVDIgeAZf9zHSjIh8RTu7v1AU4oW5zva4M?=
 =?us-ascii?Q?RiEHmun1mAHwxs6cNHQRpMEHglUk1T78AKmbHHCCgCuRd4MC6pYGR414s5qY?=
 =?us-ascii?Q?/APIzhGNsSjqQSBE2RPTtn4wUUjxjxsnd/7pWP6T5caZP2rXdRYv2KP5/kzs?=
 =?us-ascii?Q?PpU+e53kZuAgvZvDSFNcISbS/RJp2F7cMzBy76rmGrkoEaWLWiT+mYwslGZT?=
 =?us-ascii?Q?gYc6JcLEDxZ+/ZwjdCbYIQVl8paYwsfgqHiWhH9sqeM5BAIBci0/GmZUldbk?=
 =?us-ascii?Q?ZNCWxuiCnTXt2K4MrDAnnNtDd7KofO5tFko8DYpDmHcWcXmZg9GwSnDYCIrg?=
 =?us-ascii?Q?M6vyr0YCWlo6YgqX93axxzYg9HoQkuZpmGlFKDuuO2Aym7iXFnR5zkYRN5Cr?=
 =?us-ascii?Q?B2uxWYrR46qG5Yi+m4rxarCa8yNP2SL3q3Ea8CN9JIlWKSlZJfVt935H3o6o?=
 =?us-ascii?Q?/s4CbiVq57Ycu7B+qijG4ot4vVT8H5/5nYA4w9I1IbeebSuJgfZghYFQoHE6?=
 =?us-ascii?Q?3XckmJ9EWrMM3GM1dujhEN8SpI9eLij+N+BH7F0bBSAJINJwJP24wGf8N36S?=
 =?us-ascii?Q?D107YuLhZKUPAhycitqJA1PM99WWT0wIWto/MXWOfdjqQLgFe5IuPXsIP1kV?=
 =?us-ascii?Q?tAb/KZ1VqY6i6lopTXQFk+slq4krP+f9KV2UvZpJ2UDAqv2dQtkDr2qcUmNc?=
 =?us-ascii?Q?SDi5f9zapaXAccWv752ok+XVmlcf1ILILPsCO+Sh1zX4b0NB1mDArYogVbh8?=
 =?us-ascii?Q?M4lPgcYGAc4epITRz4UizlmoyVsM3trtwIkfdpG2ZQJkIqEKdqctqngBLk50?=
 =?us-ascii?Q?QNg+wmkrIJhxT/q6VsbFi9sEa+pHDkfhdCIjKzndiggBpjrod+iDmwtL9rtk?=
 =?us-ascii?Q?rbnJazwGW2H7FM6vlj6qM07/YGAP/K2qXdBUSM03PmEcZd6Gm0hGyB2TZVhm?=
 =?us-ascii?Q?Ih1mrDWQZSwuPBfG1Hs939yR+gqXee68mjYQwp1DMJyQiDCLZGLur4uJYAuY?=
 =?us-ascii?Q?LSzkUzw9Nufac8KJTzIiUDt1/78yrrf/aOInB3TMwrHOHHYFy6tgOUJMqvF+?=
 =?us-ascii?Q?R8wW6X+57i7C0ypo8Ea7dWzkJwB+AQwhrT4dUhvdLpKmIomyEsm6ozQXfoy2?=
 =?us-ascii?Q?2GAzEomTP7bDTZNx7yhmUxawSZRXCql3GSVddkGijMcHD9iZ7NkSkN1EvwJM?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d179ec-c8b3-4e18-47b6-08dc4f8f85c8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:28:22.4315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PszXnHB5ncVvRmIR55nbNz0hF2nk9WlWHDfRjtxtwEt3179OOpMfqQVxOjZCfhaOZi0kzR69Sj1FI+1/FZVaPYiZj+G8ew0fag/vstZaeio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8694
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> The driver stores access_coordinate for host bridge in ->hb_coord and
> switch CDAT access_coordinate in ->sw_coord. Since neither of these
> access_coordinate clobber each other, the variable name can be consolidated
> into ->coord to simplify the code. This change also simplifies the
> iteration loop in cxl_endpoint_get_perf_coordinates() and allow all the
> access_coordinate to be picked up in the loop.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
