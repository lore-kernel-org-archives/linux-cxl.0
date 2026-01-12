Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22937E316
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244156; cv=none; b=g8cqEu00pTpAfIPqTGyiBhclLNqTi1LolEGza+4pZt29y+u8Sg6nmFSGVofMSJXwBVj2o4cr1VtLTeAOANWL7POaWqvg0e99C8Rn2yRu+Z03BBj/mNqGKfnv2E9dEMzRYV0bWNVdOWqJlhVwGvrbOdRMm8S4HInUWgX3ITlslm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244156; c=relaxed/simple;
	bh=UclWX63fGn+76lJOJEAYUq4t4ohSd9HEsKoA1eHOk2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0lpEJXUo3KWLjWWgMP3dFZqTTHqi0uCsusCTZQtjQxgt3087GfhPZ6amlh1CM6wDWx9bM/eRd7hh0c0gNqmGhokXwkqvqi2Tk3P174+jlMrblvjkZOt6OxSp9UNlfVRTOWha99O6OtTfjE0YfTOFdXLz21yzuMl+YsRgX+Ooyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcB8eMKM; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcB8eMKM"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7ce2b14202fso2920752a34.3
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 10:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768244154; x=1768848954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYsHNBbYooeyWKTpHrg47SbkaPnJvaXLI4Q2tRF9T8s=;
        b=kcB8eMKMLLOZI2zQ8gHDRVfCVvW4r+4CqoO6cJm+j0EASaBXx9QER/19PQj9dqNGNO
         aYyNz5VwfuZhuASU9Mz4oDouYCLRd+ObBROxHUMFeU6kOQvkSviBLmS5Unu0E5qAYds1
         v67yot+BhBsJe9TxkPf2UvwAAC8vaOkFCBn/F93tyBiMEHDu8d5aKqgGhuRzTNpXN0d8
         43m1gOKOknQxNyqNa/Qm5foYOQLmePImEqGownc8d4MLCRAgMrwPT1dxwjX2f87UrqwB
         P64kc01+GARQe1yUJHkD8AsaLpoiNuleglUQI5v+gIOPe/YUEv4ENk4z3CY9Z0zyTYlq
         6gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768244154; x=1768848954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FYsHNBbYooeyWKTpHrg47SbkaPnJvaXLI4Q2tRF9T8s=;
        b=NHjz22dIsQbBeEv4F9DvO1xNRJuki7MA37EkkIoYDtCKdNfTdJeyqq8qHuMNENoilr
         l6E/1zSW6FaXT47QvU/bZltwLzlUdx12F0mFuMHiLLonlEWUK6+LIjVZCCVlRx9R/cyc
         TyziKg9nD/XGGPSfQMMa7Sq9UFII1IvT5Ax9hO5t1+Wamh3FnmNrmqZy74kVFTeoa/S0
         v3AQahGpVh6KfnRnqFZPvwMOyoPTHGTpkX0QuzpsAq/H1N4PvlGE2bU5YoGrrgx9AqL/
         lk2bV2kGC+gogkMLMHZ85MzoP9r3qQPKpwTNEmjQoszFd+ifQMgGB7DYvFBkL1mfkFth
         gGUw==
X-Forwarded-Encrypted: i=1; AJvYcCVAZ8dQOL2aac6/KZGzglzZfK2xmMFGqzbrfcGQZmf7zj8PjSSEFjZf9mAlTfKG2koMFL0tVktbGYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW2Ne1YjoJpDt/G7XeC2lQxqL6pXM9B2FgKgmLM85/udPFdk7f
	5UvMD/mBpSu2KezlHIhR9Cnl1CY6nay5YoiA/E11uIQvDqM9XCmNtyIy
X-Gm-Gg: AY/fxX5rcJEDeicx22mERAOr0VkXhPtXFl53DmFsAIUcaLQTq01gbCnPJJTJa+0AeJ7
	2xb7DFyPtGjqIzYEi4arBQ4TWHcnzUGdIWgzdodGxYbDowUEkvz9S67mNzB9UfJ+W30IQVcPaBN
	bbTP1wG6s3X+IvgKnyToYOQIHkf5Kah+p6Ml5i4z+ZqJzj5wixaje0JJoMJtBVUs/W9ZruJbwoa
	ICKW1eGSNoDEbMMc9OYffNXr9kiene8DhsI+CaTKvfE2IpNhXsfd+rkJj7vpUgi73GXMSfkQ3gC
	aLqFrmQAQlZa+2cGh2p66DTkQXEA10V3l+QCseXm/v2eqjVlN1d+KghaQiKCz94J8e6EaYTPAID
	LdA52bV+lJOWJNa5b63osNxTutlQwTCoHXCIpTe3BcS1+ETS2nCvvL+L1k2bivq+fN5raIgmyAz
	H35N7KzoT+e4dG7QjFvQHgy6Ogk+MUkzoy4LAv3cFa
X-Google-Smtp-Source: AGHT+IE1iJyYHUxrRRJzQnvZoITdjEtERZksRqGBumj+1tozUwX2FshEuhzALaYG8xEGOVq48wdoFw==
X-Received: by 2002:a05:6830:448d:b0:7c9:57ff:4cdf with SMTP id 46e09a7af769-7ce50bef39emr8458614a34.25.1768244153635;
        Mon, 12 Jan 2026 10:55:53 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:b02d:f13b:7588:7191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af6efsm13473549a34.18.2026.01.12.10.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:55:53 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 12 Jan 2026 12:55:49 -0600
From: John Groves <John@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 07/21] dax: prevent driver unbind while filesystem
 holds device
Message-ID: <fcik72d66pfzk4xvubywt2mzdqr4lqtqjgexrqr3l3acpxc5hv@vp6oueyvzrll>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-8-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107153332.64727-8-john@groves.net>

On 26/01/07 09:33AM, John Groves wrote:
> From: John Groves <John@Groves.net>
> 
> Add custom bind/unbind sysfs attributes for the dax bus that check
> whether a filesystem has registered as a holder (via fs_dax_get())
> before allowing driver unbind.
> 
> When a filesystem like famfs mounts on a dax device, it registers
> itself as the holder via dax_holder_ops. Previously, there was no
> mechanism to prevent driver unbind while the filesystem was mounted,
> which could cause some havoc.
> 
> The new unbind_store() checks dax_holder() and returns -EBUSY if
> a holder is registered, giving userspace proper feedback that the
> device is in use.
> 
> To use our custom bind/unbind handlers instead of the default ones,
> set suppress_bind_attrs=true on all dax drivers during registration.
> 
> Signed-off-by: John Groves <john@groves.net>

After a discussion with Dan Williams, I will be dropping this patch
from the series. If the fsdev-mode driver gets unbound under famfs,
famfs will just stop working.

Based on feedback so far, V4 should be coming in the next few days.

Regards,
John
