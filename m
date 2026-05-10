Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBFE375AC3
	for <linux-cxl@vger.kernel.org>; Sun, 10 May 2026 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778424021; cv=none; b=QL34visMOKZosXT0n+1FVlLCA8J1m86vU776nE/KSDu5jK3VimwDWo8cxGpTe0KXZHdyfH+EHlnO2PYaPv8DZiZ8g8li+S/crUYUwuQBJNz+mtGk7oehJZBJhb9xU9gG6whGl3Fn7PtUWhlmcWppzk95FInojxzCW1mBZYEgdM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778424021; c=relaxed/simple;
	bh=siSpsQjxKBJBQUtqz/CL8FbCQlQeBJKwELhg7lkt6kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BizW0jjGA+iNmBhbtqcvfJE2xw5E9rj6O/UHC/W6h74sdQcaxEczCweydoX67/LzkD6fnUelmUGi+6/6shjRbRc6EpWm3fepZUiK2Hdf9DW97q9rFtH9nqJ+BQDRfqDfDb9hPdi4YNJ0h/3RxmvCFOv3kMmiRSe4bkFSpQoGcg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DJJq9vvz; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DJJq9vvz"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50fb4a7d704so26189591cf.1
        for <linux-cxl@vger.kernel.org>; Sun, 10 May 2026 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778424018; x=1779028818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zN7aWTUA3H4RFHbkfRpLkMHDYoiJE8XD5BaVLkKqp84=;
        b=DJJq9vvzen0LZVjxGhKDtS1iqoGK0QDNZ4wieLAuqSFGe7EaKsp7WgdiC9ezNG2Hen
         LKKCmw6tSd+ZWxUu1iBYIEOxexIU+s4+uNzsgq12YZOF182fLKdLpAE7WxAejfSq+cQv
         v9wdMp/YVCYgHnzd9FpZHHr6jE4h9oXWpbLJTRzOqYP9qjOYyL5cHj1ZOds4qCCmMxXE
         QOHqIlTkE7YUWAsiM+ISjMd6LzciBTz7QuZ4z2rpgMGV5bw+2QkMLbl/2S7EJ0neoIKi
         qS6uAbmbrNHYnlRT6QSVUupc2cD30p4TAqwkfqBEz8TVBWW/i8tJnkniNdLdQiXEY49g
         93Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778424018; x=1779028818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zN7aWTUA3H4RFHbkfRpLkMHDYoiJE8XD5BaVLkKqp84=;
        b=c6XaLtAorSpT4mg5Q1ptOCj0/9kH1amdy97k1ylUzunAls5LZ7oq6NJtSAAn6NHdX4
         4b85RvHP8u153ailw+9QegkzONHyXtZ3b8utM9XJZkLxG8BT6HNnx+XMWdHdL+ZBMvXi
         9X67ZfuGkyWGw4a1BEbb/twQ97KU6b6QnjYIAxmGYyShZhk7FrRPsyHN0/BjxVaa5kxF
         TnCfLK2SkvhXwaC+e6PUkeSLinEgpEelkL1jYav6MYcaNItZkkRNFz6TZLaYtzsDO46e
         JMjHVMaHl+xOyGaXnShQMUsYOL9Rsm72KOyWxb6iyYyeesOIWoyBjmo9w/rwnetprcrX
         tYAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CWHvKonpT2ckezN/tqvlD25lLMY58cHsD7dfMyZN4hX810cAbLH8/lbH7N1vbLaY7p4l77MQHuqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHzMbFAz7sSJs7zm8kSwuzs8im29xAFuov7kerCg3UYPJ+gjYh
	lv8wKQpfNop+U7Zf6Rjqmsd1vgCCZr0Q+ZUsfk0JkQcyHWztqK+kW3dpgJwrFC//kr8=
X-Gm-Gg: Acq92OHve+vdF1OCN8Bz5/fzuqW0AM+W0OHFPI77YYJ8CG6jlKvm9dZhzHAPWXVKYl4
	BSIxPfwSS+Dq8sneJAj/3O0212QTm39N6oEKI2L4cfpx+RAvQgk9Wl/JuaO0Q/reAbPM34OaZ5M
	BWEcdgvrlHZSuFvmS/TsvrvYz6kO0cl5QMJn1gk2pDIS25vULFGgw58z2732iSQOmXUJF6ZNxhO
	JKAJqGYloNchaewyuMijVBv4DUreFhDAW6hIz2D9KMTvAERGNNA21BokE3VsPre3AnbGQRWd0uG
	qVeAueCTdk/bI43Pb8tr3X/VpL+9h6ZX9WpKIvC+bCxQXf5omMvZbDF+Z+MwHqI7vDrfPThEjsV
	h0jC7ur550oEvbIy3Qf2Cqw99RjCz92WFtlsOKcIrafLXby4jsZ+DZfU1TqCNB7qBZ0qR2KI+kT
	Qj455R6bjWLmjwzpYbEwV6gj9s0Mqoz8d7wpddvkeIPC8utmV7rmnag8ZIKEOJUF5i/9aX8cVL2
	5mkCf2nHQWr
X-Received: by 2002:ac8:5e11:0:b0:50e:89e9:271c with SMTP id d75a77b69052e-514a0a60821mr91286531cf.17.1778424018487;
        Sun, 10 May 2026 07:40:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7bef56sm67617811cf.15.2026.05.10.07.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 07:40:17 -0700 (PDT)
Date: Sun, 10 May 2026 10:40:15 -0400
From: Gregory Price <gourry@gourry.net>
To: Ira Weiny <iweiny@fastmail.com>
Cc: Ackerley Tng <ackerleytng@google.com>,
	Dave Jiang <dave.jiang@intel.com>, fvdl@google.com,
	linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, djbw@kernel.org,
	iweiny@kernel.org, pasha.tatashin@soleen.com, mclapinski@google.com,
	rppt@kernel.org, joao.m.martins@oracle.com, jic23@kernel.org,
	john@groves.net, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 00/12] dax: Add DAX to guest memfd support for KVM
Message-ID: <agCYz5O36zLATni6@gourry-fedora-PF4VCD3F>
References: <0e831045-3b01-4934-bf43-b3ef01ce0158@intel.com>
 <CAEvNRgE3ifAvgVS4bLeNp_eVp0=6b3p+myYEXSfyS+Qrw5mrtw@mail.gmail.com>
 <69fd37c5cfa4a_1d1951006d@xwing.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69fd37c5cfa4a_1d1951006d@xwing.notmuch>

On Thu, May 07, 2026 at 08:09:25PM -0500, Ira Weiny wrote:
> 
> 2) What you propose above does not give the gmem 'protection' for CoCo's.
>    So yea that is the bigger issue.
> 

Realistically, what you actually want is to add:

   private_dax.c
       +
   MEMORY_DEVICE_CONFIDENTIAL

And just make sure they work together to produce:

  a) open() works -> produces an FD
  b) no direct-mappings, struct page exists, can be accessed by KVM
  c) all userland operations fault (memory is never in direct map)
  d) unbind explicitly zeroes or calls a registered sanitize() func

But this adds a new dax mode and a new ZONE_DEVICE mode.

A private node with NP_OPT_NOMAP might be cleaner, but you still have to
do the hotplug/memremap dance either way.

~Gregory
