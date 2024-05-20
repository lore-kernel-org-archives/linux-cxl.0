Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEDB34CDE
	for <linux-cxl@vger.kernel.org>; Mon, 20 May 2024 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716227759; cv=none; b=Hr/8mKLA2z7EtZhDvKQ6gXIQ/j0UqWzgC4yTqEm95YpbJhju4+CIK1M3Y0XrhbU8U7pKfSc+y6/RWTMsOk04ym8vJK3r7QBAMtioU5uZEoAp63qE48ZyavjdCawkZmRoAqYu4HKfBB94jSTEPInP4+PEVF2v+7eelAKqFU1o5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716227759; c=relaxed/simple;
	bh=wTY0gni9gDcv3yW/QgjZF5SEzVCCQbZJmeG322g5hss=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQ+5timk3IdlSR2W+6PBav/WIjuZbqrPKqt5s0sIMufu8HaRuoW1rnL/DyAncdq7RxrikO709x2Uq1p0h3A7RwRl6PN/7znXgeQ6HfTgZYRiNmEgTNjCn1qlojzVjmvBJ/YN+uf9IpQjuCp0SRjB/4D9UBo6BqcRss6+8JNfZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEr3YGc0; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEr3YGc0"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de61424f478so2701891276.0
        for <linux-cxl@vger.kernel.org>; Mon, 20 May 2024 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716227757; x=1716832557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BtjAIyJLEqd+Ar6/hpaY1HvZ1kKP7FiX4lHjiKrcUkM=;
        b=UEr3YGc0TFvailYIks73R4h1cvIWaw9HeBFXNBFZcqQoSW3Aiv/6C70hvFYxPpbNaM
         9d8fb613yzIXTcAxFDJS8rS4uyw9CCWCGYvo2/Rh3l/qETDWUnalQrvBvdpcU6oj8kOC
         AkviGOrXeMbR86xNyiMoxAJj7WxTbvHpwouwzsdSeXOmXQm2XcBeGWyggMMw5sLvl5UA
         2SMJRZkLPe2w4hcV+6BSZF2EBV5EU1BZrkJqJrWIXjhQyGOUfjEGlNTXt4cz/w6tO592
         izdYeeeRzXLi13ri4Tylk5SgEeoGan96Hm+l/MCwD8ei/8CETCxtfz4MdD1dA4SlBLCG
         il5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716227757; x=1716832557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtjAIyJLEqd+Ar6/hpaY1HvZ1kKP7FiX4lHjiKrcUkM=;
        b=ZRixNtxDNBf6tbzLbnbut/8mHSX/0v/g7B0yTrM9fphuvwoLxKSBKytP+eIvoey7EV
         FweDsq2eKJjwznlWX2gHLDwlp/l1rUzF4sy+xV80aglpXtw3htH4cHTgOPwJSyrF7Stm
         r0L/JZJ1XsBneBBimOZiGeOiuO8M2ptinjkIlgKMsF+5ZQoXwb/wylJTU6XAqV8ykLOA
         Njr+mxtxMMa0goBqnCMx23uEP7SkuQVrgF3bGe8a++YCDvCA5DwJDMFvWn6B/9Z9Hk2q
         XfYHTiw9vdEk3VnmROcQqxCDHtfjvBNG7D7NXwStNbu+9eNJ1Y/xOdORxXP8D6ZOV6wX
         oWiw==
X-Forwarded-Encrypted: i=1; AJvYcCUysiHD9Gdl6I9dxzo9uMuTQjIhrW9UIMoTYAqf2k28a88MrZcJaNxkYqFWApOhJRGDtXwnmFypHyr+5niiQs4kFb4LhDI0pX/a
X-Gm-Message-State: AOJu0YzLXGf0Ok5x/YNI+LlVp4vH68LO2YA+/FPBYyVj779hpOHEDqXY
	Yuh82B06jT2xrOd9fWK5PWsDK2mpDxIQaSED8b6q4BW2C1D0ebLb
X-Google-Smtp-Source: AGHT+IEYrKDe5exF08nsZpdAWuKzkvTmM4QcyPcyPsDamE95yqUGPNA5y6MRzoSCzaUkwj/egK3DRw==
X-Received: by 2002:a5b:d4b:0:b0:df4:4345:260b with SMTP id 3f1490d57ef6-df4434527d3mr14529116276.36.1716227757112;
        Mon, 20 May 2024 10:55:57 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dee6073d62esm4377992276.1.2024.05.20.10.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 10:55:56 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 20 May 2024 10:55:41 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	gregory.price@memverge.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZkuOnZCxyo896ocv@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-10-fan.ni@samsung.com>
 <877cgkxzal.fsf@pond.sub.org>
 <Zivk37xBGPsL_yo5@debian>
 <87h6fkob0t.fsf@pond.sub.org>
 <ZjLCS8yJC-OvPsUS@debian>
 <20240520175012.000045fe@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520175012.000045fe@Huawei.com>

On Mon, May 20, 2024 at 05:50:12PM +0100, Jonathan Cameron wrote:
> On Wed, 1 May 2024 15:29:31 -0700
> fan <nifan.cxl@gmail.com> wrote:
> 
> > From 873f59ec06c38645768ada452d9b18920a34723e Mon Sep 17 00:00:00 2001
> > From: Fan Ni <fan.ni@samsung.com>
> > Date: Tue, 20 Feb 2024 09:48:31 -0800
> > Subject: [PATCH] hw/cxl/events: Add qmp interfaces to add/release dynamic
> >  capacity extents
> > Status: RO
> > Content-Length: 25172
> > Lines: 731
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
> >       "selection-policy": 2,
> >       "region": 0,
> >       "tag": "",
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
> >       "flags": 1,
> >       "region": 0,
> >       "tag": "",
> >       "extents": [
> >       {
> >           "offset": 134217728,
> >           "len": 134217728
> >       }
> >       ]
> >   }
> > }
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> Hi Fan,
> 
> A few trivial questions inline.  I don't feel particularly strongly
> about breaking up the flags fields, but I'd like to understand your
> reasoning for keeping them as single fields?
> 
> Is it mainly to keep aligned with the specification or something else?
> 
> Thanks,
> 
> Jonathan
> 
> 
> >  #endif /* CXL_EVENTS_H */
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 4281726dec..27cf39f448 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -361,3 +361,93 @@
> >  ##
> >  {'command': 'cxl-inject-correctable-error',
> >   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> > +
> > +##
> > +# @CXLDynamicCapacityExtent:
> > +#
> > +# A single dynamic capacity extent
> > +#
> > +# @offset: The offset (in bytes) to the start of the region
> > +#     where the extent belongs to
> > +#
> > +# @len: The length of the extent in bytes
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
> > +# @cxl-add-dynamic-capacity:
> > +#
> > +# Command to initiate to add dynamic capacity extents to a host.  It
> > +# simulates operations defined in cxl spec r3.1 7.6.7.6.5.
> > +#
> > +# @path: CXL DCD canonical QOM path
> > +#
> > +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> > +#     Table 7-70.
> > +#
> > +# @selection-policy: The "Selection Policy" bits as defined in
> > +#     cxl spec r3.1 Table 7-70.  It specifies the policy to use for
> > +#     selecting which extents comprise the added capacity.
> 
> Hmm. This one is defined as a selection of nameable choices.  Perhaps
> worth an enum?  If we did do that, we'd also need to break the flags
> on in the release flags below.

Initially, I defined a enum for selection policy. But for users who are
not familiar with CXL spec, I think the enum definition is not very clear to
to them without reading the spec, so I removed it. Also, there are some
reserved bits there, let it as uint8 may help keep the interface unchanged
if some of the bits are used in the future?

> 
> 
> > +#
> > +# @region: The "Region Number" field as defined in cxl spec r3.1
> > +#     Table 7-70.  The dynamic capacity region where the capacity
> > +#     is being added.  Valid range is from 0-7.
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
> > +            'selection-policy': 'uint8',
> > +            'region': 'uint8',
> > +            'tag': 'str',
> > +            'extents': [ 'CXLDynamicCapacityExtent' ]
> > +           }
> > +}
> > +
> > +##
> > +# @cxl-release-dynamic-capacity:
> > +#
> > +# Command to initiate to release dynamic capacity extents from a
> > +# host.  It simulates operations defined in cxl spec r3.1 7.6.7.6.6.
> > +#
> > +# @path: CXL DCD canonical QOM path
> > +#
> > +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> > +#     Table 7-71.
> > +#
> > +# @flags: The "Flags" field as defined in cxl spec r3.1 Table 7-71,
> > +#     with bit[3:0] for removal policy, bit[4] for forced removal,
> > +#     bit[5] for sanitize on release, bit[7:6] reserved.
> 
> This can be nicely broken up into removal policy enum plus two flags.
> It might be worth doing so to give a nicer interface?

So if we choose to do it this way, maybe we use enum for the above add
command also?

> 
> > +#
> > +# @region: The dynamic capacity region where the extents will be
> > +#     released.
> 
> This has a better definition in the add dynamic capacity entry above.

Yeah, will fix. 

Fan
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
> > +            'flags': 'uint8',
> > +            'region': 'uint8',
> > +            'tag': 'str',
> > +            'extents': [ 'CXLDynamicCapacityExtent' ]
> > +           }
> > +}
> 
