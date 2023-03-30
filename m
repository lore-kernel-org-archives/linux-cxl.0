Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E60C761A6
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 18:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjC3Stf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjC3Stc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 14:49:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380DBCDF9
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 11:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680202171; x=1711738171;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BrJTqXm/rJpTdCDr7coTAwQJKfUp19N/ICJAqSj6Z9Q=;
  b=DPjsaJoiU3uoNC9AI7O+cIB/TIGv/P6+kf8E1kh738PDTxiuUpxwybQV
   O7SJUcGSssh55sHTdlkvvPz9EF6JxnYv03/NIZ8LLwwmgoGc1oS8iyufz
   v+lEZiAYrMr+wgTgBNAWQrjgpGmMgI3kPlHNZlkQEFk6HfWR/ISEsOMKz
   P/acesrDHS4R/NHXFsMjP3ZePl/Y2vtD/0nE5/SqyU2+hz52C/rijpoFe
   01mhyjgjFRcqZt1vUcKGPaOYwCYtWH8oqdKyVX6YXrmqFn2Ju4h4LaToe
   VgD4mARMBbQrL9K6sF6m85hJ+x5PnV3RSGMsumh17rSOw2f5HrTY4cSxu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="406257493"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="406257493"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 11:49:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="684817846"
X-IronPort-AV: E=Sophos;i="5.98,305,1673942400"; 
   d="scan'208";a="684817846"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 30 Mar 2023 11:49:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 11:49:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 30 Mar 2023 11:49:30 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 30 Mar 2023 11:49:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqcVhXqV+AuvGGFxDQQMt3okX4NMwBOrtkhn4JZ6wtB2jZ0nbg+/htvZFR04/VKxNNpD2s1TdaY6USSNR93ORvS2HCzfd3P82xPSw9jkeLAkvHlLGlzXww3nHt44+azgfbr7qSUOIdcTQBKvggpTRrSuZdfssWiSv6/8xItmGFCIWWL9zY10yZeiERU0PoxXHGWUKtn891e+4xc9V/zCXzNYSVE9AXc7pyf3XlmuhjH8k/JSyESkm6LRCGFl35Gf8oVYgiFQUvLMa3DPLxVbkbRXvElydmt3JXG4QPRSLtHUnef3oh+5y85QaC6Sn/mYu0WZFCXYOcQsFAQh3AZgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXYlBlqJdTFWAf1nKRxoul0zUvdqOQeCHoV630hcuBg=;
 b=C/oQZzLnheICnQL2Z7aFD8hiXsxOP89a1frcbu5sWAPXf0e/fr1P4s1kHiXd4kAZCndQfHHDeX2VIS+mHrnd+b4YsJhv5ttdxvM3exxYc0pZIEJNueIxEGILIgs23v8F+I1HSl+4OeGZAFqPgHfCXwghLALkigyrxSHV5xANROi2M0FcT/iB1usNPZt0KuhnFSwAZ1v5FL255/Qxvh78cQgifL97ZNavNBGlx0zuQaeRwlk6rvgqnPBIpccPf5w9T+u3IWrF3xuLfnlBUYHSncHFwo4hx5WEkkjvsxe1esmiACgm1pQCZmGkNqd7Tmt5yb82oQTnnz9dl0LFeHRkgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5424.namprd11.prod.outlook.com (2603:10b6:5:39c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 18:49:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%4]) with mapi id 15.20.6254.021; Thu, 30 Mar 2023
 18:49:28 +0000
Date:   Thu, 30 Mar 2023 11:49:26 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Avoid NULL deref when component registers are
 missing
Message-ID: <6425d9b6bf502_c722294db@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168012574357.221280.5001364964799725366.stgit@dwillia2-xfh.jf.intel.com>
 <20230330181916.00007fb8@Huawei.com>
 <6425d2be21bce_c7222944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20230330192758.00001c08@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330192758.00001c08@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aaa301a-66a4-4cf4-f3d4-08db314f7dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jk6tugbJ9FhvHn6VENwAZGOmItky9GTrd9F3YPke4zeubCm6PGvZauwn7JJGGjG2M9YcYsnwrqqLsOGxsfKChqMm33eNEmKyHbr8wVn3aw0Waw9ugibLKFeQ9tzUbiM55hEMjhh3/mG0WQtCwvnTr/UIAZDvcXoef1qLL6zLWE3cvMOAS1gCXQ3gRJGS8DrrqvGH2MW5Zr0RaNsvlYzGA6yaFXTEeWp/+ODpXkcfOFRYhr3EZNVWMTKFiebaxNbfJYRNBzA/1yTEQMAiw/KLhN6jFSn6ROXyS9vGGP0932BR+akJrKSgl5syAysmZni1aXFaeUGEVqhxHs9VayxU6xeWusK2j9L+rlqEzfaSUejxJduJPpZ8KCLAYXqMFP5aSYAltcdv5gTYwZZZciF202/jsDquCySMQn7TK4bkmFB3Zm1Vq3AqkJkduca9ZQ8PXE1emOh4nCJhdgjq55oCVxdVgQHuSD7qvo/pRZTzoVfKKvnX70ocg3+WwtVygZNNWZVBjEJC3srYLwXF5oAovm7L9AG5IqYBv5xo0vAwAanu84upDMYufZATQZD7yqaq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(86362001)(2906002)(478600001)(6512007)(9686003)(6506007)(83380400001)(107886003)(6486002)(26005)(66476007)(316002)(66556008)(66946007)(41300700001)(186003)(82960400001)(8936002)(4326008)(8676002)(38100700002)(110136005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LjmeOGqT0Bb9m81zQtN67xuEePmgAUNPCsqdLq5i1eIWqw2/BUeuYfFx2Y0W?=
 =?us-ascii?Q?OghAjuh6acHNOOyLxypZkRp7GA4fG2aBz+a3X6AlU6Y8Wyjiwk08v52tnZD/?=
 =?us-ascii?Q?Tv9o842AHZCRFP3KaGdGOfX1a53LUYejRbsExhcKCQeWC1Wwu4i0Lknn4KxL?=
 =?us-ascii?Q?yfbEjzuEq4Ys17bmweP9AuELnQFzPNnBHa/qCI1Suh5nIQoq2UUtTO64phSJ?=
 =?us-ascii?Q?NxARLQXLPprrWh80BDJB8DbUMGOga90pXKELSnacfYvFAlLPpkfyU/mUHPRW?=
 =?us-ascii?Q?fDN0lNAr2pHbKL9L9Suuabmc5ri6AVUKGN7IzXTIU5D/H6BrFMZu80nKztGz?=
 =?us-ascii?Q?L57+EyTAz70M99nbxrXQni/zxtglsiyvE93XKwn7DPFZnwjzVicssbIBUfYI?=
 =?us-ascii?Q?+y/mH7F2awAQLhtvWkdaUnTgg0mOYByUnHB61t97IO4a8u+UJwEHpD9Y3dhw?=
 =?us-ascii?Q?p/ns3CFZGOFDoe7zaQHNNKisxPKPhW6iR+1l5REFpbxwXdnBg2gQKvuUPVtr?=
 =?us-ascii?Q?eG8s7WXz8KsYBew5hHHcXZS7wjhSIcZgDqYJ4cb0MD+JkgMhSFFu/zid2rqr?=
 =?us-ascii?Q?Q2TyG7OtQ4vD7b82dniAnAYNxNBm4yAl+w7i4Kvcfug16abSKEa811I6hBKO?=
 =?us-ascii?Q?sInC7P3TzwOcyOuEPvZzeLKaRih5Thz8DIEi0eAXF2N/+BIbOXo+oHFtSRBg?=
 =?us-ascii?Q?F6KofCUEyeNsM6EdGLlifAIVgFaSRIbKZ4Mo7lcTGQWF0q2/GdQrHiykxm2v?=
 =?us-ascii?Q?2KWhzmlhPfE/CMisTvStRMIuCPSDN+D2p1gL19WnG4wKnqO7TeklyA/jh8Xw?=
 =?us-ascii?Q?qyq051mCquRu2bvpR3Ff3762n/aUl3TEvP+QGBpabSpHehHJ33lGTwQr/kW7?=
 =?us-ascii?Q?oApIwSEQ9ehrqIdL76m6Z1dboc7dQsq6aqcjKxh1CpEsIdyD7an0j6M9kq33?=
 =?us-ascii?Q?ujIgiD+StVuHTqLElkW56R7XOMe45cH5fmHQgabRpOjEI+joH5845gBYLR7F?=
 =?us-ascii?Q?Px+15YYtZyIRMyCAQn5952vs3jm1nJMSSZz5uZU6bTR57RWzo1mjQO6Q18CO?=
 =?us-ascii?Q?DEXWUMOXHJFAjMR0e4TNgp041/MEpNsx8xMWJsRDbhmZ3Fhs5U54NEOEO4zQ?=
 =?us-ascii?Q?hdNLBohhT9NP34ZmROftADAULml7zozTXnbcN2o0epSZzf6KO5fOqSiZVqcg?=
 =?us-ascii?Q?HVUTtM1jOJEzQkRR/ZZZJrp3+vwVdPF4DPgSbE+Hj3zm/avv0ogWdsb5RsJT?=
 =?us-ascii?Q?GDZWW2XLeQJ69W2wE9aFOyXBIeHeUzSF58OnDxhQniSj+qznzHtFLJ74KDcM?=
 =?us-ascii?Q?uokZSNVS4lwIfCBwkhcPvmKQn8MGcU5nBekcktB4rocKCfFvpM9NpMq40Eb2?=
 =?us-ascii?Q?S0re2oJXeK/2YjrrseILhaT4bJ4xJWhOuprxB2Dl+1oXeb+moNm2tk7YCI5i?=
 =?us-ascii?Q?ktDgxMuRatmMSB+P8f2KrqoiDnld9R4fQTtyOYFxGEyWUnZEYpJ9ovoomUL7?=
 =?us-ascii?Q?JziIZaoXCw0h+/+ao+za71Eyan8J6NEbss4YEG5/wRRrVPxqTlSYYmnQehCx?=
 =?us-ascii?Q?To5YGnGamSjAnmYFNFN888C9idNU7k1C5DYslUQbkz9vcgamtkPw/gzuaFFX?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aaa301a-66a4-4cf4-f3d4-08db314f7dd7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 18:49:28.8368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtBTO8PMrw8+lMcck0JqcLZFWryecVSbYY1zaTHoEYCLL5gW2sPstRrtNt+oKYPHa5lf0GZI8Eggs60A7IcBMhWQ0OJcXYGTW/mVdVUgROQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5424
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 30 Mar 2023 11:19:42 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > > On Wed, 29 Mar 2023 14:35:43 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >   
> > > > The cxl_port driver attempts to support endpoint devices that do not
> > > > advertise a component register block, but by inspection
> > > > devm_cxl_setup_hdm() passes a NULL @crb to helper functions that should
> > > > be skipped.
> > > > 
> > > > Return early and skip setting target_count since that is only relevant
> > > > for switch decoders, not endpoint decoders.  
> > > 
> > > This is a good observation. It would be nice to not read it for the
> > > HDM decoder path either. Obviously we don't use it so that doesn't do
> > > any harm, but to someone reading the code it looks like we care about the
> > > value.  I'm not immediately sure how we'd establish at this layer that
> > > the HDM decoder is a switch or HB one though..  
> > 
> > @info is NULL when this routine is called for non-endpoint decoders.
> 
> Ah, so we could pass a flag into parse_hdm_decoder_caps() and not read
> the value if it has no meaning for the particular decoder.

How about kerneldoc on 'struct cxl_hdm' clarifying @target_count and
other fields, because I don't see the benefit of logic to skip parsing
that field. The overhead of an MMIO cycle to read the capability
register has already been spent.
