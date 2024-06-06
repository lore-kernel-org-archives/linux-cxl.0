Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8332BAF1
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682823; cv=none; b=IOFIENpOsvoJDUkVVOLE8MDATvwy6jGveUZvOVXutoycWW9magmQJBkQPVcvoCoyqQxksg1akjcdqyJO9YrsQ2Y9uqn8iIeoETGgUWJ2EEO/3mj99o9QT2MLUCYpqAXYgsbjwI8dS3qh1L7r7HKJpvbFTl3a8IgA1TNkO2bAPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682823; c=relaxed/simple;
	bh=s5sqYy6BZ4oD8gnx4WKBMZSCMRQX++QYIU5sD7d+Rkc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1kDoUl7Oet31dFTT24uq3Qg0xJueIbTJxGZpJX85VviqKi2rXmr0sVEodBHdBQjrH/gjBV/eb0VSZ2QEISGF5QFHlhNNZPdpCWoPOVMBsl0tQLj+DS9fRF7fhrwArshsQpQgyAGZVcYHtDrhCjwnPU2J3MFvHrpqi/Dszmy95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUR6YYRN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUR6YYRN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717682820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBHcCC0aOQEbkk/FxhoIR6lpW/jON2WJxquJeI7WZTo=;
	b=JUR6YYRNolfYR7sW/qwo9qAFOUpmYhUvXVUmU2q4bEvT9If8mZC1cIAXXZj0lIeSTbBtm+
	+oqslPmTV5qXLNWunKStu691P0E4gj0L6I38t19NK9tjkHx1JvwEC0HlEMUtGotlJrx5cN
	vc8k6zdPrxuEPtkWtHj/7I/0gB5mGAA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-uc98RwPxN6ukyOrfKW1fnA-1; Thu, 06 Jun 2024 10:06:58 -0400
X-MC-Unique: uc98RwPxN6ukyOrfKW1fnA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52b890339d9so835885e87.2
        for <linux-cxl@vger.kernel.org>; Thu, 06 Jun 2024 07:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717682816; x=1718287616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBHcCC0aOQEbkk/FxhoIR6lpW/jON2WJxquJeI7WZTo=;
        b=ghGFSbUnGLyEHvuYut/9ceZ+ljlfaKxf2ZYXBRfMpyA9rvBS2x6+6wNPUQewPomIgZ
         nXqFo77FvH2+86Kc3od3mSvZCQvd31vhhRsMUiEkqspZUAzshCSBjFL3avWnXNfiXggN
         y6mxznfgs9EIXQKG7Gx3JGP8/1ijxixgTJzXZXDw+b2RPksAmrxbvnpJ0008VF4b0F+T
         3Dfi58FoD1V4jhfGWVSIA5BYizlg4Rnj3mIwr55dCUMlRVtQ/x6G+4/+1kKfMZt1fl99
         oble46dZp67Rh0Yybl7mJiWhuF6jh3vgVGPSUqVuDKZIDsq2aCes6u3RRIM4liRAnPND
         j6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUDDB2tQvTfW3qL3b8EFJ1Jr8RZSCETw7YsOhFIYUCf4OVTqq4D3DlO6VLpW6Muymz330/vn6MKpl/OO5or43w4cSaqO0HMUlJu
X-Gm-Message-State: AOJu0YzjRIzdN4siVuyXn8HfC19AYIszA+LphVCkeQZnwERMybzVfRN+
	uMPfJdWfDDicjOe4iyIcilunoyrqGUXqMJnApPAPszcn0j0JVPGRCic6wGH9YpCgDreJClKGVlT
	0xXS3O68FswVs5cIb9l68is7gpNmhaZkDMpw/oaLekuXV0gLbY11/h+cTXw==
X-Received: by 2002:ac2:4849:0:b0:521:532d:eb38 with SMTP id 2adb3069b0e04-52bab4f93dcmr3259535e87.63.1717682816686;
        Thu, 06 Jun 2024 07:06:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbJAFLjsdBKlNTdAip+7FwWJOQ+9Yin99Uippg7rK0J/TatnJ8UMFE70w9tAEZ7grWCl+WuA==
X-Received: by 2002:ac2:4849:0:b0:521:532d:eb38 with SMTP id 2adb3069b0e04-52bab4f93dcmr3259520e87.63.1717682816251;
        Thu, 06 Jun 2024 07:06:56 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d66d0esm1647700f8f.51.2024.06.06.07.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:06:55 -0700 (PDT)
Date: Thu, 6 Jun 2024 16:06:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <philmd@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, Dave Jiang
 <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH qemu ] hw/acpi: Fix big endian host creation of Generic
 Port Affinity Structures
Message-ID: <20240606160653.27226def@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
References: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
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

On Wed, 5 Jun 2024 19:04:55 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Treating the HID as an integer caused it to get bit reversed
> on big endian hosts running little endian guests.  Treat it
> as a character array instead.
> 
> Fixes hw/acpi: Generic Port Affinity Structure Support
> Tested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> Richard ran the version posted in the thread on an s390 instance.
> Thanks for the help!
> 
> Difference from version in thread:
> - Instantiate i in the for loop.
> 
> Sending out now so Michael can decide whether to fold this in, or
> drop the GP series for now from his pull request (in which case
> I'll do an updated version with this and Markus' docs feedback
> folded in.)
> 
> ---
>  include/hw/acpi/acpi_generic_initiator.h | 2 +-
>  hw/acpi/acpi_generic_initiator.c         | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
> index 1a899af30f..5baefda33a 100644
> --- a/include/hw/acpi/acpi_generic_initiator.h
> +++ b/include/hw/acpi/acpi_generic_initiator.h
> @@ -61,7 +61,7 @@ typedef struct PCIDeviceHandle {
>              uint16_t bdf;
>          };
>          struct {
> -            uint64_t hid;
> +            char hid[8];
>              uint32_t uid;
>          };
>      };

not sure on top of what this patch applies but I have some generic comments wrt it

why PCIDeviceHandle is in header file? is there plan for it
being used outside of acpi_generic_initiator.c?


> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> index 78b80dcf08..f064753b67 100644
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -151,7 +151,9 @@ build_srat_generic_node_affinity(GArray *table_data, int node,
>          build_append_int_noprefix(table_data, 0, 12);
>      } else {
>          /* Device Handle - ACPI */
> -        build_append_int_noprefix(table_data, handle->hid, 8);
> +        for (int i = 0; i < sizeof(handle->hid); i++) {
> +            build_append_int_noprefix(table_data, handle->hid[i], 1);
> +        }
>          build_append_int_noprefix(table_data, handle->uid, 4);
>          build_append_int_noprefix(table_data, 0, 4);

instead of open codding structure

it might be better to introduce helper in aml_build.c
something like 
  /* proper reference to spec as we do for other ACPI primitives */
  build_append_srat_acpi_device_handle(GArray *table_data, char* hid, unit32_t uid)
      assert(strlen(hid) ...
      for() {
            build_append_byte()
      }          
      ...

the same applies to "Device Handle - PCI" structure

Also get rid of PCI deps in acpi_generic_initiator.c 
move build_all_acpi_generic_initiators/build_srat_generic_pci_initiator into
hw/acpi/pci.c file if it has to access PCI code/structures directly
(which I'm not convinced it should, can we get/expose what it needs as QOM properties?)

btw:
build_all_acpi_generic_initiators() name doesn't match what it's doing.
it composes only one initiator entry.

>      }

