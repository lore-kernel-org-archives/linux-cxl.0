Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5DE2D601
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFgeel0n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704411609; x=1735947609;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IqseY1XqXIjQjCQR8sKvnueQq5BWmfMR3KkSU52NcOw=;
  b=jFgeel0nmrqnzAk6qTrc7Vab+bTEFbUnR4oodAoiMV1o/LIWO2rtQNwV
   NwggVEXU4v54d5zlvuDnEiyxydTnbiLez4W1NVpzRWSNEvpAnIeNoZTT1
   IgPLoGznVAspPDt1P8IfOtW///X/Ff9yIncSl7xpuTPgaPV8QMr501wqp
   920aZwQ+QEyfm6PQy9h4ri1fg/17QnaugxX4olA2fROINXFGGjihXInuq
   zqF4botUrQISjbTcb5i2J3Bx6VLcLqYIenbLnDGAgJSIsRca4COF8t+/w
   FqW8WuGueLCYTYhJRrMtSB41NDa4BbjGENLiLBvKncW+enib4CSSfUVun
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="400149351"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="400149351"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:40:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="730310542"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="730310542"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 15:40:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 15:40:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 15:40:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 15:40:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZcdAuupnrMdNz8Gzx+cLMoWXfRYQJMBqJPCl/15/+P26L6OR3JoKmCbFu/UihaVdqfKDnKV6SkTEOKJSbTrW1kbeEJyfST6r7YKaBkJucsE42SxqUx3/RvrGNiSa+PYCPiBhFE7MdI7x7nTd7j1p6kr0RTt1GcoENBmahYEFxLfB1j2jxF5aE5IvjoJRtyK3QHmFXPWvcW3xCduYNRRv9CufaSABZlmoeZZg5IzR4EfEaTsBDLitpUByibFDGpanf5LwS1RAbZdc0uo1ugP8znhiE9vZsU6wpLGEp6WsOzGk0vicqvJpmkpmgzcH/o1Y3uovuZAgj7oHIruyVx0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAp+Rmr9HM4gFkzOkEfPoBxOr8zKtaGVpxZzHcY7GrU=;
 b=lEyjnaLaVgB785v5cH9h6lbkg0gW2MCkEUW2nhvZUHTrJiviAiw8HacbXCLqf3LbzNbRo0QfTFIsVVUETHatsJ07uwTa+XI0aHSc6wRoT42LDBhJDX0ibd82WuE9bXl3jwwR9pwiD69GxYFeJFEQ+gqop4zH5k9SXv3YUZzGT5d29yO7As/+kZanKVk3tA/DnPYZl+o2YY4hiXm024TrL0RXxq5mjYM+YbDdkw1gxIZUMe7TJmN6LKdBfrrGPKMEYbFWejakednYlkDOIU/K/pcZhSqACsLtGWRPRKOwE41nw7Pp1OpL981xVvVtu/SNmrgCbRxrSTc1PYVmjmB7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7825.namprd11.prod.outlook.com (2603:10b6:930:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 23:40:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 23:40:05 +0000
Date: Thu, 4 Jan 2024 15:40:02 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <rrichter@amd.com>
Subject: RE: [PATCH v3 3/4] cxl: Refactor usages of cxl_root from being
 referenced indirectly
Message-ID: <659741d22ba90_8dc682942b@dwillia2-xfh.jf.intel.com.notmuch>
References: <170440924347.3570725.6271367271629367301.stgit@djiang5-mobl3>
 <170440925509.3570725.9669871754496155658.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170440925509.3570725.9669871754496155658.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:303:b6::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cccc94-f103-40aa-8f30-08dc0d7e7a3d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylm9Nr8BxAWzr0vzbQ9bYUYq0+BlcirH0KD33cIxcvxf6RjaR/KwrKnwAy9b0E4CI4XFkpY+XeZyob67EY6fvN3euQBTT/619JFz7xKjtJr7pA2WYzJ+ZY3lEqAhzk5DMNSbiyeqWOsKOoIkVyZ0HTk/EJUjgmxiGOnrDoEUFJKHBM1SC15EsH24w2VXjHiX7fCocaiu1N/WpvPdFol/fAHgTVEcJ2fuV55NICXultNqJ9kctysOWAOe6AJgv273VPq2zyRc6Po1yDlhjZc6uiVlzSuoL0bsCYsS0PrRMjsjoXg/wpDOpb7COJ5FiihE3whT7Wl1VBmFMLPluZDRJLao3JdFdm/AJ2GmCDIDeLDXZeVO0XKUrkg9A3dmHMJlQagwiu6BZUAdx9UdYC1P7KUEyySZEXcjZ0DSo2NLowTz1za0YFIqTUNUTx5CJxFjBlwRmty9jjNlKMr8wJLJT/1vJhI/pnbHnQn1HrJyEt52VE91cyz0q3WkGnGFSKZRGHJxOo/PiBjNrfwwMyshw7Ieutw3i+QVB2otQ7t//YnxiEy0ngwmqA98EKSaZet/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(5660300002)(8936002)(4326008)(8676002)(316002)(9686003)(66556008)(6512007)(66476007)(66946007)(26005)(83380400001)(38100700002)(41300700001)(82960400001)(86362001)(6506007)(478600001)(6666004)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TBilm+GSQ6VB5oEZMRuuUCzEkEsV7noCIyrWJiCrH1nAng1+vDRbNWMWmeuF?=
 =?us-ascii?Q?cdTwHrv+7M2BYoz55h0U7Y4tqjWW8yrVil4opPfd2qatFk/xrlGNdtIFpnGJ?=
 =?us-ascii?Q?5rgFfjg47n9SWMFWmOBSW2cTpDWYEwAUgM/3ZOiJxxB0TzE/XpCkMzgQ1HEw?=
 =?us-ascii?Q?XfDJ5y8uLo4UwD31BywutzxZZoIm8VZeayQdvplWgayUH4g6liBukVfHxtLR?=
 =?us-ascii?Q?08B3azrIRhZi3IT0KetsIe2pKIHgaEbmnkXtOuOQB9W6QkSDlYyUnObaUkyZ?=
 =?us-ascii?Q?6i3HJoIDafoz8UAKadp4mInjLrJmlgtyhtMIu6sVs27wJXNJzoVMpjmHV8Pc?=
 =?us-ascii?Q?+NQ/S8/1Z7mtDoXcXNQjH8CzQgm2EmS3pkAAOrewwEOtDwSTUdXQL98w6riG?=
 =?us-ascii?Q?xNuENlkwHuGF0Pe0l4AdZzkbb5JQ2+3GKeAsLgRA2NWZTPZ/oEr2R015RHbj?=
 =?us-ascii?Q?ZMcSwCCiheyUb4T5pqou36j58cKp7umVQlAf4YvUcMh/tIDvF8UOKTLb0HII?=
 =?us-ascii?Q?cDOr79uDFFHbtXK+4JeQ3sijFWk76g5iGQW2zvIcUg2ZQep8fGQf7Y8ou0QX?=
 =?us-ascii?Q?YZ1Q/brL9/BJKgr69MSpTsLwkVuynTq3FS5IDAvvV7xS++B435cO+kUh0Mzx?=
 =?us-ascii?Q?P7sA4NI4r5wQpeIOMCnSTVmikJ36/sK+HXYsaOt6qyMcNm9Oz+03IVJso0Nc?=
 =?us-ascii?Q?gDUxefcpt7njCDZUyYYmG9AgEkbYvBF7/zGm93DQzcCvFTfNtqP1pTf32jbb?=
 =?us-ascii?Q?qwgEb5o93Q9sfPalnw16xsjvrsdYx/wGRhynNvmZsGGidhkL52WzOJuRXGVg?=
 =?us-ascii?Q?TiqEsG9O8ofaodW44Rs7JH60zXMzhh/4JHCE/mrsrnuOeaRhAyFL2ufLo9sR?=
 =?us-ascii?Q?gkjD8KcCYOFpBG4Lb+weq9Q9G3O1d4f7roNVXpPNPNSVs+uuBaAxBeUkFGhB?=
 =?us-ascii?Q?L9sBaQ9za86Za3HvLI95d/xcTCo115cXUvxjko8fF71TROkMlY6faSQTIYqj?=
 =?us-ascii?Q?GctUJntTXVcRCSG89K7Eu31kJR00gEQmCUEJv/BzYh1ulxPUBOOBX/FzMwt+?=
 =?us-ascii?Q?87nxfuLwzIBXCJo4hYNEtBr5xaCWeYcy9KHjw9/gE9NOo6gn1BeFrVRY0L+A?=
 =?us-ascii?Q?ej0ut1jMCq7xeL053mLfekwwJITYtsqXyPdUBREO0B4ES4PVq2RRqNI1zDKO?=
 =?us-ascii?Q?/+NGRj+xt/ANh02Dau+2DfgQCD2F2CYN5101Sfb14EpSocA3ww1VcXjb3FSH?=
 =?us-ascii?Q?VCYwEBOuUKf9C2Ru77Gepoc/FQeka7DuonyP9YY3cfjwVdUQRainP0r8ILPN?=
 =?us-ascii?Q?OBZfZ0bWbFkJPTXRggnxm+9LPPz4AlrMnsj1A+QJdEGdC/S93QMyD9k59vVL?=
 =?us-ascii?Q?nW2fI9p4c+JuvwJ7HdTD+UEpu/TpiPKFGn76QLroI6ljnhWjZQ4nsNYdGdI5?=
 =?us-ascii?Q?vxRvTCnLWzKOygSenRDiDetijLlZqIn067rNwf/l04MIHcDqk1AGYu3QniEu?=
 =?us-ascii?Q?A47RyQjJgCd3DErECFBRhfUV9rZatHdPNbLmyXaGecWuCbfuAZQmiqpaFhT0?=
 =?us-ascii?Q?zjXODNMPanH2iVQXMfhp+0PT8bTbU26pzxMoT2QEdy6WWad6QadqjzDkKLv9?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cccc94-f103-40aa-8f30-08dc0d7e7a3d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 23:40:04.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzrSva4XcEbI0CMDMkl8/7FPdZbp1AJseIb6/j5v+vc1WvkwjrcLVLUviePFtUT1OOKs3x12mXF7tdp/NPsHMF0BfBF3UpSJ0B+ZXKyBPDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7825
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Commit 790815902ec6 ("cxl: Add support for _DSM Function for retrieving QTG ID")
> introduced 'struct cxl_root', however all usages have been worked
> indirectly through cxl_port. Refactor code such as find_cxl_root()
> function to use 'struct cxl_root' directly.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/acpi.c      |    3 ++-
>  drivers/cxl/core/cdat.c |   19 ++++++++++---------
>  drivers/cxl/core/pmem.c |    6 ++++--
>  drivers/cxl/core/port.c |    4 ++--
>  drivers/cxl/cxl.h       |   14 +++++++-------
>  drivers/cxl/port.c      |   12 ++++++++----
>  6 files changed, 33 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index afc712264d1c..37cfd5516024 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -295,10 +295,11 @@ cxl_acpi_evaluate_qtg_dsm(acpi_handle handle, struct access_coordinate *coord,
>  	return rc;
>  }
>  
> -static int cxl_acpi_qos_class(struct cxl_port *root_port,
> +static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
>  			      struct access_coordinate *coord, int entries,
>  			      int *qos_class)
>  {
> +	struct cxl_port *root_port = &cxl_root->port;
>  	acpi_handle handle;
>  	struct device *dev;
>  
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index c5031e90bb96..280ca1508f21 100644
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
> @@ -174,12 +173,10 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  		return rc;
>  	}
>  
> -	struct cxl_port *root_port __free(put_device) = find_cxl_root(port);
> -
> -	if (!root_port)
> +	struct cxl_root *cxl_root __free(put_device) = find_cxl_root(port);
> +	if (!cxl_root)
>  		return -ENODEV;
>  
> -	cxl_root = to_cxl_root(root_port);
>  	if (!cxl_root->ops || !cxl_root->ops->qos_class)
>  		return -EOPNOTSUPP;
>  
> @@ -196,7 +193,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  						    dent->coord.write_bandwidth);
>  
>  		dent->entries = 1;
> -		rc = cxl_root->ops->qos_class(root_port, &dent->coord, 1, &qos_class);
> +		rc = cxl_root->ops->qos_class(cxl_root, &dent->coord, 1, &qos_class);
>  		if (rc != 1)
>  			continue;
>  
> @@ -352,15 +349,19 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct cxl_port *root_port __free(put_device) = NULL;
>  	LIST_HEAD(__discard);
>  	struct list_head *discard __free(dpa_perf) = &__discard;
> +	struct cxl_port *root_port;
>  	int rc;
>  
> -	root_port = find_cxl_root(cxlmd->endpoint);
> -	if (!root_port)
> +	struct cxl_root *cxl_root __free(put_device) =
> +		find_cxl_root(cxlmd->endpoint);
> +
> +	if (!cxl_root)
>  		return -ENODEV;
>  
> +	root_port = &cxl_root->port;
> +
>  	/* Check that the QTG IDs are all sane between end device and root decoders */
>  	cxl_qos_match(root_port, &mds->ram_perf_list, discard);
>  	cxl_qos_match(root_port, &mds->pmem_perf_list, discard);
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index fc94f5240327..da92a901b9e8 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -64,12 +64,14 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
>  
>  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
>  {
> -	struct cxl_port *port = find_cxl_root(cxlmd->endpoint);
> +	struct cxl_root *cxl_root = find_cxl_root(cxlmd->endpoint);
> +	struct cxl_port *port;
>  	struct device *dev;
>  
> -	if (!port)
> +	if (!cxl_root)
>  		return NULL;
>  
> +	port = &cxl_root->port;
>  	dev = device_find_child(&port->dev, NULL, match_nvdimm_bridge);
>  	put_device(&port->dev);
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8c00fd6be730..b8af09464363 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -972,7 +972,7 @@ static bool dev_is_cxl_root_child(struct device *dev)
>  	return false;
>  }
>  
> -struct cxl_port *find_cxl_root(struct cxl_port *port)
> +struct cxl_root *find_cxl_root(struct cxl_port *port)
>  {
>  	struct cxl_port *iter = port;
>  
> @@ -982,7 +982,7 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
>  	if (!iter)
>  		return NULL;
>  	get_device(&iter->dev);
> -	return iter;
> +	return to_cxl_root(iter);
>  }
>  EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 492dbf63935f..8f43a06c4f72 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -617,12 +617,6 @@ struct cxl_port {
>  	long pci_latency;
>  };
>  
> -struct cxl_root_ops {
> -	int (*qos_class)(struct cxl_port *root_port,
> -			 struct access_coordinate *coord, int entries,
> -			 int *qos_class);
> -};
> -
>  /**
>   * struct cxl_root - logical collection of root cxl_port items
>   *
> @@ -640,6 +634,12 @@ to_cxl_root(const struct cxl_port *port)
>  	return container_of(port, struct cxl_root, port);
>  }
>  
> +struct cxl_root_ops {
> +	int (*qos_class)(struct cxl_root *cxl_root,
> +			 struct access_coordinate *coord, int entries,
> +			 int *qos_class);
> +};
> +
>  static inline struct cxl_dport *
>  cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>  {
> @@ -734,7 +734,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>  				   struct cxl_dport *parent_dport);
>  struct cxl_root *devm_cxl_add_root(struct device *host,
>  				   const struct cxl_root_ops *ops);
> -struct cxl_port *find_cxl_root(struct cxl_port *port);
> +struct cxl_root *find_cxl_root(struct cxl_port *port);
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>  void cxl_bus_rescan(void);
>  void cxl_bus_drain(void);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index da3c3a08bd62..656f2e03d2ea 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -94,8 +94,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	struct cxl_endpoint_dvsec_info info = { .port = port };
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_port *root_port;
>  	struct cxl_hdm *cxlhdm;
> -	struct cxl_port *root;
>  	int rc;
>  
>  	rc = cxl_dvsec_rr_decode(cxlds->dev, cxlds->cxl_dvsec, &info);
> @@ -130,14 +130,18 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	 * This can't fail in practice as CXL root exit unregisters all
>  	 * descendant ports and that in turn synchronizes with cxl_port_probe()
>  	 */
> -	root = find_cxl_root(port);
> +	struct cxl_root *cxl_root __free(put_device) = find_cxl_root(port);
> +
> +	if (!cxl_root)
> +		return -ENODEV;

This is ignoring the comment above:

        /*
         * This can't fail in practice as CXL root exit unregisters all
         * descendant ports and that in turn synchronizes with cxl_port_probe()
         */
