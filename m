Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9C2E7734F
	for <linux-cxl@archiver.kernel.org>; Sat, 30 Sep 2023 02:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjI3Cms (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Sep 2023 22:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjI3Cmr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Sep 2023 22:42:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3BD1B5
        for <linux-cxl@vger.kernel.org>; Fri, 29 Sep 2023 19:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696041765; x=1727577765;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NWtFcDrrueYsPzzXaS+Rf15ZEXCBqxbANdl5cdZNDAs=;
  b=mpjDMzG4TUblGMG6uQ8whKtC7REDcwXnaLiYKXMkveRU42WYRPbdmVQW
   qVclD2eVskp/w/miBNrx5mD4535ls6rKkRfwkzy73m3xocwj8TTDkgQJE
   oz2Z7fl6SHLhTuhVT2fAChPz0XtWylNzLtEZqCeKo/Fs0bfRr9Xazk/Y6
   GS2wRBL+xeOkzsAvVGzej5RRqlv/cH8r5HlBfR84Ep+oUjE2LmUyuTm/s
   PEeBbkHQRg4bnbXROR/xs0YYWRolEGr1Xigwuc+0rlimfXNjw8a9rVFD7
   gBYZbBoOQ5GkFFUTexQCYMT1OOPyOgT1BQaj4UAY6YCU9fzBmMSRpa0I7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="448910356"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="448910356"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 19:42:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="779451265"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="779451265"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 19:42:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 19:42:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 19:42:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 19:42:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 19:42:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtit8rA0lnPGHzp6DN9E5Iz2y53QNTJmPmmAzlEbZxb2FJZebFMxARmLYWhv+duV8bprQ5y5q6Zg9XBIMOKkVi5kLc5NgtEd+cUKaMDj7Yw1Zt8xsJIBidQStIgNn1dyPiGNkvIs7g1aLVXvNGoJAWmm9IAXaf7FILfBi/oHl4BOHaQ3Z0Zt6vtvEoBj2Ld3ziRErgRz1kDxZyyOVAHkV7KHXG4DqLdEsosIE2McJw4JzEekH6cl7jJI9gYjbJ//2c1wzsmEJHDZA8S5UOFZiandogifQRS2R34nX76ohkUgZsJ/RkKrD80onoot8bumbC/TuPzDI76X963r6KGePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2yZP81EH4HpYNM3c52FkO3k4xBzQz4cjxYwWJ8hNfc=;
 b=WJzx7ziWiTSrrCIbwxU8Tv0a5s+7Gn+ktCIAoz6GzCvHp/wBxIq6ajP0jhbBsMpvdXrqdPvMX8Rc3fOF9FfJW5e5CjVkca3vQGsqMpF6PgQS60C4MXW/ppZWSC1FK623mPWdJhUdZmjBCOYZ1NBg31AwLQz9tC8e7byC7Mim/K9Ck0zkAITkMgtTseYgOT4yuTUaqLLL+W6iM4/fUef8dDzCh5uJeTjoB7oEyBee+t+LCXGLHcwa+UCEDkR85HK8aEQAXywIUvCYz67AWJt0Q+fADu6jiYYUYatbV+WQ+ms9A+GnEnfyuMN7roLRDS9a02T72emML+Ew5jwNlRjG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4741.namprd11.prod.outlook.com (2603:10b6:208:26a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.39; Sat, 30 Sep
 2023 02:42:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e%4]) with mapi id 15.20.6813.017; Sat, 30 Sep 2023
 02:42:35 +0000
Date:   Fri, 29 Sep 2023 19:42:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2 3/4] cxl/pci: Fix sanitize notifier setup
Message-ID: <65178b043fd07_168c4629416@iweiny-mobl.notmuch>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BYAPR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:a03:80::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: 553c7f5c-2f4f-47d2-7bbc-08dbc15edb7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXkmeIaGvjnixR0Q6RW7KbULbJT9TshY3APTxa8WYKPqu8yZBeW1wYOOmxjTEfbbbUV1tw9jqBVWDa9/BaAzH5l1KCeOxWj9iw1k0I1OL7BtJBIdQr03ulSyOYNB52b+4sQetZkQpT3q+sAFSfLZYl8WR6NQeiaxj3UYLAggx0v6PirIcpx4jCxflm+tBxymNwf3Glk6n25FBNlOQoesgM4LlQiPr4cyt1gnMyBnciwhqRm8SPbouvftceY3e5R1mAUd9ITDe9Nb3BNCJqiBpaiTQeutLLYYgtPPOeqMKkenGoYkV0dHKp2fJhvtFyQrwlsla+yb2ojSleoliWtjw8J7xiTVTRuMVHkKYVtYAZZC7QTpfTWPXX/sFzZ/ISAutaKf/sCmTWRpO1mq4I4+nuV8y50bB1b9yZJ+bkNtzAAt9NHZYYCyjyB+tWAVCO+qCJISdSX4taLDlpF8moRUgtqRZi9lAz9PoZN3MFOMuB5PFggqsLBvjn5OTjn4CXd3cpkjJfv+MLgAyKr5phbmkC4BdutAFNvYIZ7uEY+UP/0+oTcFp6/0OFKHo/v+1huq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6666004)(5660300002)(44832011)(107886003)(2906002)(83380400001)(26005)(4744005)(82960400001)(38100700002)(86362001)(6486002)(6506007)(6512007)(9686003)(8676002)(8936002)(4326008)(54906003)(66946007)(66476007)(66556008)(41300700001)(316002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D9kuOVM9ZC5v2nJzl5ySG+FHJjDb3imx7d6dNaxbt8wWIRHHmgqnGXUeu7+A?=
 =?us-ascii?Q?bIhrUPu76kQtWLAunV225m+3G2bXtgQliXau90kEQVxDYdHy1qSzLmTRYA3P?=
 =?us-ascii?Q?2azq6rXwP802vtNW45w12gJekgRtW6twxUi7gOg24oFYXLA5CCMoEru/UgXm?=
 =?us-ascii?Q?881XylXri5UH3D2UgbcdXfDO1XMkZmbXgujR+CytI8Pn/6Gf3MgxZW65CCKn?=
 =?us-ascii?Q?7cmwx5Qin58baRNoDrufkhdel1ZaZiLazhsaHck1/OkdIc695WNCPnGK0bnj?=
 =?us-ascii?Q?QSxOUPTcS59c+539VQCs0MhaFUY1+OCVVEjuhit7BRbiFCI7D/ffJciQBKC9?=
 =?us-ascii?Q?A76aFBi8QXYoZTmztkzBk6zNn/CLXlsoMKe3XsCApz/9m9E2x5G1VOWB7Zcn?=
 =?us-ascii?Q?UxWuknevjsj/7gEwXkzJKGFxje5yPMNMpKZ2E0w5MFYXwAMDZ2QiWbD6dYzM?=
 =?us-ascii?Q?erM4s8523vqEQEi1ykiNFX4zqpBVAHmh+ti2+JPT6+P3X6cD1ZtSE8AYUXtP?=
 =?us-ascii?Q?2PxBB+Et/CamAf17Iygq0MJ7n8rtOQQ7MiXw2YIdI6wUT3+cUwpZR0T9oCoh?=
 =?us-ascii?Q?zqKdoQOJ6E6whwkyJ4zv6rPgZUtp3P3qCCP+eHYN1U5U/IdH3RElrm71qXc+?=
 =?us-ascii?Q?Zm7mNYX+U0l0/ThnDZuVn3R02+ljzBJCSj88IbuZy0XvIkt9X4eOLSYIF4Bx?=
 =?us-ascii?Q?YCJ4UeRiGZuLoezZUbckHb2YWD6Bn/0Z6WszO6wkNGoM+4z8X5E3zf2GZIAu?=
 =?us-ascii?Q?OzswV57faT5Ya5eAj2BilewJW+CCk8yk7Py2e35GVgYPaQAR981hK14jgPX+?=
 =?us-ascii?Q?56tiT8EZtUmU4O0BL7EhmTnoi983FOag/zaeWgUu48pHdTN3g5pF9ws7P4NB?=
 =?us-ascii?Q?kPx54/vuD0iiPj2wok0u5L/u7xam+sIAIuN5cdiwjCIKO3304ZhK0FXn7nvp?=
 =?us-ascii?Q?+OxHbann6A/qgQNocdci+vs3eStf8P5oqIWY6ImMf47TB3REgm4K7HztXbNk?=
 =?us-ascii?Q?yE2x77UJNCyShYXXvm/CrMNzMyy9YnaUS+hGgSSX0Q9zRDU1QDQVL6vjwn/Q?=
 =?us-ascii?Q?tK8BLUtyHiQiTUqXoePHGe8LEmGeTJCreW5k05ZDWrhTuB+ZP3kSPChQ/S9H?=
 =?us-ascii?Q?Nj7x3kznHTHcf6C79mZvARxt6NahrDmi+zqyMOkOh4xTOVk/Gz+clztTdChI?=
 =?us-ascii?Q?0Q6y5xFQR3S8sAnqXuIBh39R9PjHurbaVDfpXrHaBDTAr2B14a9+ts32x18O?=
 =?us-ascii?Q?8rodnOC4scZb64BMZqNS52GbsJLu5AiPsQveed3oS0Wg5K0la44+iBPnmqTC?=
 =?us-ascii?Q?a+uLI3U/Cd2deiKZ6DO4YPKH6AJqEGShYShLanLd60D13c5z2g1yoz43fbFO?=
 =?us-ascii?Q?gMIvShQq/cLTs2VrnexSQbHEHbTY5j93qz6BPKNoSSxC97DRXuys2B1nxlci?=
 =?us-ascii?Q?MGZLa3RcwuID2Twozz/i2YTtKKW3etPOwQ/KCWDYByMfj+MG0qPY8AD5UV9H?=
 =?us-ascii?Q?5BwKpU6529ONu1cDQIhjc/5u4lAAYoP3d8SazGaWBaemjWuiBsFC/5h+p92c?=
 =?us-ascii?Q?gPx95XDfVkNpTkMmR3ABc2EHLsVRUteK5vUjFs0b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 553c7f5c-2f4f-47d2-7bbc-08dbc15edb7f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 02:42:16.2212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkYnb8+MSpH8+rGYYx/QurRKwHQo5g2Aw+tg56ITE2SMZzRcgCR79AKLv937428VOtbipQAuIobrk7QJklYWkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4741
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> Fix a race condition between the mailbox-background command interrupt
> firing and the security-state sysfs attribute being removed.
> 
> The race is difficult to see due to the awkward placement of the
> sanitize-notifier setup code and the multiple places the teardown calls
> are made, cxl_memdev_security_init() and cxl_memdev_security_shutdown().
> 
> Unify setup in one place, cxl_sanitize_setup_notifier(). Arrange for
> the paired cxl_sanitize_teardown_notifier() to safely quiet the notifier
> and let the cxl_memdev + irq be unregistered later in the flow.
> 
> This fix is also needed as a preparation fix for a memdev unregistration
> crash.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
