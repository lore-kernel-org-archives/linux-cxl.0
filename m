Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B4E2641C3
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080602; cv=none; b=ldE0kadZEgFJer+Smz9VUsrkSfRo8VV301i34aZN3XxWqdaj4HyXxoNm6kQjD7mPm3Vz5UAj8tSGR/JX4OfNQ1bYwXb7V2gQ2cc0xbBK65kOZDrC1O3Z8r1yqP7ErDaF6PNhw3TwmGFagvSMq/CLqNpE96MSsUwyPNe/R9m4b6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080602; c=relaxed/simple;
	bh=CQZh1hGW51X6+MKJqFHzqzZmBj8e2sGYeqjGA0wC2r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQ/Nm2M7hHSUx3peDm3Ls3Xq/l/NmT6/9glzI0/vaYS4Hu1eyKRlTmVLCZg7mZcBfO5uDi9sYqJnv2+jpRr9R45gerb40rXFL+mGrmHBpUG41T0o05/eYzKGp0Zez1drD+I/4S0Jn6etay/A+nI5q9LXsKFT7PsNeL6b6HbBE7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LthYqdyv; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LthYqdyv"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7be8efa231aso137744785a.2
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 11:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740080597; x=1740685397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BKXoW+AQZeUkigvC87NIB17R97sV2qU5a0HdEFayysQ=;
        b=LthYqdyv5NLj2SUCk5xSMEvDAeaRlAxaEMLHex+C3XnL4jnOovKcVFcUgt2Nj93JrV
         yKdDHNBx0ayUpACMDeGXhbrQoB+eMpEM/rivGVZ7Cn15NNJEM7umkoa1q6YzKUP4HGLT
         9uEHfOeoRb4p0z1W5yusU1fSeM+4k1/N2eLMi/6SnXbXvH7lC6dU2gb9vitHDWF23X41
         FC4WHPcEqOVTafL6oqJjKkxGtyH4JPKmNty4BcW9xXYzVSGM61XtDBQ5DIh4oRWP/eW0
         O32axZNWFGS0ryMgTD3TJ4sp4T4xE7sMLoJyns8nRa6CkOQA9DXDKKt7i/KB6X3E3leE
         7daA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740080597; x=1740685397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKXoW+AQZeUkigvC87NIB17R97sV2qU5a0HdEFayysQ=;
        b=k+pXviPOVo/Sx48uEN2FPke/QrL804/IVN5I9gqH7B5v7NnGipYmCmc55iIw1grwT4
         9BqwaHcBn10lfnC++EH0p9zuEYl/mo3CQBJUOGjhkAqudNKBImwOHDG0lrToDjf9kkn0
         69wYVSFz3BiQ50bO2o0QvbxzY9wsXDUWAGYG7wMSMMJpLjyU4Z8szPhpvOljJwYbU6FS
         kHUPg9rBWTFz0vL3VY9YO5bmPzIM/85ruIBI4k2qltoYF8KTovahcK0RjjVphRKWSyeD
         FYANpi1jI6bJVa3i2j0tuQDDq3XLMeKICPWquPxio7q1Wfuqd+Pk5QZDr0RY5aP0kP2U
         Ugfg==
X-Forwarded-Encrypted: i=1; AJvYcCV5WjPTnHkbvNP4+0vtMObplh4nyjbmeVtLBSK1hpLIpwLvAa8qW0g8DhZE/F6o9UrT6xgTJUJIWLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKrv+azmskR9SvbVB931vwwRGfkF1F0d/DS+xqVD0LqCdNzgqw
	xhMqftamyZv6nAa0FStLBTfDdsRBVe7wu1ClbptPt/O4fvET1MrkOPXdIU3e0/Y=
X-Gm-Gg: ASbGncsd6Bn15FWWkynuwGce/SSZyWV4IrPXcuAt64nZHh+04pRRTHhc1Fjy/PkeMOp
	DbN3kA2AvXWV6vsrVP0HMTOfHWqStl1h+eqmAQs/5r/cRnnoQ6j6p48L93jn7HyOonGmK+iXzqY
	2NGiHruXgJLJWUMFrNXLIhYuCQMhNAaF7yG+y/Wg0/Zi8rKRO9Ezjx/eAocimWlcU1oYlgz68V2
	X74r6fMXolmDY16E8SAtkl050SSJ4hF7QOYXOqttsKDvk14FbiL0y/+eQHMHM5IZqv143V9VHK2
	B4KjamFF4GgttzqIdgsnXnNhFkRdQMGlybp1qBGwqnDMq03zZwWkNrBqwMzCJ/NBJgdp9Q7WSQ=
	=
X-Google-Smtp-Source: AGHT+IFkRBvFtjCgVNrmnWtpZGK+MU4yinBj+hI3wWaAiYndlO+MZu3xzUHT50RI7AcRiLnUL0Ns2A==
X-Received: by 2002:a05:620a:2495:b0:7c0:a16e:e83f with SMTP id af79cd13be357-7c0cf96f05bmr2517685a.52.1740080597543;
        Thu, 20 Feb 2025 11:43:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b2bb3d00sm289265585a.17.2025.02.20.11.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:43:17 -0800 (PST)
Date: Thu, 20 Feb 2025 14:43:15 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 10/15] cxl/region: Use root decoders interleaving
 parameters to create a region
Message-ID: <Z7eF04PLfr5rhiLT@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-11-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-11-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:51PM +0100, Robert Richter wrote:
... snip ...
>  static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> -			     int *pos, int *ways)
> +			     int *pos, int *ways, int *granularity)

Function name starting to diverge from functionality

find_interleave_config() ?

~Gregory
