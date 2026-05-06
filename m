Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5A625776
	for <linux-cxl@vger.kernel.org>; Wed,  6 May 2026 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778044780; cv=fail; b=mNkJS7RXRPs06PKdHBEvqX/6tEJE4aWL8gjh2OpQVoN4JgPUqn931oEZ9QH+JNnlG+Otez9k9FzJszlpJyC7Y6U/Eyz5PbFN5pU1LEvYJMjN4JVXhk5DpEWvz4RCIA6/0fSQgJ7ZsDhI4UME0o30hIgLDxjMHErV9nM5KHLx6xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778044780; c=relaxed/simple;
	bh=HM0zdjvAboXejJnmG2JTDANMi0MRvJ89IYkgXlYpF/w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B7Xk5NoY6hwv1DJXIerntXF75ykX6XY9R6SgOHS1qXSIlL1LiE9gRWkzP1ziDWMQagSl9G7f7g7/VRQVQ5bR9h70z3s2dBOwzkyWPbgTTyiokLiVlXLrqi0yrtp1oomKYNb66FNPTYp8Rc9caEcss5HSti0fQSR4WNo14bajkng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZaOt4dA; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZaOt4dA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778044778; x=1809580778;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HM0zdjvAboXejJnmG2JTDANMi0MRvJ89IYkgXlYpF/w=;
  b=OZaOt4dAg2eG07ido9n264p+Hzu3lx8shtXCIKCpWjTWEaYewhLnapE1
   Mm41EKGg+vnf7gkbogTXRtErTcTRbGxfbQNGLIItIm5YlUnBi6dJf5v7F
   LiOclNOVgbqfzwmCq4B4vBuk2oQENAqljKjsa2MaWmPSfLvrtASLlZaZG
   t2lYIesnBH5TAMEIjL0biIi6WpnZxtOMMUe0OqC8wNUj+tdN403sG7u7d
   xZVY4IyRvvwy15TBzvNoapRcbuQVyui7SU7M1yEJCtUw2psTJkS0MEJW0
   Z9QU2uyBmOtnRTrsJpJFNlqmjc3OupKVAJ23oSqO/785pxoQlYZ4H1q85
   Q==;
X-CSE-ConnectionGUID: N3AjWgYNTaG1asowpaWFWA==
X-CSE-MsgGUID: z2nA0cy2SMyNyN0qpGdBog==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78789696"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="78789696"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 22:19:37 -0700
X-CSE-ConnectionGUID: ss7AGF6CQ+uuZrrPdb0/nA==
X-CSE-MsgGUID: WPcIrvoxSBun0fN3IqnYfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="231439040"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 22:19:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 22:19:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 22:19:36 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 22:19:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Npnx6NEE08sLGZgiIVcDOXIhAMdl8AWlsr3l+0BcjO5egIO64IHM+qaa3ky0kKOjuSaIPJMHY6fgperLkz73oKWZeeqJI58TAmZ11z6dgNX4caohzsjzoV+g/ZbFKUUB1kbO+WpGtcVUqnOfFiqtuvLcVcJIHjtY3WZZ8nill5cV400JhtKrte2EXyhlcSh/NLSt7Mv+NvH+hx26TxFKD4ri2DmQbMQ8c2H1yykAJyJnZ8zn0ILLE3pC+aNm83CsBvWlYxliw+otXvvAeMEyjlggEjTMmQyXvNQqRz2WdaZDAa3FP0gIaxRFA2QmSw2kEviTTatgBB1fkcATyJmEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyOKm1i87/nmH+qetXRiE17hFytbWkiPL8OC3+8huZo=;
 b=V60udtxOEhDhLmBA6jPzVWMU226iOMBe5Cw3cua/o3rJqeJumfQkL7/qUFAM1VcW9vBQTvtUY1DKBzpdJ363L/5eVBlMIjFZ7b3nGnVmm+0GHsJW2ZxTKmPvTX3cJGCAIdwB5iL1fDFMzQ0dGQxt4LTH3XNmDUs8h5RudhM868Odmz+vYnf+y0+jgdTzMj2BDtBmM0fXZbi6ka+iy60BknGaJOFLHVSmML5X90cAhA4eIq7JQZmS9QPm1n0ZHafJ0fiHID/F1o8l6UQdNsrfQdWXTlfH67lxdNMvkiYXzOtTuv7MwOCsxUBhfUcnfzdKwkpJOW6AD7p70DQd2co2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MW4PR11MB6910.namprd11.prod.outlook.com (2603:10b6:303:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 6 May
 2026 05:19:28 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 05:19:25 +0000
Date: Tue, 5 May 2026 22:19:18 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>
Subject: Re: [PATCH 6/7] cxl/test: Add cxl_test accelerator driver
Message-ID: <afrPVjKIQEPwCUAJ@aschofie-mobl2.lan>
References: <20260422230237.2599333-1-dave.jiang@intel.com>
 <20260422230237.2599333-7-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260422230237.2599333-7-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MW4PR11MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ade66d0-3edc-4d15-fb3e-08deab2f0a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Yc+ylvKX2/JXIq0KHN9lfdpEzVwUhaFxoH/NPi3tSwAaCxz6gzeY0m8zZBMYVfT1PROLGyQoy0+bSgOHDnDYnvfx1N+2w1wqnhYom/lsy6LXpbvgM56mvlRqtaLZmZZdfopZpbULh6l+qcF9fv/sVChYTlXhaeR0lPLtZHVBhuJlKT4CTfEulndFj9k7umpkWtbmRD73t2oPKQt3N/o6CJe1SBh/JYSFdZzVOuMerIq4PXD1yBV94JBTQKvgEo3NE83cpVviVHyIBTJ2rhE31ntdwcpZ9DD7BZgz058yAvTLJw1Mom+/0uCQsdCqf6YSL5dERuuNxAsUi9WxpTbr97055tqokRAq5NJyA+8SmRBm2Ry1zo5fbXg9MRrZq4Wj84F2l4Gf0zaCIXVUG1ahddpo/HrquspqwbVt5FHySdQIvQoAxvjqHf0v3WIaMJXQbnYDY7Ci8eik7eWLHAe5aTqmtJ5V/90Q9PRBzd6q/K/4z06gv/REfLXks1KNbnH4Yo7ToWeQkQg0DIjcqK+YLNwVt4w4hMw/uXYAjo8eFhNK5iEvGiMvC85BMSe9C2vfAdhg/lWRW8Nwsgj75+dlccicAEh7HCahMABiZG7kuRVtC94Jqwgw2LnjSVP0Uv7elWwCjrskNqTtCP3emW2mDSS7nXWPhwl+VhuP8O/6kLXA7jAg53ypa8imWO4cZUeK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c9urR5qYumrj7uWBppXsazW+fz03VkUZd8iEdZPaz2I5bAt3GbggHwtrgWnK?=
 =?us-ascii?Q?OGkvrMKuHZeJ6ZtFScZEyzpaxHvs8tFUb9PkRW8c3CZ9slJAyZngi6QCEzja?=
 =?us-ascii?Q?RtsZZ8RypA4OO9XAMeImfK3j6Wmqf/bR+tRrhHIs0nNu6dd81e4Se87KWkaP?=
 =?us-ascii?Q?J3DuQfS5Pzm+ufTcQBFQ/alAHWSKj5N8sf8sgd6Ig4lYQ4RLhuvq/apgxzrC?=
 =?us-ascii?Q?5lCJxlsjWhPmWnHTSssGMSisu+4LTQgjPDFNlp/0IA/yjR0iPBR4kQIewr4b?=
 =?us-ascii?Q?kMqH2fBaEwt1PmFpgNWVs8NJnQ76v3We7HYy0vun8JdbOCavcyHJ9oGXx2lE?=
 =?us-ascii?Q?oS1+sBMOChMEKFyjuN8CYs+AQWq+/R3I5PFWyGXAWTW/tTtd11qKLShudXTw?=
 =?us-ascii?Q?z/y+IE+cjDj0eh7tNhk+IvBzeyDzJ2imSFLiczqFSDEPrK2ou+9tgKRLR7JG?=
 =?us-ascii?Q?29D+1SVbd8XJZV56tJB6a2hhn2cEF7N4yYjAf9d9Xw7c0X8n5PK8yjH7zORQ?=
 =?us-ascii?Q?HZdrkwLFysh5MF9YWee2ZyngBQiHXPB1k9lN/JtOXSQgv+a0ofRdHyK/0ay1?=
 =?us-ascii?Q?Hs8aXwsKqD5TZWz917L8tdaArJA/gNabnm6tTmbNBdwr/cda1ZmqQWDxqCkP?=
 =?us-ascii?Q?J86oKcIcv1/2TEuANwBJQZFwWIKakHQM4EJKhdhNkoreQx9+JoyOmiF6HK/6?=
 =?us-ascii?Q?BFsY4Kawak8oizivGDCS3lMY3AMFAPMfaj7hCDfzlE7DS+KBK1isik5YgJaP?=
 =?us-ascii?Q?kWf8oY+f+pU5LA/Ihh+jyYe0jlrMPCzQJ+Vv9EW8IZ2Armuomr6HTsAEPr/O?=
 =?us-ascii?Q?c/heGVP2ZGLhT/7Tcs4a86eBbw1jbf0qPFXs2rdp9njw+dkP5tDJkT+Mmpgo?=
 =?us-ascii?Q?tBrFDPg7hA2EU7RbqvqMsMpkMzjMj+QFJ9Iw+I2XdNiVeie1ZOdhv6sr6kw2?=
 =?us-ascii?Q?aN8yMuh3QkSR9hdDCKj4gdBiBNAtW8YOjBGn6X1S4h8kLPBv3n2Y/hXW76Zt?=
 =?us-ascii?Q?xs6ZkCfMevAFXZ+7wyD3oXE4CSDyICAh2EUEnD7yg+A7v/XsvucK2k4aGAZB?=
 =?us-ascii?Q?D+sdTUCultRhdDhtkwXD/UcKGaElCD+B5r/71WXE4hVE5FWhHf4w7YzYmIpd?=
 =?us-ascii?Q?2/1p4GilBdNoD5HQ0xE9H+auGmW5ufiBFYLMtOnwqV3H3mYky40h4IHkcJgQ?=
 =?us-ascii?Q?RfHuNK1W8dE64rOKnBQpk1p+sCOqa/+DHKh1GDC0g5KeLPdjzwjitj6GorHq?=
 =?us-ascii?Q?l7sH5dK0acBK5UD5dSBYF1MHyjnBVrk3fuv4Ifg9x+BggluGoWDdF0dicpoT?=
 =?us-ascii?Q?y5xpUXUgfKuJakwnXdI2RIm5qUTQuIRnjDPOFKz7p46+eNqGdIJ4f7/e0D/u?=
 =?us-ascii?Q?sraLSWS1gYHxfgRhCAxmDhsp8Hxa4vr3KyXxjQeTBnzhaz0TWY+ODsrBwTWI?=
 =?us-ascii?Q?kv78vaX2C9xPee+cS85PzYTvJEwXQYXVJ6YUCjsQ0Sb6KmGSn4SD5Djk69hF?=
 =?us-ascii?Q?5YsFXN4XqyflNYYsyM/8Y4Gc8PWO1BEdYu+u4W+2Vjm0mFPHYg++hWD9dtTf?=
 =?us-ascii?Q?WTkGcaoVt1cCyqnrSLgxdB5p8QKExWto60orltbiYULWOK3e+MLspArTRg2e?=
 =?us-ascii?Q?hXscGQYReO5X+LOjJvuY+MUlxmkPcvDqNS6+zVzDZ2MkWTXQUlxAg+wHoVJj?=
 =?us-ascii?Q?ZB1vUf+fNtwU+uxYJ8NwFkp3z7mLhsz1FOzFiTiOacCTpMi4EqJm2sQT6J8n?=
 =?us-ascii?Q?s/5U4gUSxfCLsrCCs5rpOjlaEsDoFCo=3D?=
X-Exchange-RoutingPolicyChecked: T12snEuF+e+SLAkZIyuarmdrTPU+/8Wz9CB3ao6pJWAusEZoYXyHXX+EFyGS+LPAV51WPcUMH3CM7GZY63H2ViYx5vsXcJuBLTD+5vxzA7xw1YVOsdM7yYGiFxh9dYqrxEYbbzIMklc4qjPR0fRIXhBo18dO061EwWt+OzeJG727WC8PUql0rrJLq85BR1R+EaYEV8raaw3gQEJBi7ShWOORRWD46CTArT0/baeoZKBjdzKml3SY5hqLkfs2Oo5wPZBq18hldcN4n/BcFqG2oiU46OH5bwyW8HDzTZN3/KCf5hoISIhm1bK8sfVz/VKdOTSZTPl7YPz40kbRE1t0lA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ade66d0-3edc-4d15-fb3e-08deab2f0a19
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 05:19:25.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13UtdTnFYoWZxnzCl6brhJSja/rBkxIN53EqBaOnjluQpI/V2G+QXKzkEXfq0Ybu0zkSZ1YZC+t0ueXosee4arv9XefdwL+n5p+Frh8sMFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6910
X-OriginatorOrg: intel.com

On Wed, Apr 22, 2026 at 04:02:36PM -0700, Dave Jiang wrote:
> Add a type2 accelerator mock driver for the platform device that
> simulates a CXL type2 device. The driver exercises the same
> minimal API calls that a real CXL type2 driver would utilize.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

snp

> diff --git a/tools/testing/cxl/test/accel.c b/tools/testing/cxl/test/accel.c
> new file mode 100644
> index 000000000000..f21fdd57034e
> --- /dev/null
> +++ b/tools/testing/cxl/test/accel.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright(c) 2026 Intel Corporation. All rights reserved.
> +
> +#include <linux/platform_device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/vmalloc.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/sizes.h>
> +#include <linux/bits.h>
> +#include <cxl/mailbox.h>
> +#include <crypto/sha2.h>
> +#include <cxlmem.h>


Unused includes: crypto/sha2.h, linux/delay.h, linux/vmalloc.h,
linux/bits.h. Looks copy-pasted from mem.c.


> +
> +struct mock_cxl_accel {
> +	struct cxl_dev_state cxlds;
> +	struct cxl_memdev *cxlmd;
> +};
> +
> +static int cxl_mock_accel_probe(struct platform_device *pdev)
> +{
> +	struct cxl_attach_region attach = {
> +		.attach = {
> +			.probe = cxl_memdev_attach_region,
> +		}
> +	};
> +	struct mock_cxl_accel *cxl_accel;
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev *cxlmd;
> +	int rc;
> +
> +	cxl_accel = devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM,
> +					      pdev->dev.id + 1, 0,
> +					      struct mock_cxl_accel, cxlds,
> +					      false);
> +	if (!cxl_accel)
> +		return -ENODEV;

devm_cxl_dev_state_create() NULL return means alloc failed, so 
return should be -ENOMEM.


> +
> +	cxlds = &cxl_accel->cxlds;
> +	cxlds->media_ready = true;
> +	rc = cxl_set_capacity(cxlds, SZ_512M);
> +	if (rc)
> +		return rc;
> +
> +	cxlmd = devm_cxl_add_memdev(cxlds, &attach.attach);

Above is storing pointer to stack allocated cxl_attach_region.
The stack goes away when probe returns leaving cxlmd->attach
dangling. I think we get away with it now because all our checks
of it are NULL checks. Would it ever be derferenced? 
Maybe devm_kzalloc attach or embed it in the the mock_cxl_accel
so it sticks around.


snip


> +module_platform_driver(cxl_mock_accel_driver);
> +MODULE_LICENSE("GPL");

"GPL v2"

> +MODULE_DESCRIPTION("cxl_test: accelerator device mock module");
> +MODULE_IMPORT_NS("CXL");
> -- 
> 2.53.0
> 
