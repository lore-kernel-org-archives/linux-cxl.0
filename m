Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4AA1B7910
	for <linux-cxl@vger.kernel.org>; Mon,  6 Jul 2026 04:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783310955; cv=pass; b=DAHT7oaR4mXgAyNEGtZxZ4j9zJx8ymu4L3JOniTh51PvcAqBSdBnilJckPazG6YE1OJSY8yl0pn+srYfNEZKyuzAg3JAZdnlBBLwc5LFJnTgafIRMjaAQcnGFz8SEi3QIPcuXQq05xGxHNPQVadsZ+D4JKkbeVzipE9jVg8n1pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783310955; c=relaxed/simple;
	bh=Am+JW8qK7UtmTNeVYqoqZ+KXyiIrkxGjVALHKOyR7a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sa6Kz+eOsZ2n/CC1XiPgw/jQjO0zLyaD/z4VjwrwYLLwTxsQJ9R5MVfUTkZrJemfJ1ex3Ddvyu/6xmZHJUHuawn273Tuv0uZUf32NeXs+lNMWr6zNaSGRwr+13CWDDH/L3XAjTriRvwxzDHODjLkuaWMjfDuxgys/Z3FIDQ6ImE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQAny4FU; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQAny4FU"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-697564cb69eso4970377a12.0
        for <linux-cxl@vger.kernel.org>; Sun, 05 Jul 2026 21:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783310952; cv=none;
        d=google.com; s=arc-20260327;
        b=RO2IKGIweLm7Ad8SnIxuzs+z3Q5mRLRsDPsl5XVc8F3uJTavDmnN3gDMj1HYYqWiR0
         BCXBcmg8haobSmxG1GXY80RjSbppbGT+gOSzeAKt0ePvpLVimP7hUY4Rd2QYYQoyFSzW
         pNdJckCS8VHDnOQVqcsteFDZXmPNWUy8bqixthyzOmmepT3k2GNT0fHQ59NZIjfi8IVf
         lHfcsh0uReeZEIdpm9ra/uaqLekyvIddONPJnjwNADeZH17f1+UpkrQlrkGx3Nn1Wlmw
         Zy5gmfT2oTVVTzfemLvqipEmISNz5dopibkncjQStuqf7gb08scrGHgtWpFGQU8czZIi
         sPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MiXEQr4owAYISSihhr8G6Y9h0iA4WKSim5kG94sRBpM=;
        fh=CFlHeAq+WLI7rfCRWnoiQBYUtEAtAxwlhnFf4y/mYLM=;
        b=fi3XMNFrBYJlsIuqBeSQaE1GXFY1gucAfIofMWkcPs2HDSiN3ZeHKTko3NOiV8n9Qi
         dDTtUhpznj16Jd2NgqLZeANY3xNP4fRu2+D4W829KM3g3n4GPGNBw27kJfg9P49o3kdb
         phvRciE5CG0bUEvGrGi2ONYdNZRZZnECXdpjVsQE+9Y+HwqS+cz46cLE1ZtRcb5bhN/u
         BnmVSKOR+4796xwRpp1egXnoWB8x302IP53mxAuDLLzShGtUOn83IJ77CyQTTRrvGUoy
         pacY77ccNUNpBwYnScbUr8ex7OiKqgZcnSl6zZNv/CDzGZmSEUvQKRhzdvcCOzpeJJrC
         70rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783310952; x=1783915752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiXEQr4owAYISSihhr8G6Y9h0iA4WKSim5kG94sRBpM=;
        b=fQAny4FU4FdARQ1vISOZJGuMLEv/n3twLkUJgotLOISLzLDs5kgl1mfa6wjfAovows
         1VElkSCV8sU8fO01nku7piV0S1ZWnFY2hpuJjFESaFOf2JriPheHCz/Ek1pE/NbK48IW
         vVCB/+G84ixqaCSAMqeWxIjob/tOZNIoTJsCSem5+gkpFQHJz8nvlpWo6vD5vlSmN4e6
         y4cT2YN5/Gob5MNNWUi8WsrQufqEYGIq4XLaegUO0oEkERIT8mFUFRWgiuF6OO0y+TUd
         uAXmd1AR1yrlVsJ4YerCh+v4f0nvy3EtoawYhPeNRryCA8AfLco2TxfiJQOIu/kp4uQn
         Yqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783310952; x=1783915752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MiXEQr4owAYISSihhr8G6Y9h0iA4WKSim5kG94sRBpM=;
        b=C7/COa4RUcbYa7sfypvxZtnYn388PsEE2LMRUOmKiSMrozyNwEi7mQrTBFiRp/Uo7Z
         yjuXH7ynA5EcJG2ByUx5jUc73Nx6f7e3Ow84ZfwOS8K8eSif589i9DufVxKP7tLWyjIS
         +TBDNgB6q0h6yrByn1a34QNe44qhwYhRNwHS7vTc6kRbqgVQRjgp8GeEbbmIGosc4frW
         2F9OzZgLL/EOOmdfvaqz7XmDgYcAZQ1FkRyCQr3VhNdSE5WRs6hBJvFYWv208Q1sV4FO
         RNrITg0nQ6vwJkZzZ1l5yTYM9W5KBJ34Zo+9PllPoQ+wi7CZ6RTvwbfjFtMxaa3bKZVB
         qlMQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUF4lvJ5E6hl7Zdxa6t0Tt06Ag7YzWg8SPaoCKD5daM//O9zcPjm/QCBrPf1HNcv/AXbGQInDe6CE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx26W4b7GrY6eQFrCyJtciJmEAaw8Yhne8fwjObacIxu0jqgUfB
	u1glhZDLY/xevbEVJxb05elbSgkK2lOoXZTigxWeef4FwE3nqBEI2wKaRgRuvTtlFHEpmRU8GfQ
	Z45A4aWK9uW3xAiikNztYbFRUHHOix4x4Fhid
X-Gm-Gg: AfdE7ckY/QarTOJR8tkEs3DA76f3MYFiaeHGllYQ5Xc90O+BUqYdRjfquOYHwCwMZ9v
	Q9RoypXfSw+Ytq1hnQaAkvdUI1TWlhPB/+LKSKp7jzrzApFi5C+67JmsRJ85xBnBNRQq+NU3zgQ
	DJYrcxk/0nV8rn+PhFo175nbHU1/a4j+rdDLUuqZTY1iqZmCYQpJpEjT51weG9Mcw5XShEjBeW8
	jnJsTLCpa4Yyn+NacB1a8EfwuWv5n4AM1WEapLyG6JDLCU0ZCMsSpPFFdeZ2KLRSsTpnfMfc+/p
	w4Ol3cim9N/RRF/QytdRDIePvXc=
X-Received: by 2002:a05:6402:e93:b0:698:9e5e:5df8 with SMTP id
 4fb4d7f45d1cf-69a1a259f0dmr2299615a12.7.1783310952145; Sun, 05 Jul 2026
 21:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618093827.3507-1-cp0613@linux.alibaba.com> <20260618093827.3507-3-cp0613@linux.alibaba.com>
In-Reply-To: <20260618093827.3507-3-cp0613@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 14:08:45 +1000
X-Gm-Features: AVVi8CewtI9RIpsTitTFWsRRd_ktSzcX7xuAlCj13Q8fkYKxPVLaaeH4zsp3B6I
Message-ID: <CAKmqyKNmFdJRUegowCGggk+4fOmY7vBxOH+_gnmTSpNhyqWqHg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for
 CXL host bridge dependency
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: jic23@kernel.org, pbonzini@redhat.com, palmer@dabbelt.com, 
	alistair.francis@wdc.com, liwei1518@gmail.com, 
	daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
	chao.liu.zevorn@gmail.com, sunilvl@ventanamicro.com, dave.jiang@intel.com, 
	alison.schofield@intel.com, imammedo@redhat.com, mst@redhat.com, 
	guoren@kernel.org, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 7:40=E2=80=AFPM Chen Pei <cp0613@linux.alibaba.com>=
 wrote:
>
> On RISC-V QEMU virt platform with CXL enabled, the probe ordering
> of acpi_pci_root (ACPI0016) and cxl_acpi (ACPI0017) is not
> guaranteed. If cxl_acpi probes before acpi_pci_root has attached
> the CXL host bridges, the CXL port topology will be incomplete
> because to_cxl_host_bridge() silently skips devices whose PCI root
> is not yet ready.
>
> Add a _DEP object to the ACPI0017 device in the DSDT, declaring
> its dependency on the ACPI0016 CXL host bridge devices. This tells
> the OS to defer ACPI0017 enumeration until all ACPI0016 devices
> have been attached by acpi_pci_root.
>
> This requires a corresponding kernel change to call
> acpi_dev_clear_dependencies() in acpi_pci_root_add().

What happens to kernels that don't have this change?

Alistair

>
> The resulting DSDT fragment (iasl -d output) for a single CXL host
> bridge at bus 0x01 looks like:
>
>   Device (CXLM)
>   {
>       Name (_HID, "ACPI0017")
>       Name (_DEP, Package (0x01)
>       {
>           \_SB.PC01
>       })
>       Method (_STA, 0, NotSerialized)
>       {
>           Return (0x0B)
>       }
>       ...
>   }
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  hw/riscv/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 309d64b322..3598e55243 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -510,6 +510,38 @@ static void build_dsdt(GArray *table_data,
>      if (s->cxl_devices_state.is_enabled) {
>          Aml *cxl_dev =3D aml_device("CXLM");
>          aml_append(cxl_dev, aml_name_decl("_HID", aml_string("ACPI0017")=
));
> +
> +        /*
> +         * Declare a _DEP on every ACPI0016 CXL host bridge so the OS
> +         * defers ACPI0017 enumeration until acpi_pci_root has attached
> +         * the CXL host bridges. Without this, cxl_acpi may probe before
> +         * to_cxl_host_bridge() can resolve the PCI root and the CXL
> +         * port topology comes up empty.
> +         */
> +        if (s->pci_bus) {
> +            PCIBus *bus;
> +            uint32_t num_cxl_hbs =3D 0;
> +
> +            QLIST_FOREACH(bus, &s->pci_bus->child, sibling) {
> +                if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
> +                    num_cxl_hbs++;
> +                }
> +            }
> +
> +            if (num_cxl_hbs > 0) {
> +                Aml *dep_pkg =3D aml_package(num_cxl_hbs);
> +
> +                QLIST_FOREACH(bus, &s->pci_bus->child, sibling) {
> +                    if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
> +                        aml_append(dep_pkg,
> +                                   aml_name("\\_SB.PC%.02X",
> +                                            pci_bus_num(bus)));
> +                    }
> +                }
> +                aml_append(cxl_dev, aml_name_decl("_DEP", dep_pkg));
> +            }
> +        }
> +
>          Aml *method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
>          aml_append(method, aml_return(aml_int(0x0B)));
>          aml_append(cxl_dev, method);
> --
> 2.50.1
>
>
