Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF18C00528
	for <linux-cxl@archiver.kernel.org>; Sat,  5 Aug 2023 02:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjHECtX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 22:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHECtV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 22:49:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D804B4EDD
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 19:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691203760; x=1722739760;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=I371uZiO/j9YJQUKQRPcp+UPUkFgwJXj4I2R80lj4Ys=;
  b=bGLu0MvYNlTX91JdkHlDEZz45Gvtx6a1/NLvCa8RG8GiR/OzHuuvhauK
   Y/H2Icy7PfxgKPhwRwq53NDHisRdoO5juA0NEsMqepTTLMP/XD8Jd7jAJ
   6xKL8CqN6XmeNE4qwNmQMWuR3VSkztGn2+9yhqT8UXrE6mdrVEMdWXdXA
   +UhOfYkqqyXkEI84GQGHqVhsA9Wu/5GTt9+XGFSlKSjiilzYM2Bv2oGeo
   jMFss6KbeaU0ewcc3tR2xD6c72PcJVh8yq9XEkShGG0jENpBnDFB6eazD
   vwFqHnAdZxK5qyb8gp6oP/QixyuRy6rnERtRf4aPI3iCgiS4NWJ5rDvvQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="355213634"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="355213634"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 19:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="707228186"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="707228186"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2023 19:49:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 19:49:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 19:49:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 19:49:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 19:49:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXZKXHwcvuWQZ1gQj2qqOzNhgYsNk921ISlL84o+xuPwQiQa1RJvKStJhKo+sOud0FYeuZgFF9ZrF1NtsL9MGKfPkHYUtcETAIfgHO1uZ5Ki42W7R4FFaAs5CRxCOj9GNdAXZK/758MpDXgU/PYuPVZHzi78UD3gvd3n27a0olDFu2RI5f9c3PvDmSeRCE1NYiFw91U4Iyy7pdvzquW1h3ht6GkO6GGB+6TFo8iwPcWgRRwZ/Y1MEHsgAgvHrnTyrpoGRoI57t8n1OAUeLrfEt1TF/Odu5QwL20OGZUtd2vFXyDGyeZy0NfJx+wYbZXrwMqP7THs3ETgmetbrBl4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5SBMlcP5fOBu9vMs6E5/nSXAB21U/LGJG7RXgIxrb8=;
 b=lO9zMKYSDrX6E/yYBU9g4mUDth9T/Yt9mkh/OdDsUw2IAKP94sjSl6+vlYF8S8BjsF1RhOltuDZBQTH7BxwTaRLzu0Y/FPhF85xmkU1MCy1H/Vt/tYwqtZcbMJjFdY7QUeL/yf4J91X3eSeFejbvcN5Cbt7jNQgwOjp5ee85Rv1AmkgsSVefZaNxnvjG+TLWbIg1OkyAW6ayxhzSCbX4unMYSgI2di1VqEwSuL2lxGAU3LdBbwdOzY4N9DmIwpeK51A+nrlWi3Hu9IG7L/G78kHUFPZYY6VtMvtFNUKiX55dZetqIhu4lCmiDYAwQ6ViRTgixA2FgPf8+UP0j5OPWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Sat, 5 Aug
 2023 02:49:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.046; Sat, 5 Aug 2023
 02:49:17 +0000
Date:   Fri, 4 Aug 2023 19:49:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] cxl/region: Refactor granularity select in
 cxl_port_setup_targets()
Message-ID: <64cdb8aa91847_2138e294bb@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230804232726.1672782-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230804232726.1672782-1-alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:303:b7::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: d2678c36-9e10-4904-074d-08db955e8fb3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BtBS8Tsn3rRTiBCX1qFVlK4UmJQUyMSJT8ecK3DCuB+5iFidmKajykLyUO14EIpwZS3c3JNGLBO7slVmh7jczCtiiYuOF8iE3xldeTfnxcGdX2JyTGXOwvx7Co8+DrwoVzBl8uwyK4UWLD1kTDJf4i0EnlMaD92uz1Dy+AUhcG71+n9BQ5Zw/nhfBYBcx2VGJ4cyuMwI9OZHuQHjpZQeW8NpDmHFsamtyhH3NXtzxN/HaDiClUfq6aOME2BhprcH430s84AogH2zBUf1VQVL1eSn9+TLto9a9M+7fg1GXYPjtD270h/YEqSvEQO6ijT4ybmTqSJE3WpZ0c+dgGQafKQIvKtzdqUoC3A+jIeIh5He10wfC01O9hpMe3H/UD9Ol9kg9qGyo/2FkrgnTFd6D/1kIKlbHhJsNPO2KpPZ83WTvL38a7JVQxH/A2ZE6bQrrNpPnWVTwhS28VloLk05FFtwaGZB8YHm1hAB8E07PmuQ5UGEOwakDtTg6jkI4VNvDn+08qhJxLJA696YLqppxjsvn4vDGDaTaQogCtCK62NW7Nt0cUfqAx0yjAAFoNwQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(1800799003)(186006)(6512007)(9686003)(4326008)(316002)(86362001)(478600001)(38100700002)(6666004)(66946007)(66556008)(6486002)(66476007)(82960400001)(110136005)(6506007)(41300700001)(26005)(8676002)(8936002)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V40DslkaGf/949xi0eya3X85nRGwf2v/vqRG4U+ptyW/1FnEaspoyadz2p/3?=
 =?us-ascii?Q?IzzBk8o5f5q3zdPEw5/FRmSDJ0xLnCAggPR1UKI7BoM5IMxiqktCadokySvO?=
 =?us-ascii?Q?o/Np0tvbzhB+gRRxUTFu0xiMtuVGEwcTmwVOlyNOIiJ19qQWXRS/uJO2+mKm?=
 =?us-ascii?Q?06ngyYQLdUu6IGa4cBzPaY+QzK+GNLdqfPFuUsjQT0+MNgRrFWGZeF5WJOOk?=
 =?us-ascii?Q?OUr2JNcn2ylTzHjV4jocE3fDCS75I5AvCD/v4oyzmyKRNVRMQLz+pTv9mVmJ?=
 =?us-ascii?Q?SV85Pt8LS24uqI5iINjV/LmdNOhGJveKPPiQk8nxXwYvPsPkow51c7J90miT?=
 =?us-ascii?Q?+0+6bTCalYEiiLPD2VlOSjv8D8vbQ4nuQc7Mn1S2ezoZUZAIi6opr3R1NQ1V?=
 =?us-ascii?Q?Ov0AZ5H+vzkI/+UONdlJXn2dxlFc/NEzuj9LHPj7RI/OTxoOoMcmQSjPWUJu?=
 =?us-ascii?Q?Ene12kq5hSutPbCvUgouNj9LhCWdniEFd1RLEB2inpYem8DnNEXvO2V3/Eu2?=
 =?us-ascii?Q?eFRcQEzyWK4N6OxXBydQkbqCQqtTSDFIbz0Xyp2MYwuPiF9RgkUIV++Z62sg?=
 =?us-ascii?Q?Ml4Ut4fs05mVhJHQwEgo5ntOPpaeJHDS5gcn4ThHlNWavL/6YBhx4aeE1/Aj?=
 =?us-ascii?Q?RvArb68ZGs7imdGZt1FTiurhujfji2YApYKK34sQEX3ZcT95yoireb2uSELr?=
 =?us-ascii?Q?sFa20NCJ7K/bOLIVdEebqhS2y7pOzahJpq8k2yIevPA9quY39PoeE1bdWMNA?=
 =?us-ascii?Q?yam+k/ZsPM6buuPSP0I0AN/GXWBMMmWwrq53o8+Ggo4Y/pJk8tJ/C/83FeI8?=
 =?us-ascii?Q?vRSj2aVc+oLRTAc/A0CZ1EXvllWnKa+APmF4LggwQ3cf1J+8neaO2mlFTdPM?=
 =?us-ascii?Q?oJIKoptkDKTFUO6Lzuk9KEUfx+Esh2+iKY46QOiJR3J5Cup5w4ebQg8cGdJR?=
 =?us-ascii?Q?epqxUIMlJpS2i8GUyB+KkihtepPVuVoD9aklLobiAIPIMAa/RezLFJHIi3FH?=
 =?us-ascii?Q?1uqSiXET8aFNLPhRXkDfBNvxKdqW2kD+I9oVh4I9Uj2ZdD/qsxYERUNYBDbL?=
 =?us-ascii?Q?vLD7OAF8MUtfGZh7YXScPmEpeNZRllUp8X4I37/LrFOr8rGvrNy0TmBPGUlb?=
 =?us-ascii?Q?sV08aC/oduf5Pl/TMX3aUwECdBWZQqkVO4VwQWB3PSVhIBGNzErndomrkyMg?=
 =?us-ascii?Q?yXnOu6EkcUf/8EqL2x/hzDBLG6i+qtkvM+7rTAqEbVUzCoa7sb3s0Y4olTGB?=
 =?us-ascii?Q?k9mYdYPG6EqilYTXO4yWKzCL+1v5OlrRQyk4ig8l88r/WK34QA+yf0iJkjLm?=
 =?us-ascii?Q?98MI2Kh+yZWmFsWIdqYC6uVtClZjIbeKcGsS/o7z987BT/ntxIq8vHrbMxh4?=
 =?us-ascii?Q?JaTO84Q7K9wcrMkdc6qYoXgLPPkv0Dz8L9P0FozuaJykC6vlAWQ8D4AP4tet?=
 =?us-ascii?Q?LD6S6ApB7ueyDr4MWl9WiqwAkSIDC8/VEfiqHrJxjC+ipOCj1gtgpuQ2ohy3?=
 =?us-ascii?Q?wEMHQ45Xn8BcbTpMFQz+B+rPvIakaVD5wNCDCdu3JAYYX1i9hHSoCleNZS+Z?=
 =?us-ascii?Q?TAAz0iCZTegVwuzZPhLTt01v9XtsGrMJ1QXU3LxxqM2Hlae77WpfmElBoBXM?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2678c36-9e10-4904-074d-08db955e8fb3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2023 02:49:17.5059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7lqrQ9CIY1ze//Qei5V9C4iPQYFUwBcQEXvPR6k7cz1Ms5WfbnF9Zbs41RvhuFPrFiabdXK+BCr6fpwGyO+LUlpyNOPKMuOKDOQLSTgMXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> In cxl_port_setup_targets() the region driver validates the
> configuration of auto-discovered region decoders, as well
> as decoders the driver is preparing to program.
> 
> The existing calculations use the encrypted interleave granularity

s/encrypted/encoded/

> value, the eig, to create an interleave granularity that properly
> fans out when routing an x1 interleave to a greater than x1 interleave.
> 
> That all worked well, until this config came along:
> Host Bridge: 2 way at 256 granularity
>     Switch Decoder_A:	1 way at 512
>         Endpoint_X:	2 way at 512
>     Switch Decoder_B:	1 way at 512
>         Endpoint_Y:	2 way at 512
> 
> When the Host Bridge interleave is greater that 1, and the root

s/that/than/

> decoder interleave is exactly 1, the region driver needs to
> consider the number of targets in the region when calculating
> the expected granularity.
> 
> While examining the existing logic, and trying to cover the case
> above, a couple of simplifications appeared, hence this proposed
> refactoring.
> 
> The first simplicfication is to apply the logic to the unencrypted

s/unencrypted/nominal/

> values and use the existing helper function granularity_to_eig() to
> translate the desired granularity to the encrypted form. This means
> the comment and code regarding setting address bits is discarded.
> Although that logic was not wrong, it adds a level of complexity that
> is not required in the granularity selection. The eig and eiw are
> indeed part of the routing instructions programmed into the decoders.
> Up-level the discussion to plain ways and granularity for clearer
> analysis.
> 
> The second simplification reduces the logic to a single granularity
> calculation that works for all cases. The new calculation doesn't
> care if parent_iw => 1,  because parent_iw is used as a multiplier.
> 
> The refactor cleans up a useless assignment of eiw, made after the iw
> is already calculated.
> 
> Regression testing included an examination of all of the ways and
> granularity selections made during a run of the cxl_test unit tests.
> There were no differences in selections before and after this patch.

Fixes: ("27b3f8d13830 cxl/region: Program target lists")

> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Fix *and* less code!? Yes, please!

> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..5a1cc59cca99 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1154,16 +1154,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	}
>  
>  	/*
> -	 * If @parent_port is masking address bits, pick the next unused address
> -	 * bit to route @port's targets.
> +	 * Interleave granularity is a multiple of @parent_port granularity.
> +	 * Multiplier is the parent port interleave ways.
>  	 */
> -	if (parent_iw > 1 && cxl_rr->nr_targets > 1) {
> -		u32 address_bit = max(peig + peiw, eiw + peig);
> -
> -		eig = address_bit - eiw + 1;
> -	} else {
> -		eiw = peiw;
> -		eig = peig;
> +	rc = granularity_to_eig(parent_ig * parent_iw, &eig);

I was going to say "wait, does this work with x3 parent_iw", and I
believe it does because this:

                /*
                 * For purposes of address bit routing, use power-of-2 math for
                 * switch ports.
                 */
                if (!is_power_of_2(parent_iw))
                        parent_iw /= 3;

...is handled in the is_cxl_root(parent_port) case.

A thing of beauty this patch. Ship it! (modulo those minor nits above).
