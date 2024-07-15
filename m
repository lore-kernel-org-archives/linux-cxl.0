Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8E418EA85
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jul 2024 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053750; cv=none; b=sl/aF/KKKplGfzPkZMqCLXZXJekm8WPKCsRcejdhoyeD4aVsJ2pGhkk+XzZdG8VjvDpbGbacgKwT6BpYm2oBU1d3GrdW8pQx0d/7TMAkEHJ8JhrgxEmjRX35gWuyqID2ESdVsrH8FscNb1U8KhWhmslIEeCW3DA+9FXAMslRCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053750; c=relaxed/simple;
	bh=nmpgmA1jJ0FHGsPw3NoXoFfaKDpgPzQIlQYLIrV6u90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnQugFUwDqGBdzRnvEkZc11X6W685vNiORWdAM80uwlL1NxZ3m1yMfHlm2RcM0eOfFoNcc5IaeHMW4wSMNhlKrI5N5Gj5preOyzV3VcgqEpyVqI98ar5Clrp/cQTzQEINA4aO4072waB9plOzm2X3hm1e1m/fUKqigK8ZWdI/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HjRrXTI4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjRrXTI4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721053747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ws5PhTNz0P/VmMKF7+lfhX1BUlSXeiJ4GRC/jFYnuDo=;
	b=HjRrXTI4biDhQz1Kjd3BdVv05WXzRCRyVvz5nii5b6SAuGhuY/S3A1irfl2uoFQrcKtKow
	7jlmLZq7uqYbUWpOKmy0o2jquQS+aJC3F4eRDYuV8y+3LfKsU4C2bG4WGSN53mux3NBArV
	Vl0OaE4NxKnKZkTLK4vyKPXmXU0MCRw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-KFJ2pQftNpCQyWBUVj4STQ-1; Mon, 15 Jul 2024 10:29:06 -0400
X-MC-Unique: KFJ2pQftNpCQyWBUVj4STQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52e9557e312so3611963e87.0
        for <linux-cxl@vger.kernel.org>; Mon, 15 Jul 2024 07:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053745; x=1721658545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ws5PhTNz0P/VmMKF7+lfhX1BUlSXeiJ4GRC/jFYnuDo=;
        b=ZSGrAG9tnzn/fUjeby8AFpUQ0pSvTTz8w4IM7/EekeqN79Au6EbUvS3a+jda+jolQb
         40yIx5uVUBJ9xyNDS5JudsG2496WP3DkVfEiq5BxW3iwCJ6KDXH6xQtWk3+QeHOVlPpt
         szrkZL93si82smpXD0HyW3WRxjd2kRlt0heMR4WXOIulk3SUev/kEaeiwK86G3OyNzRX
         3nklSrQNs6i9wAxwJ/bC8bLSdYTRwH6OM+3XPwOCPoLI6J6M1TGXonuYEDSLZHX3bZBK
         KmVitTc5xoC4LszzOdI9Of/o+5+tYyybetVzVUDkRa5XD5+J+/lpiWBoVx2HJ5tm9sSg
         D6qw==
X-Forwarded-Encrypted: i=1; AJvYcCX1awrSbqTMELnPCKa66NYTCC7/ZStOMttvVKDBD3Xd+dkTt73unn7B1NLTEcU785yoAKY5NltiCErq2u7zBQSD2dUHvW3RRzlF
X-Gm-Message-State: AOJu0Ywlixkx8LzdVwqDK/j/pBDhj25olXhHjt82g6yRPUrD+GIEM5QD
	FMbnUdBzZIzA1iY2ele+nIXdIc/2liZ/EzlWMcpywsnQkDfVNbZY38tGuuEuWMDO3+pf3FZGSWs
	mo90r6UWifXV8O34jCBxI14Tih5SB3LbNS2kc/V9/5O//pfT1KEyUqnCeGQ==
X-Received: by 2002:a19:7508:0:b0:52e:9e70:d068 with SMTP id 2adb3069b0e04-52eb9991982mr11692859e87.4.1721053745077;
        Mon, 15 Jul 2024 07:29:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS/AvLqLDzlSBdLrXM7r1k4epfASzSntpsp9ap0YGiwKCK/6CpZnxUO86eJKxb6L4kz1F6rg==
X-Received: by 2002:a19:7508:0:b0:52e:9e70:d068 with SMTP id 2adb3069b0e04-52eb9991982mr11692846e87.4.1721053744689;
        Mon, 15 Jul 2024 07:29:04 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5ef44b4sm89667445e9.42.2024.07.15.07.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:29:04 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:29:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Dave
 Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v5 07/13] hw/pci-bridge: Add acpi_uid property to
 TYPE_PXB_BUS
Message-ID: <20240715162903.3573fb47@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240712110837.1439736-8-Jonathan.Cameron@huawei.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
	<20240712110837.1439736-8-Jonathan.Cameron@huawei.com>
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

On Fri, 12 Jul 2024 12:08:11 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Enable ACPI table creation for PCI Expander Bridges to be independent
> of PCI internals.  Note that the UID is currently the PCI bus number.
> This is motivated by the forthcoming ACPI Generic Port SRAT entries
> which can be made completely independent of PCI internals.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> v5: Add missing property description.
> ---
>  hw/pci-bridge/pci_expander_bridge.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 0411ad31ea..b94cb85cfb 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -85,12 +85,25 @@ static uint16_t pxb_bus_numa_node(PCIBus *bus)
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
> +    object_class_property_set_description(class, "acpi_uid",
> +        "ACPI Unique ID used to distinguish this PCI Host Bridge / ACPI00016");
>  }
>  
>  static const TypeInfo pxb_bus_info = {

