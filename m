Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF22EC571
	for <linux-cxl@vger.kernel.org>; Thu,  5 Mar 2026 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692209; cv=none; b=W6qMFWrd+Vv33wVI05nlKR1wsjdLbHRpOjkbpOLmSFrzzO7bw7EWbfOx4U9qZzDPcpsMrKu6Gp+YvErGUDDF5EdfQZtT8L6Xq6CVpUihIKDF8BruTV/X0Ajp197SY1UHXBhWZsrP4mntJ+aKHQeJItYEj/dYJfLg7iUaZK5UYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692209; c=relaxed/simple;
	bh=RSYeVVB5gM+WAo2d3lVU4OBg2ZhjPkwL6PcMWE5Z8QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyQKgh274fNR9C1hzRNdJo472B8NfV0HsiGYAMGsgwwS6sYMITIyq7jNvNghDdlOjDKuA17ecreTAUF+0hQzH7e1W0tduLArSxQ6BqE88utxmiEJCR95P942lvW9IJVvQvTlm4hKlBQx3qFtwXhGct+MW4aIUJlSx/phCxeReDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Qlh2SUmX; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Qlh2SUmX"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb39647a70so736096885a.0
        for <linux-cxl@vger.kernel.org>; Wed, 04 Mar 2026 22:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772692207; x=1773297007; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rc+lawyKza1Txu1nyRU7GMN4VIjut5I8Whyb42/urzU=;
        b=Qlh2SUmX3TjK+3kt62gUpaa6Syl3n+TI80xjXeZxQscfizvUAwsJEveZs0gCxjKtZr
         N3vy4eVgp476tFdCBlkD3QnsJ7bkBHU0hYPX+48cKqTRzV7xi/8woaaMfCtifAeK4qIV
         cz+Bx6fexk1//5qW1TYiwZi7Pwlwjp9FwHW3fSc72IEdLJrpHXzmBvS8et4TnzDQGqPI
         eTgWd3N3DCRHjuJb53U6xhI1CSQoa1JvUSG/TjlECkQ5PGZ8ebVXMQ7ge7JiWcADoEAv
         huBqbOYA+LrN3pRWtUZXpihMaBROEikQ3/0x6OB9GJKOtiKaZI9qDxF3MVDG4a2BHBtI
         o/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772692207; x=1773297007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc+lawyKza1Txu1nyRU7GMN4VIjut5I8Whyb42/urzU=;
        b=rkiN5UkyC316z+GMfMMvIPqnG+5LON3H9mxiSXx67P+NH4d8XL/vtXm5HV4eOuNHcv
         SqN+EBmunUY0diSSeyPrGB5BijJ954nHp7COmCXbHAoUPfUq2o/1tNhFa/Pwba3TlHo6
         Q1xdsLEAteJ2dCfw1imX6tH8kASgC/mLioDjSaENQqj2ZrxDcn15YLuO+ImLJJiZMtlP
         PjWuwkZZV4y0kq5OrslLVPkRqlXxMaQ4W23KqVSHVXzrPMm85SsAfmCQYo1KmJG/L+ZA
         5lhSdaQ7fH8sHs52wCYDcI/tj/slvKdDsr+4gmHBW89B9MgRzwi3l0GkYASJMj979K+t
         FsFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhahYtm/5KUq3KiJLCOPX81hWN1yZ7Psx37PCih5Tv0JLJ3rCfotgwYt3LPynnHqPwCgwtantDcpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw5Al+3G2skJSzs6W02D4pwbVgVU2xY0DuoUmKgv6OeOvcUXIC
	b1UC1WO0ZbATgV49aM2PgDreh6FdDV3adPlMtY3dZndsTINEJPledHHYkZvW0FciLzE=
X-Gm-Gg: ATEYQzyZyfi6oh84dlo8Rxm0wpw1Cy7Vqcv8a5YO/VC8EhfjjyxbZp0QDoHTngKgy8/
	v1zeFMi7RXxC9jf09Ipeq1ywxNYGBGZKsrghbLyT1F4MfuNMhUbgbMpy8W0soqOiSvTv6smOaLn
	IRVFsb63BWwjsL0uPKOeRIA7UZbB7nRiuUOaxsnFsjlKhXrV8wRJV4za+/IimFeTRy+V8vCXKa+
	nPCa8wG7/SE/oALNxGPYH0M0S9FeIbjZjcPiS5k+RGg8MNGZ55fO7wWRkZhjO0Jldni7VGKE0J+
	DtUwmNP4eOhbE2O7W6eRSyDhP3spqFX+0ur3Erxmwu8jtTyLgT+gg8E6/qEzFBNGVrOAmJbCtll
	e4rnJiT0dTBVspfxChyyq8VTnweOqYYLfxuTELyW4pmI4mMabHfPeKrmBfuessukFq0OIWzMO+h
	E73YOc3ws7p8ARyaoLs6Ks7J7ETCRIAmswlbacr6fs1qayUxlqS/Pww1iJGvFQFznhIoO7MQn5O
	BceVWLyBw==
X-Received: by 2002:a05:620a:2681:b0:8c6:a26b:7e92 with SMTP id af79cd13be357-8cd5aec6952mr599870185a.15.1772692207123;
        Wed, 04 Mar 2026 22:30:07 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf652bb6sm1949118285a.4.2026.03.04.22.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:30:06 -0800 (PST)
Date: Thu, 5 Mar 2026 01:30:04 -0500
From: Gregory Price <gourry@gourry.net>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS
 during NUMA init
Message-ID: <aaki7DZ78o_vr0kb@gourry-fedora-PF4VCD3F>
References: <20260304080647.169434-1-haifeng.xu@shopee.com>
 <aaho0IyQ0WAjcRMM@gourry-fedora-PF4VCD3F>
 <8ad398f6-995a-489b-8ca2-f21afdce47e4@shopee.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ad398f6-995a-489b-8ca2-f21afdce47e4@shopee.com>

On Thu, Mar 05, 2026 at 12:18:05PM +0800, Haifeng Xu wrote:
> On 2026/3/5 01:16, Gregory Price wrote:
> > On Wed, Mar 04, 2026 at 04:06:47PM +0800, Haifeng Xu wrote:
> 
> Every memcg records shrinker info for each possible node. If we use online node
> instead of possible node，then during memory hotplug, we must tarverse all memcgs
> and shrinkers to check whether corresponding node has allocated the shrinker_info.
> This way introduces more complexity.
>

Right, but some systems might actually WANT this many nodes, and this
does not scale well at all as-is.  I also don't think it's as complex as
you think, most of the infrastructure is already there.

> > If you're not actually using CXL, can't you just disable CXL in the
> > BIOS?  Then you shouldn't even emit CFMWS at all.
> 
> I have asked our Intel Support Engineer, he saied that cxl can't be disabled
> in BIOS.
> 

Huh, this is surprising.

If this is the case then see Dan's patch here:
https://lore.kernel.org/linux-cxl/1f5074979a58803ec875dd10c9234c7b1a17192d.camel@intel.com/T/#m0d64b723a63ca7faf44311c52c1ebd5f280ae626

That should deal with your issue more cleanly.

Otherwise, the problem you're describing here really should really be
fixed with either better lock scoping or lazy-allocation.

(Already poking at the issue a bit)

~Gregory
