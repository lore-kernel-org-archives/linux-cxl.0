Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8649917836E
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494889; cv=none; b=Nvn8Lq7mgUtbqxwNQejmhQqxjSzZ11M+5FlRa93f2N9UjhPYKPRWdbbcqN29yXOB5s9Qy1cR/e2RcHOwrQpltO7i0LIGnbuMM9cN7jekCo5GGfFk3Mixccnco5s9xugCwZ6ngnVYoodxkxnVFFsQyrV7rwf6HiTn5J0FX/b0LRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494889; c=relaxed/simple;
	bh=qPfmQz6upuclaj0FW7sLTUNPRfd6sZIhFH8PzRuNihk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyRyrge/avZndoxRI6/2gOCQ0XKc50DoGp0QNBMt0enSOOIoUAW81gtRgulxPyKUtCP5BKHj75Xcy/+G1mM2npSBa6BpfpyHsh3mUDMxSVKj17sIOHS/CMzwP/ZoRRpUweA1+wwYKfBqWyCshjRsyrO/d6uQOq64IPWsmTFOX7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbPCAPT5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbPCAPT5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719494886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYUx4KqikT7Aj5OJG6BCx/5Xs46RwC0eG9WjjQEbO+c=;
	b=ZbPCAPT55PWGj6sVP3zj8vfy7Onon2Is5uEaAvHkFdLnmVWHbM5c1tgHnMahWsRlZPCzIK
	ThVX7n64VdU4RBX4fMfgTBoT799sJ7FwZ3s2bK6LTi52jbZtme9fQxmWTYH6Vbvw4qAjpr
	jjWH016gqyZS5rW1wfBbEL0xnFnKHD4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-q6yDlDp6PQixyLyLb6glJQ-1; Thu, 27 Jun 2024 09:28:04 -0400
X-MC-Unique: q6yDlDp6PQixyLyLb6glJQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-363542774e1so6914720f8f.2
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 06:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719494883; x=1720099683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYUx4KqikT7Aj5OJG6BCx/5Xs46RwC0eG9WjjQEbO+c=;
        b=qPr23PRjewbtppGL+6yrhoAWe4wWjkTiVBIfA5MG2pVdIYCDfG6ej5MivssYDtEFll
         xldQ1LJjzowgdPIAFhucfQMY61BQJm9T1WmJkThDuc0S13881B8s2zebIKQA0epJHlPB
         xgIh+GBNhoBYkL5/hMIMVnNQs4KkzQCOpUtXnJemt0ruWqc8/VPkzTsI15J9goqk/+13
         I2kitvEqUD0jxXhvDZIwI/9hAkOXCu/bJ430mkHZaHLtb4cJOLbU5saxmPEYbBgaeasg
         prglvk3yUfB8tWBUYVAfrqZX5opPxH3fisdUMVq6wOXLH0r3yXRWZIZdtFyteOmpaHRM
         Vr4g==
X-Forwarded-Encrypted: i=1; AJvYcCXZZPwder1pzBa3sqbZDa19rncX9xGGcTPgf+7wPUe7N7Tg+zoHXSl9+qTjtJBXuR2O0pss3VCjJEMLoMqb/Yxz6IjFrDqqEX7Z
X-Gm-Message-State: AOJu0YzWzuW+3OncSZ1gJkvdrQxerq0pi6yVzsNWL1f9ertt66zBOf0R
	z8d0B51mnNSfxeUebR6zDhJCqoE1kutm1WgpROsvKa+jx5/nb1q3dFDXr1BbB8In1y7s2xA8GnV
	8X4W78G5r/SFZgdzB/jrz3k26M6W14GYJPSYPlO3o2W+vupazO7w3rQXyLg==
X-Received: by 2002:adf:a384:0:b0:35f:1eba:cf66 with SMTP id ffacd0b85a97d-366e9656803mr9408266f8f.61.1719494883727;
        Thu, 27 Jun 2024 06:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA0748DfHU6nJAiOFrTFZSa0Sf8UG6c7brVlaiAadLN09St07sfilGx20k3+Kx+JJlWOx8Kg==
X-Received: by 2002:adf:a384:0:b0:35f:1eba:cf66 with SMTP id ffacd0b85a97d-366e9656803mr9408251f8f.61.1719494883357;
        Thu, 27 Jun 2024 06:28:03 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674d992187sm1557396f8f.38.2024.06.27.06.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:28:02 -0700 (PDT)
Date: Thu, 27 Jun 2024 15:27:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 07/11] hw/pci-bridge: Add acpi_uid property to CXL
 PXB
Message-ID: <20240627152758.5eafb402@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240620160324.109058-8-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-8-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
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

On Thu, 20 Jun 2024 17:03:15 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> This allows the ACPI SRAT Generic Port Affinity Structure
> creation to be independent of PCI internals. Note that
> the UID is currently the PCI bus number.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v3: New patch
> ---
>  hw/pci-bridge/pci_expander_bridge.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 0411ad31ea..92d39b917a 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -93,6 +93,21 @@ static void pxb_bus_class_init(ObjectClass *class, void *data)
>      pbc->numa_node = pxb_bus_numa_node;
>  }
>  
> +static void prop_pxb_cxl_uid_get(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    uint32_t uid = pci_bus_num(PCI_BUS(obj));
> +
> +    visit_type_uint32(v, name, &uid, errp);
> +}
> +
> +static void pxb_cxl_bus_class_init(ObjectClass *class, void *data)
> +{
> +    pxb_bus_class_init(class, data);
> +    object_class_property_add(class, "acpi_uid", "uint32",
> +                              prop_pxb_cxl_uid_get, NULL, NULL, NULL);
> +}
> +
>  static const TypeInfo pxb_bus_info = {
>      .name          = TYPE_PXB_BUS,
>      .parent        = TYPE_PCI_BUS,
> @@ -111,7 +126,7 @@ static const TypeInfo pxb_cxl_bus_info = {
>      .name          = TYPE_PXB_CXL_BUS,
>      .parent        = TYPE_CXL_BUS,
>      .instance_size = sizeof(PXBBus),
> -    .class_init    = pxb_bus_class_init,
> +    .class_init    = pxb_cxl_bus_class_init,

why it's CXL only, doesn't the same UID rules apply to other PCI buses?
>  };
>  
>  static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,

