Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E8927A112
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240211; cv=none; b=S8zxEaHjKOCmJ0t7fZQHcA0JwEEWAojMIGdH9WHSZsCIoQ71D22DVjwdpzr7NMXEftEUvjncvFyllqv8Q2Bw26ssWnlJLXyHO0tUZYDXd0L3cEp+k/eQ+1LH9W6tb5TwyuU0ncb4/QKHoktfPyEFsyveN7Nf6HVT+PXcf1AE4VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240211; c=relaxed/simple;
	bh=2Eq8/z0CfIGoA83SP9KPH8M1gkzzw035FghWA+Cwjp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2pQ9cVmkX6YuhafwmUHtOHTN+dBfZ2T8U7N7l8j7nHKPaNgpcmsC0+G32hcSaY4CpSUOXo1fOhxXdVexohI+B/aaC/DcwsYVJ6OkMOWWb7eURKJ/XpBSZdPVVqHS5KgF8Yom5NOVx3Ri3VKc50pT5LgMNRJdu0tMfkUcQfqfZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jFA43ki0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jFA43ki0"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476977848c4so265591cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 09:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747240208; x=1747845008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NG10cvai2OX7LZJN8zVe6/Jr/Err05M9CRh06hrOVvU=;
        b=jFA43ki0xygEKWc+jIgDUEOa1DW7PFR5NnD4bUmm7IbWhlQq0cNxYwP4KTl5XFrjEi
         Q2iAJ0wZiTW8YAVhoYCs1kseNTgrLE408qjANuym7WTVElCxKzHPRwgID4g4/QaPiU1Z
         3I6x7vAUrgPp0j0lkcIrXm+7asnV+OcRvkjvSPZvPQhcc86CwZnt9g+bcId/JOiZGn81
         kE3AxgyIXsb8ZkFQVVchCPXedVQsXwIlDv0tgv/SjmaF8WMwxXw5v7ex92I51hSSwx7C
         K9PZIFEtCJLy0lvCeLYJg+Nyzi9xkIXRQAv+Jf6o+P0Q/9/5V24Lm88nlzeVP/3s30HC
         qbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747240208; x=1747845008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG10cvai2OX7LZJN8zVe6/Jr/Err05M9CRh06hrOVvU=;
        b=CwVEjoq0CdHz2U92NX//TdWi5BkQGWz89AN4MpxDv52dlj06ORUZmeAgLsA3I+s1nW
         aFYNax0iFGliHIya5rz4QBT6dV/zTeY0X22AZZPNf+n9SskOqArwJNbNAZ+VETkumtkr
         +M2aR026U+wpsxyMe9SmU0gS/+lRUfBE9+135rxM1AOlLOH0cTLsYrU+nxydwPJ/4uET
         HnVcKHen50pnvv9kgp0DZXuX69VOBFBaiy8nTYDxLZTLzkjTmgbENcRkFPo5RG4c7krM
         sLXZczlxc7JDXrO+hTD5vSYq5YcF+GZtTIk4b6r6aAWH753CmB3AEgGOK+BNqVN7s4mu
         M90A==
X-Gm-Message-State: AOJu0Yy6A6BuD0hyg8oI5BU6Sy0Tw1V8BGrt53GS0c8YnGhzBmnE2r07
	jukIPufpxEoOIMeAdT3PR0JrDCYufgPKN55l4SblstkMjQcjrVVAf8Rfye91HhY=
X-Gm-Gg: ASbGncsnPI5hJmUtvsGGW86wAr7fwX8KjW751N7ZKkkAUiS+b7QCbBvQFk1gB0a1aNF
	RbplqlA+SDfgLNg5w04KO213YE8TOLcHXq4Ih0Um2ixzDM3m6z4Z/QysR0wbp41shypNMSfRbRQ
	NMEEnFfMo7ACCXBNpA8gZmaAra7XD5XBnoJt+e6UdCa8b5M+OLc95+ouqGjhPYVcQs2Pcar5MDS
	lVP48z/MRC0eQ9QdizT+CnAQmfSL6AIR0XSsG9w25HLpmNH3MKDMQACN3Z3oUouUnKlnW6CD0NJ
	5JyZjDn0yURTNTt02MatuzsLhQfnbAepjX8xidK/6jUwN05zvd1gov6u8UeRgdbIUW0O/fQqD27
	vLtS6Gdp6YKPJTeUHDlbwOLm+32eye00=
X-Google-Smtp-Source: AGHT+IFCnQm4vgbH4cuZJ0FQS9KrqTgQGGLgQjxV5pK1LDKpt3y6G4lhgE+kQGemzvPe4Ah8BgPtRg==
X-Received: by 2002:a05:622a:2b49:b0:477:e4e:9186 with SMTP id d75a77b69052e-49495c658c2mr74420481cf.11.1747240207780;
        Wed, 14 May 2025 09:30:07 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4945248d051sm82021231cf.29.2025.05.14.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 09:30:07 -0700 (PDT)
Date: Wed, 14 May 2025 12:30:05 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH 4/4] cxl: doc/linux/access-coordinates Update access
 coordinates calculation methods
Message-ID: <aCTFDcFNSq38Zn0k@gourry-fedora-PF4VCD3F>
References: <20250514003133.584401-1-dave.jiang@intel.com>
 <20250514003133.584401-5-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514003133.584401-5-dave.jiang@intel.com>

On Tue, May 13, 2025 at 05:31:33PM -0700, Dave Jiang wrote:
> Add documentation on how to calculate the access coordinates for a given
> CXL region in detail.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

This is awesome, thanks Dave!  Minor nits inline

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  .../cxl/linux/access-coordinates.rst          | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/Documentation/driver-api/cxl/linux/access-coordinates.rst b/Documentation/driver-api/cxl/linux/access-coordinates.rst
> index 71024fa0f561..cf86920f083a 100644
> --- a/Documentation/driver-api/cxl/linux/access-coordinates.rst
> +++ b/Documentation/driver-api/cxl/linux/access-coordinates.rst
> @@ -5,6 +5,84 @@
>  CXL Access Coordinates Computation
>  ==================================
>  
> +Latency and Bandwidth Calculation
> +=================================
> +A memory region performance coordinates (latency and bandwidth) are typically
> +provided via ACPI tables :doc:`SRAT <../platform/acpi/srat>` and
> +:doc:`HMAT <../platform/acpi/hmat>`. However, the platform firmware (BIOS) is
> +not able to annotate those for CXL devices that are hot-plugged since they do
> +not exist during platform firmware initialization. The CXL driver can compute
> +the performance coordinates by retrieving data from several components.
> +
> +The :doc:`SRAT <../platform/acpi/srat>` provides a Generic Port Affinity
> +subtable that ties a proximity domain to a device handle, which in this case
> +would be the CXL hostbridge. Using this association, the performance
> +coordinates for the Generic Port can be retrieved from the
> +:doc:`HMAT <../platform/acpi/hmat>` subtable. This piece represents the
> +performance coordinates between a CPU to the Generic Port (CXL hostbridge).
                           "from a CPU to the Generic Port", or
			   "between a CPU and a Generic Port"

			   either works

> +
> +The :doc:`CDAT <../platform/cdat>` provides the performance coordinates for
> +the CXL device itself. That is the bandwidth and latency to access that device's
> +memory region. The :doc:`DSMAS <../platform/cdat/dsmas>` subtable provides a
> +DSMAD handle that is tied to a Device Physical Address (DPA) range. The

Similar to other doc - need to define DSMAD.

> +:doc:`DSLBIS <../platform/cdat/dslbis>` subtable provides the performance
> +coordinates that's tied to a DSMAD handle and this ties the two table
> +entries together to provide the performance coordinates for each DPA
> +region. For example, if a device exports a DRAM region and a PMEM region,
> +then there would be different performance characteristsics for each of those
> +regions.
> +
> +If there's a CXL switch in the topology, then the performance coordinates for the
> +switch is provided by :doc:`SSLBIS <../platform/cdat/sslbis>` subtable. This
> +provides the bandwidth and latency for traversing the switch between the switch
> +upstream port and the switch downstream port that points to the endpoint device.
> +
> +Simple topology example::
> +
> + GP0/HB0/ACPI0016-0
> +        RP0
> +         |
> +         | L0
> +         |
> +     SW 0 / USP0
> +     SW 0 / DSP0
> +         |
> +         | L1
> +         |
> +        EP0
> +
> +In this example, there is a CXL switch between an endpoint and a root port.
> +Latency in this example is calculated as such:
> +L(EP0) - Latency from EP0 CDAT DSMAS+DSLBIS
> +L(L1) - Link latency between EP0 and SW0DSP0
> +L(SW0) - Latency for the switch from SW0 CDAT SSLBIS.
> +L(L0) - Link latency between SW0 and RP0
> +L(RP0) - Latency from root port to CPU via SRAT and HMAT (Generic Port).
> +Total read and write latencies are the sum of all these parts.
> +
> +Bandwidth in this example is calculated as such:
> +B(EP0) - Bandwidth from EP0 CDAT DSMAS+DSLBIS
> +B(L1) - Link bandwidth between EP0 and SW0DSP0
> +B(SW0) - Bandwidth for the switch from SW0 CDAT SSLBIS.
> +B(L0) - Link bandwidth between SW0 and RP0
> +B(RP0) - Bandwidth from root port to CPU via SRAT and HMAT (Generic Port).
> +The total read and write bandwidth is the min() of all these parts.
> +
> +To calculate the link bandwidth:
> +LinkOperatingFrequency (GT/s) is the current negotiated link speed.
> +DataRatePerLink (MB/s) = LinkOperatingFrequency / 8
> +Bandwidth (MB/s) = PCIeCurrentLinkWidth * DataRatePerLink
> +Where PCIeCurrentLinkWidth is the number of lanes in the link.
> +
> +To calculate the link latency:
> +LinkLatency (picoseconds) = FlitSize / LinkBandwidth (MB/s)
> +
> +See `CXL Memory Device SW Guide r1.0 <https://www.intel.com/content/www/us/en/content-details/643805/cxl-memory-device-software-guide.html>`_,
> +section 2.11.3 and 2.11.4 for details.
> +
> +In the end, the access coordinates for a constructed memory region is calculated from one
> +or more memory partitions from each of the CXL device(s).
> +
>  Shared Upstream Link Calculation
>  ================================
>  For certain CXL region construction with endpoints behind CXL switches (SW) or
> @@ -90,3 +168,12 @@ under the same ACPI0017 device to form a new xarray.
>  Finally, the cxl_region_update_bandwidth() is called and the aggregated
>  bandwidth from all the members of the last xarray is updated for the
>  access coordinates residing in the cxl region (cxlr) context.
> +
> +QTG ID
> +======
> +Each :doc:`CEDT <../platform/acpi/cedt>` has a QTG ID field. This field provides
> +the ID that associates with a QoS Throttling Group (QTG) for the CFMWS window.
> +Once the access coordinates are calculated, an ACPI Device Specific Method can
> +be issued to the ACPI0016 device to retrieve the QTG ID depends on the access
> +coordinates provided. The QTG ID for the device can be used as guidance to match
> +to the CFMWS to setup the best Linux root decoder for the device performance.
> -- 
> 2.49.0
> 
