Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792842D73A1;
	Mon, 13 Jul 2026 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958702; cv=none; b=Hkn4+X+HtB0AHzFgXOrHtTStecjdm0jlvjFY2q2s/8NrpuGR3mILQCoXLcuj4ilfN2HoTorpbhSX4ZBeqWD+PLkQGwr8mEQIGMt0tme7+g+5jKUua23yBVnawXb7uQHvoYbNdP44uI1sirQVUNLyBfLCqwgZmtttqAdy9nmUquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958702; c=relaxed/simple;
	bh=LUgiwiCDMfL2K2aMu1Lzxx962YtqwNSWuyvENlcV+0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac5kSaeq9n1VjlNqV8o+B89J9qH1OyxRS3aVHP6eyWrbEe7/TgyTZEpqVAeNVyDQHXfAuZmXbQmr+rHJFS2VKxMB0RNFDN1SJzc+w5TKIwS8XrGWfc2VhkB+SWn56DNfnAWgFSOJ5c3Ao7pNILpA3+TlEWqMlP4IoLRINni7YB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=pdCxyM1h; arc=none smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="pdCxyM1h"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 121173E1ACC;
	Mon, 13 Jul 2026 16:04:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a235.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.104.253.237])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 68FB13E38D9;
	Mon, 13 Jul 2026 16:04:52 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Absorbed-Abaft: 22f03418100c0222_1783958694876_1906233772
X-MC-Loop-Signature: 1783958694876:324422122
X-MC-Ingress-Time: 1783958694876
Received: from pdx1-sub0-mail-a235.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.253.237 (trex/8.0.2);
	Mon, 13 Jul 2026 16:04:54 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a235.dreamhost.com (Postfix) with ESMTPSA id 4gzS1v6LBGz1049;
	Mon, 13 Jul 2026 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1783958692;
	bh=x1IRo2saMd0Iq7tGGG29bORp1HMYrMxTetsjM4TDx2k=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=pdCxyM1hLYpe0/uMzgd6JRQiD0P7iNIldMuVrPybDrEU2wxRSMOM+zZmWugYF4s6G
	 OS7h1o50BrErKUJQNNstNDU6ROikdl9rRxhdI6kNBPWKwbpP60/mOx69E6z21Q6pXq
	 p15m4VLn1MReaN0BOB8iy+VcytUtbr6ArvdAWZ4D07HpKWio37Mq3hiqUHz2DlNGDw
	 X+OnxGs3+7ugZW0uEpOq8poR0kcBszJfkU5x9DgjkLiBxZg8SEroEf1wGQMblMZqkb
	 n7+aUMOIdxcXMfmzgJBce4MMBNEWlJTvw9fyCiJSbuUHZR6hEAset8KX1tl114MJB/
	 +quns2RXYfYyA==
Date: Mon, 13 Jul 2026 09:04:48 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Mayank Rana <mayank.rana@oss.qualcomm.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl/hdm: Enforce CFMWS memory type policy at decoder
 commit time
Message-ID: <20260713160448.wvkpmbldmfciq4a3@offworld>
References: <20260711003341.2602368-1-mayank.rana@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260711003341.2602368-1-mayank.rana@oss.qualcomm.com>
User-Agent: NeoMutt/20220429

On Fri, 10 Jul 2026, Mayank Rana wrote:

>A CXL Fixed Memory Window Structure (CFMWS) in the ACPI CEDT table
>carries a restrictions field that describes the memory types a platform
>window supports.  cfmws_to_decoder_flags() translates this into
>CXL_DECODER_F_TYPE2 (HDM-DB permitted) and CXL_DECODER_F_TYPE3 (HDM-H
>permitted) flags on the root decoder.
>
>However, nothing currently prevents a caller from committing an endpoint
>or switch decoder whose target_type conflicts with the CFMWS policy:

Hi Mayank - please refer to the latest Back Invalidate patchset (v5)
for properly dealing with this:

https://lore.kernel.org/all/20260615145529.13848-1-dave@stgolabs.net/

Thanks,
Davidlohr
