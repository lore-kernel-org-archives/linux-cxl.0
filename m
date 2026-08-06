Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A80499F0A
	for <linux-cxl@vger.kernel.org>; Thu,  6 Aug 2026 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054279; cv=none; b=Rn1U64I5p2Ns6U+96tw9e9JOLA+qEfQ4LY7/YwZWqTHR9p290E4tdgY8oQ8b3p6j52YyBZM1XjXkBk6v3At0umjjudqbI5nKVl3ANAWHy5QV0kkoP35n6rUiNa1tMH+TuslrBCjJdjILXKfvR0Ga8a1Vjh4orVx64NBu4B9tURY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054279; c=relaxed/simple;
	bh=vBSwfYpDDTgwd6+GO3iIxrzRGWg53xkqWYgOrms10+k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZ9zjwNrQoSA4CDwWa30XZ5yCWREc0y0UIIXpwRUzwOGZpxseSbMv+m2YrJFyq2a2H5RYJvAFUMlJLM/CUGNxjsPAs4wtoakotxGth2tU9BIdYNb6sYq3cA0zSH6cteE2nUiR+N4Gf3k4fU+bLkiHZutYE42TXJ/3Xa43lECOEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwEbyGLh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwEbyGLh"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d02b4c3601so31355085ad.3
        for <linux-cxl@vger.kernel.org>; Thu, 06 Aug 2026 15:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786054277; x=1786659077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Taune2r+NXfjBAxg07RGJytisNNYjB7FbzdhiuVu+8c=;
        b=gwEbyGLhvDxx2sQ6gk6W3jd106IGtrhbucAOuzqfih4OLlHJmyjVdMF7JVQS5HI2hM
         zPg9RUcRPruza9+aAh1bW+CJsd2a54x9LYhbLTN2UBJb9jDKYnFIeEq0x+1V+GaTzxTl
         GuiQfYqhxAslL3K9CvSzYbTGM/akyrBCeRAnndNrT/SmH47gTIYjD3CHd++9qOrfg3Fq
         qiVb8hNPynnwNJBPeddlXcU7cEu8wZsLCG9oNWutOlRJsIE6QyryJD5PpPlh2CnBr+tw
         rIDJenLVFvN4KYhMQ0Zpz0DCPeNzdDAcOBLn6qL0CRvopH0uNOqAkd/KUyDdtcursv5n
         rKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786054277; x=1786659077;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Taune2r+NXfjBAxg07RGJytisNNYjB7FbzdhiuVu+8c=;
        b=kngpyYNtQhU4XoKQMCkNEjB8NoeKcOM9/BWzMYMN29o6kDsE0GlH3k7qZtNN0ys2Wq
         G3d0hrh0oz2cyeJF5bOEN8L3cvxzf7dn4SYXuKSighwMBrb0u84uy3qgJj08JIai84kF
         ecYGSdW9J+UhMgzEOQ9YIuvI7Z1ep9jxS7aXCroNlZ/5C2ZXnH/ro8udm1elov2AZuS2
         BkxiMo8yj5eGWSFvgx3LyVCpzUnsjObLa+0EfnQbhh2NfkS0424iXJkBEcE/t00FkMnm
         gvb2pwZA22b6Yu1Pg9ri/+pyVTBtuijHh/Jo53Qju0dWAG9fHIhlds7j5OC6pfjDnOhx
         CEVQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro5EYjhKaYGKAusGUJ6/UeBKpfjtAU37bIDj+48jrdIeairwRwoPAxEOWgFL+CykhN4n4Q3Z6JSGKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSwSJzkrXYd6c9Ixro8TcTWRTDqnYiMmuwUmt+n/2JD5VDFCFA
	4JVkuIpO1VwfeT5c7yi0ZwrqjPMwahepi88ExcHk/RxjZzeH5Hkib1OT
X-Gm-Gg: AR+sD11h41/pKUfpAHs/jjNWZQxMgBjn7mfkwC3qCusL6uYc1xdH4Dx9QybYeggRDYb
	oKTmnWoiRNqUDzLHswv66efyOMLsbzxzCiqd91+JPX6bJcQkAmj4RLBLK1R3E43mMFgl1afmkgU
	Q8xjSmDnGpzKHVGvj6kR/k/IusuI6/ctfe1tmtY6YI+dPvJOPfmymCZaA+i7N31JmhT2xbN72Wh
	Wk+FPRvVCXj5+jF5AWj6oqkEq2nRHbymWBtNQ1luKuqtsamHKHov4sHFLNUJYaWlgdLP85U3aSq
	bt790WN57ZFB0rZLEU5Z0BRrV3qXEBscjXSRp5e+FFVzJH2dmU1BJxZh9Kt+9nCzD0tYIQ0+d6o
	HV6Tk4Ull5jhNLsdHmURl5kXEYO0s7NIdes70TvptCbx3ylfkKi/z2DnS2JeqR862oCZW1K6lgX
	TsXxGLE1IoCFgJNoGF20aW+I9wjyqjjtZdDEAC91JcrVnunZIcVMEHz+xK
X-Received: by 2002:a17:903:2288:b0:2c6:8d95:fd6d with SMTP id d9443c01a7336-2d0ca98f8a1mr179206395ad.21.1786054276584;
        Thu, 06 Aug 2026 15:11:16 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14dbeaa95sm511055ad.38.2026.08.06.15.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 15:11:16 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 7 Aug 2026 07:11:42 +0900
To: Alison Schofield <alison.schofield@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v12 6/8] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <anUGnhq094ykZM1a@cxlqual>
References: <20260731084901.1512819-1-anisa.su@samsung.com>
 <20260731084901.1512819-7-anisa.su@samsung.com>
 <anEzpWk5jRdwMwvt@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anEzpWk5jRdwMwvt@aschofie-mobl2.lan>

On Mon, Aug 03, 2026 at 05:34:45PM -0700, Alison Schofield wrote:
> On Fri, Jul 31, 2026 at 01:48:11AM -0700, Anisa Su wrote:
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Dynamic Capacity Devices (DCD) support extent change notifications
> > through the event log mechanism.  The interrupt mailbox commands were
> > extended in CXL 3.1 to support these notifications.  Firmware can't
> > configure DCD events to be FW controlled but can retain control of
> > memory events.
> > 
> > Configure DCD event log interrupts on devices supporting dynamic
> > capacity.  Disable DCD if interrupts are not supported.
> > 
> > Care is taken to preserve the interrupt policy set by the FW if FW first
> > has been selected by the BIOS.
> 
> Hi Anisa,
> 
> I gave one comment in response to a Sashiko comment, wrt 'drain'.
> Another below-
> 
> 
> > +
> > +	/*
> > +	 * A CXL 3.0+ device can carry dcd_settings field without DCD command
> > +	 * support, so size the request by the device's policy_size and only
> > +	 * enable the DCD interrupt when DCD commands are supported.
> > +	 */
> > +	if (cxl_dcd_supported(mds))
> > +		policy->dcd_settings = CXL_INT_MSI_MSIX;
> >  
> >  	mbox_cmd = (struct cxl_mbox_cmd) {
> >  		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
> >  		.payload_in = policy,
> > -		.size_in = sizeof(*policy),
> > +		.size_in = policy_size,
> >  	};
> 
> Can you help me understand what happens if policy_size is only 4 bytes.
> dcd_settings is never sent in the Set command. How do we know cxl_irqsetup()
> isn't using a value the device never accepted?
> 
Hmmm... good catch. If a non spec-compliant device reports support for all four 48h commands in the
CEL but simultaneously reports a 4 byte policy_size, the device will never see
policy->dcd_settings. Then the re-read at the end of cxl_event_config_msgnums()
doesn't erase the value that was never really set on the device:

	/* Retrieve final interrupt settings */
	return cxl_event_get_int_policy(mds, policy, NULL);


^ reads into the same struct, the device returns 4 bytes again, and byte 5
keeps the value the driver just wrote. So "final interrupt settings" is
the driver's own value round-tripping back for that field, and
cxl_irqsetup() arms the DCD interrupt from it.

A spec-compliant device can't trigger this, since cxl_dcd_supported() requires all
four 48h commands in the CEL, DCD is CXL 3.x, and a 3.x Get Event
Interrupt Policy returns the 5 byte policy including dcd_settings. But to
enforce it explicitly in the driver, added the check below in cxl_event_config(),
before cxl_event_config_msgnums():

	/*
	 * dcd_settings cannot be sent to a device whose policy is too short
	 * to hold it, so the device would never accept the setting
	 * cxl_irqsetup() arms the DCD interrupt with.
	 */
	if (cxl_dcd_supported(mds) && policy_size < sizeof(policy)) {
		dev_warn(mds->cxlds.dev,
			 "DCD supported but interrupt policy is only %zu bytes\n",
			 policy_size);
		cxl_disable_dcd(mds);
	}

Disabling DCD makes cxl_dcd_supported() false, so the Set stops setting
dcd_settings and cxl_irqsetup() skips the DCD interrupt.

Thanks,
Anisa

> 
> >  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> > @@ -596,7 +635,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
> >  	}
> >  
> >  	/* Retrieve final interrupt settings */
> > -	return cxl_event_get_int_policy(mds, policy);
> > +	return cxl_event_get_int_policy(mds, policy, NULL);
> >  }
> 
> snip
> 
