Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156A91D5AD3
	for <linux-cxl@vger.kernel.org>; Tue,  5 Nov 2024 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730841173; cv=none; b=l+AChKWxriXfKR2PLoo3QG5lW1a3DZlF3nLwWrjNiNkKQZzVvHASySAu0hyNYc1Ka2jXhx/pIhuHpF46eg+vAr8SiKoGJypvr0D9y+V0Jz5D7Dzjru3N1aCTOcAEZO7V45sCrFVS8hfbUqurNPUQ3KIGlDRU66v4eqebC/R/72w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730841173; c=relaxed/simple;
	bh=6JwoiYHAs7WX6Oj+ikspeggKqZvlGh5jGIa3cgq2Yds=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5tFw35/lLNUp3P70aKluwSHTDYQnUBfNK3370Eo1al6wk6Efp9JYulD44qyDSLy0voweIItqFQmFmW7KJlKPurDiuKdH3i+ZiFp58qAueBYqURUsvFN/6zVPsL6Oo2/sVKIiWP18SHdk0ofZ4xW6beKz8eil8msNQg5GWsAclQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV5p/The; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV5p/The"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e9f8dec3daso46615847b3.0
        for <linux-cxl@vger.kernel.org>; Tue, 05 Nov 2024 13:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730841171; x=1731445971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAcu8Ypdd9R2EX1w/g4oTXgSQUNI6rVdLhXAOpIdn/I=;
        b=TV5p/TheakpO0qjwH/KzhfqoeQyB5BaQTr90qDYbr1Jg8GIIBG3yysEuV34wigitlY
         uvpYK60pND5NTLtyRJTdm53X0XBaVLrolgQbmVgFmq0giTvZuyrxW7g2eeVArL6I70lQ
         QjzQG/syDgfQs3BTxZjXQvwNLO4oFJmNDQLdQNkBPo0/neoUKOd2G0vcVyOmS0vkonFT
         JE3sA3uxwUlJI53ARVpuY18cc1qFhaYcE/LLEKiAlhZF9xBr+HixHt1N27arks3xX6bg
         +EtHqk4Cp/ZiIR4APvAVMaJ3fWBWigX//Cols8Wwxc7PGZRdyRBRAE2qCE7ReVMK5vFY
         E5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730841171; x=1731445971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAcu8Ypdd9R2EX1w/g4oTXgSQUNI6rVdLhXAOpIdn/I=;
        b=d5EVhfMwQHhdzE5DKdLlQmmySR15Znm5LT45VTuv04FaO4+5n+vaY1sGQX+WyoOR8F
         QR5ozSQl1Py6m4sF/6xbuS3KBM39rmHTSWJDk1jUunXi4vKaptn2EDbiZMLVOz1ta+fx
         f8DA5tccOiuoF+lA0PjwujtHkMJOknIfQp9DZww3mC9nj/LCBvT6vP95f5t/yZXygjsc
         ljVIVVhNx7glWJC46ylNyfMXPcLHB9SimVRO1C9eNhF9jVqq8s5+/6DDjcEIrQxuMdWi
         uV3ylak5C8PqLhFT9Kn2GYj7NDd4sLdhoju/gkBjIg+5U/+71/lKqctYOArHLt4n5HvJ
         BZbg==
X-Gm-Message-State: AOJu0YzVYVLsNWJEV38uXN2CeqZE3/DABEF2QH0lSMrgZeKkvYaf4C0E
	eVbKvmIBoMhIt4ww7ZHUna41hw0l8jiLThIfAf9f7qnqwyZoU6ogtHXT7A==
X-Google-Smtp-Source: AGHT+IFk643dklQFhj2PXQ9UbLSeLqFDjFC19MXl/L7de9yPXDAtuUl1fwSB/pyOuxrtrSUj0sYtkA==
X-Received: by 2002:a0d:cd85:0:b0:6ea:4d3f:dfa6 with SMTP id 00721157ae682-6ea4d3fe2d6mr177261587b3.0.1730841171026;
        Tue, 05 Nov 2024 13:12:51 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55ac9d29sm24582367b3.11.2024.11.05.13.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 13:12:50 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:12:49 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
	Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 05/10] hw/cxl: Check the length of data requested
 fits in get_log()
Message-ID: <ZyqKUSddpuukhrW1@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-6-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-6-Jonathan.Cameron@huawei.com>

On Fri, Nov 01, 2024 at 01:39:12PM +0000, Jonathan Cameron wrote:
> Checking offset + length is of no relevance when verifying the CEL
> data will fit in the mailbox payload. Only the length is is relevant.
s/is is/is/
> 
> Note that this removes a potential overflow.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 27fadc4fa8..2aa7ffed84 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -947,7 +947,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>       * the only possible failure would be if the mailbox itself isn't big
>       * enough.
>       */
> -    if (get_log->offset + get_log->length > cci->payload_max) {
> +    if (get_log->length > cci->payload_max) {

If offset is beyond the size of cel_log, will it be a problem?

There is a comment just above saying "
 * The CEL buffer is large enough to fit all commands in the emulation, so
 * the only possible failure would be if the mailbox itself isn't big
 * enough.
 "

Not sure how it avoids the case when the offset is too large.

Fan

>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> -- 
> 2.43.0
> 

-- 
Fan Ni
