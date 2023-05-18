Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47C0C77B7A
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 03:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjERDk1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 May 2023 23:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjERDk0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 May 2023 23:40:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A8F30F3
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 20:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684381216; x=1715917216;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oiUDVYGpJ8F4FPT6nE0EPR8ldUd5940mLM9W9QEksm0=;
  b=FQVHZRn+7WftGzuNIsctbi1ehMZA3a1RC+LkWtRdH6kWhSGdGC5Dpnb1
   n563tpg17kND08ZmIvTS9/BFP5bdNmXCgID8wJrJ9opN3hoF75g0Ps3kT
   5gNF5J+y2jPjr0X2ymg7/CVQ9dL54/MpdIMrlugoHODTJFm5fqRgEnxqL
   /oRnxF8kKaqrdI+814w8+an41D3u4SDunUjQZPtaHwe6Vlvqg0n4BrwpK
   fNy6onFmXeDx1bOBPT5jD+DtXgMIBRZSE32b19IsjV4ml3cX4PVaTNkY1
   ZNancI3F7BYHLnyMtifPk2vabrsPIEcBoxSix6Hbxr3+b2y6KMaZOQ08L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="417617914"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="417617914"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 20:40:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="696148986"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="696148986"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 17 May 2023 20:40:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 20:40:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 17 May 2023 20:40:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 17 May 2023 20:40:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4B8i11jC9+dkg6DPnHov1fe9OtFVnXY2uLnPKEJ87igX2FscMF25MeVtFGaukoO6C4nug9LGnkyF+yRRi0s2DylI9/S+pJs0/+5avzgbpGcarTtYHiEDCFygsplVPNPBdQJHsnv7NRInF8+vEbCbYz01v/KqmHN7lyn0Wc3H9SlR8Ebt0uyTHRgpRKybVCMIM+FR1JPA6G9270DTsOLpod3sKOrxQQ10F2GJdWAiFnf9BL+moRZAN0/JWkkFqu0sCD4FmxAn1C1M1TiNITOTcvOEG/GpsRp09cD6SZWKnqSYNkN8FG1KJUeALv/6Ojz5OBYi8n8pMgpypZ0QYDjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymInCTqpy7+wXuo/ZXhz+kOtLh3t1fuQlHc2Qxurg7I=;
 b=L9Kj8Xj4tYaOpuUSqvnI8LrGuN5rBatjLJRGHJbbvD7ncczIiV+JgzvSDuLQYjVRctCKLAhfmPuLZhr1LYlKyBpsr/MnOIqbPk9JGkc0j2l8Rr63cFY5S+0VT7XHGhNBI0GRRzduTNnkqTkI8M8q7pFGqSaWrckXsErCLA4o4Nab+vCq7l5ZsdkaayDvMS8LXV7yah3Bap2zDQAqDnD9kxvSygUyPfVQuMjLO86OCoUtANtWKG8ZaU7a7zJZ+kHE9BXwgFj8NOU6rh/Ov4iOdyx+B9nWkXYqcS5TSLfMIrdOQnvm+syhDD+QpImKzY8GCSKgtnifKKHtT9FORmxFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8255.namprd11.prod.outlook.com (2603:10b6:806:252::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 03:40:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 03:40:14 +0000
Date:   Wed, 17 May 2023 20:40:10 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH 1/3] cxl: Wait Memory_Info_Valid before access memory
 related info
Message-ID: <64659e1a97d6b_250e2945d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168428284429.2205351.8883627879572769367.stgit@djiang5-mobl3>
 <168428295907.2205351.12793990978386772732.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168428295907.2205351.12793990978386772732.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb4181c-0371-4b84-a223-08db575196d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 734NcuHzdgW8N43OaP6HUH8BtNKI0os+T2Hd0tYbhYOXf6vC/WbPk2oj9hBQ92OchvZTi57eILLZCYOjBVhOKMx2S1ihvGemmPbvxlpTXv4gHCHShdH+9+4gCuYmDztVVzagh2asKxyGN6Vqii3HfIdhzdqRoSy7OsEAqRQzZ04379sHvkgCbCSn3HgDZNG69iuSlzUYtlZHrHCsuT0uvMNcJzTv/iAwHaK3VZloaNMe6f9lmvWoUGud8NjSU9K4t6/dlHUL9zq3+7Q/tRPm30dpDPIIgxr+TqhBFe8OSof2ON8jVVxSJyikWJU3+RK7ETHyov5YE9mWLB3tKJVxsdDQwFFeQRIQ3xgLM4yNgqvstDY/dbD8n32v2sc2waRV6dQ0yKOAOm6XssmIViRSOLyRNBLWHR4KHPzC6++1aLprCNeWAAUICNGjoxcfM5MjouF9HgvQhH2Rt3wJr/LOCG/bhbNrNslHA8BFhgXh1eIpTggwXOjV+wMf42mXiQrzcU1fnITSZZdAsI4/giQe8BJsJPrPMAb0itSDS9LsmcCEI+yW06JZZekGc36xCqGK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(6486002)(6666004)(6506007)(26005)(107886003)(6512007)(186003)(9686003)(5660300002)(66946007)(82960400001)(86362001)(41300700001)(38100700002)(316002)(4326008)(66556008)(8936002)(8676002)(66476007)(2906002)(4744005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bt4Fu6IreaBpK5wPj5uxZ+7FB3Dg3Iljz+SDKCtf0H1PO0WxQ5KidFS5jBHq?=
 =?us-ascii?Q?Eh5M059DkDY3HCEpLJy6Xw3LW4PmETNfRxJi96TLKiwZHwDL5pioTOo2cxml?=
 =?us-ascii?Q?5IOn2+qondfCl1Ia6heluzk0jyCSXKSbRFz9pKAM7zOL4A9HoKWvWyXaiAjF?=
 =?us-ascii?Q?YH2IHerMorMfgCB+kQ52OUg+TNyDKaT/B2CQUbRuCu74i6gMbEztX5Evaxlo?=
 =?us-ascii?Q?7h6m+0pJ+8iq7nHeEjPvTNYZh2Fmla4DHSv2wAa28MdMnH4jpqdbQhevzguO?=
 =?us-ascii?Q?vSYTWBdL1fJvQ1aIois4Xi1Ae0UCZuNpCx2gB2E80q6qPNHciY5uyzlHcdKI?=
 =?us-ascii?Q?QB/r4OUYw5HEeZcdTO1zyvGbPl6Ie7XHKCHu85hOiwLSbrFl3WW/qjKlGvyz?=
 =?us-ascii?Q?EZXaWejFRQ2T+SaQPG907pI8YTTbbTJ9J4iDBax8Qycb+iVpl7C28EF8bwVz?=
 =?us-ascii?Q?txHgqa/1dLvOh3Cww0yPJn8C+hFPSZ6kbTQrM3OfXUC7cWMXNicKKSfOh823?=
 =?us-ascii?Q?WgZyJ6fzSMVgCY3woFpPL+eoWfc/nxbTt5xE2tSezqdTk1jZFK3yKEADRN+1?=
 =?us-ascii?Q?s0P7VNTqXYPOOytxBpea+2nLF/D5fbDELTsppr5fcO+ZTKX/FZDGLj82KfGh?=
 =?us-ascii?Q?b3T5vlL9/V72/kTNV+AgnoO3+uMsuaqEYaouzk6LUIgsHBvZnbxM62qcXTBE?=
 =?us-ascii?Q?U474fx1CaTW/LUtaOyZtVb54xs9o+tTaIe0DI+uIELSzsYJgnH1//w4KC2sa?=
 =?us-ascii?Q?W7LWnwLrEJK8xRq4Z4fz+jYzUiodeEjug/ms6jGCS/Gssm58wTZMl/YHwzNd?=
 =?us-ascii?Q?Fo4ffaQYFL5yu0nJTP/FcZzBDKNJ5SGCidv9g6AKDoGad/BdsK9myP567unz?=
 =?us-ascii?Q?j8AFu8TUWcz4UO9tm1SpBQX859LuWbpzRm8bjH45FEjvOoI20IWn4sMBktK9?=
 =?us-ascii?Q?VT2r4iiAme3tzTpMhjBLqkkA9zbFjNp5+heWGtki3siYdS/8vQeM1zvoIDm0?=
 =?us-ascii?Q?fVpKbbNvMErnDs1BkkC63Cpz/ji1NX5bWhVL+YL2gHllC2PmwELw4xYJdO/D?=
 =?us-ascii?Q?OvMgbxgV0EbplIChd4Z87170fpFvpVkLb3s60AE96NHjs0X6ySoZZa9v/sAQ?=
 =?us-ascii?Q?l/pLwOcDHBaTgvpXcvu4z8wB7OBqwbKT0yaV9wQl+dvz29fIOpEchfFeBrce?=
 =?us-ascii?Q?7oJk6+PP8lMiJFF//gvbQaNYoDmRin2o5nm4ldcHGUOlxGH3PJrGIY+bqJKR?=
 =?us-ascii?Q?irfFm4hWv5rQ6PwAmnLPwwiK4OpmPS8w2f70zTZVWLJePGmkyFVpETKdOS5l?=
 =?us-ascii?Q?SDAHDILj2LK3GFojVeU6UZpDRFzZpqZeCjjHCOxkHLqgY9tAR/ybPjTxfyxT?=
 =?us-ascii?Q?ITs+TapNYmgslGwK2//GM8hWuwBZfloSrMbOiWxwsc4amy2Hb4pwXlZlIdY+?=
 =?us-ascii?Q?M+Mt95bCMEBdW0XwnkhRfilWGaUaWcLc3LCm10nhIYxTnel23U84czpDNnon?=
 =?us-ascii?Q?tDszc9T2Rt4ZYJY81hHV6wsHeGSk1Ul3JLYVzkjIjm7iBqJoEd1p7vmI5AOV?=
 =?us-ascii?Q?l8MpAIavOE75sJC90qz3/wJilXwtwPsaVuywsfkMaIyZx1QuWnHIy3WjLr66?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb4181c-0371-4b84-a223-08db575196d4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 03:40:13.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qs/B4WTXoy7kFAqkI1v+/qJU5OqsCCz8gjm1j8VbgDEO9iZs2uH9Ke0vP6obD4nJTKlk6QVVTYlUznQkbxEK54mBCVMuJC77+5iY7pWIcmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8255
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> CXL rev3.0 8.1.3.8.2 Memory_Info_valid field
> 
> The Memory_Info_Valid bit indicates that the CXL Range Size High and Size
> Low registers are valid. The bit must be set within 1 second of reset
> deassertion to the device. Check valid bit before we check the
> Memory_Active bit when waiting for cxl_await_media_ready() to ensure that
> the memory info is valid for consumption.
> 
> Fixes: 2e4ba0ec9783 ("cxl/pci: Move cxl_await_media_ready() to the core")

Please be careful about picking Fixes tags. This one is just code
movement. The lack of valid checking for both ranges was from:

523e594d9cc0 ("cxl/pci: Implement wait for media active")

I can fix this up on applying.

I assume no need for flagging stable@ at this point since this has
always been this way with no end user reports?
