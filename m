Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110F9C74A5B
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 04:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjC3Efm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 00:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC3Efk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 00:35:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B2A59C4
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 21:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOgY6hvHsy3mTSY+NtmqyCwZiSD/RJU8DapJIqI8p28DFpoMd0xjSw0XtOAgSkWhk0e0n1L5/B722OaDwEIZcx0esuBS5F6/8UjbkaSm40whrd7K2MFskolKpbP4tA2wHiYg1sEHHS3j52V0n8tls/TpaJ/L6wdhtBM0E9BQ7l5BjiPsSdMQd6x9OdFHiVLKFtKSfCyXhwhn6D8aBk9edonesLFqhMSj9S5gAqcidmezVJ1h4LXooUm92+WuCIRTO/fsXE6qn/0Lqg4c/wDFfRXUwTLwE5mJz37qChwN3uA5zfj9Erxzuh8ngp3BYfniJwNBqVE3Zfe3WmcZa67i0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6t9KKUq4VqiKsf62lXsR6VKE6y1fgV6MMGd+sjAlcM=;
 b=kH8ZIJxgi/wuBJN9mbMBkYsZl/BdOxkSzntWldClhQiY9OXErhc5hDGndQgVJgw/zzptTcz2V8GcLSAfVPCawvezP0HHXAfjUAOTnNvZjojtd9YqTYyHaAe5Vhqnj2hEJWjqIzO+Z6Eh6x4vRVub/t/KsyK32rxpofiakiGy6WCYcpDb2cXEM+b04T3cPu2pLrcvt5Usq/lCV02QHE/eKlJKZ40/M0hJiSNOMqyxILz4vyl1QVAGKOt8CDb2cwhB/c1ZEVqDskE+edbLxjhw3KvtRmT6YhBAtdi31qbNIiIM6HuzcQLMEBIzkb6WuIoUw8n+HVWuP1RwbuYy5AwzuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6t9KKUq4VqiKsf62lXsR6VKE6y1fgV6MMGd+sjAlcM=;
 b=dwwPECtC+H0ij9idkne8rh18dE4cct4EA+rm15lpKnZa5bSMEJaxsaoJBKhN1/34ncr++VWbg289UUfyoQK/dJ2iOBrwoDntqYKm8zuaLjlsxM2Kt1SUn1NqieVZOUY7V9hSupgHcbpmX8wlnsh0FjZrSOIwowQkprZA/g6lbOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW3PR17MB4170.namprd17.prod.outlook.com (2603:10b6:303:46::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Thu, 30 Mar
 2023 04:35:33 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 04:35:33 +0000
Date:   Wed, 29 Mar 2023 13:20:03 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Message-ID: <ZCRzQxmafPCCWJOx@memverge.com>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
 <ZCRhhUDcmypVKu0X@memverge.com>
 <64250e45bea49_c722294c2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64250e45bea49_c722294c2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BY3PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:217::16) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW3PR17MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6f5b3c-b3a3-443d-43da-08db30d8330a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbqCuEP+5Qic/URPOYr5zeC8flIO+m2IYuFGxzZv2zIQ5vtS7Oka4dAAsvSpnOPK7hOOFTSonZGokOqKuszjvqrBSNX0cPrXVjSxCTm/EJ24Vm8+cgH6whpPV7QfNwz7SOeax1FQBD8iNUXHO53ukPZGM34vf/78P6T+y7QysJDiJu2W8K2+gULH7vd5ZHpc2bT1oeQKCCPjwQXBWGuEXBTL1BRmv1L9B/jka0HHEWwWloPJ6YuLRuIhqTamQsDd3yxNG6019jMpQpiSPM1jeue2ZnfdR4wPrSIRvXuzHayv0JkfJaZkDJClQDixZDV3ZfyDZxKjFeTGlJGcqSMwIjqUj1AriVxTSW9eqmvcfBnGEWNz/Orrc9i7NuZKUXP2byFP6rKoQmYzPX57zYRSeKY841Wo/v783kCTO23ZabgF/tXe3J7EhwtshPUXOCN52/XNC0r9gecMsrDD68pF3Vf52SM/05ClZl+OLREJioxSW95SU7cXptfcKIxg9KKixOAv3U3KIiMEhwq+j6m8lDeL/kA+qGJ0ApcYS6f9br3EQHZ2wvu2DW9Iw5OEkOPw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39850400004)(136003)(346002)(376002)(396003)(451199021)(316002)(6666004)(26005)(6512007)(6506007)(6486002)(186003)(83380400001)(6916009)(44832011)(4326008)(8936002)(2616005)(66476007)(8676002)(66556008)(66946007)(41300700001)(5660300002)(478600001)(2906002)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/FB8AIVsctGfwGfSxCWJ2WEfWZlLmOoly59Lb/FS+R3a/gqDrk7XEZJV41/8?=
 =?us-ascii?Q?dK3ZDVF4lYvhNrNDTf6qC5Pt7ABQUAp0y0w2VPtjdq/p3XzOY3aBMQBhshu1?=
 =?us-ascii?Q?MvKavFgYbjYuNYV7jRhNADkzFyjUt6nZQ1cxtRHDLFHbIuVW0ls7TPBzNBC5?=
 =?us-ascii?Q?9NFkr1rIh1wEGMtaBdygw3OEVmR+gzyBsxlBPFa/PuQ7Dnxoh5mM2ba6NkS9?=
 =?us-ascii?Q?k0jqG5TmLObQPvP868JhUuyEmTCDwxhQE7fhhN8OC37YScqTulFzsYNR29yX?=
 =?us-ascii?Q?HpCl+RP/e4HAlWQBKlQjn2sAg0rO8OICOmPWhBK4st3iotKz+a2i1pp415tk?=
 =?us-ascii?Q?G+lIdhzh8jcUFQJkydq5/C4NlnIkMtE4oGtdQlTYdNvy8CtN/uB+uI1GOIOT?=
 =?us-ascii?Q?YLKtEFnoTFmq8p7qpUZApzyNCIean7/lANlGaSi05/Uznk2LtbAG7/eGlHYv?=
 =?us-ascii?Q?+oCq1CzjM6iCPb8pWZVCc9xLD+uBL9XkGcnRnbmKtQjgvKMAH9FAf+3ztFVc?=
 =?us-ascii?Q?Ksdf4shXolXfnNNVuQ3SdH+yrZjk7Rn9/dZA7z6g+bXjlbLa8IyPx5ZemJUU?=
 =?us-ascii?Q?3NQGL2dDph4ir8FBcblOsE+adPwm9axFNIwo9PfCb73yVFcGpS1NZvdeH9qM?=
 =?us-ascii?Q?hh71BqcsIFZ1K+svs0ggdBiE3tSUZfxYF53ksr2FcBcxLl8qilvD1t0MaCtG?=
 =?us-ascii?Q?hXJBcwdqNsOdWJ4aPmQVjx/ilsy9hrLBhZis/WCOE70xoG+1dOXijSTSogFy?=
 =?us-ascii?Q?A9ZSutHPB5BrKE5tMGJ08R7x5cLg/L8yaOIp06IccV3WOp9KfmA/+6CpPSC/?=
 =?us-ascii?Q?z+uOfCbKBEhjI3IGDHjdijvauNeiMQNz5WqQtMXqyDmlP9z4uGOKxvT6npgf?=
 =?us-ascii?Q?0iYsJAc6plK3jhOzR2BqXQ0kb7Omg2RCXEwkdnQjLT/p5n74oXOsfFe2dswf?=
 =?us-ascii?Q?UQnfr8xbJWYmGP4oWKypXbZul5SNwOlKtRfIX9g4ELXCUZ6LLdDdpbSizf/j?=
 =?us-ascii?Q?Q3QwdYTmnAvaaTiiQoMuvDk0ItA3mrMvPmLiT8ii5smPBcv2KnVrlVZeToLr?=
 =?us-ascii?Q?oqgl2Puny61kxsjC7/gz8ShAxXPOLST3bRKiKq97dg1VbrmZgI3HLtzrheKK?=
 =?us-ascii?Q?b3lc+5wvydWTOiII4f5qNAotWYh6QoFdDOCb6+cB/4D43+lo1SutlFHDkPTF?=
 =?us-ascii?Q?XZEZvyeLvaWxGFS5e6vAFjl53OWrqw5qEncJGUb6b9wLB5LmDY8Dg2ZiBRHc?=
 =?us-ascii?Q?kbfVzl5FF4zXLgKGu6Ks7saGJpP2Ua9tDXldLWD81y9/DIsfV4atYTlzAR2d?=
 =?us-ascii?Q?RC11FVfLb0+HvKbDQybmxKi/6FHE2lkBEx0H8vIMnJaDDFTy0JZnkvLIrneX?=
 =?us-ascii?Q?aUjgXrCEdr2CwreXgX++8ik8LXBWxMYDolVm2nfHUMbWBlrBi857kDA8VcF8?=
 =?us-ascii?Q?C1O92AVvFGHxZORxOBRP31P/yAr9cRGF4IfERhF2Jo8/yH8ArYNf+LYHL8ed?=
 =?us-ascii?Q?QyL88OZkM3BdmbQbHbsjGnCcXMQCZrsSe3SDzM7HD1bUpoh70wIVuoYQCt/m?=
 =?us-ascii?Q?xid9EY9/D/c2Dz2HjRAN3ZJ+bmsAtDiFEArFeFOVMEDn0iUYCn4A7RlxLKB7?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6f5b3c-b3a3-443d-43da-08db30d8330a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 04:35:33.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eDwub1zZ1jeWXWtvDNFr5PF+fOTadOHxPIZ/4twuBa52xTEuP9a0ut6AiqDbKBpgnqm3rQ7e1bOQ7NweDZnwHy6pBfcIA6yfatmsPnHRyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR17MB4170
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 29, 2023 at 09:21:25PM -0700, Dan Williams wrote:
> Gregory Price wrote:
> [..]
> > I have an example host where *dpa_base ends up being 0x0 here, and as a
> > result later down the line the region fails to register with this:
> 
> First off, thanks for testing.
> 
> > [   21.974117] cxl_pci 0000:3f:00.0: mem0:decoder1.0 no CXL window for range 0x0:0x1fffffffff
> 
> So, this debug message is a statement about *HPA*, DPA is the device
> local offset, it just so happens that in this case the HPA base and
> DPA base are aligned.
> 
> [..]
> > (full cxl log with bonus prints i added)
> > [   21.607034] cxl_pci 0000:3f:00.0: No component registers (-19)
> > [   21.641831] cxl_pci 0000:3f:00.0: DOE: [d80] failed to cache protocols : -5
> > [   21.642866] cxl_pci 0000:3f:00.0: Failed to create MB object for MB @ d80
> > [   21.643686] cxl_pci 0000:3f:00.0: Failed to request region 0x0000000000001fff-0x000000000010201e
> 
> I assume that this is the attempt to map the RAS component registers
> given the driver load did not fail. Would be interested to see this
> platform's /proc/iomem, but this is separate from the DPA mapping issue.
> Perhaps this device tries to define the RAS capability with another
> block that was already mapped?
> 

I'll snag more information on this tomorrow when I can do a bit more.

> > [   21.644371] cxl add_dpa_res: (0, 1fffffffff)
> > [   21.645540] cxl add_dpa_res: (2000000000, 1fffffffff)
> 
> Ok, this device has a 128G ram region and no pmem.
> 
> > [   21.965692] cxl hdm dvsec range: (0, 1fffffffff)
> > [   21.967045] cxl emulating decoders: dpa_base(0)   <-  *dpa_base
> 
> That's ok...
> 
> > [   21.967778] cxl_add_to_region: searching for root decoder with address range(0, 1fffffffff)
> 
> Now it switches to search for a CFMWS for the HPA that just to be
> identity mapped to DPA by accident.
> 
> > [   21.972824] cxl match decoder: found root decoder, r1(1050000000, 304fffffff) r2(0, 1fffffffff)
> 
> I am assuming that this means the only CXL window defined for this
> platform is 1050000000-304fffffff?

Yes sorry, r1() is the root decoder which maps to the CFMW, r2 is the
device dvsec defined range.  I actually wrote this out while i was
working towards the second half of the experiment, just left this here
for completeness incase i got something wrong.

> 
> > [   21.974117] cxl_pci 0000:3f:00.0: mem0:decoder1.0 no CXL window for range 0x0:0x1fffffffff
> > [   21.974905] cxl discover_region: failed to add to region: 0x0-0x1fffffffff
> 
> Driver is giving up for cause because either the BIOS failed to program
> the range registers of the device correctly, or it failed to publish a
> window for where the device is decoding.
> 
> > Ultimately having trouble deciding if this is something broken with
> > bios, the setup_hdm_decoder code, or the discover_region code.  I'm not
> > PCI guru, but we should expect the rdm dvsec range to be in the range of
> > the root decoder window / CFMW:  r1(1050000000, 304fffffff)
> 
> Yes, either that or a CFWMS for 0-1fffffffff
>

Given this system is single-socket, and has only a single CXL memory
expander connected to it, and that a CFMWS for 0-1fff.. seems
irrational, I'm going to go with the Range Register is wrong.

> > confirming this is the issue, i *forced* the dvsec range register to read
> > out base+0x1050000000
> 
> Nice!
> 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 7328a2552411..6fc6df0f7b5a 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -340,12 +344,16 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
> >                 if (rc)
> >                         return rc;
> > 
> >                 base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
> > 
> >                 info->dvsec_range[i] = (struct range) {
> > -                       .start = base,
> > -                       .end = base + size - 1
> > +                       .start = 0x1050000000 + base,
> > +                       .end = 0x1050000000 + base + size - 1
> >                 };
> > 
> > 
> > And this resulted in everything working "as one would expect"
> > 
> > [user@host0 ~]# ls /sys/bus/cxl/devices/
> > dax_region0  decoder0.0  decoder1.0  endpoint1  mem0  region0  root0
> > 
> > [user@host0 ~]# numactl --hardware
> > available: 2 nodes (0-1)
> > node 1 cpus:
> > node 1 size: 0 MB
> > node 1 free: 0 MB
> > node distances:
> > node   0   1
> >   0:  10  50
> >   1:  255  10
> > 
> > [user@host0 ~]# echo online_movable > /sys/bus/node/devices/node1/memory33/state
> > [user@host0 ~]# numactl --hardware
> > available: 2 nodes (0-1)
> > node 1 size: 2048 MB
> > node 1 free: 2048 MB
> > node distances:
> > node   0   1
> >   0:  10  50
> >   1:  255  10
> > 
> > 
> > Basically the question is:
> > 
> > Is the DVSEC Range Register expected to be programmed by bios, and are
> > not being programmed correctly?
> 
> This debug experiment makes me think perhaps the *device* is at fault,
> not the BIOS. Perhaps the device accepts writes to CXL_DVSEC_RANGE_BASE
> to set up the decode as expected, but reads return 0? That's the only
> way that I can see that forcing that offset results in successfully
> talking to memory.
> 

Noteably, this is the same system in which i discovered a bios bug with
the CEDT.CMFW base.  I also have a patch in the kernel that corrects the
CFMW interleave target indexing.

So it's entirely possible that the bios is not programming things
correctly and simply leaving the device indexed at 0x0, while the device
sets up most everything else.

But I will investigate a bit further.

> > Or is there something else missing here to correct for the CMFW base?
> [..]
> > If it's the former, then this patch set is gtg and i'm happy to add my
> > Tested-by tag.  If it's the latter, can we hotfix it before release?
> 
> Yeah, FWIW, I don't see anything wrong from the kernel side, and would
> be curious what the BIOS reports if it reads back what it wrote to the
> CXL DVSEC range registers.

At this point I concur, you can add my tested-by to each of the patches
on this line.  I will reach out to the platform and device vendors to
investigate further.  Thanks for the input.

Tested-by: Gregory Price <gregory.price@memverge.com>
