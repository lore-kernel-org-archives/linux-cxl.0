Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A1AC77B7C
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 22:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbjEKWvD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 18:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjEKWvC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 18:51:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3AF49C8
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 15:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683845462; x=1715381462;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wLXYRAsy3cAN5b8O7G3f4DInQlnIxnde674/5hVH15o=;
  b=WJuVWKgIpIgI4LdxAQaFw7rYzLnufqRCVL20RrpO7x5tqGR6Di0njJbq
   scq7o/3ZOvSOeVRMzZD32tdr7re8whzICRGXX7wFo4VIfDhCKIHDy+RYF
   N7M13Yr0AcRyIbRYwnRyur8l6V7vBG5VlqmWlrOqiWz3czHLB66INOe2A
   xX5NLg737x7fuf1eQk9xyyCPVIqOMtUo3DcI1EAJvOBPIhG5nbob6fJr6
   eNDc6Xdur8scJ3ugb3n+deqyy68IKDTxGwwkb2Is2dI1r7KR/eEOZxLZ5
   kJHP1aEN38Mk37Vjl5sqWtAdWlt2MeRBE4ukLdHY1Fzn6MGtO2S/4koNd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="378788013"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="378788013"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 15:51:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="874157009"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="874157009"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 11 May 2023 15:51:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 15:50:59 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 15:50:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 15:50:59 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 15:50:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2tphw2dVK/GQi39ylINhBwCW9yiW9FrO2juiJsuNoLiv+2gTa7B1cpEzLVyEwfnoRw0N4Oj8ASyXzB08qt6i8MsNJ58IK7PG0jd7dsUC/P3kcPk33zi5DtDHF6+7Hb9Ijbb/qxNuZ4a91+7BD03+5N5wdla+6/WSKDWdEGFO9Kw0XdCl2Rm3nJ2DJkoUnvRS+FovcHdptJuwChNVBfcEqju+Im6s/MMUFhk8ElLTDPZ32omUSXEqJLqoXdk7uFxY7Ve/Wc3zGBdmf0ww+frldLdYAYG9QlQ9pt+bCMFHBLbCNa+v4uCPBeeL6doSzOxKxCI4tWhsmx7srBNpe2fTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcgvBnjfhLcIiNvUsE7zFx1/QGvP3PhycRSGAv7PZkk=;
 b=j9R1Aqax31IZ5RUGG5uA19BUIlZNcP6NR/qDk+JVFH1mGQkDILFS9ECZPwOJQ1RShyH75bejpunjy4syCemmfenWH8OVbgK53Ytw1A8ypNo/1jSvLfKIqTpiz2dcvK52OgBW2gEG5vt8Ds90CknmGo+M7VW0G8bt6oBBvFdgeQk9B/99tYJKEptMtZvObkq97sLKld7onkBSaLRnaWz889KD0utImEVvvyx/ppUxgS5XJnio8WFtR6fKuf3Risg/OIhAZwAAIMa0PvPVHdfPQowbOhzYbZC/1ARSRQJToZ3V4TDbzCAl9M7thOYC686jpNup1IriASV0BdV1TN1Rcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7332.namprd11.prod.outlook.com (2603:10b6:208:434::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 22:50:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6387.022; Thu, 11 May 2023
 22:50:56 +0000
Date:   Thu, 11 May 2023 15:50:54 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [RFC 2/3] x86/numa: Introduce numa_remove_memblks(node, start,
 end)
Message-ID: <645d714e62c4e_1e6f29423@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1683742429.git.alison.schofield@intel.com>
 <57bc9bb8823a295dc71d7e8ff8ae93a3af8c0be3.1683742429.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <57bc9bb8823a295dc71d7e8ff8ae93a3af8c0be3.1683742429.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR13CA0239.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: df1d1a68-c262-4ee8-4a73-08db52722e84
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMUamOD8342LpHwpqjRd9wPT0TWhZ7k1Ccmdz0F+XM7gcXzVhzSfWxtY5oHNIdBN6btiiCHA3SxXiP1ONhyMMeEo4gkSdlvR40+VIFiXo/8bg2DWn0DLzZ7tRWTDJVPJKi0B3+fpi6xC5hnldzO2NJpC/3IGZqlH62O8oLnPwroSvcrKLtOCk6gtYA1Lj8af3DeFXxPXmO3XOODgSirXwtjFqLHXhCITV++Kk0G8aZvxzj6ya5y1r+FS8WwpBK0UVSBo1Pb/Kx/YN004NMG7STcnBK6SNcLFGIzkkDfX7Z2c5UkpchgG7oCMVrKTtTu1BoW3OHPT6ertvQw7rLaSo7tyu74exKLk9O2oFyCKbDOwj9PQLrizR6I9U65xhD1oSJKKm63l7L+R+hL1+GrLySsdiGiIo+Lu2uNpVp+4UpgKnMXKVo+iGz/U3X4Sd0N+Q2gHzV8+FmWUQ9fDbuGtFaSMeaGHUd/Xty8OcxGCuqWvn2Aabu9+soX2DSBuaw6HQrNOZcNBN8pRqV5jiG3M1J8oNkY4sej8S2vE7oH++NppG13xkfQSJa4VTP0bpsQW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(5660300002)(8676002)(8936002)(83380400001)(2906002)(186003)(82960400001)(38100700002)(86362001)(26005)(6512007)(4326008)(6506007)(9686003)(41300700001)(66946007)(66556008)(66476007)(478600001)(316002)(6486002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X660TfGOADQV5+rZUfq53m6ZiCTN0CenqWxR0ewdUS5COfxhbmkqDsP9QMx6?=
 =?us-ascii?Q?Jhf922tY//opwogWLOifSVbA+s6HCYdZ0AsIprfKvZd4TtVvyAlt2FZjHn2T?=
 =?us-ascii?Q?UhDgzzo2Vm9OmqidSjEstyTlh0Wv3TLXQczNZVlVALxcVq9p1bO+zZmv55yO?=
 =?us-ascii?Q?wVqMIvw3CC3E1VKcNoOlebI0j4J2ES8+X0MIaiSoefYQVrmXxpU02gxnvhYV?=
 =?us-ascii?Q?perHLhAwEDE8YB2cRyYoKfPMtlvTXbi0bMA9Q6EtyFSZCjBBTL5zNOK8hafH?=
 =?us-ascii?Q?66OcLVyC3XRW0WQS/IBIOsWp4tl1Ty1bFi0Ce7e9zDSNO/klia3XmmgAmxub?=
 =?us-ascii?Q?gdPBcQZlByVmyyRs5xVTKU7p6nEcXqVQO63IOxVotyCYRXcs5sQDlR13+SMo?=
 =?us-ascii?Q?WuOJiwQgVCenrRFqiQP3wrH2mjv+Gw7O6fZ4wVgwc0px160xVYVqi9akpodf?=
 =?us-ascii?Q?lnDVR7HfwqaMOinUynhHpqxDoiNQorORtXuFUmZsc3x47QcqmtpG5hcHTuAd?=
 =?us-ascii?Q?vbGVmG2FBV9h/vWnIL7beXmMaV0Rfx5luVeOoHiRVqWJPYkjaZgyB7nhOczU?=
 =?us-ascii?Q?3kg8pfzuww0coF7ZitLRlT6U69ywJ0Ccyvu7sjlIUtQnepRh9WmVIWWU7Cor?=
 =?us-ascii?Q?H5HFBF/ByP9jq4IrEw0FBcUxkLyGHkWV0KsuVzar9XpYZ/wpZVGm9FAIXdJ2?=
 =?us-ascii?Q?TiFtheO0+UAsdUwEXB/Flz1R+nNe935kjn+Xj7arRbYTfj6Dx7ABG3wWZArw?=
 =?us-ascii?Q?NR59dy/62qriMpLL23E1YaCeE2/nR/DumiwebJmHHfUZlMamRvG6+LJlE2jW?=
 =?us-ascii?Q?dyv8T1NpEeyEkiyHTZ10u6LPHaShBz3xbldZ6iWeEgZCa4lweNxGJWm7DdRq?=
 =?us-ascii?Q?wV1elbedbeWuK/ClQreOHAAZEUkoyUMyTHFcSGHJ5e8ia3bmsC01JxR9LYfW?=
 =?us-ascii?Q?rh6YEbkbbBBpmRxhnfgBWN9Rv8zSHIiJFoC3iYlJG2y2g+b91f20BdN8Ooyj?=
 =?us-ascii?Q?k6TmFNF/nRHCfUbKlCWaX/hyh08ibsBpiDPDdHIy+QSd/hM6NcXBirAjDq1a?=
 =?us-ascii?Q?f8qZHuiZ8AG8Yrx5s9BKUDcWtD2XECxfs7vQhoK/HCkxVXtVTGJQmjvOZB41?=
 =?us-ascii?Q?rwZ6KISWt1ChkmeZ/2vHsEscUG2ASSVKg2AB8JRGxnlrTTnqM1rwLvO64RWD?=
 =?us-ascii?Q?gpg3PNBDAUkoG4Zv9AxZpSM8fJvMSJF4Mna/9es/WQ6KbXNjTxuqR0wd+GGo?=
 =?us-ascii?Q?m6+H6uaJah9b8uw0T8wASVUyFhEaA8Mqt12LWDXSFE1aC5Gwb9AbMaU27r7d?=
 =?us-ascii?Q?ffXskOuTthk2RoLLY15fPQ9hent/ypEDJMEw7ciWi6NNyAyQNfPbAJsweZHG?=
 =?us-ascii?Q?tIgWijbfni5PEUrcsOYgMPGUJPRI/qy7WYzz89zSlKDkFiAxIbXSf6G+Yq6D?=
 =?us-ascii?Q?+Sy+C5iiKQ35ZHCm6DVmG/R5ApNx1zXqvjnUlr5i0xIu/2nS5szdifQnSUxs?=
 =?us-ascii?Q?dsVqatU51oLtUuPxydgLvMZkClhyhevb4VDT9c7QFyY4ZiCSYO+MLkZRsYfI?=
 =?us-ascii?Q?N7IDzFqmlveR2gizuun+0AKP9oe+tEs9mqflkBWqIyPoVRNES0S9xnC8bFg7?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df1d1a68-c262-4ee8-4a73-08db52722e84
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 22:50:56.5126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZ2T0uEb5Z1aD3lP4QOPp4I1kroKPUlADdqDZtkSi8KhxL2hhSKvokGqJd0/hez5joTZRcB7x59FZcra6sBy4nEwWpDRNxv0lfXwLq1xwIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7332
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add support for removing memblks from numa_meminfo that are
> within a start/end range, and of a node.
> 
> numa_add_memblk() allows in kernel users to add a memblk to
> a NUMA node. There is no method exposed to remove a memblk.
> 
> The use case here is to allow the ACPI driver to remove
> redundant memblks when it knows they exist, rather than
> implementing a cleanup that needlessly walks all memblks
> during a cleanup phase.

Again this assumes a particular way to solve the memblk update problem,
it's not clear that a remove method is the way to go versus an update
method.

I.e. its not clear to me where the "redundant" memblks appear.


> numa_cleanup_meminfo() exists for merging memblks, however,
> it only considers adjacent memblks, and, it actually moves the
> memblks to numa_reserved_meminfo, before doing the cleanup.

So either the algorithm for solving the extend memblks when they overlap
CFMWS needs to be described here, or this patch needs to be squashed.
