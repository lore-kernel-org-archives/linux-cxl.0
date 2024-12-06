Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61813DDDD
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463652; cv=fail; b=PsAlsRsWirGT3g2OlXlDZPcqFQChGkWl6l0i1Uj+W+XiDc4Wyns5k26bzQLuYDXVpOyeV31b5M7H9h95/R7Fj/8VpVsf2wzE+xlpawII1C92DJn3vJGX/pL7D64WsV7YdT8XAR7HqTtxUN5XhFcPFqQL5tANqSD1SDXm41DZ9w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463652; c=relaxed/simple;
	bh=5lbDVOHnUvOTLFvKANS7pvPLusV0D811AiEDWmjRcNw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DMEZoj6udIDUmzNpq9j62i+9gOLd4Fg1JWDAsZOhx1trv+dbM3/bUQdBdxssyqzPo9LtSpMZ4yIpM+aQ3nbcjErtOqqxMQePY/rgfTPQCsjW/qz8bLaK4d+C4/CIYKn5rcV6crO5ZjCuPaS2uYD9ENHFF8PAxIqH6kfiAKcLYK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWhV+mnO; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWhV+mnO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733463650; x=1764999650;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5lbDVOHnUvOTLFvKANS7pvPLusV0D811AiEDWmjRcNw=;
  b=CWhV+mnOVIXEJV51oZt5cgkuTFmWYeZWC7k9qqlEDd/tRipn3hJz9EP1
   bo6UsOA4AYlAPJyh1xKGZP1VO988YXSWgL1zdCAMzLD1opl/FRz8U0wAk
   DQhfMXMD0ZBOiyJdORo9FWwe5i+usoUsgBbBummLHMEMGJjXjMh6oF3qm
   8iy/Bh5EUr7NqafmbZHV24azscwHVRLBDs81nFJkXXoJ2LYIA73T5TrtQ
   B7BMzyg+i4y5NRs2LHtiR9nsfwQ+OTlYp8Lk0W/hXMD+Pcc7H3q5mSl7R
   AjJkeUe7QFapDM4TpYMaBVsymSQN2Z1QTCQJvyCY0JgWjWzPeg637tm93
   w==;
X-CSE-ConnectionGUID: n/A61z9wS32Ec+XXM9ru/g==
X-CSE-MsgGUID: GlMI+ZJMRHi0vtcwbtJK8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="59207431"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="59207431"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 21:40:49 -0800
X-CSE-ConnectionGUID: Tf87kiGURiuv/+73b6JZAg==
X-CSE-MsgGUID: GKw9nnndRNS72tlsZo2Znw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="125212862"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 21:40:50 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 21:40:49 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 21:40:49 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 21:40:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFyc5n4ob9g/E2ZTEeYpPLQzW0FSf6LCMseXU01syJ4sLWBq3OZ4At4bv1+QHfcb7EQFWC7q8DGLP8m+y6VjDOmS2Rs5cp6A4I0/ZfYs0p15kWw47QYoKLElqNFloyYCkjyjJ6pa/Y1giZyecZs0Hvb2Wnqn7pGuaP/ifpv+ZCUIgDKme4okTWssmyee6DflzcQDSzKaL2BRoElrM/wL3U0ydb/4l8BHOyc28FwEQn9FBHXQgtL5j80vfCFlredjLjbnqhJyGkdjqescKq6v31KbsbbdrHAgTRujLsZI6s1Dl6Z9UtL6wO1/tON1MjPU5Trj9df9X4xBmRVPziad2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwOczUmaZV5+mWcbnRIzGSbBGqQ2gssnPZuzqm/ZRao=;
 b=mPciEATx5wK/nrYv3ivZmA7SJVyriAXv/krc/OwopKZmJAFOO8hAyHeDi6YKoXdRb4vjZ6cHqU9gJvqAdhmgV8axowo89IT2nRn3oh9+MRCPNhdRR45yXBPbGlaBvzwxizHD9IQ5bIqe0JmVl8lM5n83TyWrDE4jN08SwJ4IaoGJAlvncEceCCLWuybH+ZerXYzZaKy+VOviFGzZ6Bs6xrYgJ8T64/CnDsDl6vhahRkPaaDz4EFm/wtwtrFeJP6eY/lVW/PF3Ff6STxGxH72jCaq3k2RTVMGkz5C42RJ0bVG2CDyZTvIKAY6Ize/rnvEEQUhYEc1FhYR4dTJ80q7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4533.namprd11.prod.outlook.com (2603:10b6:208:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 05:40:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 05:40:46 +0000
Date: Thu, 5 Dec 2024 21:40:44 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 13/20] fwctl/cxl: Add hw_info callback
Message-ID: <67528e5c5dea4_2507329420@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-14-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-14-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0114.namprd04.prod.outlook.com
 (2603:10b6:303:83::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: d4742215-8457-41c9-66e6-08dd15b8887a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZUCLeDAeloabe6LEojkW6Lj6u8p5DS9OLvYfeoVdh2SNhQ8HjZ3nQTh3xKVo?=
 =?us-ascii?Q?WImqoyH/57Cgu1of6b3I75FfsEwAKwafate/ZSBKMh5Ye2iZmI75Mdz4OU9L?=
 =?us-ascii?Q?RJUQDAcCo0oFqcpcM4YEqbZAn30QMlp20Xmq82IXZhp9z/+5hMJbzI2Gh92d?=
 =?us-ascii?Q?0Jh1GcwhR9kvOoHGXJFWDoT4MldphxYLV8TX/1hx15JK0gqJ8bLITyrGqHvJ?=
 =?us-ascii?Q?20N+JLbhWwUqbk4dDA9GXzqnGwq5KD67dYq6bBEaChxkCa3tOyzHFhIgTu6n?=
 =?us-ascii?Q?9ZpIs7TeblQGOBkL1XHsPkAnc6MP+HEftaqDo8y/iNPjeLL5nIRkmyWOt2g5?=
 =?us-ascii?Q?kW9KiDGNttGg4jmtIZJmJ9Pr75Aa34F5aQtyyU/luZ44kLIINZIf5nsAHAnP?=
 =?us-ascii?Q?WkOtEOCX0+Kj3sStHjjbL5modqmrDEV7W7yp0dz3TmyBQespXL+VlCCa3ZmC?=
 =?us-ascii?Q?diWAfvAaxjfJAyjUKgqhvz9W8Uw1rNC5Ldz6m9F3Izbip6wuu1nN82+Bf3s5?=
 =?us-ascii?Q?Jrb0OqZUPC7kpLhgN6Fc0HHsgU5acAEvSVEhU+6pkT57ukdCIquF2EogCKd3?=
 =?us-ascii?Q?q0Fj7CsA0jSie44fISqN0E7CvtPmCEIIxGOcUpFY5t7/PUM0GnFToJDwdCCW?=
 =?us-ascii?Q?0efu5BX0goN5W2PQS9B3HxJNxoLdxlNf/wVtyREo3v2RqN1PEOuVw/Jlmsiz?=
 =?us-ascii?Q?6qKVRbw2x46dLAEq7NXNaSkO99DSCkHT5scuxyTZ2nomPR06okNCl5ZPdqRb?=
 =?us-ascii?Q?heCsXCfiORIMpckkHOwsApaxIpxr9Gid9pmGVwCg0sSqFJ+bYx7qabN2mYvA?=
 =?us-ascii?Q?3kqLH3DbngqGJn+lubqAdViZPyIDQrgRSNnHX5px/r7/P9CclkAOTLIlbfjH?=
 =?us-ascii?Q?SHKmPsGlmhVvYlFE/sU4eRwBBDWENOSjRzrS9YQ/VAp88RrnqKqwz9F7gOaG?=
 =?us-ascii?Q?JgI/0QanDlm1YjEEAIQYyOeI9zqjpTNoLFhcTr4EmFKq942hASHhQNr9IjOu?=
 =?us-ascii?Q?EsNhw6jMCT6SA0ZXYN9zYvcTRb+Q4BsSyGxMyMSZNqmfmdASUx1sSxPnWDu9?=
 =?us-ascii?Q?yeru5/C18F8Sb5SdJefZslR13IOIGyNy0fO8g8La2PR5FCwgcADiJV1mfzfa?=
 =?us-ascii?Q?JWQlcRD8UY1cJIOfnJyERMHxLNknJo2qbvzXJ/pyYg9kLnQk9rMGn7TaKPSn?=
 =?us-ascii?Q?CdBGaaeg+gan1kLYPmuGK5qCjqp+rcp4xB2K/SsuSX6mwf1NB7fecvTGeTQE?=
 =?us-ascii?Q?ovvNsJCPFOnjbBiW5nekY4SQDgoxqpKZjHzwnYVJAINp3qsY0Ch7hU8Is5Lg?=
 =?us-ascii?Q?4nzM+ffQoNXWA2HVRS/2Lvy3srdszdHqPh4McffhzuJjCQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?05RQYGhHtn+7bWuHe6yCsGn8dc8C561HgbLzKBal7aqtkoCVny2FJjVARZDg?=
 =?us-ascii?Q?cawGtUL4SY9XRNr56ZED9qAYERhj7CJyxOWyD7hIme5yJTjN2o9zjQyB6YJr?=
 =?us-ascii?Q?NkNdlTAbpu1MX9of3Eot+eT99h/Vaoiko/M2dVIUJgJ6ltTP6wi03GYRBTyZ?=
 =?us-ascii?Q?7c4HznEaWNIF4Pn1aLb0CD5eLx8P4mDf/rCFvdw0PexmPjak//f/zfVAylHo?=
 =?us-ascii?Q?YnokhOLb6gx/ecxO8Rk7Bd0T7gjeKesSgUat4RQU3CCMJRq76IfNqFdte3Hg?=
 =?us-ascii?Q?st4AP5MLlMYX7nrLRmDG35OV89//NM2UbC9n8wvnqBKpF7l3UZflmnrT6cnn?=
 =?us-ascii?Q?2zeG/y83dL9UIiAd/HuQ4bygKSAmDDjXeXgiXFpNMWpcZ9Ha7mXB5r5ThmpQ?=
 =?us-ascii?Q?gDYDUNBhgPWLRB0U0xIUBSuGQtYsdDMLVBr005Q4tpWGPdU8NWri7LMdlyYl?=
 =?us-ascii?Q?MBLbGm/jLzy5RihPaXsbeUhNQXXhQNVy0xs3zfIPvSUCSI3yLG5yUkJgcJZf?=
 =?us-ascii?Q?UsZmjaF619bjJH5li9V0DLwvCzaowVfoAkGC+3SJ/+6G7BHnXkx6Fd1CHyqu?=
 =?us-ascii?Q?fmU1Zh2q440WGNN4voxFEkcadhapGF2Z4PVVM9FX1FqyDGg2b2V0+7K/kFLs?=
 =?us-ascii?Q?D44x9k5XcJZc1M0yOWuwEH+JwQe1+7V+zNczxmv57GK66xkuVVuUYP73GF5W?=
 =?us-ascii?Q?BlkJ6kclhv4m08bevDTtBs+MzxQhhRZCmMasw6O7AI6E/QL6nOQuTQBi+g6+?=
 =?us-ascii?Q?Vx5yupi6RfZC0knTARwyaNcjWqZgAppdWhdRg4iGZsCz5b2CGSi2AZ1tOZoi?=
 =?us-ascii?Q?t69bkV8as8MmTj8dB9H+JKEUHWC/uGgcnESCXuigQzZxHui5F2w6O/w7QFdd?=
 =?us-ascii?Q?UOrEf/OFCA48zM0V4sbY4NP4mamQ3mywLK7rtu9K2BcyHufYCpY1EZTQyR4a?=
 =?us-ascii?Q?fb3YciFf2ugIDnHRJG4ko/5EjdWEtNPDKjkeoFiJVTfkjB8CDj1eqPkJDqe3?=
 =?us-ascii?Q?ipRJF3wtX6j/G5wrW7iY5EFn8rcg2URMcW4O0t4TJ15VGKFa+mnVtWfH1qda?=
 =?us-ascii?Q?nqXrji4D03/EGZjo8e3Q1bay0gwmywxdnh00TQjLug+N+yldZ9eL2hJU/btU?=
 =?us-ascii?Q?iUktALTXik4hZYf9PEIROEPTumU2kEApkQZjrvI6+Qp70kZ/piPvmbPsDbux?=
 =?us-ascii?Q?HHlPnf3bKS371XXxyt1XmGaaoz7ZfpX/UdZdM4ilLafvyL3pu6/qKnOVynS5?=
 =?us-ascii?Q?aWkyXcd6W/vWOm6+1hlqOIYNozFz+PmcsyIRUNfhgfNseo1M8bvU2Ojmw3Lj?=
 =?us-ascii?Q?xH4ffS4g3mS3jAbTn/UflWwiGNxRu5YrN8ji1CqKdZofTjf9IbRToNv3slUa?=
 =?us-ascii?Q?c2uy39e1YzLQPpMTy3r0G24iVZ+JjBWxj0wBPQZ3I/q1JHVA9ZjmwBBlj5Ei?=
 =?us-ascii?Q?Z35C2s2vFxYN+lRTier31+UtykfTyK648UBIZLxT9pPzg7GytFv+8ZYUta91?=
 =?us-ascii?Q?byR7pNa81NaBIezKZ/F3KALEMc1JSTzV9qoXjmwd4IT0epW3LWD03CqTzImz?=
 =?us-ascii?Q?1tjYvaILkpuU8+toxtFaPN+F+PG8j84g8EaWdbHxRne4NHoEb6WDXUoU1Ioe?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4742215-8457-41c9-66e6-08dd15b8887a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:40:46.5577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RI/VE7OcotcOl2j4A6xHB3umRo4C2f6c91jlw6ODNbcsMRzhhxNmP3bYqmXwKa2D3/EDr+w/jMXdcyIWbeXf1VWR8nDnAUSvYb7Yuxe49tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4533
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 42 +++++++++++++++++++++++++++++++++++++++++
>  drivers/fwctl/cxl/cxl.c | 25 ++++++++++++++++++++++++
>  include/cxl/mailbox.h   |  2 ++
>  3 files changed, 69 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index fba6bdd30a82..65fceabb9fe7 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -9,6 +9,8 @@
>  #include <cxlmem.h>
>  #include <cxl.h>
>  
> +#include <uapi/fwctl/fwctl.h>
> +
>  #include "core.h"
>  #include "trace.h"
>  
> @@ -573,6 +575,46 @@ int cxl_mailbox_user_commands_supported(struct cxl_mailbox *cxl_mbox)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mailbox_user_commands_supported, CXL);
>  
> +/**
> + * cxl_mailbox_user_commands_info_get() - Retrieve array of command info
> + * @cxl_mbox: cxl mailbox context
> + * @nr_cmds: number of commands to retrieve
> + * @outbuf: Output buffer to store array 'struct fwctl_command_info'
> + * @out_len: size of final output buffer
> + *
> + * Return: 0 for success, or -errno for failure.
> + */
> +int cxl_mailbox_user_commands_info_get(struct cxl_mailbox *cxl_mbox, int nr_cmds,
> +				       void *outbuf, size_t *out_len)
> +{
> +	struct fwctl_command_info *entry;
> +	struct cxl_command_info *info;
> +	struct cxl_mem_command *cmd;
> +
> +	if (nr_cmds > FWCTL_CXL_MAX_COMMANDS)
> +		return -EINVAL;
> +
> +	entry = outbuf;
> +	for (int i = 0; i < nr_cmds; i++) {
> +		cmd = fwctl_cxl_find_command(cxl_mbox, fwctl_command_sets[i]);
> +		if (!cmd)
> +			continue;
> +		info = &cmd->info;
> +		memset(entry, 0, sizeof(*entry));
> +		entry->id = info->id;
> +		entry->opcode = fwctl_command_sets[i];
> +		entry->effects = info->effects;
> +		entry->size_in = info->size_in;
> +		entry->size_out = info->size_out;
> +		entry++;
> +	}

Yeah, I am going to double down and just say that if userspace wants to
know the available features, it just issues GET SUPPORTED FEATURES
directly over FWCTL_CMD_RPC, and the kernel can return a cached and / or
augmented instance of that payload.

Everything this dynamic command could return could be automatically
generated by a script that converts CXL command effects to FWCTL
security scope, no need to ask for that information programmatically.

Otherwise I am missing something subtle about why this infrastructure is
needed?
