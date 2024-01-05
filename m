Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5971E4AE
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KI2hjsKo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704494121; x=1736030121;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zktu33ljdTXi63dgtTw2Utuw+jlr5Ti9SIFeLKRY++w=;
  b=KI2hjsKo8w6Pu5+pe3xYN4dignnYfiATnBZZv2o/hAIMj1TDm4GC6Fw1
   /mWX0DDu38OojMBImQnsTrwQkH4QgtwVUHffNulOkyDHW7GHJGOqO1Ula
   MbEo07xso9YgFbvky3yTXA+WN4w8MpjDaDSAHM/dINXQGYBK6Vcz+ZWvK
   pUigiIBLeIichjysqz6GfJz0kJOxJIyd4xanWH+w2C0iJLlPUymAGKUBr
   7v+qFq9FxZNQNrn4VkDVIaZLRKSLijYTu+KM2EnP7JQl4+rC2nsIStoNQ
   RX4Qys5CnhBEoXNtTSS/4iJo2gGGhG+khZoCz4RNXnTdAfxsv0EJwcFqE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="377750587"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="377750587"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 14:35:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="815071754"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="815071754"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 14:35:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 14:35:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 14:35:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 14:35:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 14:35:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8ZCwWu/vKd9ERsyO1tIqMiWYts2FPd+bu5gtT2vrg0pvGLkHrVNuHQo0Jo4o6d9X2Ove4Jg0L3feGfpl9CUzANb7il/i0gkB/V2NVWwIalFHzHao3SPVpruD+uOtTIJa0zUH0eyelF09jANQVefIWzUj65gpfyabXNYCdqbDn8YAqum3/fVyd6VC0scheKEx34EDsRSEB9L+OHAl0NnYbQqC12N8yx6r8E7T6s4DZrzqLA0LnbjfQBBskmPW4IwBN57dY9d3oWmdtf9R72EAWkamP9nehjBhoY9nbA7DMB1XjlpwkntgxgJKTRFKQwJT+bFACH07T28wilLhivL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wz8TC12XobTVMxzk9wkgkwJlsOoBdrLiFBKFb1Zgx0Q=;
 b=jgQZ+FvCF6s0/MRszAzrT8GGOD3GFZYw6tGneJc67iyJhkIOtcDPAQUcmOxgh7gRQkDhNJPvkdWB0PNBgeYbq+SW5zRYdM+cbcbketScVeFD18BNKYRN0nEC/tpbhaq07/bcR0N21eDnyUE6cTf59OgHNzFq3XmQayj5Q1szyo8n0FdoYZE+3m07GV+ZbNNB0YLrVJtNfLkoYGOZUmAbzfITrzEo9QN952c/xh/i2+LpKKCotFCXdP5d7Few+nHeIc/M2ls8BnG62jk91xEdlrt8bmjqEk6SXdeGO2GVt9bTLuM8baWRHvUKv+aFOzVB+Bwpb4BJ2PO1NKy3oHPASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6528.namprd11.prod.outlook.com (2603:10b6:8:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Fri, 5 Jan
 2024 22:35:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 22:35:17 +0000
Date: Fri, 5 Jan 2024 14:35:14 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, Robert Richter
	<rrichter@amd.com>, Ira Weiny <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH v6 0/5] cxl: find_cxl_root() related cleanups
Message-ID: <65988422aafa8_127da2294dd@dwillia2-xfh.jf.intel.com.notmuch>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 63742c34-7c89-4b25-2afa-08dc0e3e979b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kL4BO1b9nYj1qw572XXxYKscq8T6c/d6dk1aeq70tHdM5sIGePLzn8gJlkDG8He+excJJv6OK4uzEpFTkPz//q1pmxXmBHWxof5TcGEzR8KowYiXhNozhngzTe0xfQ+/eH2DMK2B4ppbvqAs/Cj+SFxI8edAaVwGqzVkT2N+ZbcLerYfOmH06BQvoucfpQk3MPQOJcRcMn+9bdNhmRUqPNj6dhnlZ+dZBOAOceBqQgPS3I7n75SSuodjuHQApLaSoZ/h2F8+I38DbRrxOEelhYSNfwa2O6PASZnsZkI917pGZN+AelEqis2a/Eo089eUnzaJIWyslak4hO7psbef3hpKU/6wXnVeYkvMYoMnlqDlWq2IYnIq1canpjJbybEoQh8y3BYsdd+8Q1zZRd5dA//+SHhky/xajdC9wPAf7QZN8SMbT/HL731Qk0hYBabot9WaCOPnuOaILe4knM0neAkPcm/kjD3ubR3XwjXt6SItxUE5t+DNSbs8Bh2Cw43QWuUTxQBkRoitQMBSNplyCm35efh+ntC3xwX2TWVjPoajHUH4C4R6W2RH5q5sNVF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66476007)(6666004)(9686003)(6486002)(6512007)(6506007)(316002)(54906003)(478600001)(8936002)(8676002)(66946007)(26005)(66556008)(41300700001)(4744005)(5660300002)(2906002)(4326008)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?USpcbvTUNEWcTW5Be3yMSMO8cB/c1PHVzpeQuKONP3kI10r4tEKMBDsXF1Uu?=
 =?us-ascii?Q?6wtx2xIxqhO0KnKhZifLqKDQ66Pozb39kHHeYxV+/jzz/8rwkwqJdU4Yahsw?=
 =?us-ascii?Q?1KFAwResK4evTI7tjeQ/7e45ygWDtpXJ5OSxhFBo2TfM0JSskwaidZlYphGC?=
 =?us-ascii?Q?RdCro7mS/vvq5sBRqMP+WGi1rwpXwMfAbIlGeVozvx6Kvm2600p8xKomIUEv?=
 =?us-ascii?Q?CPsrZX7eeHBugHdu9+pC85AH/zB9Ip8CUENAv/eu5UJzwd57BTGhzxoHmh/4?=
 =?us-ascii?Q?iJd+ei8QmhfPkBihULIhurRlTnQiCZEaD6D9wlZv497+TUcMtU2D+tu2e+Tn?=
 =?us-ascii?Q?/cXSTADV3nnDUeX0sBWUfVewDthia2cWRruUc+FP4ORTGBiBVQzM4Hv0aJK7?=
 =?us-ascii?Q?V6fypbQ1mbmqS/cs4lyVdsDFkhrAZyyMVeZDVrgfzUvN5M/R+60iBPZOn+ka?=
 =?us-ascii?Q?cc0wEb+tU9d3BcyIyU/ny/BJiSV9AY84S2LbGYj0V87M0e4Kd1BjNzUisynX?=
 =?us-ascii?Q?oFlux1V7tUWUYwQ3tois6RB+9v6Opu1lHNeuX+s+Ha8qWdXcrtLul1mo8ySd?=
 =?us-ascii?Q?ZBOnO5/5+0C+x7yhuJC9cx2iyuQqvcUH/+xBz1IF6qCI7hu3rhWwszpdf79F?=
 =?us-ascii?Q?dw7h/vnRb6ZOcgPTbMFKy9rSpiakxjilf47eJT3deRiQIASKBSZxFFqFE0jx?=
 =?us-ascii?Q?TkEVgSE/whw5bvjMnIO9jPWSoW0TbFcIl+h6YQ3WMWiIcDFfYAGN94vWB1KO?=
 =?us-ascii?Q?jA2xHclsj7I1k1goZn0y3lChclbm0C/LAmmRSoCgHFytxB24qLV43CIlnlJx?=
 =?us-ascii?Q?Eh6SaPj6FroI5YkS57j5pWFW0jGmpYmzYr8ps6+C8d64SUCnCIatpmTgXkmf?=
 =?us-ascii?Q?HXDGOqJ0W5YMLkKeNGkC74EZVb59FfL4UgkefFdFg56vVSshA3mZUkYW2Hpe?=
 =?us-ascii?Q?J3qcWVOFI7V/E34XFXesqTntC6oKL8ivLOAn4CoSj6cvwkmLDFvnZDPXnV1k?=
 =?us-ascii?Q?M6h1XtFFperReQhFK+zThEymTRjbgv/YOoyN3f+SKhJ1QOgwBdg6zmnibhT3?=
 =?us-ascii?Q?3WCfhGuQ0zp5kwpmiLBYlX5D3yyFFzLTAIENRSLus/DX3CKaAmu4WnhaRo8O?=
 =?us-ascii?Q?JgBiMEvyecu3p1XJ2s6d3rPzSdSxovyjkltFWsu/niO88oNdO4zsaxa1yKx/?=
 =?us-ascii?Q?F9YSELOT91JybPjb97cDFvi+WdkqGWTj2V1vI+Gt8CSgAO9fnv3DS2KQaK0q?=
 =?us-ascii?Q?byLlzCq3WOCGDygpx2fM6imfDZApWjDJe18J8kdvgcnx2gmX7cxLwehG+bIU?=
 =?us-ascii?Q?h3OdOczOPOpMDUavNFICdPKIW/3bplFEKmD1kVdD6wK+tGZDdaVDhSpvsmXU?=
 =?us-ascii?Q?7mVqMiZO5y3/adL/NDYtbotERBPK0PU8VTRhybcUcyxf8O79wL6cgBGcAMM4?=
 =?us-ascii?Q?488l+LFQQWxQHSUH9FZ7/0Sc2FJShZOyEuXnGWHCI5t4tCwovwol5OCG3yZL?=
 =?us-ascii?Q?KGS6x6Wv7IFYmJLu2C8EfzOw4XgrTDk3OgDQID4nzGLeK7StDwiu3Y/V1USM?=
 =?us-ascii?Q?9Bp7va8qT0Jp8d/1xL0+SJSBnrWfqtb6LoWu/mQqHY0y7YoxpExIGyywRUsZ?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63742c34-7c89-4b25-2afa-08dc0e3e979b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 22:35:17.6488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StD4BNrmSrET0MqVdTdSinbKne70VR1n/yAU1+/uemG9rZMOqk96nDXgpC/ggAhvzMiQ7winZq9MlLpm9/VsxkJHAN1uEoE3SE2VDLlAs5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6528
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> v6:
> - Fix breakage in previous series for device_find_child() (Dan)
> - Move DEFINE_FREE() for put_cxl_root() to first patch (Dan)
> - Don't touch put_device() until final cleanup. (Dan)
> - Add review tag from Ira.
> 
> This series provides a number of small cleanups to make fix_cxl_root()
> and related code more readable and safer.

Looks good, Dave! Thanks for the spins.
