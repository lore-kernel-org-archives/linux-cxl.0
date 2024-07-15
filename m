Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E3190675
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jul 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053788; cv=none; b=cyayfv/Irv2hLoVgVPM7EZmpdISU/4DtXUAzpvTnjgEK7mtsoe4dVx21TwMsFI3vb9WD/Lq6iz8bH0ejo6uRSYij3eSgDdvLhti+KGrzhm/FVH7h/ufGGTf4qOyDRJu4FP3ELaMNjLVdc8vGM29g0Yik67jamBhWuiG5sDKpCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053788; c=relaxed/simple;
	bh=PYmgUuDf46+oU50J2zFJ32lKYbC3ywVDaNJBZfehIR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pP9Dy+hWFaXFt2NykPcVv0XsSzcoD4oE/k+/MkwkNPAadpUgsTsozTTcR6xKtiXj+w0kp2wqz1Y1P4NuK//5gmq5tPYV6Wizld4uo4EJiSV7FyX9/+1ojlhgiPAlZE7J/V/OlW05csBmx1gvp6xJrR8fAiA+Jj53s29avKhZiXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NL/FzBRX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NL/FzBRX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721053785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fMcgl+1UkPeUjDXshVSWNgTJeZuds3OPWpHtLfyyLGs=;
	b=NL/FzBRXKh6t0kyZNA82nGtwikbi3RvlH2v+aeHcMGtHIT5Fwx0ifb6k0SfHAL4BclkCJq
	DppZyDRwSFvN9aIwUF8xjVigIzWhn12+FdKcLR3l2Pdk8pQa7l5vBICQI7vjHCWRiXi056
	2QIaSeiiF+bX/eBQTI/hPCBwuI+2DSc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-5ykUN1gcNE-oIRKMja1_qw-1; Mon, 15 Jul 2024 10:29:44 -0400
X-MC-Unique: 5ykUN1gcNE-oIRKMja1_qw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-427b57e3c6fso3573745e9.1
        for <linux-cxl@vger.kernel.org>; Mon, 15 Jul 2024 07:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053783; x=1721658583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMcgl+1UkPeUjDXshVSWNgTJeZuds3OPWpHtLfyyLGs=;
        b=UOHJ3EG1W2tpwM7BjH1GEG23514vKRLY0kezKtIVEBKkyZ4vrH2xFmw8v9H87/CVEM
         Vg8Zdq79Fg4/xX5YGGr/fJzEVYmtGRF36rJW3PPz9rGrDbbelphYDFZaKxPMZvIs4BZ3
         ivmchcRB0RHNLklPhmj1jyhisY1QK/hpyctWrCd/AE6mUuhAqKZ8TWflUgwxEzi05Wdl
         EkC037IFX6ksQ7mX/s+4Rc9Wd1qBPf7atWfZs4ax1gMcuz+/zclByVywA5D1kL/Jc4la
         g0XBm1SKLU33Ph4iSDUR2FjNtFFZmV4YzMfs+XsfrIZPZMRtLUx3lJaYOdmwWQaSyCap
         BQig==
X-Forwarded-Encrypted: i=1; AJvYcCXNwR290FZoPocUl7HeKb1rBMiCiW5tRd6ZcXrMF3SVrX8qubH5Qdq6JgRX2UToMziyAY7W5QJeJiMP02xw5k+oYbSLDYRwyXlH
X-Gm-Message-State: AOJu0YxhKcLFUcVnm7rgZ6XZoH97dkN4qH4Ju/DKPrs6f0aTyb+DPPs3
	B76dh2dkKw2fHwZXyy8mB7RMyApC9ELs6GPsm4t/mYQtrXEv1KyNJv2PkSSxhsD6uhor0Stcu9N
	7KBcV9LLcRbJ+y3eopOeINJM93F6wZrvD9938Oq7jAVt+s02Z2Aaz1Sr27A==
X-Received: by 2002:adf:fb52:0:b0:367:94a7:12cb with SMTP id ffacd0b85a97d-367ceacaaaamr12775732f8f.43.1721053782869;
        Mon, 15 Jul 2024 07:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmY4ZGp74sKtTX+24Hg7vTd6Jh9kf4WQIur3c2F6swt232bqQLeRb+/7XzA65+QJYhcqFBRw==
X-Received: by 2002:adf:fb52:0:b0:367:94a7:12cb with SMTP id ffacd0b85a97d-367ceacaaaamr12775716f8f.43.1721053782648;
        Mon, 15 Jul 2024 07:29:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccbddsm6530110f8f.64.2024.07.15.07.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:29:42 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:29:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Dave
 Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v5 09/13] hw/pci-host/gpex-acpi: Use acpi_uid property.
Message-ID: <20240715162941.060b64f7@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240712110837.1439736-10-Jonathan.Cameron@huawei.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
	<20240712110837.1439736-10-Jonathan.Cameron@huawei.com>
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

On Fri, 12 Jul 2024 12:08:13 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Reduce the direct use of PCI internals inside ACPI table creation.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> v5: Similar to previous, use bus number, not uid in ACPI device naming so
>     that uid can be 32 bits and we don't need checks to ensure it is only
>     8 bits.  Not change to the actual numbers as the UID == bus_num
> ---
>  hw/pci-host/gpex-acpi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index f69413ea2c..f271817ef5 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -140,6 +140,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>          QLIST_FOREACH(bus, &bus->child, sibling) {
>              uint8_t bus_num = pci_bus_num(bus);
>              uint8_t numa_node = pci_bus_numa_node(bus);
> +            uint32_t uid;
>              bool is_cxl = pci_bus_is_cxl(bus);
>  
>              if (!pci_bus_is_root(bus)) {
> @@ -155,6 +156,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>                  nr_pcie_buses = bus_num;
>              }
>  
> +            uid = object_property_get_uint(OBJECT(bus), "acpi_uid",
> +                                           &error_fatal);
>              dev = aml_device("PC%.02X", bus_num);
>              if (is_cxl) {
>                  struct Aml *pkg = aml_package(2);
> @@ -167,7 +170,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>                  aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
>              }
>              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
> -            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
>              aml_append(dev, aml_name_decl("_STR", aml_unicode("pxb Device")));
>              aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
>              if (numa_node != NUMA_NODE_UNASSIGNED) {

