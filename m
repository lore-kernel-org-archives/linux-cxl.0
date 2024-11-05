Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D3383
	for <linux-cxl@vger.kernel.org>; Tue,  5 Nov 2024 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842591; cv=none; b=i1G6XzYzRfWADTEsT5qgDbBUrJjciVlL1J12+qaFl27RTX616uLCoBD0KN0Ex3XcdKJ3iwTiVKCjalP3fIBa60hxMCO+k9MAAmae6mOTRvyYaKHS61ehHcZA7QHMnGcq+2G+pqsWkJnyV4ACXqNW6v5vwupX8KSyZJua3Kzpkh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842591; c=relaxed/simple;
	bh=e1x3FvAU4dvwXo5om4ZQBFKI1RhBVUGsffQaiU1Of60=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pygeKjR1fG5T+Y+Rvx6LPUWyorNp2fiUAvNydu4iq9Xml8bklMQqntj50Im3A/U4H5aIB8iMlRNeWTCezr2f3yHr1beGVuY7Kk5s1joWawAfCeyTj6yks5wQWJrbIXRTnE1P+HQZER4/X/BduzDnD+WNw8ealyZTto39WkerOuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ify9FijD; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ify9FijD"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso7584607276.1
        for <linux-cxl@vger.kernel.org>; Tue, 05 Nov 2024 13:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730842589; x=1731447389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4wfVOsn32GqzG6pxswvFxXo8voam2CLSZwUERSSj1Ms=;
        b=Ify9FijDoTPrFxxwovAv5Q6l1hC9doRnmyO/L74LA9GP3OmWsICJvm7+RTWc4R+P5/
         A4i5+J9h2Hh+Vd1jMQsE203FUQQXbgrmy4Pc7HrR0upmHMrQ8iiCo92IUqSZ7DGsG6+L
         ZHSVAQkb0aGPmRyF128FcAACyWKz0+Ldpp+OTghiIHmvJZNzBgm1P80RJmWTGx2XNz3d
         0QvS6+GjfU6osP9TUeC/onwCjOHEJZGkYoarFvlhFgxHlZxB3Q7pmPIEnzwhnFhDN1W/
         clN3sVT1V9SglQCR0y5jiUF4vlgDiuSSrRejNj+yIBiREl74V/PqrG2vW4sa+J3PIS5s
         mWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842589; x=1731447389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wfVOsn32GqzG6pxswvFxXo8voam2CLSZwUERSSj1Ms=;
        b=XnHsYgzCW1JlDScfvsafaNzZkscci3DqcYwsBSMo+gfXqh25JJXJa9INByX51TR6ou
         +yOK0nnb7P8Sw3s7lS8efek+t+1Ixpna/kMNFhGdcLhw8ecoe/XSTHCloQufBEVubr5b
         T+dIU5C6V2Eu9/iX79wQL3+r4XAfFvswbkef2aHcuuXy15/8CyDpjIoyIQC3eD3teskl
         laac2kNEpwIfy8RdqCwioltLMjNU3AOX7Su83mywj4+u58lgdFlF5EEJVeSkkRAUJCZV
         yzolvkV6VoHCmp/huApZukp0RaFVMjS3RUa3d1lAW1/a+ctdNMGW4qBPOKbv334tbjvW
         dDeA==
X-Gm-Message-State: AOJu0YxRFdIizO+8my9wJLDWLtP2UZdjN5gbWC3lLPuleWf1not5v7Nd
	oJeicXm/4YKP1U+dikSllTJ9Zb0JaODw8vbldj6vMrwRNDphKbtA
X-Google-Smtp-Source: AGHT+IHTcyp+hTCKXTQM8NURjWdb/wybDjQkaoPQbm0ljzs2ehicrb9RiwmQ6/ONHVDLwyN4FwVQIQ==
X-Received: by 2002:a05:690c:7201:b0:652:5838:54ef with SMTP id 00721157ae682-6e9d8b5144fmr400605567b3.37.1730842589160;
        Tue, 05 Nov 2024 13:36:29 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea8d4ba90asm13781577b3.119.2024.11.05.13.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 13:36:28 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:36:26 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
	Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 09/10] hw/cxl: Ensure there is enough data for the
 header in cmd_ccls_set_lsa()
Message-ID: <ZyqP2upw4OqN1k0q@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-10-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-10-Jonathan.Cameron@huawei.com>

On Fri, Nov 01, 2024 at 01:39:16PM +0000, Jonathan Cameron wrote:
> The properties of the requested set command cannot be established if
> len_in is less than the size of the header.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-mailbox-utils.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 078782e8b9..f4a436e172 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1503,8 +1503,8 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
>      const size_t hdr_len = offsetof(struct set_lsa_pl, data);
>  
>      *len_out = 0;
> -    if (!len_in) {
> -        return CXL_MBOX_SUCCESS;
> +    if (len_in < hdr_len) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>      }
>  
>      if (set_lsa_payload->offset + len_in > cvc->get_lsa_size(ct3d) + hdr_len) {
> -- 
> 2.43.0
> 

-- 
Fan Ni
