Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEA33644A0
	for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770999256; cv=none; b=cGgTrWuuKv36XK0Sa/lRJuDSOHoBiMw1ZYX5idvIqDMTrdI08psnjDPaMDOxFz5nis7rkGIWMz+L4DvL80k4IVFIzfc7rOHVAr1VS+nBE+SbDAdNU8fI8NC1UmBHvn+VrqIFlJOGPkQoju3YB8SnKryh1/M4HJni6iXRDcdCa6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770999256; c=relaxed/simple;
	bh=gYOA7Jd2sD+F4AI6OhnO4bQgKhYCRfntgN+Nceji7DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lETgm8h/YNtc0f5jg+FevBkfeDFN/fFxSaVwMDpJBNled2iX8ObcK6JtJ51J8l4YVbxPb39QLneEEoAnrsTYsjIkEW0w93f/pnCyF27l+5xktkGazh5TbwZmtGwqFjMkn3qDGim9v2p4JulhR/PjDpQiyBDHI5/SMgj4D4zgXRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dghY7PcD; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dghY7PcD"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb4081e82aso121679185a.1
        for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 08:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770999254; x=1771604054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgbJ2hZD9atfYQt5BUJcJLNlHTxXKvF+WEu0/IJVXc4=;
        b=dghY7PcDu4mhNNln83RJ8sCUeLOZeMXaL++PIS2JAbS1FgOv85lf4FnJrwG/FAH8bT
         5gGKG9xcs1sM5hiClFHDRU+/zgkclZxm7gcWdFrFftlgMIzMBtifE4fYU6NoHgkudjcJ
         HCPP+QRIcvxPRL0BNJwCslhbbhSjShnD1uDbnKIgIrKil5wb5Uj5njK3St9aBP1mTyWd
         TUcJAOe+rX7JOjvU/2Lk9wR7wa+xRr7wmPHXlzub/zntQ+te58tShzWIKyf/6UatLGu0
         Tf7jSnNxrdhQhXJEWI0te3JVvGt/bZaWGoPrsm4uzy8G5Chg0UtJkQxgmLPceZzoacf/
         2DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770999254; x=1771604054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgbJ2hZD9atfYQt5BUJcJLNlHTxXKvF+WEu0/IJVXc4=;
        b=mB6Z0+NCqwi2aG/kvqHi6hOTlU9nDCv8S0arMg6On6XROutpYkwex7fIpIRG/JrIY1
         fO7LT0nytj+EjFwuhgOZE90SNgiEDilqbOa3jNM2Bq2+Ah0N4YBkShqQEy1B5J8qnXYN
         i0hIOoXt+SW29774BxtxOkQQRgpY9Qjr+xpyYyzaeJG0qbUqaBLVVi1T0Y4rlam8dqxx
         d3Jkp+AC5J8VrOiQGaL2sVtP0PnxuNgMfW/VZUZX2urQIVl/CgH8O6bKaOmGYfVW4Aj1
         iJYA3tnR0fGU+ZF0177niN8CS1yQNeBTuujjoS5hoRiH8l4LPl/PIiSvruerV1shvhOs
         QmAQ==
X-Gm-Message-State: AOJu0YwAr1JhdB//zN6HkDVm2fiALF7BDOywuZGiRLfgXTBj0ZS8ytM5
	wULpwqxjHMILp/WR5IscNuScy1YIQ1anPdUZbgnsQLI9TXtDaZmydLg69CPM611rU1D/hX7yjTj
	uxuXX
X-Gm-Gg: AZuq6aKVA4er2oO4ibFe7bQjNXnawlkVP9FI6ntS8Mqo3U5MWeLqwxy89PexfJoar0d
	MTiVIeW8w+bGk4/KF5OCkfx2nhicMSNKXb0lWLBodS2nzJRMd+VSU9SX026kHV9ssZ5WucZyYz+
	On+K23TPVjjYleA7EotwpjuEjKcVxjSYRm1zgFUo2+t5kUHSnDvk/GrMNMu5XSCPw+JPWST5tfH
	QLTIl18BtofybyRMXK+FNCFSAgxec2YFCaxiCqTGGnIaH5r4uJOkxxXx5BPLu3GehTa5PFgHv2U
	iELu7hwooHRo0zhOBJ6rnixC9F4Gv0VBhyh1tvLGN4281PUE+Zc9SzhRAPASUO2sBBuOqNuE8mI
	HARQeqqbqjFnWbFvMYP+pHvw2Qy+7nX4Thfb5eL7PGzwV71lcEfffNyhP2EugjkPcys8bnQQypB
	CMBBR72ycYORZn9Bq+6ARMQ4kOSjhrEvtV47OX+SHx+LcbwfKGC3DQiQNxCbCjfhcMUPhN1Fw8F
	IukaYziZeykhBQ=
X-Received: by 2002:a05:620a:3188:b0:8c6:af59:5e2c with SMTP id af79cd13be357-8cb4bf6a3cbmr8015185a.18.1770999253839;
        Fri, 13 Feb 2026 08:14:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb39da3dc6sm401861185a.51.2026.02.13.08.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:14:13 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero <alucerop@amd.com>
Cc: linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/22] sfc: support pio mapping based on cxl
Date: Fri, 13 Feb 2026 11:14:07 -0500
Message-ID: <20260213161410.2945294-3-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260201155438.2664640-23-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com> <20260201155438.2664640-23-alejandro.lucero-palau@amd.com>
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
I am completely unfamiliar with this code, but the question it poses=0D
at least seems reasonable.=0D
=0D
~Gregory=0D
----=0D
=0D
On Sat, Feb 01, 2026, Alejandro Lucero wrote:=0D
=0D
> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/e=
f10.c=0D
> index fcec81f862ec..2bb6d3136c7c 100644=0D
> --- a/drivers/net/ethernet/sfc/ef10.c=0D
> +++ b/drivers/net/ethernet/sfc/ef10.c=0D
=0D
[ ... ]=0D
=0D
> @@ -1263,8 +1281,25 @@ static int efx_ef10_dimension_resources(struct efx=
_nic *efx)=0D
>  	iounmap(efx->membase);=0D
>  	efx->membase =3D membase;=0D
>=0D
> -	/* Set up the WC mapping if needed */=0D
> -	if (wc_mem_map_size) {=0D
> +	if (!wc_mem_map_size)=0D
> +		goto skip_pio;=0D
> +=0D
> +	/* Set up the WC mapping */=0D
> +=0D
> +#ifdef CONFIG_SFC_CXL=0D
> +	probe_data =3D container_of(efx, struct efx_probe_data, efx);=0D
> +	if ((nic_data->datapath_caps3 &=0D
> +	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&=0D
> +	    probe_data->cxl_pio_initialised) {=0D
> +		/* Using PIO through CXL mapping? */=0D
> +		nic_data->pio_write_base =3D probe_data->cxl->ctpio_cxl +=0D
> +					   (pio_write_vi_base * efx->vi_stride +=0D
> +					    ER_DZ_TX_PIOBUF - uc_mem_map_size);=0D
> +		probe_data->cxl_pio_in_use =3D true;=0D
> +	} else=0D
> +#endif=0D
> +	{=0D
> +		/* Using legacy PIO BAR mapping */=0D
>  		nic_data->wc_membase =3D ioremap_wc(efx->membase_phys +=0D
>  						  uc_mem_map_size,=0D
>  						  wc_mem_map_size);=0D
> @@ -1279,12 +1314,13 @@ static int efx_ef10_dimension_resources(struct ef=
x_nic *efx)=0D
>  			nic_data->wc_membase +=0D
>  			(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -=0D
>  			 uc_mem_map_size);=0D
> -=0D
> -		rc =3D efx_ef10_link_piobufs(efx);=0D
> -		if (rc)=0D
> -			efx_ef10_free_piobufs(efx);=0D
>  	}=0D
=0D
The CXL path sets nic_data->pio_write_base but does not set=0D
nic_data->pio_write_vi_base, while the legacy path does:=0D
=0D
    nic_data->pio_write_vi_base =3D pio_write_vi_base;=0D
=0D
Since nic_data is kzalloc'd, pio_write_vi_base stays at 0 in the CXL=0D
path.  efx_ef10_link_piobufs() then uses nic_data->pio_write_vi_base=0D
to issue MC_CMD_LINK_PIOBUF commands:=0D
=0D
    MCDI_SET_DWORD(inbuf, LINK_PIOBUF_IN_TXQ_INSTANCE,=0D
                   nic_data->pio_write_vi_base + index);=0D
=0D
and also for the special-case check:=0D
=0D
    if (tx_queue->queue =3D=3D nic_data->pio_write_vi_base) {=0D
=0D
Wouldn't this link PIO buffers to incorrect VI instances when using=0D
CXL, since the local variable pio_write_vi_base has the correct=0D
non-zero value but the struct field was never updated?=0D
