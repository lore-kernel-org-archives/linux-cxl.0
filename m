Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DF41F5842;
	Wed, 22 Jul 2026 00:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678859; cv=none; b=TFhx+RXNungxNgMWxdQ6qmncy7RLSVJ1gsLiifrQgnBueAKasIHXyjMES/OtRKQPSfvo/JPzipUPE9+fAGY1xyVt2aJHf3BLTuFla9BWewmaOtc5qvmCppgqtEW+JYVbXgmbt0YXstP2RH+VVGWzgpaA2BCDeY80nwC1GBY25yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678859; c=relaxed/simple;
	bh=rc8ljG8dSIlqk+aIVEJqaImUZnf7Li885PYIOTVqgks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6+jPCtRnnv73riRuzAYt1eg09CqKO2dj58bBj1Xq2eXgWoTtQ64NFZXM8cVsTaDtkDSBrUsh55PtSbWUDBQ3enT+HlTyx9qnXlbLnaC2LIn0OhaP1L425RGsCML6uc2uTZHh+XlmLd3igjR41uZ/azIOYh9qlOqcEB4hpeJrf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYZqa9on; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYZqa9on"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44BA1F000E9;
	Wed, 22 Jul 2026 00:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784678858;
	bh=pAe5TcYHgmHD6jozIsXi+gmsvMZD6KYR7+ijGn883LE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fYZqa9on+cpDorDMyr7npnS4PcnZ1EWN6odyia9y8+8g12fJUFMbUilZsCJBCU8G3
	 mMfAHLbl0P8naXpsdfW1wHah+iQSQCyvQVdEViLXN8WnAXoIFePIs6OBrrVQ5aaj8S
	 VNMXJPqyOyEhUkHxMt4gNflyQmffWiVzBrDgSReBl5O0t5Q232bUeOGYPA9c8lvrTb
	 mYfJyAdFvodsh3F964XNo0liA04n/i+Vp3srW3cTNzqBdTbW95vCUbrAovz5cXosXT
	 F8mWFF22Wu4xjSNvGJtZnTEkGOfbNLdbt+Z487wt/+4vVVTpgWQk4W+6kbYbA7alap
	 /rkqMjvSo/kYQ==
Date: Wed, 22 Jul 2026 01:07:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, djbw@kernel.org, danwilliams@nvidia.com,
 iweiny@kernel.org, ming.li@zohomail.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH v7 0/2 RESEND] Support zero-sized HDM decoders
Message-ID: <20260722010731.053a6bef@jic23-huawei>
In-Reply-To: <20260721085715.39322-1-icheng@nvidia.com>
References: <20260721085715.39322-1-icheng@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jul 2026 16:57:13 +0800
Richard Cheng <icheng@nvidia.com> wrote:

Hi Richard,

RESEND series should always include a brief note at the top of the cover le=
tter
saying why. Otherwise it can get rather confusing for anyone seeing both.
I'd also always reply to original post (even it when to subset of people
or similar) just to call out you are resending and hopefully stop
the reviews getting split across the two postings.

If it was just that it had been a few weeks, don't resend for that.

Jonathan


> CXL r4.0 =C2=A78.2.4.20.12 ("Committing Decoder Programming") and
> =C2=A714.13.10 ("CXL HDM Decoder Zero Size Commit") permit committing an
> HDM decoder with size 0. Firmware may commit and lock such decoders so
> the OS cannot program regions through them; this is a platform design
> choice rather than a specification requirement.
>=20
> The kernel currently rejects these decoders with -ENXIO during port
> enumeration and aborts enumeration of the entire port. On affected
> systems, this prevents the CXL topology from appearing in userspace.
>=20
> This series enumerates empty committed decoders into the topology while
> keeping them out of region assembly.
>=20
> Patch 1 makes zero-size DPA reservations first-class. Since the resource
> tree cannot represent an empty range, an empty decoder is backed by a
> separately allocated resource. This keeps port->hdm_end, skip handling,
> and in-order DPA accounting consistent. Operations requiring non-empty
> capacity, including region attachment and poison queries, are guarded
> appropriately.
>=20
> Patch 2 adds the mock_zero_size_decoders cxl_test module parameter,
> disabled by default. When enabled, it installs committed, locked,
> zero-sized endpoint, switch, and host-bridge decoders under
> host-bridge0.
>=20
> Testing on arm64 covered enumeration of eight locked zero-sized
> decoders, DPA reservation and release after those decoders, ACPI
> unbind/rebind, module reload, poison handling, and rejection of
> incompatible cxl_test module-parameter combinations. The core patch was
> also previously validated on a Montage CXL Type 3 device.
>=20
> The corresponding ndctl test is attached at
> https://lore.kernel.org/linux-cxl/20260709022857.18732-1-icheng@nvidia.co=
m/
>=20
> Changelog:
>=20
> v6->v7:
> - Rebase onto cxl/for-7.3/cxl-type2-test.
> - Patch 1 is unchanged.
> - Adapt patch 2 to the refactored Type-2/Type-3 decoder initialization
>   paths.
> - Integrate mock_zero_size_decoders with special-topology parameter
>   validation and reject its incompatible use with fail_autoassemble.
>=20
> Richard Cheng (2):
>   cxl/hdm: Allow zero sized HDM decoders
>   tools/testing/cxl: Enable zero sized decoders under hb0
>=20
>  drivers/cxl/core/hdm.c       |  52 +++++++++++------
>  drivers/cxl/core/mbox.c      |   3 +
>  drivers/cxl/core/region.c    |  49 ++++++++++------
>  drivers/cxl/cxl.h            |  10 ++++
>  drivers/cxl/port.c           |   3 +
>  tools/testing/cxl/test/cxl.c | 109 ++++++++++++++++++++++++++++++-----
>  6 files changed, 177 insertions(+), 49 deletions(-)
>=20
>=20
> base-commit: 1c6b4ceafc3b994871c29340e0c1ddb0af5800e7

