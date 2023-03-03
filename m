Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55599C7EE30
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Mar 2023 21:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjCCVVr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Mar 2023 16:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjCCVVq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Mar 2023 16:21:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB345FEAB
        for <linux-cxl@vger.kernel.org>; Fri,  3 Mar 2023 13:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677878503; x=1709414503;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aVCpsAyBom8DnvVN8UM3Gb6yCLEKhY19rsZEaHP3EpE=;
  b=GJG4eytnWWw6DAg0fJv7ocY37/04LbDs81og0BDf8inquCVTCHn+TUTj
   uilCGzEzXduDxiuvlkIFimZ2Nq8EIpHwU20jGqzbffVbsbmE1QlyYPeWx
   0lQw0tMKZxCTgWC2ONkcw45UBHlNVSKDgUYwzlu5M3agFOkxGHQKmvpAf
   MBV0ixD4BPyKSfQkBSaLlTtbsLrawD4Zp0fA97GsyOQ2UBRkQW5dwTOLl
   8tSvCkResm2zWUwSSn+o02XJeUSNuMhOfluiKImxvIl/KohqjB7kH9jKI
   YMq8KNkgkttEpzqAS6n7qBRQadFObJjjRdsX8k92tyYWQVC0kJ4uF3+Hm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="397748582"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="397748582"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:21:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="707987709"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="707987709"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2023 13:21:42 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 13:21:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 13:21:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 3 Mar 2023 13:21:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 3 Mar 2023 13:21:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWlPFH/6qi6s8xnNNGa01WJnTDUikoOLokiVuHNmkIA82pMBDgL/7E8asHcTs9gEyN6oT5qAbSYQA8w45Tgvf8naDedJYHP0fM7qYCkYU/zMQKy30pbnxIBxRYR9Tctw60G0Qi+e6cqckw+Y4AiFXnNQ1FzLnueFbOSxhEo1ZQxGntyOFJ26qfg1cInl3uukrje4lV04pKUMFRMedViYMjd5XzQLsLH6BcDeDI4LaGBzZZyUgkd/RvRLEsIEu6v97FdPb9eypTb7CFsI09TMgj4mMJdUHE4dRn+vGaRUU1IXRSUgy9MS+2PovYejKMDmYTK8r9nW/IwmEw7VEX7TGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DK/4C9nF8rMgI78eG9CECMkdZ1aAUhz9gUKmMyWmn9M=;
 b=WSASGYw/slve3E9EecyE9uWFS52/GhQ2G+7xWDMkOI1SMW+/gvnxJzfy0IsDnH7K5BMab6VhgMAC66apdPLoNge8GPq+QlwyRQpFhGj+lR98RH79lYmb8pABBuIT9+3hqLY6gcB7O842J91DVvzy2A2X4lNelZ+0tEDULiDohV3u6Jp5ploHwdWl+k2PRMHAggd0NIAQb7hW5HwyVW1c+rPW0ctYH062OYBsZo88jRkT7IHzYk8I6xVnwhZ553tvmGLKJ9tjGvJdClD0afAfL1s0FQJQJ7LrABlhDzhCITKr1Icb+/NOYkYBJAdg4/vLyujZ17U/vXhDGe722M1qeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB8014.namprd11.prod.outlook.com (2603:10b6:510:23a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 21:21:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 21:21:38 +0000
Date:   Fri, 3 Mar 2023 13:21:31 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH v4 4/6] hw/cxl: QMP based poison injection support
Message-ID: <640264db1b4e9_5d837294f2@iweiny-mobl.notmuch>
References: <20230303150908.27889-1-Jonathan.Cameron@huawei.com>
 <20230303150908.27889-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230303150908.27889-5-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: bc235ad7-c531-4f15-e5e7-08db1c2d4636
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsgMWTurPbMKitwLlrgoZN4AG+VQkT6WOi9Nbb0emcps6H0B8iyQKaos3e0Z7/c+ojczisWp0tURKCoEe6N4UtFIilQBE3dxwltl/hj98EhzhT1CCwqt/13o3yGjVpOn1EMpiQq83dY0rSK5nTB+G3u/0uCQX97HKRLcwIEnj8QUyxdFs3S+p6OybTDBWPTAwzzT6wMy80q+ptnlvvJb0A/i408gwgPo3QpQ0Xvzhqdx9TRm+OnxGOioohe9MzjgMXSNaq+OXvteYTYhJucfmZtDU0zD3uYXVW4dU2fep+gWRSr2NBGSINF8FTlvu2E5FrYgLVa+kp4kdqS6DrJm5za7cApVuvUd9fJ9lslJ+qrGpjqTPtr+E5TV5/sBwN0oLG8Vp1WqGccRaN83ktloq9BQndL3S3it0LmB2lseQnKVS0oZHWFhdvjtBsszttkH2gHvWdmhAlrSrv8ZHI6oF9iiOO339DhYoF5lbBZy9oIBbKJQTFGvTeT6zGhBjU/gMsNX7AxjfuLTdppG9H+qf/jU55NToWkgZVXXI+2IHd4kHD1eWN8vWWWAIt012XbEzL1ZayFOthC2zugFP/ejEQUj944iaqV3WqCszZXO0Ow+kmYoQqjKwFeReECNq/a+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199018)(86362001)(41300700001)(66946007)(8676002)(66476007)(66556008)(8936002)(6512007)(4326008)(54906003)(9686003)(6486002)(83380400001)(6666004)(5660300002)(6506007)(478600001)(316002)(26005)(38100700002)(82960400001)(186003)(966005)(7416002)(2906002)(110136005)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mzE/pU9l273qHgifp2oSDlRf3ncP5QhNJxKRJ+KpxL8bAcgBvA/mpdJU29ed?=
 =?us-ascii?Q?tBMcFzcTtxprhsEbS/GSgMirAs9TkLPiINfkHsm1qAdrJQy5+J3KrrEEYy86?=
 =?us-ascii?Q?DZ7m3dXfjQGlg7T9fIc11zqceL/kYq2CLkNQiHt8uTmqal4XlRnqC8xtONs0?=
 =?us-ascii?Q?9ROmpXlTk3uR9+/znBijG7xo8OtAbDSlBcxsWSzysUQWyeLdhrk9xqQkGmRu?=
 =?us-ascii?Q?2FqpYPyRrdxmhN1uvd9LagglhvzV8KXw8hiAc12fUxrV11du6vYnU0mc3JT4?=
 =?us-ascii?Q?z97ilVVPy7SUAEcQWnxHe6tf6YwJtsiibNiRHViZkEey5b+osecOrdxv1XAb?=
 =?us-ascii?Q?hbTZEY+iMaAIr8kXXBqDQAK9pk6jyoBXn0Rbmpmxs4WECT9MwUKlpMFRC5xL?=
 =?us-ascii?Q?lb9lN7uq/beIOv6HYDtsrn5F3kLGJRWWzfKbTRHth7w9a6LFthcHKbWmwLgX?=
 =?us-ascii?Q?4lFbm03BLlEl40jLOGXnPaJGrjh3XiXI9UNHDhraEE2U/pCdokJtSmUDZIZm?=
 =?us-ascii?Q?hoAt/VM3QYAK1O/xLJlsvivhbU5v5OVCukU2FKcfjFsdtJGesDqlwlhiZ0xM?=
 =?us-ascii?Q?lDOqCWXfu7CB1v9iNyoq1hoO4n1L5KSBNT+Q50fn/TBfJoF+9qSYYFUE/TRi?=
 =?us-ascii?Q?z3aJ96RqYBunRDdt2xzZtLWPJqZYRY2caPsRbdWUI5coGE2E2cLb7kMGxUTY?=
 =?us-ascii?Q?F39ot1H06cVroRGEmUugttDxEBopG2JopSVxMiF7bC01YuC2IakCIHZ+sfB+?=
 =?us-ascii?Q?jxO6A7m6ZlrOYX8Bu+xlUkV/kTFN2CdgQx7gYlVIStvel+ZxUJ6EIoQDT3Mk?=
 =?us-ascii?Q?7AH1LU5Yb4+0h3FX7xI1ayNXd+HJKj0zEHJCdS517c0gt6smOlfFq4f7Vqox?=
 =?us-ascii?Q?fg3vX1AZ2kX5Hjr7XAQHfZGj2GmG8EgF5S/TUrethwZDrkEIrxNtjIkbjBqW?=
 =?us-ascii?Q?h3fSoK+U+hFIPzTSX8NCJpF0hnzS8K9sjOmMSx731SHNeEOviP+Pl77tFWiP?=
 =?us-ascii?Q?1hhYZMaasRI0rmNQcGrErYFO0OZgEu9415BOKkaihAHvlk1kcEPolLqf15jS?=
 =?us-ascii?Q?9RtneH8JsNOwKmAwS5Z8x/+YJ+zhXcPsTA0n2O+k2RWOcHHjazt3RHpSFCaA?=
 =?us-ascii?Q?kn8PjcrKv/3/L0bjf9/Tv0jsyGkfQIqCUBfkhNeYkXIUVUITrNItOK/WewA1?=
 =?us-ascii?Q?s3cBkGoXK565nld0WEkBUM2lLhSmrQJwALJuSRiDeOszt9+ns58/bKMKP35m?=
 =?us-ascii?Q?GWpG+EmoYzxKoYubEC8Pyb3L4BmjaBkUlAlgiUroQFZvX9yUphtAL0cdcov9?=
 =?us-ascii?Q?hyBzyTcHeBkEK81PWSgq6H1H9yL2jQTBIZvTl4maGtefVoZo6aT/55yXQaYf?=
 =?us-ascii?Q?PxwCcjhMk0e5ydQK+36B5PYi+DqP5+nEVcWz86BlerhODigHntwaU8G5aee8?=
 =?us-ascii?Q?fwKcm6bWcOhtTrGPFmgij0v2eylaHRddpkKWD30D1ae+U1WGgPTzgjBpfPyi?=
 =?us-ascii?Q?WsZ6d3gpYrr4HkI/8Bb7WHGt3LxD/KLP4mrp/cUdlBx7hZAgqOxjx5cu0zuH?=
 =?us-ascii?Q?4ZKrwKWZmRfnLGNXwxAIfZtcH8oUmuwonBy+tZyV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc235ad7-c531-4f15-e5e7-08db1c2d4636
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 21:21:38.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEGtImLK5IJYlIVCtMp12soyOmYzFu+xke7vc6Xyes/wwBcG5xpBmu1eat9Lte+TvRV5WCreAqyf8Kyjs7dScQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8014
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Inject poison using qmp command cxl-inject-poison to add an entry to the
> poison list.
> 
> For now, the poison is not returned CXL.mem reads, but only via the
> mailbox command Get Poison List.
> 
> See CXL rev 3.0, sec 8.2.9.8.4.1 Get Poison list (Opcode 4300h)
> 
> Kernel patches to use this interface here:
> https://lore.kernel.org/linux-cxl/cover.1665606782.git.alison.schofield@intel.com/
> 
> To inject poison using qmp (telnet to the qmp port)
> { "execute": "qmp_capabilities" }
> 
> { "execute": "cxl-inject-poison",
>     "arguments": {
>          "path": "/machine/peripheral/cxl-pmem0",
>          "start": 2048,
>          "length": 256
>     }
> }
> 
> Adjusted to select a device on your machine.
> 
> Note that the poison list supported is kept short enough to avoid the
> complexity of state machine that is needed to handle the MORE flag.
> 

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v4:
>  - Widen the mask on Poison source (lower bits of the address)
>    to allow for Vendor Defined. Change will make it easier to potentially
>    add a means to inject such poison in the future. Today it has no
>    impact.

[...]
