Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8EE340A6A
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152628; cv=none; b=s3KMmrN9+AbN1gvNHLZ7FRaxS28VxW+sxmMoQRMls8IIMoPJL8KMequU+iTRag6V2Ucrs7iL800ZulOA0zaozz+hSftz/h+tkVuR0be3GNTaFYrMFmfb2Pai4auMmqDR5yuVxF1UdGWsbIGiZoM90F8bCcpCYzquZHDHMe1UVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152628; c=relaxed/simple;
	bh=FeWcPfr1HGbpbHe1Z+nDUmCyzg6sdrCbUaHldOtHR/c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tD8/ftu35PcVr7SojcplW/F+fnCw+eB9txkwcmkq3d5A+G/LmAFinHc0C21pbEb6jLOE6+bf7ETFcCuny+x2VnPoCfiZSbiyyaSJ9LpUlDWaF1Tcj0hGa5yXYNnSZBCrbius6lUoqJZvA66sk3+MvkoJpNM1QppOJM8v1rFAEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfUhqo63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfUhqo63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76341F000E9;
	Wed, 15 Jul 2026 21:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784152626;
	bh=ErfsdCX4K9OBtBlUv98x0X5IyaCV/hKbm28rhbsKIYk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kfUhqo63aoUqVbdwX3S0OEkFo9/mD1nDN9QqeCuIy0YjXoxMD0eUzvX5yFkmtn9+Y
	 hzXB47ZTdggC4+MZgg7DLtaivfPOTsIpxVRAkl46nSxNSKAcWl/zFoRS/VMyivjZ6+
	 Um2GIzLF56B2BOHFiSHWsHYkEyz4ewOOBDDxoJlirt6vnHIfVNYrQLmfNfkwNsGsGN
	 XRHEQ0i/H8bv76xc8GnA/awh4RwfPJj3dOhPKrf5wLH60qBd0CKhx+8Xx3wOX0/vBR
	 XAIUqOrGXSFowNCLt9EhPEdLuit/OlxNKRpKrrsUA3UMSCTn6vkELvudpai56DMpjY
	 H6T6f3/lmuvLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] cxl/hdm: Restore commit_end when decoder
 enumeration fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <563095ff87e66b72651c15248a1a6dd6f5ddc3b5.1784150131.git.alison.schofield@intel.com>
References: <cover.1784150131.git.alison.schofield@intel.com>
 <563095ff87e66b72651c15248a1a6dd6f5ddc3b5.1784150131.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 21:57:06 +0000
Message-Id: <20260715215706.A76341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Mixing goto-based error handling with scope-based cleanup helper=
s (`scoped_guard()`) in the same function.
--

--- Patch [3]: [PATCH v2 3/3] cxl/hdm: Restore commit_end when decoder enum=
eration fails ---
commit fee00b887a5dc8f3c4c335d03db77d2ecce10947
Author: Alison Schofield <alison.schofield@intel.com>

cxl/hdm: Restore commit_end when decoder enumeration fails

This commit restores commit_end to the none-committed baseline on the
enumeration failure path so a subsequent probe can enumerate cleanly. It
also protects the commit_end advance against concurrent readers in the
DVSEC emulation path.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c

[ ... ]

> @@ -1198,7 +1199,8 @@ static int devm_cxl_enumerate_decoders(struct cxl_h=
dm *cxlhdm,
>  				dev_warn(&port->dev,
>  					 "Failed to allocate decoder%d.%d\n",
>  					 port->id, i);
> -				return PTR_ERR(cxled);
> +				rc =3D PTR_ERR(cxled);
> +				goto err;

[ ... ]

> @@ -1220,17 +1223,23 @@ static int devm_cxl_enumerate_decoders(struct cxl=
_hdm *cxlhdm,
>  				 "Failed to initialize decoder%d.%d\n",
>  				 port->id, i);
>  			put_device(&cxld->dev);
> -			return rc;
> +			goto err;
>  		}
>  		rc =3D add_hdm_decoder(port, cxld);
>  		if (rc) {
>  			dev_warn(&port->dev,
>  				 "Failed to add decoder%d.%d\n", port->id, i);
> -			return rc;
> +			goto err;
>  		}
>  	}
> =20
>  	return 0;
> +
> +err:
> +	/* Reset to the none committed baseline for a fresh enumeration */
> +	scoped_guard(rwsem_write, &cxl_rwsem.region)
> +		port->commit_end =3D -1;
> +	return rc;
>  }

[Severity: Medium]
Does mixing goto-based error handling with scope-based cleanup helpers
(scoped_guard) in the same function violate the cleanup subsystem guideline=
s?

The documentation in include/linux/cleanup.h notes that usage of "goto"
and cleanup helpers should never be mixed in the same function, because it
creates confusing ownership semantics and can lead to bugs under future
modifications.

Should devm_cxl_enumerate_decoders() either be converted entirely to
scope-based cleanup, or avoid using scoped_guard() in the error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784150131.gi=
t.alison.schofield@intel.com?part=3D3
