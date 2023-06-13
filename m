Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6F7EB64D8
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 23:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240839AbjFMXrO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 19:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjFMXqv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 19:46:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63405273F
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 16:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686699946; x=1718235946;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IwKs9pgyzgK/Ym7Ya+ZODy7YSC8vuUmpABnBiug9OSg=;
  b=dTNbbVUcRuia/hwFmX6i5Gki4zeETuUhnzj4zKfi3PtiTcTXfLbvwrYv
   8VLcl2q90K7ZJlGhAJLNkHw6/z6MeWt3o9ZBL+d0HL2FtY170DIOD+hpv
   NIx7vGmlYRRLK7OeBSeN1gT7pFemFIyJQn0NNCVGu7bswmsF7XXiFATMN
   +34GiZfC4DVPRVAH6V/XP3nPgO90Ci6h0pWCeOHawsh3PwrVH44eqbmYC
   qAyiyUlhMrKOxaUBxaW4MsF/qgjXtIQBYUVRw8r40XiVEY1G87SOi7TI3
   A7GKwI+XxHux60TIeC0CJI7DXGhxyhHlLSwEon911YQToGqhtj5+1BNXe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="386881171"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="386881171"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 16:45:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="705991148"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="705991148"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 13 Jun 2023 16:45:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 16:45:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 16:45:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 16:45:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 16:45:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTPmACxJKEHAzPVymfATjsMjGDqWM5i7TvNvjUQSkPKsKCCEVShsx7atux6HLA2LXSaKs5SKOytx+jDqeaXx4QgpKhxIQ62endRkOXmrBvXyisRehWLOp2F5gT42KARBnz/QBKAlFiBXQSjfjCn2OTVKLS5eDvlKgbzQpHdYCPnKSZVWXNafYE7NSja2eQNBO1Z9wwk+hcqQ53yjQD1rAc8KSmvHWHKcOTaywgQFAZTyFYNf+2ItFzM82Zvdw3EtOOUmXg9G4q2W7+D/l6lKg3sFR82Mvk/A7M3asUwtdQ8GvoZTzs4w6S4luiG9S4m1RJ+LoMQf+AFEbZh7buqczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=he9cAlAgIli7wIT04CWL7JOrMGb0fhND/QClxx1IaMg=;
 b=A8xL0eJIKmGBYMcieunNhkgeOS3jeh+bjgEkB3f6TFzEYjZMXGzEyotozFtGFmshXaPOj9HJfiseioBhJ0oCbski6tKxiCuY2xykhm5Cv2jgyyKrrNqoAjIYy2maVAoO/rksuWlpPzFuONtrZO20kiEOnK0UhjQy2pxyTZN3YyXdQsWjruUtjP9744c2A9b/V3YyYfKicXtF4B3rhNgtsDiDo4Vzue/ehRsoyLtD5xDFaNgFHHdwuXsM0aD1uaZIxOj3P0a/4hg3mRNVrhCgklTGzwnsBaEEipFWDah0kDVc7bN+KD29lPGA+cuMQax61QISzuhzRYBj0fXXw0kc4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB7615.namprd11.prod.outlook.com (2603:10b6:510:26e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 23:45:25 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 23:45:25 +0000
Message-ID: <14e827a9-27a7-06f0-bcf3-653e1e74648c@intel.com>
Date:   Tue, 13 Jun 2023 16:45:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH 14/19] cxl/region: Clarify locking requirements of
 cxl_region_attach()
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>, <navneet.singh@intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592157618.1948938.9911784721014622223.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168592157618.1948938.9911784721014622223.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:74::29) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a53b330-bbd5-4b0a-9d52-08db6c68422a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4IDFV/1XRf5xp/CGEDfpdVW7wWlq4DjFIef6S22dzvFl9s4g0MiWwTAVyeYTgL5gy79CSot7C8/tFFLPPElh00yR+VGc+035SsutlJv5z1wHqdbBZ+fkriWkNBOWFzWunQllBj+mMiklVn7F4boeNJjHa5c6p0I5zAe9uj33IXwBuihrB+ULpct5GdBKGUr0nti4dvDDVIK/fHmEMqNO1Fg7lDnb9NKArqYB52P4YZwt+Cf8O4MD5XzaSBGnY4DtBa1sh6bWye0o4DoIuruhlyj+b8tiar/ummiCrUgRiPgq1jlNSolG41465vQjqqMwLUFoYZYdH9ZiNuOjAvszvJGfCwsDb0QsvMdNxnbDrm7Eb+eEreU9ffGNeh5HOC1MfPMWWxhN4Z0pCz/ViyBoSTN9EymH+9aaDpfCNWj0t8YdP/BZdP85X2RtUE8L5Pr+GB2PGN+JG/cNV8gmt18M7PzOiULEAl5d1da3g49lD57Tt6tX+DkXaxNyGH5sUtltTly/yCyAvcCver+GfTVFAez0Zl7ZmakdDrEjceKOFq+4vQqMSVef3Zx+qdjbRZBsap/flzpEmkWCWH+1Gqt5Q9fAyRzFY9f6I0SfQe0A1YefesvZRea1rZk4/kdwSrnbWuaeEFJQ96Q6dY1wRLkjfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199021)(5660300002)(4744005)(8936002)(8676002)(2906002)(31686004)(66476007)(66946007)(66556008)(4326008)(44832011)(6666004)(6486002)(107886003)(6512007)(26005)(6506007)(53546011)(41300700001)(316002)(186003)(82960400001)(83380400001)(2616005)(478600001)(31696002)(36756003)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmttT3Z2SUU2clh4Sk84Y3lzL1ZoZlFwVXJQKzV3a0NreXNiYThXYnV5QUND?=
 =?utf-8?B?UklXaEI5VjZjRnl1T2E1cU9nTFRnbWJKTG00S0Z2OXR1cHlOK0FFRTcxUlRF?=
 =?utf-8?B?TUxNZXVyS3VuSjliSEFBM1JmeEh1YWdiaEVFMkRQdmE3N3EvZktWUFVvS1V0?=
 =?utf-8?B?Vm5XOFViVi8rdkcrR1oxKzVJRzU0eHh5dStMdDVJRkQ0ZC9NT3hNM29WZm1I?=
 =?utf-8?B?VVlYZHJVU1ZUbXp5cExnZzd1ZkJQYjVhL3NOVFJQYjJEZjVUZ1F0UlJyQjhJ?=
 =?utf-8?B?UEphRks1WnJaMnNFNFpvbE04c2RaTFRRUmFvS3B0RStEMUYvUmZYVHZyQUpa?=
 =?utf-8?B?cnI4ekYvMEFXNk9sZVY4RVdvM2RDU0dKOVhpUzhQQVZGV0VrMVZmU0FDcHJr?=
 =?utf-8?B?SVR5bkVkWnRuYXZLZFErc1RzVmo5L1gwQmVzc0d2WktEcHVHMVNqR2tjMTAr?=
 =?utf-8?B?SXNEL0JDWW5mdmRLdlNYRTRwWVFzVXgraklaZ0JROUtqVGEySkhPRHZHUEJG?=
 =?utf-8?B?ZjlVQ2szK29nVW8vUU5vTkNkZlFvdjFkYTBkOEJMM3h2dkxmYzd4YVJMVjVX?=
 =?utf-8?B?VWJRajd4MGlTY3NCL0UrM0VUci9zYkptWGZ6a3g3V1kyVi90eHVqWGJZaUlJ?=
 =?utf-8?B?THpjdlc5UittVjFhN0FTSEVzT21mU04rYkFuQzRhQmpuUGwzb0JnN1BlRGE0?=
 =?utf-8?B?eXdKcGQ5TjdmUlI3L2JkVXRkaVFEczR3bmJZdVc5MFk0UWlhaTRGMHF3YWE4?=
 =?utf-8?B?c2pZODNPLzZIOHBQVGRoL29scWZxb3lXY09PWmgrS1RNbTJSam9CazVQWlRJ?=
 =?utf-8?B?RjNKZE1CcEUvZmFaRlpsUGhzZDRIbWxJcE53Z2FHcUpIZFBoeFQrd0puVW9K?=
 =?utf-8?B?VEhvRGlKMDNNekFZNDMwazhmbUN0Y1Bnd01tdjFkdDhqSU1oQTBsaWFkbExR?=
 =?utf-8?B?VmVnbUlaSitqNUo2Z3Y2NU1tanlLclhzYng3R290ZDZ0cysvK2RnbWpPSWZT?=
 =?utf-8?B?Z0xTb0d0QzdGbjNHeTU1RnBldHNWcHNpTCs1TmdBT2J5TG41V1pZbjQzU3BJ?=
 =?utf-8?B?OWxUVUd3RURPWXRvdXJTRU1lUE9nRkhTS1NrNXg5U0VBUUZ0TW8wRC9USXo3?=
 =?utf-8?B?aDZybm5oK01ONDJ5QTVTaGtDMW5nL1lPTGcwVHh1M2pFVkxqSitwTnp5YXNj?=
 =?utf-8?B?TWxGaWNBNXRwb2p2ZDUzYlp2R3hhdjV2K0NWOHNnbHU1TnlPcktKbHJBRjdB?=
 =?utf-8?B?Rk1COHZ3UmJDOS94OW4rTDhsS0U5OXJNM0VieGtxenMwME1nSmVtZGpsVUoz?=
 =?utf-8?B?Vk5LeFNmUHMwZmJZeS9NdHNLSWtsWWkvV0ZTQlg5WUd6UExFNEdnU25Sajkz?=
 =?utf-8?B?a29ZUnNVOWpOYTJuMU50aHB3WUp2T3BpeEFNNEFNRzRVbVlYTzNFL1NYSVBx?=
 =?utf-8?B?OWlHM1ByYWhESGVnbEo2NUlFaFNwcHo0S0Y3SzNjVStBSEExRURENXJwVUlk?=
 =?utf-8?B?eHRJMW9weno1UEtFK3d6b2piaDIvY1NTV3pVVzFrMkVFekwyeEtrR1RrRWpz?=
 =?utf-8?B?RTYzZzlEckVTR0ZRMEh4aGpFVmJkZDBaWGI0Vys5Zk1uSFJGUERVUUtrc3RH?=
 =?utf-8?B?cjltWi9hTFN6dXVoOCs5clp2Q01WZ3ZJc2U0NlBsMWVORmZpdHRyNkdydzRt?=
 =?utf-8?B?UlVhK0JOcGt5QW16RWlhRUh5aGhRaUt2SnJyL2hoeThTd1J1YUNycnR2MUpM?=
 =?utf-8?B?VWhZbjdaNkl0eUs1LzdlSzgrc3JuUFNOWUd6aUl5dkxrcjNzd2RWajZMRVJR?=
 =?utf-8?B?ckFiQTR0ZlVoMVdTUUZmYmRxU2dKTmRkOVU5UFF3Sk1mT3pNdmxmbkYwbmNv?=
 =?utf-8?B?dlhJNzNhdjBESFJzKzJrMG1hTW8wWjVTNDVOcXUyT0xrUTFmeWdXR2RKbGNF?=
 =?utf-8?B?TzBPRTBrVEZCRVQyVEMwU1djWjZ0T3EvTisxZU9KcWRaaER3dzFqdURnZGVC?=
 =?utf-8?B?SlU5UlZEeUUzdjZhRGFoM0VJQ2ltbUdYUm4rcWJUbnlJRllVSDFzaklzVk9E?=
 =?utf-8?B?cHQ1Tloya3RqM1dSb1YxdUJmYWI5bVp2WDJDUXA0cVhpbG1ERGgxM1lYM2dL?=
 =?utf-8?Q?x9YudZU+s7cArm1xNmbCI+syT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a53b330-bbd5-4b0a-9d52-08db6c68422a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 23:45:24.7443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiOfP4vjmi6sQ/GI93cW4vOKZzltIpKUJHWAiaBbVYVusK+8XusQHNdDwgb7SCpWSZ95e3Pj24kQHwOpmYp5Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7615
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/4/23 16:32, Dan Williams wrote:
> In preparation for cxl_region_attach() being called for kernel initiated
> region creation, enforce the locking context with explicit lockdep
> assertions.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/region.c |    3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4d8dbfedd64a..defc2f0e43e3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1587,6 +1587,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>   	struct cxl_dport *dport;
>   	int rc = -ENXIO;
>   
> +	lockdep_assert_held_write(&cxl_region_rwsem);
> +	lockdep_assert_held_read(&cxl_dpa_rwsem);
> +
>   	if (cxled->mode != cxlr->mode) {
>   		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
>   			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> 
