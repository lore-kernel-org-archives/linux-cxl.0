Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78D35957
	for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611788; cv=none; b=N2eJ8Ybla08tPx9Ef6sD8X7fTEVjQk+EEKvfXsjZo30Vhsu550ktqNe7j1gw7XUthF6h4S2NAM++FCTAU8uSCeA5j4bTPMQm5I7uraE0FoCLdPdcGvY/hDxRKgeEhdYvK/PmfnoaREYDd3O7OG3DIpig95zzJEGPkymzq83fQjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611788; c=relaxed/simple;
	bh=dHi6mddP97OeVxzaVKIjlxOYH3mfkHdgWR3Kb/0b+g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lr73Mrjl/o6IrRxBb/NU4nKmia6P2bGH42tP3awA0ex5XAAiL924IGykLf9rUQiNR2pTBH0j79xAiN8A+DgkNDSmoVoY7jnlMIw5Xrjy2hNIlMQ7cxn8FTJ5XJ4Hl+q2sGaU5i0QY/F2kxj8ElkUBKyD66mzcSwP3R4rNA59Gug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crO4vgKm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crO4vgKm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771611786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LttNL2Bzddd6snzX9FoV/P7CPQ8jBQrN2ar5SQSrW8=;
	b=crO4vgKmMLDo/9/81a5H8/Xp7bYtYN8hEgqVSJ/nTRY5JJ1DUlt6QVj4wku2v/dgCCESa+
	zHibYzx0VgAiNmH6waJrpj/pu2ZHAgTGPYiB08rIslxxXL5Wc96CmUejxsbnQL3Gk+9IV8
	7egfN/weEVbITxsXuPoEL9zvaL0bNUg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-ygavEEG7P5-a1G6J1M-OMA-1; Fri, 20 Feb 2026 13:23:05 -0500
X-MC-Unique: ygavEEG7P5-a1G6J1M-OMA-1
X-Mimecast-MFC-AGG-ID: ygavEEG7P5-a1G6J1M-OMA_1771611784
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4830e7c6131so23424185e9.2
        for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 10:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771611784; x=1772216584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LttNL2Bzddd6snzX9FoV/P7CPQ8jBQrN2ar5SQSrW8=;
        b=TaAulfoBVDzVbfC1AhmWtj9l1hjWq1IOkWrx8YjUe0DxNZXsTvmhB5XhzOPInY09Hq
         G3KAi8p4d7lw/YvmJHTF6mTf0hg97noAoSfhkCXceC/WUYcrbA7SjbynXqDoH2TpAFgd
         PU4+3QoFaO4Asv7gbm5lnFs/BFARvWQNIkJUPJPdkq8yScnWv+UskKkt3GLzu9MkjeSa
         8K3ssZuMle8lxpDUXLk2BzVbMztcoh4gHe6CdD+DTHClD+hZo61sCsWCe0ULWXjvVZcl
         qV3F+7FwqBS/H/zojzQleytgWfLpMdjWM3mGDMjQYCcJ2SEzS8m/1ryEv+BKWXz+Jj1U
         FqyA==
X-Forwarded-Encrypted: i=1; AJvYcCU0/GGhERgJ52KgQaOLWpWmQXf3FX7LWEZ8PpZUDVCVga66ZMu9JhQ7AyspXdw21rPu4e7RIADq6xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTawE8jRTsgrerOsyqkq9MZX41c0O574P1EhDbMSJWZHWfRzK9
	uuSqyDNrMp5jHgaD2672Eu7BUlJ6uDlCDY6qtF+ZgkiZgota41zmI/AkNWN+RFVu/yeyaSHB3Wi
	XTCd3YHC+oXiXNFFRvxWM5VIjmp04T9qRtG48+b8c8iLwGv+6xjpAB5wLcMVmJA==
X-Gm-Gg: AZuq6aKYL3hrhDl3/ovGIOGkNvxtJkLw0S+Ek+bABbGGkbiUMxe13bcdExgvQD1u3qZ
	UX5419uwM5HYnZwvivsC1KyF1xfIpAIL9UpISPdi7pN0ubUTmYSjGETgDboO0cTAXrc5YaKnlN1
	5pvNSJ+orL1ZnWAiYwE1geDND6sMJkIYDhE6/CoWL84TEohHt4UoBYL5r7kUSaw1iLHUZFZXD6Y
	fWvydsCEWIHCwrOkLnjsK/jHE1jImLe/FIE8Fpg7iVAM+rMDVfiftN6nIjUKsDKiImp9tVe/PIr
	HjnB/ZT8tYvsY52D1MrPq0m/G44go2q62K/b/S1+/QDsPZQ74oeDnQjv/PriQIZksSNnNLm5bku
	99yrwikdkJtjsXi6glN/HwDcbOlTzyVfv62KfybtA7jUnTg==
X-Received: by 2002:a05:600c:8b01:b0:480:1e9e:f9d with SMTP id 5b1f17b1804b1-483a95fb247mr7138345e9.8.1771611783974;
        Fri, 20 Feb 2026 10:23:03 -0800 (PST)
X-Received: by 2002:a05:600c:8b01:b0:480:1e9e:f9d with SMTP id 5b1f17b1804b1-483a95fb247mr7137935e9.8.1771611783505;
        Fri, 20 Feb 2026 10:23:03 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439567aad3csm24228623f8f.36.2026.02.20.10.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 10:23:03 -0800 (PST)
Date: Fri, 20 Feb 2026 13:23:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Davidlohr Bueso <dave@stgolabs.net>,
	linuxarm@huawei.com, linux-cxl@vger.kernel.org,
	Ravi Shankar <venkataravis@micron.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v7 1/7] hw/pcie: Support enabling flit mode
Message-ID: <20260220132238-mutt-send-email-mst@kernel.org>
References: <20260204170936.43959-1-Jonathan.Cameron@huawei.com>
 <20260204170936.43959-2-Jonathan.Cameron@huawei.com>
 <20260220131854-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260220131854-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Oet7ioAkA7Ua7nm14dwKfvvid8RyAjQNvFlq2RHGtCk_1771611784
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 20, 2026 at 01:21:12PM -0500, Michael S. Tsirkin wrote:
> On Wed, Feb 04, 2026 at 05:09:29PM +0000, Jonathan Cameron wrote:
> 
> ...
> 
> > index 85694707e2e4..3c7ecd8c48bc 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -405,7 +405,7 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> >      dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
> >          .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
> >          .ctrl                    = 0x02, /* IO always enabled */
> > -        .status                  = 0x26, /* same as capabilities */
> > +        .status                  = ct3d->flitmode ? 0x6 : 0x26, /* lack of 68B */
> 
> 
> would be clearer as:
> 
> .status                  = 0x6 /* IO, Mem, non-MLD */ |
>                             ct3d->flitmode ? 0x0 : 0x20 /* 68B */

(ct3d->flitmode ? 0x0 : 0x20) naturally due to precedence.

> 
> 
> I picked this patch up, comment fixup can be a patch on top.
> 
> 
> -- 
> MST

