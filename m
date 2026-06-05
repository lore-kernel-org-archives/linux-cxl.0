Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E793C6A38
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695823; cv=none; b=gOjw0bnjre+06tGNe4gj7E41rV4TyVmq7vpVAuGuRouQ9okBY0sXuV6hRRPIdSncMzJnGmNev3uN7zFw2XRFx4t/Ck2TOwATZbYzy2kzf2Qm7OATMNzXuHB1XFNzWn3s4YTmrgd+AKOwObPnydrs3oHE/dTumkZy7zGqteEudrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695823; c=relaxed/simple;
	bh=g/uKp+Kypu5nsKraqsfRJP2QJGUO/CBDdxfUmVZClz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D76Cw66tEp287EPf5MAZquy1fjUAiFA7B9NP5ihY0dyQUmF4Sn1EksPykvsnRtl/22nnAjJkejJFcGr85HZMz1gdAuCVMFjt//1CGMUvEZvDvaiCTvwKuqddjn2HUdnngeOzdgZNa9qFTIzs+trn7aTmgSKunXFwcKOM6QLReU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=G2jjWcqg; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="G2jjWcqg"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-91578122305so385851085a.0
        for <linux-cxl@vger.kernel.org>; Fri, 05 Jun 2026 14:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780695821; x=1781300621; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w3e264EXuF93CA2YNjr7D6CScO/3LfEt9+ewpdao2ag=;
        b=G2jjWcqg6RsAtG0BcX5I/kjlo3n2qGDPQSmL0stbCbijSEjHIsw0k5e1f0gyLwJcAe
         Q+J6aCbYAu21kSre+uMtwLeXW1OJAAZZ1DeVoPLQeuTpUvrWb+VqXS82xv0dyMVLzzzJ
         8tfaZRsARMX4m0QGqLcP6egHXbBV5u91aETVJuGQYtjIK9YoDTZBzDBSL4Seu8n0PRbV
         K9ODRFFmzVcZdzUZ+dm5txNNxRtrgLK4AG/V8hesi2M3SJGWZJL0yMLihId1rDm4QPPN
         JwWIm2vM+SlbLvurN79T4CVZZmDi9O0BUd6rgeAfXiQEfReFjcQvPA8DPg9lDvRX4+r8
         L21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780695821; x=1781300621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3e264EXuF93CA2YNjr7D6CScO/3LfEt9+ewpdao2ag=;
        b=YDUqnmX8Bc0RNxDDX50W/zFY+9c6UVv4Ex3yO9sb71lT8YTb/u5KiIZqDhhpAUV7w0
         cfHBUBDtYnz09uNIQjFhRnOjpdMrbVNf+FbcRtrtf7wMV0eZrJuCsARQ5UB+LDfpWZze
         Yjs+Tpu9nzdi28QKDBBYJmMigfZvzDfTBAzhti0hfv+WIRaC6Sz872obtvlvrtd/OeSh
         1qeiDIcsZO3vrV+OFktADbzz9+BFIh12KNshxQ0JInc/vzP1r+q/3di87k5PYL1GhH/e
         fZwjS5K7UQ0im7NBpBjbp9Rlzbryy5+73Vad+OxLhtbw/4bPlnpQ184MIr+aXyOTBTcL
         T7IQ==
X-Gm-Message-State: AOJu0Yy+65ePL6rrxcJt0CQLiZl9Wh5YS6gyVV+ZlMN9zwsWGsU77CdO
	uxDC45bnBo4P/oPv4w1YRHCK/6FMmb0gJLdv8oteo5yDLz3ngU4RwL5wqi4vYaXrSZ+hDQTMUJb
	US5FHdPHmrg==
X-Gm-Gg: Acq92OExMf1i3eI+xl1n+OLJ6DAF6z9H6l9TYD2C3ZRd0xWitcqw2kmp8Nye6F/b/PN
	kwcAAylEGnqy0CvAUT67TdPFnnaOyIuWdA5OhrfW9vlEPHxcKIp4itvO/Ci0pQqKGc8OtqPrLMD
	BDeQDbWJ9dF36ADcX0pD5Kc/66H8F6eSe9P8fA1KlQoEd2e73+3EFsFIbrxBj2q0igok4IlD/2U
	TDoildB2bjoYhoau8larY5jL0cuiJl8opvLtgPQ8f73srYqB+wNwfFrUdEqZqB4/iz14pGVD7Fr
	R2UCv6QrFjMbc8GIfQKqDmfmUAQLxjI31e6v9BdbKH1LekbylXS5OmHjqWRwO/6p/n7kK8wKZlr
	/MLxDowlEx0a8LQiyXDjedlppKn9lAUEcodHa8N2CC48E4ha79qg98M/+553QoD6pIXVS2tmCFN
	A28rDsqqJTGlsB0TS5xdBG4msVWgpEA6jrO5fmI2KCnSptECP/1UTpcAUBTLyXtAif/RJvr2lVS
	HC2ljMfjjRtV7h4XQ==
X-Received: by 2002:a05:620a:1a18:b0:915:776d:52fe with SMTP id af79cd13be357-915a9e07fc6mr980638185a.57.1780695820823;
        Fri, 05 Jun 2026 14:43:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3b3f6bsm996717385a.33.2026.06.05.14.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:43:40 -0700 (PDT)
Date: Fri, 5 Jun 2026 22:43:38 +0100
From: Gregory Price <gourry@gourry.net>
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 3/9] mm/memory_hotplug: export
 mhp_get_default_online_type
Message-ID: <aiNDCjf-rSVjK868@gourry-fedora-PF4VCD3F>
References: <20260605211911.2160954-4-gourry@gourry.net>
 <20260605212916.7B3591F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605212916.7B3591F00893@smtp.kernel.org>

On Fri, Jun 05, 2026 at 09:29:16PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Lazy initialization of `mhp_default_online_type` can race with sysfs updates, silently clobbering the user-specified hotplug policy.
> --
> 
... snip ...
> 
> [Severity: High]

Classifying this as "High Severity" is almost comical.

If we want to address this, then we can just slap a lock on the global
and call it a day I suppose.

This seems incredibly unlikely, and a good example why a single global
auto-online policy is bad anyway.

> This isn't a bug introduced by this patch, but exporting this function for
> asynchronous driver module initialization paths significantly increases the
> probability of a data race with sysfs updates.
> 
> Can this lazy initialization clobber a user-specified hotplug policy?
> 
> If a driver calls mhp_get_default_online_type() and reads the uninitialized
> state just as userspace writes to /sys/devices/system/memory/auto_online_blocks,
> could the following sequence occur?
> 
> CPU1 (Driver init calling mhp_get_default_online_type):
>     if (mhp_default_online_type >= 0) // reads -1
> 
> CPU2 (Sysfs write calling auto_online_blocks_store in drivers/base/memory.c):
>     mhp_set_default_online_type(online_type); // sets user policy
> 
> CPU1 (Continuing in mhp_get_default_online_type):
>     if (IS_ENABLED(CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE))
>         mhp_default_online_type = MMOP_OFFLINE; // clobbers user policy
> 
> Does this unprotected check-and-set sequence on a global configuration
> variable need serialization to prevent the user-specified policy from being
> silently lost?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260605211911.2160954-1-gourry@gourry.net?part=3
