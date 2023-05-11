Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA590C77B7C
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 22:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbjEKWqT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 18:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbjEKWqT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 18:46:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081342D68
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683845178; x=1715381178;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3nkF2CWWhE90ukT91TXPfdvyUyKCpEBU1D7/4xMWYeA=;
  b=KjeVN7txHyEynYKVjMVMLX3NfETSmjBpMOmQ9mNz+ZK2YcCGfourzWoq
   YjB3HFNEsCbRP5Hl0T+bM9pgnlzsY3RikiIYXBQTVIjpDlyoeEWT8omLZ
   eD4YTmQnIfWWetvHiFrctQSNfhpuI+Tfd3OndxFGLYiJoJYg/HcplJ3PD
   iW5UZIqKqk/wWyLJa936huRDaPN5Os2Xxgz+y4Eq21r4OnPBqeBBCp+PU
   B0nw8+CnP+zOvalF5DEXsihwm1Meawh0vBRrt231gF5alSh/LrME2UnZ9
   74j7hBAKBwwPpSIaIkMzBQkhRlmSnmQoo99aMPWU1PQlfVvvHdnI1g8aB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="353768574"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="353768574"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 15:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730568693"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="730568693"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2023 15:46:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 15:46:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 15:46:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 15:46:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 15:46:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjgvFXf8HSQya1HSiaw3FAmoTNLjpTsXq8SXz/8lgzenlRNbfT+VgdNFBhoxE57h7Ee2JvesG7SwjYqoE+UMkQQ9ftjkPEW1lBneXeRCDBPkGeuu6zJHDk6zyFl+ysiWTG+B6xiEnwJ5RSzdEY9bASbiQUGiTI9nH4CxwaLiC9qX31a7/9qDF+PBIBSHVWsz88kRcofQKAB6bmLnIZKtfluvdruabjTt7gHIvn3yF8twJL98sR9y1e6sCAJoFaVQ6hnzdBvOSJXs0cxMZS4SkjkTVwfypgnGRfvcefwfmY7mHqwGXe7n87cqm9NTlik3g8BXuoHgJGDESdFZGrCXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/qcONK+GsgK37dxHqePB3BxXOjvevxyjx6m+5Dgsl4=;
 b=OnmPuHYAOsy3YZIVPc95Vl5FP0LbpwfXhst9d1Ma3OwQCWfKZSSThaOLVf9nWAyqJMKRl6lrnvOHgnz0sGSBHKS0r3L4P3Zzyd+gif7EeyiwppnR7eXidzeRaKrN9q3JsMDtYV1uIsbVNPVyH8pnigT0r/k9Oqao1wJ8WBrAJJdp+voXlHiVW1Ji8+fy3uTpL5TWORl8Q7sqXW9X6Hl9Gvn+pjJIRHwJRkZrSB9c2yB7YbDH+MUWcrsuU6vyLSI6XMhq5PyXRZ2l5c5+RQ2aQBf6Qn1J6Eu74/pwmZSXwR+WSVK+QXiVY+ZuPa1Io70Ukcj6PkY8f0Nrjx4EuG1K9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7332.namprd11.prod.outlook.com (2603:10b6:208:434::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 22:46:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6387.022; Thu, 11 May 2023
 22:46:13 +0000
Date:   Thu, 11 May 2023 15:46:10 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [RFC 1/3] x86/numa: Introduce numa_find_node(start, end)
Message-ID: <645d70326e3ae_1e6f29479@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1683742429.git.alison.schofield@intel.com>
 <6bf1866161446f03105ec50c3a09de194d830bc3.1683742429.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6bf1866161446f03105ec50c3a09de194d830bc3.1683742429.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: c38828e0-84cd-4bc6-aacd-08db527185bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qxAA1h6SZU+FNilIxMnvkB1276KQVmDTAny2P2W1D5zLGnx89y6/5eonUuPJ2C8IJFZ5i5Slj3oyHxZDmP+Bz9d9dnvpNtaq+oMgTtVUI2VCvRWATNspmeKI86MHxMKaxwLsBUY5GQTaz9H3lRTqcQyFHuWNrpbkz+YI0ofB+DwVK2ckxRmBGsGezp5VKMZumz1K8bg+sduvmkLzM4xWRi4WA5OtnJ5GJ1Kj3vVH/I/sfOxzGnR8Ac8FXOq0dKQHmuhIw7lK6xQlMloJ2XeMLTe3wZR9ZwXjySc9vYhXxCxd8xCFOBUPpLjtSEpgqdfETsc6Xcx8HFme1FOPIkEnqTWnbQaWZWwMy6ZNV6gEY9H9NTOcsQSg2BywjZQDEFBrBLF2ChUWZr6ib6s4NndePAdFXMk8LstRoVtY1r+S6PUoGctdD8PIAC5u7TGZYw4EXDjLgEMjJKyU9co+Jz5SqGTSkrYlaIrxv6wV6aMuey2mj5nmseQNY4Q0oTvt97EvBUZZq2EAaIzIjjfkmuiCxC1SUqkUnnT4C/FexYaNqKSaC5ZYx+UuUlPZ9jJlBeV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(41300700001)(66476007)(66556008)(66946007)(6512007)(4326008)(26005)(9686003)(6506007)(6486002)(110136005)(316002)(478600001)(8936002)(8676002)(5660300002)(86362001)(2906002)(4744005)(83380400001)(82960400001)(38100700002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yF8EcYAtrWfD5fuIpoA88nIaOSgGXOxTpw4nWkLw+GH7TTfsdHO0vDqWEJ/i?=
 =?us-ascii?Q?28xoXLevRePt7ZGTh7zqYANVKfWI/wqt/5AQaEaI4DhCm6PS/3AXw9N83EL+?=
 =?us-ascii?Q?1CYM9ETw9M90tme5h6uSGOfVePTI+tcLFfF+X5hTfHE2o8JrmgqGldjOEl7I?=
 =?us-ascii?Q?BIP88aUjvMLGztGeD7XhqXzyZxXuj++GhA+VTc4srQc2rPCjs44xYpRzGYcB?=
 =?us-ascii?Q?7FpVwZeQr4FK4L8943u+/JzliACg/wBIbgjSxTHSmQo8o5gSaZXZgx2VvSc8?=
 =?us-ascii?Q?ZSNLEBm0AsZdJAjTqjkQJuDFg5Zdbn+VoDqfYMnGNnKt0XtEDppmSIS1KklI?=
 =?us-ascii?Q?qHh8OQL27Ze995RrRwgPxASwU93Qml3AlC3wzjGEzdpzQX9a1rbjzssjFJky?=
 =?us-ascii?Q?3TU+F3Nwnpx6TF9fuFt0CtaU/yZLVqKNSCIjeWtrADMbt5cVBFd2mN6QnGhh?=
 =?us-ascii?Q?k/p8EERLUYGSBoRtRbysJ7oHh1OITpqmnhd+brYffcxt/5pToaLobqK2jtIo?=
 =?us-ascii?Q?t8I6ltg4Mky7m9oZ8bYGHNgt2NxmVQukOSfLjgJnI/NN/6YkH4TKr3f7+Syf?=
 =?us-ascii?Q?5WnakibEpP1wcFln+X/mED0Hxt40HRfoIVvOvFNeESgfng8RK4LYJe69woAU?=
 =?us-ascii?Q?JtQESbBoAjhUhW9pVfumXUtnB9/M/fbhmR0hpNUvIUwfZJAX5Ux0O+H3R1AT?=
 =?us-ascii?Q?snF3eY7Mff1OjyngPPReBCBo2PI0tt7uqkwxsyNxSsqxhoLNvxJpTOqBfxJv?=
 =?us-ascii?Q?bBRTSau4F7qQbCpKsIoP3AkktRZLTWTtnAXHsDckbh6ODU9fU3soU3GCyRO1?=
 =?us-ascii?Q?uct4PQZe5nReGu/7RJU6cqrC/xD6vKMBupLyjYC2opNtt7VpZI2pc0LQ6Lbx?=
 =?us-ascii?Q?G+G8FUXvRlSJUtwfUoTq7VmOnIh9c0L2WEp2C7nmLz03S9bFtPjUS7jsEIhX?=
 =?us-ascii?Q?iBkVlrduXb0s4AIZ0mkR+D8zBp/d1Fv3Gzxkg4AWugFGq2eNdgebGz43cE37?=
 =?us-ascii?Q?Oco6EfQrqV9ll/7UEK/CYYxyXgT1z6gOu70eJyPY/NQwkgeedahmLTZdz2/h?=
 =?us-ascii?Q?OaMWBg2eLvMNs5svVsB1KUwqNpbzaPfe77ZJp7zaMqkpj2HQpZhgwLnBo5Pj?=
 =?us-ascii?Q?x1eHEMgxY7qobwrp2C5aVitOuY0DQldc7lAGtWWUehMk3GnU66tftfBrg8zw?=
 =?us-ascii?Q?mRJoEjsf0U3DRhAlsBTDl5lWXZ2cxM4lnOnVve9awUkujhkG/+ej2cku1/Pj?=
 =?us-ascii?Q?CVBsI7ZWrz4XVPajzbNuT8II3aZ3QJtbBNfAYcukZ7jXWTEF1r9j/gyuSPk2?=
 =?us-ascii?Q?/7Y+xcS8S9GrtEEbclD65x33nunnCqKTDvCG9dNx3XRMgWwZryjXFXB5thIt?=
 =?us-ascii?Q?j+894MGJBh6cHQjpqXdSgGoY11H1d7ja9XezIsBVSDT/K0rZGMgAURr3QWEK?=
 =?us-ascii?Q?XpDP3P4Rq5XSIJkdKDS3nfb1T8Znsye5QMTy17xWzXGJNwt4m0y2yXItraoF?=
 =?us-ascii?Q?YXJSpYU2Nd6DQ+OHWomTylfPYD2rzvFX9POiMnmdjsrBiAFm6KIPgmMkhodJ?=
 =?us-ascii?Q?xJKRmk1OU6pOw12FGaapddJojNr7nYLE93YVLk4QE/L3t3AOxEXk3csxStCM?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c38828e0-84cd-4bc6-aacd-08db527185bc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 22:46:13.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cXwxdwQp1L3lD9REPbWWJ+hnd7rbUnvQGL4aBsdL/Mn4CgBG+jPxFk7DLqHUaMkBi1zd5+GLctWnH9wpxMoIETmN0Dl3nWZRtiqQlDyq0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7332
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> phys_to_target_node(phys_addr_t start) returns a NUMA node id for
> a single physical address. In order to discover if there is a NUMA
> node assigned to any, in a range of addressses, there is no solution.
> 
> Repeatedly calling phys_to_target_node() from start/end is too
> expensive to consider. Examining the numa memblks is nicer.
> 
> Introduce numa_find_node(start, end) to return the first NUMA node
> found anywhere in the start/end HPA range.

I don't think this patch stands on its own, it assumes that something
*wants* to scan for nodes by a range. Maybe it becomes clearer in a
follow-on patch, but this feels like it wants squashing.
