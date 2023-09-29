Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B62CE728C9
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Sep 2023 16:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjI2Q2a (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Sep 2023 12:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjI2Q23 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Sep 2023 12:28:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C44199
        for <linux-cxl@vger.kernel.org>; Fri, 29 Sep 2023 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696004906; x=1727540906;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t8Cai6Ak+54qCikkVMnE8DJAPx4wTpQPAatJxQZPoyg=;
  b=alpbkPekgr+4mNcXfukMOJuzRKSqRHJ3WGZWtbnvGXEF4y2u48sFSus3
   eDKLV7oHF0lbrBNolNikYG3qFRBVvJV/YpjwTHabThQRKeTgi6dptC5BA
   EfveFprwpqX8JuxE5Jha6N1sU7PWszZTQDQdfirpzHBFIN4ZU1z+0UZSf
   DjTjDXJfqCZEuLdusGVhiTbEJcY1MuLDvxK7E/S+CUOb3QYcQ1OBKfj5e
   gZmlnkfHG5L6W8WIraM4MF1uS7z6zmoW46NuYjmazEvKQfJybNMrHKifX
   3LxcGCQ9fZE+nHlCdasKXGGvBz6lCw0K5UhhZ5lvn8cJqb+syVaG9wmOb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="367389738"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="367389738"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 09:28:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="872804"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 09:27:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 09:28:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 09:28:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 09:28:25 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 09:28:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFXcK1MqaWmoayr5gytlXpwKcnvUBc0tQA5FAoVeAS+B6oQsTU9gyYyFwjNP3Wdh54cQ4eRKP+gTg/X5BJqJ0b4ijEFpHW6TSF3Jz5bHzeVccdI6+SDLydLV+wKEqworvNiNCGle3+IXjDLDd7GViXYAMAO15OFejMGFI0Rr4aAyv3Df8FkaSLFFxKbEz9OFrN/usVMXVY5a3VOSX7qAUO0MEuSHNyISReltz8JLPtsTrUYn1k/QX4R6RPhNJ9BGsSdY2eiF4N0xl1rlbyA/BeAkB9NSCu094MR2zR82+ixXPKBSgo4MCAp2gD2ZymkZh9hKZKRbs6Griiz8rX9Hdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKcNRgePC4LFXRzJzkZXitQFfYMaXgZDGQQZ/gwdCww=;
 b=eHPvHlsMikb+vRJ6NWQ45U3qatNp8ZOS0AHA37kQpcLpA6cpQ6hlRaAhN081Xcgqm3/Nct8TYFTFVgXxq+VSsPrqZx9mb0cYrNChbZ1AsUFotqX4/hPtPd1qS7MK4cJrrLgin9VGvXDJQotXx8hKnn7VwuRIfX9y1j39H6g8zK6+ptGoxkYOiGA19yx3IbYlo3jnrgqlc3HExTftV4h733ShFODkI4AtLDlROnbdjk/tEgXLPyANVLiGOU2M+bCWBiGiEtNW5OjEWVVcO4Cy7ivaZRM9w8SJD/I4v30rFiQhgP+hVU3XzdmkBu1lmX2HSQTugaCmm8gbdmG2W4oFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 16:28:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 16:28:23 +0000
Date:   Fri, 29 Sep 2023 09:27:56 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/mem: Fix shutdown order
Message-ID: <6516fb0c110b1_bf912942b@dwillia2-xfh.jf.intel.com.notmuch>
References: <169596542307.790108.11339208844199665348.stgit@dwillia2-xfh.jf.intel.com>
 <20230929100316.00004546@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230929100316.00004546@Huawei.com>
X-ClientProxiedBy: MW3PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:303:2a::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f07ad39-f850-42f6-7a73-08dbc1090def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmAghgAAl1lKSLR3IkoCpNvrWlJ9SO8NjKh3f5EcOtc3Gp62NGbwhBRX5W3a+sbX04CM9c4sOqHotT1DOdsuaO/IKGRpVonpdp0I1pF+SD/06LEc8BRSfQi33b5hkrk6pqgPCMIL57tRERqPT4YjNk9Sqmw8oFjBw0uKpfSwxv3eDxuenj6JNdSbX5Fh6sQrUe/rt2x+LKd6VtPANQtBJtUj/ZvY4zYXZ5Ay0uPF0f/5aG104RWb3NDoTtSPUgnhGEnrKEKRz3Nmbdvimp+GiKDf8lAjtYSGqYY1m1R35jXtUObh/cLH1yM68tutiNgpgUEQOrMmULIxzDWlHGEhjwYE9epfbCGkqjcyl33GRY9qoMkxfEJS2xtifLvlxRfbhTL+VLA+3sQnDbJ3e9s4SZ+NXhwu+A5N8rnI7Qx0MP6r3BzQJOKoYWhPYOhQQU5RXhf1zYBSudI6rle7dNgr/8cVf73/XQrX+Lj9dNr5ITOmvRn5fatIA+sMOGL9QFEE0vllmdys2/m94tfxiGM7VT/NLKrgMVfJN9GkgNtmkWY57AmaNLEKhY2DKgPDbW6dGctnFtVnGtJhIFcOlPC/CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66476007)(26005)(110136005)(66946007)(41300700001)(316002)(2906002)(6666004)(6512007)(9686003)(5660300002)(6506007)(966005)(478600001)(6486002)(107886003)(66556008)(83380400001)(8936002)(4326008)(8676002)(82960400001)(38100700002)(66899024)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EzjiA84ZlH95fyisOth8XE8RKlQoUQA3SoVz+0rkqgtSF0uaNxFyrxN5N4tm?=
 =?us-ascii?Q?fUvNgpqXs0Iw/aTBwZTjue2+QAwdmPm3uYPKMKTbQAt0NGUGfCCe/+5avXUk?=
 =?us-ascii?Q?FAlH2ML4MqtUnrN0AP9nxRR0bdvJ3DXs91uHIDn02j4IS90vrw0Y4gUsJLL0?=
 =?us-ascii?Q?BXjfCw+KTv7NQvvU9eqKSrhabz1PEXavECBTMh2f9k7e3mSoa7/+IOG+d42P?=
 =?us-ascii?Q?R6uAMOkfCDwy8Pzsou0cJAuwQ5lik8m1iM0JVyWDvuP2rYC/G1DK9uT1SY5t?=
 =?us-ascii?Q?SVcA0JHBPr93SL4tAhzaMlCLAM4w1PrGVN3IPk2+mQStncqoQ/AuT4mB7n3L?=
 =?us-ascii?Q?jk+DH5GC6YfgAkE0mVukN45pL7pvvhzjNDHSKS3NJZzpYVIZu0w3sicdK3BO?=
 =?us-ascii?Q?vGxpLh7t5WOwSC3twlUBf6PSOaSA89B3ZeF01do8VEyWfPTikMPkFrRF2Hc4?=
 =?us-ascii?Q?hqM/aJv1f3nv6ANkh+4DSzRk/75JZ+qsV0tAUO1Hfy1Xk8R+c1CtcQ3iPHcp?=
 =?us-ascii?Q?ch5yQWE9ZTuNkD1HpqETIqe17FgPoU/dxPXDiQz3ryM6rD5XGLLKSCmj4eBz?=
 =?us-ascii?Q?gbkzYOQD9OnDbkHfB9o1xuWRaGiIE7v24nAuN6k0FpwD+f9KqBuHuLQLo9wx?=
 =?us-ascii?Q?yb5ZEmvp3QcDLruuSwoL+UYc50uDYw2lCjNEXrHWnhCJlKPdrmaE8Az55Jje?=
 =?us-ascii?Q?QQu/9gE83w9CWlJD/OcOMAwG4SX8qbbUUcFNLapUphWqvolHRIunFRQsa1Ds?=
 =?us-ascii?Q?v6l9LP1KE3PVKOMPonDMm0hlKbeDmGr0PhEshIHUM1/ZO9sntIdWgMFS/jwi?=
 =?us-ascii?Q?v/zrsF1/WZxAzqb3vzAO7A4R/MdtKpa6FP/tYyB8aPZLYgdXp16LLorDB984?=
 =?us-ascii?Q?vHE32zSE0qH7SvWJoe1AbVoEwXrNgik69u2LcDFPU/MzjPwY3pvUIEWOT8pi?=
 =?us-ascii?Q?4xB6ZRExG1EeZQqaZyxPZL1br6FU5RzMJTc2VA9K6muunna3/4D68p2ALmyp?=
 =?us-ascii?Q?a/3nTuzltC3YHvVEZknKzgbYuBhPeUnEy3Rv7BZCuAdN06UMfmVpPpyrXBu2?=
 =?us-ascii?Q?T6Nxr3eX1sCt3trF//IgvqVCTds1rkj597AmachKFyCola6A3L4CvcjkKWWF?=
 =?us-ascii?Q?YYQDEvQJtCXmQemiQkzlQMqRkyM9ROkBzNewuK6TeY5nd5ND2o+YLjfoFxvy?=
 =?us-ascii?Q?TV5pZZ8HHx7Sok/utg0ivn5vmkRR4Ms9R03GAGC2WzGfxv+4cUjiv+Y+8ra+?=
 =?us-ascii?Q?GIAkN/Uuzkc+Fyk/NrfLk4ajxYPiOR1WGLDgAMVwvV/TBygCVR3upUXCkiHj?=
 =?us-ascii?Q?/7AJNRHUOzu2iRj09ktC6GwC6ljR36vhOBuClzMEiQmjI89GD6yojW9nTB0x?=
 =?us-ascii?Q?KsChEup+KDY7pFzm7+ak2+9wD0JJbiGNSuaRHybJ1lUdpfoMsEZzjsS/5Mbt?=
 =?us-ascii?Q?+ReBrB+qjAaYj3GAX5qbxChMewBz2dBn8pmwq+dTKyXqvGOjocJXtEyhNh+C?=
 =?us-ascii?Q?TCtRCZzfgWmXmQOaV+m5ueImxLdsamaeTMwwy32iGqyCbljaKBxlqTjDxOZz?=
 =?us-ascii?Q?lf6DpG4/eotkskLlRlGZhHbCBjWXGf6d/GAYvdVZ7g9B0YDeevX0KMA4IWGD?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f07ad39-f850-42f6-7a73-08dbc1090def
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 16:28:03.7790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RPra7LL0n08yJapqcmJbhQwr3klqiEEjrJRvIgO5CBGjGJJvE80N7V6xeqpC0vgSyqe6x5q2UjaGvblRakMQn7BX46OsCml8IdArsGjxF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7965
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 28 Sep 2023 22:30:23 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Ira reports that removing cxl_mock_mem causes a crash with the following
> > trace:
> > 
> >  BUG: kernel NULL pointer dereference, address: 0000000000000044
> >  [..]
> >  RIP: 0010:cxl_region_decode_reset+0x7f/0x180 [cxl_core]
> >  [..]
> >  Call Trace:
> >   <TASK>
> >   cxl_region_detach+0xe8/0x210 [cxl_core]
> >   cxl_decoder_kill_region+0x27/0x40 [cxl_core]
> >   cxld_unregister+0x29/0x40 [cxl_core]
> >   devres_release_all+0xb8/0x110
> >   device_unbind_cleanup+0xe/0x70
> >   device_release_driver_internal+0x1d2/0x210
> >   bus_remove_device+0xd7/0x150
> >   device_del+0x155/0x3e0
> >   device_unregister+0x13/0x60
> >   devm_release_action+0x4d/0x90
> >   ? __pfx_unregister_port+0x10/0x10 [cxl_core]
> >   delete_endpoint+0x121/0x130 [cxl_core]
> >   devres_release_all+0xb8/0x110
> >   device_unbind_cleanup+0xe/0x70
> >   device_release_driver_internal+0x1d2/0x210
> >   bus_remove_device+0xd7/0x150
> >   device_del+0x155/0x3e0
> >   ? lock_release+0x142/0x290
> >   cdev_device_del+0x15/0x50
> >   cxl_memdev_unregister+0x54/0x70 [cxl_core]
> > 
> > This crash is due to the clearing out the cxl_memdev's driver context
> > (@cxlds) before the driver is done with it. Fix it by keeping the driver
> > context valid until device unregistration completes.
> Ideally good to have an explicit statement of which bit of context
> is used in the cdev_device_del() call.
> > 
> > Fixes: 9cc238c7a526 ("cxl/pci: Introduce cdevm_file_operations")
> > Reported-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> I'm not that keen on the fix, because it makes some incidental ordering
> changes and the ordering in here is messy.  What you have feels like
> it's fixing on symptom whereas there are other issues here.
> 
> Firstly, as a side note given I'm looking at this
> code cxl_memdev_security_shutdown() should perhaps take a
> struct cxl_memdev rather than the struct device that it then

cxl_memdev_security_shutdown() is in the wrong place, it should just be
shutdown like any other optional capability.

> uses just to get hold of the cxl_memdev available in
> cxl_memdev_shutdown().  The equivalent setup code
> cxl_memdev_security_init() already does take a struct
> cxl_memdev so this would be desirable for symmetry if nothing else.
> 
> However, cxl_memdev_security_shutdown() doesn't actually undo
> the stuff in cxl_memdev_security_init() which previously sent me
> on a wild goose chase.

Yes, that needs to be cleaned up.

> 
> Offloading that put_santize callback here to devm looks dubious to me:
> https://elixir.bootlin.com/linux/v6.6-rc3/source/drivers/cxl/core/memdev.c#L1031
> 
> .. for a function mid way through a bunch of stuff that is otherwise cleaned up
> by cxl_memdev_unregister() via devm here
> https://elixir.bootlin.com/linux/v6.6-rc3/source/drivers/cxl/core/memdev.c#L1066
> seems like a recipe for future pain. Could we just move the put_santize()
> call directly into cxl_memdev_unregister() and the error path in
> cxl_memdev_add_dev() and make sure the order is as expected.
> 
> I had a long argument written up on why cxl_memdev_security_shutdown()
> was in the wrong place in the new sequence before seeing that it
> didn't balance with what I assumed it did.  So probably still in an illogical
> place given I'd expect all the 'security stuff' to be initialized at same
> point in setup and tear down sequences (reversed obviously.)

Yes, I tripped over that and should have mentioned the grumbling as I
held my nose and fixed the crash.
