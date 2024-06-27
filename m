Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351B17BB11
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492722; cv=none; b=IbErED52UYl9UfzAV8QhG5fAinuth6CDn+QyNTCaBW0mahKkOBNd87Es0a5Kw57IQ+6Iunem7I34br2cZwxzc5Lcjea2SMd+F2KsBy+VKyYp4e8lH5BMnXIRVYnXvKUPGv/XioahsA8l7ymVoUAZPOzEH5Wbs/SdUjWQQ2hWI18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492722; c=relaxed/simple;
	bh=8/P3UbgjGhUXLGTy5RsQ120LdSBK6V1Lm0uVyAl7KzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+sB5dQON5niHOo6yoEHiIgqtCYwZKNrLMr88jMShx4uA+dZ9iL7XHUPXCPtEV73l6J7A1bxVvaUKIilMNcBjXSPCgTz2TZuHW4vFH2mH34rPANZouBWH2tNsPoaXJSs/p+wz4NXeJsRVvB0D0VMP3CkYOxphAXf6K6SPI05aDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z2s6iH+e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2s6iH+e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719492719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGvNYGjLjM8OIwTle51VFi9dejDE14SsqCvTH3GKYcM=;
	b=Z2s6iH+eFl8Zna46yCY3d91FO9noxwkn6PIeTbeEatEUJJ1x7KnzLgXPykJ6IudcqYaa0M
	AgS8gA9Wtc6WEALyZfvdXlDgOcjeXlAq6JCRu/PgWCtb3ZE6KbRg5SPL1pyuPJxDYM4pK7
	NiXERATzl/vsjDOhiFR+CpCHSgmeGz8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-kD3WEfcDP9aUUgU86CZ5Hg-1; Thu, 27 Jun 2024 08:51:58 -0400
X-MC-Unique: kD3WEfcDP9aUUgU86CZ5Hg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4248fa5daacso30546595e9.0
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 05:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492717; x=1720097517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGvNYGjLjM8OIwTle51VFi9dejDE14SsqCvTH3GKYcM=;
        b=K7P2SY17dApZFbFdRtWMWh7UZhDX+edakFFcHFjYZYLVjrcaCe0QI7CmVkWrIbbxhJ
         9505R3qHIfFMFgXhJ4dbdpoEl4/4stetVc+jpU9iwK6GdoWj16zTTESU2pVoGIzPF6H5
         CV4gGMo94ltnJiwBCjAC3fK8jwlpzSCymYQ0ssU7ZPog5WQcN4CFSeVab/K2cK2siUx8
         onbULiYrHJmBQOtHfZxMZw94sf0fAJScC670+9jRxToJ7qB1b8dAaoZ49FqrAUQx81JK
         qcV44CETPHHrrjAiQ3enOacMVxAV8bRWr+a5kICC/vrp5fPAGsrldUzs0rDo5IE5rFLo
         UASg==
X-Forwarded-Encrypted: i=1; AJvYcCWkkc0uzTw+pLJmjEKivbs0z+16iYdXaTg7OFQ4BJGd/N1Ji7PEeqIvfAJ2s8/1aA98WNUKX58PfEoQzmVXiRauHcCYrUvgJTUN
X-Gm-Message-State: AOJu0YzYoEjJKqN0ry02AZE+cyO6UJRetN/0ZsN+9G47vdcxV46Qeu15
	QKHCoghYcMuxfulmrdq6b9v+d9/G7keA1LNij8/nAHb3p9Pc/rmtUIUEWya194Ikrn9GkJWbbcx
	WGZOn7ygqVlKim9DlHhrab6eYDUFtxvjY0mJ59jiPM2lY+EfUIuYUAidDQQ==
X-Received: by 2002:a05:600c:4251:b0:424:a655:c8b with SMTP id 5b1f17b1804b1-424a6550d34mr46974575e9.19.1719492717317;
        Thu, 27 Jun 2024 05:51:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3wtb7WPTnXwlztmFUbhY/EtSnUr2q1igQo2dwg2StxvIw1KRqBrc/SahmxFxNVuSK23r/OQ==
X-Received: by 2002:a05:600c:4251:b0:424:a655:c8b with SMTP id 5b1f17b1804b1-424a6550d34mr46974345e9.19.1719492716898;
        Thu, 27 Jun 2024 05:51:56 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c84248afsm63616395e9.31.2024.06.27.05.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 05:51:56 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:51:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 09/11] bios-tables-test: Allow for new
 acpihmat-generic-x test data.
Message-ID: <20240627145155.2c3d3709@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240620160324.109058-10-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-10-Jonathan.Cameron@huawei.com>
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

On Thu, 20 Jun 2024 17:03:17 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> The test to be added exercises many corners of the SRAT and HMAT table
                                      ^^^^ did you mean 'corner cases"?
> generation.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v3: No change
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
>  tests/data/acpi/q35/APIC.acpihmat-generic-x | 0
>  tests/data/acpi/q35/CEDT.acpihmat-generic-x | 0
>  tests/data/acpi/q35/DSDT.acpihmat-generic-x | 0
>  tests/data/acpi/q35/HMAT.acpihmat-generic-x | 0
>  tests/data/acpi/q35/SRAT.acpihmat-generic-x | 0
>  6 files changed, 5 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..a5aa801c99 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,6 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/q35/APIC.acpihmat-generic-x",
> +"tests/data/acpi/q35/CEDT.acpihmat-generic-x",
> +"tests/data/acpi/q35/DSDT.acpihmat-generic-x",
> +"tests/data/acpi/q35/HMAT.acpihmat-generic-x",
> +"tests/data/acpi/q35/SRAT.acpihmat-generic-x",
> diff --git a/tests/data/acpi/q35/APIC.acpihmat-generic-x b/tests/data/acpi/q35/APIC.acpihmat-generic-x
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/q35/CEDT.acpihmat-generic-x b/tests/data/acpi/q35/CEDT.acpihmat-generic-x
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/q35/DSDT.acpihmat-generic-x
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/q35/HMAT.acpihmat-generic-x b/tests/data/acpi/q35/HMAT.acpihmat-generic-x
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/q35/SRAT.acpihmat-generic-x b/tests/data/acpi/q35/SRAT.acpihmat-generic-x
> new file mode 100644
> index 0000000000..e69de29bb2

