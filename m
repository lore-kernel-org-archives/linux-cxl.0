Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7170010E6
	for <linux-cxl@vger.kernel.org>; Sat,  6 Jan 2024 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="joHCU5+c"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28b1095064so8237966b.2
        for <linux-cxl@vger.kernel.org>; Fri, 05 Jan 2024 16:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704501957; x=1705106757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNoN3Ij+Cd17C0GUAoGM7Rr6uhOfADaZ28dH1HWgLyg=;
        b=joHCU5+crq4GmFZnic3+sgVXjBqOoZRz/DiEg/SkIaWyEAuFGT0LwaoO0uFyj6dTFg
         2qohiGGGNB+VMwfSXPaaULtCKHOl+y29RMOe4+NhJISA12BRpgthP17PtdYbAk+M1qK8
         ep8Z3hdtZpuf814FpoGPBfRHvDlonyPJ41GwcP3yWHz2uYAZ1tvymnhkOUc5w19mmDZx
         tsC5g8fA/HvKLUf26CIOznzHayShbe5Fzfd8k3aL5uHbHgfXZENeeAhnTKeVOAOYplHL
         eebyg4uX2AMkDWaolg8wWHP9FCyzd0NN+EeqXF74rSF01pZko8Zm9ISD9zQIDMuYY4xc
         fisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704501957; x=1705106757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNoN3Ij+Cd17C0GUAoGM7Rr6uhOfADaZ28dH1HWgLyg=;
        b=r2XrPSTxaS+m7M81YW2V0SMlyQVpXF2hIfxPubyZiVSYtuY0peELu7ZZHlH3OgTq+c
         GajSgRbuhwuQ69euMCn/N6aOTRMWVdt8ejJL4SGtX6rQ4uQM08EEPRwZOlLZHgDPI77H
         JtJBhgp8qgLl+FR9ilXYGoFTwWJtzZeIv8j0JwhnZ54En4NOEYcb5xOdGXkXIEget8GT
         U/IhlMN0TDxYiobDl4PgNuIy7kGwgy7WbSKmp9gDbP45WYEdYsvfyybsUzRawnzFLOcW
         umeAlmVuoodgj23+Mpqaoy7GH7X1KspV/RbAhaMOj3wDcDXB62G/6S4/cpr2V6SHyfDI
         vsEg==
X-Gm-Message-State: AOJu0YzRq91EOCurZxEtGEhU13RNVPBvwNMSg6i/LSEEUt44HMz4Qcqx
	9aUPQM+0+Kt6L/cnKwNgJfZpn355jFk/S9T7oJy6CfTmdn7pOA==
X-Google-Smtp-Source: AGHT+IEswPo5jFQads7GsL6Js6uz2hURc4eup2AE3Rs5C3QzDVqwMiOyL3m3wGWnnUXkk0GCf/iKzssXBe0dgchMgLE=
X-Received: by 2002:a17:906:245a:b0:a29:513b:dda6 with SMTP id
 a26-20020a170906245a00b00a29513bdda6mr47137ejb.225.1704501957579; Fri, 05 Jan
 2024 16:45:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com> <3ecd3b5a-c4d3-4fd5-b75b-d89b1d4b45e5@redhat.com>
In-Reply-To: <3ecd3b5a-c4d3-4fd5-b75b-d89b1d4b45e5@redhat.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Fri, 5 Jan 2024 16:45:46 -0800
Message-ID: <CAAYibXhjuhi9jupkSWE-9fdC=HaH-R=NXMyAs1tPiqGX6OF9rg@mail.gmail.com>
Subject: Re: [External] Re: [QEMU-devel][RFC PATCH 1/1] backends/hostmem:
 qapi/qom: Add an ObjectOption for memory-backend-* called HostMemType and its
 arg 'cxlram'
To: David Hildenbrand <david@redhat.com>
Cc: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ben Widawsky <ben.widawsky@intel.com>, 
	Gregory Price <gourry.memverge@gmail.com>, Fan Ni <fan.ni@samsung.com>, 
	Ira Weiny <ira.weiny@intel.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, 
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 5:04=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 01.01.24 08:53, Ho-Ren (Jack) Chuang wrote:
> > Introduce a new configuration option 'host-mem-type=3D' in the
> > '-object memory-backend-ram', allowing users to specify
> > from which type of memory to allocate.
> >
> > Users can specify 'cxlram' as an argument, and QEMU will then
> > automatically locate CXL RAM NUMA nodes and use them as the backend mem=
ory.
> > For example:
> >       -object memory-backend-ram,id=3Dvmem0,size=3D19G,host-mem-type=3D=
cxlram \
> >       -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> >       -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,=
slot=3D2 \
> >       -device cxl-type3,bus=3Droot_port13,volatile-memdev=3Dvmem0,id=3D=
cxl-vmem0 \
> >       -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D19G,cxl-fmw.0.int=
erleave-granularity=3D8k \
> >
>
> You can achieve the exact same thing already simply by using memory
> policies and detecting the node(s) before calling QEMU, no?

Yes, I agree this can be done with memory policy and bind to the CXL
memory numa nodes on host.

>
> There has to be a good reason to add such a shortcut into QEMU, and it
> should be spelled out here.

So our end goal here is to enable CXL memory in the guest VM and have
the guest kernel to recognize the CXL memory to the correct memory
tier (slow tier) in the Linux kernel tiered memory system.

Here is what we observed:
* The kernel tiered memory system relies on calculating the memory
attributes (read/write latency, bandwidth from ACPI) for fast vs slow
tier.
* The kernel tiered memory system has two path to recognize a memory
tier 1) in mm subsystem init, memory_tier_init 2) in kmem driver
device probe dev_dax_kmem_probe. Since the ACPI subsystem is
initialized after mm, reading the memory attributes from ACPI can only
be done in 2). CXL memory has to be presented as a devdax device,
which can then be probed by the kmem driver in the guest and
recognized as the slow tier.

We do see that QEMU has this option "-numa hmat-lb" to set the memory
attributes per VM's numa node. The problem is that setting the memory
attributes per numa node means that the numa node is created during
guest kernel initialization. A CXL devdax device can only be created
post kernel initialization and new numa nodes are created for the CXL
devdax devices. The guest kernel is not reading the memory attributes
from "-numa hmat-lb" for the CXL devdax devices.

So we thought if we create an explicit CXL memory backend, and
associate that with the virtual CXL type-3 frontend, we can pass the
CXL memory attributes from the host into the guest VM and avoid using
memory policy and "-numa hmat-lb", thus simplifying the configuration.
We are still figuring out exactly how to pass the memory attributes
from the CXL backend into the VM. There is probably a solution to
"-numa hmat-lb" for the CXL devdax devices as well and we are also
looking into it.

>
> --
> Cheers,
>
> David / dhildenb
>
