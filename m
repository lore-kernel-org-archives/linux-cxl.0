Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E237A4B9
	for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783894890; cv=none; b=iXhqNb5Iq7tGvXA88dIasXVz6jYnvkXCgHz5sAXc2D0tmbiftakWID8Arm+ACYbrGzriM1EndxcIteU2y410F5LR9DALMyQ4R3jwadfv7BO0uHfutTwHJt79O3tTxTRBGrLRwCnUHSgnPuuSaK9Tp3tkx2thGYrMZFUl4dbVBEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783894890; c=relaxed/simple;
	bh=yXFkHL5kLy0YmcSeIBWJ/pJv7FWST/0rD1sn/vpnnlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+c/fnzh2OhYubO5jDISMNt/almudaFcm+0oIo4octF6lEZS2uL2Z8cU1VJeJkmOnpvdoMdhDZaRsORVOgVKKsWPJimJJ91JUu3V2AvtpXNQGSowzjgF7XOxRiJHMAPoYuLRN1X36YOkdBUY6QVpV7gzXCB3yvbbAAvR26FOseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=es9ZEdAx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="es9ZEdAx"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso19569945e9.0
        for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783894887; x=1784499687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yXFkHL5kLy0YmcSeIBWJ/pJv7FWST/0rD1sn/vpnnlo=;
        b=es9ZEdAxIcbFw1bX0rbFbs/J+Hem6iEGnVb3ZzpzC6RcVxDjUV+idFAKIpsFC46Bym
         A/NJGC+TpeGR9uTk1yl0cZhka+XaPP+4x/WdCcJiokP/wRe4i2mas4FhcRYPtdH8QVJs
         V7GDZ0OS1F8cBp81RmUxJEsc6UpLwZQSLvhpd8E6dy5KxXeOLZdyAJolQRvZNyEKSW1w
         RUbJsV7SWWKR71oOuu7yIRX91gqaRGW3imRr91cViZbhhGPRcJgN1gZRoli/a8HMzAwq
         AeDHppeB6kJ4VXUsBKiopTipGR5RjYeWx6PPQPAXjR4DpMD4kr80exOPMvKiY3ehJRdP
         Y6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783894887; x=1784499687;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yXFkHL5kLy0YmcSeIBWJ/pJv7FWST/0rD1sn/vpnnlo=;
        b=egatxFdD2BvbeMwH48M6ilZiBbXabe7anbkrT04eG/5cKIMaTmpirf1WupModGSS19
         cmIHOs2Jhej9DGPAvApV8i3hg/WYPIDaUWUiTFpKcOi3NUfI0D6z2iNH9wxflBsPRbfj
         20IrLdQfNsRxoFBm2CPeh6QLOcMY1HfV5f7Q/DROxLtVf7wkLyIKedv+dE8KwamDXdJ0
         RLr+4hyhSxDHZ0L53pKZvd7NOmSDWx8xzcxjhQ4OavdwtEnS2/diBw1lOY9c7Nn4/IcS
         9Xi4djK9eitw47DE4wyOv/0nH8ecv0uIYqeMnY7eATzKoIjNE0lkREWjhFAaInsZJtrx
         8DDQ==
X-Forwarded-Encrypted: i=1; AHgh+RqU8iORREwK5rBM3Z439fU0jTNrnHg+hTTD9W87T5XjuSYPVB1tP+m9tBvGZzRwJqYgwr9a/rd8GFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTwZpbLyHLPT2Et7femDugzlE9xzSET9uKZoXDPfhg1KPF2Zvp
	M7pReupfnNNjueYS7v0wl8Z7RnXFG5uTornHLm1yP1XPoQy5PJoeixF0cL8IGfAz3iyEklkmomM
	6z54W
X-Gm-Gg: AfdE7cmnrTVT7lxpVJTM9wQiWgAjUMwIpoYP1oKgAPqkur67CAYj/L2wgNWWRPIfMzP
	nv90XTHWU9Lgogyr5Q/44J59GSruwCyXIixobIypCMJKxYn+eiaa8DML0VXHuIkdy7M/JHTSrv+
	nAjyoIHzCZMJ/J3RkXXGEA5SLqiMXEHZp76o1dwZwUhZK/o1qPKMcydKUje93zO9FWfnjThlT5H
	4LrF47Js0CHa6OhNIN35JUl5oUEWzr+RfCbCESV1mEhPB/56wOML9X8/M53Vr3pKuGmKY7k60Jv
	yRPMWWN51vF6uEG6CI4jhIxA25Nsd7SvXgN0C3kaX86JcwQbcLFnfTnhntqyRGl/Q3BrKWZ8sHS
	OuNLvjgiRQ7bSf2MKTs78IxaxN9ZPsga5gErhONrSbQV6q3MzntS84U6CiDvitdVUQTrwmZxqZQ
	FzfMxaD95QwE3F848fVA==
X-Received: by 2002:a05:600c:3543:b0:493:f6c1:2f09 with SMTP id 5b1f17b1804b1-493f87dc753mr64927015e9.6.1783894886966;
        Sun, 12 Jul 2026 15:21:26 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493eb742a49sm296924145e9.12.2026.07.12.15.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:21:26 -0700 (PDT)
Date: Mon, 13 Jul 2026 00:21:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
	Saket Dumbre <saket.dumbre@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, 
	Dmitry.Lamerov@arm.com
Subject: Re: [PATCH v7 10/10] RAS: add firmware-first CPER provider
Message-ID: <alQTUuwze5ZjGabk@monoceros>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
 <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-10-8b3a85216cef@arm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o63zw6szpf3k5nqs"
Content-Disposition: inline
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-10-8b3a85216cef@arm.com>


--o63zw6szpf3k5nqs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 10/10] RAS: add firmware-first CPER provider
MIME-Version: 1.0

Hello Ahmed,

On Wed, Jul 08, 2026 at 02:59:09PM +0100, Ahmed Tiba wrote:
> +#include <linux/mod_devicetable.h>

Please don't add new users for this header file. Only use those
<linux/device-id/*.h> that you actually need (if any).

Thanks
Uwe

--o63zw6szpf3k5nqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpUE2IACgkQj4D7WH0S
/k5Aagf+IcCM3MbiQFXq44EFdGthF9zwEU47GU8P9/gSXah2GXOz59WKWZqRlJgo
j4mZ9uRbJqwLqZ7OtPIZj1IyEY9Bmeix2uL7sJuVUBcZ2qRaX3OxW/xi8zEaH0fi
1DgPWPB5MHOhvc5d5JJAeoqaV3TCXNxNEF8uvyiaGJWFIr7oGvWZVJCPTmjbqVt8
vzyFYzCac+qNGAzM6F6FhjNsegEgpsSAP2XIIruYv2+iPpHWzMbx+LpknKOq8Rws
N/Cmj3SBH5ULfApKqkL4QqeHk6RnfAclAjr/EdYS7nE6L5Bdot9DOOil56IDxCps
pX4u0VGI9OqUoeIeIDXaS9GJsG261A==
=Eag/
-----END PGP SIGNATURE-----

--o63zw6szpf3k5nqs--
