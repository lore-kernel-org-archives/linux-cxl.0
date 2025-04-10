Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852A21DF965
	for <linux-cxl@vger.kernel.org>; Thu, 10 Apr 2025 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297994; cv=none; b=cA2T890pQKtdwD7bgISG3l/Jd1tkCP/gLAzcO3ixesChdFit8SryVoNQsfX8Db/XTYOj8CGDLBXRCP0ktPeW56otTQq5L+fhiFMFKtubfa8aU43tMNnG5UO6DDRITNAvolPPn4AhA17KLMFSFOIPn18L1Gx7U2gilkno/fqIPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297994; c=relaxed/simple;
	bh=je2xeU+5EFXOKewbxoiHcMXim0d9qsQ+k9mhNHLPxX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCyt9PxMhvR/5A3qzpeosW/Fiqg1/fugNIiBqVY2Y6qI85AU/S45tRg97/X1kxBgQrLUIvDTDRIyDzv4TnsIjRelc/JcbY0h+SY6+Hb6uzJZxGsVoO2oin/2kc3j08eu2R6K7D0iRT/Z3EkrAfiJmJa6F9qbdNp50r/GOSjncDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SYnOScZK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SYnOScZK"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3A8E640E01FF;
	Thu, 10 Apr 2025 15:13:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KT75HmweaEbC; Thu, 10 Apr 2025 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744297986; bh=T5syLLxXtNZWGCMgxEU3Ka+p3mUuj00dfOAmTMREI3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYnOScZK3z187kywYH5oyxh+66ZCF/U07UQmw80EYZBoMSPAauMQUZ7fw7U9ZMS2D
	 75lgZItBcTOf/b+JCsE8eCoUyEwPhaM+VaJWgDG13an5bQOL4DkVVyYe7tIF96nyB7
	 z2w8+9x1xpRQnhIapHH1xiQXEOKlHi4WPuiOgFAJdTiBFTQmpjkuO5d6z87n/ylmbU
	 f54BUNgZyB7qN1yOCOxcqFakANzggRpRUfD46TZ/t/k2AKW7eH+4ZsrXNAx3q9EM70
	 d6+KbE+oJJXOz7tgZHDsy5bfLFmPDhVcYLD506TRluSVv6JAGPuvoGwUXfFEi7Y7nr
	 5wDXQz4BQVa9vh8wYJdv3yq450mMlDOYrMiW3qznbHt/mKTvZvqdNLEWBI1qhPFToS
	 cc8620Okf42RjsSLwvGrDmE+1clbLVnKVx+9cjYTxIcWbFNOWAjeTO4J4/zh1qZd3I
	 awHT6HidQZAvIEugnK7dyD890vhsbaeU4gDYv1FvRBfpFZVtQI3ZkErZypGmSN0QbY
	 6d3Coz+tKhfNH1CMkeQaoyJhFHSiRkileX3cKdU0vNCGx9j4Rpp+Jh6HE52NknsHmM
	 ijw+ZNgjaL8PHDaLEgLFGkXQvb4/8VbAfVsxW2ydbnXHzGu5YYhIdi+ROLcKJEHVXF
	 qyBes58cmvkbdcS5mx3RBxz4=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A599840E0242;
	Thu, 10 Apr 2025 15:12:59 +0000 (UTC)
Date: Thu, 10 Apr 2025 17:12:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, jgg@nvidia.com, saeedm@nvidia.com,
	jonathan.cameron@huawei.com,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v8 2/9] cxl: Move cxl feature command structs to user
 header
Message-ID: <20250410151258.GEZ_ff-tuUo7wmlHDG@fat_crate.local>
References: <20250307205648.1021626-1-dave.jiang@intel.com>
 <20250307205648.1021626-3-dave.jiang@intel.com>
 <20250410150315.GHZ_fds7lfQWfdQDrg@fat_crate.local>
 <7938f399-3e96-48a0-8329-5d938728e6dc@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7938f399-3e96-48a0-8329-5d938728e6dc@intel.com>

On Thu, Apr 10, 2025 at 08:10:04AM -0700, Dave Jiang wrote:
> Thanks Boris. Jason has a fix queued for 6.15-rc.
> https://lore.kernel.org/linux-cxl/20250407174910.GA1725933@nvidia.com/

Thanks, looks good. I hope it lands upstream soon.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
