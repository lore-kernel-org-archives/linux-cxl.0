Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45625138A
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 01:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZtNe7UZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704763005; x=1736299005;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1hQ8XsrGDiCB8ifHXju1axrZ65jRaWsSecMxMLVKhh8=;
  b=cZtNe7UZ+mYfeNiH9YwGxSIvynzWUSeayPbuIOGPTIFanMZY6PC2jCdx
   vwRe9ylPy4YJ7HpotX6vFd+M/rIoDMcuCasT0tyQowNw59AReu58dncQl
   HgxSuYMpo/rQbPuy23tkWl5FppS0lLuhnnpLeGShMK9NSVzaOFC4gnZCR
   qKcai3YZRfMbn8glSpWLxOsm1Ggg6mmtkzfDuDxPBpM9dedgPkjbNv+EZ
   i4ZefuN4w5rDWf5AN0SvE05moF2cCVRJqdSft0D7XojQjHDHxKwSJ79S/
   lB3XOPlOTKLxYJjDBC8guLjHOJ6LQZAfsH8wZCFe4Lv1Ia5PoS0hOkM31
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4797294"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="4797294"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 17:16:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="785037319"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="785037319"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 17:16:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 17:16:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 17:16:41 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 17:16:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egXsJoNMW/TiIm9q2xNtGArAwuKOZJqiVc/r/OV7gKACh8RiV7A97PPQ0q1nQ00QtuA0VQ8hEXIe3mQ6qerFrHtLSHs6WJadfI7SXbsvhx/EjdpGEWVWAeVGksvIUMlhJCngX6HS3QKuXX1e5Lgi7M866a27H8y/sN1oyGPzLMsCfKe1WL/EWWrVsW5ZQj/qzcxF+bWcqKprJc4754++62UeYNMd0BGyG7pB4zmZNNwPmFSNu/Qz1pkigMFlOD7uSSnMtauP8YDFadudblE25gVUw4HF2sWFASN4+2p4kWwy7bQi6cd7iDrXoW9ar/zWRKK0G7v0B+RomjL5uWFn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXHvZ8F3qUHAOOfga2GQ/qRueUpdZaNBbSfF7ytECNE=;
 b=NeeNzlLI5BNDnKrbtfhnuMx+zP4/dwmkNBMGTj6NAPxNsfkC5DiMUfVteXpuxmTyVez9llPCq1/wHHm3axwrLLSKOyi9waXBFu+6YXMpVUdv4apXbE7oEBplmQRIwJSbSSmgV2tXzZ/IVpFxhHcSyxdfX0QeDB8o+IDUCXJELGG6p3ljfonQs2H/AhwVu7SJYQdlOqohBp3sfkiJU28kGeurG3m/YzAfElKzoXrLbP7QreC1uprlRKeerZQHXUFRTNndKqn0gZPViQ0tUmLqO7zBNAT3KlgHNEdFQUwO9J4gJ2kG7xNCZdPn49zH4cNuThQndlUgeCJiNyHWVTnWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6935.namprd11.prod.outlook.com (2603:10b6:303:228::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 9 Jan
 2024 01:16:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 01:16:39 +0000
Date: Mon, 8 Jan 2024 17:16:36 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Robert Richter <rrichter@amd.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>
Subject: RE: [PATCH 1/3] cxl: Remove cxl_root check after find_cxl_root
Message-ID: <659c9e745e6e5_127da2294bb@dwillia2-xfh.jf.intel.com.notmuch>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
 <170476242895.115624.3127891331552985140.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170476242895.115624.3127891331552985140.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR04CA0356.namprd04.prod.outlook.com
 (2603:10b6:303:8a::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: ba77a6a1-3586-4dcb-81a7-08dc10b0a18f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnyeodN1/Szx8jHQ+AxvXlK9AyOcU/9vqVczlB8OACwGgDNlDLpEKU35F4/ufw31rVJzDr3q5Nj+YwPMnPMqBasMogajRsLrIcpcRajaX9ovB4+5fnERQlM00f6jW7p2fsHO4yGAG+1fpDUplG0YDUPXVwloq9Mb9G6owztkFuaNYGEx79F4iY0psGmKruosy4pUNyCD1buZ3FRbQOeAQnl3EqvKdq2S3aRqNvJS2vAGpCZJ8bYLbmqH+W2O4A3jSaU5TdAtDWWpbbuWSiMBT2Hsc/B7sUMM2hLDml9VTXrlvGsZaQoyNSGbj2Bvg7Y35jD24vDgrcIaeTADKnbgsVLFIlaVpKVk1IPNq3SIUAbdSmVkaVOrK+M7Glcub+FNw0zWrZ5Utw4RH+H/990oosdWbxVU7amEp9RvJ6O65jDWtls5dM36kxq5auhb7foqqaKzOjafkiUbHYX+xGJnI4yNKLW7yL2AepP6tyDeUABlzXKvIrTweWGeeZpRnGbWoa/ymQBzbDriuLyDX5n4ezMXtSjZeukx9Tfkm+hBiDDecszggNAtv5F1mKmStIXF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(83380400001)(66556008)(41300700001)(66476007)(2906002)(6512007)(4326008)(316002)(5660300002)(8936002)(6486002)(86362001)(8676002)(478600001)(82960400001)(66946007)(9686003)(6666004)(6506007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ge61vIBRP+1/iBjNzgPyXJXJ0kzMP4qXzUYd/Rt218K5o9Q0cMq6NOEJ5W5i?=
 =?us-ascii?Q?2//LMvSdGMUv1+4n7tEWXXMfs4b+l8pOe+ym9ryk0PrrqKIjBLQpTDQDeE8B?=
 =?us-ascii?Q?yBKrsO9W+mWTtp+cFnqp83SgPDtt5c9LzV/ajlDL8cGRssglH7nq77z+kal8?=
 =?us-ascii?Q?6KB193eg7wG1idF/nSkEyNA70oCvMidaYulqPd4sUqbCmgLRxKEQFT1rhKuU?=
 =?us-ascii?Q?mpoq6NFW6sQ3q8DMpKtOBj+sd0Y1D4XqZ4Qtukcm3MBxZzII7LN+bbnIZmo9?=
 =?us-ascii?Q?WUKXTdUUdV7m9JTbolj2PmTYwRRXt5esTYY3p0I9Yngr0Ld0MfGUMDptAUEC?=
 =?us-ascii?Q?RSR8X1W1rua0V08D7QZXHomebpiP0Po9H5NRdKDt3jZ9mRPNeFBeq6Inkou3?=
 =?us-ascii?Q?qcFLZuz7q6IgMd5hJFwDe0baYzTQiVoLKfnKAAUvbTbN7i6JP0oFe0S4kBba?=
 =?us-ascii?Q?c335q8q+3dy4EaT0BTNMA2rW56Z73oO/FXhNp3cc1Qqr2S/tDf1s5Eff4cWW?=
 =?us-ascii?Q?sRATtUlVvu4C9qnnwKokHeLICuZh25iHd8E5dQjRfyusWc6Dcs1pOfFnaj4M?=
 =?us-ascii?Q?KzkXdDBBbS0o/v6oXORah4VTp7Hly5y01CPPUA8wJzb3VJMMzWeHVSrEppwN?=
 =?us-ascii?Q?zBDhk4i7NK4n21tDyc6ERRk1srgBq2s5ufWKhGYNNo+v8ZQblqRjR5YrBVVc?=
 =?us-ascii?Q?XzuzmldSokogYi4WpbMKsgMxInK/QJHvvo3TBYj0iLJvY42aroO38O3K8HJ6?=
 =?us-ascii?Q?82Y2Ro4zn9q/EAdIgKO2SQRuxTlCT9LYYY2CR9VuPl+zarmBwPyUrNZnnYyf?=
 =?us-ascii?Q?HBhqzS4uoqXNm3Le8Svai7OI/d4f+Lj7o9feu0/9ZLl0naWGee3QsspdJMzy?=
 =?us-ascii?Q?ePM6I3aVHkAA4GOoknx4PEL0R+Jj7KsSbkIET+HmYjoQQnhjHZFDBn0Sv0n2?=
 =?us-ascii?Q?qCeEX1lbkhHyY73lXI9i4LFxpm/yyYdbTHNnMRUKRpWghWNXMGl9PjfejyGp?=
 =?us-ascii?Q?MuJlL9Ajduy6A7gVa5xvLStOpT3eNo3VDyLzC3Fe1sfn1Xij7aKgtnTekKS5?=
 =?us-ascii?Q?qquQqrzFTXOKJO/vZy9hEYOQDuk/tiSlNy06d1bgrMqNH465IJDsy/J3L3QC?=
 =?us-ascii?Q?CGUe0Y/M5wvw2vasWuxcU1htSGVXTxm9zytPhEnat1yoiJshZjzYw1MYG96n?=
 =?us-ascii?Q?BWoVo1a/v8HMk7aGzxZhLGm7Zq6LxxABcm1BufdbaGDbdHalozmJNQrS/8tk?=
 =?us-ascii?Q?CQW+HAIZ+XQlNoawVn4fldkbzd+GRO51wCCS6xZRDEo7Xh4oVuXx0mJP+6Gf?=
 =?us-ascii?Q?Lfhwz0Mnu25d/zbYPazV81sXArAeUbr4GJ2FExFOHvnrM+5UsJefeuqMODV1?=
 =?us-ascii?Q?R2ns2peY87kk2DqZy3sZ8y8gW++RCe6ez9m3DF0oXLgrOuhBpWOomwhL2KHE?=
 =?us-ascii?Q?0qVVNlwGl2gNlWBkOhq+vqxWK60MObJKZ9srXE4XPia0oKXoRqXA7U+VX4i5?=
 =?us-ascii?Q?wouZaWxUi72Z2lSs6mUs3K0FkR3fGXbZW7kjX1NUyZqNvKISE6zsSdFS5W7M?=
 =?us-ascii?Q?ljhaSCqjMBg2494A3+7iR7ZdbEWhHChF+6Ff6sLDSnkVni5f5CEzBq6nj20Q?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba77a6a1-3586-4dcb-81a7-08dc10b0a18f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 01:16:39.2876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZ30WuK/u85vOqECgtm10sGS5URkjVOFvsj9ayDuqjJgrX+Sn8IkTSPARDjNVpZO7DsefyS4NmfSFLbHrgoH0kO5Dxg+wukqK0UJLUBRzQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6935
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> find_cxl_root() can't fail in practice as CXL root exit unregisters all
> descendant ports and that in turn synchronizes with cxl_port_probe().
> Remove unnecessary check after calling find_cxl_root().
> 
> Suggested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/cdat.c |    6 ------
>  drivers/cxl/core/pmem.c |    3 ---
>  2 files changed, 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 6fe11546889f..f7ba7bd2e459 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -176,9 +176,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  
>  	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
>  
> -	if (!cxl_root)
> -		return -ENODEV;
> -
>  	if (!cxl_root->ops || !cxl_root->ops->qos_class)
>  		return -EOPNOTSUPP;
>  
> @@ -357,9 +354,6 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>  	struct cxl_root *cxl_root __free(put_cxl_root) =
>  		find_cxl_root(cxlmd->endpoint);
>  
> -	if (!cxl_root)
> -		return -ENODEV;
> -

These are kind of ok because cxl_port_perf_data_calculate() is called
from cxl_endpoint_port_probe() which has the exact comment you reference
in the changelog. However it is not clear a couple of calls away that
cxl_port_perf_data_calculate() can / should be assuming its calling
context.

I would be inclined to keep them.

>  	root_port = &cxl_root->port;
>  
>  	/* Check that the QTG IDs are all sane between end device and root decoders */
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index e69625a8d6a1..ed76d37e4fd9 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -68,9 +68,6 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
>  		find_cxl_root(cxlmd->endpoint);
>  	struct device *dev;
>  
> -	if (!cxl_root)
> -		return NULL;
> -

This one is definitely needed since it is not called from
cxl_endpoint_port_probe() where it knows the linkage exists.
