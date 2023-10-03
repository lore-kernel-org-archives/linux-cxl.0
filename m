Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72449E8FDBE
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Oct 2023 22:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjJCWkQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Oct 2023 18:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjJCWkQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Oct 2023 18:40:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C94B4
        for <linux-cxl@vger.kernel.org>; Tue,  3 Oct 2023 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696372813; x=1727908813;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S8R8EC6Ad15ZJVkLfQIgzG+ht+Nj0z8V5P41B1lsz00=;
  b=Vfoig8UmseTCM7vk57t/WUJE/UnohPdAkk/wmvGaluhcr6oStmmb3LF7
   OUbCn9psERUTCikSniVud8mGuN2DvVK7jZBlALXbMGBz4n57/SX3B+QWe
   M3EwE2I7H2JTCrKMLHCPh47SkOR3ENyn82DdDakkF/bJdkHNPYuA8OIfB
   B/jmM9zeKmpkiQCjuZBJWnxulRctPBd5SNlxTNHtmYTlCE2vxXUY0xt9F
   EbZ4Et48P7TTuK1e4d/+B8iZkkpqjLDG+rpr/vsUK1HupPBCRakua1FgY
   G6uSQqelZXq4nFzZwBeqnTyrfBC0ex2WAkjJ/tJXB02XJZOlekhamZb1M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="386866271"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="386866271"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 15:40:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="744660667"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="744660667"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 15:40:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 15:40:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 15:40:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 15:40:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdGCdLUla7L6nuHnkVk7t+cq3snqjTCLaqljd7WyzzibKn++Rl5U94yU02iplVrjm9/9YP98nm3q+Q1/RZDVzINX+h4fgqjyfiz+Tt1uGGwjFLMWNoxVj9Y8CT76b2S0P887uqUiGgeJOak1xAdSS5pdV2A5u4hR1OSMK2XLrXrpyDbEb+BwwvgQaM58LRHjeRJBrLJnZldNF7+nDMy7P+3G+2QeIhUxyRimtDYr1pp3FVkbZt3uI4prOzdO3QiaGieF484r0wXpPSJHB/HZkmc/2XbsHk4/yGpNGDCDthfJImaOZ3zIIKO2cBxsI/+3b6oBdvNWrJhU3WCfkuprJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDSOEQU34ahd5ym4NnWV0Z7i5rIExxjBIhCd/IGorWw=;
 b=U7Cuckyv6c+pcGydm1LfoaDK7e6vpVE6mqq/t5r7lI3EG38pKG5KVXLn3iEujBwW+7S7f/tMvcw22mzztObSebIoiQ2KG9UyvS0UzmFSpFeYz82aEPJ98NAQuuG/kmYxwCjseGQgoiwl+PEJGhiSWmN3/BXbia2A11ctUoy0cfl5wPPuBkaQbXwI0RwyynLQo9xrExt/sAmv6iaP9Lb20GRQF5Xp3eLmgFjzDa2d89mDTnMxwcG/tYf4oheKe2PgyTy57brcPOJlxTcCU8Vv8zNNFyXiOCWhWlZXuV4weZFf1ovqTaFblJo+Zq7SkCTWidJ9y9KLdZN+y2WGaTrEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5292.namprd11.prod.outlook.com (2603:10b6:408:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Tue, 3 Oct
 2023 22:40:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 22:40:10 +0000
Date:   Tue, 3 Oct 2023 15:40:07 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: RE: [PATCH v3] cxl: Add committed sysfs attribute to CXL decoder
Message-ID: <651c98472dfed_ae7e729495@dwillia2-xfh.jf.intel.com.notmuch>
References: <169575398814.4028282.11591056324662123995.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169575398814.4028282.11591056324662123995.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW3PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:303:2a::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5292:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a483c14-6e38-4d10-9341-08dbc461b32c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKQvrmS8DUC6iaf1PHvFKhShiLS5LoByTqekMNm5W3Xpfm6nNunctQ/kEl/QAGuc2F0w+5qwLe20VDwuNIP/7w7VcHgtAvIS8zAlIoXIr9uwfIGJklM5OgV7Ffwi+B5UlPHnHM3hyGBBzwkNMVeJKLGunMqYOY7jujkZN4v2NxgYJdUSWCo60QFs4yQyjaC4cPGNGWbwv+Wbf/v+vyOSVHzK8pcngnA8q/GLC3S2u499VttoKioWgnmqFzUBK0THPMs5hJxQfuWQNiVqBYjNNnsnFdfK6lKmumw1kS4JegVfyZ1BcwA/dnT9vUbMa0iBRQwnyhVU4qAJSzHZxb/59irooBLpq8Awy5YnUazxXWxYTRWYwLdVckC/m960RsepWYDC0EKXcyB4LJLaQRrmBns1vXOangvckOOBlQQeTJeZZ4lCYlBC3CmXlWKAjAC4EAH6klB4fkh9wtRFM78UfPnkGpO1UPSuYZup3AMGN/sGs4t4l78J4tl039xHzWsvaM/pFnfSW5fVjl7/kstqpePtwrmrQmjFhLBE3g3NzOIz7wXnggz3UHPyTRDPjQkP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66899024)(83380400001)(316002)(26005)(66556008)(66946007)(66476007)(6486002)(107886003)(2906002)(6666004)(5660300002)(86362001)(9686003)(41300700001)(6512007)(82960400001)(38100700002)(6506007)(8936002)(8676002)(4326008)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JQRBfCTih47ZE8av9qOLWNS4LsVThfWBMKrgge6hdl+qX3iWAsrGlsA6lUPD?=
 =?us-ascii?Q?bJ5qbSgcwlUdCv3BrVXrvw1b4zANH8klu3CqMDHlVbcrmqtGEusT9UYR81lc?=
 =?us-ascii?Q?CkTYoOF6p67Cr424JB91uJvquggFx/wW2Z0lJOoELuzCgEqqpDapiPDRCEoI?=
 =?us-ascii?Q?c2JJiZ53yDHqr2qFFgQlSTkhNE9cTbx06VO5Yf5RjnoIgy046RKmlffLVK1X?=
 =?us-ascii?Q?LYvDSxVxsqUVgBu11US2adQ/PB+zaLjE6afq7j3tMHF0mbiA9pw1584j19B6?=
 =?us-ascii?Q?xwBaIDb19YeQJ3zwvQQwErYzNmDAck7tI4o28vInG9O1n9qBryC9VBHX98xJ?=
 =?us-ascii?Q?TWhNEgFF4mfzu3SXJFgi7/4Hda/R+rBcEbHEVOduVSP6tp1RzfFDoJisNVu0?=
 =?us-ascii?Q?ae7pr4sA7chM27lSc0JWlP8vGEYbf4WB1/5J7yNPT/r/X/h6UH1fQIxJnCNq?=
 =?us-ascii?Q?BAi+u3gWwOra9MEsLy6Z/pIosfL/4WkrTcq/4Uxt2VOTk9nxHEThFe+2MucH?=
 =?us-ascii?Q?8MpjipzGb6+qPPPZKDcv0jLcN1XrT/6Yh4L2ol9T7G/Eyg/LB4+Mnj3XtGi7?=
 =?us-ascii?Q?LnSgCdZBFGXXSr95WJ5WRAkR5Zu7SmBUkaYCIIWB8Hr7piJk4m7JRYggij6v?=
 =?us-ascii?Q?Wpzj2GfSgj49ruRT1KqjYlS22jmblZgwm9BqbGFqUf9whBrb51HhdndK4wQs?=
 =?us-ascii?Q?tE/ss37Xg0sS+jh5a5C121629eEz2lfK36uysTGA0nFQavZ2fb8N/EbJVWMX?=
 =?us-ascii?Q?ZnVRacNYXU79ApznM89ZGVWuUSHB8za3rDgE3R5bj/GN/Xtmd0xiEwrPWOt8?=
 =?us-ascii?Q?TlKlKUjcspnNBP074RomORJgex5+vWU0tAsrNTbaOl3MYEER7cYM+LSMrvhv?=
 =?us-ascii?Q?D4tRgxFGPMd1FBdAGiLDaBwjpPHFLm9MsYLXqmYC3p+bNyO3S9MyhjIFDjLY?=
 =?us-ascii?Q?KPHsG3Gnpve2C9tmPseJZ7fp0CqWalz2vBI5fXUpZ2+y9fXbqOjaH7Ofxp6G?=
 =?us-ascii?Q?buMzOdmjb2g2yt9HO+PY7UWKu9+pKGp9ciG4pibqf1oHZo85myWMQUODXuvk?=
 =?us-ascii?Q?q0YcscFNuvrw/gxQGfvE+hsOqLyA/96XROMT2SYAD8F5AG85cBRQY3Q9j93P?=
 =?us-ascii?Q?2MgMS49jNdNyyDdOfWM+cJIMniyxNBsvFMKxG97a3MmINWKLpHM26vUjs7pN?=
 =?us-ascii?Q?6QvkI9FNN2DT0dmrh60MASXho8fZF6DOfdE8xcEfj/KBfozZ6RGlnaH39ueQ?=
 =?us-ascii?Q?x+tFpaOph7xlNuKVqyFH69roLheOLSIWI7+BCflx7U0oNgo5KkCmoP3viAss?=
 =?us-ascii?Q?cJCitxnCVi+4j3nXFOIBiGCMcfRUodP4gU9DXA5KHOHSMQMGXQttJ3B4PfKb?=
 =?us-ascii?Q?6jlnN8KQE06oKH3D8ghX7XwO6+Mw297X/AO40se8TUVYpIxDX/H1vpUAfnnw?=
 =?us-ascii?Q?ap77Gh/NxcI/i/9FQQyd0XjVDbAKKJOAFlvIagTRYOk0UJRYV8rrsIRqF1Nd?=
 =?us-ascii?Q?4FR6CwkPpaE2JAUC5poZa2+1ZEL3LauKThsQqixARZat+6w+QOvcHw5Qui6R?=
 =?us-ascii?Q?N6Lc9DMLPFlbCB48AzS2uv/IX6e0NsTkYcheERrOT5Djjy6CAjs5BcHvfFfU?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a483c14-6e38-4d10-9341-08dbc461b32c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 22:40:10.1979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wcTUy/x7LVdnV87xXYZKIdZtes9E8kNSK0jHlPootsIZxC2czhVUgfpIalooYgOf/G2YoY4iFIyiE3tyBCSFKWcksOhChClGqmHS8PZXmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5292
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> This attribute allows cxl-cli to determine whether a decoder is
> actively participating in a region. This is only a snapshot of the
> state, and doesn't offer any protection or serialization against a
> concurrent disable-region operation.

A random thought occurred while realizing that the kernel uses a check
of:

    port->commit_end != -1

...to determine that a given port (switch or endpoint) has committed
decoders. If the goal here is to determine when it is safe to disable an
entire memdev maybe it is better to check all of the decoders at once at
the port level rather than one at a time. It is already the case that
CXL prevents decoders from being committed out of order so what do you
think of replacing decoderX.Y/committed with portX/decoders_committed,
where it just does:

    down_read(&cxl_region_rwsem);
    sysfs_emit("%d\n", port->commit_end + 1);
    up_read(&cxl_region_rwsem);

...and cxl-cli aborts destructive processes on that attribute being
non-zero.

Is there any use case for userspace to check for individual decoders
being committed? It can infer "decoder committed" from "decoder_id <
decoders_commited".
