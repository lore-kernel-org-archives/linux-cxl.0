Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDE0393DC0;
	Tue, 23 Jun 2026 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245624; cv=none; b=taJT9RUkIT9DE3Oz5btiLUpQxU3dR2RCdV9l2mW0RSECeEfx+dH/zYYVIpBfVVaHUH0T1gFhJcAuIFyCC2TBO2Zdry5O7CUkbjRk8o7xKqvocKPuKpHNO83ktTdUeVCDBK9M9JY8zJwCkq+H94BJIUiodv+EUAReBNBvYt5fs5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245624; c=relaxed/simple;
	bh=PHGXJxOtvZv/2oM4oitNGgJriT6/viGTPr6wr/g0/HM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=a5M+jnCy6T/bzMpIdWisJylkxyUW+F4fOmNNmfe/Hz/lAkCtVVUVhloojjsIQ1KiyrtlfPrLzRVPUtZwJOuTfAFTXWfzWk6MBfSuS2KEQlvCaphPml3wnlWwP6h2ZiZ3Ik4borlUvCbcWkwstdSvoe6guMUsW89MQDrPBbzFSYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ds3/5E0Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ds3/5E0Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62D01F000E9;
	Tue, 23 Jun 2026 20:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782245623;
	bh=+pTaiP9/XzZRkS43G4ANQ98/hCEbIOicBYmW2LYukrw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Ds3/5E0ZqCs08Ta8voqnBHbYrbGoKvZwn8BosUO2LNQRD1UPyAdWjR2rwDpPFSYP6
	 TZqUG8I7vCsNpE+SUsU3Mrg03Ss/6wDAiGdn34DJUe4jKj3WoYQWtu3ttysG0nzKR2
	 oG5RyO914PQ5vt52B/1xBmKUajIBzwE/Ed/G5+yJ1ziTF0JQZhZwJp0kI3rWGADGvy
	 wrUcRl3eGkRrz9RqudU4Nr8N0qj//mesFPikyM3n+qTot+90adMthMNeq2QTTQsQTK
	 Ez2N4RyGveyHIHFHkYMc3VQcPrjL15JHlS76FpIVUEMQ1FtQHDACP282l/tiSbADvh
	 HYFVHjBj0+5vg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2D7A9F40077;
	Tue, 23 Jun 2026 16:13:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 23 Jun 2026 16:13:42 -0400
X-ME-Sender: <xms:9ug6aoSv2FfJ0yPSQhLEO79HY3GmDUj7oigj4Bi4Z2Am6eKYnIhCgA>
    <xme:9ug6akI9Fq5mxTbxdbzIjFz1MGKOpFpo3zfpSaL8K8Ge0G-DqgdkDdiAzDZdXQgPz
    7AGquAHawBM8HFA1jP2DwZUVHmWnE_UNP-2J3y5Ijxdzp20Y25KbQ>
X-ME-Received: <xmr:9ug6ah0axUrGdDA4esG9cdyTdGMUonC7kgMpoUGd-cL7Y4cZg-9OwIi3twOSCjEuxwL0FW_4EdKlmic44uwgT0pAKw-Q3A6tqXU>
X-ME-Proxy-Cause: dmFkZTFFF1FA8dWde6p9MtEMMJ/U1T/qXIGOJdiBLeeFEUydWpKvaIWSXjvXcLYz5wTXmB
    hDSEfag0Kjhc+mGiHTqsV/nAPaStvP+4hZvfxahEt35+eLPAljIFjX5yrdIJ7MFArc0ekS
    wNHJWXpePtoX22SSrWaTkMRdZPY6t8FkfQRp5oxwZ1dlkAScECC3uFqXI7U5LAXl9Kb5Go
    6pWqDz8iAtF41bTPp3ZIIJDpVftedree52Bt1FwJqTSgUak6qTm2z/hhi1/tTHnoGPI0Lm
    5P8i02hALlJpHzoQ3smo1bANw5MaldRb1s9zHzs8o7bkUbCxdgojNCzx9TBKztP/gp2Bl0
    DtjUjQY8LNYnIkkoL1tU6lvy6XojgJxEmIwdYyrQnsmzRQJHjwEhr7HvICwdydx214PMUq
    mZOru+0uyAlpeRSURTGQWNmp5wmJo18sVZ2W06tONMH/h8JBxiUCwgBiVrd30GMHe0WIML
    pTKetUlngBcl0htPPnIYC7tvJHIieRP7VxDOG2vFcSK5kO13x+rsjEHoMBnvGCMJnjXses
    8SJEQCF2nZ7r17mln+TAv4yAVMbtwq8EBG9WCsCq/6KsNnpBtViH233aFR3J8rQtLTLTkw
    NoGVZgaIhEGVQ7LMlNo/iQM8n2TstY/V6sURoWCI+as1I9JI907TgRxyzm0w
X-ME-Proxy: <xmx:9ug6avLCeeRNK291jG2EMHSRIRcDtH64XK-1lGe5d7q3lpYbALXvNQ>
    <xmx:9ug6apmO30nowumG4naJRNHRYJemUdqII8quyhhLGk26sD_A7WSlcw>
    <xmx:9ug6alPhZzsWXQ2NNMVQ0-5vIK-oWJYvW5Qp3pwGj4A2iiSurTj5nA>
    <xmx:9ug6agyQ6dD5v9sVntilcCsbgNlErpS4x-KrtsVt1wh4yw4K8yUUig>
    <xmx:9ug6alnOvpt8dHfXcrnHe73dxIpX6gLT9ZcrioeUpyrC5agnvr-ejKSr>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 16:13:41 -0400 (EDT)
Date: Tue, 23 Jun 2026 13:13:40 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Richard Cheng <icheng@nvidia.com>, 
 dave@stgolabs.net, 
 jic23@kernel.org, 
 dave.jiang@intel.com, 
 alison.schofield@intel.com, 
 vishal.l.verma@intel.com, 
 djbw@kernel.org, 
 iweiny@kernel.org, 
 danwilliams@nvidia.com
Cc: ming.li@zohomail.com, 
 terry.bowman@amd.com, 
 alucerop@amd.com, 
 linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 newtonl@nvidia.com, 
 kristinc@nvidia.com, 
 kaihengf@nvidia.com, 
 kobak@nvidia.com, 
 mochs@nvidia.com, 
 Richard Cheng <icheng@nvidia.com>, 
 Vishal Aslot <vaslot@nvidia.com>
Message-ID: <6a3ae8f486d0e_3c9f100bd@djbw-dev.notmuch>
In-Reply-To: <20260623091019.33417-2-icheng@nvidia.com>
References: <20260623091019.33417-1-icheng@nvidia.com>
 <20260623091019.33417-2-icheng@nvidia.com>
Subject: Re: [PATCH v5 1/2] cxl/hdm: Allow zero sized HDM decoders
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Richard Cheng wrote:
> CXL r4.0 =C2=A78.2.4.20.12 ("Committing Decoder Programming") and =C2=A7=
14.13.10
> ("CXL HDM Decoder Zero Size Commit") permit committing an HDM decoder
> with size 0. BIOS may commit and lock such decoders so the OS cannot
> program regions through them, this is a design choice rather than a spe=
c
> requirement.
> The kernel rejected these with -ENXIO during port enumeration and abort=
ed
> the whole port, so affected systems showed nothing under 'cxl list'.
> =

> Treat empty decoders as first class instead of special casing them, bac=
k
> them with a kmalloc'd resource, since the resource tree can't represent=

> an empty range, and keep the skip and hdm_end accounting intact. Guard
> the paths an empty decoder can't serve, e.g. region attach, DPA free, a=
nd
> poison queries.
> =

> Suggested-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Looks good, you added the cxled_empty() helper and dropped the dev_dbg()
announcing the arrival of committed empty decoders like we chatted
about.

The comment on cxled_empty() could use come adjustment, but maybe Dave
can fix that up on applying.

Reviewed-by: Dan Williams <djbw@kernel.org>

[..]
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..5231345ff78e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -324,6 +324,15 @@ struct cxl_endpoint_decoder {
>  	int pos;
>  };
>  =

> +/*
> + * Some BIOS use locked empty decoders to preclude HDM decode aliasing=

> + * for TSP operation. Use cxled_empty() to handle that common case.
> + */

Hmm, that is not the "common case".

/*
 * The common case is decoders with no reservation, but also handle
 * decoders with a zero-sized reservation that firmware may install for
 * security lockdown purposes.
 */

> +static inline bool cxled_empty(struct cxl_endpoint_decoder *cxled)
> +{
> +	return !cxled->dpa_res || !resource_size(cxled->dpa_res);
> +}
> +
>  /**
>   * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
>   * @cxld: base cxl_decoder object=
