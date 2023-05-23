Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FF6C77B75
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 18:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjEWSkq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 14:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbjEWSkj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 14:40:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1979A10C7
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684867230; x=1716403230;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BQQSmLaOm1JQjIGph5TSS6o3MM6SG66wk2pZcryIxKA=;
  b=dTFjxIqAEZgMaR4gfjyB77W32WvmvKhnOtbI86j6OoYsvMQt8+6lMYo+
   mNn2TTLuAR3NTCKIh5gP8C//0mIh/t0zRLXOGkbuh81NGQ/9uaeB9pXV3
   vbff7l1xrmFFj5i29YzEQ1G/Ku0xyrW8f/4YyZbSydN0j6ZNf441/k19C
   tq0h5TDFdflCyPXo4On51FAGu4oqb4dDnusjKgweZKWRnZ9Go07YU5l/D
   Ty9u6+HHUxcl02ZFDM1MuZZD3KO023CXiPfPsony9fwIGsC+QA01ocisz
   tZwSfZMKoUknUAwWpXfNHSpr4BFbg+d1HEyx9qnQY4w/Y1r98/Vcobwdd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="333690099"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="333690099"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 11:40:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="773906621"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="773906621"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 23 May 2023 11:40:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 11:40:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 11:40:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 11:40:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b91IrsKEPzSK9E/to+YzwUNhQGzXMo/MCcF5GaawD22oVHQPGx7q1OSbN7Xxe9WYixVKrf2DcJbZGklOZHOJ/KuMyRZYrxJEdweb9qxTtlZvEnSFR2oRgEQSFYdqEqdflHX+ON2EBrWgNP2GMCmDpaD8Ir5rQuX5bKZPUHs1frw6lW0KqOahPASDZtUQc+kdiQy8pLtnjcTETufQTP/rMsnZ/sUiw5zodVDyVqzqpH6HMUD9XYD5dyXz9HHerUI0gP8k+i+IDytjV5+k2XTAe7O+lV01oiUExuFu0f4JQrnyUOj/zzlO9h5CeemqsyjliTTXTs8N2t2/61qwvyLDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1dqeDHWxNu4ptkR++mmrU4r+uVxP7io6nl1lYqSvNE=;
 b=iWhCxmHE1MWCAxfvwJhdSpOnIiRlhnxtmXRp7sVc7smfk3rJj+LUejkeA8Ey6cPvDmZxKpwHsSMZmaKTMoXTTnAimOyOPXVv3hrMNOPDI0N3WlB6nwm8gP9L/jDrMOGyrey1MgaGo4fGzkXLykpjmW0YJ/idX05I6/MFXiTAZox4ZaDQN019i3dEfjgSV/0fCZQevMSQ5mMR4hry6YEbigNL5IGM0ZVm1SBfu6iuRF/BvmF2tfYbCwqHXlVGYm50iVekGRubqMcV/8PrSII5XWwZgNwZSc49+vU0Vtg64FbXQ1BPB/PBvmVfvF6VRFTKnFAoUe7dJlrVXF49+4Xj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5550.namprd11.prod.outlook.com (2603:10b6:5:38b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 18:40:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 18:40:21 +0000
Date:   Tue, 23 May 2023 11:40:19 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Vikram Sethi <vsethi@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "catalin.marinas@arm.com" <Catalin.Marinas@arm.com>,
        James Morse <james.morse@arm.com>
CC:     "Natu, Mahesh" <mahesh.natu@intel.com>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Message-ID: <646d0892eadc3_afb77294cb@dwillia2-xfh.jf.intel.com.notmuch>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <BYAPR12MB333685D98C43D5247BEA998EBD409@BYAPR12MB3336.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB333685D98C43D5247BEA998EBD409@BYAPR12MB3336.namprd12.prod.outlook.com>
X-ClientProxiedBy: BYAPR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5550:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f5ee97-6af7-44eb-a6f8-08db5bbd29c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0Do8fpBf/xOQcC37Zd6b2fJV5ffppU7q+g6Xdq+aquimNX/Vgt717IKqjV8dy4IY0C0XI7ktc6OSgIgfhfh0uZfhD9mO12DfDtqTI1oQaHiAATSb8GI+OpmFfPv3Gce7YB8GKC/vl5FWaoY46HJeHOEVSSmeqBwASQ1+nW1/jWdPEblPc4HkdYqcCn2Kv7sx2KL48780reluypxG0fHzjJ6dMp3/ooFGdFm7LKU2Oqxfujy2gXTQkXtbQtuzLe5tTJNrZ8e0M7M8KZyXexVvyOJa+17sw8X5b9rQ3dDI5P+lK4G8UfcoMJU6WhAgVeNs59fCA1+PgicBGqBeDJyKkxe8FeyPS720odWMueQ4mDGcCTs3iLoyVnJRleZNkMTt7zDOeY6VEvKatluuSNWJROASDND+jugV9EagDFHVtb625nULD8q3Fme+T3bVu/mQSTFDRuxn6iBKJt2KDwBh/meyRsWxKdlnHi5R9mgAuW/apywHbKMAEyPqWC99XHdersdOD70sxt2hgm8zSAngPZzJ7KcSwEfauFL+Pu/ohY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(966005)(6486002)(41300700001)(478600001)(110136005)(316002)(66556008)(4326008)(66476007)(66946007)(8936002)(5660300002)(86362001)(8676002)(107886003)(6512007)(38100700002)(82960400001)(26005)(6506007)(9686003)(83380400001)(53546011)(186003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AMlQ2g9m8MoaKh/VXhny+5gsAJDWgFiIF0OCS3tEc/egNHItYyUuxWrPo4Fw?=
 =?us-ascii?Q?QPA5kOaHRlhvLNO22tVF/M/p/WV/KHrSM/OVisfqJktMXe7wNTxV/b+aWEga?=
 =?us-ascii?Q?cGPFnH5zpRlHShUz6/isL765asKJKbZhIOFaGST2IggpJQMIuais1KCSy7pl?=
 =?us-ascii?Q?gEcHKakLbQrNd9Ui0v9IAtRZ5egrlRZNKB9dZDDmn7mp9lS+ZChGWsan0dET?=
 =?us-ascii?Q?6ykbfL0KMlKXtu5jBRNzFTiGmB0cW9fGKECTR8LjpJICoOHHVz3mlVX62jNl?=
 =?us-ascii?Q?X46A7z4XXGWMOIetgY63e7qPuFD+jGeOLZ3mU7GBDxs9yvt9G1Si1MPpmrsV?=
 =?us-ascii?Q?Jm3zDHzLyhgKy6BIO/6vBUONHzlE/R7StVczE8P4WN1TPK8EtzwgkgUQrtkL?=
 =?us-ascii?Q?2Ie4WzeS0oYibBcejqcW/JAjxkSpQV33Bm3pcytTKOVA4yWlT5Dh93mEPIYR?=
 =?us-ascii?Q?/vVcs64LT/mMyyDtkIaM6dnNN2L15zF0XRc/xEwXLwRwP6P++KxzO98pRr6Q?=
 =?us-ascii?Q?ZCawEnIA5ieXE7twtUDCZctk2waJlh9T8+CYnPSHxqlNw/USXyRa1NaUMAeI?=
 =?us-ascii?Q?KPKtBHcfQ/JaTjkeQn4tmm8FQ/SIq8NW/SipX6e00oJEVL15w6CvtCmuzSnd?=
 =?us-ascii?Q?PnTUj+HJB1YO9GRzFWZIEvYVMGg8l9bZCaomQI+x3VyxVbn8MCPtXHESdpM8?=
 =?us-ascii?Q?e+LzfqSxvZ98+gdBBlYDf1dh08EQEq5Cjs0qMrRw3R2TmFbpsr8+LNcSMium?=
 =?us-ascii?Q?OI/pMxI+a8uA8h0gDZ7+Yd+lkXerjJX+ecXzzr1RZl7Pdz0QM4zmrMA/Mv2a?=
 =?us-ascii?Q?+JqszGZnhnooH+URvzHz/H3YRcI2CLrNmxbgf4BWyAZfSduKZDCWu2QyQY02?=
 =?us-ascii?Q?sWD5QZ2xW6GXtslSIZ4+A01PZu/kvlNyo2yC59V9/hoPJxcfRWA6ZIPknYK9?=
 =?us-ascii?Q?6NQ+V7JES34wnpp6nVFRKcGfgnlFHVVvVSdDYzWwFLb+A297ZQFVZgEyFWv2?=
 =?us-ascii?Q?s1GD4rVGm6quaVgXs/3hLC1tUYkwB5bfZUccswp+vv+EkDBzlvWuWwxl0tu3?=
 =?us-ascii?Q?rqpWJg1b4SvG3Vo9ijUeqYrR4vAgGw3yuzkTgPxHaPPmOgnpczBi3hgr6QN7?=
 =?us-ascii?Q?MjZWUL3Y+WO7Lmw0Sp3HsuXhnikSbc3C9RnJZ2wCcaL5mf+F1SnCaujs+emY?=
 =?us-ascii?Q?I//SGOS0LHAD3XtzQDGPvnkmzaIvF9DCm/svVX4JN1dVE17CqjUFocvYnC7T?=
 =?us-ascii?Q?BPVro8XDiIbWHKIMBz6kqLO+QP8GHRuMu390fP7UZhxLsDItUGhXLb7//JKf?=
 =?us-ascii?Q?IjG0oSU0VK24tiW0iqfRsZGXOh46n13DbvkbYOZUVZcBWfwdFRX3Z9xs1zUz?=
 =?us-ascii?Q?xC2Jiws+nudou+nSIGs6hSDj5k+6z7DDJuiVyNO2fXWYJFFhuRsm9K14CyLQ?=
 =?us-ascii?Q?A0oKigXYf0jJL1mafpYBtGP7PR/3sA7iryFpN+pJO0+R8e6Brvo9lujS6D0Z?=
 =?us-ascii?Q?QtgjeipMSHK9wewtjk2ZWXfbS7oBNtIsrha6KORJgpRZb6iiQM3blUMyVu6d?=
 =?us-ascii?Q?fVmgi/0qu3VJY1EJ6qbD0tA8Wxak67Zm+h+evD0geEufGU/ozNU+xlNb7UCC?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f5ee97-6af7-44eb-a6f8-08db5bbd29c5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 18:40:21.4159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lnm0L4fYlYefPH0g/bg1c6mEavxHBGrRv9ihM4pKePGDqSzIxHgAHbhmEta4L1RB0nN8aumwehC93bIT8q2oorEh3S7rgUJi+ZNy8jw8UXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5550
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Vikram Sethi wrote:
> Hi Dan, 
> 
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Monday, May 22, 2023 7:12 PM
> > To: Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>; linux-
> > cxl@vger.kernel.org
> > Cc: 'Dan Williams' <dan.j.williams@intel.com>
> > Subject: RE: Questions about CXL device (type 3 memory) hotplug
> > 
> > > Q4) Current CXL drivers/tools support Hot-removal request from PCIe?
> > >
> > >     CXL specification says "In a managed Hot-Remove flow, software is
> > >     notified of a hot removal request."
> > 
> > Currently there is a requirement that:
> > 
> > cxl disable-memdev
> > 
> > ...is run before the device can be removed. There is no warning from the PCI
> > hotplug driver. Which means that if end user does the wrong sequence they
> > can crash the kernel / remove memory that may still be in active use.
> >
> Is there any notion of a cache flush when memory is removed (or in future CXL reset)?

No.

> Generally, CPU caches must be flushed when memory is removed because any evictions
> when the memory isn't present can cause async errors which can be fatal to the system
> or at least to VMs, depending on ISA.

This seems incompatible with memory hotplug. The cache flushing is only
done on the subsequent reuse of physical address range to make sure that
any pending evictions are complete before the newly constituted address
range is put into service, or that any prior clean cache lines of old
content are dropped. See cxl_region_invalidate_memregion() for where
this is called.

> If the kernel does the cache flush, it must be done
> with only uncacheable mappings present to prevent speculative fetches after the cache flush. 

This is why the invalidation is done after physical address range is
populated by new devices. To flush any speculative fetches to the old
composition of the address range.

> Even so, kernel VA based cache flushes will likely be slow, so may be better to have the notion
> of an arch callback that can invoke firmware to do the cache flush. 
> Perhaps arch_remove_memory is the right place to invoke such a cache flush/FW call?
> I think the CXL specification should also address the need for cache flush when removing memory
> or doing CXL reset.

Seems out of scope for the CXL specification, this is up to each arch to
handle.

Here is some discussion of what ARM is thinking about in this space:

https://lore.kernel.org/all/40cd479b-f0f8-5dba-0e41-4cef73693927@arm.com/
