Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793408271;
	b=0FZXFK/3DD30aIk4I34cMKaK/s89oUAZWE1EASjPYF3dezXR0RE0bpQvdMNxSiEkuaI8
	 h5mw7JEwxv5c4YZoQ6pJR0ISyn10zue9dMszTjaBfEfC2nho/kgct8r1rebxyZfNoFJES
	 C9ZIdq5o+/QytptFHMvYjC6LNCwCeY+XFep02inV6m5VGhNGAO2n6E6q9h6uFWHXyYeLe
	 wtxMxOD/UkQ6VWuKugiba3srL9bVCru8bAZPDbEwLKbYv4sBW60E5Q7xz5FuP1Sy6+2hS
	 SITcmaK1y63E73zfppx4Pe3nyg7au0c8tWNeBB8im+7obOu48e2TxzrowduQIuoOU5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793408271;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Bl537ijlD23VW4erxTZOlzT9E/4cxctJl4Miyc9Kivg=;
	b=elvT+DoSwBqk0mXohswBGSZoOyX/CYadJ+vKUznM++CysVOL41mFf+4E6qyUvBi6z0pT
	 xGKbbfRJSG3rRFuEIX+xf7oeW1z2S5sw95dmAAaEKhxsicbhqeVcx3uemmiGYtv/XrjQh
	 Lu8XK6csW5fTrfbrobgt0wIeijlehSEjXE/8dw04UyYlLJGbzMDYZNDkFdotS2lwe+k3y
	 XMd44vviDMqg05+aaCwSz8tglJGilnzgQ0xjjAbyBW2LsAwLlNSBhODfBv+/GswoLEtwJ
	 TBMDPRsgSKs5z2v/jJzGkJgOgpKNlnHMUG06rcr+RIUu6F5POpTmKU5Hp1bSBT49U7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473E2606A31C
	for <linux-cxl@vger.kernel.org>; Sat, 31 Oct 2026 00:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 473E2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so655590a12.0
        for <linux-cxl@vger.kernel.org>; Fri, 30 Oct 2026 17:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793408270; x=1794013070;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bl537ijlD23VW4erxTZOlzT9E/4cxctJl4Miyc9Kivg=;
        b=AtozPMoGLcNhVrJmGA1LC6yv7XbM9j/gR2M3c+TTlnFCKpMALk1q0DSUZM/jc2Df9w
         xmISy4EeMOKFenIZomM0QVCIiIPAoESoUlbf4YR6hZeciiZGOz9BSzxiucE4maeaQn80
         uKNakncoHasNbT5R+boc8JpTi/h0RhKL5p478GxDL9tfW0s1NVXlejzM6dQIhMHw/oW5
         ShjG+SDvgPlnOa4GX4ZU8L0Qhtq1Spt0HgpuywSt9CIJ04sdIUSNzCJeyHbTRO9uquSB
         nQowK2RQdM/fmtBuzdc2CVLnP0Y3ojbv/YiMRnA0Q32xWDDyPIxvgLaNR5e6fjmWwmZY
         gXqg==
X-Forwarded-Encrypted: i=1; AKwUvBxuebhL3kd6zcq9gmB7+zsg53sahdOEkMUhFBt15+SdmHVVUitXvYsHlKAh44wmTKzCajyivm15uf4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiEmXF5VwBaiP/cmU3mqLTAroA8iY//bcmzur7euqAeL9mc6Mk
	cdG1jMWEIQ2zIzIEuL7sT6PZlHD345gEUx/2dUqsaCIaza0hrAyTVQrZybZoEikq9/GK
X-Gm-Gg: AYBFou0giSNXdKGNLNosbbNh68NXsuPFWrrS3ux2s4TnAbXK/Y1FEWVv5BvAL1WJ+UC
	PzS0+gH/j/WTR79IyO0os0EBleaStAQsFJ0+8SSQQhBAXewYa3CeA+GIQ+2CPjcIvU5aveGPoXL
	dtFR9Q3IIvRpu+K+PYWF9Dv5vyMbemjE8CfoWzLZto9mBSe9T0mVw7oqxXouQQJHjXGMJrthF1t
	RJ9dKJMS6UeHoA0xs2cUaoA117Z6mUaVJ0WBzr/M8/HvCqCMVUvj8e+zEEVEB8e/IKEgXfyZopN
	twTt730iCLnLevU+szRaoORtaGGCqecvEjmRsIkcY5janioSg3AhB7K/FgxoyQ42L0tSVJp9m4+
	diiVpDK3jetb1ErO4VvlbYHsmUmJTido/PcXltsmAGA52zzqH33det8QoKJkDboLBM9AyXp6Njk
	2fsZG02m7Q07Nq/ICdDtGwBC1gwG8FtxhuoCEXUJJuWcLzyVXD2O9Va/9NOMIdOItXvhzeXtpuR
	7fyc7jhqr7OKBl35z2dJmUIJm52kMEq8G9ztOm+6II22TDmosrbJl48pkTon04KvoSoZkp6QBHT
	+buvf9zscoTrEl2MDbZuTS5ya7qrdpv3wxyq2p1M1z1X05UrQuhn2mNGs/8nvBOq36tTHROnBJd
	FDSq7aG/YWMKQ+B6m7x14QJQKrbIwM7c9qvIyN8U=
X-Received: by 2002:a17:90b:440d:b0:3a4:fe48:d410 with SMTP id 98e67ed59e1d1-3ae897f8c6fmr2910757a91.30.1793408270496;
        Fri, 30 Oct 2026 17:57:50 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98f888sm10200098a91.13.2026.10.30.17.57.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Oct 2026 17:57:49 -0700 (PDT)
From: Jongwon Lee <ai@linux.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/edac: Mask DPA flags in the event record cache key
Date: Sat, 31 Oct 2026 09:57:42 +0900
Message-ID: <179340826284.3478.8780635809480680434@linux.com>
In-Reply-To: <8afa233c-13c3-478e-89d2-1d3f87ec7c08@intel.com>
References: <20261030072721.31970-1-ai@linux.com>
 <8afa233c-13c3-478e-89d2-1d3f87ec7c08@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On 10/30/26 10:44 AM, Dave Jiang wrote:
>> Co-developed with Claude Code.
>
> You can drop this now. Or just put it under ---

Moved it under --- in v2.

>> Signed-off-by: Jongwon Lee <ai@linux.com>
>
> Is this a real email address? Please use your actual email.

Yes, it's my own address and I read it. It's a linux.com alias
that forwards to my inbox, and it's the one I use for my other
upstream work (rasdaemon). Happy to change it if it's a problem.

Thanks for the review. I'll send v2 shortly.
