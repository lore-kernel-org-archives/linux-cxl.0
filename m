Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9883524501D
	for <linux-cxl@vger.kernel.org>; Thu,  9 Apr 2026 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775705977; cv=pass; b=Amn/X2dAt94gBrkO+Lkeu5mLgIjAGfpzOhjMAFJBTA8bBueuEyZ9KnJSqGXC0o5SYtuJ06Z1UYNHWtWdxpQinBnpw/wYGPAVI535ec3zfOIivNVVZz+IlLycg/rASZyJ7NKS8vL5363GXZVhiswI9BGq5D2GHVf/LQ+Q+0YaNnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775705977; c=relaxed/simple;
	bh=ipzqqbtUTjTUXelIrvbr406hnlHtjj80FJssP+iGieM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfagSLsnreKS7wao918xvIqiXwqelwzSaxZRbx6zJ0x5jKdRXn1I+qKE5n2fWfTmY2gWGjrJjMBv2s78dDscFolI+9rkBQDJHr8DQ5iXDrda86Dmdpeb/Hj1I60V/2NMnU2JGPqh3PuOaflNCvKltgPu4iyuXfcD8pilDK/HwuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/m5kjUA; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/m5kjUA"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8f9568e074so69536266b.0
        for <linux-cxl@vger.kernel.org>; Wed, 08 Apr 2026 20:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775705974; cv=none;
        d=google.com; s=arc-20240605;
        b=OXw+Q1Ip9NJsu3KWfB+FSvDbXdcS+00ffR+VzEfLY/siTSkdwvPNGZoLG+KW4Tx8uv
         4DCP7wLOb+OQEw5LJkBEskv+l0LngGRxtmBsQ1GoC4lpgsioJQ2LRK5fLpqV3+9519m2
         2Wx5MiBM6oJlXzMu4yxUaE9MaQ8Rzp0l0N+5dATHpyv58FhbavNxghM7C7ve/vNdzM1N
         HdyPQM3SbjkrdXqxMyBZQ1FpPrvGgBi56IqWg5KgjWXUw++kqYosKFGSsqrXq461upFS
         HfTuwYzp6/Kltjb+AkXLSWWyDbBuCF6oNjHapqWo+KSDV3Ou7pNH2rob1NG7RtcJDvQo
         qLSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3nK2rPjTD2J2hcTM4BMrIGnDtvubzv9T1WI+OHmAy3g=;
        fh=zvOCp6qhhKatbbf0szjHydk+ZQp77pQu7yWmEeTKbmY=;
        b=OrkLk86dxljfEnH5ekyYfsbff5fmHaszKIu+YWVHHbOMSbmsI43KqJ8vBsY5zuyphv
         76A5xgtmD/+jlaa0Mzt1FosHIJS0umLXZ7eVgvUR04w5E5iMdqvyMxAc9TfRVOcM8YF8
         164w8w8hF1Ol5E/GVSqad2H1VfX5hL7q3FEoaCAEGeCrbpUKi0nGOj2zsbNKN0NVkmJT
         z6sSgW4JrbNRDxaN3QA+8SANUOa0BmIXa6+a+fMfU6xSwDncuBeiMGZBSraao+XMGC3o
         4ZoAf6+YzIVsAOEUDg/MKM+mwiqilmhRzQionibAcRa9UCzTKq04ml9Bra59C0XRMQx6
         +UTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775705974; x=1776310774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nK2rPjTD2J2hcTM4BMrIGnDtvubzv9T1WI+OHmAy3g=;
        b=r/m5kjUASiqAbHtDa6Rpw4MiO3QxDjcYQrkoPIxQhSEt8OhFq432UurTa9db+6rMR4
         1tSQCN+pH0oShWSsQVEBe9gNS7A1a72NTkMqJ4XsEL4nolY/THohvyHZDQq5+J6r+sLO
         ywxKgQCCbqxcz4+QvY5yjPpFGuPwnT1/eYwLK3sS2cTQeOatR7eEdiAtOs2rXSH4gv55
         IN6sjFfEPANe5sF+KDe3aLe02/t7JIy1StdLK//FbvorQO6UnLneZpVovVWgAcf4sCgx
         ADvPKCPKt7HTGaj6dBjZggXk92GosIxJgGEh7UiH02CTbg7ugtYXohith8SrwDnpryzs
         ggNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775705974; x=1776310774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3nK2rPjTD2J2hcTM4BMrIGnDtvubzv9T1WI+OHmAy3g=;
        b=b5Huf4Q0cztlgnANpy1XXpkeKu9Jg3UHCaGFNs9aZ6K+I+23wGmYIko2hV5mMkjhGx
         4c39BV8xjGqh0iCPOlY3VeIftYFXyXSo68ZeXse+atwLsTgn0MIuwedafdgF5sqOV7k5
         PEpiMsPSGxQkBfv1x71cWv71Zz/ka0x3mq0lkK8Yneyq1kwZPUbxQ2ON9EnBDRPl6RNl
         5yegHwXxnERgaKTrnCA3QcUcLwHThXXpIChFOVCXkjmhZ0CbhugX3L8euzvZom2wB6av
         EK14qWGrFyCpiVhrbOJcoI+jCawe+GOIbnrxJ527zCNdh2i195eUNk2z4CaVraom8YyB
         f1dg==
X-Forwarded-Encrypted: i=1; AJvYcCUBvPs8rdYO2XgxZcQr7wQlzbr8pMx2NJ64nhemhu8cWEVIEwVqHCyybFlohxI0DEZoTGopSYz0zy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx57qQIAslO6C9CNZrXB4+JM4Y7EViXeJmXYvZ95ahCkRE8V32E
	AbvhIqQY1EHLHoZCt4ADkzDL9/PWPVVfT7k2hyxEP8pqbhpYIFrOWFxbsqhV3PYC82xfcgGsY7J
	1nInoyI7gykSlW+8VenUSjpyBZy3zoGs=
X-Gm-Gg: AeBDiesbntHZnCmmJhmFImgXiY+DjPSRgg3uukJUHAd6qToCzof3X+msvCtPUrmmd1x
	/ridxGyfieCRKkpOR6whZkvombnJZdjQC+540AA02auAu73yseHI41iBFDQusRHDT+a2Gls/Zkh
	ZUTep6cgae2sXJHl3Xya43WBw5yOsvsm6diCx/ewwAMMvlblxkpxO52tDJceVcceqHPXo5bN7H6
	VuecU6g16Ll86JeWt3QI5nslwbUE00HP4epfe78XknI3UFKiicopDhWENfQc+BzOPF94oFlfOqt
	tl+usLZk7OEEvbJhjNZwD/Qg/V79oomoXY4eQg==
X-Received: by 2002:a17:907:96ac:b0:b97:d126:c007 with SMTP id
 a640c23a62f3a-b9d4766357cmr74156066b.30.1775705973292; Wed, 08 Apr 2026
 20:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com> <698d6b7faa190_2e57100d3@dwillia2-mobl4.notmuch>
In-Reply-To: <698d6b7faa190_2e57100d3@dwillia2-mobl4.notmuch>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Apr 2026 13:39:06 +1000
X-Gm-Features: AQROBzBMdVWviJ7UQPVJiSjzXhX3MyVPNdI2Nycp2rCssuJJohwu6SX0ICGXpZw
Message-ID: <CAKmqyKPyR165rACXRMJXgyUOp6OUdQqSsym-gfYVFnKLZ4ednQ@mail.gmail.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
To: dan.j.williams@intel.com
Cc: bhelgaas@google.com, lukas@wunner.de, rust-for-linux@vger.kernel.org, 
	akpm@linux-foundation.org, linux-pci@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 3:56=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> alistair23@ wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
>
> Hi Alistair, quite a bit to digest here and details to dig into. Before
> getting into that, I will say that at a broad strokes level, no immune
> response to the core proposal of depending on a Rust SPDM library and
> forgoing a C SPDM library.
>
> Most of that allergy relief comes from how this organizes the C to
> Rust interactions. The core SPDM implementation calls out to C for the
> presentation layer (Netlink) or is invoked by sysfs. That makes it
> amenable for sharing those presentation mechanics.
>
> Specifically, my primary concern is integration and refactoring
> opportunities with the PCI TSM implementation [1]. The PCI TSM case
> should use the same uABI transport for requesting + conveying device
> certificate chain, SPDM transcript, and device measurements as PCI CMA.
> Note that in the TSM case the SPDM implementation is in platform
> firmware and will bypass this library. The TSM SPDM session is mutually
> exclusive with the CMA SPDM session.
>
> [1]: http://lore.kernel.org/69339e215b09f_1e0210057@dwillia2-mobl4.notmuc=
h
>
> > Security Protocols and Data Models (SPDM) [1] is used for authenticatio=
n,
> > attestation and key exchange. SPDM is generally used over a range of
> > transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
> >
> > From the kernels perspective SPDM is used to authenticate and attest de=
vices.
> > In this threat model a device is considered untrusted until it can be v=
erified
> > by the kernel and userspace using SPDM. As such SPDM data is untrusted =
data
> > that can be mallicious.
> >
> > The SPDM specification is also complex, with the 1.2.1 spec being almos=
t 200
> > pages and the 1.3.0 spec being almost 250 pages long.
> >
> > As such we have the kernel parsing untrusted responses from a complex
> > specification, which sounds like a possible exploit vector. This is the=
 type
> > of place where Rust excels!
> >
> > This series implements a SPDM requester in Rust.
> >
> > This is very similar to Lukas' implementation [2]. This series includes=
 patches
> > and files from Lukas' C SPDM implementation, which isn't in mainline.
> >
> > This is a standalone series and doesn't depend on Lukas' implementation=
.
>
> So, I *am* allergic to how this series references Lukas' work by
> pointing to random points in his personal git tree. I trust that was
> done for RFC purposes, but it would have helped to call that out in the
> changelog and set expectations about the ideal path to coordinate with
> that work.
>
> > To help with maintaining compatibility it's designed in a way to match =
Lukas'
> > design and the state struct stores the same information, although in a =
Rust
> > struct instead of the original C one.
> >
> > This series exposes the data to userspace via netlink, with a single sy=
sfs
> > atrribute to allow reauthentication.
> >
> > All of the patches are included in the RFC, as it depends on some patch=
es
> > that aren't upstream yet.
> >
> > Now that Rust is no longer experimental I have picked this back up. If =
the
> > community is generally on board with a Rust implementation I can work o=
n
> > sending a non-RFC version and push towards getting that merged.
>
> As long as this stays explicitly designed to minimize exposure to
> "refactor across language boundary" events (as initially seems to be the
> case), then it seems workable.
>
> > The entire tree can be seen here: https://github.com/alistair23/linux/t=
ree/alistair/spdm-rust
> >
> > I'm testing the netlink data by running the following
> >
> > ```shell
> > cargo run -- --qemu-server response
> >
> > qemu-system-x86_64 \
> >   -nic none \
> >   -object rng-random,filename=3D/dev/urandom,id=3Drng0 \
> >   -device virtio-rng-pci,rng=3Drng0 \
> >   -drive file=3Ddeploy/images/qemux86-64/core-image-pcie-qemux86-64.roo=
tfs.ext4,if=3Dvirtio,format=3Draw \
> >   -usb -device usb-tablet -usb -device usb-kbd \
> >   -cpu Skylake-Client \
> >   -machine q35,i8042=3Doff \
> >   -smp 4 -m 2G \
> >   -drive file=3Dblknvme,if=3Dnone,id=3Dmynvme,format=3Draw \
> >   -device nvme,drive=3Dmynvme,serial=3Ddeadbeef,spdm_port=3D2323,spdm_t=
rans=3Ddoe \
> >   -snapshot \
> >   -serial mon:stdio -serial null -nographic \
> >   -kernel deploy/images/qemux86-64/bzImage \
> >   -append 'root=3D/dev/vda rw  console=3DttyS0 console=3DttyS1 oprofile=
.timer=3D1 tsc=3Dreliable no_timer_check rcupdate.rcu_expedited=3D1 swiotlb=
=3D0 '
> >
> > spdm_utils identify &
> > sleep 1
> > echo re > /sys/devices/pci0000:00/0000:00:03.0/authenticated
>
> So this is where it will collide with TSM that also emits an
> authenticated attribute. See Documentation/ABI/testing/sysfs-bus-pci.
>
> The rough plan Lukas and I worked out is that switching between TSM and
> CMA based authentication would use sysfs visibility to coordinate. I.e.
> TSM to CMA conversion hides the TSM "authenticated" attribute and
> unhides the CMA attribute of the same name.

That seems straightforward and is already documented upstream as well,
so that's pretty easy.

>
> The most significant unsolved point of contention between TSM and CMA is
> the policy on when authentication is mandated and the driver probe
> policy. The proposed model for enforcing device security for
> Confidential Computing is make it completely amenable to userspace
> policy. Draft details here [2] to be refreshed "soon" when I send out
> the next version of that.
>
> [2]: http://lore.kernel.org/20250827035259.1356758-6-dan.j.williams@intel=
.com

CMA will eventually need to support some sort of drive probe policy as
well, but that can wait until later and isn't going to be dealt with
in this series.

>
> To be clear I am ok if there is an incremental option to have auto_cma
> and/or auto_tsm that arranges for authentication or link encryption to
> happen without asking. I take issue with auto_cma being the only hard
> coded option.

I have been working through all of the comments and discussions and I
think I have addressed everything, except for this one.

To summerise, is the high level issue is how do we know if we should
use CMA or TSM?

Do you have any more thoughts on this?

Alistair
