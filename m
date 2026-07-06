Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43FE384CCE
	for <linux-cxl@vger.kernel.org>; Mon,  6 Jul 2026 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353258; cv=none; b=b5ZK8oJN9Kz1uJm/p/9OfTkd4COkg/SWI5DdlaXms7rtls6u++RSgcqBXHN0gJfdJGxTOjG7geBlzq6+1lccmt5QggYI8jcdgCH7umh/eVyHTFqAZH9fRaePjJjMhhfLNOwSMvgPbouaaY7Mo4mjxhcsCcjsqQSfYAcYNPf9UVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353258; c=relaxed/simple;
	bh=jgtOj6HV0Lc74Fqi3YIUHikZwpNHEx6Z+PICt2TBtOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUPgVF2ozGmVeN9hqNCOtmZBVj1wRcqo7m7B5SFwgASfp0xXyhdCyF0caUhcSB4f2zrfttH3E2mRWDe11xANuKE8Syu3o8X0pszPm6f/dOxbTTnIfky7msCz8jVPH4vYdaIjrBqa1SZIqJ1UEs12hkKR75K6CmTFETWLWDGzddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=T/8O1Qpe; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T/8O1Qpe"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ee88fce572so28362906d6.1
        for <linux-cxl@vger.kernel.org>; Mon, 06 Jul 2026 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783353256; x=1783958056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dIem8hyNlrcvgSP8xqIijowENEp+G1sYVnPl46s39CA=;
        b=T/8O1QpeP78nJ/OkqbzrxdaIXjUVtpEka/Sb8ndpjaSMdimAv/kSDNox7FixBtsj9h
         YqJgFxZuZb/ykoTmKJ3ESaihh/hGQtw+zFEY79mwmbAfCnEf2PR+d5NHpXvK6fG30as7
         j11EnI+E0XeeuSC4Z0GBFGBu3x/6ll/xUhtfvkCc51fjrZRZWiqNDCtqbnCYkqfXQWf7
         ldLZtSRidM3DrBYVoLrYwuthnwf9KzYeshNCDQmRjABVbYjOMZrOLnHlww8SZd+Ah+Jv
         WJ2zcIKWdAuWlB/ilMZKeqjz2/TPRFfA7bY3H5i5ZBKL18gKoExPaAzw1O51dhhGlqBX
         Hgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783353256; x=1783958056;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dIem8hyNlrcvgSP8xqIijowENEp+G1sYVnPl46s39CA=;
        b=mHnFAj2O0vDuq7xMdPlAPlbyWuNFwIODH0Q3ZzaxIZqqxL2vJp6HRmNKACe1+9lWDS
         APt/yyegHhpohjV3VZahidZ/PPu+wWWLLCZ3Gji1m90PMavO/chuBg9Hxtq4O4N7aA0V
         iu6a3b/OtAcPGNqgdud8zgbRGtb3pIL7BwzVs4oKQcAsW6iYwDAH1OYMvwbR/449g0Sn
         pjNyyrUrxks9BiUNf7e0Mfu9MluEFV3KUo16gipTeC3KiFHmkQvFyjjb2mpd9WjGYFG/
         3NBGlvhKkOgd04Y8g9Pw7eMR+HYjWD0wC+G3E/AL9FStNqpUQmQrupvNtszKYFS1kRzO
         6gUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1m1NILcp40s2Rd2R0eqXyT2CiaIzeaPGFkhVJ4mnGj2AOeG8ujtSrqT6DDxCXhhTsxY9zTPEaJUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwuTnKR0A/K7jr0x0ceI05lL9uXmrASTpggh/ZcoBdUMijKULL
	BjknPDWFsha+21PdOBVlNJS03YXj63XsYmdlQyLxSeJkMrSmPwiHZPGZXTHDGbf5euw=
X-Gm-Gg: AfdE7clpovN2aj9tEu4meDnS8g5x75dvumfTv3o9KpwC0tk375JxTvacqKYHJ6hJUMj
	wKhg92ssUaabv4hqLYqLPP3cpi8zExOVqL3J97E1NQpfM7eA4Zcova5W7G3OlFb+6IA9ZR9uz02
	kJKv36J/2maA1zGQUs7jl2i6x3eXEXFEzzQsI+R5aeLCJLkC4Rdk9F5g5pdASCFCw00XrhhoTXs
	mzb2iXK9ByQhiEDTP2ulANs9z7NIWsLmdUqg5EqgWIpc8ovPaeeIHyKWpQWOCCN/MJG0wj9TV5P
	+ytvsQ2ATJ10t2tPEF42ldJYryO58dnPP5S6TNj1iBa8LCtmYSLNbUt3ePlrFUEqueMz1IdkRK+
	T19MqCIL1voIv4e3zXtl6mAUvoICOPZiROd4n/nmRyq5WpKlhMg4h0U9QHG8S
X-Received: by 2002:a05:6214:4506:b0:8ef:4749:b1cd with SMTP id 6a1803df08f44-8fcb461b5cdmr13721496d6.30.1783353255815;
        Mon, 06 Jul 2026 08:54:15 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724bad04sm151773616d6.44.2026.07.06.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:54:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wgleA-00000000a9W-2CyF;
	Mon, 06 Jul 2026 12:54:14 -0300
Date: Mon, 6 Jul 2026 12:54:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhenhao Wan <whi4ed0g@gmail.com>, Dan Williams <djbw@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] cxl/features: bound fwctl command payload to the input
 buffer
Message-ID: <20260706155414.GA118978@ziepe.ca>
References: <20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com>

On Sat, Jun 20, 2026 at 12:33:15PM +0800, Zhenhao Wan wrote:
> fwctl_cmd_rpc() copies cmd->in_len bytes into inbuf = kvzalloc(cmd->in_len)
> and passes inbuf and in_len to ->fw_rpc(). The CXL callback cxlctl_fw_rpc()
> ignores in_len and never checks the user-controlled op_size against it.
> 
> cxlctl_set_feature() bounds op_size only from below
> (op_size <= sizeof(feat_in->hdr)) and then reads op_size - sizeof(hdr)
> bytes from feat_in->feat_data via cxl_set_feature(). With a small in_len
> and a large op_size the first memcpy() already reads past the
> kvzalloc(in_len) buffer; the out-of-bounds bytes are placed in the mailbox
> payload and sent to the device, and a large enough op_size can walk into
> unmapped memory and oops the kernel. The Get paths pin op_size to a fixed
> size but likewise read the input struct without checking in_len.
> 
> Reject, at the single dispatch point, any request whose fixed header plus
> op_size does not fit in the copied-in buffer. The lower-bound test guards
> the subtraction and ensures op_size was copied in before it is read.
> 
> Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
>  drivers/cxl/core/features.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

CXL folks, you will pick this up?

I think it should be cc stable too

Jason
