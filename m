Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6EC3CB8E9
	for <linux-cxl@vger.kernel.org>; Tue, 29 Sep 2026 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700312; cv=none; b=rShOm8lwWsP60u437L0O8/kTuoxfh/9yP7okW4QXE8w81LHPRJNuboXKF0x9W86mZvHAlY5NQcXXHEb6twxDzyhL1AP/X/vGXHydwBBSj+mG1ogQB+JPP1neS/6YbX/nBd6eiBHFI357P28aLbdJ71dqjuvHmrAiUoETiO9XAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700312; c=relaxed/simple;
	bh=pzAzdR9BiH1mdON2VztnIv4S20nrfvEj1ZZ9bTFcoOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pz0y1DZYGrWwZS70X8oD60zvS2iKgIY4Q6ecQQuwxC1f5BIjoh41f84BR5pEb4+4kclRNtkC9G/0qUUH6UC8yfpb7MaDXu8reapWN+9iFZyH6Jy4UbXd9bYbksaG6LwdcekF1ZfES9jukIwz6sfQxux7l+nKSu7WYEdTLW+x0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=c8BEuzcj; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="c8BEuzcj"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so25989865e9.0
        for <linux-cxl@vger.kernel.org>; Tue, 29 Sep 2026 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790700309; x=1791305109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q9JXGfEXa1TAeD9LIbvvMLuTX8tLs2uHeRrwmi+1sAA=;
        b=c8BEuzcjrX4AVbLCCR7BIL/5B5S63QqVq8Pqotkge9Cq+yLyEhoqOIR8V520egSps5
         6fBH7CCX1yBFwnZMTDpxFZhXPL8scqYh3+fjabRM8Zw5n8cXlU4xWkX74bwT1tthsTPR
         dz6A+ZHACZRK60Ks3iPmf8CFqFn2Y9TEVCBbZfiFnIEOD58g48D2fTrIaS/fYwM8EFN1
         6v+j4aYRoibmkkMrKMzEuskzdygn0teiX3sU2PDY1OydALQcBqdWqOiHJSKkMd5Gh8W5
         bap1rBvueGB5HtpagZ+QnE8xSL4nQoHWpgeTWuMksVMBcaDszDW2Zhqi5jwVWlY+VvU5
         6KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790700309; x=1791305109;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q9JXGfEXa1TAeD9LIbvvMLuTX8tLs2uHeRrwmi+1sAA=;
        b=od4Tzn7wccIxxsrPKub8szSTRCEeY3AepmI5RgqdrIsrPhWVcs5pAGDhyjEAbDwAcE
         3cZ7VF7WOHxphe1cHABZu0ioiMXhidPhoQ1fLHAzGrgEC00otVg/A9x9dPto+6py2gcE
         j4EHBrjTXgtvWW0eMUPYEFPvfR7FApJmtYjic74ybvV44prvw4cHGxZfPJ/geE2KFIr+
         sgVxsjLJH6uBzFE5ygFOO0jMinPw12Vathl2p5/51fG41Nc59OA2whWPGTF+s1PUinyh
         /od46Vr60qa6OcQQhXbpeA03W0MC7gx00F3eACAieFW//r2x1c0E+W1VLUbBYxv8sg87
         25BA==
X-Gm-Message-State: AFuF++kLaY+wGvK9EgknoXPMgy7BOiU40uR19xGR+4Lr0+0kJeH0WKvi
	ZcBZLOqO+Uh7pEgSgW+6psOPaK1Jgu3Vp95F9KaTy4BM2w7eHb/5T3owwuH00Uza9o8=
X-Gm-Gg: AYBFou3YgV6CUaP2ZUzFX07d3/QCTnCvd5miR3rR9PZNGYA9GWPBEKwEzGhHygBy26J
	CiuaPy9SS4XTEhFTvI9NASjBb6MXJxFZHZA46L2YYa8AwXZ+Erv1QHvqkwoLMY1UET/9B7m5wsn
	souTcTK5FMQrUMQiCX3M8HidfuuAp9RkhVLx7CEUZSkBHZ2eKhroniG4H/0jy2j9O6OWNcPrjgX
	uT4wfq6FWy5LqUOYxLQZdDtPU2O+OWMq2wefGRLoNJT8V6ockDa0GY0WECDe7bJjrLJvaZvG+6M
	TYew6yw4nHWmRZ2PKNbPuEYzi8mZHUrpsJVpiI0Qhy/YQG1YCcQF5p87CQRsCcT4LwQQKDR44/K
	Q4HQmWxaYACug4tJOVp7cSyk5gd//PFHdQg/DU1gx2hlbmllCyqcCMI/CBNOmAdaEMzRYCW/ZuI
	0JviF1k1UtMGhc1DnyUF5M02h6oIrvEfXGc/vcNZPirBvNHmSWwk//dlh1FolxfhFc2g==
X-Received: by 2002:a05:600c:3b14:b0:4a0:12d6:33b6 with SMTP id 5b1f17b1804b1-4a012d633bamr34824815e9.8.1790700308596;
        Tue, 29 Sep 2026 09:45:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::5:5c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfecb39sm98759315e9.7.2026.09.29.09.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 09:45:08 -0700 (PDT)
Date: Tue, 29 Sep 2026 12:45:06 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org, 
	alison.schofield@intel.com, ming.li@zohomail.com, icheng@nvidia.com, stable@vger.kernel.org, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] cxl/port: Clear cached dport pointers when a
 dport is removed
Message-ID: <arvrAEJ14KRtypKt@gourry-fedora-PF4VCD3F>
References: <20260928230341.2315153-1-dave.jiang@intel.com>
 <20260928230341.2315153-2-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928230341.2315153-2-dave.jiang@intel.com>

On Mon, Sep 28, 2026 at 04:03:40PM -0700, Dave Jiang wrote:
> Switch decoders cache dport pointers in cxlsd->target[], and nothing
> clears them when a dport is freed. Readers then dereference freed memory.
> 
> KASAN caught it under a cxl_test load/unload loop with concurrent sysfs
> reads (abbreviated).
> 
> Clear the matching slots from cxl_dport_remove(), walking the port's
> decoders the way cxl_port_update_decoder_targets() does on the add side.
> Scan all nr_targets slots, the target[] allocation size, and clear every
> hit.
> 
> Fixes: 8330671c57c7 ("cxl: Add helper to delete dport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Assisted-by: LLM
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
