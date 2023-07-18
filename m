Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB82C001DC
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Jul 2023 21:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGRVbT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Jul 2023 17:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjGRVbP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Jul 2023 17:31:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ACC198D
        for <linux-cxl@vger.kernel.org>; Tue, 18 Jul 2023 14:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tg1vCoy8KLOWNVh1DVYvXAbG3AUaYoTxOpZWqI+ycVa37T5aZ/61FBuG0ymMK67V51+QCOv1RpCzT+5CNZYmg1FuCWLw3z8BSVJDQlVKJ3R/HAKXVFY6nmjC/fna9wdWo//GuOH8z3cBg5H1dYAm0aESjKzDluLPfprdHxTsucDr0s8I1F2an8aPqXrmsHnYgMNuwz4xmt1ymtxPnSXjbzHxWCfZcTQGSndD448JMBIGVAbOcZiEGeNs0qUiXqFCWVdRGWvxutRU3T1jCaiNCGZL//DYX+4uUlfwmIETX3CsA/a2FMOTEbzZ/rjY9nAtGS5+/XFksl0+9XowdOAruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jtr7xc9qWJuyjbnFRYnbSOWXadxQfCGOzKhiVK4opI=;
 b=FmZkCZqfyFx5YST/BRFqjhzf3xSeFUb61ok0ATnAqcilosc08yJs128BnIyb1xGC9TCuy6ImhY1PJcoI1D5j7iWVUhpzrihX5gSu58HhOMXup0fK71GYR80LXuSyUK1rBMQc1A79VZv8lRWccLOlgoU0PhmVoWCLLCVpe24mAOibeMqjk9NS/bOFvBoALy0tyFS261DucyEHbYfQgOyzwtcxQQ29B9s1/sJOp9Uwu9CzSJNsq1gNp27S6EHTtw6ENNHp80BV+rJaomgNhGFGkSH6H4ZeI9T+vXxQBmGq1Ra7jZpC9HPjWoPogKHJeZmlHn+pFV/raO5XWv7y2KJdsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jtr7xc9qWJuyjbnFRYnbSOWXadxQfCGOzKhiVK4opI=;
 b=BWUkbK5MXoksQs/JgScuagH1iOSOwnhE7skGDlqSMiOruPbRxiXDxj9USvYSYhWE+nssv0q1FtPbtzT5ISrkHFmANlhw1hMxHkZnJeoHUUBlNIcCopX7mOiFV91E4P13s1knD7YeGR1j/nbyQ9eWzxO5fduwM0eMExtunNwcpgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH7PR17MB7075.namprd17.prod.outlook.com (2603:10b6:510:2f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 21:31:07 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::4434:5ccb:5b13:592c]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::4434:5ccb:5b13:592c%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 21:31:06 +0000
Date:   Tue, 18 Jul 2023 17:30:57 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        qemu-devel@nongnu.org, linuxarm@huawei.com,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
        Jonathan Zhang <jonzhang@meta.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [RFC PATCH 10/17] misc/i2c_mctp_cxl: Initial device emulation
Message-ID: <ZLcEkSLAj5yXVOVc@memverge.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
 <20230717171646.8972-11-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717171646.8972-11-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH7PR17MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 25cc0350-529c-4923-f095-08db87d64ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2fPGGcbqx1eD6evU9VqrSAPPy9eYWq17H0Df/rNiGz1fcxrrRzwIj9z34ivVCODMPAabcxQaTYdBEgvdrhdwMC7mMBehdnhKy2RBkRBq5rHWFZJ5AHr66IrrsmXOZUTJEYz3WEvMX3AnEz7/FNyeeDvH+hphGtJFEWhXyh8KwHrQN2otCV2OBEgxYu0RPaGXkfHRwoR9DK8IcwYor/pO4SAB8YeGk2i4fFDG4kfxS9l3NrbjcVKTbAE1RDICnhE7o7P6NgD29sGW131DDCztbtIsdqhBqmSVaLCH27MLwao7U2PinNBPL7NfyMclqHEYrJdbr80q49r8ZSZHRntKaQBOFsUvnV4jgNDuvIFcHS235lpXVJL0xZCKrkWN/eeTt/weh5oH+ASPSuT1Q+FaupziVsOnLtM6b8JC5KWqWA8r5yQRTkBe0Wm1uq6+NZgCXOzwn1XbrsF/2+mqQ8ce1mEwFxPBlUvSC667bWsyByLUy5744lbdYwfwExdnIY/aMNBZI4BqDZSPwVnEmmIRsyNKKRXBkjpOtCueiyx3Ca8/3ON3hL3hKzeGgcRYUhQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39840400004)(451199021)(6486002)(478600001)(54906003)(6666004)(6506007)(6512007)(26005)(36756003)(2906002)(5660300002)(66946007)(66476007)(4326008)(6916009)(41300700001)(316002)(7416002)(8676002)(8936002)(66556008)(38100700002)(44832011)(186003)(86362001)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zxkR3wvJda+tLRHGXwBQxumWhYv6ApSJr4vsPia4U8xxqREe7ZYIJqRQVDUw?=
 =?us-ascii?Q?NMgLMkAJeqIU2Rr2U302GWjC7/8uql1IglP3If/kUoBQoJzNPMXOdFvCwR9N?=
 =?us-ascii?Q?879yFZOxpANiXGNNU/oHqfZB/WD6NdkfY293c77DYyHEtSqa9XgrbysBwR/I?=
 =?us-ascii?Q?8dkWeGSNARB6RT/ekdcIBgTkK7gnK/mFyszjphzFBtsHTMrh3Oa72Pp1yHcQ?=
 =?us-ascii?Q?aU/tj1I6xt4xxMEw6WyscwnrAjwNYhuzlYJ+lXuKdK7FvDA1oT+iSIwTtpTt?=
 =?us-ascii?Q?fwmWjKAdHODPvo5JmmsmDWVoNcuSE6SCVM88BEdXKizxq7gY0tgiKEtUuP4v?=
 =?us-ascii?Q?L/PuHZWWtUcTgvBmQlaspbMX6rDOeqANV2vbU1eMXF8Y4gZW2Y9sLjsoBlrx?=
 =?us-ascii?Q?EoEc34Y+54rIOVl5YNCo7e3qgdX6c1+vGuzP5kR5EIEuh4sHt3TEZ32/6mcG?=
 =?us-ascii?Q?U0J/vFNP9RbaPtL9BLuxgq74hDsrT+oELhTUAbHonGi8whttg5KTVLjjdGsu?=
 =?us-ascii?Q?hl6ibcCmdYLpzaON6Yf1A3cWC5JqbSr90DYDk6GF0T0R6d5+W57pv4/Vk9Ka?=
 =?us-ascii?Q?5m2/MJfMBhOge6kv21gs62DCRzOtEkRBK7cU3zjGEW+MjweLTBTB0YxWwJ4D?=
 =?us-ascii?Q?5zfJXJOQ2f0J+sfTklnLVm+8gzmRKK29jBdlYc4tm37h6LED409temqNquEW?=
 =?us-ascii?Q?SBjC9D8RuM7Poxfp+F5YUYYG7rk0q+KMk07JFmsMR8po2NJ5cxkknacf0PTh?=
 =?us-ascii?Q?zLFYuYUwrwLad91X+gFY4OZv0ZkIU3+iwcep86qO0ZdvVnVV/fPQ9iiyypwa?=
 =?us-ascii?Q?MEAGn9KqjXG6f/3ouElMw3snOq0rqUFv/P5NlS49VYg880SMtd6b1EtCNuTP?=
 =?us-ascii?Q?tfzfmDF1m0UYzIL77u/MYcLFDcZk+iX+KPMmNASaDrb4m9bdL6pETuiwL/nT?=
 =?us-ascii?Q?ffZviwNN/3PeOkfJMXKTM5SHHyVW+/ZZEEdeZpqZSX+VtxOFYVyZ0lv233Qx?=
 =?us-ascii?Q?+tQHcT6MOQq+DpI3tr7FBvLDMil4TKH2KKzsq3tqm6dxnW96LXi9ByNQp7ao?=
 =?us-ascii?Q?BaSb/kNdW4iLo2eFE7nhPWPx4UWk/YLokPIjv21RqLv5SHwvsyqRxl7nWMVj?=
 =?us-ascii?Q?rDa9SxPxrvd7oAfENC67CHmEJDH51fPZQE1YOW3eIyKG18coNv8m4YNacKh0?=
 =?us-ascii?Q?EJHEOm+lLwQg+ziRtEitwHHe4lE7cpBW4vEsZuhvYmuUSzcyC8GYa5B9DeqD?=
 =?us-ascii?Q?LrFEgTsnNGN9nKzh0D8f88CpFeUtiWkDyWsDhvqOVt7bfNnUuEgC6BZ5EmnE?=
 =?us-ascii?Q?1Fb8YSt0ucZUUN/jyHUx6Jor+v3tTj7MbLjO1UBD3z2ZJmzAFPYrhzje9nIk?=
 =?us-ascii?Q?44hO0IhbwtHGH64nE1Ixm2lwkCug3oxglksUjm6kGdyY5fdMBl1vkKKkiC3u?=
 =?us-ascii?Q?zYVwK4nf2jG/fNIsmU5DQ+KtOHtBXuhPl0MysUYsB7LavuXD0Jdfx+4K1NRl?=
 =?us-ascii?Q?4PoQ/krg0S+HbUc4E2IHtf6Ird8ETarMjLY5r/3LXjrVRFYdzC6mKx7jLz2f?=
 =?us-ascii?Q?0WSaYg804EjL3BE16h3O7wN7c8gabRJYJ6CM1y2nEaNyPKD3btfwACaTYztp?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cc0350-529c-4923-f095-08db87d64ba6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 21:31:06.7688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9vNMQDyAf76o68rZsRZoQFpcEadwXNT/aV+OA6CYjyh1BLA5ik0h/IA0utZqCqEtCLGI3vQ42M9ZUi7/cA4YoU4S6li4sENyYtaG5WEPkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR17MB7075
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jul 17, 2023 at 06:16:39PM +0100, Jonathan Cameron wrote:
> @@ -397,8 +401,9 @@ struct CXLType3Dev {
>      AddressSpace hostpmem_as;
>      CXLComponentState cxl_cstate;
>      CXLDeviceState cxl_dstate;
> -    CXLCCI cci;
> -    
> +    CXLCCI cci; /* Primary PCI mailbox CCI */
> +    CXLCCI oob_mctp_cci; /* Initialized only if targetted */
> +

I've been humming and hawing over this on the MHD stuff because I wanted
to figure out how to "add a CCI command" to a type-3 device without
either having a billion definitions for CCI command sets - or doing
something like this.

I don't hate this design pattern, I just want to ask whether your
intent is to end up with CXLType3Dev hosting many CXLCCI's based on what
wrapper types you have. 

Example: a type-3 device with mctp pass through and the MHD command set

CXLType3Dev {
    ...
    CXLCCI cci;
    CXLCCI oob_mctp_cci;
    CXLCCI mhd_cci;
    ...
}

Instantiate:
-device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 
-device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem1
-device cxl-mhd,target=cxl-pmem1,...whatever else...

where the MHD code is contained within its own type/file, and the type3
device hosts the CCI for it.  Similar to how you've implemented the MTCP
stuff here.

The reason I ask is because certain CCI's don't necessarily get
associated with "a bus" so much as "a device".  the MHD example - it's
still part of "the device", but it's optional.   So does it make sense
to create this wrapper without a bus association, or to just pile it on
top CXLType3Dev and have to duplicate the code across any other
multi-headed devices that folks may conjur up?

~Gregory
