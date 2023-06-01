Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28563C77B7A
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jun 2023 17:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjFARZX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jun 2023 13:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjFARZW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Jun 2023 13:25:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F75FB3
        for <linux-cxl@vger.kernel.org>; Thu,  1 Jun 2023 10:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685640319; x=1717176319;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PDPZBpQVXWElXHTI9rPBUOiG/KUbFgitI2skCXsB06M=;
  b=FtwefIFCN9EJufMa++comGC1m0JEyfsnBNo+o0iHLtv1mOv/1QdqjbtC
   OKc0Y0k3iLzrGF3hVdh+QJpAOLk1fGwbtr7PeC9wARNCRcFgDq+UcjtWO
   s+tpfBP+5q+9BH0DAuQuSkIiduGcNyNPkakXefQere6BMi+kdBXFow8DE
   x1+cNqPiIzrt3hMjV9Z8vgwsHLqxL6ZH1CtdZ4hFoM3njaNkus+fCXHRO
   Wz2Myw1b+1CsmsNDCnXZQ48FG43oPtJadrKC2TqOGd8X/vMbYCnlIsbC+
   ke1wKAvgH41CNd/3bDCyyDTaqGL6jyJjfOAQYHNRLpEri14ZQGJY28rKw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="340249260"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="340249260"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 10:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="797240276"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="797240276"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Jun 2023 10:25:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 10:25:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 10:25:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 10:25:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 10:25:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO+uEqSfE91cg7up7aVsBSb7uzKQ2uCme5PtuBcEyZAI34iX3XVMZh62DINZtJiwnFKSDrkL9j+XQ+aCylBZHiOHw537vmvUuUfgn9xt5ITcTlm+Lild+ul0k9CI46thF7OinNdHQ1bbxstUmlY7gxhpzfbmKO4PtAJXmXzKO1XPnTHzpgrMGV/OeZDoZopW/i2IW6FXEsZ+tgxIN2roswdKqvcXFKibKgAdgMtP7yAjMa/VaSQrEtXGy/polntl6dU4NxtDmeFF8AKBf3aKBkEHiBofo/tXd4DoNnqoVyPKg4rGEXEiZxTVad7XLUA8y5VSn5OTJZ+IaodxjoadUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKo+qekEjeOazpmwzr+q/lg5KYxHKh+9XRoCKb0vqik=;
 b=WVFpKNkp0mu1I+V555UEaax8Bpvs7/bSEpgG+OtRbP3/QB2TvGOg6WUnSrAenGZDCbVjIamBvdMkB2n9DaTzR4+/pdqJ+F3AS0CPTeePA9Aw9k0a73mtVrtHxmTJ/JeNgQrjR7piGHbL5hHCFJK5KLHLIiXA6eL7GcRBMidhbMf7zI/gKK8tM0Ev2UjQbTjMYWWeFQMkOHCxxTxx3uPm+t0O4X1D2fOGKyCglUMpeO4W06SPezkD1Q+xj1sz4lAwmk/ng1ee7PqZXgUiXIWsPWRNn7cI5MFMxhaLmAR3vljlB2jbsAkWKX4p+7Ps3LyzaqnKo3dEf/RF95VQizdNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4950.namprd11.prod.outlook.com (2603:10b6:510:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 17:25:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 17:25:16 +0000
Date:   Thu, 1 Jun 2023 10:25:13 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>
Subject: Re: [PATCH] cxl/port: Enable the HDM decoder capability for switch
 ports
Message-ID: <6478d479df118_e067a2946@dwillia2-xfh.jf.intel.com.notmuch>
References: <168437998331.403037.15719879757678389217.stgit@dwillia2-xfh.jf.intel.com>
 <20230601162712.00003bd5@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601162712.00003bd5@Huawei.com>
X-ClientProxiedBy: BYAPR08CA0065.namprd08.prod.outlook.com
 (2603:10b6:a03:117::42) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee696a0-7ed4-4062-6908-08db62c52a1d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yi0jZS1mqIl7BgiXSJH9+Umtal7/ea5e2U+V6x94/Rv+lygtJBsGu6RTB84QE9DPIvci85l0j3q/3Dk0sbFO9t6GXH+d9kBBBCFUtrb+p7lE+5e7WR6nMzpj6LcMb1iPSTDnliWU43Ks8LIx+h4XbfVTWHskyl+GO5WIXbaOZbVNo9JIe0Y6csbOBz5/mxsy6pfi6aJEGDze/6zIWiLaZgiAN0H8nfstmVt+leAELbHbznFzl4Kx4W69q3xiW2/fsooVwRh6xXnyygVBQsSAjGcOuyYQNcaQpVHhHI77CLyIGxIdAp4nGE1JxOktxrCQUUkSx3R4ksr/xH3iYBZWDL7JPfC3/t7BWBCIkXLkGbiQQ6D+2jb8OkKrWQuRlO2XpJIOLhybNBqOu+jdYKyflcG4Nr5HTU+gD2PYtrfE583Flz2M+fDt7G5+Ke4eY5Z9c6csUzo5iyOZXCr1+d2EjfCIc+qHRL6ISr5H+7MeLRDa7hjVXUn4Z2tbyKWP63ZHAs9jk1SW+LX5qKT+74zLpCsbyaUFC5Xtsh/ghin8X9SFth58cuWARK1FSi5TJ1wm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199021)(82960400001)(6486002)(478600001)(6666004)(186003)(9686003)(6506007)(83380400001)(6512007)(38100700002)(86362001)(26005)(107886003)(316002)(41300700001)(66556008)(66946007)(66476007)(4326008)(8676002)(2906002)(8936002)(5660300002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?stDNtnWcsoo8FFXsL7GqfYDj9fsywTlepStU6jZjICg9o//WMVJIO3HwP2wc?=
 =?us-ascii?Q?FHVvLaIosK6M+HvQ/c79IRK6aXYTaLCNzzk7+Lo4Rt26Njmv+mDFOek7qEV3?=
 =?us-ascii?Q?6YhfGlwjRdwuAYXK01L9PXeW8SoAgDGXB6Ar5X/UN0l54rd2j45sfsPk3Dk2?=
 =?us-ascii?Q?kvqfeGsZIV/H7payshtCiDr3ErxMeU1/x+F2HSPmUYdy08T3hv1jYWDvnOs8?=
 =?us-ascii?Q?BBPcopYSXoqGoQtzdPpZmKexETnWMqIVcopIDPL7nCnP8ppjyqbyonRLQxPF?=
 =?us-ascii?Q?ZhnShR9pD+GZ/zs/MY7WAWeTgQieOV2Mo1E+nRhKx0zwgyvIdcDeGgNMiGFt?=
 =?us-ascii?Q?/O48dfWmfESEUNEJbr6M9268CD2a/C4EDocuVVBF8b4RrPOl7NgLZwXPUsDs?=
 =?us-ascii?Q?UG0lkRAUfMTY/SlhmnVDELrJdVvzPf8ot4jH6fJUrAQqZZCJmk9UWYCXwYmt?=
 =?us-ascii?Q?YJAZ3f+j3iQDsqrH20QFr3bh2lD1OX3Tke/mKEkJ+Pl26DKw2eVKBd+s7Ws3?=
 =?us-ascii?Q?Fr7+BpoA9UPcZYd87iBXx/oINtdF2bVi1VfF4inZ64FH9Hki/RygYLVmqi97?=
 =?us-ascii?Q?wrPCkO/+vpwU+mlM0uvVeH/7vwUfaMI4YUQOfpxgWZg9IF9tU0WkbqXIE7Qu?=
 =?us-ascii?Q?KKDUlCg6FuxRkf4KFpAX0R7RcHdl9v6Bg9/BG/9E0olWxkEPQzEHmb77Kvxo?=
 =?us-ascii?Q?jpzlgQmpiMWsPoXxJ+Ohrh2VxGKjGI+RZvcXVIdk+OdTYfL6dCQemcn6ReBG?=
 =?us-ascii?Q?hMEFXOIoh20gNXnfOc4T1dD+NrVFhnE1OWFUWDRqcxeyj2J+jOQhKLQDPX38?=
 =?us-ascii?Q?IkFF1nPM0tAJNM7iEl5xdszZPSBQ+j01uVE2spX3pue6NzYjFhIlnbIm74q8?=
 =?us-ascii?Q?NyxCEyZRzmRhtKmqVYUiBFBZVridLLdhWvV+m56c6WdwZYv0SFMQn98lMYAK?=
 =?us-ascii?Q?R2oalKjzt/ELwUW2Z22+9tnXLv/SZ+V+2b3Cpjs0JxaIAK9Pxc4knA5tW/ys?=
 =?us-ascii?Q?7sf7l7xm7BR/V4GIPKd2f677eU+dQjQwnfpyHRrC47Z+zO2RnNvpu+NNhVo8?=
 =?us-ascii?Q?F+dUiHblh6ECxunFEFPgsyZQ5XKEu6F46EIXDEd+/Bo+GlLjiVdk4+L8iG5u?=
 =?us-ascii?Q?NaqOmn0qFKzzqb8CdzTpj0k7nPDM7OOWGEFYb9IiIrhzNXFJUE6rH4LJtyDM?=
 =?us-ascii?Q?GGs1cvtvqZbhQIdvEviZVTn46AwJZv/K6k1at4NzGv7dnk1Jtt1hQT8RIcfu?=
 =?us-ascii?Q?wq8cdWeVw7/vCsFfEmgP4w1u8ARIfxVzzj2eL3CMinf+GRaZVhDjga+v1Emo?=
 =?us-ascii?Q?X+UOHSx63w6xfcHg/mPyRO4YCg2lB9qhUEsiylzE6JjfG1QOLKz+xQ5c206w?=
 =?us-ascii?Q?hOuTS2PX1umZ+6Dhe1sC7JZka68/Nm7r6Q6R8N3ZjcUH1to2qlp5n2Z3razN?=
 =?us-ascii?Q?5qbqzsRQwiqRXvMLsSmfycK352LOQvD114gnN8GnGM6LgieH/Wc9OO1n9PKC?=
 =?us-ascii?Q?GMS/VZDNaZqt1itqE3j6H0QO1a6UeHGCfRyY/m5EfDAR27KyXTMr5JsHJFIc?=
 =?us-ascii?Q?2fIc3i6MTK900AIR0FEih5UraQBv6U900nCoc66rySBg0hx+BcWufliC1YBv?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee696a0-7ed4-4062-6908-08db62c52a1d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:25:15.9395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+QsxjTd5VMJCF3gQ+YhI85qOjQYkYyr70HTo5J8sq13ckokpr987V0HW0iejoz2Pa0jRkGtqiRE67jlKt3D4hcnPSNpCjXZvdoSnpbWzX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4950
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Wed, 17 May 2023 20:19:43 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Derick noticed, when testing hot plug, that hot-add behaves nominally
> > after a removal. However, if the hot-add is done without a prior
> > removal, CXL.mem accesses fail. It turns out that the original
> > implementation of the port driver and region programming wrongly assumed
> > that platform-firmware always enables the host-bridge HDM decoder
> > capability. Add support turning on switch-level HDM decoders in the case
> > where platform-firmware has not.
> > 
> > The implementation is careful to only arrange for the enable to be
> > undone if the current instance of the driver was the one that did the
> > enable. This is to interoperate with platform-firmware that may expect
> > CXL.mem to remain active after the driver is shutdown. This comes at the
> > cost of potentially not shutting down the enable on kexec flows, but it
> > is mitigated by the fact that the related HDM decoders still need to be
> > enabled on an individual basis.
> > 
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Derick Marks <derick.w.marks@intel.com>
> > Fixes: 54cdbf845cf7 ("cxl/port: Add a driver for 'struct cxl_port' objects")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> I doubt anyone will be surprised to hear that the QEMU emulation wasn't
> checking this bit when doing the topology walk.
> Oops - I'll put together a fix.
> 
> I'm guessing this is already queued or upstream but if not
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

So I took it on faith from the reporter who said "the kernel is failing
to enable the HDM decoder capability in the root port", but now that I
go back and read the specification this bit is only applicable to
*endpoints*. So something else is wrong and this needs to be reverted.
