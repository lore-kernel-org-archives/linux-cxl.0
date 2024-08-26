Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BCB1993BA
	for <linux-cxl@vger.kernel.org>; Mon, 26 Aug 2024 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708139; cv=none; b=cTOSrgkVDWTJ8U8L4lHLHO6XgAZhn0V95Z3r9r9b+yZJAQ4v3QzdaDYDrC/Bku+PaZtsLgygh8puXajQwr7WxKA5fsj7/sOrJaRz7Wnu6AKxBgWmPUsAR5ynfO6wkP4rpPC4pki0hQxKbQru3mRrNAOHtUIBnyxuTWodKbELLDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708139; c=relaxed/simple;
	bh=y3bTwWiAvBcr8xpfUU+F1eoqSM/33mMGjdhkV+RrYk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfVzIINzSRspCMK9sPImvLVl4/D9kqIX/SoGaOpT9Ej2h73TyaSIR+g1/NJlaY++LmhgjAQ/tgYbCgbUstUJ0SS0K+CelVOiTI6/R5ntxQBpC+YQ8lG1h798IhU1LCl2O8vwgNnK+0Y0NpTxedKjQVCYBgxA/PhErBvR5UX933U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDYP5E7b; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDYP5E7b"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-498cca5d48aso1666682137.3
        for <linux-cxl@vger.kernel.org>; Mon, 26 Aug 2024 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724708135; x=1725312935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XeMKiOOWPXVPZaxetALQ00I6J7fyRUHujLp8LvoZwXg=;
        b=eDYP5E7b9uHjPl9WPg4kvWYsXffcLOG0UtNOBgn8KrzRYwX3OuDlp76nyVL4jt9MHK
         9XKJ+tDRXfvIyfBoLT8q7uBgtJqfZncLXL3fllTS/9S2d9UBGOrO12IFW0jhmaXSAv+B
         8jrYfIePw8FbqBcEnifhIW8+1pnU3AUv+vICsdOAre1o+QgjKTQYFXdD/gFoquwCqpla
         yrEzcOLjSpsj0Q4dpa6immvi2QZenH95nsROwbPBn7mVGXr0vDkEUFszgtjd4ud5O5di
         QuezaNAJLx0aI34lkBQsabGircPOXPuGgsFi41BFzBkjrCCnuu9le6OuPUURVhkWhWOp
         gRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724708135; x=1725312935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeMKiOOWPXVPZaxetALQ00I6J7fyRUHujLp8LvoZwXg=;
        b=ll7gB9HvwhXVIJFhmy4eX/ZVBgmfycg6rgwUCC5Z8HLX4QCN6WSsz9NwXWAKJ0DJR8
         GuxI19Bpo4xmB7ZABuE1W2RXCOeIwMsXPL2GmNCbvoqYBUDDL6dM+8o+7Jz7hIRTiMJx
         0XLmFiz1G8AfkmRO6+kXZvpKdWIyKWxxWuHzlXMyjFbFCwwC1J4l26k+b202O/aG7D4q
         StiC6mQqUtFcinBZLXQes3MNzMxVAVwQ3SfZYiyVMBPm7n68QBdOVDhbPoG7/TMcO60A
         gj53wbQZleUH5KSK/ok1HbwdiIgbUA6tdnV2072PjK8DLip3hFmDysS0kX3kBDpRfBVD
         rEqg==
X-Forwarded-Encrypted: i=1; AJvYcCWSYmo8vdNci7bMezOApgYdFWMa9rksRgXCVbLTk3NtjumxhFNEVnbNrMfw/DTY6cN9Vx7JQEdCAA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmAUKp99ES7CLOh4blEM3GENPCBrNnvz7Xscj5b6h3OYWi1eBE
	uoaaFL11ZIeLGcBVmUmIcM1tv96pweNQOMBX6WOXk4KSJQyJ085+cEPFukpmdTnXn9iGzKSSAoO
	yC7LQE3gb6OQOCMP2yQZQbi7Yj5aAfgrErZAx4cRFlOg/AJzQ9yHO
X-Google-Smtp-Source: AGHT+IFahHCeuJlDlaa5/eCHItPH4qVMJYdtrrT4au2DWbduZ36ZOWkktQQxYZjPExV2o/UzTy6gpYMEXZF8JXmpOv4=
X-Received: by 2002:a05:6102:4427:b0:498:e22a:433f with SMTP id
 ada2fe7eead31-498f451fb7bmr15509004137.3.1724708135341; Mon, 26 Aug 2024
 14:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814205303.2619373-1-kevinloughlin@google.com> <0bae453d-b4a8-3132-9fd0-bca0eece6a74@amd.com>
In-Reply-To: <0bae453d-b4a8-3132-9fd0-bca0eece6a74@amd.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Mon, 26 Aug 2024 14:35:24 -0700
Message-ID: <CAGdbjmLVFZJq7OJv2OwM3knmwfb-j8nZP7G_ownFA3kd3fYbVA@mail.gmail.com>
Subject: Re: [PATCH] device-dax: map dax memory as decrypted in CoCo guests
To: "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, changyuanl@google.com, pgonda@google.com, 
	sidtelang@google.com, tytso@mit.edu, pasha.tatashin@soleen.com, 
	thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"

> How can I test this? Can I test it with virtio-pmem device?

Correct. Assuming the CoCo guest accesses some virtio-pmem device in
devdax mode, mmapping() this virtio-pmem device's memory region
results in the guest and host reading the same (plaintext) values from
the region.



>
> Thanks,
> Pankaj
> >
> > Signed-off-by: Kevin Loughlin <kevinloughlin@google.co > ---
> >   drivers/dax/device.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> > index 2051e4f73c8a..a284442d7ecc 100644
> > --- a/drivers/dax/device.c
> > +++ b/drivers/dax/device.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/fs.h>
> >   #include <linux/mm.h>
> >   #include <linux/mman.h>
> > +#include <linux/cc_platform.h>
> >   #include "dax-private.h"
> >   #include "bus.h"
> >
> > @@ -303,6 +304,8 @@ static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
> >
> >       vma->vm_ops = &dax_vm_ops;
> >       vm_flags_set(vma, VM_HUGEPAGE);
> > +     if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> > +             vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
> >       return 0;
> >   }
> >
>
