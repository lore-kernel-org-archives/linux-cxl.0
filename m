Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2B1CD1ED
	for <linux-cxl@vger.kernel.org>; Mon, 25 Nov 2024 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574150; cv=none; b=dbBCFYw2J94sJwrY/xQ4ACOWKL0GqaRlTEsQ1thj7+eBXv1slWXCg4amkwjSh7jLQ35lwHGqlBiOz0Z68oY6PBtQeIg3hQCKhQXrd4nVazS3gg+WoSuJUaYeR90eZVfhQL1fe/9zAh+uicOPCiZJjIOMjBQTgLGRinjkOV8RQsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574150; c=relaxed/simple;
	bh=3rZk83BFapNTYSBmR45Ri1F6BV2vIxTmxP9C/qJIk3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBkWE5BUc2AJ/K7/s0rykuVfxqoLWKMVI8BYIFAB5xrfncRT81O+oXMjcRFDOfyF9szoC0TZLb2mj+YnRnwuHhOQ6RAr1AMHm0aWgCiRFxHIg4yE8bV9YCWXS3TDF1Q8VpCH0tsKFG51uhdp1VJahDQVbZQITHEU7SC1qr7QWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bmy3a9g7; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bmy3a9g7"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46695478d03so9523911cf.1
        for <linux-cxl@vger.kernel.org>; Mon, 25 Nov 2024 14:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1732574147; x=1733178947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F0LEVVmh09qWTmRbUUXnS8M397YMXluTgjzA1Orh4xQ=;
        b=bmy3a9g7l3vx+n5XzpfPuVURidiAr7SCb3Jx2iua8cP1S26eoskIAzODwCqpCRK2lq
         6H1eTsN6vMhDzv1OeqLP8Pe3mOYDtVcX2lkqMoLYOsamRlZLR798a03Pu9pH+7ToZB7R
         BckPEXjV//WboJlMAzxycaHzdU6olamSGgaPEviGzqybS9tPcFNs+F8X5HIyQhoCrHc0
         sUJe6XNMKtANmIIXdzKSIqYlOoV92qpBnMshjcbV7qTECR1a1bXWEmp1SnbziviQbYsa
         HAOee697Itt7oe25TPx9rqync05qV9+IMX8zpJhdZpilNGcQ8VO+sJVRYmHesxvSC10S
         66DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732574147; x=1733178947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0LEVVmh09qWTmRbUUXnS8M397YMXluTgjzA1Orh4xQ=;
        b=gpyuWbwPoFrvqViJsAul9WJEwIGnAr8AnjLNhKYFauwWhsaIaAMvTwlTP2YTiA0dk0
         JSEdPPYtW/YBm63Yt5RWmdhDMLDVnuuC6a8/BynOL4lbAd8TiHM2m/orARmWwxqU4xbc
         wQftf6AZGKvI0h/06gfHhCyWogYluNDYP2sPEwTh9/uHiC+symFprr7AsfjJeurZgAfq
         PbtHIEo9xHEm9WGkdV+tqqyi1/gfPUWXR7Kp4myRv0TiLbVU5amZyqPxsSlRnA6PXqw/
         te0DUR4g+3MuROicJ1cseBNe5w2swILropqkjHKqP+uG6GB12iMrQbk2IYgZsxUakJhn
         whzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzyRs0a1THkTdgy3bkKm5N1cOzDLDhncrert/V0sh44cj7HHXHyzDO1h/3dTccCaQSNIgBm2v+QP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0YRx1xybczNpXajitubrPpVfWqUEGJdTmP3su/ubzKMMLNgu3
	QtxLDF8oVmF93xNIV1exVt3RxcQUJvaBejad2yGYz91lJXtbt1Ww0Rn2PmAlx+0=
X-Gm-Gg: ASbGncuF10Sssq8DuY0duMyPck5xMBDC4flVVtjK2NxyawGovNN3hR0zEZBxyiCqIZX
	FOlXDFPmUbayiZWKu7qPzQM77C3y73Z2y0l3pMyccsZu6Bc4vh7pp9zstqJpxv9106cO2d+G1av
	y5FHOgsAi76VvrQK9xZ1jrDiH4QWyLj+mujBdt2AheKy9je1AaqopVtLbEuIUkt8P7ljvO9UGjq
	HHhueUpzFniA8TW2A8jdPXUKzCYV+ovqNiGVDWMBtq5RJsNTf7EbVysG6yUvZ++qWK4IBdp9V5B
	/ZLmHH6DmSkcB2WtKYxUdfEPU5bfj6uupqo=
X-Google-Smtp-Source: AGHT+IH7fIwbkI4uH8JkSw8OIkc51k/5IJgozs97dQO+2GrBwa44CknCf+8EgNq+gOdx+sWFIvRlIQ==
X-Received: by 2002:a05:622a:1917:b0:461:1361:eb14 with SMTP id d75a77b69052e-4653d5225demr239121711cf.2.1732574147447;
        Mon, 25 Nov 2024 14:35:47 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466a47fa3f8sm2743791cf.69.2024.11.25.14.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:35:46 -0800 (PST)
Date: Mon, 25 Nov 2024 17:35:31 -0500
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, kernel-team@meta.com,
	Jonathan.Cameron@huawei.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, david@redhat.com, osalvador@suse.de,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	rppt@kernel.org
Subject: Re: [PATCH v6 2/3] x86: probe memory block size advisement value
 during mm init
Message-ID: <Z0T7s7_j0_FCtihr@PC2K9PVX.TheFacebook.com>
References: <20241106155847.7985-1-gourry@gourry.net>
 <20241106155847.7985-3-gourry@gourry.net>
 <6733c9d135589_10bc6294b6@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6733c9d135589_10bc6294b6@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Nov 12, 2024 at 01:34:09PM -0800, Dan Williams wrote:
> Gregory Price wrote:
> > Systems with hotplug may provide an advisement value on what the
> > memblock size should be.  Probe this value when the rest of the
> > configuration values are considered.
> > 
> > The new heuristic is as follows
> > 
> > 1) set_memory_block_size_order value if already set (cmdline param)
> > 2) minimum block size if memory is less than large block limit
> > 3) if no hotplug advice: Max block size if system is bare-metal,
> >    otherwise use end of memory alignment.
> > 4) if hotplug advice: lesser of advice and end of memory alignment.
> 
> This seems like documentation that also belongs in-line in the code.

It actually is, just ahead of every check instead of in a numbered list :P

~Gregory
