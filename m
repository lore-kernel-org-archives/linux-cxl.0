Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A385179972
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714497499; cv=none; b=NgWLm7krx3ZHgD4PJLpzAxyB+ZTfVZ8qkB01lZcquwTBSt5QQVcPJo15CaQSwcsQGtlAlJv+h2IZ07+XTNLL2JHdsVFxg0pbl0fqMttVXrNMQ7m5HTmb9VHQZ7EoMzF/ah10hgWFQ7gi6TqtsxanvAeOhDnjV0Lz1KNXaONLrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714497499; c=relaxed/simple;
	bh=07nR9TqKbWyL/3Cwv8f8r+oy9LzjCtfNOWq/zRtHglA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WChZcXIaugrpYVK1miL0v1+xZVlYA56knIEOuSo7bxPBGXJlQZ2nfw7/48h8hsw/cs/n0CSma/uvbi/vqTUGSgd0nfyoJDVf30OyB08JIEzmkgzmiYQuTl72DV0+Hnc6uRelsk3zp730sOrMW1SKRdctuEC7nrQeJGJGop2TvmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaboKuTL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaboKuTL"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e651a9f3ffso30502545ad.1
        for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714497497; x=1715102297; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nsNRjkgE5rTSwuDeHh29cZYgJuZ5Zz1LUGVq6rxOApI=;
        b=MaboKuTL0bCiKI2b0EdcekNxdCx6GvGAzl+mRtcUHq/Y/eVZGwO2B3j6AbpoNnpK4J
         +ukO5CbD52MUoDn9QOg2ZCqvciGSa/AhBzzUiAa5v2TYPqYGQh6rj7HlEQpomOIBSNhN
         nkUjfoqeU3gehBKZ66OqzreR+cIqLAVfQt4QwjXbmjnYRGH/lO3HC4gewvK+3UsienBZ
         I5M363ETUVQX/CjhSQcibZglXRdoDHkG4M1Umyo9XAJpIOF6e2D4hr/jopNohUilAYot
         Y/nF0b3YBb/YsTgOmbt7d2jMswHUAQ0UuzcdRFlqdgsAhAmC0AyjDe6t09WFyFIvM0a0
         zIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714497497; x=1715102297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsNRjkgE5rTSwuDeHh29cZYgJuZ5Zz1LUGVq6rxOApI=;
        b=Znc7d6M2tea8kiFNqIvFDtTV1IlxxVXhzHBWoZ/pXkU2oHxWd0xfHIZqeX2uGvLd+j
         yiByLkLOOgQ5mM/g69FUlZLPUVgBeoAJFV76slukQ6Ok0eVr8M67vgzw4TR0tbHnLDlb
         wTiD8/jlfqs2q9UgECZoyR6R810zWFBpN4xJByQccG67Gio//yxC1GeWyE9KenqCW4Hb
         ZR4W26LivwdMyfAW6dhGhFroTkCb95kV6tA2EiJSr74m6oTrElgBkqSFV8GsRgyMBgGT
         75TD+l18Zgm5BYRriBd4zHTjfPKrze8b8oGEUI5GY0AmgJyfx4h1GwB+edyNkqtFellp
         YL8w==
X-Forwarded-Encrypted: i=1; AJvYcCV2vdtkmq3wEgoL11Be/qsPI6KST1HnwMyWW/58kl0VEz3nzvnHQCXiHZ8faxnqSp58l41DLmHq5k+91EReL5MsVBGoVdSn4Fh+
X-Gm-Message-State: AOJu0Yw/rOxQPldaAMhyOlBCPhAewFRUo6xF/b28gjLOjrLlniweNjGZ
	pDsYnavzm7yIrl78dsDqNTugA6RhNYQosP1YZCEzVWkVr0V+Hhxh
X-Google-Smtp-Source: AGHT+IHcotiS/suo6YXQ3Itp9q4KCo12aaLYOWIEjR4S59qRVCUxWYnvobbnDmqcZ5jw7TGXiIY61A==
X-Received: by 2002:a17:902:7292:b0:1e8:c962:4f6e with SMTP id d18-20020a170902729200b001e8c9624f6emr32518pll.20.1714497496693;
        Tue, 30 Apr 2024 10:18:16 -0700 (PDT)
Received: from debian ([2601:641:300:14de:44d7:a685:6990:1604])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902e84a00b001e5a5ea5287sm22617943plg.208.2024.04.30.10.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 10:18:16 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 30 Apr 2024 10:17:52 -0700
To: Markus Armbruster <armbru@redhat.com>
Cc: fan <nifan.cxl@gmail.com>, qemu-devel@nongnu.org,
	jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
	gregory.price@memverge.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZjEnwPeoivsW8y5Z@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-10-fan.ni@samsung.com>
 <877cgkxzal.fsf@pond.sub.org>
 <Zivk37xBGPsL_yo5@debian>
 <87h6fkob0t.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h6fkob0t.fsf@pond.sub.org>

On Mon, Apr 29, 2024 at 09:58:42AM +0200, Markus Armbruster wrote:
> fan <nifan.cxl@gmail.com> writes:
> 
> > On Fri, Apr 26, 2024 at 11:12:50AM +0200, Markus Armbruster wrote:
> >> nifan.cxl@gmail.com writes:
> 
> [...]
> 
> >> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> >> > index 4281726dec..2dcf03d973 100644
> >> > --- a/qapi/cxl.json
> >> > +++ b/qapi/cxl.json
> >> > @@ -361,3 +361,72 @@
> >> >  ##
> >> >  {'command': 'cxl-inject-correctable-error',
> >> >   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> >> > +
> >> > +##
> >> > +# @CXLDCExtentRecord:
> >> 
> >> Such traffic jams of capital letters are hard to read.  What about
> >> CxlDynamicCapacityExtent?
> >> 
> >> > +#
> >> > +# Record of a single extent to add/release
> >> 
> >> Suggest "A dynamic capacity extent."
> >> 
> >> > +#
> >> > +# @offset: offset to the start of the region where the extent to be operated
> >> 
> >> Blank line here, please.
> >> 
> >> 
> >> 
> >> > +# @len: length of the extent
> >> > +#
> >> > +# Since: 9.1
> >> > +##
> >> > +{ 'struct': 'CXLDCExtentRecord',
> >> > +  'data': {
> >> > +      'offset':'uint64',
> >> > +      'len': 'uint64'
> >> > +  }
> >> > +}
> >> > +
> >> > +##
> >> > +# @cxl-add-dynamic-capacity:
> >> > +#
> >> > +# Command to start add dynamic capacity extents flow. The device will
> >> > +# have to acknowledged the acceptance of the extents before they are usable.
> >> 
> >> This text needs work.  More on that at the end of my review.
> >
> > Yes. I will work on it for the next version once all the feedbacks
> > are collected and comments are resolved.
> >
> > See below.
> >
> >> 
> >> docs/devel/qapi-code-gen.rst:
> >> 
> >>     For legibility, wrap text paragraphs so every line is at most 70
> >>     characters long.
> >> 
> >>     Separate sentences with two spaces.
> >> 
> >> More elsewhere.
> >> 
> >> > +#
> >> > +# @path: CXL DCD canonical QOM path
> >> 
> >> I'd prefer @qom-path, unless you can make a consistency argument for
> >> @path.
> >> 
> >> Sure the QOM path needs to be canonical?
> >> 
> >> If not, what about "path to the CXL dynamic capacity device in the QOM
> >> tree".  Intentionally close to existing descriptions of @qom-path
> >> elsewhere.
> >
> > From the same file, I saw "path" was used for other commands, like
> > "cxl-inject-memory-module-event", so I followed it.
> > DCD is nothing different from "type 3 device" expect it can dynamically
> > change capacity. 
> > Renaming it to "qom-path" is no problem for me, just want to make sure it
> > will not break the naming consistency.
> 
> Both @path and @qom-path are used (sadly).  @path is used for all kinds
> of paths, whereas @qom-path is only used for QOM paths.  That's why I
> prefer it.
> 
> However, you're making a compelling local consistency argument: cxl.json
> uses only @path.  Sticking to that makes sense.
> 
> >> > +# @hid: host id
> >> 
> >> @host-id, unless "HID" is established terminology in CXL DCD land.
> >
> > host-id works.
> >> 
> >> What is a host ID?
> >
> > It is an id identifying the host to which the capacity is being added.
> 
> How are these IDs assigned?

All the arguments passed to the command here are defined in CXL spec. I
will add reference to the spec.

Based on the spec, for LD-FAM (Fabric attached memory represented as
logical device), host id is the LD-ID of the host interface to which
the capacity is being added. LD-ID is a unique number (16-bit) assigned
to a host interface.

> 
> >> > +# @selection-policy: policy to use for selecting extents for adding capacity
> >> 
> >> Where are selection policies defined?
> >
> > It is defined in CXL specification: Specifies the policy to use for selecting
> > which extents comprise the added capacity
> 
> Include a reference to the spec here?
Wil do.
> 
> >> > +# @region-id: id of the region where the extent to add
> >> 
> >> Is "region ID" the established terminology in CXL DCD land?  Or is
> >> "region number" also used?  I'm asking because "ID" in this QEMU device
> >> context suggests a connection to a qdev ID.
> >> 
> >> If region number is fine, I'd rename to just @region, and rephrase the
> >> description to avoid "ID".  Perhaps "number of the region the extent is
> >> to be added to".  Not entirely happy with the phrasing, doesn't exactly
> >> roll off the tongue, but "where the extent to add" sounds worse to my
> >> ears.  Mind, I'm not a native speaker.
> >
> > Yes. region number is fine. Will rename it as "region"
> >
> >> 
> >> > +# @tag: Context field
> >> 
> >> What is this about?
> >
> > Based on the specification, it is "Context field utilized by implementations
> > that make use of the Dynamic Capacity feature.". Basically, it is a
> > string (label) attached to an dynamic capacity extent so we can achieve
> > specific purpose, like identifying or grouping extents.
> 
> Include a reference to the spec here?
Will do.
> 
> >> > +# @extents: Extents to add
> >> 
> >> Blank lines between argument descriptions, please.
> >> 
> >> > +#
> >> > +# Since : 9.1
> >> > +##
> >> > +{ 'command': 'cxl-add-dynamic-capacity',
> >> > +  'data': { 'path': 'str',
> >> > +            'hid': 'uint16',
> >> > +            'selection-policy': 'uint8',
> >> > +            'region-id': 'uint8',
> >> > +            'tag': 'str',
> >> > +            'extents': [ 'CXLDCExtentRecord' ]
> >> > +           }
> >> > +}
> >> > +
> >> > +##
> >> > +# @cxl-release-dynamic-capacity:
> >> > +#
> >> > +# Command to start release dynamic capacity extents flow. The host will
> >> > +# need to respond to indicate that it has released the capacity before it
> >> > +# is made unavailable for read and write and can be re-added.
> >> 
> >> This text needs work.  More on that at the end of my review.
> >
> > Will do.
> >
> >> 
> >> > +#
> >> > +# @path: CXL DCD canonical QOM path
> >> 
> >> My comment on cxl-add-dynamic-capacity applies.
> >> 
> >> > +# @hid: host id
> >> 
> >> Likewise.
> >> 
> >> > +# @flags: bit[3:0] for removal policy, bit[4] for forced removal, bit[5] for
> >> > +#     sanitize on release, bit[7:6] reserved
> >> 
> >> Where are these flags defined?
> >
> > Defined in the CXL specification, it defines the release behaviour.
> 
> Include a reference to the spec here?
Will do.
> 
> Is the numeric encoding of flags appropriate?
> 
> In general, we prefer symbolic encodings.  Numeric encodings can make
> sense when
> 
> • the encoding is stable, and
> 
> • QEMU doesn't need to decode it, only pass it on to something else, and
> 
> • both the QMP client and the "something else" prefer a numeric
>   encoding.
The encoding is from the specification, and we do not invent anything
here. It is stable and all the updates to the spec need to be backward
compatible.
> 
> >> > +# @region-id: id of the region where the extent to release
> >> 
> >> My comment on cxl-add-dynamic-capacity applies.
> >> 
> >> > +# @tag: Context field
> >> 
> >> Likewise.
> >> 
> >> > +# @extents: Extents to release
> >> > +#
> >> > +# Since : 9.1
> >> > +##
> >> > +{ 'command': 'cxl-release-dynamic-capacity',
> >> > +  'data': { 'path': 'str',
> >> > +            'hid': 'uint16',
> >> > +            'flags': 'uint8',
> >> > +            'region-id': 'uint8',
> >> > +            'tag': 'str',
> >> > +            'extents': [ 'CXLDCExtentRecord' ]
> >> > +           }
> >> > +}
> >> 
> >> During review of v5, you wrote:
> >> 
> >>     For add command, the host will send a mailbox command to response to
> >>     the add request to the device to indicate whether it accepts the add
> >>     capacity offer or not.
> >>     
> >>     For release command, the host send a mailbox command (not always a
> >>     response since the host can proactively release capacity if it does
> >>     not need it any more) to device to ask device release the capacity.
> >> 
> >> Can you briefly sketch the protocol?  Peers and messages involved.
> >> Possibly as a state diagram.
> >
> > Need to think about it. If we can polish the text nicely, maybe the
> > sketch is not needed. My concern is that the sketch may
> > introduce unwanted complexity as we expose too much details. The two
> > commands provide ways to add/release dynamic capacity to/from a host,
> > that is all. All the other information, like what the host will do, or
> > how the device will react, are consequence of the command, not sure
> > whether we want to include here.
> 
> The protocol sketch is for me, not necessarily the doc comment.  I'd
> like to understand at high level how this stuff works, because only then
> can I meaningfully review the docs.

--------------------------------
For add command, saying a user sends a request to FM to ask to add
extent A of the device (managed by FM) to host 0.
The function cxl-add-dynamic-capacity simulates what FM needs to do.
1. Verify extent A is valid (behaviour defined by the spec), return
error if not; otherwise,
2. Add a record to the device's event log (indicating the intent to
add extent A to host 0), update device internal extent tracking status,
signal an interrupt to host 0;
(The above step 1 & 2 are performed in the QMP interface, following
operations are QMP irrelevant, only host and device involved.)
3. Once the interrupt is received, host 0 fetch the event record from
the device's event log through some mailbox command (out of scope
of this patch series).
4. Host 0 decides whether it accepts extent A or not. Whether accept or
reject, host needs to send a response (add-response mailbox command) to
the device so the device can update its internal extent tracking
status accordingly.
The device return a value to the host showing whether the response is
successful or failed.
5. Based on the mailbox command return value, the host process
accordingly.
6. The host sends a mailbox command to the device to clear the event
record in the device's event log. 

---------------------------------
For release command, saying a user sends a request to FM to ask host 0
to release extent A and return it back to the device (managed by FM).

The function cxl-release-dynamic-capacity simulates what FM needs to do.
1. Verify extent A is valid (defined by the spec), return error if not;
otherwise,
2. Add a record to the event log (indicating the intent to
release extent A from host 0), signal an interrupt to host 0;
(The above step 1 & 2 are performed in the QMP interface, following
operations are QMP irrelevant, only host and device involved.
3. Once the interrupt is received, host 0 fetch the event record from
the device's event log through some mailbox command (out of scope
of this patch series).
4. Host 0 decides whether it can release extent A or not. Whether can or
cannot release, host needs to send a release (mailbox command) to the device
so the device can update its internal extent tracking status accordingly.
The device returns a value to host 0 showing whether the release is
successful or failed.
5. Based on the returned value, the host process accordingly.
6. The host sends mailbox command to clear the event record in the
device's event log. 

For release command, it is more complicated. Based on the release flag
passed to FM, FM can behaviour differently. For example, if the
forced-removal flag is set, FM can directly get the extent back from a
host for other uses without waiting for the host to send command to the
device. For the above step 2, their may be not event record to the event
log (no supported in this patch series yet).

Also, for the release interface here, it simulates FM initializes the
release request.
There is another case where the host can proactively release extents it
do not need any more back to device. However, this case is out of the
scope of this release interface.

Hope the above text helps a little for the context here.
Let me know if further clarification is needed.

Thanks,
Fan



> 
> > @Jonathan, Any thoughts on this?
> 
> Thanks!
> 
