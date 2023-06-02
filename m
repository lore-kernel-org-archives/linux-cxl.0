Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62550C7EE24
	for <linux-cxl@archiver.kernel.org>; Fri,  2 Jun 2023 13:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjFBNCa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjFBNC3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 2 Jun 2023 09:02:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9219A
        for <linux-cxl@vger.kernel.org>; Fri,  2 Jun 2023 06:02:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QXjm62KxVz6D8X5;
        Fri,  2 Jun 2023 21:00:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 2 Jun
 2023 14:02:25 +0100
Date:   Fri, 2 Jun 2023 14:02:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Vincent Hache <vhache@rambus.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [RFC] cxl: Multi-headed device design
Message-ID: <20230602140224.00000756@Huawei.com>
In-Reply-To: <ZHTrMyQfd8AhxMe5@memverge.com>
References: <ZBpe6btfLuuAS35g@memverge.com>
        <20230515171807.00006d8f@Huawei.com>
        <ZGMglwWwZCP4FUtW@memverge.com>
        <20230517151859.000055b4@Huawei.com>
        <ZHTrMyQfd8AhxMe5@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 29 May 2023 14:13:07 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Wed, May 17, 2023 at 03:18:59PM +0100, Jonathan Cameron wrote:
> > > 
> > > i.e. an SLD does not require an FM-Owned LD for management, but an MHD,
> > > MLD, and DCD all do (at least in theory).  
> > 
> > DCD 'might' though I don't think anything in the spec rules that you 'must'
> > control the SLD/MLD via the FM-API, it's just a spec provided option.
> > From our point of view we don't want to get more creative so lets assume
> > it does.
> > 
> > I can't immediately think of reason for a single head SLD to have an FM owned
> > LD, though it may well have an MCTP CCI for querying stuff about it from an FM.
> >   
Sorry for slow reply - got distracted and forgot to cycle back to this.

> 
> Before I go running off into the woods, it seems like it would be simple
> enough to simply make an FM-LD "device" which simply links a mhXXX device
> and implements its own Mailbox CCI.
> 
> Maybe not "realistic", but to my mind this appears as a separate
> character device in /dev/cxl/*. Maybe the realism here doesn't matter,
> since we're just implementing for the sake of testing.  This is just a
> straightforward way to pipe a DCD request into the device and trigger
> DCD event log entries.
> 
> As commented early, this is done as a QEMU fed event.  If that's
> sufficient, a hack like this feels like it would be at least mildly
> cleaner and easier to test against.

Or MCTP over I2C which works today, but needs more commands for this :)

I plan to look at the tunneling stuff shortly.  Initially I'll punt the
guest using this to userspace, but potentially the eventual model might well be to
make it look like a bunch of direct attached CCIs from userspace point of
view. I'm not 100% keen on pushing the management of hotplug into the
kernel though as particular CCIs we are tunneling to in a wider fabric
may come and and go.  For an MHD this would be easy, not so much if
a switch CCI with tunneling to MLDs and MH-MLDs below it.

> 
> 
> Example: consider a user wanting to issue a DCD command to add capacity.
> 
> Real world: this would be some out of band communication, and eventually
> this results in a DCD command to the device that results in a
> capacity-event showing up in the log. Maybe it happens over TCP and
> drills down to a Redfish event that talks to the BMC that issues a
> command over etc etc MTCP emulations, etc.
> 
> With a simplistic /dev/cxl/memX-fmld device a user can simply issue these
> commands without all that, and the effect is the same.

Yup - something along those lines makes sense.

> 
> On the QEMU side you get something like:
> 
> -device cxl-type3,volatile-memdev=mem0,bus=rp0,mhd-head=0,id=mem0,mhd-main=true

I'd expect this device to present the mailbox commands for tunneling to
the FM-LD - as such I'd want a reference form here to your cxl-fmld below.

> -device cxl-mhsld,type3=mem0,bus=rp0,headid=0,id=mhsld1,shmid=XXXXX

Not sure why this is on the bus rp0. 

> -device cxl-fmld,mhsld=mdsld1,bus=rp1,id=mem0-fmld,shmid=YYYYY

To be spec compliant that cxl-fmld still has to support normal use as well
as tunnelling to the fm owned LD - so it's a superset of a type3 device.

My gut feeling is keep it simple for a PoC / supporting enablement.
1 device on the host that is also service as the FM.
  Probably just an extended type 3 with some more options to turn this
  feature on.
1 device on each other host that connects via socket
All device share same underlying memory.
Access bitmap is fiddly - either a push model over socket, or a shared
bitmap like you suggest.  Either works, not sure which ends up cleaner.

It may well become more devices over time, but that should be driven
by the different types of CCI sharing common infrastructure rather than
trying to figure out that model at the start.

> 
> on the Linux side you get:
> /dev/cxl/mem0
> /dev/cxl/mem0-fmld
> 
> in this example, the shmid for mhsld is a shared memory region created
> with mkipc that implements the shared state (basically section bitmap
> tracking and the actual plumbing for DCD, etc). This limits the emulation
> of the mhsld to a single host for now, but that seems sufficient.
> 
> The shmid for cxl-fmld implements any shared state for the fmld,
> including a mutex, that allows all hosts attached to the mhsld to have
> access to the fmld.  This may or may not be realistic, but it would
> allow all head-attached hosts to send DCD commands over its own local
> fabric, ratehr than going out of band.

Not keen on that part.  I'd like to keep close to the spec intent and only
allow one host to access the FM-LD.

> 
> This gets us to the point where, at a minimum, each host can issue its
> own DCD commands to add capacity to itself.  That's step 1.

I don't agree with this one.  I really don't want hosts to be able to do that.
They need to talk to one host that is acting as fabric manager - that can then
talk to the MHD to do the allocations.

> 
> Step 2 is allow Host A to issue a DCD command to add capacity to Host B.
> 
> I suppose this could be done via a backgruond thread that waits on a
> message to show up in the shared memory region?

The actual setup should be done via the single host with the FM, but there
is still a need to notify the other hosts.  I'd be tempted to do that
via a socket rather than shared memory.  Just keep the shared memory for
the access bitmap. Or drop that access bitmap entirely and rely on each
host keeping track of it's own access permissions.

For testing purposes I don't have a problem with insisting the owner
of the FM-LD must be started first and closed last.  That ties lifetime
of that host with that of the device, but that isn't too much of a problem
given the lifetime differences we may want to test probably sit at the
FM software layer, not the emulation of the hardware.

> 
> Being somewhat unfamiliar with QEMU, is it kosher to start background
> threads that just wait on events like this, or is that generally frowed
> upon?  If done this way, it would stimplify the creation and startup
> sequence at least.
> 
> ~Gregory

