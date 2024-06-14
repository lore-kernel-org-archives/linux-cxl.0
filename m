Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9AC1922C1
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718362654; cv=none; b=o1A2khG13+5tHfeo1oVjYzfngvUQQH1doCmzZ6mumtv3WV+/VLP6P1vdPcxdY6C5V/q3dFN+Y6bqhXBLpH93KK1uPGeoCXsGlZ+T3SCeS9zq/x9ejqTq1OZQocyugilo61pzlpC5awi2sHlqrFtx+o0ejOeyuwMSrC+SKQH/4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718362654; c=relaxed/simple;
	bh=cQJZpCjkx6FLhdD5+DB2mWzSr1FJiyM4ZnShaJVtnGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0m+z5fY9MLHdBuf8hm5KRM66uUyFdx9W2B1wz7z9AIkipQYgNWTtYpRPsDmivZF4Vt4sY1F8TfTEdQdkxU44yiHlj9Tfx/aByVYSfsrWMDkE6bNO7+VgEVCI1b62UJcf6pOoogT4ai7RVWXlrNshAyvbnnzs3ayZphLGXqVDOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLRmdusn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLRmdusn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718362651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fN7WzfpET8/k+tVrmxHvGsh2LVZtfm7YDEkeLlFW7/s=;
	b=QLRmdusnFR3J3P7/fm0vBxhy7j0nVq+g37MfI0QbNvsjPshz9cDqWcPmTHggweINP0tHTl
	4E+OJN43PNnsLTtyQnavIhJwmejDUzt62/001wfMVq9La2PKlYc8sWXNBKIPmPzGak5Qyl
	+Ek9Db2ZVjVbEGS/jaGKTGA6Rp4AfTE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-F8QbX2VsPpa3v_hOZI6y6w-1; Fri, 14 Jun 2024 06:57:30 -0400
X-MC-Unique: F8QbX2VsPpa3v_hOZI6y6w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4217f941ca8so14047025e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 03:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718362649; x=1718967449;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fN7WzfpET8/k+tVrmxHvGsh2LVZtfm7YDEkeLlFW7/s=;
        b=lcMZ5QN8xKPufVWUUUu4PXHoOLEG6exGL5av4l22PTMLYNp8R1Kn7g7HzeIExmXe0W
         K8QpWGIGUiww3PwuY2zgWDkpKlfSWp4xk4y0lLVpMoALrff0cIjRMJfsmLoU2H8y4MKl
         7pw9N9DSAkYTQZz34KQU0OzQFRHXkJSdKaOebRWNGRmDXbtvC6ffJWhJaF16nQ9evGWk
         QwnQ4pk6DsNkjmuOYn44KQGJixe6yRDhx6tdwB3xJitC+liwD5ugI3E+IOBbLZkrd0+q
         C7qi99ramR6s/8qLI0BSh6q+UlxGnoepu5c3QGgsxoBGyzbUA3dst1qHR7sX+bSu4IXu
         NqPA==
X-Forwarded-Encrypted: i=1; AJvYcCWMY9wkqMIPLSYMc2XaXAO3rWq8jlR8DgLW9eTTC5KTXPvN+XLJx1kUtVp/NHhoZqqdHfI6tc5wQTgaLCINqt/N521KmF5raZuJ
X-Gm-Message-State: AOJu0YyHg4PCREJbryOMw0cG9u9Ivp3qLoF6S37L4tsXWYeiJaiSH6X4
	PbtYSL197u8hzFDa9w3RPLLitO2Dy2psLOyTAMj9Bj9FenRG+kOc3WE0q5rUnSLB8kueBZRn0Jh
	806lIjVC6jO4qqS0hLsymv7vflSeeHvS/yeSQLQILl5yz223GLqNeFF5/FA==
X-Received: by 2002:a05:600c:4206:b0:422:123f:4b15 with SMTP id 5b1f17b1804b1-42304859ac3mr18967705e9.37.1718362649235;
        Fri, 14 Jun 2024 03:57:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh2zbOD2OPNaUR8T5QPRlt0WZVOKSQ2zPkrdXRzfccin7dF1Bb80XKafBtiXS+LPnfFW+CtQ==
X-Received: by 2002:a05:600c:4206:b0:422:123f:4b15 with SMTP id 5b1f17b1804b1-42304859ac3mr18967445e9.37.1718362648774;
        Fri, 14 Jun 2024 03:57:28 -0700 (PDT)
Received: from imammedo-mac ([185.140.112.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eefa07sm94554795e9.8.2024.06.14.03.57.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2024 03:57:28 -0700 (PDT)
Date: Fri, 14 Jun 2024 12:57:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, Dave Jiang
 <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH qemu ] hw/acpi: Fix big endian host creation of Generic
 Port Affinity Structures
Message-ID: <20240614125725.730f8914@imammedo-mac>
In-Reply-To: <20240606184716.00000708@Huawei.com>
References: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
 <20240606160653.27226def@imammedo.users.ipa.redhat.com>
 <20240606184716.00000708@Huawei.com>
Organization: imammedo@redhat.com
X-Mailer: Claws Mail 3.11.1-67-g0d58c6-dirty (GTK+ 2.24.21; x86_64-apple-darwin14.0.0)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 18:47:16 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 6 Jun 2024 16:06:53 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Wed, 5 Jun 2024 19:04:55 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > 
> > > Treating the HID as an integer caused it to get bit reversed
> > > on big endian hosts running little endian guests.  Treat it
> > > as a character array instead.
> > > 
> > > Fixes hw/acpi: Generic Port Affinity Structure Support
> > > Tested-by: Richard Henderson <richard.henderson@linaro.org>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > ---
> > > Richard ran the version posted in the thread on an s390 instance.
> > > Thanks for the help!
> > > 
> > > Difference from version in thread:
> > > - Instantiate i in the for loop.
> > > 
> > > Sending out now so Michael can decide whether to fold this in, or
> > > drop the GP series for now from his pull request (in which case
> > > I'll do an updated version with this and Markus' docs feedback
> > > folded in.)
> > > 
> > > ---
> > >  include/hw/acpi/acpi_generic_initiator.h | 2 +-
> > >  hw/acpi/acpi_generic_initiator.c         | 4 +++-
> > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
> > > index 1a899af30f..5baefda33a 100644
> > > --- a/include/hw/acpi/acpi_generic_initiator.h
> > > +++ b/include/hw/acpi/acpi_generic_initiator.h
> > > @@ -61,7 +61,7 @@ typedef struct PCIDeviceHandle {
> > >              uint16_t bdf;
> > >          };
> > >          struct {
> > > -            uint64_t hid;
> > > +            char hid[8];
> > >              uint32_t uid;
> > >          };
> > >      };  
> > 
> > not sure on top of what this patch applies but I have some generic comments wrt it
> 
> https://lore.kernel.org/qemu-devel/20240524100507.32106-1-Jonathan.Cameron@huawei.com/
> 
> Comments are all on elements of the existing upstream code, but I'm touching it
> anyway so will look at making the improvements you suggest as new precursors
> to v3 given we are going around again anyway.
> 
> > 
> > why PCIDeviceHandle is in header file? is there plan for it
> > being used outside of acpi_generic_initiator.c?
> 
> I'll add a precursor patch to my series that moves
> it and anything else that should be more local.  May well move
> to being local in aml_build.c given your later comments with the
> various fields passed in as parameters.
> 
> > 
> > 
> > > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > > index 78b80dcf08..f064753b67 100644
> > > --- a/hw/acpi/acpi_generic_initiator.c
> > > +++ b/hw/acpi/acpi_generic_initiator.c
> > > @@ -151,7 +151,9 @@ build_srat_generic_node_affinity(GArray *table_data, int node,
> > >          build_append_int_noprefix(table_data, 0, 12);
> > >      } else {
> > >          /* Device Handle - ACPI */
> > > -        build_append_int_noprefix(table_data, handle->hid, 8);
> > > +        for (int i = 0; i < sizeof(handle->hid); i++) {
> > > +            build_append_int_noprefix(table_data, handle->hid[i], 1);
> > > +        }
> > >          build_append_int_noprefix(table_data, handle->uid, 4);
> > >          build_append_int_noprefix(table_data, 0, 4);  
> > 
> > instead of open codding structure
> > 
> > it might be better to introduce helper in aml_build.c
> > something like 
> >   /* proper reference to spec as we do for other ACPI primitives */
> >   build_append_srat_acpi_device_handle(GArray *table_data, char* hid, unit32_t uid)
> >       assert(strlen(hid) ...
> >       for() {
> >             build_append_byte()
> >       }          
> >       ...
> > 
> > the same applies to "Device Handle - PCI" structure
> 
> I'll look at moving that stuff and the affinity structure creation
> code themselves in there. I think they ended up in this file because
> of the other infrastructure needed to create these nodes and it
> will have felt natural to keep this together.
> 
> Putting it in aml_build.c will put it with similar code though
> which makes sense to me.

the point of moving handle packing to aml-build.c,
is to isolate primitives that likely could be reused later on elsewhere
and hide little endiannes from API user.
So shuch errors as you are fixing wouldn't be easy to introduce
(as long as API does it right)


Also this API probably should take not packed BDF, i.e. something like this:
    build_append_srat_pci_device_handle(GArray *table_data, bus, dev, func)

Or a packed BDF as you suggest in the later email, but then API function wold have
to 'decode' that before putting numbers into table, which complicates things
and likely would pull in PCI deps to unpack BDF, which I'd rather avoid in
generic aml-build.c

> 
> > 
> > Also get rid of PCI deps in acpi_generic_initiator.c 
> > move build_all_acpi_generic_initiators/build_srat_generic_pci_initiator into
> > hw/acpi/pci.c
> 
> Today it's used only for PCI devices, but that's partly an artifact
> of how we get to the root complex via the bus below it.
> 
> Spec wise, it's just as applicable to platform devices etc, but maybe
> we can move it to pci.c for now and move it out again if it gains other
> users. Or leave it in acpi_generic_initiator.c but have all the aml
> stuff in aml_build.c as you suggest. 
> 
> > file if it has to access PCI code/structures directly
> > (which I'm not convinced it should, can we get/expose what it needs as QOM properties?)
> 
> Maybe. I'll see what I can come up with.  This feels involved
> however so I'm more doubtful about this as a precursor.
> 
> > 
> > btw:
> > build_all_acpi_generic_initiators() name doesn't match what it's doing.
> > it composes only one initiator entry.
> 
> I'll look at tidying up all the relevant naming.
> 
> Jonathan
> 
> > 
> > >      }  
> > 
> > 
> 

