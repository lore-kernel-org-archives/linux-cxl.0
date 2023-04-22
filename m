Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A2BC77B78
	for <linux-cxl@archiver.kernel.org>; Sat, 22 Apr 2023 23:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDVXW0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Apr 2023 19:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDVXWZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Apr 2023 19:22:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365391713
        for <linux-cxl@vger.kernel.org>; Sat, 22 Apr 2023 16:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682205744; x=1713741744;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W5+1vf0AiJp/mjptfiNkV4omHs3c7sQsCvefZSaLv0g=;
  b=RTr/svquA30J6XihuX7TTQtaUPiqgwkzcS6WeC290L5lcC8WisHFiTSI
   98oZhqlilDc8Zes+nfkskf2MBiX4ViGEBlBJb/qAEU4y44fEhsZjLeAch
   IXcROMRIoA2MKZ6uqQG5oERSIGDesL0H65s1FHNaHX32IxNzGfeprlMD2
   34yT95KqOHPHYzugZLst0KBh87hC013OLmdKrdEZg+A+5EVaRMCEluj+e
   gxyj8SVsRgqq7HmQA8HeBk6gYYsYu76kwSLaXgwBoo0LzzovTTXdiO3FV
   4Stpfy0exAlLuBvXwM+JPtHmudAh0dLAV2QVySjSlBKt/vWJ2wRHjJEUS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="335096696"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="335096696"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 16:22:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="723129008"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="723129008"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2023 16:22:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 22 Apr 2023 16:22:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 22 Apr 2023 16:22:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 22 Apr 2023 16:22:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 22 Apr 2023 16:22:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQKfZ+0X3k8IZZdWhJL7FayllbpS90eACfEegPXL4BvCOsNpOxBWEsr5uSjdi0RO+bd0UmXZloa6KhTD3bUlhlRMxKeGDU8hTiagE7Ab94AUTrCXJm5RtsSi8fraW285c5voIJU8FORti27OI6VfTYSehaQj03Q87wZOwpm5cyj7+puq3+dhnnbrT1q8VLBdId018FR1BxVLk6uHgjVuJr/LqqQlmOqXjBQK0YIvsN74hU643Aqlhb5X3ZuDUwbhRh3NpECpDx0MkZ2biR1IqBkHL3c15eiyOv8dJeDb0jr0/z9WzypVvOzE0oItUdfswF4maHf6jgBqDc4aqu/htA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnTffYre67DndgZOyzAV4/1zYqE5luXEzMMwnKJL8p8=;
 b=CrZXA+jbYUuuZ1UcgVrOwQbjGgR7VWqYv4p8yJkMStU+W6S7CEEciI5f+t5fUFeSVZbfA+rbpUKEupTXldLwcF6Kdrp5byD3ADBdsfOuCrWdqWKbbyiCB78+icdRud+GUcs8IiVzSGYxt8US9AMrXMfzmniHr+dYEw11d/M5PimTjGm/5z0ZrXfvmH0P8u6VpX5NR4eQRVBkmiVm0VkQ5Bk5m4Z6LtzUhInwOq206kD4KxDISLePcfYrS5FfaSCMWohnci7cY1v1guOJ5OAc9Em0R6RzbZg9y7lRC5o43WF63iU3mhYMQ4ljei05TQbR2Dwz1/4dSZNS0NDqZ1RdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7418.namprd11.prod.outlook.com (2603:10b6:806:344::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 23:22:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%3]) with mapi id 15.20.6319.032; Sat, 22 Apr 2023
 23:22:20 +0000
Date:   Sat, 22 Apr 2023 16:22:18 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Lukas Wunner <lukas@wunner.de>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/port: Fix port to pci device assumptions in
 read_cdat_data()
Message-ID: <64446c2a54c53_1b6629433@dwillia2-xfh.jf.intel.com.notmuch>
References: <becaf70e8faf9681d474200117d62d7eaac46cca.1678543498.git.lukas@wunner.de>
 <168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com>
 <20230422083502.GA31480@wunner.de>
 <20230422140534.GA8951@wunner.de>
 <644449689728c_1b66294e1@dwillia2-xfh.jf.intel.com.notmuch>
 <20230422223005.GA12308@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230422223005.GA12308@wunner.de>
X-ClientProxiedBy: BYAPR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::36) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: b76d95d5-3258-4194-0e59-08db43886b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SGl7+uRKC0iZ+kkQFprI7zp3iddCfHF2upgb90f1dtVHmKDpRkUQ7GQb7LZ2owqBYVNLZltp2pWrZabppRfvdlH631yDhmU4VTpO6hN9blvBf25UPjpYJ8SeLN1QEavnuObuEpjRF+Nq+mP8qGgnH+mR/wBvjJo+6KsflE+fuR0B2X+/OoYZs9ySwJCyXqyoD/qS/Gk/kFQzpKD8zgkTIfNBt6WMkD57nBh0QhaVNcsQ7Qd8uKlxIkMgAROzKk1rEZq/wg4OGMI8ws+nT6k2yFgKXRLDLGqpIxkVcBvOtc5zxCHyiSEBASBJb4zjwG/rWMzhp2EysT1fDpDN6l975LMArAsv7VUyOl6ClpowxvuzApcNJh+xs4FfjfYFZ1r3tAQHwmu/JjpECrhITfHKTlqtVqTSCeAxm8atFkovrv5x0q6F29ak1gAk+Galf3TOEobGCLxiZvzQuCqWCm6EdGOiCO+Mf6hybX4DLzWha/BvR5SR5VlXgYH7oG2dc9k2fnIsJlKNUgpgHCJW8b8908pAal8UWR88CWXp8bmovf65Ul5Rox81IvMStmCExcsP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(107886003)(6506007)(6512007)(9686003)(26005)(186003)(316002)(66476007)(66946007)(66556008)(4326008)(478600001)(5660300002)(8936002)(41300700001)(8676002)(110136005)(6486002)(82960400001)(38100700002)(2906002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/+XWgoXJI3uCaUdkF/i3xkbSgk9wKnpSzmN39SAbMj8ff4ByTo5zP/0tEErr?=
 =?us-ascii?Q?UvMPfDsicnL73bd4f8PsN//P2aL2PhcJwDIYgwbwAOUx/74LLbLbzpYnCBku?=
 =?us-ascii?Q?vHWh7rfX6C1D5XZslQpG76igdBHvrYR7dUzjqODtjvQm4GchF9e1d6ZeoOLz?=
 =?us-ascii?Q?66RGm61bOz9OePxdJAfkSAf9shlWjFxK3BFi12sBn8EUg178c/p0caYqKH13?=
 =?us-ascii?Q?8rJGBf04bCPCW6sMpUhxNAtS47arkNmtu96wxPWGJ+QXeBWMz2ewTDqekx4H?=
 =?us-ascii?Q?vEic3dha9FdYQxCrFB+yMIWsMQ6elJYRSdCAdmJzyWp5fdxAsRQcrMP3WpTV?=
 =?us-ascii?Q?CmhgmoxrVX4qCLVLBUKb+yt93ZirnJ4N75lfQVnVWU1aQYeJV/90lEDf83j8?=
 =?us-ascii?Q?DabU5dEVelgp9QXDiCa53vjJiJR9jhshg0iosyUW1frXU7Wl053+Yt0hi5mK?=
 =?us-ascii?Q?pQ1kCvnxmTdFFi6B9AK5OOeTOSRB2kRajHd/4s3SS2iocxVGoFX1Xsmjrpu1?=
 =?us-ascii?Q?S0gTwvf1sSF94YuqKvH4vvl/FlzwsZl3i3jGPQRZA6T/F+2gL4MIN/DTnCP0?=
 =?us-ascii?Q?EEkuTCAsQ+QaIgNA74Bgn7DjbaWziWmYVmJcQvw0HTslO8LgTwmfZU3NA6kG?=
 =?us-ascii?Q?HdcwT+sK024goqL7yNwt+/Ll66pxxFFX15fhmdHYS2bco1Ckt6kuzO5Xoljo?=
 =?us-ascii?Q?BWffldbz7AcHUEwHpnCe4Qj2vF6xqgVyYEkJc6I1TkIt8cJ8Rgh4EyC8HdGb?=
 =?us-ascii?Q?ZdJGvPLwHJY378VyyN6y8LVk93GkqmXbFO3UK1dJuFGtSF9xQh6O1pBmyDA2?=
 =?us-ascii?Q?b92/NeX+CyC/icwsNlK3JjNpjW4hf7JpDmSnXya6nKHWy3tVYHiwSQkiB2m4?=
 =?us-ascii?Q?PWuGZNjedMTx8oOrQ1RC6zf6j8O9Bnt6df/z3iefyE0kuJxu672kJ9csawuv?=
 =?us-ascii?Q?B4Z9F2K6sWgNvArD0o4ibR33hWledkLa/6K2lq4jHernGjcYHpZkqH3hZwMY?=
 =?us-ascii?Q?5LE9IyD1yXnuDmo9Kt1NdAzs9odvkk224nJmPzi0C9KS/M46cxWAsmHbKFBR?=
 =?us-ascii?Q?hPn/muJRtsMhwuFEFFgEMbFYCNdVXurOyf8d84kP2ZzAXfF4ux+0I/2DE+VC?=
 =?us-ascii?Q?fqtqihJQLNnBnUZEd+Y/31jDrjjOmOIhxO9n+zVMHTJxlw8xWIOVrXZZLkCu?=
 =?us-ascii?Q?3EmVakaZo/BWZRNKGOQvFsVGAmayx/RjFgQdOTRQ8xBu8GRJZKbChYUsWRMR?=
 =?us-ascii?Q?OZhCEWLesCP0vGiBqBxfQ0r+6O15iRJHTF6HqHUlPrBpP4cOjjB4fKHJMhPa?=
 =?us-ascii?Q?MmCFvg2U86L3cHRb1J5mxE605WkU3rXNNmGyEun2+/Atg9TnKnuAKpJ2DrBy?=
 =?us-ascii?Q?C+WuISo4yrMF+AWBRMbwhpdoahUqBBnGL/eZ7ylXGpU7fyXDmaKPZvFPjaVT?=
 =?us-ascii?Q?4nqvaOJlc+Do45sDTIzkEKMH2MCK4vohwIQ94APPf6Invsg4Ou3PZfVgaqg7?=
 =?us-ascii?Q?pFxjCmENW4Vys69uzVRYUYzSSGrW1vUPSAE8sK4OrbZWPuuXRznh9Be0PBtk?=
 =?us-ascii?Q?uvF7CwGzz4QKKrXYK+BYjyd2bZNiSuNK94Y+57QfH2LHuLJlg0yCtLtjDf6Y?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b76d95d5-3258-4194-0e59-08db43886b71
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 23:22:20.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaVBmj7AUvJjlrLMihLVse3zWsskoC+coQbwIbgQiQzmnY0jWDbYhLAhJzq4cQykCQUsDtLBxR7vigUQCOJt7THekc6KyJI1ETWMpbDm4Ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7418
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Lukas Wunner wrote:
> On Sat, Apr 22, 2023 at 01:54:00PM -0700, Dan Williams wrote:
> > Lukas Wunner wrote:
> > > On Sat, Apr 22, 2023 at 10:35:02AM +0200, Lukas Wunner wrote:
> > > > I note however that before af0a6c3587dc, xa_for_each() was run on an
> > > > xarray which was not initialized with xa_init() on non-pci cxl ports.
> > > > (xa_init() was run from cxl_pci_probe() -> devm_cxl_pci_create_doe()
> > > > but xa_for_each() was run from read_cdat_data() -> find_cdat_doe()
> > > > for non-pci cxl ports as well.)
> > > > 
> > > > Hence can't this crash prior to af0a6c3587dc as well?
> > > 
> > > After taking another look with a fresh pair of eyeballs I think
> > > you may see splats with CONFIG_DEBUG_LOCK_ALLOC=y (even prior to
> > > af0a6c3587dc on non-pci cxl devices) due to the missing xa_init().
> > 
> > The xa_init() was included before in the removed call to
> > devm_cxl_pci_create_doe().
> 
> ... which was called from cxl_pci_probe(), so only if a pci_dev exists?
> 
> I guess I must be missing something...

Oh, no you're right in the sense that the code will use an
only-zero-initialized xarray before the move to the PCI core, but a zero
initialized xarray is sufficient. Recall that xarray walks are only RCU
protected, so the xarray spinlock is not used for xa_for_each().

The change that makes this a failure is now the doe_mbs xarray is not
even allocated in the !pci_dev case.
