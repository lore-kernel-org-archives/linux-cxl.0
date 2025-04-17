Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316202139DC
	for <linux-cxl@vger.kernel.org>; Thu, 17 Apr 2025 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897745; cv=none; b=D2nhwysv/H5bZanC1YyqIsYjrTivQQg2XiGZuXyO7YPtFUiho5BejBY6EaRGAlSABIh1ByrZNItN0A/Vne+Yamosx89wV5DdbBcdMfSDFkr5uN4X4ZRUDqKrC9Y4VwO0ku9WUdPUuqH/nIWuNbeU7++0JvhV9leYZ6+nQtJXlkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897745; c=relaxed/simple;
	bh=/G8aJT+2T51yuf1WMDS23rZs0mn1rjY5FgNlcDdfeVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ln1Vb7rCtwBYmzg8LJU8BkRFEaAz8bUdPhQLa8t83HqE29kzN7rHOBgyn3D/lp+gpCEkG4aRMgyQYCeGOpgvg+sfgfnj1f9tiCOdrgLNhDHfKxxPUzNgv2bfP4bUEaSXs5LZkU2nXPtuUBggRG4S4KAiieuEox06GW8gBaK7gRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HQuLgu7y; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HQuLgu7y"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c59e7039eeso104671585a.2
        for <linux-cxl@vger.kernel.org>; Thu, 17 Apr 2025 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744897742; x=1745502542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCJlmAze3Kym1WnCOQVGanklH0i7woN3rI47oROiF2o=;
        b=HQuLgu7yWdAWzRZwzRVfrFpyE8udjgf4nbyz8nte29Hu4PtLkW7Xki86R55JZZtY82
         BL6OQy6iBrPkQyv1d/nw+jaKCdarKuo6AipAcALwI+54w1DvqnW8XtQf9oGQ2dg/h8bt
         TLy/DSgaPnoaKoTjOohfMSjm4SiRIaKFmP5oP7d8CHC5++X+XXxkktQe5pY8jLbGbSCp
         bkIe1ysVMmTrhGTmJl29aC1gj+ZapMsXq+V+q25JdFHh7GAgC9vEXnJ0bRf7fHymvG3W
         yR3MjeH11r0LKAXwrYPqvNDvuZvTcGii+GPN5ImqTkQTez6zpa0KsT3ouh8djALm1luX
         WS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744897742; x=1745502542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCJlmAze3Kym1WnCOQVGanklH0i7woN3rI47oROiF2o=;
        b=WqhvB8agU8V2GA3j6SPtPYXzVMhYR5Mbol03vFBy1CL9tH7iXr6kI70fanzvDBLEfR
         NPKtOFuxt4aWjxDhuOWrODwwpw9z3QLmsvIZ5nQ3s4aRkAoJGzUvl3G3eSvKn2gZHEFL
         Y/HoQ8XKnDu3K19OgOuT1fRqtJA7ba6Uu8JJKacb9BILWMV2xUiWfzzIvTjqF1UT02Pt
         u2qO2dKM5mdCpCok1Cjowohol5fvPmXAllgyw3LwtCc6ktKKQOOUzGpkKM4mZlnl+ToK
         aMxZmabw1dfNHVwLCxXOKEVjlKcgyhLYuc+HiUO4qaNknbIGLAh8EY4pT7cWY1BBAzax
         vjWg==
X-Forwarded-Encrypted: i=1; AJvYcCUN/mta1xweT6m1+91olZ+ELI3rsh/muZ/yDoTwMD9ERKtqeHYiC1kuTe0oGzFn+1G8jkASXV7iIuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP1PCevUW2kJbagvBxWxDdyXmOPOMO4FK6aLNZjDddACz/0Grv
	8Ylay+YKUvYFOCtHXt+c4/DGCZaPUMqOZnOrhNNvGI7i8Wn0CHFUgOsXZEcVxOo=
X-Gm-Gg: ASbGnctbClQMgnGwSliFhYRZQjZROpeb5dNJ4fZ5xt/LSSucJswctADFogIZK5N2Mvo
	12bPKEBQvIaG0NxhUecW07Mmdf7eFJGVYeXjdt8V6lpetYbNslUq01ZLPU+SBSvcl+oF8JN3SwA
	qnnWlQ0RMSHBtkCEwWcn4xAHHfvXH2kJN3fS5VwighI7HQnJbzPJiOJ6bYWRu5Ddh+98C0elB7u
	QW4KTpl2G9PiLhYlF5k2KAb0T50voJn442qTc+PV0f3lvLqMoupGsc6sz0ty59xB9duf6YqyH0+
	sMqhYZgmonFyHy3vTarzK60+kqjXY5uywpxsqPJ2eRiXtBhOiN8/Da9IAUzByGEVBhL4OeTvzCr
	oachk54hUO/jPJWQ92XFxXkI=
X-Google-Smtp-Source: AGHT+IG+vwdBOW78hJS2ARBoaeXcloe4PsBtjCQ3PHFHML6iqoEhTKREvxrGmJBv6hdomksBTVCVDw==
X-Received: by 2002:a05:6214:5093:b0:6e8:fa38:46aa with SMTP id 6a1803df08f44-6f2b303673amr89566246d6.33.1744897741965;
        Thu, 17 Apr 2025 06:49:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea101c2sm127614776d6.94.2025.04.17.06.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 06:49:01 -0700 (PDT)
Date: Thu, 17 Apr 2025 09:48:59 -0400
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
Subject: Re: [PATCH v4 03/14] cxl/pci: Add comments to cxl_hdm_decode_init()
Message-ID: <aAEGy6Lyt1WH5QgQ@gourry-fedora-PF4VCD3F>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-4-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-4-rrichter@amd.com>

On Thu, Mar 06, 2025 at 05:44:37PM +0100, Robert Richter wrote:
> There are various configuration cases of HDM decoder registers causing
> different code paths. Add comments to cxl_hdm_decode_init() to better
> explain them.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Gregory Price <gourry@gourry.net>

