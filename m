Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C31FCF41
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139519; cv=none; b=As8jVD/tNwH4JTdcC45ojB95ehhYgMJUEnyAcP9guPER5qZ9JF8i9VKrp6+6wu8ohtpocukMqz8qgpfyN+XnMmAPFnrbpFqeyybaBbYN/0jS4AFREr/NzS4Z68nP8YQgsP1An1scy3CZCbo92E5kB0FMcZEt/XMHfoQcrVvZZ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139519; c=relaxed/simple;
	bh=yfIfL+POLiJ30NxgYv7j+jnpGlALZIt6NFQ9Ps7CrdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUALzXjdiQd+Ux7/VBy1OdUutMSvSTGaWu9uyeJRmtwhS1bLKW26eSIZN8m9B833LyVKhbnAHTiNjP7U0tvE9Vo6Ir31jXIiMOTAwtUJANdfT69u8/LKbss8/I2j/rQ1tYb9AbjYI0DvblGiJqFHXTkzALj4XUnvB66DMaalxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EdPtg6/J; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EdPtg6/J"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b61161dd37so1456191cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 13:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758139516; x=1758744316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJOsiB1bpVW5O3ppXUgWRDtm86RikS6Y+yhj+zAkaVw=;
        b=EdPtg6/JwGcibacmGlPGIWO8PqDby/mP7FZRP+qXZinCUrheES/7Ju9XjJPZpUlJrz
         +yvvgv4bWR46xowVDM/QaAwqG/bFtSUuZ89h8kpEpHo/bkfbHHzwINYQLWy2MT0zSRdU
         7kUAoLc0c9hHav17qrZ7DkVWBtztfPA9CeOB8ESp3bwtOiBLZoPn7DnhDhmJXplmKgDo
         qQOi1JJ9ark9a9I83yYU0fSpvsSvvEHsUT8drOauet5vLeJutM4bQHp6h9ohrtOi+aN2
         9EUg8S8psjUbgq3qftIJ/TWV+J3KVyJlsFtcZLU74RM9+LqBdKU0oLfL/ydooPoczQR7
         A/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139516; x=1758744316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJOsiB1bpVW5O3ppXUgWRDtm86RikS6Y+yhj+zAkaVw=;
        b=Sbni8REp5LRpFEYgL8Ux3IAf8tVWIEvIa9/eVcdWILJdR+fMbUzvNSu7bhNS6LIkgv
         U4hgwYwUTUNtMkN2m4Bgpu//cDBybNsSOD2fnoT37dJ45hWJSAkEAbdw4Ms7n7YPHiAx
         bPx+6uPZ1F9YCDIDssDfgl0oCslDD4T7BEDqBw8iqEBRQJSd0rsBg3oRI8r6IRFS6Y6p
         SQUdwnKeKjFlnhzgGcpOyDFDGJTSzNjpWbt/6+sXLeY6v5zAk44KGRnikTrx86HNMadc
         8t/S/TksBbS1EYYfbcPJIfGUi0uvK/tPGkKBJh9kYVWrqxC9ZP3fovDeK4/+F0PN+Sjj
         W67Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgisd57ivJY5X1w//OJ2WyLLlR2fGIpUr5/bgjmQJV8XnWy2O+7bUGj+Fe3mEIFAW9rXw7x8DDLzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKM/I9R/xpJhfURfldGnulPuZLDeyCTqyu259+LipbRS8uZN/P
	Q3zJJ68ADPuqE8DaBRJnUJamipDXZofegEmyNUxrJLFsBQ7i7W5I4Ji3Ad8uKhRubDs=
X-Gm-Gg: ASbGncsQr6mIMq0qBrzbIsRRafIVPX6OGbQil9XQWbq1qNlsj09eb8Th2WtzstfhkgS
	AEGf4S7UxofuyJsQ+tqH9MdaQshj/jMrMOja/3TJQiySzTO5y1RCZQROroNw79hnSPs85HeYsES
	rWaZ4IgXMEWjRaESYhwjyTAZuXdtgqiLNHc1kCeGVovYBz00u6z4AreBwMzAQVl7I4v9x1pCM1l
	NG1QNoxvp9IJoJ11hOKTS3U3K7hWFGo/5DiLkANaqhph03AaA7JflYMv1dBjXksv1nplwpmeUd4
	+koZBMwi6lifKII8xFM4kedvEKX2NOrOQaK2tgj9NnDq0wF9oVpPMdMwIrSlW1XPcF3g/SQPZSP
	IdJk0vuBl15eP5PUabpu/DlCfefcxQfUFWQFd4nNmlx104/T8vX2o3BvTsM4415b4u0xDpMQ+44
	P6hoE=
X-Google-Smtp-Source: AGHT+IHkspUc1p8HZXKoRsdqMt3Uynx+jmY/D5qq0kQlFo+6agSywrHnZywaLkDz7glbxTmttKdAYQ==
X-Received: by 2002:a05:622a:580e:b0:4b7:7ed2:c3f0 with SMTP id d75a77b69052e-4ba66d141b2mr39682451cf.32.1758139516308;
        Wed, 17 Sep 2025 13:05:16 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda86b279fsm2914211cf.33.2025.09.17.13.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:05:15 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:05:13 -0400
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
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 04/11] cxl/region: Add @range argument to function
 cxl_find_root_decoder()
Message-ID: <aMsUeUME_6wkhfp1@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-5-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-5-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:06PM +0200, Robert Richter wrote:
> cxl_find_root_decoder() uses the endpoint decoder's HPA range to find
> the root decoder. This requires endpoints and root decoders to be in
> the same memory domain, which is not the case for systems that need
> address translation.
> 
> Add a separate @range argument to function cxl_find_root_decoder() to
> specify the root decoder's address range. Now it is possible to pass a
> translated address range of an endpoint decoder to function
> cxl_find_root_decoder().
> 
> Patch is a prerequisite to implement address translation.
>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Maybe worth noting that this patch is just a refactor (i.e. no-op).

Reviewed-by: Gregory Price <gourry@gourry.net>
