Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB02D59E8
	for <linux-cxl@vger.kernel.org>; Fri,  6 Feb 2026 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395533; cv=none; b=gEtSunnA/WLOWMj9I3UZMOBdvhCYQygTCI/77ubzNOd7ESksu2PTIvB4KX48htkwdCGGtWjlHgJw2CfG0zXN+iGtb2v1v8UURXsKUVqC6fSRuBFYpfYwc4gMRGDqDXZybeU3g2Q4epcNDqrkNeeotMKaqENCfmY+1bXmBhYq6Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395533; c=relaxed/simple;
	bh=wuYDGXofKhp+5WwzY9IVZTgHv1CZ8Z/muf6ux2J7X0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvePStlKl9ziC9gU/rbOGuGSU9kyvsxArtkcqk43PiOvAuDJZh2SLbKVSAZhlgO2zuXa1Rp6Les1p7oCyLQ9rrYVzG3/1sCoehV3nKUSn/0N2n4BUX71HyghCKkqJIkkLJWCKaxJSIaRdX1s7f9QV+mBBRIWK4S18q2AYG2Tlfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BixZDLax; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BixZDLax"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8946f12b1cfso26973756d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 06 Feb 2026 08:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770395532; x=1771000332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zudsOAj0AfzZbqg1Lmjm4tJJgjoNQsiYFBqGBNU0cc8=;
        b=BixZDLaxoRIKpQwUIFJX/5FrDT2G7P3G5ot/KvPil+khqW3W2/GZGq6S1r2taZMF3R
         lOnwtREw/1ae9ftQ/rA31vo/u+H8Ge/Oy1orD4VE4uPfa59KcvLclQU29oO4V3JiEgk5
         +SbdqGUsWQ22zrdOukCThZBaqyfk/KSedkaTzneR84mWHvUUkDNpPX2R5k8V8l0Lw0w1
         8oUORgt4zhflFFfdA9yl5b316CJ7+22LuqaX70qD4zE6q7gR+FdPSaNUZ99WkPFZ9BT3
         si+lIIeQYMutCRSYdeBhfcP+UOh0dP8I3q974TAsixj8KfWXxPMg/T5NqYXQ/aFHOd37
         qKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770395532; x=1771000332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zudsOAj0AfzZbqg1Lmjm4tJJgjoNQsiYFBqGBNU0cc8=;
        b=GRf5kv2dAmN1ZyiH9b6O9OqAry2rYxapjS6ujZ65EDm9omx1EwY4DxCCUNdEUJmwXt
         EjBzhI6gfRxNVYDcOf2pj6rxExRco7spXlbfFeOd37kxYTuGq2ZRv5G1Ccl/+nFi6Tuu
         uU86P0XneSGi7qExQnHEqK+ryI4y+fHs8YJremd3TPXnH9iK/0/1KDeW+rCzEBFwz5gZ
         2pGw2jnSpq6zTpMlVqvVB3cyLyDFX65N3PLLFlY5Io8MvT6HkdpKttulDy38taHYKGkN
         vgt76GMam6wpLNjmnu+N+/Baqj8AePBCe3aZHZX0i+X7BMs8ud8kTboaEEhdjJTe7KIY
         AM0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0mBlYwJmb2M9+CRXrEk8pJef1KLkG9diLG0F5makeIrit8t6Hj1CMbRiBjkWjR9dlF0JGthQryEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCeNkjFbwUSbIwAyQw5Ql4kA6OMSmdtHro4qdVu2oD3UXQieBg
	aIIdUyTz9o/nXV5RFD5Fh0wq1ZVd/msdzqqeM/LaXqP41iknfUhP//ANn/nGh85Ait0=
X-Gm-Gg: AZuq6aIs46jyS/8WNtr3y/fUoxeuffFvow0j+a/8NTiz53DRrERQul9h44zG9mcNpdp
	R8b+w9WKorIx5z4bnQJca2chX3cSxK1WIs30raOqe1UOZH1LjXdoNil8iihUuwjKoS+CqVPOKa7
	77VEZyVKi1OJY1jQCWZx0STBd2h2jG8baEC9SId4wu8oSzFW6uZSDk1KUc4Wfk5yJyBFCZEcM/1
	fL5ngi8dl6tJpB2SVjJWYTGss5uAtWAb4t+hE0nKoN8T67XOMt/25c0cQMjN1aWkle9oU98ucik
	a605Udib4GnC6DbXlUZ4nJNpfubUl6y3vkHff/xjkhSKSCu4tpHCJGd3IxD90mQPmUA1cFAvsLN
	26JJ+NF8jBP6W4BYPE9GLfXQkCdmWYWuC0B0WrPIre2UmR/QTLVZ4sEQtD09mwKCsfsSRCWmVNq
	VLy4mD2awWAS/GvAcKVzMYfaPfS80GZpiWTEOPCq/uJ2T1EZgkkpdSapppSY+P902Hr3IFWQ==
X-Received: by 2002:a05:6214:2522:b0:882:4c83:af43 with SMTP id 6a1803df08f44-8953c86f554mr44159066d6.42.1770395532119;
        Fri, 06 Feb 2026 08:32:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf37b9asm21134616d6.9.2026.02.06.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 08:32:11 -0800 (PST)
Date: Fri, 6 Feb 2026 11:32:09 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Cui Chao <cuichao1753@phytium.com.cn>, dan.j.williams@intel.com,
	Mike Rapoport <rppt@kernel.org>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, qemu-devel@nongnu.org,
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-ID: <aYYXif7IPXnXZPnn@gourry-fedora-PF4VCD3F>
References: <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
 <aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
 <a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn>
 <20260205145842.efb90572a902ae4c481e6ef6@linux-foundation.org>
 <aYUjf0OrD8f_bJCy@gourry-fedora-PF4VCD3F>
 <20260206110305.00001fbb@huawei.com>
 <aYXtHa4Y2y_5xgcS@gourry-fedora-PF4VCD3F>
 <20260206150941.000028ae@huawei.com>
 <aYYOZ1TK5dpX_h_Q@gourry-fedora-PF4VCD3F>
 <20260206162644.000050fe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206162644.000050fe@huawei.com>

On Fri, Feb 06, 2026 at 04:26:44PM +0000, Jonathan Cameron wrote:
> > 
> > This should fall out cleanly.
> > 
> > The additional nodes won't be associated with anything, but could be
> > used for hotplug - I imagine.
> > 
> 
> That aligns with what I was thinking as a first solution to allowing this
> to be more dynamic.   We can get clever later if this doesn't prove sufficient.
> 

I can get this out pretty quickly, hopefully sometime next week.

I had a long talk with Dan about this topic previously, and I'm not sure
how we get more dynamic than this to be honest.  nr_possible_nodes is
*definitely* expected to be immutable after __init all over the kernel,
it's used to allocate a memory.

Surface area is very large here.

~Gregory
