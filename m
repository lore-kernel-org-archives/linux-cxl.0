Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77A23EBF32
	for <linux-cxl@vger.kernel.org>; Wed, 18 Feb 2026 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771380800; cv=pass; b=O7Gp/b8wCSp0Zv28q3HD640D8gl/12gmuvOex90KLF29zrXOA3VKmwxsKWYzUMnGWweFj3OW+EmwVG6G1wQQGEZqLnTR9ufodoDSajTI72sLQ3fIrW10+YKj9GURIrsRKpg7TH+OONhGrtuGdhEr+keo/5UaxkbnXmx2WoVxsvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771380800; c=relaxed/simple;
	bh=S/Z/B3945DyN1CgtJ/z53VZxf7iks2VH62eReMEjqQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRh1k4lAPJvhmTpWK0rIhekdPahtNc7iFl0N8eNggkLSYWDwx4RfOnyZmBorbZpgAYjuDb3PckzC5w83KG0aB/yAxjK5/9HZFmPST2wZ0XPMXzoCY6GW+sfflMXtoPhmdJQ9m7EWSR34yv+uj58ynF0AkdDt3dI+hQ/fYMkUMe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joH4Wp/m; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joH4Wp/m"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65bf2f59d64so3510635a12.1
        for <linux-cxl@vger.kernel.org>; Tue, 17 Feb 2026 18:13:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771380797; cv=none;
        d=google.com; s=arc-20240605;
        b=evV0oDSLIwJ7oxPnx0B1vlM2CNrEKUth8+ovaaWA7pmtIZ5VeA/+BGhQdm5VwMCyra
         NBcui5ss5cczvBCz7TBuFjPy45Gqyc5ARgOUi7YHvKr2adaFhAiatQq0ivZt019y2R/k
         ZLHhAsA2QtTt/RpydqJhyjkOtPeQ3dO0LSVJbsx2KAn0pTdwLLKubb4MU+E8adoeDmG9
         aWu7IT7jaCjsqdItfKpjNe2mlhJFX/FOtv6P0F57Cq0COVQK5M14sH0MtfXt4MyFiPht
         ezrcuivyEksLlvjrKI5RElnkOMqev+9QIApvwpv2pz8e4KwKgTVnyBTk6JZa0iu6/FV+
         mpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yt03EibpDHB+OSTayepUfQsKwul4kw22IcVV11w6O5c=;
        fh=6GTjQ4o/Kd3bF9OQFXxk7WEeXMhkvqmSSepYcfybFIM=;
        b=OipYcvYecJhMKr+rCplta5kdNLkWas+jf9WHzlfYyKtHz9SepR+n5c1+kFTQqQvSge
         uKx/BjXCHON3ec+qZ1Um7qZBZqJ1oXOIWCaVuolQpiRy42JduF2Jl6UV1hOG1ScxvYb+
         uKqOb2NSo7Lu3jMLYf4FXfdQPub3epRZcbv7HxTTVq+gE+CuugQy+A7kXtlsG5YGdjOG
         920j+zxzatVsgRPGgm8gIojv570hJR+37NC7hOFJuFh8sVi4fOozFnOa9Sej8lR0l9b0
         p8UtQnZFBQZNgUehZx0/yRGoZRH+fE1/VV+L4yFQVfoykv0sC4VkZKH9IEZhejFtgE1N
         usFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771380797; x=1771985597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt03EibpDHB+OSTayepUfQsKwul4kw22IcVV11w6O5c=;
        b=joH4Wp/mCKT9U/skqar+JcyFggO/PFCWbsG2S0Ko3fh8pyoyy408Dj8dKHgdU8j4g/
         0w96RKfWqB57c0+8aDL267bFTtBQrFuylgJTOXPm3g0cSHrv9Ta4V8mL/NJJWsm3xL3G
         9TyPUI3a3pduG7vpYOGsPaSWnwoxwu3jKiqK8jkoEqwxYWk3DirkMe1VqlyU+nX0Eqih
         u1pLKj3eiokeeCwdGN8IGdSWgZPZpkHEg0cxlWEkk26AZyeMTtmkjE3Ps+z2iusV9+BP
         lUBMgppSLH9HIPoQpmUY5er7uqMeS/XEIo3XnIRuE2b0GMl5dS0A609AmMagKZow2oCW
         ugig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771380797; x=1771985597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yt03EibpDHB+OSTayepUfQsKwul4kw22IcVV11w6O5c=;
        b=k5UdPv1d800bTKynO+FV5hYGcPdqcrlSp8NPLf7jrxG24jlymr5lLxvaqTnlYqMj9A
         d5c7x6cnBUhXTvqZAXbnkDG1H4kzkDsG6AEjpajt3/ABVIfdqLK22t2Bt0ePntktwAgZ
         7PAUz+bdIl5JJZT/pUZBmwomIFVynotV/CZu9sD7k0WtOTONitdYVAf1hrMut9yzMWl9
         pZBF6po2jUK45Hh9kiwnUsbTJaTsz89mTr9gs8zScc1tsvkEv6fN5yncpYCqikTXbAZm
         XKQVzD/5fM9I2xiN4Lc6CyYD+T4KoWoLc1yKsVdYHDpDXlHhu1t4RnLFr3ayGyFAdbAs
         QmiA==
X-Forwarded-Encrypted: i=1; AJvYcCVsVfjBy33W/GzZ1u3yWZlsPAEm8wsyBt/USifDuh7wVGD/vmgM/1QbvflinBWdzYW9Fwrl950nPWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8uIoz7+o0KAYqKGjF7jTSQ43TeNLwDuS2TozdBcJMXen1akxN
	Nh5ctrXrRvK9Xr66U+n/rxMD2DIvBBGUP0iCocvZwdAxJkE1hE0JGIRXAlxplNo5uJ2x7k9JMc3
	aB7xgZ1c10OT4FY7PmTk/gYyvQxQ+ea4=
X-Gm-Gg: AZuq6aIttu2HBjBRKcA4wkPN3a+SbP788Tns1JwSH3GfI+ayZkVm96LMhyyIU4YbmHG
	NhwMTXOD1REs8JuVvfkzs6PfFQ54KyOUU1plpEnhy3s/YcvhU+gdrDuD55B1lCW6Fq+e0vPO9DQ
	JXkg/cIt/GsAh4bo0sHIXdsfZ5QppNNx36IH8V+Nh56kCjTIDWnzks2c0gGyVZCCRbbhJyOMv7J
	BcAFN741NS6wHMIog9j0ZVTLCi6hwnPbzb74quk/SmGHo8pxXmUdxViaUdNqtjdqP9qG8hVxzkc
	bzDMBDNQ1fPbk9wwUXPHD6m2YbumHl5QY56X/Q==
X-Received: by 2002:a05:6402:f16:b0:658:c1b3:b958 with SMTP id
 4fb4d7f45d1cf-65bc7605c53mr5233615a12.0.1771380797025; Tue, 17 Feb 2026
 18:13:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com> <698d6b7faa190_2e57100d3@dwillia2-mobl4.notmuch>
In-Reply-To: <698d6b7faa190_2e57100d3@dwillia2-mobl4.notmuch>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 18 Feb 2026 12:12:50 +1000
X-Gm-Features: AaiRm50kUfToGCU-ZHMlptQVt4b0wRA7xDMepx3E9_wmPCsQaIda1MtDKAVhlig
Message-ID: <CAKmqyKPoY+u+9MxDb5eeCdQDB+KB=CVwqVBgCsKUK+uua7QY0A@mail.gmail.com>
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

Great! That was my goal.

Also, with netlink some of the C code is autogenerated, so a Rust
version would be tricky to do well.

>
> Specifically, my primary concern is integration and refactoring
> opportunities with the PCI TSM implementation [1]. The PCI TSM case
> should use the same uABI transport for requesting + conveying device
> certificate chain, SPDM transcript, and device measurements as PCI CMA.

I do think broadly that they can use the same uABI. I'm sure there
will be refactoring required though.

> Note that in the TSM case the SPDM implementation is in platform
> firmware and will bypass this library. The TSM SPDM session is mutually
> exclusive with the CMA SPDM session.

As long as we can get the details from the platform firmware (which I
assume is possible) then we can present them to userspace via the same
netlink ABI.

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

I was trying to convey that a lot of this work was done by Lukas, I
didn't want to appear to be claiming otherwise or stepping on toes,
hence the links to his git tree.

As for an ideal path forward, what I think would be really useful is
if Lukas' prep patches get merged. Lukas sent them in his original
series and they have been reviewed there. I have picked them up here
to help with testing, but they could go upstream today and set the
ground work for either a C or Rust implementation.

That would reduce the size of any future series as well.

From there it would be worth thinking about a C or Rust implementation
and maybe just focus on one and work towards that.

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

That sounds fine to me

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
>
> To be clear I am ok if there is an incremental option to have auto_cma
> and/or auto_tsm that arranges for authentication or link encryption to
> happen without asking. I take issue with auto_cma being the only hard
> coded option.

Ok, so we would need a way for users to select TSM or CMA and specify
policy information?

Alistair
