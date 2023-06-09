Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB27C7EE2E
	for <linux-cxl@archiver.kernel.org>; Fri,  9 Jun 2023 21:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjFIVHL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 9 Jun 2023 17:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFIVHK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 9 Jun 2023 17:07:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6619B1FDC
        for <linux-cxl@vger.kernel.org>; Fri,  9 Jun 2023 14:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686344829; x=1717880829;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NLoJ/OxNviJlL5lq8UNbLuQnXWATxLli8g63wko0Sek=;
  b=JTv58xh5qBXofCeKnHsjPt1wPpfD+IaK+St95xLtpIGzKcUB1YvAdCtZ
   yMxNITR89HcY/uy4sdhCA30Numbfdpo9orIG+xS8GBbTLomjQmSyQ+8De
   QQ8dXwZpeh+dsCk3DzZMGB4LC+JOTGPwecJlp4lijPcd36wDdEUxP4xC8
   47JizsMVjgIwoa3bBdBGXdeBKcYrCyyRcrEvgvbILPcPm+raXZhx++WZl
   Ejn9A8kqjEEfNsDunM73rng7n/A7fscX/wvvjuC9ZwyBHdImJh+k80ay4
   teIYjEGoiW3/v+WBIzEJaIRR+x+OyuXM+hQmKFC6i5q72QDWQBu2wctCw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="347334925"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="347334925"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 14:07:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="704681096"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="704681096"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 09 Jun 2023 14:07:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 14:07:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 14:07:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 14:07:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 14:07:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GazuwbwlemBcPr8x1oCqZ1mPOAburDMhGOuBU1Nb1zpTH2YVfbhtO0baOwgoo2lbAFTUY1NYYz3xzm/dcsQ7PuL8Oe5jcKhYrQQ10rKs5DP1eJ/oxsJnWYbouXnm+6VgHmzncAhvcvW2LCpmNC0UAOi68sny+NSGY2mkOy9Vf5bu/Z/q5SRSNzgZjdnQkhRCuS/r5oKKZK5XgNTYek7+IwD9YLWkc7bSWQDYVgTDauHp/q1gpMzk+L2WaUMDPb/++8uXFOcNC0G9F25BPTEfhbswouXau6CGJiL7oIcYJfvxgm6cg6xkXea2GKUo24qfJXxsokcPss/C9FzTgkcU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUlQrdIvJVLyn+fgOQahxLv72A+dOaCVnTda47phocE=;
 b=QggqiHTNxtZiJyzdvcxRBe1rJbasCbwgmCpBWf2gp3oA/IlVmvg+YI1oCs99mn6vZg6EU616eF6ozPLiaFSpitWUmuotQL+RWZ5f63T00hsn8JTJmEhhiw3mjcSgzTyjSgIiUPtjLHlbsmd4dN5szqePLfFDeq4gT6t8W/SPD0kocLj4TvbOpFY8zywg8rRduAjzU888AYoNUdll9QGk8hAmZ8OjrtsfQWwwqfmdBJ9mqASUH6J2CrDlNz+7fu7lRk8Faga4rm7q6XWqV0KwwjvL11S5/nRJbTu2tY4BgvDIvsnlLyZSOSBCt9yE9WSB9DB4QOhIEZDA4+vMa1b8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Fri, 9 Jun
 2023 21:06:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%6]) with mapi id 15.20.6455.037; Fri, 9 Jun 2023
 21:07:03 +0000
Date:   Fri, 9 Jun 2023 14:06:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "nifan@outlook.com" <nifan@outlook.com>,
        Ira Weiny <ira.weiny@intel.com>, <sheshas@marvell.com>
CC:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Message-ID: <6483946e8152f_f1132294a2@iweiny-mobl.notmuch>
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
 <20230511175609.2091136-1-fan.ni@samsung.com>
 <647e1cf4e7e5e_7471a2948f@iweiny-mobl.notmuch>
 <20230605175112.GA2290821@bgt-140510-bm03>
 <DM6PR18MB2844A78EB692A69CE10031E2AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
 <6481f70fca5c2_c82be29440@iweiny-mobl.notmuch>
 <SG2PR06MB3397ED98E693C77C97345792B250A@SG2PR06MB3397.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SG2PR06MB3397ED98E693C77C97345792B250A@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-ClientProxiedBy: BY3PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::11) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW5PR11MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 1408cd4e-d484-462e-b706-08db692d78b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9WvSW5/k+5lySrRUuuRMaRJxXx1Dn8vvbAnrBIwgTWbByjlRVVB48G8PjFG7c1WoXyLpVEgE3MBA+Of/Rqs6U/iWzfcPmh4NtY1Rjh/c02cDV70OaE1zbQCYxltwNwi+RvZdM3C4MJsQZS3C8FqARqNjwXll/3SaOlM2etBIHX2gYDI8KWprhUwEDiljU4Lkjuagh8tkxQgINrHYqWUCf0ocmnYufWJGr4Mo2JzOus8BHiXYugIxdVEMRE4xNIgN0Z3dd1pQI5ji/qDOAR39iWW+5CDcqKwzaFSmtkI7biR1UY6M29EpEsC2s34PiOS9tV0rlxNt/wvGtIPZZoQMqx3nkc9cBHKyesQnFHMlvpkXtbuuW/6zpTT4JBJt4OzkszeamI0avYxT+fwk29YG9f6tLEIL3imQcZVKsDednLUdlcEqgmtHTAJgXOjGNlbIvlZaX1DzkG3QEDN5CCa9tvHeKopnd2iSeqH6iukKjCdemW9w2T+h68j8g24FaNkh07aUBVRxIrd9Zp95Dxw7apo1y3tdE7GbGSmnP4ZfbaXtjekJRzHIxSWy2/cvUj07Wu2IoYAZQNKp9IaKmYF/mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(478600001)(316002)(41300700001)(2906002)(110136005)(45080400002)(54906003)(44832011)(7416002)(5660300002)(6486002)(8936002)(66946007)(66556008)(4326008)(8676002)(66476007)(6666004)(26005)(38100700002)(6512007)(6506007)(966005)(9686003)(82960400001)(186003)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UPY2Fx+k01G4u8TS4PHG1h5mZjZt66it8DyBsxQmeuDOEr0LiDkvUkSVXeZa?=
 =?us-ascii?Q?bj07lhUVcSz7G6GdusY0uTJawrRFrvmwRnhxogl5zJmGNmd7BIDI6P7kNwNC?=
 =?us-ascii?Q?88OmKxA00HBfMRNzAoIJ8kooaCr0Be8+1xvahmLb2AtUkTUpOCtC7Et+qkDf?=
 =?us-ascii?Q?EuXO+YeHkO1xOdYyvfSOD5SlwRd7qL6zurFjvMQVtxWdr8WF8I3JLrhW1BlB?=
 =?us-ascii?Q?LixkV+juwAjzhp9kNYbA+KS/EWTX8QlbOJ8/P5QkAXviGXVJrKFQP1wSHjqv?=
 =?us-ascii?Q?L9nLCKQI93BtVrV6YJ6KdgXNy/mrPoYDKrEhPGUtP01ox8QtgvmwbGz8SEsD?=
 =?us-ascii?Q?cTeTiZp2jKeg1tY7+ONSDggZ529368YETqeRKdqfUmVPcQM6BlD4FDYkq+ON?=
 =?us-ascii?Q?NEL90U6lSbypivKWdkV3n4rJ7cgaMq9LOdCsoMptolcwdmZHXiBhbegnj1e5?=
 =?us-ascii?Q?Kc8ytJWrC62w1vw8XGNzFE9B+CNMvaybHc3RKLZg58TSX098Zvs7kfcn5HWW?=
 =?us-ascii?Q?BxsnIhIk0JvHCjY+2rJxyWgbfgKkwcKm8yyTJQ0Ytba7j2e9tOicnnXiPNzo?=
 =?us-ascii?Q?KChbBpqDq0MsHY5nF0WmJxuEhWEFO1VfMqppJRzc4aAKnORvNCqg1FsP0RV6?=
 =?us-ascii?Q?RrowdNoyQeIbSn6VhMPaVDDEsaFfCZlCB4SfvlZiwdJM0uLT0q37CDEIzy2f?=
 =?us-ascii?Q?ZTJDovP6Q6/9ToyUnCfdtN63ZO/M1q3WJZ3Yz+EtbYRRg75YDaBzeYGGgonS?=
 =?us-ascii?Q?lkoJ0sg0e21N7t/nEqLGM6BDE/TwvtOQNOiVPaBy2QBeptz7v8yq+6g3Hqrw?=
 =?us-ascii?Q?q6lDWKLoNWYwnb7CI1quQY80R8T6DYl0Bo0SfY8GcewQCnH4BGNZw3HePefQ?=
 =?us-ascii?Q?Qt32LqFAL6WZTTvswjQmTuaoLiIQ9YDXxwcHUsq69rnda2+t+BdK8erTU1DD?=
 =?us-ascii?Q?DiBQl1dFBRusLK2wM5m+yGmmskLingKJXheRFI+Cm74hWI2sCbGn2D1gKfuB?=
 =?us-ascii?Q?2tijji+tZarM5yEakVc80MMrOo32qIDz0yx0utv9ReRk0/G8Cj7pXcsZtqCB?=
 =?us-ascii?Q?5JF7f3kDYwkAxM1Sy1F3RBcljex20F8mVYhKDe9HzJsQfHXd6MGy8QHC81Un?=
 =?us-ascii?Q?7dsW0jAwsK+UBsF4CB7tllu8beb7Zy/TxEYPAV2Riu7D/FBMaLidMTuv9nHp?=
 =?us-ascii?Q?zFng6OzvBUNxysEXydBGPbUKjOq157B+nwr1P0G+W0kV9y5m/CH0ITOC07x6?=
 =?us-ascii?Q?He1dXyaJVSztju0iYhz2/AA9PAfVKIVF7vVUa5qscAn1Yb0r97vmOO4i4lWg?=
 =?us-ascii?Q?dxRfYaUhXQIhO7yEDUtXH/tx1irJUOZAIJmQQ9eDduGhxnd/6Y++q2ytkaIL?=
 =?us-ascii?Q?/YbCcQ67Mmm/Ajtn71MunLhvniEwn+tbnMrYd1NKdJS/6ZrWkTUn0nQnJchj?=
 =?us-ascii?Q?Duo+NP+K8lB7EbO9mnWTDcVtHxTqbgGYPDujZJcsPlCVQBUHASX4ZbZxtcRY?=
 =?us-ascii?Q?UZ7uI5g35qy0gSE7Li7Js/8jU15zHQfimtX04lbPvofGWuihYZGGg/JL98Fh?=
 =?us-ascii?Q?/VURZ/vcc74zbCzICMLANc784ncC8r8B4IEGsjmL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1408cd4e-d484-462e-b706-08db692d78b7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 21:07:02.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOPdw3QRDlrso7aV0Fa2o0p7sgVVcVZux0630u36QV3qeZZ+Ly7JNcYOBmK0BS2V67IFE3RE9GJtASpJZXjB5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5810
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

nifan@outlook.com wrote:
> The 06/08/2023 08:43, Ira Weiny wrote:
> > Shesha Bhushan Sreenivasamurthy wrote:

[snip]

> 
> Hi Ira & Shesha,
> FYI. I reabased my patch series on top of the above branch and created a new
> branch here:
> 
> https://github.com/moking/qemu-dcd-preview-latest/tree/dcd-preview

Thanks!

> 
> It passes the same tests as shown here:
> https://lore.kernel.org/linux-cxl/6481f70fca5c2_c82be29440@iweiny-mobl.notmuch/T/#m76f6e85ce3d7292b1982960eb22086ee03922166

I've not gotten very far with this testing.  But I did find that regular
type 3 devices don't work with this change.  I used the patch below to get
this working.  Was there something I was missing to configure a non-DCD
device?

I don't particularly like adding another bool to this call stack.  Seems
like this calls for a flags field but I want to move on to DCD work so I
hacked this in.

Ira

commit ed27935044dcbd2c6ba71f8411b218621f3f4167
Author: Ira Weiny <ira.weiny@intel.com>
Date:   Fri Jun 9 13:56:33 2023 -0700

    hw/mem/cxl_type3: Exclude DCD from CEL when type3 is not DCD
    
    Per CXL 3.0 9.13.3 Dynamic Capacity Device (DCD) when the type 3 memory
    device does not have DCD support the CEL should not include DCD
    configuration commands.
    
    If the number of DC regions supported is 0 skip the DCD commands in the
    CEL.
    
    Applies on top of Fan Ni's work here:
    https://github.com/moking/qemu-dcd-preview-latest/tree/dcd-preview
    
    Not-yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index a4a2c6a80004..262e35935563 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -288,7 +288,7 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 
 static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
 
-void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
+void cxl_device_register_init_common(CXLDeviceState *cxl_dstate, bool is_dcd)
 {
     uint64_t *cap_hdrs = cxl_dstate->caps_reg_state64;
     const int cap_count = 3;
@@ -307,7 +307,7 @@ void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
     memdev_reg_init_common(cxl_dstate);
 
-    cxl_initialize_mailbox(cxl_dstate, false);
+    cxl_initialize_mailbox(cxl_dstate, false, is_dcd);
 }
 
 void cxl_device_register_init_swcci(CXLDeviceState *cxl_dstate)
@@ -329,7 +329,7 @@ void cxl_device_register_init_swcci(CXLDeviceState *cxl_dstate)
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
     memdev_reg_init_common(cxl_dstate);
 
-    cxl_initialize_mailbox(cxl_dstate, true);
+    cxl_initialize_mailbox(cxl_dstate, true, false);
 }
 
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxl_dstate)
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 93b26e717c94..80e9cb9a8f04 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1526,7 +1526,8 @@ static void bg_timercb(void *opaque)
     }
 }
 
-void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
+void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci,
+                            bool is_dcd)
 {
     if (!switch_cci) {
         cxl_dstate->cxl_cmd_set = cxl_cmd_set;
@@ -1534,6 +1535,9 @@ void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
         cxl_dstate->cxl_cmd_set = cxl_cmd_set_sw;
     }
     for (int set = 0; set < 256; set++) {
+        if (!is_dcd && set == DCD_CONFIG) {
+            continue;
+        }
         for (int cmd = 0; cmd < 256; cmd++) {
             if (cxl_dstate->cxl_cmd_set[set][cmd].handler) {
                 struct cxl_cmd *c = &cxl_dstate->cxl_cmd_set[set][cmd];
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 329e8b5915b3..e6e6e125990c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1276,9 +1276,11 @@ static void ct3d_reset(DeviceState *dev)
     CXLType3Dev *ct3d = CXL_TYPE3(dev);
     uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
     uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
+    bool is_dcd;
 
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
-    cxl_device_register_init_common(&ct3d->cxl_dstate);
+    is_dcd = (ct3d->dc.num_regions != 0);
+    cxl_device_register_init_common(&ct3d->cxl_dstate, is_dcd);
 }
 
 static Property ct3_props[] = {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1ccddcca7d0d..4621bba4f533 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -233,7 +233,7 @@ typedef struct cxl_device_state {
 void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev);
 
 /* Set up default values for the register block */
-void cxl_device_register_init_common(CXLDeviceState *dev);
+void cxl_device_register_init_common(CXLDeviceState *dev, bool is_dcd);
 void cxl_device_register_init_swcci(CXLDeviceState *dev);
 
 /*
@@ -280,7 +280,7 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
                                       CXL_DEVICE_CAP_HDR1_OFFSET +
                                           CXL_DEVICE_CAP_REG_SIZE * 2)
 
-void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci);
+void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci, bool is_dcd);
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
 
 #define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
