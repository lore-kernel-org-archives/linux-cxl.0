Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7F8C77B7D
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 02:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjERC4O (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 May 2023 22:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjERC4N (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 May 2023 22:56:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67EE19B0
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 19:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684378572; x=1715914572;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N7SMpLnNkYNUgFZq9fqboXOV6mZcw6lj3iBVJsH63Yk=;
  b=eMLIYH8yRGxiTn39cieyhmTt6ccyKOzHFwov70w5f+V4JfaZY9rUlTZe
   ZMozJTxijYEO9EBqpSBPo9Sk7UA/ZmuU57sj6EUsjZUWIpZ9OL7abpyGQ
   n6a1k3NMnCMOo61OwOa7hZ448A9TU4+PpC6Mmhih+k9wyWfBp2q9Z4CzL
   4OSw/O7fRK2yUXfZVUkvfP2+zU2B8BOg+uLF12lrCt+86nBr9HSvcBpbX
   ooP1wKvnsnW/tmPKJaNuXu19qNpNdn993+kgRzt5an9os+cvvxLZsvPFO
   oPpC3KqFEnl8bT4XJtOHIZfsXNKgvakuRZ/DqdwwDL6z/7LiC6XVSTwo0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="349453788"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="349453788"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="791778013"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="791778013"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 17 May 2023 19:56:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 19:56:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 19:56:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 17 May 2023 19:56:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 17 May 2023 19:56:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBT896Lg+KlO4Y3Sl2wncoMzmsNiyW0hlzEjth4Xjia9ypG8yjcaY+WI8fcSeHVY4JI/6lqp3MlaR9/anfgMuBa+tveYxIn9cRXLCxhwvLzBOGgSLobN7utdIFVrVgrX7motAIDHHCqq1fCVDetGq8yl+zGX8iVfCFzVpUA0kZ4AbTBySeWFX44BH+4HYb4c8kKuxnbE4NUqx61K8Y45/Wxi+g8kMiW+slBPJeo08jJIvYIveVwRDSEDyTGayb2MQLx0sCW6aSvEio+HmTokAfQmlvRjSzqnF39nCie/NByOqhKK3yFBzdK3KIZNOh0oqDAUsNGwOr7CWJyYjj4PJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7n6lSAIB21btigWf60k+dI9KlIgrm1EUrZjOT7bp3Y=;
 b=TBWSCm4SGNBo2aJEcrQOsj505fWMmilWveW8e/I5gzf87Li6oDKXI8gpn1/IeCQ/mKKJvtckNiIHUvp8roQyv/rSZQmjhYTAIWsmvoCsQpDUuqFPg/fPQZOfg/O53OXi99ii+F+585MrxxsER1sHg6OGQlUJ/ouIUWyNsSmsYpazD7NyioJJeltZe3Js+INvcriiQxlY8ljaIrxBHm/xHkoOG6f9jCGafHWnYOiQupclfpyb8Y9xUDHsdRTY2FsnHMjVh/rOb3fcm2y2/sH9oThFYLs0usZLmWtQZwVJOVYZGmNijzFqgumv/eSkb0W0ey7vDOHBsVZAaNMzujFK1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7720.namprd11.prod.outlook.com (2603:10b6:510:2b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 02:56:00 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 02:56:00 +0000
Date:   Wed, 17 May 2023 19:55:55 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH 3/3] cxl: Move read_cdat_data() to after media is ready
Message-ID: <646593bbe667d_10937a2947d@iweiny-mobl.notmuch>
References: <168428284429.2205351.8883627879572769367.stgit@djiang5-mobl3>
 <168428297113.2205351.16197713607932380832.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168428297113.2205351.16197713607932380832.stgit@djiang5-mobl3>
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b1dec9-f383-4e0e-ccca-08db574b691d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKsLxlGXyDZKOBsuzfXmca/ozpAxpQEnaLOXbNN6Gr38DBeEuxkapNhqulwfAiI/g2NtlYKAU6goikrWbFNDCtYB2Ph3pKHj9bwCwE7gpPpHlhuroXfaUd9e2F+B8xXwFO2iks67IzYRKrEtjH9mnUOlmE3PJgoj64OD+lLD5bXZs17w4VyWAthB/L3KbGSiYtDJW4XRS1oTc08P4ycG9ivGyMGkFnA6gE3ksxPysy1P+dmk/xlEegE5+tkZj6PbQVau8abs0k5uD3qYqkMTCAE4l2RrxC2ztZgvCnigxAtN3+KEkyoL3iIi3Nd7MqrgFKkIQ+3nsVNn3dXkNLwkympSDhHYEDgo7JTubhPHzocurd6Q27RdWW02sfIm7eps5SZONXOAa7iKNaNnLHrvdkT6wX9FJu/4RFPkf0wCLZ/HEBj9IhB1/LX3XLKQfCUL+UNZJyjQzDlsLDZG35cL58REi4K4Zf/Jdnzw0Mj/d6d2AJY/Xb9DmLHCMgiHV34WEDazFeyXQmlCXPFQPFTYoXyuEeoGWw1+1NhXgEWswWjJJDL8tVJv3YMUxKrlrUPz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(86362001)(316002)(66946007)(66556008)(66476007)(6636002)(4326008)(478600001)(6666004)(8936002)(5660300002)(41300700001)(2906002)(8676002)(44832011)(6486002)(38100700002)(82960400001)(107886003)(9686003)(6506007)(6512007)(26005)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s4Klt22x5k2cyCOeqmPIRhtJSak3NfyOFi09xDR6wG8N5NXbId6KwZpioABc?=
 =?us-ascii?Q?eOXycwFXVhK3rIk/eoLCgSJyWYwYhH7ZQ8GmczFFLpmvhtUqFnrPQtZeqMwV?=
 =?us-ascii?Q?livPeP68od5BJEt3FamNayx/+Na2HiMHFVou4WRxjm1WnYxbIl2rdZww3GZj?=
 =?us-ascii?Q?IiMJISGla0j/7j2Ht8xy2cTx3H7ThJhhD+AVfoXlKwhZ5btqa5c1gsD9GSDe?=
 =?us-ascii?Q?dteszZ/UZ+TOoLx2Fzr4XWXF1Kd8c6gMiEpEF0HRhrQfDO6TODxuoOLoch51?=
 =?us-ascii?Q?9Sgq3R0QH2JmmrnuP9HCES8ngFbxUXSmBSTCI5tVf2OSxoVEGvbNcpK9ecDM?=
 =?us-ascii?Q?2LVGFgP7KHumjZx0mFov3QmMOtXITIZmAuE8KXWF7Ysp64lJPb3uKoqJNbvp?=
 =?us-ascii?Q?FJDqD1FqPz+E75Ly0y8YfiMGTphgl5Bq/7iuFYphX9B/5OBnVeDvzJo0UXRJ?=
 =?us-ascii?Q?754agaXwrsxFhPnEY6R5xS9dDaEZyRM6rGnB+8Lnv6BbH2oB123BQn/vWagF?=
 =?us-ascii?Q?rRoYldmBtyLRsUrRJA0EUZLejGWc2jVFApOwSOH4ks0m870pBW/dX3d0S2xm?=
 =?us-ascii?Q?pIJPXnchpfymAd5jMQ8oICQE2AM7vxnmo450M1pMybpg/5rADZP+U/JT3a9r?=
 =?us-ascii?Q?rUJ/JY8+MBTNgjgwY8x5yCkLoNxPJcHRiV8OveTdsA5r+1wYz/roGC73tmU3?=
 =?us-ascii?Q?BbA/H2hBmSUfEZTPZowYvQ9z6YFPh27+lpVeoopLAYcll56rp74+Bl9zuHkk?=
 =?us-ascii?Q?Kdi/1CQBCu/WfJ+SNAMsC0LEfn+/7hjlVf1mlxh/nYMiefUMSwdwXnKTfn5k?=
 =?us-ascii?Q?cLb5bmxkSfqwMR5Rzihlv/HNUSaY/mwcrpYPC6JIRLUz3poKIqKaFmxX5rH3?=
 =?us-ascii?Q?Iq72EaqyZSm3SNP7F3ei5zpKxro+KsokxSfOKlVCfnShFlppzgp2VUDA7Lhs?=
 =?us-ascii?Q?SLWvvX9moXBlfChLoBdXAb5XOu/uXRyP0ZzJoiNIcW/8WV9fby3YZiIpxF53?=
 =?us-ascii?Q?9BPa0emHLWKFNgAJdu6uN3Yg0E5sKWe6lxQG3BiIrG1ICMe9FbZRCAKKjwIf?=
 =?us-ascii?Q?TWT1np80mRTeKzKaLd2NGDlQE4Qrg4G8eNLcg+VVzQrT4DinaZ5lMIWK35Ms?=
 =?us-ascii?Q?gTHUZGhDpD3QB7lKrLXpjFq5ujNhnTdfVQgs904XUD7QerTPpCO9ZMYdgEAd?=
 =?us-ascii?Q?AkYLhYWJdWnxdvNNS7akUFv425RtpqHRAhUxC634mupfWgaiyTW+96DkGWKQ?=
 =?us-ascii?Q?hEKl+cHcm4t/k++bIpj0JviI6qViz6kCp0yeOR1ovaHJ2ul9xSHZuKkBUXmx?=
 =?us-ascii?Q?v+FVZDbxXBJGH3APeE+70XaCWUJzVAaKf/ULb91Fnf8fqpancd3Gy6MKCCTR?=
 =?us-ascii?Q?9EMhNE/Hd5h5uU8FgjyVKVQBOgftWwKNsckg5sinR3QiZkcbO2k8r5dHe6ZN?=
 =?us-ascii?Q?NFJJIFcILSwQ8U5SFsY2uVLxTOgS//ubvO7SdqFixprXIBRP1CXzj7OiSDdI?=
 =?us-ascii?Q?7CPRkCY3tUmd4qrOEZKPXcLeNxHdZJPBlU8qJ5TwW6ONLYLsXotGmCxpZiay?=
 =?us-ascii?Q?h//k9E+YlAXkppdmo00pV2WgWm0t2J7Df5DYALfP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b1dec9-f383-4e0e-ccca-08db574b691d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 02:56:00.4678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vv99FdMZy0lC8OoDxaMACh0CYriz84iOLL7DNOHJ39fP8B8kSbBDbS/dvJEPAqEAXIduUIzAwUvLSIfYPWq0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7720
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> CDAT data is only valid after the media is ready. Move read_cdat_data() to
> after cxl_await_media_read() is successful.
> 
> Fixes: 32ce3f185bbb ("cxl/port: Split endpoint and switch port probe")
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/port.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 40e7b7de8bf6..bebc297fde5c 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -96,9 +96,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (IS_ERR(cxlhdm))
>  		return PTR_ERR(cxlhdm);
>  
> -	/* Cache the data early to ensure is_visible() works */
> -	read_cdat_data(port);
> -
>  	get_device(&cxlmd->dev);
>  	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
>  	if (rc)
> @@ -114,6 +111,9 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  		return rc;
>  	}
>  
> +	/* Cache the data early to ensure is_visible() works */
> +	read_cdat_data(port);
> +

Does this apply to the latest master?  I'm not seeing
cxl_dev_state_identify() in the current cxl_endpoint_port_probe()?

I think this is good and needs to go in but I'm not sure where this call
is landing now.  I assume it is right after cxl_await_media_ready()?

Ira

>  	rc = cxl_dev_state_identify(cxlds);
>  	if (rc)
>  		return rc;
> 
> 


