Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1923266580
	for <linux-cxl@vger.kernel.org>; Wed, 25 Jun 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864841; cv=none; b=tKrsW3T/esep1LgFk6NkZT8bmB0t4brOS2NXQRgPGbtNwIVFN+AsO9UQmBdzOOL4IcoFHBNmQdExl0INbvb5WwQ3wyHy+gZW+KLYHNSu9Yp2zrgsvdAgNRdCScpEQfIsqOrjOQDaOYpgGWm/AebnFOiL3eDC1qq8vXesYhBmWKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864841; c=relaxed/simple;
	bh=I3VMeM3ROOebuGmLfBamVIQdry0me/Db5bPJT6IVBiU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJd5ExCwuxkhfIn+UP9hF5MrPoD2N8z3BwT7LsDZEd65IqECWkh09X2WUV8rPyr26b1DKzPrlwmk9yIkr2LKyZDTb8ZYLg1ZQOy13oOWrb3JOwOFtKON7ilW98E8P2GQiERMQY2J2MOahOMLCJbSpHe3dgJP/26piwccl1+k/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y0IWnLvX; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0IWnLvX"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-735b2699d5dso4261551a34.0
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jun 2025 08:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750864838; x=1751469638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N8J0ohQkucXBpYPSUPUSvYWk0PHTE1+Gl4bdfegEge0=;
        b=Y0IWnLvXsc3fEcGsQFavcKXEFpMdeXANtpCDE4i6UnW/kwQHGCVVi1o2YKuJF/Q8U9
         EMo06gzMVI/LrvQpjflqBfjAHTek6qWhOmYrHrEwcFCR1j96hbbiNbxCB6hNVXx3UEZp
         lnLXEe/BmJFvRmfqf/wf/pzYcYDCCWJXRU2Cppf7dbn1/Y/H1MQWBkeu8GzfcJuhSZ7I
         IZ8pU+yOtFEBPmJtOUTNKw3gC54Fyf+1SrWXB4GHkPYl61RQSwSfNezKw38j+pvJxA5e
         3Faitaxz9FYuOTRpfHg+q2AcjaCgGit/XdL9cxxNiqk7QzKGLZr/Iq/cI8vS1j8TFRKj
         2/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864838; x=1751469638;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8J0ohQkucXBpYPSUPUSvYWk0PHTE1+Gl4bdfegEge0=;
        b=L5Dog1B2BQplyi7PTnSUTEk/t0wm7PpjBZ2Ku6eVdNMwAiLTusPPQcG1SGi41nj+VP
         eE6w+jEGFg+KE2PL5HCOAx5MQb17URy9N247R+YUnlWiPgX6btX+aroU7qKDUm1X82Yv
         IPyw1ESlfC2DQMbHJ/sNd/rDi6ZiJob5liXPab4KOSY2v8LPXxV+zb9q/q1h3ryRGklx
         4nkutm0ndE9YBj3d1+P8Xs+mItOGMxBnCNRTyjk3L0IQZI7b3yD++5GzAa4YRGxIp/cB
         1HRZr2PgyzW4tCt2iOeaVp2QCoMGQ4mM2n6SbMzIVvVIjmqrXsKKp9UcP8xwhwxY59pz
         +mAg==
X-Forwarded-Encrypted: i=1; AJvYcCV4s6USd+zWp0+E7o8/VYHToKggiDDux5JWFLkItsy68bbfy7ifVYdUlTpHGJNFK+Adsif2fviLO6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPF+6kgDEe8Z7ADKzsd/gokB3grFHefVpFLw/mcD+sdJThIjPN
	YlaOKOp0Q7eZm8wFJtZCHAeohCNc3nKBG8uMVspLHcvKfJz4hq0amA8uj0IQa3nCJS8=
X-Gm-Gg: ASbGnctDxEPRCnmlhrAnMuPct0cbjNQZnvrs0UIyEjwjDcwY2G1CLvEpZh3JdD1qkJl
	zPGyC79Q/T4KmnEG4C5vqck9h9g7vkvG2FrHmI60ShlPlMx2SbhYL+xgushtOKl756IMB9fHul7
	I+zlmGe7q9NZd5USPGxT9JusMqMXBmpQ7IiIXaQpYbLlORaUH2tV8cJDCvOuW5GbxB93xl2lCQv
	51IQwOZ9Nq6EMKE0kDdsNQ2fbQpCLE0cqEnTLPe6lKTi2sH/mwzp1BfSxgSjpNdeYbDBl5K3Stv
	5UT5ZfUKadPU9TsAApCREsafvpizo7ucqXPrLJD4kvofDIwdDAn56W+hFDJCzzUVIiGyew==
X-Google-Smtp-Source: AGHT+IHN+Igzxn2usZkb70KRzmmATFBMBOaapKjVxLI0arjq0Ex2N8xDeTWjV+sIuuSwiIxu3jHu/g==
X-Received: by 2002:a05:6830:8419:b0:72a:47ec:12c6 with SMTP id 46e09a7af769-73adc5099e7mr1611593a34.2.1750864837773;
        Wed, 25 Jun 2025 08:20:37 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1fca:a60b:12ab:43a3])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73a90b337cfsm2275280a34.28.2025.06.25.08.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:20:37 -0700 (PDT)
Message-ID: <685c13c5.050a0220.38a39d.dcf8@mx.google.com>
X-Google-Original-Message-ID: <@sabinyo.mountain>
Date: Wed, 25 Jun 2025 10:20:36 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: gregkh@linuxfoundation.org, Benjamin.Cheatham@amd.com,
	Jonathan.Cameron@huawei.com, dakr@kernel.org,
	dan.j.williams@intel.com, linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	marc.herbert@linux.intel.com, rafael.j.wysocki@intel.com,
	rafael@kernel.org, sudeep.holla@arm.com,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] driver core: faux: fix Undefined Behavior in
 faux_device_destroy()
References: <2025061313-theater-surrender-944c@gregkh>
 <20250614105037.1441029-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614105037.1441029-1-ojeda@kernel.org>

On Sat, Jun 14, 2025 at 12:50:37PM +0200, Miguel Ojeda wrote:
> On Fri, 13 Jun 2025 20:33:42 -0400 Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Great writeup, but as Miguel says, this isn't needed at all, the kernel
> > relies on the compiler to be sane :)
> 
> We may still want to clean them up, e.g. for tooling -- Kees/Dan: do we?
> e.g. I see a similar case with discussion at:
> 
>     https://lore.kernel.org/lkml/3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de/
> 
> Which in the end was picked up as commit 2df2c0caaecf ("fbdev: au1100fb:
> Move a variable assignment behind a null pointer check").

Putting the declarations at the top was always just a style preference.
Putting declarations at the top causes issues for __cleanup magic and
also bcachefs puts the declarations where ever it wants, but otherwise
people generally still put the declarations at the stop.

regards,
dan carpenter

