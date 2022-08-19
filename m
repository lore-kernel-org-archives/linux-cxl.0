Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B46C00140
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Aug 2022 00:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbiHSAhn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 Aug 2022 20:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344581AbiHSAha (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 Aug 2022 20:37:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9BEDF087
        for <linux-cxl@vger.kernel.org>; Thu, 18 Aug 2022 17:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660869447; x=1692405447;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a3/F+5yAKAmeUId0RJ3Ai9wtgnKc9wRvUvhmkFfs78k=;
  b=OAf1KSs6H+dhzhfUt9wryabUG+kiKuNp/4Qcuw2t9ixt66Fo+4FEMTor
   WJtSRvHbwTROQI78hQM3ii8npYgOoZS7QLN8/LuvpYRAJwOiMrd5625cp
   hgndd1qIFo5OD/zm+7VaPor6nOYAocGKzUiRfsbOefP/2K8Bomv4AL6aY
   0SAcrHp4SO3Go4+x5DoQG1YiZZE3uKzsZ9xf2/PkY1MEYvGZebD8fIbey
   T7PmZ5NSXU5CjLRfUFtBP7BvuNOqSbCpafZPKHHE1y0Q38WrgDnhcSaFa
   KkG669OY5f4tCM+98CrlMvAraZI81D7m7AceizbfxX9XeD9PLPJ9GQBG3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="379197315"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="379197315"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 17:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="637057523"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2022 17:37:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 17:37:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 17:37:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 17:37:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 17:37:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmGwT5DaELfvu31BlS8/utfL4V8BuZkNYTI6ziYc+N/RlPM1ooh0tjqRfYparjeeEfQJTNtLYLQVmmczlaXmg/z3yCSnTJ7oJdZHl+NgbN/Ne+ljgIHXBgq4tgegb3+EG5WXcFEmPPa2KIyrBjGrAGBhp+i3b76SMuKjvY15fm8aYowxovxIBx8LEXHI1eJjJhZ9xbuR5EjPhFL6ISsIyjeg/8zOzm1tvqVcda3Lh3gqdW+LSLDbnuNY2g/JIG02JQg27DCDVdp5Jqfl9Yj85V4A6PWNE9nlEv0Zsiw892UVHG/dMi2Rzg8rrBcTz4psVjO8VvD55qsSJaCvF4tlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKcVONe/50UIbupDo5Uj/Oo6Qq3PA/AysIMfLOw0wl8=;
 b=Yi/DwaPcjkJxkX04NU8VRV5qKbPZhTEBiVU72fYrjPBfMj7Za3KU8dFi1GEe1xFoSZSH2Wym1Z7YlBqAb2CbNRyrHpnYBZRK/qkGz18c8vMtP2EvEB26krR1k3X7DSEsX3W11Qpv5J2gafmLrfAhJqOUevuJfKR8RxLTQ6t1HynJFrXp4RIldJwoEytDQwWFV6lN/clWcRSGmpUOnGNhtxa6gHJwfByHXkN537Jbsq3riSdEFXhixLqzB7QeyUoSUtQuJ2GrHOHI5RFYkBwWfwp8o/bZx35cw9+RBKiXas2cNME8XiSsGZ9NpOOQHQXoNhR7fP5/C1VNc400FVoFJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW5PR11MB5785.namprd11.prod.outlook.com
 (2603:10b6:303:197::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Fri, 19 Aug
 2022 00:37:24 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5525.019; Fri, 19 Aug 2022
 00:37:24 +0000
Date:   Thu, 18 Aug 2022 17:37:22 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>, <linuxarm@huawei.com>,
        Bobo WL <lmw.bobo@gmail.com>
Subject: RE: [PATCH] cxl/region: Fix null pointer dereference due to pass
 through decoder commit
Message-ID: <62fedb421d71f_11e5e3294bd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220818164210.2084-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220818164210.2084-1-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::31) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 035f1f50-c471-4978-b179-08da817afc0f
X-MS-TrafficTypeDiagnostic: MW5PR11MB5785:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMwVTf12l3eQlodyc7ILzmo45GoFLMiUfPGjR2P8psc0Ye60r7WoUdq4DcXgOsegpbaZ/z5GSu+4NH95HfF/03dYkGe4wmpg8hy+CN8sXvyvTDY9dwTL/TpwF1A6sN2ZVylsXlZk1YmxbCU97lRIMs/iuztquZkm9K33DSD/lHyaoTrAjrzLr/jLfG728asVdoAKCO+R3Qahl/7NMaauHlkV/3AGR9DRwrr1WViJ/AsHT7e1FifWio+1ZOMEfXbCO8wgD8ZAOD9NoNs3K4WTRGdw5hhr5FgK9fio1QCEQTgzu13RN6MmI7BOXPvebtZjmRMd3gS9ynKDCwDU8IoISq+eTf2LIoDgOPCh7F0dqXFCoBwlCVW5cqQlb4pTMg6i4j66gMoyDnIgIr04KwXKGb++IwdUc0NgQJHYQdwPXdkBRpv+Px/eIxsbnCVChObov07mXQZi5L8/gePcEgSRk5LH9qZNduR/bhb9Ferzxu4Iy6bL1LF0ELnS0Ae+akdY3A60PEP2oY3i5l4ICZIO51HrWoV0bnZ0AurjYVtOp9pmtP0N6NhP60Va8Kmepo0oqG9hF2Y0zaCm5vTP9f41zHTP+h1XL3WD6uKaQrMOZT6CfiwSdo6cR/o36NFPBH5Axt646R76y24LzQtqtVIvmydUDYhAW8Xnqa4zvyK0lCvkgK5WNK+5f09p71wng4eUhN3pwtGVya3w3IMlH1i+Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(39860400002)(136003)(396003)(82960400001)(86362001)(316002)(66476007)(41300700001)(66946007)(6486002)(5660300002)(8676002)(66556008)(478600001)(4326008)(2906002)(9686003)(6512007)(26005)(186003)(6506007)(38100700002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4MKR/8geX5hlGuJWdhN9CBM6cP0pJtE5Krh2clJ7z+C5qOCT20ai4kHESC6h?=
 =?us-ascii?Q?XpqUPL/7BSLj0Iw77HFWBSCi8t7twcPTZEHcvdR4hTXzk3pZJH6P72wqZ7fa?=
 =?us-ascii?Q?FaaudXfmNcyi5WLI1ni6L0V6k1tTNfMacqh356Z+g0CgsIYQm2H89mhICw7O?=
 =?us-ascii?Q?kkCf+b0RsEIipoPULFj2dVeve9aH6vON4GXB9sElofvKYSFouePifWEhPww4?=
 =?us-ascii?Q?9dYlk2ebYfRjqSzeYPbcL48FTAT88VShPXMElE0iecs5pnRxDtBr6wQSpySn?=
 =?us-ascii?Q?GBFuvlOmjnIVZk9OrdY0yzC9FPVhskGiPkK1nf874RQanf07ENNjyRCMdEoG?=
 =?us-ascii?Q?UyaPVETkvW7wijim1DU2mTF3444KrOnUXFHirfWlJhFTcmYS1Cv+bmGXpagL?=
 =?us-ascii?Q?AIDKPk8j/jXXr6nNTZ6akBkTqXwDh2gF9stZ+HV7KOxFBlKRZQFa1djlKvJo?=
 =?us-ascii?Q?Dq5hOzUL3PBBzSwBF+Nj/c3Z2TbBlLvMx51CQdbkTMXFjFxqcnyFAcek5rIi?=
 =?us-ascii?Q?LO6QejqLpiFeLeXLzRobRhwz2uYkWNxeM6Cnuwc1S7/jyv4FmhLV6OOqlsQT?=
 =?us-ascii?Q?d4KFYEZQQqkSi+mKBiZqI8YcI3rScRJuN6mRPva7aNLURQXruwi/i0wF4aWl?=
 =?us-ascii?Q?2Yhi19GkC4Ar749xbwynFwlXiN1sncr0XLqRROJOU1cGlwVbV0RVFd7ZiN6X?=
 =?us-ascii?Q?DacDR4k+UeSdWvqGmxOme4y8Fr83y7bvirnZo2dvcvU3esPx0OOLHlGJqJbW?=
 =?us-ascii?Q?C0/y7my8okPuGaAHnd+XDPx8+q8YDdjv1DQebmxRvMKrwys91QltGVhK8FP8?=
 =?us-ascii?Q?HrrBDn9i8XKHIeXz+ulEAHNMti71UMx7dyqbyT2Im3nwSp+StlifkpQnG7Oo?=
 =?us-ascii?Q?2czEMGMDWHvnXEZgun7dMK2NreHQ4VEDDP6dQ4EaHQpKiRUxUNEMnEKMuD6S?=
 =?us-ascii?Q?XSGLxrAeFxYwjZvLcZDFd/8E59b9yq/J0/OJSdQ53pqfS4b/0Ft0r80GRJRu?=
 =?us-ascii?Q?ph/gxflJRuGCLb82c6NTQWX4HmEJdAGrekyiRnHwZBv6gkCbjRHaihyy/qih?=
 =?us-ascii?Q?hX+ln68ZMtY/B2/5Dc73OPtRlJVqajPteKZehDUziTw1Tp3fn/rFfrrqUsqE?=
 =?us-ascii?Q?p3ySlQWvvUYlamyFTKVVnSZgLAGmmfY1RY8HAthGlsLLCGLlh2YfoAI8qogf?=
 =?us-ascii?Q?b8cBZpinh9z5A8MjBT/1tXQ2cRn1mtZNdFXGdClpNiJ3swsorwKwEx12lBuv?=
 =?us-ascii?Q?KQOstWE3bJa9X9vz27IifcCR1o9/Ua+bj28uZ8YCBoY2Tgoi/ZG9HkD1/FSv?=
 =?us-ascii?Q?+NPzoqtGXUjPbacaWL6nAyYs8QAPbxRSP7kbTpFvSMcdLEbrk9IKM9OQ4Zym?=
 =?us-ascii?Q?xi1TunmnticYIKywxIbScOjiue2cG/888uq5E3WL96l5dAydCd2ovXjV6q94?=
 =?us-ascii?Q?m8H8dOsm9EdWXkUUolQ4OCD+69QpV6Pu3kUU6Zg/1iKxkwNRudsziaAE6wCH?=
 =?us-ascii?Q?uUb8Sz9Mz8xi43Fw05jm7xwDbZ5XVrtgWbLA7Lx0LNwuVvslXKZlER1lNAx0?=
 =?us-ascii?Q?fDFRDvqOuVBnm5MfgugLjqGrww3scYZH540ZSKkooP98aStaJzDWs9Ihcf3h?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 035f1f50-c471-4978-b179-08da817afc0f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 00:37:24.3257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tEcNr0mmy2XT9To7qUcvLKXA75X9cli1rtPQA8BQYxklaTeRl4VB9QzBdp22vBpbAw9N2QQEX+N8ieB8r5BryBVhLY6F/Hod2jaM31nxqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5785
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Not all decoders have a commit callback.
> 
> The CXL specification allows a host bridge with a single root port to
> have no explicit HDM decoders. Currently we assumes there are none.
> As such we create a special pass through decoder instance without
> a commit callback.
> 
> Prior to this patch, the commit callback was called unconditionally.
> Thus a configuration with 1 Host Bridge, 1 Root Port, 1 switch with
> multiple downstream ports below which there are multiple CXL type 3
> devices results in a situation where committing the region causes
> a null pointer dereference.
> 
> Reported-by: Bobo WL <lmw.bobo@gmail.com>
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> 
> We could fix this with a stub function perhaps as an alternative?

How about keep the callback mandatory except for the passthrough switch
case?

Something like this (untested):

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 401148016978..b1137f6dc2d1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -172,11 +172,17 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
                /* commit bottom up */
                for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
                     iter = to_cxl_port(iter->dev.parent)) {
+                       struct cxl_switch_decoder *cxlsd = NULL;
+
                        cxl_rr = cxl_rr_load(iter, cxlr);
                        cxld = cxl_rr->decoder;
-                       rc = cxld->commit(cxld);
-                       if (rc)
-                               break;
+                       if (is_switch_decoder(&cxld->dev))
+                               cxlsd = to_cxl_switch_decoder(&cxld->dev);
+                       if (cxld->commit || cxlsd && cxlsd->nr_targets > 1) {
+                               rc = cxld->commit(cxld);
+                               if (rc)
+                                       break;
+                       }
                }
 
                if (rc) {
