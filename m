Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE921DEFE8
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192665; cv=none; b=NFV7hYt1ZSK0UEE47K/PmtPfrD5i5TSn+oxJ97mySA8BYUc3mEVmpOpuAlgErQSYJAomuN+003JQwOLGUoNFssSCHGbVV9dnpZF3IEUaXmK5P1Evqz8C4iEqFPpgVAPTSQlXNNQCGQzL6viRQi8NKQGl9PD6gIwEsUS1jwPD/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192665; c=relaxed/simple;
	bh=aJfv5nRnKwSdBkqB0u+lWWG0vavcIkBIY3JFAwkHk6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lrssCs8AdgEQimgue2Zq0dbTqNBb77a2o42SZU+Y641I4yt3uaWERfBdan6sJCoUXIIVPguAEAKYordfLWc2xHjJF1xitrqnMqmPmyWBRUzOC0ltI7pgF1bz7DCVF2W7kn6f/JVaVrdxdG2Y8XaEPXiaAJwXsqXNX/Uv4yLWbr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lS2aHDTU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lS2aHDTU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0566E1F00893;
	Thu, 11 Jun 2026 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781192664;
	bh=F8nd+p67u4t36h+GZKSBdhPenkI5pQPUyL9Cu3BrfJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lS2aHDTUS3rVv5Cp3H2jOwyso5OvLkyMiF2TJr/6c9rbdomXO5YpIZpiPjuVn8m+i
	 n4V5MjTs3EqKzipJsVT+1v3waS2wbdetNA/xqB0bXFipWBmj1K9dnQjZ8s4N2+J6t+
	 8ud/ip2H1oOJr1shC021zadKmuleT6N5HXaq7hhpr0TFB3UakMyR8GlgOtO6zC/v1E
	 F8JjTCmCrLqfh+Hn4WHHJd6QnhnP4Pr0IXQH9AfrnMAtWhlnxJ1+qHldVbRcqgnbpN
	 1RXjMUstiK7dRRachAUCmE3bP197oyaOEDhv+R5MqM4vjmEeKbHw2bVhxfqf8FByoT
	 DfN+ILC1yHiRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] cxl/test: Fixup hdm init for auto region to
 support type2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260611152124.3656434-6-dave.jiang@intel.com>
References: <20260611152124.3656434-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 15:44:22 +0000
Message-Id: <20260611154424.0566E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Concurrent modification of shared switch/root decoders and their=
 registry entries without synchronization.
--

commit 7bae93279b06918f3ff41cc5d5704995d896c3cb
Author: Dave Jiang <dave.jiang@intel.com>

cxl/test: Fixup hdm init for auto region to support type2
   =20
Add support to setup initialization of decoders in order to support type2
auto region.

> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index de4124afa1328..0310f2efd3319 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
[ ... ]
> @@ -1239,7 +1287,76 @@ static bool mock_init_hdm_decoder(struct cxl_decod=
er *cxld)
>  		cxld_registry_update(cxld);

[Severity: Medium]
This is a pre-existing issue, but is there a potential data race here?

Because cxl_mem.0 and cxl_mem.4 are probed asynchronously, both threads
can reach mock_init_hdm_type3_cxled() concurrently. They both look up the
shared upstream switch and root port decoders via device_find_child(),
and then simultaneously modify shared fields like cxlsd->target[] and
call cxld_registry_update(cxld).

Could this lack of mutual exclusion corrupt the mock cxld state via
non-atomic writes or concurrent registry updates?

>  		put_device(dev);
>  	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611152124.3656=
434-1-dave.jiang@intel.com?part=3D5
