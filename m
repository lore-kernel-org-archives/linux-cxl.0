Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25322C77B7D
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 15:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjERPkl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 11:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjERPkk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 11:40:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6FCC4
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684424439; x=1715960439;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=txJgYbdV8zpm2Gq9JqrMcTSuNLCHfrUXF872XKt9qbo=;
  b=CBtVePh1TIiAhe9tPhsWRvl8CgLII5x8klX9dchr22qsTxiVAc8pa7jX
   kZQZr9e+bncerrJ61hhPfPYEgY4yyDEMMSiI39w8Il6NM2ncesHQJkeh2
   hYRaNWNyGbuvDx0jP8LUAA3XZJ3ugCPRC0a/OvfhAM312TDCHQboVOMzY
   4wpeZjW2n9TlXxJ4gX4uzPE5PV2JE5nHJOhjczOiYISo0LZYbHYo5yqUM
   +ZGIZ7TfjLFAjAbYBvQ1c9vOpb8SR0wFfotXxUvRRl++eE8aldq5KJ7fD
   Yztt32cU81jZyrQmechX1nP44lx//dnTFiwvVBbsMBQ8FYun/6WZGcAp/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="415547967"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="415547967"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 08:40:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="771916904"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="771916904"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2023 08:40:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 08:40:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 08:40:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 08:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjQoqke5DGWJhkh0qpQ7mfxzWLWy326P48boaIaqQy7E0QaGCqBjUQu02QVXxLCtCqSXKBWKtwXetM2gsY1G2V6AZqEtbFG+JMRN3MwAAhFMr6QYkmgcFHJU83m/3PY0bho8hF5GWgyUrlcGt+6no//0WXEjQy9iTu6A3QJi6E4o3jgyG4N1MEHAesABqYqZ3QUSAn32DPl2afza3ggSht+fSju9UKkyOl3GtljEz4fk0JsbmItAjCDPsVYVFosWVK8ySDHBd6Ui2OhKCQdgKg2ZaB64PRc50vOB0uflWkmw6NiDF1aPYnmc1BVEd0f3FFCXh6iFoxNsKZQRUZwDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azSYNUX/rgQP2b0PvfMrkdBTap3++B+0CMYsWdYE5Y4=;
 b=XyHqJXQ7eHML0R3OrPTf/roRyL8cFgwfmH4WDd+FgaqqlqlgfOFrgSXzVNfQRGwnBKN5BLkYzRp6/1lIyO0B68uQI3XHCJ26gdVDvv89FYrHm9Edk3s9lqcc4T1SaMVF5IoYEql1skgZzLWy5+YYa8OVLBIzBfzDQ9QtkR4TPJpYqDXzyFdtdB55cvuM16HrpU0H1BmXokp6QLcwDqxkqEuznIRAirvcKjzwNfe2VI+OjJQMJ6Zwor1rHlk8e3qQLJav/JMTHMgkAmjpmbzv6+mLUoo8CNQva2aDKdEJI42Xps7eLW/5SsOILO7VBJR5tSxoHSlpanLuUD29E/1rEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7517.namprd11.prod.outlook.com (2603:10b6:a03:4cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 15:40:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 15:40:36 +0000
Date:   Thu, 18 May 2023 08:40:33 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: RE: [PATCH 2/3] cxl: Move identify and partition query from pci
 probe to port probe
Message-ID: <646646f14f173_163ae29467@dwillia2-xfh.jf.intel.com.notmuch>
References: <168428284429.2205351.8883627879572769367.stgit@djiang5-mobl3>
 <168428296504.2205351.15006863208285686036.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168428296504.2205351.15006863208285686036.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:303:6a::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d120c6-f174-4c0f-4e33-08db57b6399d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hR0ZmpNjclTqgWbCHPIv7UTTW6jE/nT2y0WYKsMvTiRdnNIKr9oQ0NcZ/x8OBrNpoXYVfGCzm8OfVzrLxdsrAIWf6LIdp9ypiauFHp6rNW76Bm+cbBMsFyt+A4gtPD2X0U/FNGdz27eGyqDhQcO58fKVpPhxGnXPssDTrOnvceQoDRAKb3PgOfu/+GWpcOx2iqWv6j2okYCHC/JHQmwLpnspMugQmaDi1bTdljjtj8fEyCSsz8W2Y0nYkgQ64+H+IwFlbb8xk/o39I2VZoXGB3i12m9ivKMkvhGHrGUzSPOXtRb5XxWeWfVLeWD5taZAXD2R1JNzr82OqhEOmdU1LeBGwRJwZtqlzT6hdp3uvNZFz5ch7G5q3XwKGF53Ud0iCf/oR8Ip8//OKn6VQXD3Qb7NLmgqwLzldLwUB40oLUzih5gmnGYESdAQZ3TialwPILzVzBU95vazycn13xJ+Q4XeCfbxMwnGL7tUGuda9jtQ9k5lPVRo1+5dPjNjiB57kyRsey9KKa0C8WxE48bz71Z7F86EJq+WU7zno3f0oZVCi1FK3z7JsCQpWqClJ93M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(86362001)(83380400001)(82960400001)(41300700001)(38100700002)(5660300002)(8676002)(316002)(66476007)(4326008)(66556008)(2906002)(66946007)(186003)(6506007)(107886003)(6486002)(6512007)(26005)(8936002)(9686003)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KWzr7nMeKVCff6fuLo4t6XlFHtyxJSGFmayo0Mno3m697euyLWbPnYMvh/LW?=
 =?us-ascii?Q?DubWSUyaZSanV2MlDsvEeeJaqRDXYAIjxd0pJG2naBoH5tkqHH4zNrDRdVrp?=
 =?us-ascii?Q?9B6coAIycgbD3CYTE9P2V9GED00srq/i2A6Z6/LK7+yVa17moZbIFvpBEGpW?=
 =?us-ascii?Q?/JYuXjmCJQyx+jc7A7pSo7Vq9a4rua0eK3lFwwndJymU29Wcr8wTBTgefb06?=
 =?us-ascii?Q?lA3Ml+oVQDtmz17YQOPKURQ49HNcyiq2/1vRz/Qf4QE93/PsALqzsn9LgIBo?=
 =?us-ascii?Q?h7nGrZbCIrdy2aXZ22Di60uWStZsXDW9SxwzYE+B7tDzJGmibdTgroMWPMFL?=
 =?us-ascii?Q?Kr4fqVvWNdwb2WWi40bHfu9W5mvFzEY+899lUrdgDqa/T5Nu7PY0eH7ek0OL?=
 =?us-ascii?Q?7UOXCSYZmGyP0+/2Evf6bdDmimdohYfeHyPU8C9OQ4jtEZUtMurHTI5CUm7i?=
 =?us-ascii?Q?kmceAy0LFRqzXUqz22idaTihcqbGRjIk5Fp2YIzwE4CB5o+q4qPdkr9rbvQL?=
 =?us-ascii?Q?6ocXky7eb0HGJOiN4xPw+gmJYumCc21wVVakrMztXhEE2Mw0SKUt8iexocIi?=
 =?us-ascii?Q?dUTcMPT+jEG7IO8zn7duxcBEr86zGaLz9Naf3si8EVd07ZtjvUdVo6bEJCvq?=
 =?us-ascii?Q?zSQUogUQrBuFaiFAfuHKZmXPunsSg4jkb81Z8RKYDQWwaX/pDcrIr0gDord2?=
 =?us-ascii?Q?5h0fmcSxVhRGdeaRtlfymj3MIKD8SaqvYX/O/yHi7skcG7Rq33vb3sHEzMEc?=
 =?us-ascii?Q?B6uiEznbp1qFRa5Ugee7+ZuYdeUKmu9aRu/1Hc+wHUVf5monlUeujDIsBG/C?=
 =?us-ascii?Q?m6UdXk/MMGpiAxC6rP4kGlhVy7E9BlAMcBMjtIkhNCYQ3ZKBD8A7YTSnHjf7?=
 =?us-ascii?Q?oNo/jK7N1jc0ZQN6UqDJcJWKXYkReyBcbUpA6aw57awJTg8Mjx7RUwRGx7nL?=
 =?us-ascii?Q?cJfg8+g1vW70X6FrPwTgZxTbzE3qETIyS2+DcsOCgr+Ej2mJ2I3kJJzWdYxt?=
 =?us-ascii?Q?bW9G9UpqXUi6lGCDkkk3WybiT7dLuSwFiFAC2YTxyFKouint5qoBiBMuoqc9?=
 =?us-ascii?Q?uuihUEBQ6ebakXxBLCSf4j+z8EcxyFxkB5+ijED9dHB7Hx3LC7IPw6OLiSgW?=
 =?us-ascii?Q?sVJczPH1lSyeQa8MBLO9qQLoDF+cumEmKiOpbc+QyAoKtn2dHRY1OvVsKhF0?=
 =?us-ascii?Q?67SbbgjDPB94cceF9JrJ/yK1tnDYUpO7hgWYZtdVteA8l5+b3D0Pes19Q0Wy?=
 =?us-ascii?Q?pTzlGNX6TUNLQUUEr5HqQrm8h7Zf7/8meEsh0KsgIKwc1+d6Vx4qh5OV/nm1?=
 =?us-ascii?Q?Gpx7IrQ2MKc+MvAeBhejf4Z+M/w/HZd1Giip92A3sxqSDm6k8vXm0QD1F7N+?=
 =?us-ascii?Q?c6hHSV7iQDSSLiY4aJkjfejfeZ+n+QaPBHDdA+xyBOedROd7pOQUhJCbGeWV?=
 =?us-ascii?Q?yGeZZ+VVkfoQJrA8P5rITxcnor6ePhS9WPYIsv19beksQ0vo1joH6CKlLyiu?=
 =?us-ascii?Q?wy97klMDuLDjGSmjWYYmnQcfmgSxhVBz4j5yw+QJ/mYYG+XyCWA7GcWIyET/?=
 =?us-ascii?Q?QTGrQ+smB3AjcafQKFvbg6tudMPIbpSYXfvYFxRTbapIxQffgPL05UG9eF8u?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d120c6-f174-4c0f-4e33-08db57b6399d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 15:40:36.7127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnCq59Og+QVCYkbepPrznJXkQmTfgUOgsbfAELmLINv3zIz3v+T2N1u2hkpOO12N+bu1+6o5wYydNSzy04pOOuDrvA/PswqQlZN5emkMnkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7517
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Move the enumeration of device capacity to cxl_port_probe() from
> cxl_pci_probe(). The size and capacity information should be read
> after cxl_await_media_ready() so the data is valid.

This causes problems with our current sysfs ABI. What does
/sys/bus/cxl/devices/memX/ram/size show in the interim? Now userspace
needs to second guess when that attribute is ready for reading? While I
agree that it would have been nice to delay capacity determination until
after port probe, that ship has sailed.

Note that cxl_pci is already awaiting mailbox readiness which I expect
an implementation would want to put behind the media ready event just so
it does not return garbage for Identify commands, however that is not
required by the spec.

All signs point to doing the reverse of this patch and moving
await-media-ready before the first retrieval of capacity information.
The requirement is that any agent that registers memdevs
(devm_cxl_add_memdev()) must settle the capacity information prior to
registration.

> Fixes: 5e2411ae8071 ("cxl/memdev: Change cxl_mem to a more descriptive name")

No, you want the commit that first introduced cxl_dev_state_identify()
to cxl_pci.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/pci.c  |    8 --------
>  drivers/cxl/port.c |    8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ea38bd49b0cf..0f85e59eb60f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -720,14 +720,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_dev_state_identify(cxlds);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_mem_create_range_info(cxlds);
> -	if (rc)
> -		return rc;
> -
>  	rc = cxl_alloc_irq_vectors(pdev);
>  	if (rc)
>  		return rc;
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index a49f5eb149f1..40e7b7de8bf6 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -114,6 +114,14 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  		return rc;
>  	}
>  
> +	rc = cxl_dev_state_identify(cxlds);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_mem_create_range_info(cxlds);
> +	if (rc)
> +		return rc;
> +
>  	rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
>  	if (rc)
>  		return rc;
> 
> 


