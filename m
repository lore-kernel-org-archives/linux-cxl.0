Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E8383
	for <linux-cxl@vger.kernel.org>; Tue,  5 Nov 2024 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842336; cv=none; b=rnMQYWr05Fd5EedK+02e1lORlA1YtYR55PSEgjNPRDIIx/W+bSzZlZZXKcJM+/nzcE5o8w1bGjX2oxNjGnuNMVNhW2VMq9TSCI4s5/LSwHNnvEmQc5qOoe3fsSdUMiQUO2eKn4D5wgM4rJ1TQNGzVgL2Ddl1FWUYQ0zIUCupXJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842336; c=relaxed/simple;
	bh=SNrdoi6QCMEB7OLnPiXHsW3eyE7XW1timkNna0yoJh4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8ovcL6MnjN34kMXOesKuQYfMyrvK0sXPFej2SN7gGPSDxmRGy8JQfU0DLxo1YoxNaTtgMch8YtaiZI6xc31xTmYyumy5eZEYKFJWgkhIFZZBkLAJU6++17pq5nsMHd87WuZEQzMcV3xSvG0kNt2aKPiqiTzBGwuzIcndpDzKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpDu8xyB; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpDu8xyB"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e28fd83b5bbso6493981276.0
        for <linux-cxl@vger.kernel.org>; Tue, 05 Nov 2024 13:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730842333; x=1731447133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7RkXnVjpcVt4e93NoUNF6wrUWDEE5LM7Uldi1UcOV6w=;
        b=KpDu8xyBGSr2vQp1udVwaukmYgFHLUk17vqWWP28YJZrY2asBRLTAj1UFIGMCJ4VGO
         FxtG+YLKDWzfnLaTShdyPdbLS1Df+2y2NW7sqkFJuP9QH8OMkx5TAxPUv9L4lHh8oDEQ
         oh96EQVTx1yNBaF3XXiIEK3AajDIC0WKvxfkrNm+ehWudp5P/j9UgWCL3aanoB5/gRO7
         x2A09yIXvoua7IjUnjZRsUejq2ZlwYaGIxksrxZDtz02RwrVDr/2elZRWD8KsqNlpCnh
         mOdQHfkx7Z8aIRq/2xIumQcdIJHWOC1ovxhpwU8bFjTqRZNI0yT4QmlXeEwhUl7FNu5O
         SUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842333; x=1731447133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RkXnVjpcVt4e93NoUNF6wrUWDEE5LM7Uldi1UcOV6w=;
        b=WGfBN0Eib5svt/Jsz/CufdAnCcVapw5lFIxHQTasAVruqTv/JNSOs7SfMuqqbeEZ1h
         iQb/B5whBhV7BdUonXFlOFNwC/F0PuNskGiXGyk4VZPy7ZbY9NJyfC4gj3fdIUVOitd6
         jyw8s1euCSJlz5wHOrxnt2LFBGChTY35MULBT93ful+m4nThhWQqqfedwCb8GCg5urbw
         R9qPQggMC/IgOyNBOzjOakI86Sg9xL8OT/CZGe2fxcGYDme9yDca/glnCFcgY8g2mEaN
         c5cme+SJpTKuQsyU0mNgfpghiz11z4OgLpNIchMWkBiIb9fSAUint1jBNDP+Ou9bXSd4
         KX8g==
X-Gm-Message-State: AOJu0Yx6Jyv5cyUkZnkgrVUZ2IqmKUMrt7rKWDXkiAu7Q8V0baghWV5m
	qZa1KKlmvtuGhSHoSLdSYZVef550OgMo/1s1LdCTt4uBx803cxlAGYZyug==
X-Google-Smtp-Source: AGHT+IHl8uFBg6XDhX0Vw70PzWun3HBMcGGd/ffvhldqgpRaKtZSeibF2h0+0UUWu5Cjpj/hTRmB/g==
X-Received: by 2002:a05:6902:2b85:b0:e29:288f:33fd with SMTP id 3f1490d57ef6-e33025ad4c0mr14994900276.26.1730842333268;
        Tue, 05 Nov 2024 13:32:13 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a851a5sm2721445276.22.2024.11.05.13.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 13:32:12 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:32:10 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
	Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 08/10] hw/cxl: Check that writes do not go beyond
 end of target attributes
Message-ID: <ZyqO2nzQM3zXZMMW@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-9-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-9-Jonathan.Cameron@huawei.com>

On Fri, Nov 01, 2024 at 01:39:15PM +0000, Jonathan Cameron wrote:
> In cmd_features_set_feature() the an offset + data size schemed
Not 100% sure if I get it right, but s/the an/the/.
> is used to allow for large features.  Ensure this does not write
> beyond the end fo the buffers used to accumulate the full feature
s/fo/of/
> attribute set.
Other than that,


Reviewed-by: Fan Ni <fan.ni@samsung.com>

> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index a40d81219c..078782e8b9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1292,6 +1292,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>  
>          ps_set_feature = (void *)payload_in;
>          ps_write_attrs = &ps_set_feature->feat_data;
> +
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->patrol_scrub_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
>          memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
>                 ps_write_attrs,
>                 bytes_to_copy);
> @@ -1314,6 +1319,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>  
>          ecs_set_feature = (void *)payload_in;
>          ecs_write_attrs = ecs_set_feature->feat_data;
> +
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->ecs_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
>          memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
>                 ecs_write_attrs,
>                 bytes_to_copy);
> -- 
> 2.43.0
> 

-- 
Fan Ni
