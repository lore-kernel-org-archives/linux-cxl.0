Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10BD33F5B3;
	Fri,  3 Apr 2026 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775217421; cv=none; b=q+J6M1RRt4wMCJn3BrleQG7uFMIBOmYH2GUknNqQWE70R4MyN+VvOM8hrn5MLiKEh9gRcI+nJyvYKn21ppBvlxSGAMWAkLVnxnYJ3le4yokU7NeEkZYgYaXLYmTrVsoGLQjjIxNlb4aLN191f0NBjMvVQOI7zgV6PxVQI/gMpeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775217421; c=relaxed/simple;
	bh=hlI1RBQqJjfpWuFZsCc6c4R0ASQxP62EyBGuIa0hpOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT1YRfme64lpzVplDtYDbJYUCqJbpcxUyyOg8GuTRIUHOOd9r7aZYnlaCTxEc+0jfIX/wlam2OOm4/updRax2fwSLTwDcZFxbhUYa52O1uikGUg6dRELsDln9MXkuqXcmDEEN0iCJXdigVlrcyf5gedfZeifP+PckN7Z6o/WPOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WExiF/lE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WExiF/lE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F48C4CEF7;
	Fri,  3 Apr 2026 11:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775217421;
	bh=hlI1RBQqJjfpWuFZsCc6c4R0ASQxP62EyBGuIa0hpOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WExiF/lER3/HxYWRZ7/VYGGhEbpEpz9xoEPNjcsCFvTGNpufubq1/grWFEw4iuMUy
	 OoXV5ZN9cvTpw+MrimzFf6s9HmUgEebMHP6rxEPoVqpOak+AAKYreCCI+aI8f5Gcf8
	 zd3TXBgf41BbeUDYgDIMBFsxjCPG+plKws+G4eTYF97BpuDvffRy9f5yT7XQBVGQbe
	 XqHjaEsIVjnSBX+EIpGZbUC6lXfkWCjygMqGuZgL2M9uFpPhtTcBQ2hiVkdvbT8xp0
	 yn+PYHPMRpNNVo0RArrBjXz2Wp47lKN2V/BGSRUsMLv3YU6gYJZRfQsOsmZPjmN+O6
	 y2sPDI66WCWpQ==
Date: Fri, 3 Apr 2026 12:56:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>, Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>, ardb@kernel.org,
	catalin.marinas@arm.com, chleroy@kernel.org, david@kernel.org,
	driver-core@lists.linux.dev, kees@kernel.org, kevin.brodsky@arm.com,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, maz@kernel.org,
	miko.lenczewski@arm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	osalvador@suse.de, oupton@kernel.org, peterz@infradead.org,
	tglx@kernel.org, will@kernel.org, yangyicong@hisilicon.com,
	yeoreum.yun@arm.com
Subject: Re: [PATCH v3 9/9] driver core: Replace dev->offline +
 ->offline_disabled with DEV_FLAGs
Message-ID: <57452867-60be-4292-9bc5-4e2faf1f3cb4@sirena.org.uk>
References: <20260403005005.30424-1-dianders@chromium.org>
 <20260402174925.v3.9.I897d478b4a9361d79cd5073207c1062fd4d0d0e4@changeid>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AVRN0JUTTuR+6v5a"
Content-Disposition: inline
In-Reply-To: <20260402174925.v3.9.I897d478b4a9361d79cd5073207c1062fd4d0d0e4@changeid>
X-Cookie: The Korean War must have been fun.


--AVRN0JUTTuR+6v5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 02, 2026 at 05:49:55PM -0700, Douglas Anderson wrote:
> In C, bitfields are not necessarily safe to modify from multiple
> threads without locking. Switch "offline" and "offline_disabled" over
> to the "flags" field so modifications are safe.

Acked-by: Mark Brown <broonie@kernel.org>

--AVRN0JUTTuR+6v5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnPqwIACgkQJNaLcl1U
h9DTzAf+NmJvooER0KUGxju0cXbQLPzjhe+zmzezOQJa1zXjXfgBycnhieaqK7ny
S+ZKb3sGXOFz1uf62w0rkTigz6ZBhVej2811kP/v6hOK59NgZZTJQfO8dQuSxEnT
a/yLND6ngy2gm9svEKalKOxPy9JbUJjkq+j/fHmoGQtgZJzi3MQgf8Dj9JD9Hi9K
CfKa+1VEAm39ijM8hfGOPXIHopw7PmdFfwGHkxLjmh4CRnWEhvWLFCPR+FiBQ0Sn
XrkEJ4xDFRK5m2nxMzIK4mnPEH5oNBFredP+/WQ/ak8W69Tqy7XcVG1E5yZLgzci
4Y9/xe7D3PUt6PvteNaqZANk/e1zpA==
=qXM/
-----END PGP SIGNATURE-----

--AVRN0JUTTuR+6v5a--
