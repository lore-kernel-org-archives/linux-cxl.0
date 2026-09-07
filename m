Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3CA5221D7;
	Mon,  7 Sep 2026 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788806670; cv=none; b=MiDAVZB5YomuAp2N4DdCUGB9XjYDg4Wuq3ygbMf7gHaBLMbq6yFJcqZmf4bf420h4KiDIybriinkTffebOMZC69wSTvg7tiw5o6oLzyufP4LSYuHpCm7Ge4xozegUL1msTRggv8TjZ9KOovc8h2WrdrEnAP8y9uqPxFEfOfkt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788806670; c=relaxed/simple;
	bh=nciSz/gyZE9auiEeJThY/O759Gt4ZdANMcDP6aU42Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odi4ICb/T69ELZGzD0JYUFkBr+Dh/Y2kI4XEJ0VE4suc7l1HWly5CGuGVNi0C0lEgpwAc2IPCUWT7iw30L9K+xGxcNm9BtVyec92iBaw1nKG557nhf6UMBoMlE/T8MlM1RJvwKr4f0Qr/syJ5tqFpw9+Kdnx6/IcyC9YoiGsK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNEHA4nU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNEHA4nU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2271F00A3A;
	Mon,  7 Sep 2026 18:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788806644;
	bh=2rkPgBM6fBKhvU4RrZDedh0bDJiTTnXLzO61eKlI9Pc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oNEHA4nUdnqBThvyFSP4NEXm81QbHW5ENnfZ9MAW+B2mniAG+G2Hh78Hq6XvMvgrd
	 CxSvG2BnbbFJbMGhGxOzrqtxMi+/76B0aa+3FWYHi0kMkXSVOugnB5mNIsxScuznTg
	 ne5bHkmZZAd9y/pvhUzS2/HtmbUB8oLjr0VpmyZ1g4w+dSqULY0WKq2L/7wmC8nRoS
	 oI+acl4w1ES8Gy3rUg+IdNzlS9A9WYMrapugJ6ohtoyTKSFYwtqnU6IAM3bpvCv+GU
	 8p7vM3CcUmWP1vG3cIOvyhGoZ71b58KgPy4xi41esbTazrzg8UM3VqxK+Nt8RCEXhM
	 6F7DBMsNgbdKQ==
Date: Mon, 7 Sep 2026 19:44:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Shaikh Kamaluddin"
 <shaikhkamal2012@gmail.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/events: Return IRQ_NONE when no event is pending
Message-ID: <20260907194400.17bb5f5c@jic23-huawei>
In-Reply-To: <20260906160901.49F851F00A3A@smtp.kernel.org>
References: <20260906155705.13252-1-shaikhkamal2012@gmail.com>
	<20260906160901.49F851F00A3A@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 06 Sep 2026 16:09:00 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The `cxl_event_thread` can enter an infinite loop on device surprise removal or mailbox hardware failure, hanging the CPU and permanently masking a shared IRQ line.

FWIW I'd be doubtful about fixing this unless we have some evidence
it is actually useful in practice.  Today we do not support surprise
removal and I'm not sure that will change any time soon.

Jonathan

> --
> 
> commit f6cda8d59c7a077a8328222a63290241e9b118c0
> Author: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> cxl/events: Return IRQ_NONE when no event is pending
> 
> This commit tracks whether at least one supported event status bit was observed
> during interrupt handling. It returns IRQ_NONE when there was no event to
> service, allowing the shared interrupt handler to behave correctly.
> 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index c7c91e8dc51dc..8b560cae91f2e 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -515,6 +515,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)  
> 
> [ ... ]
> 
> >  		status &= CXLDEV_EVENT_STATUS_ALL;
> >  		if (!status)
> >  			break;
> > +
> > +		handled = true;
> >  		cxl_mem_get_event_records(mds, status);
> >  		cond_resched();
> >  	} while (status);  
> 
> [Severity: High]
> This is a pre-existing issue, but can cxl_event_thread() get stuck in an
> infinite loop here?
> 
> If a CXL device undergoes a surprise removal or a mailbox failure,
> cxl_mem_get_records_log() can abort early without clearing the hardware
> event status:
> 
> drivers/cxl/core/mbox.c:cxl_mem_get_records_log() {
>     ...
> 		if (rc) {
> 			dev_err_ratelimited(dev,
> 				"Event log '%d': Failed to query event records : %d",
> 				type, rc);
> 			break;
> 		}
>     ...
> }
> 
> Because the local status variable evaluated in the while condition remains
> non-zero, the loop will restart. If the memory-mapped read at the top of the
> loop then returns 0xFFFFFFFF or the stuck status, the loop will spin endlessly,
> permanently masking the shared interrupt line.
> 
> Should we add a mechanism to break out of this loop or track whether the
> hardware status is actively being cleared?
> 
> >  
> > -	return IRQ_HANDLED;
> > +	return handled ? IRQ_HANDLED : IRQ_NONE;
> >  }  
> 

