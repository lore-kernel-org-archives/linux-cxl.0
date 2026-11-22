Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795351180;
	b=zZlGI2HYomHnegHVoHppgH5ay2c7nPhKYIy1KoQDZGJZv2WmMpDVylu2Up1oERlIKA+2
	 rDAFCtY2oz8Qz2MIhhI6T9dX8wukgg4sw2lKd8DUENGjyXN8Vm6nxLeNUOgoCHpP6R4z3
	 e7GgIvsLJQbJtBCcEh6rCaOvyR2eGUxa9GAG0wz495b4P6TLWishoCMdukc9cChhnlciv
	 TvVtgYanqr7FmXUPCkGcowCZP9wvrB0QVpVCCynpsX9lH1xkcUu+2nEx9HOZGFk9s3LR7
	 XkydJu35Pwc9UsiUaxp6hnu1Yd+0k90rw5KnfzSy2Jcn7G/MDRSWVlPinYFCk5Aki3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795351180;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Tq68+KUWHs/0rKXbPMQCB54y8xzPuqCAq70zUpq+O9U=;
	b=Fwq8Gv5uNCOL/wPU6PeNPUSErZY6nN8tLP9xsvgZZm6f8KeLICEpMpDksX0hjx7gxyJ9
	 EYEi7aEq0+tPe9HquRy4+0FwgHd8pTqUJFr7jFv7XoYGddAS9mSpE0xLYU+XrnNvK0lb6
	 ZJpCiKFxS/go59LZcRNcqJSlvq4N0RAbZjrub6YlhcKMbIocLu2v5rri2QhDSXWx7rJ3K
	 OQAMqNbedNWGEPgfJl6FlGksDq75QdIHavRvR6lschU7PhukIk+vAhKmrMKjS/mT89Lq4
	 eOe0wnQm6u/EO6fFYBblnz7cS3w2+bNDhRVIBmlGQFaFvImCyu4/TQzMpB5E6W75tDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAUh2Tlv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C721B606A32A
	for <linux-cxl@vger.kernel.org>; Sun, 22 Nov 2026 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAUh2Tlv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5311F000C6;
	Sun, 22 Nov 2026 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795351180;
	bh=Tq68+KUWHs/0rKXbPMQCB54y8xzPuqCAq70zUpq+O9U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=eAUh2TlvjKOOMSiGzbm3/bZ6kzvK7LspXh8lC0k3QDvi/pv1r3FI+Z5fqoEYzlcXB
	 /hAfRv8CdSwe5sD8WqBSTva8NObZGiZIJwa/sPiWxxs8NYLDqKIW0o18sSWZKX95Ya
	 RK/umlzvwCDIk6APOzddZtlGtSr7ybbEauDZXnH7Lyh48dX8Lfgpt//oWqCsIe5zgh
	 soDWiBbWuReiDZJcoT1p40yWRTX91/MO22oevoIcIy2nrsVWjGkpXx5tWShwQKPv0d
	 Z9vtU2mGpdKIVkl1qeGCIVb2/Lp2wr90SWxTl5wsKM4wTPWGDhRPq26NSb+onyor16
	 PL7CtQJb/Z4Rw==
Message-ID: <sashiko-outbox-227929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/port: Do not queue a memdev detach when the memdev
 unbinds itself
Reply-To: sashiko-reviews@lists.linux.dev
To: "Unsung Lee" <unsung0317@gmail.com>, linux-cxl@vger.kernel.org
In-Reply-To: <20261122122014.2194208-1-unsung0317@gmail.com>
References: <20261122122014.2194208-1-unsung0317@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 12:39:39 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] cxl/port: dangling pointer in cxl_port_add() on
  device_add() failure [1]
--

commit 0b760e3be76b85ac20765da3eb83e58f481f44d5
Author: Unsung Lee <unsung0317@gmail.com>

cxl/port: Do not queue a memdev detach when the memdev unbinds itself

This commit marks a memdev as unbinding during delete_endpoint() so that
schedule_detach() does not queue a redundant detach work item when a
memdev without an ->attach callback is being unbound directly.

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index fffcb9954dde5..4960a288a1166 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1514,9 +1514,12 @@ static void delete_endpoint(void *data)
> =20
>  	scoped_guard(device, host) {
>  		if (host->driver && !endpoint->dead) {
> +			/* @cxlmd is going away, see schedule_detach() */
> +			WRITE_ONCE(cxlmd->unbinding, true);
>  			devm_release_action(host, cxl_unlink_parent_dport, endpoint);
>  			devm_release_action(host, cxl_unlink_uport, endpoint);
>  			devm_release_action(host, unregister_port, endpoint);
> +			WRITE_ONCE(cxlmd->unbinding, false);
>  		}
>  		cxlmd->endpoint =3D NULL;
>  	}

[Severity: Critical]
This problem wasn't introduced by this patch, but in the paired setup path
cxl_port_add() [1], does a device_add() failure leave
cxlmd->endpoint dangling?

drivers/cxl/core/port.c:cxl_port_add() {
	struct device *dev __free(put_device) =3D &port->dev;
	...
	if (is_cxl_memdev(port->uport_dev)) {
		struct cxl_memdev *cxlmd =3D to_cxl_memdev(port->uport_dev);
		...
		cxlmd->endpoint =3D port;
	}
	...
	rc =3D device_add(dev);
	if (rc)
		return rc;
}

When device_add() fails, the __free(put_device) cleanup drops the final
reference and frees port without clearing cxlmd->endpoint, leaving a
dangling pointer that can cause a use-after-free on later teardown.

[1] https://sashiko.dev/#/bug/linux-66ab7dca-4e52-440e-82d0-9a0b35e9f79c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122122014.2194=
208-1-unsung0317@gmail.com?part=3D1
