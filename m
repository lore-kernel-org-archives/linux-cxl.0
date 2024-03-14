Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7991573539
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710448362; cv=none; b=CDqUh2EoWeYhKNRJnUpUn/fdPhNgG/32+QjHvHF3+EpZiCBPTzDYmmWFgHYCyuSEFBrsWurPnTXnIXIpR9MpR5mLsIfOEOR080dj5fShJJKtMF4X6C3lL2anw0z5GmZTKbw+N3fTgRCTlprx46DHmQgb8wn8stnfJnloh7RNNzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710448362; c=relaxed/simple;
	bh=rN25oYDwU3w2hdU/vJHtcYPHccRUFQGcMbcb4X5Apk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rx5gv7XfgROHOWkWNDYWneyFeBcisHZitEoYBPmuj4e2avtdOnL5qib7yz0X2wwT5lCzUwj851RP41cfgaqS3aR5TUPfdSpsKZC9lKzvqv7ieCcPhqt3hCkwn5AFJ4QNInqriwqo0kdEIL0wqTgC2dZWo5Y/n5GMQbVh9L3IIp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBEBC433F1;
	Thu, 14 Mar 2024 20:32:40 +0000 (UTC)
Date: Thu, 14 Mar 2024 16:34:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
 <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/trace: Initialize cxl_poison region name to NULL
Message-ID: <20240314163452.1ec5f30f@gandalf.local.home>
In-Reply-To: <ZfNZIlWumlLyWcjE@aschofie-mobl2>
References: <20240314044301.2108650-1-alison.schofield@intel.com>
	<65f3016b8b0d9_1fe3d329441@iweiny-mobl.notmuch>
	<ZfMuDlDbVHtlAL8z@aschofie-mobl2>
	<20240314144405.2ae1d16a@gandalf.local.home>
	<ZfNZIlWumlLyWcjE@aschofie-mobl2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 13:08:02 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> > Which doesn't make sense. What you want is:
> > 
> > 	__string(region, region ? dev_name(&region->dev) : NULL)  
> 
> Compiler didn't like that NULL. 
>  warning: argument 1 null where non-null expected [-Wnonnull]
>    50 |                     strlen((src) ? (const char *)(src) : "(null)") + 1)
> 
> Compiler was fine with, and it works with ""

So the above should have been:

	strlen((region ? dev_name(&dev->dev) : NULL) ? (const char *)(region ? dev_name(&dev->dev) : NULL) : "(null)") + 1

And the compiler didn't like that?

What compiler are you using? Clang? I believe the above is valid, and
shouldn't give a warning, as how does NULL get returned unless the compiler
got confused.

> 
> > 
> > and then you can add the __assign_str(region, NULL) to the else path.  
> The compiler was fine w NULL here but gave me garbage in the output when
> region was NULL. "" worked.
> 
> I'm posting a v2 that functions. Please take another look.

I will.

-- Steve

