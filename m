Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50738372
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzG5ytyl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704413994; x=1735949994;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jQNZniRHj+PKazsftsFLn6gXiGfA4/nprn0ypGsFddo=;
  b=MzG5ytylAUtQ7gHDbyzxbo8zqGjzvsd/OJumHGqTQyZsvpBf0+hBDXcj
   wJos6gdCYJPs7be3qG52g/xRGlPyOziaAIM2Kejzr7m98SLiOkBrj0XYt
   mdXvpj+/HVQ1cTakRaPTYOYjHYfhzAHioZvfd+ubqUpPULNFphvkF0XNm
   JU5bYFUiPJ0tqJmvogomHI1OPTTCLZZchHmRjaMx+mvRYY+xJ+SoAKfHR
   58c8y3XAyZVuN/C4bIyOj7e0e7o8cAn9rhkJphLIw/U4kOhmhShGot75j
   5hkgQAXfjG56DZOPYXgm9/6q4buuB7YcB1f8Ta+K5qa0kFK3dT9X4pW1x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="463793341"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="463793341"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 16:19:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="924077213"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="924077213"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 16:19:51 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 16:19:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 16:19:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 16:19:50 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 16:19:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTfSjei3OCRSxX7Yy7lLdH+j/9LLGK0q6VkJM5TNLel2KTr+rjB/hEPyb6AVsctqzcrPMHUenBKmVJETOMJSuPBAHR56krpAwLIJk/WAVo6Mdu+fOlJaH5PmJzvUtx5ZNcUxUehIl7lW4rnrX29ARUZxjHLg9zl5aaAL6oHKEkVp+SscODJFpt5+Zf+Y5TRxh5waIFxlIZSdU+BgCylVAVN4k7qczcrLXddpwUmfDucqqa67VQhYlgnepn1TvI1IOP53X1JnyFOPf0VqCMLppOJ79+RpHIlb3s9Wc9ZHL9JtAW36wddSzll/6+lfYGRfQyDE7P90J1J/XwNGLPMU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iQ+vrOqdqOoijZ1U/DOmj3C7QN+PiMEhAMHRDRkyq4=;
 b=n64MGvxIWBl0fNN/h+rPWFlbWN0CTYBLeOy/lSegWWvYoeq26GWQTkRGjxMV1nPW2tOW+a4zJeshVH2Y0ylDLwQOSAG+slzkjdSoq8/e9NGSkIyK+lv8Y4Cn4EgDqt7UGbFQRKeN0zO28ASi4BF+4HmpM5NVdYHcEbiXYUOTPHs97nQkMbtgC3DqI9a5y4kSHBIpbHeXHABhWP29m1B9rKuCmig+X6pSOPBj5gta7RJC1ss/JbxNI663ZwP7w/zLBzHHttl15mQUsN8f+XT5Pqckg/3fisjLMG+aiL98gM4cZsyh5M7vtB6HX8dF1KxsIFE75EcAR2jw6ZoUuwQ+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8115.namprd11.prod.outlook.com (2603:10b6:8:12a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 00:19:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 00:19:48 +0000
Date: Thu, 4 Jan 2024 16:19:45 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH v3 2/3] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
Message-ID: <65974b21859a8_8dc68294dc@dwillia2-xfh.jf.intel.com.notmuch>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
 <170441210897.3574076.3084661576808646327.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170441210897.3574076.3084661576808646327.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW3PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:303:2a::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b566c2-1dee-4f7a-1784-08dc0d8406ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X05SBJnHtvv58oBtAlgWfqkQUzT1Er14IdvgtqJkyq4Eb2HdVWopKFS44EvvId9D3dZ6EEiEp37cjybaWGd5M2tEt8Rx5RW9xTr/xEhywpNusVQO8lDOaLoboJoxy/fS9mSOPu2430z3QhEa4iknUrc0VJw5DGVDpuMF8+55O25VpaltFev07ZEpWeV/Yp6clAny+twlZDS7vLDifAgli2VcUDRkRtHeAN5YTVphZrmbR9nUGaExca6rW/rHeT0sJJFeEV9hiFw2ySLYE2Iy0oHVNy07Zng+errhLUHLXHacmot3hRzrwymL19n13E/ECALE8Jy4jFgu7dLiz88kG4NW7iMVYwWYusefugrwYOs7qUYZ/gv9LxIbwaPokuT3n7+RJbNskSU5BcyKmr2Rt87YfoPljANGUzkGzP2IYJE4kS0r1RLE+rsUyhj0ddXQ0n6sKk5sNp+L6nD6DZhue4YhJy4p0N1Y8tzFyAKbkDF5AIzKKsoy9d7ZLDgrUTLaeVITPOPeD1geQ68YuKkaFWtcB/9b2Jdpp8H1ywpMfRMk8gLFga9r9jeZgatZlruI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(4326008)(8676002)(8936002)(82960400001)(2906002)(41300700001)(86362001)(38100700002)(5660300002)(6486002)(478600001)(26005)(83380400001)(9686003)(6512007)(6506007)(6666004)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bIgSnPdZkCBeQYNGOfaPp9lBrSK7OdbNbPQtoKt3q2g4iffzmfHRYSEiNliA?=
 =?us-ascii?Q?Hz9Ei/IODM3isE8qtVvruoUJjA5KEi8rZpwT8IeJkpdpHiAR+Tot+uIKVoj1?=
 =?us-ascii?Q?Ps8SnkKibpyt68q1PcBaldG51lor4IrXqeywvfT51lKujRUPHHJ/ra7BczOL?=
 =?us-ascii?Q?84x1mxqPXOc7Re7JtWAjg/d/SlTZQSQdrBC8aP8PUh7cjeea84SX0y6QnLt7?=
 =?us-ascii?Q?LMSIJfZiukJKtm/kX8njhPjyXIWAzN0H+/PC/7W2oVgJa2a61xKgK1uUF7X9?=
 =?us-ascii?Q?Q53/VrYFfeA/cw4ANUR5L1CjzArANsHEYbb13x6No3T4mOIzsn4SNmiPF4uH?=
 =?us-ascii?Q?HYBsCAr8jEU0NzBVB1XfDExmCMgeriMK9+ipAqWMiQEiR4DrnEo2ZE+JEhKV?=
 =?us-ascii?Q?ioMB7f3FSpAyKOO0rxjjklzrr+x5B0pzbIP4UOMGQPy+g9tAIvSLrRmbS74K?=
 =?us-ascii?Q?lPWVH5bgmu7obwE4quzHoBFEAazUJSOvJkLwz+RsFfQFbR1280gQqFJt4OYi?=
 =?us-ascii?Q?K/5M2bzk1ECGIgdkl7atQ34xrAg/jbfwYChOz3/oJbnqRMUDGwqM50n5X2u5?=
 =?us-ascii?Q?sKmzo/MQgsUtfRV88aJZPhz7lH3vf6KMZIz3iKM6Hvv36/wbwPEj3y4bgMa4?=
 =?us-ascii?Q?J7it9Lco6vu6rK//wuIZeq4jXdqhK3fiJd/fGC1gqepfgn+gsS9+aoePXh0P?=
 =?us-ascii?Q?quNhQoQaVkS6ncYzpHXWlh67K8McZFGEexfgNPMhlDlhfAxC2xqhe2/idf5c?=
 =?us-ascii?Q?5SyoScJD/YW8o+ebQwJONLzgBuV/0ikm4zRdJ8NjTrnCPUiS+iqyNUSE/Llu?=
 =?us-ascii?Q?TLcYWbtf/MreqrISuSAPigpsqEaH5kdird9eqQqHfnRSa9BsYhZS7I3+L/vy?=
 =?us-ascii?Q?MTA1t2li6aflddEiKBK/SC+NkUgyxVn5i0H1Xr3QAPJYU0rc/iw9GENgCEUa?=
 =?us-ascii?Q?+1XBqGCt0Yt1CsoCVbnUSd7PbDfbTOe9VFGArQPfOVz7j6TcDngWkRJJOPzV?=
 =?us-ascii?Q?jdGoqWwANW1lC6ZVBo1+6gb7z/05pwR98xLRt0mkT/kZQTP+sQai/dcydZTK?=
 =?us-ascii?Q?7w6LnSrhJe/8I2/LUUOsm4L0XGqsGU38UR716p+BX1q63+6Q5Qn4zlGpE1Fj?=
 =?us-ascii?Q?lguZOvX0aXnz1cK0GU1ZRlelRdT3VdNIloSvZPZi0Av4rzebihzjlJMHadTG?=
 =?us-ascii?Q?DMyG2QL3BXaVpzkSqLfRmDbk1OA7Xbas0Anxfq8RltDqe79cZeYZjl9qWrp9?=
 =?us-ascii?Q?jWUOoqE8zg/yaHeEjM58WUsw/C6/HDCJ1KXUPQA8qS0Rffb5U/9vumQDFVtL?=
 =?us-ascii?Q?wCFpptmlek9Rfatqdl+e3PTe75G0So8spPEhyDThOzdNjiiar5dhVncxinE/?=
 =?us-ascii?Q?UR7o39VFHSJLDEe8z7CGC726bUBqNeIcokmHxQc8ZkA9ZCmYZQXGZ4DDpwW4?=
 =?us-ascii?Q?ywDZKBnRahWBfxho4cX+Z/l/SwcYp6FVyzrU9768xESm8FGjNXu94u8P3rAM?=
 =?us-ascii?Q?dpH49gJanZ87Y2/I5akpM/UFJgZpmrN8ea0jv63Nh9cX0ko3VVVVmplj/NJZ?=
 =?us-ascii?Q?F4PmQDB1U0EqPPMfjljb3XD1To6kDOmIHXLP1xwYWCDSJQV3tvILTcECMK4U?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b566c2-1dee-4f7a-1784-08dc0d8406ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 00:19:48.1942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/bKRTuCzwEWpFIZ8j4Hjj0wze54NZEI0EAANe0AfV4/cwsI2QdWUaJwpubjDYXFVybJrzMkYlFr9leJt0ehoG+e2jg4iTUXbkh+VvIdkag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8115
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
> region. The bandwidth is the aggregated bandwidth of all devices that
> contribute to the CXL region. The latency is the worst latency of the
> device amongst all the devices that contribute to the CXL region.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Make attribs not visible if no data (Jonathan)
> - Check against coord.attrib (Jonathan)
> - Fix documentation verbiage (Jonathan)
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   60 +++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c               |   40 +++++++++++++++++++++
>  2 files changed, 100 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index fff2581b8033..86d3dbe12129 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -552,3 +552,63 @@ Description:
>  		attribute is only visible for devices supporting the
>  		capability. The retrieved errors are logged as kernel
>  		events when cxl_poison event tracing is enabled.
> +
> +
> +What:		/sys/bus/cxl/devices/regionZ/read_bandwidth
> +Date:		Jan, 2024
> +KernelVersion:	v6.9
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The aggregated read bandwidth of the region. The number is
> +		the accumulated read bandwidth of all CXL memory devices that
> +		contributes to the region in MB/s. Should be equivalent to

Perhaps:

s|Should be equivalent|It the identical data that would appear in
/sys/devices/system/node/nodeX/access0/initiators/read_bandwidth if /
when this region is onlined as memory nodeX|.

Note that I did a s/accessY/access0/ since this data is relative to a
single Generic Port. The performance from other intiators that go
through an alternate port is not represented, right?

> +		attributes in
> +		/sys/devices/system/node/nodeX/accessY/initiators/read_bandwidth.
> +		See Documentation/ABI/stable/sysfs-devices-node. The generic
> +		target bandwidth that is part of the whole path calculation is
> +		the best performance latency provided by the HMAT SSLBIS table.

Shouldn't this be s/HMAT SSBLIS/CDAT DSBLIS/ throughout?

...but maybe just delete it because this number is pretty far removed
from the CDAT data. The data has been munged by considering the
intervening topology, and is aggregated across all the endpoints.
