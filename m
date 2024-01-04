Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ECE2C1B3
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdXUBCuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704398864; x=1735934864;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zcPv3GS3og6Ugb4rFr3TaT8GxGruxKkFUYSMH14p5a0=;
  b=EdXUBCuPaFWrIirLLsoNMgEbo+NAO6txzmbs5bryy2NiI8dcsMZDB0Lq
   nOhTEWbCU1tM+4NbO+IsQBddjcftW8NgDzkp5q+EwVURFH6AnTp7LYOwE
   8VfN2lOLxTO2e4BjsIZDygGzM01q8VDSPoFqsQyZ+pYTOPOBDKB0raU1c
   jSFEPntr8RwoW4BHS1FMYETfLome09UrPtJXqySEV/s3aT8vTPCYetwwA
   +ewxMlbrywmUay5uWeBEc8aQn/CtCdzDUeNbBAKqzCQVJlV1XuHeZXfFn
   oMcBC846NGIKTuPLsWatg0r5JbXD50bW1YXxga5WHMZM5hrbpOaUeyNkU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="387799264"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="387799264"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 12:07:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="953727380"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="953727380"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 12:07:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 12:07:43 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 12:07:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 12:07:42 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 12:07:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wsylq4j9LzwsG8zwcfxBle8nE0GU35RnrX/UpO2X11JdExKejG0RwlnkGtlNJ8tYywEmqIl9tBvnt1wbzMj0liiRDU2z8dk7XtJtMcmIavoNEMSbVEHerYTMk83zrCJoMwuVqcP+6mqLNNylD7zMoXhwDyURO2NXmd9Lbfs5HhIuyGNIU2PfkK1YEHx5wLcTKf1OgqLmWUOAdywXW9iJSQ/2SzEdZgxOMbXoJjk09XMu5pUGzHDlvXmw+X7JGhtfw36vbzvfjUTrA685wuK588irYu2D/ui+18OW8QHqgyyrIkcSX0d8bAMt78Z5sEUwBlWpxnmafmeZ4qyDcxj7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCQrDLiGnBNBt8dqUlJct+kstHi8txBXiIIMB4etkg0=;
 b=S/IZ1DsFCvJkysbimDjN+uUoSMGPzMA34zrDliqm5tt3eoPdQ+4cPGFGJ4WdyQsLmNoPct9TwkrC4g0TXiO8xj67VMPvTUoCiNzVVNKO92N8l5gAWtxJ7DPzruWzt0JeZx8eRZJjoGbHxDV9qLmIq5UYcYZmLuA7wdP7lvACzRVsBdlFJFgYYuUsmw1WmZ8RCdgwUkbLqeLfK5BQT7qKmcSs9PbpB2Iy13yp0Bp9r4C7h7HiG3OkGaql3zJN2/mMbunFSQPMvZe2++R7Ve9TLwXgId6P6MLbcX56nlSUsZBU3rkIUSJl65uk2ndtKdqZWVjVE32MB9ns91eCJfVT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB5989.namprd11.prod.outlook.com (2603:10b6:8:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 20:07:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 20:07:31 +0000
Date: Thu, 4 Jan 2024 12:07:29 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Robert Richter <rrichter@amd.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>
Subject: RE: [PATCH v2 3/3] cxl: Introduce put_cxl_root() helper function to
 have symmetry of find_cxl_root()
Message-ID: <65971000f3249_8dc68294a8@dwillia2-xfh.jf.intel.com.notmuch>
References: <170439742132.3519628.18244037289884549403.stgit@djiang5-mobl3>
 <170439743417.3519628.11381251582844385622.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170439743417.3519628.11381251582844385622.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR04CA0189.namprd04.prod.outlook.com
 (2603:10b6:303:86::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 6895bd85-4968-48ed-0e3f-08dc0d60c8b5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UU5qC8TrQey9OTke2Fs76IFmJTSTky8Yb3nsjoJ4sGlXIVLfXobJ+0os4R4IpVSbB5p/U3PTNIwEjNqt7KutrD94MTp20RwacJWhn8K3bn/BdVhDDrLU3ygVwVZaZUoIB8vTr5E7BY8asRUdw/zURnn3fqgX0JweJUN64Qcw6nyDJ2p4/zzmawTVOYiWXM+jVSb2n0w7yxICrB343p6dabjqurwm/Ji9caHFwGjE5/wn/BGghMkF3u5XIT81m6+i1xROmgtclwzY0ln+T48hy2tYBT6ZMsBeSICTDOXF2Eowc5D7BdePkBLhWLPgqpE3YgKFdYnm1nKptukxoxj/Ty+VGujJ3EAHjWAi1D1dUFeVhHnEhbS86CnaEYBNqIcdb4jaKUZZjMGjamgOibjb1vABGd1TxrtdTpoQtVIl0/FXkYRFUzyZw05FFJwyOF62wJP+OJwQirS4Q6VNv4aKJsMZxicko09GDqOfnVl7khybcDzG+7vvhWeKaHcK9eDqavWVv/X/Os2u3eUTuuPlkn0E+QRxhZ2K6ofsbupIwF2HzV0322ApprwoZKPPYIh5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(26005)(83380400001)(38100700002)(82960400001)(8936002)(8676002)(316002)(478600001)(5660300002)(4326008)(9686003)(6512007)(66556008)(41300700001)(66946007)(66476007)(6506007)(6486002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?86Ooq85/R3P3FSSFfHeK1UulRSJg8PJr/EtI0Vs3wAM7WQH2AUAeJmj5oBvS?=
 =?us-ascii?Q?ug+lm7A5kyHT5uBrWlIWpcxd5fNWtKbtvWcVFNWpTu1GhfqFkio/YwEC0WBY?=
 =?us-ascii?Q?8NJ2DJuHx1CwY/SHZD8Jo6OZDL72J6z9a0RS9xHuVmtPpVxOmDDMKXPluPvc?=
 =?us-ascii?Q?vIrli6IPtVt5AWOaGCUHHBna7KUzwIyuKsxTb7H0dG2My/3MsNhTLvFwVGzl?=
 =?us-ascii?Q?6hRxAEBWFuIBJETRVSj5cWFta8QiWEERgChganvaGeDF3UEE/CS8XLJob8eM?=
 =?us-ascii?Q?dhiMELqvBK4Y76sPkSgLhbPseHkAfG4ihdBwPKOFpTSFEm21dfpZ7REcatmU?=
 =?us-ascii?Q?uYU2XO1grK/8nrE/V9npKnNEVaWoid+phzTonrY1NP2mlMViijnN2qC+zkFQ?=
 =?us-ascii?Q?JTEZged7jkmsHXGeAKJQV8ghQV0MMvt3tStKJL00XW84cEo9fuF2qN98LYQT?=
 =?us-ascii?Q?6a137aOZuLjwVWQHrITOI+SjgjhhvAil0gchutQXcOjmg7kbQut1b1RVsDQe?=
 =?us-ascii?Q?8oEhlCEUEah3fUCthGtpo0TkDXmJFmI7E/m7UqabWBsA9cdYAi6VzzM+QACz?=
 =?us-ascii?Q?B5J3gIMHhTbqcr3COyUOsfNV5wZUVwtOoW0hDRo+ZgYbjgMjcIuY9sYsSZOA?=
 =?us-ascii?Q?tNdsGULJgTJHRcaqkViB8/SZXJl5tZ3XPK6zXalPB7aJsUncC+JaFQUZDwNB?=
 =?us-ascii?Q?7qWvx/bOpY+K1+ZTVGACppsCq1CVS50UZXoe+loUComTzKQBPppYtqTubibB?=
 =?us-ascii?Q?wD2EZkd23nppR6B/ajPrxqQM8oOaq5k1V0ykTGCcLyQ0w1SspnaRxvd7i1Bf?=
 =?us-ascii?Q?7/Ihf8wsqsZoF5Usyvzs8HWM5cfK0tOfm24eZY6slfengnp2iDlhAk8u4uxk?=
 =?us-ascii?Q?/Kbmbkm5PMH3DOusUxCaBIV0HgwdWmrYlRia3GIzXHPD/W2Sy1jROmWIxRrc?=
 =?us-ascii?Q?251/xqADERwZ0TGF0CU11NATNvPoiwDG1sImabtTng60apV0T3ybHt1o1uwz?=
 =?us-ascii?Q?xy8MTpqLg2qgPo101rr5YEAyQuBB34AhMa536dQTbWK9M25LSUYtYQY4XYLi?=
 =?us-ascii?Q?W4Pl2KYqPbDczbPLg1tYeLdiAAYSFDwKn7UptCuoyyph37WFO1P8mxba2m/9?=
 =?us-ascii?Q?Yeq1VYtOKXmutqkMbsOBddufxAgbUTewjna0hWAXBlHUPb9tZ+lcyMHUwN1w?=
 =?us-ascii?Q?krW5EwU/A58ldaDKCmn6/adOWqEbkgyU1Lm4ktcxiOwkvamkfwwcuJ4VA+fP?=
 =?us-ascii?Q?19y2htIqvYwBIeMVvuwUJPGoZTenB56AW/r/oWvpEqVslsF9EG/vwom+kbWd?=
 =?us-ascii?Q?XH4bIi+ifG1a5aUHf1U9eA0gMqOmwBdVBI/vnx4u3wO2zC4jM+NEVzbvRTFX?=
 =?us-ascii?Q?/LuHUyh197hjwaeoYxRgSqvfmQJZKwQpa5/doJwDaJK3L8MqWvQpCKd2c6yp?=
 =?us-ascii?Q?6Qr6RxVkBhgbmnTZQkkQBR7FGLgpa1KJiYGzUVSvqM6MNSm6HlT+QeLRfv8W?=
 =?us-ascii?Q?b0KnEJ4H/Y+BKO4MirLkYVRlfhooxsDP9D3Ra27cSx5NXjIFkBOpGBITFZVj?=
 =?us-ascii?Q?vDM/jFtQSDXeHRhaPU9CPs6FxH6iV6Syi2Z05ffgnEIx0Qmk9FmpXM9GLifE?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6895bd85-4968-48ed-0e3f-08dc0d60c8b5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 20:07:31.6638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0b1ikUQ7Hl2ukNOIgF2p90YdpDhyIHjuckjO4g0/cCr1ptxoCyvTm5sRs+HizmNUAvYSxMChxn0geabRPXiOdAio4mx8Q3oQBuV4lyN0bQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5989
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add a helper function put_cxl_root() to maintain symmetry for
> find_cxl_root() function instead of relying on open coding of the
> put_device() in order to dereference the 'struct device' that happens via
> get_device() in find_cxl_root(). Add cleanups for all code paths that
> calls put_device() after find_cxl_root().
> 
> In the process also clean up cdat code that uses __free() on the root_port.
> The current __free() call for root_port in cxl_qos_class_verify() and
> cxl_port_perf_data_calculate() depends on 'struct device' to be the first
> member of 'struct cxl_port' and calls put_device() directly with the
> root_port pointer passed in. Use the put_cxl_root() call instead to make
> the code more precise.
> 
> Suggested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v2:
> - Make put_cxl_root() an exported function to be symmetric to
>   find_cxl_root(). (Robert)
> ---
>  drivers/cxl/core/cdat.c |    6 ++++--
>  drivers/cxl/core/pmem.c |    2 +-
>  drivers/cxl/core/port.c |    9 +++++++++
>  drivers/cxl/cxl.h       |    1 +
>  drivers/cxl/port.c      |    2 +-
>  5 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 701ed53ce337..18399baa45b8 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -158,11 +158,13 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
>  	return cdat_table_parse_output(rc);
>  }
>  
> +DEFINE_FREE(put_root_port, struct cxl_port *, put_cxl_root(_T))

Lets keep the free routine name and the __free() type the same name, so
it would be put_cxl_root() throughout.

Overall, this exercise also highlights that the commit that added
to_cxl_root():

790815902ec6 cxl: Add support for _DSM Function for retrieving QTG ID

...really should have been broken out first to rework find_cxl_root() to
return a 'struct cxl_root *'. We can clean that up now on the backend.
Callers of find_cxl_root() that need the port should be doing something
like:

	root_port = &cxl_root->port;

> +
>  static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  					struct xarray *dsmas_xa)
>  {
>  	struct access_coordinate c;
> -	struct cxl_port *root_port __free(put_device) = NULL;
> +	struct cxl_port *root_port __free(put_root_port) = NULL;

Where possible assign to find_cxl_root() immediately, or move the
declaration down to where find_cxl_root() is called.

>  	struct cxl_root *cxl_root;
>  	struct dsmas_entry *dent;
>  	int valid_entries = 0;
> @@ -352,7 +354,7 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct cxl_port *root_port __free(put_device) = NULL;
> +	struct cxl_port *root_port __free(put_root_port) = NULL;
>  	LIST_HEAD(__discard);
>  	struct list_head *discard __free(dpa_perf) = &__discard;
>  	int rc;
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index fc94f5240327..1b8d7f812f1a 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -71,7 +71,7 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
>  		return NULL;
>  
>  	dev = device_find_child(&port->dev, NULL, match_nvdimm_bridge);
> -	put_device(&port->dev);
> +	put_cxl_root(port);

I would say nothing should be calling put_cxl_root() directly. The fixup
here is to convert this to use __free(put_cxl_root) at declaration time.

>  
>  	if (!dev)
>  		return NULL;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8c00fd6be730..f989f88960bb 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -986,6 +986,15 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
>  
> +void put_cxl_root(struct cxl_port *port)
> +{
> +	if (!port || !is_cxl_root(port))
> +		return;

The !is_cxl_root() can go away if this function starts taking a 'struct
cxl_root *' argument directly. Let the type safety happen at compile
time now that 'struct cxl_root' is a distinct type.

> +
> +	put_device(&port->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(put_cxl_root, CXL);
> +
>  static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>  {
>  	struct cxl_dport *dport;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 492dbf63935f..ba82b2f89898 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -735,6 +735,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>  struct cxl_root *devm_cxl_add_root(struct device *host,
>  				   const struct cxl_root_ops *ops);
>  struct cxl_port *find_cxl_root(struct cxl_port *port);
> +void put_cxl_root(struct cxl_port *port);
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>  void cxl_bus_rescan(void);
>  void cxl_bus_drain(void);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index da3c3a08bd62..398f5d50e942 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -137,7 +137,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	 * assemble regions from committed decoders
>  	 */
>  	device_for_each_child(&port->dev, root, discover_region);
> -	put_device(&root->dev);
> +	put_cxl_root(root);

Another one to convert to __free(put_cxl_root).
