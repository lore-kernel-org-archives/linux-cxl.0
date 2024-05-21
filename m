Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30B89475
	for <linux-cxl@vger.kernel.org>; Tue, 21 May 2024 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716334738; cv=none; b=BlOAw5It0nhfxqNuvvq4PbDOsNfPfEVbZ+qCy0s7HgyeJl1PcQf5vEG7+RZ7G02dJetNCZiwcgFY/s/75xU4QJKwUiRAg0NWQVZ75ZIodWSV6VyQ7P38E0wZgc5hzg+AZ0YgtIFe302Ly054l4WUt15SKgSRZ5MKFqojpxqcLVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716334738; c=relaxed/simple;
	bh=9ZV1+nGYMx4cXzcJ4bP+Ui5i0xdIVb28x/QSO394DJE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8vKtFVLZYQk1xI26xBWmf9LP9GyItMGz4/MavDUtk7eFv3GTLCGpFmMhT3/dvl0Nkao/KLty97OrytrxqnqRPLGiJ/k1mMReu4gAMt9s48YofTOBpCT44am0zJrc2RTGoUuFIQxEuOgHduCwXVJNcZmbK/KatpZh0KSBYNrA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDmHH8Ks; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDmHH8Ks"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso1393096a12.2
        for <linux-cxl@vger.kernel.org>; Tue, 21 May 2024 16:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716334736; x=1716939536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TfCnJtdyD/uzrKZ8o/xY+WhPnZ4AgcXIZ/ZIkO8OCP0=;
        b=XDmHH8KsxcFqi+QJJ/QIiVVhXH/ipEVQhee0fbs7CiLCn+pcPc7ZjH8GOlgfAnMfJf
         G2K/giuTx3OojgLXewgp/+WsNqFOsTrnaMhg+M548xsrHymhxoyjnoGsWXcdXl2jjemE
         oym7+pc6DSjaedq4P4We7XvJfIPrkahjnwDHIhdMBTtvLE1zIcOVdrskMn56OGAVRjvg
         4KB0onN74cUkqetN1ahJJvo4NFGY/Vd7DdexJ2DLJmwbFBWf1EIu3cJ438+qwJJPgZBt
         upn0XVqK4cQ+uxpDcRLUmdLBhtaxHSwqPYuEG2xDhgQL3jy8alCxqMtHqgqwZTUz2ORg
         C3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716334736; x=1716939536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfCnJtdyD/uzrKZ8o/xY+WhPnZ4AgcXIZ/ZIkO8OCP0=;
        b=JFMC+eboY/PDvRmfcEAE+3NBOhQGUaazYMedSjaFm9P3P7TSa1qwxwpxW5vUjr8+9u
         NkSrZS/gr5roexvtuiXSx3IUXAQxFSKxu/QCsmx/9Pn7v+nI/nqV9ZC0kw0bXyYqjaE1
         CFlfaMShhPPs5hQJ8vzVs2Fao+B6qfTK0llW/PtGAQRkz3t2qiqNu3Pc3M0TVPSHaX36
         fSI6oP9rVmZMPNis+eBvcYkY/ejbf/wF8KqoyYoQkyi0B8xPbBZclV8xpfv/xQijcd97
         +IMeoGDqaP5i+O7tDj6EUb7+bJEGmMXCVskhp2cLDDQEqq/QGHjFAWVSbPJZ/rbtB9zc
         xKUw==
X-Forwarded-Encrypted: i=1; AJvYcCW3EMXbJN1Ljg1AulPBDpzxseEtgHTLUAs+EotdX7YZJPKWTGsA276lalkNmsZRPxTBj1BsInIruc2kYBK3pufcGYB/9LBa4TrC
X-Gm-Message-State: AOJu0YxS1pZlIDs0pqhOhznF1HaYRYZIbYi8yM3c9QFrCJ5jMsXBnlBQ
	GcbGSR+beQIVQs6+xsb4Zc8mM5pyvT85NgesXjS11iyLlPVkvmhG
X-Google-Smtp-Source: AGHT+IHI8ENoGEW9i2PKsQzv7nwT9Wh0XjRg/c0q3ldfcn7oTJRiDXl4QIwkMhGdGFu3XXTUcaWZBg==
X-Received: by 2002:a05:6a21:3386:b0:1a9:8b4a:b84 with SMTP id adf61e73a8af0-1b1f884508fmr544182637.18.1716334735986;
        Tue, 21 May 2024 16:38:55 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:3a56:ff85:21cf:d468])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2563c0sm226881995ad.287.2024.05.21.16.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 16:38:55 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 21 May 2024 16:38:53 -0700
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
Message-ID: <Zk0wjWL2cbwdF69r@debian>
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

Hi Jonathan,
FYI.
I just sent out the updated QAPI patch with selection policy defined as
enum and removal policy split out in this thread,
https://lore.kernel.org/linux-cxl/5856b7a4-4082-465f-9f61-b1ec6c35ef0f@fujitsu.com/T/#m9838d6afda49fb26eb90526eae5550256f5d0f56

Planning to send out v8 on Thursday.

Fan

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
> 
> > +#
> > +# @region: The dynamic capacity region where the extents will be
> > +#     released.
> 
> This has a better definition in the add dynamic capacity entry above.
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
