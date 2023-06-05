Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186EBC7EE23
	for <linux-cxl@archiver.kernel.org>; Mon,  5 Jun 2023 17:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjFERgK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Jun 2023 13:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjFERgI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Jun 2023 13:36:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2090F91
        for <linux-cxl@vger.kernel.org>; Mon,  5 Jun 2023 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685986566; x=1717522566;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L/rGtwjCSmKK6qOUsU8ii93FJgmh+N3lLBhCdgBy9BI=;
  b=Rvw1XEYOTGDXyRg9I8S3quGFeprUh128HLantS67frHKzZ1J81/iWwsm
   hEOZc6dM3Wy2OS5YNwqKnihKa6h1BYJu5ymzp438G7o/YbuvIYHlRHC06
   /iVodOCxdaDKpwfHcQOGmn60qwdiidbfSnbYbv/oXY3BQ2e5IRtNoRAbF
   1v/FXT6/ByiEBwE94zDJBj41ZB8Ecf5Zy1EAgvr+4hka2qJXULVMpUhBZ
   qTDwZwiWkMxEjNFMG1iVDEDwuEL7f3Cb3ErJgWm5++2jJ49RgphV8uCCr
   5NGCPcSmp6bNr/JRvbOoDN6bwFHbW0RNU89ko7bGyVIFCmbCk5X2gxPpD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="384739601"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="384739601"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 10:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="778646934"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="778646934"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jun 2023 10:36:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 10:36:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 10:36:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 10:36:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 10:36:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ese0mUrSIAb39DSmA7zR4DNSz3RWzwPQJ2FeVhBgMrRMeJohe2F/a+1BU0AE2Rm07aRE5r/QNyacccmd26VaWvfSsH3A1U9nCHLGl5hZi2NeFcBM85/BFi8rxBZ7WwaFK9GAiIaIvc3yC9xoB9eBuOriN0rvWnj91cTbJajbNuIlfqCp71J5WJcBztEgtTjzZZSZ6WV4yQVh5rCigQlhhJx6m2BsYuFVF/AenxssMHCLGYncIiv7bFrEFiliqBYUNw4x0O3lbOMa3v/Vs2bFoRdgVZyUhUUEW4pg9yRcjZA87AOWDuONAF2ER6xJXMCKckHk1qidKFYoMkUiYgheDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwI8b0c6pwlLUYguo8qR6461pDxkkXvRys7okam9GKY=;
 b=MoQGiJHOgmkUQyLs9eqt0BMLtENNsxSjP6u9V9iVht8bNRGORs69xvnWT+VxUgYhtMOKbEOPT3/G8CpSwvGSjilbnjtWF/JvUZdFJg3mH1+XNE0wuxJURTvoRtj3EQ7CBFi7nTehZzDal85Ci6n6kHOQquP7V6PJxiQhpKoglfAWG7veOrDSG3uEUFiGs8NQN785rx53jXHTxLLhvIXt5eUv7d9RZLHGD2TtM275oj6fnCBfC331fg2bCP7rGo1j6mpZzKCE5aNGIeIcYCB5nTeEFQv/2b0NJIhdDB3/+HSAvD/ZMJwSpCgkiR/dV70rU5VDePbLHw6rETTToi/42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6773.namprd11.prod.outlook.com (2603:10b6:806:266::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 17:35:57 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9679:34f7:f1b:1e7c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9679:34f7:f1b:1e7c%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 17:35:57 +0000
Date:   Mon, 5 Jun 2023 10:35:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>,
        Fan Ni <fan.ni@samsung.com>
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Message-ID: <647e1cf4e7e5e_7471a2948f@iweiny-mobl.notmuch>
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
 <20230511175609.2091136-1-fan.ni@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230511175609.2091136-1-fan.ni@samsung.com>
X-ClientProxiedBy: BYAPR07CA0090.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: aa06ab74-cd45-4841-7ff1-08db65eb51ca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6L/RwLtIetu3XxF8zRbYi+rdGaYecGXIwC/7rIznpUaty1iTdeAQZUD4Hp+o0NnNBWWREy8Pl7GQNNz+bDPk1ioEfwHdveheOwimitF0sSPtx2WA0HcbpYL2WAk2mJxiHv07O9uj5xV0JenTOQo+sm1l0j1q4ZdBEReJvvJ8ExI05HKAj3yTWhOVdEX7r7z/hWaWdyElYRHlmgPNDpR6Gv4p3SBarOwJeLO5s0xbFwYA5WEixKkuup55UDrhAQg/rIRaiA2SWT12d6xto4TcJgMlBHnICeUEYamAO61Qu09qSlXWg1G2p2PEyVmgXL6tskNHjHl73z3io3hebKGtZjMZgmvWAsA1hAxc+ApOzD2hVqfLfhC9c5eRP4lIETV1u/fxG6IZYADIjeyo5ic5kgKVlcUtfP5SScjAER3BA+VL0Uo2GQg5nKoYRAiuRdDVQgOuxyHi7f5/N6VSmtkmQ8+ALEzd6SsxL1jRTUgxCSZnSd95BbuPiT6PREYUPGiAllG0PBq0XgOkMDaWewqbbntN/oPQYodvfaz/oOgRWpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(83380400001)(38100700002)(86362001)(82960400001)(478600001)(110136005)(41300700001)(6666004)(6486002)(966005)(54906003)(8936002)(5660300002)(8676002)(44832011)(7416002)(66476007)(66556008)(66946007)(4326008)(2906002)(316002)(26005)(6512007)(6506007)(9686003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NUoJ3//VIjf3dfcw7JsPi2Sb21BvEXU8LoKv7KklFs+cZvI7VxzKwi10T8Zf?=
 =?us-ascii?Q?XFzVjQW/EBSFTBCsvKKAhatlhBJpdjF0I/TpRvX8CFeINcvF0h6F9r3gPF9w?=
 =?us-ascii?Q?vwpTxgXXnMnExAtWUSIoYJJnD3hwH1BDnXmqqk/LNCDmyIS4PK8Tcbumhjx2?=
 =?us-ascii?Q?IEHuQtveJWrFWVi3s4FqlxboWzHz99evgvwajoldMACvhlGm2PaEYpUZqeug?=
 =?us-ascii?Q?UyLCiZeU3qYn7R5VVdn1Lzxz+JY/9T2REuVhb+iCFSd6Dn5nZ/3SfT8wGvvt?=
 =?us-ascii?Q?cgjonB7kUIgiE7Nvt7S+RuypctViEmMqyQYdIYjIk6AKj9mcEIBJ+brrsqhd?=
 =?us-ascii?Q?MA79q9Kjypn+/GuMDyEACNrKxJEVlVP42tAJIV13LhEvgpy/UBClk+QFCcCL?=
 =?us-ascii?Q?hkQvaV3jCKkJHyARbCIiWq0JBfgEiqGYNkk2ajGpYArAiU1JurfXzHZC5i6b?=
 =?us-ascii?Q?1nB8nN3qZMwMYnr4ZcDqGlqOgYZZwXZWHf121lwaycPP4rDhSLhAqt8oOjiM?=
 =?us-ascii?Q?Wm0M8wBTyTepoh2XBlbArKJmX4auFIIO9mnNVgUPl1ZS3H3AnUgQ95qnvt/U?=
 =?us-ascii?Q?gkvTVHC9oF5vaSfLYw0g/nPZeBlxavdlxI8wr894RsXF/X9QYh2QkyvR/wL1?=
 =?us-ascii?Q?HsE8Xy832JQDTLEGjwpgSJenAZquH13wYxbcJC/IkPguELArIq0HxkfmxX0V?=
 =?us-ascii?Q?imZboPpj9vlkjSyViQ8cHXvLIIGPAlGoj+5ouYJMN7/19nSZ65PYC+7eiGQ9?=
 =?us-ascii?Q?eHecrSHFq0yjii6j86wtSka259g/Y4rWzIFLQj3p8KmCPLiV3jENjxdwswTz?=
 =?us-ascii?Q?TFGLY9fjbIM+KDcIrWHxqZyutLKpN9W9oK6lqWfWllTjDSNyUU5lQuurT6wv?=
 =?us-ascii?Q?5i9RMRgEgjU8ymZiJDFHNNWxz3x9cdqOE02NQmHC2Sz8NH8xWCmNhI1RbRAQ?=
 =?us-ascii?Q?67gEreCTlxgpxLPYZHtpCqBCiyPxn3XBHSZVbsYzrKeqvWvQPWc8DcpRoKz+?=
 =?us-ascii?Q?GxlsVAaOx9bcy4JCk0jv+7zxMVyBJEdY9GEKd/wYoWAe8E/e3ryh3y+i4MI7?=
 =?us-ascii?Q?7hNTFBQR4LG/1JkwIyVLS+6LO8PIkv3aUZ0Vw51dQzGxiQOyfHc63CQ5zjhN?=
 =?us-ascii?Q?9GhpNLXVTWVRf6TSRGPiEV3R1Vc0aH8UOPaxydAYFASHET5iJhy6QA8XcAgr?=
 =?us-ascii?Q?nM1rGnbHmNxi2X3VIMRJJkihPqZ8tO/9oRQVVqpyG8dzV0wNXe94gSH+bGpZ?=
 =?us-ascii?Q?EcVESJMrg46jq+gn21WVBNy3L7sNdKCT8korPZfOkzwHzHBmL1oH2zrzx3br?=
 =?us-ascii?Q?lUeALgvpzAmbjFKufLSvfbUbe50LyYKHup71TEi1c9oqrnUgw4dm6MH3UX0p?=
 =?us-ascii?Q?VP3LVwtl+yLS8+dwNq2GYjEpCNwAzMSB2pk8JU3hQhYC1Lin43c8zXEAzBC/?=
 =?us-ascii?Q?9SJsqvmhYbxS3T6K09+wWnNCyzISbguNnuykcMvy+befCqpSeFZFzD3hqPXb?=
 =?us-ascii?Q?pgO+jxdCnbh+6R8EpkMAUPm4+aHM+ftNfemxPgFmkA6W8NRulVmOfiRNE5k3?=
 =?us-ascii?Q?Ef/jXmEHDTIgyLNjgbtnhIWrcGVgNsr4SnqH0pkF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa06ab74-cd45-4841-7ff1-08db65eb51ca
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 17:35:57.1308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ei9QzqQ2fz2RaXxRcjg5UYl5kWrK9xaDNDY+c5hQ+ueWmFPW0gWX9ueKpz9tPaTATxVMBnreDxrfPdeLL3FCyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6773
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fan Ni wrote:
> Since the early draft of DCD support in kernel is out
> (https://lore.kernel.org/linux-cxl/20230417164126.GA1904906@bgt-140510-bm03/T/#t),
> this patch series provide dcd emulation in qemu so people who are interested
> can have an early try. It is noted that the patch series may need to be updated
> accordingly if the kernel side implementation changes.

Fan,

Do you have a git tree we can pull this from which is updated to a more
recent CXL branch from Jonathan?

Thanks,
Ira

> 
> To support DCD emulation, the patch series add DCD related mailbox command
> support (CXL Spec 3.0: 8.2.9.8.9), and extend the cxl type3 memory device
> with dynamic capacity extent and region representative.
> To support read/write to the dynamic capacity of the device, a host backend
> is provided and necessary check mechnism is added to ensure the dynamic
> capacity accessed is backed with active dc extents.
> Currently FM related mailbox commands (cxl spec 3.0: 7.6.7.6) is not supported
> , but we add two qmp interfaces for adding/releasing dynamic capacity extents.
> Also, the support for multiple hosts sharing the same DCD case is missing.
> 
> Things we can try with the patch series together with kernel dcd code:
> 1. Create DC regions to cover the address range of the dynamic capacity
> regions.
> 2. Add/release dynamic capacity extents to the device and notify the
> kernel.
> 3. Test kernel side code to accept added dc extents and create dax devices,
> and release dc extents and notify the device
> 4. Online the memory range backed with dc extents and let application use
> them.
> 
> The patch series is based on Jonathan's local qemu branch:
> https://gitlab.com/jic23/qemu/-/tree/cxl-2023-02-28
> 
> Simple tests peformed with the patch series:
> 1 Install cxl modules:
> 
> modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem
> 
> 2 Create dc regions:
> 
> region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode
> echo 0x10000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> echo 0x10000000 > /sys/bus/cxl/devices/$region/size
> echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> echo 1 > /sys/bus/cxl/devices/$region/commit
> echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> 
> /home/fan/cxl/tools-and-scripts# cxl list
> [
>   {
>     "memdevs":[
>       {
>         "memdev":"mem0",
>         "pmem_size":536870912,
>         "ram_size":0,
>         "serial":0,
>         "host":"0000:0d:00.0"
>       }
>     ]
>   },
>   {
>     "regions":[
>       {
>         "region":"region0",
>         "resource":45365592064,
>         "size":268435456,
>         "interleave_ways":1,
>         "interleave_granularity":256,
>         "decode_state":"commit"
>       }
>     ]
>   }
> ]
> 
> 3 Add two dc extents (128MB each) through qmp interface
> 
> { "execute": "qmp_capabilities" }
> 
> { "execute": "cxl-add-dynamic-capacity-event",
> 	"arguments": {
> 		 "path": "/machine/peripheral/cxl-pmem0",
> 		"region-id" : 0,
> 		 "num-extent": 2,
> 		"dpa":0,
> 		"extent-len": 128
> 	}
> }
> 
> /home/fan/cxl/tools-and-scripts# lsmem
> RANGE                                  SIZE   STATE REMOVABLE   BLOCK
> 0x0000000000000000-0x000000007fffffff    2G  online       yes    0-15
> 0x0000000100000000-0x000000027fffffff    6G  online       yes   32-79
> 0x0000000a90000000-0x0000000a9fffffff  256M offline           338-339
> 
> Memory block size:       128M
> Total online memory:       8G
> Total offline memory:    256M
> 
> 
> 4.Online the momory with 'daxctl online-memory dax0.0' to online the memory
> 
> /home/fan/cxl/ndctl# ./build/daxctl/daxctl online-memory dax0.0
> [  230.730553] Fallback order for Node 0: 0 1
> [  230.730825] Fallback order for Node 1: 1 0
> [  230.730953] Built 2 zonelists, mobility grouping on.  Total pages: 2042541
> [  230.731110] Policy zone: Normal
> onlined memory for 1 device
> 
> root@bgt-140510-bm03:/home/fan/cxl/ndctl# lsmem
> RANGE                                  SIZE   STATE REMOVABLE BLOCK
> 0x0000000000000000-0x000000007fffffff    2G  online       yes  0-15
> 0x0000000100000000-0x000000027fffffff    6G  online       yes 32-79
> 0x0000000a90000000-0x0000000a97ffffff  128M  online       yes   338
> 0x0000000a98000000-0x0000000a9fffffff  128M offline             339
> 
> Memory block size:       128M
> Total online memory:     8.1G
> Total offline memory:    128M
> 
> 5 using dc extents as regular memory
> 
> /home/fan/cxl/ndctl# numactl --membind=1 ls
> CONTRIBUTING.md  README.md  clean_config.sh  cscope.out   git-version-gen
> ndctl	       scripts	test.h      version.h.in COPYING		 acpi.h
> config.h.meson   cxl	  make-git-snapshot.sh	ndctl.spec.in  sles	tools
> Documentation	 build	    contrib	     daxctl	  meson.build		rhel
> tags	topology.png LICENSES	 ccan	    cscope.files
> git-version  meson_options.txt	rpmbuild.sh    test	util
> 
> 
> QEMU command line cxl configuration:
> 
> RP1="-object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=512M \
> -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=512M \
> -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=512M \
> -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,dc-memdev=cxl-mem2,id=cxl-pmem0,num-dc-regions=1\
> -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k"
> 
> 
> Kernel DCD support used to test the changes
> 
> The code is tested with the posted kernel dcd support:
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.5/dcd-preview
> 
> commit: f425bc34c600e2a3721d6560202962ec41622815
> 
> To make the test work, we have made the following changes to the above kernel commit:
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 5f04bbc18af5..5f421d3c5cef 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
>  	CXL_CMD(GET_DC_EXTENT_LIST, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_CMD(GET_DC_CONFIG, 0x2, CXL_VARIABLE_PAYLOAD, 0),
>  };
>  
>  /*
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 291c716abd49..ae10e3cf43a1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -194,7 +194,7 @@ static int cxl_region_manage_dc(struct cxl_region *cxlr)
>  		}
>  		cxlds->dc_list_gen_num = extent_gen_num;
>  		dev_dbg(cxlds->dev, "No of preallocated extents :%d\n", rc);
> -		enable_irq(cxlds->cxl_irq[CXL_EVENT_TYPE_DCD]);
> +		/*enable_irq(cxlds->cxl_irq[CXL_EVENT_TYPE_DCD]);*/
>  	}
>  	return 0;
>  err:
> @@ -2810,7 +2810,8 @@ int cxl_add_dc_extent(struct cxl_dev_state *cxlds, struct resource *alloc_dpa_re
>  				dev_dax->align, memremap_compat_align()))) {
>  		rc = alloc_dev_dax_range(dev_dax, hpa,
>  					resource_size(alloc_dpa_res));
> -		return rc;
> +		if (rc)
> +			return rc;
>  	}
>  
>  	rc = xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_dax, GFP_KERNEL);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 9e45b1056022..653bec203838 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -659,7 +659,7 @@ static int cxl_event_irqsetup(struct cxl_dev_state *cxlds)
>  
>  	/* Driver enables DCD interrupt after creating the dc cxl_region */
>  	rc = cxl_event_req_irq(cxlds, policy.dyncap_settings, CXL_EVENT_TYPE_DCD,
> -					IRQF_SHARED | IRQF_ONESHOT | IRQF_NO_AUTOEN);
> +					IRQF_SHARED | IRQF_ONESHOT);
>  	if (rc) {
>  		dev_err(cxlds->dev, "Failed to get interrupt for event dc log\n");
>  		return rc;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 6ca85861750c..910a48259239 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -47,6 +47,7 @@
>  	___C(SCAN_MEDIA, "Scan Media"),                                   \
>  	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
>  	___C(GET_DC_EXTENT_LIST, "Get dynamic capacity extents"),         \
> +	___C(GET_DC_CONFIG, "Get dynamic capacity configuration"),         \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> 
> 
> 
> Fan Ni (7):
>   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
>     payload of identify memory device command
>   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
>     and mailbox command support
>   hw/mem/cxl_type3: Add a parameter to pass number of DC regions the
>     device supports in qemu command line
>   hw/mem/cxl_type3: Add DC extent representative to cxl type3 device
>   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
>     dynamic capacity response
>   Add qmp interfaces to add/release dynamic capacity extents
>   hw/mem/cxl_type3: add read/write support to dynamic capacity
> 
>  hw/cxl/cxl-mailbox-utils.c  | 389 +++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          | 492 +++++++++++++++++++++++++++++++-----
>  include/hw/cxl/cxl_device.h |  50 +++-
>  include/hw/cxl/cxl_events.h |  16 ++
>  qapi/cxl.json               |  44 ++++
>  5 files changed, 924 insertions(+), 67 deletions(-)
> 
> -- 
> 2.25.1


