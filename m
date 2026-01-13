Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792B434EEFC
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768326462; cv=none; b=hRmyWwiLHnxUjiFhLsmlRc4nQyJqJSmOARTA1yVsLP3EY7Tweq83o3giZ+l8RIEaq6y87MYUwFYHVcIrOqzIMOIB97ccaOVsqElZOXCSlGASt2ZXFBHFhYRe8QI5/wQQejAjD0dwm7N1CqKcxEBCZTBLUyuU9pbRkd2ixjfr0/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768326462; c=relaxed/simple;
	bh=cnF7gL+f498xD3emMp74viD9O3aPL35VADjMMOGdYlA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWahccka7MzmgtBicrtwAECXFE8gYnobG29Wt0QcX5Saufj9vb66GOQyD22+1vTaevYf9FOfbEM5Pz4ctos+UAAb0o06zLotyYhocOK8IwoFzToN6RbmO8FMwJswhYZRVUYBIeYE5TMTAPhDZSizwa8Fm7wzHkUDK1wpdQ76r2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drGsf4tW6zHnGh7;
	Wed, 14 Jan 2026 01:47:18 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 12E9B40086;
	Wed, 14 Jan 2026 01:47:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 13 Jan
 2026 17:47:36 +0000
Date: Tue, 13 Jan 2026 17:47:35 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Markus Armbruster <armbru@redhat.com>
CC: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
	<shiju.jose@huawei.com>, <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu v2 2/5] hw/cxl/events: Update for rev3.2 common
 event record format
Message-ID: <20260113174735.00002934@huawei.com>
In-Reply-To: <87ldi3f2m2.fsf@pond.sub.org>
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
	<20260102151512.460766-3-Jonathan.Cameron@huawei.com>
	<87ldi3f2m2.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 12 Jan 2026 13:16:05 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>=20
> > From: Shiju Jose <shiju.jose@huawei.com>
> >
> > CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record
> > format has updated with optional Maintenance Operation Subclass,
> > LD ID and ID of the device head information.
> >
> > Add updates for the above optional parameters in the related
> > CXL events reporting and in the QMP commands to inject CXL events.
> >
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi Markus,
Thanks for taking a look!

> > ---
> >  qapi/cxl.json               | 20 ++++++++---
> >  include/hw/cxl/cxl_device.h |  7 +++-
> >  include/hw/cxl/cxl_events.h | 15 ++++++--
> >  hw/cxl/cxl-events.c         |  3 +-
> >  hw/cxl/cxl-mailbox-utils.c  |  3 +-
> >  hw/mem/cxl_type3.c          | 70 ++++++++++++++++++++++++++++++++-----
> >  hw/mem/cxl_type3_stubs.c    | 24 +++++++++++--
> >  7 files changed, 121 insertions(+), 21 deletions(-)
> >
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index d5b86159f1..b3c2ac9575 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -33,20 +33,32 @@
> >  ##
> >  # @CXLCommonEventBase:
> >  #
> > -# Common event base for a CXL Event (CXL r3.0 8.2.9.2.1
> > -# Table 8-42 Common Event Record Format).
> > +# Common event base for a CXL Event (CXL r3.2 8.2.10.2.1
> > +# Table 8-55 Common Event Record Format).
> >  #
> >  # @path: CXL type 3 device canonical QOM path
> >  #
> >  # @log: event log to add the event to
> >  #
> > -# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> > +# @flags: Event Record Flags.  See CXL r3.2 Table 8-55 Common Event
> >  #     Record Format, Event Record Flags for subfield definitions.
> >  #
> > +# @maint-op-class: Maintenance operation class the device requests to
> > +#     initiate.
> > +#
> > +# @maint-op-subclass: Maintenance operation subclass the device
> > +#     requests to initiate.
> > +#
> > +# @ld-id: LD ID of LD from where the event originated. =20

Logical Device.  I'll spell it out the first time. From the glossary:
"LD: Logical Device. Entity that represents a CXL Endpoint that is bound to
a VCS.  An SLD contains one LD. An MLD contains multiple LDs."

So what does that actually mean?  It's a number that identifies the
bit of a device that is presented to a given host at a particular
point in the PCI topology that we are faking from the underlying CXL
one.=20

I think best I can do is just spell out the acronyms. If people
want more they need to look at the spec :(

Time for a deeper explanation that probably no one ever wanted :)

=46rom a physical topology point of view think of something like:

vPPDs are virtual downstream ports that assign an LD ID.

	HOST 0           HOST 1               Host 3
	  |                 |                   |
         RP                RP                  RP
          |                 |                   |
          |                 |                   |
        __|_________________|______             |
       |  |   SWITCH        |      |            |
       | _|_____       _____|_     |            |
       ||       |     |       |    |            |
       ||       |     |       |    |            |
       |vPPD0  vPPD1 VPPD2   VPPD3 |            |
       ||       |     |          | |            |
       ||_____________|          | |            |
       |           |             | |            |
       |___________DSP0________DSP1|            |
                     |           |              |
                     |       Some other dev     |
              Traffic tagged                    |=20
              with an LD_ID associated with     |
              a given vPPD (so 2 tags here)     |
                     |                          |
     ________________|__________________________|______
    | (CXL Device) HEAD0                     HEAD1     |
    |           Now splits up based         Only one LD|
    |           on LD_ID                               |
    |__________________________________________________|


Hosts see:
Used letters for down stream port numbers to avoid
any explicit mapping to the physical ports above.


          HOST 0                  Host 1             Host3  =20
            |                       |                  |
           RP                       RP                RP
            |                       |                  |
    ________|_________     _________|_________         |
   |        |         |   |         |         |        |
   |    ____|____     |   |   ______|______   |        |
   |   |         |    |   |  |             |  |        |
   |__DSPA______DSPB__|   |__DSPA________DSPB_|        |
       |          |           |            |           |
    ___|______  Nothing  _____|_____      Other dev ___|______
   |CXL Type3 |          |CXL Type3 |              |CXL Type3 |
   | (H0, LD0)|          | (H0, LD1)|              | (H1, LD0)|
   |__________|          |__________|              |__________|

These IDs should only be reported for events that are isolated=20
(as appropriate) to a head and/or LD and as you can see the hosts
don't actually know these IDs even exist hence there is no need to
report them via in band path.  If they don't take the values
that reflect the LD we are actually talking to, then we are
reporting someone else's error! Via out of band / switch CCI we
see the top diagram where we definitely need LD_ID and HEAD_ID
to make any sense of errors, particularly as the memory addresses
in the records are specific to Head/LD pair.
=20
The recommendation of the spec is don't set them for simple reporting
over inband mailboxes. Now you might think we don't have out of band
support upstream yet (my staging CXL tree does have both MCTP over
I2C and USB) but we do have the switch CCI and that can tunnel to
out of band interfaces (technically it's over PCI Vendor defined
messages but in practice it ends up the same from a 'what can I talk
to' point of view as something truely out of band like an I2C bus.
We don't actually have event queues on those yet though... When
we do we'll want this command to queue events there as well as on
for inband path.

So we are adding them now for 2 reasons.
1) The spec allows it even for boring inband event reporting
   (recommendation only to not do so) so we need to check the kernel stack
   reports correctly.
2) We will want to add event queues on the out of band interfaces and
   for those we'll need these IDs.

>=20
> What's an LD?
>=20
> > +#
> > +# @head-id: ID of the device head from where the event originated. =20
>=20
> Are these identifiers taken from the CXL spec?
Yes. Though feels odd to reference the glossary for the definitions.
>=20
> > +#
> >  # Since: 8.1
> >  ##
> >  { 'struct': 'CXLCommonEventBase',
> > -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8' } }
> > +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
> > +            '*maint-op-class':'uint8', '*maint-op-subclass':'uint8',
> > +            '*ld-id':'uint16', '*head-id':'uint8' } }
> > =20
> >  ##
> >  # @CXLGeneralMediaEvent: =20
>=20
> [...]
>=20
>=20

