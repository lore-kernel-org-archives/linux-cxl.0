Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E81144D21
	for <linux-cxl@vger.kernel.org>; Tue,  4 Jun 2024 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502161; cv=none; b=swB2zQG/VmBFdyErxA0tsQCcwIXYYLLDxFXtxPLXkZI/vG4c08BhB16A2mUfauhEaiFP1QTTCTDqRo8ztpce1u0gosmzr2nIbkYE6PInP9W55BHyzcbs4bhi4LOodbVLGJoL7XVKD4+lVhsOSlEb3zXqGKJLsVEHzAuLqGGJEIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502161; c=relaxed/simple;
	bh=N38/H5UB0ucOumaNTuszeSTRJXHjr73yBkkJzY2cBEU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXvr9FsbTUs8VZM81jaemVv0Kbd5mkY98caC405nwk+zy6YMlYrXKCqmlR+4D/zase1iveAj2unvjH+XpHI+/pFCfWaxqMQffiGzJcGEx8ZsqzqSFJXo6H+0MmyAWXUHu7GpbKLK8gsRE2TVa5cj21nKPrZZ7kqkVKCp2f0BqdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VtptG29Pzz6K9df;
	Tue,  4 Jun 2024 19:54:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AAFC9140A9C;
	Tue,  4 Jun 2024 19:55:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Jun
 2024 12:55:55 +0100
Date: Tue, 4 Jun 2024 12:55:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <gregory.price@memverge.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>,
	<mst@redhat.com>, Fan Ni <fan.ni@samsung.com>, Svetly Todorov
	<svetly.todorov@memverge.com>
Subject: Re: [PATCH v8 11/14] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240604125554.00005549@Huawei.com>
In-Reply-To: <87o78hb2ra.fsf@pond.sub.org>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
	<20240523174651.1089554-12-nifan.cxl@gmail.com>
	<87o78hb2ra.fsf@pond.sub.org>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 04 Jun 2024 09:12:09 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> nifan.cxl@gmail.com writes:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> >
> > To simulate FM functionalities for initiating Dynamic Capacity Add
> > (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL spec
> > r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces to issue
> > add/release dynamic capacity extents requests.
> >
> > With the change, we allow to release an extent only when its DPA range
> > is contained by a single accepted extent in the device. That is to say,
> > extent superset release is not supported yet.
> >
> > 1. Add dynamic capacity extents:
> >
> > For example, the command to add two continuous extents (each 128MiB long)
> > to region 0 (starting at DPA offset 0) looks like below:
> >
> > { "execute": "qmp_capabilities" }
> >
> > { "execute": "cxl-add-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "host-id": 0,
> >       "selection-policy": "prescriptive",
> >       "region": 0,
> >       "extents": [
> >       {
> >           "offset": 0,
> >           "len": 134217728
> >       },
> >       {
> >           "offset": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> >
> > 2. Release dynamic capacity extents:
> >
> > For example, the command to release an extent of size 128MiB from region 0
> > (DPA offset 128MiB) looks like below:
> >
> > { "execute": "cxl-release-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "host-id": 0,
> >       "removal-policy":"prescriptive",
> >       "region": 0,
> >       "extents": [
> >       {
> >           "offset": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> >
> > Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
> > Reviewed-by: Gregory Price <gregory.price@memverge.com>
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>  
> 

Hi Markus,

Thanks for the detailed review.

Fan is traveling for a few weeks and may have intermittent internet.
He asked me to help with any feedback that came in during this period.

Perhaps at this stage (as Michael has this queued) best bet is a follow on patch
tweaking things.  The blast radius is more or less contained to the
qmp file subject to a few parameter type changes.  I'd be keen on this
approach if possible because that lets me start attacking the annoyingly
large queue of stuff dependent on this series in parallel with
improving this aspect.

Proposed draft patch at end of this email and responses to individual
comments inline.

I'll do a separate patch in response to your suggestion to mark the
two interfaces unstable.  For now seems there is little disadvantage
in doing so as I assume there is nothing stopping us removing
that marking in a cycle or two if things look stable.

> [...]
> 
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 4281726dec..57d9f82014 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -361,3 +361,146 @@
> >  ##
> >  {'command': 'cxl-inject-correctable-error',
> >   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> > +
> > +##
> > +# @CXLDynamicCapacityExtent:  
> 
> Three existing type names start with Cxl, and only one starts with CXL.
> Please make your new ones start with Cxl, not CXL:
> CxlDynamicCapacityExtent.
Ok. 
> 
> > +#
> > +# A single dynamic capacity extent
> > +#
> > +# @offset: The offset (in bytes) to the start of the region
> > +#     where the extent belongs to.
> > +#
> > +# @len: The length of the extent in bytes.  
> 
> What is this?  Memory?

Yes.  Probably makes more sense to add to the initial description rather
than down here.

# A single dynamic capacity extent.  This is a contiguous allocation
# of memory by Device Physical Address within a single Dynamic Capacity
# Region on a CXL Type 3 device.

This is all a bit of a balance between not quoting large chunks of
the specification and providing enough detail here.
Reality is that people who don't know what this is, won't use this
interface.  We can add some additional documentation to introduce
all the concepts but it probably doesn't make sense to do so here.


> 
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'struct': 'CXLDynamicCapacityExtent',
> > +  'data': {
> > +      'offset':'uint64',
> > +      'len': 'uint64'
> > +  }
> > +}
> > +
> > +##
> > +# @CXLExtSelPolicy:  
> 
> CxlExtentSelectionPolicy
> 
> > +#
> > +# The policy to use for selecting which extents comprise the added
> > +# capacity, as defined in cxl spec r3.1 Table 7-70.  
> 
> Use the official title: "as defined in the CXL Specification 3.1" (I
> think, the actual document is behind a click-through agreement).

Sadly not that simple, hence the desire for an abbreviation. Should be

Compute Express Link (CXL) Specification, Revision 3.1, Version 1.0

Can drop the Version 1.0 (as there have never been other versions and
probably won't be) but the Revision part matters (unfortunately)
hence the r in the above.

Not that we've used CXL r3.0 etc in previous QMP docs for this. Perhaps
just sticking to that and relying on the reference in
docs/system/devices/cxl.rst for the canonical reference.

For now I'll go with the (almost) full form here as it's never wrong to
spell it out.  So all the new references will be to
Compute Express Link (CXL) Specification, Revision 3.1, Section xxxx


> 
> > +#
> > +# @free: 0h = Free
> > +#
> > +# @contiguous: 1h = Continuous  
> 
> What does "1h =" mean?  The numeric encoding?
Alignment with spec, but doesn't need to be here so removed.

> 
> What exactly is "contiguous" / "continuous"?  I figure it's clear enough
> if you have the CXL spec open in another window.  Can we condense it
> into one phrase for use here?

@free: Device is responsible for allocating the requested memory
     capacity and is free to do this using any combination of
     supported extents.

@contiguous: Device is responsible for allocating the requested
     memory capacity but must do so as a single contiguous
     extent.

@prescriptive: The precise set of extents to be allocated is specified
     by the command.  Thus allocation is being managed by the
     issuer of the allocation command, not the device.

@enable-shared-access: Capacity has already been allocated to a
     different host using free, contiguous or prescriptive methods with
     a known tag. This policy then instructs the device to make the
     capacity with the specified tag available to an additional host.
     Capacity is implicit as it matches that already associated with the
     tag. Note that the extent list (and hence DPAs)
     used are per host, so a device may use different representations
     on each host. The ordering of the extents provided to each host
     is indicated to the host using per extent sequence numbers generated
     by the device. Has a similar
     meaning for temporal sharing but in that case there may be only
     one host involved.

> 
> > +#
> > +# @prescriptive: 2h = Prescriptive
> > +#
> > +# @enable-shared-access: 3h = Enable Shared Access  
> 
> Similar questions.
> 
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'enum': 'CXLExtSelPolicy',
> > +  'data': ['free',
> > +           'contiguous',
> > +           'prescriptive',
> > +           'enable-shared-access']
> > +}
> > +
> > +##
> > +# @cxl-add-dynamic-capacity:
> > +#
> > +# Command to initiate to add dynamic capacity extents to a host.  It  
> 
> "Initiate adding dynamic capacity extents"
Done.
> 
> When a command initiates something, we commonly need a way to detect
> completion, and sometimes need a way to track progress.
> 
> How can we detect completion, and if we can't, why's that okay?
> 
> Can adding capacity fail after the command succeeded?  If yes, how can
> we detect that?

The full flow can fail, in the sense that the host can reject the offered
capacity.
This command just initiates the flow.

Today we can't detect it via QMP. There are a could of options but I
think they are out of scope for this document (for now).
There are a lot more DCD features to come and I'd include a
resolution to this aspect as one of those.  Aim today is just
to get to the point where we can test the OS handling - other
cases like virtualization of this require a lot more infrastructure
on top of what we have here.

So likely options:

* The 'fabric manager' will have an out of band path to the OS as it
  doesn't spontaneously decide to offer capacity - that happens
  because an orchestrator (think kubernetes or similar) has told a
  host to bring up an application that needs this extra capacity.
  That path would typically include an acknowledgment that the capacity
  has turned up and the host can run what it was asked to run.

  There is an inband path for a real fabric manager interface that
  we don't yet have an equivalent of in QEMU. An earlier version
  of this patch set provided a hacky equivalent so was dropped.
  That path is the Fabric Manager side Dynamic Capacity Event Log
  which has events for this
 0x4 Add Capacity Response:
" The host has responded to the Add Capacity event and the Dynamic
  Capacity Extent field in this structure specifies the capacity
  accepted by the host.  This event shall only be reported
  to the FM"
0x5 is the similar one for release.

So long term there is probably a need for a reporting interface
but lots more to do in general and I think this is functional
without that.  For now I think all we can do is document that
discovering success must be done via an out of band interface.

I've added:
" Note that, currently, establishing success or failure of the full Add Dynamic
  Capacity flow requires out of band communication with the OS of
  the CXL host."

Does that work for now?  We will have to remember to update if/when
we add a way to query this.

Also clear we could benefit from some additional documentation
in cxl.rst.  That's a job for another day however - for now to
get the details users will have to read the CXL specification or
may watch a bunch of conference videos and webinars at least.
 

> 
> How long until completion after the command succeeded?  Unbounded time?

Depends on the host, and indeed unbounded - ultimately there is an abort
path (forced removal later in this doc) but it is sometimes fatal for the
OS running and only meant for the case where the host OS crashed.
Not many operating systems play well with force removal of memory and due
to a race condition it may looks like that to the host.  So basically
it's a 'don't use this' kind of hardware feature.

However it's not that QEMU is waiting for it beyond  having some tracking
structures allocated that are not freed until the flow has finished.
This is very much an an asynchronous flow.

> 
> > +# simulates operations defined in cxl spec r3.1 7.6.7.6.5.  
> 
> "defined in the CXL Specification 3.1 section 7.6.7.6.5"
> 
> More of the same below, not noting it again.
Sure. Hopefully fixed throughout the new text. I've not taken
on the existing cases today.

> 
> > +#
> > +# @path: CXL DCD canonical QOM path.  
> 
> Sure the QOM path needs to be canonical?
> 
> If not, what about "path to the CXL dynamic capacity device in the QOM
> tree".  Intentionally close to existing descriptions of @qom-path
> elsewhere.

That text LGTM. I'll focus only on new cases of this for an initial
patch but there are a load of other cases of this text that will
want updating separately.

> 
> > +#
> > +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> > +#     Table 7-70.
> > +#
> > +# @selection-policy: The "Selection Policy" bits as defined in
> > +#     cxl spec r3.1 Table 7-70.  It specifies the policy to use for
> > +#     selecting which extents comprise the added capacity.
> > +#
> > +# @region: The "Region Number" field as defined in cxl spec r3.1
> > +#     Table 7-70.  The dynamic capacity region where the capacity
> > +#     is being added.  Valid range is from 0-7.  
> 
> Scratch the second sentence?

Sure, I guess because nearly everything else is just a spec reference
and this isn't adding enough info to be useful?

> 
> > +#
> > +# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-70.
> > +#
> > +# @extents: The "Extent List" field as defined in cxl spec r3.1
> > +#     Table 7-70.
> > +#
> > +# Since : 9.1
> > +##
> > +{ 'command': 'cxl-add-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'host-id': 'uint16',
> > +            'selection-policy': 'CXLExtSelPolicy',
> > +            'region': 'uint8',
> > +            '*tag': 'str',
> > +            'extents': [ 'CXLDynamicCapacityExtent' ]
> > +           }
> > +}
> > +
> > +##
> > +# @CXLExtRemovalPolicy:  
> 
> CxlExtentRemovalPolicy
Done this and similar.
> 
> > +#
> > +# The policy to use for selecting which extents comprise the released
> > +# capacity, defined in the "Flags" field in cxl spec r3.1 Table 7-71.
> > +#
> > +# @tag-based: value = 0h.  Extents are selected by the device based
> > +#     on tag, with no requirement for contiguous extents.
> > +#
> > +# @prescriptive: value = 1h.  Extent list of capacity to release is
> > +#     included in the request payload.  
> 
> I guess "value = ..." documents the numeric value.  Sure that's useful
> here?

Dropped as not useful here.

> 
> > +#
> > +# Since: 9.1
> > +##
> > +{ 'enum': 'CXLExtRemovalPolicy',
> > +  'data': ['tag-based',
> > +           'prescriptive']
> > +}
> > +
> > +##
> > +# @cxl-release-dynamic-capacity:
> > +#
> > +# Command to initiate to release dynamic capacity extents from a  
> 
> "Initiate releasing dynamic capacity extents"
> 
> When a command initiates something, we commonly need a way to detect
> completion, and sometimes need a way to track progress.  See
> cxl-add-dynamic-capacity above.
> 

Effectively same reply.  Today you can only do this via out of band
comms with the host.  We have quite a lot more to add before we
can report this via QMP. This is very much part 1 of DCD support,
I'd expect us to be still adding features in a year or more.

I'll add similar text to proposed for the add path.

...

> 
> > +#     capacity as a result of this request.  
> 
> What does it mean "to sanitize capacity"?  Is this about scrubbing the
> memory?

For one meaning of scrubbing.  Not the one that is normally applied to
memory which is patrol scrub / ECC error detection and correction and
subject to a long kernel mailing list thread at the moment and another
QEMU patch set on my queue..  

Why can't we have a be dictionary of canonical terms. Ah well.
Added a slightly shortened quote from the CXL spec.
"This Ensures that all user data and metadata is made permanently
 unavailable by whatever means is appropriate for the media type.
 Note that changing encryption keys is not sufficient."

The last bit is because we will shortly have secure erase support
via another patch set and in that case changing encryption keys is
sufficient.

  

> 
> > +#
> > +# @region: The "Region Number" field as defined in cxl spec r3.1
> > +#     Table 7-71.  The dynamic capacity region where the capacity
> > +#     is being added.  Valid range is from 0-7.  
> 
> My comment on cxl-add-dynamic-capacity argument @region applies.
"The dynamic capacity region where the capacity is being added."
sentence dropped.

> 
> > +#
> > +# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-71.
> > +#
> > +# @extents: The "Extent List" field as defined in cxl spec r3.1
> > +#     Table 7-71.
> > +#
> > +# Since : 9.1
> > +##
> > +{ 'command': 'cxl-release-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'host-id': 'uint16',
> > +            'removal-policy': 'CXLExtRemovalPolicy',
> > +            '*forced-removal': 'bool',
> > +            '*sanitize-on-release': 'bool',
> > +            'region': 'uint8',
> > +            '*tag': 'str',
> > +            'extents': [ 'CXLDynamicCapacityExtent' ]
> > +           }
> > +}  
> 

So with all that incorporated, what I currently have is:



[PATCH] hw/cxl/events: Improve QMP interfaces and documentation for add/release dynamic capacity.

New DCD command definitions updated in response to review comments
from Markus.

- Used CxlXXXX instead of CXLXXXXX for newly added types.
- Expanded some abreviations in type names to be easier to read.
- Additional documentation for some fields.
- Replace slightly vague cxl r3.1 references with
  "Compute Express Link (CXL) Specification, Revision 3.1, XXXX"
  to bring them inline with what it says on the specification cover.

Suggested-by: Maruks Armbruster <armbru@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
I can break this up into a separate patches, but that's going to be
quite a lot of churn as often multiple of the above affect the same
paragraph.

---
 qapi/cxl.json            | 152 ++++++++++++++++++++++++---------------
 hw/mem/cxl_type3.c       |  18 ++---
 hw/mem/cxl_type3_stubs.c |   8 +--
 3 files changed, 107 insertions(+), 71 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 57d9f82014..a38622a0d1 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -363,9 +363,11 @@
  'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
 
 ##
-# @CXLDynamicCapacityExtent:
+# @CxlDynamicCapacityExtent:
 #
-# A single dynamic capacity extent
+# A single dynamic capacity extent.  This is a contiguous allocation
+# of memory by Device Physical Address within a single Dynamic
+# Capacity Region on a CXL Type 3 Device.
 #
 # @offset: The offset (in bytes) to the start of the region
 #     where the extent belongs to.
@@ -374,7 +376,7 @@
 #
 # Since: 9.1
 ##
-{ 'struct': 'CXLDynamicCapacityExtent',
+{ 'struct': 'CxlDynamicCapacityExtent',
   'data': {
       'offset':'uint64',
       'len': 'uint64'
@@ -382,22 +384,40 @@
 }
 
 ##
-# @CXLExtSelPolicy:
+# @CxlExtentSelectionPolicy:
 #
 # The policy to use for selecting which extents comprise the added
-# capacity, as defined in cxl spec r3.1 Table 7-70.
-#
-# @free: 0h = Free
-#
-# @contiguous: 1h = Continuous
-#
-# @prescriptive: 2h = Prescriptive
-#
-# @enable-shared-access: 3h = Enable Shared Access
+# capacity, as defined in Compute Express Link (CXL) Specification,
+# Revision 3.1, Table 7-70.
+#
+# @free: Device is responsible for allocating the requested memory
+#     capacity and is free to do this using any combination of
+#     supported extents.
+#
+# @contiguous: Device is responsible for allocating the requested
+#     memory capacity but must do so as a single contiguous
+#     extent.
+#
+# @prescriptive: The precise set of extents to be allocated is
+#     specified by the command.  Thus allocation is being managed
+#     by the issuer of the allocation command, not the device.
+#
+# @enable-shared-access: Capacity has already been allocated to a
+#     different host using free, contiguous or prescriptive policy
+#     with a known tag.  This policy then instructs the device to
+#     make the capacity with the specified tag available to an
+#     additional host.  Capacity is implicit as it matches that
+#     already associated with the tag.  Note that the extent list
+#     (and hence Device Physical Addresses) used are per host, so
+#     a device may use different representations on each host.
+#     The ordering of the extents provided to each host is indicated
+#     to the host using per extent sequence numbers generated by
+#     the device.  Has a similar meaning for temporal sharing, but
+#     in that case there may be only one host involved.
 #
 # Since: 9.1
 ##
-{ 'enum': 'CXLExtSelPolicy',
+{ 'enum': 'CxlExtentSelectionPolicy',
   'data': ['free',
            'contiguous',
            'prescriptive',
@@ -407,54 +427,60 @@
 ##
 # @cxl-add-dynamic-capacity:
 #
-# Command to initiate to add dynamic capacity extents to a host.  It
-# simulates operations defined in cxl spec r3.1 7.6.7.6.5.
+# Initiate adding dynamic capacity extents to a host.  This simulates
+# operations defined in Compute Express Link (CXL) Specification,
+# Revision 3.1, Section 7.6.7.6.5. Note that, currently, establishing
+# success or failure of the full Add Dynamic Capacity flow requires
+# out of band communication with the OS of the CXL host.
 #
-# @path: CXL DCD canonical QOM path.
+# @path: path to the CXL Dynamic Capacity Device in the QOM tree.
 #
-# @host-id: The "Host ID" field as defined in cxl spec r3.1
-#     Table 7-70.
+# @host-id: The "Host ID" field as defined in Compute Express Link
+#     (CXL) Specification, Revision 3.1, Table 7-70.
 #
 # @selection-policy: The "Selection Policy" bits as defined in
-#     cxl spec r3.1 Table 7-70.  It specifies the policy to use for
-#     selecting which extents comprise the added capacity.
+#     Compute Express Link (CXL) Specification, Revision 3.1,
+#     Table 7-70.  It specifies the policy to use for selecting
+#     which extents comprise the added capacity.
 #
-# @region: The "Region Number" field as defined in cxl spec r3.1
-#     Table 7-70.  The dynamic capacity region where the capacity
-#     is being added.  Valid range is from 0-7.
+# @region: The "Region Number" field as defined in Compute Express
+#     Link (CXL) Specification, Revision 3.1, Table 7-70.  Valid
+#     range is from 0-7.
 #
-# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-70.
+# @tag: The "Tag" field as defined in Compute Express Link (CXL)
+#     Specification, Revision 3.1, Table 7-70.
 #
-# @extents: The "Extent List" field as defined in cxl spec r3.1
-#     Table 7-70.
+# @extents: The "Extent List" field as defined in Compute Express Link
+#     (CXL) Specification, Revision 3.1, Table 7-70.
 #
 # Since : 9.1
 ##
 { 'command': 'cxl-add-dynamic-capacity',
   'data': { 'path': 'str',
             'host-id': 'uint16',
-            'selection-policy': 'CXLExtSelPolicy',
+            'selection-policy': 'CxlExtentSelectionPolicy',
             'region': 'uint8',
             '*tag': 'str',
-            'extents': [ 'CXLDynamicCapacityExtent' ]
+            'extents': [ 'CxlDynamicCapacityExtent' ]
            }
 }
 
 ##
-# @CXLExtRemovalPolicy:
+# @CxlExtentRemovalPolicy:
 #
 # The policy to use for selecting which extents comprise the released
-# capacity, defined in the "Flags" field in cxl spec r3.1 Table 7-71.
+# capacity, defined in the "Flags" field in Compute Express Link (CXL)
+# Specification, Revision 3.1, Table 7-71.
 #
-# @tag-based: value = 0h.  Extents are selected by the device based
-#     on tag, with no requirement for contiguous extents.
+# @tag-based: Extents are selected by the device based on tag, with
+#     no requirement for contiguous extents.
 #
-# @prescriptive: value = 1h.  Extent list of capacity to release is
-#     included in the request payload.
+# @prescriptive: Extent list of capacity to release is included in
+#     the request payload.
 #
 # Since: 9.1
 ##
-{ 'enum': 'CXLExtRemovalPolicy',
+{ 'enum': 'CxlExtentRemovalPolicy',
   'data': ['tag-based',
            'prescriptive']
 }
@@ -462,45 +488,55 @@
 ##
 # @cxl-release-dynamic-capacity:
 #
-# Command to initiate to release dynamic capacity extents from a
-# host.  It simulates operations defined in cxl spec r3.1 7.6.7.6.6.
+# Initiate release of dynamic capacity extents from a host.  This
+# simulates operations defined in Compute Express Link (CXL)
+# Specification, Revision 3.1, Section 7.6.7.6.6. Note that,
+# currently, success or failure of the full Release Dynamic Capacity
+# flow requires out of band communication with the OS of the CXL host.
 #
-# @path: CXL DCD canonical QOM path.
+# @path: path to the CXL Dynamic Capacity Device in the QOM tree.
 #
-# @host-id: The "Host ID" field as defined in cxl spec r3.1
-#     Table 7-71.
+# @host-id: The "Host ID" field as defined in Compute Express Link
+#     (CXL) Specification, Revision 3.1, Table 7-71.
 #
-# @removal-policy: Bit[3:0] of the "Flags" field as defined in cxl
-#     spec r3.1 Table 7-71.
+# @removal-policy: Bit[3:0] of the "Flags" field as defined in
+#     Compute Express Link (CXL) Specification, Revision 3.1,
+#     Table 7-71.
 #
-# @forced-removal: Bit[4] of the "Flags" field in cxl spec r3.1
-#     Table 7-71.  When set, device does not wait for a Release
-#     Dynamic Capacity command from the host.  Host immediately
-#     loses access to released capacity.
+# @forced-removal: Bit[4] of the "Flags" field in Compute Express
+#     Link (CXL) Specification, Revision 3.1, Table 7-71.  When set,
+#     the device does not wait for a Release Dynamic Capacity command
+#     from the host.  Instead, the host immediately looses access to
+#     the released capacity.
 #
-# @sanitize-on-release: Bit[5] of the "Flags" field in cxl spec r3.1
-#     Table 7-71.  When set, device should sanitize all released
-#     capacity as a result of this request.
+# @sanitize-on-release: Bit[5] of the "Flags" field in Compute
+#     Express Link (CXL) Specification, Revision 3.1, Table 7-71.
+#     When set, the device should sanitize all released capacity as
+#     a result of this request. This ensures that all user data
+#     and metadata is made permanently unavailable by whatever
+#     means is appropriate for the media type. Note that changing
+#     encryption keys is not sufficient.
 #
-# @region: The "Region Number" field as defined in cxl spec r3.1
-#     Table 7-71.  The dynamic capacity region where the capacity
-#     is being added.  Valid range is from 0-7.
+# @region: The "Region Number" field as defined in Compute Express
+#     Link Specification, Revision 3.1, Table 7-71.  Valid range
+#     is from 0-7.
 #
-# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-71.
+# @tag: The "Tag" field as defined in Compute Express Link (CXL)
+#     Specification, Revision 3.1, Table 7-71.
 #
-# @extents: The "Extent List" field as defined in cxl spec r3.1
-#     Table 7-71.
+# @extents: The "Extent List" field as defined in Compute Express
+#     Link (CXL) Specification, Revision 3.1, Table 7-71.
 #
 # Since : 9.1
 ##
 { 'command': 'cxl-release-dynamic-capacity',
   'data': { 'path': 'str',
             'host-id': 'uint16',
-            'removal-policy': 'CXLExtRemovalPolicy',
+            'removal-policy': 'CxlExtentRemovalPolicy',
             '*forced-removal': 'bool',
             '*sanitize-on-release': 'bool',
             'region': 'uint8',
             '*tag': 'str',
-            'extents': [ 'CXLDynamicCapacityExtent' ]
+            'extents': [ 'CxlDynamicCapacityExtent' ]
            }
 }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 284db94182..2242986d8b 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1873,7 +1873,7 @@ static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
  */
 static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         uint16_t hid, CXLDCEventType type, uint8_t rid,
-        CXLDynamicCapacityExtentList *records, Error **errp)
+        CxlDynamicCapacityExtentList *records, Error **errp)
 {
     Object *obj;
     CXLEventDynamicCapacity dCap = {};
@@ -1881,7 +1881,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     CXLType3Dev *dcd;
     uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
     uint32_t num_extents = 0;
-    CXLDynamicCapacityExtentList *list;
+    CxlDynamicCapacityExtentList *list;
     CXLDCExtentGroup *group = NULL;
     g_autofree CXLDCExtentRaw *extents = NULL;
     uint8_t enc_log = CXL_EVENT_TYPE_DYNAMIC_CAP;
@@ -2031,13 +2031,13 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
 }
 
 void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
-                                  CXLExtSelPolicy sel_policy, uint8_t region,
-                                  const char *tag,
-                                  CXLDynamicCapacityExtentList  *extents,
+                                  CxlExtentSelectionPolicy sel_policy,
+                                  uint8_t region, const char *tag,
+                                  CxlDynamicCapacityExtentList  *extents,
                                   Error **errp)
 {
     switch (sel_policy) {
-    case CXL_EXT_SEL_POLICY_PRESCRIPTIVE:
+    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
         qmp_cxl_process_dynamic_capacity_prescriptive(path, host_id,
                                                       DC_EVENT_ADD_CAPACITY,
                                                       region, extents, errp);
@@ -2049,14 +2049,14 @@ void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
 }
 
 void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
-                                      CXLExtRemovalPolicy removal_policy,
+                                      CxlExtentRemovalPolicy removal_policy,
                                       bool has_forced_removal,
                                       bool forced_removal,
                                       bool has_sanitize_on_release,
                                       bool sanitize_on_release,
                                       uint8_t region,
                                       const char *tag,
-                                      CXLDynamicCapacityExtentList  *extents,
+                                      CxlDynamicCapacityExtentList  *extents,
                                       Error **errp)
 {
     CXLDCEventType type = DC_EVENT_RELEASE_CAPACITY;
@@ -2069,7 +2069,7 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
     }
 
     switch (removal_policy) {
-    case CXL_EXT_REMOVAL_POLICY_PRESCRIPTIVE:
+    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
         qmp_cxl_process_dynamic_capacity_prescriptive(path, host_id, type,
                                                       region, extents, errp);
         return;
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 45419bbefe..c1a5e4a7c1 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -70,24 +70,24 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
 
 void qmp_cxl_add_dynamic_capacity(const char *path,
                                   uint16_t host_id,
-                                  CXLExtSelPolicy sel_policy,
+                                  CxlExtentSelectionPolicy sel_policy,
                                   uint8_t region,
                                   const char *tag,
-                                  CXLDynamicCapacityExtentList *extents,
+                                  CxlDynamicCapacityExtentList *extents,
                                   Error **errp)
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
 
 void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
-                                      CXLExtRemovalPolicy removal_policy,
+                                      CxlExtentRemovalPolicy removal_policy,
                                       bool has_forced_removal,
                                       bool forced_removal,
                                       bool has_sanitize_on_release,
                                       bool sanitize_on_release,
                                       uint8_t region,
                                       const char *tag,
-                                      CXLDynamicCapacityExtentList *extents,
+                                      CxlDynamicCapacityExtentList *extents,
                                       Error **errp)
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");



