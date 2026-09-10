Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174E43D9672
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789077288; cv=none; b=aysI2CP91EcyAx4iTLnikhl1TmTg27Q/9hccAo10SNNYBTyJVJWGYi3qTw/C/J6wygVU2SgInzaW6lW6hUQ5gGYTo9muJUuZeLR8AjFhpOh3P4Ll9o/RbafD2bG+P3rsibNGrzPKh27bRpdhQ07HvPrCSL/5BD+3QKUmCspYkBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789077288; c=relaxed/simple;
	bh=BwgF1GkORN12f2V7sskjGRZGN0Nc7wMltwHLzDgg3Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yl80UWjy3cNPpTpwdetj9XByQ1CJmZJy944oMPPswX8UzWoEwpY4P+0HPX4s6Qk6TMdufJxuaxTHb0C7E+RV4dR3JfuvPENdJdu2k3JYvM1MxfjRdFrGIupaWZB/uD2jtKey8oiZH/ULHmF3MLo4oWz6jmxMk3JJRU0GEzYgq5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdIZfNxI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdIZfNxI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972331F000FF;
	Thu, 10 Sep 2026 21:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789077287;
	bh=UjcmrVXdd+9Jd2n9LOYOxfcynonZDQQSJ/Z+P+jThdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IdIZfNxIhfuze/3x2YK9g1sXt7Xec8TSzacaDnCsGD90VNg8jdwtA/Qpr0QNk0PPP
	 rTgjJ9i2TeZLTswf8Fv/q6Gfqc1MuT68XFsyRqgwZgaTcKgpIQpGGYPrGFKpveJH77
	 6QTrgby+N4rGrqqVfI+VoQI+OsrnwQMQkziFw0WsqXG6pSYEhT2zP2oVhiu9aBMXZI
	 OYMxtGExf9WS6O7I04BegbKLrVXvsscxHLIwuW30cA/mSEdHV5xUazZE45KtJJxDBA
	 t07Q5aZomd6tN+Y9xNAh+nZV4+Ve6TSGO68U7tQEwemG53kLah3/ES/MNtmWS7D5+B
	 xQm3L9uIX2ADA==
Date: Thu, 10 Sep 2026 22:54:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 1/2] cxl/cdat: Fix uninitialized stack use in
 bandwidth gathering
Message-ID: <20260910225441.05cb19df@jic23-hlaptop>
In-Reply-To: <8afb1842-630b-42e9-be90-e79ab7445530@intel.com>
References: <20260831092216.540644-1-kanie@linux.alibaba.com>
	<20260831092216.540644-2-kanie@linux.alibaba.com>
	<8afb1842-630b-42e9-be90-e79ab7445530@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 09:01:33 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 8/31/26 2:22 AM, Guixin Liu wrote:
> > cxl_endpoint_gather_bandwidth() and cxl_switch_gather_bandwidth() declare
> > access_coordinate arrays on the stack and rely on their helpers to fill
> > them. The helpers assign only the bandwidth members, and the combine step
> > assigns even those only when both inputs are non-zero. The latency members
> > are summed from stack residue on every call, and the bandwidth members
> > keep that residue into the region access coordinate sysfs attributes when
> > the endpoint CDAT reports no bandwidth.
> > 
> > Zero initialize the arrays. Zero is the value this code already uses for
> > "not reported", so an unset member now reads back as unknown rather than as
> > a plausible number.
> > 
> > Found by code inspection. Tested on a QEMU CXL topology with two endpoints
> > sharing a switch upstream link and HMAT generic-port coordinates for the
> > host bridge, which the calculation requires to run at all: with temporary
> > printk at the combine sites, the unpatched kernel summed 0xfefefefe, the
> > CONFIG_INIT_STACK_ALL_PATTERN stack filler, into the latency members, while
> > the patched kernel reports the CDAT latency values there.
> > 
> > Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
> > Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> > Reviewed-by: Richard Cheng <icheng@nvidia.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
