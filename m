Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gK4o/2+B"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC7DD0
	for <linux-cxl@vger.kernel.org>; Mon, 11 Dec 2023 16:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702341019; x=1733877019;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rl5ljX0Nwr9p+SccN3QS9sYGmZbWw1uRNZ5WrfifT9A=;
  b=gK4o/2+BtjrxE3zkz9Egy0M6y7bKs4yVl0VgyQxCTzEp4ow4SgQlsbjr
   0fGRlKXkmo+3P38R3+ACzk0S4a/A6OKEhAAslGizmTLL3u7Im9oQ3mZW3
   s1YcSFJrvqCYMf9Rl4mjlLM9jcXSszgWTVv9HrNX+UhM1hxdCRKS2OEzT
   07xA37gxE0rdvP5y42qw5DiHo0ecuYK3YuJn5+7ZjaUVxGOBVrFxNdJlS
   v6ThUegoUgzAQzkX3pPKK1cc/pADdcqSeMXcFVywjGE5pH8vkV5Jdaip6
   x3uu4urHSwOIdSL5Y3FGxSWi9ljbatir0rq4VTAMxilPJVY13tb/4/eIC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480929128"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="480929128"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 16:30:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="843702733"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="843702733"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 16:30:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 16:30:15 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 16:30:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 16:30:15 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 16:30:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/bqB/ai6FyH1kGDDUzjaRytwPUVkfGzkaZ6F5wq9cC42Xv+W7zcpjynrqq0vl15vqk6Me4m5XgaODusy4e0KVYa6at73CNoTfnPCPBCS4gdP75KisQqUdwbdmi3cde1JhrHB1PHv/r91RCIXiQSp7+r/pUMZ1+ZS/7F4pyq/MxB1ne3rm46dQanEf+qLbHk3v0yd4TilgeXZ33xTZnax+fWrQ8PLl1lGBT+D1VSdbWWAiO70+vVENH/8rJdmVtzGSERfAefVx3OsJurA/8fWsgb4QeramwZED2VTzG8eCccgc0wVWa5RI5q3Lm25GKOp6C2LVPeF8+atniEqWtjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aySnwjAMfqBflxT9BPXshYky0gj9omOxzf4kKW4dWE=;
 b=C61i1Ns87wv6NzRmmJPgJWFhW5kwkT1SZHvKdepXxl4ac/42jFfRAMLJ+38GjIq7JrQEHUDiHsh5mmHAHN4ZuyonpRLaN2VJugUj3sUEQ8rr3gdrteSmp7CKSpXUZGZaLzotwLmzxyVFYSKd/TzQib1GFAEH0DAj3+S5JqnK+hujZd9ZAXvgdL7pv/cSd0WuaQDyfANpKECYWmtWGeXzmoI4enZnUukGp+T66CAUnvAaozftXP21dPUhkLygHnnsV9fEgti6+ouDXaDyqsYcDs946NAFEgBeXlgHWOK7uhlRUvR/Z067m82QBW8KQ+EtqYQc01zb/dZiT02yxcEhkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 00:30:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 00:30:06 +0000
Date: Mon, 11 Dec 2023 16:30:02 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<jonathan.cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH 3/3] cxl: Add memory hotplug notifier for cxl region
Message-ID: <6577a98a59529_a04c52942f@dwillia2-xfh.jf.intel.com.notmuch>
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
 <170199192262.3543815.6979022920061286874.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170199192262.3543815.6979022920061286874.stgit@djiang5-mobl3>
X-ClientProxiedBy: MWH0EPF00056D02.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:f) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ec3184-9698-417e-8f94-08dbfaa97cae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOB9HB6ITeVEto/FpQaR7OxDwLDGQdMfO+PSLbPdukO5dC5EJQ1DvIu6hYICCJzc6qwhfHgmS4qpOa4XtVyYUZqPGS9mPWuYSAxakGnJsm3o5pljmoCXL9o8Akj/+Tte2yBKwF1iOlxu+IgqNwUfRug9ayhLMWEo4OHleG2VYyPGrTxx8EnBnKx5KbG8XFRCNkMVgdUAE9cyeNlSXBnoX/6LM9G7zB0HrAepxxg4d9PMLGkxE7chAGU9y9KQ2Kdp179X4RPIb1PQGRBetzLP7zIQDsItie3uGGcogwuYTrwdOI5UFBbEm7qvRfZrtuwwEmllcacn6vWtge+u0jrtyWAZYkjdOkIEFspdeLNd9031CzYWfgCQCqSJ6kSR5qjF/GuTmN5i/OWYb908Jj1oB2QYZ5QNvEnqIkv/moVt8mRMoTLZXSeXVCFUkMW/Lfoi5Yn1A30nqMmChc0ZJeLwo8wg1nX9p/wC1W2gxmFw0zM1V4tGqSAcnxrB14BrauJAWYh3ufP4R36NGOsFoP1FALfa5rNu6UVjq1vpbvxWbGJG6FIpUMDGych1NaTnse3o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(82960400001)(86362001)(38100700002)(83380400001)(5660300002)(316002)(6666004)(6506007)(9686003)(6512007)(66556008)(66946007)(8936002)(8676002)(6486002)(66476007)(54906003)(4326008)(41300700001)(2906002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VVmZDCxIZ5fgyLw80IIb+tD84Ew1NpPNQsOkeKs3IBtN5QSdcVbcAgqjYF8Y?=
 =?us-ascii?Q?5Ve6S7foZbb8VjtOfbLwjcGTP75b24AjFCIGUHYn+CEN+9ChicbXV9oOuYN8?=
 =?us-ascii?Q?2Fq41FpeOnVrRiGUh1XJnEt5PQIP5NIx20x6922ua17z9ifDoelfiZcXVPG8?=
 =?us-ascii?Q?aZDLDYMTqnY8UPLzJXOoX8W7RxROC9XwMll52//tKJ81TttrG00oK4DceJxW?=
 =?us-ascii?Q?d8TlfwmyklbxKPYxxo0s4GplQiFWQgiY3pRcT2e9Eh2JR7wwghhSevcZyVMm?=
 =?us-ascii?Q?OHStbn6NQ/dWcikRDlonjailLpy1BBkFEY1FYH/R3ap4M2/rj+EnvTfxMQeQ?=
 =?us-ascii?Q?Ip55NIHr+LP5Tsmu90GMlnMhV22kTkSBjzePEg64qUlLVkC7USDJ/5XSnuZG?=
 =?us-ascii?Q?x83cqcsmvXBg5X00HTK1Y1Izvw9UaMLSXeC/CR5fUo2mLCtrTv5b8YOOsl5d?=
 =?us-ascii?Q?0JcpVHZuXBTQhotwYiJsUKeezBTqfXf2LOQoaMuc76xai4uPLQSD2DaKT4HT?=
 =?us-ascii?Q?4X10XLarEz06Ej450pQmxMwU4/M4pgXDpAn3UWnw5ltH1+xeT2QEtbkYKNMH?=
 =?us-ascii?Q?vQpFSLv9IDHpFMhz8jEpJb5DFEqXHqrRtYx4sSgWalpyQoxAlkWFaBdkPjiZ?=
 =?us-ascii?Q?qBgAFOnsBDzCcjoHJZZu1EKeYSIwBDKF693ci+KLZFGGqhzMIPIl9tCBfWSi?=
 =?us-ascii?Q?jGTtG3n4YmsCF9x9wwTVLuaq2C39OoKPGLCqUPwSyJAU5ov0eJiqN8bhA4Y9?=
 =?us-ascii?Q?9OesKjKJqv8WMMPDoO94Lzn7+MP+kdLBaF6+UhR3dpty+EBCoijnF8xQJxCF?=
 =?us-ascii?Q?k5+m4/6VjsyvKE1ZLC9RhpJQkM77vjuk4qmX76CbDz6+ejEzIz9LEpTNdQOM?=
 =?us-ascii?Q?wO00fDY688jSzKhRUaJd+ZO+dc58dbWqzy9omNfYfOY7z1Nq4nxWYa6e9Auf?=
 =?us-ascii?Q?ZBqWmOV5V2g8732F+RtBwrTpqi1+z6t2gZMD6BSZMYvVZ7qn0eIFAtj4rsXU?=
 =?us-ascii?Q?kmqYjEudW4gk55A62TlNTaNEHN1fq/oyoIVTtyLWVy+mPzlXGIqy/50Q3h9o?=
 =?us-ascii?Q?sRaECS+PpJjCkJ5tEQ4G71rhyJIpBoLwlQgP8X0NK0TGIaQHBllV6VYCUkju?=
 =?us-ascii?Q?fvRy1EgFwu+ek2tmz+H04H5FOhfIEIm4V7UD0uVqTzDHEQzY5LzapzsD3mDQ?=
 =?us-ascii?Q?N2oOThyjZ2hv+uISuofNbWhyBaLlZnv/qK/LvrCip8lWSkKlBBHBL3YpZFn0?=
 =?us-ascii?Q?8HBmaxuZv+tcf+Ua8ONwfWjE2UtGzNPk29Z87EFG7xXly+7/8QbchCJTpA4x?=
 =?us-ascii?Q?X2Z/e+ni4Z/R59KTDpKPXI+tmKFatGSnyfvmrP3A7MqL3XTZTiRWP7FC4Vap?=
 =?us-ascii?Q?uEhXdW1SrVnYOGacHSovBLTMR+BksHs1/l0gYJmHg0RGbXu+1VfWraNa7tKR?=
 =?us-ascii?Q?mVHYwSSg732+RUf83X2+Oi3cySRH4cf/Hmuq7K+yl5FVfD2kkmIKBBK/a7qu?=
 =?us-ascii?Q?gtbzdH24QssHtqyRELs5aFDWcbaktEB3WH4YveAgiaVZgXPrbcFRzm+nM8/Z?=
 =?us-ascii?Q?zOJeI4PmaaxRxGX16LOBFYSLuI9U4ygeWc2q1yHd3Y3LgdE9LdRPHmadwQ0t?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ec3184-9698-417e-8f94-08dbfaa97cae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 00:30:06.4869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5PfgZdw+Ofa54EJSEuPYvSSwHOKDyGG0a6hRrmhbuTWHZl2/nUJ3NPgea4V6FA63ehxuJkTprh6ivDfHxMzBLqukpRakkeQHiNZdMyDXoJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7444
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> When the CXL region is formed, the driver would computed the performance
> data for the region. However this data is not available at the node data
> collection that has been populated by the HMAT during kernel
> initialization. Add a memory hotplug notifier to update the performance
> data to the node hmem_attrs to expose the newly calculated region
> performance data. The CXL region is created under specific CFMWS. The
> node for the CFMWS is created during SRAT parsing by acpi_parse_cfmws().
> The notifier will run once only and turn itself off after the initial
> run. Additional regions may overwrite the initial data, but since this is
> for the same poximity domain it's a don't care for now.
> 
> node_set_perf_attrs() is exported to allow update of perf attribs for a
> node. Given that only CXL is using this, export only to CXL namespace.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/base/node.c       |    1 +
>  drivers/cxl/core/region.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |    2 ++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index cb2b6cc7f6e6..f5b5a3f11894 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>  		}
>  	}
>  }
> +EXPORT_SYMBOL_NS_GPL(node_set_perf_attrs, CXL);
>  
>  /**
>   * struct node_cache_info - Internal tracking for memory node caches
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 72c47f624d63..3794e91e12b1 100644
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
> @@ -2958,6 +2959,37 @@ static int is_system_ram(struct resource *res, void *arg)
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
> +	struct access_coordinate coord;
> +	int region_nid;
> +
> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE || !cxlr->coord)
> +		return NOTIFY_STOP;

Shouldn't this be NOTIFY_DONE? NOTIFY_STOP prevents other callbacks on
the same chain from getting notified.

> +
> +	region_nid = phys_to_target_node(cxld->hpa_range.start);
> +	if (nid != region_nid)
> +		return NOTIFY_STOP;

NOTIFY_DONE?

> +
> +	/* Adjust latencies from psec to nsec to be consistent with HMAT targets */
> +	coord = *cxlr->coord;
> +	coord.read_latency = DIV_ROUND_UP(coord.read_latency, 1000);
> +	coord.write_latency = DIV_ROUND_UP(coord.write_latency, 1000);
> +
> +	node_set_perf_attrs(nid, &coord, 0);
> +	node_set_perf_attrs(nid, &coord, 1);
> +
> +	return NOTIFY_STOP;

This should be NOTIFY_OK, right?

> +}
> +
>  static int cxl_region_perf_data_calculate(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> @@ -3077,6 +3109,10 @@ static int cxl_region_probe(struct device *dev)
>  
>  	cxl_region_perf_data_calculate(cxlr);
>  
> +	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
> +	cxlr->memory_notifier.priority = HMAT_CALLBACK_PRI;
> +	register_memory_notifier(&cxlr->memory_notifier);
> +
>  	/*
>  	 * From this point on any path that changes the region's state away from
>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> @@ -3108,9 +3144,17 @@ static int cxl_region_probe(struct device *dev)
>  	}
>  }
>  
> +static void cxl_region_remove(struct device *dev)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +
> +	unregister_memory_notifier(&cxlr->memory_notifier);
> +}
> +
>  static struct cxl_driver cxl_region_driver = {
>  	.name = "cxl_region",
>  	.probe = cxl_region_probe,
> +	.remove = cxl_region_remove,

Keep the region driver from needing a remove() callback by using a
devm_add_action_or_reset() after the notifier registration.
