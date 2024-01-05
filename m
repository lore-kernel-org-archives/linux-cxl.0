Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AADF1FDA
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 04:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjIK0laA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704429621; x=1735965621;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K6+Im6QnrY44JPYgkBQMQg3QVbXFajRGewY6Y2Eo/YU=;
  b=TjIK0laAROaDf4TH/KAYERDTa/TG9xS8FxRRkVc309AadOEGYHU0f9Qg
   y3wWbqQLEkMtBFgJwUCH2BQFJWP5Yx4AG7H9oymX+JZjtJFFnpXrbiueC
   +pvh3lBNXeLS4KKFnHSJL89RO2/X3pNK+eR+2Ka50/tYs9FTpfM35gpAy
   w3+3hPyx+JlEQX0rGajlZKAuVgZmvucoln9NAlcnGIOIhj4NMzhY6o/KV
   em5XjVPY7pA0YUOtebTJxiKjdHEPbXGPlgDydjk1MwppF/8YwR0y0cmfA
   VpZBmc7iiuxYIN3OHFUrK//GsZdc5rDkuv9Dr0n9DB330tYyHEV91tghj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="377583730"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="377583730"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 20:40:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="809443101"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="809443101"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 20:40:19 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 20:40:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 20:40:18 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 20:40:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkCGpR43V+s0vpuYibu8wXwNKuTWUiFeCCywuO1Pqj6TUefVkgtEKPDG4tkUSq0t5+RWRZsHVGztTN475yQaoWKztvnzwOd95GAkzaEa5U38K/CbDxX3MymIE5T2vmY0w1TOaWYwPLV4v5rgxv0edKA/1d0Vw1oSUio4Ib7UhUMYsDJHVDoPv5AWaInDm2bmeyY73My/NRfYAqFvWEIDKMkK3X7CjQCZ3dLkkXTbS9Z6ceuzp0hfm/3aBgcUnvMOfdC8ZT9WXXIQrbUIFTeVHofaJ7vW8lRJ5BKYjRy2csxpi0cBvscnWlgIAix38asaT2hKApAYYfhRzRCMiU0mTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/+VXbIaCAy7btYp4A5gV9BVTA45y0OmjVsPhL+9bno=;
 b=mTeyHLmlWJqbijUt/fT7ei/sbKlunJwt0V5jkKOEqyJznWcXtN/IKmsb4bsrxWSswLrkynmhECjN2H/eb0HWAq1p4eITUnzXTpWQ3xaHOXbhYmEoMEqFgI761JdgIpxwz//g4r63MS0/ckHIFgGPzn9qPguGTZEZ4cFRd7KFQYi2T1hw8hHH5hwjKRY95YigNPOLNklu13mwunmUYg65Rhp8tGgzMziVIcpF7FrcGn63+bh3i8OQQuEpZCClzk94DXVKXXrUlfkB5Mi/wFpnbl9k5ZQvnp1KMviJ+jTDXBQmIfw/l8BF99qFnbAxJLqkXJqskGNdh1xB+6hO2lCQnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4530.namprd11.prod.outlook.com (2603:10b6:5:2a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 04:40:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 04:40:16 +0000
Date: Thu, 4 Jan 2024 20:40:14 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <rrichter@amd.com>
Subject: RE: [PATCH v4 4/6] cxl: Fix missing dereference of 'struct device'
 in cxl_port_perf_data_calculate()
Message-ID: <6597882e62423_11cc4c294d3@dwillia2-xfh.jf.intel.com.notmuch>
References: <170441738812.3632067.2103652995360101907.stgit@djiang5-mobl3>
 <170441750612.3632067.3372196682717758963.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170441750612.3632067.3372196682717758963.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:303:6a::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: f257b2f5-54f7-49e0-3722-08dc0da86a23
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4F3O5OAFpAjw9sXxSSMCNgJhTCKgpJBhz92V+afNN/c6h6VmB0kQAsWtVXNzXhkGNOWtN3C07WrpcUAK0LcYV47g1v3uEcv1I5LL64i/yYGiBNmWDcptV2Ab3krHcIF8c7LUCImJyLaCJOuVTyXaUvQNdr7MnSCeVF0+6OvMko9xvEuCghHYR0tokEwybbfea2NFgRbmofDefieCW9s/AvJq8rYcLBvAIzCRR82fCpkkSvhhnZX0L2sZsBJZZmq/OIDJ8VvL54ObcWoIIbk8/RLRSRnF+xXnev2+7TZ08N90QXY7iyedOPcnBYb1j6XxHRhpPTg4cXRUbLSfEqIhsJsM0Xxph5UndbgaI0R4NCubvLYpUNr52aDHYmzXfnUvKOY7Uxd2T+3BZ3CHsbTZU5pCzOSpLssYSwhQjtF0FY3cSHusJh4NPmereF4rBLDPos0GLh5Gu1TLgfaEtagpXQwtKDH7PjF7qx67WjTbhZDwkfHe+/GWxnIxUs1TLxQzUsE0DYz6i6r2fB1IdbBaSIOchR8oOJxWV5EgUKgndQkD+e9BDLupmQ4mkPUZxh0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(9686003)(66946007)(6512007)(6486002)(6506007)(66476007)(66556008)(86362001)(82960400001)(38100700002)(2906002)(83380400001)(26005)(316002)(5660300002)(478600001)(4326008)(41300700001)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?51immJ1Ka98wXa+thwwy966FruBpD/z1MASx0WY1D3jtSYR/zcwkp9ABfvG9?=
 =?us-ascii?Q?TaJN5tCAGCskBfnDhZmLyw0wppwraBW08Xb/UGFkfR8gr3yGOt4iMH1EueO1?=
 =?us-ascii?Q?eZMvlY1lw1oPtXWlDkrk8/SPkTuSxKyZkHH6AQ2pGyWc2i2j8/bPEVJLz5wi?=
 =?us-ascii?Q?sI5Il3BI003aZXg17H63LoiWgnor3DZ8lWgZuGj6KsrH2PE4bjVytKuez1xK?=
 =?us-ascii?Q?uB2gbSiZaCB+0cURQYHn/HHFSKP+Y79VSYpxInigwEi6EHKzwBq+jw10aNUa?=
 =?us-ascii?Q?+gCRGps+w7t9eydMDhV+Zs7GtyUhturVB8RfcC/sDcLc3unERda3/oYtPMjV?=
 =?us-ascii?Q?L2JKU5FZ9CNJS2RvCtsI9HYZ5HP4fwa2lDz1HlcGCMwNboPwfKz10Az5f27v?=
 =?us-ascii?Q?DRGX3Ev5iC0nt6xN309SALBvlsCP2nbMKhEcAZJJuprUmKKO8vVAGzlEamYE?=
 =?us-ascii?Q?XCOo0cV9+MDbJOcf4cwuF9usaTB5ALMKcqNUySsvaIca6EaIrl3T+V7Ltq/2?=
 =?us-ascii?Q?JL5GIpXXP1oEsz85+iJu5cceWnZQurJnDJ/fhOywn712mxWG4lHd+fMy5xuF?=
 =?us-ascii?Q?pgvp9zB0Ih/V20FTQWJW++NBlzPswbtGhB2T+6eYJbdN6xykabr38pS/PJNI?=
 =?us-ascii?Q?xdZv54O8oWEMxvE5MuPISdvB6gHZs1cf+iYr5FotnBAodbMafq/rMoC6g/aS?=
 =?us-ascii?Q?zCJL7GTz+DNAa6ZFeom3kaf0kwI53+LYtKeknW1Z5/crTS4DEc7R/6x/cE2N?=
 =?us-ascii?Q?9btauaTPxX+RxfSPDKs2aimZCz33Ndh/SeDTLJsa8+q1oqZ8TY1vRmkUSsQq?=
 =?us-ascii?Q?0ExqvQEM2vv47ggco8bqFe63R5WPrSoEspKZtzEVR6QdxYOHUwDnO6zRJXO6?=
 =?us-ascii?Q?RWLwBGvEMXDWrBk5kUmR5gWtWooe672eW6xaBFDyFBp8xyANaXU4rG6HU2X2?=
 =?us-ascii?Q?SQyGB5LyvfYJvd933flwc8SosCNqkOhkr9L3owMJCPprpt185zOemUGJ6v92?=
 =?us-ascii?Q?IA79SqcNw/c7JVgra6CxM9QD/0MH5gWsedy4MIewnC3rw0VlF7ImN7W8ZhNH?=
 =?us-ascii?Q?ph9pzv6Z39EyawRqEcyw5F2d8zOQSWCDLtNmGCeU7eA7HHxMzyzZqmBMavJq?=
 =?us-ascii?Q?pbAyLiUWNgjz9y206HY+uzto7mOVvDyV3imJG0hKi6Oc12QGtY+XxTfjOzWx?=
 =?us-ascii?Q?g4/yR9xwZN6HuYfxS18WaOTFWGWT7KvQ06gEnYfsqbp0qpde3ewGZEjCcGNW?=
 =?us-ascii?Q?WIjd69EbLiS7TzxyXHPyGM/jVdDFePf3QSt8up3jofNfBkwje5uR7vK3K88n?=
 =?us-ascii?Q?welhMW5alsX+IMf4l6H5/sAuA8fgsytofXagCK1dkVKlkoMoPOq2gwwSAl9t?=
 =?us-ascii?Q?80IAhRvkC6qKRP6RnlaMAL1Xa6ysDO/PRhtVOQJqjZRSF4+8r/1TQoDpz3++?=
 =?us-ascii?Q?QGBb6gpAkOkTnSjy0RbXiwvcy+uoqJPjulZNNAeeXmHmWtfhP2A7vzkPg3T5?=
 =?us-ascii?Q?Bq8GkpUPgRKMxhQE84LwxSDS5WWMzEwd2abHnuq65C91JDgwYeTSGR0opLzu?=
 =?us-ascii?Q?EHBWnyvxNz0rz3Ll6POFNS4fMY0J2dUs71PirVw4CrvQgnXOxVzNS2mU5FGz?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f257b2f5-54f7-49e0-3722-08dc0da86a23
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 04:40:16.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rp4LBnzpD//2l+vjFOM0L2tHyWkIloHpUU9zpVhcT6xg+iuVfWGNZcxHQeo9ACdgOW+TDpOulRTs0B5hqlOYwT6BWwZoHk1NH0RHGyUDd38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4530
X-OriginatorOrg: intel.com

Re: the title:

    cxl: Fix missing dereference of 'struct device' in cxl_port_perf_data_calculate()

How about:

    cxl: Fix device reference leak in cxl_port_perf_data_calculate()

...to me "dereference" is a pointer operation.

Other than that, looks good.

Dave Jiang wrote:
> cxl_port_perf_data_calculate() calls find_cxl_root() and does not
> dereference the 'struct device' in the cxl_root->port. find_cxl_root()
> calls get_device() and takes a reference on the port 'struct device'
> member. Use the __free() macro to ensure the dereference happens.
> 
> Fixes: 7a4f148dd8d5 ("cxl: Compute the entire CXL path latency and bandwidth data")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/cdat.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 0df5379cf02f..c6208aab452f 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -162,7 +162,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  					struct xarray *dsmas_xa)
>  {
>  	struct access_coordinate c;
> -	struct cxl_root *cxl_root;
>  	struct dsmas_entry *dent;
>  	int valid_entries = 0;
>  	unsigned long index;
> @@ -174,7 +173,11 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  		return rc;
>  	}
>  
> -	cxl_root = find_cxl_root(port);
> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> +
> +	if (!cxl_root)
> +		return -ENODEV;
> +
>  	if (!cxl_root->ops || !cxl_root->ops->qos_class)
>  		return -EOPNOTSUPP;
>  
> 
> 


