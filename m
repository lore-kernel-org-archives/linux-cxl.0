Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D02035FF58
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375674; cv=none; b=dQU3Hwsm4kIzWFCkB0qBHkMPuxzVh58wDKvcmdBSKSk1Q8IOzEseEm4KZdO6hn5LxjO62N8hxSq8MAf6lyuHa/jQCvO2XR6zUdynjyp0INJe0w2BPaiwbtz7oWhMAPTy7TKEss4KJNBzY89PW4Yol+B+woBvSRFCYBJlVftWiCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375674; c=relaxed/simple;
	bh=YyI/iTIJ9RcC/M65iKgZNGC6iZ1MdCy2kVuxHHvwg3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g40ELqPZ4QnUJhuToKY9AyBea1v0i4yGGVYQbhCYEjAIk8iOsu/Zv4Xs6WTcwljhqE6d2mBWUMrxkaWr0A3qtONLAY63NCLIk17934OWsZUvrB2OpfqZaS/vxrveV/US+s9dvAQz37egA+v1qbgRrn3mPqA/2OPzdfkLlH/+3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZWtR8oO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZWtR8oO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768375666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NqRYHbIQYK5ASZulp7INzG8WNrUlmsrOT4EgaMAoRrY=;
	b=eZWtR8oOE8NxCM0dNMGcDsZEashJq78NwVPtLbMBPUWGVbNWtLk7QEX1H2cphfngmSWMyx
	jaxVYHkTxfL4uwsEbauALFc2985Olv4gjC1/G8lupi4iaUy0fIbpm6jBQ8OsG16Kgv7pX6
	Ih0/WSOFTq0nEh4PreaWVK/9WzXzyEE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-CNSrHqA3O-Cul7-dBXQk2g-1; Wed,
 14 Jan 2026 02:27:44 -0500
X-MC-Unique: CNSrHqA3O-Cul7-dBXQk2g-1
X-Mimecast-MFC-AGG-ID: CNSrHqA3O-Cul7-dBXQk2g_1768375663
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E10418005BA;
	Wed, 14 Jan 2026 07:27:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82EA91800285;
	Wed, 14 Jan 2026 07:27:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 0B77421E66C9; Wed, 14 Jan 2026 08:27:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>,  <qemu-devel@nongnu.org>,
  <shiju.jose@huawei.com>,  <linuxarm@huawei.com>,
  <linux-cxl@vger.kernel.org>,  Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu v2 2/5] hw/cxl/events: Update for rev3.2 common
 event record format
In-Reply-To: <20260113174735.00002934@huawei.com> (Jonathan Cameron's message
	of "Tue, 13 Jan 2026 17:47:35 +0000")
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
	<20260102151512.460766-3-Jonathan.Cameron@huawei.com>
	<87ldi3f2m2.fsf@pond.sub.org> <20260113174735.00002934@huawei.com>
Date: Wed, 14 Jan 2026 08:27:39 +0100
Message-ID: <874ioo64d0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

> On Mon, 12 Jan 2026 13:16:05 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>> 
>> > From: Shiju Jose <shiju.jose@huawei.com>
>> >
>> > CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record
>> > format has updated with optional Maintenance Operation Subclass,
>> > LD ID and ID of the device head information.
>> >
>> > Add updates for the above optional parameters in the related
>> > CXL events reporting and in the QMP commands to inject CXL events.
>> >
>> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Hi Markus,
> Thanks for taking a look!

You're welcome!

>> > ---
>> >  qapi/cxl.json               | 20 ++++++++---
>> >  include/hw/cxl/cxl_device.h |  7 +++-
>> >  include/hw/cxl/cxl_events.h | 15 ++++++--
>> >  hw/cxl/cxl-events.c         |  3 +-
>> >  hw/cxl/cxl-mailbox-utils.c  |  3 +-
>> >  hw/mem/cxl_type3.c          | 70 ++++++++++++++++++++++++++++++++-----
>> >  hw/mem/cxl_type3_stubs.c    | 24 +++++++++++--
>> >  7 files changed, 121 insertions(+), 21 deletions(-)
>> >
>> > diff --git a/qapi/cxl.json b/qapi/cxl.json
>> > index d5b86159f1..b3c2ac9575 100644
>> > --- a/qapi/cxl.json
>> > +++ b/qapi/cxl.json
>> > @@ -33,20 +33,32 @@
>> >  ##
>> >  # @CXLCommonEventBase:
>> >  #
>> > -# Common event base for a CXL Event (CXL r3.0 8.2.9.2.1
>> > -# Table 8-42 Common Event Record Format).
>> > +# Common event base for a CXL Event (CXL r3.2 8.2.10.2.1
>> > +# Table 8-55 Common Event Record Format).
>> >  #
>> >  # @path: CXL type 3 device canonical QOM path
>> >  #
>> >  # @log: event log to add the event to
>> >  #
>> > -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>> > +# @flags: Event Record Flags.  See CXL r3.2 Table 8-55 Common Event
>> >  #     Record Format, Event Record Flags for subfield definitions.
>> >  #
>> > +# @maint-op-class: Maintenance operation class the device requests to
>> > +#     initiate.
>> > +#
>> > +# @maint-op-subclass: Maintenance operation subclass the device
>> > +#     requests to initiate.
>> > +#
>> > +# @ld-id: LD ID of LD from where the event originated.  
>> 
>> What's an LD?
>
> Logical Device.  I'll spell it out the first time.

Yes, please.

>                                                    From the glossary:
> "LD: Logical Device. Entity that represents a CXL Endpoint that is bound to
> a VCS.  An SLD contains one LD. An MLD contains multiple LDs."

A line of acronyms marching ponderously across the page... made me laugh
:)

> So what does that actually mean?  It's a number that identifies the
> bit of a device that is presented to a given host at a particular
> point in the PCI topology that we are faking from the underlying CXL
> one. 
>
> I think best I can do is just spell out the acronyms. If people
> want more they need to look at the spec :(

Fair!

> Time for a deeper explanation that probably no one ever wanted :)
>
> From a physical topology point of view think of something like:
>
> vPPDs are virtual downstream ports that assign an LD ID.
>
> 	HOST 0           HOST 1               Host 3
> 	  |                 |                   |
>          RP                RP                  RP
>           |                 |                   |
>           |                 |                   |
>         __|_________________|______             |
>        |  |   SWITCH        |      |            |
>        | _|_____       _____|_     |            |
>        ||       |     |       |    |            |
>        ||       |     |       |    |            |
>        |vPPD0  vPPD1 VPPD2   VPPD3 |            |
>        ||       |     |          | |            |
>        ||_____________|          | |            |
>        |           |             | |            |
>        |___________DSP0________DSP1|            |
>                      |           |              |
>                      |       Some other dev     |
>               Traffic tagged                    | 
>               with an LD_ID associated with     |
>               a given vPPD (so 2 tags here)     |
>                      |                          |
>      ________________|__________________________|______
>     | (CXL Device) HEAD0                     HEAD1     |
>     |           Now splits up based         Only one LD|
>     |           on LD_ID                               |
>     |__________________________________________________|
>
>
> Hosts see:
> Used letters for down stream port numbers to avoid
> any explicit mapping to the physical ports above.
>
>
>           HOST 0                  Host 1             Host3   
>             |                       |                  |
>            RP                       RP                RP
>             |                       |                  |
>     ________|_________     _________|_________         |
>    |        |         |   |         |         |        |
>    |    ____|____     |   |   ______|______   |        |
>    |   |         |    |   |  |             |  |        |
>    |__DSPA______DSPB__|   |__DSPA________DSPB_|        |
>        |          |           |            |           |
>     ___|______  Nothing  _____|_____      Other dev ___|______
>    |CXL Type3 |          |CXL Type3 |              |CXL Type3 |
>    | (H0, LD0)|          | (H0, LD1)|              | (H1, LD0)|
>    |__________|          |__________|              |__________|
>
> These IDs should only be reported for events that are isolated 
> (as appropriate) to a head and/or LD and as you can see the hosts
> don't actually know these IDs even exist hence there is no need to
> report them via in band path.  If they don't take the values
> that reflect the LD we are actually talking to, then we are
> reporting someone else's error! Via out of band / switch CCI we
> see the top diagram where we definitely need LD_ID and HEAD_ID
> to make any sense of errors, particularly as the memory addresses
> in the records are specific to Head/LD pair.
>  
> The recommendation of the spec is don't set them for simple reporting
> over inband mailboxes. Now you might think we don't have out of band
> support upstream yet (my staging CXL tree does have both MCTP over
> I2C and USB) but we do have the switch CCI and that can tunnel to
> out of band interfaces (technically it's over PCI Vendor defined
> messages but in practice it ends up the same from a 'what can I talk
> to' point of view as something truely out of band like an I2C bus.
> We don't actually have event queues on those yet though... When
> we do we'll want this command to queue events there as well as on
> for inband path.

Truly more than I ever wanted ;)

> So we are adding them now for 2 reasons.
> 1) The spec allows it even for boring inband event reporting
>    (recommendation only to not do so) so we need to check the kernel stack
>    reports correctly.
> 2) We will want to add event queues on the out of band interfaces and
>    for those we'll need these IDs.

Makes sense.  Thanks!

>> > +#
>> > +# @head-id: ID of the device head from where the event originated.  
>> 
>> Are these identifiers taken from the CXL spec?
> Yes. Though feels odd to reference the glossary for the definitions.

Since they are from the CXL spec, I don't need to think about names that
are more in line with established QAPI naming conventions.  That's why I
asked.  We're good there.

>> > +#
>> >  # Since: 8.1
>> >  ##
>> >  { 'struct': 'CXLCommonEventBase',
>> > -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8' } }
>> > +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
>> > +            '*maint-op-class':'uint8', '*maint-op-subclass':'uint8',
>> > +            '*ld-id':'uint16', '*head-id':'uint8' } }
>> >  
>> >  ##
>> >  # @CXLGeneralMediaEvent:  
>> 
>> [...]

