Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1415D39FDA
	for <linux-cxl@vger.kernel.org>; Thu, 25 Apr 2024 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714024109; cv=none; b=EwnVcOkFTU4WPnAMEF6bfkK456LQzaT1TLRdOWvAW/0V5g0eZFYGGNDjfLYvoIFWltUEKz3kFXmk5nwmcmF6VRP8EWIIJcLc5ipf4OIijIam5PjHP2oH7H+pBmJy/k4ZwoFe9qKiJmkOcs33UgiW99LhD/TwoQxv0thXwLsIHWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714024109; c=relaxed/simple;
	bh=a7O8krwSJMDoM1fmzbYZIhgXM7Pm5gye95g6vwZibEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G7LjNhnWbkPA/eojqyMjS4v7P7OisBFVh1WSMjBtcg5zuYXkOXge//YPMMmjH8stWdv3Bbuce/DsLom0TdMkjlYAHivP+hofFbyRwtvmceHJjf/+XehWCwOQsbQV8ty2WhOOomXb0YI6NbtoraAmFQRbp7n8K9cHE2X2Vr8bqvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iT5yhU82; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iT5yhU82"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714024105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pq8lyW8pwhSXwTHGT5/PRxattYgKT2SYaChMD0oCzJM=;
	b=iT5yhU82afvcMqCY4IOi/eGHlKvc7FSW/HSWCzY/1+8ENzQ6e0uakVEm442ug2cRKdi3Rs
	6xK0RwuiL7YnGcPFzQHlIGaF89DObl+EwYBp7aymZCVmqeji8CqjaOb1KYtJT+nhbZkE44
	EanqRP5A/4H/y1ARLcMnlS9BM6It1LY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-8MLZg9TsN5mT7_ujXN9q1g-1; Thu, 25 Apr 2024 01:48:21 -0400
X-MC-Unique: 8MLZg9TsN5mT7_ujXN9q1g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AF96811029;
	Thu, 25 Apr 2024 05:48:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 073061C0F120;
	Thu, 25 Apr 2024 05:48:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id F01C321E6680; Thu, 25 Apr 2024 07:48:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: fan <nifan.cxl@gmail.com>
Cc: qemu-devel@nongnu.org,  jonathan.cameron@huawei.com,
  linux-cxl@vger.kernel.org,  gregory.price@memverge.com,
  ira.weiny@intel.com,  dan.j.williams@intel.com,
  a.manzanares@samsung.com,  dave@stgolabs.net,  nmtadam.samsung@gmail.com,
  jim.harris@samsung.com,  Jorgen.Hansen@wdc.com,  wj28.lee@gmail.com,  Fan
 Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
In-Reply-To: <ZilDz3X5hmda5oNr@debian> (fan's message of "Wed, 24 Apr 2024
	10:39:27 -0700")
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-10-nifan.cxl@gmail.com>
	<87a5livrdr.fsf@pond.sub.org> <ZilDz3X5hmda5oNr@debian>
Date: Thu, 25 Apr 2024 07:48:18 +0200
Message-ID: <87plue9en1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

fan <nifan.cxl@gmail.com> writes:

> On Wed, Apr 24, 2024 at 03:09:52PM +0200, Markus Armbruster wrote:
>> nifan.cxl@gmail.com writes:
>> 
>> > From: Fan Ni <fan.ni@samsung.com>
>> >
>> > Since fabric manager emulation is not supported yet, the change implements
>> > the functions to add/release dynamic capacity extents as QMP interfaces.
>> 
>> Will fabric manager emulation obsolete these commands?
>
> If in the future, fabric manager emulation supports commands for dynamic capacity
> extent add/release, it is possible we do not need the commands.
> But it seems not to happen soon, we need the qmp commands for the
> end-to-end test with kernel DCD support.

I asked because if the commands are temporary testing aids, they should
probably be declared unstable.  Even if they are permanent testing aids,
unstable might be the right choice.  This is for the CXL maintainers to
decide.

What does "unstable" mean?  docs/devel/qapi-code-gen.rst: "Interfaces so
marked may be withdrawn or changed incompatibly in future releases."

Management applications need stable interfaces.  Libvirt developers
generally refuse to touch anything in QMP that's declared unstable.

Human users and their ad hoc scripts appreciate stability, but they
don't need it nearly as much as management applications do.

A stability promise increases the maintenance burden.  By how much is
unclear.  In other words, by promising stability, the maintainers take
on risk.  Are the CXL maintainers happy to accept the risk here?

>> > Note: we skips any FM issued extent release request if the exact extent
>> > does not exist in the extent list of the device. We will loose the
>> > restriction later once we have partial release support in the kernel.
>> >
>> > 1. Add dynamic capacity extents:
>> >
>> > For example, the command to add two continuous extents (each 128MiB long)
>> > to region 0 (starting at DPA offset 0) looks like below:
>> >
>> > { "execute": "qmp_capabilities" }
>> >
>> > { "execute": "cxl-add-dynamic-capacity",
>> >   "arguments": {
>> >       "path": "/machine/peripheral/cxl-dcd0",
>> >       "region-id": 0,
>> >       "extents": [
>> >       {
>> >           "dpa": 0,
>> >           "len": 134217728
>> >       },
>> >       {
>> >           "dpa": 134217728,
>> >           "len": 134217728
>> >       }
>> >       ]
>> >   }
>> > }
>> >
>> > 2. Release dynamic capacity extents:
>> >
>> > For example, the command to release an extent of size 128MiB from region 0
>> > (DPA offset 128MiB) look like below:
>> >
>> > { "execute": "cxl-release-dynamic-capacity",
>> >   "arguments": {
>> >       "path": "/machine/peripheral/cxl-dcd0",
>> >       "region-id": 0,
>> >       "extents": [
>> >       {
>> >           "dpa": 134217728,
>> >           "len": 134217728
>> >       }
>> >       ]
>> >   }
>> > }
>> >
>> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
>> 
>> [...]
>> 
>> > diff --git a/qapi/cxl.json b/qapi/cxl.json
>> > index 8cc4c72fa9..2645004666 100644
>> > --- a/qapi/cxl.json
>> > +++ b/qapi/cxl.json
>> > @@ -19,13 +19,16 @@
>> >  #
>> >  # @fatal: Fatal Event Log
>> >  #
>> > +# @dyncap: Dynamic Capacity Event Log
>> > +#
>> >  # Since: 8.1
>> >  ##
>> >  { 'enum': 'CxlEventLog',
>> >    'data': ['informational',
>> >             'warning',
>> >             'failure',
>> > -           'fatal']
>> > +           'fatal',
>> > +           'dyncap']
>> 
>> We tend to avoid abbreviations in QMP identifiers: dynamic-capacity.
>
> FYI. This has been removed to avoid the potential side effect in the
> latest post.
> v7: https://lore.kernel.org/linux-cxl/ZiaFYUB6FC9NR7W4@memverge.com/T/#t
>
>> 
>> >   }
>> >  
>> >  ##
>> > @@ -361,3 +364,59 @@
>> >  ##
>> >  {'command': 'cxl-inject-correctable-error',
>> >   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
>> > +
>> > +##
>> > +# @CXLDCExtentRecord:
>> 
>> Such traffic jams of capital letters are hard to read.
>> 
>> What does DC mean?
>
> Dynamic capacity

Suggest CxlDynamicCapacityExtent.

>> > +#
>> > +# Record of a single extent to add/release
>> > +#
>> > +# @offset: offset to the start of the region where the extent to be operated
>> 
>> Blank line here, please
>> 
>> > +# @len: length of the extent
>> > +#
>> > +# Since: 9.0
>> > +##
>> > +{ 'struct': 'CXLDCExtentRecord',
>> > +  'data': {
>> > +      'offset':'uint64',
>> > +      'len': 'uint64'
>> > +  }
>> > +}
>> > +
>> > +##
>> > +# @cxl-add-dynamic-capacity:
>> > +#
>> > +# Command to start add dynamic capacity extents flow. The device will
>> 
>> I think we're missing an article here.  Is it "a flow" or "the flow"?
>> 
>> > +# have to acknowledged the acceptance of the extents before they are usable.
>> 
>> to acknowledge
>
> It should be "to be acknowledged". 
>
>> 
>> docs/devel/qapi-code-gen.rst:
>> 
>>     For legibility, wrap text paragraphs so every line is at most 70
>>     characters long.
>> 
>>     Separate sentences with two spaces.
>
> Thanks. Will fix.
>> 
>> > +#
>> > +# @path: CXL DCD canonical QOM path
>> 
>> What is a CXL DCD?  Is it a device?
>
> Dynamic capacity device.
> Yes. It is cxl memory device that can change capacity dynamically.

Sure the QOM path needs to be canonical?

If not, what about "path to the CXL dynamic capacity device in the QOM
tree".  Intentionally close to existing descriptions of @qom-path
elsewhere.

>> I'd prefer @qom-path, unless you can make a consistency argument for
>> @path.
>> 
>> > +# @region-id: id of the region where the extent to add
>> 
>> What's a region, and how do they get their IDs?
>
> Each DCD device can support up to 8 regions (0-7).  

Is "region ID" the established terminology in CXL-land?  Or is "region
number" also used?  I'm asking because "ID" in this QEMU device context
suggests a connection to a qdev ID.

If region number is fine, I'd rename to just @region, and rephrase the
description to avoid "ID".  Perhaps "number of the region the extent is
to be added to".  Not entirely happy with the phrasing, doesn't exactly
roll off the tongue, but "where the extent to add" sounds worse to my
ears.  Mind, I'm not a native speaker.

>> > +# @extents: Extents to add
>> 
>> Blank lines between argument descriptions, please.
>> 
>> > +#
>> > +# Since : 9.0
>> 
>> 9.1
>
> Already fixed in the latest post.
>
>> 
>> > +##
>> > +{ 'command': 'cxl-add-dynamic-capacity',
>> > +  'data': { 'path': 'str',
>> > +            'region-id': 'uint8',
>> > +            'extents': [ 'CXLDCExtentRecord' ]
>> > +           }
>> > +}
>> > +
>> > +##
>> > +# @cxl-release-dynamic-capacity:
>> > +#
>> > +# Command to start release dynamic capacity extents flow. The host will
>> 
>> Article again.
>> 
>> The host?  In cxl-add-dynamic-capacity's doc comment, it's the device.
>
> For add command, the host will send a mailbox command to response to the add
> request to the device to indicate whether it accepts the add capacity offer
> or not.
>
> For release command, the host send a mailbox command (not always a response
> since the host can proactively release capacity if it does not need it
> any more) to device to ask device release the capacity.
>
> But yes, the text needs to be polished.

Please do.  You may have to briefly explain which peer initiates what
for this to make sense.

>> > +# need to respond to indicate that it has released the capacity before it
>> > +# is made unavailable for read and write and can be re-added.
>> 
>> Is "and can be re-added" relevant here?
>
> Not really. Will fix.
>
>> 
>> > +#
>> > +# @path: CXL DCD canonical QOM path
>> > +# @region-id: id of the region where the extent to release
>> > +# @extents: Extents to release
>> > +#
>> > +# Since : 9.0
>> 
>> 9.1
>
> Already fixed in the latest post.
>
> Thanks again for the review. Will take care of the comments in the next
> version.

You're welcome!

> Fan
>> 
>> > +##
>> > +{ 'command': 'cxl-release-dynamic-capacity',
>> > +  'data': { 'path': 'str',
>> > +            'region-id': 'uint8',
>> > +            'extents': [ 'CXLDCExtentRecord' ]
>> > +           }
>> > +}
>> 

