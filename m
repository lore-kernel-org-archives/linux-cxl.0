Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8781F1C5799
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780879822; cv=none; b=riHEMoeGFBWti2xAQaLem4ISbbzyEdVxQb1RpO7gaKygJ90vhCbMBAJP2dul6Zh9eZfPKQu5OBDuzrF261xJsktJT2kUkABGOixJ/IN/P732dXBxQ8WV3RZyKOV1rc2tyLRE/A8RHKiSIuVRGkji17xRuOOfXNjK5EGN6xNmAV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780879822; c=relaxed/simple;
	bh=Nzc7ZRB72BRQgibHILx95SmXkJ6wwSRvRHTwptDAmJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iL+JMwGLcExgWrg2cxGdKQPpySIxDMSFHOd9QS0/YlJTG28joSLCrear+DNgg450u7l/qQCd6aI85Y89FrVQcS4FE+HwakuQ2vMSCAiU407gSTAqs8H9xCwIpNK9qkuzQX5ag3jY7Z6PNl5pIUkxQmx9XRQ9+94wkCGY1m6Uyew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=fIXQb9aD; arc=none smtp.client-ip=23.83.223.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="fIXQb9aD"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9AE957E2806;
	Mon, 08 Jun 2026 00:41:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a252.dreamhost.com (100-105-225-54.trex-nlb.outbound.svc.cluster.local [100.105.225.54])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2FD687E1DFA;
	Mon, 08 Jun 2026 00:41:43 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chief-Abiding: 4d7be9db57e0b7e8_1780879303477_3418800092
X-MC-Loop-Signature: 1780879303477:1002946274
X-MC-Ingress-Time: 1780879303476
Received: from pdx1-sub0-mail-a252.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.225.54 (trex/7.1.5);
	Mon, 08 Jun 2026 00:41:43 +0000
Received: from offworld (186-79-212-212.fo.baf.movistar.cl [186.79.212.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a252.dreamhost.com (Postfix) with ESMTPSA id 4gYYBq66ldzyrG;
	Sun,  7 Jun 2026 17:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780879302;
	bh=Nzc7ZRB72BRQgibHILx95SmXkJ6wwSRvRHTwptDAmJM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=fIXQb9aDX6G2FYZXNYfyjl4d0sa3aqL5AUJJzuou9yagA2Qtlrxvjmk2yYwrk24Wr
	 uEDYLxyXIbB6bN7NToV6uvWMcE5Mv4tjyD+lbgzV1dQBqis0e9nFBGex54mD9S5oI/
	 +Ftyi5zlZntIt0qxMKTrk9HmROoxXv+506O58os9DSYgGrcEOUk7lvElMeW+j8w2Sk
	 bwpj+Zr71GZpDE8eG/OFvIzzJuPTUPNlI1GGuqmzEg9PW+eeFGdt/32kG5YBuFVvXF
	 bA2Zq15RCJnDC/gGnqxOS6+vfcSSilH6NZmwwIwZsfYSPQy7po0Thf3Wpc1evIi/Yw
	 rGnb8Um+dNblA==
Date: Sun, 7 Jun 2026 17:41:34 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org,
	benjamin.cheatham@amd.com, alucerop@amd.com,
	alison.schofield@intel.com, gourry@gourry.net,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 0/5] cxl: Support Back-Invalidate
Message-ID: <20260608004134.y2vivyghfvggcw6x@offworld>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <aiI2Y6su1iAmOXxL@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aiI2Y6su1iAmOXxL@MWDK4CY14F>
User-Agent: NeoMutt/20220429

Hi Richard,

On Fri, 05 Jun 2026, Richard Cheng wrote:

>On Thu, Jun 04, 2026 at 05:33:24PM +0800, Davidlohr Bueso wrote:
>
>Hi Davidlohr,
>All the above patches lacks of v4 tag,
>small nit pick but it confuses me at first,
>maybe add the tags to every patches in the patch series.

Its rather common in lkml for only the cover letter to have the
version; but sure I can label all of the patches, specially
since I labeled v3 (but that was my script misfiring).

Anyway, thanks a lot for going through Sashiko reviews and
verifying some issues. At this point I have addressed all your
feedback, but will wait a little longer before sending a v5
to see if anyone else has comments on the series.

Thanks,
Davidlohr
