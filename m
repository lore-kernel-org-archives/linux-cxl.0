Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A514B950
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569428; cv=pass; b=EpIYFbYQN500Jk/QlSJO7kTjs5uF0xW49wJQ3MyhWrFH3+WbS9R9IRnIhL4QkHpgwed41JNl1K6+4/kDb2+ZOq+mSu5xbjP2JeL7qEETd5XhhvOiYy9ciWRBU7YO7T9j99AzOoIpURgOkGPeVxL6ReEjUAGmMlRG8CvJqSHi/XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569428; c=relaxed/simple;
	bh=HmC4GJVP/MuId7wMS7jQqVGcvD/xN+Q6P4pWhySI3vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZusw2dMd2NCML52FWlK0pKjG0fmYcsdgX3TfBBehE5kvfwuVshO0EcbQ4GKAxcOxcAN8M/8nt/MNcRJRzll1pzVjaXAZNHilhCUHr5QRZyXqEgwrr79ikIE5hAEpqRKP+Nrj8RHlqXqsT3IoFtHxABFPvtxrB9JoXYna9HGJyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md3ilzUt; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md3ilzUt"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba320so1156987a12.1
        for <linux-cxl@vger.kernel.org>; Wed, 08 Jul 2026 20:57:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783569425; cv=none;
        d=google.com; s=arc-20260327;
        b=mdY7b5HcvbauBsl/1j8FtfELr/h4jQIfWUhN8ITMDvSp+T9m6JDnI59Gd6wOr8wA2X
         ZcMZCWHO83qjDH/5do8U1OkRMwyswDSgJMWGK+lDSJPQCUABa5P1cmrnIKVFJcrfq1sl
         mHN7C2zHstD35/J/52bJGTVIyWOcgpYdY/eXDUjEQ1IE+ztuyOUP2tXhxk7e2r8trvLn
         7qLwbGY4w7y+KSXPkclQFMunbubxNKJK8tJrmeYb/AF8OUstd9nVCpuzEfIoQtT2y/dt
         Vh+G10GkAiFShHvlbDMkqRiYX6XA2mjzo6DtSDay7Ca/hk+HvtOyPm4UbhgBcNOZImBa
         7F2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nLplJtHM2neuMqbdGc8BysGwibKRIQ2sUJ9QDSTjj9U=;
        fh=z580cH9v8C5sRvlqQzsJKEH668AJfPM+F7wRVng5lBc=;
        b=FqM/HqLbpelTumvku7AZY/FuRxkHOqWTxFBDAHLKVavFcX1MS7wvXc18WyKBQXaY/4
         2BJu1OcTCgfkNM4ZqBQusqfUl0qTqg+0hSbtMu/HmVaOSRIvD1B6W6SZusv19i2O7t+M
         9RT/B7RuQpDIU2I+ut+tkVxDP1FcnrVL2IjRpiJ1ee4JjdXMUo277rQkW/tkjUyVSU8I
         m7MeSy8zHq3aop6qlM2utP0KdG38IfItZQjjKy00E4Iotwqs7Xfh95h091dcKK3XMhbE
         lr5DzjxKjUM5796UxIE2reThF2vo0wKzez9ntgvZ7hfaTODk5LbEpK50kGXl0R3qPhsc
         zVLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783569425; x=1784174225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nLplJtHM2neuMqbdGc8BysGwibKRIQ2sUJ9QDSTjj9U=;
        b=Md3ilzUt8taueICBYz/kJJLf6o9xdkuYJYArHbjVm7MfYrcS+7Zv53p+4qOHNrlQ1V
         0shqLSoPNJZR55K2uo2d9JdKYHDmRDc6XlhPFHOeW4rZZErXOwtaJZgpSUw4+/kF6YsH
         kQfgHJzTi8ZJyuiv3HC4wssY9MdadrTQQCZ6eRomgC9iJa1GygLQHNM3A1BmfoVHJdhg
         FvoPoeL0Cp+fjz/kGnhGH9JtKjGvk5Z+IVM+d5iww1FSSNqAv81ZSCC4dMb1aBlRwI14
         LJnzHeuCIJ5Og9V8g6s9bvvtVD95dKOBmYJVM+YfxnMF14DRbH+HdOt7pCLh37YNVWZ8
         N/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783569425; x=1784174225;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nLplJtHM2neuMqbdGc8BysGwibKRIQ2sUJ9QDSTjj9U=;
        b=M6dLvx9gsw5v8BUXFMoMB0wDeJZ0oLIrysbKuS1zR4g1fWFJWXmwF7O20gcCUzP8x/
         Kc0+x1VlXf9aqCFOz66I8oKw2U8T2nuTAWlCWKUA8a9asvPSFItip+V3pqtQ9/uSYgzQ
         6JXAHFwQL+5qoSPvZf8ASdp50IpTOynMurly2uQ8vVMAUfBfN4UhzPBF6Rzc73lt8U+x
         bBjoJ9gthxFL0WZjlZw/7w31sQ7uPtYXpSNmZmk613YSXck6S2t/L3TUpUndoXxdT8l6
         /9ytIUoTRAuthKyFhX9XWVEH5WfOxXpAQDXkZKJ/nOJC+hZ8YFGMYdbowIJbNUU6JdRt
         kb3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrYjgrjO399JbXqPyIH/KnEeZfec7BwugF/bVydWU+N8NJiMaUH+bil7GlfLPsNmoC+3rUIhzPemGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytQSdR1PXdHy9f1V4aCieXllgvt1TVAtfe+LmwpRd6De4YZe2V
	/kLObdcj3oC+Uk977wlUPT8WDEztJTOaFxxavC0d+jz2ofsN6N26G2ZBdH0w4su3m2y2J/6DXJr
	N5NqlCVpaP+X5JhBFcV2UBp5JSg2o5U4=
X-Gm-Gg: AfdE7ck5XwnzkO5p23mOXNllaxTp5rgT+BmDztqGTn3loGZ67DrQ3Yf6FkXQNoQjEnW
	SoGLzgoMdtBpFJthqnSAQ71lnPXyILYAoq05Iu9XlNQaKSHIvVCnghLLH751/C5hhrMiEIyRV7Y
	PbiRMx+ILb2ccGcVIZGiN0QhXT+ANjpCzN0XqI9LVqEHq6ciUxlC7OHfB/ZWGy1eMmVBCfPo7iO
	Uy4S68LY+u+wI5ldE0hl79Yz5uCCOj0cry3AbgjPdoerTARIsQJ5gLSthBad+eGhIZHcUk8O8hD
	xNd37R937uLWtTPuGChCfZk3+io=
X-Received: by 2002:a05:6402:3814:b0:698:7418:57a9 with SMTP id
 4fb4d7f45d1cf-69c032a82a1mr376176a12.17.1783569425398; Wed, 08 Jul 2026
 20:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618093827.3507-1-cp0613@linux.alibaba.com>
 <20260618093827.3507-3-cp0613@linux.alibaba.com> <CAKmqyKNmFdJRUegowCGggk+4fOmY7vBxOH+_gnmTSpNhyqWqHg@mail.gmail.com>
 <20260707115030.5161-1-cp0613@linux.alibaba.com>
In-Reply-To: <20260707115030.5161-1-cp0613@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Jul 2026 13:56:36 +1000
X-Gm-Features: AUfX_mzGPIZl7w4I_sfMBRvqxgaPOqutCMZGwIBH_MVFtTqZr67SNShdej1XIes
Message-ID: <CAKmqyKPskHLaQMs1SCNjNRzhZjX-E=4KO4x_KS8kAc+LvSh3qQ@mail.gmail.com>
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

On Tue, Jul 7, 2026 at 9:51=E2=80=AFPM Chen Pei <cp0613@linux.alibaba.com> =
wrote:
>
> Hi Alistair,
>
> On Mon, 6 Jul 2026 14:08:45 +1000, Alistair Francis wrote:
> > What happens to kernels that don't have this change?
>
> Good question. The behavior depends on how old the kernel is:
>
> - Kernels that support _DEP processing but lack the
>   acpi_dev_clear_dependencies() call in acpi_pci_root_add(): the
>   ACPI0017 (CXLM) device will remain deferred indefinitely because
>   its declared dependency on ACPI0016 is never cleared. CXL memory
>   would be unusable on such kernels with this QEMU.
>
> - Very old kernels that ignore _DEP entirely: the behavior is the
>   same as v1 =E2=80=94 the probe-ordering race between acpi_pci_root and
>   cxl_acpi remains, but nothing is worse than before.
>
> The kernel-side fix has already merged:
>   https://lore.kernel.org/linux-pci/20260526025118.38935-1-cp0613@linux.a=
libaba.com/
>
> So this is effectively a "new QEMU requires a sufficiently new kernel
> for CXL to work" situation, similar to other QEMU features that depend
> on kernel support.

That's fine, we can say you need a new kernel for this new feature to
work, as long as it doesn't break existing PCIe for old kernels

Alistair

>
> Thanks,
> Pei
