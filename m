Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3F4257824
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 04:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066409; cv=none; b=VDDr81qDtBJVqLsz1XTJhVvHHAMKa6xkVDFYHqy3HfDTfL9Ljze5HvGyNe+NVtONLoxpsq2ys0D2XXCEwCHMkWwUfXTwHbzNaecLQ2aYMptTxyNZ1pXiySIraMUwxdJFib7/UeJ1mHI3hU+OrHB9lTfpVJFnBXffcJ4D+R0UUfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066409; c=relaxed/simple;
	bh=3vSW98b3AcnJ+HyuyLuVkPdAdZUos7uD7da1d09by0k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZifFPcabodBIxinVsq/VjSP3+3nJXyQkFzjsefKsHs7THFIbjxpZRuT8itmitWgtChwXa0S83XtYd5i59LXqfG8voCazYWU7mHgpNpyv8mCCSL0HUQCLPTMQTe7S/HISXaCJM9YacC5rhMdl0tPMGY/FY0POU4Ce/CpufsM7jXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjI5289o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjI5289o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5071F00898;
	Wed, 10 Jun 2026 04:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781066408;
	bh=WoSjl63QShdw68XMyKkbEmXBz/6kgxt00miA1edw4oA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=BjI5289oTfAkaHd+VyupdqVqtL0LbOPbQR0LlquhahC1x1LmZMW7xn/5DKTCmrvno
	 1yRLSXpowR+uQcQTrHrFNoKejUrLdWo6eeOLHdanNyT4TQ3qhnbWrsFN47VZxER1c9
	 rusBARPdz02wIvZP1N0/mgC6/hpVOuWC9LczDbBvgS44ptzW3JboB+7/Voko0zZyEj
	 xSO7W1Z2uC9y6HLH5xaPdRaTaBZ0cja8ri1p+Vjm1gjBujMshDDn6lzgHNFvPYQC1o
	 dm5sgyUxev+0tkAVkTlZTrNZH2LukhLDcJfpG+lNdz0XjovLzBMD/ke2sB3J2t+p77
	 88GN5JQ18GMuw==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 03E80F4008B;
	Wed, 10 Jun 2026 00:40:06 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 00:40:07 -0400
X-ME-Sender: <xms:puooartxUOWVJWjP9i1pm_ZhJ7DHSN8yR1rf-KC7Hq2jU0oRZSK7Jw>
    <xme:puooanRCYccyma8OX7kHm3uUZNYB5jUY3DkW6nNFC28FYoogMsfTaaMPiSjomjpDb
    Voht4rZYWAkAXvqp7yIKamFOfKGnD9Ip6ozpkP8uKZ2Eq43bMVRsp6a>
X-ME-Proxy-Cause: dmFkZTFEC/Lc2mI8hRKup+1H0cd+KHlftFP6jyFwqmSwGAPtbw/QP70ianDIDLRo3ygFBX
    LV/++7SgEhh18rjcq96WS0w7b56JymnP43li/t9RzcCv4VbAwH6NIAPH72DhaygWeANwsD
    45IGxJ0ynSKhEnd4LoaCV2Rg29yfASlsbKR/wjszd1SgplohdyI4k4t7zhoqWaTLjhBYpo
    P8yVVnrW59Y9IiYfJ2gyJTa7jgmuPeFs4/lJ0CDyPvwKrEBDE7aMDkWiI08RqDyAAwuGKB
    t1ygBGFgORhxaHv3Hke986ePfhFZvqLf8DRZbznqzGuaw0zDamn2zOVd0NCNHeMojwqDXD
    e1kI1x8uhG06mCRwYQ3+n6sbl/zFbCNe/nksQKE1ZDbYFY5RW0Be+W0Kwrgx89Pl1J5E/Q
    m2GPt4HX446oSVRZkVFwsrOj7Bk+u1PHU/p+YbPlG1H/tRic5vWB3D6Rv+SBRbCwCSI2zC
    VY4JUlF45so6UQI+GHATOOfFa5SfZGtSxlSraCsFPvBwW7NW3BVtqL5KpgKYRrtYhvrYZ7
    DIn8T6VgPMMpULvrK7pEt0icV1KkWvmz++Jfa3CUkLs9XcGLA91oySwloRdXDEIKaRm2d2
    YlBNEbfvJDTpQgyQHngK4/ZWLJkIMrdiZpvcWXimpQs/I6nLyErDDqJVGz9g
X-ME-Proxy: <xmx:puooatBGUVzKmNeQU45VL4dwgsHyuHZSgzYQeP_vtOeV5ElZnyW2pA>
    <xmx:puooalgk43DKCJbxTIGjjksmqgzvnT8IXPo9NNUE2T15Zg_ryQCP4w>
    <xmx:puooavMXvBxs-y3QWcFsxE1mqRT_WN-SbsWIgjvIjDC9IhTEI3ZLRQ>
    <xmx:puooal-CVujYW08sP9dOP_cyQo8Km6Fjj3gUgzs6p1OP6x8amZJ4jw>
    <xmx:puooagctTro3jbH7U2qeSQAerD0mzfOGeswzTniZ2B6lD6y4Si91cgN5>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D69242CC0083; Wed, 10 Jun 2026 00:40:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 09 Jun 2026 21:39:46 -0700
From: "Dan Williams" <djbw@kernel.org>
To: "Ethan Nelson-Moore" <enelsonmoore@gmail.com>, linux-cxl@vger.kernel.org
Cc: "Davidlohr Bueso" <dave@stgolabs.net>,
 "Jonathan Cameron" <jic23@kernel.org>, "Dave Jiang" <dave.jiang@intel.com>,
 "Alison Schofield" <alison.schofield@intel.com>,
 "Vishal Verma" <vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>
Message-Id: <b60cb7ed-82b4-4e4e-9d3c-de61478f9a22@app.fastmail.com>
In-Reply-To: <20260610042101.222349-1-enelsonmoore@gmail.com>
References: <20260610042101.222349-1-enelsonmoore@gmail.com>
Subject: Re: [PATCH] cxl/port: update reference to removed CONFIG_PROVE_CXL_LOCKING
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Jun 9, 2026, at 9:21 PM, Ethan Nelson-Moore wrote:
> A comment in drivers/cxl/port.c refers to CONFIG_PROVE_CXL_LOCKING,
> which was removed in commit 38a34e10768c ("cxl: Drop
> cxl_device_lock()"). That commit switched CXL subsystem locking to
> custom lock classes, which can be validated via the standard
> CONFIG_PROVE_LOCKING option. Update the comment to reflect this.
>
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---

Looks good, 

Reviewed-by: Dan Williams <djbw@kernel.org>
