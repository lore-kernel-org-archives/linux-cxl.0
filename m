Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D642204C37
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jan 2025 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737773781; cv=fail; b=ZLD0Lx77c6PvsTHGOE5L8VeUQl3JUa0ZfNiDGYplGWsSBnWG2WCwoNBIQr5D+wXISX9xbQvmsTpe2gX1UJwLg0ba5V6uR7oU0dFs/WAULLxj3hJmWy0QyZ8UfwvCdQC+77FTEj/BmlwqEVS052e6+k+TQ+jWDu1R2mKgh5sVi0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737773781; c=relaxed/simple;
	bh=V2BpFjBFFfnyr7irjQfJA/5+Ol+2lUxmQnSQ44iXTAk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f4HmHHJNgYFSeJ3KzPBr9atdz0YWthcZSjdnSods0dqIvQQ/9ot8vPoNgLKf7EV79b7F1tyBPyFPetQPZzYK3l54E9Dw2zqIq+iBTNQK6fT92/lj8EcQK5qI9EJ8KRnr+o44Ib2AgKLljZzlYveGBUSMUT5vIyqf8muOn6DzBpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkmAxwmy; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkmAxwmy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737773779; x=1769309779;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=V2BpFjBFFfnyr7irjQfJA/5+Ol+2lUxmQnSQ44iXTAk=;
  b=jkmAxwmyQFjShBJ51VGweGRQWHYSQsPiTbKOVGgydyyPnvADjh4NLw0z
   63EgoKZxPBKwCnRj5Lj9hvUGo9988r9wRJRXEJvzds4mc/x9ZhcEC3Hvo
   bTAtwfA8+aQSQ6yDJoN5yhrENXI8cOba+Mumc1J2YdxPXdmfcLCA3tO5j
   TvD14XaO4UfkEImEJ4oToUw42Dq7/tBzGWbYK2iTsbcBR0lt0zz61R4FT
   bOFJ8OFC4JYJsJoNqAp4m7+jzMIpQlIh00BZpbTqEZDVtXt2DJuIwCqJs
   Ncd0w7ChzsTBRT8JE9TsoqtEEVtq2G/flFuI0BwtIcjF+MEgmYwwz4Xcx
   Q==;
X-CSE-ConnectionGUID: wOBH1rj8TI+LM08rO7bSCQ==
X-CSE-MsgGUID: AK9KL8KpSXKlwZ0WP99uNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="48906827"
X-IronPort-AV: E=Sophos;i="6.13,233,1732608000"; 
   d="scan'208";a="48906827"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 18:56:19 -0800
X-CSE-ConnectionGUID: nmcQBN1vQk+OhwtJz7YXwg==
X-CSE-MsgGUID: oWspvclYTMmttHekUzfYqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,233,1732608000"; 
   d="scan'208";a="107734339"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 18:56:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 18:56:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 18:56:17 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 18:56:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCP6lSm/7CxMsINqE3WT/YlU1sznVvLJigqonUAgZLP9+IJ2Ci+RRPMexZif6ZsFBCtdq16ymewJJk34PIdBL25RlqXFFrlmfR4F578q7+kKApUYsBYV7OcFqW7FqA/ZG99NBfsULXNKIia4DTtybb0NbyHA2OfcadEP4P41q34Q4KIft2nAcRTiNUHmHDq5WBvf7layC6uoFO4ZPo1kqKuF8bKej4ClLWqZrWgnNiiaAcouQI+yBp7yqzEDLEcJoLo4LGVme6nG2QwhqNLLYj91DNR9mlSEGIM9jgv3NPTVU0k0lFLDiIxduMqMpK8bb2REK6H6fuTkNLY9I6a04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRTkf5lrw7TJ4shqnZXBlsxG9qV3y/B5rI1PprVPz/I=;
 b=raWHEWFBOuhItWrmQyltyXMLDVHFlMVPQV0jbhjFciiCOotQn3krX9868bBK3MzBZZF9SHfBo0hoP6ROaOX8egFqxbvgaDkWCQoYvISK5l37dj0kUS9gqTdPwZNoRcIhvFfjola+IlKjHNNhM448kMo9d34UqFU9nGjbxRt2jKHA7Oza8t922dvInTHOjp08vr8IfgiTf7IAO3Y6f3xm2Rm21pW4utZX2FRv766z9RAASKu03lx/+Fi9ENRDj/OhtiqxAlpidp48Bll4b2HiWTHQqDIOYqCuL+rM3RchZLthQR2StbBlN6E4wcMNK3XDwM6XA++q+YV7hqbCghnV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6927.namprd11.prod.outlook.com (2603:10b6:510:225::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Sat, 25 Jan
 2025 02:55:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 02:55:30 +0000
Date: Fri, 24 Jan 2025 18:55:27 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 19/19] fwctl/cxl: Add documentation to FWCTL CXL
Message-ID: <6794529f6ee16_20fa294a3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
 <20250122235159.2716036-20-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122235159.2716036-20-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:303:87::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e65822-81d3-45f8-7970-08dd3cebba69
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mJL/2Y4xndLDRlacHbwlWpQ856ZOrjOT+d+f2MqXba8lntekTAPJsspX150O?=
 =?us-ascii?Q?phyyPq1F3H76g4A+S383qawueQiyUNy6078eiYbJ7VP7pZdbCtq6+kzyalZB?=
 =?us-ascii?Q?I6tvRx1A1A14nUa8z1XLHk+2rem19NOAiTim0+oMlQDI3oANRGDWaQx03ozy?=
 =?us-ascii?Q?Z7EHMU5tdr93Vj5ZarmZVZnHH93GLzdUiSIeRTJXx/4zAumRuFX6AG9o1wuq?=
 =?us-ascii?Q?qPeEFoF/cW7SQwxuUkU0KzC6zzSLF3TbegiQPflM3VoMtc6TMJ29HDocy+r9?=
 =?us-ascii?Q?EqylS3gnZO9H3Lj1lv5ptNiEEETLRIBKmFgm2SALZumiypZrpfcFDIJR3sUW?=
 =?us-ascii?Q?5paMtUvkDcsqgg4878VQCIsX1jI+kLjfttoCvS3QUbfaKARlcb+70YFTQ32q?=
 =?us-ascii?Q?cfT80CZmdaDIEOeSUnfqG4iv3hxl753x+xL8bootxZBgC0tTujCOyGK1oeTK?=
 =?us-ascii?Q?2EmtgOmH8cdx5SnETRPAR1JUBEcWMKfXWmIs/tY4GhkEnwbNQHNWIjOa6ZBX?=
 =?us-ascii?Q?kJL2sI/WIKSynGPuZ5eNafFR/Jt/nz0mfPySgOi20uTOLZ0dPhBMTAc0tw2j?=
 =?us-ascii?Q?q86R/n6eMsZ6lVLty6EedLjQAmIeayf4PhoHHd6ZEokavTM3ijJzxQaY1bQB?=
 =?us-ascii?Q?biSBAbCAJ8rXA/9uqEzxPbf5ro9VyhS9MH55lPEetYd4li8dodHFyos39kI+?=
 =?us-ascii?Q?LbXFOxLz1xkWy06xWGrF6x2CaIZHp+wUEIKLefEVYWsCY0DHd9zgzMbqam1R?=
 =?us-ascii?Q?smZmxGXsKmJuZA79Y1QVH9efsNAAqew93BhCA7VUEhwLbLckmRahmedMC655?=
 =?us-ascii?Q?2sWI93uHlhQnC9vYoPQ0COkc0NvEhBdF9krVVlottc1bnxh055gLPp84L8PR?=
 =?us-ascii?Q?Tm4SrRsPdAQb9Dq94XoTwOnoEe5mldqIbHUbvdl8ewa1Wg1X6wJe6iNu6Igs?=
 =?us-ascii?Q?620zrkKStOvPkh8kS0upnTmEdeUPpNefUL4OGaY6PCaYD+Ei1MJ1SREJmmFq?=
 =?us-ascii?Q?y1HqD/G70RPB04gN5Q6RzwA5Jc1kDGHOfCAj73CwNFDe1GZvSD/J3/ZHl3HX?=
 =?us-ascii?Q?NRVtkVB/PTFNb+IgwFmMZ6bj/+ww+iF6r04tdVzllNaIJqbnNKkHNVOvzKgy?=
 =?us-ascii?Q?OhptQDrdnmqHgBftl6vAOmOjdPzbaV6V7ZgTXCWXRn5p1lsJV83uC2wt6pi5?=
 =?us-ascii?Q?YfQ+JeHbLVguWTqpRoALmgUck10HWLJkICBfdATBOORYh69qYPUrz4AlNuSH?=
 =?us-ascii?Q?UtCIvtgw3vuCJhG1mnRMtMIBTYY8VJMyNiGM+TqTFjW2fXospVrhhy1qpEqf?=
 =?us-ascii?Q?OeAhPcnSxmY3BddCX/RwqyMZBvnAiwSxq4U4UGzBbRINUSu1uhB0hdTyhYB3?=
 =?us-ascii?Q?6KZmVHuTAL8zVQcC3/o8TW3dA+XW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EoFy6OC4AtL28ycdnEG51lGmvzUhzCGMxOMdkgzDAhu1d+Y8YuvEhFpNw+Q6?=
 =?us-ascii?Q?klPfd7UeS4wXqVXHzuArCMPk73l1Pjcf+hiMATeT+tsFMwfzF96UzcahOohL?=
 =?us-ascii?Q?t39tZ2VVmlfx9PmhYh6aMkzAjW7gKuEkl6vtcbImYl0o55j/pHgxT4Q2wAL9?=
 =?us-ascii?Q?BsjvDw43gZo/oL/6pI7LuUL8Jh2vEuEwwX5RzRiqOcwTU1YJbXrqCjie/Mno?=
 =?us-ascii?Q?JsI1Nai3yB96BrmJeMl1GHd1OaXSqP0f8yEoqxqa/rtA/DRbb6r/bs/RZsAm?=
 =?us-ascii?Q?CPWkB3DBg5jjcWsRF9fMFEq/xkixmK+taxtqkB+x+v/xMugYFlyd2O8CEq/h?=
 =?us-ascii?Q?xpRSxW4KKwndWuvD4qCj0QBtT6tuVWlSNAPl/AKN1jJ2DZgokp1bu7FOl+6P?=
 =?us-ascii?Q?zUS6RCw9ToJEehn3hXoZINkPtBaQ0qoIS+jG36EptsCh6qqk3FXdOFwzDslX?=
 =?us-ascii?Q?8TDFwFjaBUSIUVMYBKcu+6exwsi+PbGHVFGiqzd2TWMf0XOljqqo0Gm+PN9E?=
 =?us-ascii?Q?kANZwrhpgYd/Tp57Z3WBqRVMFVew4RpSYEQ4W6l7DXQKcR0yiWrHDtMLVlWC?=
 =?us-ascii?Q?LEWm+SynwhKhkYuJsUW6+QPH68Pe2Xty3Ra0RFmmfFywCbX80rpvlGTyoraH?=
 =?us-ascii?Q?BUWQSXN5j3ZoFYgWlnG1flNHrFqF0I0a1q77LjYdDk7Em1ZVtwsBmDScb8Tu?=
 =?us-ascii?Q?GUDPnG6Y8uiB1PnSNbcZYZF2knG6HOIIMd3d5aJkyi0DGz292Ka+m9G5zcFE?=
 =?us-ascii?Q?RWC/D8r8AYQ15Cqr32QjRG2ndaSpiG1lCzbaSlwvaHLMYlJ4CEU7EdSivdre?=
 =?us-ascii?Q?d1rVPiAZWy7/4pEI0lBva1XDp65wAKMZLmW2NdItN1m07lZLQNgewy7Qc6rm?=
 =?us-ascii?Q?P9wKg5M/UqfSXay5trkAH6IlgyrWJl4mCUesFTxKay1hQBlV+aQkkpkY0G5v?=
 =?us-ascii?Q?eRfOZwTnDjm+YFrMGUQRGQDR0VpSLh61HrSZpLbpNaPF6Rxe4xiz3Dn/XgIj?=
 =?us-ascii?Q?gnO3U5a5b/Yc54LLMVVc44DtnlzIEYty/C4qUS+h6xM/PQiFreyGY/TPALda?=
 =?us-ascii?Q?MF7R/udLbHr0tzp5E4v+4i2bDjJJcjLeiglUKqwSF3JKrVrUzUsoXKNGYQuv?=
 =?us-ascii?Q?r3z9eCNw0AvQehroRtqt+X9JM/XHFXwTHR7sATbvwvqwzIgMlegzJUX7OGkd?=
 =?us-ascii?Q?1VnIMLkbKi46JjIESXvkvuTM68rKAfzyJ8abFA56Q7IPel44uGRsUjpRVMNJ?=
 =?us-ascii?Q?vq5uHmID7l3CXzLZuY5MLuh4Fx8N8FTDskvjUt3Rv9V96RkDXU30lpzO4kCK?=
 =?us-ascii?Q?lN20yJCf23cYbmyMVy1nsit35p2PzdoMuc8V9SqgpFUPFEfGpdHksuwnAPT0?=
 =?us-ascii?Q?wJ38qEdh3gzlCBbATtcPwR8oB8pviOZ1c/0v+7FxJK9waTVhL96TS+qnKBsI?=
 =?us-ascii?Q?4kJa2LBUU2Er2kktgWlxARO5h8k+1fXV6TNkudxHqKJ72c7foX+LVK8aZa7V?=
 =?us-ascii?Q?2Azt1g25kvbBGT43JBcmPDl0k/VCLG2gUmBb+eJdikBa0mYn+RDYC1zzmiKt?=
 =?us-ascii?Q?VhjkOh5xICcRGdIWTRe9ICgvQGYMw9Uv2pElee35cxK3V+7Jl4x3c4+fwwQD?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e65822-81d3-45f8-7970-08dd3cebba69
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 02:55:30.0092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2kz26cQqBx7l0alGiFNrYlnvjItkXLgg7cFL1ABFR4CIuMjhyWVkQ86KKhy9e5vxzOwUElhGH2vN0lb/J+SPuWqSvbZSZuJIHHyxdTIh7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6927
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add policy and operational documentation for FWCTL CXL.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  .../userspace-api/fwctl/fwctl-cxl.rst         | 81 +++++++++++++++++++
>  Documentation/userspace-api/fwctl/index.rst   |  1 +
>  2 files changed, 82 insertions(+)
>  create mode 100644 Documentation/userspace-api/fwctl/fwctl-cxl.rst
> 
> diff --git a/Documentation/userspace-api/fwctl/fwctl-cxl.rst b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
> new file mode 100644
> index 000000000000..f774bf2ecb5f
> --- /dev/null
> +++ b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
> @@ -0,0 +1,81 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================
> +fwctl cxl driver
> +================
> +
> +:Author: Dave Jiang
> +
> +Overview
> +========
> +
> +The CXL spec defines a set of commands that can be issued to the mailbox of a
> +CXL device or switch. It also left room for vendor specific commands to be
> +issued to the mailbox as well. fwctl provides a path to issue a set of allowed
> +mailbox commands from user space to the device moderated by the kernel driver.
> +
> +While there are a large set of mailbox commands, only the feature related
> +commands will be allowed to be issued through fwctl initially. No background
> +commands will be supported at this time.

Just describe what the CXL FWTCTL for Features Interface is, not what
it would/could be. Someone reading this doc on docs.kernel.org without
access to git history is going to wonder what "initially", and "at this
time" means. That's better changelog fodder, not interface documentation.

> +
> +CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
> +CXL spec r3.1 8.2.9.6.2 Get Feature (Opcode 0501h)
> +CXL spec r3.1 8.2.9.6.3 Set Feature (Opcode 0502h)
> +
> +The "Get Supported Features" return data may be filtered by the kernel driver to
> +drop any features that are forbidden by the kernel or being exclusively used by
> +the kernel. The "Get Supported Features" command and the "Get Features" falls
> +under the fwctl policy of FWCTL_RPC_CONFIGURATION.
> +
> +For "Set Feature" command, the access policy currently is broken down into two
> +categories depending on the set feature effects reported by the device. If the

Capitalize Set Feature throughout when it is reference a specification
term.

> +set feature will cause immediate change to the device, the fwctl access policy
> +must be FWCTL_RPC_DEBUG_WRITE_FULL. The effects for this level are
> +"immediate config change", "immediate data change", "immediate policy change",
> +or "immediate log change" for the set effects mask. If the effects are "config
> +change with cold reset" or "config change with conventional reset", then the
> +fwctl access policy must be FWCTL_RPC_DEBUG_WRITE or higher.
> +
> +fwctl cxl User API
> +==================
> +
> +.. kernel-doc:: include/uapi/fwctl/cxl.h
> +.. kernel-doc:: include/uapi/cxl/features.h
> +
> +1. Driver info query
> +--------------------
> +
> +First step for the app is to issue the ioctl(FWCTL_CMD_INFO) in order to retrieve
> +the information from the driver. A ``struct fwctl_info`` needs to be filled out
> +with the ``fwctl_info.out_device_type`` set to ``FWCTL_DEVICE_TYPE_CXL``. The
> +return data should be ``struct fwctl_info_cxl`` that contains a command mask
> +that indicates which of the commands are supported by the driver.

Per the code review, succesful invocation of the info command implies
the Features capability is operational and returns an all zeros
payload to indicate first generation interface support.

> +
> +2. Send hardware command
> +------------------------
> +
> +Next step is to send the 'Get Supported Features' command to the driver from
> +user space via ioctl(FWCTL_RPC). A ``struct fwctl_rpc_cxl`` should be pointed to
> +by ``fwctl_rpc.in``. ``struct fwctl_rpc_cxl.in_payload`` should point to
> +the hardware input structure that is defined by the CXL spec. ``fwctl_rpc.out``
> +points to the buffer that contains a ``struct fwctl_rpc_cxl_out`` that includes
> +the hardware output data inlined as ``fwctl_rpc_cxl_out.payload``. This command
> +can be called twice. First time to retrieve the number of features supported.
> +A second time to retrieve the specific feature details.

Please convert this from passive to active voice. I.e. s/should be
pointed to by/points to/

Some sample code to enumerat and issue a Get/Set Feature for a made up
Feature UUID would be welcome here.

> +
> +After getting the specific feature details, a get/set feature command can be
> +appropriately programmed and sent. For a "set feature" command, the retrieved
> +feature info contains an effects field that details the resulting
> +"set feature" command will trigger. That should inform the user whether
> +the system is configured to allowed the "set feature" command or not.
> +
> +It is recommended to take a look at CXL CLI test directory for a detailed
> +user code example on how to exercise this path.

Should be small enough to copy here directly. Otherwise provide a URL
directly to github or similar for someone reading this on
docs.kernel.org.

> +
> +fwctl cxl Kernel API
> +====================
> +
> +.. kernel-doc:: drivers/cxl/core/features.c
> +.. kernel-doc:: drivers/cxl/features.c
> +   :export:
> +.. kernel-doc:: include/cxl/features.h
> diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
> index 06959fbf1547..d9d40a468a31 100644
> --- a/Documentation/userspace-api/fwctl/index.rst
> +++ b/Documentation/userspace-api/fwctl/index.rst
> @@ -10,3 +10,4 @@ to securely construct and execute RPCs inside device firmware.
>     :maxdepth: 1
>  
>     fwctl
> +   fwctl-cxl
> -- 
> 2.47.1
> 
> 


