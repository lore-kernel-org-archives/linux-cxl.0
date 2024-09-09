Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDCE130495
	for <linux-cxl@vger.kernel.org>; Mon,  9 Sep 2024 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725924203; cv=fail; b=bMs5aBmCL1530N8GlcW+fYcbCSrcuzJNxnPI83SW2tXbTRP+yGKYzrdw+wgd+mdGM0m+BE9Zo4jGptDBo7Vix8mddjNSIlYkFlR/ALnGEygzqB50tpSMmVzHPuY6gtE3pmTh8uiBqsV+Ie72SGg0JE+0/BIU3Hg2nCXE4dKOyNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725924203; c=relaxed/simple;
	bh=2Tq1kViNLJRuOn29k8IB6r3wZMywPlOt0hHxrTUTOtU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RnwoOnpGQ0m4/wRzoUnTeCNo8r/kn+i7ftjPUHOO5uJ+/pekdBiHNLuNMWNEOQmdVyryiptxCI1jdEuW89073i2SPkW1ku1kgokfMRnY0i039dDmJsRMjt7tD6cqUT3bHvHNVvVihR/fin//DXIE8FfwRLywEleT1nnZYjRHJUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ww+5cVSJ; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ww+5cVSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725924201; x=1757460201;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2Tq1kViNLJRuOn29k8IB6r3wZMywPlOt0hHxrTUTOtU=;
  b=Ww+5cVSJp965IQsXgIwXw71SV3fcNmpRt0dHZWwask7LxuNn1YDkJFu1
   14pyFLVZ7jLOKxsMmCI4zFN+bIPMYmc4IklnXB0FZybb6wsW0qN/BfL1V
   D5MfiU+/vLAiUq8wDkaeyNwvxse7F/NWz//rDQ9jxIceX7c5D5Dl+FG1V
   A8Ly6GO0YZJ3VwEoqnYhB6iPZtvq8T/+pzTRAHIpPWRrDiS2GJzY4Sz16
   Yfs2CSs9GWM3Tqse+d+cLn7PtdoSpHSK3XrCFygwdGnzhZXY7/HAA2F+N
   3PoE3pdiyBM9JX+s4ly4i8E0vEGxjqB8eiwK410fUpiZPMPbT1kyBrpGB
   Q==;
X-CSE-ConnectionGUID: q+7vAJP4Rlqr7QtDy0SgzA==
X-CSE-MsgGUID: qDlsQlmMTMWs6KA6ERehLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35992815"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="35992815"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 16:23:21 -0700
X-CSE-ConnectionGUID: tbBgTuZ1S8idE9+aF8O+9w==
X-CSE-MsgGUID: gUTo2hrtTKK9SVVTCg99Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="71619868"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 16:23:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 16:23:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 16:23:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 16:23:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FThwFXfXj/SSKfzKH3YWmddHCML4Ffs6/dbr0EgdZyk203B0tdimiMMA2IWEoGHJlVOf9heyfiyARK93lici9g8zoXz+esRQq/lnP6oxijQZ/4vUxjZYsfXClhtxpMamLnZNKh0Z/PTikjeQjGStVyAaEoe2zXAg39lZu8tiXRHsgoQ4DlK88k+KWB+tSybtbza/i9jI2nzq1BlR1Fk8wzr/lt6GpQCH+BjTBVZIaUTPd+pFc037w/zIxZhPM7N+NmHUAxgpQeW2yhZam3yTaPq/CU30XF1Qwtbjdpgew52nbpxoml8D2mDzNv5U8J0VF8a6o2wwDg9/XrBiYOoxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YS9oqkhKcvpqykH+MWYoxvO5c7byIglA8xN9CTU2CZQ=;
 b=whMQxlXjtQsRBEl4SXnZOW4rFWgvyYYd8GM+lILRIuLe9CL2gL6Mp//sJ5VG1WRrqTKlYxrIvmS4xrr4VEgHvED7gb1PMpZI+9TJpqsULgLQuJoPyjPHNusK1oX95hEInXRCyHaAFKAnFCcGVfdI5p1dn8v9CgsZGY7ObaYMulheBee/ySqWHgC/2BZAenw7LZq24Kp7v00Q7fe9/WEkasToNSq2AixsCxnwL3DfnCVl5c3EZlDjj049mtIwySP95x6Ly3tSBRNkLnejW7dNMOMMw3/MpX9nAFkeT0S3TWWTQy8zi4jX549xRjLWIG6YcOhV5unurawqxo+k5wPaYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL3PR11MB6505.namprd11.prod.outlook.com (2603:10b6:208:38c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 23:23:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 23:23:16 +0000
Date: Mon, 9 Sep 2024 18:23:12 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <alejandro.lucero-palau@amd.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>, <fan.ni@samsung.com>
Subject: Re: [PATCH v4 3/3] cxl: Convert cxl_internal_send_cmd() to use
 'struct cxl_mailbox' as input
Message-ID: <66df8360a46c0_3c80f229474@iweiny-mobl.notmuch>
References: <20240905223711.1990186-1-dave.jiang@intel.com>
 <20240905223711.1990186-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240905223711.1990186-4-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:303:b7::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL3PR11MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: e062de95-55ec-4380-067b-08dcd1266222
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tyto1tVQvVSPa2T1V9OQIAICS+1r7Aq+zal0/M42DMOHThA2LaY5jlbAb5/6?=
 =?us-ascii?Q?p7K1aMF5fApAQ8B03ycW1I2cZYdqd6DNs7Jkyn1R/R8bGioQx578X4xqmdx9?=
 =?us-ascii?Q?sq7Dtfw5f5HOttuakR2Xlt5JDJ60h4ZPWFdT8gz/HzK2sZ/MQRbx+VJ3Jsdj?=
 =?us-ascii?Q?JBPNw/AUEynk6WAnYLs7yHc7/nK6nFiYzKV0Za1ew9rKraKB2tTS4uBmxFVQ?=
 =?us-ascii?Q?qWOPTrHSuHchUimgnToTGk0scw7/iHgF8czbQXKnJ7/gu0QcvYZLi9Voq5cZ?=
 =?us-ascii?Q?3uGvG1SmQaD1OSc25jMya7xkt/lSUINL6PFyWaqobVwiJ7MewjFhbMLXKMyR?=
 =?us-ascii?Q?HGticAwFHbrxPHAE74n42TRni197k3inCY6A0CBzBKxBcNmV/2FGuYI11B1m?=
 =?us-ascii?Q?yEbXjYG9efpf0Vlpw/b5Phcpy2WVI1aHKekgfOimhVGz/bvEvmfIeWisw0l6?=
 =?us-ascii?Q?/ccCzlkNARwXydlQ+bEnsNKhSg+VW5I/PXZEg2ppnIJd+s4Bn/hgvKFtTww4?=
 =?us-ascii?Q?H/j/VF6ZY0/hufUq7wWNzO8uDG26zDFaI0ts5R5L7DfLMGmSZvwQ6yDyNniO?=
 =?us-ascii?Q?f36S+21VseGMVe3UgQsTNhaJCNeed3/k2omxBawF0LJ3kAXJ8TcudgiRUNEG?=
 =?us-ascii?Q?BbrwndmFZMcTiiYhhY4d42chrd3SLVDorGFVCs6UB1vbrasCHU2K1cbgbRi7?=
 =?us-ascii?Q?PzuxbU5j3W9Fefl2DUl5XZzb907xm//nOCX2eJVuL4UtYrn89vFKaLLcyNAq?=
 =?us-ascii?Q?8fWGdnJ62FH3Wy/34mMafP2F3hKNamS79m/5Kr6IOuZ+eJPrpEwAXDzDowlu?=
 =?us-ascii?Q?bAvWdUB0zlFsqapetmZbOjvN7geRZEZBrQfL7gQRdwE0pBvMwIcHDQltZPmK?=
 =?us-ascii?Q?6Hv1pW0jg89jNYWhqSXfFJFZyn/fDvT17gePqQk8W7jKXJ1Tqk/ot163x1Oh?=
 =?us-ascii?Q?2YUDkwqPreWXHEb7Dv4xNntUUf5ADN1+HKeDX4PY87gcjtEjEXg1fo3CtBUe?=
 =?us-ascii?Q?RNm8y5R1FQpy2Bnl7hN1kQ7JGsPIH1TGay4vYIW8daQ78DjZz+50BXLPYanm?=
 =?us-ascii?Q?3eBV1I412qpTaHiIZ5H4urnvHsDXRF4s0oTC0YdNeLUYJfqWsIzx8A8yKNjk?=
 =?us-ascii?Q?N7tmcUTDAKAVRlEJclCLWgij8nsms/NEgiJBNsXmXA94ni+YWUKG7b6EGV3m?=
 =?us-ascii?Q?5c0/cimz7zPFrvDLt5fYmiWv7t40bOk3pl3weMmOcrd+3QqK7Uw/MyEQzsmF?=
 =?us-ascii?Q?PY5ucfJM55kYJE3S5e9qG3aeciZyDNSbT/S4o3/Nkj/M8CgBk3yTqIYhHFgC?=
 =?us-ascii?Q?Urs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JDeVZpbNp6BqCO2boLH/k5fWKVIv3dBmSe5L2fLzc3ekLQGFBjWpIvCaHs0n?=
 =?us-ascii?Q?Re6eiyUhcAAC3hH1uAeDJPvDkEpU71bqaq+yx3M9vFACl/AdduizcXZvGWtr?=
 =?us-ascii?Q?WUHBl9gaAbin++U5yqMM6ajg2YrWKwhi0sBJxvIOUQR6TYq+Rd2e4jcFkBmX?=
 =?us-ascii?Q?9PrvrVGJAQZ6Cl7788HlUd6kOSSxeItdL5xtARkIm9NMUpfSi8tO0AR8wL9+?=
 =?us-ascii?Q?wS/a6utNdCJpg5ekKsHij1h8S9h4ImGtZ9xLtsI3b28UjhDX/gdz4tHGhP1g?=
 =?us-ascii?Q?wBeVq896h+yeVGxRRA9G9J6ChR/SU3SqG62ZDLWX9HYlCpQnDX0G6qEBfSC1?=
 =?us-ascii?Q?j8rSaaJHVTKnBan+mI0qYUWqIQ7Ft4vl1qVJc3u5MOBXxE9unTvXTgGthZgL?=
 =?us-ascii?Q?AFDlmOhxEvkPf9+30JuBML0S3ARLFnT1er++aNx9zUi8zx7eijnXkknnFTVv?=
 =?us-ascii?Q?0312rY+QIh+BCBAhCmHVG1g4EdnlrL3mgR0NjnkYJEg0Tdybqbxny0tuWTQ9?=
 =?us-ascii?Q?qJG5X/LRHvQn6FbnNVIpPrjFeMFlVaOWK7R6yWoWOtaH6mdpWViKrqjtca9b?=
 =?us-ascii?Q?NKHB6xL11BJDh3XJSa4wg2mmrlpsSpWuCUC4F2nyBITv6ViE55iysyCIOoWK?=
 =?us-ascii?Q?Ch66dP0RtgEI250IxJRuXVQ9AAkg255guhPyAMeUdUjfyij0VBTdSLo4mSM9?=
 =?us-ascii?Q?+v/U4QUEhPw0z1pVHFOseU6SwxkPumB8s0cOL/vWR/CAjqEjflKM6bhEHZ0l?=
 =?us-ascii?Q?mlsNwJLyE0tN5iCTp6cE5W3hSL3lfN9Il7SiF+stkt0Bmtkn+9H/XBadb7wy?=
 =?us-ascii?Q?G1m2dM3mnF5ddiN4mDGoEllJB3/FVraNT9AmkdNTkpyIPUpkYa9b+4r3N7un?=
 =?us-ascii?Q?3BR9VeoLvb3pHFdlA9Z7Sujq3YnmYXoDmZE53QSX1OGewZEYlT9zt/I5dKmf?=
 =?us-ascii?Q?4819ttaEFi7/lpNCTTjglUUUMC6NqH/zwmM0Po5lrguW/H4vBmw0+VgvS9QY?=
 =?us-ascii?Q?bIcbB3ac1Mogc0JW8Dg+8f6MzqrhgX/BNxL/LK+ssa96CzZthd4QoeAeOfhs?=
 =?us-ascii?Q?9m73UkDF1KS7i/VhvjdO/u+qI5mQsxkZS8oS+liqa3CDsfqn4lkNFGgWAxMb?=
 =?us-ascii?Q?mNGxC3l5gOPXjzB2H8JvXc3AUSjb99sZnBvRnihweNqmPofyAL3OLmxywm9v?=
 =?us-ascii?Q?vSpO+q62xwBmb6tkTCCTrm55hgpjVuLx6V+Ek0PII0gNaWOATZMOlYE7IAsP?=
 =?us-ascii?Q?SdikGs0opOpVaocC+uaeypDgE95FjkfAl+bx+mlZg+kmBtCeTVQiN+q2raVk?=
 =?us-ascii?Q?QRZND1k3VdMkSgdh55fZouOVkLEdkeMNNsGKbBBhnH63tAG6rvYrnqBbIb/+?=
 =?us-ascii?Q?O3Z5pUfC3yRDL7652MmeSincWp4g3EUYYC+Wq6g8xPyzPsXPdeRpw3tyS4VE?=
 =?us-ascii?Q?HY3GYIxAZohTMuOwCh+j06hMankvXHEmTuWQyQqZYowVQ+6cADDiAC0T/DLj?=
 =?us-ascii?Q?M/3v9JSXyCaUmtvzYTC2h89Ps7Cl0kHL5BcF6iWwDgFe7kV5QN3wxN8nP5LV?=
 =?us-ascii?Q?47csl92GS8UiukouuyTTh/xUBR4X8T3VghaY5d/N?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e062de95-55ec-4380-067b-08dcd1266222
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 23:23:16.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XADGkLG4P60tYzj0yPSe8Ls4wKEK/s8QsmVB60rXs9qYdcLd/byKBK643lOW9UubwZx+my0CKbexLw9PenA/tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6505
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> With the CXL mailbox context split out, cxl_internal_send_cmd() can take
> 'struct cxl_mailbox' as an input parameter rather than
> 'struct memdev_dev_state'. Change input parameter for
> cxl_internal_send_cmd() and fixup all impacted call sites.
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

As a straight forward conversion.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

But some calls like cxl_set_timestamp() could also be converted later if
needed I think.

Ira

> Link: https://patch.msgid.link/20240724185649.2574627-3-dave.jiang@intel.com
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c   | 38 ++++++++++++++++++++------------------
>  drivers/cxl/core/memdev.c | 23 +++++++++++++----------
>  drivers/cxl/cxlmem.h      |  2 +-
>  drivers/cxl/pci.c         |  6 ++++--
>  drivers/cxl/pmem.c        |  6 ++++--
>  drivers/cxl/security.c    | 23 ++++++++++++-----------
>  6 files changed, 54 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 4d37462125b9..e77fb28cb6b2 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -225,7 +225,7 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>  
>  /**
>   * cxl_internal_send_cmd() - Kernel internal interface to send a mailbox command
> - * @mds: The driver data for the operation
> + * @cxl_mbox: CXL mailbox context
>   * @mbox_cmd: initialized command to execute
>   *
>   * Context: Any context.
> @@ -241,10 +241,9 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>   * error. While this distinction can be useful for commands from userspace, the
>   * kernel will only be able to use results when both are successful.
>   */
> -int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
> +int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			  struct cxl_mbox_cmd *mbox_cmd)
>  {
> -	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	size_t out_size, min_out;
>  	int rc;
>  
> @@ -689,7 +688,7 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
>  			.payload_out = out,
>  		};
>  
> -		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  
>  		/*
>  		 * The output payload length that indicates the number
> @@ -775,7 +774,7 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *
>  		/* At least the record number field must be valid */
>  		.min_out = 2,
>  	};
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0) {
>  		kvfree(ret);
>  		return ERR_PTR(rc);
> @@ -964,7 +963,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  
>  		if (i == max_handles) {
>  			payload->nr_recs = i;
> -			rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +			rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  			if (rc)
>  				goto free_pl;
>  			i = 0;
> @@ -975,7 +974,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	if (i) {
>  		payload->nr_recs = i;
>  		mbox_cmd.size_in = struct_size(payload, handles, i);
> -		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  		if (rc)
>  			goto free_pl;
>  	}
> @@ -1009,7 +1008,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  			.min_out = struct_size(payload, records, 0),
>  		};
>  
> -		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  		if (rc) {
>  			dev_err_ratelimited(dev,
>  				"Event log '%d': Failed to query event records : %d",
> @@ -1080,6 +1079,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
>   */
>  static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_get_partition_info pi;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
> @@ -1089,7 +1089,7 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
>  		.size_out = sizeof(pi),
>  		.payload_out = &pi,
>  	};
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc)
>  		return rc;
>  
> @@ -1116,6 +1116,7 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
>   */
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
>  	struct cxl_mbox_identify id;
>  	struct cxl_mbox_cmd mbox_cmd;
> @@ -1130,7 +1131,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
>  		.size_out = sizeof(id),
>  		.payload_out = &id,
>  	};
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -1158,6 +1159,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
>  
>  static int __cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	int rc;
>  	u32 sec_out = 0;
>  	struct cxl_get_security_output {
> @@ -1169,14 +1171,13 @@ static int __cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
>  		.size_out = sizeof(out),
>  	};
>  	struct cxl_mbox_cmd mbox_cmd = { .opcode = cmd };
> -	struct cxl_dev_state *cxlds = &mds->cxlds;
>  
>  	if (cmd != CXL_MBOX_OP_SANITIZE && cmd != CXL_MBOX_OP_SECURE_ERASE)
>  		return -EINVAL;
>  
> -	rc = cxl_internal_send_cmd(mds, &sec_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &sec_cmd);
>  	if (rc < 0) {
> -		dev_err(cxlds->dev, "Failed to get security state : %d", rc);
> +		dev_err(cxl_mbox->host, "Failed to get security state : %d", rc);
>  		return rc;
>  	}
>  
> @@ -1193,9 +1194,9 @@ static int __cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
>  	    sec_out & CXL_PMEM_SEC_STATE_LOCKED)
>  		return -EINVAL;
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0) {
> -		dev_err(cxlds->dev, "Failed to sanitize device : %d", rc);
> +		dev_err(cxl_mbox->host, "Failed to sanitize device : %d", rc);
>  		return rc;
>  	}
>  
> @@ -1310,6 +1311,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
>  
>  int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	struct cxl_mbox_set_timestamp_in pi;
>  	int rc;
> @@ -1321,7 +1323,7 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  		.payload_in = &pi,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	/*
>  	 * Command is optional. Devices may have another way of providing
>  	 * a timestamp, or may return all 0s in timestamp fields.
> @@ -1338,7 +1340,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> -	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_poison_out *po;
>  	struct cxl_mbox_poison_in pi;
>  	int nr_records = 0;
> @@ -1362,7 +1364,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  			.min_out = struct_size(po, record, 0),
>  		};
>  
> -		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  		if (rc)
>  			break;
>  
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 05bb84cb1274..84fefb76dafa 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -278,7 +278,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
>  
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  {
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_inject_poison inject;
>  	struct cxl_poison_record record;
>  	struct cxl_mbox_cmd mbox_cmd;
> @@ -308,13 +308,13 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  		.size_in = sizeof(inject),
>  		.payload_in = &inject,
>  	};
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc)
>  		goto out;
>  
>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>  	if (cxlr)
> -		dev_warn_once(mds->cxlds.dev,
> +		dev_warn_once(cxl_mbox->host,
>  			      "poison inject dpa:%#llx region: %s\n", dpa,
>  			      dev_name(&cxlr->dev));
>  
> @@ -333,7 +333,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
>  
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  {
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_clear_poison clear;
>  	struct cxl_poison_record record;
>  	struct cxl_mbox_cmd mbox_cmd;
> @@ -372,13 +372,13 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  		.payload_in = &clear,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc)
>  		goto out;
>  
>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>  	if (cxlr)
> -		dev_warn_once(mds->cxlds.dev,
> +		dev_warn_once(cxl_mbox->host,
>  			      "poison clear dpa:%#llx region: %s\n", dpa,
>  			      dev_name(&cxlr->dev));
>  
> @@ -715,6 +715,7 @@ static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>   */
>  static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_get_fw_info info;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
> @@ -725,7 +726,7 @@ static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
>  		.payload_out = &info,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -749,6 +750,7 @@ static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
>   */
>  static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_activate_fw activate;
>  	struct cxl_mbox_cmd mbox_cmd;
>  
> @@ -765,7 +767,7 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
>  	activate.action = CXL_FW_ACTIVATE_OFFLINE;
>  	activate.slot = slot;
>  
> -	return cxl_internal_send_cmd(mds, &mbox_cmd);
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  }
>  
>  /**
> @@ -780,6 +782,7 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
>   */
>  static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_transfer_fw *transfer;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
> @@ -799,7 +802,7 @@ static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
>  
>  	transfer->action = CXL_FW_TRANSFER_ACTION_ABORT;
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	kfree(transfer);
>  	return rc;
>  }
> @@ -924,7 +927,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>  		.poll_count = 30,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0) {
>  		rc = FW_UPLOAD_ERR_RW_ERROR;
>  		goto out_free;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 4ead415f8971..c7c423ae16ab 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -811,7 +811,7 @@ enum {
>  	CXL_PMEM_SEC_PASS_USER,
>  };
>  
> -int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
> +int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 36b8620105b3..dee843c244ae 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -658,6 +658,7 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
>  static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
>  				    struct cxl_event_interrupt_policy *policy)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd = {
>  		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
>  		.payload_out = policy,
> @@ -665,7 +666,7 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
>  	};
>  	int rc;
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0)
>  		dev_err(mds->cxlds.dev,
>  			"Failed to get event interrupt policy : %d", rc);
> @@ -676,6 +677,7 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
>  static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
>  				    struct cxl_event_interrupt_policy *policy)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
> @@ -692,7 +694,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
>  		.size_in = sizeof(*policy),
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0) {
>  		dev_err(mds->cxlds.dev, "Failed to set event interrupt policy : %d",
>  			rc);
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 3985ff9ce70e..5453c0faa295 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -120,6 +120,7 @@ static int cxl_pmem_get_config_data(struct cxl_memdev_state *mds,
>  				    struct nd_cmd_get_config_data_hdr *cmd,
>  				    unsigned int buf_len)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_get_lsa get_lsa;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
> @@ -141,7 +142,7 @@ static int cxl_pmem_get_config_data(struct cxl_memdev_state *mds,
>  		.payload_out = cmd->out_buf,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	cmd->status = 0;
>  
>  	return rc;
> @@ -151,6 +152,7 @@ static int cxl_pmem_set_config_data(struct cxl_memdev_state *mds,
>  				    struct nd_cmd_set_config_hdr *cmd,
>  				    unsigned int buf_len)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_set_lsa *set_lsa;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
> @@ -177,7 +179,7 @@ static int cxl_pmem_set_config_data(struct cxl_memdev_state *mds,
>  		.size_in = struct_size(set_lsa, data, cmd->in_length),
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  
>  	/*
>  	 * Set "firmware" status (4-packed bytes at the end of the input
> diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
> index 21856a3f408e..452d1a9b9148 100644
> --- a/drivers/cxl/security.c
> +++ b/drivers/cxl/security.c
> @@ -14,6 +14,7 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
>  {
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  	unsigned long security_flags = 0;
>  	struct cxl_get_security_output {
> @@ -29,7 +30,7 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
>  		.payload_out = &out,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0)
>  		return 0;
>  
> @@ -70,7 +71,7 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
>  {
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	struct cxl_set_pass set_pass;
>  
> @@ -87,7 +88,7 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
>  		.payload_in = &set_pass,
>  	};
>  
> -	return cxl_internal_send_cmd(mds, &mbox_cmd);
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  }
>  
>  static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
> @@ -96,7 +97,7 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
>  {
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_disable_pass dis_pass;
>  	struct cxl_mbox_cmd mbox_cmd;
>  
> @@ -112,7 +113,7 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
>  		.payload_in = &dis_pass,
>  	};
>  
> -	return cxl_internal_send_cmd(mds, &mbox_cmd);
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  }
>  
>  static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
> @@ -131,12 +132,12 @@ static int cxl_pmem_security_freeze(struct nvdimm *nvdimm)
>  {
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd = {
>  		.opcode = CXL_MBOX_OP_FREEZE_SECURITY,
>  	};
>  
> -	return cxl_internal_send_cmd(mds, &mbox_cmd);
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  }
>  
>  static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
> @@ -144,7 +145,7 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
>  {
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	u8 pass[NVDIMM_PASSPHRASE_LEN];
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
> @@ -156,7 +157,7 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
>  		.payload_in = pass,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -169,7 +170,7 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
>  {
>  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>  	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	struct cxl_pass_erase erase;
>  	int rc;
> @@ -185,7 +186,7 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
>  		.payload_in = &erase,
>  	};
>  
> -	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  	if (rc < 0)
>  		return rc;
>  
> -- 
> 2.46.0
> 


