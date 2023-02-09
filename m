Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF733C61DA4
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Feb 2023 16:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBIQop (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Feb 2023 11:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBIQoo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 9 Feb 2023 11:44:44 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD596467D
        for <linux-cxl@vger.kernel.org>; Thu,  9 Feb 2023 08:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675961082; x=1707497082;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DuHHNX6XOBoVVCgPT/uEezl/WvEq4kv/Z30LYaQjwDE=;
  b=UQegkiaequAiXSiC8QgEND/7kPFTdeA3aQgSzoruZIZvMAQXUplv3wDO
   LevWUgjKQ70SE/Tkcnq6sWTPUT/niFkpBziKCjoo3up2udlLwovQOkQ6h
   0Ri6esQMqcK9GpUEBMCE2KRwpSRTzIZcH7tmTjcRNh1pfztogZcAiqOPS
   fVAi+A5azMWp3rh9scZHtKcLOo8i5OlYLRVsgTXe6qhhtuvRFO8iYkmMl
   V/Cb23EUGQzRHCfsb5349BnBWoJAC4hpqF+RLwnkwK9t9c05wOhjuYqkc
   q2MTRuNV7/V+GYYAYJFdxS0F2rqJuMgxd4nerk6C9IkLrqV9HPAdsE6dk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="392559372"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="392559372"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 08:44:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="810434536"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="810434536"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2023 08:44:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 08:44:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 08:44:39 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 08:44:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkbnsBb+nQW4h9iMsAaZm4oFlL86vDsRnCWMr0UTrFJM+HCVKrOxZ4Tlj7r/XWlyksknGHDpql5yQEkB9aeNs6ykalU70z4eaa6XIlQ4xqdsis3FPwlL0VlcI6m8IkIqMngHg8QkGuBfSUUvQI5mbABXO4dX5N5yl0J0KlK37k8X6K3CvFMJuRlew7QlSsCTbCh7Pl3N4IRlvjLWUeS+OIrJwoYgVZO4upAdfC8E/5HUO4znd1CbXQT4tBzLRhoZqbcGV60xvgfuTSi4ZqAoBH9ZJsZEfT564x/pePu/f2TaBz1hEsHlp21djNIWYpFlRBHCiNqO1PyKS54WeHoMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20okL+9MHyVrjyS2pr55enUh3UcA54phcks5dgwAzPY=;
 b=Xk2a7AHIfsIEP9XZU1tx5C9SiH24e9PjrurYDZGwSvGWB+jiKaqJZS16sG4hgdzKlUt3iyUdjOERsvlPiXrN+M1C8GpLFk19SHkP+d9Ct/S72gyh/3HD7kUC+GXaNb3bKfDPlqoS/UTdwtEtYP/YQBcYvCj7Nn36U6YzHvK5d5zS6wPlgXX+lERXkHVxEBlc9yfhLPoOjACGki7H/qTOT9p7XR/C6lT7itHiNMkuFUCcHsaSFZhvnHDvJDvn5BuK3QY03gQfbPEAIaeOaCyFBRaNbsSq/2wJkDEQJUCN3tgQxwLPEo3KpA87Kjgit22s5e2EwxtjsxagBsXb97ufcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4696.namprd11.prod.outlook.com (2603:10b6:208:26d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 16:44:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Thu, 9 Feb 2023
 16:44:35 +0000
Date:   Thu, 9 Feb 2023 08:44:33 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>
Subject: RE: [PATCH] cxl/mem: Correct full ID range allocation
Message-ID: <63e522f120234_46ad92942d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230208181944.240261-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230208181944.240261-1-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:303:dc::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a46f16-3f96-4553-4b5f-08db0abced47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FqSEKb6dRor2HK3ENf6iYXKxPpn77DapaRG/AoxXySkZ9cflnxY44bX913sASE882gg1MGRT8usTgfshRvZcJxG+bUne7eURqjPl+M/bqG/97h3LqW4QZJvj+x9YDVaVlysrv4g5o0zz8s4305azKvefvOXkz1sdR08+ZqeodYifWXESuwgVgHuYmdp/64Ir+99kHIYgiUUhcWoRuT/Ibewfwwr5rgYFVksqIlU9U/basSpnbKQ7KmPvaXWH6xnqDl8ULM/1lUy9nfok9UqjaUHYBz7BKX5wl87yaZvpp/cYS3EW6O0/fPepwFROXo4HvwjH+HbC5vFtWJSTj4YQ4RLr7mj9EFYjwWvAVIdXvRilxcN9vYAWA8FNcKk0c4tmdyh7eYQ1Jzy1gUbrMNuh2gAFEMJqilhp8IiIopYvZ2fv8odnpMe1K+J95lFv1vDKKLwk+AYprIPzNh5EYWAB23vdb7YFA6bDlmvBEBHry5H8OaSr3QN9+WRyYGXAzf/JAK8x+C5QKQIZPKEApnknRUbdXqSNqPCd9qYkGDnvtyOfP26NM6E7MkNUQhbPJNHtez7lRgmahZlmRPFc4n8mgn6q7jE5AcHo6BR17EDML/y2JY5n3BYetzn9+00ywGfw0AbOnyOxo04b9xNw34niw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199018)(83380400001)(86362001)(2906002)(8936002)(5660300002)(4744005)(4326008)(66476007)(66946007)(8676002)(66556008)(41300700001)(316002)(82960400001)(6486002)(38100700002)(6506007)(478600001)(26005)(186003)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?roPzoSfTIzwOfZROrIdGo9VValBCCn2kRi0Io8yAD+TL4Z78ENGGdI3calvz?=
 =?us-ascii?Q?m4b8UEa5g53uArRCYp9hqmcbPoX6yuZRjnf2aqViCvxo0Wd0w31NceNXrzkE?=
 =?us-ascii?Q?Q2g3LmzbZp2JAyOxrvuMlzf3f07d2bP/cHwi/v+GoJRYcSBgqGetjuvgOUh5?=
 =?us-ascii?Q?DRkaWEZdopVIJG95Zmhsvq73l+ZDwLy+DyJPxQ6PBwvGY1Ht+AQZCZHclScA?=
 =?us-ascii?Q?mjzSgK8MxmLQGi9NmunMmpm7tQWEZTvXSWy01E0DhLNy4RsxhMv77FWzCpqe?=
 =?us-ascii?Q?CsoG7+yGB2wkFxqFhRaIHdUmXDw5Ze1aPDmKlhWGtthVpb+duM/SvUeD5yGO?=
 =?us-ascii?Q?qvb0dLZpTTkekZnFPacYW+Sawx3botpuZd15c8lKmuQGcwlbVVjmxYxbPwBi?=
 =?us-ascii?Q?rDjtsA8J/1W+EhFOj3AwoKORTA2eaTamFTsxF63OQTjCRP9MqDuUKXhRVN19?=
 =?us-ascii?Q?1zouB3XntB7Z1V/tCKbPqwslBxZ1HDGPAelEzppryhJGitLkIUJWPLGQ9APy?=
 =?us-ascii?Q?No6+IIzg7DseMLgOAsen+9VcV6CwLa2NPK1PViAnSGGbLc0HTcrgY0aNEAs7?=
 =?us-ascii?Q?HdIeJzFIJVu65tXc3njitRDmVFTVJTnscaorPuBtQWd+U7bAqJXxMlM5SHQG?=
 =?us-ascii?Q?xx5WMSG4Bc36d9TZHf5geM2+VexokkSTLlZTi2tD9k8PFd/4j+a1uUpofd1b?=
 =?us-ascii?Q?sgKlaXWjKJ6ujWjF4XM9bXYG6+DFC7KUXiRqc5QxvOQ59qwDn54bKqEXwa2d?=
 =?us-ascii?Q?Z3/+8a+8WMSKJROdvsNxg43GRU7QMvkxb8q63M7X1XfTL54OX4RHXASNM1JZ?=
 =?us-ascii?Q?D7bSKufOGO2LMWpIpvKbt6ekL/Q7J5R5F8rzVKuoy3IRUlgpHjL3fqkPn1Sj?=
 =?us-ascii?Q?WThVjUKVVDdNGYtimIOVpzJaq3YNvL/xdNwsw+fYJIwDeUuebjRJw6DvHLUO?=
 =?us-ascii?Q?XVtpmuUIwva4nq6qdEQaflMEVQO+n//IZ4LvYSPMKXUcfENBnk/AKzTH7S9d?=
 =?us-ascii?Q?sq0zrz0XQRXAIs0/zrOfYQ/1yh/mS0X8+WZN2VQ7F0TJeBXQ7ZgCDHrRjbO3?=
 =?us-ascii?Q?uMcLvNiJHRELV9VI8NMES+E8CTgHb4NoHQzL33ngFLPtHRuUhd59tSTY06dp?=
 =?us-ascii?Q?kW19d9dSxKuX5YctCC2QlFQlju1e+Fq63Dr6v0itOMC8O148SF5MydHayMGB?=
 =?us-ascii?Q?aqIj8LdC3pOpyQwq6YHKO0n3muEc05OZP3LEpINjYAXWyZlHFG3yv0cxXBYt?=
 =?us-ascii?Q?bZopARg/PLVFFr9/01Cmlh8blRxyjehhy6osthTcpaehQBcrYayxUceRR8Jq?=
 =?us-ascii?Q?jly7RATpOPLlPfDxHzldT5jGvchxgU0R2rPaUzP40lvlvnWcNKoD3PeKaGJ5?=
 =?us-ascii?Q?FUGTK9zD3lmdQ51lHFU2mPiozuggRudUBSoVkAgtPA4Xpc0GuGyz9l2DzGuW?=
 =?us-ascii?Q?GM3WOxLJ514DVwi8SMKpO5DSUumHvuuzXiNZ3OvMu/9b/XbqmRq20JRsbgU5?=
 =?us-ascii?Q?ZdEdpdFJgSCk0wyW/jkQa4T2UNIvG7SpPkyaJNEWkidbLUqZfG1nWpanCP91?=
 =?us-ascii?Q?iGzmLR3pYwgYkPcVsHK0KgnUd5+yZEshGKxlJI7bDe4E41w3z2RKBGGDrqCH?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a46f16-3f96-4553-4b5f-08db0abced47
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 16:44:35.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+RoG4f25FtVelPQ9X/JE2IEmyj/mX5lqpawWtgl9IWxjpVOg2VhJhI62wSyaobxbJnKGbBlolV/13aUyhkfvXjp3EtRgvbSJUF6VVo6yfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4696
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> For ID allocations we want 0-(max-1), ie: smatch complains:
> 
> 	 error: Calling ida_alloc_range() with a 'max' argument which is a power of 2. -1 missing?
> 
> Correct this and also replace the call to use the max() flavor instead.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/memdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index a74a93310d26..12bd9ddaba22 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -242,7 +242,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	if (!cxlmd)
>  		return ERR_PTR(-ENOMEM);
>  
> -	rc = ida_alloc_range(&cxl_memdev_ida, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
> +	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
>  	if (rc < 0)
>  		goto err;
>  	cxlmd->id = rc;
> -- 
> 2.39.1
> 

Looks good to me.
