Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA04B2853E0
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771877399; cv=none; b=JY9ZRqafCGPIhr+qsnan5dGOEyeZke1BAblQikbZyXRzvM0mtmINF1dfhzl/wU4gcqLzwkVAbJjnod9GwnooQJSFn1sdnB56J9Hjdl2+t7xXUltA/4lIMySYgrphR+UqeU89fduEkqGL4FcdOVdgnOWrMaz29g8wHxI6otQIWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771877399; c=relaxed/simple;
	bh=3sirou32C7pHf8NJR90Uyfts53jQHNaK56lTKFXveL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8kxhafqh6hbIyHUdwtrj3/m3JumZ3YsltS9/dOxcq0zO1jHsca+cPfEWI07vrokHwHZtv40AAXqUH/bv/6m2N+8IOV6nCW5wDzBl4VKzp91rkVl3m4yGpbmyD25ZD9QMWg2xNL3QdRb6qbFPTnldL1c0aSA9tLpXdpOSKLsTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MLT/JkE5; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MLT/JkE5"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506989e8516so39555491cf.0
        for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 12:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771877397; x=1772482197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ue6mVOXZpixv6BvKE+WzvIxIQyINwZDMiRkADcGx4tU=;
        b=MLT/JkE5YsNCtMxLu+hscmZT+lp8AOVzS5ZCjhJw3mDvNy0w4gWUghlVc81R1wfpV1
         RTzRIeAycSr71sxxk0D7gJXoVoDLs5vpHWfKKbTqGfZHScqLVGrQnpymbRFYEjtEObFV
         qwe6wEusJ1zERpcRvs5UfwxS2xQXmUGc3e4LC9ubrTPtdx5AVA01r6jfUzAqkHFMWI5H
         MjoriW8PpQ+gv8lzYvGW1HhgALBXRDf2IBxm7EUXN7SrWvvgWZNHuEOzGuYAQ8MxtUuR
         lBDJDGZwA2MHhg0i3u4p7PYijNNzBuwyE6ajJtrVAN+DrL98LrYVMQ0F5ZOtfRvfBObP
         irXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771877397; x=1772482197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ue6mVOXZpixv6BvKE+WzvIxIQyINwZDMiRkADcGx4tU=;
        b=BRBpnnZjVs5w2ivB+mtH9Y6S1CGr0d2KxgYkxKUK6jfe0t74qaMCPEioipI3FX4Q+K
         mRg2KHrytguhoL2xFn3cTTIk4KAa6Jj4Wgf8TKUxAnUe4SMulvjwr4xeCyQpKyYZFgC1
         dE0LUUHLbl7tvUDBxOTOWTuAf0KO4xUR2hPF2SM3RkqLloe2+n3/MFC72qjf09zI1j7/
         RePxzhfrTzXTiukibZd4tzeHYHGVvSkUs+FZx9qaI12jNw2L0xtJIBmmIKp0BNNCuTC9
         l9wpdn1a9J6dT5dVSVmKiEB/dDGfChQUKBKcid5ly92BQ1L+nijhpFG0j+n9qBbLdJTa
         rF7A==
X-Forwarded-Encrypted: i=1; AJvYcCX9L8IQ4ylRd2fbws5YWN0QF+JX9CA2jACOta91Nh4SiL67xRNexFf0SB1yzae3SlGhzOvoJIkWKNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwND91972GAKGTP5DYEwp0MbgVZuQnVmzXg0F5j6+S+XAInvszU
	kVF1Wjgtd0FrP/E51QHt/7rQrXB41qf9zr63gWQy2o4tnEs9VOODWls7UYQ6lmlK+89tKRrqOwV
	gYKak
X-Gm-Gg: AZuq6aIrkqxgj0aQpe0ilvkSuogezkVx/yZyXn0gsLPOg+AoqEr1QQyTwv/qcA4c3B4
	sD8Lue2CffTPJokWru+Qxo7sPtBm3amvRvrShn8VM1nOJL9KdxGESu7zjcJbj5c5Ddg0G/GKyVu
	/R/8ha7UZJx6jRo1SCXbtFfmrS2mqyiHebc/3pQHxvdK1riUpdgv6lLWoliMU2LWyLvSQ9ec4ds
	bCSPHA46vkZ/P19ohhbp/I9cP8XkVbC9cUbI4szOeKJA6qt9o8VFYyK0S/kHaBb2MWq9sY8OX3u
	UTchQOWtfbPadCRRc8N7bToFmv8fhKzkiFmKilj0LbEv0BfPIvibb4pg7NbqVNxF+5o2/QCdlor
	1QNhfrpBi14OsOLpp3YsS08u3qzfEGs4350bYHQQERkgGlz1Dn7LzowMZ0mC/cTCuxXDvTyNKEE
	//HpPhlxXbN7XN8XQtIVMfLx7xvukllS8yE6cZINedGPHwHDcfADH7Xr6W3BoDQaNhAETIN+g4w
	7tc1SoX5g==
X-Received: by 2002:a05:622a:1191:b0:506:a43d:778f with SMTP id d75a77b69052e-5070bc1a837mr134143161cf.34.1771877396363;
        Mon, 23 Feb 2026 12:09:56 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0eb32dsm919153485a.31.2026.02.23.12.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 12:09:55 -0800 (PST)
Date: Mon, 23 Feb 2026 15:09:54 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl: Test decoder flags as bitmasks
Message-ID: <aZy0EtERdCpGn4gF@gourry-fedora-PF4VCD3F>
References: <20260206181404.1025991-1-alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206181404.1025991-1-alison.schofield@intel.com>

On Fri, Feb 06, 2026 at 10:14:02AM -0800, Alison Schofield wrote:
> The CXL decoder flags are defined as bitmasks, not bit indices.
> Using test_bit() to check them interprets the mask value as a bit
> index, which is the wrong test.
> 
> For CXL_DECODER_F_NORMALIZED_ADDRESSING the test reads beyond the
> flags word, making the flag sometimes appear set and blocking creation
> of CXL region debugfs attributes that support poison operations.
> 
> For CXL_DECODER_F_LOCK the test reads beyond the defined bits, causing
> the test to always return false and allowing resets that should have
> been blocked.
> 
> Replace test_bit() with a bitmask check.
> 
> Found with cxl-test.
> 
> Fixes: 208f432406b7 ("cxl: Disable HPA/SPA translation handlers for Normalized Addressing")
> Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

I independently found and fixed this with the same patch.  So +1

Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>

