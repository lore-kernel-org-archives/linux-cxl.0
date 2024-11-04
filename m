Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5CE208A7
	for <linux-cxl@vger.kernel.org>; Mon,  4 Nov 2024 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730736077; cv=none; b=eLDYjrEhd0jEGBcBjq/gLPqIALbeIEFeDFqIOUT7o84DsBSySjXkx0Z1lm3C7V4mGO+Ct2an1eEQ6fjlB/l5UbYypNMF6iSj+OU56gHB4+0jxG9jhfWBSOPqWbuUX1lfEOXkjAhqdjxNN04qMIrZ9vpr8NDafnCCe/Hgu22a9gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730736077; c=relaxed/simple;
	bh=ORj2dlSfniXXpJtxY6G0WatfNKNkL+Bkg7soa1eAeg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QxiiamET90BOC/L/BsFT3IkVl2V8F5zKk3aJ0C6HO78QzgIrrxv43RH8plkAX3s+AnmH4VIAmXThQUajXKgUTesjDLyQ8KmLvghLjV6PJDbpQXFajlVXgTRwuG9fOYm+avsPeKK6sXmMhHsXMSM/IimXQVMLCpImu0Vhd9ZAMhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mu4f6UeB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mu4f6UeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730736074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glyKfzkfyvJXA7/ay+ru80n7y82wopZiq4LC3nJhYrU=;
	b=Mu4f6UeBMJIzhkhRRuKAovb4dHIBPd8d1GInscrq6tWyVgcU1LMKsflkT7RwBGEmGOWeBY
	uKlEmTOnaUy5gAm9hN6aP1Q5DZE45k/Gyrnx2sn6BpdkOSP8WH6Ctxc0R6lTtOqIGMylP9
	pJsoV3baElymUIdKNvvf35JTkvZpBWc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-D5uHhngkNEWJfi7ysy8YtA-1; Mon, 04 Nov 2024 11:01:13 -0500
X-MC-Unique: D5uHhngkNEWJfi7ysy8YtA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315cefda02so32494455e9.0
        for <linux-cxl@vger.kernel.org>; Mon, 04 Nov 2024 08:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730736069; x=1731340869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glyKfzkfyvJXA7/ay+ru80n7y82wopZiq4LC3nJhYrU=;
        b=P84Yer+lN+Y1ywSQ/Niz1OBb7XccGN5E8TVekP323hmc/9ymL6b4QQrBFpe82ZnDUL
         VdiPUeY/Ap+waphZoheWLHdJswE2aOZ6xu9a+eLFLLYBzs9mNhAjJLbeCqs2oLIJFVH7
         Ms4q+4xJI0ojn1yR3bWU2Tgvz4ZAW4zTIkIaUoD3+1CCb8Ho3BbxW9l/mtYBeKJml0Jr
         YVd5FxqP/+yR2z3QEMIYTioAIrTonevDtbJINZu6zTHifyoOVVxzBhtFCcZcvPEi53Z4
         84PQq0B62d5G7l1SSKRdbvN0+NegUqnIbA/hQQbw5Ib8kTekkbFUsYvX3TF8m7ftxao6
         lc4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTd7wJBghGhp7Xz1YMy+zOix+5+ac4NhOO2xpsfahJ/XNuKwsgczyycKHrhrFyJrWw7Pk3/8W4Sng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYFjWQZEHcp7lN6ivgiCLVNYZqjx7yRWFmXiziiuXKKHAG/PMM
	r0vataFmtbNJuFWrEN9vFOGKmz8gHC71nkDcaZ81lxh6paFTpC2ANjx4nLVzaV/KzCdXrhYfh0P
	iNK9LDFbDtAzp7ki1JbcizwBI0nbtunod2Xz0RCbJ57HGl8L2FPJkxesFAg==
X-Received: by 2002:a05:600c:511f:b0:42f:4f6:f8bc with SMTP id 5b1f17b1804b1-4327b6fd459mr145929045e9.9.1730736068633;
        Mon, 04 Nov 2024 08:01:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+FtZnSp9FyS3QfLbt5RRa1dgWpqlgrecSI/3rjVwzRzw61tu/+nDVm82KxzMkMNkxbrb3mQ==
X-Received: by 2002:a05:600c:511f:b0:42f:4f6:f8bc with SMTP id 5b1f17b1804b1-4327b6fd459mr145928485e9.9.1730736068142;
        Mon, 04 Nov 2024 08:01:08 -0800 (PST)
Received: from redhat.com ([2a02:14f:177:aecb:5a54:cf63:d69d:19ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9a9a53sm186721365e9.30.2024.11.04.08.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 08:01:06 -0800 (PST)
Date: Mon, 4 Nov 2024 11:00:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: imammedo@redhat.com, Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org, ankita@nvidia.com, linuxarm@huawei.com,
	linux-cxl@vger.kernel.org, marcel.apfelbaum@gmail.com,
	philmd@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, eduardo@habkost.net,
	Michael Roth <michael.roth@amd.com>,
	Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v6 14/15] bios-tables-test: Add complex SRAT / HMAT test
 for GI GP
Message-ID: <20241104110025-mutt-send-email-mst@kernel.org>
References: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
 <20240916174449.1843258-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240916174449.1843258-1-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2024 at 06:44:49PM +0100, Jonathan Cameron wrote:
> Add a test with 6 nodes to exercise most interesting corner cases of SRAT
> and HMAT generation including the new Generic Initiator and Generic Port
> Affinity structures.  More details of the set up in the following patch
> adding the table data.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


I could not yet figure out why, but it fails on i686 (32 bit):

https://gitlab.com/mstredhat/qemu/-/jobs/8262608614

any idea?

> ---
>  tests/qtest/bios-tables-test.c | 97 ++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 36e5c0adde..f568c4a21c 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1910,6 +1910,101 @@ static void test_acpi_q35_tcg_acpi_hmat_noinitiator(void)
>      free_test_data(&data);
>  }
>  
> +/* Test intended to hit corner cases of SRAT and HMAT */
> +static void test_acpi_q35_tcg_acpi_hmat_generic_x(void)
> +{
> +    test_data data = {};
> +
> +    data.machine = MACHINE_Q35;
> +    data.arch    = "x86";
> +    data.variant = ".acpihmat-generic-x";
> +    test_acpi_one(" -machine hmat=on,cxl=on"
> +                  " -smp 3,sockets=3"
> +                  " -m 128M,maxmem=384M,slots=2"
> +                  " -device pcie-root-port,chassis=1,id=pci.1"
> +                  " -device pci-testdev,bus=pci.1,"
> +                  "multifunction=on,addr=00.0"
> +                  " -device pci-testdev,bus=pci.1,addr=00.1"
> +                  " -device pci-testdev,bus=pci.1,id=gidev,addr=00.2"
> +                  " -device pxb-cxl,bus_nr=64,bus=pcie.0,id=cxl.1"
> +                  " -object memory-backend-ram,size=64M,id=ram0"
> +                  " -object memory-backend-ram,size=64M,id=ram1"
> +                  " -numa node,nodeid=0,cpus=0,memdev=ram0"
> +                  " -numa node,nodeid=1"
> +                  " -object acpi-generic-initiator,id=gi0,pci-dev=gidev,node=1"
> +                  " -numa node,nodeid=2"
> +                  " -object acpi-generic-port,id=gp0,pci-bus=cxl.1,node=2"
> +                  " -numa node,nodeid=3,cpus=1"
> +                  " -numa node,nodeid=4,memdev=ram1"
> +                  " -numa node,nodeid=5,cpus=2"
> +                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
> +                  "data-type=access-latency,latency=10"
> +                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=800M"
> +                  " -numa hmat-lb,initiator=0,target=2,hierarchy=memory,"
> +                  "data-type=access-latency,latency=100"
> +                  " -numa hmat-lb,initiator=0,target=2,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=200M"
> +                  " -numa hmat-lb,initiator=0,target=4,hierarchy=memory,"
> +                  "data-type=access-latency,latency=100"
> +                  " -numa hmat-lb,initiator=0,target=4,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=200M"
> +                  " -numa hmat-lb,initiator=0,target=5,hierarchy=memory,"
> +                  "data-type=access-latency,latency=200"
> +                  " -numa hmat-lb,initiator=0,target=5,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=400M"
> +                  " -numa hmat-lb,initiator=1,target=0,hierarchy=memory,"
> +                  "data-type=access-latency,latency=500"
> +                  " -numa hmat-lb,initiator=1,target=0,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=100M"
> +                  " -numa hmat-lb,initiator=1,target=2,hierarchy=memory,"
> +                  "data-type=access-latency,latency=50"
> +                  " -numa hmat-lb,initiator=1,target=2,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=400M"
> +                  " -numa hmat-lb,initiator=1,target=4,hierarchy=memory,"
> +                  "data-type=access-latency,latency=50"
> +                  " -numa hmat-lb,initiator=1,target=4,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=800M"
> +                  " -numa hmat-lb,initiator=1,target=5,hierarchy=memory,"
> +                  "data-type=access-latency,latency=500"
> +                  " -numa hmat-lb,initiator=1,target=5,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=100M"
> +                  " -numa hmat-lb,initiator=3,target=0,hierarchy=memory,"
> +                  "data-type=access-latency,latency=20"
> +                  " -numa hmat-lb,initiator=3,target=0,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=400M"
> +                  " -numa hmat-lb,initiator=3,target=2,hierarchy=memory,"
> +                  "data-type=access-latency,latency=80"
> +                  " -numa hmat-lb,initiator=3,target=2,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=200M"
> +                  " -numa hmat-lb,initiator=3,target=4,hierarchy=memory,"
> +                  "data-type=access-latency,latency=80"
> +                  " -numa hmat-lb,initiator=3,target=4,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=200M"
> +                  " -numa hmat-lb,initiator=3,target=5,hierarchy=memory,"
> +                  "data-type=access-latency,latency=20"
> +                  " -numa hmat-lb,initiator=3,target=5,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=400M"
> +                  " -numa hmat-lb,initiator=5,target=0,hierarchy=memory,"
> +                  "data-type=access-latency,latency=20"
> +                  " -numa hmat-lb,initiator=5,target=0,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=400M"
> +                  " -numa hmat-lb,initiator=5,target=2,hierarchy=memory,"
> +                  "data-type=access-latency,latency=80"
> +                  " -numa hmat-lb,initiator=5,target=4,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=200M"
> +                  " -numa hmat-lb,initiator=5,target=4,hierarchy=memory,"
> +                  "data-type=access-latency,latency=80"
> +                  " -numa hmat-lb,initiator=5,target=2,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=200M"
> +                  " -numa hmat-lb,initiator=5,target=5,hierarchy=memory,"
> +                  "data-type=access-latency,latency=10"
> +                  " -numa hmat-lb,initiator=5,target=5,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=800M",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
>  #ifdef CONFIG_POSIX
>  static void test_acpi_erst(const char *machine, const char *arch)
>  {
> @@ -2388,6 +2483,8 @@ int main(int argc, char *argv[])
>              qtest_add_func("acpi/q35/nohpet", test_acpi_q35_tcg_nohpet);
>              qtest_add_func("acpi/q35/acpihmat-noinitiator",
>                             test_acpi_q35_tcg_acpi_hmat_noinitiator);
> +            qtest_add_func("acpi/q35/acpihmat-genericx",
> +                           test_acpi_q35_tcg_acpi_hmat_generic_x);
>  
>              /* i386 does not support memory hotplug */
>              if (strcmp(arch, "i386")) {
> -- 
> 2.43.0

