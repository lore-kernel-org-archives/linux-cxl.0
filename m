Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBD217F27
	for <linux-cxl@vger.kernel.org>; Wed, 17 Jun 2026 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706269; cv=none; b=nKijNewurwBYNEcEDGIAh8mLAC9WCJ7UBt9dPAjdi/up44WjrgRE7dagFIP8TW9DKmBm6zu32/WBIHUM2p0yDZbtq3mj5AdyMxsaEkTivxDRkbA3yp/3qMjJWnMiFLsxC87RGVtuCEP8UdTbHI76VqmwgW3aSr5tSySDepwF6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706269; c=relaxed/simple;
	bh=9FUKbmQ+PChBSVaaxCqei51y0yiEuSK2alJ0UJHfWUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqf4mn1HsCcRvmbuzTvvhotS9d7eIh5sZUU7ErkvXWa/3LWrmoPfD8tsTZLARj06FjOvy5HP2gIKV3pnYrpRP4BXFu7FYHW06yqJ0ZAj7d9ySUjb1hmOjgCHPJL7QLq/EU+9jnJYbfZIpphWUX5EyjS4nM3h0I3l8Mq5Q45Joto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=i8awV3fr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="i8awV3fr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so61562085e9.2
        for <linux-cxl@vger.kernel.org>; Wed, 17 Jun 2026 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781706266; x=1782311066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ2dIgGYiEosps8TepSobN48VXcZUJj8FKtvRmZVRa0=;
        b=i8awV3frh+CV+n4or4FRiY5A0PxkdKNj07TRRxAzoyOiydjXVQXaOgMuR5u2qB13r0
         1qsEDE2ZtqNrDTmqbkGD934KxSu2yZupe8fUWFckrbjdOz171v1BvPsxGPWdACsdt40d
         21Fb8yGF1XvjSVil6JvI8GqNqHoRIoJ3kJctVGGqL+1fG5m9+Zjcv4kCYVKcBx5jQ9xo
         9jM9umA5v78P5PxdAMUfQDFDNdc1DGY3GREbiAHuAOe+GPjekqpViW/ZSJGbtXTL9m3b
         p3BdeAs2efSAgEtpkUDA7BLB5vbF4giV+dQGLWAdLdMla7NnJwIdpgqKGJ4ao5zvB1uo
         9qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781706266; x=1782311066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ2dIgGYiEosps8TepSobN48VXcZUJj8FKtvRmZVRa0=;
        b=cIuQ1JZ/S+E+7PtORdCjNE5KprrySQzpUBoOirl36KzwgIDQMEaKcbYNKIUXjpXw2y
         EfU/Mae7RFTSPAhNkDQG/c6xEjHIitSwR0Xg1nv4EW0EC4sY2OC+yMzbBMCEr0Dy0pBY
         gogc+vGuwrpJriyA1EkfQbadESW8QegUnjFc1mleHdkoYMJNM3aqxgV9qEJRWwn0YQ/k
         Jg8syO1WF2yf80C0TXYlFXurWww+GPO1FI2Uy8OSaKhXhKyGT0oByOymNNX+hQ0R0Nos
         skiAL2iVFb3K5U3OYB+6spML7QuJsxn3Wbu+taHC6SHF1lxrNNFWremwiudo9JM9QlkJ
         rU/g==
X-Gm-Message-State: AOJu0YxIpJ4hJsAkjrB23w8nnaquyBUrhaYoTwmtUQnqQI8nd/cttFy2
	sbqDYYnYWAlVGooF7WrOw4m4SYPJwNZusWXLPgt+kLOHwXg5bdWRkUjIB5WNLXISYcY=
X-Gm-Gg: Acq92OFjnmaSHn+StNvsPDDWB3x9/vEfWZTNNHVr47jXccBZplpWDJN4mFfyx2S/IYI
	TreJ5tHh+I/QHem69O8EZXxqV0GHHzd4cJ+Rozn8CAgdU6YQpO+XFTNDFSrjhq1WamTD24Xq1Sn
	jcbS9nfow8bioB7fRPtsGYOvCJ1buvACYkRW2EQYvdHvYnLKGGXuPfdCO43eIjAsJNunS+kYiAZ
	Rjo4lh7yNVvo6JF7llddAnq6XnRSLAYuKJNvJO/HNWrvha2Pm+gRt5GdUwm5/frfd8cNftS2bLw
	BV1C7tS1x1tcPvbMZPQ54Y+RZfzvRC1FiZBdNk4iSHkHK7exTdc0SHjDLOvsRuQtlAnpN7xcvlb
	zL8MQs+HmeQ5H+PpX1+1my1ghK5bWfMMi+AQRs/K7Jgji5losoOEoalGjR6rU+jql49ANHR8esR
	AXfDI+IW3PPbYi/Rj2cpbfzUiWmKZVCZCEKaAaZ2omFeRTF/2Gkui84unXRvjB4nGrOeL50Rncm
	cj9
X-Received: by 2002:a05:600c:608a:b0:490:b65f:8b1 with SMTP id 5b1f17b1804b1-492333ba1d1mr85648985e9.5.1781706265704;
        Wed, 17 Jun 2026 07:24:25 -0700 (PDT)
Received: from localhost (p200300f65f47db043b42891e8adbe9a5.dip0.t-ipconnect.de. [2003:f6:5f47:db04:3b42:891e:8adb:e9a5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4922fa510e7sm198929775e9.7.2026.06.17.07.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:24:25 -0700 (PDT)
Date: Wed, 17 Jun 2026 16:24:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, djbw@kernel.org, dave@stgolabs.net, 
	jic23@kernel.org, alison.schofield@intel.com, vishal.l.verma@intel.com
Subject: Re: [PATCH v5 6/6] cxl/test: Add cxl_test accelerator driver
Message-ID: <ajKt3db8vA_SEvSX@monoceros>
References: <20260611234409.256765-1-dave.jiang@intel.com>
 <20260611234409.256765-7-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pi2w6gsufoqmi53e"
Content-Disposition: inline
In-Reply-To: <20260611234409.256765-7-dave.jiang@intel.com>


--pi2w6gsufoqmi53e
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 6/6] cxl/test: Add cxl_test accelerator driver
MIME-Version: 1.0

Hello,

On Thu, Jun 11, 2026 at 04:44:09PM -0700, Dave Jiang wrote:
> +static const struct platform_device_id cxl_mock_accel_ids[] = {
> +	{ .name = "cxl_type2_accel", 0 },

Please drop the 0 here (and the comma before it).

> +	{ }
> +};

Best regards
Uwe

--pi2w6gsufoqmi53e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoyrhUACgkQj4D7WH0S
/k5vbggAkr3qUJzq+oCrMxtLxYIKM6aLJ09tvwdi0p8/WFOGE6YXpesnUHSNz5Ia
uYYDJ8BLzUd/by+rafG4wWPZ29iB1PB0T6MuZiOxAvK9Ie6mMjvubTiPh8qfERi2
rZlLPUT/rDoGuvlZoPZn8LsUwAlzECux9ghJXIkKZLMdi/yhSHAGqkWLi+6WbRm1
FzrdorDslHx5UmspMXcdq5DnpvWuLOF09KriSRa/g4vXXU/x5OHFiuXGfnMto2xk
cM8Bsh6znR1i4R6exRvRXqoi7Q1+fJW8jjxJGKyWfM9zX/aWlIEGaRCowQxDeVwg
2jHMGtRNonsaYyoOj9oTpP7eRD1+Lw==
=fA6j
-----END PGP SIGNATURE-----

--pi2w6gsufoqmi53e--
