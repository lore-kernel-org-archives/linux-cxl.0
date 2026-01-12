Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD772270EC1
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768258736; cv=none; b=rhEEp6DAvVw6/dzCHoPXH6HeqlO0rC176Vjv15I9SVj3CSe6BdVbgumF0cUqLpfiOiR4uzVXc/u07DSMkXyzcECDK9V5RskLaDQKReQWbY835w2MwDh1OAA7AjOatfSOvOwfnmstfmtZTLu89wevThAqzSWQ8wbjPDfwqhH96rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768258736; c=relaxed/simple;
	bh=OSvzN76rg+seSFGLS7/iTzPxgoJrSwfFsL1yCV0y0YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWNU1krqjXAy/t/FDtwdUOKR5XnBdRG/ACBlYWHUp+wIT/PWcchwJFbINJ2ixXI9HZPr6CEUEg9G+iWecJnN28/g5wvSJRNoDjwS104zUSLZpqD60iHP4WR1r36OiBnImK+K2TJHUe9YiEFx2te40IVmClczLAm3nPZOGXS6TW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HI2b8Qcj; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HI2b8Qcj"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c0d16bb24dso657796585a.0
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 14:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768258735; x=1768863535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+jOrSXuNU+8iYUyXwE2u0G+cRndsCz6SzUMkSsouk8=;
        b=HI2b8QcjvhSa16UtnnC94P5UOQVULBcHYwCatmUG5mSqYzJt93LlpcLCzihucuX5Ao
         KwaHyxG77f8k4n2lirVRsXAXwpIJcbR73YVabZYzKOE48dCWY9DfTnFcZNB231h6h8cf
         +/XcDA/vypgr8jBdoMoaZ2Rag8G9yF62YjXLRERPNFqwA8Pq5g/q6Mc3g1g/J3XbGion
         0MgOJ4Z4vEv6R8VQGlfDQtAT3BDS1hmlhRkfaSurFq4lX+baoGjgQy5i04FVkTLMRQq8
         crptODpJHt8ImdnGa4X1GmGz48ihpoi1G0f3Ctqpp2TPy+oxFq902lME8sI6M/4hk18t
         5Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768258735; x=1768863535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+jOrSXuNU+8iYUyXwE2u0G+cRndsCz6SzUMkSsouk8=;
        b=DsWyjOR3ggGttQQFhRuOFU3qkop7DWo+0zW3J4xu+7iKIHimK5SVeZ4Z7xNS+ZIFw1
         6PKsN+GfIi+0jZIjHu37ddm0F8t1G5KI+Ry2xpqZZxAC2cbLrrOz2KkNc6IG1TtNjJsY
         918HOvzHCvMyBMnulDkZ2GGWZKAbD54f2Hgg4EYgTZJgTaoLP6GTHKLo3cPh82fha8re
         g1b405xMTZSI8MSQ8ZkoCFhSg7WbEG+43RBiGLbwpqoeM1yUylsgenPvZMldOmTFxIGX
         4Q2z3Nk+lJ/Wt9fOZsjs2irXVHZjUeoBueUxXn2w8CrWtaSQzd62ORXMspNw70FRAdNa
         Ejkw==
X-Gm-Message-State: AOJu0Yx9OCniBq+0vtCaDqAL/NkRpbX/rtanvffs77ErynsE9MfI+4dm
	Ii9VZUVg66Zl72msavpx47veU8n4swydcV9g4quyRSU5Ick5nmY5ffiCOES1rqhJ6uU=
X-Gm-Gg: AY/fxX5o3bjPrbaFxyfKHTNT9wZPEJ4cV61Vm1lY9ko1cMOy1K7AfjNPaxqnrlP5I0i
	dWfy6NghU46XkVApj/Uk6wOvE82qPHSclnnPPux8/YyWbXGb4fP/7css6LlDLMsTXBmLRACFTZs
	E5kzQEcfPzg52SoVjvGmXtklscJy7jCgTm65m/e+S11Kuctvbx7ZQ0nhdOLnRxPJQ7b+vOKIste
	f+7qXcpAadrqDBopX/Q3kfztUDnXRQprOulzsp54iqQO1semL6dmwzGT/SrdiCV8AEVNZwaiWWF
	qnREVU3yTUbWMvjygghhslR4In+ff8og5Bcq5KzyBv2pbV653PpVs2KZUTEQ6G+22YfhcISgftH
	DJTXgvyeWqNCCVHAgVVZ41Yy9EKmnFJBmURyrZdfdHghGVBvMj9r8/DqrTvXFuD4fHEft9U8SCQ
	IgEBnzTOwVpuhbZz9MJdodCZ5gyIkImiD8+jSNq5ZmfOqAR6KOqPk7E99JLrE9n3OkRibWYA==
X-Google-Smtp-Source: AGHT+IGPazFaHUXjrDI8vZD8dC9hZWiv8xk7YlvWeX/nonxL8cgY5K7prBq9qebB0rMTcisWnKhSxA==
X-Received: by 2002:a05:620a:4143:b0:8b5:8ba0:b312 with SMTP id af79cd13be357-8c3893dca40mr2875894285a.48.1768258734712;
        Mon, 12 Jan 2026 14:58:54 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b917dsm1661818585a.17.2026.01.12.14.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:58:54 -0800 (PST)
Date: Mon, 12 Jan 2026 17:58:21 -0500
From: Gregory Price <gourry@gourry.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, s.neeraj@samsung.com
Subject: Re: [PATCH 3/6] cxl/core/region: move pmem memctrl logic into
 memctrl/pmem_region
Message-ID: <aWV8jSUoCG5Yxv_v@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-4-gourry@gourry.net>
 <1b9d3e1c-7b8a-4c9d-8788-4f901f985079@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b9d3e1c-7b8a-4c9d-8788-4f901f985079@amd.com>

On Mon, Jan 12, 2026 at 03:10:47PM -0600, Cheatham, Benjamin wrote:
> On 1/12/2026 10:35 AM, Gregory Price wrote:
> > Move the pmem_region logic from region.c into memctrl/pmem_region.c.
> > Restrict the valid controllers for pmem to the pmem controller.
> > Simplify the controller selection logic in region probe.
> > 
> > Cc: 
> 
> May want to forward this to whoever this Cc tag was meant for :).
> 
> One nit below, otherwise this looks good to me:
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> 

doh, meant to send this to Neeraj at samsung because they've been poking
at pmem stuff. Thank you.

~Gregory

Neeraj:
Link: https://lore.kernel.org/linux-cxl/20260112163514.2551809-4-gourry@gourry.net/
