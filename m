Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50931062D
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068231; cv=none; b=JL1C5nSJjlwZflXLliAB+5hpflNLXP4DUBZeFC7mQ0hNimlgoJt4i2nLpebxyuK8CoJ3V1J33MKK3rjQRtWXhYIGyNIhoYi6Uv+0pRbCSaxshWRiEz0qaYmBB//iVsMnpTRGSlWEYgW8tNlKuJJEu9n/YYAedTNy+S/o3Me54y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068231; c=relaxed/simple;
	bh=kWEypPVGwJEMybutYPQAIuFoGDfenpYyYtSso4g6JH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INzTPW3BsD/iia7p2ZhNntHLfxVVC2d0quxm2kVWK9D+fuVI1UIwh5OaqM9jTQEua0WNu8smjllTy+PXJElJlo8IyHcqSTC7eepUuskHCZLdZj+6QQcFXkoZz4sJWuaJXwq+fc/oJxdYA3Jhto3IDJhq2GbSllLc3gJQg9WpJTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Mzx9Hd/R; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Mzx9Hd/R"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6af798a83so568885685a.0
        for <linux-cxl@vger.kernel.org>; Mon, 02 Feb 2026 13:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770068228; x=1770673028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8laAOVGcrjt3grREBpdlanB8iPI5gP36V5MB+/CpDTw=;
        b=Mzx9Hd/Rzt+M+pJq9wOJRdRLoK7Svg7rFWFXH2nBvx1PV9vaNObCnNYbF5O2Kk4OLb
         VjdBr7JKdmQzzE7uEqmt9JLCMpvCohdG2P1YFr2uBfPFwoKU3TPlMPjzgW62pD/yEXh8
         wPAvQ2YR6/lVWr2aZXP7mV+0JIu88qFTCOcSoPvqmFz83INXqVooueaHMy00oCZlmgys
         XC+QiXVYxKLHy3bY7XOqqu0tjlENqGPiyXu+s2SLdl5vuVqJTvO5OQcwCEGokRqsm6S9
         B6n3U3wEoh96z1SiUNTjG044xBGkEWryo/9BUQepQmGkdG9rpXMy4P/C638jFPArwfiw
         poKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770068228; x=1770673028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8laAOVGcrjt3grREBpdlanB8iPI5gP36V5MB+/CpDTw=;
        b=cqOQuAPaZjolvCt708FGt3yPBJJTWJ6bL4Dk4Dx2T09y3DQNQRazWvys5cqqY7D1Jc
         Z6Qq6x2vrHaDf1vjWkggILSVrdlNDhbP3vm0OWTsUNaNJl3lab3YkHbkMn9QAdoyFoQB
         UlRQaLsady6Utu9hC0fuOBLi+XMJIDyNvkII9/nGDX/UNBcvxxael0cf9d01X5DVkSv+
         AjcmvA5Wal6qSJqXo9QWmdFcEbtfc2hRBum3tPw4aB2cQ18X79wXmJqC0wOHSb3VExfc
         Iv28d87ZsVLQPEgpqJrpHwTlTm79DVxfCCSVda95oapomPLKtL0MNc+NThFv8dI31T7m
         4ifg==
X-Forwarded-Encrypted: i=1; AJvYcCWPoAk6gUCn28+WIznFWWpiIJxylrqP767CwbOs+wceGzVhnLALCVRmmAxYH2zWXCS4Re4dDyhxKIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIx8ubWF78/1HjWXA+Y4XXnRfSs9cnGk4nDydSXVXTMRZyaPtp
	1ecXRYEMLtWJu7D4mXkAIHdXBwXTthOw4WvF10KynxIM+NFfDUELGZu4LwjQ4rbnTIc=
X-Gm-Gg: AZuq6aJxsFqWe8oZJAmkFNYGCHkLXljJls6siDcbLSErPzt/gOjYjRx8nSKcQR9PbNU
	YJqy700gUSF6nrmMuXlkijSeiZupYyYtBKBKkdRHDlmioIf+GoJxUDC0ri5f1iS0k5obu6UmV8H
	vaKeSpVOWtc3iCyTPV+N+3gkCikxeCXiFVXJA3YG2NBjv0IOdmH/xHwTMvPls/2arXl3rZcduky
	0V6keQmCOk2AMoTZUz0/korebltoo2V0gDRyAkKXCRcZWWGPYnxtv2u8F62l4Y/7ZRic999owP1
	N566VigZeR1BB7kJvh0+Z/5HzHI8N514tyojxzZSeCaiN+izDER9oX7YhSTZtUnfLdpK0y76EQA
	WNl8DRNfuKEncDe3d3/9XsP+shHI46iTO1R1vAuY5/3zsubKypGfTjs+RQYxwiAUHIjwBU2gCFb
	VxnkyCPqIW/W5yX3HoBVR/YqkOjl6eId6ky0xULzzAH/+2IRwabYASNJ6Ewh2enERUIxGb3g==
X-Received: by 2002:a05:620a:46a6:b0:8c6:e22b:25f7 with SMTP id af79cd13be357-8c9eb1fc204mr1562950785a.18.1770068228565;
        Mon, 02 Feb 2026 13:37:08 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d61c6fsm1317392985a.47.2026.02.02.13.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 13:37:08 -0800 (PST)
Date: Mon, 2 Feb 2026 16:37:05 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
	terry.bowman@amd.com, john@jagalactic.com,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/9] mm/memory_hotplug: add __add_memory_driver_managed()
 with online_type arg
Message-ID: <aYEZAUJMLWvaug50@gourry-fedora-PF4VCD3F>
References: <20260129210442.3951412-1-gourry@gourry.net>
 <20260129210442.3951412-3-gourry@gourry.net>
 <20260202172524.00000c6d@huawei.com>
 <aYDmor_ruasxaZ-7@gourry-fedora-PF4VCD3F>
 <20260202184609.00004a02@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202184609.00004a02@huawei.com>

On Mon, Feb 02, 2026 at 06:46:09PM +0000, Jonathan Cameron wrote:
> > 
> > I can add a cleanup-patch prior to use the enum, but i don't think this
> > actually enables the compiler to do anything new at the moment?
> 
> Good point. More coffee needed (or sleep)
> 
> It lets sparse do some checking, but sadly only for wrong enum assignment.
> (Gcc has -Wenum-conversion as well which I think is effectively the same)
> I.e. you can't assign a value from a different enum without casting.
> 
> It can't do anything if people just pass in an out of range int.
> 

Which, after looking a bit... mm/memory_hotplug.c does this quite a bit
internally - except it uses a uint8_t

Example:

static int try_offline_memory_block(struct memory_block *mem, void *arg)
{
        uint8_t online_type = MMOP_ONLINE_KERNEL;
        uint8_t **online_types = arg;
	... snip ...
}

int offline_and_remove_memory(u64 start, u64 size)
{
        uint8_t *online_types, *tmp;
	... snip ...
        online_types = kmalloc_array(mb_count, sizeof(*online_types),
                                     GFP_KERNEL);
}

So that's fun.

I'm not sure it's worth the churn here, but happy to do it if there are
strong opinions.

---

David do you have thoughts here?

~Gregory
