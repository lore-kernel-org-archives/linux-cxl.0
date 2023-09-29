Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CC0E7734C
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Sep 2023 23:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjI2XwT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Sep 2023 19:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI2XwS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Sep 2023 19:52:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6179CF1
        for <linux-cxl@vger.kernel.org>; Fri, 29 Sep 2023 16:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696031536; x=1727567536;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3Ao7GfYEVtOCpqW5vwXI+X/XFs11CH2f3rOtQkaJTxc=;
  b=KuSMx98bdHteUHHiYJo7Od/4TmmCXmU1fQ6XHCZmsb4GW7zSAMLRdcQk
   ahOKgiFfsSD0oAr86wqG97orZUA8LOSH9cbX7iSFkS4t0qod3yrr7Ja2U
   ga8kRj2k1TDo6iGC0hzlxTlFLXfnbKXcr05ip317VTFzbMuZdJAQUN2a6
   Bwb9dy0ARoqdmJLWj+wrU+mKPO7UtDhxdV0q6T0zScZb3+H3sp4/yFJfv
   dkdv9kWwnAr9aIq2QGZcXe84znSvi4EutpCayGMNnwwjcfFG2JsrWjyb7
   51M7QhJVtDPKRxMpLtg/3hb3C61/JItt9hUea5bBDrTdOo8n/ZpfueRUR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="446565550"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="446565550"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="873831860"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="873831860"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 16:52:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 16:52:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 16:52:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 16:52:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hL94GxDIXXWpjQTU81jIS9CKvhajPhHW+wLGuFsWWnRVkYGaok8810wgxKBYj2j1MnyHdb8W6dZkBbJp7oZ7QFBkI2oCSU0ef2BeAp8XODnuOnUYLYJ42ckVsqkCi1FmQYAqMavgQeLw9ICBfs1G5L8lN9f1Js+10Qk7dICyLuzYCKKSaVg87SJr73gPVVjoRCkRx+7MVUlVeh3qjgT5eCSRidb/j5EqyI2ZLkxYSaw+layZZYBIKJBlBx9lZlr1U8cekHUzVVu6CZxMKr1JRr1U1y5xETqKiZYr9D7MeMUtejpsGZ0/eNNzNZERmH9JXN3oQsocaXZBrkIkWbhFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIAo7S2WjxgUjSQsL6ClIQiILQYYxp81gxDqDfeQEd4=;
 b=V9HeBiEjSvqW0UZax4/RYHvCYhMEQZ0eUhq43tzZh1LHO2nayxWVglGCWNRFL3A55mBMYfcZVebgZzEPJSYHQIO2Wlc08OPXMdx+ZUjTqgZ+5IKrR0jt4U+lKfx+Kw45fqXoQT4aEoTsjOOg83dEJikECz9euQXe/ZeD/pOf30Md6iqhEt2HwzgmKdmsx3IwVmoJytohH2KdC6RBEXmFVwOYvsRGyS9zodFJHutJ/lf10z64wo83P2yAmEm6Rm5CEjA/wT0B1TZTvE5H8l9XhBbxcDesZaqB2MhMlLXJVq2J9EQmwVgjLCWa/4i6NbyRQhbGJLZ2JwTckVh6JEE7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 23:52:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e%4]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 23:52:09 +0000
Date:   Fri, 29 Sep 2023 16:52:06 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 4/4] cxl/mem: Fix shutdown order
Message-ID: <65176326ddc98_168c46294e8@iweiny-mobl.notmuch>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602898991.904193.3059334392093961032.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169602898991.904193.3059334392093961032.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 3476e64f-11e8-43fa-61bb-08dbc14717e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZoI/w/65Qb6V22dDI9QLaae79sc2ag4QYBM6JjSVPyQ/mqUDNoXdncQaUxpcxXkoK/Zx89ArZdC4ckm+6g3seBF7j3LnMGsr0ljTcCz4VJ9eztTA2Fk//jUoMctZIi1JVvlIKO6lCxlpFhdm45UinZ/xJ7j76ueQ9eFk79z3q0GehNPNDAlNo2GXf5BWo13WkjJhjLrc6pEaqim+a2NHTryDBAzv/TolkZasUQM98vBhVeqIj9ckc6gzPQ6u3JvbDtairIwXHrttvKFZ1C9t/QN6RfTZciUuHw+rPcRc1mOGMUYdIOh7la3xM1E2NuvzVEMh3YjCITE9zP1sdLm4JwskIiskBshxKOk/aNsNQgfBhkhBD1J+Pze67Gdn065qNnYp8QB2nLz9x9HD9dLpWEhaXVzj3fB9a5PrfOr6eTb3hMyplvcxRXcKvr2pZ0JWFh1SXvEZPS+SuM7FEkabxOv0gLg5jhDCnnWUujTLtzYzWgbYdU4nb+6HOt7tiWY4eGofNdg0PGpXRTER8Ma4sgtUO13O9v/KeoRD0Mp1b6qk187OpTgmSd6JfKNoAqe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(8936002)(107886003)(26005)(6506007)(9686003)(6512007)(38100700002)(82960400001)(86362001)(66476007)(316002)(83380400001)(44832011)(4326008)(66556008)(66946007)(8676002)(5660300002)(41300700001)(2906002)(478600001)(6666004)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GxRislB6q9CP4HH4NI8KwlKHyGnpXdypBaadHCJe3WxUiUjzK1RkEZRRh5mk?=
 =?us-ascii?Q?Mo/24z43yj9ZXC0UYUHo1AeF+8dffg/0wBsHRqw1Gl9XGET+PHLyKAMEVDkh?=
 =?us-ascii?Q?JnnbyZIx1acojL1HTLg0WmUrX+Hp5wbqvB1m9GsZlrU9dKQ7QQONxGDUZAK4?=
 =?us-ascii?Q?tspL6byzXs6TQFg6Zcej+jwsEZa5Ce9nNJCIrK2unEjohs4bEWw65bmAS0JE?=
 =?us-ascii?Q?isvs0DWM1I/ZJusPIMpidRYtjoenLcn7pETE50frq1E0oaBrwNZc0tm0JrH4?=
 =?us-ascii?Q?xIIVSnMOcNkjM6MvI6hLMxxqRz+SBOJd9/i7mgS9mcI+P8X741VKBQL70E6g?=
 =?us-ascii?Q?Y+jGDqKkSIkisR964cpkoklkmvs3UYH+fM+pOHvUwqMl73aciRouqut4Etwq?=
 =?us-ascii?Q?NEDDrlQL4JGE0WkPTBUccy9Perz413vIvSObgCc9g3VB/Jc3JDOLBn4hk1R4?=
 =?us-ascii?Q?d0dWrpHEWhJbBsMlESMhaoceNoRg90q9qpljG4/orLEGX6x/RTTFmwA/DBX5?=
 =?us-ascii?Q?HlqU4BEfHxXb9EDSZvyz2d/L5d3fkdha/k4b9PISveBsJ+aOUhdJgVQE0dXl?=
 =?us-ascii?Q?k9Pn+ytR+LIQDIcfUKxIKG3gFlLeuceRC6uy7fh2wVhERS3Y8CsMFsGvQHcO?=
 =?us-ascii?Q?U64zcBVaqeRgJ81SV/VQX+7FHzvafozYtZX2XSF++Q3uEzL+/MwJXslkEyVd?=
 =?us-ascii?Q?txrrhBL+Xm29eFcAUKTb/bEeSkEOlLX7fAXdoLaRgAmgiT4oYQEGcy/PqiU3?=
 =?us-ascii?Q?gx/qo7A5+QDTalVkZ6JFSIhyzK/5ZKsusL4/0bDyEG0LvqS0Nbx86oHmB27y?=
 =?us-ascii?Q?hAxB6z8vhMLE52gXF3XuatTMvSyJgLnkwEqkSi4tNZRnUJhKUJK8aAYuQb4J?=
 =?us-ascii?Q?ljIPwswc9rLdYmPain3BimbTmxTit5ZC73UHBprUHkQv5G/fnJdGr2xJW5gk?=
 =?us-ascii?Q?1RIKtwrPq3EEgclr9UhunkAimzcktuOz5R73MTQETMJRyc+ajeYOd07HovEy?=
 =?us-ascii?Q?To+TwTNLEfWHNHXCzaPlwVUF9f0Jr/hbBeib105OE5w6hTG98G2Gs7Vul7WC?=
 =?us-ascii?Q?twFSbBakGdh3bLVA8VopBmC7E3h/f14QdVLP3BA6R/wcKbp4RUoHbp5wq/yk?=
 =?us-ascii?Q?EFOo1nrtGEAZiIYtn+ZHiSaa/G/Lu/pQ/O2NeDHPfWqifGADJYA83bEdecmU?=
 =?us-ascii?Q?R/xmBNIMwE7Sr5DstC/xuag18CoaOyhChF5nbAJyf42QdGbd2OACmGRJhIz1?=
 =?us-ascii?Q?UygirAZPsjho+PfL9Aitsj3RJTfITcldatS1u0kIzZtGBr2cg09KG6jS2zGd?=
 =?us-ascii?Q?ZFniZ8tSna4Y9tM6XtG+UcxgEP2eRXKOrFVLEjV1fH2+I05l8l8S1oPiTkmu?=
 =?us-ascii?Q?kF+6dY6Z2L1W+azfzAStCEA9C6iivqolx6kzGfh5c3mtW3m5SxWqCE88mS7e?=
 =?us-ascii?Q?37uo/4pM52n+ukls7vnOJk/y4Uk1tnvRE8g5nxXHxBOldbT5lVCfjZm5gW3C?=
 =?us-ascii?Q?gcQh7Rcc/o4x7+1IRx2Db7rEu2I0HQcT724kn9LVZhn4VKNmzGs+U6FqwfnI?=
 =?us-ascii?Q?pef/g17rqSDVH99O3n74+pK258krO8IRAa0AgazB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3476e64f-11e8-43fa-61bb-08dbc14717e9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 23:52:09.2283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dM6E9aupD9gZFDYA/a/0zl5u3NdcvErvZ0a82ms2afWC5h16YP6QQOoqQNSb29pbi3SRM3SHSsa5ty7RRGYLCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> Ira reports that removing cxl_mock_mem causes a crash with the following
> trace:
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000044
>  [..]
>  RIP: 0010:cxl_region_decode_reset+0x7f/0x180 [cxl_core]
>  [..]
>  Call Trace:
>   <TASK>
>   cxl_region_detach+0xe8/0x210 [cxl_core]
>   cxl_decoder_kill_region+0x27/0x40 [cxl_core]
>   cxld_unregister+0x29/0x40 [cxl_core]
>   devres_release_all+0xb8/0x110
>   device_unbind_cleanup+0xe/0x70
>   device_release_driver_internal+0x1d2/0x210
>   bus_remove_device+0xd7/0x150
>   device_del+0x155/0x3e0
>   device_unregister+0x13/0x60
>   devm_release_action+0x4d/0x90
>   ? __pfx_unregister_port+0x10/0x10 [cxl_core]
>   delete_endpoint+0x121/0x130 [cxl_core]
>   devres_release_all+0xb8/0x110
>   device_unbind_cleanup+0xe/0x70
>   device_release_driver_internal+0x1d2/0x210
>   bus_remove_device+0xd7/0x150
>   device_del+0x155/0x3e0
>   ? lock_release+0x142/0x290
>   cdev_device_del+0x15/0x50
>   cxl_memdev_unregister+0x54/0x70 [cxl_core]
> 
> This crash is due to the clearing out the cxl_memdev's driver context
> (@cxlds) before the subsystem is done with it. This is ultimately due to
> the region(s), that this memdev is a member, being torn down and expecting
> to be able to de-reference @cxlds, like here:
> 
> static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
> ...
>                 if (cxlds->rcd)
>                         goto endpoint_reset;
> ...
> 
> Fix it by keeping the driver context valid until memdev-device
> unregistration, and subsequently the entire stack of related
> dependencies, unwinds.
> 
> Fixes: 9cc238c7a526 ("cxl/pci: Introduce cdevm_file_operations")
> Reported-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Ira Weiny <ira.weiny@intel.com>
