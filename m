Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7915FD1A
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492266; cv=none; b=pEC+nRTXSWOsMfz+FBEThMl430cFd47gCx0Porz/Uy8WMuGoZLeHjyfZBBhpiYJ1iHzr90QLs8KrAXzu3jo12BHLqM8ZAtWK1TLoysITxx/MNNLNfAuU12gfuckSP3ytdZ+n8b5lRvlqPL7OuQ5OditSsGyWkBJHaq6k8zo3Uak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492266; c=relaxed/simple;
	bh=+gHtLaZICjwljSY+PpZIp+YCgmKv0wuwrggER588Yac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLjQO3LuUGiXQVdAC+a/68HDyPGDSuDtKM289E9BSe7Z5wOjQeTTwwaG+DL0OhcoJSiplpajiwvwU0Tx89jSYPBrXJGaXk0NKr7qrKB7nI17u7mZ3fKCQ1IMlBxQbsO2bUeRJze4nN7umwSAgJEWrzz8QogXVRDsBg7k63iG0RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IAiG5a+B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAiG5a+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719492263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBm7xISxjDwLk3rw9TadeY1LhrJHrMgyAheJsxX0IGE=;
	b=IAiG5a+BX7jXeIpVrIQ0l1Ydq3vt1CdekYdTBspKtrVWItJKQsHgOchaF9MxkKqDEFva6r
	IoVA6X1TrWNJ3aOKFmiYEa17NTXmRI+yGK2JhKmjq6raGYzS1zjymOgpN4UTIwfr7yXK1u
	ZW++Z1gkOMmSvu6jyAN5criWvV3wMiE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-pBToL8XHMDKK3_97xAW5Ig-1; Thu, 27 Jun 2024 08:44:21 -0400
X-MC-Unique: pBToL8XHMDKK3_97xAW5Ig-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42568f0cc18so92665e9.0
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 05:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492260; x=1720097060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBm7xISxjDwLk3rw9TadeY1LhrJHrMgyAheJsxX0IGE=;
        b=K4K2VA+hO0uOrv5V2gLwCseitEckuEAAvzgNXAMMZ6aH9rdSB0NZa2YUGF0oLjPO/7
         OSxV3ovpv8D5cLpRFlOmA73vRoCOrkZWCIsIpThrQmK+o3JHjuBeeZmLuqgdmoRmjB6V
         5Kj5Tfq0ktCbmMTAxsTr7+VacOAYCfNoHcXkodGMz8KGj1yd9ShPiBBA2vmMNNO+i5jj
         Y/lznq9LGTYsl4Om/gqgM+rwesvuJEN/Y+pKPEDG2vNVQnwClnTPXgVKi0lL95E4mAb1
         xWVCFc6OCKhOlSF6GXdLTFC6nddaQz7d2ujUtGiHRD8lWLAvbwPU1QJpBCoF/1/64H7L
         pWyA==
X-Forwarded-Encrypted: i=1; AJvYcCVeN30qs6zXAcBqcXqY5zDvfEXtdqC7iBGq3kXu/2LcbbHlmsbtcXLvKRTEImj1huDivtABItHKz/GG9hyWu6xD6YeNhDKpUKid
X-Gm-Message-State: AOJu0Yz1kGeGY5lhQRMf5372AtBxx60rHuEzriPx6drhLrWIeYbCUWd5
	54lMX+FtRjA+xmms8Lbr4czUlzicUccpq7Z4mlpgS4N5Q/V+x/Ax6aIwMGEECANhgeoD2wwM2+b
	x40eFZXxyWKCPxt02wjGqAFJCkf9VL0lfezgLDKyAAtOwW+9KDakLre3awg==
X-Received: by 2002:a05:600c:4652:b0:424:acf6:6068 with SMTP id 5b1f17b1804b1-424acf6613cmr32899585e9.34.1719492260639;
        Thu, 27 Jun 2024 05:44:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKxt7tLNVMCXKX6PJ7ozexvquYD12f2guCgA7gWtFzSUp8HRAHAaVL5mfcIklI3atYlwAq0w==
X-Received: by 2002:a05:600c:4652:b0:424:acf6:6068 with SMTP id 5b1f17b1804b1-424acf6613cmr32899405e9.34.1719492260153;
        Thu, 27 Jun 2024 05:44:20 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4249b133b44sm65910895e9.0.2024.06.27.05.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 05:44:19 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:44:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 01/11] hw/acpi: Fix ordering of BDF in Generic
 Initiator PCI Device Handle.
Message-ID: <20240627144418.3f9052c2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240620160324.109058-2-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-2-Jonathan.Cameron@huawei.com>
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

On Thu, 20 Jun 2024 17:03:09 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> The ordering in ACPI specification [1] has bus number in the lowest byte.
> As ACPI tables are little endian this is the reverse of the ordering
> used by PCI_BUILD_BDF().  As a minimal fix split the QEMU BDF up
> into bus and devfn and write them as single bytes in the correct
> order.
> 
> [1] ACPI Spec 6.3, Table 5.80
> 
> Fixes: 0a5b5acdf2d8 ("hw/acpi: Implement the SRAT GI affinity structure")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> v3: New patch.  Note this code will go away, so this is intended for
> backporting purposes
> ---
>  hw/acpi/acpi_generic_initiator.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> index 17b9a052f5..3d2b567999 100644
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -92,7 +92,8 @@ build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
>  
>      /* Device Handle - PCI */
>      build_append_int_noprefix(table_data, handle->segment, 2);
> -    build_append_int_noprefix(table_data, handle->bdf, 2);
> +    build_append_int_noprefix(table_data, PCI_BUS_NUM(handle->bdf), 1);
> +    build_append_int_noprefix(table_data, PCI_BDF_TO_DEVFN(handle->bdf), 1);
>      for (index = 0; index < 12; index++) {
>          build_append_int_noprefix(table_data, 0, 1);
>      }

