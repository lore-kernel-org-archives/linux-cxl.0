Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F513C7EE2D
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Mar 2023 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjCCQoG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Mar 2023 11:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjCCQoD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Mar 2023 11:44:03 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E87BAD07
        for <linux-cxl@vger.kernel.org>; Fri,  3 Mar 2023 08:43:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcMopqfFSmXEfyTEpi5Lz0a3D0koCTAFGAtdS5YIGmgo6j58obxdGR2KHUcR9jQGA2EptfaRdSYFRtT7zzvavbUXcaKihEPWMYR8ul02pfZ0wQpwqjI9yr7r7G1PMJ978azqWUsNm9OtthXOI3h1eWgnCFKbhpQImSQY0Rv5eo4iy4uTLD6gcBX+zKwBmbBOsG2p70sSrJWzHVEkeDdeul72ZQRbo6j1x4mqxhSyGFp7bUavu0QjYgZSs4yJNTmJ9O5YUSnL9RkuMEDbL06vb4As+hRvXM0xM4967p/25P2qhvv/Mfd4YfXP/h9SYopoSZYIoMgJjC0FeMTsxgtUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKql8R4nN8pdnDnpKcGS0TZY5iBxiiFdHvv7DHRApRA=;
 b=inl+1RUFlp9T+fmKc0mGRog9pmxI+1lN4R+XbaDzRHwts7zqCv7uKLvTMLYCyUX4Uq5cvqprWN2pvwNIh0C+t9ZdYg5Zv1oqJqTNlet4Gryb0ETcZZ1WJ61QFpCp8DewRhKhkLpg4YSOzsF/sBrnDYfiWl2NRpVKxlAMIFN8L8y6MLeUe3a9OXe7htXhaFyOFOHaE+pj3tycLLlYhko1DrY/nMfPWdxZMMmd//aYGtriQ1s6kJOg3l44F9QOhhzsaxR1E8P6SKHU4QI6VdvxMMnjUcfNMgs+RSfzdwlCq9Rg0uwm/wXPhNXI8K5qnpJCKnvo+xh1CqSPfNU89DJvbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKql8R4nN8pdnDnpKcGS0TZY5iBxiiFdHvv7DHRApRA=;
 b=p9mom3YK8Rtfix+89CsCqek0V6cI4Rv/fNHR5nmkxJwQhn2WRdMDrdUVegtGcjxQyON82P4Yy9ATAXuK98pzog8+T2QhuvwS2RNn8VqMbtlvApil+CT3reV4qrkw1kp7gg+dcOSvaPCPiEHAmSnmDU5ZlCTl6CFgGd3h2ZAZknQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by CO1PR17MB5177.namprd17.prod.outlook.com (2603:10b6:303:fc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 16:43:42 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%3]) with mapi id 15.20.6156.018; Fri, 3 Mar 2023
 16:43:41 +0000
Date:   Fri, 3 Mar 2023 11:43:33 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dave.jiang@intel.com
Subject: Re: [PATCH 0/2] cxl: DVSEC Range emulation fixups
Message-ID: <ZAIjtbmqStyhQfKn@memverge.com>
References: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
 <Y/gPhE3hDnTEd6PI@memverge.com>
 <63ff9d85215e_495bc294e2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ff9d85215e_495bc294e2@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::27) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|CO1PR17MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f40aef-177b-49c9-3a71-08db1c067239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fit5LqV8xbOcSIoXJO3qvN7DqYe+IxE7P3T1kh2dmA0efDkWAEsoqkxeK+S7rGahCzq7ApT8st3wpWNyXY6TLjfmEKeYi94Heh5fNSFfqNmiOnkoDR7+ebaH/ZBjpbrHwVVO0ir4SfVLZV50rJQxXXY7rFV/CQOcJnNV52iqdOguq8JhqO680jwD4CwNug1hL2nrkhiEWg1Jzt8vrfwWTOVu9ND1xyrsUG2OqXPVMFdcBMdoR1LIude0jLojEvflraX2LHuNARDCJ7+4WwZvEhZ+x2ISev0ekyaxdgYYp8Q0ttKwbUiTUFzzIztZNtw6jyD4zbFAGfhmJhAntz1jYKJiuVs3F8Gr57rip5hUp3qKQbtmDyBe7Q/LGJSN4BoNfOXuSJj5OV6ziAwpz7h9cIROxVXY9buta+K133kbUlIe4VsXn0H7rQ3nW8f5gwrdUEw4H2QKs4rcpYBQmQ3bh50CBg9lGFNjHZ8E23OTwwhxP5cnMBNrTjaYl4wGge0oV74arBs1gZek9EjTxc1Uf+slERNB1H12ZfOuhL079nU9N7xCt8haVoiua+FGM78H4nylZShoghthFUIDUPellSk/NmnaToDMnBVmWPiJ3H0UidzfI4QuMyR/GXRGe+gGAY9tAvsZnHureGaV22j9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(376002)(396003)(39840400004)(451199018)(30864003)(2906002)(44832011)(38100700002)(86362001)(478600001)(6486002)(6506007)(45080400002)(186003)(26005)(6512007)(36756003)(66476007)(66946007)(66556008)(4326008)(6916009)(8676002)(83380400001)(19627235002)(6666004)(5660300002)(2616005)(41300700001)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w1mLdGkwO0S/6IkpbwD60sbwZbf04utRpzpkoAo3XYdWxXU/RxCs8TGJOeq8?=
 =?us-ascii?Q?UZKPXt2gKd/TvhKmNfiqdMwt8aDCQsntwfCkeiWo1MZjrVsTx1QYE0YOJu6+?=
 =?us-ascii?Q?rGZCRO/7DefUdkIfW35qozt+Ikax0eT2kre7ZOb17xf2XL5MqaMV4uHmncJy?=
 =?us-ascii?Q?XC1Nu+8aowllswaAKP2KbOeNuTgJ4e1OQqwqutNgjrEwssTDRwABNMSyBkYj?=
 =?us-ascii?Q?vfVT0a9LZy9v3V3BOwb26BcjjStNgu0UjWYINOnahFXsGxsglrEydRlz95gm?=
 =?us-ascii?Q?HDSSlZuDsBa+FCn9Xj7nq1molFTVwhEzEJq/nt+Sfa+OhHXil5SGXvm1ZYJT?=
 =?us-ascii?Q?2Qrzving26LsXpKC6gsMaJFz9/hUi8FglfEaEcSCXV6BkZwZ72pUSWTREIVK?=
 =?us-ascii?Q?7geLiGmma+sT8lxR2Ol8lF2fouwwTBrQM1hTqn+JW5RhwUZznLcD/22Tw/el?=
 =?us-ascii?Q?nHpNw32IC59dor8Sm+oXANjjXG8JdG5zTpjGbjaUNzasllrznKyverGsbnJL?=
 =?us-ascii?Q?24Eg8Q9bvIlRcboUs4Zitp2BVkbChOYKpA6SelYu1npxFw3lk1P/FzmFTsqz?=
 =?us-ascii?Q?RlT1PI5KgkggXs+soILjJ/hK5+ETcNo5Xer/mKbgiVIIyBc2v6oEaqoBi/eR?=
 =?us-ascii?Q?ACduYY1EeiJ3MaCrIYqRV5V+aBi/K2mLchpA3NusHP0/LkQ070mA3pLYsxDs?=
 =?us-ascii?Q?dEh8/DdCFQN541YILXeGFIiqu74v/Ibww4JxMaGFnuNjPO8BtIDy0zV0R7m5?=
 =?us-ascii?Q?uRUXkKqVLAyARLMzD1y500KlUK5OzveXtpBf6x6HLarg35EWlzoFrpvrWN4i?=
 =?us-ascii?Q?Ay3Yu8YooGyGKiW1iPfTk8wMwtvikjZrMesvJm20xPIVOTVEPpsw4m0HpEtK?=
 =?us-ascii?Q?UD9+x3VqbuVxMo0TDSK8ZIzTmybrJuDZGZ/Br6koqLJWmoaAq3IH/rL9sdsm?=
 =?us-ascii?Q?yzO/Wx5SG5Q59vKTxMjyBUAwwqlO0Ek4EP2Wywqul4DL0cc9T7CEsMr/PgPe?=
 =?us-ascii?Q?VkdOjjmQd1kArXCYAxCEBl7pqUNtfDpi3vmNIeL0CrlY9d3m6N8LHW7H9JSS?=
 =?us-ascii?Q?Cb7B7Kb+R3u7EGntkYYiWW+12yUmEgefyFPUqSWKJKP7lXLDgXUsN1bBv6Gf?=
 =?us-ascii?Q?jYWZNU4hRnWSSSdHSsALp8xOCPP2lblIhDgCDwDfR6y4X6aUq9c5twf8BdWT?=
 =?us-ascii?Q?w/ICVkF52efS4CJjU+zjFI1hrM2GKq9P3k7sqUF38Oqk9H/9fXTWeupguMCM?=
 =?us-ascii?Q?6UNv1CPI1wPgl/KGDcasB8r2teQcw4IXz779onSKqm1pu0mBQckFjGeEp0di?=
 =?us-ascii?Q?i6QP9R1nG4dafEZJLs3fWIALH/p5l5WK0itQJgGvF4HegjDN+ySmtm1vWECG?=
 =?us-ascii?Q?17afikfABfYVMvE3gLlZ5Dj3wTu9ZUxRhGRFfO7EpqOYz6o3vqemQ7B3+ybR?=
 =?us-ascii?Q?A0vH0r2bHJCVGyNN5XCYeKPhmDs0AZMaZ9UFO7qLc+RNGE0TEp+L4C/Q0oVi?=
 =?us-ascii?Q?0qaQnsEwOGd7+feYQovRGTicPPDcVBZxKfWiQxvKd0PWz7pqzv8OW1C2AFyc?=
 =?us-ascii?Q?L8HHRuT+hS9dBf2sk0NOoaXAZ/Ipp97Y8kxKYbmcAD/oBWFtGwu9eAuwgWsv?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f40aef-177b-49c9-3a71-08db1c067239
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 16:43:41.6666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uMH+6PoNxjU2MMt2wmiyHEo6Au3WAfl55+D7PlSE5syEWFKPTYmJtOx8wBv9FCFd0msr8GFyqKgd6DJWs3BZi4FY35E0XBW+Msvv5tGOuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR17MB5177
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 01, 2023 at 10:46:29AM -0800, Dan Williams wrote:
> Hi Gregory,
> 
> > 1) The system I'm on fails to register a CFMW/root port decoder.  I'm
> >    not entirely sure why, other than during cxl_decoder_add(), the
> >    target map contains "[0,]" as the target id's, and the only
> >    registered ports/decoders are the endpoints.
> > 
> >    I don't know whether this is because the hardware just doesn't have a
> >    root decoder, or what.  But it makes the volatile region patches
> >    non-functional, and i have to revert back to static configuration to
> >    use the real cxl device (i.e. don't mark it EFI_MEMORY_SP).
> 
> It looks like the BIOS is trying to report something in the CEDT.CFMWS
> but it looks
> 
> > 2) Per the second bit - there's no component registers being registered
> >    for this cxl device (plus some spurious DOE error).
> 
> If the CEDT is broken then for RCH topologies the device component
> registers will also be missing.
> 
> > 
> > 
> > The no root decoder thing has been throwing me for a loop, if you can
> > help me shed some light on this i'd greatly appreciate it.  If a socket
> > has no decoders, should we expect memory expanders to be managable via
> > the volatile region system in the driver?
> > 
> > 
> > relevant dmesg info
> > 
> > [   21.928436] cxl root0: Failed to populate active decoder targets
> 
> Would be interesting to know if decoder_populate_targets() is returning
> -EINVAL or -ENXIO.
>

This is returning ENXIO.  Most specifically, the path here goes through

cxl_parse_cfmws
  cxl_root_decoder_alloc:
  	rp: 0xd85ea62a
	ways: 1
	hb: calc_hb_module
	succeeds

	decoder:
                flags: 41
                hpa_range.start: 1342177280 - 0x50000000
                hpa_range.end:   1342177279 - 0x4fffffff <- suspect?
                interleave ways: 1

  cxl_decoder_add
    cxl_decoder_add_locked
      // cxl decoder allocated by cxl_root_decoder_alloc
      cxld == &cxlrd->cxlsd.cxl
      cxld->dev.parent: 0000000096ae77e1

      // parent device port?
      port == to_cxl_port(cxld->dev.parent)	

      port->id: 0
      port->hb: 0000000000000000
      port->parent_dport: 0000000000000000
      port->nr_dports: 1 
      port->cdat_avail: 0

      target_map[0]: 0

      decoder_populate_targets(cxlsd, port, target_map)
        find_dport(port, 0) // target_map[0] == 0
	  // iterating through ports:
          [   22.614465]  find port: dport->port_id 4 - searching for 0
        [   22.657306] dport not found
        -> ENXIO

So the root port has a parent port... but the parent port doesn't have a
dport to the root port we just allocated? That's confusing.

The only dport for the parent is 4, and that might belong to the other
decoder on the system?

[user@host0 ~]# ls /sys/bus/cxl/devices/
decoder1.0  endpoint1  mem0  root0

Since this doesn't happen on QEMU, I imagine we would expect to find
this linkage, but it isn't happening for some reason.

I'll have to see if i can get the full topology out at some point.

> > [... snip ...]
> > [   21.965126] cxl_pci 0000:3f:00.0: No component registers (-19)
> > [   22.001597] cxl_pci 0000:3f:00.0: DOE: [d80] failed to cache protocols : -5
> > [   22.002351] cxl_pci 0000:3f:00.0: Failed to create MB object for MB @ d80
> > [   22.003265] cxl_pci 0000:3f:00.0: Failed to request region 0x0000000000001fff-0x000000000010201e
> > [... snip ...]
> > [   22.339973] BUG: unable to handle page fault for address: 0000000000001000
> > [   22.340584] #PF: supervisor read access in kernel mode
> > [   22.346801] #PF: error_code(0x0000) - not-present page
> > [   22.349059] PGD 1339ec067 P4D 0
> > [   22.350877] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [   22.354558] CPU: 45 PID: 1351 Comm: systemd-udevd Not tainted 6.2.0+ #7
> > [   22.358357] RIP: 0010:cxl_probe_component_regs+0x23/0x180 [cxl_core]
> 
> Can you send the output of:
> 
> scripts/faddr2line drivers/cxl/core/cxl_core.ko cxl_probe_component_regs+0x23
> 
> ...from your kernel build directory?

cxl_probe_component_regs at /data/cxl/drivers/cxl/core/regs.c:51

partial stack trace:

readl at /data/cxl/./arch/x86/include/asm/io.h:61
cxl_probe_component_regs at /data/cxl/drivers/cxl/core/regs.c:51
map_hdm_decoder_regs at /data/cxl/drivers/cxl/core/hdm.c:95
devm_cxl_setup_hdm at /data/cxl/drivers/cxl/core/hdm.c:134
cxl_endpoint_port_probe at /data/cxl/drivers/cxl/port.c:92
(inlined by) cxl_port_probe at /data/cxl/drivers/cxl/port.c:139

> 
> I suspect this crash can be avoided with an explicit earlier check for
> missing component registers, but that's not really a fix for this
> failure.
>
> Can you also send the log without these patches applied for comparison?

attempted to trim to just relevant stuff but i can send the raw logs if
really needed.  Note - pci 0000:3f is a memory expander device.

the issue seems to appear after the first patch

>crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
>if (!crb && info && info->mem_enabled) {
>	cxlhdm->decoder_count = info->ranges;
>	cxlhdm->target_count = info->ranges;
>} else if (!crb) {
>	dev_err(dev, "No component registers mapped\n");
>	return ERR_PTR(-ENXIO);
>}
>
>rc = map_hdm_decoder_regs(port, crb, &cxlhdm->regs);

we're reaching map_hdm_decoder_regs with !crb, and that leads to a
null+offset dereference in cxl_probe_component_regs:

cap_array = readl(base + CXL_CM_CAP_HDR_OFFSET);


before patches:


[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000104dbbffff] usable
[    0.000000] BIOS-e820: [mem 0x0000001050000000-0x000000304fffffff] usable
[...]
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000104dbbffff] usable < dram
[    0.000000] reserve setup_data: [mem 0x0000001050000000-0x000000304fffffff] usable < memexp
[...]
[    0.001000] Early memory node ranges
[    0.001000] Initmem setup node 0 [mem 0x0000000000001000-0x000000104dbbffff]
[    0.001000] Initmem setup node 1 [mem 0x0000001050000000-0x000000304fffffff]
[...]
[    2.109081] ACPI: PCI Root Bridge [CX00] (domain 0000 [bus 3f])
[    2.109097] acpi ACPI0016:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    2.109116] acpi ACPI0016:00: _OSC: OS supports [CXL11PortRegAccess CXL20PortDevRegAccess CXLProtocolErrorReporting CXLNativeHot]
[    2.109474] acpi ACPI0016:00: _OSC: platform does not support [AER LTR DPC]
[    2.110128] acpi ACPI0016:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability]
[    2.110145] acpi ACPI0016:00: _OSC: OS now controls [CXLMemErrorReporting]
[    2.110447] PCI host bridge to bus 0000:3f
[    2.110457] pci_bus 0000:3f: Unknown NUMA node; performance will be reduced
[    2.110471] pci_bus 0000:3f: root bus resource [mem 0x24000000000-0x280801fffff window]
[    2.110487] pci_bus 0000:3f: root bus resource [bus 3f]
[    2.110516] pci 0000:3f:00.0: [1b00:c000] type 00 class 0x050210
[    2.110540] pci 0000:3f:00.0: reg 0x10: [mem 0x28000000000-0x28000ffffff 64bit pref]
[    2.110564] pci 0000:3f:00.0: reg 0x18: [mem 0x26000000000-0x27fffffffff 64bit pref]
[    2.110838] pci 0000:3f:00.1: [1b00:c000] type 00 class 0x000000
[    2.110861] pci 0000:3f:00.1: reg 0x10: [mem 0x28001000000-0x280010fffff 64bit pref]
[    2.114296] acpi/hmat: Memory Flags:0001 Processor Domain:0 Memory Domain:0
[    2.114313] acpi/hmat: Memory Flags:0000 Processor Domain:1 Memory Domain:1
[    2.114328] acpi/hmat: Locality: Flags:00 Type:Access Latency Initiator Domains:1 Target Domains:2 Base:1000
[    2.114347] acpi/hmat:   Initiator-Target[0-0]:110 nsec
[    2.114358] acpi/hmat:   Initiator-Target[0-1]:510 nsec
[    2.114368] acpi/hmat: Locality: Flags:00 Type:Access Bandwidth Initiator Domains:1 Target Domains:2 Base:100
[    2.114386] acpi/hmat:   Initiator-Target[0-0]:28800 MB/s
[    2.114396] acpi/hmat:   Initiator-Target[0-1]:5000 MB/
[...]
[    2.283144] pci 0000:40:07.1: PCI bridge to [bus 41]
[    2.283159] pci 0000:40:07.1:   bridge window [mem 0x380b0100000-0x380b01fffff 64bit pref]
[    2.283187] pci_bus 0000:40: resource 4 [io  0x0000-0x02e7 window]
[    2.283199] pci_bus 0000:40: resource 5 [io  0x0300-0x03af window]
[    2.283211] pci_bus 0000:40: resource 6 [io  0x0400-0x0cf7 window]
[    2.283222] pci_bus 0000:40: resource 7 [io  0x4000-0x6fff window]
[    2.283234] pci_bus 0000:40: resource 8 [mem 0x000c0000-0x000dffff window]
[    2.283247] pci_bus 0000:40: resource 9 [mem 0xb0000000-0xb1ffffff window]
[    2.283260] pci_bus 0000:40: resource 10 [mem 0x280b0200000-0x380b01fffff window]
[    2.283274] pci_bus 0000:41: resource 2 [mem 0x380b0100000-0x380b01fffff 64bit pref]
[    2.283370] pci_bus 0000:3f: resource 4 [mem 0x24000000000-0x280801fffff window]
[...]
[    2.321401] pci 0000:3f:00.0: Adding to iommu group 30
[    2.321486] pci 0000:3f:00.1: Adding to iommu group 30
[...]
[   22.882894] cxl_pci 0000:3f:00.0: No component registers (-19)
[   22.893368] cxl root0: Failed to populate active decoder targets
[   22.894495] cxl_acpi ACPI0017:00: Failed to add decode range [0x1050000000 - 0x304fffffff]
[   22.895253]  pci0000:3f: host supports CXL (restricted)
[   22.911081] cxl_pci 0000:3f:00.0: DOE: [d80] failed to cache protocols : -5
[   22.912145] cxl_pci 0000:3f:00.0: Failed to create MB object for MB @ d80
[   22.912604] cxl_pci 0000:3f:00.0: Failed to request region 0x0000000000001fff-0x000000000010201e
[...]



after patch 1:

cxl_probe_component_regs+0x23/0x180:

readl at /data/cxl/./arch/x86/include/asm/io.h:61
cxl_probe_component_regs at /data/cxl/drivers/cxl/core/regs.c:51
map_hdm_decoder_regs at /data/cxl/drivers/cxl/core/hdm.c:95
devm_cxl_setup_hdm at /data/cxl/drivers/cxl/core/hdm.c:134
cxl_endpoint_port_probe at /data/cxl/drivers/cxl/port.c:92
(inlined by) cxl_port_probe at /data/cxl/drivers/cxl/port.c:139



[   22.782228] cxl root0: Failed to populate active decoder targets
[   22.782864] cxl_acpi ACPI0017:00: Failed to add decode range [0x1050000000 - 0x304fffffff]
[   22.784735]  pci0000:3f: host supports CXL (restricted)
[   22.835657] cxl_pci 0000:3f:00.0: No component registers (-19)
[   22.854734] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[   22.855072] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
[   22.865626] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[   22.869447] cxl_pci 0000:3f:00.0: DOE: [d80] failed to cache protocols : -5
[   22.875385] cxl_pci 0000:3f:00.0: Failed to create MB object for MB @ d80
[   22.876136] cxl_pci 0000:3f:00.0: Failed to request region 0x0000000000001fff-0x000000000010201e
[... snip a bunch of ipmi stuff ...]
[   23.388179] BUG: unable to handle page fault for address: 0000000000001000
[   23.388809] #PF: supervisor read access in kernel mode
[   23.389177] #PF: error_code(0x0000) - not-present page
[   23.389566] PGD 12df78067 P4D 0
[   23.390017] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   23.390405] CPU: 13 PID: 1316 Comm: systemd-udevd Not tainted 6.2.0+ #10
[   23.391098] RIP: 0010:cxl_probe_component_regs+0x23/0x180 [cxl_core]
[   23.391468] Code: 90 90 90 90 90 90 90 0f 1f 44 00 00 41 57 31 c0 b9 06 00 00 00 41 56 41 55 41 54 49 89 fc 48 89 d7 55 53 48 83 ec 10 f3 48 ab <8b> 86 00 10 00 00 66 83 f8 01 0f 85 30 01 00 00 c1 e8 18 0f 84 93
[   23.392103] RSP: 0018:ff801efeb0da78a8 EFLAGS: 00010282
[   23.392408] RAX: 0000000000000000 RBX: ff4f082287578800 RCX: 0000000000000000
[   23.392721] RDX: ff801efeb0da7910 RSI: 0000000000000000 RDI: ff801efeb0da7940
[   23.393029] RBP: ff4f08233a9eeec8 R08: 0000000000000000 R09: 0000000000000001
[   23.393326] R10: 0000000000000001 R11: 000000000c1c20e0 R12: ff4f082287578800
[   23.393613] R13: ff801efeb0da7998 R14: ff4f08233f0f0428 R15: ff4f08320032a010
[   23.393965] FS:  00007f6682548580(0000) GS:ff4f083181e00000(0000) knlGS:0000000000000000
[   23.394307] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.394647] CR2: 0000000000001000 CR3: 000000012df04001 CR4: 0000000000771ee0
[   23.395003] PKRU: 55555554
[   23.395324] Call Trace:
[   23.395637]  <TASK>
[   23.395933]  map_hdm_decoder_regs+0x46/0x90 [cxl_core]
[   23.396340]  devm_cxl_setup_hdm+0x95/0x120 [cxl_core]
[   23.396664]  cxl_port_probe+0xdc/0x1b0 [cxl_port]
[   23.396967]  cxl_bus_probe+0x14/0x50 [cxl_core]
[   23.397271]  really_probe+0x1b6/0x410
[   23.397557]  __driver_probe_device+0x78/0x170
[   23.397855]  driver_probe_device+0x1f/0x90
[   23.398165]  __device_attach_driver+0x85/0x110
[   23.398440]  ? __pfx___device_attach_driver+0x10/0x10
[   23.398778]  bus_for_each_drv+0x77/0xb0
[   23.399096]  __device_attach+0xb3/0x1d0
[   23.399376]  bus_probe_device+0x9f/0xc0
[   23.399656]  device_add+0x41e/0x9b0
[   23.399935]  ? kobject_set_name_vargs+0x6d/0x90
[   23.400199]  ? dev_set_name+0x4b/0x60
[   23.400445]  devm_cxl_add_port+0x345/0x570 [cxl_core]
[   23.400750]  cxl_mem_probe+0x1ca/0x310 [cxl_mem]
[   23.400995]  cxl_bus_probe+0x14/0x50 [cxl_core]
[   23.401258]  really_probe+0x1b6/0x410
[   23.401498]  __driver_probe_device+0x78/0x170
[   23.401792]  driver_probe_device+0x1f/0x90
[   23.402032]  __driver_attach+0xd2/0x1c0
[   23.402268]  ? __pfx___driver_attach+0x10/0x10
[   23.402482]  bus_for_each_dev+0x73/0xa0
[   23.402695]  bus_add_driver+0x141/0x230
[   23.402896]  driver_register+0x77/0x120
[   23.403097]  ? __pfx_init_module+0x10/0x10 [cxl_mem]
[   23.403832]  do_one_initcall+0x6b/0x350
[   23.405789]  do_init_module+0x4a/0x220
[   23.408580]  __do_sys_finit_module+0x93/0xf0
[   23.411445]  do_syscall_64+0x58/0x80
[   23.414885]  ? do_syscall_64+0x67/0x80
[   23.418410]  ? do_syscall_64+0x67/0x80
[   23.422373]  ? do_syscall_64+0x67/0x80
[   23.425381]  ? do_syscall_64+0x67/0x80
[   23.428484]  ? lockdep_hardirqs_on+0x7d/0x100
[   23.431170]  ? do_syscall_64+0x67/0x80
[   23.434292]  ? asm_exc_page_fault+0x22/0x30
[   23.437575]  ? lockdep_hardirqs_on+0x7d/0x100
[   23.440641]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   23.443242] RIP: 0033:0x7f6681f0afbd
[   23.445806] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 33 ce 0e 00 f7 d8 64 89 01 48
[   23.450708] RSP: 002b:00007fff40383f78 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   23.453096] RAX: ffffffffffffffda RBX: 0000559037cb6d70 RCX: 00007f6681f0afbd
[   23.453110] RDX: 0000000000000000 RSI: 00007f668270443c RDI: 000000000000000e
[   23.453113] RBP: 00007f668270443c R08: 0000000000000000 R09: 0000559037cc51a0
[   23.453117] R10: 000000000000000e R11: 0000000000000246 R12: 0000000000020000
[   23.453119] R13: 0000559037cbef10 R14: 0000000000000000 R15: 0000559037cc5220
[   23.453131]  </TASK>
[   23.463696] Modules linked in: cxl_mem(+) cxl_port irqbypass rapl wmi_bmof pcspkr dax_hmem ipmi_ssif acpi_ipmi ipmi_si ipmi_devintf cxl_pci k10temp i2c_piix4 ipmi_msghandler cxl_acpi cxl_core acpi_cpufreq fuse zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 nvme ast tg3 nvme_core i2c_algo_bit nvme_common ccp sp5100_tco wmi
[   23.463784] CR2: 0000000000001000
[   23.463799] ---[ end trace 0000000000000000 ]---
[   23.463804] RIP: 0010:cxl_probe_component_regs+0x23/0x180 [cxl_core]
[   23.464017] Code: 90 90 90 90 90 90 90 0f 1f 44 00 00 41 57 31 c0 b9 06 00 00 00 41 56 41 55 41 54 49 89 fc 48 89 d7 55 53 48 83 ec 10 f3 48 ab <8b> 86 00 10 00 00 66 83 f8 01 0f 85 30 01 00 00 c1 e8 18 0f 84 93
[   23.464021] RSP: 0018:ff801efeb0da78a8 EFLAGS: 00010282
[   23.464024] RAX: 0000000000000000 RBX: ff4f082287578800 RCX: 0000000000000000
[   23.464026] RDX: ff801efeb0da7910 RSI: 0000000000000000 RDI: ff801efeb0da7940
[   23.464028] RBP: ff4f08233a9eeec8 R08: 0000000000000000 R09: 0000000000000001
[   23.464030] R10: 0000000000000001 R11: 000000000c1c20e0 R12: ff4f082287578800
[   23.464031] R13: ff801efeb0da7998 R14: ff4f08233f0f0428 R15: ff4f08320032a010
[   23.464034] FS:  00007f6682548580(0000) GS:ff4f083181e00000(0000) knlGS:0000000000000000
[   23.464036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.464037] CR2: 0000000000001000 CR3: 000000012df04001 CR4: 0000000000771ee0


after patch 2:
same results
