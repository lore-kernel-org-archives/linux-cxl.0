Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2A3149C4C
	for <linux-cxl@vger.kernel.org>; Tue,  4 Jun 2024 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512604; cv=none; b=nPAl8Qao/OjsizSzTtOCOQy612rAN6WYacta5dNPwfEnkYL0I9c/YqldH1czKkS6vlCo4JcRXY6t18/cuYw9N62wPLl8avvOMNH0q2+3Xgl5rE/ZGm3FJUaU2rEjbrjOqOYVTrgmxdE6F+KlT/1cwp9C92DAuZTfVVYKg4z/lRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512604; c=relaxed/simple;
	bh=1EA77EHT/ijBeEnO7KHdK96/6WxfOXrR6ECkwjNYoCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YNbM+VPGVvvTZTaDitYMN6/GrzVrSL8g1GAHdI2XvOfibyDdh6vC458aEhgKwDaAU/poQR7YhAsZeB6PxwMpQ3NB523GMnCJYMVHPtoJHE2dwl6LjwbWNkhY9kyJTCoNJyJCeWLi4cx2Js2hraL4UJSaJtP8JToT0fA+RdHy0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eASpAY+q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eASpAY+q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717512601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p5n9mKXXj70nTIBdZfuXHq/cSlUhF4A+DspURC2e2y0=;
	b=eASpAY+qLmRb5deJ6hxxho8NrR38CeNU5H/60n7Mt2GkmHOtxQZ3aIRqpFQtdsIgcUueL6
	sKAphrO0QoVw6jMJUuCPWIq/gtWh/ZH8RhuOefiO3nyKK8/S+Ek4uRfkEi+Yn1+h/SHlvY
	AHcZe22J6Jn4O1sZMxb2mA+E5ypnU4g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-vNdGRakhNCmURGZyWx2IlA-1; Tue, 04 Jun 2024 10:49:58 -0400
X-MC-Unique: vNdGRakhNCmURGZyWx2IlA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87EFE185B920;
	Tue,  4 Jun 2024 14:49:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B71B1C060CE;
	Tue,  4 Jun 2024 14:49:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 0F30B21E668A; Tue,  4 Jun 2024 16:49:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: <nifan.cxl@gmail.com>,  <qemu-devel@nongnu.org>,
  <linux-cxl@vger.kernel.org>,  <gregory.price@memverge.com>,
  <ira.weiny@intel.com>,  <dan.j.williams@intel.com>,
  <a.manzanares@samsung.com>,  <dave@stgolabs.net>,
  <nmtadam.samsung@gmail.com>,  <jim.harris@samsung.com>,
  <Jorgen.Hansen@wdc.com>,  <wj28.lee@gmail.com>,  <mst@redhat.com>,  Fan
 Ni <fan.ni@samsung.com>,  Svetly Todorov <svetly.todorov@memverge.com>
Subject: Re: [PATCH v8 11/14] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
In-Reply-To: <20240604125554.00005549@Huawei.com> (Jonathan Cameron's message
	of "Tue, 4 Jun 2024 12:55:54 +0100")
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
	<20240523174651.1089554-12-nifan.cxl@gmail.com>
	<87o78hb2ra.fsf@pond.sub.org> <20240604125554.00005549@Huawei.com>
Date: Tue, 04 Jun 2024 16:49:40 +0200
Message-ID: <87ikyo69vf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Tue, 04 Jun 2024 09:12:09 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> nifan.cxl@gmail.com writes:
>> 
>> > From: Fan Ni <fan.ni@samsung.com>
>> >
>> > To simulate FM functionalities for initiating Dynamic Capacity Add
>> > (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL spec
>> > r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces to issue
>> > add/release dynamic capacity extents requests.
>> >
>> > With the change, we allow to release an extent only when its DPA range
>> > is contained by a single accepted extent in the device. That is to say,
>> > extent superset release is not supported yet.
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
>> >       "host-id": 0,
>> >       "selection-policy": "prescriptive",
>> >       "region": 0,
>> >       "extents": [
>> >       {
>> >           "offset": 0,
>> >           "len": 134217728
>> >       },
>> >       {
>> >           "offset": 134217728,
>> >           "len": 134217728
>> >       }
>> >       ]
>> >   }
>> > }
>> >
>> > 2. Release dynamic capacity extents:
>> >
>> > For example, the command to release an extent of size 128MiB from region 0
>> > (DPA offset 128MiB) looks like below:
>> >
>> > { "execute": "cxl-release-dynamic-capacity",
>> >   "arguments": {
>> >       "path": "/machine/peripheral/cxl-dcd0",
>> >       "host-id": 0,
>> >       "removal-policy":"prescriptive",
>> >       "region": 0,
>> >       "extents": [
>> >       {
>> >           "offset": 134217728,
>> >           "len": 134217728
>> >       }
>> >       ]
>> >   }
>> > }
>> >
>> > Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
>> > Reviewed-by: Gregory Price <gregory.price@memverge.com>
>> > Signed-off-by: Fan Ni <fan.ni@samsung.com>  
>> 
>
> Hi Markus,
>
> Thanks for the detailed review.
>
> Fan is traveling for a few weeks and may have intermittent internet.
> He asked me to help with any feedback that came in during this period.
>
> Perhaps at this stage (as Michael has this queued) best bet is a follow on patch
> tweaking things.  The blast radius is more or less contained to the
> qmp file subject to a few parameter type changes.  I'd be keen on this
> approach if possible because that lets me start attacking the annoyingly
> large queue of stuff dependent on this series in parallel with
> improving this aspect.

Sacrifices git history tidiness for development velocity.  Judgement
call.

> Proposed draft patch at end of this email and responses to individual
> comments inline.
>
> I'll do a separate patch in response to your suggestion to mark the
> two interfaces unstable.  For now seems there is little disadvantage
> in doing so as I assume there is nothing stopping us removing
> that marking in a cycle or two if things look stable.

We can certainly make things stable when we're reasonably convinced they
are, and have a need for it.

>> [...]
>> 
>> > diff --git a/qapi/cxl.json b/qapi/cxl.json
>> > index 4281726dec..57d9f82014 100644
>> > --- a/qapi/cxl.json
>> > +++ b/qapi/cxl.json
>> > @@ -361,3 +361,146 @@
>> >  ##
>> >  {'command': 'cxl-inject-correctable-error',
>> >   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
>> > +
>> > +##
>> > +# @CXLDynamicCapacityExtent:  
>> 
>> Three existing type names start with Cxl, and only one starts with CXL.
>> Please make your new ones start with Cxl, not CXL:
>> CxlDynamicCapacityExtent.
> Ok. 
>> 
>> > +#
>> > +# A single dynamic capacity extent
>> > +#
>> > +# @offset: The offset (in bytes) to the start of the region
>> > +#     where the extent belongs to.
>> > +#
>> > +# @len: The length of the extent in bytes.  
>> 
>> What is this?  Memory?
>
> Yes.  Probably makes more sense to add to the initial description rather
> than down here.
>
> # A single dynamic capacity extent.  This is a contiguous allocation
> # of memory by Device Physical Address within a single Dynamic Capacity
> # Region on a CXL Type 3 device.

Yes, that's better.

> This is all a bit of a balance between not quoting large chunks of
> the specification and providing enough detail here.

Yes.

> Reality is that people who don't know what this is, won't use this
> interface.  We can add some additional documentation to introduce
> all the concepts but it probably doesn't make sense to do so here.

I suggest to try combining references to the spec with just enough
explanation to serve as reminders for the people familiar with this
stuff, and maybe even as terse overview for the rest of us.

>> > +#
>> > +# Since: 9.1
>> > +##
>> > +{ 'struct': 'CXLDynamicCapacityExtent',
>> > +  'data': {
>> > +      'offset':'uint64',
>> > +      'len': 'uint64'
>> > +  }
>> > +}
>> > +
>> > +##
>> > +# @CXLExtSelPolicy:  
>> 
>> CxlExtentSelectionPolicy
>> 
>> > +#
>> > +# The policy to use for selecting which extents comprise the added
>> > +# capacity, as defined in cxl spec r3.1 Table 7-70.  
>> 
>> Use the official title: "as defined in the CXL Specification 3.1" (I
>> think, the actual document is behind a click-through agreement).
>
> Sadly not that simple, hence the desire for an abbreviation. Should be
>
> Compute Express Link (CXL) Specification, Revision 3.1, Version 1.0
>
> Can drop the Version 1.0 (as there have never been other versions and
> probably won't be) but the Revision part matters (unfortunately)
> hence the r in the above.
>
> Not that we've used CXL r3.0 etc in previous QMP docs for this. Perhaps
> just sticking to that and relying on the reference in
> docs/system/devices/cxl.rst for the canonical reference.
>
> For now I'll go with the (almost) full form here as it's never wrong to
> spell it out.  So all the new references will be to
> Compute Express Link (CXL) Specification, Revision 3.1, Section xxxx

Abbreviating a long title is okay as long the full title is still easy
enough to find.  But always abbreviate the same way, please.

>> > +#
>> > +# @free: 0h = Free
>> > +#
>> > +# @contiguous: 1h = Continuous  
>> 
>> What does "1h =" mean?  The numeric encoding?
> Alignment with spec, but doesn't need to be here so removed.
>
>> 
>> What exactly is "contiguous" / "continuous"?  I figure it's clear enough
>> if you have the CXL spec open in another window.  Can we condense it
>> into one phrase for use here?
>
> @free: Device is responsible for allocating the requested memory
>      capacity and is free to do this using any combination of
>      supported extents.
>
> @contiguous: Device is responsible for allocating the requested
>      memory capacity but must do so as a single contiguous
>      extent.
>
> @prescriptive: The precise set of extents to be allocated is specified
>      by the command.  Thus allocation is being managed by the
>      issuer of the allocation command, not the device.
>
> @enable-shared-access: Capacity has already been allocated to a
>      different host using free, contiguous or prescriptive methods with
>      a known tag. This policy then instructs the device to make the
>      capacity with the specified tag available to an additional host.
>      Capacity is implicit as it matches that already associated with the
>      tag. Note that the extent list (and hence DPAs)
>      used are per host, so a device may use different representations
>      on each host. The ordering of the extents provided to each host
>      is indicated to the host using per extent sequence numbers generated
>      by the device. Has a similar
>      meaning for temporal sharing but in that case there may be only
>      one host involved.

Better.

Feel free to omit some of the detail from the last one.

>> > +#
>> > +# @prescriptive: 2h = Prescriptive
>> > +#
>> > +# @enable-shared-access: 3h = Enable Shared Access  
>> 
>> Similar questions.
>> 
>> > +#
>> > +# Since: 9.1
>> > +##
>> > +{ 'enum': 'CXLExtSelPolicy',
>> > +  'data': ['free',
>> > +           'contiguous',
>> > +           'prescriptive',
>> > +           'enable-shared-access']
>> > +}
>> > +
>> > +##
>> > +# @cxl-add-dynamic-capacity:
>> > +#
>> > +# Command to initiate to add dynamic capacity extents to a host.  It  
>> 
>> "Initiate adding dynamic capacity extents"
> Done.
>> 
>> When a command initiates something, we commonly need a way to detect
>> completion, and sometimes need a way to track progress.
>> 
>> How can we detect completion, and if we can't, why's that okay?
>> 
>> Can adding capacity fail after the command succeeded?  If yes, how can
>> we detect that?
>
> The full flow can fail, in the sense that the host can reject the offered
> capacity.
> This command just initiates the flow.
>
> Today we can't detect it via QMP. There are a could of options but I
> think they are out of scope for this document (for now).
> There are a lot more DCD features to come and I'd include a
> resolution to this aspect as one of those.  Aim today is just
> to get to the point where we can test the OS handling - other
> cases like virtualization of this require a lot more infrastructure
> on top of what we have here.

Sounds scary...

> So likely options:
>
> * The 'fabric manager' will have an out of band path to the OS as it
>   doesn't spontaneously decide to offer capacity - that happens
>   because an orchestrator (think kubernetes or similar) has told a
>   host to bring up an application that needs this extra capacity.
>   That path would typically include an acknowledgment that the capacity
>   has turned up and the host can run what it was asked to run.
>
>   There is an inband path for a real fabric manager interface that
>   we don't yet have an equivalent of in QEMU. An earlier version
>   of this patch set provided a hacky equivalent so was dropped.
>   That path is the Fabric Manager side Dynamic Capacity Event Log
>   which has events for this
>  0x4 Add Capacity Response:
> " The host has responded to the Add Capacity event and the Dynamic
>   Capacity Extent field in this structure specifies the capacity
>   accepted by the host.  This event shall only be reported
>   to the FM"
> 0x5 is the similar one for release.
>
> So long term there is probably a need for a reporting interface
> but lots more to do in general and I think this is functional
> without that.  For now I think all we can do is document that
> discovering success must be done via an out of band interface.
>
> I've added:
> " Note that, currently, establishing success or failure of the full Add Dynamic
>   Capacity flow requires out of band communication with the OS of
>   the CXL host."
>
> Does that work for now?  We will have to remember to update if/when
> we add a way to query this.

Good enough for an unstable interface.

> Also clear we could benefit from some additional documentation
> in cxl.rst.  That's a job for another day however - for now to
> get the details users will have to read the CXL specification or
> may watch a bunch of conference videos and webinars at least.

Would it make sense to add a short paragaph on what's missing there?

>> How long until completion after the command succeeded?  Unbounded time?
>
> Depends on the host, and indeed unbounded - ultimately there is an abort
> path (forced removal later in this doc) but it is sometimes fatal for the
> OS running and only meant for the case where the host OS crashed.
> Not many operating systems play well with force removal of memory and due
> to a race condition it may looks like that to the host.  So basically
> it's a 'don't use this' kind of hardware feature.
>
> However it's not that QEMU is waiting for it beyond  having some tracking
> structures allocated that are not freed until the flow has finished.
> This is very much an an asynchronous flow.

Vaguely similar: when device_del merely initiates hot unplug, and
completion requires guest cooperation.  This puts management
applications into an awkward position.  What if they don't get
DEVICE_DELETED event within a reasonable time?  What is a reasonable
time?  We later added DEVICE_UNPLUG_GUEST_ERROR to avoid this for the
common case of well-behaved guests.

I'm not asking you to do anything about this now.  Spelling it out in
documentation seems advisable, though.

>> > +# simulates operations defined in cxl spec r3.1 7.6.7.6.5.  
>> 
>> "defined in the CXL Specification 3.1 section 7.6.7.6.5"
>> 
>> More of the same below, not noting it again.
> Sure. Hopefully fixed throughout the new text. I've not taken
> on the existing cases today.
>
>> 
>> > +#
>> > +# @path: CXL DCD canonical QOM path.  
>> 
>> Sure the QOM path needs to be canonical?
>> 
>> If not, what about "path to the CXL dynamic capacity device in the QOM
>> tree".  Intentionally close to existing descriptions of @qom-path
>> elsewhere.
>
> That text LGTM. I'll focus only on new cases of this for an initial
> patch but there are a load of other cases of this text that will
> want updating separately.

Okay.

>> > +#
>> > +# @host-id: The "Host ID" field as defined in cxl spec r3.1
>> > +#     Table 7-70.
>> > +#
>> > +# @selection-policy: The "Selection Policy" bits as defined in
>> > +#     cxl spec r3.1 Table 7-70.  It specifies the policy to use for
>> > +#     selecting which extents comprise the added capacity.
>> > +#
>> > +# @region: The "Region Number" field as defined in cxl spec r3.1
>> > +#     Table 7-70.  The dynamic capacity region where the capacity
>> > +#     is being added.  Valid range is from 0-7.  
>> 
>> Scratch the second sentence?
>
> Sure, I guess because nearly everything else is just a spec reference
> and this isn't adding enough info to be useful?

One, it adds relatively little over "region number", and two, it's not
actually a sentence ;)

>> 
>> > +#
>> > +# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-70.
>> > +#
>> > +# @extents: The "Extent List" field as defined in cxl spec r3.1
>> > +#     Table 7-70.
>> > +#
>> > +# Since : 9.1
>> > +##
>> > +{ 'command': 'cxl-add-dynamic-capacity',
>> > +  'data': { 'path': 'str',
>> > +            'host-id': 'uint16',
>> > +            'selection-policy': 'CXLExtSelPolicy',
>> > +            'region': 'uint8',
>> > +            '*tag': 'str',
>> > +            'extents': [ 'CXLDynamicCapacityExtent' ]
>> > +           }
>> > +}
>> > +
>> > +##
>> > +# @CXLExtRemovalPolicy:  
>> 
>> CxlExtentRemovalPolicy
> Done this and similar.
>> 
>> > +#
>> > +# The policy to use for selecting which extents comprise the released
>> > +# capacity, defined in the "Flags" field in cxl spec r3.1 Table 7-71.
>> > +#
>> > +# @tag-based: value = 0h.  Extents are selected by the device based
>> > +#     on tag, with no requirement for contiguous extents.
>> > +#
>> > +# @prescriptive: value = 1h.  Extent list of capacity to release is
>> > +#     included in the request payload.  
>> 
>> I guess "value = ..." documents the numeric value.  Sure that's useful
>> here?
>
> Dropped as not useful here.
>
>> 
>> > +#
>> > +# Since: 9.1
>> > +##
>> > +{ 'enum': 'CXLExtRemovalPolicy',
>> > +  'data': ['tag-based',
>> > +           'prescriptive']
>> > +}
>> > +
>> > +##
>> > +# @cxl-release-dynamic-capacity:
>> > +#
>> > +# Command to initiate to release dynamic capacity extents from a  
>> 
>> "Initiate releasing dynamic capacity extents"
>> 
>> When a command initiates something, we commonly need a way to detect
>> completion, and sometimes need a way to track progress.  See
>> cxl-add-dynamic-capacity above.
>> 
>
> Effectively same reply.  Today you can only do this via out of band
> comms with the host.  We have quite a lot more to add before we
> can report this via QMP. This is very much part 1 of DCD support,
> I'd expect us to be still adding features in a year or more.
>
> I'll add similar text to proposed for the add path.
>
> ...
>
>> 
>> > +#     capacity as a result of this request.  
>> 
>> What does it mean "to sanitize capacity"?  Is this about scrubbing the
>> memory?
>
> For one meaning of scrubbing.  Not the one that is normally applied to
> memory which is patrol scrub / ECC error detection and correction and
> subject to a long kernel mailing list thread at the moment and another
> QEMU patch set on my queue..  
>
> Why can't we have a be dictionary of canonical terms. Ah well.
> Added a slightly shortened quote from the CXL spec.
> "This Ensures that all user data and metadata is made permanently

ensures

>  unavailable by whatever means is appropriate for the media type.
>  Note that changing encryption keys is not sufficient."
>
> The last bit is because we will shortly have secure erase support
> via another patch set and in that case changing encryption keys is
> sufficient.

Works for me.

>> > +#
>> > +# @region: The "Region Number" field as defined in cxl spec r3.1
>> > +#     Table 7-71.  The dynamic capacity region where the capacity
>> > +#     is being added.  Valid range is from 0-7.  
>> 
>> My comment on cxl-add-dynamic-capacity argument @region applies.
> "The dynamic capacity region where the capacity is being added."
> sentence dropped.
>
>> 
>> > +#
>> > +# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-71.
>> > +#
>> > +# @extents: The "Extent List" field as defined in cxl spec r3.1
>> > +#     Table 7-71.
>> > +#
>> > +# Since : 9.1
>> > +##
>> > +{ 'command': 'cxl-release-dynamic-capacity',
>> > +  'data': { 'path': 'str',
>> > +            'host-id': 'uint16',
>> > +            'removal-policy': 'CXLExtRemovalPolicy',
>> > +            '*forced-removal': 'bool',
>> > +            '*sanitize-on-release': 'bool',
>> > +            'region': 'uint8',
>> > +            '*tag': 'str',
>> > +            'extents': [ 'CXLDynamicCapacityExtent' ]
>> > +           }
>> > +}  
>> 
>
> So with all that incorporated, what I currently have is:
>
>
>
> [PATCH] hw/cxl/events: Improve QMP interfaces and documentation for add/release dynamic capacity.
>
> New DCD command definitions updated in response to review comments
> from Markus.
>
> - Used CxlXXXX instead of CXLXXXXX for newly added types.
> - Expanded some abreviations in type names to be easier to read.
> - Additional documentation for some fields.
> - Replace slightly vague cxl r3.1 references with
>   "Compute Express Link (CXL) Specification, Revision 3.1, XXXX"
>   to bring them inline with what it says on the specification cover.
>
> Suggested-by: Maruks Armbruster <armbru@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> I can break this up into a separate patches, but that's going to be
> quite a lot of churn as often multiple of the above affect the same
> paragraph.

I don't think breaking it up is worth your while or mine :)

Patch looks good to me at a glance.  There are a few instances of

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

[...]

