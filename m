Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA98B33D6F6
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104989; cv=none; b=ekVCCYSr6XkHXP/eCPoM88+v2JHR168mXVNoPnlx7PtR1EbSRQ7CU6DXODiAK5kXXLOiBNRuPjDat8ZejqluftJm6b7O1XnxQXkC1baISBeGbIj2nv8KR6z6AvAfkaDOViHS/uZZ0f/BmzqkQpdVr2U995Ku/PG4VvlkHmXf3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104989; c=relaxed/simple;
	bh=HnQGF+GQp2hqS7/UCHcdVaF6HDlO/rgXAhOIogT0hbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4f5u7oQOZPsvZhHJPF7rMjQzX49SnV3WazD1ZMI9IQ2rrt9RsJ7ZLQqIz+8zBacESmv89FRaUECCqX+RsqVtcqaEa39Ayfnkh9916oBP4WYdXTbhgIxobwW6z5YKlhUljtCwqOVShWKDCXQbFBqK8VQ9rWX2zhYgsNoYipVURw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=e+ioyvD5; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="e+ioyvD5"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c5389c3cd2so130107085a.0
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 10:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769104975; x=1769709775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lk0DadVMYIedGPbXp5WhX8kegjjbwpGdfj2a8a3noKw=;
        b=e+ioyvD5mh1+7tOT8IK9uxQSA/8K/fj1ugC7ALfhyl7CGOvsAUAbCSe5UZvkCj8lGi
         RlQo/vElbPcwjw2FdOf8BjXqyNxIHb57qwr0HxgBshZUBP2UfnuxvnIoJBsP9fdonccI
         A/A49gVzdTm2KMyeMzJSfF0u8pa64FX77cLEM/4nGZIquoxR1baiO4ooaH1lL9ex2Q/4
         LFXT2zGdLiA1W+GY6RWZeAE8+a6ATWNY9YlOzgJklNysQS3Ruc5uYRJxt4DPpSj5RfXd
         Tf55THYRDTBlEbFxerHkY7BZJTOboTl3Tz+dV6X1jO05fvoYcF30kK9JBvQ1wZ/3v0L6
         5FMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104975; x=1769709775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lk0DadVMYIedGPbXp5WhX8kegjjbwpGdfj2a8a3noKw=;
        b=XPZ0yr0Oi4ngP//mM9hXs8WCg1Dfrx8mirF8y4+FPtnRhzYK+OyAjedl0DC3mFxcvh
         0qR3ORGNFCsuAC5uugb7uAmNMZttUuszFKEq8irbOMBUH0GLU2VrID0usMk9Uis4FBJS
         XVWynFqaQQUIvBth6Rs0lqWQ85JspUQ19bjVr3Tcyop/ZDoOVOTRKHHi7KD9V+rHy1Ec
         JufsOq6tj6EH2k3JMS5PZDUKn+9R66qmjabz9qm/jpcfNvq63zFAOng3Edo4B3JHW8g/
         emdrkpg08IdtbWqqT4ajWxv/TCAEwsMYTluaOcWgdfZw/+5PvANIdXrwqVcxFKQUchas
         jv/A==
X-Forwarded-Encrypted: i=1; AJvYcCVK4AzEwHsOTDZwEhZoK13Q++dTYG+yGe+dn6tLKAQz02X2tnvwnFEYmhlWm6AMMHmN0ZsrYYCbu9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0nAN1cuiXXFoIF/b4G4F7htSqyEChObyGIPcMlqo+3egeXUwh
	j8Ee8g0kN76APsR7jIFE0oeSt+bvCidv0DqNFXQDf8F1CziCPLR5sT0hWilbsAC6RHc=
X-Gm-Gg: AZuq6aI7BejkES5gbVN5Bt2pcj5qOEHKUQU3GArF9+b0tlB6YvCgswQDkRN/O/FXLO4
	7oGr5u+uGHxYZWcvhKHL52qICYQQY6luD3X+JgDy7AY0hJQ3gt85OXKn9IUp1g+8rODbLNBL/S9
	hgRFephlka8ao+qagRJXyh7Z7wZgjJ8AAZ3Fe9/cIghP/oNW+vLbByYULlpyeTzVY1GMGSHDGn5
	xhmRqO3QSAxONwR2/LthAm+58b19bCO/C5YgUXYMxcZqMwApcv2+K1zdYkCbc218uLSpJOUnJwn
	qOWZ2YduBR6jpUN//ysrvPGi/G/n+iBTaQdHm2E46CVAnJBpR54NiSNsDRazd6wNyT7ElEJVNKr
	x5DuBEwLarjmWsc97snE1cf88osal2mRK92Ln0+vMcQN90Vpj1k8OzjzBYgOr/nIqeiq3QCyKN7
	CQXVacCOVwR4xPAiMg8hXGihJwR6PNOoWuXtTBZBiM9hKr4uNRC6vQYSyrDl0PzlwwWsf7zw==
X-Received: by 2002:a05:620a:410a:b0:8b2:3371:e9d6 with SMTP id af79cd13be357-8c6e2e44d03mr38296485a.62.1769104974462;
        Thu, 22 Jan 2026 10:02:54 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71c083esm1471036185a.17.2026.01.22.10.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:02:53 -0800 (PST)
Date: Thu, 22 Jan 2026 13:02:52 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 3/3] Documentation/driver-api/cxl: ACPI PRM Address
 Translation Support and AMD Zen5 enablement
Message-ID: <aXJmTNKoPhqSDl8J@gourry-fedora-PF4VCD3F>
References: <20260122172432.369215-1-rrichter@amd.com>
 <20260122172432.369215-3-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122172432.369215-3-rrichter@amd.com>

On Thu, Jan 22, 2026 at 06:24:29PM +0100, Robert Richter wrote:
> +
> +The following changes to the specification are needed:
> +
> +* Allow a CXL device to be in an HPA space other than the host's address space.
> +
> +* Allow the platform to use implementation-specific address translation when
> +  crossing memory domains on the CXL.mem path between the host and the device.
> +
> +* Recommend that the platform provide a method for the OS to convert device
> +  addresses to SPAs, such as a PRM handler or _DSM. Document _DSM as the
> +  preferred method.
> +
> +* Specify that the kernel (Operating System) determines Endpoint SPA ranges and
> +  interleaving configurations using platform-specific address translation
> +  methods.
> +

As-written for the state of things - this is fine. Just making a note given
feedback on the translation patch set here:
https://lore.kernel.org/linux-cxl/697186008aa26_1d6f10061@dwillia2-mobl4.notmuch/

If the spec is updated to include such translation tables as described
in the discussion above, then this should probably be updated to say:

---
     Platform shall provide the appropriate CEDT translation tables.

     If the translation mechanism can't be encoded into tables, then it's
     on the platform to justify this and provide PRM or _DSM (etc etc.).
---

~Gregory
