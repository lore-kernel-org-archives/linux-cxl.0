Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3915D5BB
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720701283; cv=none; b=euzw9H56/tIYqOV2cgikhhUSgW0u2ZBMDuznOjSjl5TWW7ftrurJ7euUQ9hhNeWy0p+hfWuMCVg+LuIE9v3lNJ3dLm/+EkZcS+IBBQFmb7BymO3UH3PMlqq3OEEUsNhWroAiQDVUfZCGWBjyw4rgl2siT/aNa8pDQB7EKvM39SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720701283; c=relaxed/simple;
	bh=LETC9v2SFll+ZF53jPbwsNEiIVzsHX9z22QC6eaSJvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfnKnUNq+JlkjACxFgCqSX/6judFhOy4zSBitpVeYXWG9XFfdGe3wrU6ByYkFZXX0+s13mMUVeNVLpl6TPNEmI1S/WocNK/55v0actpzb32VoWmS6cw7/pf9TCe1OHjwS3Nxf3CWqctQkazBFaWzicw8r6E+rIzQ4ZKzuJ6J8Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G76LY4Ny; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G76LY4Ny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720701281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bxb/8w4DES5aJg9E5ei3A2woovHRbaf3PI/9QzkhEVE=;
	b=G76LY4NyV3CBcZwUgStj/FweLkNRyljI+f7lr2P1swdIya2819N9hW0zlCiTEecLgPf0Lo
	xakCLjx4pDZ+4Dt1I6kOhatwMXVXpMW69qrojxE/QBoNu9Wx0xqam+zsUsqfT04k+EP/pj
	3GOnOlGhSaNbDrSM12qjUW1ibsIMAto=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-83GQNPHGO5u7sN87umACCg-1; Thu, 11 Jul 2024 08:34:39 -0400
X-MC-Unique: 83GQNPHGO5u7sN87umACCg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52ea965188eso1189399e87.1
        for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 05:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720701278; x=1721306078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bxb/8w4DES5aJg9E5ei3A2woovHRbaf3PI/9QzkhEVE=;
        b=QVc9PlP8woaJKb35PMT3s7KSBPDHs/Lc6ixJmMLgSpXobzvUx3bqVXhSfi7537WCdO
         OpNjHrm9mxdKPKKzsS2hV4JIxX7CZ0ebNObqsNXqxZk7Y/sOoeVciN3KQsKkT5UdvPBF
         +1zklI1FgS3lflkYIpsKJOV4loZBfd8Eoth64NUi5d+HFhpr9uoNG/2EZuhdX6a4NUEU
         48GrKmgpSpDlSPYcPD1IRwFPZqA0fsW5AZTuTUeIerV/dFFEx9VGhd/qFA3fIviXYm1/
         FJbc4sn92NYC7qm8dbdTTTt7vpW5ypKLBqIDmllLDLDNgUBkuX69G2tM1qKZWqBgGH6S
         4noQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8zWaR1inyr3M2/YktaHOXQl3yLtRJ2J57POx/sd9d+GWQLWvBYnO/socT0kMUYZWcIkEdUnavavmwpiFS7su0SgNu58cMV6GU
X-Gm-Message-State: AOJu0YzR31teZFg2HRyjla0Voh0JPHytNPZecYX+nKIRWDwk3XZuR2WV
	suo40QWbVOm90kdQZuvdD/WQi6lL0LI8S8rI+yJYaHy2DN7kzkNYJq5s0WC+4GcfZ6q+Ts94aWH
	2twlGp0fJnuVlQEjW425aAnmCdA310N51pBHjlc+EcV7cplcqwT3cDlqPKw==
X-Received: by 2002:a05:6512:3e19:b0:52e:93d1:57a6 with SMTP id 2adb3069b0e04-52eb998e483mr6103949e87.6.1720701278326;
        Thu, 11 Jul 2024 05:34:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt5dnrspIs4beSaN9giDzz5Dhq9xTuLYc24NNSTl+lKF/RRpQXbzbbcNFjHF8swmRuzya+Ww==
X-Received: by 2002:a05:6512:3e19:b0:52e:93d1:57a6 with SMTP id 2adb3069b0e04-52eb998e483mr6103936e87.6.1720701277823;
        Thu, 11 Jul 2024 05:34:37 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741624sm113560185e9.41.2024.07.11.05.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 05:34:37 -0700 (PDT)
Date: Thu, 11 Jul 2024 14:34:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v4 08/13] hw/i386/acpi: Use TYPE_PXB_BUS property
 acpi_uid for DSDT
Message-ID: <20240711143435.1e5f33b0@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240702131428.664859-9-Jonathan.Cameron@huawei.com>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
	<20240702131428.664859-9-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
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

On Tue, 2 Jul 2024 14:14:13 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Rather than relying on PCI internals, use the new acpi_property
> to obtain the ACPI _UID values.  These are still the same
> as the PCI Bus numbers so no functional change.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v4: New patch.
> ---
>  hw/i386/acpi-build.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index ee92783836..cc32f1e6d4 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1550,6 +1550,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          QLIST_FOREACH(bus, &bus->child, sibling) {
>              uint8_t bus_num = pci_bus_num(bus);
>              uint8_t numa_node = pci_bus_numa_node(bus);
> +            uint8_t uid;
>  
>              /* look only for expander root buses */
>              if (!pci_bus_is_root(bus)) {
> @@ -1560,14 +1561,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                  root_bus_limit = bus_num - 1;
>              }
>  
> +            uid = object_property_get_uint(OBJECT(bus), "acpi_uid",
> +                                           &error_fatal);

theoretically acpi_uid is 32bit, so if we are expecting 
only 256 buses here, then having and assert to catch truncation
would be good.
alternatively if this UID can't ever be more than 8bit, I'd use
 visit_type_uint8() in previous patch to make sure too large value
won't be silently ignored.

>              scope = aml_scope("\\_SB");
>  
>              if (pci_bus_is_cxl(bus)) {
> -                dev = aml_device("CL%.02X", bus_num);
> +                dev = aml_device("CL%.02X", uid);
>              } else {
> -                dev = aml_device("PC%.02X", bus_num);
> +                dev = aml_device("PC%.02X", uid);
>              }
> -            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
>              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
>              if (pci_bus_is_cxl(bus)) {
>                  struct Aml *aml_pkg = aml_package(2);

