Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369119;
	b=TtchFQ3O5lBCkXcx9M+RwVo6GkxUvQPKIaxRmfjQa1Qyw4RxeLjX11lNWBAd8Klyk6sG
	 fil9S2aZ8erSxTaLbPaydBXgMU1QDpoWaqe3dtL1YenHtLEwhIrf+kCxxw59pF9cyatkI
	 eai6+DoueX3va3gUMk8fy3O7oCdPPCw46N0b5Tkf+WSFlwmM7MQ1V9j9Rx8gGnDJIwsNY
	 lCwauJUHKVx1cS/gS49Gd1PU/aEu6VmqfHDAoGiPBKVFbDvyl2XENsPoo6M6Rz6nM/to3
	 9rTm8bGN3BFk50ZRQxzCBtmCLdFknv1rYVedt+a9Q9HYtl7koPyjQwvrh6tj0uPg6BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=9UBOGrnevchYzRdIK+lYuYuVpkBp6bntw5wHhZWKMa0=;
	b=MxydzKdjLXTpzfSL1ci2C6VPzjOt9gCq20r5f0V95wpHCw7RhIMur++qBcMoKO+/zT86
	 thxuO7OCXy/cJV5U+vOO2r+a0EZIbV/2OmUtOp9DBmVDkJfJVYRWknEtSnobvJmfTwb7I
	 doPGWz8U+ejILgA563plbI47+PxbqgbUA9eIlnfWVRRxFJIqoS8+OC2aWoA8xNOGbv77e
	 SREOJu/en3usacCxrVh+YPO0NkMna8zNL9gZw9D/Mqxvr5DesIbVhvozIWBkvnJgibA1T
	 0IupBh1d6J88U/p1Z2nx6BARAQBnfiUM4ml5nwmCepHyUvoxVaH0j+q6B95N5tRJvKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jiegxRGU;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8398606A31A
	for <linux-cxl@vger.kernel.org>; Fri, 30 Oct 2026 14:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8398606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jiegxRGU
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7c3b75caad1so541661137.0
        for <linux-cxl@vger.kernel.org>; Fri, 30 Oct 2026 07:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793369117; x=1793973917; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9UBOGrnevchYzRdIK+lYuYuVpkBp6bntw5wHhZWKMa0=;
        b=jiegxRGUdFRU0ymHzJexSx7PPQQxv+SH15NeLyX05TkSFevqwkjt6AXfkJKLbtJvpk
         3BRS70Y+pIX4SCQYbbQZbUd8GtAGUQS3V5q8lsBWGAaAx/llql43PR5qqW7UUemSCA70
         hFXnuhGyElBpWRY4Pg7YzPdZQeCbkoOV6V4KMEGg+pAjcu87ZijWePnXeU7SC+uVumDD
         zVooKtjQ8LZnVhVMUFyGi8hVG9YnhsvCL8F1tP1wYxQ8nMtTchInlG1Pazcb3QhqyOV2
         0TqIWGS+ROUM7Vz4WZIiXIYFhxneDHh5Rs8SyPmXcwPh9CYFr8qL+Hw1pqYvOJVXOeCa
         rryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369117; x=1793973917;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9UBOGrnevchYzRdIK+lYuYuVpkBp6bntw5wHhZWKMa0=;
        b=VxCwK5gM9HmNpDP+TIBimX+2qmz5uERVMHYHLK+t65R8ODDYvfyrTCUOQt2D+W9k7X
         yR4vAHUDJMB1J7J1/H6xYfQqKDOOjunUNwCeHTe2vrXwWbalq8oFoaEqWdSolmFxKOWK
         gqtVGvRcfGzeYbDlRxAA6mn7y9e5xMMbFuB3rHML2/AgAjGp643MLdMJ55nbPlFtYuGI
         Pk5RMsH+dtQn9LRhIunEFe1Seuaq35F7rf1LJWtGGAGCZUSWkdoisePNcEYUh1lRAyOO
         UOTJlDOCQvFVtomHNf3IHpOtPT6mrrQVPKgJ8002CE7zfwHF62MK3K6zutn6qWHv1TwY
         susg==
X-Forwarded-Encrypted: i=1; AKwUvBzpG7D8OY8u5Pk3pJBITAROwbU4zNv+Q/YKWdHIev4vCMky618KzDd5uXad+ENDn6ehpiwdhxCHfSQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1RcomS1Ccnt6Sh6qzlriKK7AmQogu8yEhykMDM8K0Bo2yBPfb
	dhEChwMkgQ7tk9aUVB9r9XiZbBWgv3b0vWVNJHEhiZd6i6yu6Bc2s3VtJiSg8hjCLWkzSuPhlmL
	THW1Z1wE=
X-Gm-Gg: AYBFou3v8ZuwoErLy1Unm9N8JzV/OS4OC0QwCHnf0u9Jr8fM+BK6o4ou3PPwt+Szr3A
	3I7vTYGnA1YPHabiAb3UeOhM93nGTWuFs5HxsNPEVzgzLDjRY+lAXTifMvWOG6qTp+i2MmFh+YI
	WMm97sjZH5mbkJg+g8h4cdSt2fJ8OSw8hMYAU6YKPHoBTiqayrCeg39QbwLlqGW/Tu8IIP42cMT
	z3PMUfwA+tJ7vYxmbWUNeIfVvQUMW2iIjHZGqc3ycPrnWyNHpYCH+2npVvZ5H8YrzBqajrSdQ/i
	4UieT582WPBwPBnVuKlNXKILneLvGtX1jPIGX9emdkXXcFG/KXqvTUFwBOkBF26i7FTVfjZrACd
	dThdzyG3yEWS1NVdR3XTbt1mLvU1EjktpwB0z0ZRlSQmqvi0yR6evd1Zx+yQtgLnSRS6QcN7wcJ
	ZJwP3gIpDHhbifHvfN+ZmHQpm8/YukH7ZVmzgfk5JONjmmMRs2dN9loO8YQxptWhA+zW5Jy6Zaw
	bbhtXkC1kBQiaZZm0GgRHpI1s7nAjwUyMWJrZiPWFRPBZyqMfQTQk4nB6MZVYy8ExsKANVw9kLu
	B65jY043MIJZm1pW/25UJtoBz8ELtK/HL9k/4zxS1wFftdTr6fIi02u1KDLqB5U+yhDT8l1b23F
	u
X-Received: by 2002:a05:6102:c4f:b0:7cc:3eb0:6ece with SMTP id ada2fe7eead31-7d072d53fa3mr1222192137.33.1793369117323;
        Fri, 30 Oct 2026 07:05:17 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca806aeeasm15954726d6.35.2026.10.30.07.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:05:15 -0700 (PDT)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [ndctl PATCH] libdaxctl: check the zone of onlined memory
 blocks
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org
In-Reply-To: <auP1-iC_4r0lF7dV@aschofie-mobl2.lan>
References: <179322248318.3398847.13424413341337264007@gourry.net>
 <auP1-iC_4r0lF7dV@aschofie-mobl2.lan>
Date: Fri, 30 Oct 2026 10:05:14 -0400
Message-Id: <179336911439.2951797.4892975963347452252.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-29 18:42 -0700, Alison Schofield wrote:
> On Wed, Oct 28, 2026 at 02:21:23PM -0700, Gregory Price (Meta) wrote:
> > daxctl_memory_online_with_zone() is meant to scan the device's blocks
> > after onlining them and fail with -EBUSY if any block is not in the
> > requested zone: an agent such as an auto-online policy or a udev rule
> > may have onlined some blocks first, into a zone daxctl did not ask for.
> > online_one_memblock() relies on that scan, it ignores a failed write
> > for a block that someone else onlined ("There will be a full scan for
> > zone correctness later").
> > 
> > But daxctl_memory_op() returns the number of blocks it onlined, and the
> > function returns early on any non-zero value, so the scan only ever
> > runs when no block was onlined at all.  Whenever daxctl does online
> > memory, a zone mismatch goes unreported.
> > 
> > Example: 
> >   memory_hotplug.online_policy=auto-movable
> >   reconfigure-device --no-movable -m system-ram
> > 
> >   => reports success with the memory in ZONE_MOVABLE.
> 
> Hi Gregory,
> 
> Does writing "online" let the kernels auto-movable policy select
> ZONE_MOVABLE? I'm wondering if this is a race, or if daxctl should
> be using "online_kernel" for --no-movable.
> 

'online' basically means "kernel picks".  I think it's reasonable to
convert to using 'online_kernel' for --no-movable.

> > @@ -1704,8 +1704,9 @@ static int daxctl_memory_online_with_zone(struct daxctl_memory *mem,
> >  		err(ctx, "%s: BUG: invalid zone for onlining\n", devname);
> >  		rc = -EINVAL;
> >  	}
> > -	if (rc)
> > +	if (rc < 0)
> >  		return rc;
> 
> What happens if the kernel places memory in ZONE_DMA32?
> Will that lead to a MEM_ZONE_UNKNOWN and then an -EBUSY?
> 

Hm, let me dig into this a little bit.  I didn't think this could happen
for dax hotplug - but it is subject to default_kernel_zone_for_pfn.

Give me a bit

-- 
~Gregory

