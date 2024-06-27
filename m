Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0023416130C
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492982; cv=none; b=VFhGYbEJdRgbvujtYxq1e3sBT0pniirNQVKrMob3ltcLHNZ5kQ1aIp4sX0Vwo5oC1qvcdydBL40PqfS38Hy8yHIAKeY43gqDq1HwuS1H4Q0TT/KulaGg7I0R7PcbJFeUmYSk57tFq7TIrVsTVeVXscQaoOtAcjG75G5tJo8S8EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492982; c=relaxed/simple;
	bh=7/U6+ur/gJ3wAVZM7ar83k0U8JGj1F6+ObNy9CuI2VM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fleltxKkmuptcVr8hsv8F8F+K4fW/NZLp4nNZFovei6a0+asyUWjDlfU/NiaFbvPtZ7IV05n+Mtbml0vWo80674mtT/4AO30aeqPI8W4R5HBRHsL5659EYSYkDyiai9KUoXKoNAgPPrC8fTwnDYlbDbGNzKGvcPZpXiz9lg75mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iS3gBWGa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iS3gBWGa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719492979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JR5ErMuEbVd1Zz4SFGXEnrGmn4JGl3Pfz9x/6WzCVEw=;
	b=iS3gBWGasD/RjVilFObbwm+PMo9OtLrCQGCLw0FVvYUpY5Wk9C+kbv9Xuc/eABmI58uVi4
	Up/vXRxxh4c6g0Doa56/S9RCDf6u5sPqHzIwhwjOAyMAdmvOByLVke5t48p9I1A3VWpIpo
	kP/qWy3Ozz0kuljgvfyoSxiVK760g48=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-zSKSulXpOJKOoKE42dFtzw-1; Thu, 27 Jun 2024 08:56:18 -0400
X-MC-Unique: zSKSulXpOJKOoKE42dFtzw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4256569a4faso3213885e9.1
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 05:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492977; x=1720097777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JR5ErMuEbVd1Zz4SFGXEnrGmn4JGl3Pfz9x/6WzCVEw=;
        b=i7IspR+VSr+7gw3DtR06NCWvQv+gKEma1bg99RqTe9JbDzfa+DzxKaW6nKgDkDD0dm
         7N3DQlzcTW0laQGarZVg4S7GuAAGimjokGQ6wBPfJ4jV8nEKzn49Py3Vrr5Yv7Oa9jB5
         e9AiPlbve8I4xyg9Udh85qAyHZBqejVNDPdeXDT1MRJ/hr9v4/pH44uIDd/SOuuMOOxh
         Wq6NlLjoj4MprOmJPUxZ4BuOamVMtIMXEt3iHlgg5sx1C+QRr3uDaMvA+cGd4/R8PEBi
         2D0qSVsBKUX6k/N/Nvo55YgQrKTNOTliRA1WhQ6iyglnqPLVvWuaCAoKar5QLCVLnRWO
         WIXA==
X-Forwarded-Encrypted: i=1; AJvYcCV2/+6vSlSiqIs1OEIRNfA7hD1uuvoCFEuHcXnUoVWXKjVZ+gbWb7a1v8+jSZLVMRZd+OxSK1tPumFo2AAaIRhtyaLaxymmgm6v
X-Gm-Message-State: AOJu0YwbfWz2j92T+2TIaLNY4kCS+Go9Y7/XjduQJdCEU3zi5WNZ09Ml
	snUlNIgXPmiMlS7/IHwqej5jzqMScNkXMpebneUZQzzmJhqgDOtM8bTHuxlzERFLjkOSPTTrNfd
	+yHGLlmB2WlwbAPDG7Qzm3tcmp5ShZuMhAb/LD8tTmDJ26YnsL4dlFnJb9w==
X-Received: by 2002:a05:600c:4a06:b0:421:8234:9bb4 with SMTP id 5b1f17b1804b1-42563126c2dmr25773055e9.19.1719492977688;
        Thu, 27 Jun 2024 05:56:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwpnlf/eRAa07oL95W2YCkf8HrDfbnms0npxB8y9IFXrOozdKcDu3WZq/h9GihKU2aoJJGOQ==
X-Received: by 2002:a05:600c:4a06:b0:421:8234:9bb4 with SMTP id 5b1f17b1804b1-42563126c2dmr25772745e9.19.1719492977344;
        Thu, 27 Jun 2024 05:56:17 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c848353dsm65954585e9.48.2024.06.27.05.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 05:56:16 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:56:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 04/11] hw/acpi: Rename
 build_all_acpi_generic_initiators() to build_acpi_generic_initiator()
Message-ID: <20240627145614.6c46c1b4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240620160324.109058-5-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-5-Jonathan.Cameron@huawei.com>
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

On Thu, 20 Jun 2024 17:03:12 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Igor noted that this function only builds one instance, so was rather
> misleadingly named. Fix that.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> v3: New patch
> ---
>  hw/acpi/acpi_generic_initiator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> index 7665b16107..73bafaaaea 100644
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -74,7 +74,7 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
>          acpi_generic_initiator_set_node, NULL, NULL);
>  }
>  
> -static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
> +static int build_acpi_generic_initiator(Object *obj, void *opaque)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
>      AcpiGenericInitiator *gi;
> @@ -111,6 +111,6 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
>  void build_srat_generic_pci_initiator(GArray *table_data)
>  {
>      object_child_foreach_recursive(object_get_root(),
> -                                   build_all_acpi_generic_initiators,
> +                                   build_acpi_generic_initiator,
>                                     table_data);
>  }

