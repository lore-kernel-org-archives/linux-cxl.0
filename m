Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5120A219CAA
	for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191377; cv=none; b=sNvtkpt30YENSUvwnFl+lWeLpaxzpbEs0HVRE4VUgFdnHUUc2ofX9NFDc6Tw2oO0aOFOlWcarmlhFzfCMpgNdqv4YXgpsPTUc7FEUlnA6al7YeZK3EALRR3YQeuXGDCVZZ2zVWVX/7tC+qNOwdje5GDdBzuKpuMKYorFPnjhKLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191377; c=relaxed/simple;
	bh=Loti1Hvz7qVSk+iC9qLqIVLr6ZNF5kZ8GfmpOU5irpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5mcdr0duKcyUC687xvW4wpOop7T3oTu9orycKuRZPUkFbfVCUQbjw1HrLVkKsQfTMbIC4IljZ5ZXwEyCIC8PjbUyLFtgSIMTQGB2MBb0CXlGssik1/VspHj3whXCMCAH2YVVL6dxm30qRQ4QFK5SpB3fs8fBvCk9XY0AyKQyko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W/kHOsj2; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/kHOsj2"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e1543ab8so2333915e87.2
        for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729191373; x=1729796173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rby35R2BKR9FUKRORyf8PZb8lK2u5GPS+7RtwehrxOI=;
        b=W/kHOsj2OYV9ClshHcco+hztTSbxjJmGNpYI3VXt6Us7dFKBgzk1BF3b4rw3gRH2UX
         zwm+A463qQ46zkTXVvmrWAfKn0Lkj+mogBxVAxqUdAy5MCjA5DjDgATrEBzS71dpWEqK
         QwV891rdaMefBHcBWDMa3sa8vAew3hWyzzAakZekZYw4qNK+I7rOlwUfl8VlG6n9YugD
         11rmdPYmOw+dP4fSf0JNBJ617qAut6wmf/e52ndHgfYr99Jj3Rnm4POITX9ogzieIxUK
         94hHh+BlsZNhXnn3Vbd+K9dqYAI0Bb1MHU0galesTeCxoCDxNJDU5fQ8UWFjs6wAREhT
         8z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191373; x=1729796173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rby35R2BKR9FUKRORyf8PZb8lK2u5GPS+7RtwehrxOI=;
        b=atol2jd1L5UcckmragHrKqbpi/DZW7OerFPyvaNFPFx0QVGDCsW/al1MJjNYNntVAw
         R47cuDK1LGXfvVZFubqbrJ31xAK7uvgtRtQWoEqWYHk9HNVzej/9rbW9g5rkeC8WdTNx
         7m32bOntlCwAT4YTqplFRPT+/C9esjSz0ZAMXHmmrdvSk6Zq08mPEQayaTMl5+9RvxlV
         OXcEnBI2sK9K5zNuW+AANVc9YYwoCwWMtM7+KNx9lZOkGPzeW88t1zEN6G+jv9B3qiqE
         lb5BTkN2q8mJVE0kejcMe4UczjGsDtebelsgfmlzwAYZCo+DnPjpE4bWXQ+g0SuJqRWX
         qZlw==
X-Forwarded-Encrypted: i=1; AJvYcCWaHqM+Cli+068zF5lLg8M3gBUxL5l9WAYAghIpQK0Fsa9iWa2kmMuuV3+EoPChgiSaa8esjI9CLOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUjHAYgAXplM8HyxlnVecUdcDPUwuRN4mnC6105ecUEijSyzG9
	iXzxSUMjv0ISU/6DXIxU9PHUWS18Lx6G73lwAxKn1TMMwGfGUIqfLbrzP5jy3CM=
X-Google-Smtp-Source: AGHT+IHE2YjxYtNXR5TxxwEX3t4VPPYn2PyRr42rlo+cwnWLBEZAn5ZYANeIupJQtfX7dMZKtlmZVA==
X-Received: by 2002:a05:6512:33cd:b0:538:96ce:f2ed with SMTP id 2adb3069b0e04-539e54d7759mr14527836e87.10.1729191373243;
        Thu, 17 Oct 2024 11:56:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68ae635csm537066b.71.2024.10.17.11.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 11:56:12 -0700 (PDT)
Date: Thu, 17 Oct 2024 21:56:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Li Ming <ming4.li@intel.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [bug report] cxl/port: Use scoped_guard()/guard() to drop
 device_lock() for cxl_port
Message-ID: <cdfad544-8c6c-46c2-b390-cc97b0113c8e@stanley.mountain>
References: <2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain>
 <671044082f7de_3ee22945a@dwillia2-xfh.jf.intel.com.notmuch>
 <20241017160445.00005c50@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017160445.00005c50@Huawei.com>

On Thu, Oct 17, 2024 at 04:04:45PM +0100, Jonathan Cameron wrote:
> > >     1582                 port = find_cxl_port_at(parent_port, dport_dev, &dport);
> > >     1583                 if (!port) {
> > >     1584                         component_reg_phys = find_component_registers(uport_dev);
> > >     1585                         port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> 
> > >     1586                                                  component_reg_phys, parent_dport);
> > > 
> > > This port from devm_cxl_add_port() needs to be undone.  
> 
> devm cleanup should sweep that up if we suceed here but fail on one of the remaining calls.
> 
> > 
> > I also think the bug originates in:
> > 
> > dd2617ebd2a6 cxl/port: Use __free() to drop put_device() for cxl_port
> > 
> > ...where the wrong port is cleaned up, but I want to revert the
> > scoped_guard() conversion first to make that cleanup easier.
> > 
> > In general for CXL I want to say that no function should be converted to
> > use cleanup helpers unless all gotos are removed at once, and if the
> > conversion needs to reach for scoped_guard() reconsider even attempting
> > the conversion. I.e. scoped_guard() is a leading indicator for needing
> > code refactoring.
> 
> I don't think it's a bug and ultimately Dan C didn't say it was.

To be honest, I thought it was a bug because I didn't notice it was devm_.
It's so ugly.

> It's ugly but a simpler path to resolve it logically is to
> stop using the variable port for two purposes.

Yes.

regards,
dan carpenter

