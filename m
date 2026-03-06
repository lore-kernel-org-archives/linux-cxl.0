Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE84256C8B
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835496; cv=none; b=Eviu/g3AUGL3pBhKwl32Nn4vosfRQghOGR+47icN+Qw2pLYh78DEgwdmgHzsYeGcV6xaVZahaUE1Ad0+SfdqOtWkCMF8y0eFeY4keIt5s3m4dowKMOpYuCI+hYUJmcUIXloDLrzRZL6721m5ARBwZP22XEUw1SDuIfmJpOjetl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835496; c=relaxed/simple;
	bh=ugpnO3CyVqqa6dmRhSDMbbBhYUntQEvUcaXZ/1Q8XVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quumk7FjWihX+boGh9eZqPMr3xosITWQr7L0KvPrf1rbwEIn8pr2IroJ2RxK5VGrKfiXzQcUFLQVHmH2E6eff/xEThwLCv6uS9xdvhBqmuHVRwBOysxO6cmGrmhtnq5vj711aQlf+gw32sgfK9zkaCCGKEg/Pev3R7Jnb9hYWvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4cgaekb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4cgaekb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F118C4CEF7
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 22:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772835496;
	bh=ugpnO3CyVqqa6dmRhSDMbbBhYUntQEvUcaXZ/1Q8XVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i4cgaekbikNCLYvu3NR6URmsW9QaSRSnox6WC8iTDh64sOo5yeQahosMiznaGgELu
	 8QXVgXwWYcxImlYfHcrmUdCUx1N3swIUZRKaFa3kzuwyMhMMYloNWrZXS1SL5sBxK5
	 0+6lQyKwtZ+Ibb/efF7Y3r539JsU9pWIVmnBSJkpaQgHjw+ioFSDlgSBBgsUgn8Vz5
	 0sQsk4ajUcRYptM1iG2XoJuebwCy/3GOrF9EV2PagoYTQmILpR+IwGwJEZThOT0uUN
	 l1Z+LtfUj97yXYMwyj03t80u6HePXQTM4KFuw6KwMrF7pSrgyZG2znqks17HO8Bo4+
	 iZzlDCbTfHabw==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89a09ef1e3aso66406206d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 06 Mar 2026 14:18:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIksUB7kBlBetxZVEF6SFkKvRrj6V3bRDj70U9nBOh1XGXpGUm9oYahcYKO37IP/RBTSdd/MzOX08=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfc7EqwnlqqYHYGnwZbbjK8SPqHYpFYYYJ6GYcRS3FGjMO783A
	eVokTp9k0x8ybk5YN6fEzCpOmZ3yHQP8qrTuVbdyLTEFS5bKYOmfa+R0LHAuhL6HVoprGYcdD+3
	pZL/BtztHndt6GcqsSAfUrs5oRI5/3Go=
X-Received: by 2002:ad4:5ca6:0:b0:89a:1790:3993 with SMTP id
 6a1803df08f44-89a30adb99dmr49897076d6.50.1772835495414; Fri, 06 Mar 2026
 14:18:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302200429.803417-1-gourry@gourry.net> <69aa2c9631aef_6423c10077@dwillia2-mobl4.notmuch>
In-Reply-To: <69aa2c9631aef_6423c10077@dwillia2-mobl4.notmuch>
From: Song Liu <song@kernel.org>
Date: Fri, 6 Mar 2026 14:18:03 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7uE3J4+td=wLpJfiwSVbeyrF261in_yj3pudK9v6_o=Q@mail.gmail.com>
X-Gm-Features: AaiRm51KmFLhVSWwbaJgIGtU796NRgTsHxOagkUlm5rlz_ojJXgq13xzBjrH_J0
Message-ID: <CAPhsuW7uE3J4+td=wLpJfiwSVbeyrF261in_yj3pudK9v6_o=Q@mail.gmail.com>
Subject: Re: [PATCH] cxl/acpi: fix CXL_ACPI=y + CXL_PMEM=m link failure
To: dan.j.williams@intel.com
Cc: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net, 
	jonathan.cameron@huawei.com, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 5:23=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> Gregory Price wrote:
> > Commit e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to
> > cxl_pmem.ko") moved devm_cxl_add_nvdimm_bridge() from cxl_core into
> > cxl_pmem, creating a symbol dependency from cxl_acpi to cxl_pmem.
> >
> > When CXL_ACPI=3Dy and CXL_PMEM=3Dm, the built-in cxl_acpi attempts to
> > link against a non-built-in cxl_pmem, which the linker cannot resolve.
> >
> > CXL_PMEM depends on LIBNVDIMM, so LIBNVDIMM=3Dm constrains CXL_PMEM to
> > at most =3Dm.
> >
> > Change IS_ENABLED() to IS_REACHABLE(), which returns false when a
> > built-in caller references a modular target, preventing the link error.
> >
> > The result is if the pmem/nvdimm symbols are not reachable at build
> > time, then at runtime it will always return -ENODEV.
> >
> > Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pme=
m.ko")
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  drivers/cxl/acpi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 127537628817..7065413eda9f 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -952,7 +952,7 @@ static int cxl_acpi_probe(struct platform_device *p=
dev)
> >       if (rc < 0)
> >               return rc;
> >
> > -     if (IS_ENABLED(CONFIG_CXL_PMEM))
> > +     if (IS_REACHABLE(CONFIG_CXL_PMEM))
> >               rc =3D device_for_each_child(&root_port->dev, root_port,
> >                                          add_root_nvdimm_bridge);
>
> I think we want this conflict to be resolved at build time. The nice
> thing about a new CONFIG_CXL_ACPI_PMEM symbol is you can check your
> config to find out why your CXL PMEM is not working. Otherwise,
> IS_REACHABLE() hides this subtelty.

Can we fix this with something like the following?

Thanks,
Song

diff --git i/drivers/cxl/Kconfig w/drivers/cxl/Kconfig
index 4589bf11d3fe..0290e0f22cf8 100644
--- i/drivers/cxl/Kconfig
+++ w/drivers/cxl/Kconfig
@@ -59,6 +59,7 @@ config CXL_ACPI
        tristate "CXL ACPI: Platform Support"
        depends on ACPI
        depends on ACPI_NUMA
+       depends on CXL_PMEM
        default CXL_BUS
        select ACPI_TABLE_LIB
        select ACPI_HMAT
