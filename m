Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5952D059
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYiPEmyW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704492443; x=1736028443;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YzMrcLBA/7PHLIPsmkItN5rU0oTN7oJ+EzCKHSCTq68=;
  b=dYiPEmyWbLkC7ia0BTRs6x1sMTTxnaCEIwDZ/ahjPU/+iFFMBIs3BR+G
   XYEqI6bYCVeaS+UwS/WIGNPaUmQ611brXiiDw/vbtyrbvQlJcwOMp+NJO
   yCVqzSh0xBWXd4tNL09bEnUbDFyc6q2IQxKcydaEk2bRvfkE7LmSAEayU
   nPYqm5VhSC8iifGYDA986TJr+aRsuhrX85ES2Bh2B7tP7H1BmVrKULhJt
   ZCP1e/MaK9+f05tfLWnsJOnu6sPLN7RK+rvH8WvZjYjWjbB+zX+WR+oP9
   sP3d/FUP6LlVUU3Sp1hgtmSK5WKcqZEIgmCPSsJiaiyAEPsYgV6//8RPG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="463996062"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="463996062"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 14:00:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="871337363"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="871337363"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 14:00:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 14:00:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 14:00:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 14:00:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSWsEwdaTjjpnj8NhUbr8lYlr/8LapeDyRxKTSbuPbx0t4Czr4rIZOHMfZwmS+4vkAF64+4JOAoLwqJ0CwTODRZcl1r4v97ckKdqdtY2tnPygK3WY+GW/fuFeDRj6yIltyyIY4RHOfqKmdJzDwCcARNk5BUqGtsYkLeC1gHNOUzZmCyfE79/eLNptxlXQCKS9mp8EVy1O2IOOfrGGiu3iO/sf09KCQodkNL4sJiv6NaocAnzGvC9/cCIJj7o/ZuU+oYCryC50rwVw7pfWKuzTg077ipaaFQdRIUNLB9Hs7G2blCh+Fg7iS5YNKoL5pZnEteVyxqwKbAqGqre+0MRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4bAexT1WCmo4Bw+CHyWvrJCdT+Ukbs5SniBhAGfoRQ=;
 b=kRSp4dzdJmEKwwX2Byi2Vb3wZ/F99todou7bK6sLvNee+dMdJzzU0KFvU5o7JM9AtkYL3iqFmdQfFn552T4WfSJ8n0xlOw3wpGwl3oejkVuxLbQUgw0nCmm3U8lPYAfA3pOWT0AeAP+iDuMgPkjoD5eCiNv7EG0gUhSGWbxjlotCA4KYYWcAgzd6tjPl2Ae8f9sXzL/qAzvxDBr1Cw0IA3Z+tKWaxPsnbyOWYd4PEhG787/L/vUBsIcsqZHin3TBGGE6+NrMxl8y6aA+HvqddS0lO/3EzPlTO/nx6RK0I/qQ37jbR4c7IHAhr09/EpvTkHZzNC/RWOmjUOTzLjG44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7040.namprd11.prod.outlook.com (2603:10b6:806:2b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Fri, 5 Jan
 2024 22:00:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 22:00:17 +0000
Date: Fri, 5 Jan 2024 14:00:14 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, "Huang, Ying" <ying.huang@intel.com>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH v3 3/3] cxl: Add memory hotplug notifier for cxl region
Message-ID: <65987bee887f2_127da229465@dwillia2-xfh.jf.intel.com.notmuch>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
 <170441211484.3574076.5894396662836000435.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170441211484.3574076.5894396662836000435.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR04CA0372.namprd04.prod.outlook.com
 (2603:10b6:303:81::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 5369a14c-8bba-4d1d-125f-08dc0e39b3f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wgo8B8lSY3QkALyRKAOsRmEBEkf/HyAOOhZrQBndb+p7X6+KaLU/ROtPLdOlry9Sww+rpPnBM9a8rpntBlwecAs1W9e1Q91jxFusdywYiZlxSSHIH3VogxHke0VabYhiRjOeCLdyiUVBO55z5AtUcZQXTJKIx9vvMwJ8JDWnvl7MUCxuJAQnpN1Mr687TpVtqP7G6buptLFtAbLn4QvWnYO6iQcYIQUd4w6izgUu6guRA5Aust797IuSbu5g8j3QJLRsLDvvYzY5simfR385DEEPC9XlYXYlDjMSar54a9Nqvf8u4kA9QVBWZW83hHXqF0xv7/p3ysKaVYYsZ+9DFiF0SUBVULWezFmWG+cnz+irBHUtVAsiGN0Ay7zUTGE3WxrMYjWlBYaYcitTW5Gk+cq2YErRtb7E9JAxsG8wEcznI4uqMVxJujQMK5szpmWorPUu0Ouw9kpa6Kcj4RVZIlPa0siUYXEr7krzfRvaOv0GaBYqL72Y2Hot3I5tzb+k1eTLUgstZgyCeo6x+2zvVecxhFyjieDpl74EwDAXlXO/uhCvU6sCR6yqKDNmy8AE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(38100700002)(5660300002)(478600001)(82960400001)(26005)(6486002)(66556008)(66476007)(66946007)(83380400001)(41300700001)(9686003)(86362001)(6506007)(6512007)(8936002)(6666004)(8676002)(4326008)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oHCRl2U/5KOO0uyWet+R8rywkPtBcvgKgfv3IBj9RPBGkkoHM2bMepwCoGaG?=
 =?us-ascii?Q?3TxwwfdMBfWDWNIYBz/bzNmBddDrLqvGJjPim5QlJYWblCH3JQnc2HmKGVkf?=
 =?us-ascii?Q?ZgKcxiljukCTnL6RdyNK6bvf7cuIn9vlXSa/daKYQmICJ0OGEgplUPWjFcwU?=
 =?us-ascii?Q?daefdhjZLmqMLhUmqRJ/SReoyLdm4HIz1n7Af0Db1XPr01T3aQfT/3YyyuN1?=
 =?us-ascii?Q?4gNqE+FMudq1/+15+YDZOK8bSuKYaWh6jcOcE0TWqaCz016pDyNIVCo4WUjh?=
 =?us-ascii?Q?EcqIBrKRsLOCAe/iNVSUI00Yts/MkgPka4WTUOkxs6TSp44cqpgDzbvzM7Ia?=
 =?us-ascii?Q?Ig1cvBdlVUJsfV5VeNuowlB0D9YcCMcXJ5nUR1Lna06PnW/A6a9CCfMFHe55?=
 =?us-ascii?Q?+QgPz+ygaOVLfz6no6tzhydli4ynMvEM75/3L+DyOmq9cx+2LzjLWJZhUS3d?=
 =?us-ascii?Q?8svtXKKu0TiK67EqBDacHtx3w/SR2ssVHxtqiO+rnVJPfdcka+TmmEvkTQ78?=
 =?us-ascii?Q?likBkiTrnRTUnvujpx3o0iozECUhCbeul07zZ5b1RGscXYj/7yUaqS1FNsSm?=
 =?us-ascii?Q?Vfs+VOwNZZQcOmqs0uU9JRX1FGNHj8Xq8dZbga3sNry8OJ2OT33HMiQIiHFO?=
 =?us-ascii?Q?8My44VpvgSpY9/dgMXkbKJRfIZxn1oHHkW4GTrMjYWgkOFAE1ms6vP8urpdf?=
 =?us-ascii?Q?dl7Fj4XitX5Sq6yOG4x3SDudAEGtAm93ebN4RTxiE1eQY8VnLdtqQjrLiVhB?=
 =?us-ascii?Q?heU2UKmP7Hv9MPh34w30UiyOzFUgpKOhrA+42VHfldGkORvSt7p+oWgV2pmT?=
 =?us-ascii?Q?pGjmcok/2yo4r0yvOYNeToh6e7DhbdJsgg+crF+akVWbWm+38OPYzDIgicRb?=
 =?us-ascii?Q?2FdgCGq8MTs9K/RLlyi7XdTmYEv2qNzmyVyQhNs5M0EULxIpjMGnXVmIZWX9?=
 =?us-ascii?Q?bxdz8M6bwLUgemKWRfc/dXJ2rAGarosHyypHCWDulz4zUqgWfNPRTFK2dMkz?=
 =?us-ascii?Q?cr+N74+dMqtowdd9+0U2+ugFbGrTN6Fc05c/+jF0XQf/pDpQL3iZ5IXGfF0W?=
 =?us-ascii?Q?BwIZWrnEHWukxV+tRPpp0WQYkbVDlF3QtHTI3vRJJFABZokoaTehM7xitd0N?=
 =?us-ascii?Q?8/lFTxZMDRSRyy47KEOf+5lsb1M9LbsWzbY1/1u2AtEYPJ2OA58k1+QR9lYj?=
 =?us-ascii?Q?1CdS51kNu/uLLrx6RGK/+v4Tvr1JJhqCOBqSr8ZypxjlOeHS8pI+uzjcJLZ8?=
 =?us-ascii?Q?JaM2UVzBFKJrFV2vZ6SqjXdjLXgqGPC6bvs+/Bm2Qh9C49lMxfHYNqkutE2U?=
 =?us-ascii?Q?YnV5YP9PalKBSywzcAYUCNfchPGCXSzjoOw/B2C3xDnSZOYIlQVHAVe9PUUg?=
 =?us-ascii?Q?3A3jz3PgqES14pIEka38DVz4eAPRfQwwJ1bYuXMKp1AYucLuE4AkyJoruI1y?=
 =?us-ascii?Q?OF9Z+u4OQNSWa9oMk6Oy40R3RH4Cwly/Aa8iXp59y9/65U/pH2EJGJi2qXLL?=
 =?us-ascii?Q?Epc0dJzHH/+k7gBIn0iAdtFKhpZ46I/fOVWdMBPPCzP3JNV3Li8FMgu8ONYE?=
 =?us-ascii?Q?uilL/klwfpCndpDxkCD/yaAoIWnTQE3X4vcCEaCDJf4teejcZsk34IK8t91J?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5369a14c-8bba-4d1d-125f-08dc0e39b3f2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 22:00:17.7505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqTlSm+VFbVZMnbLj1RlTxx8VQzPUmjiHLYpYAuJjDcXmkdEcgor1nH6ZniC4FFV+FUUdfSurxRPFn0qm+ntEUlUnRoksihirawqeO1+xBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7040
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> When the CXL region is formed, the driver would computed the performance
> data for the region. However this data is not available at the node data
> collection that has been populated by the HMAT during kernel
> initialization. Add a memory hotplug notifier to update the performance
> data to the node hmem_attrs to expose the newly calculated region
> performance data. The CXL region is created under specific CFMWS. The
> node for the CFMWS is created during SRAT parsing by acpi_parse_cfmws().
> Additional regions may overwrite the initial data, but since this is
> for the same proximity domain it's a don't care for now.
> 
> node_set_perf_attrs() symbol is exported to allow update of perf attribs
> for a node. The sysfs path of
> /sys/devices/system/node/nodeX/access0/initiators/* is created by
> ndoe_set_perf_attrs() for the various attributes where nodeX is matched
> to the proximity domain of the CXL region.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Change EXPORT_SYMBOL_NS_GPL(,CXL) to EXPORT_SYMBOL_GPL() (Jonathan)
> - use read_bandwidth as check for valid coords (Jonathan)
> - Remove setting of coord access level 1. (Jonathan)
> ---
>  drivers/base/node.c       |    1 +
>  drivers/cxl/core/region.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |    3 +++
>  3 files changed, 46 insertions(+)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index cb2b6cc7f6e6..48e5cb292765 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>  		}
>  	}
>  }
> +EXPORT_SYMBOL_GPL(node_set_perf_attrs);
>  
>  /**
>   * struct node_cache_info - Internal tracking for memory node caches
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d28d24524d41..bee65f535d6c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4,6 +4,7 @@
>  #include <linux/genalloc.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/memory.h>
>  #include <linux/slab.h>
>  #include <linux/uuid.h>
>  #include <linux/sort.h>
> @@ -2972,6 +2973,42 @@ static int is_system_ram(struct resource *res, void *arg)
>  	return 1;
>  }
>  
> +static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
> +					  unsigned long action, void *arg)
> +{
> +	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
> +					       memory_notifier);
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct memory_notify *mnb = arg;
> +	int nid = mnb->status_change_nid;
> +	int region_nid;
> +
> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
> +		return NOTIFY_DONE;
> +
> +	region_nid = phys_to_target_node(cxld->hpa_range.start);
> +	if (nid != region_nid)
> +		return NOTIFY_DONE;
> +
> +	/* Don't set if there's no coordinate information */
> +	if (!cxlr->coord.write_bandwidth)
> +		return NOTIFY_DONE;
> +
> +	node_set_perf_attrs(nid, &cxlr->coord, 0);
> +	node_set_perf_attrs(nid, &cxlr->coord, 1);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static void remove_coord_notifier(void *data)
> +{
> +	struct cxl_region *cxlr = data;
> +
> +	unregister_memory_notifier(&cxlr->memory_notifier);
> +}
> +
>  static int cxl_region_probe(struct device *dev)
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -2997,6 +3034,11 @@ static int cxl_region_probe(struct device *dev)
>  		goto out;
>  	}
>  
> +	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
> +	cxlr->memory_notifier.priority = HMAT_CALLBACK_PRI;

Something minor for later but it is odd to have an ACPI'ism like "HMAT"
in region.c. It is even more odd to have it in include/linux/memory.h.
That really wants to be "HMEM" or "HMEM_REPORTING" since the platform or
driver code that wants to update performance details on memory-hotplug
need not be ACPI code and in fact this new CXL callback is the first
instance that proves that.

Otherwise, this patch looks good.

> +	register_memory_notifier(&cxlr->memory_notifier);
> +	rc = devm_add_action_or_reset(&cxlr->dev, remove_coord_notifier, cxlr);
> +
>  	/*
>  	 * From this point on any path that changes the region's state away from
>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 4639d0d6ef54..2498086c8edc 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -6,6 +6,7 @@
>  
>  #include <linux/libnvdimm.h>
>  #include <linux/bitfield.h>
> +#include <linux/notifier.h>
>  #include <linux/bitops.h>
>  #include <linux/log2.h>
>  #include <linux/node.h>
> @@ -520,6 +521,7 @@ struct cxl_region_params {
>   * @flags: Region state flags
>   * @params: active + config params for the region
>   * @coord: QoS access coordinates for the region
> + * @memory_notifier: notifier for setting the access coordinates to node
>   */
>  struct cxl_region {
>  	struct device dev;
> @@ -531,6 +533,7 @@ struct cxl_region {
>  	unsigned long flags;
>  	struct cxl_region_params params;
>  	struct access_coordinate coord;
> +	struct notifier_block memory_notifier;
>  };
>  
>  struct cxl_nvdimm_bridge {
> 
> 


