Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9221D2147E0
	for <linux-cxl@vger.kernel.org>; Fri,  4 Apr 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743787351; cv=none; b=O23+9Yo6RfUYZjACjHQBOoKGHhZ88K5uZu8XyYdA4pcWJ8wwC7UUc7CRKneb5ERaKZbtxuPSzojTvQYNVxASydK+LfsjdiTvc+CFDxij0PGQ4wB2QN/9SQsiRoy1LBQrvXzFd0davNw52jru9O9NagmcoG1w9Olj/EI9PtgZsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743787351; c=relaxed/simple;
	bh=ZJigoLO0XUuv8rpOLqbma7w6louNn+EBbne/BVcrNrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj5JVRi8crtYjTRWt22y5iHeRxy3X4zJi6gM2eksFbdQlrd37gr9VtoqxGW0rcomf3jiRki+tl3DwUgMP+NscX5foMaXaM+mLCd011/Me97w/F7qUFK3DIb4aLk3WcYDrC+cO7U09LCvLVZ4+mvwzhlTeOwQe+ZjF5CPUN9hOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Pn1Ioa1P; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Pn1Ioa1P"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6df83fd01cbso13599926d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 04 Apr 2025 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743787348; x=1744392148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PATlcXEUf2c7HZ7OV7dOmgWFjlDBED3/6vIgl63QLNg=;
        b=Pn1Ioa1PfHYTmcqpzBqskwaid4oPLzSx8MT6dmJTmUyU88hkCwBI1WlAwk1e6UZN8W
         9EwI1xbTpEp1gGViLvCEA49BswtHkFaikTn189/YeY9DXxsqPECYoqbXCKZAHwx4mKLN
         S/fnJvQ6Ju9Yhq+o1sbDAsnJyy/ZLLLCLT4+fHDJhK3Ctc2jm9iQgnfMK9ugVVHhozZU
         yiamORU2zpN8LR7d58Nju9ujYgXrZqRNHAVxmSGaO4/KEfzmGGw8zWJ0DkxGiZzVIV1D
         sZ9mNbfmsz60GTRoSRbqSZ/hspTklwn5Ytagjlqpc55VXRZQV8r8t5xO7NS6c74qoKmi
         WfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743787348; x=1744392148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PATlcXEUf2c7HZ7OV7dOmgWFjlDBED3/6vIgl63QLNg=;
        b=xBJzLX5HNOw3JKH8TObX9buXsZFBSrbPs2/yYpqXYUFDlsqQQFzrkrc/q9JGNmqpMg
         JWW3DUzK41X2k+9Ob/e4R5L4iJvd5ybTHZmahBNlajQlLQzQZPZJBftvM5w8Cphsrcvj
         eq8ba1Tv31uBFOvy3s03vCMSYKkH4H/oMqc3tzZPiZc/IltoWInVFNK03EWmFEYX+wVW
         srVbHgBEW/PD7mtwYD9+y24W3IhEhiyxmyHAD8BkTRP4Qk/O2KPnS5RioMRm5Lsya+8S
         lj1451h1kqkxQwETYIepJCHUXLy70Weittut2NDayiGO7Bvrkyw2VmNtltjfTDkSxFz9
         NhvA==
X-Forwarded-Encrypted: i=1; AJvYcCUmN78XJHhd5NnM/8RjbfEtRNiWX8onLV1WWAfgPKz7fWD0yZ0KaMOUP0xTIWG1lgdODj7cCtHvJ14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNxuOsoco2+Q7/RhsizcwGj2wAqwLJXJFcFtzqyGQCfsbMuD+O
	PiFaiQvZY4kwyh77q8ND9La0zjks4xyxiY35q6F83TvV/Q8D3KYv8R3XrSSuqOY=
X-Gm-Gg: ASbGnct+lYE/OrMYGTFDXVqq0XUixrKfQlywKWKmVnIQwbthD3GdJdytXaD6fAWqp/5
	xm0k3jQBXZqWV4ucwknj0ijbsjyqLZ1pDAB6WjQRS/vc0kLyCM+JfINwspOgal6IJss0Rr9Ffds
	xvj2GNyBKVqnTJ5LDCsASaY3G2pakZCFnyPF6A52EaK+M1ni2bU4xalWBJxLvrvkhjyk04V0PeP
	awguQiLvbOpv2jHQzVDp61BXRxH7ynNxePiMRYgPwyQIy4rIgXX7d6vHiGtvn1h4I5Ez+HwuYsT
	6+pxgQw4KEVj5aO6ztioyUm6swrFXnpZRrCFycbfUg==
X-Google-Smtp-Source: AGHT+IHe60/Uu4PrKphc2rO5BSUpl63xrVt2LuOqa7v9kFyQkG6E0kZxDVSPsYQMFyOC5OblBZrO7g==
X-Received: by 2002:a05:6214:27e4:b0:6ea:d604:9e49 with SMTP id 6a1803df08f44-6f064b2757emr56473726d6.34.1743787348348;
        Fri, 04 Apr 2025 10:22:28 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::6:3e6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0efc12besm23949416d6.16.2025.04.04.10.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 10:22:27 -0700 (PDT)
Date: Fri, 4 Apr 2025 13:22:25 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH] cxl/region: Continue recalculating position during sort
Message-ID: <Z_AVURWuOL75DPqE@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-5-rrichter@amd.com>
 <Z-_8kRHep5LVeuvS@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-_8kRHep5LVeuvS@gourry-fedora-PF4VCD3F>

On Fri, Apr 04, 2025 at 10:36:49AM -0500, Gregory Price wrote:
> The auto decoder probe proess overwrites the endpoint position
> temporarily to record its temporary location in the region target list.
> This patch restores the pos recalculation during the sort target process
> so that decoder probe order doesn't affect region probe.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Disregard this patch, it appears to break is subtly different ways now -
sigh :[.

~Gregory
