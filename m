Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619FF366062
	for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611677; cv=none; b=PJpo3VfijHgh7/7w62RMf2CHXT7xMEaJChDvA6pAIFPIUVDQdT59fO9ijJcsHZzHxMwQeNIhRam9kNH5rsAJbMb8XMfcNCHDDvC9Yc0BZYIyFUp6DDBBtTv23zRWxmKSEVBFvOM3z5bw507vOwpK0b89Am8AqIQtdQ/HABc1uUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611677; c=relaxed/simple;
	bh=qFJZakFFpnYqljueuCfjOz5rho1nIXeG9EUVTIcC6bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iIW/HXRApCP7HibaeicYzwwRUAmg77ITKJlapWy+GAn9/NgIXkJImKstEvlDniDyVzx+FlOxcX2RVqlIHaabWlGo64HEz/TSg/Sh2WgkQArvS21SHKxq2hudjFzwfGtWDxe/0yU+koCkZSBe5ZMFCx9+Jy8bMHLgn+Ebm6teRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJDhjN0W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJDhjN0W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771611675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qx3KqccoVD+buOQJFSsol/WxOhpIJq+dUsmxkc+v/TM=;
	b=TJDhjN0WCxOeU+ppEcvgc8OvKIJXn2XcioKd9vxti2H0lEeAn+GqFyszhQXH1VQ0ZVWXnR
	Do6n8Eug4GffuILVHiMg9/2rgqKOBOHGQhoISuBRFUKHF+2oVuPxRo1cN51to3ug3bUjqr
	PGN5fhz+zpwOq0zi/BBJit+JxPKpFoc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-L3N2dcMEP7SvzbrQcVflMw-1; Fri, 20 Feb 2026 13:21:14 -0500
X-MC-Unique: L3N2dcMEP7SvzbrQcVflMw-1
X-Mimecast-MFC-AGG-ID: L3N2dcMEP7SvzbrQcVflMw_1771611673
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43768240a29so1776078f8f.1
        for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 10:21:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771611673; x=1772216473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qx3KqccoVD+buOQJFSsol/WxOhpIJq+dUsmxkc+v/TM=;
        b=u3Vpk1u9vCzGDs06HRqLbBWMERLCNq1HfPzcq6f0/yq81I2e6GEcH1hhbMY5+fvnvA
         lI2cZpPCqHo7bXNo3beQkXnJ6Rvaa0z4MPwF7SN7AYYxOjFF2UqfOWFfWcY+GktdoTSF
         N+a+DbZLkAoAh9pVDdsUehhi6OVqtsN1RulJCz2B1nZ63K0v+tpibGkgGMGOi6ce9jjI
         Rn74aGvWSyc9+i1thTfy9O5MwUI/8gFgic5Q+wpAkL050JyagKYgyitM01E9I5RjNRmH
         yuiPh67hIlOqzfITOZpge9tFqJ0hKGY1ORv09uylJyBKrC1fSH87zYh1FW+g3J3i7xOg
         cCcA==
X-Forwarded-Encrypted: i=1; AJvYcCUf+agjKQBJHxihS3xZZEcElBj244WO9b71443Q5sVZOVJhEOZp0NaetZdS6eJGWftggqFCyNEMTZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpFhPrHb2cAkDfiebAIJ+jBHf85aVRGPfF4GhODTxO85YXKAoR
	QWrj+nAPecdzpWA3XQPolKPMbStvg450wdWuDARW2xGbJ70mQNgmrReDsIuVElSOXXHoC3ql8T1
	4Q64FfO6oVpWLMdp/efZ+tJkFjzJ/DaJxUh3NcmdMwirLbyrDDahYPXzEbO/fDg==
X-Gm-Gg: AZuq6aJwlZkDtbJnjWYcgxooXajbQYS2MA86kkxUGcg4zPP1kw6PKxbMop3M1u0SJ1E
	IYpDVPihiyh84OmH58ePFXSfLJb5NpTy1rTQ8oa6ZMXx8UHXn3r+xCei67/0TRw0lR6685SqjDh
	UkeuFJHNIZBPjoj2Mv1qDAIqd1G0LBaAAFakvO183Nc1Xcyf4X53Pm+UMvTCTXlXM1pSbkBrIok
	OZAlFsU8Q/Ini5wkWLQECNgAGzgr4AA20otIXLWPezULma3JWSalHaOmAtWn0MiXC3QTosFBq8r
	BdGQ6qhQmMsbNCGVjq8/hnHJ1/ShterN2L845VD3sZJQvAg/fDEVdEkavHd/z/bLrM21si1xrIz
	zdNIm6EoGitkRXvB8IsrVwjaKSgusEzsXCuWLclAD0GvGwg==
X-Received: by 2002:a05:6000:2405:b0:430:f593:aa34 with SMTP id ffacd0b85a97d-4396270cbedmr12077059f8f.17.1771611672583;
        Fri, 20 Feb 2026 10:21:12 -0800 (PST)
X-Received: by 2002:a05:6000:2405:b0:430:f593:aa34 with SMTP id ffacd0b85a97d-4396270cbedmr12077019f8f.17.1771611672144;
        Fri, 20 Feb 2026 10:21:12 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abd259sm60474336f8f.24.2026.02.20.10.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 10:21:11 -0800 (PST)
Date: Fri, 20 Feb 2026 13:21:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Davidlohr Bueso <dave@stgolabs.net>,
	linuxarm@huawei.com, linux-cxl@vger.kernel.org,
	Ravi Shankar <venkataravis@micron.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v7 1/7] hw/pcie: Support enabling flit mode
Message-ID: <20260220131854-mutt-send-email-mst@kernel.org>
References: <20260204170936.43959-1-Jonathan.Cameron@huawei.com>
 <20260204170936.43959-2-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260204170936.43959-2-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 62rKVhQDNc1_08E94XbUI5cghs6fLA7lkDY2zkLHXCg_1771611673
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2026 at 05:09:29PM +0000, Jonathan Cameron wrote:

...

> index 85694707e2e4..3c7ecd8c48bc 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -405,7 +405,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>      dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
>          .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
>          .ctrl                    = 0x02, /* IO always enabled */
> -        .status                  = 0x26, /* same as capabilities */
> +        .status                  = ct3d->flitmode ? 0x6 : 0x26, /* lack of 68B */


would be clearer as:

.status                  = 0x6 /* IO, Mem, non-MLD */ |
                            ct3d->flitmode ? 0x0 : 0x20 /* 68B */


I picked this patch up, comment fixup can be a patch on top.


-- 
MST

