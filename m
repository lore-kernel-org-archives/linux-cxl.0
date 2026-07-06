Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B5B3A9D9B
	for <linux-cxl@vger.kernel.org>; Mon,  6 Jul 2026 04:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783311069; cv=pass; b=CaGywmqGS15SklqOqx8pdmffC629CPkW5A44f78jwumBJ6sz0RYPk6cdZq4d3smuHk4bzmV+kI9l/xNfS7617jf2+THxBTa0l5hJTGrUyCCUdP51ICTlOaY9NvqEPeYnxhE67LPRuu4CGTmQ+MHQi/HBCtJharoORN5yF4eoS4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783311069; c=relaxed/simple;
	bh=CH1qM5/COWWxE8rnytoyXT+I2HCc7dULq+Y7tzs7cS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnfWByj5JOOlOPGISc8LKtDTa2mieTLFC4OiQm7oTxvCnzAtK1CQGQIAa7Op50EkQOwNAeHUda8EnDxXeo9qSc/joqKG745DQJ0dq7rnhJdNh3Kul71g1HZx3gHEGEIyZuVzAV6aWXzLud1ySawq9rFatOTXrMaaxImL1nFVWuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvFleykt; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvFleykt"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-698b6c87884so4423212a12.2
        for <linux-cxl@vger.kernel.org>; Sun, 05 Jul 2026 21:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783311066; cv=none;
        d=google.com; s=arc-20260327;
        b=O4VJdnkJ3srGp/5qZW/4dfPB3nHl1BZLRRU2Qg7yGfey7V4ZVkgFhfu/zsDAOd/sH7
         L353wsA+BMUqduqOKCDXyqyg/3R1QBvjIZL4RlhzZZ7Hxa/3XxbHpUYlT70QrLeO5zp0
         G3BjHEahsXNbM34ey9/dssSkmD/Z7V1VqDyiGMnM0lDexu7FpJrXKbxBFoOd28vkETzo
         3S47h5Nz/Sp4H/Tz+zgQJfB76z7fmkiDjD6uQUYeB1W7IxksRXEKepWJijYRgqVwsXuP
         Db84lQ3BmJzLI/bWoxgG+B0ooRBdwEFZMkOlYBvwgJDKFj4UHG/gYrp5KqXq3Nf09Xl4
         Gx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7HxEleNdpcq/puEELEg1OY61bl0n76N0fS35a2/nEw4=;
        fh=V/fHg6TBydxmrgQc93RtrTioj1+sh3xVDNiKvJo2Ecw=;
        b=gkTNqYn2qDwWOv2zJrT/BsK8CufPLJcP1DyHQZv1Kcz+A6IDfnycmFZJk1klIUT9Ss
         Fv3pnSGsus/bruKcmjvG3L6HXxuo0k/eqkj3hQu3ToHMfD0dqjvZFkvgFyKz0AOklH6i
         3xAlk9KMFdJyKhXvS0IRUCamPg6LRJQWvudInd7DHccs/NeQ0BGxgU9jWor9UXCEtM1l
         qxuPX8/l74r4eyZjsOYVkm5vRSGeK5ZhbqCfTh4AKHwcUQCjVSoLpQJAZeUZVXT5Hx1H
         7OQRnhKcyQ+LzaIrhjEy4Aa4drcgt4LrH2XwKvWqAT5Pj7jMi8h5iDKzKnEToo3gz08l
         kAUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783311066; x=1783915866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7HxEleNdpcq/puEELEg1OY61bl0n76N0fS35a2/nEw4=;
        b=cvFleykt8XD+YO1rUd2Q8l/LgzNpZpwy8Wh0EysZ58zHMDYorwuuFroz9Vv8UwmXU5
         SF60rNjf6nC//cRVrhokzm/KYNMOdUCPYnXQ+GjqEGL3kOTM75WSDGED59KzA/jHN/Y1
         zQ1Tj3Umva+qj8tOtSrShumwo10EMXVOt7wx9GED1CSvfKgLdsJNRII5zZSuoCO4ih87
         uaAp0zJWLBip2LzJbdQrXDDLcbMqQBFeHXB/okdd2EWO2g7awtUNrPDaA2+nPERZBTO6
         4IWbMHN4qPIajR7RxsRICq2HyqiV9uTBq3JMxug+QOtQZ/5aB8rFH47ExaogVaJHP9Q/
         +Oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783311066; x=1783915866;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7HxEleNdpcq/puEELEg1OY61bl0n76N0fS35a2/nEw4=;
        b=Hv58hQ1K3IPgyPdPHpsMx86VZnfJSdDxd8c+cAE0szMFjknrQSuijuarFbFjmetk29
         NqxFQF+A7jrQ2484ifCAH5BaYFHmExC0LWYeg7FjE5MYKBE2LL23QR/U+5VgkaY1cSLw
         nFJrQEYbhWKv2UrF6wUDAER4gNlhcJxphv0aqkA05rJcc7aMiGV+4OkaQaaToCj4A6A9
         4R9D5bw+tHwtCPvmUiegTV5Mfee8PXDRVpU4B4RooJC8Nyhj9TvShgzstrDLDZ69+tZS
         wZyrLCcjVesopYlkPJMBJ8iSDqAljUZyrP4pzwlGrSdf/e5fIU33X1FxiBskxmSYgpfo
         D4MQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjZ/1qAubDybBlN0nfZh2QC0k47WW6IvKjnUiFL/t+lINaYiZpX5nqTf2CKzB+het89Otso1H+5sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZKMaUYw9IKzo1Db+WgsWpq/3zt3wz7vVw9IAhVFcbwhJ+7gn
	7DwsRBdwZ5LnhjTKEqRcsMQ5Uan2i/kahZynt6mGeLq1WYd8lzbDjHMOMk+gxLd9Y+Ukv/227Mf
	vUUxztoITtwVHKp/fpxFaTfULST36EIQ=
X-Gm-Gg: AfdE7ck12TYZJbCalvuLZhQhPfQLQcqpFIzyWiEbnc/+Av9or6PoKJm5KNJxKcr9XR/
	Z4dKC/mDAzXlqz4ii4Pjx3qnwzaJ/CO0dlsmYpL5PeVk0k4R1T/tRerBv6I54BAdVMkWyHJhlg4
	c6zAXY5bky5NMjvjbaDClBCUiofPPIAcq5aw8nrEF3OO4ylvoi1m/+R7b0i1xT90ssjyxSwB8An
	0wbDFTwfBLjnsZ6NDX56C48gydfUS6LCjAE5jc7c+aAjjOqXILLtZG1LUvLhZUfPnM1k8JdR/eC
	lBq4wJownqvN0DlHjS/u55OXqXKS1lKh14bvAg==
X-Received: by 2002:a05:6402:3908:b0:698:3e99:815a with SMTP id
 4fb4d7f45d1cf-69a1a4c094bmr2715772a12.38.1783311065710; Sun, 05 Jul 2026
 21:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618093827.3507-1-cp0613@linux.alibaba.com> <20260618093827.3507-5-cp0613@linux.alibaba.com>
In-Reply-To: <20260618093827.3507-5-cp0613@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 14:10:39 +1000
X-Gm-Features: AVVi8CdAeWtetyAQk_qrrsZ1ircuBVcHeYNWKbPeiByd5CkQfkXfp2U6MM-auzE
Message-ID: <CAKmqyKP1DUuLBxLhsqVXa8Bsk_x_r=rg+-08dOg46fkEO2W0rQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] tests/qtest: Add RISC-V ACPI bios tables test for CXL
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

On Thu, Jun 18, 2026 at 7:39=E2=80=AFPM Chen Pei <cp0613@linux.alibaba.com>=
 wrote:
>
> Add test_acpi_riscv64_virt_tcg_cxl() to verify that enabling CXL on
> the RISC-V virt machine produces correct ACPI tables, including the
> ACPI0017 CXLM device with _DEP in the DSDT and the CEDT table.
>
> The test boots with cxl=3Don, one pxb-cxl bus (bus_nr=3D12), a CXL root
> port, a cxl-type3 persistent memory device, and a fixed memory window,
> mirroring the existing x86 q35 CXL test pattern.
>
> Since pxb-cxl is a root bus, using -cdrom causes QEMU to auto-plug the
> cdrom drive into pxb-cxl, triggering "Only PCI/PCIe bridges can be
> plugged into pxb-cxl".  The ISO is instead attached explicitly via a
> virtio-scsi-pci controller on pcie.0, following the same approach as
> test_acpi_aarch64_virt_tcg_pxb().
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/data/acpi/riscv64/virt/CEDT.cxl | Bin 0 -> 108 bytes
>  tests/data/acpi/riscv64/virt/DSDT.cxl | Bin 0 -> 6212 bytes
>  tests/qtest/bios-tables-test.c        |  54 ++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+)
>  create mode 100644 tests/data/acpi/riscv64/virt/CEDT.cxl
>  create mode 100644 tests/data/acpi/riscv64/virt/DSDT.cxl
>
> diff --git a/tests/data/acpi/riscv64/virt/CEDT.cxl b/tests/data/acpi/risc=
v64/virt/CEDT.cxl
> new file mode 100644
> index 0000000000000000000000000000000000000000..81d746dfb09ccb147e26bb640=
60404ca3191d097
> GIT binary patch
> literal 108
> zc-nJzbqUE~U|?VjaPoKd2v%^42yj*a0!E-1hz+6{7!(+IKx!BefCEf2LP-snumA^?
> O0aMEg#QH!C(hmS*@&^F`
>
> literal 0
> Hc-jL100001
>
> diff --git a/tests/data/acpi/riscv64/virt/DSDT.cxl b/tests/data/acpi/risc=
v64/virt/DSDT.cxl
> new file mode 100644
> index 0000000000000000000000000000000000000000..45999636a05a16f68d1f418a5=
8d9b80a8a62c9bd
> GIT binary patch
> literal 6212
> zc-pO)%WoS+9LHzvjqR-0&f0Mj=3Djrqzae%_tantltHTF7bT*Zm;rVlBV91*2z8`P#y
> z5CtJh4?H3sYJ<3NaYa=3DA0Zs@65?r`dLI_kOZd^FR0U;rUnO)o2Z@QIw$VS?ovFG=3Dl
> z`E1tSkGJfUm&#coLJv!e_M9_bI$yKL<)#TCR9hXbkKfiVG@Mdn`SzS{1Bf-|D&<7c
> zu2p1bO2isxDrLE^7MD^_8HclnHKEG<+ur{2?c=3DlO>{&19`I+h&88jgyoTZ`>k2P$&
> zsL6fZNu`YBJKd_>vg9hoO<6frvD-_iJN8*wneQy&lv5IW3WX`eid$$$?Zqlr7CM!x
> zX2=3D+5)mUo(ene=3DR;m#Usl$~;VB9!Vitjw=3DF55KzlL3Q)a*PnfR`g1KktfjM|#OjOJ
> zR@aYQd};0aD{EI*Z^~(>kIPAm`q_GWx$_J4MLFr@?xY>g_SBa9=3DS{7(fZd3EP=3Dpo~
> zG46{9wIWI?Vj?KQ2nA)pml5`76aq8CK^fD&4Bek`G%!OC%BcA=3Dy8IcFff-#v87sbw
> zh(F_4U`8Y;W5bsb^=3DC{4W<-NBZuv4|t&EC354&}B)D~*8J=3D?iBYO*$I#NF}Zt*g*}
> z<h4ws;nW?i6_pQ&(m3isK-2+_I<2B60;1H#;?Fu5kaaL1s}PhG=3DBz^jS%)}l_QRSD
> z+yCv8Kc*@w<+K?xiw}&L+R5BfX~8hPSxoh%Qcn#U{Tt#n@q+wxl*O8ORa_RU@+dkV
> z!diW)cm8GLRywZ7cXovOw+OGTsq-q*rfM4@b!OU~utF2*gl@`FLU`j^J<S`K^m=3DYx
> zVYeIh^4+l^w{oJ>(|kiiUL|(BVc#rax3bXbX}+OhuQI>e4f|%%h48IF7n*OVF4~ms
> zuAj4uIJ=3D0mi#fZPGeVpZ;*2n7ggK+c870mrb4HmnMw~I?j4@}7IlGCon>f3fvzs{$
> z;xvfUU`~TM<HQ*!&Ny?%nbRarlQ>Q0G?_C&oC)GgFlT}}lf;=3DM&LndtnX`vDdx*1#
> zIeVDXB2J4qE#|bCGew*!;!H7TiaFE7nI_IObEcWImpFTgvzIx0nKMJ28RE<^XNEcZ
> zh_jD4`<SzjIs1vTpE&!Ov!6K!h;x8A2bgn!IkUu>CC)5!W|?!4I0uPykU0mLbBH*H
> zh;xWJhnRDiIERUIm^p`;bA&iYh;xKFN0@VzI7f+dlsQM4bBs90h;xiN$CxumoH^pm
> zF=3DwvL>D{=3DWGoE=3D@UJYj3_cwNScHU~Wt@jclWV%8=3D>?*dr+dF4!H4(Fy>ho^fcH6e=
d
> z%qJU*j;(L53%h(S-&`>7Y+X|By<GjR@K0`J`qOhair=3D01<)Zg${O7+eUH)OS`pt<?
> zhOCo6{kOSp=3D(27?9%J%Y*igHbH&%??O4GW#by<5;rMmCso4t3p+_$~gEVWnTC)Cp1
> zLbbY$71e5%^~X+V$^l2^Q3Xt@x}%CmH6|63N}tr!ZhQS+(wj@IF~7a;sT=3Dms0<nJ<
> zh<&s`?3V@Jt=3DSdd*(&0=3DCxNY=3D`c3D|oD!}EcFv=3Dcz??Bs6Sk;G@f(*vah_NO;Zs5=
Q
> zRS<p^1gRiM1;Hu^RzZ*of>aQ!f?yQ{sUS!N!72z=3DL68c9R1mC!U=3D;+ZAV>wlDhO6V
> zkP3oS5Uhe=3D6$GguNCm+v2v$Lm3W8J+tb$+_1gRiM1;Hu^RzZ*of>aQ!f?yQ{sUS!N
> z!72z=3DL68c9R1mC!U=3D;+ZAV>wlDhO6VkP3oS5Uhe=3D6$GguNCm+v2v$Lm3W8J+tb$+_
> z1gRiM1;Hu^RzZ*of>aQ!f?yQ{sUS!N!72z=3DL68c9R1mC!U=3D;+ZAV>wlDhO6VkP3oS
> z5Uhe=3D6$GguNCm+v2v$Lm3W8J+tb$+_1gRiM1;Hu^RzZ*of>aQ!f?yQ{sUS!N!72z=3D
> zL68c9R1mC!U=3D;+ZAV>wlDhO6VkP3oS5Uhe=3D6$GguNCm+v2v$KkOU7*2rJ~qYt_SZ{
> zJ{L7^wDnJjxGRAqiqldQueI8c?`USY{j6Btg4GsQPmwpD_SLwX?v8M83}Wx=3DQX1x?
> zERtQp9{E^f9D71zbp7z2Nn)2d(kMGsy?MZ!^TE`Qe>jt`SMLn`Ssnb|t~R^3u88ea
> zSo3zvx2t-6#vu)CYjwfEBjoVT&Cba^;Ff4VTa4J}=3Dd1LzOg*bF&(zYUcHvp|Kwmvh
> z%XF)!?qb`BXQtG8%_h9{-v4*)@87?;K7Ienmu7tNqk3n(S~IzIMcYotLRwmvlJY;~
> Cu_#Oc
>
> literal 0
> Hc-jL100001
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index 510751799e..4625b76692 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2194,6 +2194,56 @@ static void test_acpi_riscv64_virt_tcg(void)
>      free_test_data(&data);
>  }
>
> +#ifdef CONFIG_POSIX
> +static void test_acpi_riscv64_virt_tcg_cxl(void)
> +{
> +    gchar *tmp_path =3D g_dir_make_tmp("qemu-test-cxl.XXXXXX", NULL);
> +    gchar *params;
> +
> +    test_data data =3D {
> +        .machine =3D "virt",
> +        .arch =3D "riscv64",
> +        .tcg_only =3D true,
> +        .uefi_fl1 =3D "pc-bios/edk2-riscv-code.fd",
> +        .uefi_fl2 =3D "pc-bios/edk2-riscv-vars.fd",
> +        .ram_start =3D 0x80000000ULL,
> +        .scan_len =3D 128ULL * MiB,
> +        .variant =3D ".cxl",
> +    };
> +
> +    /*
> +     * While using -cdrom, the cdrom would auto-plug into pxb-cxl becaus=
e
> +     * its bus is also a root bus, triggering "Only PCI/PCIe bridges can=
 be
> +     * plugged into pxb-cxl".  Attach the ISO explicitly to a scsi contr=
oller
> +     * on pcie.0 instead, following the same pattern as
> +     * test_acpi_aarch64_virt_tcg_pxb().
> +     */
> +    params =3D g_strdup_printf("-cpu rva22s64"
> +                             " -machine cxl=3Don"
> +                             " -device pcie-root-port,chassis=3D1,id=3Dp=
ci.1,bus=3Dpcie.0"
> +                             " -device virtio-scsi-pci,id=3Dscsi0,bus=3D=
pci.1"
> +                             " -drive file=3Dtests/data/uefi-boot-images=
/"
> +                             "bios-tables-test.riscv64.iso.qcow2,"
> +                             "if=3Dnone,media=3Dcdrom,id=3Ddrive-scsi0-0=
-0-1,readonly=3Don"
> +                             " -device scsi-cd,bus=3Dscsi0.0,scsi-id=3D0=
,"
> +                             "drive=3Ddrive-scsi0-0-0-1,id=3Dscsi0-0-0-1=
,bootindex=3D1"
> +                             " -object memory-backend-file,id=3Dcxl-mem1=
,mem-path=3D%s,size=3D256M"
> +                             " -object memory-backend-file,id=3Dlsa1,mem=
-path=3D%s,size=3D256M"
> +                             " -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,=
id=3Dcxl.1"
> +                             " -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3D=
rp1,chassis=3D0,slot=3D2"
> +                             " -device cxl-type3,bus=3Drp1,persistent-me=
mdev=3Dcxl-mem1,lsa=3Dlsa1"
> +                             " -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.=
size=3D4G,"
> +                             "cxl-fmw.0.interleave-granularity=3D8k",
> +                             tmp_path, tmp_path);
> +    test_acpi_one(params, &data);
> +
> +    g_free(params);
> +    g_assert(g_rmdir(tmp_path) =3D=3D 0);
> +    g_free(tmp_path);
> +    free_test_data(&data);
> +}
> +#endif /* CONFIG_POSIX */
> +
>  static void test_acpi_aarch64_virt_tcg(void)
>  {
>      test_data data =3D {
> @@ -2888,6 +2938,10 @@ int main(int argc, char *argv[])
>                             test_acpi_riscv64_virt_tcg_numamem);
>              qtest_add_func("acpi/virt/acpispcr",
>                             test_acpi_riscv64_virt_tcg_acpi_spcr);
> +#ifdef CONFIG_POSIX
> +            qtest_add_func("acpi/virt/cxl",
> +                           test_acpi_riscv64_virt_tcg_cxl);
> +#endif
>          }
>      } else if (strcmp(arch, "loongarch64") =3D=3D 0) {
>          if (has_tcg && qtest_has_machine("virt")) {
> --
> 2.50.1
>
>
