Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041353C1D6A
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906392; cv=none; b=kJyag0q+9RTtFG1UkpQ/Ccg8ViXnxctfwxgou9ksvm2YjEkJRGY3KPDI4ZQNJ93cFKjdeu1z0kM81VV7ax2HmIOIf6JQLWOYcHL5LEaPnCZmJmG+h9H+g1NmBkUhC1+GJxsCvarXFUOPILeQ8i2Jz2VsHljm9nMiWeYWvs1wVvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906392; c=relaxed/simple;
	bh=Vh2+HuugUHtPBvLPlvc8p85K6hVUWhvV9mB2OaIyOBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rK5KDBbdxu1q6v8ykgFU+q07dWZ+895/fgM0YHsAe/i6ClNM4RRFIakhV/e5JcRekw3Br5IvIaHGg4Fgtp5egZXJwoBur/RA3VEPMb4Mldor+d2fXeIJ8Go1GYWNu2pVcq78i2chUd9y25OWeJNaJvlNh0lDjhW/ygz8gKLj+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBrrszMs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBrrszMs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70251F00A3A;
	Tue,  8 Sep 2026 22:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788906390;
	bh=82c9jY0T6uC6259gkaelHOkQyAWovD4jlOl2NM6WgTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mBrrszMsUutmWdKW+MVfp+s1lGIKIg1i+IcH3ZckC17360aWxy9vWtZGjRma2/7V/
	 EfM1iFbAws36HMYVi/VKOAVMgDQLvOzF3xKaQIOifD34D7kkhWLfhKltAGWKXIrWY7
	 8qXB1i4PeRrPz9Mcc5xzTiy6H37EILiG4Z8kJfe7nBk137GCBxswlPWmEAqusZOAsc
	 pWBaTR7OpzL0CWnMHruBtpNzAPP1JVbfxZxmaxGQS3RFtdO7jxBXGzDYcMKjLy4HeI
	 wkIHOgIW0Wx09kpJNuW1eHdneCv/4qu3EfFUXhSClwQrFVlzgcjrKiatL73bMF3fAo
	 hbQT7GtjbmiGQ==
Date: Tue, 8 Sep 2026 23:26:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: Anisa Su <anisa.su887@gmail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] cxl/events: Return IRQ_NONE when no events were
 processed
Message-ID: <20260908232626.064abcf2@jic23-huawei>
In-Reply-To: <8e22c1c2-8098-492a-8162-3dd27507c853@amd.com>
References: <20260901002912.958-1-anisa.su@samsung.com>
	<20260901002912.958-5-anisa.su@samsung.com>
	<8e22c1c2-8098-492a-8162-3dd27507c853@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 14:19:05 -0500
"Cheatham, Benjamin" <benjamin.cheatham@amd.com> wrote:

> On 8/31/2026 7:26 PM, Anisa Su wrote:
> > cxl_event_thread() returns IRQ_HANDLED whether or not it found
> > anything to do. Claiming every interrupt as handled means a device
> > flooding its MSI vector is never detected.
> > 
> > Return IRQ_NONE unless the Event Status register names a log to drain.
> > 
> > Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---  
> 
> I'd mention that the MSI will eventually be disabled, but otherwise looks good
> to me:
> 
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> 
There is also the aspect of sharing.  So I'd assume we'll hit this path
a lot because it was a different interrupt source.  If they all reply
IRQ_NONE then as you say MSI will eventually be disabled.

I saw Anisa just replied to another similar change.   For me these are hardening
to enable the spurious interrupt detection stuff to work and we should be
return IRQ_NONE for the case of we checked if this was the source of interrupts
and it wasn't.  Note this different from us getting an error on something after
we know we had an interrupt.

So I think this patch should go forwards

Jonathan

> Thanks,
> Ben
> 

