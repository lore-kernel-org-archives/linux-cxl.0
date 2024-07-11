Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3B4156F3C
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720700873; cv=none; b=BRi1UXAGdS5w0Mn7ijonB7613g4N1CfWzVC61I5I4Qe1P53oCb/9hkWL59HJjGBqT8GdwKiR0oVgjwiQ/IkzxCK/Cldiunv9HDNyz9idv1cIcZIM5CghHRA+fCcU/LjmD3EqrVFbH1DeqxOe5wcXDkSOkrzAQLybToudaaPert8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720700873; c=relaxed/simple;
	bh=Bc0MPURvONZnAkScf+YcSuwASHtTIysB6qwffHXTgrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHwxCSd7o1pXbhBB4TfjDdaMD2g8ZoVe0usF1kdrLWJPLn75SjhGhgcHe6HeEi4YCl1loUdTFbBfQ9neLFXyRp1lyZtkyWAXh9fHI5Oxzf7UzBA2Mrjy3VfQb6wOw2GWncBH+RI/gyYWOE0gacinxVECwJICJG4MjwyFiLIhYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMRbc6z/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMRbc6z/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720700870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHI/4wPP8R2+ilKy81OFpjP4p8f9UonN9Xj6JbRjkNk=;
	b=HMRbc6z/P9Rtdx4a1htTg5Sapz3eqSDWYc19VENaZ/uAC7Ac/rQzBe7sm4qx8+xJvxwhDI
	1Sq39he5awmIRLqY8Y3ddU8VDcATdl36Trvk+GhNyeOxCfWFvGsvD0nYdMrxTKyX10rml+
	DVqnyNbXLahmGl1bZlwTdfDXu7gT5Y4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-gOWuyp7mNRixXc23CyL2MA-1; Thu, 11 Jul 2024 08:27:47 -0400
X-MC-Unique: gOWuyp7mNRixXc23CyL2MA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4265b751469so9785125e9.1
        for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 05:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720700866; x=1721305666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHI/4wPP8R2+ilKy81OFpjP4p8f9UonN9Xj6JbRjkNk=;
        b=cn71UeDsBJ5Vo/PZNJicVhVACb8fzZJ306USN8xkRPFMjGgBJ0IvnPnxCRGfjrLaAO
         axESQsQJgpic2MH1krMelXV6nlywhI0GwoUlT8pEj5//3861Or/JoV72Viz0Tq401vEL
         lQx2Tn41K6Wz5TaU/joYdXOKgcXOtnHOmbxG3hvl6gBSTDmWM3OBlotJyoTV0kmHjQI7
         n6Vb8KLDOMMyWwyxgISXVS1iQjzo4gutquhKli3f9prZcoO6Sy87BZe9HVBP09AEZT8m
         pn1ji1OtiBf/Avre2LKwf32rUUbvWQU7w5wkbheDUzfihJmXMhlsfxSEC1txi4m1ObiS
         fKlw==
X-Forwarded-Encrypted: i=1; AJvYcCUsmO/NcboGd8Tup4QNT1qUdYnmOGdEJxL4D13dSmFRzDtxlbT0WgH7PEn+wnA8t0HHCp8NOpwGt2IYkAuOGfohCCcvEk7RGBNd
X-Gm-Message-State: AOJu0Yz5sg5/nU4KyeD3NWOceA2n5rB3BTvntjx9pKjKYL4u/PuSAo1y
	lNw/F4EioLuW3XLWDKqal0exaAqKe9FCGI9xHFEFViGaTax5wPqFJhvvIMh5tEfLF3m9YE24FSU
	PznpEMoGhDq44j7qI5PJnahm/6s978B+LBldlYnHYJq8WMibwsfqvMDonlQ==
X-Received: by 2002:a05:600c:181c:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-427981f2dd6mr21542305e9.17.1720700866561;
        Thu, 11 Jul 2024 05:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYXeTwwrqg0QrhxkyzXKVN89bw3IsN5quyO9A3wdmCPi1B8HD3wtsQt5kI60Q2uvLyiovT2Q==
X-Received: by 2002:a05:600c:181c:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-427981f2dd6mr21542185e9.17.1720700866187;
        Thu, 11 Jul 2024 05:27:46 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42793dc2bcesm66002165e9.29.2024.07.11.05.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 05:27:45 -0700 (PDT)
Date: Thu, 11 Jul 2024 14:27:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v4 07/13] hw/pci-bridge: Add acpi_uid property to
 TYPE_PXB_BUS
Message-ID: <20240711142744.1178daec@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240702131428.664859-8-Jonathan.Cameron@huawei.com>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
	<20240702131428.664859-8-Jonathan.Cameron@huawei.com>
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

On Tue, 2 Jul 2024 14:14:12 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Enable ACPI table creation for PCI Expander Bridges to be independent
> of PCI internals.  Note that the UID is currently the PCI bus number.
> This is motivated by the forthcoming ACPI Generic Port SRAT entries
> which can be made completely independent of PCI internals.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v4: Generalize to all TYPE_PXB_BUS.  The handling for primary root
>     bridges is separate and doesn't overlap with this change.
> ---
>  hw/pci-bridge/pci_expander_bridge.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 0411ad31ea..d71eb4b175 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -85,12 +85,23 @@ static uint16_t pxb_bus_numa_node(PCIBus *bus)
>      return pxb->numa_node;
>  }
>  
> +static void prop_pxb_uid_get(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    uint32_t uid = pci_bus_num(PCI_BUS(obj));
> +
> +    visit_type_uint32(v, name, &uid, errp);
> +}
> +
>  static void pxb_bus_class_init(ObjectClass *class, void *data)
>  {
>      PCIBusClass *pbc = PCI_BUS_CLASS(class);
>  
>      pbc->bus_num = pxb_bus_num;
>      pbc->numa_node = pxb_bus_numa_node;
> +
> +    object_class_property_add(class, "acpi_uid", "uint32",
> +                              prop_pxb_uid_get, NULL, NULL, NULL);

missing related object_class_property_set_description()

>  }
>  
>  static const TypeInfo pxb_bus_info = {

