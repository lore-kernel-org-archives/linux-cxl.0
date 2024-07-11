Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A128FF
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712458; cv=none; b=nnsQgM5upp0/CuNbQoG37BohG/WzQuIYtrv8YnBkfyLZf4/g40BmY37FRtYmT6ldO0esX2kRxTE+BxkCGNorUHfk+u1Frm8ddFSiKzkpmeFtXu8K5fexuy7eA6BDW2rlYFgHuJuseQVkuX4j6c5W3ZVBGgi7qv93kUTdFT7yhjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712458; c=relaxed/simple;
	bh=rBkthWhcvQScir+tmHNx/hP5nmcCufgKFaMkLDKze2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LY5b1OcOFrzH3thio2jvHcYkzDTukBHWH/AzaOEl45rW3GLr8USGZm1WjVhFtbBEQ1OB8UrWkXcJFusBk0O+YkhxLxTz9/7ZrARFnpL2QtsPDuSRwFnV3S7SQWkJuZiuK467siC11ksSyuAmsoQ1TQaD40TWxdAHmzfETkHnYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKwYWXat; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKwYWXat"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720712455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OsjfsTlsj/Ghe1NV6WpqPyLw4t3Xvvi5gxbEOGMofqU=;
	b=RKwYWXatQ9ELhN7hO34Bm/j0Lt11d954pfp5X7U88o7tYhjyTEaFUFbbh8Z3K9uAC5geyq
	fkjV/uQr5KGkn4gv/azqzgu+UGi+Iut9PmIACpBUePzNOe7oUQh4xspIToLA1Y5QAeaqfk
	jBQdERauogyw/yPZgmkxqPnfhe7Adu8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-6xrogOPONRGzRepJ9TI3_A-1; Thu, 11 Jul 2024 11:40:54 -0400
X-MC-Unique: 6xrogOPONRGzRepJ9TI3_A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42667cc80e8so6464995e9.2
        for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 08:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720712453; x=1721317253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsjfsTlsj/Ghe1NV6WpqPyLw4t3Xvvi5gxbEOGMofqU=;
        b=lNVJtK0bakyGjFoJ8Lac7vegaBJgD7l0EQsX1SbTCS4VsP4sdabqnPKEBCrrCbZUu4
         +hEahLFP1FCKZWffxsknLrIAwrycA6IhzwBXX3eygmEcAZs7LjDoZDDjP4WXdg6Vb3Qn
         Jhl3univPLXN82F8JhYI2caP2eZAVh/hSE0vxwr/qbU03hWbPWuKtCJS300/BnphH/Uy
         BWVPjfXDJ/dfUOjxp8/nmGypszwDjvuD9vI1ZE2AvDYiSD2qOWxUYv0ssE3Es0N1lDcJ
         aT2CiKLbtdyEwxosPwKtorjPCB5qRN1voxndLIh2IPpfvDV1bqVzUODi33/sPWwN+yTf
         p6rw==
X-Forwarded-Encrypted: i=1; AJvYcCVO1DWvePtSx1dslOI2g+HY/7x02HvmW4KZdPSYdpxiKNXdmEhHyN4CvWhX4dIr2W1sIMJf72f38JLVie65u+p47oeuQgBBTB9o
X-Gm-Message-State: AOJu0Yy42/ywQ/DYIkdapmu0cQrcoAoBk50sBgPpCEckf80D4l3DsL5K
	8P6b+f7SF5ITkkwVuVfqisHxWI922B3C0odG/4tEWx1BbByUymmqWF2ugxsyrVegnGCUrZi6lTg
	PMPC4bZVuVt3O+iUw4Ijs+v04pIJkq1TTp1eQlo8oE9PoL+NBMeeQih/5wQ==
X-Received: by 2002:a05:600c:17c7:b0:426:654e:16d0 with SMTP id 5b1f17b1804b1-4267018b105mr74065675e9.0.1720712453025;
        Thu, 11 Jul 2024 08:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRjy+TOeaReztYTSjC/8SCGznQL2TkFSPfZoMqe2yvPzpSmQoBY88yy1Yd7PIYFZg0fPeDJQ==
X-Received: by 2002:a05:600c:17c7:b0:426:654e:16d0 with SMTP id 5b1f17b1804b1-4267018b105mr74065465e9.0.1720712452473;
        Thu, 11 Jul 2024 08:40:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:761e:f82:fc9a:623b:3fd1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42662315363sm201463505e9.26.2024.07.11.08.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 08:40:51 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:40:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	ankita@nvidia.com, marcel.apfelbaum@gmail.com, philmd@linaro.org,
	Richard Henderson <richard.henderson@linaro.org>,
	linuxarm@huawei.com, Dave Jiang <dave.jiang@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, eduardo@habkost.net,
	linux-cxl@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
	Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v4 06/13] acpi/pci: Move Generic Initiator object
 handling into acpi/pci.*
Message-ID: <20240711114034-mutt-send-email-mst@kernel.org>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
 <20240702131428.664859-7-Jonathan.Cameron@huawei.com>
 <20240711141240.0ec77fd2@imammedo.users.ipa.redhat.com>
 <20240711163851.00002f93@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240711163851.00002f93@Huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 11, 2024 at 04:38:51PM +0100, Jonathan Cameron wrote:
> 
> > > diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> > > index 20b70dcd81..174b490e5f 100644
> > > --- a/hw/acpi/pci.c
> > > +++ b/hw/acpi/pci.c
> > > @@ -24,8 +24,12 @@
> > >   */
> > >  
> > >  #include "qemu/osdep.h"
> > > +#include "qemu/error-report.h"  
> > 
> > > +#include "qapi/error.h"  
> > is this necessary? 
> > it seems to be compiling just fine without it.
> The error_fatal extern is in there.
> 
> I guess there is a non obvious path via which that's getting included
> anyway. is in there and it's not obvious how it is included I'd rather
> keep it as an explicit include to reduce fragility if the chain of
> includes involved gets changed.
> 

+1

> > 
> > > +#include "hw/boards.h"
> > >  #include "hw/acpi/aml-build.h"
> > >  #include "hw/acpi/pci.h"
> > > +#include "hw/pci/pci_device.h"
> > >  #include "hw/pci/pcie_host.h"
> > >  

