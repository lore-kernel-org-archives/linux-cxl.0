Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5D7C7618E
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 21:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjDUV2Z (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 17:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjDUV2Y (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 17:28:24 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2080.outbound.protection.outlook.com [40.92.107.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCFC1FF0
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 14:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjkA4p9QAtlLSO9RRWoQqssfUhbVhysOOB2fqeoxWzvUo+0zyIJkvVRKI8ETlMmPWMezJWVpf8CxJywG5qapoiTocz4HCVleuAXeXXB42jdr4SBjrupuMb15rFa4iCrLC094Ngvc3tA7kIsqfwKSaKsYTn25/6UkSyx0Ku6RHuET/QXATtBWegVFqyAied0wXiG46zHMlv7FwqCq2tPZJr2aXYznuAZ8r673YGTtVQwvHAUiXPQ7PWxoxDteFmHnXO1Lkng/GQs30DaQi4TY9D8IVSAVEtQNtCh1+IM6k2mfVp1N8iPfVKxUQqc3nGbXFHHMth+aPfxNo8Ukaphgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuAmqsItmsGQRZRf9pTeixQ3ySJGGJV+RGKqI+al9Rc=;
 b=d+3sm+pr5lbHHO42tn5Ppqk+LFQzTLAjMFwSVthXDU079VV9nlNNLBJ6iNbts9vldVfJsWfa9UCDGCxzRB7wVWbARtqZ7f3Mus9zahuNISyfdsNJxNjuFwW2HzZa71B2IcMkxVJIqPOIT9ObxIEFW06I1tSsAUnICNluFrsbnUfafw6pQuejhXnTjPO0IvP/KEs/jkgfiTZEf4seQGSZM6Cw+i6oDzo2qAIoF7gWpUvWPaLYFF68PJ/MHffQNh8CVyAfEPUUSb6GKApWF+nOHOLgGzFshCndxeG48VtRjlsdWDWp60tQved57ddvCiBknq4+Ev2x3ARGEm9KLEx9vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuAmqsItmsGQRZRf9pTeixQ3ySJGGJV+RGKqI+al9Rc=;
 b=tExxtnJlR6nUIoeHeVYCZIfnihEuPCAjRPZ7Uovdt0edNRCDLlymqjW9rpPMtgUJ+kIug/0Xh/0vpwJuL2B/30OoNbdHP2mTcd4aVFf/fQUlW/MOfEJFsDwDU6Ifiimsnfw8jb30tNAi7mHO6b0cP6HdwshYqgJt2iLq+zP6vjUNCOi0hkffMQnW4u+rqbwJ/Gm1f9myhO//Y6aJhJnaaXYfkWsyp8iA6obptQjZbsPHTjemsiUSCsSibSRYt0E6PDxhUP4iwwKDiIaAG/b//IgIkPGDyIwIuoMaA18rppR56Vq1/sWs+D5IidV8xekxmAG5Mywq5fGCwvz/DcFOcQ==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 TYZPR06MB4238.apcprd06.prod.outlook.com (2603:1096:400:82::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Fri, 21 Apr 2023 21:28:17 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::c0bd:8353:f30:aa5c]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::c0bd:8353:f30:aa5c%2]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 21:28:17 +0000
Date:   Fri, 21 Apr 2023 14:28:02 -0700
From:   "nifan@outlook.com" <nifan@outlook.com>
To:     Fan Ni <fan.ni@samsung.com>, gregory.price@memverge.com,
        Jonathan.Cameron@huawei.com
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "navneet.singh@intel.com" <navneet.singh@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>
Subject: Re: "release early" preview of DCD enabling
Message-ID: <SG2PR06MB33971CF6D06031351D4D5745B2609@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <64326437c1496_934b2949f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZDWVkJKVThJzhMzM@memverge.com>
 <20230414130414.00007c88@Huawei.com>
 <CGME20230417164134uscas1p1a279ed4d3e5ebe9fa95aef849f2c560b@uscas1p1.samsung.com>
 <20230417164126.GA1904906@bgt-140510-bm03>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230417164126.GA1904906@bgt-140510-bm03>
X-TMN:  [22bj9EqM/oQNIl13sME7NuEmnR3RfC3B]
X-ClientProxiedBy: SJ0PR05CA0201.namprd05.prod.outlook.com
 (2603:10b6:a03:330::26) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZEL/4pFvzlzYmMTA@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|TYZPR06MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5fcd87-1c6f-48b1-a72b-08db42af51f9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyBevLpE3WOScEld2xAXarGylso1f3QH4dq/NA/lPNRrv9jQmL6MIHoHQQdfq15QcVP6OeWXiwGv6JV33ZNbnb7XFgNKe9krfnMEGmzQ2AxgZTiD1AjWF9+QADM/M24Bx9uKF1XOGTtvlSOAS2WkJObXZBMxfX9KQ6fub+379co6SzdeVYbSpUnGWL0wqHhKmAHvCTIbj/IdvdZUBc6WBsozyZ+PAZyuPF+LL8hx9XSZOBdfG0pahfWZ6aETPuMDYxsqYzwYzhAm0S3N9T5ka4e/Ok1pER4eclJY3ZHVaBqP18tlAohZJxcHh/M5Ecf85NrZMGxq+xhjo962O4aoAF156NrAufXUcgEfFKJWCQh1CMnzDvKHhYFM4GSujjLTkK1Pyb+bZnVFZkRiGb0jtgG45Hd5spculMkIYFllr1ARd1s1pbJI7xUpFu+LLZZ8OM9EzEqk2LgVnviWR3kzF1R6K5rN0sikZf9U67gzJCb7Xrbw/PWRf+L9Bv3FIc5fGmP3s9FBD2ZvIXC23usxpdDjDtCqmUxrNsvpS75llboRaZVS/Xz/aAI61jmXwz38UJTxhcsn1pghIKk3YAW/foBHb+k1dDe+HVua1SasHtFMD0SEN1HfQ6u8imgI7f84mtTxNw5KWYYiQff74+xwZw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFVWeU5tK3ZyK2N4WUF2ai94dExCeU9zL1FsTGFkQVFrck44d0ZYend2MmUy?=
 =?utf-8?B?cHY4NVFnbE1vTWRNZzdic0RDL1I3N2M5L1h6Z09ESU9FUDBTaVAycWNmdDNG?=
 =?utf-8?B?K1Y5ZXY4M240TVVOQzlUMmRhbnFGVXZkOW9UL3lhZ1VGdXJOZ3hqaUVhVU5F?=
 =?utf-8?B?SFhJTk1FUnZhZndwdTB3MGZtcUdnWGI5NDQvSUZvUWFaem83VW9CYlVYUjZC?=
 =?utf-8?B?cDdaUURrb0NJQjFVdEdwTm5YSGxSeEoyMDE4cml4bkNydU5kUWZtdXlRMGNj?=
 =?utf-8?B?VXpSYjVGeFYzZDhEd24rKzZUVi9KbXh5QThWTnRNQXVvUnprRVVreGVpTkRM?=
 =?utf-8?B?VXFxampYZU1pUTBSbXdFNXR5VVBxeFVjaytvQjI2RkxySjd6RElteWtnZDFy?=
 =?utf-8?B?cnIrM2VMTHh0cUtNWUdLL0JNZDVRTGFucmhzS2tRV1ZXTFJnaU5YQit6bC8x?=
 =?utf-8?B?bGJHcTRwSkhpNFYvMnUyLzM1NTNXQTkvY1Nrb3VyeVJNWVVZcDI2cE43Qmdi?=
 =?utf-8?B?bUVDZUNoZElxN1V4TlBsTFMzZklPOXFTVExVVnU4TTJiQUlvTHNXdEZacDJT?=
 =?utf-8?B?N0NINTV0YW5PNUllU2dDdnc0OTBxTVZBRkp4Z2dtMzNpT1ZQQ2ZZelBaRW1t?=
 =?utf-8?B?RmRvSTNkTjBJU3NJYVdtdjMyQVdVek5acjJrZVVmWkZ5OXdxUTcwRXowZ0t2?=
 =?utf-8?B?a3hCclhjY2JndXRFZFkyYzFKR1FRZEVPb01RMHkvcmRNSVhBYmlGWWFwbGt3?=
 =?utf-8?B?blZmbDJOVlNCcC9pQkpGWnZlSHpVUkFrcTlZWjlVWkpMNjZ4SVoxV3BYUVhi?=
 =?utf-8?B?NXJIOThGUHhCMThUdC9PQU9CblVvVkh1SmZBVGRkNGR3VW5TTDNObTMza3lK?=
 =?utf-8?B?amJHL0FlMFVjZXR2cURiTjdZY3FJcFlZY2JQeWt1RmpwMTQ5NHRiYzI4blJS?=
 =?utf-8?B?WFN4eUpxZjZ3NzByTEpqS0NDRldCeXVEanBDRjE0T0VwL3ZXRUIwODRxY0Y3?=
 =?utf-8?B?RkdGOVVrZTduWWdWcEFobVEzUjQ4Q3VIQ2VsQVhSR3NBL2ZCbDl1SXVBRHRH?=
 =?utf-8?B?RktUa3B1UUZOaGNPdnJ5OFBpNWFzdmx6VkpwMnJqT0lGUFhBckp4USs2V3lh?=
 =?utf-8?B?OWp2VEFDMURlUUIyZVdUaHViN2lJN0ZZaHFQTW5WSXhvREtKK3JoTk1xeUF4?=
 =?utf-8?B?R3ZLMVpDaExHcDZ6NFZhdTIyZzRZeFVvcHBoNE1xS2NFN2phNEFxVVRvOUhQ?=
 =?utf-8?B?S0VtYTNUUGx1bjdnRjQycEdLMkdoUW10eHg5MHdTNzkyaXlQWjgrR2t5RkxZ?=
 =?utf-8?B?SEs2TlJpbWNxajZOUkwxSFZDUkx4emgwSStqS0krL0FiWHR3S2hORTkvcW11?=
 =?utf-8?B?WTVNaXlPaGhOSU5BYTRiSm4vT0t3bk1xa1NyWjYydlhXcWRYYTNVRlQ4WlRi?=
 =?utf-8?B?clFVaUpqWUFiczYrOHJaUDhoU3V4ZFh3bmZ1MGFuVk1CUnljZDdRSmo4NW9Q?=
 =?utf-8?B?RDVnczE0TnkzQmNON0l1dXN0ZnI0R0V5YnZrbTlHK2xuSHZVYXRlSmtqNlRo?=
 =?utf-8?B?eFpCZWdNbkt3STFTbDJkQ0lidEZzVUZkcjVBeklFUEVMSlVrK1htUmRJemhB?=
 =?utf-8?B?QWFmYUlVQkVKclhscG1PdEh4YmpXdWc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5fcd87-1c6f-48b1-a72b-08db42af51f9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 21:28:17.0180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4238
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Since my last post, I updated the code, and it can do some simple
end-to-end dcd test with kernel dcd support.

See below for more details.

The 04/17/2023 16:41, Fan Ni wrote:
> On Fri, Apr 14, 2023 at 01:04:14PM +0100, Jonathan Cameron wrote:
> 
> > On Tue, 11 Apr 2023 13:14:56 -0400
> > Gregory Price <gregory.price@memverge.com> wrote:
> > 
> > > On Sun, Apr 09, 2023 at 12:07:36AM -0700, Dan Williams wrote:
> > > > Here is an early draft of the DCD work that Navneet has spearheaded.
> > > > Given the interest level I thought it best to do the remaining
> > > > development and refinement of the functionality in the open.  For now
> > > > this is just a git branch that will become a patchkit on the mailing
> > > > list in a few weeks.
> > > > 
> > > > Questions are welcome, but I do not recommend a formal review until the
> > > > patches hit the mailing list.
> > > > 
> > > > This has had some checkout on an internal functional model, I expect
> > > > QEMU and/or cxl_test grows an emulation of DCD before this patchkit is
> > > > committed for mainline.
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.5/dcd-preview  
> > > 
> > > Awesome!
> > > 
> > > for the QEMU folks, has anyone be actively working on a DCD device? I
> > > was going to start looking at it, but didn't want to duplicate work.
> > 
> > Not that I know of.  Was thinking I might hack some of it together, but
> > not gotten to it yet. 
> > 
> > For and end goal I think we want:
> > 
> > a) Add all the config stuff for DCD regions - perhaps hardcode one initially.
This subtask is there in my code.
> > b) Device that generates DCD events (don't care on interface to make them happen but maybe start
> >    with QMP similar to injection interfaces).
Two QMP interfaces are added to add/release dc extents. At the this
time, we keep the interface as simple as possible to do the work.
> > c) Device that maps the DCD extents through to doing the correct read and write behavior for
> >    reads that aren't in DCD extents.
Not implemented yet. 
> > d) A standards based way to poke the FM-API. Tunneling and / or MCTP CCIs
Not touched yet. 
> > 
> > 
> > Can probably split this up though so if multiple people are hacking on it they don't clash.
> > 
> > (a) and (b) needed to do anything useful with kernel side.
> > (c) needed for testing long term, but don't care initially.
> > 
> > (d) mostly separable - needed for a 'nice' test setup but not for basic functionality testing.
> > 
> > If you want to take a look at (a) and (b) and maybe (c) that would be great.
> > 
> > There is lots of independent stuff to do for (d) so maybe I'll focus on that in short term?
> > 
> > How's that work for you?
> > 
> > Jonathan
> > 
> 
> Hi Jonathan and Gregory,
> I have some initial code for DCD support for qemu emulation. It
> mainly includes following
> 1. DCD mailbox command support at qemu side;
> 2. QMP interface to support DCD event like adding/removing dynamic
> capacity
> 3. DCD Device representative for Qemu emulation (based on
> cxl_type3.c)
> 
> The code is only draft now and not completed or tested with early
> enabling code posted by Dan in the thread.
> If you are interested, feel free to use it as base and carry it on.
> I will also continue to work on it.
> My next step would be to check the kernel side DCD code and
> try to fix anything missing/incorrect at qemu side, and then see if we can do
> some very simple DCD test with both kernel and qemu support.
> 
> Here is the code:
> https://github.com/moking/qemu-dev/tree/dcd
> 
> Fan

Initially I prototyped the dcd device as a new device class and found it
may be not a good choice and will need a lot of code change at qemu
side. Instead, in the new version I extended type3 device implemention with
dc capability. Now it is able to do some simple test together with kernel
side dcd support. 

Here is the qemu code branch for the new version:  
https://github.com/moking/qemu-dev/tree/dcd-v2

The code is not clean at all and not ready for review. It is for people who
are interested and want to have a early try of dcd support at kernel side or
who want to use it as base to carry the dcd feature on.

What we can do with the code together with kernel dcd code:
1. load the cxl modules touching identify memory device code change at
kernel; 
2. touch the code path of the mailbox command to get dc region
info (spec 3.0, 8.2.9.8.9) on both kernel and qemu side;
3. touch the code path of the mailbox command to get dc extent list info
4. touch the dc region related code to create dc region
5. use qmp interface to add one dc exent and the kernel was able to
create dax device for the extent, and the memory can show as offline RAM.
And the extent can be released with the qmp dc extent release interface.
Re-add a released dc extent has issue.
6. NOTE: real read/write access to the dynamic capacity is not supported yet.

What operations have been tested:
1. install the cxl modules 
	modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem

2. create dc regions:

region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
echo 1 > /sys/bus/cxl/devices/$region/interleave_ways

echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode
echo 0x10000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size

echo 0x10000000 > /sys/bus/cxl/devices/$region/size
echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
echo 1 > /sys/bus/cxl/devices/$region/commit
echo $region > /sys/bus/cxl/drivers/cxl_region/bind

root@bgt-140510-bm03:/home/fan/cxl/tools-and-scripts# cxl list
[
  {
    "memdevs":[
      {
        "memdev":"mem0",
        "pmem_size":536870912,
        "ram_size":0,
        "serial":0,
        "host":"0000:0d:00.0"
      }
    ]
  },
  {
    "regions":[
      {
        "region":"region0",
        "resource":45365592064,
        "size":268435456,
        "interleave_ways":1,
        "interleave_granularity":256,
        "decode_state":"commit"
      }
    ]
  }
]


3. add one dc extent (128MB) through qmp interface

{ "execute": "qmp_capabilities" }                                               
                                                                                
{ "execute": "cxl-add-dynamic-capacity-event",                                  
    "arguments": {                                                              
         "path": "/machine/peripheral/cxl-pmem0",                               
         "num-extent": 1                                                        
    }                                                                           
}                  

root@bgt-140510-bm03:/home/fan/cxl/tools-and-scripts# lsmem 
RANGE                                  SIZE   STATE REMOVABLE BLOCK
0x0000000000000000-0x000000007fffffff    2G  online       yes  0-15
0x0000000100000000-0x000000027fffffff    6G  online       yes 32-79
0x0000000a90000000-0x0000000a97ffffff  128M offline             338

Memory block size:       128M
Total online memory:       8G
Total offline memory:    128M


4. release the dc extent (128MB) added through qmp interface

{ "execute": "cxl-release-dynamic-capacity-event",                                                                                                                                                                                                            
    "arguments": {                                                              
         "path": "/machine/peripheral/cxl-pmem0",                               
         "num-extent": 1                                                        
    }                                                                           
}                                                                               
~                     
root@bgt-140510-bm03:/home/fan/cxl/tools-and-scripts# lsmem 
RANGE                                 SIZE  STATE REMOVABLE BLOCK
0x0000000000000000-0x000000007fffffff   2G online       yes  0-15
0x0000000100000000-0x000000027fffffff   6G online       yes 32-79

Memory block size:       128M
Total online memory:       8G
Total offline memory:      0B



QEMU command cxl configuration:

RP1="-object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=512M \
-object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest.raw,size=512M \
-object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=512M \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \                            
-device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \          
-device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,dc-memdev=cxl-mem2,id=cxl-pmem0,num-dc-regions=1\
-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k"


The code is tested with the posted kernel dcd support:
https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.5/dcd-preview

To make the test work, we have made the following changes to the following
commit of above kernel code branch:

-----------------------------------------------------------------------------
commit f425bc34c600e2a3721d6560202962ec41622815 (origin/for-6.5/dcd-preview)
Author: Navneet Singh <navneet.singh@intel.com>
Date:   Mon Mar 6 08:45:59 2023 -0500

    cxl/mem: Trace Dynamic capacity Event Record
-----------------------------------------------------------------------------



diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5f04bbc18af5..5f421d3c5cef 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
 	CXL_CMD(GET_DC_EXTENT_LIST, 0x8, CXL_VARIABLE_PAYLOAD, 0),
+	CXL_CMD(GET_DC_CONFIG, 0x2, CXL_VARIABLE_PAYLOAD, 0),
 };
 
 /*
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 291c716abd49..ae10e3cf43a1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -194,7 +194,7 @@ static int cxl_region_manage_dc(struct cxl_region *cxlr)
 		}
 		cxlds->dc_list_gen_num = extent_gen_num;
 		dev_dbg(cxlds->dev, "No of preallocated extents :%d\n", rc);
-		enable_irq(cxlds->cxl_irq[CXL_EVENT_TYPE_DCD]);
+		/*enable_irq(cxlds->cxl_irq[CXL_EVENT_TYPE_DCD]);*/
 	}
 	return 0;
 err:
@@ -2810,7 +2810,8 @@ int cxl_add_dc_extent(struct cxl_dev_state *cxlds, struct resource *alloc_dpa_re
 				dev_dax->align, memremap_compat_align()))) {
 		rc = alloc_dev_dax_range(dev_dax, hpa,
 					resource_size(alloc_dpa_res));
-		return rc;
+		if (rc)
+			return rc;
 	}
 
 	rc = xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_dax, GFP_KERNEL);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 9e45b1056022..653bec203838 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -659,7 +659,7 @@ static int cxl_event_irqsetup(struct cxl_dev_state *cxlds)
 
 	/* Driver enables DCD interrupt after creating the dc cxl_region */
 	rc = cxl_event_req_irq(cxlds, policy.dyncap_settings, CXL_EVENT_TYPE_DCD,
-					IRQF_SHARED | IRQF_ONESHOT | IRQF_NO_AUTOEN);
+					IRQF_SHARED | IRQF_ONESHOT);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event dc log\n");
 		return rc;
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 6ca85861750c..910a48259239 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -47,6 +47,7 @@
 	___C(SCAN_MEDIA, "Scan Media"),                                   \
 	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
 	___C(GET_DC_EXTENT_LIST, "Get dynamic capacity extents"),         \
+	___C(GET_DC_CONFIG, "Get dynamic capacity configuration"),         \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a

> 
> > 
> > > 
> > > ~Gregory
> > 
> > 

-- 
Fan Ni
