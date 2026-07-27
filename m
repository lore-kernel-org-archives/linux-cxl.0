Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC62E7391
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181019; cv=none; b=LKbfr1fPTukxSctSYjWyrPXxndBhxTFQ5Lu4Y1JpgZzQzamZBjt+XvFd7f6Y/E/FoY7muwNY/iQ/3bqK19SM2851oOJDPXeNWXI0PBUYbrHucXWkKQOqRXiScWBpcCvgy6qryd3uWk5hGS/W622IfVEBC/LB+mAyGRusHPtExJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181019; c=relaxed/simple;
	bh=JczSnD98rIP6mTuesYNHjTWch89iviYdViRwxw5CuNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ah4Cjv8cYMdV1sM5tBZdSoU9oFnhk/Llh4WjiH8P5T149l3Io4JFqDkZJ6ig4MA7PFPUebGNUZYFYjkcw9xHbONH18NiEiWM0A9DFSQnJ/y0Xyhmi6v1lsN4cnkNXQD/oO6wFyIi6chjs1/GeIoGH6Rr5VT9P82RDX0e6AXTutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUQENw+c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUQENw+c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785181016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8enDtt8cqW6+NfaeAchD/r03eS4yL17OiwkOLzPRv3s=;
	b=ZUQENw+cVJ2StZ0N/bk6cJpl/LacvdkniXTWJavgwv1oozsjFFo3B+NcRKJf9me86E20ug
	Acr4lgoDjdJ76Qfmdvd2ABB1zeDl7GFHnqr9f8WF9wSMMlIDBpcveuE8LZv9gSi55mrBIF
	uKlUJDt1uxmbZEfizLYBPsr/J9vw0wY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-NjmKU0s_PTyxJKqzrfqEgw-1; Mon, 27 Jul 2026 15:36:55 -0400
X-MC-Unique: NjmKU0s_PTyxJKqzrfqEgw-1
X-Mimecast-MFC-AGG-ID: NjmKU0s_PTyxJKqzrfqEgw_1785181014
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-496b61bd846so21198935e9.2
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 12:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785181014; x=1785785814;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8enDtt8cqW6+NfaeAchD/r03eS4yL17OiwkOLzPRv3s=;
        b=WsXjnMXGyk7WFrvbE0cWjx0Qe9uq05MFKGCFagzwaN7wchfevbYRIKFxJtONM9a9FE
         UXEBzXjTHYrRdBDsyCQdE1Gxnx68hbCG47LEG2PJH6WhBXliAp3ATMHugvXdw7CC2fNz
         3PmqtyXB9KXmkGyIRm/tbSIXN87DSNSBhnSV4bZHmf+n1ygGvYEUxRRXnn+DbhQG17/L
         MVYTC69bfwKVRK8pEEU0CFDucQCdYT4CJckpSy/q3U50vcYUVMrQVgGlVFl+1JBGeIbE
         fv1xBeKfJuIald61pJUHL58LWOkKONX4PhgKDRRziWlGyIiSZtWL8PAjqmCFwBHpU3N3
         n4sg==
X-Forwarded-Encrypted: i=1; AHgh+RpwWLY5i6yGgqw+WBnKVBkCxBsID+9rF1qRlAjCoNy3pW6YgLECJ/Sg7aptjAomnaE2BCmtRSA0hac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvg5yGcnUKbly0Pfb2Ik6WjWgRHoax//SkUL880XfChLU4rFTg
	Kvnbpt3sqbOGBnOTx5BHJZwRohKU/1vkCIeRGFlBqqs0VitVIpIhqfO/SJVpOVna/wjO93GYRFD
	uWioGDSMpYG9jrY5OnFtAMsYm6yA5IK2q1K9elTS74wWT2TNaXBVYjTbqia0u6w==
X-Gm-Gg: AR+sD11clB+a6pKznxfWKtmzZGXTgaLzuUUTPZRA7bnuxNSDg5JYS/LyevrEKUBTw/p
	KHF6PpGc71nF6S6QixFDMhhi/ERuA99KOknVjoVovI1XdfjsiEyI/MGHgayKc+d7daW/8+57wgm
	CxeTQXzznpF1SqJLIv1H1p9k/uOf5sOYvPtEYI2AgpFQ4wh5P3tOB97ZGTnkrO0axGhyncaiQvi
	22wGcX8OQZjOO4XC/dO0mwUbKK+ocskJPb6uqxlQUHA8jyPqYB4iEQ7D7Af1x0cFHJOFmVbAUBf
	oMP8v7xkNLiIDu3jTBZv1sZRMBXXgl5Q1Wkgs/ISizmP6a2pUXKZ0NaJFi986w877LDcItCZ/UD
	kLsgYRHEIXbwdG+AN2+ZhNg==
X-Received: by 2002:a05:600c:1986:b0:495:5943:b76c with SMTP id 5b1f17b1804b1-496c4fe1f75mr4131285e9.34.1785181013949;
        Mon, 27 Jul 2026 12:36:53 -0700 (PDT)
X-Received: by 2002:a05:600c:1986:b0:495:5943:b76c with SMTP id 5b1f17b1804b1-496c4fe1f75mr4130955e9.34.1785181013441;
        Mon, 27 Jul 2026 12:36:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfe07e1sm252109975e9.3.2026.07.27.12.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:36:52 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:36:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
	Brian Cain <brian.cain@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 03/12] block/blkio: fix compiler false-positive warning
Message-ID: <20260727153554-mutt-send-email-mst@kernel.org>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-3-d0c4831ed7ea@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260727-fix2-v2-3-d0c4831ed7ea@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: agu4_uS7FkA26R2wAybuyk2QdV5LoAmqekN1ynjuUEQ_1785181014
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 12:44:02AM +0400, Marc-André Lureau wrote:
> Under some optimization, gcc produces a false-positive:
>     ../block/blkio.c: In function ‘blkio_co_getlength’:
>     ../block/blkio.c:943:8: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>       943 |     if (ret < 0) {
>           |        ^
> 
> Replace WITH_QEMU_LOCK_GUARD with the simpler QEMU_LOCK_GUARD.
> 
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>


or we can disable erroring out on these warnings with these "some optimization" options.
the warning in question already questionable at best.

> ---
>  block/blkio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blkio.c b/block/blkio.c
> index 52a8be220d1c..4801339f98b2 100644
> --- a/block/blkio.c
> +++ b/block/blkio.c
> @@ -937,9 +937,8 @@ static int64_t coroutine_fn blkio_co_getlength(BlockDriverState *bs)
>      uint64_t capacity;
>      int ret;
>  
> -    WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
> -        ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
> -    }
> +    QEMU_LOCK_GUARD(&s->blkio_lock);
> +    ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
>      if (ret < 0) {
>          return ret;
>      }
> 
> -- 
> 2.55.0

