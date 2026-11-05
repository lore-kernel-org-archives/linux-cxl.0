Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868143;
	b=vlIUoB0i6UTK7kOBN9tIAoCNv4XUkF+7rO/Gba3Uhbey3tIG1KOq17iQGL3ARujA40qs
	 DiWuCBC7RYsq4Y024P22jWoc3W0hmSCbyj9zjcFSflean/oP6NKd3bqt+Bus+jdEJQTma
	 AcpcTE480ddh5drW1Q7p4AQdfQvxmUiq5wtWrb9taWdeGgBWn7iYGeVtQ/mwQ/FhDjfu7
	 TPgl2mtaAlJPl9SjJQAJOlIwn/5DgdlKyurqX/OKtf5rafszh7se72G4ZKaOjywpR38iH
	 G/bSvVP/9pU7NYDXN1M1F4cw9sxb2ePM7t2dSp6M7BlY7Qq9eRcNhfDv6fcIa4Hun4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868143;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BY5SPkqBUC/LVpn0704Yh687udlFm9JNFJUu9ANrPdI=;
	b=Dw5RS23lmiHnkxnVESeBafaH4U+sunvfW59N6x+nHp1VZ6aj82COA9GqjJsiKMCtMWSn
	 ZKaiN5AvDdsIG3LTWW77tW2SVEnk7Cvc0NB+uTXCfvb2X0VLwFLpD3tcH1qD4s7FnQ5YZ
	 DFIQZnMWRUjvyKp9h3nEVyartpJFZQWl+9DmtL9yhD/qAZdY9E02KizNC+1MgYyvfXxAL
	 rMc9b0xpxh54EccDHx7ojYz17MGK5xttDVHfTnbaURtBCPm5Ono/2c3c8uOKlJSTa0pGP
	 5EtlANZImL7bcw0UO9WSyMLF3Deh+eC/kgQpWPp/AE+WWaooYhkTkRUZjtqohM1XHDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A40606A334
	for <linux-cxl@vger.kernel.org>; Thu,  5 Nov 2026 08:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99A40606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdab938dc83so715048a12.3
        for <linux-cxl@vger.kernel.org>; Thu, 05 Nov 2026 00:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793868142; x=1794472942;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BY5SPkqBUC/LVpn0704Yh687udlFm9JNFJUu9ANrPdI=;
        b=H6/Z/D7b4UrH77Oih26yRFHEv1g+2OkpqW5YduMmkgS8whmD8m+pTYU9rRARXspeyR
         G4Ydu0uwGAjYGiJzGs6s5gQqJXUcZGeSCN5xhWx+Qp46FBt1kz6u2elpVSIFu655YJdZ
         BUvCnkHs/ZCz47Yj+SFJDRoYqAR8h0eIbijFNPvw4/wtONd6u0HYRWZR6aOAifSn/UQk
         hJu4kSwnRuFtcywLj285iC/U4YBp1WZ0dIk/Zy1uWXqbt7D9TPFmL6r+P+sgpfUo7OE4
         88hUHY/WWP9rB3coPnWfwQQio68DqOHtd/aEwbr9jfYJiGdaB3Cuhhlt9duej3VRxvT6
         YyWg==
X-Forwarded-Encrypted: i=1; AKwUvBwIhNFX9GHzmJIToDsRAwXKs4zehpOo5rp5sBhq54dG7LugVho6dibZ9755zBJ4pfobhIwRG7DssXQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8Iva7JySnNrEq7u1QcLy7NtKKmqoDqzqWAxw4oBxZYi/DjTYd
	GQOot0eSJ+j02MqXTCms+sZ/hJH+WuXNYetHBm2UR5rPiK1Qry18u33NFP6QiNN35DCP
X-Gm-Gg: AYBFou2MLJmBzGuF7Rw1+3Wm5KWziqaR+02QdOT1s+ogPJcmNGHXF5o9waaEXHWmeTI
	QCGvV3zqdlITDoyW0Br9ZiCv609B8OEgx10un1ftZclx7aG7468S68QxbUgW5EY4ELaiHCqPIIt
	dCgMdleFHBZ+Os4487s0SBtSegoSiFxUWYpuXBKkvJs8TbfJIBEDKH018e/aYxW/wyaRUt2353Q
	XzirSNZVBWgXg6n35a2+KUwJ5dSMCd7daecqck7eebOGYRyt0JKz9BJczWv13nDv58n6kz5Wpom
	3bdJz23G/0Z4JVg9hfJVyUKMy6KGqoSgCMQhgX0KQsfGElAsKwRFfO+ijALQZhNXXUtIQv3fHYb
	/Ofwppcu+6yOY5yHfghYfyUkIiPCoyQwKocVNaCskUoIVCr96ZdIF2QbUcD2nI3oUPJZdtkqiDf
	N40e8m1ZloMtdiYafdGB3D/OwbhltRo4hyosfaWyrim+OVTgf1a/lOE3mPNcxmL3uEEQYcfp4Bq
	apTm06xQsmOhdGH67TcXBPQwIjOgiaeUSAjkvnb9GBvCOvOMXXZ6yjhvfM2o6sMBNVK3K+sO1+o
	jiyn5b3l0Kcc0kPBPQQ66EloUVJa4k1P+z0usUlaUgGwH+gAjyRmk5UkfX5+8rwYmC7ZRkQVUEn
	Icr/4j8CdmzTdbE5VupJH5U8uNkwiLllNgvZELm4e
X-Received: by 2002:a17:90b:57cb:b0:3a8:c0cd:57f9 with SMTP id 98e67ed59e1d1-3ae89744ca2mr15840169a91.25.1793868141815;
        Thu, 05 Nov 2026 00:42:21 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32812a6sm2720088a91.11.2026.11.05.00.42.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2026 00:42:21 -0800 (PST)
From: Jongwon Lee <ai@linux.com>
To: Li Ming <ming.li@zohomail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v4 2/2] cxl/edac: Mask DPA flags in the event record cache key
Date: Thu, 05 Nov 2026 17:42:13 +0900
Message-ID: <20261105084212.55292-lm2-ai@linux.com>
In-Reply-To: <f4be9108-e5ea-4e6d-bd6d-0af14f28951d@zohomail.com>
References: <20261102123233.74598-1-ai@linux.com>
 <20261102123233.74598-3-ai@linux.com>
 <f4be9108-e5ea-4e6d-bd6d-0af14f28951d@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Ming,

Thanks for the careful review.

On 11/5/26 16:20, Li Ming wrote:
>> +static inline unsigned long cxl_rec_key(const struct cxl_event_media_hdr *hdr)
>> +{
>> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_MASK;
>> +}
> This function actually returns the real DPA of the event record, I think
> the name should be cxl_rec_dpa()? xa_load() uses attrbs->dpa as the
> index, but xa_store() uses cxl_rec_key() as the index, that could make
> readers confused.

Agreed, cxl_rec_dpa() says what it returns. I'll rename it in v5.

> I think the implementation of skipping unrepairable records should be
> moved into a separate patch, and this patch focuses on using real DPA as
> the index parameter of the xarray.

Makes sense, I'll split it out. I would like to put that patch before
the masking one, though. Once the key is masked, the DPA from the trace
event matches a NOT_REPAIRABLE record, so if the masking went in first,
those records could be repaired at that commit.

> My first feeling is that we should not simply ignore unrepairable
> records without any logs. But I am not very familiar with this area, not
> sure if we should report this repairable bit in trace log or output a
> kernel log while finding an unrepairable record.

Good point. The trace events already carry the flag: cxl_general_media
and cxl_dram print dpa_flags='NOT_REPAIRABLE' for such a record, so user
space can see it before it requests a repair, and the request then fails
with -EINVAL. If the maintainers would like a message on that path as
well, I can add a dev_dbg() in v5.

I'll wait a few days for other comments before sending v5.

Thanks,
Jongwon
