Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E3E1D9A48
	for <linux-cxl@vger.kernel.org>; Tue,  5 Nov 2024 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840670; cv=none; b=lpDrX6ERui6CF67yCu8k3KK3j8cKJn18dVKgkm4TZK16+6A5nv1DIdfde1PGbgzystvCLyb1zZIN5675hTKPC1FUNL/LJst5w3xCi7JZEv3HhyUOQOWkcisffUorzxcITkbE6oHYheuJrDWr8mgQ8zRI8jgEZXjN2tDptaBvmWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840670; c=relaxed/simple;
	bh=yin+6jSAIZSsBrDemjUmVt97T1rnRLctx1cPZqapCQI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYQp1sbwvNN4yGDRRlh926Cq+maTdVyBNM73gCZmpKAhnI/qoMxbdFXxL42KzxMgJTZyg7WIi7MuTFBkhU7FDLT+kn2xyRWbOC01mWQZu78k5ww61akH/y/OisRe+c7yhImuIr/lS0K1x8S3UuzizyroOkJSyEMkcUJM46enHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dph5NDeJ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dph5NDeJ"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e29218d34f8so185295276.1
        for <linux-cxl@vger.kernel.org>; Tue, 05 Nov 2024 13:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730840667; x=1731445467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=noY2bbayWon0kk66SxDlIazndIr82AwdxwcFGXTlqdc=;
        b=dph5NDeJDzC6dt/6aBd3ZwKXsyDPFJNku0twG5gmhPdkFkb8z/fWS0ZrPOTfBap8v0
         mqW2bBSqVcxnuYcS6DtCUqgQ6gFs9BJoLyOYr6C4uis1ZZAvtoR+iPPTRoU1wmBoGMme
         3LI+1xeGeZm14VteVrBRpVuD3pEIG3UKIc1b5Wyz8kI5X8lwSYc0kj7B8x8NKe+R3+IE
         yGbk9gehaiSho389lCB/cJgIgsUfb2+bEX9VKpx/oanPg+tYK+LOXIpc2DBFbwjnS+8W
         2qUOmD9pe1OiuQvxQ68QbYPxizWGrrn+wjCt7MCqs0uv6La71WX/+lN4xdUlD47LQPEq
         6qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730840667; x=1731445467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noY2bbayWon0kk66SxDlIazndIr82AwdxwcFGXTlqdc=;
        b=TECZ0jAkyW/GgInS2y2A2FSuAP71ci06k1DxcsMwnpRvHOSiDb6cOyLXfNd3yK3Upu
         TFpgMb+oKP2KE56CK+wwVM2uLChlAw/f06V9dQGjusZAK3D65KyzUQl9VgW3gfBwM2/e
         OfV3llsdM1mQ/024CMgtX1obf0CvvXQ9RjPFhhf+G5sqXR4Eexg+UWK6VauZy0msC/Ss
         m6C8sUsz+2y6ITO6ahwIJ5vVmfTWB38qklvlFlRaOCRTv4kYWFy9bIV37sIpSfbRP0dX
         MRgxiPktB43nmaWdzdJtOmJrhTKwiM4Asr/k5m03XHK5/GbnRRa1ggj9SSJakzA5hi07
         4gHQ==
X-Gm-Message-State: AOJu0Yxr9tSW7e4y+sFJbLNayPFBEWCIV0OYbnTBKPxzQc/Vh/HZO4/y
	J+fWgmt2LyEjw3uHTwRqbZW4pHYnnkGeGiTVhQz8eczcNma+M3Ge
X-Google-Smtp-Source: AGHT+IFbm8n9GmKArvIQ1qteK4fLi0OpvBJrYmhg6D1YhI9wwIBUjaMq6jBRxc4GkqiirzMt5RBKIA==
X-Received: by 2002:a25:5f11:0:b0:e29:7e27:dad5 with SMTP id 3f1490d57ef6-e335ad7175dmr44845276.23.1730840667499;
        Tue, 05 Nov 2024 13:04:27 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8adffd8sm2601283276.60.2024.11.05.13.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 13:04:27 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:04:25 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
	Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 04/10] hw/cxl: Check enough data in
 cmd_firmware_update_transfer()
Message-ID: <ZyqIWRP_ynMsb34n@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-5-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-5-Jonathan.Cameron@huawei.com>

On Fri, Nov 01, 2024 at 01:39:11PM +0000, Jonathan Cameron wrote:
> Buggy guest can write a message that advertises more data that
> is provided. As QEMU internally duplicates the reported message
> size, this may result in an out of bounds access.
> Add sanity checks on the size to avoid this.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-mailbox-utils.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 3cb499a24f..27fadc4fa8 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -705,6 +705,10 @@ static CXLRetCode cmd_firmware_update_transfer(const struct cxl_cmd *cmd,
>      } QEMU_PACKED *fw_transfer = (void *)payload_in;
>      size_t offset, length;
>  
> +    if (len < sizeof(*fw_transfer)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
>      if (fw_transfer->action == CXL_FW_XFER_ACTION_ABORT) {
>          /*
>           * At this point there aren't any on-going transfers
> -- 
> 2.43.0
> 

-- 
Fan Ni
