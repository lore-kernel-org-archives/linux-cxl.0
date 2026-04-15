Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477B324A06D;
	Wed, 15 Apr 2026 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262761; cv=none; b=U0EiHY3Sm5aYVin9Hn4wVW6nMb3We3qxILMgcBV2z8SFatGCQIXxdObqtlVESRYRwiJPEmEreMYO4pixaTq+W2KhSlKScbpRKn9C/PaiaNfM1JBbaCgkmAYEhMl54NYEwr7Z9Opb4w9t5PRp8Uqi1Uj78tC9DipGga9EsgN6gFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262761; c=relaxed/simple;
	bh=bLW34hLhcn+sA/4V1HQFx+N6MLu9s6DF+84xoTsNCz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXfhKPghPwcW31TzxK40tpCNxh80wktHH9nPjwNULcIdeJ/eCb0MDZfeQWcpktkMFsP1ZZ3oE55n1Ab2Md15y7H40HvIVdmL2yafZEBj72dIfXT27lhAnpUK4fY+4k/feN3LbnYRTmWUDz/UemG3YyWWRRdM4lRrLB/ycc2U9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUYrDVWv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUYrDVWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B862C2BCB3;
	Wed, 15 Apr 2026 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776262760;
	bh=bLW34hLhcn+sA/4V1HQFx+N6MLu9s6DF+84xoTsNCz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUYrDVWvS70T28iQWOK7bRpsBUUzV67afiMGw7tnTTYS9axykMG1GFce8AnW33yy1
	 AaYMw95W+p4xICcMKk3PaTq+j+hEBkd96v0hTEsEzVwlrsj9xU3/k3xw9yCtk7uO8G
	 AHH667iC82VS5TZzdEhe9GlzXb8cTkShTrCwKJOsQCz5dbnHB8Ur5L8C3HzQg+CndE
	 NfNz8Be2D3eG6zmoiXgeELz9/VUVaYeJTCFqpiQ0Fx6sfKSFaZ9rF1CihS/7QB6TEc
	 ozH+gCuSZu0UjRKL1F9FkfYLEgzMaB1q3jhZDDWFNMWUXtewX+CD8o+HCV8LaMsvzZ
	 hcRcaGpxGM5UA==
Date: Wed, 15 Apr 2026 15:19:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
	jic23@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, djbw@kernel.org,
	linux-cxl@vger.kernel.org, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, linuxarm@huawei.com
Subject: Re: [PATCH] MAINTAINERS: Update Jonathan Cameron's email address
Message-ID: <20260415-glandular-fraying-fe324d79c5be@spud>
References: <20260415124357.12539-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WqSaF2/nXOBPM/qn"
Content-Disposition: inline
In-Reply-To: <20260415124357.12539-1-Jonathan.Cameron@huawei.com>


--WqSaF2/nXOBPM/qn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 01:43:57PM +0100, Jonathan Cameron wrote:
> Update my email address for CXL, FWCTL and Cache subsystems to use my
> kernel.org account. Also update .mailmap.
>=20
> Separate patches will replace maintainers for HiSilicon specific hardware.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>=20
> Any merge route works for this, but given there are two CXL entries,
> perhaps that one is most obvious.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--WqSaF2/nXOBPM/qn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCad+eXgAKCRB4tDGHoIJi
0j9tAQD4EJ/DRm8PjKHjsMVCgYVqCmdoJdWKrS2RxJ1yL14MaQEA7QYDjgat4R9Q
g/p8K/hF+LzS1XYFjFINkWBDh1nZWgU=
=4ZVq
-----END PGP SIGNATURE-----

--WqSaF2/nXOBPM/qn--
