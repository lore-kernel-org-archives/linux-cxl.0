Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE0FC77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 23:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbjEKXRC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 19:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbjEKXRB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 19:17:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEDA59F3
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 16:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683847020; x=1715383020;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=20UjhVGIR/SkVaEtqina0ADj+XTtv1K0ucHCFY5nyaQ=;
  b=Bd4lBt/9BKNDqZw0f4X/4IyNkA8PSZls/y7cyYm/QZIuhYQmNbEjMs8t
   zUW//YxmjLFhBxLFHhSKBdm4FDEMhI0iGn+9E/VroR0XmVO2LZNVznssn
   1Hzqr7C03IG7ygrjVfDKJYGY9b5MgupU5r1lT8B7IkedRp82eiPITV0YF
   Jfq/sU9I4oOHvfOzU6Wsf1Gq3INpzXRdpYtRbroBD+mn709b6xHXJaLoK
   0RBtwnGvlCb2T4t1Ua86XcS17wJNIXEVlRqwpGQcCe6g/yroPAR60VRjN
   Rp9wWG3t7nuoT1RaS2ZEjgvW9qHnRPTm2T7ReuFK6OA8QlQFlXIwMBgEF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="348151120"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="348151120"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 16:17:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="844178348"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="844178348"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 11 May 2023 16:16:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 16:16:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 16:16:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 16:16:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 16:16:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZoBh4RClaAG2OWluAu6FM4YgMguGy04tNbQHe75JIUTAkdwXj/YaXZtv+IqnJL4QdRPgRpkNvtHU/CgjWguUm66rcxCiT1/GuseR9Gn6HB4oGAI5MwVewGSpAXy22T4QVGBz/6VQX1KmLzrSUlxmLzGgqt/A3LNoRnmoy02DoeRZubhA2/vQ9bin7Hea1LeN8B9bScnLCKIdj2UCnGXoJqRsnu4isu8hxVazSt7K0CEVlZQ1uQQBBCWDw9EIXpGnmFGX55PQBcJ5Cas4iJ1yHMFWlYNRm1JQunKYJxXmFj8QVqz+FuQX12sICSxEv5ZKYrIZeJGeZ1G1aRVc7Qhow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rw5tW+VKM/x3WxB70abpxaBbxpJ5gz8GhWVd+b7emg=;
 b=awiqyiRFYd+UlgYHJNTt5Q43eMf9adgAY88v//u/2JseLDd0bEgoqAi3kEK4g4siNOR1AiU3FHAkZ6WcoN7tjLqg987PWriG45gkDct7CA/WdI66+A6QYLUCcv9ZNJCeEJQSG5PGmjnofFXbkwnTaSNF5i2D4cgGXIGKLedhMmOObqz3FhIcBfFoPhg1GAalqBJJHmmdWLN5r6RZTGo/GClyGD3pu75Fb0vKplm3YTf4N8F1muD2cRiip+7dIau5DUyUM6XgSGrXXlAh4w7TLOk02szNyi0G/wnCv7O9CUvlD9mGAIdci5euGsA7ETMeNsbKzfNu7+OP91jkJGizOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB8397.namprd11.prod.outlook.com (2603:10b6:208:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Thu, 11 May
 2023 23:16:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6387.022; Thu, 11 May 2023
 23:16:57 +0000
Date:   Thu, 11 May 2023 16:16:53 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [RFC 3/3] ACPI: NUMA: Apply SRAT proximity domain to entire
 CFMWS window
Message-ID: <645d7765a218a_1e6f2944c@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1683742429.git.alison.schofield@intel.com>
 <79a10b7101a8fab56f9ff3f9a4de73bee3156b40.1683742429.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79a10b7101a8fab56f9ff3f9a4de73bee3156b40.1683742429.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB8397:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c312db-198b-411a-4629-08db5275d05a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9v3H08SsvccCa6K7KLUDjJy0l6u+wnAFic1QYSI1Uw5LlMui+HAkzHahJK6nS2KAvKZXfmyBBqnQJ4TAx0kI6q8CNKPtqMhpipPDiPeOqbToRQ7x8bLLTYMqlpFbVtmGhPHW4ZLlreMpAwQzWNoXMN4yeG0IalxA1bWfMle7hXb2O7Ce+rycew3zXP0miRpp4IylHFefCRS8XsilMP3abOf8I9nyBkylWr1y2CGZjBgNQktTsw7NbvbPcqDZ819FCw3ef8LC6AUHYJEPGfrCMxhYE7X50B8HTkzWpvHbshca3lp89rcbWIqEsOzfpRwXGXJBI9zePPGjTVoe78IB0QL7u+p2UUefAXIb5XkylBL/Lw1u4rol9Oi7Z9gkdvJMvrPTZHz45iFM61ph2t/rUUcpjOPGbRAtqd/ENx7OD2EBbXiNdC5vooGtebRPfL/J+cRwB7bg54ZFYzI0tHbAPg9XO+SCtj7FMCGDYUuzHOQN3t/nok2KQy42fH44LnUQ61g5pRaPqrtWAw0UsBcDQp+x7tjIl9yYhbBtjTpX2AXJW2gYTEoYCFalV/nEGcYn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(66556008)(8936002)(8676002)(478600001)(4326008)(5660300002)(66946007)(66476007)(316002)(83380400001)(86362001)(82960400001)(6666004)(110136005)(41300700001)(38100700002)(6506007)(6512007)(186003)(9686003)(26005)(6486002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkxoVkxFZUNtTnZLVDE3K0lhTEMyTGFlR3E0QSsrY3A2RU01SlgrNVhsdmU1?=
 =?utf-8?B?emhFcmd6QWZHQmlqUGZWd0RSeElMMWh2OEpwLzNGa2d1NVJBaTNJSWpmdkRL?=
 =?utf-8?B?cG16eDlIM3NBQmxPZVE1UmI3Qm9MajkyK0hqdzNnVmhXUHNWRmRsZStqRzZ2?=
 =?utf-8?B?OEhkQ1krNXFEREd6RWhORVJIb21pekQwT1ZYK1dnRmlHYjBGZGZ2ZjZoSjZG?=
 =?utf-8?B?ZEo4b0hjQ3M4RFY4NFIwNEQzdXZLcCttc3dzVGNJK2NyN1FWWFBISVBqaWEv?=
 =?utf-8?B?RzRpaGw2dmtYaTYyOEM4UVNIaFRJVDdIYnIzTXBlUFRSTXQzTmhOa1p6RmEz?=
 =?utf-8?B?NHNZeEtGclR4WXVQZTAwNGQ4aW0xNS8zMEY3dGRrVUdwR0xvRGQ3Uml2aDhh?=
 =?utf-8?B?MDBiRzFPVlRmdnFtN21GcW9LY1AzYmxTbnN4c1MwWkRsdlo1c1Z3TE1PNEIy?=
 =?utf-8?B?Vk9DUWhJclZjU2RHQngvT3pZdWFHQXUxOC9LVzA3b2xuckZxenBrU05IdG5q?=
 =?utf-8?B?UzlhRmlxMXlsMFhZQmRCa0hVVjZwTHNBWVFlOWFmM3dMRHllZDhlQURpOEp2?=
 =?utf-8?B?ZWtzMlV0em82a2NmcDRjeHNycUliZ1lIUVBVSVVBb2g1RkptRENEOXZFeXNr?=
 =?utf-8?B?SmYwZmtvN2VQVEpJWUEzMk9BUkw1UWVrSFg2alpSekRDS3IrMWRjSHRoZUhX?=
 =?utf-8?B?Qk9KaXlZZ2IzM3pXekMzTGNqbktyRHAvNGJNVml3WTlHYWZ0eUJUMUp2aCsw?=
 =?utf-8?B?dUY0dGg2V3ViK3lLeTAvSGw3RmFocVhBaHhSd0hPWFdjblc3VGJQYTVndkRW?=
 =?utf-8?B?Um1KWEUyOXNFL29xeWdrOWJrd1Nna1FaWjUwN1N6ai9mUFBoZGpJcTRNSGNz?=
 =?utf-8?B?VEt6NGViMG5TMjQ0OUVQY1hHM3ZxOExONFVxVXUrektJcHo5Ti8vcXFHMVk5?=
 =?utf-8?B?WXJqZTZocWZJSG81VEkzcUdvcXVweCtnYi9YUkZLMG1uT2ZKWHZNWS9mNU1t?=
 =?utf-8?B?U1IxOVZVbFJZSWlCQ3daN2tYbmY2YVo4Qk1pNmg1YnF5aW9ITHkrdVVqYUtk?=
 =?utf-8?B?MHF5Rk8xaEdtaEM1cnlkZDRjb2Z0bmxmbWJrZ2IwMWl4QjhkVlVydEY1VFdp?=
 =?utf-8?B?TTl2WSsxc0I4REY0RnpkNWFNUURiNTY0NHZ4VEU4QjEzU0JWNFE3MkYyMGlY?=
 =?utf-8?B?UEdkNk9EQWNON2ZkN0E3WDV2WnlxQTl0QmtpRlJMaEp3a0V1NXdBVWNSWHhU?=
 =?utf-8?B?QS93VWd0amhnRGRkdjJ5RndiRHRQd2Z1c0x5K243ZW9HNG9IOGRTWHhyNExj?=
 =?utf-8?B?cTZJR3RadSs0NEVYUWh1NkVyN0dsMDNaOC9ScTk3QVhBMFFBUmk1UEhZV3Zu?=
 =?utf-8?B?aHhjK2VpWEJYZFhPQVdvQ3BaNmRINk1xUUNTbUZ4TldSdzhoMjlQRWhZT1pB?=
 =?utf-8?B?aFphbkhyMkFDZjNsOEE3Q0Z3MUJIRGo5QzJJVlZ3aVNqYWxud29Ua2tuUElr?=
 =?utf-8?B?QjVXVWd0bndjT0c1QldnYUtOQzZWcllZeHlaU2xxSGQ4dVVybFE4bHlLY0Y5?=
 =?utf-8?B?VzFMVUduV3RsVHRvMXYwSHM5TCtXakp2TW1WUEtUdVRlZ3FhZ3hvYjNoaUhF?=
 =?utf-8?B?b3FFU1lvdFp0UlYvMzV6RmplUldOY09oMlE1RkcvWjJ6ZlduZlZDUmhWWWFN?=
 =?utf-8?B?NEcvM2VOa0xldXVpajRxYlpzNVppMm5jdHRYc01IQWd1TUtVTCs0a1l2eTF1?=
 =?utf-8?B?UHhsblRJQWl0ZTJxR2IrVHhCMHFHbjVFRUVYMHVHMTNPQWtvTEk4eGx3T3c1?=
 =?utf-8?B?QWlaaldiMytlUTVwQ0pVQXFPOXowR3ZOWS9LdVdxS0VHYWd2TFVPSi9uRzFG?=
 =?utf-8?B?YjFGck9CNTlRR3hRWGQ1c2JIVmROdVNaSW9FQnErUlFxQTBDQVRKaDVuaHkw?=
 =?utf-8?B?OEN3U0gxSmlDc2hnUjcrY052OGM0czMrUS9KVC92RC9XSjZaUE1QUUNqakxL?=
 =?utf-8?B?STQ1SWNicVlrQ2tPRGozN216NFU1MS9mcnNVYkdYeVlvK29NaDdwVDJTNCtH?=
 =?utf-8?B?bWRlcEcrcFQ1YXUwbWdSaFJweXFoSnNuVWVaVEVrcnVhT3VJVlU3N2JONkpM?=
 =?utf-8?B?ZlBIaEIrQndHaFlUUktBb21tZ3FCZk5aR1V6TnVNM09VNXlwK0lNK3R0aE0y?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c312db-198b-411a-4629-08db5275d05a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 23:16:56.7257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaR4fVJOgD12XiqbO9kTpKpRP4K/i2swNceDgJQ0ODHxv5qfnnzs12GXuOe8DcqUQeyJ85lOFqd2cVGJI/N2usOvqNNYfxItoeAjjhtIZTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8397
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
> CFMWS not in SRAT") did not account for the case where an SRAT entry
> only partially describes a CFMWS window. It assumed an SRAT entry
> covered the entire CFMWS HPA range, start through end.
> 
> Broaden the search for an SRAT defined NUMA node, by replacing the
> previously used phys_to_targe_node(start) search, with the recently
> introduced, numa_find_node(), that can discover a NUMA node anywhere
> in the CFMWS HPA range.
> 
> If any NUMA node is discovered, proactively cleanup, by removing any
> memblks, partial or whole, in the HPA range, and add one memblk that
> encompasses the entire range. That has the effect of applying the SRAT
> defined proximity domain to the entire range, as well as doing a memblk
> cleanup at the point a redundancy is created.
> 
> Considered and rejected, letting numa_cleanup_meminfo() try to remove
> the redundancy. It doesn't currently address this case, because these
> memblks will be moved to numa_reserved_meminfo, before any numa_meminfo
> merge is done. Also, the merge logic in numa_cleanup_meminfo() works
> on adjacent memblks, so it would need to grow in complexity to search
> for these potential cases.
> 
> Considered and ready to reconsider,  allow an extra memblk for every
> CFMWS HPA range that is also described in the SRAT. Is that a concern?
> If not a concern to have the extra memblk, then skip the memblk remove
> work entirely.
> 
> Fixes: fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/acpi/numa/srat.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 1f4fc5f8a819..f41b65e9b085 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -301,27 +301,47 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>  static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  				   void *arg, const unsigned long table_end)
>  {
> +	int node, found_node, *fake_pxm = arg;
>  	struct acpi_cedt_cfmws *cfmws;
> -	int *fake_pxm = arg;
>  	u64 start, end;
> -	int node;
>  
>  	cfmws = (struct acpi_cedt_cfmws *)header;
>  	start = cfmws->base_hpa;
>  	end = cfmws->base_hpa + cfmws->window_size;
>  
> -	/* Skip if the SRAT already described the NUMA details for this HPA */
> -	node = phys_to_target_node(start);
> -	if (node != NUMA_NO_NODE)
> +	/*
> +	 * The SRAT may have already described the NUMA details for
> +	 * this CFMWS HPA range, yet it may not have created memblks
> +	 * for the entire range. Look for a node with a memblk covering
> +	 * any part of the HPA range. Don't bother figuring out if it
> +	 * is partially or wholly described. Replace any memblks in the
> +	 * range with one single memblk that covers the entire range.
> +	 *
> +	 * This preserves the SRAT defined node and Proximity Domain.
> +	 */
> +
> +	found_node = numa_find_node(start, end);
> +	if (found_node != NUMA_NO_NODE) {
> +		numa_remove_memblks(found_node, start, end);
> +		if (numa_add_memblk(found_node, start, end) < 0) {

I worry that this blows away information in the case where the BIOS for
some reason decides to describe multiple proximity domains per CXL
window.

I think this wants to be an algorithm like

numa_fill_memblks(start, end)

...where that walks the range and for any gaps in that range extend the
last memblk to the end of the gap.

For example if the CFWMS to SRAT mapping is this:

 ┌──────────────────────────────────────────────────┐
 │                  WINDOW0                         │
 ├──────────┬────────────┬────────────┬─────────────┤
 │PXM0      │ GAP        │ PXM1       │ GAP         │
 └──────────┴────────────┴────────────┴─────────────┘


 ┌──────────────────────────────────────────────────┐
 │                  WINDOW0                         │
 ├───────────────────────┬──────────────────────────┤
 │PXM0                   │ PXM1                     │
 └───────────────────────┴──────────────────────────┘

...and if that finds nothing to fill, *then* create the next proximity
domain for the window.


> +			/* CXL driver must handle the NUMA_NO_NODE case */
> +			pr_warn("ACPI NUMA: failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
> +				found_node, start, end);
> +		}
>  		return 0;
> +	}
>  
> +	/*
> +	 * SRAT did not describe this window at all.
> +	 * Create a new node with a fake proximity domain. Add a
> +	 * memblk covering the entire HPA range.
> +	 */
>  	node = acpi_map_pxm_to_node(*fake_pxm);
>  
>  	if (node == NUMA_NO_NODE) {
>  		pr_err("ACPI NUMA: Too many proximity domains while processing CFMWS.\n");
>  		return -EINVAL;
>  	}
> -

Unrelated whitespace change.

>  	if (numa_add_memblk(node, start, end) < 0) {
>  		/* CXL driver must handle the NUMA_NO_NODE case */
>  		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
> -- 
> 2.37.3
> 


