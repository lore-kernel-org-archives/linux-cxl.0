Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662214A02
	for <linux-cxl@vger.kernel.org>; Tue, 10 Sep 2024 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988088; cv=none; b=sKegqixPE/ohE9Rn0JrE3VxY+R2okYZLRIZy6y5b6cztPV66Gs7Nquq+X0318YnNnxWOWPIqYiB1X/o27RyFV9Xnp3wu4K+FaZ6LfKulJbOTqSd+/U2DztAt0FmeD2b0mVMbnh27MFVLDKeNOusMG3aMIKjsYMPou0subA8OBIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988088; c=relaxed/simple;
	bh=pHOglaS18I3HyGyi6xCNZBAiukRKyALg8bzIIcsayC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XBzxX1XRPXY4QGlyf2XRHRJJV/wUR8Asjt98i3x1BBbxsgcTBFHx9XSThtpa/DGhXiB6Ql8fodid00oko9w/7PrGPBEcaStbQdXfAA4lt8TLQotKzb6rmt7EZnFajoojVn/t/rOLBEQivh2RX/htMyUZOLAl6MAFaF3h7xdkXLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ef5duaAf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ef5duaAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725988086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lf/Qy2gveqzzeUrPleD6Y+arIZhOGK7DpbQVzYwI5co=;
	b=ef5duaAfm9KOZ6OtSfo3cu2TQwof2zPIuT8G90DjGUguK+7Y7UHQPuKbFLSvMYssAWvC20
	NgcJOqrLnywyLTzrTsBabWO0goCY6y305BbSGGzxLuE1SJJduxHUq/MOQDEKmdQ9skM+MV
	WRWThpuCsNlLW0eIGGr+vtFBSns8NJE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-RHcaze9kO5KqUw1UkHTrQA-1; Tue, 10 Sep 2024 13:08:04 -0400
X-MC-Unique: RHcaze9kO5KqUw1UkHTrQA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374c434b952so2715630f8f.1
        for <linux-cxl@vger.kernel.org>; Tue, 10 Sep 2024 10:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725988083; x=1726592883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lf/Qy2gveqzzeUrPleD6Y+arIZhOGK7DpbQVzYwI5co=;
        b=DsH3zIlQ61v1dbJ9IA9YevwgdesdL3F8/kuyJj2PQkH9+bSmWJl7T/S/UXwwXshpYz
         mmkeO8UxUji0B9eer1WV2+iN3+Dsk7F+O61Trhn6uFUSNngQI3Sw3xtwjtiErs9JYpYb
         eknz3M4YsJJ4hoKQhulDYOsdqxvLT8N94nMJ3lL+EF+7ck/QWLrn+atgR3KChhAj8uVS
         GGeQ1fTi+VJYi9Tx+fpiIsk6Kg3a4IEe6XTuJw1eVH+wuII5EnFeYAOCmntednfuBZ3T
         jT6zKa4lBfk/j1fhX3ClP3Oc7KDbOq/U0y1dFV79xe2NVCzXBiw7w+i5GHV3FCw2mIQ4
         04mg==
X-Forwarded-Encrypted: i=1; AJvYcCX1hN5sKV9ltvR+1ZWhfSVqN090xC1obPjIkk+9hbFEunm5UoPFhzkKlRVfska49RGl8pU8aaj9I1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YweBsnHkN5t7XQHzcXTVqDCaGnmq/O1BcmYiaNeoJS2+kbWyYcx
	XeckVR2xnPEtr8+6fMo1mx6kxAoSn5KGbvrNkEGpBeBEKvrAtMD0vf9eCfD+jWqSZ1EpdTXqtLF
	e+mTjwKqB8oGcXJn6ER1QYHB5rZZed+R5ODbhXfY/sCuF/jOvim8kgY5+EQ==
X-Received: by 2002:a5d:688f:0:b0:360:791c:aff2 with SMTP id ffacd0b85a97d-378896a3f79mr10470593f8f.47.1725988083100;
        Tue, 10 Sep 2024 10:08:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCiXROo9SdEae2cmc9J0aTNuzdcQ6vj9HYigfI6Hd+jfjlRutmvJOElKnuCtfTGLjArCBW9g==
X-Received: by 2002:a5d:688f:0:b0:360:791c:aff2 with SMTP id ffacd0b85a97d-378896a3f79mr10470571f8f.47.1725988082442;
        Tue, 10 Sep 2024 10:08:02 -0700 (PDT)
Received: from redhat.com ([31.187.78.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675c11sm9382991f8f.55.2024.09.10.10.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 10:08:01 -0700 (PDT)
Date: Tue, 10 Sep 2024 13:07:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: ajay.opensrc@micron.com
Cc: Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
	john@jagalactic.com, emirakhur@micron.com, ajayjoshi@micron.com,
	sthanneeru@micron.com, ravis.opensrc@micron.com,
	arramesh@micron.com
Subject: Re: [PATCH] hw/cxl: Fix background completion percentage calculation
Message-ID: <20240910130723-mutt-send-email-mst@kernel.org>
References: <20240729102338.22337-1-ajay.opensrc@micron.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240729102338.22337-1-ajay.opensrc@micron.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2024 at 03:53:38PM +0530, ajay.opensrc@micron.com wrote:
> From: Ajay Joshi <ajayjoshi@micron.com>
> 
> The current completion percentage calculation
> does not account for the relative time since
> the start of the background activity, this leads
> to showing incorrect start percentage vs what has
> actually been completed.
> 
> This patch calculates the percentage based on the actual
> elapsed time since the start of the operation.
> 
> Fixes: 221d2cfbdb ("hw/cxl/mbox: Add support for background operations")
> 
> Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>

Keep all tags together with no empty lines pls.

> ---
>  hw/cxl/cxl-mailbox-utils.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index c2ed251bb3..873d60c069 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2708,7 +2708,8 @@ static void bg_timercb(void *opaque)
>          }
>      } else {
>          /* estimate only */
> -        cci->bg.complete_pct = 100 * now / total_time;
> +        cci->bg.complete_pct =
> +            100 * (now - cci->bg.starttime) / cci->bg.runtime;
>          timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
>      }
>  
> -- 
> 2.34.1
> 

