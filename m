Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57973164DF
	for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770999255; cv=none; b=cG6pJn6ViwmhbE8IHo8vUSgaVg9IdQeJGzcrcwldLusD17lPs11R1CLjJwUUA8TtRxKUZon81tLBzoPm3EFVPGRqKOXCthLQokkQlNLEu19chZz2DIfTx4jQABJO8CiGKEpOodr978zVaW+fYYQO7YdUySYZ3d8Ni2tyOFbI9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770999255; c=relaxed/simple;
	bh=k0+aRJ3IUuarB2zMZblbi3T0axeHfpnV60kS0VoDgF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXbaJGsmaUxP0PgjahJpseVDi3N9MpCPP56M6tdlJW8uDYr51LCwAmVZF9dEz9a2Pyv1eRQERFs21WQhd25zXYhblcAi46VZRPkY2yYUhmnxNriU/ef9Jd/K58m5YC7kH/GPMhC/FHn++QNBGmQNPPyy0gR0FkLSZ3eu44fp1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=I0XoICng; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="I0XoICng"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c9f6b78ca4so145628085a.0
        for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 08:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770999253; x=1771604053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ohzmGcjlqDye0brlPb+kXwsuRqWVNcPe4L1+AfQUaY=;
        b=I0XoICngKzupTlLR2OPZ7xDnbt+M6NUCk6snFjnAc/Znx7TPkMLNSntK5mJfHMQru6
         E4W/HPsxsKxIaF8nQFLEL8Jlcv05SDnS6i+H8rilrXwEax2hw2RasmkEc2FEPDlsOe22
         wGndE4mk3Ho+0dzvfqHAVP3EP+QaqrsfGFa1q6cf0qhNpRq0YNIjowajPPiNo5jJ2fw7
         +n3F7sWXzeSNFc/B4kmLRmVy8kp8jgZyhBvrpdYB+V9uKul73ovjKYhd/0QYzWqtCmn0
         SdfbBRmVAq5FWSvGdyMJJrII0yuvmd6FN5dn94lihNFqJqdHCG5bTAW2PpgE99GX7iiu
         Amow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770999253; x=1771604053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ohzmGcjlqDye0brlPb+kXwsuRqWVNcPe4L1+AfQUaY=;
        b=NAxa/fz3Eq+FPNBce5lzqI9yRM0UkqXshnaVrYo3X+qfti+t2dED7T4ds1F5paTv3Z
         Sng+vAcVgP+Yu3mP3C4MxhIwluUb7KrciwdqBHCfqx/WoKev1gkG1cnXgmE/y5mN17Zv
         +PHTKYqGoehcLeLGAKmHW2VFO6+wIeQRZBSKmE0QSfXfqJ68Wuc2a6eYAPGojX6dN54t
         yEy9u1GyOMSnHhUY6E97qgL58ef/AqGt/mbCLRH3qjnle4ag5sGBMnszN75d95q2yJDi
         MDORDncSE2jg4ILziiatZPkGj6Ow8PdjSiZRqrB7rYvdtzTuA/m4t67Sjcr66umxVOv6
         7PTw==
X-Gm-Message-State: AOJu0Yx1gmoyeG2x1bTwkccBvuUCdj3U6ZrCZ3AqjW4dj1CtpmBT/Hh4
	nVMzC2AqlPm2YgQVOpnEfQol21ny+GdjPqxr9HtRKHoNdWaDy/RUi0DDWqRk5napAFg=
X-Gm-Gg: AZuq6aJ01oZMufGY/DoK91rHmXyV+cQ5yDy4D6/mh+nQjt/9rQvJaeT5ThZDiEU5Ep/
	IDqgoo6y/QCmSeCcXW1at8blq3tyuTPWYOF0nJBaSYd1stTX2XSrDyVTtiV1EHAyBr8yKpyqJBf
	eh7Fd3lJsFicwPKf2PwWESQFc6XobM+txK/6nvvfhmBWOliuwSUr4Q8R3xqKZt1PMriaGSdK19M
	bcI2+Yx2z/cblINHqiDLhIfG24MkYloiwn8oKMkIBwehpk4HKBAdh8AhensTvWJHl5vwi1n/F2T
	lixXxKK+QssC03xQWw8lykNUOCz/CEbJUbicCcgezqt7z8ADvNIhjWpn9jvbY+UdQohm3Bi5xXR
	ABBqciNzGILlQ5jErIQUZmmtY5eE9MsGIHE5wzFv96Nwltw2L9xLUM0emboGlS++MjyDJItTHIS
	I2xI7yXFqrBBqR+yRnRWlSQrzWMnmhSfu+iQbnrFz+ldl6to4wJxIlNI3PWcl81NM1HlajqmZOF
	TikoCOOcMoVlDE=
X-Received: by 2002:a05:620a:4444:b0:8ca:fe7f:7324 with SMTP id af79cd13be357-8cb4c014375mr1237185a.53.1770999252828;
        Fri, 13 Feb 2026 08:14:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb39da3dc6sm401861185a.51.2026.02.13.08.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:14:11 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero <alucerop@amd.com>
Cc: linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/22] sfc: create cxl region
Date: Fri, 13 Feb 2026 11:14:06 -0500
Message-ID: <20260213161410.2945294-2-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260201155438.2664640-22-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com> <20260201155438.2664640-22-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This review was generated by kreview-0811365ff2. =0D
=0D
This is not an automated email, the reviewer though this report=0D
looked valid enough to consider discussion.=0D
=0D
----=0D
sfc code so won't speak to the internals, but ordering question seems=0D
legit.=0D
=0D
~Gregory=0D
----=0D
=0D
On Sat, Feb 01, 2026, Alejandro Lucero wrote:=0D
=0D
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sf=
c/efx_cxl.c=0D
> index 2cfd0a46225f..4d5f3974e51d 100644=0D
> --- a/drivers/net/ethernet/sfc/efx_cxl.c=0D
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c=0D
=0D
[ ... ]=0D
=0D
> @@ -147,11 +155,11 @@ void efx_cxl_exit(struct efx_probe_data *probe_data=
)=0D
>=0D
>  	if (probe_data->cxl->hdm_was_committed) {=0D
>  		iounmap(probe_data->cxl->ctpio_cxl);=0D
> -		cxl_unregister_region(probe_data->cxl->efx_region);=0D
>  	} else {=0D
>  		cxl_dpa_free(probe_data->cxl->cxled);=0D
>  		cxl_put_root_decoder(probe_data->cxl->cxlrd);=0D
>  	}=0D
> +	cxl_unregister_region(probe_data->cxl->efx_region);=0D
=0D
In the non-committed path, cxl_dpa_free() is called while the=0D
endpoint decoder is still attached to the region.  Looking at=0D
cxl_dpa_free() in drivers/cxl/core/hdm.c:=0D
=0D
    if (cxled->cxld.region) {=0D
        dev_dbg(dev, "decoder assigned to: %s\n",=0D
            dev_name(&cxled->cxld.region->dev));=0D
        return -EBUSY;=0D
    }=0D
=0D
Since cxl_unregister_region() has not run yet, cxled->cxld.region=0D
is still set, and cxl_dpa_free() returns -EBUSY without freeing=0D
the DPA.  The return value is not checked.=0D
=0D
Should cxl_unregister_region() be called before cxl_dpa_free()=0D
and cxl_put_root_decoder() in the else branch, matching the=0D
reverse order of allocation in efx_cxl_init()?=0D
=0D
The cover letter notes that v23 expects committed decoders as the=0D
primary flow, and uncommitted decoder support is deferred to=0D
follow-up work, so this else branch may not be reachable in=0D
practice today.  Still worth fixing the ordering now so it=0D
doesn't bite when the uncommitted path is enabled later.=0D
=0D
This issue is not fixed by the remaining commits in the series=0D
(through 10fe989f9e85).=0D
