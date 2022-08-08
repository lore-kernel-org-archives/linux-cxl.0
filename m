Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5F6C00140
	for <linux-cxl@archiver.kernel.org>; Mon,  8 Aug 2022 15:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243599AbiHHP6s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 Aug 2022 11:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243674AbiHHP6r (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 Aug 2022 11:58:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6DA1571D
        for <linux-cxl@vger.kernel.org>; Mon,  8 Aug 2022 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659974325; x=1691510325;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ow0rgTDnZlB+35CfhODc41hRxwdjuDE3vRCVaclMr7g=;
  b=V8ckGnHOu+bggv544q8VrRK9SglXWjYpHWl5w8FxFmEAaLBW62RF8g7f
   /rMR22O30Wb/UOjoxvdtDIKvg+KfKxlZg2j9W0XG18XSTxCW6YJHtcdio
   hN/E6ck9SLsvOPgOO5D13iLDoBhcv7opUNGZMdcyKOBGFixZZMz+QGoui
   HBIcUBR5+mJzSbpZrRYxhbRdtVo14KbXnLbDHifBkbXlWoAnXhMpFzkfI
   wZLhZau8g3fmTfHoslgDklzhG2HGQt1qNsEFV9I1sEdZGli+TEC877emw
   imYz/qTPvbXhL2XBvac2O7GADzP4eYlYK+kBLXGRrLF74VSkoIDjBe+A2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="291864526"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="291864526"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 08:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="780539417"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 08 Aug 2022 08:58:45 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 08:58:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 8 Aug 2022 08:58:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 8 Aug 2022 08:58:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnYi9VqLuC6d8pJETzdUojoDo+f/wXNe4UtJNvW0C505H/KR3DDYtjKY7Iz9cVcUrINy5h+JtICSk7/Lw3k7g/mMWx28zgtaqkAmatroqELXCBEC4CdGCvxjG77cb1H+5uFJSwOzcAWtO6oVhS90XYGQ/MzjBImKP+Ra6t5qzRNHal/g01BqStgdOoxOmva6EBZVGDjGG/NizmhTYJJGilW0fBIdlz8FJ59PiYepXIJIF6Wj7/Hk61UBJvj1yQjfOh6jTNUu/N7tGOIsRVg51l3DzKM87WagZKIIAednjJFJ3jV5tuJILZzY1GqfUXFaAvmeQLMKObuXvhgtvJBmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVlBKI7tquWAdDb5N2l7qfhX1nQ2krw6mgJz4UVZjIo=;
 b=lD/88lvH2ubh1qV+8PXhwQGF/myNt5K0j7xZ0bQ8kOF8TU8FXMBBUROYweaPMvRdlwP+C4VRn6+iK7hVuws4ffnmCrwjFOe93ZVif4NXhVNE/w630xn/nAWPG4X2gSqFBHUG8MJ/hDy74Lk12+30KBNpE2CBSur8EXCQBFEqL/j8Ezd09VMu+4FIFd7FQvOE2DlGjOFAmv/Uk65Dv87R4zvL14/7X+FMQ/7UQUBbz97zA1J3Lsm13ngNcrOdi84upM7e5l/Z4EFrTTwvapBE4oI7SHcWlu1iGkuRoGPem8GlVMOPOnyHrYeEjXX/cUaz9rhHds7Xf1COPF/1xauDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN9PR11MB5321.namprd11.prod.outlook.com
 (2603:10b6:408:136::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 15:58:42 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 15:58:42 +0000
Date:   Mon, 8 Aug 2022 08:58:38 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Bobo WL <lmw.bobo@gmail.com>, <linux-cxl@vger.kernel.org>
CC:     <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: RE: [BUG] cxl can not create region
Message-ID: <62f132aee401b_1b3c294c@dwillia2-xfh.jf.intel.com.notmuch>
References: <CAGr_yG0UrfJAMWta3EkR1F0JZ4j--sig74p6vKL3K6TZDx9YGA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGr_yG0UrfJAMWta3EkR1F0JZ4j--sig74p6vKL3K6TZDx9YGA@mail.gmail.com>
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 590d3521-7584-4a5b-b7fe-08da7956ddc7
X-MS-TrafficTypeDiagnostic: BN9PR11MB5321:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Arclw/rGWYfPjhWQ1+2TAm9N48tBpF1bS9I8DkaDfvtWkE4Rn3ozj2lHfDILNVyUtg7/q9x/vcFuZ+3qqYLrHrSQ1wSfXDfxhrzdfNeFpSyMDK3f8+1Vufz3nNMhcdhC0P1X3MkxEBsyP9+uBYSKA84N3tZqjQq0PE4+c8i8k4rYw6gRmml1/6kbAhZjkwWJIKmZjarydaZr4nWC1L4IxMHsFXuXqzGal4kGW+nJrH0zPeOP9Qvo/RTT6HK1NxBOHckVQlmHaG7++hk5x2xXH2SetMauJ2nvB9Rtin+7I3UluS/jmeWbt3iqgHf2fc9/yzMlQx7rgmtQtdJEnux4CR9/6/b54MJ0dR623hd5zY8DZHplFViZgFrhwJGrkwLt59PLAq1aQUuqMz7HMkggpBtTotCwTgXyWQKG4GpUDMq/HUY4+J6QvvJH5E7nSuxopIU8uLU3hMHNlaqiZYpbKANZLjPgvPJToUWWPELqncgHKOp1e1c83YjpHbKWGQSO/SGIhsRys2LjvLKsXgqpTr6VEuW4Od4FSfa9zSLT8me98OeYdOIveQPkmELPCPCgddBmVS2rTJW+PFHL2dj61CCHfaTl27sWr3BJc7Y7jnMk4maHisdDMnkTw7lthTryb8rTrKy4lDbrRFXGrjUciPF/7sCOXQ3suozbaWbonUsQpr+dbjixAd4N+I9uzdkP+XCNb2EtMmMDXUTmP34P89mdJdRI9qTdYUxJQ3gesr+EkuFK+sc8DGkiCw5n1lMnHPjmZfiQhFtislf7IKFBd3WJlb95ydPgfwNQB4xjjEvdT03oy0cNfPp2fFYioNy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(39860400002)(366004)(376002)(346002)(38100700002)(82960400001)(45080400002)(186003)(83380400001)(316002)(9686003)(26005)(8676002)(6486002)(4326008)(5660300002)(478600001)(966005)(8936002)(2906002)(86362001)(66946007)(66476007)(6506007)(66556008)(6512007)(6666004)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B0S/94X6PSvpN+9bTPZuC0129i5Uzc9vTSTEfXHCmtyBAbZqlsv/0R/KQN1T?=
 =?us-ascii?Q?nfXwUsVH1P7kaFGq+ph7PBNclCw0wKamuap9zXYytMyNHZNOR1gTMo0v1RiG?=
 =?us-ascii?Q?T8jVNPSuksBFnfoO1B0IT1dSz2jp7WMWPfwCRKBQAjz81Ui7m3MmONW896w3?=
 =?us-ascii?Q?w8JnOLzvMNfNxN8Frvq59SB3jsNOHiVVOYQQOzIKIYl4+LvQ8KoJds0hoi5b?=
 =?us-ascii?Q?a0iQkvceUlJ2Jy+OMKb+nJnNDGwtQAqbfvWu2UMMQx//52nyYho0n3uBKJM7?=
 =?us-ascii?Q?ODJ6SW3d74mO147xts5nqO+1n/fuNeEp645V0haIYK+hMk3gIHsqlg6s+rvY?=
 =?us-ascii?Q?XxL/5MOsjjSZ655kA2eI5ORy5a/qI03d0J3MFSzbQWfGCL2QLB+e8McmNZTG?=
 =?us-ascii?Q?Nt7euN1YDjmZOGyFWzGoNtJ9sEdUSqXv62IXhsqatR5cjLhmbGks+ptOxoEN?=
 =?us-ascii?Q?FDwiR87h7WxI8OBzlAKioMXInblBnuRxtSkM86vQCirCWXxf2ZeurMvMiMZf?=
 =?us-ascii?Q?mXQyJ5XR4/YSgx41nVKB8gmogTF8tCJKZ2rTUyn8wnD/J2ibnaaoay+TY4k3?=
 =?us-ascii?Q?7YdxEivkn+Ji4nDCJNLVfiGkPZEagQ/gIu/vUij4DCoD9+q8P6mghekRF0fj?=
 =?us-ascii?Q?XGlRkxEyaggqvTf8pK4Kc7DUUgrnrm5lNKCHaP1IhZXdeoI51/Q7oLga8M15?=
 =?us-ascii?Q?Z5xmxKJRRgq43oKidg31pMQblgCjAJp5nq8P9793AJIu5d+N0szXAaVhqd8G?=
 =?us-ascii?Q?R6Y9BxbogVwp3tGRMTgxWvILWfk/fdpwHr46XExZYjD+c1M2ofvKHqOT/dUM?=
 =?us-ascii?Q?vJZK4ET9aG09GYEL3VZIxMS0dQBmbYORm9yPa+tUeUOBBTcvRzWGYLEdcyNs?=
 =?us-ascii?Q?qQUv1nm8wi8ldkKKgfImdWnUvbcT2/IBc362UMJ6OUMPxoAMFDuQKLzmiCZP?=
 =?us-ascii?Q?6dD2+1boBkbn2OHRZvoIBBEhGTrYuZNjtG8U5HqigMk7iLxFpmiT0AYg3Za3?=
 =?us-ascii?Q?dV+M2YS0L9qUuT659uifSvYM2Svlid0c/HqWTcTRQh0dNfqXW/6mubpwtEiS?=
 =?us-ascii?Q?/OXQkL2NAE1eC/ZUa1OMquy5Cxv/5/CUeeEMmzp8GDdPIicGQEckn55XMcgb?=
 =?us-ascii?Q?WS1kTruK4KVmFfrgXzl/JwkhYsLWc5+SPV/OTWal8G20N1h0u9xzi0Ld9irC?=
 =?us-ascii?Q?CwlXWxefKwrK72c9ElpDiqqdIPvfCC/xlrPGGd2kHlbO+PS2iARa19MFM81c?=
 =?us-ascii?Q?fx12sXNlk4vIM/HkGOlNW51lReS46bJaGNH1G+mKsbsl36VXkKyYuNuQAAbd?=
 =?us-ascii?Q?aW3qnahkayXVpYCjdV1EOicCzPVQHH5Kw/YeKIJVTjGjslJUh052wXwwHSDX?=
 =?us-ascii?Q?U+Iac19m1hSn/4jg1w44qKsDxQJfjcaCxQTPk3Cs0Xn4NHeCdCFkOl6WP3oJ?=
 =?us-ascii?Q?+pP9/F9PZwuxLuvMVi2qjiHQoP3H9nhMWsJXVckdAwfT/c7bDlkZv80f2AVt?=
 =?us-ascii?Q?i727gSlT0WpLYqIgcoNmbvBuwGZsA2mmwxEl5/FFCdcWSoas0DWvTgAATvdd?=
 =?us-ascii?Q?vtNO91qHuTRkn1PNLLRvuFYI5qaqzgmI2tjkegfDqNk4x1Y+UzFClvjytqsr?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 590d3521-7584-4a5b-b7fe-08da7956ddc7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 15:58:42.4316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIv9+JzEaNIPwmL6vPV2EB6+Fzg1TtgQB/Uz8+VqtLKLsBRIv8dA/kIH6lgrRrd07ZobYf75pjtzCw8OLDeTOmUbnlC1nnQMmGTIgD0ySoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5321
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Bobo WL wrote:
> Hi list
> 
> I want to test cxl functions in arm64, and found some problems I can't
> figure out.
> 
> My test environment:
> 
> 1. build latest bios from https://github.com/tianocore/edk2.git master
> branch(cc2db6ebfb6d9d85ba4c7b35fba1fa37fffc0bc2)
> 2. build latest qemu-system-aarch64 from git://git.qemu.org/qemu.git
> master branch(846dcf0ba4eff824c295f06550b8673ff3f31314). With cxl arm
> support patch: https://patchwork.kernel.org/project/cxl/cover/20220616141950.23374-1-Jonathan.Cameron@huawei.com/
> 3. build Linux kernel from
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
> branch(65fc1c3d26b96002a5aa1f4012fae4dc98fd5683)
> 4. build latest ndctl tools from https://github.com/pmem/ndctl
> create_region branch(8558b394e449779e3a4f3ae90fae77ede0bca159)
> 
> And my qemu test commands:
> sudo $QEMU_BIN -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 \
>         -cpu max -smp 8 -nographic -no-reboot \
>         -kernel $KERNEL -bios $BIOS_BIN \
>         -drive if=none,file=$ROOTFS,format=qcow2,id=hd \
>         -device virtio-blk-pci,drive=hd -append 'root=/dev/vda1
> nokaslr dyndbg="module cxl* +p"' \
>         -object memory-backend-ram,size=4G,id=mem0 \
>         -numa node,nodeid=0,cpus=0-7,memdev=mem0 \
>         -net nic -net user,hostfwd=tcp::2222-:22 -enable-kvm \
>         -object
> memory-backend-file,id=cxl-mem0,share=on,mem-path=/tmp/cxltest.raw,size=256M
> \
>         -object
> memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest1.raw,size=256M
> \
>         -object
> memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M
> \
>         -object
> memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M
> \
>         -object
> memory-backend-file,id=cxl-lsa0,share=on,mem-path=/tmp/lsa0.raw,size=256M
> \
>         -object
> memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa1.raw,size=256M
> \
>         -object
> memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/lsa2.raw,size=256M
> \
>         -object
> memory-backend-file,id=cxl-lsa3,share=on,mem-path=/tmp/lsa3.raw,size=256M
> \
>         -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>         -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
>         -device cxl-upstream,bus=root_port0,id=us0 \
>         -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
>         -device
> cxl-type3,bus=swport0,memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0 \
>         -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
>         -device
> cxl-type3,bus=swport1,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1 \
>         -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
>         -device
> cxl-type3,bus=swport2,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2 \
>         -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
>         -device
> cxl-type3,bus=swport3,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3 \
>         -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> 
> And I have got two problems.
> 1. When I want to create x1 region with command: "cxl create-region -d
> decoder0.0 -w 1 -g 4096 mem0", kernel crashed with null pointer
> reference. Crash log:
> 
> [  534.697324] cxl_region region0: config state: 0
> [  534.697346] cxl_region region0: probe: -6
> [  534.697368] cxl_acpi ACPI0017:00: decoder0.0: created region0
> [  534.699115] cxl region0: mem0:endpoint3 decoder3.0 add:
> mem0:decoder3.0 @ 0 next: none nr_eps: 1 nr_targets: 1
> [  534.699149] cxl region0: 0000:0d:00.0:port2 decoder2.0 add:
> mem0:decoder3.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
> [  534.699167] cxl region0: ACPI0016:00:port1 decoder1.0 add:
> mem0:decoder3.0 @ 0 next: 0000:0d:00.0 nr_eps: 1 nr_targets: 1
> [  534.699176] cxl region0: ACPI0016:00:port1 iw: 1 ig: 256
> [  534.699182] cxl region0: ACPI0016:00:port1 target[0] = 0000:0c:00.0
> for mem0:decoder3.0 @ 0
> [  534.699189] cxl region0: 0000:0d:00.0:port2 iw: 1 ig: 256
> [  534.699193] cxl region0: 0000:0d:00.0:port2 target[0] =
> 0000:0e:00.0 for mem0:decoder3.0 @ 0
> [  534.699405] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [  534.701474] Mem abort info:
> [  534.701994]   ESR = 0x0000000086000004
> [  534.702653]   EC = 0x21: IABT (current EL), IL = 32 bits
> [  534.703616]   SET = 0, FnV = 0
> [  534.704174]   EA = 0, S1PTW = 0
> [  534.704803]   FSC = 0x04: level 0 translation fault
> [  534.705694] user pgtable: 4k pages, 48-bit VAs, pgdp=000000010144a000
> [  534.706875] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> [  534.709855] Internal error: Oops: 86000004 [#1] PREEMPT SMP
> [  534.710301] Modules linked in:
> [  534.710546] CPU: 7 PID: 331 Comm: cxl Not tainted
> 5.19.0-rc3-00064-g65fc1c3d26b9-dirty #11
> [  534.715393] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> [  534.717179] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  534.719190] pc : 0x0
> [  534.719928] lr : commit_store+0x118/0x2cc
> [  534.721007] sp : ffff80000aec3c30
> [  534.721793] x29: ffff80000aec3c30 x28: ffff0000da62e740 x27: ffff0000c0c06b30
> [  534.723875] x26: 0000000000000000 x25: ffff0000c0a2a400 x24: ffff0000c0a29400
> [  534.725440] x23: 0000000000000003 x22: 0000000000000000 x21: ffff0000c0c06800
> [  534.727312] x20: 0000000000000000 x19: ffff0000c1559800 x18: 0000000000000000
> [  534.729138] x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffd41fe838
> [  534.731046] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [  534.732402] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> [  534.734432] x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffff0000c0906e80
> [  534.735921] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80000aec3bf0
> [  534.737437] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c155a000
> [  534.738878] Call trace:
> [  534.739368]  0x0
> [  534.739713]  dev_attr_store+0x1c/0x30
> [  534.740186]  sysfs_kf_write+0x48/0x58
> [  534.740961]  kernfs_fop_write_iter+0x128/0x184
> [  534.741872]  new_sync_write+0xdc/0x158
> [  534.742706]  vfs_write+0x1ac/0x2a8
> [  534.743440]  ksys_write+0x68/0xf0
> [  534.744328]  __arm64_sys_write+0x1c/0x28
> [  534.745180]  invoke_syscall+0x44/0xf0
> [  534.745989]  el0_svc_common+0x4c/0xfc
> [  534.746661]  do_el0_svc+0x60/0xa8
> [  534.747378]  el0_svc+0x2c/0x78
> [  534.748066]  el0t_64_sync_handler+0xb8/0x12c
> [  534.748919]  el0t_64_sync+0x18c/0x190
> [  534.749629] Code: bad PC value
> [  534.750169] ---[ end trace 0000000000000000 ]---

What was the top kernel commit when you ran this test? What is the line
number of "commit_store+0x118"?

> 2. When I want to create x4 region with command: "cxl create-region -d
> decoder0.0 -w 4 -g 4096 -m mem0 mem1 mem2 mem3". I got below errors:
> 
> cxl region: create_region: region0: failed to set target3 to mem3
> cxl region: cmd_create_region: created 0 regions
> 
> And kernel log as below:
> [   60.536663] cxl_region region0: config state: 0
> [   60.536675] cxl_region region0: probe: -6
> [   60.536696] cxl_acpi ACPI0017:00: decoder0.0: created region0
> [   60.538251] cxl region0: mem0:endpoint3 decoder3.0 add:
> mem0:decoder3.0 @ 0 next: none nr_eps: 1 nr_targets: 1
> [   60.538278] cxl region0: 0000:0d:00.0:port2 decoder2.0 add:
> mem0:decoder3.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
> [   60.538295] cxl region0: ACPI0016:00:port1 decoder1.0 add:
> mem0:decoder3.0 @ 0 next: 0000:0d:00.0 nr_eps: 1 nr_targets: 1
> [   60.538647] cxl region0: mem1:endpoint4 decoder4.0 add:
> mem1:decoder4.0 @ 1 next: none nr_eps: 1 nr_targets: 1
> [   60.538663] cxl region0: 0000:0d:00.0:port2 decoder2.0 add:
> mem1:decoder4.0 @ 1 next: mem1 nr_eps: 2 nr_targets: 2
> [   60.538675] cxl region0: ACPI0016:00:port1 decoder1.0 add:
> mem1:decoder4.0 @ 1 next: 0000:0d:00.0 nr_eps: 2 nr_targets: 1
> [   60.539311] cxl region0: mem2:endpoint5 decoder5.0 add:
> mem2:decoder5.0 @ 2 next: none nr_eps: 1 nr_targets: 1
> [   60.539332] cxl region0: 0000:0d:00.0:port2 decoder2.0 add:
> mem2:decoder5.0 @ 2 next: mem2 nr_eps: 3 nr_targets: 3
> [   60.539343] cxl region0: ACPI0016:00:port1 decoder1.0 add:
> mem2:decoder5.0 @ 2 next: 0000:0d:00.0 nr_eps: 3 nr_targets: 1
> [   60.539711] cxl region0: mem3:endpoint6 decoder6.0 add:
> mem3:decoder6.0 @ 3 next: none nr_eps: 1 nr_targets: 1
> [   60.539723] cxl region0: 0000:0d:00.0:port2 decoder2.0 add:
> mem3:decoder6.0 @ 3 next: mem3 nr_eps: 4 nr_targets: 4
> [   60.539735] cxl region0: ACPI0016:00:port1 decoder1.0 add:
> mem3:decoder6.0 @ 3 next: 0000:0d:00.0 nr_eps: 4 nr_targets: 1
> [   60.539742] cxl region0: ACPI0016:00:port1 iw: 1 ig: 256
> [   60.539747] cxl region0: ACPI0016:00:port1 target[0] = 0000:0c:00.0
> for mem0:decoder3.0 @ 0
> [   60.539754] cxl region0: 0000:0d:00.0:port2 iw: 4 ig: 512
> [   60.539758] cxl region0: 0000:0d:00.0:port2 target[0] =
> 0000:0e:00.0 for mem0:decoder3.0 @ 0
> [   60.539764] cxl region0: ACPI0016:00:port1: cannot host mem1:decoder4.0 at 1
> 
> I have tried to write sysfs node manually, got same errors.
> 
> Hope I can get some helps here.

What is the output of:

    cxl list -MDTu -d decoder0.0

...? It might be the case that mem1 cannot be mapped by decoder0.0, or
at least not in the specified order, or that validation check is broken.
