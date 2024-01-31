Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E74C1E862
	for <linux-cxl@vger.kernel.org>; Wed, 31 Jan 2024 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691387; cv=fail; b=hIOvwLbVNOByOOsi2F8n4eIl8Nb+w8Cb043WYhcL6YBhrYQvy1CNAna8fFc47YcVj4Je1nlVsj5X9sHtDYwq2TbyDwPQ8n1yK529juFh5FV2X5KQ+HEFPutufGOEArj/rTW+5c2TFkrNtNd3+xgKFT1FpdljjKvcRQop/7rH0sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691387; c=relaxed/simple;
	bh=xnwioYzn4G0L7kQ8b7nYanIQOwCcJ34NgT8sgCwI/no=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tOerCJlyWeO+UEoUPFwHBm390mO6ub/xiqjZF4acA7ZADEgUeuoV1gNLzDUMnkje0QRsfpfYP5jOijrUZTMXKcTMOr/dZIUqTbMftCbxnx2CFCkeDg1dnfu7db+BzKzwnLmvNF+7z1dp9IFwiZWB+FdCbMNULcsh7QuhuFfkimU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a01Q+nu1; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a01Q+nu1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706691386; x=1738227386;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xnwioYzn4G0L7kQ8b7nYanIQOwCcJ34NgT8sgCwI/no=;
  b=a01Q+nu1wDxD97AjfWlQk7ZQc+70kv6qwkYgMFmQepqF+HqmCxQXnRSI
   6w2rXMHUFu+rr7+rQC7L9anIOpMCGGvUeVOnTYnnM9E8cPz4JzSIR978w
   ZZg0HokuzkdN3lKo1wk4t7LxK3WJ8dC6QuT5ZNYSW9RGykZw/UTbdF8MY
   lpQQSyulw+EzPqogsovitc5rqddcYpDh0zowahKR0uTA4ztJ3A75P+QGh
   YaD2DVplQUgvjVbUitMoIBX6SNDwJW1YcuGsFO+Tj+j3U+0LJySPgfDYD
   ZDFKexG+urWYR18JAxO8gzOoG7F6l2QvOhlD8m0HUNwConI6WqZ7ARmoW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3389963"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3389963"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:56:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822493947"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="822493947"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 00:56:23 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 00:56:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 00:56:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 00:56:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDa7HeuIC4+41N471isXDWLLZXwPXkSzwEWyL6PuHpEKR+cpBJInraq0KaWE9hEzhbFfTvztv3Pij4iPOP1S02g1V0W4UdIeq6I26XE4K05RRftPTJ3WqG/sSsgIXJjGNuEmdpIDwmIYJMCijLUt05L+0kVlMMphDyuYPypJ6z05szMeYGAhV6qvPgjUIjyvmBYooYTJINH7qSjKx0YRjbkj0WycBmQ9JUNXKp57nm8dcyov3d1QN0n8PYAr7lY7tZJiAMtiIJwgHE8LDFwSkzdfYyiFo09eZHHuA6p5uUd/PgLt0/bEIaGlJUPdfOTO1HkFBivHVjRrrMry5JYaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipmRIETIXFIDMbgGOMuQTo2cYeavGU+kmQdMLTd8cxE=;
 b=Or3HfYKEG+lPjv/gQkC6ZnBOtEMn4uxDXvNK83sHnt50shd3cw0Fo+aspyo5sUhg+KivVvyCzpeCpP+i5RUDhQV5nBmsw+JQyPQ/fxVXU6h7xztPHbE2+VXDMET8lZWWEznDWW1VuHREXRYoKZGRcDYyKwLwAtioR4kTzFAmRpSqFffIQCVYEoST1RIxtBfwkV3+Sw2XtJ+NPyxlg2lt90rp6L0ZjUsDXhrvSDWeMBLX+JTR4q8e35oeAwvsqAIr7Hesre4FtrXtQtddkFPh5xqiEKxZJ/AznFkX8UW6jDNMZjo0GlXLYSNObIv72rlHCGFPO4FFxUFo+jp0MrBpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5496.namprd11.prod.outlook.com (2603:10b6:208:314::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 08:56:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 08:56:14 +0000
Date: Wed, 31 Jan 2024 00:56:11 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Wonjae Lee <wj28.lee@samsung.com>
Subject: Re: [PATCH v2] cxl/region: Allow out of order assembly of
 autodiscovered regions
Message-ID: <65ba0b2be2775_5a9dd2945b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240131020726.1790160-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240131020726.1790160-1-alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0268.namprd04.prod.outlook.com
 (2603:10b6:303:88::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5496:EE_
X-MS-Office365-Filtering-Correlation-Id: 5459fce4-5fe0-44cc-b4d3-08dc223a7aa3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xn7NIGKN5iXkkVIUlugqIDfBLc/C31qpW0amynWfg45IxBI50si/VKLWo7m3KZOThEsO9M8zd3S+n4xILlfXT7ndjQQ2SNUiLhWIzc8g8v7/ZYgWnH1Alm7dUyBX3wxw+vXGGPfVv+X5t46am1ZO7QlvbInX8chmonFYwPKul0BOL6baORQGlt+gdtEQcA701WYLqReEyYCpffWP6l/EOq2pBALiZc7wn9dTwJROHWOus7ROpS4kQVNTFV0tZANybL9oxkyC9bjwjYcaSQybtpq9NX6zZ/ccuHB8YC2IxQ+23rX+TNMd5Rw3dyyxHOwZI2lztN6OFNGn86wGm+VAGPoq0GwJXtCCq4r9cF0drQGloQ9Ioxyy4Aamjunk3AwMtjjo6hl7I1cxAkxOwlXIYgbq1xmwCZ5UfJ6ew4OrWaKo2b99sEu2DMQld+au2eGXvx+4QEM32KJtw8ghENOnwnk6p1lBSRp1urBkiXHh51x27EmwMlvVj7FCtHyKqYTQkZlFGMZ8wlBRZ7wYcs/e13VA/g0dXXBqBpA5gWMVHdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(26005)(41300700001)(966005)(316002)(66476007)(66556008)(478600001)(6512007)(9686003)(6506007)(83380400001)(6486002)(6666004)(82960400001)(38100700002)(66946007)(5660300002)(2906002)(8936002)(86362001)(110136005)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gJV6L+CDPYW3wAive3Z3kRpSX5eQiK24PgGkVbtxupwEZiMkdeRSm/GS2zFz?=
 =?us-ascii?Q?ZCaL14EOZ+fPOrItAE8aZVzMIbngaw3h86zgKXOEhEmsD/Q+608umulm99ge?=
 =?us-ascii?Q?fMRqa+UEWt7vOyJFRtx1nTSFOVArTZ62fAxAkdKG5riHiBwWnxVK2E0ge/1V?=
 =?us-ascii?Q?Tz4jpESigT3WQEzwBm7JQfHeasgihFJdOudcPwQ7iE0yt8y5pGAVpTR37CIl?=
 =?us-ascii?Q?0k8VNWVq8T3Qz3/fYlwlNxznLGhunefZqEpGbKYs9nnCOFcNxRu0SnrUhImx?=
 =?us-ascii?Q?gS6FZF1Fj/Qdi/wl8/BnNyW/2l3vGEf5f8bnejMDGWqSRdfPIY8aAZtii81q?=
 =?us-ascii?Q?5hglHSsh/l4eRoEbV78b+ORIFyEtXGARqrkOQosue7j3P/TpuARaPcDmhQiL?=
 =?us-ascii?Q?aikd2f16O4GgKVzt7W8NTDUpIVuNBtRTC68blJHHdFA7AjHf6uyoov9qXoPk?=
 =?us-ascii?Q?gYV7kqPA2IgEVRZr8mT9EYQakzMAllGvz5b8wXLmZ1ASEzUtYjpWwRH3mlxr?=
 =?us-ascii?Q?mARPPIncbYpRIsHzWSdhuNutLSanKN6gLGnf7BpQXVetKHYSQkIpxs+DUxAQ?=
 =?us-ascii?Q?yOwcKHo+GWppMIu30T16yZ6t/CEuF0U74xjrTKjwKa+q3Qc3ysUro+fa8MMW?=
 =?us-ascii?Q?CEj64lcG095lVIxUuiyncsqmeJTFCEJnUPegj32fEVAOhr8vPuzrFi9ANMil?=
 =?us-ascii?Q?FVyD9vMQ2NIlUyUFkG6tFJrfyY0udi7YvWTk3SF32DnM97USwJgP74b7VMS+?=
 =?us-ascii?Q?iKCnZxhj0dxva3pfosoNmgN5xyMYVM47Kbi4mA4AvuUhHZGmunHWNa/9ecnk?=
 =?us-ascii?Q?Na9DyXG5bDYsOEBNgSfmkKaFSpSy4D60mCmVZ2F4vcDylz8GQCNRKNsJy/Ag?=
 =?us-ascii?Q?wfTQaDESPYAmhV5795VRlWgt24ZDLjt4FwajLhH7E2Q5DAOiw5dTUjZeaHj9?=
 =?us-ascii?Q?Chjvp2JzonMVvQBkes/geTQQxCe2ysvPlzA9rAPjxmv8O2qVjouxh5CVV6vM?=
 =?us-ascii?Q?bRxymxeVyI66+U0c6jXmP0uzyF5OioH4e84EDc0swo4Qp8hsRbB+3kuPTiMt?=
 =?us-ascii?Q?PVrEoBpnoSEgpaO+7vDicxuzXF+2X4KsBniZtRO1E4ZAhVMzxBM2R1b7g6e7?=
 =?us-ascii?Q?dkiSYac16bx8T745H/m8k1eI4Obgy0a3fBtOxrSK4kAdRwgNcXMpcqJjmvy/?=
 =?us-ascii?Q?SDNx1lyPjSeYj9mCan7cza53+RmAKvEsCUDTEWxbRJCPEMxTDIThMTTv6lHv?=
 =?us-ascii?Q?BdWBUonHOEmpRhgsZz2wyjN7u8jpDOUZ1uQ1qUiENYJp9dRBQVbR9ZIFFV5h?=
 =?us-ascii?Q?O8Zvp9zrli/ZUf/yIhUadWPP5lVKu34kisph2bQ1wfbx4o4DQuK1WSmMWnHM?=
 =?us-ascii?Q?tPzGmW8Ci/azdCbtG59TCTKFYaIFb/eBOZMH72qOz60Ks2hStm2PWHjejO+s?=
 =?us-ascii?Q?IjR1AzL16z0gQ3Bxmd4ykPn16XY/zaV7Qq5aIFoorMhl+4PzF9Ff8+XnL0ao?=
 =?us-ascii?Q?k0qdkjXZxZ7LcgErsHL8MOIqinLXY91/wL9q9jMVdZjBtctGK/em0OGWhgQt?=
 =?us-ascii?Q?e5+fcatvjWh+mp70jofSLKvH7JuKGV7GIZvZNCQmqV4+alAv326pG/+dz6xg?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5459fce4-5fe0-44cc-b4d3-08dc223a7aa3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:56:14.2052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kvm0NnYWgqgCFMd3hrEhMN5kIGskYaag0Ls9eC4RoDpd6dh31vwmb6pQl+Skglno95LCxPr7txRqvO2AbXIO7sZR9zicH/o9zOURUH1HH8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5496
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Autodiscovered regions can fail to assemble if they are not discovered
> in HPA decode order. The user will see failure messages like:
> 
> [] cxl region0: endpoint5: HPA order violation region1
> [] cxl region0: endpoint5: failed to allocate region reference
> 
> The check that is causing the failure helps the CXL driver enforce
> a CXL spec mandate that decoders be committed in HPA order. The
> check is needless for autodiscovered regions since their decoders
> are already programmed. Trying to enforce order in the assembly of
> these regions is useless because they are assembled once all their
> member endpoints arrive, and there is no guarantee on the order in
> which endpoints are discovered during probe.
> 
> Keep the existing check, but for autodiscovered regions, allow the
> out of order assembly after a sanity check that the lesser numbered
> decoder has the lesser HPA starting address.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Changes since v1: 
> - Get decoder via available struct cxled_endpoint_decoder. (Wonjae)
> - Check F_AUTO in alloc_region_ref()
> - Fold assignments into the declarations in auto_order_ok()
> - Drop Tested-by tag due to changes
> Link to v1: https://lore.kernel.org/linux-cxl/20240126045446.1750854-1-alison.schofield@intel.com/
> 
> 
>  drivers/cxl/core/region.c | 47 ++++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 0f05692bfec3..28e8af1e54a2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -753,8 +753,32 @@ static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
>  	return to_cxl_decoder(dev);
>  }
>  
> -static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
> -					       struct cxl_region *cxlr)
> +static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_iter,
> +			  struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_region_ref *rr = cxl_rr_load(port, cxlr_iter);
> +	struct cxl_decoder *cxld_iter = rr->decoder;
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +
> +	/*
> +	 * Allow the out of order assembly of auto-discovered regions.
> +	 * Per CXL Spec 3.1 8.2.4.20.12 software must commit decoders
> +	 * in HPA order. Confirm that the decoder with the lesser HPA
> +	 * starting address has the lesser id.
> +	 */
> +	dev_dbg(&cxld->dev, "check for HPA violation %s:%d < %s:%d\n",
> +		dev_name(&cxld->dev), cxld->id,
> +		dev_name(&cxld_iter->dev), cxld_iter->id);
> +
> +	if (cxld_iter->id > cxld->id)

This only works if @port is an endpoint port. The order violations can
also happen within switch ports and in that case it is invalid to
compare a switch port decoder-id with an endpoint decoder id. So I think
this needs cxl_region_find_decoder(), and cxl_region_find_decoder()
needs to handle endpoint ports:

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ce0e2d82bb2b..f1a9d1798d21 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -730,12 +730,17 @@ static int match_auto_decoder(struct device *dev, void *data)
        return 0;
 }
 
-static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
-                                                  struct cxl_region *cxlr)
+static struct cxl_decoder *
+cxl_region_find_decoder(struct cxl_port *port,
+                       struct cxl_endpoint_decoder *cxled,
+                       struct cxl_region *cxlr)
 {
        struct device *dev;
        int id = 0;
 
+       if (port == cxled_to_port(cxled))
+               return &cxled->cxld;
+
        if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
                dev = device_find_child(&port->dev, &cxlr->params,
                                        match_auto_decoder);
@@ -853,10 +858,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 {
        struct cxl_decoder *cxld;
 
-       if (port == cxled_to_port(cxled))
-               cxld = &cxled->cxld;
-       else
-               cxld = cxl_region_find_decoder(port, cxlr);
+       cxld = cxl_region_find_decoder(port, cxled, cxlr);
        if (!cxld) {
                dev_dbg(&cxlr->dev, "%s: no decoder available\n",
                        dev_name(&port->dev));
