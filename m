Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502A204F66
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738783120; cv=none; b=tjNovZyuQwaWcvcoLEaLJ+VxuW/TwrPcu/GBOhdIxp/aBzYHKD0l+kkku/d1/Z86Lv257pvwQU0k11TEB8CHhg5HMH/U5uhCDRTk5ot9VCBWkTe06WiMqEjpkH4AYIFtxi/vm5jORsgZQo9iCz7qxnp0wSTru2a0Oa31OsizztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738783120; c=relaxed/simple;
	bh=oPEtVOpN+aKW2p42nBcWfhpXpIMCi7MvBIh1JiLFbt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoM/otNMdVU/hi36qJknNdVQGuDzXUOlbVVrEQoIvSl56ElgXTnr0hCcnN1TUVWzvJMeQuMREW1kNLR9rSxNwa/Gxgg/wdUCjjLWnVajw0sG/0DKI2ElEfc914uBzsyHbOqydb+PyLVsz0dhukPerluy3jn4e67AcxINh5D5YIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RTFeBvmd; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RTFeBvmd"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e1a41935c3so1672686d6.3
        for <linux-cxl@vger.kernel.org>; Wed, 05 Feb 2025 11:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738783118; x=1739387918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E8qwzDwdGFn2CeBU5qdUptdR+RuNYBJ5DWAN8nwQPu8=;
        b=RTFeBvmdEvKDmcmddIsf0EYrX4rI2b9ARfkwsGGL6RpD5+flZoc0o7d5cFCf4y5B01
         XVvT+neQNDlcZONXdv1yRFVZ7SFXvPAMb7ll6PhYgIK3vY+vDF/WFaBOwdimn9lMPdKL
         mKBlcJksdNfB1sE9XLU+nFkFhf7FrjEoG5+ObnSXE/85e3RlRQZy6IhkmJwIm6z8zWWv
         iCEQ9an2xg4rXJvW72LKm18/LSxpQZ5Xl17YZ5V3/vaiqV0ZR7jCJ+Plw3K9NtmIZvGf
         UgB6aDmR3clMCMgwYFxGItQbwwk9wi3NakzVHtxJuyyi+zmKECf8Rntn/WoNTgaiVziD
         O+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738783118; x=1739387918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8qwzDwdGFn2CeBU5qdUptdR+RuNYBJ5DWAN8nwQPu8=;
        b=vSDs6BOLHqFbtZxcy0yK5lRQBYtgQr22U8hWRqiZpKQVXCD72JWHnHzf1Fl0IM4kCj
         X6x5kwr/6tpar7Vh1id/NhB++Bk1VifCMuQb0BNPbFZYBnIZOsDfUOFWpniP+oVQeClB
         TYyRE1n/FlLVF8QtrfqYeVLJkfR9S/i3MNejavZhKf/ujO7TpjWPy5eKMgr6YoaPnLFe
         a8pdiwufYSKX2QQWVk1076mgsrRIrXX3zBVQ3XBkIhL0XyOelyrgUeTc6Twgcqd2MTvS
         JCH3l0ErfMVEu8s4x6j6kchBrlNK6PsutInjm5Me9BzGkSgHXD+QlZzp5NCkLUfngJsq
         d4uA==
X-Forwarded-Encrypted: i=1; AJvYcCW8K4CaHb/cCaSBTqYh2DO5q8s+R35jmlxJukAuTdW743+RdVp36yzd+8jksxpfTHGOdQLEyxHEZvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX4YTbQyQ0vstW5/64vTx3aXo+U+46zYCb/Wrccy7A8r+Rq7xr
	ETJovyvwRw40iVlJlFIC7DVFPpVAsOEAxpUWkR74qX5GaC2UcQloXtg8SKLNtlM=
X-Gm-Gg: ASbGncvb3ZacBPAzaXcdUNH0koa1TfK+KYp1M7lqv6jiR0bVSZBV6QX0ljjB5vk2Lm1
	7h6Kw7UwEw2nzKAxgKXS2aRetqYj9ixzQ2RK8LdTDAymBhtURZhwg04g61pBIA5U9iWV8mBQJVE
	CavpXP9nnhkJpID6ftqxLYlagcFzNNtaUyV1/oL9/Tl3g0+Um9giTHzxrqbmHTYZ3Qpe3d0ClT7
	9e8ynRjrVXcc3OdrAd1mMTgQ1aH4GZOV9HFeOXk3DSvnNtG8qEWkglim1pRnoJTl2geJ8Gxj/dI
	C35cU4thdwQdEnDboyTK5vcaJ+2Cyp24ZXokm3gTx5vjBPk4abarMHmNfk2yT8OZgvgkw+wpYw=
	=
X-Google-Smtp-Source: AGHT+IFBZGVDEyC791dt6sAmkuAb3iqn/vqzDlTFUXbWrByVqgD+IDHPq9lEi6GiDD3ACBsbSTEaKw==
X-Received: by 2002:a05:6214:e4e:b0:6d8:821d:736e with SMTP id 6a1803df08f44-6e42fc4fc9cmr64862866d6.36.1738783117509;
        Wed, 05 Feb 2025 11:18:37 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2548141aasm77300476d6.28.2025.02.05.11.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:18:37 -0800 (PST)
Date: Wed, 5 Feb 2025 14:18:35 -0500
From: Gregory Price <gourry@gourry.net>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v6 3/6] efi/cper, cxl: Remove cper_cxl.h
Message-ID: <Z6O5i1ic8lCgKN9z@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-4-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-4-Smita.KoralahalliChannabasappa@amd.com>

On Thu, Jan 23, 2025 at 08:44:18AM +0000, Smita Koralahalli wrote:
> Move the declaration of cxl_cper_print_prot_err() to include/linux/cper.h
> to avoid maintaining a separate header file just for this function
> declaration. Remove drivers/firmware/efi/cper_cxl.h as its contents have
> been reorganized.
> 
> No functional changes.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
