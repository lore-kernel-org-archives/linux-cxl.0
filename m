Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0618EA9D
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jul 2024 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053770; cv=none; b=Gz/Et4DDPpjZzojHt5tWrGlW2voBtNoNk4vRPqvNlDpK33lFSEqdVK+0TDQV8aYIw0SNy1/j48jfwuVMuh8OTEdtDIYbWvBBpvkVfbFPFdZBa7Z5z09+BXD1+sDndtVV/V3X68qVbA2GNdrm0/ndhk+ucqiImG0aD3JZBiZkOUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053770; c=relaxed/simple;
	bh=wGr/ulkYwPH7J3xvB1laaftkMEu4MtSs+bHJIZtysSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuHiU37ZA5I3CW18OU4yedDV7uDQv0TEO271Uh9zpsvFGaOO7/SM4xWFAdjb3WkwFng9aBi7GS7trsb37+5SyFyOaxXciVD3cpv1L6lA5MX56fE7ZYEwTOOP53UratUtkIS2vicCAOtTSOr+2CQyU7vgGmIy7bGJ84We4VTApCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHaOwtN0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHaOwtN0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721053767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/6Nn6Qo6sZhY1rmWRCEE3hPzHnZaGhYdt4zkwvkZoE=;
	b=HHaOwtN0/Hsb0FBDr6Uj1dv1zdPatJrc0/LA2RkKxsPm27XV7ynegyx+XmqDMlVszzTNS3
	t6lm0EhMiicRcetSwXXmslPnVVDbzQP1V1jziqpa8/Swceuklus5fffh8QEmzoC6Gpr4OZ
	CZbwiGus9SdXuDplaAUAKMhaALLqpB4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-rRdfTLAcPGio2yAHvldq8A-1; Mon, 15 Jul 2024 10:29:26 -0400
X-MC-Unique: rRdfTLAcPGio2yAHvldq8A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42668796626so31434905e9.0
        for <linux-cxl@vger.kernel.org>; Mon, 15 Jul 2024 07:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053764; x=1721658564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/6Nn6Qo6sZhY1rmWRCEE3hPzHnZaGhYdt4zkwvkZoE=;
        b=Mq0vl2BOY9xlRpMhT3VD/AJZC4PC9lcBgtOZ03TiRTAokfA2Il015yPLgtiy5BNc0a
         r0zsGD/OrJEoufFaHgGg6qI3JfTfI6imGI62nq0Oufg99IiqpG7bLII4s1UVt9RmXc/N
         fLJqtS7K3+TlNkqvWnq0NmSDcJevbhrHsVU+A8e9mdnlq7RAEcTt6Er3soWOu8uuoK/s
         ZOxT5DAG9BfeGxEGeXmLwQwQ9kiQx1WcYP8YBKsUxBPogxuFRTgB2aSVMCw4u1AT20th
         z7S5cttC8C1FhBwoQfMwVcjTT/nRtNVPLTwmT0GGCApgeUvIuB1NaSeifWDVPmExe1PH
         VluA==
X-Forwarded-Encrypted: i=1; AJvYcCVd0EkIuzdVzRdfDpkt2Z3elfhMMJG7oCaySXhwZ3dwBwz2R6fG+XY3yp5UbHxLhlg8vccSNX1Bn0ZXy4SDjadOlOUcMpN5QmyZ
X-Gm-Message-State: AOJu0YzSKblburozdvWn1JJGvButSclOt0IN5hZUFZp8JtdmUvtxuNp+
	lEfOM8dszpIzX0q/1ha5dtH76QpDSTaxBuyWyOWDfqdcQE1rX6KPZuNk+c7xPa3cwdx+cFUox1D
	AxqOtep4oAmGjBo0pfvMlhYkB+UK5xHZq5uLZ+HL5lLSxMQLJstA4eB1Wzg==
X-Received: by 2002:a05:6000:156d:b0:367:f054:7a94 with SMTP id ffacd0b85a97d-367f0547c40mr11627501f8f.5.1721053763965;
        Mon, 15 Jul 2024 07:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvMeozCQs/5GA5cFvsua0ih8QMtCrL44KzSqGiICd7C8KdavHo+nLParr9x4UTUBqLLmixlA==
X-Received: by 2002:a05:6000:156d:b0:367:f054:7a94 with SMTP id ffacd0b85a97d-367f0547c40mr11627470f8f.5.1721053763647;
        Mon, 15 Jul 2024 07:29:23 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafb91csm6643094f8f.74.2024.07.15.07.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:29:23 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:29:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Dave
 Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v5 08/13] hw/i386/acpi: Use TYPE_PXB_BUS property
 acpi_uid for DSDT
Message-ID: <20240715162922.52c190ce@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240712110837.1439736-9-Jonathan.Cameron@huawei.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
	<20240712110837.1439736-9-Jonathan.Cameron@huawei.com>
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

On Fri, 12 Jul 2024 12:08:12 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Rather than relying on PCI internals, use the new acpi_property
> to obtain the ACPI _UID values.  These are still the same
> as the PCI Bus numbers so no functional change.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> v5: Leave the device naming as using bus_num so that we can
>     relax assumption of the UID being only 8 bits (it is but
>     we don't need to assume that)
> ---
>  hw/i386/acpi-build.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index ee92783836..2eaa4c9203 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1550,6 +1550,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          QLIST_FOREACH(bus, &bus->child, sibling) {
>              uint8_t bus_num = pci_bus_num(bus);
>              uint8_t numa_node = pci_bus_numa_node(bus);
> +            uint32_t uid;
>  
>              /* look only for expander root buses */
>              if (!pci_bus_is_root(bus)) {
> @@ -1560,6 +1561,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                  root_bus_limit = bus_num - 1;
>              }
>  
> +            uid = object_property_get_uint(OBJECT(bus), "acpi_uid",
> +                                           &error_fatal);
>              scope = aml_scope("\\_SB");
>  
>              if (pci_bus_is_cxl(bus)) {
> @@ -1567,7 +1570,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>              } else {
>                  dev = aml_device("PC%.02X", bus_num);
>              }
> -            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
>              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
>              if (pci_bus_is_cxl(bus)) {
>                  struct Aml *aml_pkg = aml_package(2);

