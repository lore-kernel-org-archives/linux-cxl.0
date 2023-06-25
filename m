Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87145EB64DC
	for <linux-cxl@archiver.kernel.org>; Sun, 25 Jun 2023 20:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjFYUmO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 25 Jun 2023 16:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjFYUmN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 25 Jun 2023 16:42:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6D69B
        for <linux-cxl@vger.kernel.org>; Sun, 25 Jun 2023 13:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687725732; x=1719261732;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GgEcpcDYScggfAN67ffFESAJxBAFgHS0XBpb24Zuf2g=;
  b=nesgh/zl/A1urrPYqS85602BwjZopNPvU6m7PmfGYJfuabp4bSKnh4mB
   w4jRphM/0oV1BjhcGhkPKt+E6o8FkKsl0EqY5++0YVqIETNN8cFItfdk9
   j3RiShhIcysYnh7SZ4i9JWcTf1q2Ptv9mFzhzBaEgNvej8n+8zBhC/j0j
   ZVHS+EnudXS9h8a5AWdr0vUqPSKNjGjSoNrbM/iAczMyY184f7W/14b03
   iuXl435lkG0vTR4vcY1x/Ugfsf2UYsAaHap0wth3b/UfG98RkFzw/jxpl
   VlRkxIgQ5xjYuLLN0RIHdCsHOhUurBVxptbAc0raCkbV5NE+ichk80w3t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="391308341"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="391308341"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 13:42:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="890071314"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="890071314"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 25 Jun 2023 13:42:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 25 Jun 2023 13:42:11 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 25 Jun 2023 13:42:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 25 Jun 2023 13:42:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 13:42:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZDvbWAJfkjstLBTYh+NwnfDxmTmhGLIdBN2Op/PV2t33HjYdXqPVGt2qLM9Vt28j0Ja+KSHGkk4IPeVskEgMHkw5EVDka/OngWVbN0XNVs8c8P8C/hm9KlvP6Tys751RfLOeWXCrEjtEl7WgryYGIUWamGnIwWTC2/Ou196AxaA65AkNia6BpOAgtM4UgMRg0sm22JPuHb0po8QssnFsaXgBdmCluA6MJQKXRM5Ja99hRUxjLloK4IUSJUTr++g6STcCTjeodhub397+0NMOJ5ktzDcItOVCGheNwyyqaBJ8MvbE7MlgA3GrE8aJvAU6CRpRXclv5mmWszKJoxdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuBvvqdfgvQPRCD1JWJz8RYkTA3ObYuQR+DsGpcYjGk=;
 b=fImjCPhH+wJ7XoFpeymorodbednZNhbAm5R2klY5swoFuXKS+jGjtL7Ein/0P1p/R5qXvYfwqzKme9IkNjR1bsub3bE2Qinz9jwzy+4JWCbxqf5+faRdfWc/jI+y3gfwXlbVSvx8+RKslAmXV+jCpQkzPhMS89vFiYyYAihzvvpQ/8RurprXxE5fD94zCEgM/MO+D0RcEFoLz/E5uQUvYvLq/FmStOAodxdwLwmMLBfmX/PVL7F/PgOUl6HQ4S/FI5uqPFvZNfZij1MPQNIBzrMCiV5/qktb7CFBqD+y1qW+Q9Dg0300U4Uq3PXU7FkMiJs4LzrVJdPgo0L+iZxQZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5427.namprd11.prod.outlook.com (2603:10b6:610:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 20:42:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sun, 25 Jun 2023
 20:42:07 +0000
Date:   Sun, 25 Jun 2023 13:42:04 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/region: Fix state transitions after reset failure
Message-ID: <6498a69cbfeaa_1dff29448@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168696506332.3590522.12981963617215460385.stgit@dwillia2-xfh.jf.intel.com>
 <168696507968.3590522.14484000711718573626.stgit@dwillia2-xfh.jf.intel.com>
 <20230622101802.00003556@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230622101802.00003556@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:303:8d::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5427:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f587a3-c679-4e37-8173-08db75bca411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WkxUMaOUTRFbJZ8EpHUcwW3P6cjQnhhHInM8dWmHTyewO9+Oi0sj1gicJeUfmPdIwB1wjs3j7xpQgWjH0gb8dN29mggnc/rTZ7FRakq2uK33ovq89u6byiBzw0VrY0d/1wUyQRrKgljTDp+irHpYVsiL3SyL5mlgoAFLBm+T8Ji4ZgU6wCaFr7OByeYZQSjwP6Cpo7iPIm9yWnyZMv0SvVaJJsB6TV4MBE83KLAYahpGfbSlYYQZe9lMhp2aPdI/C0a+KtJw8zs078+cnTTC4iUnzTzefRR0tLaCCSYq2wi+m0c4Hu/aAYGUcIG3ch/vBeKxw7vxZaBaebl+CWUv3R4jxh1jHzKJxyDpx22cy4kKWIxPFEyOs8c8Ivnh/RgYuj7ojm54NCVheAWZSChbf7hHnd8kv2yO96XCYF81O+8Uvb5xeJo4n/9QgeBvkN7aGGY8ogQl79lLSzXMlTz2RUAoI/gk14fo06329Cx7x4utuwvyg0dvPhHHyc2cqiDgMu3SItqPm+c/sGxmJxSryLgiax0323g/pXqz6PZ7QEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(5660300002)(41300700001)(316002)(86362001)(66476007)(8936002)(8676002)(66556008)(4326008)(38100700002)(66946007)(82960400001)(6486002)(966005)(6512007)(26005)(6506007)(2906002)(186003)(9686003)(478600001)(110136005)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6cCuljFg2W+fLEUF9/8o5cRzGP9PGmJ40f6Y1tffXyvKmDwIwFOqFWMPb7ec?=
 =?us-ascii?Q?ieK0cQpLHixEcvvpJAuL0FMiFPEF2SJ1HH6UqHxDaUP52KChveyTzF7r9Otk?=
 =?us-ascii?Q?MyRUuejyQ9oTV70lgqsvGoeyIPqA2/Ml8geHVi/FTi1BJRtQM/2+cmPDh2Di?=
 =?us-ascii?Q?m0NwRhbtYvFyBTJ1QjWQ/U8/yr4CfaGgaCMf1zVlAx4qoNZL58SP84Ed82PC?=
 =?us-ascii?Q?y/8XzpS7Y3nyc3eu3abHVRWCvNl5iwWv4iiXgI0u6fOSgGM61mJOGXGLm0V6?=
 =?us-ascii?Q?V9C99xdfxd6CkANf6snT2q2OUGfZjf2lIAE1IlCGnRWVBAw+lYUHXZk3hwBM?=
 =?us-ascii?Q?IksZW4Dhj70bpWq2sT40mgBJXNvFuEKaTMNF0arBz7KKWWzhqCvPYAv/7Lxt?=
 =?us-ascii?Q?5KAq+fHq1ssx6aewNYR6eIEzpviTahSTDnt7YHV8F++jt9fAZVC5y/2Si59J?=
 =?us-ascii?Q?+AcYXE/Lfl5MxYW0WkjyyY5QIq9p3z29pBK3QokdQ3zQ/m4PhinUEZfYMmaQ?=
 =?us-ascii?Q?or9pGIpN7Iwi1vtdKadO0WSs4oPjMzOoZbGLfKn0WPnWvsk9UFIBppXckbRQ?=
 =?us-ascii?Q?KhTkhxA21Lr41ug5QiGg1BSG4qTmFA16gUYvyvDLKCS2O1fqa84bIAyt0DC2?=
 =?us-ascii?Q?thMLPYWcZCrduYjgVQ6i1CEohl1/EUpoiwf4vZA5OtVTn5/T05U/xdXPpfCW?=
 =?us-ascii?Q?Zd3fXdc65JB7qzhAhfR3Y66WZ4MqHWHqm8N1xxS8pJajfGm4XvjK07kgCMH6?=
 =?us-ascii?Q?yimTidbn4EwXzxvn8pxzGRvLHvyMy5qZzsvKl8sBU9M2+gWOK4JgULRLJzOC?=
 =?us-ascii?Q?HU8LSpiKot8+ddOU0FeMG9DOxzhQcMDCtU3cW1MAugmc0BVS8COmzEABBGvm?=
 =?us-ascii?Q?NxIb4KRBIyjgKuXD/IOqrCBCTTuIXzIiKyLhs6gpSJYtV/e/bvSJZvmnkgg3?=
 =?us-ascii?Q?ZMiQrJ3SvtZ0s4bv6wpeB9b1Gf2vS1tBRV0BbmdTD69WtiprQmvcm1xGmnFJ?=
 =?us-ascii?Q?/HBB9X7nfn3ey13nv48jQy/9MUf4LxAyvQFJRM6NccBV5xO9CXdYz0ciEhjn?=
 =?us-ascii?Q?UkZKZn3MI16Vj7Q6kX8HsITyH/O6MuvrOQF/7OKuQHZVoxYyUDq/Ms0H4d3F?=
 =?us-ascii?Q?ymFINFRRNz7KoQs1XY/i+PsoOPCb/st8n0WU8RUL6Ho0XBBTySgIkXUH+Qlb?=
 =?us-ascii?Q?RlrNoOxsXLaghXJtxJsYQYV1F/7D0tn2AWh3jQeAd57OXCeHaSBIJTf071/g?=
 =?us-ascii?Q?B7x9j+c2pNtlNh+RoAhjXA728kV5rwygYxc+vQqjXMF2uxZ60UZLubsqt+8w?=
 =?us-ascii?Q?ZWqg8SlLyaOlPXEnVIf1Np4zeK7N47/x+V+4PIbEMsiBu5CK12KbK3npWIVV?=
 =?us-ascii?Q?EnKkWvZmiZZZglPHN5saT2uRZrldM3hItuxxuUUcg1t5ODVux0KO0+ZBd1qz?=
 =?us-ascii?Q?YwKJtAVsWqoRQ4QBYndggP5m+HZdUInf4fK1YfG17MD/KQt2RzznWTMyebuc?=
 =?us-ascii?Q?3qtbm0EZDW7ST0AqtI/PYk0EdnTNvMyhdXHjYBNhV0C8DUTBgpfx7jJZmOfv?=
 =?us-ascii?Q?eEEDXAteYJA0gS5sqNy7hFFi1B02eK4tjLIcwFegWm0S6leEOe5lu71siIGT?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f587a3-c679-4e37-8173-08db75bca411
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 20:42:07.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCaoDdJZrIkRcC8n36gIhMvo/bTSCn6voDEjmyX9+RCKda8nVY/LadiUVxNWJOmf6P+KfHZGhfa+p1CatW3rfYbNA7+wCH/XeQDsENQHf+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5427
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 16 Jun 2023 18:24:39 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan reports that failed attempts to reset a region (teardown its
> > HDM decoder configuration) mistakenly advance the state of the region
> > to "not committed". Revert to the previous state of the region on reset
> > failure so that the reset can be re-attempted.
> > 
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Closes: http://lore.kernel.org/r/20230316171441.0000205b@Huawei.com
> > Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> LGTM - though maybe even nicer if we can be pretty sure this will succeed
> before trying it.. (same comment as previous patch)

I had the same reaction, but satisfied myself that this is something
that userspace can manage. I.e. tooling can effectively predict when the
kernel will complain about this ordering situation and prevent it. In
other words, the only way this happens in practice is if userspace makes
a mistake.

It is already the case that partially committed decoders need to be
tolerated by the platform since setup and teardown are not atomic. So I
think 'cxl destroy-region' is where this follow-on smarts belongs.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for the collaboration as always.
