Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2694EB64DC
	for <linux-cxl@archiver.kernel.org>; Tue, 27 Jun 2023 20:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjF0Uw7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 27 Jun 2023 16:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjF0Uwz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 27 Jun 2023 16:52:55 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2071.outbound.protection.outlook.com [40.92.107.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7ED2D53
        for <linux-cxl@vger.kernel.org>; Tue, 27 Jun 2023 13:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmWkxzWlJRLl7c344STgd/oA42XFYUIi86tJzQjLiaZE1L5ob8vKb9fBTuLlOfgLbLBA69rCtxLfph6VXSuxsJz4uNIW+L5jIoCn83HpwPoT/uGHWrSTrzGersvgKoLghyeiR5djcEfSe1GbHsWi93fOYhHOCXRjhQVMirr0zXj6KIhusMWrJzvmoqg9T433gpayLcJzWDizpm2YOV51FAL16Eua/iIDGJewv3FQ34j75L/WuM/JA8AeWiBxdfbTG4K6iW1nAZzgOEk2Wr1sSDTAbMp/f9ASL2HgpGrbAeWgqcXcmYFxuQ0STr+NOAIhwmYtnn0f5gTF/6591Y8AWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkK52er+SV68jxT7K1+niT1C6qy93CapmraJbO4fHB8=;
 b=PK2igGtxWI2eJxUo2eIe5Obhb2ovsUjp7Sw1gWUZ8qsprT56uu3xaswnvrcBGKTuCtdsLljq/MCx9B2skEKfcOkqjt6pNKu3Eca0lGVWWqf3USoHSJU+0+c+lz3BuHE/BoCMZ/vCPVm5Qgp531GdZH5YiY5p0j3PrcDrwwUoi+Wcgmvsw1/7VLPy7tUVNMYSSDbKm9WQMdLauWGShsLlTpzRbAEpjL46RDs7pW3aMlDPl6HkzBDPMAFWHni5KIXM3tmVgGKQ1yDqnMEaX3XCrM8EBNg048lTCesybYotLgM0Y0HpIo66xVGRo2tw3F1aJR40X/ftZYilmeMtlEdnag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkK52er+SV68jxT7K1+niT1C6qy93CapmraJbO4fHB8=;
 b=gIdxgsAR6FpNfy55P47XK7k8kUkDf4V2uBNWVv5Vt2aeQ7hXg9UQi7bSVOqdIvugp7SmOPSqQ/OrVq+uIYjg1c0GGjFgrEy6rzXWOBm1UhRYANWLlrrSPl9mxN2o2zBdhylSXYT2LDH5u0NCmpPmXAtN0YrkeXRF0TdXpvoOS+4t516PX8jpHHuCxwb3x+nq0N4RmBLGLDz/N8e0Q7z7jDZE5gek5DqaLJ/gti64thWaBg7ZgLhyH5jJ+kWoSOtKEOf90pVr759u68FlQ4lqrFMAR3dry1mUpkG4Wno/hHdFgOHVmxW8nqu1xAFdwBC4SAUrzRKiJgRYzNBp6z+lXA==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 TY0PR06MB5777.apcprd06.prod.outlook.com (2603:1096:400:270::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 20:52:43 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 20:52:43 +0000
Date:   Tue, 27 Jun 2023 13:52:25 -0700
From:   "nifan@outlook.com" <nifan@outlook.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        navneet.singh@intel.com
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Message-ID: <SG2PR06MB33970B719515271CBD0303E5B227A@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
 <20230511175609.2091136-1-fan.ni@samsung.com>
 <20230515140036.00003301@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515140036.00003301@Huawei.com>
X-TMN:  [zmaMoHEcKn88ne3C8Ry6azTK7V8N6grK]
X-ClientProxiedBy: CH2PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:610:5a::11) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZJtMCRxJCuFmmS/d@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|TY0PR06MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ac0abd-5852-4835-ae38-08db775073c1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0thiMGx7a2vjkNnLCsEZh8v5pq1Zzbb9wKIsY1sCGbWf3o+PVqPkhDu08OLPfXneV1g0bAUTqqMDnqlYEpveTtjIE+nRgzqLtJQjx/i426nZRe7KT7xbDOY3NqM8kx7ddUiX+7HNxJnolG4uoX0dA0KfV1C7pZxogmJ9+EapqX2zvAlDLNDSxEO5ULaIULzTLrfYMLGIZEgVC0zmpAG+tM5fy3mnGvOI4Ttg5lzymNd45pfwHzMtyYkVK7TZA+beeedr7ioZXnkXrw3DN+kUrv6QrpbR5Yx1uNFkbfhlpkC5rVA6aXCZGsNFrpzaAzuOg5wZP4g+rnhqGvG44wr85wZfN9I3dyLusmSmqjfWd9Vs5vv5wcUOEM46xBZpAfgMrHKmZZRFK2DR260yxDZKogYq+hntuOHY7B6WweUL14K/KmDMhHWE3pU6yY7em68QYyAhDvjCSvpcqsh0WHmxOZLdDFoU7pyyPlswnj712Ig3VMa6yN8zPXaoU/xnABd+zwybf8RXpBsUtcxpQMyk8Tnnoev6hYiSjqgMm2THA4fF0fJXJR9x+5qcrnGrd4KSG07IqDnBevsKwrx+cVtVg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE1CVWVHdE0rMDJvZm9ESkVnOHBxZ2lFM1hBUHEvU2lYbVZRcDNkMVduL1Vn?=
 =?utf-8?B?ZWVxRkp5aTllMTNPRCtac3VleEswVElNdXY1bGtCb2dtRUM1ZE1PL0F4OWVB?=
 =?utf-8?B?R2lzVzlLVEg1Vm95NjliVzR1cDMzQks3US9BVFhJL2JuRFJqMWlSbUo5eWFm?=
 =?utf-8?B?VkhmeFQ0K2tTdmVIYnNRclNrOXhhcDhKM1VHdVRDOWx4MTUySDJZSVJFclo0?=
 =?utf-8?B?cUNtd3hVYUJTRk8yWk9JN3kxeE5tcmFFQUVTaGthdzV3U3p1d1dyRkpEZHp5?=
 =?utf-8?B?U1FIWlVtRjcxTnBHcUk4ZlRqNVRnM1gzMmM1WnEweFluTmxhSXZrVVpackg2?=
 =?utf-8?B?SXlydjhsSzM5V2kvdm9ROXV5dHF4cm04L1VBcWhtQ0VWSHZPS01wK0lxOUox?=
 =?utf-8?B?Q0NXSkt4NVQrVW9SOWxvQUdERDBkUHErOElsTW1nblp0aVhnWldhTERHSWRq?=
 =?utf-8?B?Z2FGYnRXWDdrYkMzbFg4Ym5aQWpVUnl2a1pUR2xXUklUdDBjaFpJTmpHMU5m?=
 =?utf-8?B?Q0huT053WWhManhHb0o2VHhnUzl5SEUrTjRpOHgrM3psQmpXaXhqeFRQZFdl?=
 =?utf-8?B?ZlU5Wnc1NzVuZy9WWkUwTE9sR01JZTBzYlMrV0QwYlhXcXNoeUtZQ29ZOGNY?=
 =?utf-8?B?aGNKZHJSNHFuWm5aUmQwSzhzSllNZmVhbjAyZDNDeDdNaEVpempEMElqQUJL?=
 =?utf-8?B?RkNOdVJad1VOelNHSjljbEF6Z0lnVHhDbHJFOGJZU0gxUjBUU0ppMXVDSE9y?=
 =?utf-8?B?M2JqREk4UTFEYkxNbVMvV1luZFRGTWRPd3l6WDBmVGlCYzhtcHJsUm5iWXJl?=
 =?utf-8?B?T3BUeUYrK2I4Mlo0aFgrRE80TWp6c0RZRCtPaDg0aVZQaUMxTFhDaVZuWHRy?=
 =?utf-8?B?UVdoSXdrU2JneTEzbUwvVHd6cUVnMGl3YlpOU0Jra0tOQ1JGclI1cmJ3V0tL?=
 =?utf-8?B?R29iOThiR2ZuVFJ3R1M2aFh1ZmRCMjllOTEralVHOUw4ekw5dlJGTHMvY0RX?=
 =?utf-8?B?d25rTGtVZTkydFdjYWRNN2g2dkE1bktCbmZQZXZMcENkNzU1NlNMMXdCUnUy?=
 =?utf-8?B?QmJqTFlSckRVbEN0UE5rQ2RjcVB4WFJaWHA1bW0xbGswZGZSNENyNDhrZXJt?=
 =?utf-8?B?SEpwZ3poME5HNWNURFRDWjNHazVyYm9mUmp0TFNjRE1YL3VmRWt1QzZoTzRB?=
 =?utf-8?B?elp2YkcrclBBTndVMDl3cjRBMVJJZDJldnRzaVFWRkdHM2ppRFZEU1hlUnV0?=
 =?utf-8?B?V2ZQTTl1OTgyNjdtWVRZa01qd1U0UEdSVHI0OUNRT0V5Sk8yV0NGMnlKREZE?=
 =?utf-8?B?QjJYeHFwa0tTTWJPT0J1VGxUT2EvYlY2dWlIOGxIM1IvSnFOdFRrK1YvMXMz?=
 =?utf-8?B?c1RjZmFMVmdlVTBqN3RoOWZvMUdiRTJXRDl6TnNzZXBFNUlJR2lnZXRoV0hN?=
 =?utf-8?B?Qkh4L1NRVjQ2ejZxak4vYUhCU1dhTU1ocVBRWG5JclJ2aTM0RDhkMWl1Tytn?=
 =?utf-8?B?MUpPa2pWOHMwbWx6NGFnYlJCM2tIL2I0SlB0VmlLeitYbDJFY2FJSTV0MnBN?=
 =?utf-8?B?ZDZ3UmprcW5haWRLT0poQjlUR3NWRElreldLaCtjSEdqUlRSajdIdjY1NWV1?=
 =?utf-8?B?UzJuTGdIbWUzK2NjRm9xMmtCajZvbnc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ac0abd-5852-4835-ae38-08db775073c1
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 20:52:43.2035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5777
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 05/15/2023 14:00, Jonathan Cameron wrote:
> On Thu, 11 May 2023 17:56:40 +0000
> Fan Ni <fan.ni@samsung.com> wrote:
> 
> > Since the early draft of DCD support in kernel is out
> > (https://lore.kernel.org/linux-cxl/20230417164126.GA1904906@bgt-140510-bm03/T/#t),
> > this patch series provide dcd emulation in qemu so people who are interested
> > can have an early try. It is noted that the patch series may need to be updated
> > accordingly if the kernel side implementation changes.
> > 
> > To support DCD emulation, the patch series add DCD related mailbox command
> > support (CXL Spec 3.0: 8.2.9.8.9), and extend the cxl type3 memory device
> > with dynamic capacity extent and region representative.
> > To support read/write to the dynamic capacity of the device, a host backend
> > is provided and necessary check mechnism is added to ensure the dynamic
> > capacity accessed is backed with active dc extents.
> > Currently FM related mailbox commands (cxl spec 3.0: 7.6.7.6) is not supported
> > , but we add two qmp interfaces for adding/releasing dynamic capacity extents.
> > Also, the support for multiple hosts sharing the same DCD case is missing.
> > 
> > Things we can try with the patch series together with kernel dcd code:
> > 1. Create DC regions to cover the address range of the dynamic capacity
> > regions.
> > 2. Add/release dynamic capacity extents to the device and notify the
> > kernel.
> > 3. Test kernel side code to accept added dc extents and create dax devices,
> > and release dc extents and notify the device
> > 4. Online the memory range backed with dc extents and let application use
> > them.
> > 
> > The patch series is based on Jonathan's local qemu branch:
> > https://gitlab.com/jic23/qemu/-/tree/cxl-2023-02-28
> > 
> > Simple tests peformed with the patch series:
> > 1 Install cxl modules:
> > 
> > modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem
> > 
> > 2 Create dc regions:
> > 
> > region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> > echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> > echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> > echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> > echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode
> > echo 0x10000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> > echo 0x10000000 > /sys/bus/cxl/devices/$region/size
> > echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> > echo 1 > /sys/bus/cxl/devices/$region/commit
> > echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> > 
> > /home/fan/cxl/tools-and-scripts# cxl list
> > [
> >   {
> >     "memdevs":[
> >       {
> >         "memdev":"mem0",
> >         "pmem_size":536870912,
> >         "ram_size":0,
> >         "serial":0,
> >         "host":"0000:0d:00.0"
> >       }
> >     ]
> >   },
> >   {
> >     "regions":[
> >       {
> >         "region":"region0",
> >         "resource":45365592064,
> >         "size":268435456,
> >         "interleave_ways":1,
> >         "interleave_granularity":256,
> >         "decode_state":"commit"
> >       }
> >     ]
> >   }
> > ]
> > 
> > 3 Add two dc extents (128MB each) through qmp interface
> > 
> > { "execute": "qmp_capabilities" }
> > 
> > { "execute": "cxl-add-dynamic-capacity-event",
> > 	"arguments": {
> > 		 "path": "/machine/peripheral/cxl-pmem0",
> > 		"region-id" : 0,
> > 		 "num-extent": 2,
> > 		"dpa":0,
> > 		"extent-len": 128
> > 	}
> > }
> > 
> > /home/fan/cxl/tools-and-scripts# lsmem
> > RANGE                                  SIZE   STATE REMOVABLE   BLOCK
> > 0x0000000000000000-0x000000007fffffff    2G  online       yes    0-15
> > 0x0000000100000000-0x000000027fffffff    6G  online       yes   32-79
> > 0x0000000a90000000-0x0000000a9fffffff  256M offline           338-339
> > 
> > Memory block size:       128M
> > Total online memory:       8G
> > Total offline memory:    256M
> > 
> > 
> > 4.Online the momory with 'daxctl online-memory dax0.0' to online the memory
> > 
> > /home/fan/cxl/ndctl# ./build/daxctl/daxctl online-memory dax0.0
> > [  230.730553] Fallback order for Node 0: 0 1
> > [  230.730825] Fallback order for Node 1: 1 0
> > [  230.730953] Built 2 zonelists, mobility grouping on.  Total pages: 2042541
> > [  230.731110] Policy zone: Normal
> > onlined memory for 1 device
> > 
> > root@bgt-140510-bm03:/home/fan/cxl/ndctl# lsmem
> > RANGE                                  SIZE   STATE REMOVABLE BLOCK
> > 0x0000000000000000-0x000000007fffffff    2G  online       yes  0-15
> > 0x0000000100000000-0x000000027fffffff    6G  online       yes 32-79
> > 0x0000000a90000000-0x0000000a97ffffff  128M  online       yes   338
> > 0x0000000a98000000-0x0000000a9fffffff  128M offline             339
> > 
> > Memory block size:       128M
> > Total online memory:     8.1G
> > Total offline memory:    128M
> > 
> > 5 using dc extents as regular memory
> > 
> > /home/fan/cxl/ndctl# numactl --membind=1 ls
> > CONTRIBUTING.md  README.md  clean_config.sh  cscope.out   git-version-gen
> > ndctl	       scripts	test.h      version.h.in COPYING		 acpi.h
> > config.h.meson   cxl	  make-git-snapshot.sh	ndctl.spec.in  sles	tools
> > Documentation	 build	    contrib	     daxctl	  meson.build		rhel
> > tags	topology.png LICENSES	 ccan	    cscope.files
> > git-version  meson_options.txt	rpmbuild.sh    test	util
> > 
> > 
> > QEMU command line cxl configuration:
> > 
> > RP1="-object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=512M \
> > -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=512M \
> > -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=512M \
> > -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> > -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> > -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,dc-memdev=cxl-mem2,id=cxl-pmem0,num-dc-regions=1\
> > -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k"
> > 
> > 
> > Kernel DCD support used to test the changes
> > 
> > The code is tested with the posted kernel dcd support:
> > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.5/dcd-preview
> > 
> 
> Very nice!  +CC Navneet who may want to comment on the below (and the
> emulation as well)
> 
> I've not had a chance to look at the code on the kernel side yet.

Thanks Jonathan for all the comments for the series, will reflect them
in the next version.

Fan

> 
> 
> > commit: f425bc34c600e2a3721d6560202962ec41622815
> > 
> > To make the test work, we have made the following changes to the above kernel commit:
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 5f04bbc18af5..5f421d3c5cef 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> >  	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
> >  	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> >  	CXL_CMD(GET_DC_EXTENT_LIST, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> > +	CXL_CMD(GET_DC_CONFIG, 0x2, CXL_VARIABLE_PAYLOAD, 0),
> >  };
> >  
> >  /*
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 291c716abd49..ae10e3cf43a1 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -194,7 +194,7 @@ static int cxl_region_manage_dc(struct cxl_region *cxlr)
> >  		}
> >  		cxlds->dc_list_gen_num = extent_gen_num;
> >  		dev_dbg(cxlds->dev, "No of preallocated extents :%d\n", rc);
> > -		enable_irq(cxlds->cxl_irq[CXL_EVENT_TYPE_DCD]);
> > +		/*enable_irq(cxlds->cxl_irq[CXL_EVENT_TYPE_DCD]);*/
> 
> Some race condition that means we need to enable the DCD event earlier?
> 
> >  	}
> >  	return 0;
> >  err:
> > @@ -2810,7 +2810,8 @@ int cxl_add_dc_extent(struct cxl_dev_state *cxlds, struct resource *alloc_dpa_re
> >  				dev_dax->align, memremap_compat_align()))) {
> >  		rc = alloc_dev_dax_range(dev_dax, hpa,
> >  					resource_size(alloc_dpa_res));
> > -		return rc;
> > +		if (rc)
> > +			return rc;
> 
> No idea on this one as it's in the code I haven't looked at yet!
> 
> >  	}
> >  
> >  	rc = xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_dax, GFP_KERNEL);
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 9e45b1056022..653bec203838 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -659,7 +659,7 @@ static int cxl_event_irqsetup(struct cxl_dev_state *cxlds)
> >  
> >  	/* Driver enables DCD interrupt after creating the dc cxl_region */
> >  	rc = cxl_event_req_irq(cxlds, policy.dyncap_settings, CXL_EVENT_TYPE_DCD,
> > -					IRQF_SHARED | IRQF_ONESHOT | IRQF_NO_AUTOEN);
> > +					IRQF_SHARED | IRQF_ONESHOT);
> 
> This will be otherside of the removal of the enable above.
> 
> >  	if (rc) {
> >  		dev_err(cxlds->dev, "Failed to get interrupt for event dc log\n");
> >  		return rc;
> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > index 6ca85861750c..910a48259239 100644
> > --- a/include/uapi/linux/cxl_mem.h
> > +++ b/include/uapi/linux/cxl_mem.h
> > @@ -47,6 +47,7 @@
> >  	___C(SCAN_MEDIA, "Scan Media"),                                   \
> >  	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
> >  	___C(GET_DC_EXTENT_LIST, "Get dynamic capacity extents"),         \
> > +	___C(GET_DC_CONFIG, "Get dynamic capacity configuration"),         \
> >  	___C(MAX, "invalid / last command")
> >  
> >  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> > 
> > 
> > 
> > Fan Ni (7):
> >   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> >     payload of identify memory device command
> >   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
> >     and mailbox command support
> >   hw/mem/cxl_type3: Add a parameter to pass number of DC regions the
> >     device supports in qemu command line
> >   hw/mem/cxl_type3: Add DC extent representative to cxl type3 device
> >   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
> >     dynamic capacity response
> >   Add qmp interfaces to add/release dynamic capacity extents
> >   hw/mem/cxl_type3: add read/write support to dynamic capacity
> > 
> >  hw/cxl/cxl-mailbox-utils.c  | 389 +++++++++++++++++++++++++++-
> >  hw/mem/cxl_type3.c          | 492 +++++++++++++++++++++++++++++++-----
> >  include/hw/cxl/cxl_device.h |  50 +++-
> >  include/hw/cxl/cxl_events.h |  16 ++
> >  qapi/cxl.json               |  44 ++++
> >  5 files changed, 924 insertions(+), 67 deletions(-)
> > 
> 

-- 
Fan Ni <nifan@outlook.com>
