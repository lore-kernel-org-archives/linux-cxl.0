Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6220303A37
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060263; cv=none; b=Pv4Ea/JNfYTLTtizWFeRkGRkot5sXOtxWjlCLA2f6U9RTWkoLVtkJu8kKSDOBN+MYhVn97L8E3IRMRmuRfe01BHeRrJU1dsoeg0atGqJ/oH0LO/FpBNalXhyAZCck2s29P7OzA44ayNqIFzw6Axuj/8UoK0A76LCDZnlgn5RNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060263; c=relaxed/simple;
	bh=ACqZRCaA3spdqDts6uSHEVfp7xm4jCQX478qyXeHvcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZurv9F3vQzoeLjhNNbIB+21YlruS+IL9arBCb+jANtt7GbbT8kyrrjBmm6Am2XmeBTer8vYw+XyG6JSGlZgRjRnnGRM74cCpsej0eab6MCSrYBiKjxMCAX4WnLGPvtn1gT2+a7U+orrRauM9GaypaWFgr5qvnE8qzHnuGeFtVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=K4bn7sZF; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="K4bn7sZF"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ffbea7fdf1so46308491cf.1
        for <linux-cxl@vger.kernel.org>; Mon, 02 Feb 2026 11:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770060261; x=1770665061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XUuyg7zHZfDu3pOaroTjLEFqqywF/ycwrMkhtrpNzLk=;
        b=K4bn7sZFD0PLErbwdk39ILzoXoboz1nPBkPA38SuEpksN3tFqsbYgQmJMZ1IWQ/wk+
         vtyK2MI+YDAYdwgO6jlKB9si1gYglwpEVEsSo4w+nBL0sxgv4Biz6Qn14c6RyOwJmzC8
         7Biw9Eo0k3Hr0DEV1UOSd1Lw0HxgNkjZhOxmHn4eR1gZrIwoPQzlxNQJMzuNJ4XusIPs
         AVN6sgMb74XWUroUaAkhe5ingTtZve/7tlpuGaW21FhXOctYj25GC0QLkL3VeGcbPDN3
         cUFhdyfDr0Gu3ths/s5e4rx5ReGrMxfOAyzCEyRAqdzEKzz1XLhWo1y1PqV0LNRRs0mR
         2+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770060261; x=1770665061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUuyg7zHZfDu3pOaroTjLEFqqywF/ycwrMkhtrpNzLk=;
        b=LpKTUZyWik+tw4E2l91GkI3HpSkORTcQvv2xkYQwkTlsc+ksXCWepymTCeZXk/P3c5
         hfS0Jqt3Bcrtst3RI7083IQrpmL2HuV2gZMyrF2VuCkX9Fg3OJwme/LAy6tiXYu+bF2T
         aoTqplDZVkNLzwh1MjTLQWQcyQwcWTsrecapmvYBWa7WeSdudyaAx3TnVhY8t2MyXxyz
         +dxhOdURBBhbivQPdQLkzEAgsd+keByDUQ8UoxAXiL319eYzhh0s0dmRyGDfGFiC9/6O
         xGudoICncmBJtg9z+BeG4YVqEqD0sAw+etGYKbSvMBb7noWvX3iXh7j/myJtIWyJZ+E2
         XfJA==
X-Forwarded-Encrypted: i=1; AJvYcCVPRBAf4B+lKL3Uc/vlM2NM4PkFiO6xJ4Ie5ZMVLYLmCBF+RaO831Q5hvnUxAGxnNsypuggVyXVkjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlF7ZDtIs4e2ionUluF5rZotDTz0/aHbblXAEdAa7QVQI5BKZH
	+fgl12Aq78/YpuIHD9UJjthxKisSIrOUZCw9G7qTl7WNj3c25IucvbrJxmVUv/jwbFs=
X-Gm-Gg: AZuq6aJLwEx3c7hehlI7ZcNRL4a60yBu9x7AkaefLOrIzdUu4O6nNqAWYzGAXjvqn+1
	qefdDqhsjIBhYKVX/yU0MUuFURmpgXYNJmTmSMgULzCDF3YmaW4xSONyF9UcSVR3DwC7cpOI3fW
	y0GCCyJ7frst3WpD9Va2QFBWGQ+B8W1Z3iEz3e7/t58hUHbIOTNvTQW2Sx9l9I/jAmrT7fSkcS0
	qCvRPZLBwZl/9mCR+JnF8Z3+tXT4kZYA8mMrn7WMmiInsku61mwhBH/4RHCgdnwtoqLWLSOaGO1
	8XfcjqqHFY8mg6y4iTZtXFomXjHEQUv6jmBCi88ENx4hOnd+nymySfbvPEaBLS6AabIYX4Isj3C
	bi8acDGlkbQqFTBy6OZPkwnl/rsI3WX2ct+a/cweO2vwEd6ad5wU2fuFOPmyKWbSPlCtUktaI51
	7H+4yTjRegCElVXex+zT7kEalKApTq1yVwufKTs2Gg3xVRovZ7Kxrp1XCNLp+kqk/vyfmySw==
X-Received: by 2002:ac8:5f93:0:b0:501:4236:5474 with SMTP id d75a77b69052e-505d219de0amr161966451cf.28.1770060260825;
        Mon, 02 Feb 2026 11:24:20 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c0aasm116119031cf.2.2026.02.02.11.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 11:24:20 -0800 (PST)
Date: Mon, 2 Feb 2026 14:24:18 -0500
From: Gregory Price <gourry@gourry.net>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Fix leakage in __construct_region()
Message-ID: <aYD54psWhfeNx_JM@gourry-fedora-PF4VCD3F>
References: <20260202191330.245608-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202191330.245608-1-dave@stgolabs.net>

On Mon, Feb 02, 2026 at 11:13:30AM -0800, Davidlohr Bueso wrote:
> Failing the first sysfs_update_group() needs to explicitly
> kfree the resource as it is too early for cxl_region_iomem_release()
> to do so.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

lgtm

Reviewed-by: Gregory Price <gourry@gourry.net>

