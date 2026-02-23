Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B983D330334
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868760; cv=none; b=eu25xgKQq2vyAEXywtXZB/VV7gD5OQ3Gagh/5SQQ1aVZ2hXdgrWfQiz/Itixn7XZeU74WflyYDgWiCzwzhduZ/EXJIFDdGj8dJX6SPRlpgcXjezMvMzEJvUyiDRzMQPwg4yAaYIOS2CHSxW1ZWkL87UW+Zv8WIAAJFNylF+hXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868760; c=relaxed/simple;
	bh=Mr4dG+bzOuF16thFEQnsIOy91AByP119yZcwcBivwY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEEcpue8i4ik+9aKU5/ixKpMrjtw+I/44/yJXN+f6kpGsYyHpLHYWTcV1C/D2cemNuDlxu/hbUzeVX7ihA+3siBOVytkT7GuDdGoXevokXOJZiLXY2FKoAnb7o4tSgIWNlruJMSkSmMKWb/L0SUqS1zyD/B5x7m3PE0FDd6pLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=T7wsU5+H; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="T7wsU5+H"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8cb48234b08so488983185a.1
        for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 09:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771868758; x=1772473558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPvGJuHAbjpU9QDADIGmFWRlHKf6KaDUt58YXXRLtsc=;
        b=T7wsU5+H8yrtdKQTgbMZLZbJPG+0sFxsXygXzl3W2kbqHtFYXzGdeNDfnOgFPX3n8V
         uFR58PyrRZNVYDR5mKzNNDzUs9RSNF4hBi2Zx/5TKH4wgcOAPpcNM4hxdtNc31tsOcwK
         oNZ9kYCU6idrNzEBSUyKGFA04hO5+WKsKDhtgGuFR0Hgu+htlYZIpFqMocQ9iHu6zKoN
         QAQzOFkrN4fyFEriTcgsY5zjE7O7EePvu5DmR/vqdCCxaCXvHqq6/zsbkB5BuAyTwvjQ
         7EiSrCy3mcLB3m8vO7VAkxOZpv2vAoHRJVvJoIrCnBS2MJdDjiuwDcl0kjH1Z7g/E/nQ
         HFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868758; x=1772473558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPvGJuHAbjpU9QDADIGmFWRlHKf6KaDUt58YXXRLtsc=;
        b=f2gDsOQtg0v1ItpM9pQN8NN+J4JvSh6TgcWtU0fljP9uRwfPtpPOS2nS+APSqDj+f7
         EJx1VA+16f3u4xCmB52OyM/E6JN7xWXPGTArFkuhha+GjoFRiE1W3oLfda+xG+z1xJ3K
         Kea2eKgaipY5wfqF2uvIzlC/Imf1zrxbVnH1N4TQRWq7dSBqBy/CS9muYM0+1AdAc7Mx
         7b78NDe4/gY97sbFxeUAIWDB2iTx7HUdGgQW44WGFfaAN5BI0vfilpJ8zoYvYs2cXwWo
         g4YJ8si8XQWvwWSDoxWaeSYwX7Vg4G9od9H0a5VsfKQKSAnS9s+1X0g6LU4t83VDRgH4
         eSGQ==
X-Gm-Message-State: AOJu0Yx9vFZIEHNjli6T4egU6sw+C7CXU1PcDfeWHtYykgy795xltlc9
	DNxpkORfeWZUOchCGBtLTeDGpjf1v9OIcSWZpPpnRdG/RAU9U+I8g4OwpZBFR82w6mk=
X-Gm-Gg: AZuq6aIP1awVS4/ytGgjYtcLP1tSEH/QLJhYAlFepPnoft+V28Mg1OxRTTrKd3h7KkE
	XGRErdkjwU3zz+fm4y1U8p1RRlyMceVoAl542kEbYPLNoA1ZNzYHpG6kDleuqK9NcCwXcKbrbBI
	Ko6QdmyT/U/HKmI8dKrkKAVPvEwqA6QyH7o861dp6/7ahYyO/ItTd70z7vHUs8WZzIJzEixwvEw
	na+W0agpexfA1uG7YDV4GaP6VZQZeSOKB6mHvZ0MuG/WBlyv6fp97IobHI4vDeGUveicygkyZBg
	fehIsIaTJC49Qyf54rniMYSGHhLAkj+XNuFQBjpsI0d7K35RKjM4nNz240GKY3QOcRgvFjsl/eJ
	Yzl08rHsAkkPYIeL+XvClAkASubJmFZ9jCfgwRaGt7eF8cwfKKB/TcYMBGU1YrR+q2KG61PCzCM
	t4RnQGDwYNf6hQsQn6lqtyzj9rX02XSxvzR+p53nvAat4JwyhnXoL1pppfjosLWuuTqL1QGjgPl
	M0xeJJtag==
X-Received: by 2002:a05:620a:480a:b0:8ca:3c67:8924 with SMTP id af79cd13be357-8cb8ca71e02mr1276284985a.42.1771868757602;
        Mon, 23 Feb 2026 09:45:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0461dbsm854265185a.3.2026.02.23.09.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:45:57 -0800 (PST)
Date: Mon, 23 Feb 2026 12:45:55 -0500
From: Gregory Price <gourry@gourry.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH] cxl/core: fix test_bit misuse with CXL_DECODER_F_
 bitmask flags
Message-ID: <aZySU-tcjVvYcb23@gourry-fedora-PF4VCD3F>
References: <20260221021810.1390342-1-gourry@gourry.net>
 <85d7abf8-3b3c-4199-a680-1453f77b3fd5@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d7abf8-3b3c-4199-a680-1453f77b3fd5@amd.com>

On Mon, Feb 23, 2026 at 11:33:13AM -0600, Cheatham, Benjamin wrote:
> On 2/20/2026 8:18 PM, Gregory Price wrote:
> > CXL_DECODER_F_LOCK (BIT(4) = 16) and CXL_DECODER_F_NORMALIZED_ADDRESSING
> > (BIT(6) = 64) are bit masks, but three call sites pass them to test_bit()
> > which expects a bit number.
> > 
> > Replace test_bit() with direct bitmask tests, consistent with every other
> > use of these flags.
> > 
> > Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> 
> Alison sent out a patch [1] two weeks ago for this. I suspect you found this bug
> independently, so I figured I should point it out. Otherwise, I would add a Reported-by (or some
> other tag) with her name.
> 
> Thanks,
> Ben
> 
> [1]: https://lore.kernel.org/linux-cxl/20260206181404.1025991-1-alison.schofield@intel.com/

Ah, yeah, missed this, and did find independently when testing unbinds.

Wasn't on cxl/next so I thought it hadn't been found yet.

Cool, thanks!
~Gregory
