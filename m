Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4238FAE
	for <linux-cxl@vger.kernel.org>; Thu,  9 Nov 2023 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I74YAoT6"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60D54220
	for <linux-cxl@vger.kernel.org>; Thu,  9 Nov 2023 14:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699569540; x=1731105540;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=36UTDTgleH3zAJqogYOQzH4wGFE/tdYAc8v0PYD30HA=;
  b=I74YAoT6bf8KMTezD09pepVQ75jn7YN7gTtaQ6XEKJHQmnA3s2NXKI1z
   Pw5LD+CL2CRaXFsO148CuPnt9p+Q+37pnUo6R7KIRCElKDmvdjrJVf3c0
   RhSOTdcNUEmSX2LQ32vOduEqCRxvInsTsRdlHJxceR6KOHvrqfaaLF2f8
   84wn3bkSpx5MybHZ+ixhONH9ih9wrPSCy0Ou2aoZgdV+bSYC+UU9jMdZs
   COKJZ8Ma98/aH1rWlNbVG8z5hRLGNVORHKp3LQxg4yiXlBtvklh+Es9cI
   FeSaQ1dsGU1Ts5vOJsG+kiApTVWAeL7WnDXrZAIWK5sGRw4DwGmeZnAS1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="380480014"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="380480014"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 14:38:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="1095015770"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="1095015770"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 14:38:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 14:38:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 14:38:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 14:38:53 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 14:38:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mv1qPk8FY/6QdBNC6GcK6clhncRI/SVj7RdlcxN678fGIVMSEtQ2X4qSbgDqeQTsLmH0PrxQrbvJ7RQEzwKO3WOSNWL2NklaLK6vvdz8nqK2upJLUzd0+5P3+uIiKQdGgEG1H0t23PEFt2+3l0pFwUSd7WUoAdWgaLTKdh2D8Q/OBox2KfFFS/xN9gB/6hWGn0q28MylFtq+iUfgTkg7695guzV+KbZYDFKbgC2F/ZGSM6/nZd9zhmPB13Jyos4alSiucchqa79yg2OvPcNqbH8IEVkpL8Nei2MrTq/UkyuoDgTac9u40GAiYqZJyJtgyxnpHBn9TtnwXEPnaabfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0oEtAdhosy3oAsV8t9s0Esmc33D2OB3pBT4s7NmmFk=;
 b=Kt2vKQ9y6X+etGJEuDXWc4JloOJdnUmF0ZTKvf9a3kPjVgeB1I8eCgRD7tB9pZMMKMTXCvuqAK3vy9YdM3o+iKuIqAehHTQGv3aX7VRBAjqtiRZ4wFcsSHXEQdhls0zXnGuFie+8GZRmDuRokstZOvllr8IyMthoiY/JTAWvY+V3Q9AchJTPtLeHM3s4K/8Il2LEQgQ1gZe1Hf7BzAY/7t97xHyWZN+52r8WDcGmGzTs6Pj99ePL+0TOi6Tozvi+0nP2NfdHxW3T9LFwRViowHPImsPv2kwzoDF7t3u1FsoLe/SyVGaDOhVWWSihgvh7Ik6wvVfa8nrSlJK7o1nTXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CYYPR11MB8308.namprd11.prod.outlook.com (2603:10b6:930:b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 22:38:45 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7%4]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 22:38:45 +0000
Date: Thu, 9 Nov 2023 14:38:42 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl: Add cxl_region_rwsem around commit_end write during
 decoder enumeration
Message-ID: <654d5f7285171_af98d2949e@iweiny-mobl.notmuch>
References: <169948110840.509375.13862681045079385425.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169948110840.509375.13862681045079385425.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR05CA0156.namprd05.prod.outlook.com
 (2603:10b6:a03:339::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CYYPR11MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: ec97e311-b14c-49f7-8956-08dbe174a209
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILYpbpMHspQ9I8X7VPathmMuAfoH4QvsbqtY7/06UTVS+G93Vt1ScyQYeNC4UOhibZkFXNNTddy0JFTvfnLyw5bN9yLVUN3lTrun7B+8xpckRl9KtLo7YJU5QOqiOQwgLdwmM4SVV1uiX+37/gJYfrQfNCkOHzjov+DYST8MUX6Jdvyj5aCcR8suST7X66R+2jsb6fvIJU3qAOa4vrE7YAxHcL3KydrOJ9AlfZYkr/ZSKKoiSJUyqHtu5rMDKwLxDg1tPBExGlafQltdOLFL9n3cx7Zi8rgSJqsKA7+k7lWdSO6Dg2gE8hjLGMZ2RfbtnW1xm3yJfWey0BLQZ4V4+yMoKBabKC/aCblnf2Gi9HtRWoMytA2OqhAHUhQUUZ/ivY85fZjb+Q02ZvCihKhmftehXTCuvlE80jGjPrY+JhPomwmPvLAnbatDe4kDnQTcCCen1h6OrRbFQyy1mtuX9wErS0lQqNDpA526yoYnaZdAmaYtyiVoI9c3p+mxoYbjIQRTjYnZsgtMxQ79t1UkhgqPL7n201BbFTRJZnhTQqiHRFFpB1WYahxxARg26zB7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(316002)(66946007)(66476007)(107886003)(6512007)(9686003)(6506007)(38100700002)(26005)(6486002)(478600001)(82960400001)(6666004)(83380400001)(86362001)(66556008)(44832011)(41300700001)(2906002)(5660300002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+2PfkT1g2rfdg9SasnVmP6tx2gatqQx+g7znMQSME93TJIj8Hisv54IEovSP?=
 =?us-ascii?Q?m/hg6TTHnBGnH5476FHpy2tAtRYixwq/R2APmJypatEiY5kLKo0ujNw605p5?=
 =?us-ascii?Q?qfFOC368rEjYYUUz+1RtELohUuXFj/uAcdO/WmsrlxF3F9pOH8SPUXGk564U?=
 =?us-ascii?Q?HiaOTRk9SuluunCCafYt1iBN1ZHvHUgDlycUHboqY0FV+skeKAuGW+j6FCfG?=
 =?us-ascii?Q?uBChpW9Bb9YPCRi9Hd7aAgIbb2bdKGLOMGGpHkbgtyvV3lX980VqGj1YV8Md?=
 =?us-ascii?Q?uLyKQtWxV3btorGOoENP9Ox9qUWd8qAxP+wqkX92bQlfya+7kcQV9yn7bAnq?=
 =?us-ascii?Q?zhL8LUmLuDIN4FjRhzZuGJv1x/3edcFAJD28g4997VBQPy6qZPOo/VA43K9M?=
 =?us-ascii?Q?r0Wt374jeLBZ+mcMN6/9AVr0Qh5tO26gsOmG0om0mT00tFAjbMwm+Bji8PcO?=
 =?us-ascii?Q?nJ+7aptApnoeWBExPQb2sUlo9bHAfjrx39GWC+cawOeBBbM3yA7fZL3luTcT?=
 =?us-ascii?Q?dMEms1CNKrWrxwZSbXrrYFjSG2H56yVVGceDXrKrBNyWRAfZnzxKfbsXSsMB?=
 =?us-ascii?Q?uuwlOaW8T8GHqp46uZRQKZr05i06QA6omqK65plwKNvIBHeLBDjU7W0tQLDd?=
 =?us-ascii?Q?mxtsb+ccso65fqjd3i1uNGvtAqvKuKj3ouxGWOGCdWuBBqsA35RXrj0XZ+Mu?=
 =?us-ascii?Q?5VkWb/yDrlway0DiChUZwNopMpZw/N2KHiYHnPgQIps/WpbtZzWphl9qO//n?=
 =?us-ascii?Q?UBrh8M3qIrMAyTOA118wCgXS9PaFsh6cAKr/7rwMluTNgKvVwt1y4T4fV7o0?=
 =?us-ascii?Q?eMRQ+cDLs7a2RBrfqXc9/fQhTGs0qBsuOfxHB7Fwijl+j71eQbWnaPHLrU+Z?=
 =?us-ascii?Q?ysaQtyBygWdd2yb0c/tbriBClaO4lWgh/sySxEW6k+t56pMY83mq+DIKwxD1?=
 =?us-ascii?Q?fyXdpoUw0kiIoquySUQrpnEJgrbhSiZpJChAWilSWpmMLm35riPGZm0OkyFk?=
 =?us-ascii?Q?fH9mu3cAi03oEmLzbbJXtVpBA5y/Ui0wZSifoCzUDLNKcfzNTIhATAlayjOk?=
 =?us-ascii?Q?dfz1XhDkNqpON7DdSn96DQ/99+XmeBqHtIHwu9xHSDFV+tZdsrlCZwBoHW/5?=
 =?us-ascii?Q?jKe8Q3+opz1JuWygiyHAUDxxxEHJlH/M0Id7v4U727Kqcifs/7XA9bkDYLUa?=
 =?us-ascii?Q?UuSEVaxGPZ9jOXJVxaIQSt4A70xSjmVinmNlj1Za6rw2mQAmzAulfhzua8s8?=
 =?us-ascii?Q?GD7v+wcAzpeLdj8d5TR+fkzY2dYYvmovomyaf7ULlv505vf3S1aTj1+2iVll?=
 =?us-ascii?Q?a1TIml+m+39LH4rV8cs7AMKxJQSYJO0yUzctH+5SS16B7MqCDw44A6TWPrDb?=
 =?us-ascii?Q?cBXrtZv2m29r5GtP8YYOSajOxTzCuJaAxq4VFEJbmqDu5JIE9M8gs4Q021Lj?=
 =?us-ascii?Q?deCbOupdoZMKFSwofPHah5mrb3+AAhlIi47RI5iO+bszzPQrt8nEaOXDX5c0?=
 =?us-ascii?Q?iCB5PNrW4Lai/qCap5ThYq02RiO9xHYuHs5lg+OOMtlJEkuD5HdWWQ3cBZzG?=
 =?us-ascii?Q?PurPpuaGo4qGJLeJtootO3uY12YnHQKKV7Cmuk+O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec97e311-b14c-49f7-8956-08dbe174a209
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 22:38:45.5796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WiHby/T8z8JlagIflioNaep9LtY7H70r8u0EF7EasdqSSB5WeFuNdcl0w4hMym9gT0LNL2rxXhVB7PJK4BWMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8308
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> init_hdm_decoder() modifies port->commit_end without taking the
> cxl_region_rwsem. An assert splat emitted by cxl_num_decoders_committed().
> However looking at the code, it looks like the write version of the rwsem
> needs to be taken due to the modification of commit_end. Wrap the write
> version of the rwsem around reading and writing of commit_end.
> 
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index bc8ad4a8afca..a8f960c496cb 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -854,10 +854,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  		else
>  			cxld->target_type = CXL_DECODER_DEVMEM;
> +		down_write(&cxl_region_rwsem);
>  		if (cxld->id != cxl_num_decoders_committed(port)) {
>  			dev_warn(&port->dev,
>  				 "decoder%d.%d: Committed out of order\n",
>  				 port->id, cxld->id);
> +			up_write(&cxl_region_rwsem);
>  			return -ENXIO;
>  		}
>  
> @@ -865,9 +867,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			dev_warn(&port->dev,
>  				 "decoder%d.%d: Committed with zero size\n",
>  				 port->id, cxld->id);
> +			up_write(&cxl_region_rwsem);
>  			return -ENXIO;
>  		}
>  		port->commit_end = cxld->id;
> +		up_write(&cxl_region_rwsem);
>  	} else {
>  		if (cxled) {
>  			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> 
> 

This part of the patch seemed unbalanced to me.  Looking at the check for size
== 0 I feel like it would be better to do that check first outside of the lock.

Something like below.

Ira

14:36:11 > git di --patience
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 1cc9be85ba4c..370ba5e39363 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -839,12 +839,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
                        cxld->target_type = CXL_DECODER_HOSTONLYMEM;
                else
                        cxld->target_type = CXL_DECODER_DEVMEM;
-               if (cxld->id != cxl_num_decoders_committed(port)) {
-                       dev_warn(&port->dev,
-                                "decoder%d.%d: Committed out of order\n",
-                                port->id, cxld->id);
-                       return -ENXIO;
-               }
 
                if (size == 0) {
                        dev_warn(&port->dev,
@@ -852,7 +846,17 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
                                 port->id, cxld->id);
                        return -ENXIO;
                }
+
+               down_write(&cxl_region_rwsem);
+               if (cxld->id != cxl_num_decoders_committed(port)) {
+                       dev_warn(&port->dev,
+                                "decoder%d.%d: Committed out of order\n",
+                                port->id, cxld->id);
+                       up_write(&cxl_region_rwsem);
+                       return -ENXIO;
+               }
                port->commit_end = cxld->id;
+               up_write(&cxl_region_rwsem);
        } else {
                if (cxled) {
                        struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
