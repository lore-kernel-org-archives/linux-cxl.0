Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2601F2C35
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736275813; cv=none; b=i8BApPzg6J0Ez+z+obqNWAfc9h8KXTpPPRIixVu9rCSr3FBDvy3tFXj1LNSNKwhri40KQL2hawBfwiJAXs2edU875X7hjmidugb4AN1m3/+2yPq3ZGg0Ft8lC02506M7eDbuS8E5A51Otd3xYqJLhU6RY91ZygOqNHWRGJBlzpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736275813; c=relaxed/simple;
	bh=gREiA+ExptbMw749WEFg5IFDQ7/buLj4tWY0SU/sl1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMeC7GNNUmAQFrQzagh+uto469ICrl7ZwGHCQAY7n+zmNoJjsFjauv/6NEBisa2fKP8GPQ9YUaiz5hXLRjYwTSK282laF2I7L5Jo1Uigpfpjk39klwLQeZCHLiKxrVYZgCXaXRYpXhzxEDUhmx16BrlhuYRJfya77nszF1qHljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=p03dc4Zm; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="p03dc4Zm"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46788c32a69so19590311cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 10:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736275808; x=1736880608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8b0r0xs2FEWVFpXCikPsrDak4qmX9wO3vzTyS3GWQ4=;
        b=p03dc4ZmauMBwhLUMdtsG0eaDFi9Glhj91UVO1HSfuh0aO3RHlPmOB4nbMaq17Itrl
         hxp6TNKii6AY0UbCmf6JVSC8XuzhYgpFrnCsIu7jyxrG6oD/nYv0A5vnwT7TN2qT3+G3
         VJp2ndMBw6R/ngF0xDvRCJyjRlpyJLV4s+b2ctaRL+j04wlvSOeGBA3FpHLFkFdqf99q
         of2E7iiGXtZZ6/mr6NRTiB0anTiVGcfAn1C9UrPFjbrM1kXebJhB34pl1ZDtgW1If88h
         lP9DB/BVy8gFa/7GEUtsXv2iv18MAO8hNrafE8uI9RgZpTMLtGBY/lMJk32PEJLfBVPj
         z2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736275808; x=1736880608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8b0r0xs2FEWVFpXCikPsrDak4qmX9wO3vzTyS3GWQ4=;
        b=uAVoOWoMUvWMLPRjVvLQpa9s75+mfevRhOyXHmWMuH3torFDBtfup1HWPrZ4ZpsWGc
         ZojxMHNVC8wXg2a+RG0o+pvqy9NjLo6kgNKpfQp81eS01cGINMWgu/yUXQF6qzwGtMsn
         63NRBc1ohVbNTMKJMqZyoR3+9QX5iMNeZc2RD9yXeYbZq/tgF9+wv46aqlm8NBg7cLs7
         QG4XUBp5ZFtyyUq3qkFkTQbcYZfeXmzJcq7mv/tfvbBsqOV75Lob0W9JyDw3krQHjbcs
         OZveGILn3ykcAUYtupPSdJ3YCbn5IkV+Yn+hl2AKhtWeVYiX9sTOw6GG2BLjPdenNJ/A
         Ne1w==
X-Forwarded-Encrypted: i=1; AJvYcCVZr7O78zOxZXW/VPVnpkivVEm6AyPbrz4H2jSU/jQEFFn8EOxh5Dg3J0on89qhvCACiaPa14EoXIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/K9tdYp8vDSBA8qssg4xmw1mPIJmEEGzc9Qu3tPez5GCZir9e
	lA6mm5OMX8iVvh56Am6nb5VUo+vWnHZN+OgBtbqd1ACZnPIpbC7TIi6kHmz4+HBu61l2u5AUshu
	r
X-Gm-Gg: ASbGnctfrVz8m4j7/TdhbZ7Cn4UJCUKI1DWgeh+lRsfCtoTKixp/FNPdMeoOyV5WlnX
	qDSD/lo3KLNSY4NJ1uZ3rCtNthI77qZ/9J1DDoYu8K+fhEmYnInelDatvHZz0gwMwoXexdVaGeE
	4emWLjS/aoVm3leB/uuc3O0/QGJyEKTJSO6YgpTk067aN0Mkw1rYoK8opNeE54F1EB5j0ARjuUg
	Hpe9ljWvV5pr4kMypL7lKoz84/g+saBHJ1UseoSCvEbOzgk7QqHUnEzGLGWIB8y/wi2efQgyiMs
	gbTMGAK0zwbUSjiQn4IjSrlsAfcEYkUhH1gcyYs=
X-Google-Smtp-Source: AGHT+IHiLo3Jy3DjTYq1THF2OcLGr1hXmwGScEax5jPL6qTEXjJhVJi25B0Py+N75PYnecfrZb/lLg==
X-Received: by 2002:a05:622a:190f:b0:466:af35:92d5 with SMTP id d75a77b69052e-46a4a8e83e0mr963287951cf.25.1736275808281;
        Tue, 07 Jan 2025 10:50:08 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb178a7sm188178281cf.62.2025.01.07.10.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 10:50:07 -0800 (PST)
Date: Tue, 7 Jan 2025 13:50:05 -0500
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
Subject: Re: [PATCH v1 14/29] cxl: Introduce parent_port_of() helper
Message-ID: <Z313XWZm2IrAIdcM@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-15-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-15-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:00PM +0100, Robert Richter wrote:
> Often a parent port must be determined. Introduce the parent_port_of()
> helper function for this.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

This is a welcome cleanup for readability, wonder if it should be pulled
ahead to reduce the size of this changeset.

Reviewed-by: Gregory Price <gourry@gourry.net>
