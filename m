Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB512E6CC0
	for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769721480; cv=none; b=aCfmVO6bG3QS5BNcawt3+csZzhyWlhi+J3wtS19AeX9WkigmIA+yaLHp8y6YeQSTa2aLmMnM8DxwU4tniEhfyB1KWj4FHkiGsW0kYY/4N9DCxPjm+7DSXe0QsRrSCGgvJbuIgfqnibbYwvmDUs/SA34HFv9xoJvuuR9PuoRBPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769721480; c=relaxed/simple;
	bh=l9xIkbZKM30zA9x2QI+alFDGiuf8CP4pmINW3Kx7q0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNIWJx1IIht02bkrwPLfmThNae1gXhC/HKEjkRiHQDj7QE3z2hvwFH+koslZca3ty9APfABOmuz1x4YfQpCnawy/VVSvJl/6n0eQLPQPAse+Xt1iZx4HXWem6PySnj+o/hcl/cPqdPk7LRoBKD2dOQszVIxwPNWyI8ApnG58OTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OzrkhGqF; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OzrkhGqF"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89469143ebcso11857866d6.1
        for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 13:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769721478; x=1770326278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9xIkbZKM30zA9x2QI+alFDGiuf8CP4pmINW3Kx7q0w=;
        b=OzrkhGqFaNFbcrvM7g0osWSQziuBpkIMijxxE5yuoXwUH64v1YQlRXRpS4eR2V0NB3
         ETTgSrHxAniIfkIxxbqhavTtU8tj/CtKW7XGIyj7D5LLXC9z2jnd4bqwlLPSgCQpE28e
         xU+6NkggMaN3OvjPjHZTJgUzqufnDxxVGbz5XHcOEGi42kC2RohF6tEdciVlPLrcQYDJ
         qRjmqKDReOX6bFYn0vuCpxjbLuXYMh6t4FTZmLyCyDINc2awm++RFe0yLaIr14NifjVT
         2Q5jS+FdjZTa5AJB7iuz4gE7DA/2hZhyMgmJbM4jEx7pwU/h0HbokNyOVZ1yKKZEo87w
         Qu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721478; x=1770326278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9xIkbZKM30zA9x2QI+alFDGiuf8CP4pmINW3Kx7q0w=;
        b=Mae2sGNXn0kvAsHcjDFIjHr88GX9O9XbcDZkBpEx1temud9qri7YSHisf70d5vYfp0
         KK6J/l+Azcip5Md7U4BIEPCKobTKchQOd4hbvlKfPvjRjLeED1Xa3nxpt8EpR4SolBuN
         fEzL/hB8LSwW/tSpW0MYlJND/XVpsaQUFzN9UFKKzTtf+gJp8/6txO9NXcrVqz2Ql42A
         spHBFyHCRG1UF23uOIt4gUfU8UqwCzWB8B3DN3o43sNZUGUXY93W3qAIDShmtxyZBbSC
         mJvOtEoU572Gs68Ww6Q/w1pHbdJZ4yIDKDQpObtAHS8SYtTCfMY+bG8rusg4neTKN0WL
         /ATQ==
X-Gm-Message-State: AOJu0Ywt85Cr+/GWyCrBhlzPjjqzXOxT5JLOh5AiP2a2HNNpQXCS9nQ7
	LpNlzU8wEpjIHsQxO1C5Y/GdRMszXQk8hS+saqnheNqsmBjgmLR3izS4rb3CJC4S/qzpR0/ugT7
	gG7qsiMk=
X-Gm-Gg: AZuq6aIbDR15YI+YDdPaB91z3403JJoHJPzW28e2L9Ech3529exR0xO2BSHyuIjQXPU
	IbQRKr9T29/WVeo629fY3TMk2C4m7BqCH0iCofS4dKmRpvYuX/NFDaU5UCa5M+zfROhs/bi+7QA
	SEceaBs9vE9gvgRqV/eCD/NXcfJ7RlbJg6Gzf5ivNR6eJKkzr8cqglQLm7EidugLKzPTkKLUTJO
	2FpWTu6xPRJWhR4TFnuzLuEmf1LM6ZExJRZNh7caPE5mFfGspIFP8B/L3H176KBbul1965qJW0a
	yJUHevpH23nWIXkjBGZSpNQ6F35OyONKFXxi23Bdm7C6ZxsCznZ0c5Ll5Y4Y0g5IeOJxOwp/+KC
	7BqgDtU90GrZdFshfr9poEfUGp/F8HOmIvzJWhPyoNUSfkqywRntjN0wu6clhJvFvHaijF+Kams
	GImDofCAXAlBna+EU/SNhKR8mZKwQTRiKEqgrbZ3JSB837yChmgPAHgMyR4kZF9KuN2Pddsg==
X-Received: by 2002:a05:6214:401d:b0:894:71c0:6fc with SMTP id 6a1803df08f44-894ea1170b8mr13110576d6.57.1769721477709;
        Thu, 29 Jan 2026 13:17:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36a5ca2sm44936276d6.7.2026.01.29.13.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:17:57 -0800 (PST)
Date: Thu, 29 Jan 2026 16:17:55 -0500
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, willy@infradead.org,
	jack@suse.cz, terry.bowman@amd.com, john@jagalactic.com
Subject: Re: [PATCH 0/9] cxl: explicit DAX driver selection and hotplug
Message-ID: <aXvOgw2rc8X7Cqxa@gourry-fedora-PF4VCD3F>
References: <20260129210442.3951412-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129210442.3951412-1-gourry@gourry.net>


Annoyingly, my email client has been truncating my titles:

cxl: explicit DAX driver selection and hotplug policy for CXL regions

~Gregory
