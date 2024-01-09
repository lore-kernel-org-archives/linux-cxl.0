Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202673A1AF
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OehX5ypQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704828508; x=1736364508;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pHoa2czENgLFGr/SEWsW4jaVWSNAvCqK1ZtRFVVVlds=;
  b=OehX5ypQjtxtJ45EW1Yrs++o0nKNko+AZsYFg5xJ+ld9prWPSwPa2G9T
   LPXjnFtDCb1zKWGi8IAcKXnJLiWW2RoaYQAEh1PannlFPmQNAF6ipA6Qg
   exlMk+niRETcWCJUpc7/GI9x+tFK3ogpbph5HEs5fl7Wug6Vzj//a7MZf
   Sq44mfeFHbrTTdxM6TD1SjvJ4BVivMouKqP7w5w7SHGI7uJjpbk+VwmIf
   Q+JSJ0Jt+0RX2JekPaZWiliXI2uLegiLbF55+HKgiSU7jrLNvQrW6deUE
   z/zngLDdD6p2gWPp9xsq+5kivV4a/Zq8V25gUshnVivOwMw2MP2eoMBC/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11786688"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="11786688"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 11:28:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="925372469"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="925372469"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 11:28:28 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 11:28:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 11:28:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 11:28:27 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 11:28:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gt+utQ07vNq87Yv3MvgTDUd/sVJsK+UuYh95h5OJF9Dy8lrYwUc7+Ndp/6N7xRUsu1O4rcTeic9UKV/GzXZpCJYKD3APu+TkR1rQRaZlWZeoH+ER4UagVizp9bFRGEhIiYhHgFVVvfPJjXadQqy/7YFVbD0D70VxTWV9mT0rHD8pHfdORKevjvubxP8Rq85ztTOz5v88Gr/a5VxybmUDvyN47DnVHP0HFTXcweLOKQ1y/c4C1XAd5/Wc7LPuVgs14z9qRN+oWQtt+JVZxv9XpLfrj/Cs9BBfuWaNvuMm+79RZh+3UG32l/g9SOchWcR6H/oPZSh40j71SwKFuOPcCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXQOjOiu0GCSopVzcmcs+Na0zDmEsI6rb+TgxfLahEk=;
 b=lqYOz1kyYe9dTMM+8x382Ydu8VV9YI2uu7Cr9643N2DgWdm+O8pJ8V/6f4whNLnDo4wMf3BhGLL3o1UtlqpayYPnUizDm6eE8xJBAn5kqk0XD0y+ls0vA8mYv0/fycgowpAWvglHzIWaXvtbZyVNAjYHXXiRSKPlQgb3NW0CKYx9lBaSt3tMjn7Szwdp1JWSmG15/CYkKkVRX0IlQ1tHODJp/oUMOjTO5e8VnXRAvVVwgcE+tSw/sck9cxXnA3j6VUtFsxcwT/t7RzWkle9CVZOpf+VAB2nHsTvhiguWboGw4VHKckoOzeAKJK9X+a5dXf4XYdJtGwi0PBZO0ZeijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6999.namprd11.prod.outlook.com (2603:10b6:510:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 19:28:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Tue, 9 Jan 2024
 19:28:24 +0000
Date: Tue, 9 Jan 2024 11:28:22 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>
CC: "Huang, Ying" <ying.huang@intel.com>, <linux-cxl@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v3 3/3] cxl: Add memory hotplug notifier for cxl region
Message-ID: <659d9e563e1fd_24a8294b7@dwillia2-xfh.jf.intel.com.notmuch>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
 <170441211484.3574076.5894396662836000435.stgit@djiang5-mobl3>
 <87r0is9v6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240108121538.00001369@Huawei.com>
 <38be52cf-a4ea-402c-9b14-47a80427f0c8@intel.com>
 <20240109162753.00005b2b@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240109162753.00005b2b@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:303:b9::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ddb909-786a-41d7-e359-08dc114925de
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Q9yF+7mUdNY/WYfXCQ0McKdnp3hQVh/scdfP9YdOfxFAVZsEoh8K9gX3JTIRB2PYPICXHdFW5cqCZ61AuITRBiwYpxn45Jq5QkdF/RszQyPaWTNzx/K1syQ7sscGOt8RxjtBYQ9QxdJy9RvDpOyKs1L5jK0odqIH8t0+/e7mTgM1PTkRBJNaD/CqeJm4gtaTGyy9nckYwVxnwxfEB/sfli2jhhuMXfKpKx7jLuwvS1nKb/0ScXth2rUDEjd3vkf9F9OrSJKvCnT5wT0BHmv503KKSaCJmy7YxjycNE7a911aV5HAMmcpjidhxVp9BWrN0pjYPnl7KRInB7VCBY1V3yK81pIs9rqNkrFDJrIU+GBeJ4f38AeKpkaXPMrr2l4PXyGApnLetLxHaOcxyfIVnIvy502/rJMpiLzBJB02V4u3uHx+auq1GbwQikGYspXnRA6k3jUQN63ZTfFoRGsOG8KTuNRqQJzH6N0bBq+CQZC/MI/PkiCY9EBKZvTio0Ra3HrcTDZbCrRdvZ+5VJ65THNXSVyVmf1QIOEcTG8BCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(5660300002)(86362001)(41300700001)(82960400001)(38100700002)(53546011)(6506007)(8936002)(9686003)(66556008)(66476007)(6636002)(66946007)(6512007)(8676002)(54906003)(316002)(110136005)(4326008)(6486002)(478600001)(966005)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l6XsHsOkY+IN8TxCkdR+BuUrQUnZGHEUZpzuwYVEEfUPKe40fJxR+PstSumF?=
 =?us-ascii?Q?Y0N9WXlkGhEXvdKurK7VDMCqz+pTYkU8i+hkSOzk0wtK+M+56S04NzY26UpU?=
 =?us-ascii?Q?ETOwlyq0UF1EO9L1OU5iTBFbBVjekS+yOWqZG2VHOS9vzkrG6f9pehnDWm15?=
 =?us-ascii?Q?LNN+EBqfK3ca4VfoI47vovdu0IOLpJSQHMuUi9u6MHAZ1oAdaZFKSK9NFsFm?=
 =?us-ascii?Q?1i9a/QOuZJxTuB01w7Wn+UJWXgjvT1C5FksjuRnVreDQVNaCwm/RdvuoRugj?=
 =?us-ascii?Q?cKafWGJtteka1XCIY0dwAIe9kAtDh6kn0F11A/GPs9kk0TxsnHGtEMOOFwFq?=
 =?us-ascii?Q?t77OIMiULCFGCtU42V+RHSOvYsHhifBsDxxEtNn8Z+lOqZgwIRxA3mbqXLJ3?=
 =?us-ascii?Q?iM4w29EA/RrZUwQ5Q9EdcfckGwS4jmN+pJ6CuwpcgXwfPm+wKfKMRbe9TOGS?=
 =?us-ascii?Q?lAghZEzUVyAE7LpiTSjiuXaBtoRgfiYiEppXntc588ySnqmNyK0KDej79rbc?=
 =?us-ascii?Q?s+7GP4YLVQSUdwWiUrgSCLs5mHZKSjLR1+yupKODktVRWc4Uq72oRG07Dn5p?=
 =?us-ascii?Q?KT4Iu7isNpoIreI8D15i9mwtLtNEGUndqe5R06MScLhE862bG2UjW5/89Egl?=
 =?us-ascii?Q?tFT0OieYQxxe8T+u/H07y56RdcxJezEVjtJXQ3oqULi4QcgAlzgFivBWmYKt?=
 =?us-ascii?Q?FtlQ8n4e31BZXmOtK/xO8N9yxvTqqRKeQABrxIyBC+ONFciHhyHWayBeXFV1?=
 =?us-ascii?Q?+UdIb7KiCOurirrhoPCFXmO3oRV59TYnqUDEY1ycZD1arSr8mGyhG5Jcnu7l?=
 =?us-ascii?Q?hfVwLNO/eAHctfWuDnRLeU/n1AxMh8VN4zT59q0OVsw1QLJ7t6ueyE8FWd3r?=
 =?us-ascii?Q?yGY1RYUQAC0FBw6OdjApF4k+zvFF/3r1n/5+azMXRMnWH1fy2Pua/hi8ShBC?=
 =?us-ascii?Q?9vKYocQtbfrFeyLpBzasITHUrKv4K4+CM2ozcJwzXMziIx/J0MeHT4w0fYsS?=
 =?us-ascii?Q?erxLZCLiQ05nqzq5/vBx5m6tLGZCaFY833OZoRlBg5E1ulyMJ3CQJPjkMENa?=
 =?us-ascii?Q?goNyNgMEh48gk3qXxyQ6/gDFRYrz/EznB0Oc/l+L8svLLzJ17yh30fAox4J4?=
 =?us-ascii?Q?VIUSqJgU83D9mfELERgYqlTFq0ASH9KTArNbnvwLHZOpgOqHNdJzK7W5ZZT0?=
 =?us-ascii?Q?mVcDhDi4Fj4gi0hbtN4WL/fFYlFUZacV6JFRUL8dfFr0dmNsXBDjnH6YuuUI?=
 =?us-ascii?Q?7b6ECi4aNDTFiRgHkmwzxPv+kCkEJ0qa1WGhBbUi/7hr3vqYV6Rd2DVpFu94?=
 =?us-ascii?Q?UNu1THsYWg1oFNnCo+VI73uq4ufUCUJHDKCyzsTDxpkx9ryJaGVM714FQaKe?=
 =?us-ascii?Q?j01oO//Kgju739ZTDDox9ct3X63phoQxF2wLdGPL0wP5X8HTLdVpXB27fbSn?=
 =?us-ascii?Q?6iAwSaYXi3Ye+nTNFHrCrCIUnFK0V8EJDVMpCrbllVZ3+Jl0xdgT/eiKfE7x?=
 =?us-ascii?Q?gU3QM+Zu3oKotCPEZzL8RtRJNAew9ZHRmPMD9gy16HMzVub7ypqR1/mVlN/q?=
 =?us-ascii?Q?L9xWXe6ffzV/ojzn1jGfj3gzLQ98gGF5B0o0tvkHTHh0nleLWrIOHHY7nu59?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ddb909-786a-41d7-e359-08dc114925de
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 19:28:24.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+jbmyPsshoeUqHHgZyQmbNnygHQNSvvTFl4Isg+cLJLCmRhReIcU5+Bt+61E2t48fn4XrvOWnRxUhiA01k70WsuZhz0GPmzip5eOOjffpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6999
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 8 Jan 2024 11:18:33 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > On 1/8/24 05:15, Jonathan Cameron wrote:
> > > On Mon, 08 Jan 2024 14:49:03 +0800
> > > "Huang, Ying" <ying.huang@intel.com> wrote:
> > >   
> > >> Dave Jiang <dave.jiang@intel.com> writes:
> > >>  
> > >>> When the CXL region is formed, the driver would computed the performance
> > >>> data for the region. However this data is not available at the node data
> > >>> collection that has been populated by the HMAT during kernel
> > >>> initialization. Add a memory hotplug notifier to update the performance
> > >>> data to the node hmem_attrs to expose the newly calculated region
> > >>> performance data. The CXL region is created under specific CFMWS. The
> > >>> node for the CFMWS is created during SRAT parsing by acpi_parse_cfmws().
> > >>> Additional regions may overwrite the initial data, but since this is
> > >>> for the same proximity domain it's a don't care for now.
> > >>>
> > >>> node_set_perf_attrs() symbol is exported to allow update of perf attribs
> > >>> for a node. The sysfs path of
> > >>> /sys/devices/system/node/nodeX/access0/initiators/* is created by
> > >>> ndoe_set_perf_attrs() for the various attributes where nodeX is matched
> > >>> to the proximity domain of the CXL region.  
> > > 
> > > As per discussion below.  Why is access1 not also relevant for CXL memory?
> > > (it's probably more relevant than access0 in many cases!)
> > > 
> > > For historical references, I wanted access0 to be the CPU only one, but
> > > review feedback was that access0 was already defined as 'initiator based'
> > > so we couldn't just make the 0 indexed one the case most people care about.
> > > Hence we grew access1 to cover the CPU only case which most software cares
> > > about.
> > >   
> > >>>
> > >>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >>> Cc: Rafael J. Wysocki <rafael@kernel.org>
> > >>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > >>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > >>> ---
> > >>> v3:
> > >>> - Change EXPORT_SYMBOL_NS_GPL(,CXL) to EXPORT_SYMBOL_GPL() (Jonathan)
> > >>> - use read_bandwidth as check for valid coords (Jonathan)
> > >>> - Remove setting of coord access level 1. (Jonathan)
> > >>> ---
> > >>>  drivers/base/node.c       |    1 +
> > >>>  drivers/cxl/core/region.c |   42 ++++++++++++++++++++++++++++++++++++++++++
> > >>>  drivers/cxl/cxl.h         |    3 +++
> > >>>  3 files changed, 46 insertions(+)
> > >>>
> > >>> diff --git a/drivers/base/node.c b/drivers/base/node.c
> > >>> index cb2b6cc7f6e6..48e5cb292765 100644
> > >>> --- a/drivers/base/node.c
> > >>> +++ b/drivers/base/node.c
> > >>> @@ -215,6 +215,7 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
> > >>>  		}
> > >>>  	}
> > >>>  }
> > >>> +EXPORT_SYMBOL_GPL(node_set_perf_attrs);
> > >>>  
> > >>>  /**
> > >>>   * struct node_cache_info - Internal tracking for memory node caches
> > >>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > >>> index d28d24524d41..bee65f535d6c 100644
> > >>> --- a/drivers/cxl/core/region.c
> > >>> +++ b/drivers/cxl/core/region.c
> > >>> @@ -4,6 +4,7 @@
> > >>>  #include <linux/genalloc.h>
> > >>>  #include <linux/device.h>
> > >>>  #include <linux/module.h>
> > >>> +#include <linux/memory.h>
> > >>>  #include <linux/slab.h>
> > >>>  #include <linux/uuid.h>
> > >>>  #include <linux/sort.h>
> > >>> @@ -2972,6 +2973,42 @@ static int is_system_ram(struct resource *res, void *arg)
> > >>>  	return 1;
> > >>>  }
> > >>>  
> > >>> +static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
> > >>> +					  unsigned long action, void *arg)
> > >>> +{
> > >>> +	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
> > >>> +					       memory_notifier);
> > >>> +	struct cxl_region_params *p = &cxlr->params;
> > >>> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
> > >>> +	struct cxl_decoder *cxld = &cxled->cxld;
> > >>> +	struct memory_notify *mnb = arg;
> > >>> +	int nid = mnb->status_change_nid;
> > >>> +	int region_nid;
> > >>> +
> > >>> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
> > >>> +		return NOTIFY_DONE;
> > >>> +
> > >>> +	region_nid = phys_to_target_node(cxld->hpa_range.start);
> > >>> +	if (nid != region_nid)
> > >>> +		return NOTIFY_DONE;
> > >>> +
> > >>> +	/* Don't set if there's no coordinate information */
> > >>> +	if (!cxlr->coord.write_bandwidth)
> > >>> +		return NOTIFY_DONE;    
> > >>
> > >> Although you said you will use "read_bandwidth" in changelog, you
> > >> actually didn't do that.
> > >>  
> > >>> +
> > >>> +	node_set_perf_attrs(nid, &cxlr->coord, 0);
> > >>> +	node_set_perf_attrs(nid, &cxlr->coord, 1);    
> > >>
> > >> And this.
> > >>
> > >> But I don't think it's good to remove access level 1.  According to
> > >> commit b9fffe47212c ("node: Add access1 class to represent CPU to memory
> > >> characteristics").  Access level 1 is for performance from CPU to
> > >> memory.  So, we should keep access level 1.  For CXL memory device,
> > >> access level 0 and access level 1 should be equivalent.  Will the code
> > >> be used for something like GPU connected via CXL?  Where the access
> > >> level 0 may be for the performance from GPU to the memory.
> > >>  
> > > I disagree. They are no more equivalent than they are on any other complex system.
> > > 
> > > e.g. A CXL root port being described using generic Port infrastructure may be
> > > on a different die (IO dies are a common architecture) in the package
> > > than the CPU cores and that IO die may well have generic initiators that
> > > are much nearer than the CPU cores.
> > > 
> > > In those cases access0 will cover initators on the IO die but access1 will
> > > cover the nearest CPU cores (initiators).
> > > 
> > > Both should arguably be there for CXL memory as both are as relevant as
> > > they are for any other memory.
> > > 
> > > If / when we get some GPUs etc on CXL that are initiators this will all
> > > get a lot more fun but for now we can kick that into the long grass.  
> > 
> > 
> > With the current way of storing HMAT targets information, only the
> > best performance data is stored (access0). The existing HMAT handling
> > code also sets the access1 if the associated initiator node contains
> > a CPU for conventional memory. The current calculated full CXL path
> > is the access0 data. I think what's missing is the check to see if
> > the associated initiator node is also a CPU node and sets access1
> > conditionally based on that. Maybe if that conditional gets added
> > then that is ok for what we have now?
> 
> You also need the access1 initiators to be figured out (nearest
> one that has a CPU) - so two separate sets of calculations.
> Could short cut the maths if they happen to be the same node of
> course.

Where is "access1" coming from? The generic port is the only performance
profile that is being calculated by the CDAT code and there is no other
initiator.

Now if "access1" is a convention of "that's the CPU" then we should skip
emitting access0 altogether and reserve that for some future accelerator
case that can define a better access profile talking to its own local
memory.  Otherwise having access0 and access1 when the only initiator is
the generic port (which includes all CPUs attached to that generic port)
does not resolve for me.

> > If/When the non-CPU initiators shows up for CXL, we'll need to change
> > the way to store the initiator to generic target table data and how
> > we calculate and setup access0 vs access1. Maybe that can be done as
> > a later iteration?
> 
> I'm not that bothered yet about CXL initiators - the issue today
> is ones on a different node the host side of the root ports.
> 
> For giggles the NVIDIA Grace proposals for how they manage their
> GPU partitioning will create a bunch of GI nodes that may well
> be nearer to the CXL ports - I've no idea!
> https://lore.kernel.org/qemu-devel/20231225045603.7654-1-ankita@nvidia.com/

It seems sad that we, as an industry, went through all this trouble to
define an enumerable CXL bus only to fall back to ACPI for enumeration.

The Linux reaction to CFMWS takes a "Linux likely needs *at least* this many
memory target nodes considered at the beginning of time", with a "circle
back to the dynamic node creation problem later if it proves to be
insufficient". The NVIDIA proposal appears to be crossing that
threshold, and I will go invite them to do the work to dynamically
enumerate initiators into the Linux tracking structures.

As for where this leaves this patchset, it is clear from this
conversation that v6.9 is a better target for clarifying this NUMA
information, but I think it is ok to move ahead with the base CDAT
parsing for v6.8 (the bits that are already exposed to linux-next). Any
objections?
