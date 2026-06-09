Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1951925783A
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781047495; cv=none; b=mRLdYMFTaWxg20+fgKRD1BZDNFaJgSoXv62L8FI912FrP77rusSEvvc999djfdCMNld7BCgyZ/6yryF0p6BDNTzakPHbKQbcG15Uypt5pITop3f9wRQLpXMeoHe9W89UalY+VwDnngzS2xwfPMmwldPx9K0nDG+r32aPkPUINos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781047495; c=relaxed/simple;
	bh=Ss8CuDUnbvm/KoC0IWoRrDApujyz+XdCUVhtiU6mCd8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FUKeDtUT3uWaYfDFPZtcgQ632iCzq547SBofIUnM+uel4h3rigdszBOPB76HGZ4J3isp7Gu8V/8C/vAT4QkpeSq1YBhFASyGhPGrYOvYpmQuvZdX4ZPEhkd/1nmk7sdVa1l2cbK6S+ByQfbeBLEfmOUCe3u6lWB7dJlqxd+VbqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ynxj/jfp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ynxj/jfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8683F1F00893;
	Tue,  9 Jun 2026 23:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781047493;
	bh=1xm4xzIJK6tPlNijeCKJBsNhudwiwx2S3gwnzBS1160=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Ynxj/jfpmUJ7Y8FVoxAQiPs+bEXZac4uiOCPUyBHVETzvY66IRZDkA1mrOi/D92ko
	 8cYmMVtBmuXn96CBqQj2LkbKCnMY3GeCaTmjRIAJN1Aw1QhsbF1hmin2mW1PVco8vq
	 /WNrefGDO6372x/De7jfaWIRCPgp80yCBW6Yj/RJCDNFziSM9101C489bwHiLkDMv9
	 eNY+Wa1fVV+0V73E4JuTJX9f/jqZPLlif+vp2qaLj5RSam1sFWarK3lAVC7nchSoeW
	 4YCgLsW91ExhihkN8F4SIt5bgUNvVjJMGsDr0Ic+k591zblfCb4gevc0mfMdjMkeQu
	 VW2cErO/mRiKQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id BF38BF4007D;
	Tue,  9 Jun 2026 19:24:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 09 Jun 2026 19:24:52 -0400
X-ME-Sender: <xms:xKAoajUZdc29Y10-cA2Lcml56EkImpAGgJQXdE3N_SO2aeSsXdK4qQ>
    <xme:xKAoagyh3RJV5IprKzipErwdyVRbydw8rxrKNk7Ikh5zl9WVBvHnSZLgGOgq0qMQA
    l8OX-6xQwDWPENb6HDtHec9T7cPkVTLeW84L89LaALbvHEJSUSFZrs>
X-ME-Received: <xmr:xKAoaiziiCXE6uPILO16wkR7Q5tXJ-gUE9fXk_fptvUZZ3LdoMOKSLWvg9Eu3WClqXOfz-QfXcE2swa0Pjx394_lck4gF1UhAW8>
X-ME-Proxy-Cause: dmFkZTGyuSDSzmUK7Bvry6ZZ3+g03myhtlP9WTQ6TpMUmV+SJbGaVFEffdrmNdpuDVWCIL
    jHrAIeCLo5G09VXhX0rFqYZ9cV5I8NkLEtJcFjOqTxhPYRepDLkCGnBnpdAdjU+b7KHH/0
    AJXB857VJZWo7RNEJVtV/bOudf2ZAN+Uja6UN8yN3yLdWEhO68yPRoF+vtJu332GM2q0Zo
    s0HaU+NKZs6r60mqj082ZPrFQFD8s7BtudYIr+AabmVWgffgdjA8T7nyxyXzMG8dXcos5h
    sAg8JpGXN+0Got2tT/LBiMI3j2kDJ5hPcf5FsdhMqG04MqZAPvFU7n9/L1uKQfJ5s8czH+
    mibFc+LgINgcpj3KQPu6mNizf6pjNJd2Mo0V3tqrsvrS2RZR092lrARogzZ669K/1hlE+7
    BEms8KXn1DvXyzbnqKEEo/pZZ/KgZQYn0vejjKsUEy9XLNeJJUmDvs63zaQ6MpP+lhVB2b
    KU85YIq04FS44VDCaoeiRNGXVr6fMR6dh98fR/Q/DUDCmcQ2D+O3LXOCa+DbII0ykFXA0m
    Rlb4gE59gY8OofpzAkMRvOGnwGIvvCdbrAEr8pNMekEdAwGIKZZ0f941aX0Gey9ewhu4Oy
    m2G741RazfNcVGvt7mfmdilxl66nljdX9Y2/ZQByJKwGy8vUvvgk6W9R2MUQ
X-ME-Proxy: <xmx:xKAoat0TKj0flOjnvQZue0vy1dGUUQILBmxyO2c99uQUQ4m82m0u8w>
    <xmx:xKAoaoqW-rBkePUWxx8doAXimzIw57xTVFXyBI3V7DfxjrtkYji-_Q>
    <xmx:xKAoarCUCjLNFf1L572KLt4Qsp4nI7mabKasEV1ZD4tqaevzQmG3RQ>
    <xmx:xKAoahoAE8X55FuPaiQ1YsFEoMihT-jiu_a8y7fIMoeyKGBcjaxSmw>
    <xmx:xKAoauB7WyaNuydB3IKb462MnP14u8HSU287r_XB3zqlCAGKXEpdDeLZ>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 19:24:52 -0400 (EDT)
Date: Tue, 09 Jun 2026 16:24:51 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: alejandro.lucero-palau@amd.com, 
 linux-cxl@vger.kernel.org, 
 netdev@vger.kernel.org, 
 djbw@kernel.org, 
 edward.cree@amd.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Ben Cheatham <benjamin.cheatham@amd.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-ID: <6a28a0c349c9b_4fa7810099@djbw-dev.notmuch>
In-Reply-To: <20260609215755.8685-4-alejandro.lucero-palau@amd.com>
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
 <20260609215755.8685-4-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v27 3/5] cxl/sfc: Initialize dpa without a mailbox
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for DPA initialization.
> 
> Allow a Type2 driver to initialize DPA simply by giving the size of its
> volatile hardware partition.
> 
> Move related functions to memdev.

The code movement is not strictly necessary. Just add cxl_set_capacity()
and we can consider a move later if mbox.o and memdev.o are ever not
both included in cxl_core.o by default.

> Add sfc driver as the client.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[..]
> +/**
> + * cxl_set_capacity: initialize dpa by a driver without a mailbox.
> + *
> ++ * @cxlds: pointer to cxl_dev_state

Stray "+"?
