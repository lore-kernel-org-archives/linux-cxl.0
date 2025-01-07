Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B5189F57
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269036; cv=none; b=bM1tEQzWuWHn+CEI0fbwCVtc0gv/aeJ7IFctkBh10+zumpCz+9EH+tHjIzEQORP6jfdSHs2eMIyHCm2EPjU6kBNdL9gxnaWlZ6Nt5eFxltCOWHUHI8mqrFqzHbKF4JKL0avlRbS+gZHAYxjinY5r2D7bZAzK+wMW5cGeERn/qk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269036; c=relaxed/simple;
	bh=EZ0xTPwErZM31eXzmu3co6GihuExPFcC28LkwkhVQBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpzlHXWg1Pp5S3/sT7TKQjlc2rSspPIqiD8czsIHxF31GJ56p2uckvESI6EO6M0WqvtqJ4+NycJftbw3EHlfgoZvHLurCDWOrZkWN9GZkgYqwZsPlZS+K2A4v/XhPSxa4fJgt9NJof8QX+B/q2B7k+xOyYRHqHfkv4CEZzM28ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Qhhdd7wA; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Qhhdd7wA"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467b086e0easo80341481cf.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 08:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736269032; x=1736873832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=prJc6J80vM0hXzE72AeZo5gS/5TjG7+GIkTH6dDxyUk=;
        b=Qhhdd7wAARYDzQqbCcRpd20pUXbPD3uzwSuqbIiPaSI/qF0WZtdLOK2yyKAXZ5f4Ee
         i0O8r4VlJ80o4wzZ4ydIJjnncjyHxZqcOvP9OnAU+LscChUj7Qj5UeCkMVsz95BXtyu7
         +TxzgKYm7HFubScU7TAQAh6YKM0dMETlnhENxGKclBXvReui0AsdJfCPsuBYwn2bjgAR
         f+7WiV2Sb9VhgAU1Go22mLUehxld/7gEFrr2doY7/bSLiVyWcvgMjPlSwvV/gJEWcOab
         A0OPEw5avPsGEzZk0v17BJEWwVg4yWJ0m8AjvpSMTOWXW9rXfsnCT2QqvCNiyl3M2QLk
         zwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736269032; x=1736873832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prJc6J80vM0hXzE72AeZo5gS/5TjG7+GIkTH6dDxyUk=;
        b=CWHEHV6QiIWJEhOw/E3PuKqyQuO0GyZYc07jjFsoYgab/00FqbRZ+S9ZziYZASYpir
         A8VMH48MJyNOFY+3KsThMzqDw8xpD45fR2yjfXcI8f6Tplgl1LDCm08sircRsws22Xv6
         LytonILassJm1d6dlZJbc8QoV+e/rxyzabCcPTgGSIalqSYnpgiblWp+++CpAh/GF3AO
         UrqYsN7ES9fBhSdwgWUa1c4k1nIvWs+k5sR/bbQ+QVXROluuFeNjCEGhGdxlT3jFJjb2
         3HsjU6Sd1HuKDwiusf7/DgCb+VyJxMR78zSCHW2QumLP3zWpydtI+DeDu2XhCeQ+z5U0
         HvQA==
X-Forwarded-Encrypted: i=1; AJvYcCVxW9cUvu3Wf+0hZ95fdcQ3QjG77IZ340uYR9/fPMmzA+S8Z9JpT7aQOmQRZyzbynhYaO8n6FkQaOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuF7Nc6C2BaCjJS+jk0WUGOmwEGkSpOQ1o3Ey/x6EEGko3qPa1
	GDf700TyW1PIoTgJQUQidpz3Qe9WXy0SMMspfmnKsn5qIkl0zdy5H8vZPh2vqzo=
X-Gm-Gg: ASbGncvswmPpBJB7Jw8emyDqAFHhE1+2fxLPfTERuLDkv1+zgXywA0ZoHupOv63Gi9U
	CAAiS1sueZHqNIgbY5Gt7T33oeDfRs8wT8jWSnkKzUkXy7roC0Wfeytz3rS/qn1PPaabwpjSoJe
	56G+TrM9WsN1aG15zDG+3srSF5eLomEmXJw/FRQibiOzYtkxUSN8CAXe38duMd8FPdoLQ7lW4qb
	zS0I4w40Zd3qKLwKEdTb9qmtfDgQfOjAmA3HCsuz5gRvVd8oPxv4Wv8O8X8pwXAmlu0TfM4weuN
	UmxRI+nNOq0N7vHMdm8UprzXuHRLFvirKga+gUc=
X-Google-Smtp-Source: AGHT+IF3risnApxZ7Aqw/S5XLX7v+4Bv1R7ttaFTwQXzm0iH8UjfbXLcxMIC+GxXc0kMcv6uMtH89Q==
X-Received: by 2002:ac8:5981:0:b0:467:5016:57fa with SMTP id d75a77b69052e-46a4a988dd7mr1008159001cf.44.1736269032685;
        Tue, 07 Jan 2025 08:57:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e64cf0fsm187087691cf.18.2025.01.07.08.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:57:12 -0800 (PST)
Date: Tue, 7 Jan 2025 11:57:10 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 06/29] cxl/region: Factor out code to find the root
 decoder
Message-ID: <Z31c5pekQ3_1JY3G@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-7-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-7-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:09:52PM +0100, Robert Richter wrote:
> In function cxl_add_to_region() there is code to determine the root
> decoder associated to an endpoint decoder. Factor out that code for
> later reuse. This also simplifies the function cxl_add_to_region() as
> the change reduces its size and the number of used variables.
> 
> The reference of cxlrd_dev can be freed earlier. Since the root
> decoder exists as long as the root port exists and the endpoint
> already holds a reference to the root port, this additional reference
> is not needed. Though it looks obvious to use __free() for the
> reference of cxlrd_dev here too, this is done in a later rework. So
> just move the code.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 18 deletions(-)
> 

Reviewed-by: Gregory Price <gourry@gourry.net>

