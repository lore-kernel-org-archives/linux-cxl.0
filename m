Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7566DC7EE25
	for <linux-cxl@archiver.kernel.org>; Tue, 16 May 2023 15:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjEPPIX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 11:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjEPPIU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 11:08:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B9A1999
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 08:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrmNx7ytfNHpqL+sQ3AZ4anr3cwVXlqMJ70SqyMtxjZi/4+vjGS4tskd3dFM2PTNb2sJE7iRyXaqtTQ1mnUpbEnv/QMm/B3AjeJHuAIuciOz8epoIYl/qm5Oh5bgPydpMuW2AwqVSJfiKPtvNxNc2QlN67QlprUVjprTb1NKf+B1HI+be2QjmXIlzG7ilWxvn3m2y158basUkFry6y4kAG0gAWCvI4CJWt78cDaF26RDk1GjioBPiFs8oiZ+lJPWb+V3VxMP1xKELGyS2XuwrAbyTdz+Yc+0YWZG9u0bhVjJPDj5MJYtdrqzKxu/wi2rSWPlcMcKCcvxfveonEWWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8GwUxStht/fm8Ro0QFImfn+AIrcVYSx4wQhuM9rzs8=;
 b=UMCqtB+zD+u/We+zt1h+J67SxL3pRaKTuDBe4bUQuZBU+6ad/KWRIlR81FcS43jnLEI9Yhet5xrZgB8wStvCVkewLhBQJpCyf4bjzF0aZnzurbwRnB7zhsMMfx/th6+u9LLfN0h2EESfuK/nxSCTjp5I1Mk0xYlriEIim4EyPrkr6WZaHhZHRq6gRE722ILQv421wwN72JXJL3llp5kDwNYuryDAWvVLHo3VpfG7ad0n2JAhPdNa5OCxoSQ4ZPGPhseiuwDPFtKT09eFMMTKbVSas8zxYSV7J6zs5BZ+v5o0Pmnn0o7KOCbva/EREzghXj4wTSVevh64z76w/0Xb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8GwUxStht/fm8Ro0QFImfn+AIrcVYSx4wQhuM9rzs8=;
 b=xJ6lGaM9yPctFMOjptiIWgjN/m5niclk3VY+UnBavKNUawSRzMkABBnRbZP5SqcJPoL4Q8HtQsTM26ks6PLuS1wlvWu0AZQdEjOzgd88UgRAwzJgCHugvxirdaGLY9ixy/rlZWQthKboUR5joi49XBpR3ZI5UW/oGyKlqE8iwV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DS0PR17MB7061.namprd17.prod.outlook.com (2603:10b6:8:fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 15:08:14 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%5]) with mapi id 15.20.6387.028; Tue, 16 May 2023
 15:08:14 +0000
Date:   Tue, 16 May 2023 02:20:07 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Vincent Hache <vhache@rambus.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [RFC] cxl: Multi-headed device design
Message-ID: <ZGMglwWwZCP4FUtW@memverge.com>
References: <ZBpe6btfLuuAS35g@memverge.com>
 <20230515171807.00006d8f@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515171807.00006d8f@Huawei.com>
X-ClientProxiedBy: BL1P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::26) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DS0PR17MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: cd7c5724-5c16-4306-c18a-08db561f5f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+98JeJ5jhqukGIjLUi+elhMHPzwxXlzwcEs+JQSJqu5tm2m4BT5bV2ARxfF8hNZtZVVxaSTw2Bt/UluqhgJTiBoXCJqDN47/7NKBVi4dR9D8JJ+07FiqhJR+DvRWmUoeRGUdvgX97iyzsxMqawhC82/m92flprJq5+9sXfa/IINO9DYYG/JxrBXzH808Gq3esu84dMuYL+fVknPqzcpdd2AsCypsnwvapaQQ4R9SiOvvwZUzgYTIu5G7t2W2+dizz5pexnPwu0JbysiBz6QoByTsvzW0O+jaqjlCPFYzLGAj05Cd1FXgt+AV99rjBcCxj/431rkg+Mig9g4WpQDYBBikXM3EmV+NR+6N+SXSBDqDiNbd6YNlK04RRR2vqvaiUCDKmyRkBkMJ2wnc862V+LV4vSGXqhz56fOIeEuVQVPOpwP4xzKhuAvLM1ijL0V26/3LKCl8DGqdwKU4Tz789o0RUtDPFPu5mhXMIvLmdi/vhcDyFTZ2qm1q4+E0KaUGnHry74pBMcq0la3aHBaIC4XmU9R/QN1+Sm4Dd+OAcMbEjo5OCkAhfEwU826WCK8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(346002)(39840400004)(451199021)(86362001)(36756003)(54906003)(316002)(66946007)(66556008)(66476007)(6916009)(4326008)(478600001)(6666004)(8676002)(5660300002)(8936002)(41300700001)(30864003)(2906002)(44832011)(38100700002)(2616005)(6506007)(6512007)(186003)(26005)(83380400001)(6486002)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DJrKWAHYpICckE8XYpnLKsdL3UMr/pjU+cyjTUT8gyR7xuLSCPPw4mnCEu4s?=
 =?us-ascii?Q?L8c7bVajAs6aA8jRAX0eV2FgKk+g5hyuUk9OU0qLRvZTZLXlC87sFxuuDPMV?=
 =?us-ascii?Q?oCi8n4Yz5zRhRswflfwfaF/UsoU+fx4LIIBriNpzuzK9mkDlGC2eos7d/eyn?=
 =?us-ascii?Q?04KtkbUgcnkSm6/qe3gzFTQxvfrSFCqnlgz1QLARDWELjGXIDIdAuY5WIMZP?=
 =?us-ascii?Q?1AAkmr/uazVzlLao6MM7zurhdsluGgMyNOASfgnYewy7aHlmjRrRSUBRWsBH?=
 =?us-ascii?Q?12KMYZ3045J7wZA4mV0EmFEjwrZtEzBG9ki54bDKqqxwU8WUlxcMM4gNcsaY?=
 =?us-ascii?Q?+T7vmBscJqSVkj+YEcS9TcH6G/ICOiQ5rpz8Ffkf+Dy2W04n2Tr7aT+iDhNA?=
 =?us-ascii?Q?HEtB/tek7Gi4AiA94rWWMibCY3PUxTJIm0tz5Dh1mRrdCsvwQ3UqsVIk7lUI?=
 =?us-ascii?Q?4OXrGTMROJufD3AxaSjiWDkIqQGYKCm6fG+uZM+67D5Tnap6J1U7fDND4jOV?=
 =?us-ascii?Q?oH7Ktz5/q2i+s0y87sK+8LuIEn7SxfmfClAJP5/yxnbfgPbyGR5n/tfJJyBr?=
 =?us-ascii?Q?kEKjxHwlfFEjTaRnQp6e3SlqlMY6fZb/RD08LRcMooSJ/JSTbjTyxjqc5vgE?=
 =?us-ascii?Q?vXTeXQf6soyQH9z1Rx/IN7LdGPvHUwguFSyWXjOEyc6mBIO3v3D4enkU3HlS?=
 =?us-ascii?Q?moWr+SMRqP9yWLAelos1c5/zz/suoJjbjXbnIVhRSo5+jDw7iIGM7po+QG+V?=
 =?us-ascii?Q?yWqEACMQJfOB+1to3VkffsOzOz976XBY3QZhCb1ZYPYwQXAgt07XZZEkcjfP?=
 =?us-ascii?Q?ExYRWCBBnbFsKpy2R+0JbMob0KZwUNstQpCyfZWIDch/B5utA4LUteXAUbM6?=
 =?us-ascii?Q?XFN0kj549lWaaob1VpaUdsBRrBkNzWSmt5v9NwbLqy6AKFYCDnUGmwVfmo+p?=
 =?us-ascii?Q?Ara0lljhpYgl4XH7VlgfNxYOW7VjTLw7bnAH1yzFUNkh2iXC2TZfUeKnhysd?=
 =?us-ascii?Q?cg3ebrGrwyMe349LtkmSiCT0JPs59kwnRydfr3bIDbgnxyaYc0JaYf99Ov55?=
 =?us-ascii?Q?0126OGPeJW2HKF4+RLTA6/Y4N0EkBFUU5D8ec+MDdw21Yxd5kw7LWDJismdJ?=
 =?us-ascii?Q?Mnw4HiFG7nvgv3DuH3AsoM9ByDFQM7UZZPLLOLORs/Jema32hmCz5baOzcOM?=
 =?us-ascii?Q?uvlmJvvnsv/TBGdU8N+mQYdLb1xeMvcaZ1e2oxKwLYninZIPdIHKJnnFB/ur?=
 =?us-ascii?Q?8lK7ROy8Fh3z6cmGas6jcEJ2fNK6Bapvj/HTP59IHTiiBtIM8V46qk3QYxlB?=
 =?us-ascii?Q?lVkGkBs1mo0XqqXCX1dcSHAtN8CSUIYvL7ozvXOFNSGcXMc0GQ2Gasvlhf5N?=
 =?us-ascii?Q?NUoGmGx2Vf8Zet3mExkgEipcXw0HWwuCdSQwo9a7POCES2gxtMZHVofrIpZP?=
 =?us-ascii?Q?7IeQncRzUgpj4u2UnsTYfHPDcliOcXW3reGFP81ItjE5QIUnd1LFHdiDMw9h?=
 =?us-ascii?Q?EwwEXwyo22DjJwC2S+oF8EMFnoCQ3DTOGKyb2bSgS0tYBh/Y7plVrv4B7JLi?=
 =?us-ascii?Q?Lh2VdtZSdJafrjsmYnq4LDjJh5tlm/OhM9ED78mwskB17QJOrlYuVcnMFxzE?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7c5724-5c16-4306-c18a-08db561f5f12
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:08:14.4135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qxuDKACa420hicQmQ7QyeaK07dzYTXRM6DNjoC3IYFWE5HHRMAVSM4X0+Y43ugy0uZP2vO/VDx0/l2uWb/snPquNJq5c821b0OfPhNDiNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB7061
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, May 15, 2023 at 05:18:07PM +0100, Jonathan Cameron wrote:
> On Tue, 21 Mar 2023 21:50:33 -0400
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> > 
> > Ambiguity #1:
> > 
> > * An SLD contains 1 Logical Device.
> > * An MH-SLD presents multiple SLDs, one per head.
> > 
> > Ergo an MH-SLD contains multiple LDs which makes it an MLD according to the
> > definition of LD, but not according to the definition of MLD, or MH-MLD.
> 
> I'd go with 'sort of'.  SLD is a presentation of a device to a host.
> It can be a normal single headed MLD that has been plugged directly into a host.
> 
> So for extra fun points you can have one MH-MLD that has some ports connected
> to switches and other directly to hosts. Thus it can present as SLD on some
> upstream ports and as MLD on others.
>

I suppose this section of the email was really to just point out that
what constitutions a "multi-headed", "logical", and "multi-logical"
device is rather confusing from just reading the spec.  Since writing
this, i've kind of settled on:

MH-* - anything with multiple heads, regardless of how it works
SLD - one LD per head, but LD does not imply any particular command set
MLD - multiple LD's per head, but those LD's may only attach to one head
DCD - anything can technically be a DCD if it implements the commands

Trying to figure out, from the spec, "what commands an MH-SLD" should
implement to be "Spec Compliance" was my frustration.  It's somewhat
clear now that the answer is "Technically nothing... unless its an MLD".

> > I want to make very close note of this.  SLD's are managed like SLDs
> > SLDs, MLDs are managed like MLDs.  MH-SLDs, according to this, should be
> > managed like SLDs from the perspective of each host.
> 
> True, but an MH-MLD device connected directly to a host will also 
> be managed (at some level anyway) as an SLD on that particular port.
>

The ambiguous part is... what commands relate specifically to an SLD?
The spec isn't really written that way, and the answer is that an SLD is
more of a lack of other functionality (specifically MLD functionality),
rather than its own set of functionality.

i.e. an SLD does not require an FM-Owned LD for management, but an MHD,
MLD, and DCD all do (at least in theory).

> > 
> > 2.5.1 continues on to describe "LD Management in MH-MLDs" but just ignores
> > that MH-SLDs (may) exist.  That's frustrating to say the least, but I
> > suppose we can gather from context that MH-SLD's *MAY NOT* have LD
> > management controls.
> 
> Hmm. In theory you could have an MH-SLD that used a config from flash or similar
> but that would be odd.  We need some level of dynamic control to make these
> devices useful.  Doesn't mean the spec should exclude dumb devices, but
> we shouldn't concentrate on them for emulation.
> 
> One possible usecase would be a device that always shares all it's memory on
> all ports. Yuk.
> 

I can say that the earliest forms of MH-SLD, and certainly pre-DCD, is
likely to present all memory on all ports, and potentially provide some
custom commands to help hosts enforce exclusivity.

It's beyond the spec, but this can actually be emulated today with the
MH-SLD setup I describe below.  Certainly I expected a yuk factor to
proposing it, but I think the reality is on the path to 3.0 and DCD
devices we should at least entertain that someone will probably do this
with real hardware.

> > For the simplest MH-SLD device, these fields would be immutable, and
> > there would be a single LD for each head, where head_id == ld_id.
> 
> Agreed.
> 
> > 
> > So summarizing, what I took away from this was the following:
> > 
> > In the simplest form of MH-SLD, there's is neither a switch, nor is
> > there LD management.  So, presumably, we don't HAVE to implement the
> > MHD commands to say we "have MH-SLD support".
> 
> Whilst theoretically possible - I don' think such a device is interesting.
> Minimum I'd want to see is something with multiple upstream SLD ports
> and a management LD with appropriate interface to poke it.
> 
>
> The MLD side of things is interesting only once we support MLDs in general
> in QEMU CXL emulation and even then they are near invisible to a host
> and are more interesting for emulating fabric management.
> 
> What you may want to do is take Fan's work on DCD and look at doing
> a simple MH-SLD device that uses same cheat of just using QMP commands
> to do the configuration.  That's an intermediate step to us getting
> the FM-API and similar commands implemented.
> 

I actually think it's a good step to go from MH-SLD to MH-SLD+DCD while
not having to worry about the complexity of MLD and switches.

(I have not gotten the chance to review the DCD patch set yet, it's on
my list for after ISC'23, I presume this is what has been done).

My thoughts would be that you would have something like the following:

-device ct3d,... etc etc
-device cxl-dcd,type3-backend=mem0,manager=true

the manager would be the owner of the FM-Owned LD, and therefore the
system responsible for managing requests for memory.

How we pass those messages between instances is then an exercise for the
reader.


What I have been doing is just creating a shared memory region with
mkipc and using a separate program to initiate that shared state before
launching the guests.  I'll talk about this a little further down.


> > 
> > ... snip ...
> > 
> > 3. MH-SLD w/ Pool CCI  (Implementing only Get Multi-Headed Info)
> 
> I'd do this + DCD.
> 

I concur, and it's what i was looking into next.

I think your other notes on MH-* with switches is really where I was
left scratching my head.

When I look at Switch/MLD functionality vs DCD, I have a gut feeling the
vast majority of early device vendors are going to skip right over
switches and MLD setups and go directly to MH-SLD+DCD.

> > =================================
> > 2. MH-SLD No Switch, No Pool CCI.
> > =================================
> > 
> > But it's also not very useful.  You can only use the memory in devdax
> > mode, since it's a shared memory region. You could already do this via
> > the /dev/shm interface, so it's not even new functionality.
> > 
> > In theory you could build a pooling service in software-only on top of
> > memory blocks. That's an exercise left to the reader.
> 
> Yeah. Let's not do this step.
> 

To late :].  It was useful as a learning exercise, but it's definitely
not upstream quality.  I may post it for the sake of the playground, but
I too would recommend against this method of pooling in the long term.

I made a proto-DCD command set that was reachable from each memdev
character device, and exposed it to every qemu instance as part of ct3d
(I'm still learning the QEMU ecosystem, so was easier to bodge it in
than make a new device and link it up).

Then I created a shared memory region with mkipc, and implemented a
simple mutex in the space, as well as all the record keeping needed to
manage sections/extents.

> > shmid1=`ipcmk -M 4096 | grep -o -E '[0-9]+' | head -1`
> > ./cxl_mhd_init 4 $shmid1
> > -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,mhd=true,mhd_head=0,mhd_shmid=$1
> > 
> > ./cxl_mhd_init would simply setup the nr_heads/lds field and such
> > and set ldmap[0-3] to the values [0-3].  i.e. the head-to-ld mappings
> > are static (head_id==ld_id).
> > ... snip ...
> >
> > shmid1=`ipcmk -M 4096 | grep -o -E '[0-9]+' | head -1`
> > ./cxl_mhd_init 4 $shmid1
> > -device cxl-mhd-sld,bus=rp0,volatile-memdev=mem0,id=cxl-mem0,mhd_head=0,mhd_shmid=shmid

The last step was a few extra lines in the read/write functions to
ensure accesses to "Valid addresses" that "Aren't allocated" produce
errors.

At this point, each guest is capable basically using the device to do
the coordination for you by simply calling the allocate/deallocate
functions.

And that's it, you've got pooling.  Each guest sees the full extent of
the entire device, but must ask the device for access to a given
section, and the section can be translated into a memory block number
under the given numa node.


Ok, now lets talk about why this is a bad and why you shouldn't do it
this way:

* Technically a number of bios/hardware interleave functionality can
  bite you pretty hard when making the assumption that memory blocks are
  physically contiguous hardware addresses. However, that assumption
  holds if you simply don't turn those options on, so it might be useful
  as an early-adopter platform.


* The security posutre of a device like this is bad.  It requires each
  attached host to clear the memory before releasing it.  There isn't
  really a good way to do this in numa-mode, so you would have to
  implement custom firmware commands to ensure it happens, and that
  means custom drivers blah blah blah - not great.

  Basically you're trusting each host to play nice.  Not great.
  But potentially useful for early adopters regardless.


* General compaitibility and being in-spec - this design requires a
  number of non-spec extensions, so just generally not recommended,
  certainly not here in QEMU.

> 
> A few different moving parts are needed and I think we'd end up with something that
> looks like
> 
> -device cxl-mhd,volatile-memdev=mem0,id=backend
> -device cxl-mhd-sld,mhd=backend,bus=rp0,mhd-head=0,id=dev1,tunnel=true
> -device cxl-mhd-sld,mhd=backend,bus=rp1,mhd-head=1,id=dev2
> 
> dev1 provides the tunneling interface, but the actual implementation of
> the pool CCI and actual memory mappings is in the backend. Note that backend
> might be proxy to an external process, or a client/server approach between multiple
> QEMU instances.

I've hummed and hawwed over external process vs another QEMU instance and I
still haven't come to a satisfying answer here.  It feels extremely
heavy-handed to use an entirely separate QEMU instance just for this,
but there's nothing to say you can't just host it in one of the
head-attached instances.

I basically skipped this and allowed each instance to send the command
themselves, but serialized it with a mutex.  That way each instance can
operate cleanly without directly coordinating with each other.  I could
see a vendor implementing it this way on early devices.

I don't have a good answer for this yet, but maybe once I review the DCD
patch set I'll have more opinions.

> 
> or squish some parts and make a more extensible type3 device and have.
> 
> -device cxl-type3,volatile-memdev=mem0,bus=rp0,mhd-head=0,id=dev1,mhd-main=true
> -device cxl-type3,mhd=dev1,bus=rp1,mhd-head=1,id=dev2
> 

I originally went this route, but the downside of this is "What happens
when the main dies and has to restart".  There's all of kinds of
badness associated with that.  It's why i moved the shared state into a
separately created mkipc region.

> 
> To my mind there are a series of steps and questions here.
> 
> Which 'hotplug model'.
> 1) LD model for moving capacity
>   - If doing LD model, do MLDs and configurable switches first. Needed as a step along the
>     path anyway.  Deal with all the mess that brings and come back to MHD - as you note it
>     only makes sense with a switch in the path, so MLDs are a subset of the functionality anyway.
> 
> 2) DCD model for moving cacapcity
>   - MH-SLD with a pool CCI used to do DCD operations on the LDs.  Extension of
>     what Fan Ni is looking at.  He's making an SLD pretend to be a device
>     where DCD makes sense - whilst still using the CXL type 3 device. We probably shouldn't
>     do that without figuring out how to do an MHD-SLD - or at least a head that we intend
>     to hang this new stuff off - potentially just using the existing type 3 device with
>     more parameters as one of the MH-SLD heads that doesn't have the control interface and
>     different parameters if it does have the tunnel to the Pool CCI.
> 

Personally I think we should focus on the DCD model.  In fact, I think
we're already very close to this, as my personal prototype showed this
can work fairly cleanly, and I imagine I'll have a quick MHD patch set
once I get the change to review the DCD patch set.

If I'm being the honest, the more I look at the LD model, the less I
like it, but I understand that's how scale is going to be achieved.  I
don't know if focusing on that design right now is going to produce
adoption in the short term, since we're not likely to see those devices
for a few years.

MH-SLD+DCD is likely to show up much sooner, so I will target that.

~Gregory
