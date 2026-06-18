Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBBC272E56;
	Thu, 18 Jun 2026 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801334; cv=none; b=kTtQDkHQJDrDOYKMynR+Vh0D+kBvc+K2ZJDtV6MbZ+Kg1xxAR4sAQCfuYJ1lJO+dPDolAKcCFIn8Bvb/wOVXuOmZolVsPBB2x9/UUwcXqgpOwNbt8KTPBocLKCZSgK3EkmLgGN+Ag4UpehsaTkNXQ1talTx8FOj8tzEue6Q2+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801334; c=relaxed/simple;
	bh=HxLrSWagyGYk3m7sWpoxbRSCOquF2+62Z+gU3t0twW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+k3MkRp2X2ihDybfGS7abblM0veSpehAUlNK3UHVGtAKT98iurjI0Ww2zman/NpweG8962WJ6KCMzxXzgn7YRHamaOh1UVsKfLqJGH0wE4ds73z6D5Od2/nv57aicZOV5jPKWnrzYeovYxpi+GQGH1uyEDNSwBMITJescGNYPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WvpC4NyW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WvpC4NyW"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5B10E40E0287;
	Thu, 18 Jun 2026 16:48:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id coyelGpZHU7H; Thu, 18 Jun 2026 16:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1781801319; bh=oGfYFsvAo+NWcbAFBVJcOqhaqOszWCp/L3SV/OjgWik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WvpC4NyWdV/wtfO8o12UcVMpDYCX7tXm0yiJHEVW3lwg0UlRupDLSy4H3YYNXtB3P
	 0ZbZ7T/ZXotmxZRxm5eBFrgOHMC3yGodfT9f3qRpz5ShI3opcrXhgH8sErqYgp9RD6
	 hdF5HSF/T2Bmbg6YvV5ESrDYaGfuNKRflT2WCVM2r/XQ7pi37jAPVcqyRzJYHKUF/T
	 Z++3M3Uw4Bai9GMOkFFeZU2wV4z/L9cms0C5YnGmh2DojWSfoHa8EDAN0QFyENOWUf
	 kjO4AbpLYwrtTm7oRfCnLGZ31TSRf41v6MINLmn7vS6uhPX/n3CfIo0NmiI40hlhiW
	 Au3+OAS+n46/I3oYA3QJsdcQKohw6eFiaH20y5oKVrA3BYQgQrVkA6VdGfN5Oy4rAO
	 qi29Jzkv6LsC7bnvav8F1EgZ88f6QvOI053hUWPKmYfDrFuB31b3tqGLIw1kqNxEqs
	 198LbEbA5BM1iWztMACwkKcGl4UEhGawKkJkgEBBGFRsRTU+EUvS7ESSPANZRmH+dx
	 ZoGl0X82e81wH+tx+hJovTl6AJPsOAUEOTAZiR0z24Zofy7Z+r0nVAbX4CCCvw7G9H
	 lK2JKoOS3D1o80/Rhn/LYjPljpQ3vn1eKUNIA72SpfgqROzEfYLRbuPixg0BqnyPFM
	 EyMv/9MYCEOxOMmF9syUAK2E=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 37DF640E01D8;
	Thu, 18 Jun 2026 16:48:10 +0000 (UTC)
Date: Thu, 18 Jun 2026 09:48:07 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org,
	devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
Subject: Re: [PATCH v6 00/10] ACPI: APEI: share GHES CPER helpers and add DT
 FFH provider
Message-ID: <20260618164807.GAajQhR9J_00j4LxaC@fat_crate.local>
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>

On Wed, Jun 17, 2026 at 02:54:38PM +0100, Ahmed Tiba wrote:
> This is v6 of the GHES refactor series. Compared to v5, it addresses
> the latest review comments and tightens the DT CPER provider and
> related helper wiring.

Sashiko has comments:

https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0%40arm.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
