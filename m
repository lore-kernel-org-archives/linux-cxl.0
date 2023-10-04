Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC7CE7C4E9
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 18:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244241AbjJDSul (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Oct 2023 14:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244219AbjJDSuk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Oct 2023 14:50:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2555EA7
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 11:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696445436; x=1727981436;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gFb91stNmalGf7OKyckMG3YJxLFYlL5VXv9IJeZhSes=;
  b=WOU0FYA43byrCpCRLmWEhffNc7ztGtgMt2PF3cC75btlyYHeTXX+r59V
   ldCPHOA39apdcGTMBTnScMUOo7jcRAceEjq8BW241AEWSG7gSpz6GlKJ0
   imYJUpajeU7J4lI4k5sxVQ4+v+aS5BZPx5VszVP2cNodOISdABbN+1Ncy
   BKsS6EqmDOI4QrdbhEDkKXhIU+rTWw9PRVbvH+ueiSIvVGolwBxoCEhRj
   I0z+R6TAU0hCEtN8pR7eN+27JFDiOo4d2S2cR8IBdTLXXnk3+dcmufZBs
   Yu4s/gniYosr8JbvBibEWwoMGYzki4fGdBqzrdTOFQJclh51MuSLS5+ss
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="387136793"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="387136793"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="701246359"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="701246359"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 11:50:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 11:50:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 11:50:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 11:50:34 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 11:50:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEOrBPGyGcq4TunXQ0251SPl8LG6VW28ROV6H0n1iBkvN6irX/xJI/7li05hS6oZAESiwsWKlZm9X50lis+DZ8tHrav7Hm3vWClUZwlu7NZUZqMkhPLRGtajuXsCXdA6CzWgYysdVD30qG1OG2dLfMIRt9AApHZMhFLwYuIpmeYJCazGd15qOR3mtfJKhqoYnMxAalRBNZxWlsk3xA7/K3B1LOwpO4E/a88S5wHGWxGMpIm0D2LIYA1/scx4U/lqyD/Er3XkidA9+n99ulxDTjRRWBt3QhgKybss3uVQ7aciw/YGUpUtuH71GyYraWeI1mwJhWrIjMxeFgjVgWU8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU/ZrRyWAS09/Tahkvk2aRh23vvNMnh3b2b48s+y394=;
 b=iY7SYcNqnjapal6HAmEiVjoDQCousgYTJU6af9AE4IvfVTRJqAqx/3GrRMuYrLv4XNDUkhNLwz/oHjbFEU/FjFC4XlSSmxcR2OewhzbaCdZnBFlRTTRiscK3Kn3Rmqr95NwWt99kmT5YUcLbhvgSCn5Ozac6WGg44+yH/2PCH8kQu9owZTDPQzI0cmqMxP7hQns104ldbUhJByCnusDvFiwWb7B3Dsm9GE7RzAgiicUlucu8WGF/Zf25OpnfhwSzU/LSE7aMS71ygkXXM1jH6mqAPMhA37PpB7D3uLJSmGV46GH0bvjXOFYAcHslQap+hTyhcl4itkup0Fjew1YG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6476.namprd11.prod.outlook.com (2603:10b6:510:1f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Wed, 4 Oct
 2023 18:50:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 18:50:32 +0000
Date:   Wed, 4 Oct 2023 11:50:29 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2 3/4] cxl/pci: Fix sanitize notifier setup
Message-ID: <651db3f5333e7_ae7e7294be@dwillia2-xfh.jf.intel.com.notmuch>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
 <zs7jliubdhd6e7eabzukvale7bfoltk7ja5lwvvue2df2n2vol@4nhsl2gzdcfw>
 <651cbb54d1ebd_ae7e7294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <z43unomoc6f542g5qxgc3zzjtrjdfnqckywd32jzavyzcouana@buy5wxxsnuty>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <z43unomoc6f542g5qxgc3zzjtrjdfnqckywd32jzavyzcouana@buy5wxxsnuty>
X-ClientProxiedBy: MW4PR04CA0228.namprd04.prod.outlook.com
 (2603:10b6:303:87::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: f37d2f0c-c31a-43d7-2b78-08dbc50ac95f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjZkmQXADR/pty1Fo5x/aXGyZcrm5BK/YRZOUIcBJXny98qJxsbIelb2JexFF3VLrWRdB7IgGatB/37a93DYKvtWCYllUvLEl+IBFpwPbxKB/mbg7/g/Ha04edQ0gofHJAuYW0h8Z5R9VuROwJkC1eGKSvMAY0H3rMUxSDGVQKW7PeIIcbvG5dCjf2Frm20+iLjLnOBN00lW77Ab+gbg/ZKMYO/yyYKS+95k0rrK04gskBckjXTB1OwR0laLz+YEv3cpf4FtgcKCrxujgQYK7zeJVrUouKHT1EEH9jqwFJmfvCxwGJq10437TS212a6/HdOeCVM7tYx/3KOMLntbqMh4KE+gWDIGWLwJ4+CD5carMPSlWt15InppGdoxOu0mjdm/ojvHTv0jP54UO5NTu5efbqHzYcbFz0RkxW5VK48G1myEeB8iTDNxjRQt6oBD9ipZamDUZxH1G1sllr9imk0+ykAX6Mhd5JKwGY8KOUo/r1S4a0yu0EZTSifuv8QrVHvGSLoAhnXDKHTTe5/T/0LNda2LaZRQk/hR5gxwcLxPIb2DhDdHONH6Sgv3aSU4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(26005)(478600001)(6512007)(9686003)(6666004)(8676002)(107886003)(41300700001)(110136005)(2906002)(66946007)(4326008)(8936002)(5660300002)(54906003)(66556008)(66476007)(6506007)(38100700002)(82960400001)(316002)(86362001)(6486002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nJgGFKKlkiEXBvzHtYMo6TiqxCnpwYO6tP8FQmvYpZkoOj52bqjDldVkwKlb?=
 =?us-ascii?Q?0242xfQEgyJ7QBPhMEGM3Pk5SYVZpmjDXPZrgcskMF4eROj++/rk9F0b2u/6?=
 =?us-ascii?Q?9ApfLS04pyXEZ/99txm4gJdAenbj5gxoVsJ1xM6H5X42W1A1Dp452nUrQqB3?=
 =?us-ascii?Q?k8iLdx9tWe/4xjoeJ7J0gWJYBlfrvYSdwBMbqloVoD6Hq7p4Xqb2PK3e9grj?=
 =?us-ascii?Q?jbeAieDPJyLRtoW0Sw+FWXTtihV4CGcP+HUmHF4qKrBW38TwjgmXWRC5Ipet?=
 =?us-ascii?Q?qzWz9JS7Glz0LivGd6M0fjUq5Mw6fF+yNh0oYSlngiQop5eGwHMW+96Zl6T4?=
 =?us-ascii?Q?EuGnS/S8ceksrbpev+UPCNLNxsIfWKnCQ4jPHBBPRMZTQrU2yJyNvcP2HZCE?=
 =?us-ascii?Q?FO0R/zQ+xoyPRtuiiL60TWcfND6RkU1PRvV7zp5N690yqD7YcMCCxIuiieqg?=
 =?us-ascii?Q?GRgItG2mLRSK6iudujf+ANxaWsq5/IrPxiCBwf4xV9xT6dHr/Up927ru3Ivj?=
 =?us-ascii?Q?f5tCEHNAPZcI7ort9/tXRdofurRhZwIrU1LXxzpOnpTfNk5AYZG5ofVba2IF?=
 =?us-ascii?Q?IWTBV/LZ+zRaXNoH0mU5G39QBSMbZmKKjMBFhXVZKF6boSQhkO5O92nyyD38?=
 =?us-ascii?Q?YDTTuRvnjv66g4ccZm6iFEliUFDC0ngXpnGzz3j5mVhR4u27GkO/XaO5bDJh?=
 =?us-ascii?Q?WkBZYn9gmqcKX2QSFl1ZP+PnOEoNRSJK2IWy2YBxyECCbFEvFfmgc6pK7ShO?=
 =?us-ascii?Q?/QqgbNMtTljhDfCuVKeF68dfZJnS3qqAgBM8xzo7lpSmUPBmmoPJC0fWhjC3?=
 =?us-ascii?Q?Xzldr+nj6WY13dKy8rWE8e6iiFL9rV+gZ95ohTxh8kHFSlEp9wKvsBVYRX8R?=
 =?us-ascii?Q?f8y6b/VUuCuyPy5c3zgxnlgsVIXUUowAWkdi94m2bes5nw8CRFEs2/W9FYX5?=
 =?us-ascii?Q?6dQqTCJxOLDfcjyozs+u9TmsaiWhDyFrlHSZRlzDiPu8bze7zCbS5CTRQL3n?=
 =?us-ascii?Q?1KttGDavGmLp8JK7MMnd80+xjm3QBzM5BQHsI7QrBUT9Oly/Gxe5phZQGgFN?=
 =?us-ascii?Q?MIl1Z1ULWOUopYOktJFbdEr7QKsGQHN9yaU0BDvMqBU1xx1yrN/TxCK7Nkie?=
 =?us-ascii?Q?syKPta0nCmHtdOBU4QqKqiRHlyuW/VUXLWLRt4OCwNrJA1mutLuR4C+Iw9DO?=
 =?us-ascii?Q?C78B2AY4yaJoP6ri/KfoHtRmK/nYWKTWPZkXsSpFb07gZcLVNK8ZmSRGPoBa?=
 =?us-ascii?Q?Q/+xokLR2xi2xfy/0e8WHIKP5u+34EQC15jxCA0r5/b005/NUDZ5KWsF8IgO?=
 =?us-ascii?Q?isEuXdS5Ljz6PgQW1xUCJnihIk9xisXF120vrfJ1w1jXxgX6+mIgNVdUKoaR?=
 =?us-ascii?Q?vqnPxBUUmRC6LU+zfl9nvKmEQwery6IZZ4VKRy3p4mQ4FTnHnrd1QjQe4FK4?=
 =?us-ascii?Q?GYPT8D19gUL1ah7CzdZpYeWnwRxf+wJvGI2+ROApM0DEgT1p+zI+NCiQglAF?=
 =?us-ascii?Q?wEKjhnVVQOi7dcQx7iKFX87g3qkRhG4VPRacz1a6RSCtXnkn8kG2QY2d6klc?=
 =?us-ascii?Q?ia6cZ8OE3A3El0+T3LKSzsGTHkAC7Z+io1bWrUFiu4EC47xLs7RJvN7PgOK9?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f37d2f0c-c31a-43d7-2b78-08dbc50ac95f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 18:50:32.3615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P15DEmOOF7WfpAXGK9Qzycn4dP+nBMFsxdz5WjrTdgR2/S46Jy2XXK6+ap1CBvkW3GlO7yzvNAqDISRBs2ToVZs+6Zyh++qpojI4am5gAro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6476
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Tue, 03 Oct 2023, Dan Williams wrote:
> 
> >Davidlohr Bueso wrote:
> >> On Fri, 29 Sep 2023, Dan Williams wrote:
> >>
> >> >+static int cxl_sanitize_setup_notifier(struct cxl_memdev *cxlmd)
> >> >+{
> >> >+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >> >+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> >> >+	struct device *dev = cxlds->dev;
> >>
> >> This wants to be dev = &cxlmd->dev;
> >
> >No, the notifier needs to be torn down in the cxl_pci teardown path. If
> >cxlmd->dev was the devm operations host then this notifier would need to
> >be setup from the cxl_mem driver, not cxl_pci. The teardown order of
> >cxl_pci ends with @cxlds->dev as the devm host ends up as:
> >
> >cxl_sanitize_teardown_notifier()
> >cxl_memdev_unregister()
> >
> >...otherwise if the @cxlmd->dev is used then the devm callback may not
> >fire until device_release() time since it is possible that the cxl_mem
> >driver never attaches to trigger the typical devm action around
> >->remove() time.
> 
> As is, the first sysfs_get_dirent() fails, fyi.

I should say that I misread your motivation for changing the dev because
that would also change the devm host, and now I see the bug.
