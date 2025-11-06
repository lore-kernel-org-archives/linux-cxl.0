Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51776242D67
	for <linux-cxl@vger.kernel.org>; Thu,  6 Nov 2025 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448815; cv=none; b=oBmmgsDKKqNeznewvF71tAzrhbbybsQqQjkLMEBbuVyD0SWWEW/wF9o/bb6esA896p935ZxMY4pW4FizO5MO73gMqTNW3R39FqstjBoZltBFWIB0xg/Q/csmilnGJi4Y6hXRLA2kZoqj0bI1hs2wTcmUAsMNwegOTSVAGy12G2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448815; c=relaxed/simple;
	bh=C0vHneuQhgLUdYFKx6kF6vlZglt7y3sZC9GU8D/7gxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbVRzTb6lUVYMwc8fWfp6jUxJRSW+TW56doHmEgWvegfvWkX45AgH4w8+WAhROcMOk+17V+/DifeLIO+WQLbt2QzuAsTWHYDjFoJQWjra/elRtzfKzGSIJ7SeVgDLn+ugFlUuDswTlm5lCE6GUhZNmdiocOJTC8aHQYqg41XpnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MVdJsHiy; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MVdJsHiy"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8af121588d9so156505685a.2
        for <linux-cxl@vger.kernel.org>; Thu, 06 Nov 2025 09:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762448812; x=1763053612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O9/U+DBQpTgitIHX5CgStWs1N89GhwPlXy4RBo3CXWo=;
        b=MVdJsHiyb/SYyRLDjaH14gM08GaPiKdgJglDBRO7GbzvKCWKiKw0Xl0EIRrUXpE1+K
         Bs2uWKsYfRP4KuzLuVIaoz9zFJfiB0He1xyD8QfQhOK3sgdvvBqif3AYjAjgIFbB7/IC
         OS3hJnYH+Pia5zKwYeLT34FrsNkbGPrLjiQxhXCWk2uTwop9ghZ3JBOkNJ5LqYDz9WjJ
         XspZBlWmUapDA/9eZcmuhwyiz5dcyfHulviwwb8mG/dCnl4SdEZzO18ahVTKSF1a9CPo
         mdyhU+2PrYmGtxQcGZACF2mSzhSpr0J3ZhQRzkdqMtxmrnZ+z/WZtdjwcLKzOzp9vwR2
         I3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448812; x=1763053612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9/U+DBQpTgitIHX5CgStWs1N89GhwPlXy4RBo3CXWo=;
        b=mkyYXZ8LY473ndJppH2nFbdgTHPWel4Fwu/BM0JnZJ5cOGThcEB1ms360Gd6MdJIMz
         R3ih7Tw3ttB8Z5B42JuhgzC2XmoqPpoGa24JOhVkLDYWTrlmgcVe6/6Ye7UtbyVMZbhw
         fVd83bnB/XchFLZIVztkWjL6WqY/dBUH5tqZrNP6DRj9ABjFJyIrC2nZYYQ/7J61zRCi
         E6bnlH5AKyZXno5SlX2FlJcNxHbjvL7exKvOhtfIrdk/gly5p8ZFKGsjGcXEfWGGDdzZ
         z6f7W6YhryGZVXb61Kc18afKMSLqwI++9gzNTz9noNM25Ow58Y16iXSY30XL0mHGzv0N
         vYvA==
X-Gm-Message-State: AOJu0YzgJrTZsjMJ7RtKmQMhlXdXs3IGQ8dxxpkK+PgLEEhndK7a9c/j
	4uYZSH555/7HnJne+PQ8iGQuADG8TUdHAwCdRPuYcDdALYY4wBOUVLjIA+NiFKLb6vc=
X-Gm-Gg: ASbGncviqLlv4R097jZ2K7Q8h//ljNbF0CXGjPQxxA70xOPoogAx3yWa5DmQX0oKLQ7
	7CM8aAj4/QSzy1REOt1nygApr3N9aw1oyhk/Tg1BLhlGw7iF+MxJ2MX1u8EoFNYANAj6EvLr1n/
	Z6mhewZU16/1ntgGM5hDKZgGtpLnbThjRlqmjOtUJe5vJIWupfwTbhCp3YzMxqiBXCqJ0vleE4B
	EIxFgyk76jM9R8l6tjFZOjC9jRDYgsCRJeu6tAxRZVzayFNRX3okKxYUn8FyROg96GiKnlUwtlg
	0B8Q2zt4Y+/OtMR2jzjdcCkWoDZQ9c5PBbegZlmrog3MjtrGiJDFaQYE8BantKzDEb8lyhAtM4o
	9YXhrZmJ0c8YAlS12NWkx8zOQ/bI4SaIdsw6wHPSM1HmW9ePb8xx1W4gA3zXbyFp/1WsdC+21V4
	GxrtogQhv3l1rMmpaZaa1+Ntym5AGqzpKcWEnzgCt4+uGEvOD/q8QS/W5yvdE=
X-Google-Smtp-Source: AGHT+IEf/eeampjHDhmRo6ZDkNQpvIN32WqkYSzpjd2urTjtt1O/SXw6t/ghU8hW3y/W1NpEJXhQWw==
X-Received: by 2002:a05:620a:4404:b0:8a8:e608:8c52 with SMTP id af79cd13be357-8b2453561e3mr49781785a.75.1762448812089;
        Thu, 06 Nov 2025 09:06:52 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355c18d7sm228867785a.7.2025.11.06.09.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:06:51 -0800 (PST)
Date: Thu, 6 Nov 2025 12:06:49 -0500
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH 1/2] cxl: Rename region_res_match_cxl_range() to
 spa_maps_hpa()
Message-ID: <aQzVqdjXTihh8KyU@gourry-fedora-PF4VCD3F>
References: <20251106170108.1468304-1-dave.jiang@intel.com>
 <20251106170108.1468304-2-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106170108.1468304-2-dave.jiang@intel.com>

On Thu, Nov 06, 2025 at 10:01:07AM -0700, Dave Jiang wrote:
> The function name region_res_match_cxl_range() does not accurately
> convey the operation of address comparison with cache size. Rename
> to spa_maps_hpa() to provide a better function name.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Link: https://lore.kernel.org/linux-cxl/68eea19c7e67e_2f899100a8@dwillia2-mobl4.notmuch/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

My favorite kind of patch

Reviewed-by: Gregory Price <gourry@gourry.net>
