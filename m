Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51B5EB64D7
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 19:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjFPTQQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 15:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFPTQO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 15:16:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229DE35AD
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 12:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686942973; x=1718478973;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=nBd7YU4iw8kWxSp3mMEMqFm948IK9HU/qJBuXczNXi8=;
  b=cNP0rF7CnUCdQHEkDep3743zd7kwH/CNsCu1MElfzopjPJKhq+GIHjTr
   r2+MUZEAiVrxS+L/0Fny87IFjfA1wycKz7BNbWFsgqaZTIrqtUniSyPLI
   /W2SFrBXAPMmdotvR7D5hexv9xG8i23FcI4pU+qJ2Zbfdk0LYo02g2R5o
   mPr/mr9KZvC2z1ALpqQkIWUD8Okb+ujcOYK8U2hOxHPBtpHjXxPN/0cGf
   92jemQ22BL2TJkHYYlul5gi12RqX7H9anatffDrTU0FEjI3GXcsbsuyH7
   A70d0b5eymMJrgIhiQNNV/UH6Y5W8WO8hQw0Ar0XAiuWNTB7E+0m9c5ec
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="358167797"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="358167797"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 12:16:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="690350193"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="690350193"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 16 Jun 2023 12:16:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 12:16:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 12:16:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 12:16:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk1ORJiMoCtZUiO212b4HSrlHHdSt097q4Xre1szR4uLZxApoudrTrlg/BvSFQ+pWq551i91qaa5ss8OQlfiA4azMxK9ll9H5yDSqpkz4rbAQeuHIaxU1r0q6qPSoJqVwMboIiXrd5SxN4LyqkK2dOrJhav9RmvAZNrPGA6m0IlRn8opBJie3Ea2+ksw5sHhQzhVJje/3CpUk6a4Zp5XbEFQYBRGZfW65Am9R8I389rRYX4hQvnyKYovK/B/Msji8VFJ3rZvRGQqaN5okeSswleLoDU5AhVq+jYgMj1gvf1LypuvtngdB3EZL0fYsFzCKkrxuzEJX4+utQxhclJU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDP94lGRZzEQT5dAWbrtFIdUenWSfk30lYNojiDaGBA=;
 b=eQUEr+HcrpK5Xp3LYP35G8Y04Is9VLAvy75692rYSIc+7XPLKSgIQjgAWGfuIdnAWvGboepyofHBno2fcPaIAeibDIWs2+qFQrS0X9RF/1rKYtkgZBPZmmqOPX7TTQABxdB3hGiKtXVP3n7IsL58k2hVCMhjlp0AhvQZe+9I1s0ABP4Bt8kXW8XwQZ7FwZitmKjgeBUTP3FKFt9gAq6AcFuAa9Y5AcrfXSmtLogJ0FfwxPMmJDqM21m+Fe8XdJE/NOtyFiUyj2dWmcyoyLkQK6ej1YWHI99WEjtscIM4Tkwxjhbo5Ar0jAebbXo91bofEy7O41drKDozj3uwEhBFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6212.namprd11.prod.outlook.com (2603:10b6:930:24::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 19:16:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 19:16:08 +0000
Date:   Fri, 16 Jun 2023 12:16:06 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v2 11/12] cxl/port: Enumerate cxl link capabilities
Message-ID: <648cb4f62a6a8_34cf08294de@dwillia2-xfh.jf.intel.com.notmuch>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
 <168679263707.3436160.10946564604121831708.stgit@dwillia2-xfh.jf.intel.com>
 <648ba7a78f549_142af8294c9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <648ba7a78f549_142af8294c9@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR06CA0069.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::46) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bc7738-e8fd-4450-2ed3-08db6e9e2331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Du97EkwEVZfIHnfDmkCq9T6eiiK5mLsDJAM36lwOBv/T+92Lyh1QXolqRgV+PLb1On8ue6VmP+GI1EFpCe+zT4e7cLYx5kyeVlzbyG6KjviPLROTun/tuizKWA4oE2vPJuoY604WaTvZ2C7DU6ElMsjkIvwqe0G6iavX5wBwNkqaLgecMcL3DEldkFcdPa0ZQuhFVuXMeI2WmVoI8AAcHHDxUs3uDflYs+SM5DxvcH0iV1mNqV+UUSmKy40SW9lANqGtwsM8RhS2lOS0Rkj+jVKdgz2NhjSpWzx5fQNO6nnidW0pojH2o8HBhEnweQNdntI8v/CrpqNXj3SGGG8PJ2tzfhk3j6L2Y0EEE/U2yB3nJKf1iI1KERdPq9AMq6WwLWKlWUWwH88PFRgDmm8WQDP4JdQmAdKEQnHxsmeDfP8UsLP0oi+OiyqsJwvu6QEq/mdhTETwOBc3H3mGw0MKaI072XHYKpRdC+9joVZQNZezsQN2V/FPFZ7fRVPkwdYrro5URt8Yaaz/wCzUZg6bzxFbXi5VhP+ThgJYx9uciybdw6VaHlRFr3Ysjce8/xXm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(86362001)(38100700002)(5660300002)(82960400001)(316002)(8936002)(8676002)(41300700001)(66946007)(66476007)(83380400001)(66556008)(186003)(478600001)(6512007)(9686003)(26005)(6506007)(2906002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/2q4D+J8oVjG5vdZeE33ZAFXWeKDpqK03uA5IsxYjZxEMSnB7DnH7HobwBiV?=
 =?us-ascii?Q?nUUDvE9fGePo6tC7LC7UBm/Hz9mHlQGiEqGN9v0Jm7JK8WMlvuFMv3OCdlkB?=
 =?us-ascii?Q?ELMpYIea2jfoyTQTjzgcBDowIvoBd5DkWwgmIWMlCg8q51bHOOUVRQO6fZOT?=
 =?us-ascii?Q?nmkGuPwsWRqOcSxqR8cVHRTN7+2zlRk+DdPr77OCGt8+mti2wMrRgsJA3CG2?=
 =?us-ascii?Q?wl0fqujzHH/dz0IBPzzJaU49+dmIzPC7v/kSE1QfBytalH4DGRfHKJGSzhKo?=
 =?us-ascii?Q?MctwfLqqwWO1ViJ+HJ8NenZFg1LZiSelryShPIVgzAUpTB5YRTNOKS13Yg35?=
 =?us-ascii?Q?Tli3JUulnKLRARaID6pf58iVep7VVXNRiX/we93dYABRiPz+kMWolaxEA70l?=
 =?us-ascii?Q?5tsJ7I7daEagxy/ELmsI+j9y+Q0CFfEvF+FZ+JHYA4WY1Pdhl/BDnrvYkO5e?=
 =?us-ascii?Q?asUH+0fWKRfMsQyRoNXtgAcURuNVJIb0JX3wskghgrns2ICfC5FLaVH6f6xI?=
 =?us-ascii?Q?M5LOtDuMra2nesDdOCuDAwC1l4Qg8uquv8SSJWZkAUFF64vdY5G22WNEgVvQ?=
 =?us-ascii?Q?fV5CyM44n2JxPZ5ow8TmOAax9cSYxdh/Mg0MZxkbY5N2zT2LQapXrbuyJ5sZ?=
 =?us-ascii?Q?fziRJdoQmhz4eiCsdZqJ6dhNsLGB5D/TWWBCNhOSxZ/crZjlX03w2djfGIy0?=
 =?us-ascii?Q?y/QkgAd4hGLd9hXBfakxpXfe7Xz3AvZQphvzXWCywpwOiOgi0gqcgFTuTP9h?=
 =?us-ascii?Q?8816ltkDcu5bm1DdbWj53+U75RcO+mMeyscukaoQbwk06+VnUGU0y939o4CT?=
 =?us-ascii?Q?s9BizNWH7e3YabcR5WVBhoxKH8ez6NlRKJyg2WgAUQ1AZtwrbHADp4iHeyha?=
 =?us-ascii?Q?Ta5yvU5SoMiUewWHxWzcYxUBDxZv7PAtVCD4Mm+7+vneUNIch5mWKgubITTg?=
 =?us-ascii?Q?ApWFOp3uKEE2SjkFHkmu+3z9kLCLI76wqTNt7vd3/juaa70XLsIhDTkQYwl5?=
 =?us-ascii?Q?UOjD9Q71wHwUESqhYCKcgoyL7+v2QJ/cin57x4vwMb5BytqBCNdOBhAaLkTk?=
 =?us-ascii?Q?5yI7kuVdl3+YjyLAkNXUZnej8XKtxFgfGbycOkYPbo/N0GAyD2KJdZ3Ttep6?=
 =?us-ascii?Q?DOUl+3j5QwEJJ2zKVTjw5J1/dteNH7qUzm8tbZ+m2Hq9DEQRs+KGofFUOW7y?=
 =?us-ascii?Q?dUY32AiW5x+7av/aOhl5s2McuBjgihju8qzd+SrQXGddEoJ7GkR+Y9PI6NF4?=
 =?us-ascii?Q?VYayc7Hky3/EcuByQLvM02qnKba5ZhZv1k30Pwb0aR4YvmSIIA2zOi9UHFFV?=
 =?us-ascii?Q?9FAidG5xbft8oBQMcODvizno3htkRFBx21JCyAHrNF7YYteBhz6r38C7JsvR?=
 =?us-ascii?Q?k0septEidFFnKGdzbEAVabrPI8ZXzmIg/peUcDKH/V3o0Ti3FIV1c9/biJKl?=
 =?us-ascii?Q?XSmnpY9+HUusvMn5EpS90x7rl25Fwhw+QOuk7SFzygeXmQjHpvYpv+/XKw+X?=
 =?us-ascii?Q?fXoQQcaTyPk5KMd9di0F6qlbmuEw0YJ+JA7xVUXhSM8EjL+PDWp8YK5RmNcK?=
 =?us-ascii?Q?LDoZomuI//iiVfLyfsSrFjMe7hOAZuvHkz8h5w0m00oKW9YmvWL6m9aOCOQh?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bc7738-e8fd-4450-2ed3-08db6e9e2331
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 19:16:07.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rNxbzXnGRP9BoDD4CzxbaxVl8GdfM+fZwgQGakwHJ3z1hlMwAaidfX9Llw4I/ksE/XW+5iK4f/wgts6IgG+XpJaf3rlv2PBRshV86o9H54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6212
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> Dan Williams wrote:
> > Per CXL 3.0 9.14 "Back-Invalidation Configuration", in order to enable
> > an HDM-DB range (CXL.mem region with device initiated back-invalidation
> > support), all ports in the path between the endpoint and the host bridge
> > must be in 256-bit flit-mode.
> > 
> > Even for typical Type-3 class devices it is useful to enumerate link
> > capabilities through the topology for debug purposes.
> > 
> > See CXL 3.0 Table-64 "256B Flit Mode vs. 68B Flit Mode Operation", for
> > how to determine 64B vs 256B Flit mode operation.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/pci.c  |  113 +++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/port.c |    6 ++
> >  drivers/cxl/cxl.h       |    7 +++
> >  drivers/cxl/cxlpci.h    |   24 +++++++++-
> >  drivers/cxl/port.c      |    5 ++
> >  5 files changed, 153 insertions(+), 2 deletions(-)
> 
> Going back over this again I noticed that it fails to actually store the
> "features" in the port object, and it fails to claim that the root CXL
> device can support all the capabilities. Here are those fixups to fold
> in:

...and now it occurs to me that this approach falls over for RCH
topologies as the link status registers potentially move into the RCRB
space. So I want to test this on an RCH topology before this moves
forward. The cxl_test RCH topology does not suffice since it only
emulates the topology, not the register behavior, and QEMU is VH only.
