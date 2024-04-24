Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AAB16C6A5
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978642; cv=none; b=g9ZAmYvOHaf/jyXAeugNzpPjpRonbykSA+1xGyxvSXq+jWeZLpgJP2YMRiLbtrZ5V5sUCxGNzFKvB4ey86E6v1US7XjZbJAATS3cDb6zyrOeI5gimf0viwxEEHIC63IrH6So0LHXJAj3926m3jYo28VLUiRTf3tkOO2V91N09co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978642; c=relaxed/simple;
	bh=pEBNdxNaPuOVUvZKmQdyzQARVm/yiyLxPLLWM3ari0M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEOt1iT+nwl6ysuH6xCr+1OL/PgSzC4p++ZxMxdQD9sxyGXjFKN0w7tiTDRwy/ZZcJE3T+QFIpNcdPQLObO2+b8pLbhziS7d2vBLYUVjODlhCUejlYJJkBe3myEbEO9i8DaRfB0Ng0BSMpCS1Ocg5GCGz5ZSR+LZ5oV3VKfBjWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF368ubf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF368ubf"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e5715a9ebdso247055ad.2
        for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 10:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713978640; x=1714583440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BgjSmDm9nEqvaBmKU8KVrKDMCb4dJzu5b3vNyI4pLQ8=;
        b=fF368ubfTmeaQb++za28PfeGjFwjHnRtdpm976cFPaV5ynZ6vXSocCkwo5EnruRTVw
         9F7pEv6lczHmnlxI9z88d+7L5P0Iz1uUJbV9V32RBMponR5jc8kZNGp1YrpFpEfa3IYx
         3z0JCZfUZAU+WjG0RGshQMyyhbatJpAgB2qtn01Thqooxp/7t0z2eHuwCswso3VG4lZP
         d3l8U9qqteb1xHMXumMD7gkUoQNjRUdq/j51gS5i1lF081yIqb3XrQGwP10BF6T1ZaK0
         T24Gnm5gw28HB4pe0dqZZxmh2toCqoKltL473adHN3S7QiHBJC3mMYd+KB9o0A16fhgM
         d22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713978640; x=1714583440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgjSmDm9nEqvaBmKU8KVrKDMCb4dJzu5b3vNyI4pLQ8=;
        b=P5Zl/U+gc47AKkGTSBoOVBGRdqpAJ/a6lHuO1AuleHJCojuAzC1mQenXhOYQp7rvu4
         umSnzGg3HKG3gRxZeuMicJPVTAZhhTjOBar5AS8sRInjZj69X6zPZqil2mxZ1z6raOWd
         81GX9Wg1Gb5LRoib2d4dIacc3y3WCZBiy0Q6+sHqur1kVw7V4K+5u3n6MRnrSs03k1uX
         ycROYDyVFyqDwR1SKIHmFgJbHebe8CV1MiU51M9Y5aSSKjOZ/n4Y6CHmwObWc5DYEMSE
         qFQG5fzIOeFpLl3KnSklHDUJO4pYWJwKrDGwD/JfUTTH2IHmIa1BMu1OxTqVr/XY4JLQ
         yT2g==
X-Forwarded-Encrypted: i=1; AJvYcCWZgaqWH4Xdue+YrC4Ez86x8xkdAVu5HcUEEoscydx5wfZoSMOPtwKges7JjViO4IwMdLBQ0/dVQcWtKaameZ/Iy1KutHNK4gGT
X-Gm-Message-State: AOJu0Yx9utN11nI+uPOCL8b8VGVW6Ieu+stH1s4wp/27GT33XkHvJKou
	3U/rQCOlnsEOY5Yi2c7yz3ZcyaXCOtaxDNBHkDBIpjAXjy5XbWCL
X-Google-Smtp-Source: AGHT+IFrb1yUe3eATE8i9Ne+A2xiCXoLKalUBVD/ETaTOSSQr0L7gGa/lf2DfSTtL/TjWXr0quHdhg==
X-Received: by 2002:a17:902:e5d2:b0:1e6:40f1:9357 with SMTP id u18-20020a170902e5d200b001e640f19357mr3836801plf.8.1713978640164;
        Wed, 24 Apr 2024 10:10:40 -0700 (PDT)
Received: from debian ([2601:641:300:14de:b318:9476:706a:e82a])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001e3e081d07esm12409930plb.179.2024.04.24.10.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 10:10:39 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Apr 2024 10:10:08 -0700
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
Message-ID: <Zik88BUMsMEFb0Nr@debian>
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
> 

Hi Markus,
Thanks for reviewing the patchset. This is v5 and we have sent out v7
recently, there are a lot of changes from v5 to v7.

FYI. v7: https://lore.kernel.org/linux-cxl/ZiaFYUB6FC9NR7W4@memverge.com/T/#t

Fan

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
> 
> docs/devel/qapi-code-gen.rst:
> 
>     For legibility, wrap text paragraphs so every line is at most 70
>     characters long.
> 
>     Separate sentences with two spaces.
> 
> > +#
> > +# @path: CXL DCD canonical QOM path
> 
> What is a CXL DCD?  Is it a device?
> 
> I'd prefer @qom-path, unless you can make a consistency argument for
> @path.
> 
> > +# @region-id: id of the region where the extent to add
> 
> What's a region, and how do they get their IDs?
> 
> > +# @extents: Extents to add
> 
> Blank lines between argument descriptions, please.
> 
> > +#
> > +# Since : 9.0
> 
> 9.1
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
> 
> > +# need to respond to indicate that it has released the capacity before it
> > +# is made unavailable for read and write and can be re-added.
> 
> Is "and can be re-added" relevant here?
> 
> > +#
> > +# @path: CXL DCD canonical QOM path
> > +# @region-id: id of the region where the extent to release
> > +# @extents: Extents to release
> > +#
> > +# Since : 9.0
> 
> 9.1
> 
> > +##
> > +{ 'command': 'cxl-release-dynamic-capacity',
> > +  'data': { 'path': 'str',
> > +            'region-id': 'uint8',
> > +            'extents': [ 'CXLDCExtentRecord' ]
> > +           }
> > +}
> 
