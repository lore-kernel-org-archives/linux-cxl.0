Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1405D2E11CC
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827726; cv=none; b=BZWTfa5DRMbfyOe5qHNScu1L3FasnOuReeIfquLpozsuRhJgZXMI5cr8usT0Ob3zJAt9AZd40BiwnKtxX71zimqHIODPDYIeCF1bNPN4gsJPjncNVUXYnKgRBnNd02FGTXAb/qF8KALQpQzN/7kOl+i7k4z9uGQFFgo2v9Oi8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827726; c=relaxed/simple;
	bh=krjJKHNFhprDN7sSARjJJ80Y+NemmLnQwRHvZmrTl/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNdHCYv1HXb4CISz690V+T25ZRIyGcHSB+nNlBlJTH9Kao3nsG7JjGfKnN+ZDttghFDoNUUOw9AxrZ4mU9ZUGODW1aZTbeWwzlmc5F/eMIoyoCvqWaXhwmpTvPCLVcaWseuT8GS1tKqZwRjO2GvmBF3Q3DvoBWubUmi9VttjJ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=i4ZRQC0D; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="i4ZRQC0D"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fabb948e5aso25084786d6.1
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1749827723; x=1750432523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DLeA9vUNbH/ePs3lyznbwlwuVDe9H7UVoc7p2adjDP4=;
        b=i4ZRQC0Dhb0FkUMyqCGd79zQy60+2c60bAyCxRHse63qBIdUEbgFMsqC1pho+vZV4H
         QKHgK0CHOeix1176xdzqAms+TiwTaff0ZathQ8mzPO1SFVVDH/eD4qvJlSM9Z14Io8gL
         fpSTUzsNX/LJVEGJdVLKA3GXtjD9D3w4+yeg+3vmT+8X2sjT57dS/ikvEaQqTVRu7ejC
         ro5Z0TA5XymyZPj9S5Oagt88FMI0kANq9zQdHHOn7RId/d0wqi2Hh3eUkhOLqXsk6Enc
         MQd6pVuB6QQG/1zb8WXTTXehaL7oVoVp6cxM1aosqI3WKA5l+t+7/BWA0/r4z+rH5iCV
         dBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749827723; x=1750432523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLeA9vUNbH/ePs3lyznbwlwuVDe9H7UVoc7p2adjDP4=;
        b=VXH3B/vFZIPYXoeqeyJggknpHRuE3HH+XVG6AHUyx820QD3V04JNObsFXN4ZveXGoM
         nZEHQEziZdoVF1EIFPjeLLSSQdeni4DgDvIxCyDwNLilL7CwfwL+RqJzhOFRkPiCfqx2
         v+wGv2z3iCrCdaklrM1YWb6jqi3pS6sxOM18XNwbf8oeMgumi5vX0t6gbTx0qa5MKjI/
         jo/xVm4Z2IZ1S/pv2+eH/G6iKbDzYP+bQfpuYdYnFR46MMor7A+SxPDfxptwwnzeQ7Ex
         xiBIv+2YnE8inoRjZJMHM8EC9eKc6rZZP+zP6pxS1oXMZ+8myQgnhjqKp7G77d+QI1E/
         O5GA==
X-Forwarded-Encrypted: i=1; AJvYcCWhXhWc7sDB4i8vNbUttcoda88J2QqgNq1q/O0u0ZvisQan7T6cDymQGb8AjPIGTyvtMglGa+e7jnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxksZYgdZdJ6VcW9Ys0qG26hmE5bcGCx6196DS0avUlR29YO1eC
	zHeBKP32TUUNMI/8t/K6YAD3dkR5riI6+zKdbtApVJrnSieeki5libec+37wn/Zb7LqEWQcCF6l
	81enm
X-Gm-Gg: ASbGncsWSDa7+M3Y0S3qSH2Hsex+Xg+W95qG9uDBiJrNnzIBZxlYRHFrEVPmYt/aUXj
	lo9Ujfi2EPzElC79cCQX35gqaB43cYDpYb9xsdAcl7wXZwJc2visSeaTlhH3KoJHPocU/BD98lf
	0miZQYeb95XA2dsLyhPYbjn5OCCAYxGkLvx8j6r9tvQp8apQxUL/ZiZVfqCnGhBmvfv89qYrvnB
	Kq7ruwL5d93xB1fBEw3DoFVMyHmu6K/St+xgJ1p5XOEXWCBafv1z5sxPVHww+6mt5KALJAKh0UX
	Bh8Vof2y2dLkvwPk4oZ3Gavi0iOjkmALmlpwsBoiQ8DcVkq+9ayezsHPRf4wbqoR4bRF
X-Google-Smtp-Source: AGHT+IF2bLQfd8ctkWZFaQ92KE4rHvpUcRaE21PwVNlkA2zLTGEURMQjL41ghV5sptIaNjXET3KTNw==
X-Received: by 2002:a05:622a:5908:b0:4a4:4063:94d1 with SMTP id d75a77b69052e-4a72fec0645mr54526231cf.8.1749827710279;
        Fri, 13 Jun 2025 08:15:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:400::5:cf64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a2bfc2asm18128431cf.4.2025.06.13.08.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:15:09 -0700 (PDT)
Date: Fri, 13 Jun 2025 10:15:07 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	Alejandro Lucero <alucerop@amd.com>,
	Jonathan Cameron <Jonsathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v3 0/9] cxl: Delay HB port and switch dport probing until
 endpoint dev probe
Message-ID: <aExAezx8lmYIQ5GK@gourry-fedora-PF4VCD3F>
References: <20250521183443.3828320-1-dave.jiang@intel.com>
 <aDm3zR2LkC3joLFL@rric.localdomain>
 <ff8ec7f0-6cae-4c1b-973d-c126ce60435a@intel.com>
 <aEBp30k03GP46eBd@rric.localdomain>
 <026e7506-b248-43bb-9118-5e3c3d817c90@intel.com>
 <aEK4hx6wNkpvYK9K@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEK4hx6wNkpvYK9K@rric.localdomain>

On Fri, Jun 06, 2025 at 11:44:39AM +0200, Robert Richter wrote:
> > I'm trying to understand your pain point WRT to why ordering is
> > necessary. Is it somehow breaking your user tooling? I'm not sure I
> 
> The expectation is broken in a way that Port in the LnkCap no longer
> matches with numbers in the target_list attribute and with dport%d.
> But I don't know of tools that break here.
> 

Maybe just expose a given port's "real" port ID as portN/target_id?

The issue is that async probe breaks sysfs object numbering in general,
and so "N" and "ID" don't have an intrinsic relationship.  I imagine we
should fix anything that assume this relationship exists - rather than
try to retain that relationship.

That gives a more formal search mechanism for ports based on a target_id
and better naming.  (I don't actually care what we call it)

~Gregory
