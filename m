Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1535F8A6
	for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770999253; cv=none; b=JgDlXDGDrj2PUt1C1RBB81zqDfqj6a43As8sQOlMfXIknsGGcKpXFFkpouMSGOOJwElgIUY4VvASaCLDxipludwW0QB/bxJAmoJUUIN+5Q0r1mqk8/LWHs+9WRGmLQGpvUS6uEHVG0NjE3pOmw7amUTne11xEb5pCmoW6hYyRro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770999253; c=relaxed/simple;
	bh=V51ablEssrNSfKuX1Hq5OtUiYKCcf8X5hv6UEk8jGlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9rHX8XToHid0mVJxaD8fTDUNL6ZJaYq0+KhXgbIgJstVEIcWcLocKnIniJnres2B8BNBSweqqYmugAPBWbSMAFI4aEYmtwRol9jzQM7jro+ZJ8nfHwWgSpDndPmYxNT2NiBVIGDmFmeHoU1v5/099ckHuZB6NGj6MiamR5LWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=htQ3ydDf; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="htQ3ydDf"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c6f21c2d81so124552085a.2
        for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 08:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770999252; x=1771604052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thDqtYQ9svVncr7vS9+e+A5WECJReTFglHn4jfgM4PU=;
        b=htQ3ydDfBsUQ8o5IcIz7d8e0mIrmgh/YE104UM9pf528zXXMgtlsySDb+SXM5apGXq
         3ZW+M2d28jLP+KUxxSSILcC2GORDOrpvP+82bPw8vwxcc4X2Ax/GozqGfxzzxzY8E2a3
         SYLhRapxSr3QRdnJ/QCBSPxyQchGWX32jDFrZ9jYPCIFHe0wGYDM6N77YF6nvilVVfN5
         KB//suc54zTPKxVM8Uo4Zpp5UgR0mAaApcHgAqLEJKu3m8uOug9qKZrz9+JfheimKbI7
         6fzKANZwXl8xGgfzlrJfELvGPwq/2iKXfMj+mfzTCaPx8IS4HUzsUQKqN8+c/BjX0d0N
         iczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770999252; x=1771604052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thDqtYQ9svVncr7vS9+e+A5WECJReTFglHn4jfgM4PU=;
        b=sq77VUfLUuAZFEKE+Ps866dIQwBUUEappR3J2w9TvlsPJoahNfO2KVVyhL7UmNwfGM
         Jk/anxGBLrpVrgIv0MX4n+xJdtcK7MM0VGwT6Q9NpFpf5NkyuU0uXd4UrpLtaAFXKXwq
         RH19QOQoM9lvflYXssdOkMPZsSsXsgaCg+K4TyK+PZTgLLzICrlft7fubOmc9gPHxXwO
         cQ8ms103vwid/ckU9agbV0G6uUrXTwDaLhV+JnIB3+5dXd5deshKDvBSMtZM3I1dl6FV
         I3aqc1GoYB/k+vrkslAyzGrT1KKgDn1Hvav+eL0aChMNyaYMg1CgiuCKlFtwjR+0cX6c
         X+pg==
X-Gm-Message-State: AOJu0Yw4cMPC3BgLlEFu+68FOKd4QRYd/26Jc49vuny9ZHQJJEL1LViF
	YZvoJbeC3AEKxb9M8NmfXnuQU5WU931QlzB5BxlNWwIHyZ6AGLnG2BKjNAePUmaKZeI=
X-Gm-Gg: AZuq6aI7eNKE9fAZpOCpdUAl2thN0uIisfwGtbwNDMs6gvScX+6TWpobuWPoNP+8n58
	UpN5buMHxrGR8Z8I7OJtwu3pn8hs7B3I14S7nq1bX6E+uHcrUZwoJo1gCSme5dQ7TFLrfr0tGvU
	tS1BsJeSkbYSiLwlFZSR+ZpI4Qp7McYtLeMwzR7lSr/GK2mywY+HNYpXS0uPqNb5pid3GwoleDW
	fMtM+ZLZBO3QeJFT87NRRY8H54B/DZ//lUS+e+U4zB8GzZWWWPh3BofqotzV24apoqEpm96O3jr
	Ox8BCE526jI7N7ek1KLv6rJmXf2hLjNzFqk9uL3Nkz9BGm5GtR3oXDrPRsYKB+cMwVRI8V3lmUh
	3JzjzB/pYm3ngpKrqlyz8e0zNC/EPh5vTmfFa3VWPd5Fe9Rf3Xh6wbiQwJTMz/WIO+58cZVY2A4
	el6DIH+3UKnSUK5BKnUp5/BUuXks4w/xHp7vEx6IQ7JtJwIDMH3L9iVOrWvl0xhS/+TdA8lrgAD
	Jje54OSRFE5+v1y9hN/XIadpw==
X-Received: by 2002:a05:620a:46a4:b0:8b2:d72d:e41c with SMTP id af79cd13be357-8cb422549c1mr296857685a.5.1770999251629;
        Fri, 13 Feb 2026 08:14:11 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb39da3dc6sm401861185a.51.2026.02.13.08.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:14:11 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero <alucerop@amd.com>
Cc: linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/22] cxl: Define a driver interface for DPA allocation
Date: Fri, 13 Feb 2026 11:14:05 -0500
Message-ID: <20260213161410.2945294-1-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260201155438.2664640-15-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com> <20260201155438.2664640-15-alejandro.lucero-palau@amd.com>
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
=0D
Cursory browse, this does look like a legitimate reference leak.=0D
=0D
~Gregory=0D
=0D
----=0D
=0D
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c=0D
> index a172ce4e9b19..d60a697f12cc 100644=0D
> --- a/drivers/cxl/core/hdm.c=0D
> +++ b/drivers/cxl/core/hdm.c=0D
=0D
[ ... ]=0D
=0D
> +static struct cxl_endpoint_decoder *=0D
> +cxl_find_free_decoder(struct cxl_memdev *cxlmd)=0D
> +{=0D
> +	struct cxl_port *endpoint =3D cxlmd->endpoint;=0D
> +	struct device *dev;=0D
> +=0D
> +	guard(rwsem_read)(&cxl_rwsem.dpa);=0D
> +	dev =3D device_find_child(&endpoint->dev, NULL,=0D
> +				find_free_decoder);=0D
> +	if (!dev)=0D
> +		return NULL;=0D
> +=0D
> +	return to_cxl_endpoint_decoder(dev);=0D
> +}=0D
=0D
[ ... ]=0D
=0D
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,=0D
> +					     enum cxl_partition_mode mode,=0D
> +					     resource_size_t alloc)=0D
> +{=0D
> +	int rc;=0D
> +=0D
> +	if (!IS_ALIGNED(alloc, SZ_256M))=0D
> +		return ERR_PTR(-EINVAL);=0D
> +=0D
> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =3D=0D
> +		cxl_find_free_decoder(cxlmd);=0D
> +=0D
> +	if (!cxled)=0D
> +		return ERR_PTR(-ENODEV);=0D
> +=0D
> +	rc =3D cxl_dpa_set_part(cxled, mode);=0D
> +	if (rc)=0D
> +		return ERR_PTR(rc);=0D
> +=0D
> +	rc =3D cxl_dpa_alloc(cxled, alloc);=0D
> +	if (rc)=0D
> +		return ERR_PTR(rc);=0D
> +=0D
> +	return no_free_ptr(cxled);=0D
> +}=0D
> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");=0D
=0D
Does this leak the device reference obtained by device_find_child()=0D
in cxl_find_free_decoder()?=0D
=0D
device_find_child() increments the device refcount (reference A).=0D
Then cxl_dpa_alloc() -> __cxl_dpa_reserve() calls get_device() on=0D
the same device (reference B).=0D
=0D
On the success path, no_free_ptr() inhibits the put_cxled cleanup,=0D
so reference A is transferred to the caller.  The matching cleanup=0D
function cxl_dpa_free() calls __cxl_dpa_release(), which drops=0D
reference B via put_device(), but reference A is never released:=0D
=0D
    cxl_dpa_free()=0D
      -> devm_cxl_dpa_release()=0D
        -> __cxl_dpa_release()=0D
          -> put_device()     /* drops reference B only */=0D
=0D
    /* reference A from device_find_child() is still held */=0D
=0D
The only caller in this series (sfc efx_cxl_init/efx_cxl_exit)=0D
never calls put_device() on the returned cxled either, so the=0D
endpoint decoder device refcount remains permanently elevated.=0D
