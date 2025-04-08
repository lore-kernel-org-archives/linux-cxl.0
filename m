Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646392248BA
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 01:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744074764; cv=none; b=IYrD7+nVdRj7cLEAHWLinnr9n3DgMy2R7gxTIotWTp1BFfO7hef6a6kk4rfvD+Q2xwkevyBOAeBr0j5wk+2YfCbV2tZq23cLXNWD5uCrHEh1PJ24z8nn7g1oydQGoZQAwj0z6Eg9f0uJco3dwmYGVpxSmpSQ9QyzqMHx/FF0r9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744074764; c=relaxed/simple;
	bh=3cyuaVwWdfw8wiX2+gdBbwJBWaUrRysD12Ve9sazaHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mw+awl0u6bPXyA5xxhWFcNqoFlB9DD9BnRdlMKpFSrtLl+GW+yZrDh/wRPJZpQGCu5D/kOnpfv1/0NOt3K3fo455W3ViKslN7EmQ7BOJlZTtV7YJnwZQCRjXsCUzalZ2lQlG6vCanFoBiLg0t4RKGJ0q0bIHkjWkGmpPPmJzFFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=e8yAOH/M; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="e8yAOH/M"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5e39d1db2so292152285a.3
        for <linux-cxl@vger.kernel.org>; Mon, 07 Apr 2025 18:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744074760; x=1744679560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AeWi0+ulUAwZ+I2W+g95O9R4Uet0Z3U0OznV/xW5Rs8=;
        b=e8yAOH/MPH5qys9/cHBhD51T8heS2fwbL+a3oo8EQMzrH6IpyRIZEtrtDLCveT18Ga
         /GbMe0CBheDOsqgWngXvVCO0jvmK2SWkWkqcOKkWm2PFvjN47i2Tz89edqC10WIAbnwC
         JviPtmCNMHG/MNg0ATLaXUJIts86Y8sTl/tW8Ux7xdpZ8/fiREZ85jQ5+4PskgP8/b+L
         kWXN0g+4E8FXDDBgWkrecVRM1owwtmqqlzagHFWyPUTh5mXwiB/m+HwbocPL8zFVHMTg
         LgtdVFvsIVpToPtO0O+DxQkmu03tvI16Y5OsIVmn1eK9YqZOyJmxhE2r30CaPYMZKFlf
         hxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744074760; x=1744679560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeWi0+ulUAwZ+I2W+g95O9R4Uet0Z3U0OznV/xW5Rs8=;
        b=JYY6xNuh0yVRGsIwo4L381clIxjPRjyIP2TQSl2+/JbrpH2S3QSsA+FDolCUN2XDS7
         7TQ2vCs4qy8+ClPILjOYT+Ap+VC8ufGJyA5ai2ov4u9CByP/ludntZs4FfUGRDkp5wVc
         FK/4qUOHrHkdxdueHH9dhymHG97cc0VKDPIu9k9g0pAoX7VYHasETFTti8ANfkX1a/uF
         RQX1lSekitn+3ZXUflwbKHzY7QlK0y8te/heUNswUYyXIBcvc7ugLf/ROJ+Q0Jo4clqo
         cXDOSoYZTgLKYXbPhG59Wtz+dL8x1JRJEnbEBlyxWXjCuAHkfk75g+wOK8z9h9CM2Wuw
         oj0A==
X-Gm-Message-State: AOJu0YzQJnGlgP0sjs1Kwmgyw7XccLLm8yp2ZC2nmY8CyvRukPBRnlyC
	DDCYHHk5as7LPMJPUamjJ1CcFThZXUrkE62N3DOfHrUgJWTmT1GI8icw2iyvoFKoaItffZ4zL5G
	V
X-Gm-Gg: ASbGncuglUvF1f4WYBD2Eruqkdnuf5Zjq+Bq7kFnRP2gaP2r2YIIhEwbDlzDeZFKNnh
	R2qN5ouVzwmlnOaT6CZZXNeS+h5LRENOxzCNcnCvfZOZn5zaxXMOMn7m9mOKTH+geeLuVNlAIn+
	ehWFFbQpD9VQy/rRlzOfb2YKhmf3m9G0KoVymQJOdUqIJt18khitT7niF5SjEheZ/0aryoYTTCf
	huxmQzjbVZD/q8sQEXMyZXYPZGupU+CK8pw/dsJV5oFjSySWuk8jFjsbSOA9ZUGG91/19k68x2V
	QCiM2NBqbCpssPFoOPu3VRkVwe42M6uPJKs4h4numcAuU2yoiyE=
X-Google-Smtp-Source: AGHT+IFma74hoD9mX2PNK+fkQvtGYdhsMVrB1xrwT9dLrfDEGykLyd9A6oLqEBqlY+hrwP0UeQDiKg==
X-Received: by 2002:a05:620a:4081:b0:7c5:e2a0:4e64 with SMTP id af79cd13be357-7c775aeda15mr2188262985a.51.1744074760215;
        Mon, 07 Apr 2025 18:12:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:400::5:5501])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b15eda8sm69006201cf.81.2025.04.07.18.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 18:12:39 -0700 (PDT)
Date: Mon, 7 Apr 2025 20:12:37 -0500
From: Gregory Price <gourry@gourry.net>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl/acpi: Verify CHBS length for CXL2.0
Message-ID: <Z_R4BfFNQ10Qh5yf@gourry-fedora-PF4VCD3F>
References: <20250407080217.76117-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407080217.76117-1-lizhijian@fujitsu.com>

On Mon, Apr 07, 2025 at 04:02:17PM +0800, Li Zhijian wrote:
> Per CXL Spec r3.1 Table 9-21, both CXL1.1 and CXL2.0 have defined their
> own length, verify it to avoid an invalid CHBS.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
