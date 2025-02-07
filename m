Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE146188735
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913420; cv=none; b=pbofqpUN3rDgBRPmYzKNEkedAZ8j4zWkhUBaNcGs1B4Y8NUH1wwbY6G/ohlcvwzb5Ej0txh+M0CQbdCK1vhmCAaI+vvU55Vk6eF77TH8zkdYOiCUK1yjCMbqSNxyMLu5KEZwqOqP5BWRJsju4SPIav2D03Ab0EUwfwHaNs6AvRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913420; c=relaxed/simple;
	bh=UJ/X1bqhgQUvz5mZeiZ7mu1qy+hSSJPVO7P9gCXAgpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+Q9UH/YjE3fgMlvPvFpoUL46EuB1z6XQwVQWYMv9Kw4MpeOtckK5thllfWLoYlPJDlMybmRBGcf0Q9Ke7qAt7A6u5uEE1YvruGKeoRqHk3jwESgf0TjuZ0nNbuF9nMs1M2IIpYiQHdmKw2eeswt/0FFNWLh9zNIt6c2iDrMpxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QUmg4KVO; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QUmg4KVO"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6e9586b82so157289585a.1
        for <linux-cxl@vger.kernel.org>; Thu, 06 Feb 2025 23:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738913415; x=1739518215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPFVTqdvqhZPbZ75tXTbpYN0u9AO7uq3Z5LkOr9vDgk=;
        b=QUmg4KVO//ZOMjblIhmUd0wAkIb0y/DVT082yrB2YAiEoL5XBk4DrJ/O+kYMFCS0dr
         gu53Q3nNaauskTEGqfecPrVveTP+68vp8AJRSduWPyK0z5rWqB2kKUiA/G/8w1TF5efL
         Bwo/ke4dAQV+Ts/HuZKHYinRZ1hgH+aCXUE3UHUp0QMI4/z9Qvd6wutMkhn77UEw24Lk
         lncrA8vur+aUhjjpwe4J8MUWLQSZqNWWLTYOznyqn5ldgVFgWdVMms3RyiONd0analJD
         sd30GmggwX1/Pug2I2kYvQYvq6q4UWE/eh4z+OrhK+CHyIGvF/rpBw1qqUXLazNmBSVF
         krbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913415; x=1739518215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPFVTqdvqhZPbZ75tXTbpYN0u9AO7uq3Z5LkOr9vDgk=;
        b=lzEIKwtJ9g1CAovtmxDC0bFVzMAIFCXho1rda9Iq01iS8icDFvXgh8MXMVGy8y/fvk
         /ye7dtfPhzu9CAxyLO5SprOofcJJOe1z8I+vGdImoHVtIQub+QVAo3cP0SH+RRA83j+g
         z2jtM5ocqk9kPmyhnKi8UxkHfpBOsvLveB1qEIwNwz74Ow1Ob9yBApxyCcuSx6UCp258
         /Yf32BZJRcIRiu4Jxqk88AhY7achkNNeNsZ88ca/CqP3dnf8BLcm7c9WMfHQK0yjGgJN
         JT45PyTO7AxjDGvyRY7m3rZLzyAgMuMXKW0z7XcwFJtClW6HiqT/9B99BVGAzv0GbQPP
         XOMw==
X-Gm-Message-State: AOJu0YxQz6p+DFueEexOSvK32tWPt3whTskht6Z41W/7+yoB6qZoWLs3
	OCBQkPWs5zIysn8OWA6tkiQkMN2PNW6Gk+jfhMatxCBlaCC0zVDjUZMRRmQOwpM=
X-Gm-Gg: ASbGncttnGOmB+Jdl56TqQjvd0sM+eQrieUhvMVUxYn8YbrC5izmDT7H3kU/4JVV7VL
	ZZNwqzU8xoq3X4susH2o4bOcHjv2fzgulxuOZfBgwCagDND+S6LqWUr12Wc9okROXEL8SuihPiX
	mN2qGGCplfVgE7j7QpoeLtvfa9mYX0QBNNmdXQl7qz3g6CNe5SHnzFRB6KX0u2c0ewC2G+9RTTf
	iUKNewgwqTIaYyK8rIOcsqb+LGJWktSUQFWQ8a5f93nDGcjePipLrAIwBehWT2zhLdu1rXiEfHH
	k2zscr2gWX38Sn4aSRV9WNwLMhgtZD5xEALc6XKSF9mR1GMZCIVF3LFHJNsROtbnei8xgTjDlw=
	=
X-Google-Smtp-Source: AGHT+IGTJPM+Z54YDmRhIyxJSdkL86rCqVxm6xIrfmJkTfPa05ZDK3edZmGObvoT1vj6Sn3CLYdpzQ==
X-Received: by 2002:a05:620a:4448:b0:7c0:b82:8f90 with SMTP id af79cd13be357-7c047c2139amr359435985a.35.1738913415678;
        Thu, 06 Feb 2025 23:30:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9f917sm157836585a.79.2025.02.06.23.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:30:15 -0800 (PST)
Date: Fri, 7 Feb 2025 02:30:12 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
	alucerop@amd.com
Subject: Re: [PATCH v5 08/16] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
Message-ID: <Z6W2hFI7UsEslB3U@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-9-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-9-terry.bowman@amd.com>

On Tue, Jan 07, 2025 at 08:38:44AM -0600, Terry Bowman wrote:
> +static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return false;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	return (pci_pcie_type(pdev) == pcie_type);
> +}
> +
> +static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
> +{
> +	struct cxl_dport *dport = ep->dport;
> +
> +	if (dport) {
> +		struct device *dport_dev = dport->dport_dev;
> +
> +		if (dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
> +		    dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_ROOT_PORT))

Mostly an observation - this kind of comparison seems to be coming up
more.  Wonder if an explicit set of APIs for these checks would be worth
it to clean up the 3 or 4 different comparison variants i've seen.

Either way

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
