Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D93A6402
	for <linux-cxl@vger.kernel.org>; Tue, 20 Jan 2026 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938807; cv=none; b=KKYL/Fgdkg7e4wzikv29XyaOFODwtc9yo1wwIxijjbraEhVZ+u5N7YzT1cx3r751PS0iN8bY3t5ke7phjBNSQsGxwvU9wtxAhiQm1U82IrE5hbQM/UbMBG7Cy4yHCNtdWymBbxyqpGnggvMfZ+0Hgd/ucL35Oi4u8jLcCXiaC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938807; c=relaxed/simple;
	bh=jqncH8eNDFRs0NTKN1ecGd43FGsZRVkVBmspyc+tkzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBW9kMxhEQzR/ZwUGhUPPQEkdDtM34fnbu7zZeIvYoRRdbSHYew6M4fH/f4ckWfgPvgZwxHZg5iwnn28wY49ksU7S/lg9mtOOPK9iAwVULR1qdedWae5zEMEV43AJtPMhPM/EQm7tSQ5+dOKwE8Nmqp1tgvqys9jcWomMJ50suc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AFkA+QBw; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AFkA+QBw"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8946f12b1cfso3445996d6.0
        for <linux-cxl@vger.kernel.org>; Tue, 20 Jan 2026 11:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768938803; x=1769543603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DT7f+nwKNVqRHxBLOEjBQ8JdR4wJCXmuunwEQyjFXwk=;
        b=AFkA+QBwptkeYa4kck1qAhVI9KUOEh1P+fDmeRxmn20nSZ2NmsLkoZ52fjm17aagj+
         NG/ZN6i6LpVfNp1/aHFbFLb0HPozr8sMoW7mB+qAWEms+cOs/VZ9L+WE1/9LfwoBDxwF
         /S73A4mYO7SNIL9NvLNCR5nWiEuI5luQBetBLUzKsTwn5AMOf3uYTO1GV781T1k+SUj7
         75FSYK+Z71SU5ya7EoDnQL95guYy0kNHVAkG3Z14lZU9vSr6T2m5txL7FZZTX3dPL/U1
         GXYuxvCpwMYrDBi3gr5sLg1VR17TTJguNp8baOjlb9RD9LWpgeTyORsoBwFO2Dw8silW
         6Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768938803; x=1769543603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DT7f+nwKNVqRHxBLOEjBQ8JdR4wJCXmuunwEQyjFXwk=;
        b=siSJDgnx/PPMJgwXaqYeRJ8Om0Jladnt5SGX5wCItEc1B4SqehQGL1ucds1ezYHVSt
         d3PeaXr0vG4zk9fGsKT22lrpgtGfpuAcLcqOkjdQUA9hlzCv91Yl5CoSjoGhG8OBMjqD
         efqBI1Hj5TNAckvEUmHTVF+AhojHMvW8fNCb6sGSqzs1GEjutyvlRb5tYtlrqhW9D51/
         SpGN7ICOAzgaR1uLOy/sEjBEnLVGJyMiTqS0c7Fu3DibKGx9kVGUuQhSvFvaY3CiDpdv
         NKpWSBIoN95PefyurzTsmnfndhp4zAOLmVrIVWdEbEKG3+npWZBdNaSu/Kc/WmMKs+zp
         jmOw==
X-Forwarded-Encrypted: i=1; AJvYcCVYjvmphfK2l7FDEMr2G5R8Jjft3KEipZKbZtTtO26SS3ubxvP/Gvs+Ob+2guPrdlXpLp9UzanpNMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBrPbVNz8TXYycZzgB8g81DMmGyOTkEmLT904mRkjkqzWNdObl
	QfzdevtOXVkbBwErIpA27jZg8INYLW7+Fxq7pfEFOSng/nRZD2yd7FqIp7fiJD0FfJc=
X-Gm-Gg: AZuq6aKUEazlPeJo7IUW2X2TQFEvv9VMeRBaXaM3HGKeD1FKzld1qJwZ0b0I1gswcbA
	9rSKJYUfA4k1ZVRZIFAyK2SqkMnrB5eAbghxM1b3YTpDlUlsAnwH0PQWOqK2XAwAngF9vDq5Qc+
	U8tagjptEpVqG+mKvp6KYEC0APM106fazRC15F7An2UcPEW6FVr2aTTItgZYyjdYKH4NzIHqYkT
	0wqSnpBB6qNI0b3OE73n9zQGLz4LGNspxIqy0A/vYurTPmV4DFWiRVhzH+FkRoFESVOptphcLCs
	gR2INXcEopAMnS2Hz5ogMP27WaUnF9fAWX6YUIZpgHoA1jiQMRhDrE4RqvHgWWSckonAUwATn5s
	cV5nKAeIU5vZ/eEi+DxE3xy40viEfHiYZkpC54wOWtNLqJYNkv7CKLRnMnzDwK74zmglx0+VNI6
	7I6DQ6YOiwobofLHZEUbAYhCxH7mB0oP4VgT2IyzR6gwdUde4XiCXZ8aItmWFfV71XLk6+Lf8eE
	WCF7Ixq
X-Received: by 2002:a05:6214:258c:b0:882:3759:9158 with SMTP id 6a1803df08f44-8942dda46camr231992556d6.61.1768938803293;
        Tue, 20 Jan 2026 11:53:23 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6ffsm110202716d6.27.2026.01.20.11.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:53:22 -0800 (PST)
Date: Tue, 20 Jan 2026 14:52:50 -0500
From: Gregory Price <gourry@gourry.net>
To: David Laight <david.laight.linux@gmail.com>
Cc: Li Zhe <lizhe.67@bytedance.com>, akpm@linux-foundation.org,
	ankur.a.arora@oracle.com, dan.j.williams@intel.com,
	dave@stgolabs.net, david@kernel.org, fvdl@google.com,
	joao.m.martins@oracle.com, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, mhocko@suse.com, mjguzik@gmail.com,
	muchun.song@linux.dev, osalvador@suse.de, raghavendra.kt@amd.com,
	wangzhou1@hisilicon.com, zhanjie9@hisilicon.com
Subject: Re: [PATCH v2 0/8] Introduce a huge-page pre-zeroing mechanism
Message-ID: <aW_dEjSr4E4N5Fn7@gourry-fedora-PF4VCD3F>
References: <20260120094744.5d92e34a@pumpkin>
 <20260120103949.7673-1-lizhe.67@bytedance.com>
 <aW_G66HeWLbyiPHs@gourry-fedora-PF4VCD3F>
 <20260120193027.3d160211@pumpkin>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120193027.3d160211@pumpkin>

On Tue, Jan 20, 2026 at 07:30:27PM +0000, David Laight wrote:
> > /* Run programs in serial */
> > sh:  program_a && program_b
> > 
> > in zero_on_alloc():
> > 	program_a eats zero(10) cost on startup
> > 	program_b eats zero(5) cost on startup
> > 	Overall zero(15) cost to start program_b
> > 
> > in zero_on_free()
> > 	program_a eats zero(10) cost on startup
> 
> Do you get that cost? - wont all the unused memory be zeros.
> 

If program_a was the first to access, wouldn't it have had to zero it?

> > But just trivially, starting from the base case of no pages being
> > zeroed, you're just injecting an additional zero(X) cost if program_a()
> > consumes more hugepages than program_b().
> 
> I'd consider a different test:
> 	for c in $(jot 1 1000); do program_a; done
> 
> Regardless of whether you zero on alloc or free all the zeroing is in line.
> Move it to a low priority thread (that uses a non-aggressive loop) and
> there will be reasonable chance of there being pre-zeroed pages available.
> (Most DMA is far too aggressive...)
> 
> If you zero on free it might also be a waste of time.
> Maybe the memory is next used to read data from a disk file.
> 

Right, both points here being that it's heuristic-y, it only applies in
certain scenarios and trying to optimize for one probably hurts another.

~Gregory
