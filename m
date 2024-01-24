Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D212A171
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120436; cv=none; b=uTqz3+dpSKP8WD04oblBBFsiu8FUDy24g2zjZ8J9Aa71n1eL+bjbvYOm7bOtqtBmsOBTZuF89EUvQv3bhGEpC1fKPM1jGysVh082dmspne+WQznM96sX9xbmJ21MoFes+VGJoGLVxEXOapqcemK2ZIHBfLsmBD0QEzk6loMGTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120436; c=relaxed/simple;
	bh=xbjMBXRi9KbOQRsk0KawcBCxTZ1Ka7W+dbZiJp5XzvM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/i+i/27u6L71PtMlL7xnff5r44I+Y03NtE5IJXJq+vhHVs2CIJsIpdNVJoEGbB4LUUsDbrUrsxatQQwfve6byU2IMRSCyVKa8PodH/8mwt5iZi9ZUzvU+Ojjz3bhYW/yVzI+xizyZ4glfHL2yd4dtbNeJOI5XA2yood3Miloas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fygl/WNe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fygl/WNe"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7858a469aso6058405ad.2
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 10:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706120434; x=1706725234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uDr042bqAkTMmsZtF2KErj5W9qTXGoieWliyT4SgJxE=;
        b=fygl/WNedKASNYcntRk7jjrpXnKQSxsVQkPpt61zw7HgyZ1WNpsTEFpezC1rLk5V7N
         X0PZ3J6mSjtO4skSjNIHkzK39+ggdT6RQwgRPGz7oIQwOSQxQRO99eyP/BodkuqTQlzt
         xo7ArodkOYBcEiS/0uTsRytoFWRZS6yj4/x3hgXiq08FpCCv3yMA/rA4WsLRYm0toh+A
         tt/1a22yvIATU40o6FWowfvIIQk1bWsbP4ASbwWRy+QKNwSfYbP3kGRZPeDAF5hU88pC
         LF5mREhszA3htskyGG2uMpVPWG6G53tspFKoW7E37atA1TOht4OqTOqKl8Q607/Hadzy
         W9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120434; x=1706725234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDr042bqAkTMmsZtF2KErj5W9qTXGoieWliyT4SgJxE=;
        b=UczAYShHsSBXqCl13mgLsu9i5UUSgzioqI4ZpK4sqRhDbK017MbIpz2DcJJuZx6aNH
         OHlknZeoe7DgVdGXWuRUpzj1PZuOkJljqSyB8AJU9QSeCrIxIye6BZ/YovcpnNJuJ6Ru
         fOt8IzyEq5zGlJvPCohKIPwtLeqSKCxxfZemWjF1RkLn/ZyyCWy3SepFK+tJFKbESlQp
         p7yibYThEhNoRFsRxuvrNJIIhdAoFSQrHr2m90HPwawQQ5pnL5p96C55OYgNGQHR+RZ5
         aw1gcWfMHi4QluT0xSNuOeDiRq5pYux/dKePjPVmLxB4dVIgKkMYZgsClGyVeHx5l1Yl
         /V9A==
X-Gm-Message-State: AOJu0YxtEowsPT6lekfI1K3W0i2R8Ty+MQYFQVNKRV5M7bkwDHcR15pu
	0+X9NwqULxCzVvNpn/Ysmokfrug3Gp4uS1/P3vR+Mag0L6n5mxOGB15qVugJ
X-Google-Smtp-Source: AGHT+IHRRM1yZHXWP2uIEivqRQkForhuWSpsUgHFjV90Pu3FR/zZH7WRIR8uslMgL8blqX8DhX+AYA==
X-Received: by 2002:a17:902:f681:b0:1d7:4681:c501 with SMTP id l1-20020a170902f68100b001d74681c501mr1211313plg.59.1706120433789;
        Wed, 24 Jan 2024 10:20:33 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903308b00b001d76e9ce688sm3021216plc.114.2024.01.24.10.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:20:33 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 10:20:31 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/5] hw/cxl: Update link register definitions.
Message-ID: <ZbFU7-k_3qwQz4rS@debian>
References: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
 <20240124134814.8717-3-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124134814.8717-3-Jonathan.Cameron@huawei.com>

On Wed, Jan 24, 2024 at 01:48:11PM +0000, Jonathan Cameron wrote:
> Not actually implemented, but we need to reserve more space for
> the larger version of the structure in CXL r3.1.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_component.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 7d3edef1bf..2c7631bd1e 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -104,10 +104,10 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
>      (CXL_RAS_REGISTERS_OFFSET + CXL_RAS_REGISTERS_SIZE)
>  #define CXL_SEC_REGISTERS_SIZE   0 /* We don't implement 1.1 downstream ports */
>  
> -/* 8.2.5.11 - CXL Link Capability Structure */
> +/* CXL r3.1 Section 8.2.4.19: CXL Link Capability Structure */
>  #define CXL_LINK_REGISTERS_OFFSET \
>      (CXL_SEC_REGISTERS_OFFSET + CXL_SEC_REGISTERS_SIZE)
> -#define CXL_LINK_REGISTERS_SIZE   0x38
> +#define CXL_LINK_REGISTERS_SIZE   0x50
>  
>  /* CXL r3.1 Section 8.2.4.20: CXL HDM Decoder Capability Structure */
>  #define HDM_DECODE_MAX 10 /* Maximum decoders for Devices */
> -- 
> 2.39.2
> 
