Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D184E3D381
	for <linux-cxl@vger.kernel.org>; Fri, 10 Nov 2023 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYMXNBnz"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73D41FEF
	for <linux-cxl@vger.kernel.org>; Fri, 10 Nov 2023 15:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699657983; x=1731193983;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PEw+Gdn3zxyEonJndxgGHaDgUcG/A9X2XPLG1pMLYFQ=;
  b=TYMXNBnz/mLTyZtPvJp0aWxyYKH72UeFE162Z++o6eFV13vDjuh2AAs1
   d98MFbyP14DkJ8//RYmsyVOKtJx2krshXQ/gK4UYJJBcu2awWEiZJwk62
   ZvkDR6s4QE2IV2BfgB5Ou42f7gay2ASXeMLGPu05b/LRILYIUl8EKElGv
   NnRE50yvFkruBoiJeeU8lMykgFuCV9OZq7Mwz6AnYSFtgSCYTFtisEagi
   8oQViB91DlwtFa/SiPzvESrptcwybnF8VxeOU5U+zCB+f2b1AgxkEFywN
   54SsyaNJN58DePmTQLVegj+s+dABrE0hpWFksB59EhqXoJcIm/wGvCGQX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="390050884"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="390050884"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 15:13:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="887447027"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="887447027"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2023 15:13:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 15:13:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 15:13:02 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 15:13:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqH7LaotN40ao358dlcsjhnNI1vD1ZVW/+QlKYT6fzFirDkjhGCBN//UrJfKXsV3UhBPKgaK/7nQnHcVGjF5P/L6c2bMgoTwGSgN0xaoo4IBT0DmGAjvPICcf6iZFEuQG+99mj1lSbQbZDuzCbmW+3ybC8FHuAQ2SALBzIYXc0j4QdhAxJTpqqerijQq5Ou7ccb0jzupuA/DSWYBBCtGrS+Zm6hnf3JshhEfFdwJjpX0QavXPHfBditQyzaaYYkd6I7b4xJRhxeZO/ZdkXvqvfflqciZxmdVSwaG4Lbcm7WfULoa4tr0rXQ7Fbslyqh5/9E7ls7+CbrtzVKnJjvddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r197h2u7aKelT1pGHmmC+UXYAnzR6PLy83GvT+HxFhA=;
 b=k5AU9hmnRgBh5ky/6+aXjVaemMhJKKd7LaPN9DYgjl3YtluG9UqJ5auCE8uAVBf5KLdd7R9m1/qdA1uejmv6rpuuTxkDU8am7d+6r73E2a4dLI6vRv30/EuSwgGFlTKxcDkoi57BOskVROfXlpDEVlAavD+E3nP8L3sjErGkw22XUbz6eRl8yWEr8uNIOJbsj6qATJU4VUN3wGXktOiGwR7CPOTvDLuG/UnPXnhYNSA9AjQn/p+K3somCjT8+7taj2GNDSQWwWDwF2kILPoahclbLqF9V+RPM6bsJyiMai2MHJQlsWTQXr8Wn/vEHJj2dZEEoE7aqyTjo5NSw4gfaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6377.namprd11.prod.outlook.com (2603:10b6:510:1fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Fri, 10 Nov
 2023 23:12:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::a49a:5963:6db:77ce]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::a49a:5963:6db:77ce%5]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 23:12:58 +0000
Date: Fri, 10 Nov 2023 15:12:45 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: fan <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH] cxl: Add cxl_region_rwsem around commit_end write during
 decoder enumeration
Message-ID: <654eb8ed72ced_46f0294c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <169948110840.509375.13862681045079385425.stgit@djiang5-mobl3>
 <ZU0525jPfkigOT01@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZU0525jPfkigOT01@debian>
X-ClientProxiedBy: MW4PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:303:b4::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: da0bbac3-45ee-4eb5-e069-08dbe24293f7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgfBsANdosEWX4oiPPYodtCY277APomALLKXYW9Bo45HMADdVB9Jfes5X9V1zAkinOLWoOhfzypr195lCOwEaXQ6wfb58XI/l2Ai0qflYiBO3BxiYsKvk27HuFPkv8unEaQOC2qPydrPkGYPKJ6KMd0raMMb5Rh/unoLhktYiHSPTJnVSPMr5/p/cd4aQFCEfOeOnzdtkfSrp+AcgYl04aXjilqaphelqOT3Lq8tVMKx3OmrtnKFHmNeyMyl3HByP4a99OL9V9fV3rDlIMFwmsTiHcNowo8tkeJkdnub+Px2TpCKNKx0UtQ2t7sUgPfmlpUapdkxyco2gWVDY0uto+Huc2QPHRpNEc6dmRYm4M2V42yf4Pfhu1lsebyKghqvvbiwHrqV8oZZZbUV/8V0qaSesJ6hh61JW5j0eNQ6x4LazlEcG5tD6ojZkJJKSjGSZT0yZ+IYcTLa4/jGxL023uwt6TtiHL3tZ8F6++qWkxkVk5knDd9tbT2wRngd/IbSEPgsl7K5+2akPGsdvECj+Fke87G9Tjio+938EmGRprZC4r0AIl0/t2gK/wPXIGeI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(230922051799003)(186009)(451199024)(1800799009)(2906002)(66556008)(8676002)(66946007)(5660300002)(8936002)(6486002)(4326008)(6636002)(66476007)(38100700002)(107886003)(83380400001)(9686003)(508600001)(6666004)(86362001)(110136005)(6512007)(82960400001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iKbqdz/47RExf4gY7YLFsORv1fzMKn2fD4CI9+tIMcSHbShm5l0Lwf2ewRMC?=
 =?us-ascii?Q?1X8R0K8dXVQkNNqqF0K/7RhnIOQeVzQhfrq3s+4tadSpYz0w3BaHqCPDGZjX?=
 =?us-ascii?Q?GswKVbSzLNYm3FoX1Rjlf+Ml9M5wwQ5NoPP6/79fbUGCLxd2sT0r1sSGOIjh?=
 =?us-ascii?Q?c+EdKqeMYT3KF7i3vYX2+PkcfBYxSxpt6cUWdZZ07DNgsMvFcEzFXCWV2HtF?=
 =?us-ascii?Q?xjkucGSTH8A9kWNK/rM4/F5rjOOiQQKbmqU8EgN6caim2aDgwQ+7nY7+X3Kp?=
 =?us-ascii?Q?6rveDLrCtli+9U3ajeG7+XO3h1/uuApPFr72yw7Ve5Mh1syOoK/u+uyeTic/?=
 =?us-ascii?Q?gnf3LC1L2ZWujktTAOX2+65phP4VCk46uT4Re3w0C+QFpXLwftKI22vIDFin?=
 =?us-ascii?Q?ZnXWMy8JOTWcakV/5IzI7+UA4S/d6Vr/HUPPgIpOABb54w7N0l0M42DJTPEb?=
 =?us-ascii?Q?vzrqZb0pgKz42/bhi0t0mmYbfXxB7ZVgAkApnHOuwdFwgGObLcb4LOYd+4fi?=
 =?us-ascii?Q?+efzVXgiZ7MocnhcOuSAHFXD/3ZT8/tP1FsDcxpzKphoUpt9XcW2d17eka15?=
 =?us-ascii?Q?YX3xt0S4QVIctrBSlcVunrHUTmPwt7VfYm9xnsgpOlmu47OpUpgyqs9hKHgs?=
 =?us-ascii?Q?WwdpHFi1pYpb9YVlmVn6MZ3gWaZ2kmxnotYUf7KtTOJnsEvb21zM0Rnlcz3h?=
 =?us-ascii?Q?1i/WsvDwFZh8hY3McAu9rdgnIqY0C/aCqUXx7w5tgHP9kdTLIZ/XWa6wFPj6?=
 =?us-ascii?Q?zvXveTxsWpzk3jCkXCHcOPubtARmZr7o8hMs2iP9xYWvDyAwzYYvAstxmG0J?=
 =?us-ascii?Q?VIE4P6NeX1h5SdcDra8kID2HIeh3T0CwaIKhokSqjTcxG/dx+Nm2CZ6Or143?=
 =?us-ascii?Q?ug8jX9iS42LWf91sNlw2u5slJ623y5agJQg4V7p/l2dr38E+h8waYlKg+smF?=
 =?us-ascii?Q?XxXZeukVx8qEbAnC9d+r6iF1TpMRpk4dmAipz1opwNc+XogYTcDFj1aQa3ke?=
 =?us-ascii?Q?2YMAbZY8LeAA/x9LipvtNXaeiS0gQciicC9+oznfiBSipL8KN7JFSboqUC0G?=
 =?us-ascii?Q?XDMeqpx0v4mJqN0P7G+snGH+3qesfkE6sdRFrKgpvqIqraH9ECQRHMI9zMUS?=
 =?us-ascii?Q?7bzcanZO6iufq+TenPO0mpdvMBv1CmTmtwEikolGodvGThKL/HAvaSjuViyz?=
 =?us-ascii?Q?FibHGj2vFnGWQNb4RNA5RaTcEjaE+Q1rQVpCS78Rx+yebBGwnISznuQuiiLB?=
 =?us-ascii?Q?VYDB98N0xMNNydUaAszF4TH3+nIgg2C0splJtZ7wB4eYKMtM/pgWp5r57Obp?=
 =?us-ascii?Q?y+xjFsYAzXEVxApOxsQaI+tcf4uTs0xvcU0o/7zC6ESz8psFhjL15FokBbMW?=
 =?us-ascii?Q?w4DJ2qkbU7L9aMhRBvBx1QXV29MHuzNRvQB3Z31aCyEHQ4Lpe2ScmFkPsAG4?=
 =?us-ascii?Q?2klSYv7CZqwy7nIFXmXySS7OKnQDWqnk1IEsOCDLTcpc07VgiGBNc12P1zb8?=
 =?us-ascii?Q?ypSW+obPbFWmgS5MFNjFV6p6+cFttvUdVPAQsTYok9Ge8VfbxoHAiCiJHt3w?=
 =?us-ascii?Q?Dfp2MYH17NoNRAn4T8IIBfEeyrlbxjo4KM2C++NQCYn6aQ6wkNBRrPMu1dxX?=
 =?us-ascii?Q?TEVBG44JcK/U2xQfNqqwjEAEBvKlljm3pf0gpOp8OvaMPJzd8s50WQynhvS2?=
 =?us-ascii?Q?Q8Az2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da0bbac3-45ee-4eb5-e069-08dbe24293f7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 23:12:58.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUmhfnb4xcCvkxYDgnlvEPktwwaA6zOGhdMmW4MxCln/9d2/QoPbytMjC38xvE+4b34w6JhNivzqOsUKUnYoQJUwj3dkFyA9B0qaX36Nsis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6377
X-OriginatorOrg: intel.com

fan wrote:
> On Wed, Nov 08, 2023 at 03:05:08PM -0700, Dave Jiang wrote:
> > init_hdm_decoder() modifies port->commit_end without taking the
> > cxl_region_rwsem. An assert splat emitted by cxl_num_decoders_committed().
> > However looking at the code, it looks like the write version of the rwsem
> > needs to be taken due to the modification of commit_end. Wrap the write
> > version of the rwsem around reading and writing of commit_end.
> > 
> > Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  drivers/cxl/core/hdm.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index bc8ad4a8afca..a8f960c496cb 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -854,10 +854,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >  			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> >  		else
> >  			cxld->target_type = CXL_DECODER_DEVMEM;
> > +		down_write(&cxl_region_rwsem);
> >  		if (cxld->id != cxl_num_decoders_committed(port)) {
> >  			dev_warn(&port->dev,
> >  				 "decoder%d.%d: Committed out of order\n",
> >  				 port->id, cxld->id);
> > +			up_write(&cxl_region_rwsem);
> >  			return -ENXIO;
> >  		}
> >  
> > @@ -865,9 +867,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >  			dev_warn(&port->dev,
> >  				 "decoder%d.%d: Committed with zero size\n",
> >  				 port->id, cxld->id);
> > +			up_write(&cxl_region_rwsem);
> >  			return -ENXIO;
> >  		}
> >  		port->commit_end = cxld->id;
> > +		up_write(&cxl_region_rwsem);
> >  	} else {
> >  		if (cxled) {
> >  			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > 
> > 
> 
> I have two questions:
> 
> 1. There are some other locations in the code where commit_end has been
> read or updated, and not guarded by a lock, for example in
> cxl_decoder_commit. Do they need to be protected by cxl_region_rwsem
> also?

cxl_decoder_commit() is already called under the region rwsem, but yes at least
the poison lookup code is currently missing the lock.

> 2. Can we have a race condition here in init_hdm_decoder so commit_end
> need to be protected?

In this case it seems to be accidentally protected by the fact that decoders
must be committed in order and the discovery happens in order, so it is
difficult to see a path for a region commit / decommit operation racing
this update of the committed decoders.

That said, I am in favor of adding the locking rather than depend on a
subtle side-effect of how CXL operates, and to avoid adding an unlocked
version of cxl_num_decoders_committed().
