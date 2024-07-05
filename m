Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B70146A69
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720193613; cv=none; b=g2IqEyVYRV0cXGY5xbpTN4QDp9shT5FXVHw/eei6+Uqc5twQpJXllgEiPm6bujD3EYDlwfv75WIPG9C9boDmZGEQo/t0TE9Un0H4jVPAn8QeaL19sh23qUFL6Lru4GXF/TlqrJ5twoYYcBMPStavGdcxbsxjAcwPcv0m85dw5h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720193613; c=relaxed/simple;
	bh=Xk3vA0U4TENu6hHY5znsH0smcSS/zwl30tPzqtEmqLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Pr3qZkdgO89RO7vYKtSPCP1nryOWQH6NFLP9cZ30pHkw+Mf1jVED6Qn/Ds1hY+ARFyooJ5ov2ClNvY1UHfVXXnz+Hp2QOOaM4c8crYmSCf8iaZUU66efDRcaTPMKP9H8WSt0iHrCjQmGhLd+vdeyVEHKxh26FvhZ1UyYPa9WAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWXuAXr2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWXuAXr2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720193610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xk3vA0U4TENu6hHY5znsH0smcSS/zwl30tPzqtEmqLQ=;
	b=hWXuAXr2MGx9sCJA28eir+N9DeJlbiquI4YLHi0/aKtJemkvg18AdbdA8NnaLTr9r8+v69
	T5Lvx7uVpkiQU36lX5H1ZCyZ3YGlpr+N9s8AlBkaaApxGd4m3qGH7hNMGiKKEYZA1SXEIa
	aJY5awH6UUS/bAithazvfrgw2Z3wuPc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-sTD5EHmzMli2zSxhOfBYKg-1; Fri, 05 Jul 2024 11:33:29 -0400
X-MC-Unique: sTD5EHmzMli2zSxhOfBYKg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42568f0cc18so12181455e9.0
        for <linux-cxl@vger.kernel.org>; Fri, 05 Jul 2024 08:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720193608; x=1720798408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk3vA0U4TENu6hHY5znsH0smcSS/zwl30tPzqtEmqLQ=;
        b=Lk1v2lMmvOGD/P87RXhyyzdz22G2BmwuDOW2MT8M4v7EZ/Oa+g9fEIasAotdP7yBJp
         hg+Yk9hwT5C1bVlGt1RkPQ3unUyxJRyX+qfxyLRJI10UVuQyjUHFeclHDhNsvfaUlJV1
         /v75Pbk02QU7XxFgR5cjy+6tuA3cCcX1OGtQN8DL9Te67bU1Ac8E4CrzOHLY/SkswyKG
         IcH15hJavwPVGPPpFTnTcyIIcRWtmXl99oWbXiww9FbFXqCIS1HWVwuuxqFe95r1d4sj
         fZJKtb5wqJQcoYpxzPtPdt3ojvh8DuzrBhigVKFBJkRXgChFX9fvTA37VA/f8cViRnne
         NESA==
X-Gm-Message-State: AOJu0YzRwfYkNzudi7xhFR0D7pCDtb89oj5GwZ5vlM6ypKDgzgjkSno5
	Zw5BMEzPd4xyIytmtsDZNJM/aR1+noheWK+yg/d30+OIubUy5MAvgLj1piCF/b1lFCeTPgMz9U1
	s2HGYRIlCSZnjHX95G0YxJn+RvGBrb9Yt3Chp1+G8h33bofoD/n7+emM6Lg==
X-Received: by 2002:a05:600c:21a:b0:425:641c:5f46 with SMTP id 5b1f17b1804b1-4264a44d471mr36436505e9.30.1720193608269;
        Fri, 05 Jul 2024 08:33:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtdKXd8/CP3N7qb/hRC9Hkxy2F8mTsiesjF9q3KZ/RvBiX2LLTl/ksw+yE/wGILJW43af7+Q==
X-Received: by 2002:a05:600c:21a:b0:425:641c:5f46 with SMTP id 5b1f17b1804b1-4264a44d471mr36436245e9.30.1720193607517;
        Fri, 05 Jul 2024 08:33:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:1b5b:ac5c:b82e:a18c:2c6e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d50b0sm66990645e9.7.2024.07.05.08.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 08:33:26 -0700 (PDT)
Date: Fri, 5 Jul 2024 11:33:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, fan.ni@samsung.com,
	Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <nifan.cxl@gmail.com>,
	linuxarm@huawei.com
Subject: Re: [PATCH v4 1/1] hw/cxl: Support firmware updates
Message-ID: <20240705113248-mutt-send-email-mst@kernel.org>
References: <20240705125915.991672-1-Jonathan.Cameron@huawei.com>
 <20240705125915.991672-2-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240705125915.991672-2-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


just a small request, pls use same prefix for all patches in
the series including the cover letter.

