Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DCF3E2746
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185912; cv=none; b=Cifa6NFKbv65o9S0RxeTPXfiP8PiIAEyG4vV7QwAa/NfE3zgw10c0M++fcDTorMv+3Cn/t+k5fO8Y7S2j8cSPMUpJEed5pfAHyc1FU6a+G51CJkF7DImmVbWGFA8DUzYDc8rgZdgal7I2Pl++HJdUN7akqxg2BihWbKu5CIFKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185912; c=relaxed/simple;
	bh=/hPcoAcsiVhSF8mrEzfE3mwf8auh2T/lnMnUVWo4CCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c1Ii3Mrz5XocKKlJx508sT2rNawUm066sXaOQj4WLcpAsQVzps/Ri6vgM9bTM8RDBdloLcwl7qhcb0oirTY8zX53KFmgPEhu1a+Vio66Fokgf62q1LvvglfNuRDE+kuZx1uievUWNCvhEarZtZUiomkyZBYyHMq5Jd/gT+by+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9rpB+Tx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9rpB+Tx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3091F000FF;
	Wed, 23 Sep 2026 17:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790185911;
	bh=1o6tw0acbULlvqOxN3I6IPqxcHgGY9Lb5A3/8i8JzIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z9rpB+Txw3K3pjJjSWwMpYVFvUEKI5KottzU6gxO4qOEc9tdjx4DTHIGbJ5dbP/X0
	 yV1pn0+UZ9PZqk/Dz54qqlgVfeM8V0xyNK+zpimwwxwjDxJ6lJDplE1hu7G3L3On7Z
	 zIBGlS4gMLxI5/rVzqL+3VxCrquz//HCXqtkwFh6VQLa6kJqlKhgJJ/Tca3M0p2X+y
	 3HFa/KshCYBoNDdLcUrSn0GCUQbszifLZJ6ipB0Wakouv9+fGxz7a5oMYwDl4KaqE9
	 TEdBrMLGIdDiiOy/cGW5cD717dqahF23eIx5j/JcTMw53J/8T2iGvY71YTymTHQPOf
	 EsMOuyBwWLRnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/15] cxl/core: Update devm_cxl_add_endpoint() for
 cxl_cachedevs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Cheatham" <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260923173342.5584-7-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
 <20260923173342.5584-7-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:51:50 +0000
Message-Id: <20260923175151.4E3091F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] cxl: implicit cast from void* to struct bypassing container_of in s=
chedule_detach
--

commit e4fe9279629e13947567c92e9190b5eeaa65a71a
Author: Ben Cheatham <Benjamin.Cheatham@amd.com>

cxl/core: Update devm_cxl_add_endpoint() for cxl_cachedevs

Update devm_cxl_add_endpoint() to allow for cxl_cachedevs as well as
cxl_memdevs. Add cxl_cachedevs to the port heirarchy.

> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 99cf77b6b6990..44d978d4205a2 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -26,9 +27,13 @@
>   * PCIe topology.
>   */
> =20
> -static void schedule_detach(void *cxlmd)
> +static void schedule_detach(void *ep_dev)
>  {
> -	schedule_cxl_memdev_detach(cxlmd);
> +	if (is_cxl_memdev(ep_dev))
> +		schedule_cxl_memdev_detach(ep_dev);
> +
> +	if (is_cxl_cachedev(ep_dev))
> +		schedule_cxl_cachedev_detach(ep_dev);

[Severity: Low]
In schedule_detach(), does this code implicitly cast the void pointer
representing a struct device directly to incompatible struct types?

Because ep_dev is a void pointer, passing it to schedule_cxl_memdev_detach()
and schedule_cxl_cachedev_detach() casts it to struct cxl_memdev * and
struct cxl_cachedev * without using the proper container_of() wrappers
like to_cxl_memdev() and to_cxl_cachedev().

While this works currently because struct device is the first member of the=
se
structures, could this regression cause memory corruption if the struct
layouts ever change?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923173342.5584=
-1-Benjamin.Cheatham@amd.com?part=3D6
