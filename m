Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B2F16D4D5
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980375; cv=none; b=C44Yb5s2yw2tUgEnKqUK3HAg8OdErc+pVMDNB86S5H+V2vJxuTIVbQG+k+s4KJF13LoNblg5/8APRq7vihs8vpmv4tLRxMtVmM/tqvz4TNzJR9qhw/8HUtX1LbHppuPRLI8qCqXIDGMByPO7FsiwS4nNPI6c7vFq0350sVpk6ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980375; c=relaxed/simple;
	bh=frGUc1tUfAf7iSVE4XBMDHFnciNBOqHhElMh6sQGe8U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj7qQChCGmoSIrFlAo01e19GlEHvbSIWFoSHiSPouBk87zq/bKm5xesookHoufNM2KEqyTJ4LrjHoTG0hDM8AIfFJ48WrVnxU63vR9KtDwqeAMhX0EvA3B9+EqJo3t2eIlv5kdP5t8oTbVLFq9HmgQ2H+pXivayu9/OiXXilXpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAOcPyEb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAOcPyEb"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed32341906so201823b3a.1
        for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 10:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713980373; x=1714585173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cR2up4bi4Kb1J42a3eTuZ1XQ06fTcq0vPdkBZmwmbEI=;
        b=UAOcPyEbDjZn0coYqtM+5Ge20t+kmAh2SMTxsRwIBqXfwhM311e9EZBbbm3bMJcds3
         MvosGUiJVDDTw7XA1Cb8rH9C7JiBjCuF8x5iM8Q9LmAPJejo671PCyzcH7oEM5K3zeUC
         kT6OKG8kZtPl2PpMwPfBGegty8WO8NHdwWdUmCNVbHgV144psb5bJrQoLJvEc5Ix/J7M
         3EbEbDWlvdvT8xMIqLJfWt3mAaAy5k5iSiOHgcHTF++ngOPBmIlzSetA1GN+u3PzXf7K
         5wNXnAud4DtJ6N3h9j4epA4kKoqey0Y5RFcWWkd79xHn/ECQQprXjAykkHKFM069awME
         XNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713980373; x=1714585173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cR2up4bi4Kb1J42a3eTuZ1XQ06fTcq0vPdkBZmwmbEI=;
        b=VjfOTbsu1AAyXi86sfHhAqf28JQdjaq5UR9xL4fBiaxZb/psVCWEqgjRO8UwAzaIK2
         qgeFwMn/5jepUYUc+I9Wjzch638oGwgBccjnSnEGY+4yaej3MX9fdoxDHtbGBtGv6pr6
         hkUK8yTHElFG3Q/udVX79K9/0EkO62z2xIWxJ326ay8Y35GT7Uz+kkVqKONlkHyDWw54
         jnVFmu5NF19TDi+S0NAUPT43RmaO0rzMmVXwOhTkM1s38qJPsjhoQBBH/3VyzNRPcV0Y
         56SjgL9xEgc4vkQY/GwYcjh6aoTrZgAOY8WEPfXYwwwKhqmsCYKwVSghH7M4cfQEg9kr
         +1vg==
X-Forwarded-Encrypted: i=1; AJvYcCUKPDytpMSIJ2xK8v0zZLkJ4hUMLWm3mcYCyCevLxqae1EwllHwS/0eg2g5N5LM810nqd3dVIYDxaMegWceq8fYvs2DLCpW+iws
X-Gm-Message-State: AOJu0Yzxj01+j1cx4ArRmeIVD9eVe7ta13nl0k3G1LGkywyg8HWY4900
	55xeIcJ7VoLf3wHwItQ3Uwffx68Ipx+Dgt6WN0RDasbdctI44hA2
X-Google-Smtp-Source: AGHT+IHVNqcDsAXO2OPNUFuHejmO1SIZtipjUnEFl/Wm+N4DVytplmJd1ZsDajfzBYu+2RjMDAXnDQ==
X-Received: by 2002:a05:6a00:893:b0:6ed:caf6:6e54 with SMTP id q19-20020a056a00089300b006edcaf66e54mr3820780pfj.28.1713980373348;
        Wed, 24 Apr 2024 10:39:33 -0700 (PDT)
Received: from debian ([2601:641:300:14de:b318:9476:706a:e82a])
        by smtp.gmail.com with ESMTPSA id v22-20020aa78516000000b006f03a06314esm11721432pfn.195.2024.04.24.10.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 10:39:33 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Apr 2024 10:39:27 -0700
To: Markus Armbruster <armbru@redhat.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, gregory.price@memverge.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com, jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZilDz3X5hmda5oNr@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <87a5livrdr.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5livrdr.fsf@pond.sub.org>

On Wed, Apr 24, 2024 at 03:09:52PM +0200, Markus Armbruster wrote:
> nifan.cxl@gmail.com writes:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> >
> > Since fabric manager emulation is not supported yet, the change implements
> > the functions to add/release dynamic capacity extents as QMP interfaces.
> 
> Will fabric manager emulation obsolete these commands?

If in the future, fabric manager emulation supports commands for dynamic capacity
extent add/release, it is possible we do not need the commands.
But it seems not to happen soon, we need the qmp commands for the
end-to-end test with kernel DCD support.

> 
> > Note: we skips any FM issued extent release request if the exact extent
> > does not exist in the extent list of the device. We will loose the
> > restriction later once we have partial release support in the kernel.
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
> >       "region-id": 0,
> >       "extents": [
> >       {
> >           "dpa": 0,
> >           "len": 134217728
> >       },
> >       {
> >           "dpa": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> >
> > 2. Release dynamic capacity extents:
> >
> > For example, the command to release an extent of size 128MiB from region 0
> > (DPA offset 128MiB) look like below:
> >
> > { "execute": "cxl-release-dynamic-capacity",
> >   "arguments": {
> >       "path": "/machine/peripheral/cxl-dcd0",
> >       "region-id": 0,
> >       "extents": [
> >       {
> >           "dpa": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> >
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> [...]
> 
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 8cc4c72fa9..2645004666 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -19,13 +19,16 @@
> >  #
> >  # @fatal: Fatal Event Log
> >  #
> > +# @dyncap: Dynamic Capacity Event Log
> > +#
> >  # Since: 8.1
> >  ##
> >  { 'enum': 'CxlEventLog',
> >    'data': ['informational',
> >             'warning',
> >             'failure',
> > -           'fatal']
> > +           'fatal',
> > +           'dyncap']
> 
> We tend to avoid abbreviations in QMP identifiers: dynamic-capacity.

FYI. This has been removed to avoid the potential side effect in the
latest post.
v7: https://lore.kernel.org/linux-cxl/ZiaFYUB6FC9NR7W4@memverge.com/T/#t

> 
> >   }
> >  
> >  ##
> > @@ -361,3 +364,59 @@
> >  ##
> >  {'command': 'cxl-inject-correctable-error',
> >   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> > +
> > +##
> > +# @CXLDCExtentRecord:
> 
> Such traffic jams of capital letters are hard to read.
> 
> What does DC mean?
Dynamic capacity
> 
> > +#
> > +# Record of a single extent to add/release
> > +#
> > +# @offset: offset to the start of the region where the extent to be operated
> 
> Blank line here, please
> 
> > +# @len: length of the extent
> > +#
> > +# Since: 9.0
> > +##
> > +{ 'struct': 'CXLDCExtentRecord',
> > +  'data': {
> > +      'offset':'uint64',
> > +      'len': 'uint64'
> > +  }
> > +}
> > +
> > +##
> > +# @cxl-add-dynamic-capacity:
> > +#
> > +# Command to start add dynamic capacity extents flow. The device will
> 
> I think we're missing an article here.  Is it "a flow" or "the flow"?
> 
> > +# have to acknowledged the acceptance of the extents before they are usable.
> 
> to acknowledge

It should be "to be acknowledged". 

> 
> docs/devel/qapi-code-gen.rst:
> 
>     For legibility, wrap text paragraphs so every line is at most 70
>     characters long.
> 
>     Separate sentences with two spaces.

Thanks. Will fix.
> 
> > +#
> > +# @path: CXL DCD canonical QOM path
> 
> What is a CXL DCD?  Is it a device?
Dynamic capacity device.
Yes. It is cxl memory device that can change capacity dynamically.

> 
> I'd prefer @qom-path, unless you can make a consistency argument for
> @path.
> 
> > +# @region-id: id of the region where the extent to add
> 
> What's a region, and how do they get their IDs?

Each DCD device can support up to 8 regions (0-7).  

> 
> > +# @extents: Extents to add
> 
> Blank lines between argument descriptions, please.
> 
> > +#
> > +# Since : 9.0
> 
> 9.1

Already fixed in the latest post.

> 
> > +##
> > +{ 'command': 'cxl-add-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'region-id': 'uint8',
> > +            'extents': [ 'CXLDCExtentRecord' ]
> > +           }
> > +}
> > +
> > +##
> > +# @cxl-release-dynamic-capacity:
> > +#
> > +# Command to start release dynamic capacity extents flow. The host will
> 
> Article again.
> 
> The host?  In cxl-add-dynamic-capacity's doc comment, it's the device.

For add command, the host will send a mailbox command to response to the add
request to the device to indicate whether it accepts the add capacity offer
or not.

For release command, the host send a mailbox command (not always a response
since the host can proactively release capacity if it does not need it
any more) to device to ask device release the capacity.

But yes, the text needs to be polished.

> 
> > +# need to respond to indicate that it has released the capacity before it
> > +# is made unavailable for read and write and can be re-added.
> 
> Is "and can be re-added" relevant here?

Not really. Will fix.

> 
> > +#
> > +# @path: CXL DCD canonical QOM path
> > +# @region-id: id of the region where the extent to release
> > +# @extents: Extents to release
> > +#
> > +# Since : 9.0
> 
> 9.1

Already fixed in the latest post.

Thanks again for the review. Will take care of the comments in the next
version.

Fan
> 
> > +##
> > +{ 'command': 'cxl-release-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'region-id': 'uint8',
> > +            'extents': [ 'CXLDCExtentRecord' ]
> > +           }
> > +}
> 
