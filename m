Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FF8194C76
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496241; cv=none; b=EA9luNHKMkdMMvpDxA7iiYYk73QFVbF+LhGEyZYM6FbYXvRGAbOURB2esRP4UuCFSJeDZTyYKKA+lpDccuxJETe1D5BBv+e7g/9AmX2ziG8V0m+DtL2htk8BE8Qm+T69HU4Bmp0t59N27+2dapfBUnEIbg/p6Go3ZbA8quW5WZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496241; c=relaxed/simple;
	bh=msqW9PLBfbN4KkbfgPwbUZq7aOzRk06MDyutsd0poP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFqx6h63hxtRGhJFf5Wc6BMEFfsmfT2Xm8GMzp4KmjGHRWO+qAUOhDvaTYvDzpqayIRg9wF4eYAJXOFRds1an5rwpYfQKDIMj2PvdSrMt6ATU2voPlDtXENQ6hBKz9zt2do2rpdg9oqSDdrmdRyWwwGI2S+Jw3J0evkXdYVSIOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9G3CgB6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9G3CgB6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719496238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/K53bCUebQ2JRHKsv54FB0P9fu+ROyN2LvLiXJJfBA=;
	b=C9G3CgB6XuLwRpbiiDxM6I4bi1fZgRyF+UN8a87o/Mshx2uJGXkEUTVTyquvU9fivkRYxz
	HENVPWRkkvRrcc4cc6wapJtjM6nBLAdHPZQJgPAJLJB5vwRQ2T/CxDj0zcHjDg9+WnMbX5
	EZobRztwXVHwZG7ZNzDvfKxJuard8tc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-VyJCZTsRNkiZoVkXt7Mx6g-1; Thu, 27 Jun 2024 09:50:37 -0400
X-MC-Unique: VyJCZTsRNkiZoVkXt7Mx6g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4255e9f5897so10111965e9.0
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 06:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719496236; x=1720101036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/K53bCUebQ2JRHKsv54FB0P9fu+ROyN2LvLiXJJfBA=;
        b=e8VWg4lPtiR6E2KkyR81AUSn8kRjPwlJcE1CAOAZeTqrxtQAxpCTzL5XQpKTTC1JBg
         2A2PoCzUog2yX2ZiW5J6MvPwIjB9Nr1I6P0Nlr4nhT0CQk2u6UeFsgXtKZXcuwY/MBoq
         vjlHvnTYUcneyc8QePXmleVJ2EGu9LOlId9wHIKui6nnZ7bgwkse8pRcpbEd0vRTWUGD
         C2aPGQGJTrZ02N+jVSBvGVG6A0egc3Emc5xXOw5x4WcMe1CvYBa0F1jhPp3cOR7H/eKz
         yeXRq4BgafOFC5/c/NBjCekXb6bVbEM/YnrbGt0ZnyCiaC44t4giL7P3Iceqp4foYPDo
         RlQg==
X-Forwarded-Encrypted: i=1; AJvYcCXH2FubObtE0r4BaEQ4J6GuVKSvOnvp6I4UfvbJWYTSWLPBaiSmI3R9Uja50Y/FXHh413rgGwKhhinWRy2972GGo7piB2pHw+9+
X-Gm-Message-State: AOJu0YzGcbzZYqhfAc8TpqKrjO9dZ9uav04EP3QtKoGBLvhR+I7/wDSz
	cZFWlqDHCrGubUOcY1L4MTFQRSVABgOiiE5BAT94a58v0GxIikd6+Rg5CCuKG+H1P5hO5NJdI06
	TjWxG1uA2vJC9SCSiF/TiZPq49aHQzM/4oKeebnnho3tvFUz5OI9u7QqIzQ==
X-Received: by 2002:a05:600c:470d:b0:422:7eca:db41 with SMTP id 5b1f17b1804b1-4248cc18101mr107719245e9.2.1719496235865;
        Thu, 27 Jun 2024 06:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMcKamJRiI3rpkVJDHck0MM+yXJbTQoD3q0JAT8y7cmLvTvn8ku0c+ocm1SzOuFhCeW7TDWQ==
X-Received: by 2002:a05:600c:470d:b0:422:7eca:db41 with SMTP id 5b1f17b1804b1-4248cc18101mr107719145e9.2.1719496235542;
        Thu, 27 Jun 2024 06:50:35 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c82519b0sm68404015e9.14.2024.06.27.06.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:50:35 -0700 (PDT)
Date: Thu, 27 Jun 2024 15:50:34 +0200
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
Message-ID: <20240627155034.69a8b9e4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240627145155.2c3d3709@imammedo.users.ipa.redhat.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-10-Jonathan.Cameron@huawei.com>
	<20240627145155.2c3d3709@imammedo.users.ipa.redhat.com>
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

On Thu, 27 Jun 2024 14:51:55 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 20 Jun 2024 17:03:17 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > The test to be added exercises many corners of the SRAT and HMAT table  
>                                       ^^^^ did you mean 'corner cases"?
> > generation.

another issue is that this and later patches will conflict with
risc-v acpi tests, that along the way change directory structure
of expected tables.

Perhaps, it's better to rebase this series on top of that. 


> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v3: No change
> > ---
> >  tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
> >  tests/data/acpi/q35/APIC.acpihmat-generic-x | 0
> >  tests/data/acpi/q35/CEDT.acpihmat-generic-x | 0
> >  tests/data/acpi/q35/DSDT.acpihmat-generic-x | 0
> >  tests/data/acpi/q35/HMAT.acpihmat-generic-x | 0
> >  tests/data/acpi/q35/SRAT.acpihmat-generic-x | 0
> >  6 files changed, 5 insertions(+)
> > 
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index dfb8523c8b..a5aa801c99 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1 +1,6 @@
> >  /* List of comma-separated changed AML files to ignore */
> > +"tests/data/acpi/q35/APIC.acpihmat-generic-x",
> > +"tests/data/acpi/q35/CEDT.acpihmat-generic-x",
> > +"tests/data/acpi/q35/DSDT.acpihmat-generic-x",
> > +"tests/data/acpi/q35/HMAT.acpihmat-generic-x",
> > +"tests/data/acpi/q35/SRAT.acpihmat-generic-x",
> > diff --git a/tests/data/acpi/q35/APIC.acpihmat-generic-x b/tests/data/acpi/q35/APIC.acpihmat-generic-x
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/data/acpi/q35/CEDT.acpihmat-generic-x b/tests/data/acpi/q35/CEDT.acpihmat-generic-x
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/data/acpi/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/q35/DSDT.acpihmat-generic-x
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/data/acpi/q35/HMAT.acpihmat-generic-x b/tests/data/acpi/q35/HMAT.acpihmat-generic-x
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/data/acpi/q35/SRAT.acpihmat-generic-x b/tests/data/acpi/q35/SRAT.acpihmat-generic-x
> > new file mode 100644
> > index 0000000000..e69de29bb2  
> 

