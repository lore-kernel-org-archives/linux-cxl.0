Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225FD2161FC
	for <linux-cxl@vger.kernel.org>; Tue,  5 Nov 2024 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730841657; cv=none; b=nib2ibwq1OceM3tYlPrsAwrEp/kKNan7pFG0G7a904sF5G9r5tVLmh9PTzE84GDeBksWPax7HM7ZpQ18lCcQ6Sw55XxsTM36xG4EjnKXMbcRqnvyYbJPkrqw697cIJ/z5i3Qa5cxd2w5MY9hH4dJ8XQffKC9BrNfFxHK0IFeFVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730841657; c=relaxed/simple;
	bh=WWp5pN2rh+MNVlQ3rHhanY4R9Rbz06DXs+ztaWQtVsY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0pdP014KOWZk6Wg0MkmJd+UOx5KNKjPX0dyb00xzYp+86mMhyoMIOP8QmdTvg+B4gdCQqMSwCMHD9zJVIQxW9YKtroVKVRxxQReDV4n/B/B82lzlnTATl4x967COpsC00PW6fYPAACdbpSx8ApHOUrw1PcZZnBmQVVeAmigZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTWTve/7; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTWTve/7"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ea5f68e17aso59092327b3.3
        for <linux-cxl@vger.kernel.org>; Tue, 05 Nov 2024 13:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730841655; x=1731446455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPiMAN9QIzBPfA7lPqV6M+Nsp42HSnsGy+bCRhwQ8kw=;
        b=hTWTve/737gGQtOZDb9I+IWYdLel66wK2ck4xFmAGhV7yLZgdKY2pr4j/dLJup+Tr7
         QxkZkC0okS7Kt6+DrpgkzaXFm6CBh2+LHknAMVgdCH/7mRqpglvFfY0XvtOl90p2T+ZW
         MPOSvCx+MBMcksAk1cw/USNzD9vhGOMU0sFAuYHYELVg1l1Gi+KPNO07td4Y1tuXXayH
         Eb86JGtmfQpE27iA7tMVYbel6jgUYpx5C014AGIfJMC/6PhG22HOSejZT5CVAYbwUP3E
         QtqS1j8w1tUXRczHLRATiLWE7K7KbRofjK7+m1FJQnIT/hcZeXx8lHu0ie8TP/7a5p+2
         0KDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730841655; x=1731446455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPiMAN9QIzBPfA7lPqV6M+Nsp42HSnsGy+bCRhwQ8kw=;
        b=UgqWdZMvilf3L8NsZGLupeDPR2TLC2XxLKDsRR+/UsRJSzy/MfgGr5i+d0RtDmFcon
         VGtSn5O0HIVFRDDUe9ONu1Wr0M8aD+4JHhXpqU8mJxeFi3ES3FtGgG/4pp1s9Gn0yFca
         LEjQ4O95UhodE/gHgoYtBaKo5swfHrT/O+0HP7MOsuoJ30DDRkkr1zcrfAluF5Nyvx7O
         lOIXXGLlqzNqGLFH0+GKUB/MaBQl+wAK7FYlMa2Hwz95tqM/dbfHpzXdoh68wdsHk6QG
         cY28I+8KHy2YHGsDloyn+ch33lDRT25E0yz+PhVcxOX9zO6xes6K33+bX7l9WRqIQSTK
         jA4w==
X-Gm-Message-State: AOJu0Yz/bWwwejdfaTJ2O8NFrN5I45gWOid3wgnwOKfKtyVBg7X62Z2p
	yMi/7UoY1U02ODGR5p92D3KcaxUMjy1HGXqh/bJFw7pktVO6kwqE
X-Google-Smtp-Source: AGHT+IF6DQRuWsdCA1IjjAnvofSDQXE9T2x0H2s/5eic/WyeD6boHgJTjO69gjSlDgkmSIulgstCYQ==
X-Received: by 2002:a05:690c:87:b0:6ea:3313:f98c with SMTP id 00721157ae682-6ea3313fa4emr280329027b3.32.1730841655012;
        Tue, 05 Nov 2024 13:20:55 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55ac99a1sm24729247b3.2.2024.11.05.13.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 13:20:54 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:20:52 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
	Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 07/10] hw/cxl: Ensuring enough data to read
 parameters in cmd_tunnel_management_cmd()
Message-ID: <ZyqMNCvnXkiwqubp@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-8-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-8-Jonathan.Cameron@huawei.com>

On Fri, Nov 01, 2024 at 01:39:14PM +0000, Jonathan Cameron wrote:
> If len_in is less than the minimum spec allowed value, then return
> CXL_MBOX_INVALID_PAYLOAD_LENGTH
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 5e571955b6..a40d81219c 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -151,6 +151,9 @@ static CXLRetCode cmd_tunnel_management_cmd(const struct cxl_cmd *cmd,
>      in = (void *)payload_in;
>      out = (void *)payload_out;
>  
> +    if (len_in < sizeof(*in)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
>      /* Enough room for minimum sized message - no payload */
>      if (in->size < sizeof(in->ccimessage)) {
>          return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> -- 
> 2.43.0
> 

-- 
Fan Ni
