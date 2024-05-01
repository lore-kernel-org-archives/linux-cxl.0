Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7823D5FBB1
	for <linux-cxl@vger.kernel.org>; Wed,  1 May 2024 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575500; cv=none; b=ZmaRMf1rn4jy7ixnkcjX3Ddy0bMKBW2Lpm098kQDoayIPj0875kNpinuvmZxEcuVeHd0I2OIHLz+l78r7p3RcmqJQciGAMjEhQ2Bhs88YGgiMk1ZPHOKQ7FHTSm9PEPgKTGnAwDi9+xNWyeRxVw7Hr8vKBoq0ARidHekHabfnt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575500; c=relaxed/simple;
	bh=XGF+Gx/6ObQES9uht5TX9XbsAD/26jfrV4n9qikj2WM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+gdQ3VhQHU+WHy9bFejD3byoYAtYnuN27ewXYlcFdnGsOoB8gtPpLlHUV25zrJTBo5ZrhVZa3DfhKtKkoPbnDgj2E7KvbtMyeIkbSjUGkImh3wS0BviGLjFUUuMjshE2pb5AUX4Oc/sOfg7cwXri/XG0CW4pUyaCjTjurr7RNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VV0YG65fxz6K7HY;
	Wed,  1 May 2024 22:57:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 68EEE1408F9;
	Wed,  1 May 2024 22:58:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 1 May
 2024 15:58:13 +0100
Date: Wed, 1 May 2024 15:58:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: Markus Armbruster <armbru@redhat.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <gregory.price@memverge.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240501155812.00002ec3@Huawei.com>
In-Reply-To: <ZjEnwPeoivsW8y5Z@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
	<20240418232902.583744-10-fan.ni@samsung.com>
	<877cgkxzal.fsf@pond.sub.org>
	<Zivk37xBGPsL_yo5@debian>
	<87h6fkob0t.fsf@pond.sub.org>
	<ZjEnwPeoivsW8y5Z@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)




> > >> > +# @hid: host id  
> > >> 
> > >> @host-id, unless "HID" is established terminology in CXL DCD land.  
> > >
> > > host-id works.  
> > >> 
> > >> What is a host ID?  
> > >
> > > It is an id identifying the host to which the capacity is being added.  
> > 
> > How are these IDs assigned?  
> 
> All the arguments passed to the command here are defined in CXL spec. I
> will add reference to the spec.
> 
> Based on the spec, for LD-FAM (Fabric attached memory represented as
> logical device), host id is the LD-ID of the host interface to which
> the capacity is being added. LD-ID is a unique number (16-bit) assigned
> to a host interface.

Key here is the host doesn't know it.  This ID exists purely for rooting
to the appropriate host interface either via choosing a port on a
multihead Single Logical Device (SLD) (so today it's always 0 as we only
have one head) or if we ever implement a switch capable of handling MLDs
then the switch will handle routing of host PCIe accesses so it lands
on the interface defined by this ID (and the event turns up in that event log.

            Host A         Host B - could in theory be a RP on host A ;)
              |              |  Doesn't exist (yet, but there are partial.
             _|______________|_ patches for this on list.
            | LD 0         LD 1|
            |                  |
            |   Multi Head     |
            |   Single Logical |
            |  Device (MH-SLD) |
            |__________________|
Host view similar to the switch case, but just two direct
connected devices.

Or Switch and MLD case - we aren't emulating this yet at all

     Wiring / real topology                 Host View 
         
      Host A     Host B              Host A       Host B
        |          |                   |            |
     ___|__________|___               _|_          _|_
    |   \  SWITCH /    |             |SW0|        | | |
    |    \       /     |             | | |        | | |
    |    LD0   LD1     |             | | |        | | |
    |      \   /       |             | | |        | | |
    |        |         |             | | |        | | |
    |________|_________|             |_|_|        |_|_|
             |                         |            |
      Traffic tagged with LD           |            |
             |                         |            |
     ________|________________     ____|___     ____|___
    | Multilogical Device MLD |   |        |   |        |
    |        |                |   | Simple |   | Another|
    |       / \               |   | CXL    |   | CXL    |
    |      /   \              |   | Memory |   | Memory |
    |    Interfaces           |   | Device |   | Device |
    |   LD0     LD1           |   |        |   |        |
    |_________________________|   |________|   |________|

Note the hosts just see separate devices and switches with the fun exception that the
memory may actually be available to both at the same time.

Control plane for the switches and MLD see what is actually going on.

At this stage upshot is we could just default this to zero and add an optional
parameter to set it later.



...

> > >> > +# @extents: Extents to release
> > >> > +#
> > >> > +# Since : 9.1
> > >> > +##
> > >> > +{ 'command': 'cxl-release-dynamic-capacity',
> > >> > +  'data': { 'path': 'str',
> > >> > +            'hid': 'uint16',
> > >> > +            'flags': 'uint8',
> > >> > +            'region-id': 'uint8',
> > >> > +            'tag': 'str',
> > >> > +            'extents': [ 'CXLDCExtentRecord' ]
> > >> > +           }
> > >> > +}  
> > >> 
> > >> During review of v5, you wrote:
> > >> 
> > >>     For add command, the host will send a mailbox command to response to
> > >>     the add request to the device to indicate whether it accepts the add
> > >>     capacity offer or not.
> > >>     
> > >>     For release command, the host send a mailbox command (not always a
> > >>     response since the host can proactively release capacity if it does
> > >>     not need it any more) to device to ask device release the capacity.
> > >> 
> > >> Can you briefly sketch the protocol?  Peers and messages involved.
> > >> Possibly as a state diagram.  
> > >
> > > Need to think about it. If we can polish the text nicely, maybe the
> > > sketch is not needed. My concern is that the sketch may
> > > introduce unwanted complexity as we expose too much details. The two
> > > commands provide ways to add/release dynamic capacity to/from a host,
> > > that is all. All the other information, like what the host will do, or
> > > how the device will react, are consequence of the command, not sure
> > > whether we want to include here.  
> > 
> > The protocol sketch is for me, not necessarily the doc comment.  I'd
> > like to understand at high level how this stuff works, because only then
> > can I meaningfully review the docs.  
> 
> --------------------------------
> For add command, saying a user sends a request to FM to ask to add
> extent A of the device (managed by FM) to host 0.
> The function cxl-add-dynamic-capacity simulates what FM needs to do.

This gets a little fiddly as an explanation.  I'd argue this is more or
less at the level of the FM to device command flow so it's the device
verifying etc. (you could explain this interface as talking to an FM
that is talking to the device, but that just feels complicated to me).

> 1. Verify extent A is valid (behaviour defined by the spec), return
> error if not; otherwise,
> 2. Add a record to the device's event log (indicating the intent to
> add extent A to host 0), update device internal extent tracking status,
> signal an interrupt to host 0;
> (The above step 1 & 2 are performed in the QMP interface, following
> operations are QMP irrelevant, only host and device involved.)

In this patch.

> 3. Once the interrupt is received, host 0 fetch the event record from
> the device's event log through some mailbox command (out of scope
> of this patch series).

It's in patch 8.

> 4. Host 0 decides whether it accepts extent A or not. Whether accept or
> reject, host needs to send a response (add-response mailbox command) to
> the device so the device can update its internal extent tracking
> status accordingly.
> The device return a value to the host showing whether the response is
> successful or failed.

(assuming the host isn't buggy this always succeeds)

> 5. Based on the mailbox command return value, the host process
> accordingly.

Memory now useable by host if it accepted it successfully.

> 6. The host sends a mailbox command to the device to clear the event
> record in the device's event log. 
> 
> ---------------------------------
> For release command, saying a user sends a request to FM to ask host 0
> to release extent A and return it back to the device (managed by FM).
> 
> The function cxl-release-dynamic-capacity simulates what FM needs to do.
> 1. Verify extent A is valid (defined by the spec), return error if not;
> otherwise,
> 2. Add a record to the event log (indicating the intent to
> release extent A from host 0), signal an interrupt to host 0;
> (The above step 1 & 2 are performed in the QMP interface, following
> operations are QMP irrelevant, only host and device involved.
> 3. Once the interrupt is received, host 0 fetch the event record from
> the device's event log through some mailbox command (out of scope
> of this patch series).
> 4. Host 0 decides whether it can release extent A or not. Whether can or
> cannot release, host needs to send a release (mailbox command) to the device
> so the device can update its internal extent tracking status accordingly.
> The device returns a value to host 0 showing whether the release is
> successful or failed.
> 5. Based on the returned value, the host process accordingly.
> 6. The host sends mailbox command to clear the event record in the
> device's event log. 
> 
> For release command, it is more complicated. Based on the release flag
> passed to FM, FM can behaviour differently. For example, if the
> forced-removal flag is set, FM can directly get the extent back from a
> host for other uses without waiting for the host to send command to the
> device. For the above step 2, their may be not event record to the event
> log (no supported in this patch series yet).
I thought we weren't doing force remove yet?  So for that we could
set default value as normal release until we add that support perhaps.

> 
> Also, for the release interface here, it simulates FM initializes the
> release request.
> There is another case where the host can proactively release extents it
> do not need any more back to device. However, this case is out of the
> scope of this release interface.
> 
> Hope the above text helps a little for the context here.
> Let me know if further clarification is needed.

Only thing I'd add is that for now (because we don't need it for testing
the kernel flows) is that this does not provide any way for external
agents (e.g. our 'fabric manager' to find out what the state is - i.e.
if the extents have been accepted by the host etc). That stuff is all
defined by the spec, but not yet in the QMP interface.  At somepoint
we may want to add that as a state query type interface.

Jonathan

p.s. Our emails raced yesterday, so great you put together this explanation
of the flows before I got to it :)

> 
> Thanks,
> Fan
> 
> 
> 
> >   
> > > @Jonathan, Any thoughts on this?  
> > 
> > Thanks!
> >   

