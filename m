Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEE516079A
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492264; cv=none; b=iendu/EoyI6OqWH7RHQMrdVLLZgsRoF7Rf7WBNdYeywNAOfrIfSVXM3cvz/iT/5IOo7O9Ai2KLLXe84FCXhW/ja6HChlepgGkg1tS+/I4aeiZWpKGEN0wh09hv8whz89eJthVg+On+XHwTg83uohW7vQeU+adMhDpWzFOiKJf2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492264; c=relaxed/simple;
	bh=IMowGwhnR3AIIMbTyJwzAOZOC0XfM5Po3H+4sRCdlOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=e+wany0RMCyQwCIEGaMNj2ZWZxMn9/fExSdoA4YaX8MBep7GxQeKYBfVSkKf/oliTE9QTXqUvjailz55ILRflZSyK7gQLxWYGIcaPsFaOEU25xCUZD7BvkU++cZp/N3EE9sgi8DTFE3WZOVOE71C0nK2pvvu/RnLBQ4m3blN6W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W4vEqdZD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4vEqdZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719492261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nw0qhz27VWUrSqZIIfeJN8ARonahQAgkRezb5pMK8yc=;
	b=W4vEqdZD1GLOC5FllqHFO1/8tKx6hHiGzqzlGObV+9FKtjVTUI3YEd12nCZmaTMhq499ix
	azkkuLQ1OIy1T8xSoxKHMx7rGG/9PpL4AaV/osrK28t9rgIqKHuhe+qRvfYMOvmGBlsJfz
	R1OCOqLKkRgBND5s4TwwMHhvCE6LsGs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-2Md2jVFdPbSsiVsSRHcm7A-1; Thu, 27 Jun 2024 08:44:20 -0400
X-MC-Unique: 2Md2jVFdPbSsiVsSRHcm7A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4255f94080bso11653455e9.2
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 05:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492259; x=1720097059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nw0qhz27VWUrSqZIIfeJN8ARonahQAgkRezb5pMK8yc=;
        b=jvb7A+6cduYRFwamG7XYF1hgOu67GARirU4DPypXRZ7GIcGxpFwywnWMl7r9or4aZ1
         Gpcc5Ib6xGYQLjyKcOr1zpem1+REzgghnGOB9kiA7hq7LlPglYQfmpXuFT6hm7DE+ISj
         5TwRcFoVlEfcqfHgMvv8uFpNzmAsTehEYfZ/LJAcJGWWkNYIfM7WWiqP1+5TIwNV0y3s
         +9GunMS2UJJOFQ6qft7h0QP7kwO7f5P8Z47q9Qej4ogUS0PHGAUvMnjHHUK7gXaJMXAG
         zYgvEjyhkZ4nqYFp3GJCsUwP5ZoqStOto6AhH4Kh95BOjwARtuGjQ66wfqnLUdPPZVCq
         6NFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDADzZfUQ1IOvmUJWAjZQP0EgJDGxIb2tbtaoAOLf/cpdIFu8UKvdRF0JcwqobUsdU+uXHO5FMIx/UUjGwJorAgRHJN60LaEtx
X-Gm-Message-State: AOJu0YzLVvLXbdYqAqJdcUtiGIqmLnF8u+eKEbqs6P8DHL9Tx+mGLCmB
	hgw6ZSLmDVsrXcNvoZh5WHX2th8wJL234ssvNNsjTJV2b/ctv72wRNOKBKA5WuDha7sKnpJZD6s
	zEojNp7SbGV2nJyaw4eIeu0o2KSR/TXZMdUeh+LkLZ7YOFqvJYBR4ugFdRg==
X-Received: by 2002:a05:600c:22c1:b0:425:6203:1874 with SMTP id 5b1f17b1804b1-425620320b6mr22619335e9.37.1719492259379;
        Thu, 27 Jun 2024 05:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHohbWV/ivJxiZFVuuYraaTNf2L+sOsL2CZcVEC/0Y9Guk8+Ak4yvsUbjlxA7IMxQDL+AtLrw==
X-Received: by 2002:a05:600c:22c1:b0:425:6203:1874 with SMTP id 5b1f17b1804b1-425620320b6mr22619055e9.37.1719492258521;
        Thu, 27 Jun 2024 05:44:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:177:a007:5be4:b928:19f7:7c2e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564bc7b09sm24203915e9.47.2024.06.27.05.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 05:44:17 -0700 (PDT)
Date: Thu, 27 Jun 2024 08:44:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	ankita@nvidia.com, marcel.apfelbaum@gmail.com, philmd@linaro.org,
	Richard Henderson <richard.henderson@linaro.org>,
	linuxarm@huawei.com, Dave Jiang <dave.jiang@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, eduardo@habkost.net,
	linux-cxl@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
	Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 03/11] hw/acpi: Move AML building code for Generic
 Initiators to aml_build.c
Message-ID: <20240627084356-mutt-send-email-mst@kernel.org>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
 <20240620160324.109058-4-Jonathan.Cameron@huawei.com>
 <20240627144244.27473a32@imammedo.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627144244.27473a32@imammedo.users.ipa.redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 27, 2024 at 02:42:44PM +0200, Igor Mammedov wrote:
> On Thu, 20 Jun 2024 17:03:11 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > Rather than attempting to create a generic function with mess of the two
> > different device handle types, use a PCI handle specific variant.  If the
> > ACPI handle form is needed then that can be introduced alongside this
> > with little duplicated code.
> > 
> > Drop the PCIDeviceHandle in favor of just passing the bus, devfn
> > and segment directly.  devfn kept as a single byte because ARI means
> > that in cases this is just an 8 bit function number.
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Link: https://lore.kernel.org/qemu-devel/20240618142333.102be976@imammedo.users.ipa.redhat.com/
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> with typo fixed

typo being "in cases"?

> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 

