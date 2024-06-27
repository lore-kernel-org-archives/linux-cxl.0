Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89D16D328
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492228; cv=none; b=Crwoh+ESaelYp/C42ppZbp5/JWS8t3wu2hbZcFrSEL/C9VLjvdKzFaYAetMOqPuLRkmwFtp09yZ6EasLnTG2+eFdl1vvRubHqeORI7YT8z0sawKCmgnXr6XmsuOrezKGy199LHfr1+sU6pQuD3RmU8QSsO+Md4NMgkJ7OAz14Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492228; c=relaxed/simple;
	bh=h4y4D4deOgjVBK9xc9jB8DZ2x7tOicDbFeP0unEHHBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qP0qZd/g9mu2VMuDj2sJhlPnzusW0xiuxXmSoJhy6LIUOEpae6jmIClFPYiuCI2+JVRQ786qPToLrxB+8POstPbgEqmwlqZWzeMKFWMEn+QrktEN8AnrGeZ1ba4HBizwKtDgD3Eo19lbetiwqSl9VVUq7qtySIg29g+6UWtvoC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XryV1Efj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XryV1Efj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719492225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FE1m8HHupndS8gQfUnBtBTuPulGMiQueYJJuEC1QPYw=;
	b=XryV1EfjXdksw+Z/leUp490O9iuUdAxF5fdO+J228tzdBfm8ELdZVFHEjxOU7a0d9tyfLN
	7M4Wc9E2jbrdbN4ukPDG3/AlhaOZX3XlQyx7jqFnj386IIIOi0570YrW1xWyszQSAAT6d5
	9nqXPlFvoSPpC4ZSJ4tjWHgghVw8jpY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-ll7HwEG9NXCT7DAGn07gpA-1; Thu, 27 Jun 2024 08:43:44 -0400
X-MC-Unique: ll7HwEG9NXCT7DAGn07gpA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3643d0e3831so5227077f8f.0
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 05:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492223; x=1720097023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FE1m8HHupndS8gQfUnBtBTuPulGMiQueYJJuEC1QPYw=;
        b=D1zWRheDMGuN88EmVAkqfyL4nwn2k7nQiIRR5e8FKQERxgjMjhF6rAtW2O2kO59S/m
         cvaYkwnYFYPOzRRAXdy2Gw+hHBeEAg6x0vfz3qfp7wLt6PCGYzB2Yyj+wBud7i5fbscO
         lKy+u1YwKgdWfi3VLBNj+sewA5Ld3JFRSv9L5RObJnojKyK081rD8QWJP6jSSmbanaSt
         49YjaKxzPvCdra8KmMBCAdcYfuuz6XnUOPAp6FiAG3EBNfqnpAocaJsbAO71s5HlrgQJ
         t7R/TaLuCTlIgBkSZDTMa7QwtTyt6x6nVynLNIRt0iezz3rtNJWfyU0KsIwNtbZgjnfd
         jL9w==
X-Forwarded-Encrypted: i=1; AJvYcCWKAzZU50FHQCpYArWs0HewqevUcFSIb6vlw9LoS3Wq/YydLR6H1AHnIg3q5pdOnnMfLZ2iLNddyGDh2Ce68u+B92lC+xPio6Q9
X-Gm-Message-State: AOJu0YxpXTNhPSmNy5lTgNtoB0Id0EWLY2eaoAt8BI8QV7KHt34zuZCk
	/xwnIK885TqBlWPjbZcj91U4t2zMXm7f99c/tUWVjKqsrpVbDvW3tqyeixy2HSBkueEdjSrTq5y
	1Edu+Okga5ELUaCHYGL9NtkAc7Gg5NgGIh9akjL+vKSVQloG/yAVj7n0knQ==
X-Received: by 2002:a05:6000:154d:b0:362:5816:f134 with SMTP id ffacd0b85a97d-366e9463da3mr11749960f8f.13.1719492223627;
        Thu, 27 Jun 2024 05:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdKOz+9xVZtelsna+VHcHlYkK8bCfxlp8Fg130Z/g2ItSS5fpHtYQ9Gb9K+MG53F8fxlA+uw==
X-Received: by 2002:a05:6000:154d:b0:362:5816:f134 with SMTP id ffacd0b85a97d-366e9463da3mr11749944f8f.13.1719492223303;
        Thu, 27 Jun 2024 05:43:43 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674358548csm1757836f8f.64.2024.06.27.05.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 05:43:42 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:43:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 02/11] hw/acpi/GI: Fix trivial parameter alignment
 issue.
Message-ID: <20240627144342.33352809@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240620160324.109058-3-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-3-Jonathan.Cameron@huawei.com>
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

On Thu, 20 Jun 2024 17:03:10 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Before making additional modification, tidy up this misleading indentation.
> 
> Reviewed-by: Ankit Agrawal <ankita@nvidia.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> v3: Unchanged
> ---
>  hw/acpi/acpi_generic_initiator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> index 3d2b567999..4a02c19468 100644
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -133,7 +133,7 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
>  
>      dev_handle.segment = 0;
>      dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
> -                                               pci_dev->devfn);
> +                                   pci_dev->devfn);
>  
>      build_srat_generic_pci_initiator_affinity(table_data,
>                                                gi->node, &dev_handle);

