Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525FA389E07
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494907; cv=none; b=aE0DV0lizcrXdQJauYQhSsCfzWNp+KODp7wx4r52Lb5o6LogifBY4qp+paDLElk3547sbC9Mk5Kcjn1wy1zvZYS1kDz+zwe6nVMVSyey7fSzxti/iALisJM/E6sm3eo8/KQUfvdretOGLGvzpswcdPoh3C3FOhEIDLfoFJH8nlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494907; c=relaxed/simple;
	bh=hdtUKyG3EQZLjxTWr84JSsClsYqHszuDmDiyAcxyI4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NyWTvnA5tMVx2SQkxGgxesi6sKQaYPZcT90mkCPBJGi8I5CM4am6DA7xrqxwFKZdIZ0l3QlWJGdHLylEK7tErt04H1wLfv7Szzh6jzF5N7YlhivIHZ7vgClsGo9UspC8v1tGf1U4PzqT+rHA0WK20zv2x0Bgh79BZs0EPzUmamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OdR41IGE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdR41IGE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789494903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isG/UafLGI1WqGN/jYrgbdMUzSDVyDgdbVXFdCNZheI=;
	b=OdR41IGEmzp3GdJgBYziacZitNgmahbDmQbsxiEhq7FM00A2fPoSovWrB9rKngrDqWqpzg
	Al3QtoBEV836L5nVKsTYxFyIqHnTI0Rw/AvjsnxsZXx4wbNZw8u38iGPpa6MoG3aEocEdZ
	b5CrZZ9dOHoxhyAuYCxk8OgUpgN8nzI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-rV7c59QbPgyhx1f-br9AwA-1; Tue, 15 Sep 2026 13:55:02 -0400
X-MC-Unique: rV7c59QbPgyhx1f-br9AwA-1
X-Mimecast-MFC-AGG-ID: rV7c59QbPgyhx1f-br9AwA_1789494901
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cf5bd2f12so50041705e9.1
        for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 10:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494901; x=1790099701;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=isG/UafLGI1WqGN/jYrgbdMUzSDVyDgdbVXFdCNZheI=;
        b=OzBVhc3jn9AVmnxiimnEATnlq4BcDWa3IsBY6oU612C5gQN6WiEPHOYGxCZhAWjOWX
         qYBPKu5eZWSb7D3VqzQac9T5kRjr0Yp1T1aO0H51uzzArar/lOQJFzpNQGfg4k2UWCRc
         Ju2yd5g5JjSucj4y/Su4YcOmcjOe0W57xx8P4N1GRRyaZu3a6m9wNLP1Ec06f1Xx0EoH
         ptw2fhWamnpbEYLVKqiCCLxUpCVC2SKOZT5VCn4UPUsT6UlKr+XHzNroJlWA6UEn2Y4s
         /kRltWovT3RSLF/20+BRN23OxKK4GuFGn0qq9uTmS66IuFXAuryNAsdi1h3uij/jl/Cu
         QVlw==
X-Forwarded-Encrypted: i=1; AKwUvBxWD6DULCgRo93nyhjrEKvI6x2slRnb1D7SlxXVDKGgBUoxlmrMAc4vFS4vR1Y05sRIuD90F0RGiAs=@vger.kernel.org
X-Gm-Message-State: AFuF++lNNGnb6yyZIQb5M+yAEQWJh6sjBcYE+VHh/YYJglxCeUwj+Ggj
	yN+NbkT200Avv4BeZL4dyrsS0xJdRz9arI5HHd0oAoSpW951XcMjqZ8zg0EnAeJR6oAyO/l5uTS
	qzh9pduCe1La0g9pm5CxXRxDz2tYeSQ8o+WGPTK2qT6FWDJ7B4WlNoRAXOo7CbwnwuLLXNg==
X-Gm-Gg: AYBFou0EuoVJx39pUy4bGG00/XQNWLXCsFXKoWVMeejL2blnITNVPq7NSEBeLCKEsSH
	ADhOFu9wiW0NVs4Ke4/FWvVkmDK/5FefZowqNN2gO77UpWrhrSVemL3F/6IrawJ58RdVj/GVn15
	03OyH+i15vRzi3iYeH2KRn+Z4ns5wiXCGhfNXxUwx+2Z/ft9sNTNxxZpkNe7pu6AApSIQWgiNh6
	si/PuSkoVKZhL7N2SXbXyl47Ni3UCoKPWa/eggk+QAAoEDsNCoRLeaPTwLu/Ib2clSg+onfuIjH
	dOtoCW1FthPfai5FeCAN3NFRrM/Gw7lC9mI3OS8L2MUnl0o/UOIRU4JGJf9TPDQOOcVCgzmFR1z
	yFdBYMpf6IF5JXd1Q9/fryUE=
X-Received: by 2002:a05:600c:c168:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-49e7a662e89mr100913825e9.7.1789494900966;
        Tue, 15 Sep 2026 10:55:00 -0700 (PDT)
X-Received: by 2002:a05:600c:c168:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-49e7a662e89mr100913515e9.7.1789494900520;
        Tue, 15 Sep 2026 10:55:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83d903f6sm6702965e9.4.2026.09.15.10.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:55:00 -0700 (PDT)
Date: Tue, 15 Sep 2026 13:54:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org,
	jonathan.cameron@oss.qualcomm.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Junjie Cao as CXL reviewer
Message-ID: <20260915135403-mutt-send-email-mst@kernel.org>
References: <20260908042310.493882-1-junjie.cao@intel.com>
 <20260915184056.44f30b8e@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260915184056.44f30b8e@jic23-hlaptop>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ouiIPjyTGU_Mmfw4I0uy--w9LRE0sC7g78nMiaNYs_U_1789494901
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2026 at 06:40:56PM +0100, Jonathan Cameron wrote:
> On Tue,  8 Sep 2026 12:23:10 +0800
> Junjie Cao <junjie.cao@intel.com> wrote:
> 
> > I have been reviewing, testing and contributing to hw/cxl for the past
> > few months, and would like to be Cc'd on incoming CXL changes to help
> > with review.
> > 
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> 
> Apologies for slow reply but for the record.
> Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> Thanks for helping out!
> 
> I'm jumping through hoops to get a CXL staging tree up under new employer's
> github.
> 
> Just waiting on what I think is final step so maybe have that done today.
> 
> Jonathan

great! just to confirm the things you acked so far you will repost
as you did previously? if u want me to pick something up out of band,
pls let me know.

> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7183babd6a..bbabcf8cca 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3328,6 +3328,7 @@ F: docs/devel/migration/CPR.rst
> >  
> >  Compute Express Link
> >  M: Jonathan Cameron <jic23@kernel.org>
> > +R: Junjie Cao <junjie.cao@intel.com>
> >  L: linux-cxl@vger.kernel.org
> >  S: Supported
> >  F: hw/cxl/

