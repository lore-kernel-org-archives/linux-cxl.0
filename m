Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C43FD143;
	Thu, 21 May 2026 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779393093; cv=none; b=TYwhQtywBey7sxkxyGURrCS6916hkbwuvVZ2s+AXuP7EKHtJ75KHYs+L4EXYd+IKbjbhGWy+LACcStwA2THa/knRhUcZNbSI3ab7ONIoFy+mtVME7dAHkaF42HsbiMiUk5J2fFg8KOb3meUOkGiXC4QuE/zbxe5c/pOyk9H8Qdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779393093; c=relaxed/simple;
	bh=PP8Gtz5OnLyxj6yGQIv2ZRHS6cd+K4sp35TGbXNzC+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVZPMW3e3i6yYmuZ52ldvAie2OfGx1OLwfQN1OWpi2V/anl9W0+p+2tk8+xlW9fJG5zdA8FTRbnxC4qUOa89PA/QOXgO1sipy2wLVj4JKBe9UXvHPADQ5Cti27g75K5jyeiewqsAy21EqBz8L8K0TB9sFd+yu1Fk7fmvJ9lqxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOVlV9ll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOVlV9ll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D001F000E9;
	Thu, 21 May 2026 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779393092;
	bh=6O1i7taobt3qaMtlX7PtASTUyFsunjXLnY65AUMbyVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lOVlV9llEUEQOpVsXdYH5nVDGfb/F2LUCUuMcC5epuCiiOiOr45+aqOGfL2xs4bQo
	 eDkUue6BbfwrR9XDbaRrHetFwF4NUhYyxB2LjfW5c2m9uF8+S+dfPOapxigxqCtCNx
	 01KEh3CQeKn8W0KTrmfRjPNPZSmAvTJVnHjC/EcUFKdzN7i/BDY2GrqG65I/fg6zcB
	 /0TNKrOFsOQrsYFOYtwLmGUJUBB5UiarhJ1NkG3Qnhiw0P64EAUFTFN8TAefP7sCry
	 YHNxmoOuDcRX0u1dvA9S/B5eDVKo6jjXx4f9ctBBT9un1TFIXhzpathjo7zmbffSBw
	 gYtO0nB1/udHg==
Date: Thu, 21 May 2026 21:51:27 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: "Dan Williams (nvidia)" <djbw@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Dave Jiang <dave.jiang@intel.com>, Smita Koralahalli
 <smita.koralahallichannabasappa@amd.com>, Robert Richter
 <rrichter@amd.com>, Jonathan Cameron <jic23@kernel.org>, Shiju Jose
 <shiju.jose@huawei.com>, Sathyanarayanan Kuppuswamy
 <sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
 Lukas Wunner <lukas@wunner.de>, "PradeepVineshReddy.Kodamati@amd.com"
 <PradeepVineshReddy.Kodamati@amd.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: RFC: CXL: How to handle trace event ABI break from
 CXL_HEADERLOG_SIZE fix?
Message-ID: <20260521215127.327549ff@foz.lan>
In-Reply-To: <7c9cb682-ec3e-438b-830c-2a5997b69c43@amd.com>
References: <51a77746-5199-44a2-aa2e-d04cdd6084e7@amd.com>
	<6a0e33507e961_1717cc100f6@djbw-dev.notmuch>
	<7c9cb682-ec3e-438b-830c-2a5997b69c43@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 07:23:45 -0500
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 5/20/2026 5:18 PM, Dan Williams (nvidia) wrote:
> > Bowman, Terry wrote:  
> >> Hi Mauro and Everyone,
> >>
> >> During development of the CXL protocol series [1], the Sashiko tool 
> >> identified an issue in the CXL RAS UCE trace logging for Ports and Endpoints. 
> >> Specifically, the CXL RAS UCE header log size is incorrectly defined in 
> >> drivers/cxl/cxl.h.
> >>
> >> The UCE header log size is currently defined as 128 u32s (512 bytes),
> >> whereas it should be 16 u32s (64 bytes) per CXL r4.0 8.2.4.17.7. Correcting 
> >> this will change the trace format and break the existing ABI contract 
> >> with rasdaemon.
> >>
> >> How would you recommend proceeding to resolve this?  
> > 
> > Split the definitions into one that reads from the register space and
> > once that passes the parsed log to the trace buffer.
> > 
> > Something like:
> > 
> > u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32];
> > 
> > ...zero-fill that and put a comment about how userspace has already
> > grown a dependency on the buggy size.
> > 
> > In other words, keep the userspace compatibility, but fix the iomem
> > overflow.  
> 
> Ok, that's straight forward. Thanks.

Such approach sounds good to me.

Regards,
Mauro

Thanks,
Mauro
