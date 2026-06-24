Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22070332623
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782327568; cv=none; b=pYbbJHKfMMb3Vj+K6+TSZ5AL6RxPElBtqwWP1CBwPajke4/6IW8/nxtfLHNap7rF0AAJmqrMorjAnZeRDZzsRlzJWWeuFrRWD+7TPTTew/ED2NVRTeA4Ilp2dzVA1kR1IHD3Oim+zVZ6MKdX0U1vcK0CDYmFdcDzefMWPBRTwVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782327568; c=relaxed/simple;
	bh=zIstxXEsUAI+ajGpmVV2P35LQJBkQnh0RLzi3QQJ3UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFECioxzsZT8H0RPl6AznBZ62z/Wgafyo3CB7B3MW0w0aILJiXB+KN6lThZb6yOUEAoYPqxKISa6vMwRtjDPoHlmEiIOyyVPqjNXwIR2Z/MY3PJNygrJtgB3toCYEYGrZsXDPcfm1wj38/wvTBA9B1FvYaef3P5a+NiVSqUrIk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eOSy0+Lz; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eOSy0+Lz"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8dcd895a4c0so15266806d6.3
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 11:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782327566; x=1782932366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pT11NgXcnMUuSA5mrycomy1NHWdVYPAjx4vn9wcSoDQ=;
        b=eOSy0+LzOURCxbTfWw68J/wjUy6HSx5RaFP5zduOe4TGryqd9mFKt3XyX7GcRdiHFF
         /dV0WRXjkxnowKwxk4uitRFVkKPr+HPk59w1jfoTeOo2oyq7EKPiq5ZAPFHgomS6TTfe
         5P9s+e1FAfdxqxfkrqpt6sEWTWEWjDLSTBruMuNKXRICyEcCbf5pvlOvv9qpi1L+d6Xs
         DAFoFBSAW4gGgM5p7MOLvTu9tTONXMHq0ORv3kSp8PAeTOP5TExs+OVV1XKmNqp8gr5e
         8hcxGnHI+8j6h13FvTs62Va3dnnP6SrDCD7t7iudeQdZ18shfocTi1eaH4c46POmhgSC
         z2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782327566; x=1782932366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pT11NgXcnMUuSA5mrycomy1NHWdVYPAjx4vn9wcSoDQ=;
        b=T/ogQGjXdEFkx67deXE+UWGB617dh46Da564lvz1qQaGV4wJ8VgLd9GE4mWEiSNLYI
         7St+qRhr+XMajS7tiU3fHixaTKR6KqBRwe9R0Rhiz+lVNNPbOtCNwNYMi0b+qEPMeJ7z
         FB5ZEeH4GgbGK53ksdtKUJZAK9TE2ntIP/ET5+TbTx+0VbAV0K3QPRUOez3TabqnvKoG
         k7tGnXEL/f6jKp6p2ninh3lSZdhMPOO3JX1tO5M7v6acnH/Ty4LF2KJ/q8vD4m5ezPEW
         43+QgA9C4u2vYvDLOqkUPRRQ4dM2r/IzkzhGp6jfZoxdsLX9ZkQM4/5X1tnsppLQuwdX
         r9pA==
X-Forwarded-Encrypted: i=1; AFNElJ9o8m4A2opTMN8ittMcuNoLCgsjZkNc7WpKQI0r/Li3GDmW4Kh74z3LQL1WbU8OuZ/EP7NUKGGM050=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9g95A4d521xsygZbQXKBL5DnAX/sgmI2FeO0jWhK1V+BUoQgz
	Za/mVJcHiVO0LCPdGo7b/RA20UUcxS2soxRCohx73XkHEg0rep7h2YSqsGeCsmMLpqg=
X-Gm-Gg: AfdE7cnHwJF/fwZkYA7Y4U/05iZc/u/eYzwjr8x1UzpMJOhPaBbN4LKsVhqUpdqMdUm
	eDmEu5VkJVK7K+hPKV7+D5j84ot36e/qZn0yz47UC1KQm5pajys0XoG/jZttaPU83WqP8ToSfoc
	aO9+g0BMAqO9ZzdjYro775rGpXseR/+sLHO/8+t1bfkUyXGK85achtkACXvbTVHN62GuAl58qW6
	AO5isaBtMrAwARkp7Wk6qRbxtWERi4QmyzTPo5hJiofK5jZYG2z857YRAaj7xE7jQOv8dmXO2N/
	KJWRLNAyTq51HYyWDrcttbPGx9fELLUOcUItNsMKAsxJG/fA9MudL9+7XVbB+t4Xh29EEDMQVg1
	KGFtTSF+cxQFM97mCAGy8k9Pjmq3ylmBvLAXTfxGwufJAZN9wq02R1it13B3kW2JbIKm97LHkaz
	wJQjv57iBnUagWDuDdLN0/nEPAy0r1U9qKJ3CFtChTtgLhbcbjWdmJAfaTlNKVAsdWgnJe
X-Received: by 2002:ac8:5ac3:0:b0:519:5836:2f04 with SMTP id d75a77b69052e-51a61af8223mr67843231cf.8.1782327565960;
        Wed, 24 Jun 2026 11:59:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f018898sm161022456d6.7.2026.06.24.11.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:59:25 -0700 (PDT)
Date: Wed, 24 Jun 2026 14:59:20 -0400
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org, nvdimm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, david@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	djbw@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
	akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, shuah@kernel.org, alison.schofield@intel.com,
	Smita.KoralahalliChannabasappa@amd.com, ira.weiny@intel.com,
	apopple@nvidia.com
Subject: Re: [PATCH v5 0/9] dax/kmem: atomic whole-device hotplug via sysfs
Message-ID: <ajwpCOSGapenRPsu@gourry-fedora-PF4VCD3F>
References: <20260624145744.3532049-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624145744.3532049-1-gourry@gourry.net>

On Wed, Jun 24, 2026 at 10:57:35AM -0400, Gregory Price wrote:
>... snip ...

Disregard, there are a few unaddressed Sashiko comments, I'm just going
to respin this.  Will wait until after the merge window closes for v6.

The rough shape of things should still hold w/ prior feedback.

~Gregory
