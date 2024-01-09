Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B217C7
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 01:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBkmtSRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704764289; x=1736300289;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0ASSFfIg+LrH71b3pmiC9k+IK0IkV89VZ3xAHSKJj0M=;
  b=OBkmtSRew9iYZFCkW8oaIfQt7WMsIqMBsKNzMFvYVM2aReW8Z2jTDVkJ
   pU16hk1enF6HdawXA5Pn9qEoHbHplPo/QX/vzDeLvrRwxjUk96eXO32Vz
   HY6MfN9FEAbtYpP+Z6eA7+SMyw4jZTzr113fsVr3BZ2n/Ddu3TRoYeCx8
   o4w2bMf1qhMNrkAOc91ML6mAUc7LZ6uXrs/6rkLfxiydtdC02Wx5qXOHR
   g4eVU5u3w33f6b3qhuAoBOBd2oxR/AWXB7YzFCZ3ZRwOed+8P/dyY0bIS
   E49UvvIn24L+TccY7Tq74MCeweKWe5rS9UfwrvvFoKtjKyo0pvwF1fMKe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="464450064"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="464450064"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 17:38:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1028579186"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="1028579186"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 17:38:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 17:38:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 17:38:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 17:38:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 17:38:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2Eeysazl1ASyh5eWSYQm/8pSq5hKmlboi9Hk+MMbwsjow/+hUyqHygV85yKS7cHHfN8ce/DuFO8fw4Js1sIXL2cEyLD1GP/fWRJQrlAKGKF9UuvYIn+Z9fIY46JprjlsDinYe9F85UFYOniWRjDqOhmbOUkAqtvi8KQHcJ+VLrmChAksw9jA7K0TrjG2P/GWAJ5WiCaiRguNJNmJLljMfBCsQJSOZxfYL42AbzKMX6yeLYuck0EhovvVVCuc5puq8ocUpn4XnDDcaxgVOhdNPrEBCgET6bHvljQr6c+50lVILwWoXel2oIP6asS1ENQviMt8HrKGB+w0KisEWa9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nbNzCK/mMzJUREd6O55fc9rXj8sXeWzywaisR+X3to=;
 b=bGBsOSemCiOuUx5tjX9DzfRQ7Mm5sDnRL4wFH4oEv2VcQIZq54jAPfDiGMqohseq82PKeEF0MbO2twr/3U1BPgxWFF5XtORAJy6VPVGLGacfbiMUCjvibDeq8w+w7ojU4dB8miblkfSpTCQ2q6tpfGs2hcw0mEzZubrZtsdYwFgai8bJm8AD6OFlbaw/6A+0yQOrApgtCllikGzqzc+DlHuHwIIQybfGpjk5cxZ9neTIP3xw16a+eDj11p04fV5wgkCgX9idYZLd/K5R/PrkcEwtajOhP41yRmvEg+i/px/+Cra8LwLMjwq00BWkiQi9g2C8YYlTe07ggkCLdj+cow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8159.namprd11.prod.outlook.com (2603:10b6:8:17d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 01:37:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 01:37:58 +0000
Date: Mon, 8 Jan 2024 17:37:55 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Robert Richter <rrichter@amd.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>
Subject: RE: [PATCH 3/3] cxl: Make calling of find_cxl_root() declaration
 uniform
Message-ID: <659ca37399107_127da22946f@dwillia2-xfh.jf.intel.com.notmuch>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
 <170476244072.115624.16860571023685051383.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170476244072.115624.16860571023685051383.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:907::17)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bb4f6b-f55c-44c3-fffa-08dc10b39bff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fD2rwQoQh594qvemMU8QuQ55JlwZR/lkqKa+s7Q260dz2hQl7mGyD+5mqk82kcgf5CIqxPveAsi3WsLrZZ+4VuvcdS7EYXJqAjV4AS5uIxU/P3Hjd81zCcDpgi0CO3PjvPrVlZm6hC1Zew3HK5VS4lsrs/TOYrxIlMeEcyUKlyPsG78dldRHZ1+ksvgKfjxSBrxuM589lt6HRsny8kgKQ8O16gZZfH+XFaxDR+VkA/L1fSLsEYx8y0SlO2YGC3fVSse9B63WUNwbzVBQhWNeA9n77GY1qU4Z7NnlgYYkMHdDuBVHoNwxcqbbDXspxrxMrOTixujiZ1T1wJsBkwKB0oxD9TfRP0VhdorGePQBNvBqyI8d8cgm4yNRKjGyf6fBhoTaaQ5aj48qx+ACLCfUc5WlROVff5t/wIhew9ovWZNOECIWFq5FJwF4e5kwPVOx+rTXrNcBZlv1qKSqKO2BxEGxBPcFbmzMAxorKCDdfmHXOcai1J1HhHLMQfdtR8lLWl2sjw4NXwrWCuHErMtbaaQF8s4NAMTR9XzwGCWdM+uoDdFJmNhih4Gvz04N1H7T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(41300700001)(83380400001)(6506007)(6666004)(66556008)(2906002)(66946007)(316002)(66476007)(38100700002)(26005)(478600001)(9686003)(6512007)(86362001)(82960400001)(6486002)(5660300002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iBOjPnQnTge1ef9CEKKZ7WVWlPXoERh8AG0TFHMVIN9SIS1ILUbEyP3FfHNg?=
 =?us-ascii?Q?ZDDVuHIPwT1i6bOdqY4d01mIiU7bewiHSxwXSjWnddwPxHdCLef28ffsxRH/?=
 =?us-ascii?Q?KDAgAzn0WEDcSCPzW6zTs2h6FQieEYAO/25vNg0kHLpiXrvz78M88k5C9PpT?=
 =?us-ascii?Q?6hQyPnyLHeg1G6hay1S/zXwsO86COVbQ76B9VIVXnxd5476So5lqFFdbBzkC?=
 =?us-ascii?Q?TIzx4XamvWRsrIfcXNgNjhT0DMLWm1rbgBaHxCwiQ22ZA9PTKx8P1QHGLM5u?=
 =?us-ascii?Q?8hbKBvgbp06qxAh9pcUPqTFyUDuOIJquGlr+LrX7aVdsgpkjT7V6NB7Q9qdT?=
 =?us-ascii?Q?TXPUYCXsMO9CPUvuEtKyvNJuDTIWC0/LjDPiyFakuviSYCZdszAOcu0OluLe?=
 =?us-ascii?Q?G4t4XkWa4j4XFz52CKAPtHxnnsnxkYhm8HofvBtSfCl/UQlJELZPCD5fLrkK?=
 =?us-ascii?Q?c6/Ex8A9v/un8EtX+MsE13NsbcuShX0kOv+c63mGNhGgrKDpFS5yc4V5WfAc?=
 =?us-ascii?Q?n4tvBeVy8Mhi0ArDPV+nOPfzUS8RusqgQbSBiXBLx/yy8tVx1H3+uRilwGEK?=
 =?us-ascii?Q?Gz1rNkQyM2yohJ+9Bu8eya56ZBxUKAeX186vSSnlVSLXawf3NNb8TDxuOch0?=
 =?us-ascii?Q?Urip71mgijpdX01aUTOMX4seLREiIBDPPHKqYw0rTGIXW2+JIVHJ4qYzmJYk?=
 =?us-ascii?Q?s+8MlKPmHPdwA3zA81WPjXUy4iPFoNVYPtUiOCtTDRBVr3RD+twGZYUFGaZs?=
 =?us-ascii?Q?Lwis8De7ewaGR0s7X8LrQUhsnbkBoVLM4NAZupYiBvQm7abu568jcJlNR+af?=
 =?us-ascii?Q?0s39/JDF718kX9Eb3pOXRWvJO4/G9IqWc98x1iRI0A8W/4d+Vd7eh2D9HmLz?=
 =?us-ascii?Q?yxMYTvDn9bknxGsNf5YGriyhRkn6n7bJvbaLkc4EDs8hCNkSBytG1r4A1mo5?=
 =?us-ascii?Q?3AOS95/TK/TucthRI1w+MWSoXd1VE/i5K+WmebRF42gqrYTFctuE32EODLw5?=
 =?us-ascii?Q?zwRZy23THFXDjX2Q184XM1hhpk40DLbMNH1UkFBOtbX2eCc9uJLBDKNkITPK?=
 =?us-ascii?Q?rjjPKBOnWkNkVMLlrAnuVX3Muy4Gqj8W97q37eTdXIP+CdyZl9NlGLxUDDnu?=
 =?us-ascii?Q?K89eVV0Vz7Ix8ni7HEdsDuOF9xiW8CXKpYHnIxjZQ/kf3NgCITwpiTGwtF+r?=
 =?us-ascii?Q?Q+7vbLs/CTaLyZvXJ1tCZnpt+1NSeDmAPD2vtTT17WqMVJ6W7MGTHASr+OgC?=
 =?us-ascii?Q?R1NcV+Q3wwHnCfbuog3ZiQgA49XiY5coAq4eAMgmRoLyq9w+cm/I7s6a4hnL?=
 =?us-ascii?Q?Qenhv8hMu2k7hqkCsPsF2eFZWIJaKDSfIOA4Wxd+FP2NE8p3UTxxWd8iQrrR?=
 =?us-ascii?Q?EO2Et/bIEnUyu/8vh1uE4REzVWGP2CCJMZ639c5YXigLgnlpCpG9LN+xtOb1?=
 =?us-ascii?Q?KJIss2RuumglkK1nHrXRTZR466wRaPGUWr7glrGlGQXJ33mMDHvFrhheZ6fh?=
 =?us-ascii?Q?AXgY0O26KrYD49kAMR6AEaaZOv5TBabuxyN6rwN4ewF8xVS1mF6k7V7Z8sup?=
 =?us-ascii?Q?Nzools2suPFiDRWxoId6+9O19E52qL9y5dnYr7aKCtOVLuwTah2qoz+XX9YX?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bb4f6b-f55c-44c3-fffa-08dc10b39bff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 01:37:58.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXmHqqQDVZE20ocwFd/oO8FNIxvm4gMNa2PHO7GCs9Ir/1bD8YhfMWBPt46UmXNwhptleq78UN3Tm+Fvhpn+kG7dBA9oULMjunCjGJYFgRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8159
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Move the calling find_cxl_port() and the variable declaration into the
> var declaration block and remove line breaks in the declaration. There are
> no ordering issues that would require the declaration to be in middle of
> the code.
> 
> Suggested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/cdat.c |    7 ++-----
>  drivers/cxl/core/pmem.c |    3 +--
>  drivers/cxl/port.c      |   11 +++++------
>  3 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 140935511bab..1d830d088389 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -162,6 +162,7 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
>  static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  					struct xarray *dsmas_xa)
>  {
> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
>  	struct access_coordinate c;
>  	struct dsmas_entry *dent;
>  	int valid_entries = 0;
> @@ -174,8 +175,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  		return rc;
>  	}
>  
> -	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> -

This looks ok, but given the comment on patch1 where it looks like a
layering violation for this to assume that it is being called from
cxl_port_probe() context then keeping the:

        if (!cxl_root)
                return -ENODEV;


...check means this one should stay as well.

>  	if (!cxl_root->ops || !cxl_root->ops->qos_class)
>  		return -EOPNOTSUPP;
>  
> @@ -344,15 +343,13 @@ DEFINE_FREE(dpa_perf, struct list_head *, if (!list_empty(_T)) discard_dpa_perf(
>  
>  static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>  {
> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(cxlmd->endpoint);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  	LIST_HEAD(__discard);
>  	struct list_head *discard __free(dpa_perf) = &__discard;
>  	int rc;
>  
> -	struct cxl_root *cxl_root __free(put_cxl_root) =
> -		find_cxl_root(cxlmd->endpoint);
> -

Similar comment as above.

>  	/* Check that the QTG IDs are all sane between end device and root decoders */
>  	cxl_qos_match(cxl_root, &mds->ram_perf_list, discard);
>  	cxl_qos_match(cxl_root, &mds->pmem_perf_list, discard);
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index ed76d37e4fd9..976212e588bc 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -64,8 +64,7 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
>  
>  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
>  {
> -	struct cxl_root *cxl_root __free(put_cxl_root) =
> -		find_cxl_root(cxlmd->endpoint);
> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(cxlmd->endpoint);

clang-format picks the other way, I don't like futzing with line breaks
if I don't have to.

>  	struct device *dev;
>  
>  	dev = device_find_child(&cxl_root->port.dev, NULL, match_nvdimm_bridge);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index c054e7b13bdd..2bacf48593e6 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -91,6 +91,11 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  
>  static int cxl_endpoint_port_probe(struct cxl_port *port)
>  {
> +	/*
> +	 * This can't fail in practice as CXL root exit unregisters all
> +	 * descendant ports and that in turn synchronizes with cxl_port_probe()
> +	 */
> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
>  	struct cxl_endpoint_dvsec_info info = { .port = port };
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> @@ -125,12 +130,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (rc)
>  		return rc;
>  
> -	/*
> -	 * This can't fail in practice as CXL root exit unregisters all
> -	 * descendant ports and that in turn synchronizes with cxl_port_probe()
> -	 */
> -	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> -

Given the "not a slam dunk" justification for the other changes I'm
inclined to just drop this patch altogether.
