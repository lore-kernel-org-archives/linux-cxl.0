Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEF7E7D0AF
	for <linux-cxl@archiver.kernel.org>; Thu, 21 Sep 2023 22:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjIUWYt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 21 Sep 2023 18:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjIUWYj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 21 Sep 2023 18:24:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570191
        for <linux-cxl@vger.kernel.org>; Thu, 21 Sep 2023 15:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695335073; x=1726871073;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1HB9V40QWXbtoQf5RoMgnBQIASU1OH67W3vRTuHVkRk=;
  b=B4GIvGr83z5aAgvLtGZu8nYHCSo26xgBaJ8kEK6/jHhQXLGFpu04lMGN
   E+HAEBOc0RnfLUroZJBP0SNPYpdCViEKMnpy71ZAVGe53kp5ySkBLHT61
   9+mdhxJLneyrrg+RoDS+4x9x5VQbXeQ/NN+rParL+N1QsIr5ZNuD1ex4h
   H/kXamLMGE4lpy9Ya1kgptCpjDAYX4aBg07Q4HxK99Aq0h8BLsYzjcdaq
   /V2azayVEXZh7lhTusWsF96TA8FUz2PLe+Llfn2HSooWZU87k1QUWzpMY
   fYda3pfeFeUDOzEGU27GXHhmQpBScBnW7Vm5VQbpKAs+VpsXrV6KThnN9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="384520429"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="384520429"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 15:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="871010382"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="871010382"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 15:24:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 15:24:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 15:24:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 15:24:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 15:24:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HR+h/0e18Arc8YlMZ//ncmoGS8CVCEXUF9jz1kIeZ90T8jtZuIL/mKNc9j7LBQRD6OuQTWQLQd+2csaPBMLOdTyVBLRhUinM8Vl1joYFCNs45qFuhzQfIxBra9nt4NdBYZJvpPkC8Y8d3EfrY4y5tG3JZyrpxp7aFPvQh97aHDlT/ontWiG905OT/nhJ78OzUuZF1R/apo61CneypO7cq2WWixfFN3FkPPqDfXTXeohlCBH4hgXVc/GIfsxcvWSzo9cG1tFE+Ts+fAzIoNIToyFLfGUePfkPxVl2XW0cKa00o45nm8lpWPFNg31KapLOlh2QTjM/+P8WlNoNPy9rRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wJj09bkWVH47d4PyBVCPsWxQRz0XPyNmgN9/9cSamw=;
 b=NZSq8zp+r17wS4w6tOuZBugv0RcA7DlYPqeq6c7KHMP9Il4b1+9kVmXyRKVkG1M92hsgibU5ttNXGbys0MjX/taBVb7dyswci+/a25Ak8LjyGLvHMUAqgLRt2vstJ2fEbXHqG4Bk5jm/2XWIPXQcu6o2tpyJN6XM+VhH/WbfFEVP8uY2IAbvNxh65KGTfXAiywvgUvb7aYZQkOgE9u9J/rW1u3tn20qQWQJw54b9eiiy2PDyRTXPQyJNxDODkTm+Qog5RMeg65Q3UHNENKqKKK3JM0f8/ZZ8bEaGl/uXbuG+NMkat/fJI0I+LpvRRQL5QBoiuiNatXid4vPZvqDBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5479.namprd11.prod.outlook.com (2603:10b6:208:317::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 22:24:30 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 22:24:30 +0000
Date:   Thu, 21 Sep 2023 15:24:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Singh, Naveen" <naveen.c.singh@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Questions about the qemu DCD support in cxl-2023-09-13
Message-ID: <650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5479:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af20e05-3c43-47f9-8c16-08dbbaf18613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Y7tHU8Eqf0MIBLslQd2M4YhnZww8Rqg8aiVAeNrSyhYJvK/Mbrnw+l1fh0N03RdkrZE0FrvPdGO7XuWVxEnY+IfDp11SWNWQSHQaUkhLhO70zQn5BH8zQWU2GkJENp12ayW7CiKGN60r9OcKoBe3RmxObwmxabVaUuctWalgrO5gHvcN3zyf/y42t9+3KpZ1J37YAEKaHa3ktoJtW3TFFbtXBMWXJTzxooCuaHBH/WSEHd8CV0t74tWxxT10zIirvRBcHN8IAjmv0CyMRJzlxmtQ7P6SdU5irHa1CqQ5XiwD2dmte1nBPN5eixhmknQXXFRK/65KkwBC+B5Sv/d7zEVIECTLeUFVMvPQUngNfE9lDBdgGZ8rTUY5Iv2WFmJFav2qzn9WaXPL1H49cwexGNr8Nt2OF0BwCO+uERhBy4EZO1B5LCN0dZob9fETAxzjYvyta14vodkt8ZZxciMZopKO5vMnukyf95kbZHzr+RqladiXvzJqPFOCybAPQRpF2ytWqlpFJQnDAgTLL2UHduEfsM3lDyeRrJ2DO+MpgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199024)(1800799009)(186009)(6666004)(6486002)(6506007)(86362001)(9686003)(966005)(38100700002)(82960400001)(6916009)(4744005)(2906002)(5660300002)(478600001)(6512007)(26005)(83380400001)(41300700001)(8676002)(4326008)(66556008)(44832011)(8936002)(66476007)(316002)(66946007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERmdyvzRdQAAwa305vVNM2TVWipI9o4v9Eyh6zj8kG6OICeJpmaUQl3a+uS5?=
 =?us-ascii?Q?0KEXvO0t6tJB8B4BWbeTf/SgxDwiRiY7fOCDOuEX96Fh0bxO+ZTxabaj26hT?=
 =?us-ascii?Q?gTw0x+xoZ8mMbCw1CpqP4M4h2McUxdCbhz5s4Z1mlToAPnBcAVs9ulgqYtTc?=
 =?us-ascii?Q?BQSgJSazsNEcXHWcexYRqKDsrB8j8DvjYfYEQAazIJbqM1Bw9R3r3Ym/FjcW?=
 =?us-ascii?Q?kP3TG62/AeocHy7MreWeT8z3Yhp/EmmS1/pbGAtK1BbfrjWVQtw5mdUilPay?=
 =?us-ascii?Q?JfXdejUmxWRsri/+y4o3qRkdjp+7qjI9I3AbdWxcQohC4ZL7g0//7pMl4N8G?=
 =?us-ascii?Q?VYCuB6di2pTsSV0J+Iu8+7YHTC6q7Ao/XOcwXHMsjjcgfW1fA+ExkwDulR4L?=
 =?us-ascii?Q?5Gdo0DdOzcFMxEcSu0OI/iZEHsub3FE5MEnBSXr4MC9W8tCczy5kQcfPe+/j?=
 =?us-ascii?Q?UEqmLvECNWVfCSVFIjp6fMKNOT08e2WI3PGKJ6BqVt68uOGldfASqjkBFUD2?=
 =?us-ascii?Q?cw6DOR6qSu5DDUy64aHzZqdOVmR/hwnJOJdxe1ExZD39Mr4gytiGwD9S/AFl?=
 =?us-ascii?Q?1F2Lu2WE3Lxbb67LKsDRNnIrhrByrNwXpBWzuHscF8WMbIWaUI2tSeyFH1qG?=
 =?us-ascii?Q?9h4V9qFHweqf2ft48sCjFCLstDtQvN9W8c3t/UhBgF3zwPz5gb6QYnJEcd5y?=
 =?us-ascii?Q?LzkdOArqusKct2i0bjhWfXBjOYhbHMjD9884zqQF11eTnOrimFl179Hk3ALv?=
 =?us-ascii?Q?0kXwAP/1/Cyn+1FV/q2P/RCs0i9lVZB8dAN0qQN8ImDUxI7baplIGHf2JUar?=
 =?us-ascii?Q?P1/7QWkTvcMxF9EeYqAS8syejKljUWgIBd+D7U1JoRQaVYFiHluwxfBrd4AC?=
 =?us-ascii?Q?QNCtksUemBSvrDrbwWtMMAUymlpznFb72pLoA7uwDM79L+mS20JyCpJkC28P?=
 =?us-ascii?Q?JrCkqMJ/An9oezCQ2px07WbkFhnHrQCwhQUFjQn58P4eLsGrRgJzWB3Z7Jv+?=
 =?us-ascii?Q?+fbRvnWVEhrPukn7z+bI1/OW1uB9Doh6quKV8ox/YNpGHX3i+epqXZYK+O1P?=
 =?us-ascii?Q?pvQ2yl9/4wNvstmoKFEvWic7CokOuPNR/qIm7jtJOsge1zKBcYwod9se3n9q?=
 =?us-ascii?Q?fzq5TzFg7DlgUGApLIk3+lNyYk7EuvgU1KAhJ3MqVJ+VNFl83QOI+1f3kG0r?=
 =?us-ascii?Q?dGkeMSQsQTzj2MoJcXuBz1Lh7r2vfIgy80DGeSArW1+Fx6e5GO4wRErwWYM/?=
 =?us-ascii?Q?SWGAyMEn/jwQhynfja3Nx4fNZ3z9UMZtO8iNd9ZdEHeLWSisiuCPGQ0TYRZp?=
 =?us-ascii?Q?7vEM4+tfCj7TkjsQOExah54cy06wY4+sjELYs/vUSFArqjY0Vh9mco3WEqsp?=
 =?us-ascii?Q?q7zwtZRCOVDvArBPBTUuWoXC2Gcay62Sc7d+oq6Bxk8o/UuuNCCEEiciSypd?=
 =?us-ascii?Q?zftB8Tto4uht7SgGf7GaIvV+UZVdKMa0ybqP+3TbLkWuPjrINOJy/3uIZh3b?=
 =?us-ascii?Q?TJ/Y0KBwKeGt9PvNyRnav0TB52kfCEXIsE/8SYzy8Y9KzRZbnQEP2o3zTcFi?=
 =?us-ascii?Q?HunDvkSG9ER8ZIGGhhQjPdRKSXjfkVYZu3VFtFL/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af20e05-3c43-47f9-8c16-08dbbaf18613
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 22:24:30.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jF6GU8GyGkPoVkTaAUKzp45Aa+VPXAx3ZkcKbwbE6rIgkj/0PlmAhVMBjzvLJ+eMndeETo0ydcFcZ93ljKasg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5479
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fan,

I'm working off of Jonathan's latest CXL branch with the DCD patches.[1]

I've been testing various things and so far I have a couple of questions.

1) If the qmp command is used to add extents which overlap other extents
   shouldn't that throw an error?  I don't see any validation of this and
   I would think a real device would reject such a request from the FM.

2) Where is CXLType3Dev->dc.total_extent_count set?  Attempting to add
   extents prior to driver load does not seem to work.  And I think this
   is because total_extent_count is 0 in cmd_dcd_get_dyn_cap_ext_list().

Ira

[1] https://gitlab.com/jic23/qemu/-/tree/cxl-2023-09-13
