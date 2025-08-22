Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437841E1DE9;
	Fri, 22 Aug 2025 01:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827707; cv=none; b=I8RoYGa9hL5DacY5wOBRlVwWSXpSW1jdE5ZOFhZLL0/30uVtWHb9hvHHPgsXIZbc0zMbrDAyLmq1VpLh3feYB4F16CbnfP76WqCkO2wgzbxp/V1BS4xAUJOk3mmMGo1BFPO5M8olF4yTxvPXNWdpViUTjwib4wNxl9W+QAP5iXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827707; c=relaxed/simple;
	bh=U/uRSC5EGWcyMQzBbgILNWMp+WFzjumqMb7BuIlxvwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWbjaD8RZxdqmxiP65kxLA787QN/HWQAmN+B9+sFIxsgnF+m9wc7iDyfPCrpHKb/YEwkITNr0YXhzJ7mx7dOWapqR+yMwbk8LslW1bRcmvV2DzSdx5EtXWzBSMkxEh9DnK56xSNcPbPH4v309dI9fSz3hn0CNKNvh0GU5NmZeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd73yZhr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd73yZhr"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2eb09041so1572024b3a.3;
        Thu, 21 Aug 2025 18:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755827705; x=1756432505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9VlbTxozbSzQO9ARnT0FclUjFleOp0pjebJJyPSVXg0=;
        b=Qd73yZhrTYz/osjtunJcS94ITqMf4YSIvB7lxZoQ00PU8YEXYeSxz4p0LG7PJK38MZ
         Deocn+Bqyq3QuEPCaEPjZ26QydGSYhGirFWOKY7iwCDcl0bU59WBWxeYiQhx+NoAmEzL
         CGiPjJoHZnOTIc5MZYwf1m7YwvoXP2gRBEkegO0BD1+KC/Rb518uz13WrUR7V4gVG+rA
         q7LrFyKmXhVVJ+MdrBjgCQQwo32VAYqx4W2ArzLmmWLR9SiyhcDM7npkb0rR8dU4n/Ys
         kbibc5AAsYGtfpTcrBHlSomsVhNCTO1FO4FUA1YdnFXbZtfisMfobTic5AL+cHe6MItk
         Tc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755827705; x=1756432505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VlbTxozbSzQO9ARnT0FclUjFleOp0pjebJJyPSVXg0=;
        b=A+QWkdN1I5NNA816JDKu35/zoqDVnceLv4BpqLAups9UNr85ifRsCztSFgGmn1JiDF
         6nUrq4AZie8zsmqpYd+VLIb6FIl6sqS0RHKG/XpQyga4e78BvdfHXs5slFmQschUc37F
         z0BwGV+o1gY9dlmgQNRi2+GmdCoXusK+9PcSvtKOksejIpORUxNWyoumROGy0u25o5I0
         IkpeSk/9JKfPMLAP6d1xDDblbAcVS3B55YahG+knSrcp9N2pAMPiVBSgLE7bJDygBP2I
         rvFCR3QLIrhnheyyVDe4rKK2/Nq4TG4miQ9VzW91k8486sHHVSTCLVpw6HMqsq3R8Dz1
         TPKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsD61jVOnJn6wOwjuQLJKODpMnJ9gG5d2eymEb/FdacJUnr99J/JAqCSp61u24inj+wfuwFW8jtjg=@vger.kernel.org, AJvYcCW8TTYJcJ8/wNsIQVxvb6ChBsHDusMd/ONQoK0wIsb96cqectf1Miu8a5Z70+n9Vl5tCkVMs9ZFAu3/r/xq@vger.kernel.org, AJvYcCWcDeIF50OdvIUWtk4B15y2By5R3jifjSuS+V3kNJenijLjiochzkX5HBM9qB84K+sspm5WbvRGgZMI@vger.kernel.org
X-Gm-Message-State: AOJu0YwOk+4xA4fc6k4Sg+ivnqyGL1svwyu9vgCcu+MMjuej0CwxIQjO
	yd8NNtF8C4jqrdQveLxm+EIXB1a51T2UMhIgmwwdKfZgegOvuStgRWSJ
X-Gm-Gg: ASbGnctytO48R2vaGS0apEMXBQWpxdqiaBBhcEE8IeXfCHSRQizUrgRP90m3QXjfLb+
	8oIyhNsmGq9gfeXWOI3UxSraNMAuFo3qhnuQxH8zFu0hjIZpEWQxWHqUvgz2LRMQ9byHabV3Oqq
	G4TE0MZyMc5D7wBaFEbBr5NHqlomUCcWCjyRuTThJ1qJScN+fBPbTvEE0Ecu2KHN4hgP07PGmLq
	eREh8N7l91ek17s+uJ+tw8/rxu1XTAz4e1wQfdJKdq0apBGeqTJ3zXF4abor/EwoYBduLo/9KnG
	pmac09t80BR4rbq6Y2HkuzDYyAjdtbQrYy8r4oe2kZup4KgXbeqmvqVGuz/ZPLhS2dzzq8KzqqA
	vCxGAziqBNVx5qjrRqK7zvQMFdqf+LQVt
X-Google-Smtp-Source: AGHT+IFtii/rdTCol8k9qDHs+gJGJCS+hHZTdi6/kZwNVS5GBodQwNFmbhwjQpzrd1QHNB6kcahQTg==
X-Received: by 2002:a05:6a00:3923:b0:76e:99fc:dde7 with SMTP id d2e1a72fcca58-7702fad0ee9mr1541193b3a.22.1755827705341;
        Thu, 21 Aug 2025 18:55:05 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e830d3558sm8693894b3a.75.2025.08.21.18.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 18:55:04 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8A737420B4E3; Fri, 22 Aug 2025 08:55:01 +0700 (WIB)
Date: Fri, 22 Aug 2025 08:55:01 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v4] cxl: docs/driver-api/conventions resolve conflicts
 between CFMWS, LMH, Decoders
Message-ID: <aKfN9d-REhpr2o7w@archie.me>
References: <20250820150655.1170975-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WDtJnK6kwVDtJAI2"
Content-Disposition: inline
In-Reply-To: <20250820150655.1170975-1-fabio.m.de.francesco@linux.intel.com>


--WDtJnK6kwVDtJAI2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 05:06:39PM +0200, Fabio M. De Francesco wrote:
> +Creator/Contributors
> +--------------------
> +
> +Fabio M. De Francesco, Intel
> +Dan J. Williams, Intel
> +Mahesh Natu, Intel

Maybe bullet list?

> +E.g, a real x86 platform with two CFMWS, 384 GB total memory, and LMH
> +starting at 2 GB:
> +
> +Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size |=
 Ways | Granularity
> +  0    |   0 GB     |     2 GB   |      0 GB        |       3 GB       |=
  12  |    256
> +  1    |   4 GB     |   380 GB   |      0 GB        |     380 GB       |=
  12  |    256
> +

I see CFMWS table above as normal paragraph instead in htmldocs output.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--WDtJnK6kwVDtJAI2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaKfN8QAKCRD2uYlJVVFO
o3BDAP9jy+wb3kJL+5zEr4wPjs2/Wf/kgEyZpO1tIEJkMmr/YwD+OYvZgfDj3lGc
nWpYZFfxjxMYkawIEOqjLuIax8bAPQo=
=gyqi
-----END PGP SIGNATURE-----

--WDtJnK6kwVDtJAI2--
