Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD158108
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602834; cv=none; b=ag+fpU/Dxne+mqaWP2zy1DKeSqvokpXKymJKR4EZ7cMdouGWx3FRuPiqwpAuQVyu3qLCxJNYeckIBurhiLpT/6lXzcjxOe8H0JNY29qloK6PzVYYLkrtYffoMOndaE05x5nGWthsDEdivdx7BaLxpRSH/UeG3oN+0Kqfa0hmnHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602834; c=relaxed/simple;
	bh=zAipQG7a+yGLxE3ec8lF2yuLBtHtSr4K3ieOy+RHy6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZ8PIe2O/Bbo40NJ80SmXGK3ETLaNH516djGAHDQTtq888JR/gtHBMVwZTpzyYW6pdwarlaoWJg+l1UGDlOwP/eyon3xlMmlth1NSp7msiuGwMq5pAY92B4CMAIWrxNZ6huMnHVFCVklHFc6DCASl6ppBvNCOEhFUZ0VoJILCwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlSWsA/c; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlSWsA/c"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55f0367b15fso2286107a12.0
        for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 00:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706602831; x=1707207631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVFn1X9E9eKy53g6Q742Sw5d2hRopQjyTEmeVWHEE+Q=;
        b=RlSWsA/cAu9UdOunym0Hc3FZHzIGXwORo6IodWdsOKS3YpSnkPf003rJZbpC20SUle
         13MtyH0+36Fn/rZnSTxmAkvaQJ5BYlILzk571knJt4pXpRXrMH8WgHYED8Oo1qfsJAU9
         2f9tyBTpZ6ga5d0KNpdurD8ZbYcsTtF6I/IODXgTBr0H33FdhZdHQAUytkMtLSyzwzKs
         hyNNkzTyNSP0PWfgKZEJ3Cchh+R7vwgu9FXAv2pxxEoSg9iCR/BBPPZnSE2z3NmhPwUI
         a3jfF+xKqdiI/lSNKnke7PnPwiHF7Uc4sysTI74d05qy+lYRfQcHS985L8hduw2YR9sK
         VK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706602831; x=1707207631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVFn1X9E9eKy53g6Q742Sw5d2hRopQjyTEmeVWHEE+Q=;
        b=ARExF1r4YSUfx2pyjj9AWrBzZU1YWIl6ebrHaU8rh598PRknYRjCL+flrFLZP/cxIn
         FC9KaHXG/34Slt+evhc08CwuihMH7QgUyq83km9mbFIKchFQ/VSYSkZXSD1RXjKS5DUP
         BQN7MUio2OUwcWTLAbil9nGf70u+SdO65VMoaOBVNl0DTFGH6V17o2iPW10CkffB97uY
         3O7L878Dpu1qg+Ru009Fs4lUot7M7DWD5v/bfytdlklU+YhVm7meU8+4RkqTUL8VJiEw
         XS/0qXhOCA9JQ8lIIpnGFj+nrBSLBYlcdgAx3q0k/nzh2m2MAxToIsJreXmxLnv+sd0/
         PoMA==
X-Gm-Message-State: AOJu0Yw79aTWKl9FTvaoXl/wjN5x45NSmdxqSUZLY1DBU+bUXdtxObQs
	Ir8m250If0t8RZ5MYdkdzpIv+LUzF5pa0U3wEJBh7ZZy9SBoutk+6pMUGn/oiZIe1MFX0714JIB
	Jl3DGtrVLr96ME9MDqSm7YTJ2SWg8eDVw6WdFEA==
X-Google-Smtp-Source: AGHT+IH3xSbO0whlApATC4e7Ju5ITVNAH1QlAJWDln453AGSObX8xKMcBfIlylKIH2NZoL8rOg07lxPGLKXme2qFerU=
X-Received: by 2002:a05:6402:3492:b0:55f:4602:bf79 with SMTP id
 v18-20020a056402349200b0055f4602bf79mr438320edc.27.1706602830515; Tue, 30 Jan
 2024 00:20:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
 <CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
 <CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
 <CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
 <CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
 <20230823175056.00001a84@Huawei.com> <CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
 <CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
 <20240126123926.000051bd@Huawei.com> <ZbPTL00WOo7UC0e6@memverge.com> <20240126171233.00002a2e@Huawei.com>
In-Reply-To: <20240126171233.00002a2e@Huawei.com>
From: Sajjan Rao <sajjanr@gmail.com>
Date: Tue, 30 Jan 2024 13:50:18 +0530
Message-ID: <CAAg4ParQKj9FUe0DRX0Wmk1KT0bnxx2F7W=ic38781j7eVz+OQ@mail.gmail.com>
Subject: Re: qemu cxl memory expander shows numa_node -1
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gregory Price <gregory.price@memverge.com>, 
	Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

The QEMU command line in the original email has been corrected back in
August 2023 based on the subsequent responses.

My current QEMU command line reads like below. As you can see I am not
assigning numa to the CXL memory object.

qemu-system-x86_64 \
 -hda /var/lib/libvirt/images/CXL-Test_1.qcow2 \
 -machine type=3Dq35,nvdimm=3Don,cxl=3Don \
 -accel tcg,thread=3Dsingle \
 -m 4G \
 -smp cpus=3D4 \
 -object memory-backend-ram,size=3D4G,id=3Dm0 \
 -object memory-backend-ram,size=3D256M,id=3Dcxl-mem1 \
 -object memory-backend-ram,size=3D256M,id=3Dcxl-mem2 \
 -numa node,memdev=3Dm0,cpus=3D0-3,nodeid=3D0 \
 -netdev user,id=3Dnet0,net=3D192.168.0.0/24,dhcpstart=3D192.168.0.9,hostfw=
d=3Dtcp::2222-:22
\
 -device virtio-net-pci,netdev=3Dnet0 \
 -device pxb-cxl,bus_nr=3D2,bus=3Dpcie.0,id=3Dcxl.1,hdm_for_passthrough=3Dt=
rue \
 -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Dcxl_rp_port0,chassis=3D0,slot=3D2=
 \
 -device cxl-upstream,bus=3Dcxl_rp_port0,id=3Dus0,addr=3D0.0,multifunction=
=3Don, \
 -device cxl-switch-mailbox-cci,bus=3Dcxl_rp_port0,addr=3D0.2,target=3Dus0 =
\
 -device cxl-downstream,port=3D0,bus=3Dus0,id=3Dswport0,chassis=3D0,slot=3D=
4 \
 -device cxl-downstream,port=3D1,bus=3Dus0,id=3Dswport1,chassis=3D0,slot=3D=
8 \
 -device cxl-type3,bus=3Dswport0,volatile-memdev=3Dcxl-mem1,id=3Dcxl-vmem1 =
\
 -device cxl-type3,bus=3Dswport1,volatile-memdev=3Dcxl-mem2,id=3Dcxl-vmem2 =
\
 -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D512M,cxl-fmw.0.interleave-=
granularity=3D2k
\
 -D /tmp/qemu.log \
 -nographic

Until I moved to Qemu version 8.2 recently, I was able to create
regions and run linux native commands on CXL memory using
#numactl --membind <cxl NUMA#> top

You had advised me to turn off KVM and use tcg since the membind
command will run code out of CXL memory which is not supported. By
disabling KVM the membind command worked fine.
However with Qemu version 8.2 the same membind command results in a
kernel hard crash.
I wanted to check if this is a known issue with 8.2 and is there a way
around it.

Thanks,
Sajjan

On Fri, Jan 26, 2024 at 10:42=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 26 Jan 2024 10:43:43 -0500
> Gregory Price <gregory.price@memverge.com> wrote:
>
> > On Fri, Jan 26, 2024 at 12:39:26PM +0000, Jonathan Cameron wrote:
> > > On Thu, 25 Jan 2024 13:45:09 +0530
> > > Sajjan Rao <sajjanr@gmail.com> wrote:
> > >
> > > > Looks like something changed in QEMU 8.2 that broke running code ou=
t
> > > > of CXL memory with KVM disabled.
> > > > I used "numactl --membind 2 ls" as suggested by Dimitrios earlier,
> > > > this worked for me until I updated to the latest QEMU.
> > > >
> > > > Is this a known issue? Or am I missing something?
> > >
> > > I'm confused on how the description below ever worked.
> > > Assigning the underlying memdev=3Dcxl-mem1 to a numa node isn't going
> > > to correctly build the connections the CFMWS PA range.
> > >
> >
> > I've now seen 3-4 occasions where people have done this and run into
> > trouble (for obvious reasons).  Is there anything we can do to disallow
> > the double-registering of a single memdev to both a numa node and a cxl
> > device?
> >
> It would be novel for us to prevent people shooting themselves
> in the foot ;) but I guess this should be fairly easy as the
> numa node logic prevents the same one being used multiple times so can
> copy how that is done.
>
> This should do the trick (very lightly tested).
> It's end of day Friday here so a formal patch can wait for next week.
>
>
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index f29346fae7..d4194bb757 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -827,6 +827,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Erro=
r **errp)
>              error_setg(errp, "volatile memdev must have backing device")=
;
>              return false;
>          }
> +        if (host_memory_backend_is_mapped(ct3d->hostvmem)) {
> +            error_setg(errp, "memory backend %s can't be used multiple t=
imes.",
> +               object_get_canonical_path_component(OBJECT(ct3d->hostvmem=
)));
> +            return false;
> +        }
>          memory_region_set_nonvolatile(vmr, false);
>          memory_region_set_enabled(vmr, true);
>          host_memory_backend_set_mapped(ct3d->hostvmem, true);
> @@ -850,6 +855,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Erro=
r **errp)
>              error_setg(errp, "persistent memdev must have backing device=
");
>              return false;
>          }
> +        if (host_memory_backend_is_mapped(ct3d->hostpmem)) {
> +            error_setg(errp, "memory backend %s can't be used multiple t=
imes.",
> +               object_get_canonical_path_component(OBJECT(ct3d->hostpmem=
)));
> +            return false;
> +        }
>          memory_region_set_nonvolatile(pmr, true);
>          memory_region_set_enabled(pmr, true);
>          host_memory_backend_set_mapped(ct3d->hostpmem, true);
> @@ -880,6 +890,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Erro=
r **errp)
>              error_setg(errp, "dynamic capacity must have backing device"=
);
>              return false;
>          }
> +        if (host_memory_backend_is_mapped(ct3d->dc.host_dc)) {
> +            error_setg(errp, "memory backend %s can't be used multiple t=
imes.",
> +               object_get_canonical_path_component(OBJECT(ct3d->dc.host_=
dc)));
> +            return false;
> +        }
>          /* FIXME: set dc as nonvolatile for now */
>          memory_region_set_nonvolatile(dc_mr, true);
>          memory_region_set_enabled(dc_mr, true);
>
>
>
>
>
> > ~Gregory
>
