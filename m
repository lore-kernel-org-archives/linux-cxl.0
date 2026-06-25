Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2EB38238C
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380763; cv=none; b=Ks/mbzaUlaK1Oi5T/SyoyKLn+7YsT6U+pWpmbuWGGxg7qr3qd4q2o47fcdMAwam7LrSHwDkP+8bq1eUb4CGaZyVlhc2WDE7IN7rgG5q5zgW4RmlrFWzB0DK64Qc5y5VWbJdQhqhLEVJU5rig7Auq6w+OU76zlKLTBx7INwWauTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380763; c=relaxed/simple;
	bh=OJ/PnaEyjyVbY9XQs6ALn37ANfLXNuxFXJ+gVpRs0TU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eGs1r6rxWYbbQxSrattdhDPxDu5HcYHumIVJIVGZ6huqprgoA/zOKkjXC9+n4+H17p1IAjbJ9pXsUjEFZmfq4Bsh2l9El/FZmXIUdkp9DpgEVZANvZvoTcuk+x3bYK+H9+j3UOl82kpFEmAT3t2oOzn2Wk/7HHEMgIJr/MrEdwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guKGZc8f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guKGZc8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB0E1F00A3A;
	Thu, 25 Jun 2026 09:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782380762;
	bh=U8CrpJY2S9sbuzUE8/HPlHjt/6Q1iHg8TU7PphEOiO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=guKGZc8fZ9HmcABVhRDxzgmlFnz0cHvc0Gsj2tKAvurO0bG1lRJsHQ3klhX1ovPSH
	 oVetNDZNQYQ2PikRoIwbOVMv11OL4lftwHeYWin+5RU3CQROW2iAim6UXbIS3lswnw
	 +K/Rdp4RPd5u/WcgQQj8JWnlkwiajtreLB7/ux/DkILKNOhTbjfO+6n4EU7kZnOmH+
	 KztyTMjAnqb2UQXwxCjBJkFFAJjmJUXifxaXLKvrYtpETge76jFY3WNSYhCBlYcDXK
	 6NjNQvI60LoiDK6H/QiCebvkcxv3lhTWqy2fo++gNy2n2jDSO1kEQ9beQkdwh2h0AR
	 DqS6adZnW/ejA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] tools/testing/cxl: Enable zero sized decoders
 under hb0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260625092857.41139-3-icheng@nvidia.com>
References: <20260625092857.41139-1-icheng@nvidia.com>
 <20260625092857.41139-3-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 09:46:01 +0000
Message-Id: <20260625094602.8DB0E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect HPA base for zero-sized mock decoders causes them to o=
verlap the start of decoder[0].
--

commit e4836660bfdfee0da74cc6f18fe1e3c9826c4c04
Author: Richard Cheng <icheng@nvidia.com>

tools/testing/cxl: Enable zero sized decoders under hb0

This commit introduces a mock_zero_size_decoders module parameter to cxl_te=
st.
It is intended to exercise zero-size DPA reservations by mocking committed,
empty decoders above the auto-region under host-bridge0.

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 418669927fb00..117691b3c62f5 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
[ ... ]
> @@ -1145,6 +1178,20 @@ static bool mock_init_hdm_decoder(struct cxl_decod=
er *cxld)
>  	base =3D window->base_hpa;
>  	if (extended_linear_cache)
>  		base +=3D mock_auto_region_size;
> +
> +	/*
> +	 * With mock_zero_size_decoders, decoders 1 and 2 of the special
> +	 * endpoints mock committed, locked, empty decoders above the
> +	 * decoder[0] auto-region (CXL r4.0 8.2.4.20.12). commit_end then
> +	 * points at a zero-size decoder, exercising the zero-size
> +	 * reservation and poison-by-endpoint code paths.
> +	 */
> +	if (cxld->id =3D=3D 1 || cxld->id =3D=3D 2) {
> +		size_zero_mock_decoder_ep(cxld, base);

[Severity: Medium]
Since the comment indicates these decoders are mocked above the decoder[0]
auto-region, should base + mock_auto_region_size be passed here instead
of base?

Passing base appears to set the zero-sized decoder's HPA to the start of the
region, causing it to overlap with decoder[0].

> +		port->commit_end =3D cxld->id;
> +		WARN_ON_ONCE(!cxld_registry_new(cxld));
> +		return false;
> +	}
[ ... ]
> @@ -1214,6 +1263,26 @@ static bool mock_init_hdm_decoder(struct cxl_decod=
er *cxld)
> =20
>  		cxld_registry_update(cxld);
>  		put_device(dev);
> +
> +		if (!mock_zero_size_decoders)
> +			continue;
> +
> +		/*
> +		 * Mirror the endpoint: commit the next two switch decoders
> +		 * as zero-size + locked so the empty-decoder layout extends
> +		 * end-to-end through the switch and host bridge.
> +		 */
> +		for (id =3D 1; id <=3D 2; id++) {
> +			dev =3D device_find_child(&iter->dev, &id,
> +						match_decoder_by_index);
> +			if (WARN_ON(!dev))
> +				continue;
> +			cxld =3D to_cxl_decoder(dev);
> +			size_zero_mock_decoder_sw(cxld, base, i);

[Severity: Medium]
Similarly, does this incorrectly place the switch zero-sized mock decoders
at the start of decoder[0]'s HPA range instead of above it?

> +			iter->commit_end =3D id;
> +			cxld_registry_update(cxld);
> +			put_device(dev);
> +		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625092857.4113=
9-1-icheng@nvidia.com?part=3D2
