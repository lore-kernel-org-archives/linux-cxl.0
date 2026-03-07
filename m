Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E10328273
	for <linux-cxl@vger.kernel.org>; Sat,  7 Mar 2026 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848205; cv=none; b=QQ+JpGBeH223tTU45rDPf4rS5Fdno17XobK8tZNgeD7Qi8nRpXYoG++UvVeslMcgN5ZnlDl0/LW7vw9REyA+itZmi/HEv9zFnpABnWICu/aitBfn9fA4xGXNWh/GmwV9KjQgqOo+KXB8iNDQRP+vZiNSbUNq/Bu46sdOfLfbRU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848205; c=relaxed/simple;
	bh=cVug2L76jzzE95ClVKYzJdsF+0M/9ja3f2cxbcil75w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=at+4HPrFCTQBLLQI1UevwnF8l9vfncfWL8ihCCoo4QyIjd4/NHGTXwa5buFO1ozoaoYowIQKJAV6W/Z5tW/jo+GOzvtdwfSA38krGq0difFGRUP2MkO99ffr1dQI3nMOsfYKkI5SFn9OPNjRxFL+CZ5He9y28CG287kv0s9ccaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B061dFGe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B061dFGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDC6C2BCAF
	for <linux-cxl@vger.kernel.org>; Sat,  7 Mar 2026 01:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772848205;
	bh=cVug2L76jzzE95ClVKYzJdsF+0M/9ja3f2cxbcil75w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B061dFGePR0Wy06d1VLGeXrVL9rKFiJKGq7NFDFU5oGQVyXYXqqEk0q+egNu88lH5
	 2YBg4koGRGqscmJy00O2rp1Es4mSVLqfuwAd0oKp9HkB07TphtOuqINqYItalajnYY
	 cwPgeQghuK/6ZXT2y1HU2ep7wzC+8Cx74yet4sFj7HHRn/8lHHCGsntKCWCkUhyuYU
	 pBd9HxbAdKfgtLDLFCrH4gzWsnlvwNmCUpYh2u58T76Wc29mg4ddh0F48VDErzE0LO
	 7m5jjTZYNJIqsw6r8zR4kPTsosFcmniTh86IDgXBDoV6n7PGfiIzSwU7SYNJIwsQtf
	 6qY7KY4rm55Kw==
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899e43ae2e1so61493696d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 06 Mar 2026 17:50:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZSbBxh4BsrAiFk9W7IX7DQobv8g2KIXh1Tt3sykIzcpXevf44vQxJ4PZI+vMgl5B/LtLRuSAAdcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcy4xhmFdAQCYsB95BnYAo8pAkJCr74/wxeX7ZI6WUgf0C9knB
	1dn34B40kPUimzTWbopo/KQJnMmEkPvDl1d+4LRd9qtxRyMuGJUXbTLBOX7dVRZzrtnBdKXCnRC
	i7BoGLIE1TFjbcmpAbVXXSK4Q+ARzfqA=
X-Received: by 2002:ad4:5ca9:0:b0:89a:1536:2526 with SMTP id
 6a1803df08f44-89a30a5998emr59169866d6.26.1772848204289; Fri, 06 Mar 2026
 17:50:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302200429.803417-1-gourry@gourry.net> <69aa2c9631aef_6423c10077@dwillia2-mobl4.notmuch>
 <CAPhsuW7uE3J4+td=wLpJfiwSVbeyrF261in_yj3pudK9v6_o=Q@mail.gmail.com> <69ab805da9dcf_6423c100f0@dwillia2-mobl4.notmuch>
In-Reply-To: <69ab805da9dcf_6423c100f0@dwillia2-mobl4.notmuch>
From: Song Liu <song@kernel.org>
Date: Fri, 6 Mar 2026 17:49:52 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5-Wwu2gm_aAszYA156c4tCsP6YBw-N5yAQKeSdsUq_jw@mail.gmail.com>
X-Gm-Features: AaiRm52rK0bEaLfqTAqCJtSn3RAEbtAd8dOwbfDoLh4mF4JN2-17SN32yWaTPRA
Message-ID: <CAPhsuW5-Wwu2gm_aAszYA156c4tCsP6YBw-N5yAQKeSdsUq_jw@mail.gmail.com>
Subject: Re: [PATCH] cxl/acpi: fix CXL_ACPI=y + CXL_PMEM=m link failure
To: dan.j.williams@intel.com
Cc: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net, 
	jonathan.cameron@huawei.com, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 5:33=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> Song Liu wrote:
> > On Thu, Mar 5, 2026 at 5:23=E2=80=AFPM <dan.j.williams@intel.com> wrote=
:
> > >
> > > Gregory Price wrote:
> > > > Commit e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to
> > > > cxl_pmem.ko") moved devm_cxl_add_nvdimm_bridge() from cxl_core into
> > > > cxl_pmem, creating a symbol dependency from cxl_acpi to cxl_pmem.
> > > >
> > > > When CXL_ACPI=3Dy and CXL_PMEM=3Dm, the built-in cxl_acpi attempts =
to
> > > > link against a non-built-in cxl_pmem, which the linker cannot resol=
ve.
> > > >
> > > > CXL_PMEM depends on LIBNVDIMM, so LIBNVDIMM=3Dm constrains CXL_PMEM=
 to
> > > > at most =3Dm.
> > > >
> > > > Change IS_ENABLED() to IS_REACHABLE(), which returns false when a
> > > > built-in caller references a modular target, preventing the link er=
ror.
> > > >
> > > > The result is if the pmem/nvdimm symbols are not reachable at build
> > > > time, then at runtime it will always return -ENODEV.
> > > >
> > > > Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl=
_pmem.ko")
> > > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > > ---
> > > >  drivers/cxl/acpi.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > > index 127537628817..7065413eda9f 100644
> > > > --- a/drivers/cxl/acpi.c
> > > > +++ b/drivers/cxl/acpi.c
> > > > @@ -952,7 +952,7 @@ static int cxl_acpi_probe(struct platform_devic=
e *pdev)
> > > >       if (rc < 0)
> > > >               return rc;
> > > >
> > > > -     if (IS_ENABLED(CONFIG_CXL_PMEM))
> > > > +     if (IS_REACHABLE(CONFIG_CXL_PMEM))
> > > >               rc =3D device_for_each_child(&root_port->dev, root_po=
rt,
> > > >                                          add_root_nvdimm_bridge);
> > >
> > > I think we want this conflict to be resolved at build time. The nice
> > > thing about a new CONFIG_CXL_ACPI_PMEM symbol is you can check your
> > > config to find out why your CXL PMEM is not working. Otherwise,
> > > IS_REACHABLE() hides this subtelty.
> >
> > Can we fix this with something like the following?
>
> BTW, this is queued now:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?h=3Df=
ixes&id=3D93d0fcdddc9e

Aha, missed this one. Thanks for the information.

Song
