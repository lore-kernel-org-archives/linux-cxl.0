Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282787;
	b=ZknR9eoZUqom52ZL9VI6hki0FBU4wb894fE8i+Dqz0hgg6/WWO7ZLk+qbuE2rqgUtZCx
	 ahnAlDNvD1kChMxIBDJTk/jcUwHnSOmldw/xtOgNBA07iAGyNLPu1r3gdFz4diNS/c69s
	 ABiO8uuZD+18Awfe0dtXUR5ThrTi6fjFHmmMGYW7GrUSjPMw4QvdJNUOyZX6/Em6HwFa6
	 e+81SdkJWWKU0uisLS/jg9suJM6QU+iDv6Ia1qPTrX4XM8tL1JRpYtv7W3fFA91sJsHTL
	 FuRUdaCKcIetpd2uYQbfq3ShyBfK3OTgDU01ABUGZc++M9KWFvf4+uJ8+14Etzq+m4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282787;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=prUUmFgIbRozxnG45CnPivtZIu1z7ZnqJIdDDicE5Sw=;
	b=R/rDuQNGBk9sH2cMCHcAmJ5+owUeJ1sY1fryoQhZlpVEF4MJqKDvMm+yf0LSu4efl89S
	 xAP2WxdZ8ZgDBugpuc03Z5Ctmpdr5bzW1G5fKlIVS5eHYWNdnA4SG6dfqg6/3q+dSdfkz
	 inF6K8+YJ6r/gl+wnwwTLt8LRubp0gOKQhsgtQ/H4HcG73xWDNQr0K6PA8glkXAUUchv1
	 GVuo1bjBOGXUE3FBObIXzHZetebkVEMsMFlPSVezPloYixiFNtudnakapU+1pNSf9JwTj
	 48gFw0XiUAevP6F2awmBE19wl6aHWMslE785o8U0x5InGM8vdWFmDRLStcOJqoApyiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWZcQ0bw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C141606A321;
	Tue, 10 Nov 2026 03:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TWZcQ0bw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DD91F0089F;
	Tue, 10 Nov 2026 03:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282787;
	bh=prUUmFgIbRozxnG45CnPivtZIu1z7ZnqJIdDDicE5Sw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TWZcQ0bwuxPTraT13m/rvH/B9NpaeOVfkvHS1EU6pHsv/cCEoFlPU5qD1oF6xbgja
	 7y37dAvwA+h7orKtdFIcl5EweVFPQ2A82Y2Jw2B/gWrlVPgnz1RKkiB6ETGC4Qy5a+
	 rFvmZ/ifs9NjBdMb+qHus/xG7i9XXQIK7tAzpMUrt7UGn7raaVgPusxLlBS8w06Nbd
	 ymSokfYa2f7jlmduMsGr+XWTgYmo1Yf9Jeqm0Fm/YOgC25PFwhNY96WXVNiucpFty5
	 Wdcsy8zDDmGwtA5Qnoo/RyHWqdCN6gaqZHfTk52HtFL2NaRRHCQdHX4hWf0bNB8Zd8
	 1nOzeXCFzItgA==
Date: Tue, 10 Nov 2026 03:52:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, Davidlohr Bueso
 <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH] MAINTAINERS: Add CXL reviewer Ben Cheatham
Message-ID: <20261110035259.052c92b0@jic23-hlaptop>
In-Reply-To: <20261104175003.297974-1-dave.jiang@intel.com>
References: <20261104175003.297974-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Nov 2026 10:50:03 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Adding Ben as a reviewer for the CXL subsystem.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ben Cheatham <benjamin.cheatham@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2a955a626784..edaf70961cba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6729,6 +6729,7 @@ M:	Vishal Verma <vishal.l.verma@intel.com>
>  R:	Ira Weiny <iweiny@kernel.org>
>  R:	Li Ming <ming.li@zohomail.com>
>  R:	Richard Cheng <icheng@nvidia.com>
> +R:	Ben Cheatham <benjamin.cheatham@amd.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/driver-api/cxl
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> prerequisite-patch-id: 57bdcea37c2a480531ec5d1022422748e462077a

