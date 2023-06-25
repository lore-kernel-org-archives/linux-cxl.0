Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1164EB64DD
	for <linux-cxl@archiver.kernel.org>; Sun, 25 Jun 2023 22:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjFYWS1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 25 Jun 2023 18:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjFYWSZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 25 Jun 2023 18:18:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6CA1AA
        for <linux-cxl@vger.kernel.org>; Sun, 25 Jun 2023 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687731503; x=1719267503;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tJ8a5VIV2CXVd4gs2XIp9KGnEkaB8frIK7SnuKK+RM8=;
  b=iJLDc1fJP2zujg3+JZmjRcWZtgfRPLCRQe8MoxxI067Zfg0yctjtKH6i
   zgWsiYP+Rq8KylolsT3k9gxDjtgmD5YBEA2SoVqtm+TWgx7q3GIct/k5L
   Wukok93R7212tpNkjwfz9pmA4rXMHVY2D7X9MpP+hOjN99aHjx/4QFAys
   kSTusmRBCYb7cNb5NKLzXvoXA90FJ2knQQz8d/mdtB6HK6yfR3P6A6Mo4
   hmAQhAt+sCfCm5CdbtGfMN+w+zzwobz5yzOpfRFTo1H5I09MAwXKJURgW
   4Mi4pL5j02h8870HS46iR9hzhC8Xt4Qyx+WCCugNWy9fSZyJNaPUVzjIy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="424797541"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="424797541"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 15:18:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="745575311"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="745575311"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 25 Jun 2023 15:18:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 25 Jun 2023 15:18:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 15:18:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 15:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeDZktHHS6oRrWhdDFQjW3K7gsUrTmuTOuzE220X03k9NVHyFGo73nnrZjr0DFaIV3P51mT9bH85Woiyor/Lajf32nviyUCSyFRE6immnEcQZzUxFc21xTK2Tm2xDcL2gH5iLv6KSjNT3s3JC0quG/wkX5RJ9hQ7OupRjQD2bNa7QVjYMeUWLimFZDkeND0jKhzG3h5rRL6YJaH7FHOQJixNhOiREBXJqbjJ64YwCNMV7mHpR6nJ2EZk8dwlKg6vN4WcIXBSgaXVRyxAJcf2TiwnUfN3ajmWQ5Eqn25BjoNR74xToCbjL8NwHsNpT+u17xilTDV+z0SS2qMEr9J1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNRoYghPBKD9pCdvfUlG73cX2naZGr2PxvQa90YAk00=;
 b=UuHSARl6v4YOm1Fo0a389VMOLfvRG48nW2qBAUeO8N1U91qf7P0yptsXBWHTLR3nLU8SQtJhpIml/pqFAzKFKjO1IdpVZUqI3y8IDHInSupMSk07aYAf4wE1oPprgWfcGs6hrHgNllLU67MLbUjmIU3hyPmgPkcNOzqe+CK1rmD3/QeyquBU20gR4wOdYczvTSfyriHr3wzj4iRaeydHWsdgSbYdELp/LWdygCiVa6oIFiXUg4WdBuI98vr5nNgpkpmR9zuCybknnb9pb56IoUayPM1Hwc/OdWPHlmHBsyUTik2cZS41RdSlWLgXbRl1lZy0nwuCMqFXOxCo6S6vRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 22:18:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sun, 25 Jun 2023
 22:18:20 +0000
Date:   Sun, 25 Jun 2023 15:18:17 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <vishal.l.verma@intel.com>,
        <Jonathan.Cameron@huawei.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <dave@stgolabs.net>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 3/7] cxl/mbox: Add sanitation handling machinery
Message-ID: <6498bd2988ff4_8e1782947a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230612181038.14421-1-dave@stgolabs.net>
 <20230612181038.14421-4-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230612181038.14421-4-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:303:86::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: c4860c94-df58-458f-b82f-08db75ca1517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0lJjYFgLHVvceL/1Gkevni7tP8pzGAu8PRZO4FpzbWM0f+b+HA5POXxuiNmCpBF/KuhsX5fYYlFECFnDZTX4ouRStc3w1eHIOVgiPQaYAJb6n4UMVm/Gfk56NH1w9Q22Ui8wRpEH4GFzOV90T23FX0BtmqsJKDUpiPF2h4Fx89SHNchXeBo2rbQ0NBEFwZv198fPBTJVgfB2B6H3SjKTHN1KKGlNZeP5ig3gPDUVms2QUEbfyV9go466q+bCtGYpXMoE00w67hH8+ly7M67GWvzfsD6GFxAoVLtabpHdroeRpIOxZcDF2mizuzklS13vt2icrYo7iiHBseSVa+6MAmGkjF6ujsGlsPVK137muNrXBgHhkUbC0f3Ejztm6XooeCq5rdTbFJJ9vauuIkY6QNpf2heGc/5q8H+Y6nBXHMU/ZHUgAxtoejcbXufhXegsnVAQt1eNjF2kAX36CWhMDDzTqhi/wsi/rStpNtbDFuDEn64+rofdAwF/ml+v53cDF4mjhnq7z9Hq/i9ztLxbZsHrdpQqhJGCbxaeB32Uq3cJECohJxPQ7BeshPV4n5Od
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(186003)(26005)(2906002)(6666004)(82960400001)(8676002)(316002)(478600001)(6486002)(86362001)(4326008)(38100700002)(41300700001)(5660300002)(8936002)(66556008)(83380400001)(66946007)(66476007)(6512007)(9686003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2o5M8WYPhAbVS6W1hLgKTMsMcOjzmk+apA5I0z0HqaqPnxo1UC2iDnCVHev+?=
 =?us-ascii?Q?O4eBre4LoRvglK6zmz0LTYOyYU5uT96rZnFfCl22TrYOVU5n02nNWlkDhT1E?=
 =?us-ascii?Q?Ml3SDunczqXApHjj/Oh83OvxkJY0oonLtJdBhRa3DHbUk14OcPE4wectFpaV?=
 =?us-ascii?Q?/Qi7FMdy/Ho6vb2YLQZRpwDMabOLQykiZZEg5qnc+jOIS3xivezNviZ7b7OY?=
 =?us-ascii?Q?eI6mB5hmNOu/3uMVeialqdCqzPgnJijk3TzpEIZpWjcZ3aOQSOiZ7CBFvdxn?=
 =?us-ascii?Q?DKDfJ0Dx1AzMvYFmHeHX5zSnh+DONxIoKKaYVu8qSjc6gCv/98+ZVvma721G?=
 =?us-ascii?Q?5TAdMJM500sOVu2Qz99GYDobHu0sqMinRRxX5W/MD5x6W50lvAqLREZLT2jw?=
 =?us-ascii?Q?17WC4xnDe5OamgDOFKKIEhLCyckT28576stwXL6guDPndIPwrfVNtySYVceg?=
 =?us-ascii?Q?I3QxbNSvtZbjF0OKgDLDixD0fsL+xedATNTQ0jiXWO3h1fbVpTttloq1DzUw?=
 =?us-ascii?Q?6LxT/uRk9BBA5Zz+xRpLGDUUnoMAlw9jFuPffm+pkV9dR5m44GQQCDPDXlxM?=
 =?us-ascii?Q?6Qf4FALGPZ85iRK6IM00eWJsYdzJBJJqsnvAsHmVaDm+OZp2LCb5Gznr9QOX?=
 =?us-ascii?Q?S2UjX09oX+74XWNcd52RV2mL/FR/8kugJJgRDkC7+FlyiFDNqukHu7bD6pCX?=
 =?us-ascii?Q?Yi7ZD89Y1jFGCMDznVAlPn46hvUJFxmom1S+KIju0vT1AgRGGTkjqHUolBFj?=
 =?us-ascii?Q?UMtnwcVy9ZHTENdfZatWuNvI+ozhtRprWsOgBOEi4FnKCDcqnDSw3r1aVcpX?=
 =?us-ascii?Q?HkXU4ryquei5FYpfcT/6siibF7lG2Pal26hOgH20JpxvV3cFcdEes191Zkg1?=
 =?us-ascii?Q?t44PxyP786WmDAbRK05nZI0JiNGBgOqhVdl5A1JVYvBs6abVaQuaqUW30HRj?=
 =?us-ascii?Q?ZkMXpMqYfcgXGJJTLKo/4GcLcr+55vwvc6O+5hWHNVOi2CXXyPwtLflGi9FX?=
 =?us-ascii?Q?BMW3aOOQywYG2UAiFD9QJKJHtnUvY9cWkirwhtRZSnFamANfZT/QlufLZbiw?=
 =?us-ascii?Q?fFWeD6R89XE2taf/h+5THBd1i3pdJdsxJ1JvVb2HA/nXlm4NwnilRLzeJBhR?=
 =?us-ascii?Q?KCwRiNb9yxMSR/PXoZ+zsH+hiqiiTyAaiARuR4E/Ef7dTJkOHs4Jx0oU7FMG?=
 =?us-ascii?Q?+MDwwvRyAeR/Ua8V+vUQVJNnvjwA2tPtZ+X0nhFQ19yFbZF5SE12gYD3ZE7s?=
 =?us-ascii?Q?6moiJapsmTod75/nAJO9yhSZQBg8E1wfpqc01GMDKNmmW/teC0rjF2R9xXNp?=
 =?us-ascii?Q?EOxVFwoE6oFL+igfKP3p0idqFBSudjvlwUJZB/UlGtHCzdSuqE8TRD9zyNoN?=
 =?us-ascii?Q?d25RHYQbURBV2UzP2eV+4yDPO3dGgK9eRJwcriMmcV1xq85xZo0aXE+KGe47?=
 =?us-ascii?Q?lG/c4UrM4oSeUKbw4e/9gEdi9ldq8nSpdytOOuQ1QT/itm6v4Vosl8NJQ6Ob?=
 =?us-ascii?Q?UywFlhfCi33z4onb1wPmII+4bX9czYBpDQJ648pMwshXsNy0hbccV/rL2X+k?=
 =?us-ascii?Q?BuwGIHIqe3BwjDisNtsONG+NkihWBasaeaa57CAp5ZNmr97/uX7DkKg/7yp5?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4860c94-df58-458f-b82f-08db75ca1517
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 22:18:20.1961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJUo5T0EMroGENgHI65E853QhR1dgufhNQRRg9ft/nj2VPnkPlwpBdvdH6Zvpnfr/8ll5bIFVtTXVegCdHeKRrDzixYprt8cTuImmi/PtZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> Sanitation is by definition a device-monopolizing operation, and thus
> the timeslicing rules for other background commands do not apply.
> As such handle this special case asynchronously and return immediately.
> Subsequent changes will allow completion to be pollable from userspace
> via a sysfs file interface.
> 
> For devices that don't support interrupts for notifying background
> command completion, self-poll with the caveat that the poller can
> be out of sync with the ready hardware, and therefore care must be
> taken to not allow any new commands to go through until the poller
> sees the hw completion. The poller takes the mbox_mutex to stabilize
> the flagging, minimizing any runtime overhead in the send path to
> check for 'sanitize_tmo' for uncommon poll scenarios.
> 
> The irq case is much simpler as hardware will serialize/error
> appropriately.

I noticed that this series bounces back and forth between "sanitation" and
"sanitization". I think everywhere it mention "sanitation" it means
"sanitization", right?
