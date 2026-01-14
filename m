Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6994C2DEA68
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404076; cv=none; b=jL2XXCHPUb1zWfBAoZgixzfOStkMzxFw7i9fAwJTjxDck4s46er6VGQ/ByO1NBkp8htevWYpRuJ5eF+jCdidddWV0OdEvmXGtUmCbspz6Ylav0Dor0d5QRpvg1ZebET0SukQ9/NPvynWFEPvpaip0yivFz5e+nhniMmcVGKUSsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404076; c=relaxed/simple;
	bh=EeEjZ2cLiQDmy17uYLRmZNhGOEhvFkx8Gp2/TDxeCy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llK9Vl9e+58Ej3t2prEVaxoqpdvXX7QVcLOfm+zHq/9JVtpkixb+zSgPKQJ+KezgolCGac2ltvLShP7f683iAYOUvcrQzTSRNdpf3UO3seC/Tc5/XBLwBXGhwrtIO6oEPwJYkxuMjLIcYW/Vf8jzGrD52Idv1fRQZ8/HABO4sE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUx/Trd0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUx/Trd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD04C4CEF7
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 15:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768404075;
	bh=EeEjZ2cLiQDmy17uYLRmZNhGOEhvFkx8Gp2/TDxeCy8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lUx/Trd0nF09Fw+0g76bfZJSrT8eVCK8yQW5eG06KBbFhlAicQwWc04TDMmPe+9z6
	 r6ao/Kt24oBHvG2a6hQkLD7nVHE24wJBcmrWBOIr9XR0KHhx8aA+Ax41O+CJu1rYwR
	 KRFugv9IiO99/bYSDoRJHp1IRnocZKAS9UB46YVv0uNkvFHJy3WimWJ4J7TXLpWbdt
	 29Ml5FxAdDlHBj5bO3fmtWNFlQlIu5E8xCWu2GFXYyHmMryIMe/A+PmXrMxd011u8s
	 23TsAOHzXDkiizwyzGoj5I0+i+QfFwJLK7HCuJQ5LIjOmW0ARbUA3D8bDgZNO9mmMb
	 YnURd4Ot8LESA==
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso5059841a12.3
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 07:21:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVq5BclTihDl+TfTZXBncVju+FNnV+ICKs6r04Fw3yPwH/uVvYcaADLd+wwJ4QWV1ANM1yK74OEdTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGXAQlDHidf/kdKZ+x7aKv72qukE1tHkz/7/HHoXHCtundV/p5
	v8i4gKuNVMNgV4mdvhX2zlQb7Gm5BciTyPGKuw/26Doj8gRz0mZLCCNjm5FaJvRBeosI1/qmbXT
	awAxQxW4+vpbBRVFPq2vWAkuGF24ezL0=
X-Received: by 2002:a17:90b:38ce:b0:34c:904a:d92 with SMTP id
 98e67ed59e1d1-3510913ccf0mr3199402a91.26.1768404074331; Wed, 14 Jan 2026
 07:21:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110114705.681676-1-rrichter@amd.com> <20260110114705.681676-11-rrichter@amd.com>
 <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com> <aWehZwXsK1IXRNU2@rric.localdomain>
In-Reply-To: <aWehZwXsK1IXRNU2@rric.localdomain>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 14 Jan 2026 16:21:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
X-Gm-Features: AZwV_QhE5x3u7M_MSiNN6vXntJPsoNGg-mpnp4GPlfV7TglKxwvzSf1QstpYyvY
Message-ID: <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
To: Robert Richter <rrichter@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>, 
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Jan 2026 at 15:00, Robert Richter <rrichter@amd.com> wrote:
>
> On Wed, Jan 14, 2026 at 08:47:22AM +0100, Ard Biesheuvel wrote:
> > (cc Peter)
> >
> > On Sat, 10 Jan 2026 at 12:46, Robert Richter <rrichter@amd.com> wrote:
> > >
> > > Add AMD Zen5 support for address translation.
> > >
> > ...
> > > Do the following to implement AMD Zen5 address translation:
> > >
> > > Introduce a new file core/atl.c to handle ACPI PRM specific address
> > > translation code. Naming is loosely related to the kernel's AMD
> > > Address Translation Library (CONFIG_AMD_ATL) but implementation does
> > > not depend on it, nor it is vendor specific. Use Kbuild and Kconfig
> > > options respectively to enable the code depending on architecture and
> > > platform options.
> > >
> > > AMD Zen5 systems support the ACPI PRM CXL Address Translation firmware
> > > call (see ACPI v6.5 Porting Guide, Address Translation - CXL DPA to
> > > System Physical Address). Firmware enables the PRM handler if the
> > > platform has address translation implemented. Check firmware and
> > > kernel support of ACPI PRM using the specific GUID. On success enable
> > > address translation by setting up the earlier introduced root port
> > > callback, see function cxl_prm_setup_translation(). Setup is done in
> > > cxl_setup_prm_address_translation(), it is the only function that
> > > needs to be exported. For low level PRM firmware calls, use the ACPI
> > > framework.
> > >
> >
> > Does the PRM service in question tolerate being invoked unprivileged?
> > The PRM spec requires this, and this is something we may need to
> > enforce at some point.
> >
> > cc'ing Peter with whom I've discussed this just recently.
>
> Interesting appoach, need to check if that works. I haven't tried that
> yet. Though, that needs some rework of the kernel code as some high
> priority code depends on the translation and that would cause kind of
> priority inversion. E.g. an interrupt handler cannot wait until a
> dpa-to-spa conversion is done.
>

This is not about running it in user space, but about running the code
in an unprivileged sandbox. So scheduling wpuldn't really come into
play here.

> For CXL it is only used for region setup in the init path and process
> context. For tracing and error handling those translations are
> disabled. See patch 13/13.
>
